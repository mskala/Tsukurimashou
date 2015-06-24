/*
 * File output helpers
 * Copyright (C) 2015  Matthew Skala
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

#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "icemap.h"

/**********************************************************************/

char *default_c_file=NULL,*default_h_file=NULL;
static NODE *opened_files=NULL;
int delete_failed=1;

/**********************************************************************/

NODE *open_output_file(char *fn) {
   NODE *tfn;
   
   if (fn==NULL)
     return NULL;
   for (tfn=opened_files;tfn;tfn=tfn->next)
     if (strcmp(tfn->cp,fn)==0)
       return tfn;

   tfn=node_new();
   tfn->type=nt_parser_file;
   tfn->next=opened_files;
   opened_files=tfn;
   tfn->cp=strdup(fn);
   tfn->fp=fopen(fn,"w");
   tfn->x=0;
   tfn->y=0;
   
   return tfn;
}

void close_output_files(void) {
   NODE *tfn;

   while (opened_files!=NULL) {
      tfn=opened_files;
      opened_files=tfn->next;
      if (tfn->fp!=NULL) {
	 if (exit_code && delete_failed)
	   unlink(tfn->cp);
	 fclose(tfn->fp);
      }
      node_delete(tfn);
   }
}

/**********************************************************************/

#ifndef HAVE_VASPRINTF
#endif

void of_write(NODE *n,char *f,...) {
   va_list val;
   char *buf,*scan;

   va_start(val,f);
   vasprintf(&buf,f,val);
   va_end(val);
   fputs(buf,n->fp);

   for (scan=buf;*scan;scan++) {
      if (*scan=='\n')
	n->x=0;
      else if (*scan=='\t')
	n->x=((n->x&~7)+8);
      else
	n->x++;
   }
   
   free(buf);
}

void of_write_wrapped(NODE *n,char *f,...) {
   va_list val;
   char *buf,*scan;
   int nx;

   for (;n->x<n->y;n->x++)
     putc(' ',n->fp);
   
   va_start(val,f);
   vasprintf(&buf,f,val);
   va_end(val);

   for (scan=buf,nx=n->x;*scan;scan++) {
      if (*scan=='\n')
	break;
      else if (*scan=='\t')
	nx=((nx&~7)+8);
      else
	nx++;
   }
   
   if (nx>=72) {
      putc('\n',n->fp);
      for (n->x=0;n->x<n->y;n->x++)
	putc(' ',n->fp);
   }
   fputs(buf,n->fp);

   for (scan=buf;*scan;scan++) {
      if (*scan=='\n')
	n->x=0;
      else if (*scan=='\t')
	n->x=((n->x&~7)+8);
      else
	n->x++;
   }
   
   free(buf);
}

void of_indent(NODE *n,int i) {
   n->y+=i;
}

void of_unindent(NODE *n,int i) {
   n->y-=i;
}

/**********************************************************************/

void handle_c_file(PARSER_STATE *ps) {
   NODE *filename_tok;

   if (context_stack==NULL) {
      parse_error(ps,"cannot set C file name without a context");
      close_output_files();
      exit(1);
   }
   
   if (context_stack->c_file!=NULL)
     free(context_stack->c_file);

   ps->ignore_semicolon=0;
   filename_tok=get_token(ps);
   ps->ignore_semicolon=1;
   if (filename_tok->type!=nt_string) {
      parse_error(ps,"C file name isn't a string");
      node_delete(filename_tok);
      return;
   }
   context_stack->c_file=strdup(filename_tok->cp);
   node_delete(filename_tok);
}

void handle_h_file(PARSER_STATE *ps) {
   NODE *filename_tok;

   if (context_stack==NULL) {
      parse_error(ps,"cannot set H file name without a context");
      close_output_files();
      exit(1);
   }
   
   if (context_stack->h_file!=NULL)
     free(context_stack->h_file);

   ps->ignore_semicolon=0;
   filename_tok=get_token(ps);
   ps->ignore_semicolon=1;
   if (filename_tok->type!=nt_string) {
      parse_error(ps,"H file name isn't a string");
      node_delete(filename_tok);
      return;
   }
   context_stack->h_file=strdup(filename_tok->cp);
   node_delete(filename_tok);
}

void handle_c_write(PARSER_STATE *ps) {
   NODE *text_tok,*f;

   if (context_stack==NULL) {
      parse_error(ps,"cannot write to C file without a context");
      close_output_files();
      exit(1);
   }

   ps->ignore_semicolon=0;
   text_tok=get_token(ps);
   ps->ignore_semicolon=1;
   if (text_tok->type!=nt_string) {
      parse_error(ps,"text for C file isn't a string");
      node_delete(text_tok);
      return;
   }

   f=open_output_file(context_stack->c_file);
   if (f==NULL) {
      parse_error(ps,"can't open C file");
      node_delete(text_tok);
      return;
   }
   of_write(f,"%s",text_tok->cp);

   node_delete(text_tok);
}

void handle_h_write(PARSER_STATE *ps) {
   NODE *text_tok,*f;

   if (context_stack==NULL) {
      parse_error(ps,"cannot write to H file without a context");
      close_output_files();
      exit(1);
   }

   ps->ignore_semicolon=0;
   text_tok=get_token(ps);
   ps->ignore_semicolon=1;
   if (text_tok->type!=nt_string) {
      parse_error(ps,"text for H file isn't a string");
      node_delete(text_tok);
      return;
   }

   f=open_output_file(context_stack->h_file);
   if (f==NULL) {
      parse_error(ps,"can't open H file");
      node_delete(text_tok);
      return;
   }
   of_write(f,"%s",text_tok->cp);

   node_delete(text_tok);
}

