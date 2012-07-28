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

static char output_recipe[6]="111111";

/**********************************************************************/

void set_output_recipe(char *r) {
   /* FIXME */
   cook_output=1;
}

/**********************************************************************/

void write_cooked_tree(NODE *ms) {
   NODE *tail;
   int i;

   while (ms) {
      tail=ms->match_parent;
      
      for (i=ms->arity-1;i>=0;i--) {
	 ms->child[i]->match_parent=tail;
	 tail=ms->child[i];
      }
      
      if (ms->head)
	printf("<%s>",ms->head->data);
      switch (ms->arity) {
       case 3:
	 printf("{%s}",ms->functor->data);
	 break;

       case 2:
	 printf("[%s]",ms->functor->data);
	 break;
       
       case 1:
	 printf(".%s.",ms->functor->data);
	 break;
       
       case 0:
       default:
	 printf("(%s)",ms->functor->data);
	 break;
      }
      
      ms->match_parent=NULL;
      ms=tail;
   }
   
   putchar('\n');
}
