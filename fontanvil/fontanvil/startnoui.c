/* Copyright (C) 2007-2012 by George Williams */
/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 * 
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * 
 * The name of the author may not be used to endorse or promote products
 * derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "fontanvilvw.h"
#ifndef _NO_LIBUNICODENAMES
# include <libunicodenames.h>	/* need to open a database when we start */
extern uninm_names_db names_db; /* Unicode character names and annotations database */
extern uninm_blocks_db blocks_db;
#endif
#include <gfile.h>
#include <ustring.h>
#include <ltdl.h>
#include <time.h>
#include <sys/time.h>
#include <locale.h>
#include <unistd.h>
#include <dynamic.h>
#ifdef __Mac
# include <stdlib.h>		/* getenv,setenv */
#endif

static void doscriptusage(void) {
   printf("fontanvil [options] [scriptfile] [scriptargs]\n");
   printf("\t-usage\t\t\t (displays this message)\n");
   printf("\t-help\t\t\t (displays this message)\n");
   printf("\t-version\t\t (prints the version of fontanvil and exits)\n");
   printf("\t-script scriptfile\t (executes scriptfile)\n");
   printf("\t-c script-string\t (executes the argument as scripting cmds)\n");
   printf("\t-lang=ff\t (ignored for compatibility)\n");
   printf("\t-lang=py\t (fatal error)\n");
   printf("\n");
   printf("If no scriptfile/string is given (or if it's \"-\") FontAnvil will read stdin\n");
   printf("Any arguments after the script file will be passed to it.\n");
   printf("If the first argument is an executable filename, and that file's first\n");
   printf("\tline contains \"fontanvil\" or \"fontforge\" then it will be treated as a scriptfile.\n\n");
   exit(0);
}

int fontanvil_main( int argc, char **argv ) {
   extern const char *source_version_str;
   extern const char *source_modtime_str;
   
   fprintf(stderr,"Copyright (c) 2000-2014 by George Williams. See AUTHORS for Contributors.\n");
   fprintf(stderr," License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>\n");
   fprintf(stderr," with many parts BSD <http://fontforge.org/license.html>. Please read LICENSE.\n");
   fprintf(stderr," Executable based on sources from %s"
	   "-ML"
#ifdef FONTANVIL_CONFIG_USE_DOUBLE
	   "-D"
#endif
	   ".\n",
	   source_modtime_str );
   fprintf(stderr," Library based on sources from %s.\n",FONTANVIL_MODTIME_STR);
   
   FindProgDir(argv[0]);
   InitSimpleStuff();
   
   bind_textdomain_codeset("FontAnvil","UTF-8");
   bindtextdomain("FontAnvil", getLocaleDir());
   textdomain("FontAnvil");
   
   if (default_encoding==NULL)
     default_encoding=FindOrMakeEncoding("ISO8859-1");
   if (default_encoding==NULL)
     default_encoding=&custom;	/* In case iconv is broken */
   CheckIsScript(argc,argv);		/* Will run the script and exit if it is a script */
   if (argc==2) {
      char *pt = argv[1];
      if (*pt=='-' && pt[1]=='-' && pt[2]!='\0') ++pt;
      if (strcmp(pt,"-usage")==0)
	doscriptusage();
      else if (strcmp(pt,"-help")==0)
	doscriptusage();
      else if (strcmp(pt,"-version")==0)
	doversion(source_version_str);
   }
   ProcessNativeScript(argc, argv,stdin);
   
#ifndef _NO_LIBUNICODENAMES
   uninm_names_db_close(names_db);	/* close this database before exiting */
   uninm_blocks_db_close(blocks_db);
#endif
   
   return 0;
}
