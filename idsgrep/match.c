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
   
   if ((ms->child[1]->arity!=ms->child[2]->arity) ||
       (ms->child[1]->functor!=ms->child[2]->functor)) {
      ms->match_result=MR_FALSE;
      return ms;
   }
   if (ms->child[1]->arity==0) {
      ms->match_result=MR_TRUE;
      return ms;
   }
   rval=ms;
   ms->match_result=MR_AND_MAYBE;
   for (i=0;i<ms->child[1]->arity;i++) {
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      rval->child[1]=ms->child[1]->child[i];
      rval->child[1]->refs++;
      rval->child[2]=ms->child[2]->child[i];
      rval->child[2]->refs++;
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
   tmpn->child[0]=rval;
   tmpn->child[0]->refs++;
   rval=tmpn;

   rval->child[1]=ms->child[1]->child[0];
   rval->child[1]->refs++;
   rval->child[2]=ms->child[2];
   rval->child[2]->refs++;
   rval->match_parent=ms;
   
   for (i=0;i<ms->child[2]->arity;i++) {
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      
      tmpn->child[1]=new_node();
      tmpn->child[1]->arity=1;
      tmpn->child[1]->functor=new_string(1,".");
      tmpn->child[1]->child[0]=ms->child[1]->child[0];
      tmpn->child[1]->child[0]->refs++;
      
      tmpn->child[2]=ms->child[2]->child[i];
      tmpn->child[2]->refs++;
      tmpn->match_parent=ms;
   }
   return rval;
}

/**********************************************************************/

NODE *and_or_match_fn(NODE *ms) {
   NODE *rval,*tmpn;

   rval=ms;
   ms->match_result=(ms->child[1]->functor->data[0]=='|')?
     MR_OR_MAYBE:MR_AND_MAYBE;
   
   tmpn=new_node();
   tmpn->child[0]=rval;
   tmpn->child[0]->refs++;
   rval=tmpn;
   
   rval->child[1]=ms->child[1]->child[0];
   rval->child[1]->refs++;
   rval->child[2]=ms->child[2];
   rval->child[2]->refs++;
   rval->match_parent=ms;

   tmpn=new_node();
   tmpn->child[0]=rval;
   tmpn->child[0]->refs++;
   rval=tmpn;
   
   rval->child[1]=ms->child[1]->child[1];
   rval->child[1]->refs++;
   rval->child[2]=ms->child[2];
   rval->child[2]->refs++;
   rval->match_parent=ms;

   return rval;
}

NODE *not_match_fn(NODE *ms) {
   NODE *rval,*tmpn;

   rval=ms;
   ms->match_result=MR_NOT_MAYBE;
   
   tmpn=new_node();
   tmpn->child[0]=rval;
   tmpn->child[0]->refs++;
   rval=tmpn;
   
   rval->child[1]=ms->child[1]->child[0];
   rval->child[1]->refs++;
   rval->child[2]=ms->child[2];
   rval->child[2]->refs++;
   rval->match_parent=ms;

   return rval;
}

NODE *equal_match_fn(NODE *ms) {
   NODE *rval,*tmpn;
   int i;
   
   if ((ms->child[1]->child[0]->head!=NULL) && (ms->child[2]->head!=NULL)) {
      ms->match_result=(ms->child[1]->child[0]->head==ms->child[2]->head)?
	MR_TRUE:MR_FALSE;
      return ms;
   }

   if ((ms->child[1]->child[0]->arity!=ms->child[2]->arity) ||
       (ms->child[1]->child[0]->functor!=ms->child[2]->functor)) {
      ms->match_result=MR_FALSE;
      return ms;
   }

   if (ms->child[1]->child[0]->arity==0) {
      ms->match_result=MR_TRUE;
      return ms;
   }

   rval=ms;
   ms->match_result=MR_AND_MAYBE;

   for (i=0;i<ms->child[1]->child[0]->arity;i++) {
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      rval->child[1]=ms->child[1]->child[0]->child[i];
      rval->child[1]->refs++;
      rval->child[2]=ms->child[2]->child[i];
      rval->child[2]->refs++;
      rval->match_parent=ms;
   }
   return rval;
}

/**********************************************************************/

NODE *unord_match_fn(NODE *ms) {
   NODE *rval,*tmpn;
   int i;

   /* short-circuit head-to-head */
   if ((ms->child[1]->child[0]->head!=NULL) && (ms->child[2]->head!=NULL)) {
      ms->match_result=(ms->child[1]->child[0]->head==ms->child[2]->head)?
	MR_TRUE:MR_FALSE;
      return ms;
   }
   /* now we can skip copying heads of permuted patterns */
   
   /* set up parent */
   rval=ms;
   ms->match_result=MR_OR_MAYBE;

   /* no reordering - always a possibility */
   tmpn=new_node();
   tmpn->child[0]=rval;
   tmpn->child[0]->refs++;
   rval=tmpn;

   rval->child[1]=ms->child[1]->child[0];
   rval->child[1]->refs++;
   rval->child[2]=ms->child[2];
   rval->child[2]->refs++;
   rval->match_parent=ms;

   if (ms->child[1]->child[0]->arity==2) {
      
      /* BA */
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      
      rval->child[1]=new_node();
      rval->child[1]->functor=ms->child[1]->child[0]->functor;
      rval->child[1]->functor->refs++;
      rval->child[1]->arity=ms->child[1]->child[0]->arity;
      
      rval->child[1]->child[0]=ms->child[1]->child[0]->child[1];
      rval->child[1]->child[0]->refs++;
      rval->child[1]->child[1]=ms->child[1]->child[0]->child[0];
      rval->child[1]->child[1]->refs++;
      
      rval->child[2]=ms->child[2];
      rval->child[2]->refs++;
      rval->match_parent=ms;
      
   } else if (ms->child[1]->child[0]->arity==3) {

      /* ACB */
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      
      rval->child[1]=new_node();
      rval->child[1]->functor=ms->child[1]->child[0]->functor;
      rval->child[1]->functor->refs++;
      rval->child[1]->arity=ms->child[1]->child[0]->arity;
      
      rval->child[1]->child[0]=ms->child[1]->child[0]->child[0];
      rval->child[1]->child[0]->refs++;
      rval->child[1]->child[1]=ms->child[1]->child[0]->child[2];
      rval->child[1]->child[1]->refs++;
      rval->child[1]->child[2]=ms->child[1]->child[0]->child[1];
      rval->child[1]->child[2]->refs++;
      
      rval->child[2]=ms->child[2];
      rval->child[2]->refs++;
      rval->match_parent=ms;
      
      /* BAC */
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      
      rval->child[1]=new_node();
      rval->child[1]->functor=ms->child[1]->child[0]->functor;
      rval->child[1]->functor->refs++;
      rval->child[1]->arity=ms->child[1]->child[0]->arity;
      
      rval->child[1]->child[0]=ms->child[1]->child[0]->child[1];
      rval->child[1]->child[0]->refs++;
      rval->child[1]->child[1]=ms->child[1]->child[0]->child[0];
      rval->child[1]->child[1]->refs++;
      rval->child[1]->child[2]=ms->child[1]->child[0]->child[2];
      rval->child[1]->child[2]->refs++;
      
      rval->child[2]=ms->child[2];
      rval->child[2]->refs++;
      rval->match_parent=ms;
      
      /* BCA */
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      
      rval->child[1]=new_node();
      rval->child[1]->functor=ms->child[1]->child[0]->functor;
      rval->child[1]->functor->refs++;
      rval->child[1]->arity=ms->child[1]->child[0]->arity;
      
      rval->child[1]->child[0]=ms->child[1]->child[0]->child[1];
      rval->child[1]->child[0]->refs++;
      rval->child[1]->child[1]=ms->child[1]->child[0]->child[2];
      rval->child[1]->child[1]->refs++;
      rval->child[1]->child[2]=ms->child[1]->child[0]->child[0];
      rval->child[1]->child[2]->refs++;
      
      rval->child[2]=ms->child[2];
      rval->child[2]->refs++;
      rval->match_parent=ms;
      
      /* CAB */
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      
      rval->child[1]=new_node();
      rval->child[1]->functor=ms->child[1]->child[0]->functor;
      rval->child[1]->functor->refs++;
      rval->child[1]->arity=ms->child[1]->child[0]->arity;
      
      rval->child[1]->child[0]=ms->child[1]->child[0]->child[2];
      rval->child[1]->child[0]->refs++;
      rval->child[1]->child[1]=ms->child[1]->child[0]->child[0];
      rval->child[1]->child[1]->refs++;
      rval->child[1]->child[2]=ms->child[1]->child[0]->child[1];
      rval->child[1]->child[2]->refs++;
      
      rval->child[2]=ms->child[2];
      rval->child[2]->refs++;
      rval->match_parent=ms;
      
      /* CBA */
      tmpn=new_node();
      tmpn->child[0]=rval;
      tmpn->child[0]->refs++;
      rval=tmpn;
      
      rval->child[1]=new_node();
      rval->child[1]->functor=ms->child[1]->child[0]->functor;
      rval->child[1]->functor->refs++;
      rval->child[1]->arity=ms->child[1]->child[0]->arity;
      
      rval->child[1]->child[0]=ms->child[1]->child[0]->child[2];
      rval->child[1]->child[0]->refs++;
      rval->child[1]->child[1]=ms->child[1]->child[0]->child[1];
      rval->child[1]->child[1]->refs++;
      rval->child[1]->child[2]=ms->child[1]->child[0]->child[0];
      rval->child[1]->child[2]->refs++;
      
      rval->child[2]=ms->child[2];
      rval->child[2]->refs++;
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
   mn->child[1]=needle;
   mn->child[2]=haystack;
   needle->refs++;
   haystack->refs++;
   
   while (1) {
      if (mn->match_result==MR_INITIAL) {
	 if ((mn->child[1]->head!=NULL) && (mn->child[2]->head!=NULL)) {
	    mn->match_result=(mn->child[1]->head==mn->child[2]->head)?
	      MR_TRUE:MR_FALSE;
	 } else if (mn->child[1]->arity==mn->child[1]->functor->arity) {
	    mn=mn->child[1]->functor->match_fn(mn);
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
	       tmpnn=mn->child[0];
	       free_node(mn);
	       mn=tmpnn;
	    }
	 } else {
	    tmpnn=mn->child[0];
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
