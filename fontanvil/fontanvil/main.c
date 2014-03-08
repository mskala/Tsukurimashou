/* $Id: main.c 2923 2014-03-08 01:52:03Z mskala $ */
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
   {"command",1,NULL,'c'},
   {"dry",0,NULL,'d'},
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
   char *command=NULL;
   char **new_argv;
   int show_version=0,show_help=0;
   
   /* init things that must be ready before command line handling */
   /* FIXME: are these really needed so early?  or at all? */
   FindProgDir(argv[0]);
   InitSimpleStuff();
   
   /* loop on command-line options */
   while ((c=getopt_long_only(argc,argv,"+c:dhil:v",long_opts,NULL))!=-1) {
      switch (c) {

       case 'c':
	 command=optarg;
	 break;

       case 'd':
	 dry_option_selected=1;
	 break;

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

       default:
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

   /* execute script, command, or interactively */
   if (command!=NULL)
     ExecuteOneScriptCommand(command,argc-optind,argv+optind);
   else if (optind>=argc)
     ExecuteScriptCommandsInteractively(0,NULL);
   else if (strcmp(argv[optind],"-")==0)
     ExecuteScriptCommandsInteractively(argc-optind-1,argv+optind+1);
   else
     ExecuteScriptFile(argv[optind],argc-optind-1,argv+optind+1);
   
   /* clean up */
   /* FIXME this is dead code in FontForge, do we really need it after all? */
#ifndef _NO_LIBUNICODENAMES
   uninm_names_db_close(names_db);      /* close this database before exiting */
   uninm_blocks_db_close(blocks_db);
#endif
   
   /* successful exit */
   return 0;
}
