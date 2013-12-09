/*
 * Wide-character-width function summarizer
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

/*
 * This is meta-code, not intended for end-user use.  Its basic function
 * is to read the EastAsianWidth.txt data file of Unicode Standard Annex #11,
 * or other data more or less in that format; build an optimized binary
 * decision diagram implementing the function that determines whether the
 * UTF-8 byte sequence for a character encodes a wide (two-column) character;
 * and then write a fragment of C code to evaluate that function.  This
 * meta-code requires the BuDDy binary decision diagram library, but the
 * code it generates does not.
 */

/*
 * Invocation:
 *   stdin - EastAsianWidth.txt data (or other data in that format).  In
 *      case of more than one line mentioning the same character, earlier
 *      mentions take priority unless ignored as ambiguous
 *   stdout - C source code
 *   argv[1] if specified - W, N, or 0 to treat A (ambiguous) lines as
 *      Wide, Narrow, or zero-width.  Specify A or do not specify for the
 *      default treatment of ignoring them.
 *   argv[2] if specified - UnicodeData.txt file, scanned for control and
 *      combining characters, which will become zero-width.
 */

/*
 * Note that the return value of the generated code on byte sequences that
 * are not the correct UTF-8 encodings of characters specified unambiguously
 * by the input, is not defined!  Such byte sequences will at least return
 * "wide" or "narrow," but which one will be whichever seems to give the most
 * compact binary decision diagram.  Specify dispositions for all characters
 * you care about, and do not run the generated code on things other than
 * valid UTF-8.
 */

#include <stdio.h>
#include <stdlib.h>

#include <bdd.h>

#include "_stdint.h"

/**********************************************************************/

BDD bits_range_bdd(uint32_t low_bits,uint32_t high_bits) {
   BDD rval,tail,newbdd;
   int i;
   uint32_t b;
   
   if (low_bits>0) {
      tail=bddtrue;
      for (i=31,b=1;i>=0;i--,b<<=1) {
	 if (low_bits&b)
	   newbdd=bdd_addref(bdd_and(bdd_ithvar(i),tail));
	 else
	   newbdd=bdd_addref(bdd_or(bdd_ithvar(i),tail));
	 bdd_delref(tail);
	 tail=newbdd;
      }
      rval=tail;
   } else
     rval=bddtrue;
   
   if (high_bits<UINT32_MAX) {
      tail=bddtrue;
      for (i=31,b=1;i>=0;i--,b<<=1) {
	 if (high_bits&b)
	   newbdd=bdd_addref(bdd_or(bdd_nithvar(i),tail));
	 else
	   newbdd=bdd_addref(bdd_and(bdd_nithvar(i),tail));
	 bdd_delref(tail);
	 tail=newbdd;
      }
      rval=bdd_addref(bdd_and(rval,tail));
      bdd_delref(tail);
   }
   
   return rval;
}

BDD code_range_bdd(uint32_t low_code,uint32_t high_code) {
   BDD rval,subrange,srx;
   
   if (low_code<0x80)
     rval=bits_range_bdd((low_code<<24),
			 (high_code>=0x80?
			     0x7FFFFFFF:
			     high_code<<24));
   else
     rval=bddfalse;
   
   if ((low_code<0x800) && (high_code>=0x80)) {
      subrange=bits_range_bdd((low_code<0x80?
			       0xC2800000:
			       ((low_code& 0x3F)<<16)+
			       ((low_code&0x7C0)<<18)+
			       0xC0800000),
			      (high_code>=0x800?
				  0xDFBFFFFF:
				  ((high_code& 0x3F)<<16)+
				  ((high_code&0x7C0)<<18)+
				  0xC080FFFF));

      srx=bdd_addref(bdd_and(subrange,bdd_nithvar(9)));
      bdd_delref(subrange);
      subrange=bdd_addref(bdd_and(srx,bdd_ithvar(8)));
      bdd_delref(srx);
      srx=bdd_addref(bdd_or(rval,subrange));
      bdd_delref(rval);
      bdd_delref(subrange);
      rval=srx;
   }

   if ((low_code<0x10000) && (high_code>=0x800)) {
      subrange=bits_range_bdd((low_code<0x800?
			       0xE0A00000:
			       ((low_code&  0x3F)<<8)+
			       ((low_code& 0xFC0)<<10)+
			       ((low_code&0xF000)<<12)+
			       0xE0808000),
			      (high_code>=0x10000?
				  0xEFBFBFFF:
				  ((high_code&  0x3F)<<8)+
				  ((high_code& 0xFC0)<<10)+
				  ((high_code&0xF000)<<12)+
				  0xE08080FF));

      srx=bdd_addref(bdd_and(subrange,bdd_nithvar(17)));
      bdd_delref(subrange);
      subrange=bdd_addref(bdd_and(srx,bdd_ithvar(16)));
      bdd_delref(srx);
      srx=bdd_addref(bdd_and(subrange,bdd_nithvar(9)));
      bdd_delref(subrange);
      subrange=bdd_addref(bdd_and(srx,bdd_ithvar(8)));
      bdd_delref(srx);
      srx=bdd_addref(bdd_or(rval,subrange));
      bdd_delref(rval);
      bdd_delref(subrange);
      rval=srx;
   }

   if (high_code>=0x10000) {
      subrange=bits_range_bdd((low_code<0x10000?
			       0xF0900000:
			       (low_code&     0x3F)+
			       ((low_code&   0xFC0)<<2)+
			       ((low_code& 0x3F000)<<4)+
			       ((low_code&0x1C0000)<<6)+
			       0xF0808080),
			      (high_code&     0x3F)+
			      ((high_code&   0xFC0)<<2)+
			      ((high_code& 0x3F000)<<4)+
			      ((high_code&0x1C0000)<<6)+
			      0xF0808080);
      
      srx=bdd_addref(bdd_and(subrange,bdd_nithvar(25)));
      bdd_delref(subrange);
      subrange=bdd_addref(bdd_and(srx,bdd_ithvar(24)));
      bdd_delref(srx);
      srx=bdd_addref(bdd_and(subrange,bdd_nithvar(17)));
      bdd_delref(subrange);
      subrange=bdd_addref(bdd_and(srx,bdd_ithvar(16)));
      bdd_delref(srx);
      srx=bdd_addref(bdd_and(subrange,bdd_nithvar(9)));
      bdd_delref(subrange);
      subrange=bdd_addref(bdd_and(srx,bdd_ithvar(8)));
      bdd_delref(srx);
      srx=bdd_addref(bdd_or(rval,subrange));
      bdd_delref(rval);
      bdd_delref(subrange);
      rval=srx;
   }
   
   return rval;
}

/**********************************************************************/

static BDD defined_codes,zero_codes,wide_codes;

void set_range_width(uint32_t low_code,uint32_t high_code,int width) {
   BDD x,y;

   /* sanity check */
   if (low_code>high_code)
     return;

   /* make a BDD for the range */
   x=code_range_bdd(low_code,high_code);
   
   /* if (in range) /\ (already defined) === true, we've been pre-empted */
   y=bdd_and(x,defined_codes); /* note no addref, we don't need it */
   if (y==x) {
      bdd_delref(x);
      return;
   }
   
   /* if (in range) /\ (already defined) !== false, must split */
   if (y!=bddfalse) {
      bdd_delref(x);
      set_range_width(low_code,(low_code+high_code)/2,width);
      set_range_width((low_code+high_code)/2+1,high_code,width);
      return;
   }
   
   y=bdd_addref(bdd_or(x,defined_codes));
   bdd_delref(defined_codes);
   defined_codes=y;
   
   if (width==0) {
      y=bdd_addref(bdd_or(x,zero_codes));
      bdd_delref(zero_codes);
      zero_codes=y;
   } else if (width==2) {
      y=bdd_addref(bdd_or(x,wide_codes));
      bdd_delref(wide_codes);
      wide_codes=y;
   }
   
   bdd_delref(x);
}

/**********************************************************************/

typedef enum _PARSE_STATE {
   psLOW,psHIGH,psWIDTH,psSEMI,psSTOP
} PARSE_STATE;

static BDD reorder_focus;

int reordering_size_callback(void) {
   return reorder_focus==bddfalse?
     bdd_getnodenum():bdd_nodecount(reorder_focus);
}

int main(int argc,char **argv) {
   char ambiguous_treatment='A';
   char linebuff[1024];
   char *parseptr;
   PARSE_STATE ps;
   uint32_t low_code,high_code;
   int width,i,j,vi,vj;
   FILE *unicode_db;
   BDD x,y,child[8];
   BDD *queue;
   int queue_low,queue_high,queue_max;

   puts("/*\n"
	" * GENERATED CODE - DO NOT EDIT!\n"
	" * Edit mkwcw.c, which generates this, or the input to that\n"
	" * program, instead.  Distributions of IDSgrep will nonetheless\n"
	" * usually include a ready-made copy of this file because\n"
	" * compiling and running mkwcw.c requires a library and data\n"
	" * file that, although free, not everyone is expected to have.\n"
	" */\n\n"
	"#include \"_stdint.h\"\n"
       );
   
   if (argc>1)
     ambiguous_treatment=argv[1][0]&~32;
   
   bdd_init(1000000,15625);
   bdd_setcacheratio(64);
   bdd_setvarnum(32);
   bdd_gbc_hook(NULL);
   
   defined_codes=bddfalse;
   zero_codes=bddfalse;
   wide_codes=bddfalse;

   /* yes, unfortunately UnicodeData.txt and EastAsianWidth.txt are just
    * different enough to need separate parsers, at least if the parsers
    * are as stupid as I'd like these ones to be */
   
   if (argc>2) {
      unicode_db=fopen(argv[2],"rt");

      while (1) {
	 fgets(linebuff,sizeof(linebuff),unicode_db);
	 if (feof(unicode_db))
	   break;
	 
	 ps=psLOW;
	 linebuff[sizeof(linebuff)-1]='\0';
	 low_code=0;
	 width=-1;
	 
	 for (parseptr=linebuff;(*parseptr) && (ps!=psSTOP);parseptr++)
	   switch (ps) {
	      
	    case psLOW:
	      if ((*parseptr>='0') && (*parseptr<='9'))
		low_code=(low_code<<4)+(*parseptr-'0');
	      else if ((*parseptr>='a') && (*parseptr<='f'))
		low_code=(low_code<<4)+(*parseptr-'a'+10);
	      else if ((*parseptr>='A') && (*parseptr<='F'))
		low_code=(low_code<<4)+(*parseptr-'A'+10);
	      else if (*parseptr==';')
		 ps=psSEMI;
	      else if ((*parseptr==' ') || (*parseptr=='\t'))
		{ /* skip spaces and tabs */ }
	      else
		ps=psSTOP; /* this catches comment lines */
	      break;
	      
	    case psSEMI:
	      if (*parseptr==';')
		ps=psWIDTH;
	      break;
	      
	    case psWIDTH:
	      if (((parseptr[0]=='M') && ((parseptr[1]=='e') ||
					  (parseptr[1]=='n'))) ||
		  ((parseptr[0]=='C') && (parseptr[1]=='f')))
		width=0;
	      /* FALL THROUGH */
	      
	    default:
	      ps=psSTOP;
	      break;
	   }
	 
	 if (width==0)
	   set_range_width(low_code,low_code,0);
      }

      fclose(unicode_db);
   }
   
   while (1) {
      fgets(linebuff,sizeof(linebuff),stdin);
      if (feof(stdin))
	break;
      
      ps=psLOW;
      linebuff[sizeof(linebuff)-1]='\0';
      low_code=0;
      high_code=0;
      width=-1;

      for (parseptr=linebuff;(*parseptr) && (ps!=psSTOP);parseptr++)
	switch (ps) {

	 case psLOW:
	   if ((*parseptr>='0') && (*parseptr<='9'))
	     low_code=(low_code<<4)+(*parseptr-'0');
	   else if ((*parseptr>='a') && (*parseptr<='f'))
	     low_code=(low_code<<4)+(*parseptr-'a'+10);
	   else if ((*parseptr>='A') && (*parseptr<='F'))
	     low_code=(low_code<<4)+(*parseptr-'A'+10);
	   else if (*parseptr=='.')
	     ps=psHIGH;
	   else if (*parseptr==';') {
	      high_code=low_code;
	      ps=psWIDTH;
	   } else if ((*parseptr==' ') || (*parseptr=='\t'))
		{ /* skip spaces and tabs */ }
	   else
	     ps=psSTOP; /* this catches comment lines */
	   break;

	 case psHIGH:
	   if ((*parseptr>='0') && (*parseptr<='9'))
	     high_code=(high_code<<4)+(*parseptr-'0');
	   else if ((*parseptr>='a') && (*parseptr<='f'))
	     high_code=(high_code<<4)+(*parseptr-'a'+10);
	   else if ((*parseptr>='A') && (*parseptr<='F'))
	     high_code=(high_code<<4)+(*parseptr-'A'+10);
	   else if ((*parseptr=='.') || (*parseptr==' ') || (*parseptr=='\t'))
	     { /* skip spaces, tabs, and dots */ }
	   else if (*parseptr==';')
	     ps=psWIDTH;
	   else
	     ps=psSTOP;
	   break;
	   
	 case psWIDTH:
	   if (*parseptr=='A')
	     *parseptr=ambiguous_treatment;
	   switch (*parseptr) {
	    case 'F': /* full-width treated as wide */
	    case 'W': /* wide */
	      width=2;
	      break;
	      
	    case 'H': /* half-width treated as narrow */
	    case 'N': /* narrow or neutral */
	      width=1;
	      break;
	      
	    case '0': /* zero-width - should only appear in user database */
	      width=0;
	      break;
	      
	    default:
	      /* ignore all others */
	      break;
	   }
	   /* FALL THROUGH */
	   
	 default:
	   ps=psSTOP;
	   break;
	}
      
      if (width>=0)
	set_range_width(low_code,high_code,width);
   }
   
   printf("/* node counts before simplification: %d %d %d */\n",
	  bdd_nodecount(defined_codes),
	  bdd_nodecount(zero_codes),
	  bdd_nodecount(wide_codes));

   x=bdd_addref(bdd_simplify(wide_codes,defined_codes));
   bdd_delref(wide_codes);
   wide_codes=x;

   x=bdd_addref(bdd_apply(defined_codes,wide_codes,bddop_diff));
   bdd_delref(defined_codes);
   defined_codes=x;
   
   x=bdd_addref(bdd_simplify(zero_codes,defined_codes));
   bdd_delref(zero_codes);
   zero_codes=x;
   
   printf("/* node counts after simplification: %d %d %d */\n\n",
	  bdd_nodecount(defined_codes),
	  bdd_nodecount(zero_codes),
	  bdd_nodecount(wide_codes));

   bdd_varblockall();
   bdd_intaddvarblock(0,7,0);
   bdd_intaddvarblock(8,15,0);
   bdd_intaddvarblock(16,23,0);
   bdd_intaddvarblock(24,31,0);
   bdd_intaddvarblock(0,31,1);

   bdd_reorder_probe(&reordering_size_callback);
   
   puts("typedef struct _WIDTH_BBD_ENT {\n"
	"  int16_t child[8];\n"
	"  char byte,shift;\n"
	"} WIDTH_BDD_ENT;\n\n"
	"static WIDTH_BDD_ENT width_bdd[]={");

   queue=(BDD *)malloc(sizeof(BDD)*1000);
   queue_max=1000;
   queue_low=2;
   queue_high=4;
   queue[0]=bddfalse;
   queue[1]=bddtrue;
   queue[2]=wide_codes;
   queue[3]=zero_codes;
   
   while (queue_low<queue_high) {
      if (queue_high+8>queue_max) {
	 queue_max/=3;
	 queue_max*=4;
	 queue=(BDD *)realloc(queue,sizeof(BDD)*queue_max);
      }
      
      reorder_focus=queue[queue_low];
      bdd_reorder(BDD_REORDER_WIN2ITE);
      
      vj=bdd_var(queue[queue_low]);
      vi=(vj/8)*8;
      vj=((vj-vi+1)/3)*3-1;
      if (vj<0) vj=0;
      
      x=bdd_addref(bdd_restrict(queue[queue_low],bdd_nithvar(vi+vj)));
      y=bdd_addref(bdd_restrict(x,bdd_nithvar(vi+vj+1)));
      child[0]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj+2)));
      child[1]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj+2)));
      bdd_delref(y);
      y=bdd_addref(bdd_restrict(x,bdd_ithvar(vi+vj+1)));
      child[2]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj+2)));
      child[3]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj+2)));
      bdd_delref(y);
      bdd_delref(x);
      x=bdd_addref(bdd_restrict(queue[queue_low],bdd_ithvar(vi+vj)));
      y=bdd_addref(bdd_restrict(x,bdd_nithvar(vi+vj+1)));
      child[4]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj+2)));
      child[5]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj+2)));
      bdd_delref(y);
      y=bdd_addref(bdd_restrict(x,bdd_ithvar(vi+vj+1)));
      child[6]=bdd_addref(bdd_restrict(y,bdd_nithvar(vi+vj+2)));
      child[7]=bdd_addref(bdd_restrict(y,bdd_ithvar(vi+vj+2)));
      bdd_delref(y);
      bdd_delref(x);
      
      fputs("  {{",stdout);
      for (i=0;i<8;i++) {
	 queue[queue_high]=child[i];
	 for (j=0;queue[j]!=child[i];j++);
	 if (j==queue_high)
	   queue_high++;
	 else
	   bdd_delref(child[i]);
	 printf("%d",j-2);
	 if (i<7) putchar(',');
      }
      printf("},%d,%d},\n",vi/8,5-vj);
      
      queue_low++;
   }

   puts("};\n\n"
"int idsgrep_utf8cw(char *);\n"
"\n"
"#define WBS width_bdd[search]\n"
"\n"
"int idsgrep_utf8cw(char *cp) {\n"
"   int search;\n"
"\n"
"   for (search=0;search>=0;)\n"
"     search=WBS.child[(cp[WBS.byte]>>WBS.shift)&7];\n"
"   if (search==-1)\n"
"     return 2;\n"
"   for (search=1;search>=0;)\n"
"     search=WBS.child[(cp[WBS.byte]>>WBS.shift)&7];\n"
"   return ((-1)-search);\n"
"}\n");
   
   bdd_done();

   exit(0);
}

