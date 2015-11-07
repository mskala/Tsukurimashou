/*
 * Bitwise-cascade code generator
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

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <bdd.h>

#include "icemap.h"

/**********************************************************************/

int prefer_cascade(CONTEXT *c) {
   int i;
   NODE *k;
   
   for (i=0;i<c->am.num_buckets;i++)
     for (k=c->am.arrows[i];k;k=k->next)
       if (k->nodes->type!=nt_int)
	 return 0;
   if ((c->am.first_key!=NULL) && (c->am.last_key!=NULL)) {
      if ((c->am.first_key->type==nt_int) &&
	  (c->am.last_key->type==nt_int)) {
	 if ((c->am.last_key->x-c->am.first_key->x)>256)
	   return 2;
	 else
	   return 1;
      }
      if ((c->am.first_key->type==nt_string) &&
	  (c->am.last_key->type==nt_string)) {
	 if ((strlen(c->am.first_key->cp)<8) &&
	     (strlen(c->am.last_key->cp)<8))
	   return 2;
	 else
	   return 1;
      }
   }
   
   return 0;
}

static BDD *reorder_focus;
static int num_bits_out;

int reordering_size_callback(void) {
   int i,j=0;

   for (i=0;i<num_bits_out;i++) {
      if (reorder_focus[i]==bddfalse)
	j+=bdd_getnodenum();
      else
	j+=bdd_nodecount(reorder_focus[i]);
   }
   return j;
}

typedef struct _QUEUE_ENTRY {
   BDD *results;
   int child[8];
   int byte,shift;
   int reorder_gen;
} QUEUE_ENTRY;

void gen_cascade(CONTEXT *c) {
   NODE *cf,*hf;
   int i,j,num_bits_in,kas,min_out,max_out;
   NODE *k,*v;
   CONTEXT *ctx;
   char *ots,*maybe_space,*es;
   BDD keys_bdd,*result_bdds,x,y,z,not_x;
   QUEUE_ENTRY *queue;
   int queue_max,queue_low,queue_high,vi,vj;
   BDD *child[8];
   int reorder_serial=0;
   
   /* check:  can we proceed? */
   if ((c->am.first_key==NULL) || (c->am.last_key==NULL) ||
       (c->am.first_key->type!=c->am.last_key->type)) {
      c->generator=NULL;
      return;
   }
   min_out=INT_MAX;
   max_out=INT_MIN;
   for (i=0;i<c->am.num_buckets;i++)
     for (k=c->am.arrows[i];k;k=k->next) {
	if (k->nodes->type!=nt_int)
	  return;
	if (k->nodes->x>max_out)
	  max_out=k->nodes->x;
	if (k->nodes->x<min_out)
	  min_out=k->nodes->x;
     }
   c->generator=gen_cascade;
   
   /* report status */
   if (!quiet)
     printf("Generating cascade map %s with %d arrows.\n",
	    c->id,c->am.num_arrows);

   /* figure out how many input bits we need */
   if (c->am.first_key->type==nt_string) {
      kas=1; /* keys are strings */
      num_bits_in=0;
      for (i=0;i<c->am.num_buckets;i++)
	for (k=c->am.arrows[i];k;k=k->next) {
	   j=strlen(k->cp);
	   if (j>num_bits_in)
	     num_bits_in=j;
	}
      num_bits_in=num_bits_in*8;
      
   } else {
      kas=0; /* !keys are strings */
      num_bits_in=1;
      while ((1<<num_bits_in)<=c->am.first_key->x)
	num_bits_in++;
      while ((1<<num_bits_in)<=~c->am.first_key->x)
	num_bits_in++;
      while ((1<<num_bits_in)<=c->am.last_key->x)
	num_bits_in++;
      while ((1<<num_bits_in)<=~c->am.last_key->x)
	num_bits_in++;
   }
   
   /* figure out how many output bits we are generating */
   num_bits_out=0;
   while ((1<<num_bits_out)<=max_out-min_out)
     num_bits_out++;
   
   /* initialize the BDD library for very large problems */
   bdd_init(10000000,156250);
   bdd_setcacheratio(64);
   bdd_setmaxincrease(500000);
   bdd_setvarnum(num_bits_in);
   bdd_gbc_hook(NULL);
   if (bdd_error_segfault)
     bdd_error_hook((bddinthandler)1);

   /* initialize the BDDs that represent the table */
   keys_bdd=bddfalse;
   result_bdds=(BDD *)malloc(num_bits_out*sizeof(BDD));
   for (i=0;i<num_bits_out;i++)
     result_bdds[i]=bddfalse;
   
   /* space for children */
   for (i=0;i<8;i++)
     child[i]=(BDD *)malloc(num_bits_out*sizeof(BDD));
   
   /* loop through all arrows in the map */
   for (i=0;i<c->am.num_buckets;i++)
      for (k=c->am.arrows[i];k;k=k->next) {
	 
	 /* create a BDD that matches the key */
	 x=bddtrue;
	 if (kas) {
	    for (j=0;j<num_bits_in;j++) {
	       if (k->cp[j>>3]=='\0')
		 break;
	       y=(k->cp[j>>3]&(1<<(j&7)))?bdd_ithvar(j):bdd_nithvar(j);
	       z=bdd_addref(bdd_and(x,y));
	       bdd_delref(x);
	       x=z;
	    }
	 } else {
	    for (j=0;j<num_bits_in;j++) {
	       y=(k->x&(1<<j))?bdd_ithvar(j):bdd_nithvar(j);
	       z=bdd_addref(bdd_and(x,y));
	       bdd_delref(x);
	       x=z;
	    }
	 }

	 /* record this k-v pair in the table BDDs */
	 y=bdd_addref(bdd_or(x,keys_bdd));
	 bdd_delref(keys_bdd);
	 keys_bdd=y;
	 for (j=0;j<num_bits_out;j++)
	   if ((k->nodes->x-min_out)&(1<<j)) {
	      y=bdd_addref(bdd_or(x,result_bdds[j]));
	      bdd_delref(result_bdds[j]);
	      result_bdds[j]=y;
	   }

	 bdd_delref(x);
      }

   /* simplify the BDDs */
   for (i=0;i<num_bits_out;i++) {
      if (!quiet)
	printf("Simplifying BDD for bit %d from %d ",
	       i,bdd_nodecount(result_bdds[i]));
      x=bdd_addref(bdd_simplify(result_bdds[i],keys_bdd));
      bdd_delref(result_bdds[i]);
      result_bdds[i]=x;
      if (!quiet)
	printf("to %d nodes\n",bdd_nodecount(result_bdds[i]));
   }

   /* set up blocks for variable reordering */
   bdd_varblockall();
   if (kas) {
      for (i=0;i<num_bits_in;i+=8) {
	 bdd_intaddvarblock(i,i+2,0);
	 bdd_intaddvarblock(i+3,i+5,0);
	 bdd_intaddvarblock(i+6,i+7,0);
	 bdd_intaddvarblock(i,i+7,0);
      }
      bdd_intaddvarblock(0,num_bits_in-1,1);
   } else {
     for (i=0;i<num_bits_in;i+=3)
	bdd_intaddvarblock(i,(
			      i+2<num_bits_in)?(i+2):(num_bits_in-1),0);
   }

   /* set callback for reordering */
   bdd_reorder_probe(&reordering_size_callback);

   /* initialize the queue of table entries */
   queue=(QUEUE_ENTRY *)malloc(1000*sizeof(QUEUE_ENTRY));
   queue_max=1000;
   queue_low=0;
   queue_high=1;
   queue[0].results=result_bdds;
   queue[0].reorder_gen=-1;

   /* process the queue */
   while (queue_low<queue_high) {
      
      /* show progress */
      if (!quiet) {
	 printf("\rCompressing map: %d..%d",queue_low,queue_high);
	 fflush(stdout);
      }
      
      /* make sure there is enough room to expand */
      if (queue_high+8>queue_max) {
	 queue_max/=3;
	 queue_max*=4;
	 queue=(QUEUE_ENTRY *)realloc(queue,queue_max*sizeof(QUEUE_ENTRY));
      }

      /* optimize for the current queue entry */
      if (queue[queue_low].reorder_gen!=reorder_serial) {
	 reorder_focus=queue[queue_low].results;
	 bdd_reorder(BDD_REORDER_WIN2ITE);
	 if (bdd_reorder_gain()!=0)
	   reorder_serial++;
      }

      /* find the variable on which we want to branch */
      vj=num_bits_in-1;
      for (i=0;i<num_bits_out;i++) {
	 if ((queue[queue_low].results[i]!=bddfalse) &&
	     (queue[queue_low].results[i]!=bddtrue)) {
	    j=bdd_var2level(bdd_var(queue[queue_low].results[i]));
	    if (j<vj)
	      vj=j;
	 }
      }
      vj=bdd_level2var(vj);
      if (kas) {
	 vi=(vj/8)*8;
	 vj=((vj-vi+1)/3)*3-1;
      } else {
	 vi=0;
	 if (vj>num_bits_in-3)
	   vj=num_bits_in-3;
      }
      if (vj<0) vj=0;
      queue[queue_low].byte=vi/8;
      queue[queue_low].shift=vj;

      /* compute all the BDDs for the children */
      for (i=0;i<num_bits_out;i++) {
	 x=bdd_addref(bdd_restrict(queue[queue_low].results[i],
				   bdd_nithvar(vi+vj+2)));
	 y=bdd_addref(bdd_restrict(x,bdd_nithvar(vi+vj+1)));
	 child[0][i]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj)));
	 child[1][i]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj)));
	 bdd_delref(y);
	 y=bdd_addref(bdd_restrict(x,bdd_ithvar(vi+vj+1)));
	 child[2][i]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj)));
	 child[3][i]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj)));
	 bdd_delref(y);
	 bdd_delref(x);
	 x=bdd_addref(bdd_restrict(queue[queue_low].results[i],
				   bdd_ithvar(vi+vj+2)));
	 y=bdd_addref(bdd_restrict(x,bdd_nithvar(vi+vj+1)));
	 child[4][i]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj)));
	 child[5][i]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj)));
	 bdd_delref(y);
	 y=bdd_addref(bdd_restrict(x,bdd_ithvar(vi+vj+1)));
	 child[6][i]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj)));
	 child[7][i]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj)));
	 bdd_delref(y);
	 bdd_delref(x);
      }
      
      /* loop over children */
      for (i=0;i<8;i++) {
 
	 /* detect case where a child gives a constant result */
	 vi=0;
	 for (j=0;j<num_bits_out;j++) {
	    if (child[i][j]==bddtrue)
	      vi|=(1<<j);
	    else if (child[i][j]!=bddfalse)
	      break;
	 }
	 if (j>=num_bits_out) {
	    queue[queue_low].child[i]=-1-vi;
	    continue;
	 }

	 /* prepare a sentinel queue entry (guaranteed to match) */
	 queue[queue_high].results=child[i];
	 
	 /* search for a matching queue entry */
	 for (j=0;
	      memcmp(queue[j].results,child[i],num_bits_out*sizeof(BDD));
	      j++);
	 
	 /* save result; is it the sentinel? */
	 queue[queue_low].child[i]=j;
	 if (j==queue_high) {
	    /* yes - adopt it into queue, and now we need another buffer */
	    queue[queue_high].reorder_gen=reorder_serial;
	    queue_high++;
	    child[i]=(BDD *)malloc(num_bits_out*sizeof(BDD));
	    
	 } else /* no - something earlier, so delete the refs */
	   for (j=0;j<num_bits_out;j++)
	     bdd_delref(child[i][j]);
      }

      /* proceed to next queue entry */
      queue_low++;
   }

   /* now ready to generate code */
   if (!quiet)
     puts("\nGenerating code.");
   cf=open_output_file(c->c_file);
   hf=open_output_file(c->h_file);
   if (c->value_c_type==NULL)
     ots="int";
   else
     ots=c->value_c_type;
   maybe_space=(ots[strlen(ots)-1]=='*')?"":" ";

   /* header file - just a comment and extern function declaration */
   of_write(hf,"/* bit-cascade lookup on %s for map \"%s\" */\n\n",
	    kas?"strings":"ints",c->id);
   if (kas)
     of_write(hf,"extern %s%s%s_lookup(char *);\n",
	      ots,maybe_space,c->id);
   else
     of_write(hf,"extern %s%s%s_lookup(int);\n",
	      ots,maybe_space,c->id);
   of_write(hf,"#define %s_count (%d)\n",c->id,c->am.num_arrows);

   /* choose a size for table entries */
   es="int8_t";
   if ((num_bits_out>7) || (queue_low>127))
     es="int16_t";
   if ((num_bits_out>15) || (queue_low>65535))
     es="int32_t";
   if ((num_bits_out>31) || (queue_low>INT32_MAX))
     es="int64_t";

   /* print header for table */
   if (kas)
     of_write(cf,
	      "/* bit-cascade lookup on strings for map \"%s\" */\n\n"
	      "struct %s_entry {\n"
	      "  %s child[8];\n"
	      "  %s byte;\n"
	      "  int8_t shift;\n"
	      "} %s_table[]={\n",
	      c->id,c->id,es,
	      num_bits_in<=1024?"int8_t":
	      (num_bits_in<=262144?"int16_t":"int32_t"),
	      c->id);
   else
     of_write(cf,
	      "/* bit-cascade lookup on ints for map \"%s\" */\n\n"
	      "struct %s_entry {\n"
	      "  %s child[8];\n"
	      "  %s bit;\n"
	      "} %s_table[]={\n",
	      c->id,c->id,es,
	      num_bits_in<128?"int8_t":
	      (num_bits_in<32768?"int16_t":"int32_t"),
	      c->id);
   of_indent(cf,2);
   
   /* print table entries (and dispose of BDDs) */
   for (i=0;i<queue_low;i++) {
      of_write(cf,"{{");
      of_indent(cf,2);
      for (j=0;j<8;j++) {
	 of_write(cf,j<7?"%d,":"%d},",queue[i].child[j]);
      }
      for (j=0;j<num_bits_out;j++)
	bdd_delref(queue[i].results[j]);
      free(queue[i].results);
      if (kas) {
	 of_write(cf,"%d,",queue[i].byte);
	 of_write(cf,"%d},\n",queue[i].shift);
      } else
	 of_write(cf,"%d},\n",queue[i].shift);
      of_unindent(cf,2);
   }

   of_unindent(cf,2);
   if (kas)
     of_write(cf,
"};\n"
"\n"
"#define MAP %s_table[search]\n"
"%s%s%s_lookup(char *key) {\n"
"   int search;\n"
"\n"
"   for (search=0;search>=0;)\n"
"     search=MAP.child[(key[MAP.byte]>>MAP.shift)&7];\n"
"   return ((%d)-search);\n"
"}\n"
"#undef MAP\n"
"\n",
	      c->id,ots,maybe_space,c->id,
	      min_out-1);
   else
     of_write(cf,
"};\n"
"\n"
"#define MAP %s_table[search]\n"
"%s%s%s_lookup(int key) {\n"
"   int search;\n"
"\n"
"   for (search=0;search>=0;)\n"
"     search=MAP.child[(key>>MAP.bit)&7];\n"
"   return ((%d)-search);\n"
"}\n"
"#undef MAP\n"
"\n",
	      c->id,ots,maybe_space,c->id,
	      min_out-1);
   
   /* free data structures */
   for (i=0;i<8;i++) free(child[i]);
   bdd_done();

   /* record fact that we have written code */
   for (ctx=context_stack->parent;ctx;ctx=ctx->parent)
     ctx->leaves++;
}

/**********************************************************************/

int prefer_wide_cascade(CONTEXT *c) {
   int i;
   NODE *k;
   
   for (i=0;i<c->am.num_buckets;i++)
     for (k=c->am.arrows[i];k;k=k->next)
       if (k->nodes->type!=nt_int)
	 return 0;
   if ((c->am.first_key!=NULL) && (c->am.last_key!=NULL)) {
      if ((c->am.first_key->type==nt_int) &&
	  (c->am.last_key->type==nt_int)) {
	 if (c->am.num_arrows>4096)
	   return 2;
	 else
	   return 1;
      }
   }
   
   return 0;
}

/* we reuse reorder_focus, num_bits_out, and reordering_size_callback
 * from the vanilla cascade above */

typedef struct _WC_QUEUE_ENTRY {
   BDD *results;
   int child[64];
   int byte,shift;
   int reorder_gen;
} WC_QUEUE_ENTRY;

void gen_wide_cascade(CONTEXT *c) {
   NODE *cf,*hf;
   int i,j,num_bits_in,kas,min_out,max_out;
   NODE *k,*v;
   CONTEXT *ctx;
   char *ots,*maybe_space,*es;
   BDD keys_bdd,*result_bdds,x,y,z,not_x;
   QUEUE_ENTRY *queue;
   int queue_max,queue_low,queue_high,vi,vj;
   BDD *child[8];
   int reorder_serial=0;
   
   /* check:  can we proceed? */
   if ((c->am.first_key==NULL) || (c->am.last_key==NULL) ||
       (c->am.first_key->type!=c->am.last_key->type)) {
      c->generator=NULL;
      return;
   }
   min_out=INT_MAX;
   max_out=INT_MIN;
   for (i=0;i<c->am.num_buckets;i++)
     for (k=c->am.arrows[i];k;k=k->next) {
	if (k->nodes->type!=nt_int)
	  return;
	if (k->nodes->x>max_out)
	  max_out=k->nodes->x;
	if (k->nodes->x<min_out)
	  min_out=k->nodes->x;
     }
   c->generator=gen_cascade;

   /* figure out how many input bits we need */
   if (c->am.first_key->type==nt_string) {
      kas=1; /* keys are strings */
      num_bits_in=0;
      for (i=0;i<c->am.num_buckets;i++)
	for (k=c->am.arrows[i];k;k=k->next) {
	   j=strlen(k->cp);
	   if (j>num_bits_in)
	     num_bits_in=j;
	}
      num_bits_in=num_bits_in*8;
      
   } else {
      kas=0; /* !keys are strings */
      num_bits_in=1;
      while ((1<<num_bits_in)<=c->am.first_key->x)
	num_bits_in++;
      while ((1<<num_bits_in)<=~c->am.first_key->x)
	num_bits_in++;
      while ((1<<num_bits_in)<=c->am.last_key->x)
	num_bits_in++;
      while ((1<<num_bits_in)<=~c->am.last_key->x)
	num_bits_in++;
   }
   
   /* report status */
   if (!quiet)
     printf("Generating wide cascade map %s with %d arrows.\n",
	    c->id,c->am.num_arrows);

   /* figure out how many output bits we are generating */
   num_bits_out=0;
   while ((1<<num_bits_out)<=max_out-min_out)
     num_bits_out++;
   
   /* initialize the BDD library for very large problems */
   bdd_init(10000000,156250);
   bdd_setcacheratio(64);
   bdd_setmaxincrease(500000);
   bdd_setvarnum(num_bits_in);
   bdd_gbc_hook(NULL);
   if (bdd_error_segfault)
     bdd_error_hook((bddinthandler)1);
   
   /* initialize the BDDs that represent the table */
   keys_bdd=bddfalse;
   result_bdds=(BDD *)malloc(num_bits_out*sizeof(BDD));
   for (i=0;i<num_bits_out;i++)
     result_bdds[i]=bddfalse;
   
   /* space for children */
   for (i=0;i<8;i++)
     child[i]=(BDD *)malloc(num_bits_out*sizeof(BDD));
   
   /* loop through all arrows in the map */
   for (i=0;i<c->am.num_buckets;i++)
      for (k=c->am.arrows[i];k;k=k->next) {
	 
	 /* create a BDD that matches the key */
	 x=bddtrue;
	 if (kas) {
	    for (j=0;j<num_bits_in;j++) {
	       if (k->cp[j>>3]=='\0')
		 break;
	       y=(k->cp[j>>3]&(1<<(j&7)))?bdd_ithvar(j):bdd_nithvar(j);
	       z=bdd_addref(bdd_and(x,y));
	       bdd_delref(x);
	       x=z;
	    }
	 } else {
	    for (j=0;j<num_bits_in;j++) {
	       y=(k->x&(1<<j))?bdd_ithvar(j):bdd_nithvar(j);
	       z=bdd_addref(bdd_and(x,y));
	       bdd_delref(x);
	       x=z;
	    }
	 }

	 /* record this k-v pair in the table BDDs */
	 y=bdd_addref(bdd_or(x,keys_bdd));
	 bdd_delref(keys_bdd);
	 keys_bdd=y;
	 for (j=0;j<num_bits_out;j++)
	   if ((k->nodes->x-min_out)&(1<<j)) {
	      y=bdd_addref(bdd_or(x,result_bdds[j]));
	      bdd_delref(result_bdds[j]);
	      result_bdds[j]=y;
	   }

	 bdd_delref(x);
      }

   /* simplify the BDDs */
   for (i=0;i<num_bits_out;i++) {
      if (!quiet)
	printf("Simplifying BDD for bit %d from %d ",
	       i,bdd_nodecount(result_bdds[i]));
      x=bdd_addref(bdd_simplify(result_bdds[i],keys_bdd));
      bdd_delref(result_bdds[i]);
      result_bdds[i]=x;
      if (!quiet)
	printf("to %d nodes\n",bdd_nodecount(result_bdds[i]));
   }

   /* set up blocks for variable reordering */
   bdd_varblockall();
   if (kas) {
      for (i=0;i<num_bits_in;i+=8) {
	 bdd_intaddvarblock(i,i+2,0);
	 bdd_intaddvarblock(i+3,i+5,0);
	 bdd_intaddvarblock(i+6,i+7,0);
	 bdd_intaddvarblock(i,i+7,0);
      }
      bdd_intaddvarblock(0,num_bits_in-1,1);
   } else {
     for (i=0;i<num_bits_in;i+=3)
	bdd_intaddvarblock(i,(i+2<num_bits_in)?(i+2):(num_bits_in-1),0);
   }

   /* set callback for reordering */
   bdd_reorder_probe(&reordering_size_callback);

   /* initialize the queue of table entries */
   queue=(QUEUE_ENTRY *)malloc(1000*sizeof(QUEUE_ENTRY));
   queue_max=1000;
   queue_low=0;
   queue_high=1;
   queue[0].results=result_bdds;
   queue[0].reorder_gen=-1;

   /* process the queue */
   while (queue_low<queue_high) {
      
      /* make sure there is enough room to expand */
      if (queue_high+8>queue_max) {
	 queue_max/=3;
	 queue_max*=4;
	 queue=(QUEUE_ENTRY *)realloc(queue,queue_max*sizeof(QUEUE_ENTRY));
      }

      /* optimize for the current queue entry */
      if (queue[queue_low].reorder_gen!=reorder_serial) {
	 reorder_focus=queue[queue_low].results;
	 bdd_reorder(BDD_REORDER_WIN2ITE);
	 if (bdd_reorder_gain()!=0)
	   reorder_serial++;
      }
      

      /* find the variable on which we want to branch */
      vj=num_bits_in-1;
      for (i=0;i<num_bits_out;i++) {
	 if ((queue[queue_low].results[i]!=bddfalse) &&
	     (queue[queue_low].results[i]!=bddtrue)) {
	    j=bdd_var2level(bdd_var(queue[queue_low].results[i]));
	    if (j<vj)
	      vj=j;
	 }
      }
      vj=bdd_level2var(vj);
      if (kas) {
	 vi=(vj/8)*8;
	 vj=((vj-vi+1)/3)*3-1;
      } else {
	 vi=0;
	 if (vj>num_bits_in-3)
	   vj=num_bits_in-3;
      }
      if (vj<0) vj=0;
      queue[queue_low].byte=vi/8;
      queue[queue_low].shift=vj;

      /* compute all the BDDs for the children */
      for (i=0;i<num_bits_out;i++) {
	 x=bdd_addref(bdd_restrict(queue[queue_low].results[i],
				   bdd_nithvar(vi+vj+2)));
	 y=bdd_addref(bdd_restrict(x,bdd_nithvar(vi+vj+1)));
	 child[0][i]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj)));
	 child[1][i]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj)));
	 bdd_delref(y);
	 y=bdd_addref(bdd_restrict(x,bdd_ithvar(vi+vj+1)));
	 child[2][i]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj)));
	 child[3][i]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj)));
	 bdd_delref(y);
	 bdd_delref(x);
	 x=bdd_addref(bdd_restrict(queue[queue_low].results[i],
				   bdd_ithvar(vi+vj+2)));
	 y=bdd_addref(bdd_restrict(x,bdd_nithvar(vi+vj+1)));
	 child[4][i]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj)));
	 child[5][i]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj)));
	 bdd_delref(y);
	 y=bdd_addref(bdd_restrict(x,bdd_ithvar(vi+vj+1)));
	 child[6][i]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj)));
	 child[7][i]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj)));
	 bdd_delref(y);
	 bdd_delref(x);
      }
      
      /* loop over children */
      for (i=0;i<8;i++) {
	 
	 /* detect case where a child gives a constant result */
	 vi=0;
	 for (j=0;j<num_bits_out;j++) {
	    if (child[i][j]==bddtrue)
	      vi|=(1<<j);
	    else if (child[i][j]!=bddfalse)
	      break;
	 }
	 if (j>=num_bits_out) {
	    queue[queue_low].child[i]=-1-vi;
	    continue;
	 }

	 /* prepare a sentinel queue entry (guaranteed to match) */
	 queue[queue_high].results=child[i];
	 
	 /* search for a matching queue entry */
	 for (j=0;
	      memcmp(queue[j].results,child[i],num_bits_out*sizeof(BDD));
	      j++);
	 
	 /* save result; is it the sentinel? */
	 queue[queue_low].child[i]=j;
	 if (j==queue_high) {
	    /* yes - adopt it into queue, and now we need another buffer */
	    queue[queue_high].reorder_gen=reorder_serial;
	    queue_high++;
	    child[i]=(BDD *)malloc(num_bits_out*sizeof(BDD));
	    
	 } else /* no - something earlier, so delete the refs */
	   for (j=0;j<num_bits_out;j++)
	     bdd_delref(child[i][j]);
      }

      /* proceed to next queue entry */
      queue_low++;
   }

   /* now ready to generate code */
   cf=open_output_file(c->c_file);
   hf=open_output_file(c->h_file);
   if (c->value_c_type==NULL)
     ots="int";
   else
     ots=c->value_c_type;
   maybe_space=(ots[strlen(ots)-1]=='*')?"":" ";

   /* header file - just a comment and extern function declaration */
   of_write(hf,"/* bit-cascade lookup on %s for map \"%s\" */\n\n",
	    kas?"strings":"ints",c->id);
   if (kas)
     of_write(hf,"extern %s%s%s_lookup(char *);\n",
	      ots,maybe_space,c->id);
   else
     of_write(hf,"extern %s%s%s_lookup(int);\n",
	      ots,maybe_space,c->id);
   of_write(hf,"#define %s_count (%d)\n",c->id,c->am.num_arrows);

   /* choose a size for table entries */
   es="int8_t";
   if ((num_bits_out>7) || (queue_low>127))
     es="int16_t";
   if ((num_bits_out>15) || (queue_low>65535))
     es="int32_t";
   if ((num_bits_out>31) || (queue_low>INT32_MAX))
     es="int64_t";

   /* print header for table */
   if (kas)
     of_write(cf,
	      "/* bit-cascade lookup on strings for map \"%s\" */\n\n"
	      "struct %s_entry {\n"
	      "  %s child[8];\n"
	      "  %s byte;\n"
	      "  int8_t shift;\n"
	      "} %s_table[]={\n",
	      c->id,c->id,es,
	      num_bits_in<=1024?"int8_t":
	      (num_bits_in<=262144?"int16_t":"int32_t"),
	      c->id);
   else
     of_write(cf,
	      "/* bit-cascade lookup on ints for map \"%s\" */\n\n"
	      "struct %s_entry {\n"
	      "  %s child[8];\n"
	      "  %s bit;\n"
	      "} %s_table[]={\n",
	      c->id,c->id,es,
	      num_bits_in<128?"int8_t":
	      (num_bits_in<32768?"int16_t":"int32_t"),
	      c->id);
   of_indent(cf,2);
   
   /* print table entries (and dispose of BDDs) */
   for (i=0;i<queue_low;i++) {
      of_write(cf,"{{");
      of_indent(cf,2);
      for (j=0;j<8;j++) {
	 of_write(cf,j<7?"%d,":"%d},",queue[i].child[j]);
      }
      for (j=0;j<num_bits_out;j++)
	bdd_delref(queue[i].results[j]);
      free(queue[i].results);
      if (kas) {
	 of_write(cf,"%d,",queue[i].byte);
	 of_write(cf,"%d},\n",queue[i].shift);
      } else
	 of_write(cf,"%d},\n",queue[i].shift);
      of_unindent(cf,2);
   }

   of_unindent(cf,2);
   if (kas)
     of_write(cf,
"};\n"
"\n"
"#define MAP %s_table[search]\n"
"%s%s%s_lookup(char *key) {\n"
"   int search;\n"
"\n"
"   for (search=0;search>=0;)\n"
"     search=MAP.child[(key[MAP.byte]>>MAP.shift)&7];\n"
"   return ((%d)-search);\n"
"}\n"
"#undef MAP\n"
"\n",
	      c->id,ots,maybe_space,c->id,
	      min_out-1);
   else
     of_write(cf,
"};\n"
"\n"
"#define MAP %s_table[search]\n"
"%s%s%s_lookup(int key) {\n"
"   int search;\n"
"\n"
"   for (search=0;search>=0;)\n"
"     search=MAP.child[(key>>MAP.bit)&7];\n"
"   return ((%d)-search);\n"
"}\n"
"#undef MAP\n"
"\n",
	      c->id,ots,maybe_space,c->id,
	      min_out-1);
   
   /* FIXME free a bunch of storage */
   bdd_done();

   for (ctx=context_stack->parent;ctx;ctx=ctx->parent)
     ctx->leaves++;
}
