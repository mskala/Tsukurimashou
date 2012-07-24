/*
 * Matching algorithm for IDSgrep
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
   
   if ((ms->nc_needle->child[0]->head!=NULL) && (ms->nc_haystack->head!=NULL)) {
      ms->match_result=(ms->nc_needle->child[0]->head==ms->nc_haystack->head)?
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

NODE *regex_match_fn(NODE *ms) { /* SNH */
   /* FIXME */
   ms->match_result=MR_TRUE; /* SNH */
   return ms; /* SNH */
}

/**********************************************************************/

int tree_match(NODE *needle,NODE *haystack) {
   NODE *mn,*tmpn,*tmpnn;
   
   mn=new_node();
   mn->nc_needle=needle;
   mn->nc_haystack=haystack;
   needle->refs++;
   haystack->refs++;
   
   while (1) {
      if (mn->match_result==MR_INITIAL) {
	 if ((mn->nc_needle->head!=NULL) && (mn->nc_haystack->head!=NULL)) {
	    mn->match_result=(mn->nc_needle->head==mn->nc_haystack->head)?
	      MR_TRUE:MR_FALSE;
	 } else if (mn->nc_needle->arity==mn->nc_needle->functor->arity) {
	    mn=mn->nc_needle->functor->match_fn(mn);
	 } else {
	    mn=default_match_fn(mn);
	 }
      } else if (mn->match_parent!=NULL) {
	 tmpn=mn->match_parent;
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
