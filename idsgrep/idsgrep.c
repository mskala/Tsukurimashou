/*
 * Extended IDS matcher
 * Copyright (C) 2012  Matthew Skala
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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <glob.h>
#include <unistd.h>

#include "idsgrep.h"
#include "getopt.h"

/**********************************************************************/

void process_file(NODE *match_pattern,char *fn,int fn_flag) {
   int read_amt,flag,i;
   NODE *to_match;
   char *input_buffer=NULL;
   int inbuf_size=0,inbuf_used=0,parse_ptr=0;
   FILE *infile;
   
   /* open input file */
   if (strcmp(fn,"-")) {
      infile=fopen(fn,"rb");
      if (infile==NULL) {
	 fprintf(stderr,"can't open %s for reading\n",fn);
	 return;
      }
   } else
     infile=stdin;
   
   /* loop over input */
   parse_ptr=0;
   while (!(feof(infile) || ferror(infile))) {

      /* make sure we have a buffer at all */
      if (input_buffer==NULL) {
	 input_buffer=(char *)malloc(1024);
	 inbuf_size=1024;
      }
      
      /* make sure we have space in the buffer */
      if (inbuf_used+128>inbuf_size) {
	 inbuf_size*=2;
	 input_buffer=(char *)realloc(input_buffer,inbuf_size);
      }
      
      /* try reading some input */
      inbuf_used+=fread(input_buffer+inbuf_used,1,
			isatty(fileno(infile))?1:inbuf_size-inbuf_used,
			infile);
      
      /* loop parsing and processing */
      while (1) {

	 /* parse */
	 parse_ptr+=parse(inbuf_used-parse_ptr,input_buffer+parse_ptr);
	 
	 /* complain about errors */
	 if (parse_state==PS_ERROR) {
	    puts("can't parse input pattern");
	       fwrite(input_buffer,1,parse_ptr,stdout);
	       putchar('\n');
	    exit(1);
	 }
	 
	 /* deal with a complete tree if we have one */
	 if (parse_state==PS_COMPLETE_TREE) {
	    to_match=parse_stack[0];
	    stack_ptr=0;
	    if (tree_match(match_pattern,to_match)) {
	       for (i=0;((unsigned char)input_buffer[i])<=0x20;i++);
	       if (fn_flag>=0)
		 printf(":%s:",fn+fn_flag);
	       if (cook_output)
		 write_cooked_tree(to_match);
	       else {
		  fwrite(input_buffer+i,1,parse_ptr-i,stdout);
		  echoing_whitespace=1;
	       }
	    }
	    free_node(to_match);
	    if (parse_ptr<inbuf_used)
	      memmove(input_buffer,input_buffer+parse_ptr,
		      inbuf_used-parse_ptr);
	    inbuf_used-=parse_ptr;
	    parse_ptr=0;
	 } else
	   break;
      }
   }

   if (infile!=stdin)
     fclose(infile);
   
   free(input_buffer);
}

/**********************************************************************/

static struct option long_opts[] = {
   {"cooking",required_argument,NULL,'c'},
   {"dictionary",optional_argument,NULL,'d'},
   {"help",no_argument,NULL,'h'},
   {"version",no_argument,NULL,'V'},
   {0,0,0,0},
};

static void usage_message(void) {
      fputs("Usage: " PACKAGE_TARNAME " [OPTION]... PATTERN [FILE]...\n"
	    "Try \"" PACKAGE_TARNAME " --help\" for more information.\n",
	   stderr);
      exit(1);
}

int main(int argc,char **argv) {
   NODE *match_pattern;
   int c,num_files=0;
   char *dictdir,*dictname=NULL,*dictglob;
   glob_t globres;
   int show_version=0,show_help=0;
   
   /* quick usage message */
   if (argc<2)
     usage_message();
   
   /* initialize */
   register_syntax();

   /* loop on command-line options */
   while ((c=getopt_long(argc,argv,"Vc:d::h",long_opts,NULL))!=-1) {
      switch (c) {

       case 'V':
	 show_version=1;
	 break;

       case 'c':
	 set_output_recipe(optarg);
	 break;
	 
       case 'd':
	 if (optarg==NULL)
	   dictname="";
	 else
	   dictname=optarg;
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
	  "Copyright (C) 2012 Matthew Skala\n"
	  "License GPLv3: GNU GPL version 3 <http://gnu.org/licenses/gpl-3.0.html>\n"
	  "This is free software: you are free to change and redistribute it.\n"
	  "There is NO WARRANTY, to the extent permitted by law.");
   
   if (show_help)
     puts("Usage: " PACKAGE_TARNAME " [OPTION]... PATTERN [FILE]...\n"
	  "PATTERN should be an Extended Ideographic Description Sequence\n\n"
	  "Options:\n"
	  "  -V, --version             display version and license\n"
	  "  -c, --cooking=FMT         set input/output cooking\n"
	  "  -d, --dictionary=NAME     search standard dictionary\n"
	  "  -h, --help                display this help");
   
   if (show_version || show_help)
     exit(0);
 
   /* parse matching pattern */
   if (optind<argc) {
      if ((parse(strlen(argv[optind]),argv[optind])<strlen(argv[optind]))
	  || (parse_state!=PS_COMPLETE_TREE)) {
	 puts("can't parse matching pattern");
	 exit(1);
      }
      match_pattern=parse_stack[0];
      stack_ptr=0;
      optind++;
   } else
     usage_message();
   
   /* count explicit filenames */
   num_files=argc-optind;
   
   /* loop on default dictionaries */
   if (dictname!=NULL) {
      dictdir=getenv("IDSGREP_DICTDIR");
      if (dictdir==NULL)
	dictdir=DICTDIR;
      dictglob=(char *)malloc(strlen(dictdir)+strlen(dictname)+8);
      sprintf(dictglob,"%s/%s*.eids",dictdir,dictname);
      if (glob(dictglob,0,NULL,&globres)==0) {
	 num_files+=globres.gl_pathc;
	 for (c=0;c<globres.gl_pathc;c++)
	   process_file(match_pattern,globres.gl_pathv[c],
			num_files>1?strlen(dictdir)+1:-1);
	 globfree(&globres);
      }
   }
   
   /* loop on explicit filenames */
   while (optind<argc)
     process_file(match_pattern,argv[optind++],num_files>1?0:-1);

   /* read stdin or complain */
   if (num_files==0) {
      if (dictname==NULL)
	process_file(match_pattern,"-",-1);
      else
	puts("(no dictionaries were searched)");
   }
   
   exit(0);
}
