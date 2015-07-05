/*
 * Regular-expression mapping parser
 * Copyright (C) 2014, 2015  Matthew Skala
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
#include <pcre.h>
#include <wordexp.h>

#include "icemap.h"

/**********************************************************************/

static NODE *extract_captured_field(char *haystack,int *ovector,
				    int field_num,int seq_num,
				    int is_num,int is_hex) {
   NODE *rval;
   char *cp;
   int i;

   if (field_num<0) {
      rval=node_new();
      rval->type=nt_int;
      rval->x=seq_num;
      return rval;
   }

   i=ovector[(field_num<<1)+1]-ovector[field_num<<1];
   cp=(char *)malloc(i+1);
   strncpy(cp,haystack+ovector[field_num<<1],i);
   cp[i]='\0';
   rval=node_new();
   
   if (is_num) {
      rval->type=nt_int;
      rval->x=strtol(cp,NULL,is_hex?16:10);
      free(cp);
      
   } else {
      rval->type=nt_string;
      rval->cp=cp;
   }

   return rval;
}

void handle_rxparse(PARSER_STATE *ps) {
   NODE *tok,*ks,*ke,*v;
   char *fnglob;
   wordexp_t wet;
   int start_field,end_field,val_field,reading_ranges;
   int start_is_hex=0,end_is_hex=0,val_is_hex=0;
   pcre *parse_compiled,*skip_compiled;
   pcre_extra *parse_studied,*skip_studied;
   const char *errptr;
   int erroffset;
   int file_num,line_num,seq_num;
   FILE *data_file;
   char *buf=NULL;
   size_t buf_size=0;
   ssize_t line_length;
   int i,j;
   int *capvec,capvec_length;

   if (context_stack->parse_regex==NULL) {
      parse_error(ps,"must set parserx before rxparse");
      return;
   }

   ps->ignore_semicolon=0;
   tok=get_token(ps);
   if (tok->type!=nt_string) {
      parse_error(ps,"rxparse file pattern isn't a string");
      node_delete(tok);
      return;
   }
   fnglob=tok->cp;
   tok->cp=NULL;
   node_delete(tok);

   tok=get_token(ps);
   if ((tok->type==nt_keyword) && (strcmp(tok->cp,"x")==0)) {
      start_is_hex=1;
      node_delete(tok);
      tok=get_token(ps);
   }
   if (tok->type!=nt_int) {
      parse_error(ps,"key field number must be integer or x+integer");
      free(fnglob);
      node_delete(tok);
      return;
   }
   start_field=tok->x;
   node_delete(tok);
   
   tok=get_token(ps);
   if (tok->type!=nt_keyword) {
      parse_error(ps,"rxparse syntax error");
      free(fnglob);
      node_delete(tok);
      return;

   } else if (strcmp(tok->cp,"->")==0) {
      reading_ranges=0;
      end_field=start_field;

   } else if (strcmp(tok->cp,"..")==0) {
      node_delete(tok);
      reading_ranges=1;

      tok=get_token(ps);
      if ((tok->type==nt_keyword) && (strcmp(tok->cp,"x")==0)) {
	 end_is_hex=1;
	 node_delete(tok);
	 tok=get_token(ps);
      }
      if (tok->type!=nt_int) {
	 parse_error(ps,"key field number must be integer or x+integer");
	 free(fnglob);
	 node_delete(tok);
	 return;
      }
      end_field=tok->x;
      node_delete(tok);
      
      tok=get_token(ps);
      if ((tok->type!=nt_keyword) || (strcmp(tok->cp,"->")!=0)) {
	 parse_error(ps,"rxparse syntax error");
	 free(fnglob);
	 node_delete(tok);
	 return;
      }

   } else {
      parse_error(ps,"rxparse syntax error");
      free(fnglob);
      node_delete(tok);
      return;
   }
   node_delete(tok);

   tok=get_token(ps);
   if ((tok->type==nt_keyword) && (strcmp(tok->cp,"x")==0)) {
      val_is_hex=1;
      node_delete(tok);
      tok=get_token(ps);
   }
   if (tok->type!=nt_int) {
      parse_error(ps,"value field number must be integer or x+integer");
      free(fnglob);
      node_delete(tok);
      return;
   }
   val_field=tok->x;
   node_delete(tok);

   ps->ignore_semicolon=1;
   
   if (wordexp(fnglob,&wet,0)!=0) {
      parse_error(ps,"error expanding rxparse file pattern");
      free(fnglob);
      return;
   }
   free(fnglob);

   parse_compiled=pcre_compile(context_stack->parse_regex,PCRE_UTF8,
			      &errptr,&erroffset,NULL);
   if (parse_compiled==NULL) {
      parse_error(ps,"PCRE error in parserx: %s",errptr);
      return;
   }
   parse_studied=pcre_study(parse_compiled,0,&errptr);
   if (errptr!=NULL) {
      parse_error(ps,"PCRE study error in parserx: %s",errptr);
      pcre_free(parse_compiled);
      return;
   }

   capvec_length=10;
   pcre_fullinfo(parse_compiled,parse_studied,
		 PCRE_INFO_CAPTURECOUNT,&capvec_length);
   if ((start_field>capvec_length) || (start_field<-1) ||
       (end_field>capvec_length) || (end_field<-1) ||
       (val_field>capvec_length) || (val_field<-1)) {
      parse_error(ps,"parserx field number out of range");
      pcre_free(parse_compiled);
      if (parse_studied!=NULL)
	pcre_free(parse_studied);
      return;
   }
   capvec_length=(capvec_length+1)*3;
   capvec=(int *)malloc(sizeof(int)*capvec_length);

   if (context_stack->skip_regex!=NULL) {
      skip_compiled=pcre_compile(context_stack->skip_regex,PCRE_UTF8,
				  &errptr,&erroffset,NULL);
      if (skip_compiled==NULL) {
	 parse_error(ps,"PCRE error in skiprx: %s",errptr);
	 free(capvec);
	 pcre_free(parse_compiled);
	 if (parse_studied!=NULL)
	   pcre_free(parse_studied);
	 return;
      }
      skip_studied=pcre_study(skip_compiled,0,&errptr);
      if (errptr!=NULL) {
	 parse_error(ps,"PCRE study error in skiprx: %s",errptr);
	 free(capvec);
	 pcre_free(parse_compiled);
	 if (parse_studied!=NULL)
	   pcre_free(parse_studied);
	 return;
      }
   } else {
      skip_compiled=NULL;
      skip_studied=NULL;
   }

   for (file_num=0;file_num<wet.we_wordc;file_num++) {
      data_file=fopen(wet.we_wordv[file_num],"r");
      if (data_file==NULL) {
	 parse_error(ps,"can't open rxparse file %s",wet.we_wordv[file_num]);
	 continue;
      }
      
      line_num=0;
      seq_num=0;
      while ((line_length=getline(&buf,&buf_size,data_file))>0) {
	 line_num++;
	 
	 if ((skip_compiled!=NULL) &&
	     (pcre_exec(skip_compiled,skip_studied,buf,line_length,
			0,0,NULL,0)>=0))
	   continue;

	 if (pcre_exec(parse_compiled,parse_studied,buf,line_length,
		       0,0,capvec,capvec_length)>=0) {
	    ks=extract_captured_field(buf,capvec,start_field,seq_num,
				      reading_ranges||start_is_hex,
				      start_is_hex);
	    v=extract_captured_field(buf,capvec,val_field,seq_num,
				     val_is_hex,val_is_hex);

	    if (reading_ranges) {
	       ke=extract_captured_field(buf,capvec,end_field,seq_num,
				      1,end_is_hex);
	       if (ks->x>ke->x)
		 fprintf(stderr,"%s line %d: malformed range %d..%d\n",
			 wet.we_wordv[file_num],line_num,ks->x,ke->x);

	       while (ks->x<=ke->x) {
		  if (!raw_add_arrow(&(context_stack->am),ks,v,
				     context_stack->dupe_priority)) {
		     if (ks->type==nt_string)
		       fprintf(stderr,"%s line %d: duplicate key %s\n",
			       wet.we_wordv[file_num],line_num,ks->cp);
		     else
		       fprintf(stderr,"%s line %d: duplicate key %d\n",
			       wet.we_wordv[file_num],line_num,ks->x);
		     close_output_files();
		     exit(1);
		  }
		  tok=node_new();
		  tok->type=nt_int;
		  tok->x=ks->x+1;
		  node_delete(ks);
		  ks=tok;
	       }
	       
	       node_delete(ke);

	    } else if (!raw_add_arrow(&(context_stack->am),ks,v,
				      context_stack->dupe_priority)) {
	       if (ks->type==nt_string)
		 fprintf(stderr,"%s line %d: duplicate key %s\n",
			 wet.we_wordv[file_num],line_num,ks->cp);
	       else
		 fprintf(stderr,"%s line %d: duplicate key %d\n",
			 wet.we_wordv[file_num],line_num,ks->x);
	       close_output_files();
	       exit(1);
	    }

	    node_delete(ks);
	    node_delete(v);

	    seq_num++;
	 }
      }
      
      fclose(data_file);
   }

   if (buf!=NULL)
     free(buf);

   pcre_free(parse_compiled);
   if (parse_studied!=NULL)
     pcre_free(parse_studied);
   if (skip_compiled!=NULL)
     pcre_free(skip_compiled);
   if (skip_studied!=NULL)
     pcre_free(skip_studied);
   free(capvec);
}
