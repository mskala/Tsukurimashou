/*
 * Output translations for IDSgrep
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

#define OS_TOP_HEAD_BRACKET_TYPE 0
#define OS_INNER_HEAD_BRACKET_TYPE 1
#define OS_NULLARY_BRACKET_TYPE 2
#define OS_UNARY_BRACKET_TYPE 3
#define OS_BINARY_BRACKET_TYPE 4
#define OS_TERNARY_BRACKET_TYPE 5
#define OS_INDENTATION 6
#define OS_SEPARATOR 7
#define OS_SUGAR 8
#define OS_ESCAPE_WHAT 9
#define OS_ESCAPE_HOW 10

#define NUM_OUTPUT_SETTINGS 11

static char output_recipe[NUM_OUTPUT_SETTINGS]="11111111111";

#define NUM_PRESET_RECIPES 1

static struct {char *name,*recipe;} preset_recipe[NUM_PRESET_RECIPES]={
   {"",""},
};

/**********************************************************************/

void set_output_recipe(char *r) {
   int i;

   if (strcmp(r,"raw")==0) {
      cook_output=0;
      return;
   }
   
   cook_output=1;
   
   for (i=0;i<NUM_PRESET_RECIPES;i++)
     if (strcmp(r,preset_recipe[i].name)==0)
       r=preset_recipe[i].recipe;
   
   for (i=0;i<NUM_OUTPUT_SETTINGS;i++) {
      if ((r[i]>='0') && (r[i]<='9'))
	output_recipe[i]=r[i];
      if (r[i]=='\0')
	break;
   }
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

void write_bracketed_string(HASHED_STRING *hs,HASHED_STRING *br) {
   int i,do_esc;

   fwrite(br->data,1,br->length,stdout);
   for (i=0;i<hs->length;i+=char_length(hs->data+i)) {

      if (hs->data[i]=='\\') /* backslash - always escape */
	do_esc=1;
      else if ((i+br->mate->length<=hs->length) &&
	       (strncmp(hs->data+i,br->mate->data,br->mate->length)==0))
	do_esc=((i>0) || (output_recipe[OS_ESCAPE_WHAT]>='6'));
      else if (((unsigned char)hs->data[i])>=0xF0) /* astral planes */
	do_esc=output_recipe[OS_ESCAPE_WHAT]>='1';
      else if ((((unsigned char)hs->data[i])>=0xE3) &&
	       (((unsigned char)hs->data[i])<=0xED)) /* mainline CJK */
	do_esc=output_recipe[OS_ESCAPE_WHAT]>='4';
      else if (((unsigned char)hs->data[i])==0xEE) /* low PUA */
	do_esc=output_recipe[OS_ESCAPE_WHAT]>='2';
      else if (((unsigned char)hs->data[i])>=0x80) /* non-ASCII */
	do_esc=output_recipe[OS_ESCAPE_WHAT]>='3';
      else if (((unsigned char)hs->data[i])<=0x20) /* ASCII controls */
	do_esc=output_recipe[OS_ESCAPE_WHAT]>='5';
      
      if (do_esc) {
	 switch (output_recipe[OS_ESCAPE_HOW]) {

	  case '0':
	  default:
	    fputc('\\',stdout);
	    fwrite(hs->data+i,1,char_length(hs->data+i),stdout);
	    break;
	    
	    /* FIXME add other escape forms */
	 }
      } else
	fwrite(hs->data+i,1,char_length(hs->data+i),stdout);
   }
   fwrite(br->mate->data,1,br->mate->length,stdout);
}

/**********************************************************************/

void write_cooked_tree(NODE *ms) {
   NODE *tail;
   HASHED_STRING *semicolon;
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
	 fwrite(ms->head->data,ms->head->length,1,stdout);
	 
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
	 
	 if ((output_recipe[OS_SUGAR]&1) &&
	     (ms->functor->arity==ms->arity) &&
	     (char_length(ms->functor->data)==ms->functor->length)) {
	    fwrite(ms->functor->data,ms->functor->length,1,stdout);
	    
	 } else {
	    i=output_recipe[OS_NULLARY_BRACKET_TYPE+ms->arity]-'0';
	    if (i>2) i=2;
	    write_bracketed_string(ms->functor,
				   hashed_bracket[3*(ms->arity+1)+i]);
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
