/*
 * Bit vector matching for IDSgrep
 * Copyright (C) 2013  Matthew Skala
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

#include "idsgrep.h"

/**********************************************************************/

/* Notes on bit vector layout:
 * 
 * bits[0], least significant 32 bits: head and functor of root
 * bits[0], most significant 32 bits: head and functor of first/leftmost
 *   child of root
 * bits[1], least signficant 32 bits: head and functor of last/rightmost
 *   child of root (duplicates first/left if root is unary!)
 * bits[1], most significant 32 bits: head and functors of middle
 *   child if any, and any grandchildren or deeper descendants
 */

/**********************************************************************/

/* "Hit your head on the corner of a block of tofu and die!" */

uint32_t magic_seed[MSEED_SIZE]={
   UINT32_C(0xe8b186e8),UINT32_C(0x8590e381),UINT32_C(0xaee8a792),
   UINT32_C(0xe381abe9),UINT32_C(0xa0ade382),UINT32_C(0x92e381b6),
   UINT32_C(0xe381a4e3),UINT32_C(0x8191e381),UINT32_C(0xa6e6adbb),
   UINT32_C(0xe381ad21),
   (uint32_t)LAMBDA,
   (uint32_t)sizeof(INDEX_HEADER),(uint32_t)sizeof(INDEX_RECORD),
};

/**********************************************************************/

void default_needle_bits_fn(NODE *n,BIT_FILTER *f) {
   f->bits[0]=UINT64_MAX;
   f->bits[1]=UINT64_MAX;
   f->lambda=-1;
}

/**********************************************************************/

void haystack_bits_fn(NODE *n,uint64_t bits[2]) {
   int i;
   uint32_t hval;
   uint64_t cbits[2];
   
   bits[0]=UINT64_C(0);
   bits[1]=UINT64_C(0);
   
   /* head */
   if (n->head!=NULL) {
      hval=fnv_hash(n->head->length,n->head->data,0);
      for (i=0;i<=LAMBDA;i++) {
	 bits[0]|=(UINT64_C(1)<<(hval&31));
	 hval>>=5;
      }
   }
      
   /* functor */
   hval=fnv_hash(n->functor->length,n->functor->data,1)+
     UINT32_C(1108378657)*n->arity;
   for (i=0;i<=LAMBDA;i++) {
      bits[0]|=(UINT64_C(1)<<(hval&31));
      hval>>=5;
   }
   
   /* children */
   switch (n->arity) {
    case 0:
      /* DO NOTHING */
      break;
      
    case 1:
      haystack_bits_fn(n->child[0],cbits);
      bits[0]|=(cbits[0]<<32);
      bits[1]|=cbits[0];
      bits[1]|=
	((cbits[1]|(cbits[1]<<32))&UINT64_C(0xFFFFFFFF00000000));
      break;
      
    case 2:
      haystack_bits_fn(n->child[0],cbits);
      bits[0]|=(cbits[0]<<32);
      bits[0]|=(cbits[0]&UINT64_C(0xFFFFFFFF00000000));
      bits[1]|=
	((cbits[1]|(cbits[1]<<32))&UINT64_C(0xFFFFFFFF00000000));

      haystack_bits_fn(n->child[1],cbits);
      bits[1]|=cbits[0];
      bits[1]|=
	((cbits[1]|(cbits[1]<<32))&UINT64_C(0xFFFFFFFF00000000));
      break;
      
    case 3:
      haystack_bits_fn(n->child[0],cbits);
      bits[0]|=(cbits[0]<<32);
      bits[0]|=(cbits[0]&UINT64_C(0xFFFFFFFF00000000));
      bits[1]|=
	((cbits[1]|(cbits[1]<<32))&UINT64_C(0xFFFFFFFF00000000));

      haystack_bits_fn(n->child[1],cbits);
      bits[1]|=
	((cbits[0]|(cbits[0]<<32))&UINT64_C(0xFFFFFFFF00000000));
      bits[1]|=
	((cbits[1]|(cbits[1]<<32))&UINT64_C(0xFFFFFFFF00000000));

      haystack_bits_fn(n->child[2],cbits);
      bits[1]|=cbits[0];
      bits[1]|=
	((cbits[1]|(cbits[1]<<32))&UINT64_C(0xFFFFFFFF00000000));
      break;
   }
}
