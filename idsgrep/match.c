/*
 * Matching algorithm for IDSgrep
 * Copyright (C) 2012, 2013  Matthew Skala
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

NODE *default_match_fn(NODE *ms) {
   NODE *rval,*tmpn;
   int i;
   
   if ((ms->nc_needle->arity!=ms->nc_haystack->arity) ||
       (ms->nc_needle->functor!=ms->nc_haystack->functor)) {
      ms->match_result=MR_FALSE;
      return ms;
   }
   if (ms->nc_needle->arity==0) {
      ms->match_result=MR_TRUE;
      return ms;
   }
   rval=ms;
   ms->match_result=MR_AND_MAYBE;
   for (i=0;i<ms->nc_needle->arity;i++) {
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      rval->nc_needle=ms->nc_needle->child[i];
      rval->nc_needle->refs++;
      rval->nc_haystack=ms->nc_haystack->child[i];
      rval->nc_haystack->refs++;
      rval->match_parent=ms;
   }
   return rval;
}

/**********************************************************************/

NODE *anything_match_fn(NODE *ms) {
   ms->match_result=MR_TRUE;
   return ms;
}

NODE *anywhere_match_fn(NODE *ms) {
   NODE *rval,*tmpn;
   int i;

   rval=ms;
   ms->match_result=MR_OR_MAYBE;
   
   tmpn=new_node();
   tmpn->nc_next=rval;
   tmpn->nc_next->refs++;
   rval=tmpn;

   rval->nc_needle=ms->nc_needle->child[0];
   rval->nc_needle->refs++;
   rval->nc_haystack=ms->nc_haystack;
   rval->nc_haystack->refs++;
   rval->match_parent=ms;
   
   for (i=0;i<ms->nc_haystack->arity;i++) {
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      
      tmpn->nc_needle=new_node();
      tmpn->nc_needle->arity=1;
      tmpn->nc_needle->functor=new_string(1,".");
      tmpn->nc_needle->child[0]=ms->nc_needle->child[0];
      tmpn->nc_needle->child[0]->refs++;
      
      tmpn->nc_haystack=ms->nc_haystack->child[i];
      tmpn->nc_haystack->refs++;
      tmpn->match_parent=ms;
   }
   return rval;
}

/**********************************************************************/

NODE *and_or_match_fn(NODE *ms) {
   NODE *rval,*tmpn;

   rval=ms;
   ms->match_result=(ms->nc_needle->functor->data[0]=='|')?
     MR_OR_MAYBE:MR_AND_MAYBE;
   
   tmpn=new_node();
   tmpn->nc_next=rval;
   tmpn->nc_next->refs++;
   rval=tmpn;
   
   rval->nc_needle=ms->nc_needle->child[0];
   rval->nc_needle->refs++;
   rval->nc_haystack=ms->nc_haystack;
   rval->nc_haystack->refs++;
   rval->match_parent=ms;

   tmpn=new_node();
   tmpn->nc_next=rval;
   tmpn->nc_next->refs++;
   rval=tmpn;
   
   rval->nc_needle=ms->nc_needle->child[1];
   rval->nc_needle->refs++;
   rval->nc_haystack=ms->nc_haystack;
   rval->nc_haystack->refs++;
   rval->match_parent=ms;

   return rval;
}

NODE *not_match_fn(NODE *ms) {
   NODE *rval,*tmpn;

   rval=ms;
   ms->match_result=MR_NOT_MAYBE;
   
   tmpn=new_node();
   tmpn->nc_next=rval;
   tmpn->nc_next->refs++;
   rval=tmpn;
   
   rval->nc_needle=ms->nc_needle->child[0];
   rval->nc_needle->refs++;
   rval->nc_haystack=ms->nc_haystack;
   rval->nc_haystack->refs++;
   rval->match_parent=ms;

   return rval;
}

NODE *equal_match_fn(NODE *ms) {
   NODE *rval,*tmpn;
   int i;
   
   if ((ms->nc_needle->child[0]->head!=NULL) &&
       (ms->nc_haystack->head!=NULL)) {
      ms->match_result=
	(ms->nc_needle->child[0]->head==ms->nc_haystack->head)?
	MR_TRUE:MR_FALSE;
      return ms;
   }

   if ((ms->nc_needle->child[0]->arity!=ms->nc_haystack->arity) ||
       (ms->nc_needle->child[0]->functor!=ms->nc_haystack->functor)) {
      ms->match_result=MR_FALSE;
      return ms;
   }

   if (ms->nc_needle->child[0]->arity==0) {
      ms->match_result=MR_TRUE;
      return ms;
   }

   rval=ms;
   ms->match_result=MR_AND_MAYBE;

   for (i=0;i<ms->nc_needle->child[0]->arity;i++) {
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      rval->nc_needle=ms->nc_needle->child[0]->child[i];
      rval->nc_needle->refs++;
      rval->nc_haystack=ms->nc_haystack->child[i];
      rval->nc_haystack->refs++;
      rval->match_parent=ms;
   }
   return rval;
}

/**********************************************************************/

NODE *unord_match_fn(NODE *ms) {
   NODE *rval,*tmpn;
   int i;

   /* short-circuit head-to-head */
   if ((ms->nc_needle->child[0]->head!=NULL) && (ms->nc_haystack->head!=NULL)) {
      ms->match_result=(ms->nc_needle->child[0]->head==ms->nc_haystack->head)?
	MR_TRUE:MR_FALSE;
      return ms;
   }
   /* now we can skip copying heads of permuted patterns */
   
   /* set up parent */
   rval=ms;
   ms->match_result=MR_OR_MAYBE;

   /* no reordering - always a possibility */
   tmpn=new_node();
   tmpn->nc_next=rval;
   tmpn->nc_next->refs++;
   rval=tmpn;

   rval->nc_needle=ms->nc_needle->child[0];
   rval->nc_needle->refs++;
   rval->nc_haystack=ms->nc_haystack;
   rval->nc_haystack->refs++;
   rval->match_parent=ms;

   if (ms->nc_needle->child[0]->arity==2) {
      
      /* BA */
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      
      rval->nc_needle=new_node();
      rval->nc_needle->functor=ms->nc_needle->child[0]->functor;
      rval->nc_needle->functor->refs++;
      rval->nc_needle->arity=ms->nc_needle->child[0]->arity;
      
      rval->nc_needle->child[0]=ms->nc_needle->child[0]->child[1];
      rval->nc_needle->child[0]->refs++;
      rval->nc_needle->child[1]=ms->nc_needle->child[0]->child[0];
      rval->nc_needle->child[1]->refs++;
      
      rval->nc_haystack=ms->nc_haystack;
      rval->nc_haystack->refs++;
      rval->match_parent=ms;
      
   } else if (ms->nc_needle->child[0]->arity==3) {

      /* ACB */
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      
      rval->nc_needle=new_node();
      rval->nc_needle->functor=ms->nc_needle->child[0]->functor;
      rval->nc_needle->functor->refs++;
      rval->nc_needle->arity=ms->nc_needle->child[0]->arity;
      
      rval->nc_needle->child[0]=ms->nc_needle->child[0]->child[0];
      rval->nc_needle->child[0]->refs++;
      rval->nc_needle->child[1]=ms->nc_needle->child[0]->child[2];
      rval->nc_needle->child[1]->refs++;
      rval->nc_needle->child[2]=ms->nc_needle->child[0]->child[1];
      rval->nc_needle->child[2]->refs++;
      
      rval->nc_haystack=ms->nc_haystack;
      rval->nc_haystack->refs++;
      rval->match_parent=ms;
      
      /* BAC */
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      
      rval->nc_needle=new_node();
      rval->nc_needle->functor=ms->nc_needle->child[0]->functor;
      rval->nc_needle->functor->refs++;
      rval->nc_needle->arity=ms->nc_needle->child[0]->arity;
      
      rval->nc_needle->child[0]=ms->nc_needle->child[0]->child[1];
      rval->nc_needle->child[0]->refs++;
      rval->nc_needle->child[1]=ms->nc_needle->child[0]->child[0];
      rval->nc_needle->child[1]->refs++;
      rval->nc_needle->child[2]=ms->nc_needle->child[0]->child[2];
      rval->nc_needle->child[2]->refs++;
      
      rval->nc_haystack=ms->nc_haystack;
      rval->nc_haystack->refs++;
      rval->match_parent=ms;
      
      /* BCA */
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      
      rval->nc_needle=new_node();
      rval->nc_needle->functor=ms->nc_needle->child[0]->functor;
      rval->nc_needle->functor->refs++;
      rval->nc_needle->arity=ms->nc_needle->child[0]->arity;
      
      rval->nc_needle->child[0]=ms->nc_needle->child[0]->child[1];
      rval->nc_needle->child[0]->refs++;
      rval->nc_needle->child[1]=ms->nc_needle->child[0]->child[2];
      rval->nc_needle->child[1]->refs++;
      rval->nc_needle->child[2]=ms->nc_needle->child[0]->child[0];
      rval->nc_needle->child[2]->refs++;
      
      rval->nc_haystack=ms->nc_haystack;
      rval->nc_haystack->refs++;
      rval->match_parent=ms;
      
      /* CAB */
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      
      rval->nc_needle=new_node();
      rval->nc_needle->functor=ms->nc_needle->child[0]->functor;
      rval->nc_needle->functor->refs++;
      rval->nc_needle->arity=ms->nc_needle->child[0]->arity;
      
      rval->nc_needle->child[0]=ms->nc_needle->child[0]->child[2];
      rval->nc_needle->child[0]->refs++;
      rval->nc_needle->child[1]=ms->nc_needle->child[0]->child[0];
      rval->nc_needle->child[1]->refs++;
      rval->nc_needle->child[2]=ms->nc_needle->child[0]->child[1];
      rval->nc_needle->child[2]->refs++;
      
      rval->nc_haystack=ms->nc_haystack;
      rval->nc_haystack->refs++;
      rval->match_parent=ms;
      
      /* CBA */
      tmpn=new_node();
      tmpn->nc_next=rval;
      tmpn->nc_next->refs++;
      rval=tmpn;
      
      rval->nc_needle=new_node();
      rval->nc_needle->functor=ms->nc_needle->child[0]->functor;
      rval->nc_needle->functor->refs++;
      rval->nc_needle->arity=ms->nc_needle->child[0]->arity;
      
      rval->nc_needle->child[0]=ms->nc_needle->child[0]->child[2];
      rval->nc_needle->child[0]->refs++;
      rval->nc_needle->child[1]=ms->nc_needle->child[0]->child[1];
      rval->nc_needle->child[1]->refs++;
      rval->nc_needle->child[2]=ms->nc_needle->child[0]->child[0];
      rval->nc_needle->child[2]->refs++;
      
      rval->nc_haystack=ms->nc_haystack;
      rval->nc_haystack->refs++;
      rval->match_parent=ms;

   }

   return rval;
}

/**********************************************************************/

typedef struct _MEMO_REC {
   int generation;
   NODE *needle,*haystack;
   MATCH_RESULT match_result;
} MEMO_REC;

static int memo_mask=0,memo_gen=0;
static MEMO_REC *memo_table=NULL;
uint64_t memo_checks=UINT64_C(0),memo_hits=UINT64_C(0);


void check_memoization(void) {
   int hard_node_count;
   HASHED_STRING *hs;

   /* References subtracted off:
    *   2 for the new_string() calls right here
    *   2 because . and * are single characters and therefore immortal
    *   2 for . being an opening and closing bracket
    *   2 for . and * being "special functors" with custom match functions
    *   2 for . and * having ASCII mnemonic aliases
    * total 10
    *
    * Any other references to these strings at this point, must be
    * from nodes in the parsed matching pattern.
    *
    * This number will have to change if the set of counted references
    * to these strings created before the call to check_memoization()
    * should change in the future.
    */

   /* count refs to .*. */
   hs=new_string(1,"*");
   hard_node_count=hs->refs-6;
   delete_string(hs);

   /* count refs to ... */
   hs=new_string(1,".");
   hard_node_count+=hs->refs-4;
   delete_string(hs);

   /* decide whether to use memoization, and how big a table */
   if (hard_node_count>=3) {
      if (hard_node_count>22)
	hard_node_count=22;
      if (hard_node_count<10)
	hard_node_count=10;
      memo_table=(MEMO_REC *)malloc(sizeof(MEMO_REC)*(2<<hard_node_count));
      memo_mask=(2<<hard_node_count)-1;
   }
}

int tree_match(NODE *needle,NODE *haystack) {
   NODE *mn,*tmpn,*tmpnn;
   MEMO_REC memo_key;
   uint32_t hval;
   
   mn=new_node();
   mn->nc_needle=needle;
   mn->nc_haystack=haystack;
   needle->refs++;
   haystack->refs++;
   
   /* clear out the memoization table, first time and when counter wraps */
   if (memo_mask!=0) {
      memo_gen++;
      /* just setting the fields to zero isn't enough because of padding */
      memset(&memo_key,0,sizeof(MEMO_REC));
      memo_key.generation=memo_gen;
      if (memo_gen==1)
	memset(memo_table,0,sizeof(MEMO_REC)*(memo_mask+1));
   }
   
   while (1) {
      if (mn->match_result==MR_INITIAL) {
	 if ((mn->nc_needle->head!=NULL) && (mn->nc_haystack->head!=NULL))
	   mn->match_result=(mn->nc_needle->head==mn->nc_haystack->head)?
	   MR_TRUE:MR_FALSE;
	 else if (memo_mask && mn->nc_needle->complete) {
	    memo_checks++;
	    memo_key.needle=mn->nc_needle;
	    memo_key.haystack=mn->nc_haystack;
	    hval=fnv_hash(sizeof(MEMO_REC),(char *)&memo_key,0)&memo_mask;
	    if ((memo_table[hval].generation==memo_key.generation)
		&& (memo_table[hval].needle==memo_key.needle)
		&& (memo_table[hval].haystack==memo_key.haystack)) {
	       mn->match_result=memo_table[hval].match_result;
	       memo_hits++;
	    } else if (mn->nc_needle->arity==mn->nc_needle->functor->arity)
	      mn=mn->nc_needle->functor->match_fn(mn);
	    else
	      mn=default_match_fn(mn);
	 } else if (mn->nc_needle->arity==mn->nc_needle->functor->arity)
	      mn=mn->nc_needle->functor->match_fn(mn);
	 else
	   mn=default_match_fn(mn);
      } else if (mn->match_parent!=NULL) {
	 tmpn=mn->match_parent;
	 if (memo_mask && mn->nc_needle->complete) {
	    memo_key.needle=mn->nc_needle;
	    memo_key.haystack=mn->nc_haystack;
	    hval=fnv_hash(sizeof(MEMO_REC),(char *)&memo_key,0)&memo_mask;
	    memo_table[hval]=memo_key;
	    memo_table[hval].match_result=mn->match_result;
	 }
	 switch (mn->match_result) {
	  case MR_TRUE:
	  case MR_AND_MAYBE:
	    if (tmpn->match_result==MR_OR_MAYBE)
	      tmpn->match_result=MR_TRUE;
	    else if (tmpn->match_result==MR_NOT_MAYBE)
	      tmpn->match_result=MR_FALSE;
	    break;
	  case MR_FALSE:
	  case MR_OR_MAYBE:
	    if (tmpn->match_result==MR_AND_MAYBE)
	      tmpn->match_result=MR_FALSE;
	    else if (tmpn->match_result==MR_NOT_MAYBE)
	      tmpn->match_result=MR_TRUE;
	    break;
	  default:
	    puts("illegal match result"); /* SNH */
	    exit(1); /* SNH */
	 }
	 if ((tmpn->match_result==MR_TRUE) ||
	     (tmpn->match_result==MR_FALSE)) {
	    while (mn!=tmpn) {
	       tmpnn=mn->nc_next;
	       free_node(mn);
	       mn=tmpnn;
	    }
	 } else {
	    tmpnn=mn->nc_next;
	    free_node(mn);
	    mn=tmpnn;
	 }
      } else switch (mn->match_result) {
       case MR_TRUE:
       case MR_AND_MAYBE:
	 free_node(mn);
	 return 1;
       case MR_FALSE:
       case MR_OR_MAYBE:
	 free_node(mn);
	 return 0;
      }
   }
}
