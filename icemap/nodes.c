/*
 * Node handling for Icemap
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
#include <string.h>

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
   rval->nodes=NULL;
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

int atom_cmp(NODE *x,NODE *y) {
   if ((x==NULL) || (y==NULL))
     return -2;
   if (x->type!=y->type)
     return -2;
   if (x->type==nt_string)
     return strcmp(x->cp,y->cp);
   if (x->type!=nt_int)
     return -2;
   if (x->x<y->x)
     return -1;
   if (x->x>y->x)
     return 1;
   return 0;
}
