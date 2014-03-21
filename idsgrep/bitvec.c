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
   (uint32_t)(LAMBDA+256), /* add multiples of 128 on breaking changes */
   (uint32_t)sizeof(INDEX_HEADER),(uint32_t)sizeof(INDEX_RECORD),
};

int bitvec_debug=0;
static int bvd_indent=0;

/**********************************************************************/

/* choose a combination of k out of n bits, depending on h.
 * Max n allowed is 32 (and that's the expected case); this uses
 * simple modulo on h, which does not guarantee truly uniform choices.
 * Should be close enough when n choose k is small in comparison to
 * 2**32, and that is the intended use.
 */
static uint32_t bit_combo(int n,int k,uint32_t h) {
   int i,j,a[32];
   uint32_t rval;
   
   for (i=0;i<n;i++) a[i]=i;

   rval=UINT32_C(0);
   for (i=0;i<k;i++) {
      j=h%(n-i);
      h/=(n-i);

      if (j>0) {
	 j+=i;
	 a[i]^=a[j];
	 a[j]^=a[i];
	 a[i]^=a[j];
      }

      rval|=UINT32_C(1)<<a[i];
   }

   return rval;
}

/**********************************************************************/

#ifdef HAVE_BUDDY

#define MAX_BDD_COMPLEXITY 1000

/* create a BDD for the conjunction of the bits in the input */
static bdd bit_bdd(uint32_t bits) {
   bdd rval,x;
   int i;
   
   /* loop through bits, ANDing them into the result */
   rval=bddtrue;
   for (i=31;i>=0;i--)
     if (bits&(UINT32_C(1)<<i)) {
	x=bdd_addref(bdd_and(rval,bdd_ithvar(i)));
	bdd_delref(rval);
	rval=x;
     }
   return rval;
}

/* change the highest bits into don't-cares until few enough nodes */
static bdd limit_bdd_complexity(bdd in_bdd) {
   bdd rval,x;
   int *vset;
   int vnum;
   
   /* if input is not too big, pass it through unmolested */
   if (bdd_nodecount(in_bdd)<=MAX_BDD_COMPLEXITY)
     return in_bdd;
   
   /* otherwise, look for variables to remove */
   x=bdd_addref(bdd_support(in_bdd));
   bdd_scanset(x,&vset,&vnum);
   bdd_delref(x);
   
   /* and remove them until we're small enough */
   for (rval=in_bdd;vnum--;) {
      x=bdd_addref(bdd_exist(rval,bdd_ithvar(vset[vnum])));
      bdd_delref(rval);
      rval=x;
      if (bdd_nodecount(rval)<=MAX_BDD_COMPLEXITY)
	break;
   }
   
   free(vset);   
   return rval;
}

#endif

/**********************************************************************/

void haystack_bits_fn(NODE *n,uint64_t bits[2]) {
   int i;
   uint32_t hval;
   uint64_t cbits[2];
   
   /* head and functor */
   hval=fnv_hash(n->functor->length,n->functor->data,1)+
     UINT32_C(1108378657)*n->arity;
   bits[0]=(uint64_t)bit_combo(32,LAMBDA+1,hval);
   if (n->head==NULL)
     hval=fnv_hash(0,"",0);
   else
     hval=fnv_hash(n->head->length,n->head->data,0);
   bits[0]|=(uint64_t)bit_combo(32,LAMBDA+1,hval);
   bits[1]=UINT64_C(0);

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
      bits[1]|=(cbits[0]&UINT64_C(0xFFFFFFFF00000000));
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
      bits[1]|=(cbits[0]&UINT64_C(0xFFFFFFFF00000000));
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
   int i;
   
   z->bits[0]=UINT64_MAX;
   z->bits[1]=UINT64_MAX;
   z->lambda=-1;

   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"TRU=%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      z->bits[1],z->bits[0],z->lambda+1,uint64_2_pop(z->bits));
   }
   
#ifdef HAVE_BUDDY
   /* handle decision diagram */
   z->decision_diagram=bddtrue;
#endif

   return z;
}

/* match nothing */
static BIT_FILTER *bf_false(BIT_FILTER *z) {
   int i;
   
   z->bits[0]=UINT64_C(0);
   z->bits[1]=UINT64_C(0);
   z->lambda=128;

   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"FLS=%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      z->bits[1],z->bits[0],z->lambda+1,uint64_2_pop(z->bits));
   }

#ifdef HAVE_BUDDY
   /* handle decision diagram */
   z->decision_diagram=bddfalse;
#endif
   return z;
}

/* match if x matches or y matches */
static BIT_FILTER *bf_or(BIT_FILTER *z,BIT_FILTER *x,BIT_FILTER *y) {
   uint64_t trimbits[2];
   int i,hi_lambda;
#ifdef HAVE_BUDDY
   bdd new_bdd;
#endif

   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"OR  %016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      x->bits[1],x->bits[0],x->lambda+1,uint64_2_pop(x->bits));
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"    %016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      y->bits[1],y->bits[0],y->lambda+1,uint64_2_pop(y->bits));
   }

   /* find new lambda, and bits we can consider trimming */
   if (x->lambda<y->lambda) {
      hi_lambda=y->lambda;
      z->lambda=x->lambda;
      trimbits[0]=y->bits[0]&~x->bits[0];
      trimbits[1]=y->bits[1]&~x->bits[1];
   } else {
      hi_lambda=x->lambda;
      z->lambda=y->lambda;
      trimbits[0]=x->bits[0]&~y->bits[0];
      trimbits[1]=x->bits[1]&~y->bits[1];
   }
   
   /* merge the bit vectors */
   z->bits[0]=x->bits[0]|y->bits[0];
   z->bits[1]=x->bits[1]|y->bits[1];
   
   /* peel off bits as far as possible */
   /* speed is not critical here (unlike where we do population count)
    * and given that we have to loop anyway when hi_lambda is significantly
    * more than z->lambda, it's not clear we'd save much by trying to
    * do a super-fast "find highest set bit" operation */
   for (i=63;(hi_lambda>z->lambda) && (i>=0);i--)
     if (trimbits[1]&(UINT64_C(1)<<i)) {
	z->bits[1]^=UINT64_C(1)<<i;
	hi_lambda--;
     }
   for (i=63;(hi_lambda>z->lambda) && (i>=0);i--)
     if (trimbits[0]&(UINT64_C(1)<<i)) {
	z->bits[0]^=UINT64_C(1)<<i;
	hi_lambda--;
     }
   
   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"   =%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      z->bits[1],z->bits[0],z->lambda+1,uint64_2_pop(z->bits));
   }
   
#ifdef HAVE_BUDDY
   /* handle decision diagram */
   new_bdd=bdd_addref(bdd_or(x->decision_diagram,y->decision_diagram));
   if (z==x) bdd_delref(x->decision_diagram);
   if (z==y) bdd_delref(y->decision_diagram);
   z->decision_diagram=limit_bdd_complexity(new_bdd);
#endif

   return z;
}

/* match if x matches and y matches */
static BIT_FILTER *bf_and(BIT_FILTER *z,BIT_FILTER *x,BIT_FILTER *y) {
   int i;
   uint64_t xybits[2];
   int a_max,a_min,b_max,b_min,c_max,c_min;
   int ab_min,bc_min,ac_min,abc_min,best_filter;
#ifdef HAVE_BUDDY
   bdd new_bdd;
#endif
   
   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"AND %016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      x->bits[1],x->bits[0],x->lambda+1,uint64_2_pop(x->bits));
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"    %016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      y->bits[1],y->bits[0],y->lambda+1,uint64_2_pop(y->bits));
   }

   /* find the bits in common */
   xybits[0]=x->bits[0]&y->bits[0];
   xybits[1]=x->bits[1]&y->bits[1];
   
   /* find sizes of bit sets */
   b_max=uint64_2_pop(xybits);
   a_max=uint64_2_pop(x->bits)-b_max;
   c_max=uint64_2_pop(y->bits)-b_max;

   /* abort if there are no bits */
   if (a_max+b_max+c_max==0) {
#ifdef HAVE_BUDDY
      if (z==x) bdd_delref(x->decision_diagram);
      if (z==y) bdd_delref(y->decision_diagram);
#endif
      return ((x->lambda<0) && (y->lambda<0))?bf_true(z):bf_false(z);
   }
   
   /* lower bounds, singletons */
   a_min=x->lambda+1-b_max;
   b_min=x->lambda+1-a_max;
   if (y->lambda+1-c_max>b_min)
     b_min=y->lambda+1-c_max;
   c_min=y->lambda+1-b_max;
   if (a_min<0) a_min=0;
   if (b_min<0) b_min=0;
   if (c_min<0) c_min=0;
   
   /* lower bounds, unions */
   ab_min=a_min+b_min;
   if (x->lambda+1>ab_min)
     ab_min=x->lambda+1;
   bc_min=b_min+c_min;
   if (y->lambda+1>bc_min)
     bc_min=y->lambda+1;
   abc_min=a_min+b_min+c_min;
   if (x->lambda+y->lambda+2-b_max>abc_min)
     abc_min=x->lambda+y->lambda+2-b_max;
   ac_min=a_min+c_min;
   if (abc_min-b_max>ac_min)
     ac_min=abc_min-b_max;
   
   /* find the best filter */
   best_filter=((a_min>a_max/3)?0:4)
     +((b_min>b_max/3)?0:2)
       +((c_min>c_max/3)?0:1);
   
   /* no good filter - try harder */
   if (best_filter==7)
     best_filter=((a_min>0)?0:4)
       +((b_min>0)?0:2)
	 +((c_min>0)?0:1);

   /* set up the return value */
   switch(best_filter) {
    case 0: /* ABC */
      z->bits[0]=x->bits[0]|y->bits[0];
      z->bits[1]=x->bits[1]|y->bits[1];
      z->lambda=abc_min-1;
      break;

    case 1: /* AB */
      z->bits[0]=x->bits[0];
      z->bits[1]=x->bits[1];
      z->lambda=ab_min-1;
      break;

    case 2: /* AC */
      z->bits[0]=x->bits[0]^y->bits[0];
      z->bits[1]=x->bits[1]^y->bits[1];
      z->lambda=ac_min-1;
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
      
    case 7: /* nothing */
#ifdef HAVE_BUDDY
      z->bits[0]=UINT64_MAX;
      z->bits[1]=UINT64_MAX;
      z->lambda=-1;
#else
      return bf_true(z);
#endif
      break;
   }
   
   if (z->lambda>uint64_2_pop(z->bits)) {
#ifdef HAVE_BUDDY
      if (z==x) bdd_delref(x->decision_diagram);
      if (z==y) bdd_delref(y->decision_diagram);
#endif
      return bf_false(z);
   }

   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"   =%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      z->bits[1],z->bits[0],z->lambda+1,uint64_2_pop(z->bits));
   }

#ifdef HAVE_BUDDY
   /* handle decision diagram */
   new_bdd=bdd_addref(bdd_and(x->decision_diagram,y->decision_diagram));
   if (z==x) bdd_delref(x->decision_diagram);
   if (z==y) bdd_delref(y->decision_diagram);
   z->decision_diagram=limit_bdd_complexity(new_bdd);
#endif

   return z;
}

/**********************************************************************/

/* match if first child of x matches */
static BIT_FILTER *bf_first_child(BIT_FILTER *z,BIT_FILTER *x) {
   int mylambda,i;
   uint64_t c[2];
#ifdef HAVE_BUDDY
   bdd bdd_a,bdd_b,bdd_c;
#endif

   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"FCH %016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      x->bits[1],x->bits[0],x->lambda+1,uint64_2_pop(x->bits));
   }

   /* abort in case of the match-everything filter */
   if (x->lambda<0) {
#ifdef HAVE_BUDDY
      if (z==x) bdd_delref(x->decision_diagram);
#endif
      return bf_true(z);
   }
   
   /* count collisions */
   c[0]=(x->bits[1]|(x->bits[1]<<32))&UINT64_C(0xFFFFFFFF00000000);
   c[1]=(x->bits[0]&UINT64_C(0xFFFFFFFF00000000))|(x->bits[0]>>32)
     |(x->bits[1]>>32)|(x->bits[1]<<32);
   c[0]&=x->bits[0];
   c[1]&=x->bits[1];
   mylambda=x->lambda-(uint64_2_pop(c)/2);
   if (mylambda<x->lambda/3)
     mylambda=x->lambda/3;

   /* find the new bits */
   z->bits[1]=(x->bits[1]|(x->bits[1]<<32)|(x->bits[0]))
     &UINT64_C(0xFFFFFFFF00000000);
   z->bits[0]=x->bits[0]<<32;
   z->lambda=mylambda;
   
   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"   =%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      z->bits[1],z->bits[0],z->lambda+1,uint64_2_pop(z->bits));
   }

#ifdef HAVE_BUDDY
   /* handle decision diagram */
   bdd_a=bdd_addref(x->decision_diagram);
   for (i=32;i<96;i++) {
      bdd_b=bdd_addref(bdd_restrict(bdd_a,bdd_ithvar(i)));
      bdd_c=bdd_addref(bdd_restrict(bdd_a,bdd_nithvar(i)));
      bdd_delref(bdd_a);
      bdd_a=bdd_addref(bdd_ite(bdd_ithvar((i&0x1F)+96),bdd_b,bdd_c));
      bdd_delref(bdd_b);
      bdd_delref(bdd_c);
   }
   for (i=0;i<32;i++) {
      bdd_b=bdd_addref(bdd_restrict(bdd_a,bdd_ithvar(i)));
      bdd_c=bdd_addref(bdd_restrict(bdd_a,bdd_nithvar(i)));
      bdd_delref(bdd_a);
      bdd_a=bdd_addref(bdd_ite(bdd_ithvar(i+32),bdd_b,bdd_c));
      bdd_delref(bdd_b);
      bdd_delref(bdd_c);
   }
   if (z==x) bdd_delref(x->decision_diagram);
   z->decision_diagram=bdd_a;
#endif

   return z;
}

/* match if last child of x matches */
static BIT_FILTER *bf_last_child(BIT_FILTER *z,BIT_FILTER *x) {
   int mylambda,i;
   uint64_t c[2];
#ifdef HAVE_BUDDY
   bdd bdd_a,bdd_b,bdd_c;
#endif

   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"LCH %016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      x->bits[1],x->bits[0],x->lambda+1,uint64_2_pop(x->bits));
   }

   /* abort in case of the match-everything filter */
   if (x->lambda<0) {
#ifdef HAVE_BUDDY
      if (z==x) bdd_delref(x->decision_diagram);
#endif
      return bf_true(z);
   }
   
   /* count collisions */
   c[0]=(x->bits[1]|(x->bits[1]<<32))&UINT64_C(0xFFFFFFFF00000000);
   c[1]=(x->bits[0]&UINT64_C(0xFFFFFFFF00000000))|(x->bits[0]>>32)
     |(x->bits[1]>>32)|(x->bits[1]<<32);
   c[0]&=x->bits[0];
   c[1]&=x->bits[1];
   mylambda=x->lambda-(uint64_2_pop(c)/2);
   if (mylambda<x->lambda/3)
     mylambda=x->lambda/3;

   /* find the new bits */
   z->bits[1]=x->bits[0]|(x->bits[1]<<32)|
     (x->bits[1]&UINT64_C(0xFFFFFFFF00000000));
   z->bits[0]=UINT64_C(0);
   z->lambda=mylambda;

   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"   =%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      z->bits[1],z->bits[0],z->lambda+1,uint64_2_pop(z->bits));
   }

#ifdef HAVE_BUDDY
   /* handle decision diagram */
   bdd_a=bdd_addref(x->decision_diagram);
   for (i=32;i<96;i++) {
      bdd_b=bdd_addref(bdd_restrict(bdd_a,bdd_ithvar(i)));
      bdd_c=bdd_addref(bdd_restrict(bdd_a,bdd_nithvar(i)));
      bdd_delref(bdd_a);
      bdd_a=bdd_addref(bdd_ite(bdd_ithvar((i&0x1F)+96),bdd_b,bdd_c));
      bdd_delref(bdd_b);
      bdd_delref(bdd_c);
   }
   for (i=0;i<32;i++) {
      bdd_b=bdd_addref(bdd_restrict(bdd_a,bdd_ithvar(i)));
      bdd_c=bdd_addref(bdd_restrict(bdd_a,bdd_nithvar(i)));
      bdd_delref(bdd_a);
      bdd_a=bdd_addref(bdd_ite(bdd_ithvar(i+64),bdd_b,bdd_c));
      bdd_delref(bdd_b);
      bdd_delref(bdd_c);
   }
   if (z==x) bdd_delref(x->decision_diagram);
   z->decision_diagram=bdd_a;
#endif

   return z;
}

/* match if middle child of x matches */
static BIT_FILTER *bf_middle_child(BIT_FILTER *z,BIT_FILTER *x) {
   int mylambda,i;
   uint64_t c[2];
#ifdef HAVE_BUDDY
   bdd bdd_a,bdd_b,bdd_c;
#endif
   
   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"MCH %016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      x->bits[1],x->bits[0],x->lambda+1,uint64_2_pop(x->bits));
   }

   /* abort in case of the match-everything filter */
   if (x->lambda<0) {
#ifdef HAVE_BUDDY
      if (z==x) bdd_delref(x->decision_diagram);
#endif
      return bf_true(z);
   }
   
   /* count collisions */
   c[0]=(x->bits[0]<<32)|(x->bits[0]>>32)
     |x->bits[1]|(x->bits[1]<<32)|(x->bits[1]>>32);
   c[1]=(x->bits[0]<<32)|(x->bits[0]>>32)|x->bits[0]
     |(x->bits[1]<<32)|(x->bits[1]>>32);
   c[0]&=x->bits[0];
   c[1]&=x->bits[1];
   mylambda=x->lambda-(uint64_2_pop(c)/2);
   if (mylambda<x->lambda/4)
     mylambda=x->lambda/4;

   /* find the new bits */
   z->bits[1]=x->bits[0]|x->bits[1];
   z->bits[1]=(z->bits[1]|(z->bits[1]>>32))<<32;
   z->bits[0]=UINT64_C(0);
   z->lambda=mylambda;
   
   /* show debug information */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"   =%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      z->bits[1],z->bits[0],z->lambda+1,uint64_2_pop(z->bits));
   }

#ifdef HAVE_BUDDY
   /* handle decision diagram */
   bdd_a=bdd_addref(x->decision_diagram);
   for (i=0;i<96;i++) {
      bdd_b=bdd_addref(bdd_restrict(bdd_a,bdd_ithvar(i)));
      bdd_c=bdd_addref(bdd_restrict(bdd_a,bdd_nithvar(i)));
      bdd_delref(bdd_a);
      bdd_a=bdd_addref(bdd_ite(bdd_ithvar((i&0x1F)+96),bdd_b,bdd_c));
      bdd_delref(bdd_b);
      bdd_delref(bdd_c);
   }
   if (z==x) bdd_delref(x->decision_diagram);
   z->decision_diagram=bdd_a;
#endif

   return z;
}

/**********************************************************************/

void needle_fn_wrapper(NODE *n,BIT_FILTER *f) {
   BIT_FILTER fa,fb;
   uint32_t hval;
   int i;
   
   /* show what we're about to crunch */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      write_cooked_tree(n,stderr);
      bvd_indent+=3;
   }

   /* call the node's own needle function */
   n->functor->needle_bits_fn(n,f);
   
   /* but if there's a head, then haystack must have that head or no head */
   if (n->head!=NULL) {
      
      /* "that head" */
      hval=fnv_hash(n->head->length,n->head->data,0);
      fa.bits[0]=(uint64_t)bit_combo(32,LAMBDA+1,hval);
      fa.bits[1]=UINT64_C(0);
      fa.lambda=LAMBDA;
      
      /* "no head" */
      hval=fnv_hash(0,"",0);
      fb.bits[0]=(uint64_t)bit_combo(32,LAMBDA+1,hval);
      fb.bits[1]=UINT64_C(0);
      fb.lambda=LAMBDA;
      
      /* do the logic */
#ifdef HAVE_BUDDY
      fa.decision_diagram=bit_bdd((uint32_t)fa.bits[0]);
      fb.decision_diagram=bit_bdd((uint32_t)fb.bits[0]);
      bf_or(f,&fa,bf_and(f,f,&fb));
      bdd_delref(fa.decision_diagram);
      bdd_delref(fb.decision_diagram);
#else
      bf_or(f,&fa,bf_and(f,f,&fb));
#endif
   }

   /* show the result of crunching it */
   if (bitvec_debug) {
      bvd_indent-=3;
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      f->bits[1],f->bits[0],f->lambda+1,uint64_2_pop(f->bits));
   }
}

void default_needle_fn(NODE *n,BIT_FILTER *f) {
   BIT_FILTER fa,fb,fc;
   int i;
   uint32_t hval;

   /* functor */
   hval=fnv_hash(n->functor->length,n->functor->data,1)+
     UINT32_C(1108378657)*n->arity;
   f->bits[0]=(uint64_t)bit_combo(32,LAMBDA+1,hval);
   f->bits[1]=UINT64_C(0);
   f->lambda=LAMBDA;
#ifdef HAVE_BUDDY
   f->decision_diagram=bit_bdd((uint32_t)f->bits[0]);
#endif
   
   /* first child */
   if (n->arity==0)
     bf_true(&fa);
   else {
      needle_fn_wrapper(n->child[0],&fa);
      bf_first_child(&fa,&fa);
   }

   /* last child */
   if (n->arity==0)
     bf_true(&fb);
   else {
      needle_fn_wrapper(n->child[n->arity-1],&fb);
      bf_last_child(&fb,&fb);
   }

   /* middle child */
   if (n->arity<3)
     bf_true(&fc);
   else {
      needle_fn_wrapper(n->child[1],&fc);
      bf_middle_child(&fc,&fc);
   }
   
   /* must match all parts, if we're going that route */
   bf_and(f,
	  bf_and(f,f,&fa),
	  bf_and(&fb,&fb,&fc));
#ifdef HAVE_BUDDY
   bdd_delref(fa.decision_diagram);
   bdd_delref(fb.decision_diagram);
   bdd_delref(fc.decision_diagram);
#endif
}

/**********************************************************************/

void anything_needle_fn(NODE *n,BIT_FILTER *f) {
   bf_true(f);
}

void anywhere_needle_fn(NODE *n,BIT_FILTER *f) {
   BIT_FILTER fa,fb,fc;

   /* if we are not unary, then it doesn't count */
   if (n->arity!=1) {
      default_needle_fn(n,f);
      return;
   }

   /* get a filter for the child */
   needle_fn_wrapper(n->child[0],f);
   
   /* match if it matches anywhere */
   bf_first_child(&fa,f);
   bf_last_child(&fb,f);
   bf_middle_child(&fc,f);
   bf_or(f,bf_or(f,f,&fa),bf_or(&fb,&fb,&fc));
#ifdef HAVE_BUDDY
   bdd_delref(fa.decision_diagram);
   bdd_delref(fb.decision_diagram);
   bdd_delref(fc.decision_diagram);
#endif
}

void and_needle_fn(NODE *n,BIT_FILTER *f) {
   BIT_FILTER fa;

   /* if we are not binary, then it doesn't count */
   if (n->arity!=2) {
      default_needle_fn(n,f);
      return;
   }
   
   /* get filters for the children */
   needle_fn_wrapper(n->child[0],f);
   needle_fn_wrapper(n->child[1],&fa);
   
   /* match if both match */
   bf_and(f,f,&fa);
#ifdef HAVE_BUDDY
   bdd_delref(fa.decision_diagram);
#endif
}

void or_needle_fn(NODE *n,BIT_FILTER *f) {
   BIT_FILTER fa;

   /* if we are not binary, then it doesn't count */
   if (n->arity!=2) {
      default_needle_fn(n,f);
      return;
   }
   
   /* get filters for the children */
   needle_fn_wrapper(n->child[0],f);
   needle_fn_wrapper(n->child[1],&fa);
   
   /* match if either matches */
   bf_or(f,f,&fa);
#ifdef HAVE_BUDDY
   bdd_delref(fa.decision_diagram);
#endif
}

void not_needle_fn(NODE *n,BIT_FILTER *f) {
   NODE *na,*nb,*nc;

   /* if we are not unary, then it doesn't count */
   if (n->arity!=1) {
      default_needle_fn(n,f);
      return;
   }
   
   if ((n->child[0]->arity==0)
       && (n->child[0]->functor->match_fn==anything_match_fn)) {
      /* !? - never matches */
      bf_false(f);
      
   } else if ((n->child[0]->arity==1)
	      && (n->child[0]->functor->match_fn==not_match_fn)) {
      /* !!x - matches iff x matches */
      needle_fn_wrapper(n->child[0]->child[0],f);

   } else if ((n->child[0]->arity==2)
	      && (n->child[0]->functor->match_fn==and_or_match_fn)) {
      /* can apply DeMorgan's law */

      /* negated first child */
      nb=new_node();
      nb->functor=n->functor;
      nb->functor->refs++;
      nb->arity=1;
      nb->child[0]=n->child[0]->child[0];
      nb->child[0]->refs++;
      
      /* negated second child */
      nc=new_node();
      nc->functor=n->functor;
      nc->functor->refs++;
      nc->arity=1;
      nc->child[0]=n->child[0]->child[1];
      nc->child[0]->refs++;

      /* binary operator */
      na=new_node();
      na->functor=new_string(1,n->child[0]->functor->data[0]=='|'?"&":"|");
      na->arity=2;
      na->child[0]=nb;
      nb->refs++;
      na->child[1]=nc;
      nc->refs++;
      
      /* evaluate the tree fragment */
      needle_fn_wrapper(na,f);
      
      /* clean up */
      free_node(nb);
      free_node(nc);
      free_node(na);

   } else {
      /* any other cases: we can't prove the negative */
      bf_true(f);
   }
}

void unord_needle_fn(NODE *n,BIT_FILTER *f) {
   BIT_FILTER fa;
   NODE *nprime;

   /* if we are not unary, then it doesn't count */
   if (n->arity!=1) {
      default_needle_fn(n,f);
      return;
   }
   
   /* get filter for the child - cases AB and ABC*/
   needle_fn_wrapper(n->child[0],f);
   
   /* Note that for cases which differ only by swapping the first and last
    * children, if we are NOT doing BDDs, then it is easy to compute what
    * the filter looks like just by ORing the bit masks back and forth.
    * For BDDs, however, we would have to also rearrange variable indices,
    * and for the cases that involve changing the middle child of a
    * ternary node we have to do more complicated shifting, so for those,
    * we actually construct a new node and make recursive calls. */

   /* binary:  one other ordering to consider */
   if (n->child[0]->arity==2) {

#ifdef HAVE_BUDDY
      /* BA */
      nprime=new_node();
      nprime->functor=n->child[0]->functor;
      nprime->functor->refs++;
      nprime->arity=2;
      nprime->child[0]=n->child[0]->child[1];
      nprime->child[0]->refs++;
      nprime->child[1]=n->child[0]->child[0];
      nprime->child[1]->refs++;
      
      /* PUT IT IN */
      needle_fn_wrapper(nprime,&fa);
      bf_or(f,f,&fa);
      bdd_delref(fa.decision_diagram);
      free_node(nprime);

#else
      /* easy bit re-arrangement for non-BDD filters */
      f->bits[1]|=f->bits[0]>>32;
      f->bits[0]|=f->bits[1]<<32;
#endif

      /* ternary:  five other orderings to consider */
   } else if (n->child[0]->arity==3) {
      
      /* BCA and CAB change middle child, so must recurse */

      /* BCA */
      nprime=new_node();
      nprime->functor=n->child[0]->functor;
      nprime->functor->refs++;
      nprime->arity=3;
      nprime->child[0]=n->child[0]->child[1];
      nprime->child[0]->refs++;
      nprime->child[1]=n->child[0]->child[2];
      nprime->child[1]->refs++;
      nprime->child[2]=n->child[0]->child[0];
      nprime->child[2]->refs++;
      
      /* PUT IT IN */
      needle_fn_wrapper(nprime,&fa);
      bf_or(f,f,&fa);
#ifdef HAVE_BUDDY
      bdd_delref(fa.decision_diagram);
#endif
      free_node(nprime);

      /* CAB */
      nprime=new_node();
      nprime->functor=n->child[0]->functor;
      nprime->functor->refs++;
      nprime->arity=3;
      nprime->child[0]=n->child[0]->child[2];
      nprime->child[0]->refs++;
      nprime->child[1]=n->child[0]->child[0];
      nprime->child[1]->refs++;
      nprime->child[2]=n->child[0]->child[1];
      nprime->child[2]->refs++;
      
      /* PUT IT IN */
      needle_fn_wrapper(nprime,&fa);
      bf_or(f,f,&fa);
#ifdef HAVE_BUDDY
      bdd_delref(fa.decision_diagram);
#endif
      free_node(nprime);

#ifdef HAVE_BUDDY
      /* CBA */
      nprime=new_node();
      nprime->functor=n->child[0]->functor;
      nprime->functor->refs++;
      nprime->arity=3;
      nprime->child[0]=n->child[0]->child[2];
      nprime->child[0]->refs++;
      nprime->child[1]=n->child[0]->child[1];
      nprime->child[1]->refs++;
      nprime->child[2]=n->child[0]->child[0];
      nprime->child[2]->refs++;
      
      /* PUT IT IN */
      needle_fn_wrapper(nprime,&fa);
      bf_or(f,f,&fa);
      bdd_delref(fa.decision_diagram);
      free_node(nprime);

      /* ACB */
      nprime=new_node();
      nprime->functor=n->child[0]->functor;
      nprime->functor->refs++;
      nprime->arity=3;
      nprime->child[0]=n->child[0]->child[0];
      nprime->child[0]->refs++;
      nprime->child[1]=n->child[0]->child[2];
      nprime->child[1]->refs++;
      nprime->child[2]=n->child[0]->child[1];
      nprime->child[2]->refs++;
      
      /* PUT IT IN */
      needle_fn_wrapper(nprime,&fa);
      bf_or(f,f,&fa);
      bdd_delref(fa.decision_diagram);
      free_node(nprime);

      /* BAC */
      nprime=new_node();
      nprime->functor=n->child[0]->functor;
      nprime->functor->refs++;
      nprime->arity=3;
      nprime->child[0]=n->child[0]->child[1];
      nprime->child[0]->refs++;
      nprime->child[1]=n->child[0]->child[0];
      nprime->child[1]->refs++;
      nprime->child[2]=n->child[0]->child[2];
      nprime->child[2]->refs++;
      
      /* PUT IT IN */
      needle_fn_wrapper(nprime,&fa);
      bf_or(f,f,&fa);
      bdd_delref(fa.decision_diagram);
      free_node(nprime);

#else
      /* easy bit re-arrangement for non-BDD filters */
      f->bits[1]|=f->bits[0]>>32;
      f->bits[0]|=f->bits[1]<<32;
#endif
   }
   
   /* .unord. is a no-op on nullary and unary trees */
}

/* this is like needle_bits_wrapper but forces the default function instead
 * of using the child's possibly customized one */
void equal_needle_fn(NODE *n,BIT_FILTER *f) {
   BIT_FILTER fa,fb;
   uint32_t hval;
   int i;
   
   /* if we are not unary, then it doesn't count */
   if (n->arity!=1) {
      default_needle_fn(n,f);
      return;
   }
   
   /* show what we're about to crunch */
   if (bitvec_debug) {
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      write_cooked_tree(n->child[0],stderr);
      bvd_indent+=3;
   }
   
   /* ignore the child's customized needle function */
   default_needle_fn(n->child[0],f);
   
   /* and if there's a head, then haystack must have that head or no head */
   if (n->child[0]->head!=NULL) {
      
      /* "that head" */
      hval=fnv_hash(n->child[0]->head->length,n->child[0]->head->data,0);
      fa.bits[0]=(uint64_t)bit_combo(32,LAMBDA+1,hval);
      fa.bits[1]=UINT64_C(0);
      fa.lambda=LAMBDA;
      
      /* "no head" */
      hval=fnv_hash(0,"",0);
      fb.bits[0]=(uint64_t)bit_combo(32,LAMBDA+1,hval);
      fb.bits[1]=UINT64_C(0);
      fb.lambda=LAMBDA;
      
      /* do the logic */
#ifdef HAVE_BUDDY
      fa.decision_diagram=bit_bdd((uint32_t)fa.bits[0]);
      fb.decision_diagram=bit_bdd((uint32_t)fb.bits[0]);
      bf_or(f,&fa,bf_and(f,f,&fb));
      bdd_delref(fa.decision_diagram);
      bdd_delref(fb.decision_diagram);
#else
      bf_and(f,f,bf_or(&fa,&fa,&fb));
#endif
   }

   /* show the result of crunching it */
   if (bitvec_debug) {
      bvd_indent-=3;
      for (i=0;i<bvd_indent;i++) fputc(' ',stderr);
      fprintf(stderr,"%016" PRIX64 "%016" PRIX64 " %d/%d\n",
	      f->bits[1],f->bits[0],f->lambda+1,uint64_2_pop(f->bits));
   }
}
