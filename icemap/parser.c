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

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <ctype.h>
#include <wordexp.h>

#include "icemap.h"

/**********************************************************************/

void parse_error(PARSER_STATE *ps,char *message,...) {
   va_list val;

   if (ps->file_stack!=NULL)
     fprintf(stderr,"%s line %d: ",
	     ps->file_stack->cp,ps->file_stack->x);
   else
     fputs("<EOF>: ",stderr);
   va_start(val,message);
   vfprintf(stderr,message,val);
   va_end(val);
   fputc('\n',stderr);
}

/**********************************************************************/

NODE *get_token(PARSER_STATE *ps) {
   int state=0,negate=0,hd_trash_warned=0;
   int ch;
   char *buf,*hdtag;
   int buf_size,in_buf,start_of_line;
   NODE *rval,*tmpn;
   
   rval=node_new();
   
   buf=(char *)malloc(sizeof(char)*100);
   buf_size=100;
   in_buf=0;
   
   while (1) {
      if (in_buf>(buf_size-2)) {
	 buf_size*=4;
	 buf_size/=3;
	 buf=(char *)realloc(buf,buf_size);
      }

      ch=fgetc(ps->file_stack->fp);
      if (ch=='\n')
	ps->file_stack->x++;
      
      if (ch<0) {
	 fclose(ps->file_stack->fp);
	 tmpn=ps->file_stack->next;
	 node_delete(ps->file_stack);
	 ps->file_stack=tmpn;
	 if (ps->file_stack!=NULL)
	   continue;

	 free(buf);
	 rval->type=nt_eof;
	 return rval;
      }
      
      switch (state) {
       
       case 1: /* reading keyword */
	 if (isalpha(ch))
	   buf[in_buf++]=tolower(ch);
	 else {
	    ungetc(ch,ps->file_stack->fp);
	    if (ch=='\n')
	      ps->file_stack->x--;
	    buf[in_buf++]='\0';
	    rval->type=nt_keyword;
	    rval->cp=buf;
	    return rval;
	 }
	 break;
	 
       case 2: /* saw 0: will be octal or hex integer */
	 if ((ch=='x') || (ch=='X'))
	   state=16; /* hex */
	 else {
	    ungetc(ch,ps->file_stack->fp);
	    if (ch=='\n')
	      ps->file_stack->x--;
	    state=17; /* octal */
	 }
	 in_buf=0;
	 break;
	 
       case 3: /* reading decimal int */
	 if (isdigit(ch)) {
	    buf[in_buf++]=ch;
	 } else {
	    ungetc(ch,ps->file_stack->fp);
	    if (ch=='\n')
	      ps->file_stack->x--;
	    buf[in_buf++]='\0';
	    rval->type=nt_int;
	    rval->x=atoi(buf);
	    if (negate)
	      rval->x=(-rval->x);
	    free(buf);
	    return rval;
	 }
	 break;

       case 18: /* saw less-than (could be start of here document) */
	 if (ch=='<') {
	    state=19;
	    in_buf=0;
	    break;
	 }
	 /* FALL THROUGH */

       case 4: /* reading punctuation (returns as keyword) */
	 if (ispunct(ch) && (ch!='-') && (ch!=';') && (ch!='"'))
	   buf[in_buf++]=ch;
	 else {
	    ungetc(ch,ps->file_stack->fp);
	    if (ch=='\n')
	      ps->file_stack->x--;
	    buf[in_buf++]='\0';
	    rval->type=nt_keyword;
	    rval->cp=buf;
	    return rval;
	 }
	 break;
	 
       case 5: /* saw slash: should be start of C comment */
	 if (ch=='*')
	   state=6;
	 else {
	    parse_error(ps,"unexpected slash");
	    ungetc(ch,ps->file_stack->fp);
	    if (ch=='\n')
	      ps->file_stack->x--;
	    state=0;
	 }
	 in_buf=0;
	 break;

       case 6: /* inside C comment */
	 if (ch=='*')
	   state=7;
	 break;

       case 7: /* inside C comment, have seen star */
	 if (ch=='/') {
	    state=0;
	    in_buf=0;
	 } else if (ch!='*')
	   state=6;
	 break;
	 
       case 8: /* inside hash comment */
	 if (ch=='\n') {
	    state=0;
	    in_buf=0;
	 }
	 break;
	 
       case 9: /* inside quoted string */
	 if (ch=='\\')
	   state=10;
	 else if (ch=='"') {
	    buf[in_buf++]='\0';
	    rval->type=nt_string;
	    rval->cp=buf;
	    return rval;
	 } else
	   buf[in_buf++]=ch;
	 break;
	 
       case 10: /* escape sequence */
	 state=9;
	 switch (ch) {
	  case 'a':
	    buf[in_buf++]='\a';
	    break;

	  case 'b':
	    buf[in_buf++]='\b';
	    break;

	  case 'e':
	    buf[in_buf++]=27;
	    break;
	    
	  case 'f':
	    buf[in_buf++]='\f';
	    break;

	  case 'n':
	    buf[in_buf++]='\n';
	    break;

	  case 'r':
	    buf[in_buf++]='\r';
	    break;

	  case 't':
	    buf[in_buf++]='\t';
	    break;

	  case 'v':
	    buf[in_buf++]='\v';
	    break;
	    
	  case 'x':
	    state=11;
	    break;
	    
	  case '0':
	  case '1':
	  case '2':
	  case '3':
	    buf[in_buf]=((ch-'0')<<6);
	    state=13;
	    break;
	    
	  default:
	    buf[in_buf++]=ch;
	 }
	 break;
	 
       case 11: /* first digit of hex escape */
	 if (isxdigit(ch)) {
	    if (ch<='9')
	      buf[in_buf]=(ch-'0')<<4;
	    else
	      buf[in_buf]=(toupper(ch)-'A'+10)<<4;
	    state=12;
	 } else {
	    parse_error(ps,"bad digit %c in hex escape",ch);
	    state=9;
	 }
	 break;

       case 12: /* second digit of hex escape */
	 if (isxdigit(ch)) {
	    if (ch<='9')
	      buf[in_buf++]+=(ch-'0');
	    else
	      buf[in_buf++]+=(toupper(ch)-'A'+10);
	 } else
	   parse_error(ps,"bad digit %c in hex escape",ch);
	 state=9;
	 break;

       case 13: /* second digit of octal escape */
	 if ((ch>='0') && (ch<='7')) {
	    buf[in_buf]+=((ch-'0')<<3);
	    state=14;
	 } else {
	    parse_error(ps,"bad digit %c in octal escape",ch);
	    state=9;
	 }
	 break;

       case 14: /* third digit of octal escape */
	 if ((ch>='0') && (ch<='7'))
	   buf[in_buf++]+=(ch-'0');
	 else
	   parse_error(ps,"bad digit %c in octal escape",ch);
	 state=9;
	 break;
	 
       case 15: /* saw minus: negative int, or mapping arrow */
	 if (isdigit(ch)) {
	    buf[0]=ch;
	    in_buf=1;
	    state=(ch=='0')?2:3;
	 } else if (ch=='>') {
	    buf[1]='>';
	    buf[2]='\0';
	    rval->type=nt_keyword;
	    rval->cp=buf;
	    return rval;
	 } else {
	    parse_error(ps,"unexpected minus");
	    ungetc(ch,ps->file_stack->fp);
	    if (ch=='\n')
	      ps->file_stack->x--;
	    state=0;
	    in_buf=0;
	 }
	 break;

       case 16: /* reading hexadecimal int */
	 if (isxdigit(ch)) {
	    buf[in_buf++]=ch;
	 } else {
	    ungetc(ch,ps->file_stack->fp);
	    if (ch=='\n')
	      ps->file_stack->x--;
	    buf[in_buf++]='\0';
	    rval->type=nt_int;
	    rval->x=strtol(buf,NULL,16);
	    if (negate)
	      rval->x=(-rval->x);
	    free(buf);
	    return rval;
	 }
	 break;

       case 17: /* reading octal int */
	 if ((ch>='0') && (ch<='7')) {
	    buf[in_buf++]=ch;
	 } else {
	    ungetc(ch,ps->file_stack->fp);
	    if (ch=='\n')
	      ps->file_stack->x--;
	    buf[in_buf++]='\0';
	    rval->type=nt_int;
	    rval->x=strtol(buf,NULL,8);
	    if (negate)
	      rval->x=(-rval->x);
	    free(buf);
	    return rval;
	 }
	 break;

	 
       case 19: /* reading end-of-here-doc tag */
	 if (isspace(ch)) {
	    hd_trash_warned=0;
	    state=(ch=='\n')?21:20;
	    buf[in_buf]='\0';
	    hdtag=buf;

	    buf=(char *)malloc(sizeof(char)*100);
	    buf_size=100;
	    in_buf=0;
	    start_of_line=0;
	 } else
	   buf[in_buf++]=ch;
	 break;
	 
       case 20: /* skipping after end-of-here-doc tag */
	 if (ch=='\n') {
	    state=21;
	 } else if (!isspace(ch)) {
	    if (!hd_trash_warned)
	      parse_error(ps,"trash after here document tag definition");
	    hd_trash_warned=1;
	 }
	 break;
	 
       case 21: /* reading here document */
	 if (ch=='\n') {
	    buf[in_buf]='\0';
	    if (strcmp(buf+start_of_line,hdtag)==0) {
	       free(hdtag);
	       buf[start_of_line]='\0';
	       rval->type=nt_string;
	       rval->cp=buf;
	       return rval;
	    }
	    start_of_line=in_buf+1;
	 }
	 buf[in_buf++]=ch;
	 break;

       default: /* in between tokens */
	 if (isspace(ch))
	   continue;

	 else if (isalpha(ch)) {
	    state=1;
	    ch=tolower(ch);

	 } else if (isdigit(ch))
	      state=(ch=='0')?2:3;
	 else switch (ch) {

	  case ';': /* semicolon separates statements */
	    if (!(ps->ignore_semicolon)) {
	       parse_error(ps,"unexpected semicolon");
	       exit(1);
	    } else
	      continue;
	    break;
	    
	  case '/':
	    state=5;
	    break;
	    
	  case '#':
	    state=8;
	    break;
	    
	  case '"':
	    state=9;
	    continue;
	    
	  case '-':
	    negate=(!negate);
	    state=15;
	    break;
	    
	  case '<':
	    state=18;
	    break;

	  default: /* punctuation */
	    state=4;
	    break;
	 }
	 buf[in_buf++]=ch;
	 break;
      }
   }
}

/**********************************************************************/

static void handle_include(PARSER_STATE *ps) {
   NODE *filename_tok,*tmp;
   wordexp_t wet;
   int i;
   
   ps->ignore_semicolon=0;
   filename_tok=get_token(ps);
   ps->ignore_semicolon=1;
   if (filename_tok->type!=nt_string) {
      parse_error(ps,"include file pattern isn't a string");
      node_delete(filename_tok);
      return;
   }

   if (wordexp(filename_tok->cp,&wet,0)!=0) {
      parse_error(ps,"error expanding include file pattern");
      node_delete(filename_tok);
      return;
   }
   node_delete(filename_tok);

   for (i=wet.we_wordc-1;i>=0;i--) {
      tmp=node_new();
      tmp->type=nt_parser_file;
      tmp->fp=fopen(wet.we_wordv[i],"r");
      if (tmp->fp==NULL) {
	 parse_error(ps,"can't open include file %s",wet.we_wordv[i]);
	 node_delete(tmp);
	 continue;
      }
      tmp->cp=strdup(wet.we_wordv[i]);
      tmp->x=1;

      tmp->next=ps->file_stack;
      ps->file_stack=tmp;
   }
}

/**********************************************************************/

void complete_int_range(PARSER_STATE *ps,NODE *start_tok) {
   NODE *end_tok;

   if (start_tok==NULL) {
      parse_error(ps,"integer range has no start");
      return;
   }

   if (start_tok->type!=nt_int) {
      parse_error(ps,"start of range is not an integer");
      return;
   }
   
   end_tok=get_token(ps);
   
   if (end_tok->type!=nt_int) {
      parse_error(ps,"end of range is not an integer");
      node_delete(end_tok);
      return;
   }

   if (end_tok->x<start_tok->x) {
      parse_error(ps,"end of range is before start");
      node_delete(end_tok);
      return;
   }
   
   start_tok->type=nt_int_range;
   start_tok->y=end_tok->x;
   node_delete(end_tok);
/* printf("<%d..%d>\n",start_tok->x,start_tok->y); */
   return;
}

static void handle_string_or_null(PARSER_STATE *ps,char **val,char *name) {
   NODE *tok;
   
   tok=get_token(ps);
   if ((tok->type==nt_keyword) && (strcmp(tok->cp,"null")==0)) {
      if (*val!=NULL)
	free(*val);
      *val=NULL;

   } else if (tok->type==nt_string) {
      if (*val!=NULL)
	free(*val);
      *val=strdup(tok->cp);

   } else
     parse_error(ps,"%s must be string or null",name);

   node_delete(tok);
   ps->ignore_semicolon=1;
}

/**********************************************************************/

static void handle_priority(PARSER_STATE *ps) {
   NODE *tok;
   
   ps->ignore_semicolon=0;
   tok=get_token(ps);

   if (tok->type!=nt_keyword)
     parse_error(ps,"priority must be a keyword");
   else if (strcmp(tok->cp,"error")==0)
     context_stack->dupe_priority=dp_error;
   else if (strcmp(tok->cp,"first")==0)
     context_stack->dupe_priority=dp_first;
   else if (strcmp(tok->cp,"last")==0)
     context_stack->dupe_priority=dp_last;
   else if (strcmp(tok->cp,"min")==0)
     context_stack->dupe_priority=dp_min;
   else if (strcmp(tok->cp,"max")==0)
     context_stack->dupe_priority=dp_max;
   else
     parse_error(ps,"unknown priority keyword %s",tok->cp);
   
   node_delete(tok);
   ps->ignore_semicolon=1;
}

/**********************************************************************/

void parse(void) {
   PARSER_STATE ps;
   NODE *token,*tmp;

   ps.file_stack=node_new();
   ps.file_stack->type=nt_parser_file;
   ps.file_stack->fp=stdin;
   ps.file_stack->cp=strdup("<stdin>");
   ps.file_stack->x=1;

   ps.first_token=NULL;
   ps.last_token=NULL;
   
   handle_opening_brace(&ps);

   while (ps.file_stack!=NULL) {
      token=get_token(&ps);
      
      if (token->type==nt_eof) {
	node_delete(token);
	break;
      }
      
      if ((context_stack==NULL) &&
	  !((token->type==nt_keyword) && (strcmp(token->cp,"{")==0))) {
	 parse_error(&ps,
		     "cannot do anything without a context except open one");
	 exit(1);
      }
      
      if (token->type==nt_keyword) {
	 
	 if (strcmp(token->cp,"include")==0)
	   handle_include(&ps);
	 
	 else if (strcmp(token->cp,"->")==0)
	   add_one_arrow(&ps);
	 
	 else if (strcmp(token->cp,"=>")==0)
	   add_many_arrows(&ps);
	 
	 else if (strcmp(token->cp,"..")==0)
	   complete_int_range(&ps,ps.last_token);

	 else {
	    if (ps.first_token!=NULL) {
	       parse_error(&ps,"unconsumed tokens flushed");
	       while (ps.first_token!=NULL) {
		  tmp=ps.first_token;
		  ps.first_token=tmp->next;
		  node_delete(tmp);
	       }
	    }
	    
	    if (strcmp(token->cp,"{")==0)
	      handle_opening_brace(&ps);

	    else if (strcmp(token->cp,"}")==0)
	      handle_closing_brace(&ps);
	    
	    else if (strcmp(token->cp,"parserx")==0)
	      handle_string_or_null(&ps,
				    &(context_stack->parse_regex),"parserx");

	    else if (strcmp(token->cp,"priority")==0)
	      handle_priority(&ps);
	    
	    else if (strcmp(token->cp,"skiprx")==0)
	      handle_string_or_null(&ps,
				    &(context_stack->skip_regex),"skiprx");
	    
	    else {
	       parse_error(&ps,"unknown token %s",token->cp);
	       ps.ignore_semicolon=0;
	    }

	 }
	 node_delete(token);
	 
      } else {
	 if (ps.first_token==NULL)
	   ps.first_token=token;
	 else
	   ps.last_token->next=token;
	 token->next=NULL;
	 ps.last_token=token;
	 ps.ignore_semicolon=0;
      }
   }
   
   if (ps.first_token!=NULL) {
      parse_error(&ps,"unconsumed tokens flushed at end of session");
      while (ps.first_token!=NULL) {
	 tmp=ps.first_token;
	 ps.first_token=tmp->next;
	 node_delete(tmp);
      }
   }

   while (context_stack!=NULL)
     handle_closing_brace(&ps);
}
