/*
 * Remap arrows in a context
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

static void gen_value_remap(CONTEXT *c) {
   ARROW_MAP zm;

   if (c->parent==NULL) {
      c->generator=NULL;
      return;
   }
   c->generator=gen_value_remap;
   
   arrow_map_remap_values(&zm,&(c->parent->am),&(c->am));
   arrow_map_delete(&(c->parent->am));
   c->parent->am=zm;

   c->parent->leaves=0;
}

static void gen_key_remap(CONTEXT *c) {
   ARROW_MAP zm;

   if (c->parent==NULL) {
      c->generator=NULL;
      return;
   }
   c->generator=gen_key_remap;
   
   arrow_map_remap_keys(&zm,&(c->parent->am),&(c->am),c->dupe_priority);
   arrow_map_delete(&(c->parent->am));
   c->parent->am=zm;

   c->parent->leaves=0;
}

void handle_remap(PARSER_STATE *ps) {
   NODE *tok;
   int remap_values;
   
   ps->ignore_semicolon=0;

   tok=get_token(ps);
   if (tok->type!=nt_keyword)
     parse_error(ps,"remap direction must be a keyword");
   else if (strcmp(tok->cp,"values")==0)
     remap_values=1;
   else if (strcmp(tok->cp,"vals")==0)
     remap_values=1;
   else if (strcmp(tok->cp,"keys")==0)
     remap_values=0;
   else
     parse_error(ps,"unknown remap direction %s",tok->cp);
   node_delete(tok);
   
   tok=get_token(ps);   
   if ((tok->type!=nt_keyword) || (strcmp(tok->cp,"{")!=0))
     parse_error(ps,"remap must be given a context");
   node_delete(tok);
   
   handle_opening_brace(ps);
   context_stack->generator=remap_values?gen_value_remap:gen_key_remap;
   arrow_map_delete(&(context_stack->am));
   arrow_map_new(&(context_stack->am));
}
