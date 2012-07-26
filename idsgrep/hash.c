/*
 * String hash table for IDSgrep
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

/**********************************************************************/

#define NUM_BITS (sizeof(size_t)*8)

static HASHED_STRING *free_strings[NUM_BITS]={
#if SIZEOF_INT>=8
   NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
   NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
#endif
#if SIZEOF_INT>=6
   NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
   NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
#endif
#if SIZEOF_INT>=4
   NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
   NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
#endif
   NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
   NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
};

NODE *default_match_fn(NODE *);

HASHED_STRING *alloc_string(size_t len) {
   int i=1;
   HASHED_STRING *rval;
   char *save_data;

   while ((((size_t)1)<<i)<=len) i++;
   if (free_strings[i]==NULL) {
      rval=(HASHED_STRING *)malloc(sizeof(HASHED_STRING));
      memset(rval,0,sizeof(HASHED_STRING));
      rval->data=(char *)malloc(((size_t)1)<<i);
   } else {
      rval=free_strings[i];
      free_strings[i]=rval->next;
      save_data=rval->data;
      memset(rval,0,sizeof(HASHED_STRING));
      rval->data=save_data;
   }
   rval->length=len;
   rval->arity=-2;
   rval->match_fn=default_match_fn;
   rval->pcre_compiled=NULL;
   rval->pcre_studied=NULL;
   return rval;
}

void free_string(HASHED_STRING *s) {
   int i=1;
   
   while ((((size_t)1)<<i)<=s->length) i++;
   s->next=free_strings[i];
   if (s->pcre_compiled) {
      free(s->pcre_compiled);
      s->pcre_compiled=NULL;
   }
   if (s->pcre_studied) {
      free(s->pcre_studied);
      s->pcre_studied=NULL;
   }
   free_strings[i]=s;
}

#define MIN_HTABLE 100

static HASHED_STRING **hash_table=NULL;
static int hash_table_size=0;
static int hash_table_occupancy=0;

unsigned int hash_function(size_t len,char *s) {
   unsigned int rval=1;
   size_t i;
   
   for (i=0;i<len;i++) {
      rval=(rval<<1)^rval^(rval>>1)^(unsigned int)(s[i]);
   }
   return rval;
}

HASHED_STRING *new_string(size_t len,char *s) {
   unsigned int h,tmph;
   int i;
   HASHED_STRING *tmps;
   HASHED_STRING **new_table;
   
   /* make sure we have a table to begin with */
   if (hash_table_size==0) {
      hash_table=(HASHED_STRING **)malloc(sizeof(HASHED_STRING *)*MIN_HTABLE);
      hash_table_size=MIN_HTABLE;
      for (i=0;i<hash_table_size;i++)
	hash_table[i]=NULL;
   }
   
   /* search for the string in the hash table */
   h=hash_function(len,s);
   for (tmps=hash_table[h%hash_table_size];
	tmps && ((tmps->length!=len) || memcmp(tmps->data,s,len));
	tmps=tmps->next);
   
   /* if found, add a reference and we're done */
   if (tmps) {
      tmps->refs++;

     /* otherwise, it'll be a new entry */
   } else {
      
      /* first, deal with expanding the table */
      if (hash_table_occupancy>2*hash_table_size) {
	 hash_table_size*=2;
	 new_table=(HASHED_STRING **)
	   malloc(sizeof(HASHED_STRING *)*hash_table_size);
	 for (i=0;i<hash_table_size;i++)
	   new_table[i]=NULL;
	 for (i=0;i<(hash_table_size/2);i++)
	   while (hash_table[i]) {
	      tmps=hash_table[i];
	      hash_table[i]=tmps->next;
	      tmph=hash_function(tmps->length,tmps->data)%hash_table_size;
	      tmps->next=new_table[tmph];
	      new_table[tmph]=tmps;
	   }
	 free(hash_table);
	 hash_table=new_table;
      }
      
      /* actually add the new entry */
      tmps=alloc_string(len);
      memcpy(tmps->data,s,len);
      tmps->data[len]='\0';
      tmps->length=len;
      tmps->refs=1;
      tmps->next=hash_table[h%hash_table_size];
      hash_table[h%hash_table_size]=tmps;
      hash_table_occupancy++;
   }
   
   return tmps;
}

void delete_string(HASHED_STRING *s) {
   unsigned int h;
   HASHED_STRING *tmps;

   s->refs--;
   if (s->refs==0) {
      h=hash_function(s->length,s->data)%hash_table_size;
      if (hash_table[h]==s) {
	 hash_table[h]=s->next;
      } else {
	 for (tmps=hash_table[h];tmps->next!=s;tmps=tmps->next);
	 tmps->next=s->next;
      }
      free_string(s);
      hash_table_occupancy--;
      
      /* FIXME handle shrinking table */
   }
}

/**********************************************************************/

static NODE *free_nodes=NULL;

NODE *new_node(void) {
   NODE *rval;

   if (free_nodes) {
      rval=free_nodes;
      free_nodes=rval->nc_next;
   } else {
      rval=(NODE *)malloc(sizeof(NODE));
   }
   memset(rval,0,sizeof(NODE));
   rval->refs=1;
   return rval;
}

void free_node(NODE *n) {
   NODE *tmpn,*to_free=NULL;
   int i;

   n->refs--;
   if (n->refs==0) {
      n->match_parent=to_free;
      to_free=n;
   }
   
   while (to_free) {
      tmpn=to_free;
      to_free=tmpn->match_parent;
      
      for (i=0;i<3;i++)
	if (tmpn->child[i]!=NULL) {
	   tmpn->child[i]->refs--;
	   if (tmpn->child[i]->refs==0) {
	      tmpn->child[i]->match_parent=to_free;
	      to_free=tmpn->child[i];
	   }
	}

      if (tmpn->head!=NULL)
	delete_string(tmpn->head);
      if (tmpn->functor!=NULL)
	delete_string(tmpn->functor);

      tmpn->nc_next=free_nodes;
      free_nodes=tmpn;
   }
}

