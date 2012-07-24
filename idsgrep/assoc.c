/*
 * Associative match for IDSgrep
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

NODE *assoc_match_fn(NODE *ms) {
   NODE *needle_prime,*haystack_prime;
   NODE *tmpp,*tmpq,*rval;
   int np_arity,hp_arity,i;
  
   if ((ms->nc_needle->child[0]->arity!=ms->nc_haystack->arity)
       || (ms->nc_needle->child[0]->functor!=ms->nc_haystack->functor)) {
      ms->match_result=MR_FALSE;
      return ms;
   }
   
   if (ms->nc_needle->child[0]->arity==0) {
      ms->match_result=MR_TRUE;
      return ms;
   }

   needle_prime=new_node();
   needle_prime->nc_needle=ms->nc_needle->child[0];
   needle_prime->nc_needle->refs++;
   np_arity=1;
   
   for (tmpp=needle_prime;tmpp;) {
      if ((tmpp->nc_needle->arity==ms->nc_needle->child[0]->arity)
	  && (tmpp->nc_needle->functor==ms->nc_needle->child[0]->functor)) {
	 for (i=tmpp->nc_needle->arity-1;i>0;i--) {
	    tmpq=new_node();
	    tmpq->nc_next=tmpp->nc_next;
	    tmpp->nc_next=tmpq;
	    np_arity++;
	    tmpq->nc_needle=tmpp->nc_needle->child[i];
	    tmpq->nc_needle->refs++;
	 }
	 tmpq=tmpp->nc_needle;
	 tmpp->nc_needle=tmpp->nc_needle->child[0];
	 tmpp->nc_needle->refs++;
	 free_node(tmpq);
      } else
	tmpp=tmpp->nc_next;
   }
   
   haystack_prime=new_node();
   haystack_prime->nc_needle=ms->nc_haystack;
   haystack_prime->nc_needle->refs++;
   hp_arity=1;
   
   for (tmpp=haystack_prime;tmpp;) {
      if ((tmpp->nc_needle->arity==ms->nc_needle->child[0]->arity)
	  && (tmpp->nc_needle->functor==ms->nc_needle->child[0]->functor)) {
	 for (i=tmpp->nc_needle->arity-1;i>0;i--) {
	    tmpq=new_node();
	    tmpq->nc_next=tmpp->nc_next;
	    tmpp->nc_next=tmpq;
	    hp_arity++;
	    tmpq->nc_needle=tmpp->nc_needle->child[i];
	    tmpq->nc_needle->refs++;
	 }
	 tmpq=tmpp->nc_needle;
	 tmpp->nc_needle=tmpp->nc_needle->child[0];
	 tmpp->nc_needle->refs++;
	 free_node(tmpq);
      } else
	tmpp=tmpp->nc_next;
   }
   
   if (np_arity!=hp_arity) {
      free_node(needle_prime);
      free_node(haystack_prime);
      ms->match_result=MR_FALSE;
      return ms;
   }
   
   rval=ms;
   ms->match_result=MR_AND_MAYBE;
   
   while (needle_prime) {
      tmpp=needle_prime->nc_next;
      tmpq=haystack_prime->nc_next;
      
      needle_prime->nc_next=rval;
      rval->refs++;
      rval=needle_prime;
      rval->match_parent=ms;

      needle_prime->nc_haystack=haystack_prime->nc_needle;
      needle_prime->nc_haystack->refs++;
      
      needle_prime=tmpp;
      if (tmpq)
	tmpq->refs++;
      free_node(haystack_prime);
      haystack_prime=tmpq;
   }
   
   return rval;
}
