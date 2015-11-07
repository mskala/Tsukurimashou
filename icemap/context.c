/*
 * Static map contexts, high-level handling
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

#include <stdlib.h>
#include <string.h>

#include "icemap.h"

/**********************************************************************/

CONTEXT *context_stack=NULL;

#define STR_FROM_PARENT(field) \
   ctx->field=(ctx->parent->field?strdup(ctx->parent->field):NULL)

void handle_opening_brace(PARSER_STATE *ps) {
   CONTEXT *ctx;
   int i;
   
   ctx=(CONTEXT *)malloc(sizeof(CONTEXT));

   ctx->parent=context_stack;
   if (context_stack==NULL) {
      ctx->id=strdup("map");
      arrow_map_new(&(ctx->am));
      ctx->dupe_priority=dp_error;
      ctx->skip_regex=NULL;
      ctx->parse_regex=NULL;
      ctx->c_file=default_c_file;
      ctx->h_file=default_h_file;
      ctx->generator=NULL;
      ctx->key_c_type=NULL;
      ctx->value_c_type=NULL;
      ctx->quote_policy=qp_strings;
      ctx->leaves=0;
      ctx->submaps=NULL;
      ctx->return_pointer=0;
      ctx->default_policy=dp_fail;
      ctx->default_value=NULL;

   } else {
      ctx->id=strdup(context_stack->id);
      arrow_map_copy(&(ctx->am),&(context_stack->am));
      ctx->dupe_priority=context_stack->dupe_priority;

      STR_FROM_PARENT(skip_regex);
      STR_FROM_PARENT(parse_regex);
      STR_FROM_PARENT(c_file);
      STR_FROM_PARENT(h_file);
      
      ctx->generator=ctx->parent->generator;
      
      STR_FROM_PARENT(key_c_type);
      STR_FROM_PARENT(value_c_type);
      
      ctx->quote_policy=ctx->parent->quote_policy;
      ctx->leaves=0;
      ctx->submaps=ctx->parent->submaps;
      ctx->return_pointer=ctx->parent->return_pointer;
      ctx->default_policy=ctx->parent->default_policy;
      ctx->default_value=ctx->parent->default_value;
      if (ctx->default_value!=NULL)
	ctx->default_value->refs++;
   }

   context_stack=ctx;

   ps->ignore_semicolon=0;
}

void handle_closing_brace(PARSER_STATE *ps) {
   CONTEXT *ctx;
   int i,j;
   void (*pref_gen)(struct _CONTEXT *);
   SUBMAP *sm,*psm;

   if (context_stack==NULL) {
      parse_error(ps,"unexpected closing brace");
      close_output_files();
      exit(1);
   }
   
   /* only write out the map if we aren't a parent */
   if (context_stack->leaves==0) {

      /* first, attempt whatever the user asked for */
      if (context_stack->generator!=NULL)
	context_stack->generator(context_stack);
      
      /* then look for a generator that actually likes this kind of data */
      if (context_stack->generator==NULL) {
	 j=0;
	 pref_gen=NULL;
	 if ((i=prefer_wide_cascade(context_stack))>j) {
	    j=i;
	    pref_gen=gen_wide_cascade;
	 }
	 if ((i=prefer_cascade(context_stack))>j) {
	    j=i;
	    pref_gen=gen_cascade;
	 }
	 if ((i=prefer_basic_array(context_stack))>j) {
	    j=i;
	    pref_gen=gen_basic_array;
	 }
	 if (pref_gen!=NULL)
	   pref_gen(context_stack);
      }
      
      /* finally, just try for any generator */
      if (context_stack->generator==NULL)
	gen_wide_cascade(context_stack);
      if (context_stack->generator==NULL)
	gen_cascade(context_stack);
      if (context_stack->generator==NULL)
	gen_basic_array(context_stack);
      
      if (context_stack->generator==NULL) {
	 if (context_stack->am.num_arrows==0)
	   parse_error(ps,"no arrows in map (%s)",context_stack->id);
	 else
	   parse_error(ps,"no code generator for these data types (%s)",
		       context_stack->id);
	 close_output_files();
	 exit(1);
      }
   }

   arrow_map_delete(&(context_stack->am));
   
   free(context_stack->id);
   if (context_stack->skip_regex!=NULL)
     free(context_stack->skip_regex);
   if (context_stack->parse_regex!=NULL)
     free(context_stack->parse_regex);
   if (context_stack->c_file!=NULL)
     free(context_stack->c_file);
   if (context_stack->h_file!=NULL)
     free(context_stack->h_file);
   if (context_stack->key_c_type!=NULL)
     free(context_stack->key_c_type);
   if (context_stack->value_c_type!=NULL)
     free(context_stack->value_c_type);
   
   if (context_stack->parent==NULL)
     psm=NULL;
   else
     psm=context_stack->parent->submaps;
   while (context_stack->submaps!=psm) {
      sm=context_stack->submaps;
      context_stack->submaps=sm->next;
      free(sm->name);
      arrow_map_delete(&(sm->am));
      free(sm);
   }
   
   if (context_stack->default_value!=NULL)
     node_delete(context_stack->default_value);

   ctx=context_stack->parent;
   free(context_stack);
   context_stack=ctx;

   ps->ignore_semicolon=1;
}

/**********************************************************************/

static void gen_nothing(CONTEXT *c) {
   /* NOOP */
}

void handle_generate(PARSER_STATE *ps) {
   NODE *tok;
   
   ps->ignore_semicolon=0;
   tok=get_token(ps);

   if (tok->type!=nt_keyword)
     parse_error(ps,"generate target must be a keyword");
   else if (strcmp(tok->cp,"basic_array")==0)
     context_stack->generator=gen_basic_array;
   else if (strcmp(tok->cp,"cascade")==0)
     context_stack->generator=gen_cascade;
   else if (strcmp(tok->cp,"wide_cascade")==0)
     context_stack->generator=gen_wide_cascade;
   else if (strcmp(tok->cp,"nothing")==0)
     context_stack->generator=gen_nothing;
   else
     parse_error(ps,"unknown generate target keyword %s",tok->cp);
   context_stack->leaves=0;
   
   node_delete(tok);
   ps->ignore_semicolon=1;
}

void handle_quote_policy(PARSER_STATE *ps) {
   NODE *tok;
   
   ps->ignore_semicolon=0;
   tok=get_token(ps);

   if (tok->type!=nt_keyword)
     parse_error(ps,"quote policy must be a keyword");
   else if (strcmp(tok->cp,"strings")==0)
     context_stack->quote_policy=qp_strings;
   else if (strcmp(tok->cp,"everything")==0)
     context_stack->quote_policy=qp_everything;
   else if (strcmp(tok->cp,"nothing")==0)
     context_stack->quote_policy=qp_nothing;
   else
     parse_error(ps,"unknown quote policy keyword %s",tok->cp);
   
   node_delete(tok);
   ps->ignore_semicolon=1;
}

void handle_return(PARSER_STATE *ps) {
   NODE *tok;
   
   ps->ignore_semicolon=0;
   tok=get_token(ps);

   if (tok->type!=nt_keyword)
     parse_error(ps,"return policy must be a keyword");
   else if (strcmp(tok->cp,"pointer")==0)
     context_stack->return_pointer=1;
   else if (strcmp(tok->cp,"value")==0)
     context_stack->return_pointer=0;
   else
     parse_error(ps,"unknown return policy keyword %s",tok->cp);
   
   node_delete(tok);
   ps->ignore_semicolon=1;
}

void handle_default(PARSER_STATE *ps) {
   NODE *tok;

   if (context_stack->default_value!=NULL) {
      node_delete(context_stack->default_value);
      context_stack->default_value=NULL;
   }
   
   ps->ignore_semicolon=0;
   tok=get_token(ps);

   if (tok->type!=nt_keyword) {
      context_stack->default_policy=dp_value;
      context_stack->default_value=tok;
      tok->refs++;
   } else if (strcmp(tok->cp,"any")==0)
	context_stack->default_policy=dp_any;
   else if (strcmp(tok->cp,"fail")==0)
     context_stack->default_policy=dp_fail;
   else if (strcmp(tok->cp,"null")==0)
     context_stack->default_policy=dp_null;
   else
     parse_error(ps,"unknown default policy keyword %s",tok->cp);
   
   node_delete(tok);
   ps->ignore_semicolon=1;
}

