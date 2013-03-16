/*
 * Profiling wrapper for shell-based systems (argv[0] version)
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

#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "kleknev.h"

int main(int argc,char **argv) {
   struct stat me,he;
   char *mybase,*wrapped;
   char *path,*ptest;
   char *scan,*pscan;
   int n,scan_state;
   int bufsize=256;
   
   /* find ourselves */
   if (stat(argv[0],&me)<0)
     exit(EXIT_FAILURE);
   mybase=argv[0];
   for (scan=mybase;*scan;scan++)
     if (*scan=='/')
       mybase=scan+1;
   
   /* get path to search */
   path=getenv("PATH");
   if (path==NULL) {
      n=confstr(_CS_PATH,NULL,0);
      path=(char *)malloc(n);
      confstr(_CS_PATH,path,n);
   }
   
   /* allocate a buffer */
   ptest=(char *)malloc(bufsize);
   
   /* search the path */
   wrapped=NULL;
   scan_state=0;
   for (pscan=path;*pscan;pscan++) {
      
      /* copy str */
      for (scan=pscan;(*scan) && (*scan!=':');scan++);
      n=(scan-pscan)+strlen(mybase)+2;
      if (n>bufsize) {
	 bufsize=n;
	 ptest=(char *)realloc(ptest,bufsize);
      }
      memcpy(ptest,pscan,scan-pscan);
      ptest[scan-pscan]='/';
      strcpy(ptest+(scan-pscan+1),mybase);
      
      /* attempt stat(), check it's not us */
      if (stat(ptest,&he)==0) {
	 if ((me.st_dev==he.st_dev) && (me.st_ino==he.st_ino)) {
	    
	    /* it's us; advance to state 2 if we're not there already */
	    if (scan_state<2)
	      scan_state=2;
	 } else {
	    
	    /* not us; save if first before or after us */
	    if ((scan_state&1)==0) {
	       if (wrapped)
		 free(wrapped);
	       wrapped=ptest;
	       ptest=(char *)malloc(bufsize);
	       scan_state++;
	    }
	    
	    /* we're done if we've seen first after us */
	    if (scan_state==3)
	      break;
	 }
      }
      
      /* advance to next thing in path variable */
      pscan=scan;
      if (!*pscan) pscan--;
   }
   
   /* we must have something to wrap */
   if (!wrapped)
     exit(EXIT_FAILURE);
   
   return do_wrapper(wrapped,argc,argv);
}
