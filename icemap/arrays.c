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
      if ((c->am.last_key->x-c->am.first_key->x)<=100)
	return 3;
      else if ((c->am.last_key->x-c->am.first_key->x)<=5000)
	return 2;
      else
	return 1;
   }
   
   return 0;
}

void gen_basic_array(CONTEXT *c) {
   FILE *cf,*hf;
   char *ots="int ";
   int i;
   NODE *k,*v;
   
   /* check:  can we proceed? */
   if ((c->am.first_key!=NULL) && (c->am.first_key->type==nt_int) &&
       (c->am.last_key!=NULL) && (c->am.last_key->type==nt_int))
     c->generator=&gen_basic_array;
   else {
      c->generator=NULL;
      return;
   }
   
   cf=open_output_file(c->c_file);
   hf=open_output_file(c->h_file);
   
   k=node_new();
   k->type=nt_int;

   fprintf(hf,"/* basic array lookup for map \"%s\" */\n\n",
	  c->id);
   fprintf(hf,"extern %s__icemap_%s_array[];\n",
	   ots,c->id);
   fprintf(hf,"#define %s_lookup(idx) (__icemap_%s_array[(idx)-%d])\n\n",
	   c->id,c->id,c->am.first_key->x);

   fprintf(cf,"/* basic array lookup for map \"%s\" */\n\n",
	  c->id);
   fprintf(cf,"%s__icemap_%s_array[%d]={\n",
	   ots,c->id,c->am.last_key->x-c->am.first_key->x);
   for (i=c->am.first_key->x;i<=c->am.last_key->x;i++) {
      k->x=i;
      v=arrow_map_lookup(&(c->am),k);
      if (v==NULL)
	fputs("  0, /* missing key */\n",cf);
      else if (v->type==nt_int)
	fprintf(cf,"  %d,\n",v->x);
      else
	fprintf(cf,"  \"%s\",\n",v->cp);
   }
   fputs("};\n\n",cf);
   
   node_delete(k);
}
