/*
 * I/O translations for IDSgrep
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

#include "idsgrep.h"

int cook_output=0;
int canonicalize_input=1;

#define OS_TOP_HEAD_BRACKET_TYPE 0    /* 0 ASCII, 1 B lentic., 2 W lentic. */
#define OS_INNER_HEAD_BRACKET_TYPE 1  /* like OS_TOP_HEAD_BRACKET_TYPE */
#define OS_NULLARY_BRACKET_TYPE 2     /* 0 paren, 1 wide paren, 2 dbl wide */
#define OS_UNARY_BRACKET_TYPE 3       /* 0 period, 1 colon, 2 centre dot */
#define OS_BINARY_BRACKET_TYPE 4      /* 0 square bckt, 1 wide, 2 dbl wide */
#define OS_TERNARY_BRACKET_TYPE 5     /* 0 curly brace, 1 B tort, 2 W tort */
#define OS_INDENTATION 6              /* 8=tab, else # of spaces */
#define OS_SEPARATOR 7                /* 0 null, 1 \n, 2 \n\n, 3 nothing */
#define OS_SUGAR 8                    /* 4 syrup @top +2 not @top +1 sugar */
#define OS_ESCAPE_WHAT 9              /* increasing subsets from 0 to 7 */
#define OS_ESCAPE_HOW 10              /* 0-5: \ \alpha \x{} \x \X smart */
#define OS_CANONICAL 11               /* 4 don't on input +2 a->u +1 u->a */

#define NUM_OUTPUT_SETTINGS 12

static char output_recipe[NUM_OUTPUT_SETTINGS]="100000013250";

#define NUM_PRESET_RECIPES 5

static struct {char *name,*recipe;} preset_recipe[NUM_PRESET_RECIPES]={
   {"ascii", "000000013551"},
   {"cooked","100000013250"},
   {"indent","100000223250"},
   {"raw",   "000000000000"},
   {"rawnc", "000000000004"},
};

/**********************************************************************/

void set_output_recipe(char *r) {
   int i;

   cook_output=(strlen(r)>=3) && (strncmp(r,"raw",3)!=0);
   
   for (i=0;i<NUM_PRESET_RECIPES;i++)
     if (strcmp(r,preset_recipe[i].name)==0)
       r=preset_recipe[i].recipe;
   
   for (i=0;i<NUM_OUTPUT_SETTINGS;i++) {
      if ((r[i]>='0') && (r[i]<='9'))
	output_recipe[i]=r[i];
      if (r[i]=='\0')
	break;
   }
   
   canonicalize_input=((output_recipe[OS_CANONICAL]&4)==0);
}

/**********************************************************************/

int char_length(char *c) {
   if (((unsigned char)*c)<0x80)
     return 1;
   else if (((unsigned char)*c)<0xC0) {
      puts("found UTF-8 continuation byte when clean " /* SNH */
	   "character expected"); /* SNH */
      exit(1); /* SNH */
   } else if (((unsigned char)*c)<0xE0)
	return 2;
   else if (((unsigned char)*c)<0xF0)
     return 3;
   else if (((unsigned char)*c)<0xF5)
     return 4;
   else {
      puts("found non-Unicode UTF-8 length byte when " /* SNH */
	   "clean character expected"); /* SNH */
      exit(1); /* SNH */
   }
}

/**********************************************************************/

void write_maybe_escaped_char(char *cp,HASHED_STRING *br) {
   int c,do_esc;

   switch (char_length(cp)) {
    case 1:
      c=(unsigned char)cp[0];
      break;
    case 2:
      c=(((unsigned char)cp[0]&0x1F)<<6)|
	((unsigned char)cp[1]&0x3F);
      break;
    case 3:
      c=(((unsigned char)cp[0]&0x0F)<<12)|
	(((unsigned char)cp[1]&0x3F)<<6)|
	((unsigned char)cp[2]&0x3F);
      break;
    case 4:
      c=(((unsigned char)cp[0]&0x07)<<18)|
	(((unsigned char)cp[1]&0x3F)<<12)|
	(((unsigned char)cp[2]&0x3F)<<6)|
	((unsigned char)cp[3]&0x3F);
      break;
    default:
      puts("internal error, inconsistent char length"); /* SNH */
      exit(1); /* SNH */
   }
   
   if (c=='\\') /* backslash - always escape */
     do_esc=1;
   else if ((br!=NULL) && (strncmp(cp,br->data,br->length)==0))
     /* must escape closing bracket if we were told about it  */
     do_esc=1;
   else if (c>0xFFFF) /* astral planes */
     do_esc=output_recipe[OS_ESCAPE_WHAT]>='1';
   else if ((c>=0x4E00) && (c<=0x9FFF)) /* mainline CJK */
     do_esc=output_recipe[OS_ESCAPE_WHAT]>='4';
   else if ((c>=0xE000) && (c<=0xF8FF)) /* low PUA */
     do_esc=output_recipe[OS_ESCAPE_WHAT]>='2';
   else if (c>=0x80) /* non-ASCII */
     do_esc=output_recipe[OS_ESCAPE_WHAT]>='3';
   else if (c<0x20) /* ASCII controls */
     do_esc=output_recipe[OS_ESCAPE_WHAT]>='5';
   else /* all others */
     do_esc=output_recipe[OS_ESCAPE_WHAT]>='7';
   
   if (do_esc) {
      switch (output_recipe[OS_ESCAPE_HOW]) {
	 
       case '5':
       case '3':
	 if (((output_recipe[OS_ESCAPE_HOW]=='3') || (c>=0x7F)) &&
	     (c<=0xFF)) {
	    printf("\\x%02X",c);
	    break;
	 }
	 /* FALL THROUGH */
	 
       case '4':
	 if (((output_recipe[OS_ESCAPE_HOW]=='4') || (c>0xFF)) &&
	     (c<=0xFFFF)) {
	    printf("\\X%04X",c);
	    break;
	 }
	 /* FALL THROUGH */
	 
       case '2':
	 if ((output_recipe[OS_ESCAPE_HOW]=='2') || (c>0xFFFF)) {
	    printf("\\x{%X}",c);
	    break;
	 }
	 /* FALL THROUGH */
	 
       case '1':
	 if ((c>=1) && (c<=27)) {
	    fputc('\\',stdout);
	    switch (c) {
	     case 7:
	       fputc('a',stdout);
	       break;
	     case 8:
	       fputc('b',stdout);
	       break;
	     case 27:
	       fputc('e',stdout);
	       break;
	     case 12:
	       fputc('f',stdout);
	       break;
	     case 9:
	       fputc('t',stdout);
	       break;
	     case 10:
	       fputc('n',stdout);
	       break;
	     case 13:
	       fputc('r',stdout);
	       break;
	     default:
	       fputc('c',stdout);
	       fputc(c+'A'-1,stdout);
	       break;
	    }
	    break;
	 }
	 /* FALL THROUGH */
	 
       case '0':
       default:
	   if ((output_recipe[OS_ESCAPE_HOW]=='5') &&
	       ((c<=0x1F) || (c==0x7F))) {
	      printf("\\x%02X",c);
	   } else {	      
	      if (((c|0x20)<'a') || ((c|0x20)>'z'))
		fputc('\\',stdout);
	      fwrite(cp,1,char_length(cp),stdout);
	   }
	 break;
      }
   } else
     fwrite(cp,1,char_length(cp),stdout);
}

void write_bracketed_string(HASHED_STRING *hs,HASHED_STRING *br) {
   int i;

   fwrite(br->data,1,br->length,stdout);
   for (i=0;i<hs->length;i+=char_length(hs->data+i)) {
      if ((i==0) && (output_recipe[OS_ESCAPE_WHAT]<'6'))
	write_maybe_escaped_char(hs->data+i,NULL);
      else
	write_maybe_escaped_char(hs->data+i,br->mate);
   }
   fwrite(br->mate->data,1,br->mate->length,stdout);
}

/**********************************************************************/

void write_cooked_tree(NODE *ms) {
   NODE *tail;
   HASHED_STRING *semicolon,*mf;
   int i;
   
   ms->complete=0;
   semicolon=new_string(1,";");

   while (ms) {
      tail=ms->match_parent;
      
      for (i=ms->arity-1;i>=0;i--) {
	 ms->child[i]->match_parent=tail;
	 ms->child[i]->complete=ms->complete+1;
	 tail=ms->child[i];
      }
      
      if ((output_recipe[OS_INDENTATION]!='0') && (ms->complete>0))
	putchar('\n');
      if (output_recipe[OS_INDENTATION]=='8')
	for (i=0;i<ms->complete;i++)
	  putchar('\t');
      else
	for (i=0;i<(ms->complete*(output_recipe[OS_INDENTATION]-'0'));i++)
	  putchar(' ');
      
      if (((output_recipe[OS_SUGAR]&2) || (ms->complete==0)) &&
	  ((output_recipe[OS_SUGAR]&4) || (ms->complete>0)) &&
	  (ms->head!=NULL) &&
	  (((unsigned char)ms->head->data[0])>0x20) &&
	  (char_length(ms->head->data)==ms->head->length) &&
	  (ms->head->arity==-2) &&
	  (ms->arity==0) &&
	  (ms->functor==semicolon)) {
	 write_maybe_escaped_char(ms->head->data,NULL);
	 
      } else {
	 
	 if (ms->head) {
	    if (ms->complete==0) {
	       if (output_recipe[OS_TOP_HEAD_BRACKET_TYPE]<'2')
		 write_bracketed_string(ms->head,hashed_bracket
					[output_recipe
					 [OS_TOP_HEAD_BRACKET_TYPE]-'0']);
	       else
		 write_bracketed_string(ms->head,hashed_bracket[2]);
	    } else {
	       if (output_recipe[OS_INNER_HEAD_BRACKET_TYPE]<'2')
		 write_bracketed_string(ms->head,hashed_bracket
					[output_recipe
					 [OS_INNER_HEAD_BRACKET_TYPE]-'0']);
	       else
		 write_bracketed_string(ms->head,hashed_bracket[2]);
	    }
	 }
	 
	 if ((ms->functor->canonical!=NULL) &&
	     (ms->arity==ms->functor->canonical->arity) &&
	     (output_recipe[OS_CANONICAL]&
		 ((ms->functor->data[0]&0x80)?1:2)!=0))
	   mf=ms->functor->canonical;
	 else
	   mf=ms->functor;
	 
	 if ((output_recipe[OS_SUGAR]&1) &&
	     (mf->arity==ms->arity) &&
	     (mf->mate==NULL) &&
	     (char_length(mf->data)==mf->length)) {
	    fwrite(mf->data,mf->length,1,stdout);
	    
	 } else {
	    i=output_recipe[OS_NULLARY_BRACKET_TYPE+ms->arity]-'0';
	    if (i>2) i=2;
	    write_bracketed_string(mf,hashed_bracket[3*(ms->arity+1)+i]);
	 }
      }
      
      ms->match_parent=NULL;
      ms=tail;
   }
   
   switch (output_recipe[OS_SEPARATOR]) {
    case '0':
      putchar('\0');
      break;
      /* 1 is default newline */
    case '2':
      putchar('\n');
      putchar('\n');
      break;
    case '3':
      /* 3 is nothing */
      break;
    default:
      putchar('\n');
      break;
   }
      
   delete_string(semicolon);
}
