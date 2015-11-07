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

static void write_c_value(NODE *f,CONTEXT *c,NODE *v,char *x) {
   if (v==NULL) {
      switch (c->default_policy) {
       case dp_value:
	 write_c_value(f,c,c->default_value,x);
	 break;

       case dp_any:
	 write_c_value(f,c,c->am.first_key->nodes,x);
	 break;

       case dp_null:
	 of_write_wrapped(f,"NULL%s",x);
	 break;

       default:
	 of_write_wrapped(f,"0 /* missing key */%s",x);
	 break;
      }

   } else if (v->type==nt_int) {
      if (c->quote_policy==qp_everything)
	of_write_wrapped(f,"\"%d\"%s",v->x,x);
      else
	of_write_wrapped(f,"0x%X%s",v->x,x);

   } else {
      if (c->quote_policy==qp_nothing)
	of_write_wrapped(f,"%s%s",v->cp,x);
      else
	of_write_wrapped(f,"\"%s\"%s",v->cp,x);
   }
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
   of_write(hf,"#define %s_lookup(idx) \\\n  (",c->id);
   if (c->default_policy!=dp_fail) {
      of_write(hf,"(((idx)<%d)||((idx)>%d))?",
	       c->am.first_key->x,c->am.last_key->x);
      switch (c->default_policy) {
       case dp_value:
	 if (c->return_pointer)
	   of_write(hf,"(&(__icemap_%s_array[%d])):(",c->id,
		    c->am.last_key->x-c->am.first_key->x+1);
	 else {
	    of_write(hf,"(");
	    write_c_value(hf,c,c->default_value,"");
	    of_write(hf,"):(");
	 }
	 break;

       case dp_any:
	 if (c->return_pointer)
	   of_write(hf,"(&(__icemap_%s_array[0])):(",c->id);
	 else
	   of_write(hf,"(__icemap_%s_array[0]):(",c->id);
	 break;

       case dp_null:
       default:
	   of_write(hf,"NULL:(");
	 break;
      }
   }
   if (c->return_pointer) of_write(hf,"&(");
   if (c->am.first_key->x==0)
     of_write(hf,"__icemap_%s_array[(idx)]",c->id);
   else
     of_write(hf,"__icemap_%s_array[(idx)-%d]",c->id,c->am.first_key->x);
   if (c->return_pointer) of_write(hf,")");
   if (c->default_policy!=dp_fail) of_write(hf,")");
   of_write(hf,")\n");

   of_write(hf,"#define %s_count (%d)\n\n",c->id,c->am.num_arrows);

   of_write(cf,"/* basic array lookup for map \"%s\" */\n\n",
	    c->id);
   if ((c->default_policy==dp_value) && c->return_pointer)
     of_write(cf,"%s%s__icemap_%s_array[%d]={\n",
	      ots,maybe_space,c->id,c->am.last_key->x-c->am.first_key->x+2);
   else
     of_write(cf,"%s%s__icemap_%s_array[%d]={\n",
	      ots,maybe_space,c->id,c->am.last_key->x-c->am.first_key->x+1);
   of_indent(cf,2);

   for (i=c->am.first_key->x;i<=c->am.last_key->x;i++) {
      k->x=i;
      v=arrow_map_lookup(&(c->am),k);
      write_c_value(cf,c,v,",");
   }
   if ((c->default_policy==dp_value) && c->return_pointer)
     write_c_value(cf,c,c->default_value,",");

   of_unindent(cf,2);
   of_write(cf,"\n};\n\n");

   node_delete(k);

   for (ctx=context_stack->parent;ctx;ctx=ctx->parent)
     ctx->leaves++;
}
