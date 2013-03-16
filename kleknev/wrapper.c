/*
 * Profiling wrapper for shell-based systems (shared code)
 * Copyright (C) 2013  Matthew Skala
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Matthew Skala
 * http://ansuz.sooke.bc.ca/
 * mskala@ansuz.sooke.bc.ca
 */

#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/file.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include "_stdint.h"

#include "kleknev.h"

extern char **environ;

int write_escaped(char *text,FILE *file) {
   int wrote_space=0;
   
   while (1) {
      switch (*text) {
       case '\0': /* end of string */
	 return 0;
	 
       case ' ': /* space */
	 if (wrote_space) {
	    if (fputs("&#32;",file)<0) return -1;
	 } else {
	    if (fputc(' ',file)<0) return -1;
	    wrote_space=1;
	 }
	 break;
	 
	 /* things that should be escaped using XML's escapes */
       case '&':
	 if (fputs("&amp;",file)<0) return -1;
	 wrote_space=0;
	 break;
       case '<':
	 if (fputs("&lt;",file)<0) return -1;
	 wrote_space=0;
	 break;
       case '>':
	 if (fputs("&gt;",file)<0) return -1;
	 wrote_space=0;
	 break;
	 
       default:
	 if ((*text<0x20) || (*text>=0x7f)) {
	   if (fprintf(file,"&#%d;",*text)<0) return -1;
	 } else if (fputc(*text,file)<0) return -1;
	 wrote_space=0;
	 break;
      }
      text++;
   }
}

int do_wrapper(char *to_wrap,int argc,char **argv) {
   int can_proceed=1;
   char *log_fn,*ppid_str;
   FILE *log_file;
   pid_t pid,ppid,child;
   struct timespec walltime;
   char hostname[HOST_NAME_MAX];
   struct rusage rusage;
   int child_status,i,j;
   char **new_environ;
   char envstr_buf[64];
   int cwd_size=256;
   char *cwd_buf;

   /* try to open, and lock, log file */
   log_fn=getenv("KLEKNEV_LOG");
   if ((log_fn==NULL) || (log_fn[0]=='\0'))
     can_proceed=0;
   else {
      log_file=fopen(log_fn,"ab");
      if (log_file==NULL)
	can_proceed=0;
      else if ((flock(fileno(log_file),LOCK_EX)<0) ||
	       (fseek(log_file,0,SEEK_END)<0)) {
	 can_proceed=0;
	 flock(fileno(log_file),LOCK_UN);
	 fclose(log_file);
      }
   }
   
   /* write magic number to start the file */
   if (can_proceed && (ftell(log_file)==0)) {
      if (fputs("<kleknevMagicNumber />\n",log_file)<0) {
	 can_proceed=0;
	 flock(fileno(log_file),LOCK_UN);
	 fclose(log_file);
      }
   }

   /* write initial log entry */
   if (can_proceed) {

      /* get data for log entry */
      pid=getpid();
      clock_gettime(CLOCK_REALTIME,&walltime);
      gethostname(hostname,HOST_NAME_MAX);
      hostname[HOST_NAME_MAX-1]='\0';
      ppid_str=getenv("KLEKNEV_PID");
      if (ppid_str)
	ppid=atol(ppid_str);
      cwd_buf=(char *)malloc(cwd_size);
      while ((getcwd(cwd_buf,cwd_size)==NULL) && (errno==ERANGE)) {
	 cwd_size*=3;
	 cwd_size/=2;
	 cwd_buf=(char *)realloc(cwd_buf,cwd_size);
      }

      /* write start of entry, first few fields */
      if ((fputs("<e>\n",log_file)<0) ||
	  (fprintf(log_file,"  <pid value=\"%d\" />\n",pid)<0) ||
	  (fprintf(log_file,"  <wallTime sec=\"%d\" nSec=\"%ld\" />\n",
		   walltime.tv_sec,walltime.tv_nsec)<0) ||
	  (fprintf(log_file,"  <hostName name=\"%s\" />\n",hostname)<0) ||
	  (ppid_str &&
	      (fprintf(log_file,"  <parentPid value=\"%d\" />\n",ppid)<0)) ||
	  (fprintf(log_file,"  <workingDir path=\"%s\" />\n",cwd_buf)<0))
	can_proceed=0;
      
      /* write argv */
      if (can_proceed &&
	  (fprintf(log_file,"  <argv>\n    <a>%s</a>\n",to_wrap)>=0)) {
	 for (i=1;can_proceed && (i<argc);i++)
	   if ((fputs("    <a>",log_file)<0) ||
	       (write_escaped(argv[i],log_file)<0) ||
	       (fputs("</a>\n",log_file)<0))
	     can_proceed=0;
	 if (can_proceed && (fputs("  </argv>\n",log_file)<0))
	   can_proceed=0;
      } else
	can_proceed=0;

      /* write end of entry */
      if (can_proceed && (fputs("</e>\n",log_file)<0))
	can_proceed=0;
      fflush(log_file);
      
      flock(fileno(log_file),LOCK_UN);
      fclose(log_file);
   }

   /* run child */
   if (can_proceed) {
      /* prepare environment */
      for (i=0;environ[i];i++);
      new_environ=(char **)malloc(sizeof(char *)*(i+2));
      memcpy(new_environ,environ,(i+1)*sizeof(char *));
      new_environ[i+1]=NULL;
      for (i=0;new_environ[i] &&
	   strncmp(new_environ[i],"KLEKNEV_PID=",12);i++);
      sprintf(envstr_buf,"KLEKNEV_PID=%d",pid);
      new_environ[i]=envstr_buf;
      
      /* fork, exec, and wait */
      child=fork();
      if (child==0) {
	 environ=new_environ;
	 argv[0]=to_wrap;
	 execv(to_wrap,argv);
	 /* any return indicates an error */
	 exit(EXIT_FAILURE);
      }
      if (child==-1)
	exit(EXIT_FAILURE);
      wait4(child,&child_status,0,&rusage);

   } else {
      /* not logging - just exec the child */
      argv[0]=to_wrap;
      execv(to_wrap,argv);
      /* any return indicates an error */
      exit(EXIT_FAILURE);
   }

   /* try to open, and lock, log file */
   if (can_proceed) {
      log_file=fopen(log_fn,"ab");
      if (log_file==NULL)
	can_proceed=0;
      else if (flock(fileno(log_file),LOCK_EX)<0) {
	 can_proceed=0;
	 fclose(log_file);
      }
   }

   /* write final log entry */
   if (can_proceed) {

      /* get data for log entry */
      clock_gettime(CLOCK_REALTIME,&walltime);

      /* write entry */
      if ((fputs("<e>\n",log_file)<0) ||
	  (fprintf(log_file,"  <pid value=\"%d\" />\n",pid)<0) ||
	  (fprintf(log_file,"  <wallTime sec=\"%d\" nSec=\"%ld\" />\n",
		   walltime.tv_sec,walltime.tv_nsec)<0) ||
	  (fprintf(log_file,"  <hostName name=\"%s\" />\n",hostname)<0) ||
	  (fprintf(log_file,"  <exitStatus value=\"%d\" />\n",
		   WEXITSTATUS(child_status))<0) ||
          (fprintf(log_file,"  <resourceUsage "
		   "userSec=\"%d\" userUSec=\"%ld\" "
		   "systemSec=\"%d\" systemUSec=\"%ld\" "
		   "maxRSS=\"%ld\" dataMemUsed=\"%ld\" stackMemUsed=\"%ld\" "
		   "minorFaults=\"%ld\" majorFaults=\"%ld\" nSwaps=\"%ld\" "
		   "blocksIn=\"%ld\" blocksOut=\"%ld\" "
		   "msgSent=\"%ld\" msgReceived=\"%ld\" signals=\"%ld\" "
		   "voluntarySwitches=\"%ld\" "
		   "involuntarySwitches=\"%ld\" />\n",
		   rusage.ru_utime.tv_sec,rusage.ru_utime.tv_usec,
		   rusage.ru_stime.tv_sec,rusage.ru_stime.tv_usec,
		   rusage.ru_ixrss,rusage.ru_idrss,rusage.ru_isrss,
		   rusage.ru_minflt,rusage.ru_majflt,rusage.ru_nswap,
		   rusage.ru_inblock,rusage.ru_oublock,
		   rusage.ru_msgsnd,rusage.ru_msgrcv,rusage.ru_nsignals,
		   rusage.ru_nvcsw,rusage.ru_nivcsw)<0) ||
	  (fputs("</e>\n",log_file)<0))
	can_proceed=0;
      fflush(log_file);
      flock(fileno(log_file),LOCK_UN);
      fclose(log_file);
   }

   /* return the child's status */
   return WEXITSTATUS(child_status);
}
