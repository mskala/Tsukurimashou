/*
 * Code generator for static maps
 * Copyright (C) 2014  Matthew Skala
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

#include "icemap.h"
#include "getopt.h"

/**********************************************************************/

static struct option long_opts[] = {
   {"help",no_argument,NULL,'h'},
   {"version",no_argument,NULL,'V'},
   {0,0,0,0},
};

static void usage_message(void) {
   fputs("Usage: " PACKAGE_TARNAME " [OPTION]... [FILE]...\n"
	 "Try \"" PACKAGE_TARNAME " --help\" for more information.\n",
	 stderr);
   exit(1);
}

int main(int argc,char **argv) {
   int show_version=0,show_help=0;
   char c;

   /* loop on command-line options */
   while ((c=getopt_long(argc,argv,"Vh",long_opts,NULL))!=-1) {
      switch (c) {

       case 'V':
	 show_version=1;
	 break;
	 
       case 'h':
	 show_help=1;
	 break;

       default:
	 break;
      }
   }
   
   /* deal with version and help */
   if (show_version)
     puts(PACKAGE_STRING "\n\n"
	  "Copyright (C) 2014  Matthew Skala\n"
	  "License GPLv3: GNU GPL version 3 <http://gnu.org/licenses/gpl-3.0.html>\n"
	  "This is free software: you are free to change and redistribute it.\n"
	  "There is NO WARRANTY, to the extent permitted by law.");
   
   if (show_help)
     puts("Usage: " PACKAGE_TARNAME " [OPTION]... [FILE]...\n\n"
	  "Options:\n"
	  "  -V, --version             display version and license\n"
	  "  -h, --help                display this help");
   
   if (show_version || show_help)
     exit(0);

   parse();
   return 0;
}
