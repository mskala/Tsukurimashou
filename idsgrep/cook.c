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

#define NUM_OUTPUT_SETTINGS 6

static char output_recipe[NUM_OUTPUT_SETTINGS]="111111";

#define NUM_PRESET_RECIPES 1

static struct {char *name,*recipe} preset_recipe[NUM_PRESET_RECIPES]={
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

void write_bracketed_string(HASHED_STRING *hs,HASHED_STRING *br) {
   /* FIXME */
   printf("%s%s%s",br->data,hs->data,br->mate->data);
}

/**********************************************************************/

void write_cooked_tree(NODE *ms) {
   NODE *tail;
   int i;
   
   ms->complete=0;

   while (ms) {
      tail=ms->match_parent;
      
      for (i=ms->arity-1;i>=0;i--) {
	 ms->child[i]->match_parent=tail;
	 ms->child[i]->complete=ms->complete+1;
	 tail=ms->child[i];
      }
      
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
      
      i=output_recipe[OS_NULLARY_BRACKET_TYPE+ms->arity]-'0';
      if (i>2) i=2;
      write_bracketed_string(ms->functor,hashed_bracket[3*(ms->arity+1)+i]);
      
      ms->match_parent=NULL;
      ms=tail;
   }
   
   putchar('\n');
}
