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

void handle_encode(PARSER_STATE *ps,int dir) {
   NODE *tok,*encoded,*code_point;
   int i;
   
   ps->ignore_semicolon=0;

   tok=get_token(ps);
   if (tok->type!=nt_keyword)
     parse_error(ps,"encoding type must be a keyword");
   else if (strcmp(tok->cp,"utf")==0) {
      node_delete(tok);
      tok=get_token(ps);
      if ((tok->type!=nt_int) || (tok->x!=8))
	parse_error(ps,"unknwon encoding type");
      else {
	 encoded=node_new();
	 encoded->type=nt_string;
	 encoded->cp=(char *)malloc(5);

	 code_point=node_new();
	 code_point->type=nt_int;

	 encoded->cp[1]='\0';
	 for (i=0;i<0x80;i++) {
	    encoded->cp[0]=i;
	    code_point->x=i;
	    if (dir)
	      raw_add_arrow(&(context_stack->am),code_point,encoded,
			    context_stack->dupe_priority);
	    else
	      raw_add_arrow(&(context_stack->am),encoded,code_point,
			    context_stack->dupe_priority);
	 }

	 encoded->cp[2]='\0';
	 for (;i<0x800;i++) {
	    encoded->cp[0]=0xC0|(i>>6);
	    encoded->cp[1]=0x80|(i&0x3F);
	    code_point->x=i;
	    if (dir)
	      raw_add_arrow(&(context_stack->am),code_point,encoded,
			    context_stack->dupe_priority);
	    else
	      raw_add_arrow(&(context_stack->am),encoded,code_point,
			    context_stack->dupe_priority);
	 }

	 encoded->cp[3]='\0';
	 for (;i<0x10000;i++) {
	    encoded->cp[0]=0xE0|(i>>12);
	    encoded->cp[1]=0x80|((i>>6)&0x3F);
	    encoded->cp[2]=0x80|(i&0x3F);
	    code_point->x=i;
	    if (dir)
	      raw_add_arrow(&(context_stack->am),code_point,encoded,
			    context_stack->dupe_priority);
	    else
	      raw_add_arrow(&(context_stack->am),encoded,code_point,
			    context_stack->dupe_priority);
	 }

	 encoded->cp[4]='\0';
	 for (;i<0x110000;i++) {
	    encoded->cp[0]=0xF0|(i>>18);
	    encoded->cp[1]=0x80|((i>>12)&0x3F);
	    encoded->cp[2]=0x80|((i>>6)&0x3F);
	    encoded->cp[3]=0x80|(i&0x3F);
	    code_point->x=i;
	    if (dir)
	      raw_add_arrow(&(context_stack->am),code_point,encoded,
			    context_stack->dupe_priority);
	    else
	      raw_add_arrow(&(context_stack->am),encoded,code_point,
			    context_stack->dupe_priority);
	 }
      }
   } else
     parse_error(ps,"unknown encoding type %s",tok->cp);
   node_delete(tok);
   
   ps->ignore_semicolon=1;
}
