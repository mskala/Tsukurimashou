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
   
   /* FIXME handle actually generating the code */
   
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
