/*
 * Array lookup code generator
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

int prefer_basic_array(CONTEXT *c) {
   
   if ((c->am.first_key!=NULL) && (c->am.first_key->type==nt_int) &&
       (c->am.last_key!=NULL) && (c->am.last_key->type==nt_int)) {
      if ((c->am.last_key->x-c->am.first_key->x)<100)
	return 3;
      else if ((c->am.last_key->x-c->am.first_key->x)<5000)
	return 2;
      else
	return 1;
   }
   
   return 0;
}

void gen_basic_array(CONTEXT *c) {
   NODE *cf,*hf;
   char *ots,*maybe_space;
   int i;
   NODE *k,*v;
   CONTEXT *ctx;
   
   /* check:  can we proceed? */
   if ((c->am.first_key!=NULL) && (c->am.first_key->type==nt_int) &&
       (c->am.last_key!=NULL) && (c->am.last_key->type==nt_int))
     c->generator=gen_basic_array;
   else {
      c->generator=NULL;
      return;
   }
   
   cf=open_output_file(c->c_file);
   hf=open_output_file(c->h_file);
   
   k=node_new();
   k->type=nt_int;
   
   if (c->value_c_type==NULL)
     ots="int";
   else
     ots=c->value_c_type;
   maybe_space=(ots[strlen(ots)-1]=='*')?"":" ";

   of_write(hf,"/* basic array lookup for map \"%s\" */\n\n",
	    c->id);
   of_write(hf,"extern %s%s__icemap_%s_array[];\n",
	    ots,maybe_space,c->id);
   if (c->am.first_key->x==0)
     of_write(hf,"#define %s_lookup(idx) \\\n"
	      "  (__icemap_%s_array[(idx)])\n\n",
	      c->id,c->id);
   else
     of_write(hf,"#define %s_lookup(idx) \\\n"
	      "  (__icemap_%s_array[(idx)-%d])\n\n",
	      c->id,c->id,c->am.first_key->x);

   of_write(cf,"/* basic array lookup for map \"%s\" */\n\n",
	    c->id);
   of_write(cf,"%s%s__icemap_%s_array[%d]={\n",
	    ots,maybe_space,c->id,c->am.last_key->x-c->am.first_key->x+1);
   of_indent(cf,2);

   for (i=c->am.first_key->x;i<=c->am.last_key->x;i++) {
      k->x=i;
      v=arrow_map_lookup(&(c->am),k);
      if (v==NULL)
	of_write_wrapped(cf,"0 /* missing key */,");
      else if (v->type==nt_int)
	of_write_wrapped(cf,"0x%X,",v->x);
      else
	of_write_wrapped(cf,"\"%s\",",v->cp);
   }

   of_unindent(cf,2);
   of_write(cf,"\n};\n\n");

   node_delete(k);

   for (ctx=context_stack->parent;ctx;ctx=ctx->parent)
     ctx->leaves++;
}
