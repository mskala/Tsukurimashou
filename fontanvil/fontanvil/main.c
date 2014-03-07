/* $Id: main.c 2922 2014-03-07 22:33:29Z mskala $ */
/*
 * Main program and command line processing for FontAnvil
 * Copyright (C) 2014  Matthew Skala
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
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

#include <string.h>

#include "fontanvilvw.h"
#include "getopt.h"

/* not clear we really need this Unicode-names stuff here */
#ifndef _NO_LIBUNICODENAMES
#   include <libunicodenames.h>
extern uninm_names_db names_db;
extern uninm_blocks_db blocks_db;
#endif

static struct option long_opts[]={
   /* TODO "dry" */
   /* TODO "-c" */
   {"help",0,NULL,'h'},
   {"lang",1,NULL,'l'},
   {"nosplash",0,NULL,'i'},
   {"quiet",0,NULL,'i'},
   {"script",0,NULL,'i'},
   {"usage",0,NULL,'h'},
   {"version",0,NULL,'v'},
   {0,0,0,0},
};

int main(int argc,char **argv) {
   int c;
   char **new_argv;
   int show_version=0,show_help=0;
   
   /* init things that must be ready before command line handling */
   /* FIXME: are these really needed so early?  or at all? */
   FindProgDir(argv[0]);
   InitSimpleStuff();
   
   /* loop on command-line options */
   while ((c=getopt_long_only(argc,argv,"+c:hil:v",long_opts,NULL))!=-1) {
      switch (c) {

       case 'h':
	 show_help=1;
	 break;

       case 'i':
	 /* ignore for compatibility */
	 break;

       case 'l':
	 if (strcmp(optarg,"ff")!=0) {
	    /* FIXME better handling of error */
	    puts("Unsupported language.");
	    exit(1);
	 }
	 break;

       case 'v':
	 show_version=1;
	 break;
      }
   }
   
   /* deal with version and help */
   if (show_version) {
      puts("Version message.");
      /* FIXME */
   }
   
   if (show_help) {
      puts("Help message.");
      /* FIXME */
   }
   
   if (show_version || show_help)
     exit(0);
   
   /* init things that are only needed when we get past command-line help */
   if (default_encoding == NULL)
     default_encoding = FindOrMakeEncoding("ISO8859-1");
   if (default_encoding == NULL)
     default_encoding = &custom;

   /* execute script */
   new_argv=(char **)malloc((argc-optind+1)*sizeof(char *));
   new_argv[0]=argv[0];
   for (c=optind;c<argc;c++)
     new_argv[c-optind+1]=argv[c];
   ProcessNativeScript(argc-optind+1,new_argv,NULL); /* FIXME eliminate arg[cv]-pass */
   
   /* clean up */
   /* FIXME this is dead code in FontForge, do we really need it after all? */
#ifndef _NO_LIBUNICODENAMES
   uninm_names_db_close(names_db);      /* close this database before exiting */
   uninm_blocks_db_close(blocks_db);
#endif
   
   /* successful exit */
   return 0;
}
