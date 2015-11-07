
/* $Id: main.c 4310 2015-10-27 15:29:50Z mskala $ */
/*
 * Main program and command line processing for FontAnvil
 * Copyright (C) 2014, 2015  Matthew Skala
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

#include <fenv.h>
#include <string.h>

#include "scripting.h"
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
   {"verbose",0,NULL,'V'},
   {0,0,0,0},
};

int main(int argc,char **argv) {
   int c;
   char *command=NULL;
   char **new_argv;
   int show_version=0,show_help=0,is_interactive=1;

   /* init things that must be ready before command line handling */
   /* FIXME: are these really needed so early?  or at all? */
   InitSimpleStuff();

   /* loop on command-line options */
   while ((c=getopt_long_only(argc,argv,"+c:dhil:qvV",long_opts,NULL))!=-1) {
      switch (c) {

       case 'c':
	 command=optarg;
	 is_interactive=0;
	 break;

       case 'd':
	 dry_option_selected=1;
	 break;

       case 'h':
	 show_help=1;
	 is_interactive=0;
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

       case 'q':
	 message_level++;
	 break;

       case 'v':
	 show_version=1;
	 is_interactive=0;
	 break;

       case 'V':
	 message_level--;
	 break;

       default:
	 break;
      }
   }

   if (optind<argc)
     is_interactive=0;

   /* deal with version and help */
   if (show_version || is_interactive) {
      puts(PACKAGE_STRING " (" FONTANVIL_VERSIONDATE ") <"
	      PACKAGE_URL ">\n\n"
	   "Copyright (C) 2000-2014   George Williams\n"
	   "Copyright (C) 2014, 2015  Matthew Skala\n"
	   "License GPLv3+: GNU GPL version 3 "
	      "<http://gnu.org/licenses/gpl-3.0.html>\n"
	   "Some parts of this software are also available "
	      "under other licenses.\n"
	   "This is free software:  you are free to change and redistribute "
	   "it.\nThere is NO WARRANTY whatsoever.");
      if (is_interactive)
	puts("\nUse \"Quit()\" or end-of-file to exit the interpreter.");
   }

   if (show_help) {
      puts("Usage: " PACKAGE_TARNAME " [OPTION]... [SCRIPT] [ARGUMENT]...\n\n"
	   "Options:\n"
	   "  -c, --command <cmd>    execute scripting command\n"
	   "  -d, --dry              syntax check with minimal execution\n" 
	   "  -l, --lang ff          specify language (only ff is valid)\n"
	   "  -i, --nosplash         ignored for compatibility\n"
	   "  -q, --quiet            print fewer error/info messages\n"
	   "  -V, --verbose          print more error/info messages\n"
	   "      --script           ignored for compatibility\n"
	   "  -h, --help, --usage    display this help\n"
	   "  -v, --version          display version and copyright");
   }

   if (show_version || show_help)
     exit(0);

   /* init things that are only needed when we get past command-line help */
#ifdef HAVE_FESETROUND
   fesetround(FE_TONEAREST);
#endif
   if (default_encoding==NULL)
     default_encoding=FindOrMakeEncoding("ISO8859-1");
   if (default_encoding==NULL)
     default_encoding=&custom;

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
