/*
 * Extended IDS matcher
 * Copyright (C) 2012, 2013  Matthew Skala
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

#include <sys/stat.h>
#include <sys/types.h>

#include "idsgrep.h"
#include "getopt.h"

/**********************************************************************/

static int generate_index=0,ignore_indices=0;
/* basic search and index generation */
void process_file(NODE *match_pattern,char *fn,int fn_flag) {
   int read_amt,flag,i;
   NODE *to_match;
   char *input_buffer=NULL;
   int inbuf_size=0,inbuf_used=0,parse_ptr=0;
   FILE *infile;
   HASHED_STRING *hfn,*colon;
   off_t offset=0;
   INDEX_HEADER ih;
   INDEX_RECORD ir;
   
   if (generate_index) {
      /* write header */
      ih.magica=fnv_hash(MSEED_SIZE*sizeof(uint32_t),(char *)magic_seed,0);
      ih.despell=fnv_hash(MSEED_SIZE*sizeof(uint32_t),(char *)magic_seed,1);
      fwrite(&ih,sizeof(INDEX_HEADER),1,stdout);

   } else {
      /* wrap the filename in a string so we can escape-print it */
      if (fn_flag>=0)
	hfn=new_string(strlen(fn+fn_flag),fn+fn_flag);
      else
	hfn=new_string(strlen(fn),fn);
      colon=new_string(1,":");
   }

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

	    if (generate_index) {
	       for (i=0;((unsigned char)input_buffer[i])<=0x20;i++)
		 offset++;
	       ir.offset=offset;
	       haystack_bits_fn(to_match,ir.bits);
	       fwrite(&ir,sizeof(INDEX_RECORD),1,stdout);
	       offset+=(parse_ptr-i);
	       if (bitvec_debug) {
		  fprintf(stderr,"%016" PRIX64 "%016" PRIX64 "(%3d) ",
			  ir.bits[1],ir.bits[0],uint64_2_pop(ir.bits));
		  fwrite(input_buffer+i,1,parse_ptr-i,stderr);
		  fputc('\n',stderr);
	       }

	    } else if (tree_match(match_pattern,to_match)) {
	       for (i=0;((unsigned char)input_buffer[i])<=0x20;i++);
	       if (fn_flag>=0)
		 write_bracketed_string(hfn,colon,stdout);
	       if (cook_output)
		 write_cooked_tree(to_match,stdout);
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
   
   if (generate_index) {
      offset+=inbuf_used;
      ir.offset=offset;
      ir.bits[0]=UINT64_C(0);
      ir.bits[1]=UINT64_C(0);
      fwrite(&ir,sizeof(INDEX_RECORD),1,stdout);
   } else {
      delete_string(hfn);
      delete_string(colon);
   }
}

/**********************************************************************/

#define IDX_REC_BLK 2001

static uint64_t bv_checks=UINT64_C(0),bv_hits=UINT64_C(0);
static uint64_t tree_hits=UINT64_C(0);
static BIT_FILTER bf;
static NODE *indexed_pattern=NULL;

#ifdef HAVE_BUDDY

static uint64_t bdd_hits=UINT64_C(0);

static int eval_bdd(bdd decision_diagram,uint64_t bits[2]) {
   int v;

   while (1) {
      if (decision_diagram==bddtrue)
	return 1;
      if (decision_diagram==bddfalse)
	return 0;
      v=bdd_var(decision_diagram);
      if ((UINT64_C(1)<<(v&0x3F))&bits[v>>6])
	decision_diagram=bdd_high(decision_diagram);
      else
	decision_diagram=bdd_low(decision_diagram);
   }
}

#endif

void process_file_indexed(NODE *match_pattern,char *fn,int fn_flag) {
   int i,ir_avail,ir_done;
   NODE *to_match;
   FILE *infile,*idxfile;
   HASHED_STRING *hfn,*colon;
   off_t offset;
   INDEX_HEADER ih;
   INDEX_RECORD *ir;
   struct stat stat_buff;
   time_t mtime;
   char *dict_buff;
   size_t dict_buff_size=0,entry_size,parsed;
   uint64_t btest[2];

   /* bail, if we can't use an index or have been told to ignore it */
   if (ignore_indices || generate_index || (strcmp(fn,"-")==0)) {
      if (bitvec_debug && !generate_index) {
	 puts("can't use index on stdin, nor both ignore and debug it");
	 exit(1);
      } else {
	 process_file(match_pattern,fn,fn_flag);
	 return;
      }
   }
   ir=(INDEX_RECORD *)malloc(IDX_REC_BLK*sizeof(INDEX_RECORD));
   
   /* look for index file */
   for (i=0;fn[i]!='\0';i++);
   if ((i<5) || (strcmp(fn+i-5,".eids")!=0)
       || (stat(fn,&stat_buff)!=0)) {
      free(ir);
      if (bitvec_debug) {
	 puts("filename doesn't end in .eids, or can't stat");
	 exit(1);
      } else {
	 process_file(match_pattern,fn,fn_flag);
	 return;
      }
   }
   mtime=stat_buff.st_mtime;
   strcpy(fn+i-4,"bvec");
   if ((stat(fn,&stat_buff)!=0) || (stat_buff.st_mtime<mtime)
       || ((idxfile=fopen(fn,"rb"))==NULL)) {
      strcpy(fn+i-4,"eids");
      free(ir);
      if (bitvec_debug) {
	 puts("bit vector file too old, or can't stat or open it");
	 exit(1);
      } else {
	 process_file(match_pattern,fn,fn_flag);
	 return;
      }
   }
   strcpy(fn+i-4,"eids");
   
   /* check for compatible header */
   if ((fread(&ih,sizeof(INDEX_HEADER),1,idxfile)!=1)
       || (ih.magica!=fnv_hash(MSEED_SIZE*sizeof(uint32_t),
			       (char *)magic_seed,0))
       || (ih.despell!=fnv_hash(MSEED_SIZE*sizeof(uint32_t),
				(char *)magic_seed,1))
       || (fread(ir,sizeof(INDEX_RECORD),1,idxfile)!=1)) {
      fclose(idxfile);
      free(ir);
      if (bitvec_debug) {
	 puts("can't read desired header from bit vector file");
	 exit(1);
      } else {
	 process_file(match_pattern,fn,fn_flag);
	 return;
      }
   }
   
   /* Now we are committed to index mode. */
   
   /* analyse the query */
   if (indexed_pattern==NULL) {
#ifdef HAVE_BUDDY
      bdd_init(10000,1000);
      bdd_setvarnum(128);
      if (!bitvec_debug)
	bdd_gbc_hook(NULL);
      needle_fn_wrapper(match_pattern,&bf);
      if (bitvec_debug)
	bdd_fprinttable(stderr,bf.decision_diagram);
#else
      needle_fn_wrapper(match_pattern,&bf);
#endif
      indexed_pattern=match_pattern;
      /* we assume we'll never have to deal with another pattern... */
   }
   
   /* wrap the filename in a string so we can escape-print it */
   if (fn_flag>=0)
     hfn=new_string(strlen(fn+fn_flag),fn+fn_flag);
   else
     hfn=new_string(strlen(fn),fn);
   colon=new_string(1,":");

   /* open input file */
   infile=fopen(fn,"rb");
   if (infile==NULL) {
      fclose(idxfile);
      free(ir);
      fprintf(stderr,"can't open %s for reading\n",fn);
      return;
   }
   offset=(off_t)0;
   
   /* loop over input */
   ir_avail=0;
   while (!(feof(idxfile) || ferror(idxfile))) {

      /* try reading some index records */
      ir_avail+=fread(ir+ir_avail+1,sizeof(INDEX_RECORD),
		      IDX_REC_BLK-ir_avail-1,idxfile);

      /* loop through whatever records we have */
      for (ir_done=0;ir_done<ir_avail;ir_done++) {
	 btest[0]=ir[ir_done].bits[0]&bf.bits[0];
	 btest[1]=ir[ir_done].bits[1]&bf.bits[1];
	 bv_checks++;
	 
	 /* do the bitvec/lambda test */
	 if (uint64_2_pop(btest)>bf.lambda) {
	    bv_hits++;
	    
#ifdef HAVE_BUDDY
	    /* do the bitvec/BDD test */
	    if (eval_bdd(bf.decision_diagram,ir[ir_done].bits)) {
	       bdd_hits++;
#endif
	       
	       /* go to appropriate place in the file */
	       if ((offset!=ir[ir_done].offset)
		   && (fseeko(infile,ir[ir_done].offset,SEEK_SET)!=0)) {
		  fclose(infile);
		  fclose(idxfile);
		  free(ir);
		  fprintf(stderr,"error seeking in %s\n",fn);
		  return;
	       }
	       offset=ir[ir_done].offset;
	       
	       /* check we have a buffer and it's big enough */
	       entry_size=ir[ir_done+1].offset-offset;
	       if (entry_size>dict_buff_size) {
		  if (dict_buff_size>0)
		    free(dict_buff);
		  dict_buff=(char *)malloc(entry_size*2);
		  dict_buff_size=entry_size*2;
	       }
	       
	       /* attempt to read the entry */
	       if (fread(dict_buff,1,entry_size,infile)!=entry_size) {
		  fclose(infile);
		  fclose(idxfile);
		  free(ir);
		  fprintf(stderr,"error reading entry from %s\n",fn);
		  return;
	       }
	       offset=ir[ir_done+1].offset;
	       
	       /* parse */
	       parsed=parse(entry_size,dict_buff);
	       
	       /* MUST have a complete entry at this point */
	       if (parse_state!=PS_COMPLETE_TREE) {
		  puts("can't parse input pattern");
		  fwrite(dict_buff,1,parsed,stdout);
		  putchar('\n');
		  fclose(infile);
		  fclose(idxfile);
		  free(ir);
		  exit(1);
	       }
	       
	       /* handle the parsed tree */
	       to_match=parse_stack[0];
	       stack_ptr=0;
	    
	       if (tree_match(match_pattern,to_match)) {
		  tree_hits++;
		  if (fn_flag>=0)
		    write_bracketed_string(hfn,colon,stdout);
		  if (cook_output)
		    write_cooked_tree(to_match,stdout);
		  else
		    fwrite(dict_buff,1,entry_size,stdout);
	       }
	       free_node(to_match);
#ifdef HAVE_BUDDY
	    }
#endif
	 }
      }
      
      /* shift down the last record */
      ir[0]=ir[ir_avail];
      ir_avail=0;
   }
   
   fclose(infile);
   fclose(idxfile);
   
   if (dict_buff_size>0) free(dict_buff);
   free(ir);

   delete_string(hfn);
   delete_string(colon);
}

/**********************************************************************/

static struct option long_opts[] = {
   {"bitvec-debug",no_argument,NULL,'D'|128},
   {"cooking",required_argument,NULL,'c'},
   {"dictionary",optional_argument,NULL,'d'},
   {"font-chars",required_argument,NULL,'f'},
   {"help",no_argument,NULL,'h'},
   {"generate-index",no_argument,NULL,'G'},
   {"ignore-indices",no_argument,NULL,'I'},
   {"unicode-list",optional_argument,NULL,'U'},
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
   char *dictdir,*dictname=NULL,*dictglob,*unilist_cfg=NULL;
   glob_t globres;
   int show_version=0,show_help=0,generate_list=0;

   /* quick usage message */
   if (argc<2)
     usage_message();
   
   /* initialize */
   register_syntax();

   /* loop on command-line options */
   while ((c=getopt_long(argc,argv,"GIU::Vc:d::f:h",long_opts,NULL))!=-1) {
      switch (c) {

       case 'G':
	 generate_index=1;
	 break;
	 
       case 'I':
	 ignore_indices=1;
	 break;
	 
       case 'U':
	 generate_list=1;
	 unilist_cfg=optarg;
	 break;

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
	 
       case 'f':
	 font_file_userpred(optarg);
	 break;
	 
       case 'h':
	 show_help=1;
	 break;
	 
       case 'D'|128:
	 bitvec_debug=1;

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
	  "  -G, --generate-index      generate bit vector index\n"
	  "  -I, --ignore-indices      ignore bit vector indices\n"
	  "  -U, --unicode-list=CFG    generate Unicode list\n"
	  "  -V, --version             display version and license\n"
	  "  -c, --cooking=FMT         set input/output cooking\n"
	  "  -d, --dictionary=NAME     search standard dictionary\n"
	  "  -f, --font-chars=FONT     use chars in FONT as a user-defined"
	                             " predicate\n"
	  "      --bitvec-debug        verbose bit vector debugging"
	                             " messages\n"
	  "  -h, --help                display this help");
   
   if (show_version || show_help)
     exit(0);
 
   /* parse matching pattern (automatic wildcard in generate mode) */
   if (generate_index) {
      parse(1,"?");
      match_pattern=parse_stack[0];
      stack_ptr=0;
   } else if (optind<argc) {
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
   
   /* generate Unicode list if requested */
   if (generate_list)
     generate_unicode_list(match_pattern,unilist_cfg);

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
	   process_file_indexed(match_pattern,globres.gl_pathv[c],
				num_files>1?strlen(dictdir)+1:-1);
	 globfree(&globres);
      }
      free(dictglob);
   }
   
   /* loop on explicit filenames */
   while (optind<argc)
     process_file_indexed(match_pattern,argv[optind++],num_files>1?0:-1);

   /* read stdin or complain */
   if ((num_files==0) && (generate_list==0)) {
      if (dictname==NULL)
	process_file(match_pattern,"-",-1);
      else
	puts("(no dictionaries were searched)");
   }
   
   /* print statistics */
   if (bitvec_debug && !generate_index) {
      fprintf(stderr,"%20" PRIu64 " bitvec checks\n",bv_checks);
      if (bv_checks>UINT64_C(0)) {
	 fprintf(stderr,"%20" PRIu64 " bitvec hits (%d.%d%%)\n",
		bv_hits,(int)((100*bv_hits)/bv_checks),
		((int)((1000*bv_hits)/bv_checks))%10);
	 if (bv_hits>UINT64_C(0)) {
#ifdef HAVE_BUDDY
	    fprintf(stderr,"%20" PRIu64 " bdd hits (%d.%d%% of bitvec hits, "
		    "%d.%d%% of all)\n",
		    bdd_hits,(int)((100*bdd_hits)/bv_hits),
		    ((int)((1000*bdd_hits)/bv_hits))%10,
		    (int)((100*bdd_hits)/bv_checks),
		    ((int)((1000*bdd_hits)/bv_checks))%10);
	    if (bdd_hits>UINT64_C(0))
	      fprintf(stderr,"%20" PRIu64 " tree hits ("
		      "%d.%d%% of bdd hits, "
		      "%d.%d%% of bitvec hits, "
		      "%d.%d%% of all)\n",
		      tree_hits,
		      (int)((100*tree_hits)/bdd_hits),
		      ((int)((1000*tree_hits)/bdd_hits))%10,
		      (int)((100*tree_hits)/bv_hits),
		      ((int)((1000*tree_hits)/bv_hits))%10,
		      (int)((100*tree_hits)/bv_checks),
		      ((int)((1000*tree_hits)/bv_checks))%10);
#else
	    fprintf(stderr,"%20" PRIu64 " tree hits (%d.%d%% of bitvec hits, "
		   "%d.%d%% of all)\n",
		   tree_hits,(int)((100*tree_hits)/bv_hits),
		   ((int)((1000*tree_hits)/bv_hits))%10,
		   (int)((100*tree_hits)/bv_checks),
		   ((int)((1000*tree_hits)/bv_checks))%10);
#endif
	 }
      }
   }

   exit(0);
}
