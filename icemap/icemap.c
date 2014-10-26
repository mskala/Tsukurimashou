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

#include "icemap.h"

/**********************************************************************/

static NODE *free_nodes=NULL;

NODE *node_new(void) {
   NODE *rval;
   
   if (free_nodes!=NULL) {
      rval=free_nodes;
      free_nodes=rval->next;
   } else
     rval=(NODE *)malloc(sizeof(NODE));

   rval->next=NULL;
   rval->refs=1;
   rval->cp=NULL;
   return rval;
}

void node_delete(NODE *n) {
   n->refs--;
   if (n->refs<=0) {
      if (n->cp!=NULL) {
	 free(n->cp);
	 n->cp=NULL;
      }
      n->next=free_nodes;
      free_nodes=n;
   }
}

/**********************************************************************/

void handle_opening_brace(void) {
}

void handle_closing_brace(void) {
}

/**********************************************************************/

int main(int argc,char **argv) {
   handle_opening_brace();
   parse();
   handle_closing_brace();
   return 0;
}
