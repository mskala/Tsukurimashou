/*
 * Static map contexts, high-level handling
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

#include <stdlib.h>
#include <string.h>

#include "icemap.h"

/**********************************************************************/

CONTEXT *context_stack=NULL;

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

   } else {
      ctx->id=strdup(context_stack->id);
      arrow_map_copy(&(ctx->am),&(context_stack->am));
      ctx->dupe_priority=context_stack->dupe_priority;

      if (ctx->parent->skip_regex!=NULL)
	ctx->skip_regex=strdup(ctx->parent->skip_regex);
      else
	ctx->skip_regex=NULL;
      if (ctx->parent->parse_regex!=NULL)
	ctx->parse_regex=strdup(ctx->parent->parse_regex);
      else
	ctx->parse_regex=NULL;

      if (ctx->parent->c_file!=NULL)
	ctx->c_file=strdup(ctx->parent->c_file);
      else
	ctx->c_file=NULL;
      if (ctx->parent->h_file!=NULL)
	ctx->h_file=strdup(ctx->parent->h_file);
      else
	ctx->h_file=NULL;
      
      ctx->generator=ctx->parent->generator;
   }

   context_stack=ctx;

   ps->ignore_semicolon=0;
}

void handle_closing_brace(PARSER_STATE *ps) {
   CONTEXT *ctx;
   int i;

   if (context_stack==NULL) {
      parse_error(ps,"unexpected closing brace");
      exit(1);
   }
   
   /* first, attempt whatever the user asked for */
   if (context_stack->generator!=NULL)
     context_stack->generator(context_stack);

   /* then look for a generator that actually likes this kind of data */
   if ((context_stack->generator==NULL) &&
       (prefer_basic_array(context_stack)>0))
     gen_basic_array(context_stack);

   /* finally, just try for any generator */
   if (context_stack->generator==NULL)
     gen_basic_array(context_stack);
   
   if (context_stack->generator==NULL) {
      parse_error(ps,"no code generator for these data types");
      exit(1);
   }

   arrow_map_delete(&(context_stack->am));
   
   free(context_stack->id);
   if (context_stack->skip_regex!=NULL)
     free(context_stack->skip_regex);
   if (context_stack->parse_regex!=NULL)
     free(context_stack->parse_regex);

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
   else if (strcmp(tok->cp,"nothing")==0)
     context_stack->generator=gen_nothing;
   else
     parse_error(ps,"unknown generate target keyword %s",tok->cp);
   
   node_delete(tok);
   ps->ignore_semicolon=1;
}

