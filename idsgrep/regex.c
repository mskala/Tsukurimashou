/*
 * Regular expression match for IDSgrep
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

#ifdef HAVE_PCRE

/**********************************************************************/

NODE *regex_match_fn(NODE *ms) {
   const char *errptr;
   int erroffset,i;
   NODE *rval,*tmpn;
   
   if ((ms->nc_needle->child[0]->head!=NULL) &&
       (ms->nc_haystack->head!=NULL)) {
      if (ms->nc_needle->child[0]->head->pcre_compiled==NULL) {
	 ms->nc_needle->child[0]->head->pcre_compiled=
	   pcre_compile(ms->nc_needle->child[0]->head->data,
			PCRE_UTF8|PCRE_NO_UTF8_CHECK,
			&errptr,&erroffset,NULL);
	 if (ms->nc_needle->child[0]->head->pcre_compiled==NULL) {
	    printf("PCRE error: %s at %d.\n",errptr,erroffset);
	    exit(1);
	 }
	 ms->nc_needle->child[0]->head->pcre_studied=
	   pcre_study(ms->nc_needle->child[0]->head->pcre_compiled,
		      0,&errptr);
	 if (errptr) {
	    printf("PCRE error: %s.\n",errptr);
	    exit(1);
	 }
      }
      ms->match_result=
	(pcre_exec(ms->nc_needle->child[0]->head->pcre_compiled,
		  ms->nc_needle->child[0]->head->pcre_studied,
		  ms->nc_haystack->head->data,
		  ms->nc_haystack->head->length,
		  0,PCRE_NO_UTF8_CHECK,NULL,0)>=0)?
	MR_TRUE:MR_FALSE;
      return ms;
   }
   
   if (ms->nc_needle->child[0]->arity!=ms->nc_haystack->arity) {
      ms->match_result=MR_FALSE;
      return ms;
   }
   
   if (ms->nc_needle->child[0]->functor->pcre_compiled==NULL) {
      ms->nc_needle->child[0]->functor->pcre_compiled=
	pcre_compile(ms->nc_needle->child[0]->functor->data,
		     PCRE_UTF8|PCRE_NO_UTF8_CHECK,
		     &errptr,&erroffset,NULL);
      if (ms->nc_needle->child[0]->functor->pcre_compiled==NULL) {
	 printf("PCRE error: %s at %d.\n",errptr,erroffset);
	 exit(1);
      }
      ms->nc_needle->child[0]->functor->pcre_studied=
	pcre_study(ms->nc_needle->child[0]->functor->pcre_compiled,
		   0,&errptr);
      if (errptr) {
	 printf("PCRE error: %s.\n",errptr);
	 exit(1);
      }
      if (pcre_exec(ms->nc_needle->child[0]->functor->pcre_compiled,
		    ms->nc_needle->child[0]->functor->pcre_studied,
		    ms->nc_haystack->head->data,
		    ms->nc_haystack->head->length,
		    0,PCRE_NO_UTF8_CHECK,NULL,0)<0) {
	 ms->match_result=MR_FALSE;
	 return ms;
      }
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

#else

NODE *regex_match_fn(NODE *ms) {
   puts("compiled without regular expression support");
   exit(1);
}

#endif
