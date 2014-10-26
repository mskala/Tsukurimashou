/*
 * Add arrows to the current mapping context
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

void raw_add_arrow(PARSER_STATE *ps,NODE *k,NODE *v) {
   int i,replace=0;

#if 0
   if (k->type==nt_int)
     printf("%d",k->x);
   else
     printf("\"%s\"",k->cp);
   if (v->type==nt_int)
     printf(" -> %d\n",v->x);
   else
     printf(" -> \"%s\"\n",v->cp);
#endif
   
   for (i=0;i<context_stack->num_arrows;i++)
     if (atom_cmp(context_stack->arrows[i<<1],k)==0) {
	switch (context_stack->dupe_priority) {
	   
	 case dp_first:
	   break;
	   
	 case dp_last:
	   replace=1;
	   break;
	   
	 case dp_min:
	   replace=(atom_cmp(context_stack->arrows[(i<<1)+1],v)>0);
	   break;
	   
	 case dp_max:
	   replace=(atom_cmp(v,context_stack->arrows[(i<<1)+1])>0);
	   break;
	   
	 default: /* error */
	   if (k->type==nt_string)
	     parse_error(ps,"duplicate key %s",k->cp);
	   else
	     parse_error(ps,"duplicate key %d",k->x);
	   exit(1);
	   break;
	}
	
	if (replace) {
	   node_delete(context_stack->arrows[(i<<1)+1]);
	   v->refs++;
	   context_stack->arrows[(i<<1)+1]=v;
	}
	return;
     }

   if (context_stack->num_arrows>=context_stack->max_arrows) {
      context_stack->max_arrows=context_stack->num_arrows*4;
      context_stack->max_arrows/=3;
      context_stack->arrows=
	(NODE **)realloc(context_stack->arrows,
			 (sizeof(NODE *)*2)*context_stack->max_arrows);
   }

   k->refs++;
   context_stack->arrows[context_stack->num_arrows<<1]=k;
   v->refs++;
   context_stack->arrows[((context_stack->num_arrows++)<<1)+1]=v;
}

/**********************************************************************/

void add_one_arrow(PARSER_STATE *ps) {
   NODE *val;

   if ((ps->first_token==NULL) || (ps->first_token->next!=NULL)) {
      parse_error(ps,"-> needs exactly one key");
      return;
   }
   
   val=get_token(ps);

   if ((val->type!=nt_int) && (val->type!=nt_string))
      parse_error(ps,"-> needs a string or integer as value");
   else
     raw_add_arrow(ps,ps->first_token,val);
   
   node_delete(val);
   node_delete(ps->first_token);
   ps->first_token=NULL;
   ps->last_token=NULL;
   ps->ignore_semicolon=1;
}

/**********************************************************************/

void add_many_arrows(PARSER_STATE *ps) {
   NODE *key,*val=NULL,*vals=NULL;

   if (ps->first_token==NULL) {
      parse_error(ps,"=> needs at least one key");
      return;
   }
   
   while (ps->first_token!=NULL) {
      if (ps->first_token->type==nt_int_range) {
	 if (ps->first_token->x>ps->first_token->y) {
	    key=ps->first_token;
	    ps->first_token=key->next;
	    node_delete(key);
	    continue;
	 }

	 key=node_new();
	 key->type=nt_int;
	 key->x=ps->first_token->x++;

      } else {
	 key=ps->first_token;
	 ps->first_token=key->next;

	 if ((ps->first_token->type!=nt_int) &&
	     (ps->first_token->type!=nt_string)) {
	    parse_error(ps,"=> needs integers, ranges, or strings as keys");
	    node_delete(key);
	    continue;
	 }
      }
      
      while (1) {
	 if (vals==NULL)
	   vals=get_token(ps);
      
	 if ((vals->type==nt_keyword) && (strcmp(vals->cp,"..")==0)) {
	    complete_int_range(ps,val);
	    node_delete(vals);
	    vals=val;
	    val=NULL;
	    vals->x++; /* already saw first element */
	 }
	 
	 if ((vals->type==nt_int) || (vals->type==nt_string)) {
	    if (val!=NULL)
	      node_delete(val);
	    val=vals;
	    vals=NULL;
	    break;
	 }
	 
	 if (vals->type==nt_int_range) {
	    if (vals->x>vals->y) {
	       node_delete(vals);
	       vals=NULL;
	       continue;
	    }

	    if (val!=NULL)
	      node_delete(val);

	    val=node_new();
	    val->type=nt_int;
	    val->x=vals->x++;
	    break;
	 }
	 
	 parse_error(ps,"=> needs integers, ranges, or strings as values");
	 node_delete(vals);
	 vals=NULL;
      }

      raw_add_arrow(ps,key,val);      
      node_delete(key);
   }
   ps->last_token=NULL;
   
   if (val!=NULL)
     node_delete(val);
   
   if (vals!=NULL) {
      if ((vals->type==nt_int_range) && (vals->x<=vals->y))
	parse_error(ps,"values remaining in range at end of =>");
      node_delete(vals);
   }
   
   ps->ignore_semicolon=1;
}
