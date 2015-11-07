/*
 * Sub-mappings and value construction
 * Copyright (C) 2015  Matthew Skala
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

static void gen_submap(CONTEXT *c) {
   SUBMAP *sm,*xm;

   if (c->parent==NULL) {
      c->generator=NULL;
      return;
   }
   c->generator=gen_submap;

   sm=(SUBMAP *)malloc(sizeof(SUBMAP));
   sm->next=c->parent->submaps;
   if (c->submaps==c->parent->submaps)
      c->submaps=sm;
   else {
      for (xm=c->submaps;xm->next!=c->parent->submaps;xm=xm->next);
      xm->next=sm;
   }
   c->parent->submaps=sm;
   sm->name=strdup(c->id);
   sm->am=c->am;
   arrow_map_new(&(c->am));
}

void handle_define(PARSER_STATE *ps) {
   NODE *name,*tok;
   
   ps->ignore_semicolon=0;

   name=get_token(ps);
   if (name->type!=nt_keyword)
     parse_error(ps,"submap name must be a keyword");
   
   tok=get_token(ps);   
   if ((tok->type!=nt_keyword) || (strcmp(tok->cp,"{")!=0))
     parse_error(ps,"define must be given a context");
   node_delete(tok);
   
   handle_opening_brace(ps);

   context_stack->generator=gen_submap;
   arrow_map_delete(&(context_stack->am));
   arrow_map_new(&(context_stack->am));
   if (context_stack->id!=NULL)
     free(context_stack->id);
   context_stack->id=strdup(name->cp);
   node_delete(name);
}

/**********************************************************************/

typedef struct _CONSTRUCTION {
   struct _CONSTRUCTION *next,*parent,*first_child,*last_child;
   char *data,*result;
   void (*go)(PARSER_STATE *,struct _CONSTRUCTION *,NODE *);
} CONSTRUCTION;

static void go_bracket(PARSER_STATE *ps,CONSTRUCTION *cst,NODE *key) {
   int length;
   CONSTRUCTION *child;

   if (cst->result!=NULL)
     free(cst->result);

   length=0;
   for (child=cst->first_child;child!=NULL;child=child->next)
     length+=strlen(child->result);

   cst->result=(char *)malloc(length+1);

   cst->result[0]='\0';
   for (child=cst->first_child;child!=NULL;child=child->next)
     strcat(cst->result,child->result);
}

static void go_string(PARSER_STATE *ps,CONSTRUCTION *cst,NODE *key) {
   /* if it's not null, assume we already did this */
   if (cst->result==NULL)
     cst->result=strdup(cst->data);
}

static void go_variable(PARSER_STATE *ps,CONSTRUCTION *cst,NODE *key) {
   SUBMAP *sm;
   NODE *n;
   
   if (cst->data==NULL)
     return;
   
   for (sm=context_stack->submaps;sm!=NULL;sm=sm->next)
     if (strcmp(cst->data,sm->name)==0)
       break;

   if (cst->result!=NULL)
     free(cst->result);

   if (sm==NULL) {
      parse_error(ps,"Unknown variable %s",cst->data);
      cst->result=strdup("UNKNOWN VARIABLE");
      cst->data=NULL;
      return;
   }
   
   n=arrow_map_lookup(&(sm->am),key);

   if (n->type==nt_string)
     cst->result=strdup(n->cp);
   else {
      cst->result=(char *)malloc(24*sizeof(char));
      sprintf(cst->result,"%d",n->x);
   }
}

static void go_hex_var(PARSER_STATE *ps,CONSTRUCTION *cst,NODE *key) {
   SUBMAP *sm;
   NODE *n;
   
   if (cst->data==NULL)
     return;
   
   for (sm=context_stack->submaps;sm!=NULL;sm=sm->next)
     if (strcmp(cst->data,sm->name)==0)
       break;

   if (cst->result!=NULL)
     free(cst->result);

   if (sm==NULL) {
      parse_error(ps,"Unknown variable %s",cst->data);
      cst->result=strdup("UNKNOWN VARIABLE");
      cst->data=NULL;
      return;
   }
   
   n=arrow_map_lookup(&(sm->am),key);

   if (n->type==nt_string)
     cst->result=strdup(n->cp);
   else {
      cst->result=(char *)malloc(20*sizeof(char));
      sprintf(cst->result,"0x%X",n->x);
   }
}

static CONSTRUCTION *read_construction(PARSER_STATE *ps) {
   CONSTRUCTION *rval,*wp,*cst;
   NODE *tok;

   wp=NULL;
   rval=NULL;
   do {
      cst=(CONSTRUCTION *)malloc(sizeof(CONSTRUCTION));
      cst->next=NULL;
      cst->first_child=NULL;
      cst->last_child=NULL;
      if (wp==NULL) {
	 cst->parent=NULL;
	 rval=cst;
      } else
	cst->parent=wp;
      cst->result=NULL;

      tok=get_token(ps);
      switch (tok->type) {
       case nt_keyword:
	 if (strcmp(tok->cp,"[")==0) {
	    cst->data=NULL;
	    wp=cst;
	    cst->go=go_bracket;

	 } else if (strcmp(tok->cp,"]")==0) {
	    if (wp!=NULL)
	      wp=wp->parent;
	    free(cst);
	    cst=NULL;

	 } else if (strcmp(tok->cp,"$")==0) {
	    node_delete(tok);
	    tok=get_token(ps);
	    if (tok->type==nt_keyword) {
	       cst->data=strdup(tok->cp);
	       cst->go=go_variable;
	    } else {
	       parse_error(ps,
			   "Variable name is not a keyword in construction");
	       if (rval==cst)
		 rval=NULL;
	       wp=NULL;
	       free(cst);
	    }

	 } else if (strcmp(tok->cp,"%")==0) {
	    node_delete(tok);
	    tok=get_token(ps);
	    if (tok->type==nt_keyword) {
	       cst->data=strdup(tok->cp);
	       cst->go=go_hex_var;
	    } else {
	       parse_error(ps,"Hex variable name is not a "
			   "keyword in construction");
	       if (rval==cst)
		 rval=NULL;
	       wp=NULL;
	       free(cst);
	    }

	 } else {
	    cst->data=strdup(tok->cp);
	    cst->go=go_string;
	 }
	 break;
	 
       case nt_int:
	 cst->data=(char *)malloc(24*sizeof(char));
	 sprintf(cst->data,"%d",tok->x);
	 cst->go=go_string;
	 break;

       case nt_string:
	 cst->data=strdup(tok->cp);
	 cst->go=go_string;
	 break;

       default:
	 parse_error(ps,"Unknown token type in construction");
	 if (rval==cst)
	   rval=NULL;
	 wp=NULL;
	 free(cst);
	 cst=NULL;
      }
      
      if ((cst!=NULL) && (cst->parent!=NULL)) {
	 if (cst->parent->first_child==NULL)
	   cst->parent->first_child=cst;
	 if (cst->parent->last_child!=NULL)
	   cst->parent->last_child->next=cst;
	 cst->parent->last_child=cst;
      }

      node_delete(tok);
   } while (wp!=NULL);
   
   return rval;
}

void handle_construct(PARSER_STATE *ps) {
   int i;
   CONSTRUCTION *cs,*cp;
   NODE *ni,*nk,*nv;
   ARROW_MAP zm;
   
   cs=read_construction(ps);
   if (cs==NULL) {
      parse_error(ps,"Could not read construction");
      return;
   }
   
   zm.arrows=(NODE **)malloc(sizeof(NODE *)*context_stack->am.num_buckets);
   zm.num_arrows=context_stack->am.num_arrows;
   zm.num_buckets=context_stack->am.num_buckets;
   zm.first_key=NULL;
   zm.last_key=NULL;

   for (i=0;i<zm.num_buckets;i++) {
     zm.arrows[i]=NULL;

     for (ni=context_stack->am.arrows[i];ni!=NULL;ni=ni->next) {
	
	cp=cs;
	cp->last_child=cp->first_child;
	
	while (cp!=NULL) {
	   while (cp->last_child!=NULL) {
	      cp=cp->last_child;
	      cp->parent->last_child=cp->parent->last_child->next;
	      cp->last_child=cp->first_child;
	   }
	   cp->go(ps,cp,ni);
	   cp=cp->parent;
	}

	nv=node_new();
	nv->type=nt_string;
	nv->cp=strdup(cs->result);
	
	nk=node_new();

	nk->type=ni->type;
	if (nk->type==nt_string)
	  nk->cp=strdup(ni->cp);
	else
	  nk->x=ni->x;
	nk->nodes=nv;
	
	nk->next=zm.arrows[i];
	zm.arrows[i]=nk;

	if ((zm.first_key==NULL) || (atom_cmp(nk,zm.first_key)==-1))
	  zm.first_key=nk;
	if ((zm.last_key==NULL) || (atom_cmp(nk,zm.last_key)==1))
	  zm.last_key=nk;
     }
   }
   
   arrow_map_delete(&(context_stack->am));
   context_stack->am=zm;

   /* clean up the construction */

   ps->ignore_semicolon=1;   
}
