/*
 * Add arrows to the current mapping context
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

#include "icemap.h"

/**********************************************************************/

void arrow_map_new(ARROW_MAP *am) {
   int i;

   am->arrows=(NODE **)malloc(sizeof(NODE *)*16);
   am->num_arrows=0;
   am->num_buckets=16;
   for (i=0;i<am->num_buckets;i++)
     am->arrows[i]=NULL;
   am->first_key=NULL;
   am->last_key=NULL;
}

void arrow_map_copy(ARROW_MAP *zm,ARROW_MAP *am) {
   int i;
   NODE *ni,*nn;

   zm->arrows=(NODE **)malloc(sizeof(NODE *)*am->num_buckets);
   zm->num_arrows=am->num_arrows;
   zm->num_buckets=am->num_buckets;
   zm->first_key=am->first_key;
   zm->last_key=am->last_key;

   for (i=0;i<zm->num_buckets;i++) {
     zm->arrows[i]=NULL;

     for (ni=am->arrows[i];ni!=NULL;ni=ni->next) {
	nn=node_new();

	nn->type=ni->type;
	if (nn->type==nt_string)
	  nn->cp=strdup(ni->cp);
	else
	  nn->x=ni->x;
	nn->nodes=ni->nodes;
	nn->nodes->refs++;
	
	nn->next=zm->arrows[i];
	zm->arrows[i]=nn;
     }
   }
}

void arrow_map_delete(ARROW_MAP *am) {
   int i;
   NODE *n;
   
   for (i=0;i<am->num_buckets;i++)
     while (am->arrows[i]!=NULL) {
	n=am->arrows[i]->next;
	node_delete(am->arrows[i]->nodes);
	node_delete(am->arrows[i]);
	am->arrows[i]=n;
     }
   am->first_key=NULL;
   am->last_key=NULL;
   
   free(am->arrows);
}

/**********************************************************************/

/* Fowler-Noll-Vo hash, type 1a, on unsigned ints or uint32_ts,
 * whichever are bigger, but always folding to a uint32_t. */

static inline uint32_t fnv_hash(int m,char *a) {
   int i;
#if UINT_MAX==0xFFFFFFFFFFFFFFFF
   unsigned int hval=14695981039346656037U;

   for (i=0;i<m;i++) {
      hval^=a[i];
      hval*=1099511628211U;
   }

   return (uint32_t)(hval^(hval>>32));
#else
   uint32_t hval=UINT32_C(2166136261);

   for (i=0;i<m;i++) {
      hval^=a[i];
      hval*=UINT32_C(16777619);
   }

   return hval;
#endif
}

NODE *arrow_map_lookup(ARROW_MAP *am,NODE *k) {
   uint32_t h;
   NODE *n;
   
   h=(k->type==nt_string)?fnv_hash(strlen(k->cp),k->cp):
     fnv_hash(sizeof(int),(char *)&(k->x));
   h%=am->num_buckets;

   for (n=am->arrows[h];n!=NULL;n=n->next)
     if (atom_cmp(k,n)==0)
       return n->nodes;

   return NULL;
}

int raw_add_arrow(ARROW_MAP *am,NODE *k,NODE *v,DUPE_PRIORITY dp) {
   int replace=0;
   uint32_t h;
   NODE *n,**new_arrows;
   int i;

#if 1
   if (k->type==nt_int)
     printf("%d",k->x);
   else
     printf("\"%s\"",k->cp);
   if (v->type==nt_int)
     printf(" -> %d\n",v->x);
   else
     printf(" -> \"%s\"\n",v->cp);
#endif
   
   h=(k->type==nt_string)?fnv_hash(strlen(k->cp),k->cp):
     fnv_hash(sizeof(int),(char *)&(k->x));
   h%=am->num_buckets;
   
   for (n=am->arrows[h];n!=NULL;n=n->next)
     if (atom_cmp(k,n)==0)
       break;

   if (n!=NULL) {
      switch (dp) {
	 
       case dp_first:
	 break;
	 
       case dp_last:
	 replace=1;
	 break;
	 
       case dp_min:
	 replace=(atom_cmp(n->nodes,v)>0);
	 break;
	 
       case dp_max:
	 replace=(atom_cmp(v,n->nodes)>0);
	 break;

       default: /* error */
	 return 0;
      }
	
      if (replace) {
	 node_delete(n->nodes);
	 v->refs++;
	 n->nodes=v;
      }

   } else {
      k->refs++;
      k->next=am->arrows[h];
      am->arrows[h]=k;
      
      v->refs++;
      k->nodes=v;
      
      if ((am->first_key==NULL) || (atom_cmp(k,am->first_key)==-1))
	am->first_key=k;
      if ((am->last_key==NULL) || (atom_cmp(k,am->last_key)==1))
	am->last_key=k;
      
      am->num_arrows++;
      if (am->num_arrows>am->num_buckets) {
	 am->num_buckets*=2;
	 new_arrows=(NODE **)malloc(sizeof(NODE *)*am->num_buckets);
	 for (i=0;i<am->num_buckets;i++)
	   new_arrows[i]=NULL;
	 for (i=0;i<am->num_buckets/2;i++)
	   while (am->arrows[i]) {
	      n=am->arrows[i];
	      am->arrows[i]=n->next;

	      h=(n->type==nt_string)?fnv_hash(strlen(n->cp),n->cp):
		fnv_hash(sizeof(int),(char *)&(n->x));
	      h%=am->num_buckets;

	      n->next=new_arrows[h];
	      new_arrows[h]=n;
	   }
	 free(am->arrows);
	 am->arrows=new_arrows;
      }
   }

   return 1;
}

/**********************************************************************/

void arrow_map_remap_keys(ARROW_MAP *zm,ARROW_MAP *am,ARROW_MAP *bm,
			 DUPE_PRIORITY dp) {
   int i,j;
   NODE *ni,*nk,*nv;

   zm->arrows=(NODE **)malloc(sizeof(NODE *)*am->num_buckets);
   zm->num_arrows=0;
   zm->num_buckets=am->num_buckets;
   zm->first_key=NULL;
   zm->last_key=NULL;

   for (i=0;i<zm->num_buckets;i++)
     zm->arrows[i]=NULL;
   
   for (i=0;i<zm->num_buckets;i++) {
      for (ni=am->arrows[i];ni!=NULL;ni=ni->next) {
	 nv=arrow_map_lookup(bm,ni);
	 if (nv==NULL)
	   nv=ni;
	 nk=node_new();

	 nk->type=nv->type;
	 if (nk->type==nt_string)
	   nk->cp=strdup(nv->cp);
	 else
	   nk->x=nv->x;

	 raw_add_arrow(zm,nk,ni->nodes,dp);
	 node_delete(nk);
      }
   }
}

void arrow_map_remap_values(ARROW_MAP *zm,ARROW_MAP *am,ARROW_MAP *bm) {
   int i;
   NODE *ni,*nk,*nv;
   
   zm->arrows=(NODE **)malloc(sizeof(NODE *)*am->num_buckets);
   zm->num_arrows=am->num_arrows;
   zm->num_buckets=am->num_buckets;
   zm->first_key=NULL;
   zm->last_key=NULL;

   for (i=0;i<zm->num_buckets;i++) {
     zm->arrows[i]=NULL;

     for (ni=am->arrows[i];ni!=NULL;ni=ni->next) {
	nv=arrow_map_lookup(bm,ni->nodes);
	if (nv==NULL)
	  nv=ni->nodes;
	nk=node_new();

	nk->type=ni->type;
	if (nk->type==nt_string)
	  nk->cp=strdup(ni->cp);
	else
	  nk->x=ni->x;
	nk->nodes=nv;
	nk->nodes->refs++;
	
	nk->next=zm->arrows[i];
	zm->arrows[i]=nk;

	if ((zm->first_key==NULL) || (atom_cmp(nk,zm->first_key)==-1))
	  zm->first_key=nk;
	if ((zm->last_key==NULL) || (atom_cmp(nk,zm->last_key)==1))
	  zm->last_key=nk;
     }
   }
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
   else if (!raw_add_arrow(&(context_stack->am),ps->first_token,val,
			   context_stack->dupe_priority)) {
      if (ps->first_token->type==nt_string)
	parse_error(ps,"duplicate key %s",ps->first_token->cp);
      else
	parse_error(ps,"duplicate key %d",ps->first_token->x);
      close_output_files();
      exit(1);
   }

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

	 if ((key->type!=nt_int) && (key->type!=nt_string)) {
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

      if (!raw_add_arrow(&(context_stack->am),key,val,
			 context_stack->dupe_priority)) {
	 if (key->type==nt_string)
	   parse_error(ps,"duplicate key %s",key->cp);
	 else
	   parse_error(ps,"duplicate key %d",key->x);
	 close_output_files();
	 exit(1);
      }
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
