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

/**********************************************************************/

/* Bit filter logic operations
 * 
 * These all have the property that the first argument, z, is the
 * destination of the operation.  Any others are inputs, and may
 * be identical to z to overwrite an input.  The z argument is also
 * returned from each function, to make it easier to pass these in
 * each others' argument lists.
 *
 * In general:  if (x OP y) returns z, then ((x matches vec) OP
 * (y matches vec)) implies (z matches vec).  It might be that z
 * matches other things as well, i.e. it gives some false positives
 * even beyond the false positives of x and y; in the worst case,
 * z might even be a match-everything filter; but that is the hazard
 * of using bit vector filters.  We attempt to avoid introducing any
 * more false positives than absolutely necessary.
 */

/* match everything */
static BIT_FILTER *bf_true(BIT_FILTER *z) {
   z->bits[0]=UINT64_MAX;
   z->bits[1]=UINT64_MAX;
   z->lambda=-1;
   return z;
}

/* match nothing */
static BIT_FILTER *bf_false(BIT_FILTER *z) {
   z->bits[0]=UINT64_C(0);
   z->bits[1]=UINT64_C(0);
   z->lambda=128;
   return z;
}

/* match if x does not match (very loose) */
static BIT_FILTER *bf_not(BIT_FILTER *z,BIT_FILTER *x) {
   return (x->lambda<0)?bf_false(z):bf_true(z);
}

/* match if x matches or y matches */
static BIT_FILTER *bf_or(BIT_FILTER *z,BIT_FILTER *x,BIT_FILTER *y) {
   z->bits[0]=x->bits[0]|y->bits[0];
   z->bits[1]=x->bits[1]|y->bits[1];
   if (x->lambda<y->lambda)
     z->lambda=z->lambda;
   else
     z->lambda=y->lambda;
   return z;
}

/* match if x matches and y matches */
static BIT_FILTER *bf_and(BIT_FILTER *z,BIT_FILTER *x,BIT_FILTER *y) {
   uint64_t xybits[2];
   int a_max,a_min,b_max,b_min,c_max,c_min,best_filter;
   int_fast32_t ratio,best_ratio;
   
   /* find the bits in common */
   xybits[0]=x->bits[0]&y->bits[0];
   xybits[1]=x->bits[1]&y->bits[1];
   
   /* find sizes of bit sets */
   b_max=uint64_2_pop(xybits);
   a_max=uint64_2_pop(x->bits)-b_max;
   c_max=uint64_2_pop(y->bits)-b_max;

   /* abort if there are no bits */
   if (a_max+b_max+c_max==0)
     return ((x->lambda<0) && (y->lambda<0))?bf_true(z):bf_false(z);
   
   /* lower bounds */
   a_min=x->lambda+1-b_max;
   b_min=x->lambda+1-a_max;
   if (y->lambda+1-c_max>b_min)
     b_min=y->lambda+1-c_max;
   c_min=y->lambda+1-b_max;
   if (a_min<0) a_min=0;
   if (b_min<0) b_min=0;
   if (c_min<0) c_min=0;
   
   /* find the best filter */
   best_filter=0;
   best_ratio=(INT32_C(1000000)*(a_min+b_min+c_min-1))/(a_max+b_max+c_max);
   if (a_max>0) {
      ratio=(INT32_C(1000000)*(a_min+b_min-1))/(a_max+b_max);
      if (ratio>best_ratio) {
	 best_ratio=ratio;
	 best_filter=1;
      }
      ratio=(INT32_C(1000000)*(a_min+c_min-1))/(a_max+c_max);
      if (ratio>best_ratio) {
	 best_ratio=ratio;
	 best_filter=2;
      }
      ratio=(INT32_C(1000000)*(a_min-1))/a_max;
      if (ratio>best_ratio) {
	 best_ratio=ratio;
	 best_filter=3;
      }
   }
   if (b_max>0) {
      ratio=(INT32_C(1000000)*(b_min+c_min-1))/(b_max+c_max);
      if (ratio>best_ratio) {
	 best_ratio=ratio;
	 best_filter=4;
      }
      ratio=(INT32_C(1000000)*(b_min-1))/b_max;
      if (ratio>best_ratio) {
	 best_ratio=ratio;
	 best_filter=5;
      }
   }
   if (c_max>0) {
      ratio=(INT32_C(1000000)*(c_min-1))/c_max;
      if (ratio>best_ratio) {
	 best_ratio=ratio;
	 best_filter=6;
      }
   }
   
   /* set up the return value */
   switch(best_filter) {
    case 0: /* ABC */
      z->bits[0]=x->bits[0]|y->bits[0];
      z->bits[1]=x->bits[1]|y->bits[1];
      z->lambda=a_min+b_min+c_min-1;
      break;

    case 1: /* AB */
      z->bits[0]=x->bits[0];
      z->bits[1]=x->bits[1];
      z->lambda=a_min+b_min-1;
      break;

    case 2: /* AC */
      z->bits[0]=x->bits[0]^y->bits[0];
      z->bits[1]=x->bits[1]^y->bits[1];
      z->lambda=a_min+c_min-1;
      break;

    case 3: /* A */
      z->bits[0]=x->bits[0]&~y->bits[0];
      z->bits[1]=x->bits[1]&~y->bits[1];
      z->lambda=a_min-1;
      break;

    case 4: /* BC */
      z->bits[0]=y->bits[0];
      z->bits[1]=y->bits[1];
      z->lambda=b_min+c_min-1;
      break;

    case 5: /* B */
      z->bits[0]=xybits[0];
      z->bits[1]=xybits[1];
      z->lambda=b_min-1;
      break;

    case 6: /* C */
      z->bits[0]=y->bits[0]&~x->bits[0];
      z->bits[1]=y->bits[1]&~x->bits[1];
      z->lambda=c_min-1;
      break;
   }

   return z;
}

/**********************************************************************/

/* match if first child of x matches */
static BIT_FILTER *bf_first_child(BIT_FILTER *z,BIT_FILTER *x) {
   uint64_t collisions[2];
   int mylambda;
   
   /* abort in case of the match-everything filter */
   if (x->lambda<0)
     return bf_true(z);
   
   /* count the collisions introduced by rearrangement */
   collisions[0]=x->bits[0]&x->bits[1]&UINT64_C(0xFFFFFFFF00000000);
   collisions[1]=x->bits[1]&((x->bits[1]<<32)
			     |(x->bits[0]&UINT64_C(0xFFFFFFFF00000000)));
   collisions[0]&=~collisions[1];

   /* find the new lambda, make sure we haven't ruined everything */
   mylambda=x->lambda-uint64_2_pop(collisions);
   if (mylambda<0)
     return bf_true(z);
   
   /* find the new bits */
   z->bits[1]=(x->bits[1]|(x->bits[1]<<32)|(x->bits[0]))
     &UINT64_C(0xFFFFFFFF00000000);
   z->bits[0]=x->bits[0]<<32;
   x->lambda=mylambda;
   
   return z;
}

/* match if last child of x matches */
static BIT_FILTER *bf_last_child(BIT_FILTER *z,BIT_FILTER *x) {
   uint64_t collisions[2];
   int mylambda;
   
   /* abort in case of the match-everything filter */
   if (x->lambda<0)
     return bf_true(z);
   
   /* count the collisions introduced by rearrangement */
   collisions[0]=x->bits[0]&x->bits[1]&UINT64_C(0xFFFFFFFF00000000);
   collisions[1]=x->bits[1]&((x->bits[1]<<32)
			     |(x->bits[0]&UINT64_C(0xFFFFFFFF00000000)));
   collisions[0]&=~collisions[1];

   /* find the new lambda, make sure we haven't ruined everything */
   mylambda=x->lambda-uint64_2_pop(collisions);
   if (mylambda<0)
     return bf_true(z);
   
   /* find the new bits */
   z->bits[0]=UINT64_C(0);
   z->bits[1]=x->bits[0]|(x->bits[1]<<32)|
     (x->bits[1]&UINT64_C(0xFFFFFFFF00000000));
   x->lambda=mylambda;
   
   return z;
}

/* match if middle child of x matches */
/* this is a little inefficient, but much easier than trying to do four-way
 * inclusion-exclusion just for this one relatively rare case. */
static BIT_FILTER *bf_middle_child(BIT_FILTER *z,BIT_FILTER *x) {
   return bf_last_child(z,bf_last_child(z,x));
}

/**********************************************************************/

void default_needle_bits_fn(NODE *n,BIT_FILTER *f) {
   bf_true(f);
}
