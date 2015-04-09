/* $Id: dumppfa.c 3901 2015-04-09 11:48:49Z mskala $ */
/* Copyright (C) 2000-2012 by George Williams */
/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * The name of the author may not be used to endorse or promote products
 * derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#include "fontanvil.h"
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <ustring.h>
#include <utype.h>
#include <unistd.h>
#include <locale.h>
#if !defined(__MINGW32__)
#   include <pwd.h>
#endif
#include <stdarg.h>
#include <time.h>
#include "psfont.h"
#include "splinefont.h"
#include <gdraw.h>		/* For image defn */
#include "print.h"		/* For makePatName */

#ifdef __CygWin
#   include <sys/types.h>
#   include <sys/stat.h>
#   include <unistd.h>
#endif

extern int autohint_before_generate;

char *xuid=NULL;

#define c1      52845
#define c2      22719

/* Encode a string in adobe's format. choose a different set of initial random*/
/*  bytes every time. (the expected value of leniv is 4. we have some support */
/*  for values bigger than 5 but not as much as for values <=4) */
static void encodestrout(AFILE *f,unsigned char *value,int len,int leniv) {
   uint16_t r=4330;
   uint8_t plain, cypher;
   static uint8_t randombytes[10] =
      {0xaa,0x55,0x3e,0x4d,0x89,0x98,'a','4',0,0xff};

   randombytes[0]+=3;
   randombytes[1]+=5;
   randombytes[2]+=7;
   randombytes[3]+=11;
   randombytes[4]+=13;

   while (leniv>0) {
      plain=randombytes[leniv-- % 10];
      cypher=(plain ^ (r >> 8));
      r=(cypher + r) * c1 + c2;
      afwrite(&cypher,1,1,f);
   }
   while (len-->0) {
      plain=*value++;
      cypher=(plain ^ (r >> 8));
      r=(cypher + r) * c1 + c2;
      afwrite(&cypher,1,1,f);
   }
}

static void dumpcarefully(AFILE *f,const char *buf) {
   unsigned char ch[4];

   while ((ch[0]=*buf++)!='\0') {
      if (ch[0]<' ' || ch[0]>=0x7f || ch[0]=='\\' ||
	  ch[0]=='(' || ch[0]==')') {
	 ch[1]=(ch[0]>>6)+'0';
	 ch[2]=((ch[0]>>3)&7)+'0';
	 ch[3]=(ch[0]&7)+'0';
	 ch[0]='\\';
	 afwrite(ch,1,4,f);
      } else
	 afwrite(ch,1,1,f);
   }
}

static void dumpascomments(AFILE *f,const char *buf) {
   int ch;

   aputc('%',f);
   aputc(' ',f);
   while ((ch=*buf++) != '\0') {
      if (ch=='\n' || ch=='\r') {
	 aputc('\n',f);
	 if (ch=='\r' && *buf=='\n')
	    ++buf;
	 if (*buf=='\0')
	    return;
	 aputc('%',f);
	 aputc(' ',f);
      } else
	 aputc(ch,f);
   }
   aputc('\n',f);
}

static int isStdEncoding(char *encoding[256]) {
   int i;

   for (i=0; i < 256; ++i)
      if (strcmp(encoding[i], ".notdef")==0)
	 /* that's ok */ ;
      else if (strcmp(encoding[i], AdobeStandardEncoding[i]) != 0)
	 return (0);

   return (1);
}

static void dumpblues(AFILE *f,char *name,real *arr,int len,char *ND) {
   int i;

   for (--len; len >= 0 && arr[len]==0.0; --len);
   ++len;
   if (len & 1)
      ++len;
   afprintf(f,"/%s [",name);
   for (i=0; i < len; ++i)
      afprintf(f,"%g ",(double)arr[i]);
   afprintf(f,"]%s\n",ND);
}

static void dumpdblmaxarray(AFILE *f,
			    char *name,real *arr,int len,char *modifiers,
			    char *ND) {
   int i;

   for (--len; len >= 0 && arr[len]==0.0; --len);
   ++len;
   afprintf(f,"/%s [", name);
   for (i=0; i < len; ++i)
      afprintf(f,"%g ", (double) arr[i]);
   afprintf(f,"]%s%s\n", modifiers, ND);
}

static void dumpdblarray(AFILE *f,
			 char *name,double *arr,int len,char *modifiers,
			 int exec) {
   int i;

   afprintf(f,"/%s %c", name, exec?'{':'[');
   for (i=0; i < len; ++i)
      afprintf(f,"%g ", arr[i]);
   afprintf(f,"%c%sdef\n", exec?'}':']', modifiers);
}

struct psdict *PSDictCopy(struct psdict *dict) {
   struct psdict *ret;
   int i;

   if (dict==NULL)
      return (NULL);

   ret=calloc(1, sizeof(struct psdict));
   ret->cnt=dict->cnt;
   ret->next=dict->next;
   ret->keys=calloc(ret->cnt, sizeof(char *));
   ret->values=calloc(ret->cnt, sizeof(char *));
   for (i=0; i < dict->next; ++i) {
      ret->keys[i]=copy(dict->keys[i]);
      ret->values[i]=copy(dict->values[i]);
   }

   return (ret);
}

int PSDictFindEntry(struct psdict *dict,char *key) {
   int i;

   if (dict==NULL)
      return (-1);

   for (i=0; i < dict->next; ++i)
      if (strcmp(dict->keys[i], key)==0)
	 return (i);

   return (-1);
}

char *PSDictHasEntry(struct psdict *dict,char *key) {
   int i;

   if (dict==NULL)
      return (NULL);

   for (i=0; i < dict->next; ++i)
      if (strcmp(dict->keys[i], key)==0)
	 return (dict->values[i]);

   return (NULL);
}

int PSDictRemoveEntry(struct psdict *dict,char *key) {
   int i;

   if (dict==NULL)
      return (false);

   for (i=0; i < dict->next; ++i)
      if (strcmp(dict->keys[i], key)==0)
	 break;
   if (i==dict->next)
      return (false);
   free(dict->keys[i]);
   free(dict->values[i]);
   --dict->next;
   while (i < dict->next) {
      dict->keys[i]=dict->keys[i + 1];
      dict->values[i]=dict->values[i + 1];
      ++i;
   }

   return (true);
}

int PSDictChangeEntry(struct psdict *dict,char *key,char *newval) {
   int i;

   if (dict==NULL)
      return (-1);

   for (i=0; i < dict->next; ++i)
      if (strcmp(dict->keys[i], key)==0)
	 break;
   if (i==dict->next) {
      if (dict->next >= dict->cnt) {
	 dict->cnt += 10;
	 dict->keys=realloc(dict->keys,dict->cnt*sizeof(char *));
	 dict->values=realloc(dict->values,dict->cnt*sizeof(char *));
      }
      dict->keys[dict->next]=copy(key);
      dict->values[dict->next]=NULL;
      ++dict->next;
   }
   free(dict->values[i]);
   dict->values[i]=copy(newval);
   return (i);
}

static void dumpsubrs(AFILE *f,SplineFont *sf, struct pschars *subrs) {
   int leniv=4;
   int i;
   char *pt;

   if (subrs==NULL)
      return;
   if ((pt=PSDictHasEntry(sf->private, "lenIV")) != NULL)
      leniv=strtol(pt, NULL, 10);
   afprintf(f,"/Subrs %d array\n", subrs->next);
   for (i=0; i < subrs->next; ++i) {
      afprintf(f,"dup %d %d RD ", i, subrs->lens[i] + leniv);
      encodestrout(f,subrs->values[i],subrs->lens[i],leniv);
      afputs(" NP\n",f);
   }
   afputs("ND\n",f);
}

/* Dumped within the private dict to get access to ND and RD */
static int dumpcharstrings(AFILE *f,
			   SplineFont *sf, struct pschars *chars) {
   int leniv=4;
   int i;
   char *pt;

   if ((pt=PSDictHasEntry(sf->private, "lenIV")) != NULL)
      leniv=strtol(pt, NULL, 10);
   afprintf(f,"2 index /CharStrings %d dict dup begin\n",
	 chars->cnt);
   for (i=0; i < chars->next; ++i) {
      if (chars->keys[i]==NULL)
	 break;
      afprintf(f,"/%s %d RD ", chars->keys[i],
	    chars->lens[i] + leniv);
      encodestrout(f,chars->values[i], chars->lens[i], leniv);
      afputs(" ND\n",f);
   }
   afputs("end end\nreadonly put\n",f);
   return (true);
}

static void dumpsplineset(AFILE *f,
			  SplineSet * spl, int pdfopers, int forceclose,
			  int makeballs, int do_clips) {
   SplinePoint *first, *sp;

   for (; spl != NULL; spl=spl->next) {
      if (do_clips^spl->is_clip_path)
	 continue;
      first=NULL;
      for (sp=spl->first;; sp=sp->next->to) {
	 if (first==NULL)
	    afprintf(f,"\t%g %g %s\n", (double) sp->me.x,
		  (double) sp->me.y, pdfopers?"m":"moveto");
	 else if (sp->prev->knownlinear)
	    afprintf(f,"\t %g %g %s\n", (double) sp->me.x,
		  (double) sp->me.y, pdfopers?"l":"lineto");
	 else
	    afprintf(f,"\t %g %g %g %g %g %g %s\n",
		  (double) sp->prev->from->nextcp.x,
		  (double) sp->prev->from->nextcp.y, (double) sp->prevcp.x,
		  (double) sp->prevcp.y, (double) sp->me.x, (double) sp->me.y,
		  pdfopers?"c":"curveto");
	 if (sp==first)
	    break;
	 if (first==NULL)
	    first=sp;
	 if (sp->next==NULL)
	    break;
      }
      if (makeballs
	  && (spl->first->next==NULL
	      || (spl->first->next->to==spl->first)))
	 afputs(pdfopers?"\th\n":"\tclosepath\n",f);
      if (forceclose || spl->first->prev != NULL)
	 afputs(pdfopers?"\th\n":"\tclosepath\n",f);
   }
}

static int InvertTransform(real inverse[6],real transform[6]) {
   real temp[6], val;
   int i;

   for (i=0; i < 6; ++i)
      temp[i]=transform[i];

   inverse[0]=inverse[3]=1;
   inverse[1]=inverse[2]=inverse[4]=inverse[5]=0;

   if (temp[0]==0 && temp[2]==0)
      return (false);		/* Not invertable */
   if (temp[0]==0) {
      val=temp[0];
      temp[0]=temp[2];
      temp[2]=val;
      val=temp[1];
      temp[1]=temp[3];
      temp[3]=val;
      inverse[0]=inverse[3]=0;
      inverse[1]=inverse[2]=1;
   }
   val=1 / temp[0];
   temp[1] *= val;
   inverse[0] *= val;
   inverse[1] *= val;
   val=temp[2];
   temp[3] -= val * temp[1];
   inverse[2] -= val * inverse[0];
   inverse[3] -= val * inverse[1];
   val=temp[4];
   temp[5] -= val * temp[1];
   inverse[4] -= val * inverse[0];
   inverse[5] -= val * inverse[1];
   if (temp[3]==0)
      return (false);
   val=1 / temp[3];
   inverse[2] *= val;
   inverse[3] *= val;
   val=temp[1];
   inverse[0] -= val * inverse[2];
   inverse[1] -= val * inverse[3];
   val=temp[5];
   inverse[4] -= val * inverse[2];
   inverse[5] -= val * inverse[3];
   return (true);
}

static void dumpGradient(AFILE *f,
			 struct gradient *grad, RefChar * ref,
			 SplineChar * sc, int layer, int pdfopers,
			 int isstroke) {

   if (pdfopers) {
      char buffer[200];

      afprintf(f,"/Pattern %s\n", isstroke?"CS":"cs");
      makePatName(buffer, ref, sc, layer, isstroke, true);
      afprintf(f,"/%s %s\n", buffer, isstroke?"SCN":"scn");
      /* PDF output looks much simpler than postscript. It isn't. It's just */
      /*  that the equivalent pdf dictionaries need to be created as objects */
      /*  and can't live in the content stream, so they are done elsewhere */
   } else {
      afprintf(f,"<<\n  /PatternType 2\n  /Shading <<\n");
      afprintf(f,"    /ShadingType %d\n",grad->radius==0?2:3);
      afprintf(f,"    /ColorSpace /DeviceRGB\n");
      if (grad->radius==0) {
	 afprintf(f,"    /Coords [%g %g %g %g]\n",
	       grad->start.x, grad->start.y, grad->stop.x, grad->stop.y);
      } else {
	 afprintf(f,"    /Coords [%g %g 0 %g %g %g]\n",
	       grad->start.x, grad->start.y, grad->stop.x, grad->stop.y,
	       grad->radius);
      }
      afprintf(f,"    /Extend [true true]\n");	/* implies pad */
      afprintf(f,"    /Function <<\n");
      afprintf(f,"      /FunctionType 0\n");	/* Iterpolation between samples */
      afprintf(f,"      /Domain [%g %g]\n",
	    grad->grad_stops[0].offset,
	    grad->grad_stops[grad->stop_cnt - 1].offset);
      afprintf(f,"      /Range [0 1.0 0 1.0 0 1.0]\n");
      afprintf(f,"      /Size [%d]\n",
	    grad->stop_cnt==2?2:101);
      afprintf(f,"      /BitsPerSample 8\n");
      afprintf(f,"      /Decode [0 1.0 0 1.0 0 1.0]\n");
      afprintf(f,"      /DataSource <");
      if (grad->stop_cnt==2) {
	 int col=grad->grad_stops[0].col;

	 if (col==COLOR_INHERITED)
	    col=0x000000;
	 afprintf(f,"%02x", (col >> 16) & 0xff);
	 afprintf(f,"%02x", (col >> 8) & 0xff);
	 afprintf(f,"%02x", (col) & 0xff);
	 col=grad->grad_stops[1].col;
	 afprintf(f,"%02x", (col >> 16) & 0xff);
	 afprintf(f,"%02x", (col >> 8) & 0xff);
	 afprintf(f,"%02x", (col) & 0xff);
      } else {
	 int i, j;

	 /* Rather than try and figure out the minimum common divisor */
	 /*  of all the offsets, I'll just assume they are all percent */
	 aputc('\n',f);
	 for (i=0; i <= 100; ++i) {
	    int col;

	    double t=grad->grad_stops[0].offset +
	       (grad->grad_stops[grad->stop_cnt - 1].offset -
		grad->grad_stops[0].offset) * i / 100.0;
	    for (j=0; j < grad->stop_cnt; ++j)
	       if (t <= grad->grad_stops[j].offset)
		  break;
	    if (j==grad->stop_cnt)
	       col=grad->grad_stops[j - 1].col;
	    else if (t==grad->grad_stops[j].offset)
	       col=grad->grad_stops[j].col;
	    else {
	       double percent =
		  (t -
		   grad->grad_stops[j -
				    1].offset) / (grad->grad_stops[j].offset -
						  grad->grad_stops[j -
								   1].offset);
	       uint32_t col1=grad->grad_stops[j - 1].col;
	       uint32_t col2=grad->grad_stops[j].col;
	       int red, green, blue;

	       if (col1==COLOR_INHERITED)
		  col1=0x000000;
	       if (col2==COLOR_INHERITED)
		  col2=0x000000;
	       red =
		  ((col1 >> 16) & 0xff) * (1 - percent) +
		  ((col2 >> 16) & 0xff) * percent;
	       green =
		  ((col1 >> 8) & 0xff) * (1 - percent) +
		  ((col2 >> 8) & 0xff) * percent;
	       blue =
		  ((col1) & 0xff) * (1 - percent) + ((col2) & 0xff) * percent;
	       col=(red << 16) | (green << 8) | blue;
	    }
	    if (col==COLOR_INHERITED)
	       col=0x000000;
	    afprintf(f,"%02x", (col >> 16) & 0xff);
	    afprintf(f,"%02x", (col >> 8) & 0xff);
	    afprintf(f,"%02x", (col) & 0xff);
	 }
      }
      afprintf(f,">\n");
      afprintf(f,"    >>\n");
      afprintf(f,"  >>\n");
      afprintf(f,">> matrix makepattern setpattern\n");
   }
}

static void dumpPattern(AFILE *f,
			struct pattern *pat, RefChar * ref, SplineChar * sc,
			int layer, int pdfopers, int isstroke) {
   SplineChar *pattern_sc=SFGetChar(sc->parent, -1, pat->pattern);
   DBounds b;
   real scale[6], result[6];

   if (pdfopers) {
      char buffer[200];

      afprintf(f,"/Pattern %s\n", isstroke?"CS":"cs");
      makePatName(buffer, ref, sc, layer, isstroke, false);
      afprintf(f,"/%s %s\n", buffer, isstroke?"SCN":"scn");
      /* PDF output looks much simpler than postscript. It isn't. It's just */
      /*  that the equivalent pdf dictionaries need to be created as objects */
      /*  and can't live in the content stream, so they are done elsewhere */
   } else {
      if (pattern_sc==NULL)
	 ErrorMsg(2,"No glyph named %s, used as a pattern in %s\n",
		  pat->pattern, sc->name);
      PatternSCBounds(pattern_sc, &b);

      afprintf(f,"<<\n");
      afprintf(f,"  /PatternType 1\n");
      afprintf(f,"  /PaintType 1\n");	/* The intricacies of uncolored tiles are not something into which I wish to delve */
      afprintf(f,"  /TilingType 1\n");
      afprintf(f,"  /BBox [%g %g %g %g]\n", b.minx, b.miny, b.maxx,
	    b.maxy);
      afprintf(f,"  /XStep %g\n", b.maxx - b.minx);
      afprintf(f,"  /YStep %g\n", b.maxy - b.miny);
      afprintf(f,"  /PaintProc { begin\n");	/* The begin pops the pattern dictionary off the stack. Don't really use it, but do need the pop */
      SC_PSDump(f,pattern_sc,true,false,ly_all);
      afprintf(f,"  end }\n");
      memset(scale, 0, sizeof(scale));
      scale[0]=pat->width / (b.maxx - b.minx);
      scale[3]=pat->height / (b.maxy - b.miny);
      MatMultiply(scale, pat->transform, result);
      afprintf(f,">> [%g %g %g %g %g %g] makepattern setpattern\n",
	    result[0], result[1], result[2], result[3], result[4], result[5]);
   }
}

static void dumpbrush(AFILE *f,
		      struct brush *brush, RefChar * ref, SplineChar * sc,
		      int layer, int pdfopers) {
   if (brush->gradient != NULL)
      dumpGradient(f,brush->gradient, ref, sc, layer, pdfopers,
		   false);
   else if (brush->pattern != NULL)
      dumpPattern(f,brush->pattern, ref, sc, layer, pdfopers,
		  false);
   else if (brush->col != COLOR_INHERITED) {
      int r,g,b;

      r=(brush->col >> 16) & 0xff;
      g=(brush->col >> 8) & 0xff;
      b=(brush->col) & 0xff;
      if (r==g && b==g)
	 afprintf(f,(pdfopers?"%g g\n":"%g setgray\n"),
	       r/255.0);
      else
	 afprintf(f,(pdfopers?"%g %g %g rg\n":"%g %g %g setrgbcolor\n"),
		  r/255.0,g/255.0,b/255.0);
      if (pdfopers && brush->opacity<1.0 && brush->opacity>=0)
	 afprintf(f,"/gs_fill_opacity_%g gs\n", brush->opacity);
   }
}

/* Grumble. PDF uses different operators for colors for stroke and fill */
static void dumppenbrush(AFILE *f,
			 struct brush *brush, RefChar * ref, SplineChar * sc,
			 int layer, int pdfopers) {
   if (brush->gradient != NULL)
      dumpGradient(f,brush->gradient, ref, sc, layer, pdfopers,
		   true);
   else if (brush->pattern != NULL)
      dumpPattern(f,brush->pattern, ref, sc, layer, pdfopers,
		  true);
   else if (brush->col != COLOR_INHERITED) {
      int r,g,b;

      r=(brush->col >> 16) & 0xff;
      g=(brush->col >> 8) & 0xff;
      b=(brush->col) & 0xff;
      if (r==g && b==g)
	 afprintf(f,(pdfopers?"%g G\n":"%g setgray\n"),
	       r / 255.0);
      else
	afprintf(f,(pdfopers?"%g %g %g RG\n":"%g %g %g setrgbcolor\n"),
		 r/255.0,g/255.0,b/255.0);
      if (pdfopers && brush->opacity < 1.0 && brush->opacity >= 0)
	 afprintf(f,"/gs_stroke_opacity_%g gs\n", brush->opacity);
   }
}

static void dumppen(AFILE *f,
		    struct pen *pen, RefChar * ref, SplineChar * sc,
		    int layer, int pdfopers) {
   dumppenbrush(f, &pen->brush, ref, sc, layer, pdfopers);

   if (pen->width != WIDTH_INHERITED)
      afprintf(f,(pdfopers?"%g w\n":"%g setlinewidth\n"),
	    pen->width);
   if (pen->linejoin != lj_inherited)
      afprintf(f,(pdfopers?"%d j\n":"%d setlinejoin\n"),
	    pen->linejoin);
   if (pen->linecap != lc_inherited)
      afprintf(f,(pdfopers?"%d J\n":"%d setlinecap\n"),
	    pen->linecap);
   if (pen->trans[0] != 1.0 || pen->trans[3] != 1.0 || pen->trans[1] != 0
       || pen->trans[2] != 0)
      afprintf(f,(pdfopers?"%g %g %g %g 0 0 cm\n":
		  "[%g %g %g %g 0 0] concat\n"), (double) pen->trans[0],
	       (double) pen->trans[1], (double) pen->trans[2],
	       (double) pen->trans[3]);
   if (pen->dashes[0] != 0 || pen->dashes[1] != DASH_INHERITED) {
      int i;

      aputc('[',f);
      for (i=0;
	   i < sizeof(pen->dashes) / sizeof(pen->dashes[0])
	   && pen->dashes[i] != 0; ++i)
	 afprintf(f,"%d ", pen->dashes[i]);
      afprintf(f,pdfopers?"] 0 d\n":"] 0 setdash\n");
   }
}

static void PSDumpBinaryData(AFILE *f,uint8_t *bytes,int rows,
			     int bytes_per_row,int useful_bytes_per_row) {
   AFILE *ps;
   int i,j,cnt,group_cnt;
   const int max_string=65536;
   
   if (useful_bytes_per_row * rows < max_string) {
      /* It all fits in one string. Easy peasy */
      afputs("{<~",f);
      ps=base85_afile(f);
      if (bytes_per_row==useful_bytes_per_row)
	afwrite(bytes,bytes_per_row,rows,f);
      else
	for (i=0; i < rows; ++i)
	  afwrite(bytes+i*bytes_per_row,1,useful_bytes_per_row,ps);
      afclose(ps);
      aputc('}',f);

   } else {
      cnt=(max_string - 1) / useful_bytes_per_row;
      if (cnt==0)
	 cnt=1;
      group_cnt=-1;
      for (i=0;i<rows;) {
	 if (i + cnt >= rows)
	    afputs("{currentdict /ff-image-cnt undef <~",f);
	 else {
	    afprintf(f,"{{/ff-image-cnt %d def <~",i/cnt);
	    group_cnt=i/cnt;
	 }
	 ps=base85_afile(f);
	 for (j=0;j<cnt && i<rows;i++,j++)
	   afwrite(bytes+i*bytes_per_row,1,useful_bytes_per_row,ps);
	 afclose(ps);
	 afputs("}\n",f);
      }
      for (i=group_cnt - 1; i >= 0; --i) {
	 afprintf(f,"ff-image-cnt %d eq 3 1 roll ifelse}\n", i);
      }
      afputs("currentdict /ff-image-cnt known not 3 1 roll ifelse}\n",f);
   }
}

static void PSDump24BinaryData(AFILE *f, struct _GImage *base) {
   AFILE *ps;
   int i, j, cnt, group_cnt;
   register uint32_t val;
   register uint32_t *pt, *end;
   const int max_string=65536;

   if (3 * base->width * base->height < max_string) {
      /* It all fits in one string. Easy peasy */
      afprintf(f,"{<~");
      ps=base85_afile(f);
      for (i=0; i < base->height; ++i) {
	 pt=(uint32_t *) (base->data + i * base->bytes_per_line);
	 end=pt + base->width;
	 while (pt < end) {
	    val=*pt++;
	    aputc(COLOR_RED(val),ps);
	    aputc(COLOR_GREEN(val),ps);
	    aputc(COLOR_BLUE(val),ps);
	 }
      }
      afclose(ps);
      aputc('}',f);

   } else {
      cnt=(max_string - 1) / (3 * base->width);
      if (cnt==0)
	 cnt=1;
      group_cnt=-1;
      for (i=0; i < base->height;) {
	 if (i + cnt >= base->height)
	    afprintf(f,"{currentdict /ff-image-cnt undef <~");
	 else {
	    afprintf(f,"{{/ff-image-cnt %d def <~", i / cnt);
	    group_cnt=i / cnt;
	 }
	 ps=base85_afile(f);
	 for (j=0; j < cnt && i < base->height; ++i, ++j) {
	    pt=(uint32_t *) (base->data + i * base->bytes_per_line);
	    end=pt + base->width;
	    while (pt < end) {
	       val=*pt++;
	       aputc(COLOR_RED(val),ps);
	       aputc(COLOR_GREEN(val),ps);
	       aputc(COLOR_BLUE(val),ps);
	    }
	 }
	 afclose(ps);
	 afprintf(f,"}\n");
      }
      for (i=group_cnt - 1; i >= 0; --i) {
	 afprintf(f,"ff-image-cnt %d eq 3 1 roll ifelse}\n", i);
      }
      afputs("currentdict /ff-image-cnt known not 3 1 roll ifelse}\n",f);
   }
}

static void PSDrawMonoImg(AFILE *f,
			  struct _GImage *base, int use_imagemask) {

   afprintf(f," %d %d ", base->width, base->height);
   if (base->trans==1)
      afprintf(f,"false ");
   else
      afprintf(f,"true ");
   afprintf(f,"[%d 0 0 %d 0 %d]\n",
	 base->width, -base->height, base->height);
   PSDumpBinaryData(f,(uint8_t *)base->data,base->height,
		    base->bytes_per_line,(base->width+7)/8);

   afprintf(f,"%s\n", use_imagemask?"imagemask":"image");
}

static void PSSetIndexColors(AFILE *f,GClut *clut) {
   int i;

   afprintf(f,"[/Indexed /DeviceRGB %d <\n", clut->clut_len - 1);
   for (i=0; i<clut->clut_len; ++i)
      afprintf(f,"%02X%02X%02X%s", COLOR_RED(clut->clut[i]),
	    COLOR_GREEN(clut->clut[i]), COLOR_BLUE(clut->clut[i]),
	    i % 11==10?"\n":" ");
   afprintf(f,">\n] setcolorspace\n");
}

static void PSBuildImageIndexDict(AFILE *f,struct _GImage *base) {
   /* I need an image dict, otherwise I am restricted to grey scale */
   afprintf(f,"<<\n");
   afprintf(f,"  /ImageType 1\n");
   afprintf(f,"  /Width %d\n", base->width);
   afprintf(f,"  /Height %d\n", base->height);
   afprintf(f,"  /ImageMatrix [%d 0 0 %d 0 %d]\n",
	 base->width, -base->height, base->height);
   afprintf(f,"  /MultipleDataSources false\n");
   afprintf(f,"  /BitsPerComponent 8\n");
   afprintf(f,"  /Decode [0 255]\n");
   afprintf(f,"  /Interpolate false\n");
   afprintf(f,"  /DataSource ");
   PSDumpBinaryData(f,base->data,base->height,
		    base->bytes_per_line,base->width);
   afprintf(f,">> image\n");
}

static void PSDrawImg(AFILE *f,struct _GImage *base) {

   if (base->image_type==it_index) {
      PSSetIndexColors(f, base->clut);
      PSBuildImageIndexDict(f, base);
      afprintf(f,"[/DeviceRGB] setcolorspace\n");
   } else {
      afprintf(f,"%d %d 8 [%d 0 0 %d 0 %d] ",
	    base->width, base->height, base->width, -base->height,
	    base->height);
      PSDump24BinaryData(f, base);
      afprintf(f,"false 3 colorimage\n");
   }
}

static void dumpimage(AFILE *f,
		      ImageList *imgl, int use_imagemask, int pdfopers,
		      int layer, int icnt, SplineChar * sc) {
   GImage *image=imgl->image;

   struct _GImage *base =
      image->list_len==0?image->u.image:image->u.images[0];

   if (pdfopers) {
      afprintf(f,"  q 1 0 0 1 %g %g cm %g 0 0 %g 0 0 cm\n",
	    (double) imgl->xoff,
	    (double) (imgl->yoff - imgl->yscale * base->height),
	    (double) (imgl->xscale * base->width),
	    (double) (imgl->yscale * base->height));
      afprintf(f,"/%s_ly%d_%d_image", sc->name, layer, icnt);
      afprintf(f," Do ");	/* I think I use this for imagemasks too... */
      afputs("Q\n",f);
   } else {
      afprintf(f,"  gsave %g %g translate %g %g scale\n",
	    (double) imgl->xoff,
	    (double) (imgl->yoff - imgl->yscale * base->height),
	    (double) (imgl->xscale * base->width),
	    (double) (imgl->yscale * base->height));
      if (base->image_type==it_mono) {
	 PSDrawMonoImg(f, base, use_imagemask);
      } else {
	 /* Just draw the image, ignore the complexity of transparent images */
	 PSDrawImg(f, base);
      }
      afputs("grestore\n",f);
   }
}

void SC_PSDump(AFILE *f,
	       SplineChar *sc, int refs_to_splines, int pdfopers,
	       int layer) {
   RefChar *ref;
   real inverse[6];
   int i, last, first;
   SplineSet *temp;

   if (sc==NULL)
      return;
   last=first=layer;
   if (layer==ly_all)
      first=last=ly_fore;
   if (sc->parent->multilayer) {
      first=ly_fore;
      last=sc->layer_cnt - 1;
   }
   for (i=first; i <= last; ++i) {
      if (sc->layers[i].splines != NULL) {
	 temp=sc->layers[i].splines;
	 if (sc->layers[i].order2)
	    temp=SplineSetsPSApprox(temp);
	 if (sc->parent->multilayer) {
	    afputs(pdfopers?"q ":"gsave ",f);
	    if (SSHasClip(temp)) {
	       dumpsplineset(f, temp, pdfopers, true, false,
			     true);
	       afputs(pdfopers?"W n ":"clip newpath\n",f);
	    }
	    dumpsplineset(f, temp, pdfopers,
			  sc->layers[i].dofill, sc->layers[i].dostroke
			  && sc->layers[i].stroke_pen.linecap==lc_round,
			  false);
	    if (sc->layers[i].dofill && sc->layers[i].dostroke) {
	       if (pdfopers) {
		  dumpbrush(f, &sc->layers[i].fill_brush, NULL,
			    sc, i, pdfopers);
		  dumppen(f, &sc->layers[i].stroke_pen, NULL, sc,
			  i, pdfopers);
		  afputs("B ",f);
	       } else if (sc->layers[i].fillfirst) {
		  afputs("gsave ",f);
		  dumpbrush(f, &sc->layers[i].fill_brush, NULL,
			    sc, i, pdfopers);
		  afputs("fill grestore ",f);
		  dumppen(f, &sc->layers[i].stroke_pen, NULL, sc,
			  i, pdfopers);
		  afputs("stroke ",f);
	       } else {
		  afputs("gsave ",f);
		  dumppen(f, &sc->layers[i].stroke_pen, NULL, sc,
			  i, pdfopers);
		  afputs("stroke grestore ",f);
		  dumpbrush(f, &sc->layers[i].fill_brush, NULL,
			    sc, i, pdfopers);
		  afputs("fill ",f);
	       }
	    } else if (sc->layers[i].dofill) {
	       dumpbrush(f, &sc->layers[i].fill_brush, NULL, sc,
			 i, pdfopers);
	       afputs(pdfopers?"f ":"fill ",f);
	    } else if (sc->layers[i].dostroke) {
	       dumppen(f, &sc->layers[i].stroke_pen, NULL, sc, i,
		       pdfopers);
	       afputs(pdfopers?"S ":"stroke ",f);
	    }
	    afputs(pdfopers?"Q\n":"grestore\n",f);
	 } else
	    dumpsplineset(f, temp, pdfopers,
			  !sc->parent->strokedfont, false, false);
	 if (sc->layers[i].order2)
	    SplinePointListsFree(temp);
      }
      if (sc->layers[i].refs != NULL) {
	 if (sc->parent->multilayer) {
	    afputs(pdfopers?"q ":"gsave ",f);
	    if (sc->layers[i].dofill)
	       dumpbrush(f, &sc->layers[i].fill_brush, NULL, sc,
			 i, pdfopers);
	 }
	 if (refs_to_splines) {
	    if (!pdfopers || !sc->parent->multilayer) {
	       /* In PostScript, patterns are transformed by the page's */
	       /*  transformation matrix. In PDF they are not. */
	       /* Of course if we have no patterns we can still use this code */
	       for (ref=sc->layers[i].refs; ref != NULL; ref=ref->next) {
		  afputs(pdfopers?"q ":"gsave ",f);
		  if (!MatIsIdentity(ref->transform)) {
		     afprintf(f,pdfopers?"%g %g %g %g %g %g cm " :
			   "[%g %g %g %g %g %g] concat ",
			   (double) ref->transform[0],
			   (double) ref->transform[1],
			   (double) ref->transform[2],
			   (double) ref->transform[3],
			   (double) ref->transform[4],
			   (double) ref->transform[5]);
		  }
		  SC_PSDump(f, ref->sc, refs_to_splines,
			    pdfopers, ly_all);
		  afputs(pdfopers?"Q\n":"grestore\n",f);
	       }
	    } else {
	       /* If we get here we are outputting pdf, are type3, refs_2_splines */
/*  We need different gradients and patterns for different transform */
/*  matrices of references */
	       int j;

	       for (ref=sc->layers[i].refs; ref != NULL; ref=ref->next) {
		  for (j=0; j < ref->layer_cnt; ++j) {
		     temp=ref->layers[j].splines;
		     /*if ( sc->layers[i].order2 )
		        temp=SplineSetsPSApprox(temp); */
		     afputs(pdfopers?"q":"gsave ",f);
		     dumpsplineset(f, temp, pdfopers,
				   ref->layers[j].dofill,
				   ref->layers[j].dostroke
				   && ref->layers[j].stroke_pen.linecap ==
				   lc_round, false);
		     if (ref->layers[j].dofill && ref->layers[j].dostroke) {
			dumpbrush(f, &ref->layers[j].fill_brush,
				  ref, ref->sc, j, pdfopers);
			dumppen(f, &ref->layers[j].stroke_pen,
				ref, ref->sc, j, pdfopers);
			afputs("B ",f);
		     } else if (ref->layers[j].dofill) {
			dumpbrush(f, &ref->layers[j].fill_brush,
				  ref, ref->sc, j, pdfopers);
			afputs(pdfopers?"f ":"fill ",f);
		     } else if (ref->layers[j].dostroke) {
			dumppen(f, &ref->layers[j].stroke_pen,
				ref, ref->sc, j, pdfopers);
			afputs(pdfopers?"S ":"stroke ",f);
		     }
		     afputs(pdfopers?"Q\n":"grestore\n",f);
		     /* if ( sc->layers[layer].order2 )
		        SplinePointListsFree(temp); */
		  }
	       }
	    }
	 } else {
	    afputs("    pop -1\n",f);
	    for (ref=sc->layers[i].refs; ref != NULL; ref=ref->next) {
	       if (ref->transform[0] != 1 || ref->transform[1] != 0
		   || ref->transform[2] != 0 || ref->transform[3] != 1
		   || ref->transform[4] != 0 || ref->transform[5] != 0) {
		  if (InvertTransform(inverse, ref->transform)) {
		     if (ref->transform[0] != 1 || ref->transform[1] != 0 ||
			 ref->transform[2] != 0 || ref->transform[3] != 1)
			afprintf(f,"    [ %g %g %g %g %g %g ] concat ",
			      (double) ref->transform[0],
			      (double) ref->transform[1],
			      (double) ref->transform[2],
			      (double) ref->transform[3],
			      (double) ref->transform[4],
			      (double) ref->transform[5]);
		     else
			afprintf(f,"    %g %g translate ",
			      (double) ref->transform[4],
			      (double) ref->transform[5]);
		     afprintf(f,
			   "1 index /CharProcs get /%s get exec ",
			   ref->sc->name);
		     if (inverse[0] != 1 || inverse[1] != 0 || inverse[2] != 0
			 || inverse[3] != 1)
			afprintf(f,
			      "[ %g %g %g %g %g %g ] concat \n",
			      (double) inverse[0], (double) inverse[1],
			      (double) inverse[2], (double) inverse[3],
			      (double) inverse[4], (double) inverse[5]
			   );
		     else
			afprintf(f,"%g %g translate\n",
			      (double) inverse[4], (double) inverse[5]);
		  }
	       } else
		  afprintf(f,
			"    1 index /CharProcs get /%s get exec\n",
			ref->sc->name);
	    }
	 }
	 if (sc->parent->multilayer)
	    afputs(pdfopers?"Q\n":"grestore\n",f);
      }
      if (sc->layers[i].images != NULL) {
	 ImageList *img;

	 int icnt=0;

	 afputs(pdfopers?"q\n":"gsave\n",f);
	 if (sc->layers[i].dofill)
	    dumpbrush(f, &sc->layers[i].fill_brush, NULL, sc, i,
		      pdfopers);
	 for (img=sc->layers[i].images; img != NULL;
	      img=img->next, ++icnt)
	    dumpimage(f, img, sc->layers[i].dofill, pdfopers, i,
		      icnt, sc);
	 afputs(pdfopers?"Q\n":"grestore\n",f);
      }
   }
}

static int SCSetsColor(SplineChar *sc) {
   int l;
   RefChar *r;
   ImageList *img;

   for (l=ly_fore; l < sc->layer_cnt; ++l) {
      if (sc->layers[l].fill_brush.col != COLOR_INHERITED)
	 return (true);
      if (sc->layers[l].fill_brush.gradient != NULL
	  || sc->layers[l].fill_brush.pattern != NULL)
	 return (true);
      if (sc->layers[l].stroke_pen.brush.col != COLOR_INHERITED)
	 return (true);
      if (sc->layers[l].stroke_pen.brush.gradient != NULL
	  || sc->layers[l].stroke_pen.brush.pattern != NULL)
	 return (true);
      for (img=sc->layers[l].images; img != NULL; img=img->next) {
	 GImage *image=img->image;

	 struct _GImage *base =
	    image->list_len==0?image->u.image:image->u.images[0];
	 if (base->image_type != it_mono)
	    return (true);
	 if (!sc->layers[l].dofill)
	    return (true);
      }
      for (r=sc->layers[l].refs; r != NULL; r=r->next)
	 if (SCSetsColor(r->sc))
	    return (true);
   }
   return (false);
}

static void dumpproc(AFILE *f,
		     SplineChar * sc) {
   DBounds b;

   SplineCharFindBounds(sc, &b);
   afprintf(f,"  /%s { ", sc->name);
   if (sc->dependents != NULL)
      afputs("dup -1 ne { ",f);
   if (!SCSetsColor(sc)) {
      afprintf(f,"%d 0 %d %d %d %d setcachedevice",
	    (int) sc->width, (int) floor(b.minx), (int) floor(b.miny),
	    (int) ceil(b.maxx), (int) ceil(b.maxy));
   } else {
      /* can't cache it if we set colour/grey within */
      afprintf(f,"%d 0 setcharwidth", (int) sc->width);
   }
   if (sc->dependents != NULL)
      afputs(" } if\n",f);
   else
      afputs("\n",f);
   SC_PSDump(f, sc, false, false, ly_all);
   afputs("  } bind def\n",f);
}

static int dumpcharprocs(AFILE *f,
			 SplineFont *sf) {
   /* for type 3 fonts */
   int cnt, i, notdefpos=-1;

   cnt=0;
   notdefpos=SFFindNotdef(sf, -2);
   for (i=0; i < sf->glyphcnt; ++i)
      if (SCWorthOutputting(sf->glyphs[i])) {
	 if (strcmp(sf->glyphs[i]->name, ".notdef") != 0)
	    ++cnt;
      }
   ++cnt;			/* one notdef entry */

   afprintf(f,"/CharProcs %d dict def\nCharProcs begin\n", cnt);
   i=0;
   if (notdefpos != -1)
      dumpproc(f, sf->glyphs[notdefpos]);
   else {
      afprintf(f,
	    "  /.notdef { %d 0 0 0 0 0 setcachedevice } bind def\n",
	    sf->ascent + sf->descent);
      if (sf->glyphs[0] != NULL
	  && strcmp(sf->glyphs[0]->name, ".notdef")==0)
	 ++i;
   }
   for (; i < sf->glyphcnt; ++i)
      if (i != notdefpos) {
	 if (SCWorthOutputting(sf->glyphs[i]))
	    dumpproc(f, sf->glyphs[i]);
      }
   afputs("end\ncurrentdict end\n",f);
   afprintf(f,"/%s exch definefont\n", sf->fontname);
   return (true);
}

static struct pschars *initsubrs(int needsflex,MMSet *mm) {
   extern const uint8_t *const subrs[10];
   extern const int subrslens[10];
   int i;
   struct pschars *sub;

   sub=calloc(1, sizeof(struct pschars));
   sub->cnt=10;
   sub->lens=malloc(10 * sizeof(int));
   sub->values=malloc(10 * sizeof(uint8_t *));
   for (i=0; i < 5; ++i) {
      ++sub->next;
      sub->values[i]=(uint8_t *) copyn((const char *) subrs[i], subrslens[i]);
      sub->lens[i]=subrslens[i];
   }
   sub->next=5;
   if (mm != NULL) {
      static int cnts[]={ 1,2,3,4,6 };
      for (; i < 10 && cnts[i - 5] * mm->instance_count < 22; ++i) {
	 ++sub->next;
	 sub->values[i] =
	    (uint8_t *) copyn((const char *) subrs[i], subrslens[i]);
	 sub->values[i][0] += cnts[i - 5] * mm->instance_count;
	 sub->lens[i]=subrslens[i];
      }
      sub->next=10;
   }
   return (sub);
}

static void dumpothersubrs(AFILE *f,
			   int incid, int needsflex, int needscounters,
			   MMSet * mm) {
   extern const char **othersubrs_copyright[];
   extern const char **othersubrs[];
   extern const char *cid_othersubrs[];
   int i, j;

   afputs("/OtherSubrs \n",f);
   if (incid) {
      for (i=0; cid_othersubrs[i] != NULL; ++i) {
	 afputs(cid_othersubrs[i],f);
	 aputc('\n',f);
      }
   } else {
      int max_subr, min_subr;

      /* I assume I always want the hint replacement subr, (it's small) */
      /*  but the flex subrs are large, and if I can omit them, I shall */
      if (needsflex) {
	 min_subr=0;
	 max_subr=3;
      } else {
	 min_subr=3;
	 max_subr=3;
      }

      if (needscounters)
	 max_subr=13;
      for (i=0; othersubrs_copyright[0][i] != NULL; ++i) {
	 afputs(othersubrs_copyright[0][i],f);
	 aputc('\n',f);
      }
      afputs("[ ",f);	/* start array */
      for (j=0; j < min_subr; ++j)
	 afputs(" {}\n",f);
      for (; j <= max_subr; ++j)
	 for (i=0; othersubrs[j][i] != NULL; ++i) {
	    afputs(othersubrs[j][i],f);
	    aputc('\n',f);
	 }
      if (mm != NULL) {
	 /* MM other subrs begin at 14, so skip anything up till then */
	 for (; j <= 13; ++j)
	    afputs(" {}\n",f);
      }
      if (mm != NULL) {
	 /* the code for the multiple master subroutines depends on */
	 /*  the number of font instances, so we can't just blithely copy */
	 /*  an example from Adobe (and they don't provide one anyway) */
	 afprintf(f,"{ %d 1 roll $Blend } bind\n",
	       mm->instance_count);
	 if (2 * mm->instance_count < 22)
	    afprintf(f,
		  "{ exch %d %d roll $Blend exch %d 2 roll $Blend } bind\n",
		  2 * mm->instance_count, 1 - mm->instance_count,
		  mm->instance_count + 1);
	 if (3 * mm->instance_count < 22)
	    afprintf(f,
		  "{ 3 -1 roll %d %d roll $Blend 3 -1 roll %d %d roll $Blend 3 -1 roll %d 2 roll $Blend } bind\n",
		  3 * mm->instance_count, 1 - mm->instance_count,
		  2 * mm->instance_count + 1, 1 - mm->instance_count,
		  mm->instance_count + 2);
	 if (4 * mm->instance_count < 22)
	    afprintf(f,
		  "{ 4 -1 roll %d %d roll $Blend 4 -1 roll %d %d roll $Blend 4 -1 roll %d %d roll $Blend 4 -1 roll %d 3 roll $Blend } bind\n",
		  4 * mm->instance_count, 1 - mm->instance_count,
		  3 * mm->instance_count + 1, 1 - mm->instance_count,
		  2 * mm->instance_count + 2, 1 - mm->instance_count,
		  mm->instance_count + 3);
	 if (6 * mm->instance_count < 22)
	    afprintf(f,
		  "{ 6 -1 roll %d %d roll $Blend 6 -1 roll %d %d roll $Blend 6 -1 roll %d %d roll $Blend 6 -1 roll %d %d roll $Blend 6 -1 roll %d %d roll $Blend 6 -1 roll %d 5 roll $Blend } bind\n",
		  6 * mm->instance_count, 1 - mm->instance_count,
		  5 * mm->instance_count + 1, 1 - mm->instance_count,
		  4 * mm->instance_count + 2, 1 - mm->instance_count,
		  3 * mm->instance_count + 3, 1 - mm->instance_count,
		  2 * mm->instance_count + 4, 1 - mm->instance_count,
		  mm->instance_count + 5);
      }
      afputs("] ",f);	/* End array */
   }
   afputs(incid?"def\n":"ND\n",f);
}

static char *dumptospace(AFILE *f,
			 char *str) {

   while (*str != ' ' && *str != ']' && *str != '\0')
      aputc(*str++,f);
   return (str);
}

static void dumpmmprivatearr(AFILE *f,char *privates[16],
			     int instance_count) {
   int j;

   for (j=0; j < instance_count; ++j)
      while (*privates[j]==' ')
	 ++privates[j];

   aputc('[',f);
   if (*privates[0]=='[') {
      /* It's an array */
      for (j=0; j < instance_count; ++j)
	 ++privates[j];
      while (*privates[0] != ']' && *privates[0] != '\0') {
	 for (j=0; j < instance_count; ++j)
	    while (*privates[j]==' ')
	       ++privates[j];
	 if (*privates[0]==']' || *privates[0]=='\0')
	    break;
	 aputc('[',f);
	 privates[0]=dumptospace(f, privates[0]);
	 for (j=1; j < instance_count; ++j) {
	    aputc(' ',f);
	    privates[j]=dumptospace(f, privates[j]);
	 }
	 aputc(']',f);
      }
   } else {
      /* It's not an array */
      afputs(privates[0],f);
      for (j=1; j < instance_count; ++j) {
	 aputc(' ',f);
	 afputs(privates[j],f);
      }
   }
   aputc(']',f);
}

static void dumpmmprivate(AFILE *f,
			  MMSet * mm) {
   char *privates[16];
   int j, k, missing, allsame;
   struct psdict *private=mm->instances[0]->private;

   if (private==NULL)
      return;

   afputs("3 index /Blend get /Private get begin\n",f);
   for (k=0; k < private->next; ++k) {
      privates[0]=private->values[k];
      missing=false;
      allsame=true;
      for (j=1; j < mm->instance_count; ++j) {
	 privates[j] =
	    PSDictHasEntry(mm->instances[j]->private, private->keys[k]);
	 if (privates[j]==NULL) {
	    missing=true;
	    break;
	 } else if (strcmp(privates[j], privates[0]) != 0)
	    allsame=false;
      }
      if (missing || allsame)
	 continue;
      afprintf(f," /%s ", private->keys[k]);
      dumpmmprivatearr(f, privates, mm->instance_count);
      afputs(" def\n",f);
   }
   afputs("end\n",f);
}

static double FindMaxDiffOfBlues(char *pt,double max_diff) {
   char *end;
   double p1, p2;

   while (*pt==' ' || *pt=='[')
      ++pt;
   while (1) {
      p1=strtod(pt, &end);
      if (end==pt)
	 break;
      pt=end;
      p2=strtod(pt, &end);
      if (end==pt)
	 break;
      if (p2 - p1 > max_diff)
	 max_diff=p2 - p1;
      pt=end;
   }
   return (max_diff);
}

double BlueScaleFigureForced(struct psdict *private_, real bluevalues[],
			     real otherblues[]) {
   double max_diff=0;
   char *pt;
   int i;

   pt=PSDictHasEntry(private_, "BlueValues");
   if (pt != NULL) {
      max_diff=FindMaxDiffOfBlues(pt, max_diff);
   } else if (bluevalues != NULL) {
      for (i=0; i < 14 && (bluevalues[i] != 0 || bluevalues[i + 1]) != 0;
	   i += 2) {
	 if (bluevalues[i + 1] - bluevalues[i] >= max_diff)
	    max_diff=bluevalues[i + 1] - bluevalues[i];
      }
   }
   pt=PSDictHasEntry(private_, "FamilyBlues");
   if (pt != NULL)
      max_diff=FindMaxDiffOfBlues(pt, max_diff);

   pt=PSDictHasEntry(private_, "OtherBlues");
   if (pt != NULL)
      max_diff=FindMaxDiffOfBlues(pt, max_diff);
   else if (otherblues != NULL) {
      for (i=0; i < 10 && (otherblues[i] != 0 || otherblues[i + 1] != 0);
	   i += 2) {
	 if (otherblues[i + 1] - otherblues[i] >= max_diff)
	    max_diff=otherblues[i + 1] - otherblues[i];
      }
   }
   pt=PSDictHasEntry(private_, "FamilyOtherBlues");
   if (pt != NULL)
      max_diff=FindMaxDiffOfBlues(pt, max_diff);
   if (max_diff <= 0)
      return (-1);
   if (1 / max_diff > .039625)
      return (-1);

   return (.99 / max_diff);
}

double BlueScaleFigure(struct psdict *private_, real bluevalues[],
		       real otherblues[]) {
   if (PSDictHasEntry(private_, "BlueScale") != NULL)
      return (-1);
   return BlueScaleFigureForced(private_, bluevalues, otherblues);
}

static int dumpprivatestuff(AFILE *f,
			    SplineFont *sf, struct fddata *incid, int flags,
			    enum fontformat format, EncMap * map, int layer) {
   int cnt, mi;
   real bluevalues[14], otherblues[10];
   real snapcnt[12];
   real stemsnaph[12], stemsnapv[12];
   real stdhw[1], stdvw[1];
   int flex_max;
   int i;
   int hasblue=0, hash=0, hasv =
      0, hasshift /*, hasxuid */ , hasbold, haslg;
   int isbold=false;
   int iscjk;
   struct pschars *subrs, *chars;
   char *ND="def";
   MMSet *mm=(format==ff_mma || format==ff_mmb)?sf->mm:NULL;
   double bluescale;

   if (incid==NULL) {
      flex_max=SplineFontIsFlexible(sf, layer, flags);
      if ((subrs=initsubrs(flex_max > 0, mm))==NULL)
	 return (false);
      iscjk=SFIsCJK(sf, map);
   } else {
      flex_max=incid->flexmax;
      iscjk=incid->iscjk;
   }

   hasbold=PSDictHasEntry(sf->private, "ForceBold") != NULL;
   hasblue=PSDictHasEntry(sf->private, "BlueValues") != NULL;
   hash=PSDictHasEntry(sf->private, "StdHW") != NULL;
   hasv=PSDictHasEntry(sf->private, "StdVW") != NULL;
   hasshift=PSDictHasEntry(sf->private, "BlueShift") != NULL;
   /*hasxuid=PSDictHasEntry(sf->private,"XUID")!=NULL; */
   haslg=PSDictHasEntry(sf->private, "LanguageGroup") != NULL;
   if (sf->weight != NULL &&
       (strstrmatch(sf->weight, "Bold") != NULL ||
	strstrmatch(sf->weight, "Heavy") != NULL ||
	strstrmatch(sf->weight, "Black") != NULL ||
	strstrmatch(sf->weight, "Grass") != NULL ||
	strstrmatch(sf->weight, "Fett") != NULL))
      isbold=true;
   if (sf->pfminfo.pfmset && sf->pfminfo.weight >= 700)
      isbold=true;

   if (autohint_before_generate && SFNeedsAutoHint(sf, layer) &&
       !(flags & ps_flag_nohints)) {
      SplineFontAutoHint(sf, layer);
   }

   otherblues[0]=otherblues[1]=bluevalues[0]=bluevalues[1]=0;
   if (!hasblue) {
      FindBlues(sf, layer, bluevalues, otherblues);
   }
   bluescale=BlueScaleFigure(sf->private, bluevalues, otherblues);

   if (!hash || !hasv)
      stdhw[0]=stdvw[0]=0;
   if (!hash) {
      FindHStems(sf, stemsnaph, snapcnt);
      mi=-1;
      for (i=0; i < 12 && stemsnaph[i] != 0; ++i)
	 if (mi==-1)
	    mi=i;
	 else if (snapcnt[i] > snapcnt[mi])
	    mi=i;
      if (mi != -1)
	 stdhw[0]=stemsnaph[mi];
   }

   if (!hasv) {
      FindVStems(sf, stemsnapv, snapcnt);
      mi=-1;
      for (i=0; stemsnapv[i] != 0 && i < 12; ++i)
	 if (mi==-1)
	    mi=i;
	 else if (snapcnt[i] > snapcnt[mi])
	    mi=i;
      if (mi != -1)
	 stdvw[0]=stemsnapv[mi];
   }

   if (incid==NULL) {
      if ((chars =
	   SplineFont2ChrsSubrs(sf, iscjk, subrs, flags, format,
				layer))==NULL)
	 return (false);
   }

   if (incid==NULL)
      afputs("dup\n",f);
   cnt=0;
   if (!hasblue)
      ++cnt;			/* bluevalues is required, but might be in private */
   if (!hasshift && flex_max >= 7)
      ++cnt;			/* BlueShift needs to be specified if flex wants something bigger than default */
   if (bluescale != -1)
      ++cnt;
   ++cnt;			/* minfeature is required */
   if (!hasblue && (otherblues[0] != 0 || otherblues[1] != 0))
      ++cnt;
   ++cnt;			/* password is required */
   if (sf->tempuniqueid != 0 && sf->use_uniqueid)
      ++cnt;			/* UniqueID should be in both private and public areas */
   if (incid==NULL) {
      ++cnt;			/* nd is required */
      ++cnt;			/* np is required */
      ++cnt;			/* rd is required */
   }
   if (!haslg && iscjk)
      ++cnt;
   if (!hash) {
      if (stdhw[0] != 0)
	 ++cnt;
      if (stemsnaph[0] != 0)
	 ++cnt;
   }
   if (!hasv) {
      if (stdvw[0] != 0)
	 ++cnt;
      if (stemsnapv[0] != 0)
	 ++cnt;
   }
   cnt += sf->private != NULL?sf->private->next:0;
   if (incid==NULL) {
      ++cnt;			/* Subrs entry */
      ++cnt;			/* Other Subrs */
   } else {
      cnt += 3;			/* subrmap, etc. */
      ++cnt;			/* Other Subrs */
   }
   if (flex_max > 0)
      ++cnt;
   if (hasbold || isbold)
      ++cnt;

   afprintf(f,"/Private %d dict dup begin\n", cnt);
   /* These guys are required and fixed */
   if (incid==NULL) {
      afputs("/RD{string currentfile exch readstring pop}executeonly def\n",f);
      afputs("/ND{noaccess def}executeonly def\n",f);
      afputs("/NP{noaccess put}executeonly def\n",f);
      ND="ND";
   }
   afprintf(f,"/MinFeature{16 16}%s\n", ND);
   afputs("/password 5839 def\n",f);
   if (!hasblue) {
      dumpblues(f, "BlueValues", bluevalues, 14, ND);
      if (otherblues[0] != 0 || otherblues[1] != 0)
	 dumpblues(f, "OtherBlues", otherblues, 10, ND);
   }
   if (!hash) {
      if (stdhw[0] != 0)
	 afprintf(f,"/StdHW [%g] %s\n", (double) stdhw[0], ND);
      if (stemsnaph[0] != 0)
	 dumpdblmaxarray(f, "StemSnapH", stemsnaph, 12, "", ND);
   }
   if (!hasv) {
      if (stdvw[0] != 0)
	 afprintf(f,"/StdVW [%g] %s\n", (double) stdvw[0], ND);
      if (stemsnapv[0] != 0)
	 dumpdblmaxarray(f, "StemSnapV", stemsnapv, 12, "", ND);
   }
   if (!hasshift && flex_max >= 7)
      afprintf(f,"/BlueShift %d def\n", flex_max + 1);
   if (bluescale != -1)
      afprintf(f,"/BlueScale %g def\n", bluescale);
   if (isbold && !hasbold)
      afprintf(f,"/ForceBold true def\n");
   if (!haslg && iscjk)
      afprintf(f,"/LanguageGroup 1 def\n");
   if (sf->tempuniqueid != 0 && sf->tempuniqueid != -1 && sf->use_uniqueid)
      afprintf(f,"/UniqueID %d def\n", sf->tempuniqueid);
   if (sf->private != NULL) {
      for (i=0; i < sf->private->next; ++i) {
	 afprintf(f,"/%s ", sf->private->keys[i]);
	 afputs(sf->private->values[i],f);
	 if (strcmp(sf->private->keys[i], "BlueValues")==0 ||
	     strcmp(sf->private->keys[i], "OtherBlues")==0 ||
	     strcmp(sf->private->keys[i], "StdHW")==0 ||
	     strcmp(sf->private->keys[i], "StdVW")==0 ||
	     strcmp(sf->private->keys[i], "StemSnapH")==0 ||
	     strcmp(sf->private->keys[i], "StemSnapV")==0)
	    afprintf(f," %s\n", ND);
	 else
	    afputs(" def\n",f);
      }
   }

   if (mm != NULL)
      dumpmmprivate(f, mm);

   dumpothersubrs(f, incid != NULL, flex_max > 0, iscjk, mm);
   if (incid != NULL) {
      afprintf(f," /SubrMapOffset %d def\n", incid->subrmapoff);
      afprintf(f," /SDBytes %d def\n", incid->sdbytes);
      afprintf(f," /SubrCount %d def\n", incid->subrcnt);
      afputs("end def\n",f);
   } else {
      dumpsubrs(f, sf, subrs);
      dumpcharstrings(f, sf, chars);
      afputs("put\n",f);

      PSCharsFree(chars);
      PSCharsFree(subrs);
   }

   return (true);
}

static void dumpfontinfo(AFILE *f,
			 SplineFont *sf, enum fontformat format) {
   int cnt=0;

   if (sf->familyname != NULL)
      ++cnt;
   if (sf->fullname != NULL)
      ++cnt;
   if (sf->copyright != NULL)
      ++cnt;
   if (sf->weight != NULL)
      ++cnt;
   if (sf->pfminfo.fstype != -1)
      ++cnt;
   if (sf->subfontcnt==0) {
      if (sf->version != NULL)
	 ++cnt;
      ++cnt;			/* ItalicAngle */
      ++cnt;			/* isfixedpitch */
      if (sf->upos != 0)
	 ++cnt;
      if (sf->uwidth != 0)
	 ++cnt;
      /* Fontographer also generates em, ascent and descent */
      /*  em is redundant, we can get that from the fontmatrix */
      /*  given em we only need one of ascent or descent */
      /*  On the off chance that fontlab objects to them let's not generate them */
      if (sf->ascent != 8 * (sf->ascent + sf->descent) / 10)
	 ++cnt;			/* ascent */
   }
   if (format==ff_mma || format==ff_mmb)
      cnt += 3;

   afprintf(f,"/FontInfo %d dict dup begin\n", cnt);
   if (sf->subfontcnt==0 && sf->version)
      afprintf(f," /version (%s) readonly def\n", sf->version);
   if (sf->copyright) {
      afprintf(f," /Notice (");
      dumpcarefully(f,sf->copyright);
      afprintf(f,") readonly def\n");
      if (strchr(sf->copyright, '\n') != NULL
	  || strchr(sf->copyright, '\r') != NULL)
	 dumpascomments(f, sf->copyright);
   }
   if (sf->fullname) {
      afprintf(f," /FullName (");
      dumpcarefully(f,sf->fullname);
      afprintf(f,") readonly def\n");
   }
   if (sf->familyname) {
      afprintf(f," /FamilyName (");
      dumpcarefully(f,sf->familyname);
      afprintf(f,") readonly def\n");
   }
   if (sf->weight)
      afprintf(f," /Weight (%s) readonly def\n", sf->weight);
   if (sf->pfminfo.fstype != -1)
      afprintf(f," /FSType %d def\n", sf->pfminfo.fstype);
   if (sf->subfontcnt==0) {
      afprintf(f," /ItalicAngle %g def\n",
	    (double) sf->italicangle);
      afprintf(f," /isFixedPitch %s def\n",
	    SFOneWidth(sf) != -1?"true":"false");
      if (format==ff_type42 || format==ff_type42cid) {
	 if (sf->upos)
	    afprintf(f," /UnderlinePosition %g def\n",
		  (double) (sf->upos / (sf->ascent + sf->descent)));
	 if (sf->uwidth)
	    afprintf(f," /UnderlineThickness %g def\n",
		  (double) (sf->uwidth / (sf->ascent + sf->descent)));
      } else {
	 if (sf->upos)
	    afprintf(f," /UnderlinePosition %g def\n",
		  (double) sf->upos);
	 if (sf->uwidth)
	    afprintf(f," /UnderlineThickness %g def\n",
		  (double) sf->uwidth);
      }
      if (sf->ascent != 8 * (sf->ascent + sf->descent) / 10)
	 afprintf(f," /ascent %d def\n", sf->ascent);
   }
   if (format==ff_mma || format==ff_mmb) {
      MMSet *mm=sf->mm;

      int j, k;

      afputs(" /BlendDesignPositions [",f);
      for (j=0; j < mm->instance_count; ++j) {
	 afputs(" [",f);
	 for (k=0; k < mm->axis_count; ++k)
	    afprintf(f,"%g ",
		  (double) mm->positions[j * mm->axis_count + k]);
	 afputs("]",f);
      }
      afputs(" ] def\n",f);

      afputs(" /BlendDesignMap [",f);
      for (k=0; k < mm->axis_count; ++k) {
	 afputs(" [",f);
	 for (j=0; j < mm->axismaps[k].points; ++j)
	    afprintf(f,"[%g %g] ",
		  (double) mm->axismaps[k].designs[j],
		  (double) mm->axismaps[k].blends[j]);
	 afputs("]",f);
      }
      afputs(" ] def\n",f);

      afputs(" /BlendAxisTypes [",f);
      for (k=0; k < mm->axis_count; ++k)
	 afprintf(f,"/%s ", mm->axes[k]);
      afputs(" ] def\n",f);
   }
   afputs("end readonly def\n",f);
}

static void dumpfontcomments(AFILE *f, SplineFont *sf, int format) {
   time_t now;
   const char *author=GetAuthor();

   time(&now);
   /* Werner points out that the DSC Version comment has a very specific */
   /*  syntax. We can't just put in a random string, must be <real> <int> */
   /* So we can sort of do that for CID fonts (give it a <revsion> of 0 */
   /*  but for type1s just use a comment rather than a DSC statement */
   if ((format==ff_cid || format==ff_cffcid || format==ff_type42cid) &&
       sf->cidregistry != NULL) {
      afprintf(f,"%%%%Title: (%s %s %s %d)\n",
	    sf->fontname, sf->cidregistry, sf->ordering, sf->supplement);
      afprintf(f,"%%%%Version: %g 0\n", sf->cidversion);
      /* CID keyed fonts are language level 3 */
   } else {
      afprintf(f,"%%%%Title: %s\n", sf->fontname);
      afprintf(f,"%%Version: %s\n", sf->version);
   }
   afprintf(f,"%%%%CreationDate: %s", ctime(&now));
   if (author != NULL)
      afprintf(f,"%%%%Creator: %s\n", author);

   if (format==ff_cid || format==ff_cffcid || format==ff_type42cid ||
       format==ff_cff || format==ff_type42)
      afprintf(f,"%%%%LanguageLevel: 3\n");
   else if (sf->multilayer && format==ff_ptype3) {
      int gid, ly;

      SplineChar *sc;

      int had_pat=0, had_grad=0;

      for (gid=0; gid < sf->glyphcnt; ++gid)
	 if ((sc=sf->glyphs[gid]) != NULL) {
	    for (ly=ly_fore; ly < sc->layer_cnt; ++ly) {
	       if (sc->layers[ly].fill_brush.gradient != NULL
		   || sc->layers[ly].stroke_pen.brush.gradient != NULL) {
		  had_grad=true;
		  break;
	       }
	       if (sc->layers[ly].fill_brush.gradient != NULL
		   || sc->layers[ly].stroke_pen.brush.gradient != NULL)
		  had_pat=true;
	    }
	 }
      if (had_grad)
	 afprintf(f,"%%%%LanguageLevel: 3\n");
      else if (had_pat)
	 afprintf(f,"%%%%LanguageLevel: 2\n");
   }

   if (sf->copyright != NULL) {
      char *pt, *strt=sf->copyright, *npt;

      while (*strt != '\0') {
	 pt=strt;
	 while (pt < strt + 60 && *pt) {
	    npt=strpbrk(pt, "\n\t\r ");
	    if (npt==NULL)
	       npt=strt + strlen(strt);
	    if (npt < strt + 60 || pt==strt) {
	       pt=npt;
	       if (isspace(*pt)) {
		  ++pt;
		  if (pt[-1]=='\n' || pt[-1]=='\r')
		     break;
	       }
	    } else
	       break;
	 }
	 afputs(strt==sf->copyright?"%Copyright: ":"%Copyright:  ",f);
	 afwrite(strt,1,*pt?pt-strt-1:pt-strt,f);
	 aputc('\n',f);
	 strt=pt;
      }
   }
   if (sf->comments != NULL)
      dumpascomments(f, sf->comments);
   afprintf(f,
	 "%% Generated by FontAnvil %d (http://tsukurimashou.sourceforge.jp/)\n",
	 FONTANVIL_VERSIONDATE_RAW);
   afputs("%%EndComments\n\n",f);
}

static void dumprequiredfontinfo(AFILE *f, SplineFont *sf, int format,
				 EncMap * map, SplineFont *fullsf,
				 int layer) {
   int cnt, i;
   double fm[6];
   char *encoding[256];
   DBounds b;
   int uniqueid;
   char buffer[50];

   afprintf(f,"%%!PS-AdobeFont-1.0: %s %s\n", sf->fontname,
	 sf->version?sf->version:"");
   if (format==ff_ptype0
       && (map->enc->is_unicodebmp || map->enc->is_unicodefull))
      afprintf(f,
	    "%%%%DocumentNeededResources: font ZapfDingbats\n");
   dumpfontcomments(f, sf, format);

   cnt=0;
   ++cnt;			/* FID, added by definefont and not by us */
   ++cnt;			/* fonttype */
   ++cnt;			/* fontmatrix */
   if (sf->fontname != NULL)
      ++cnt;
   ++cnt;			/* fontinfo */
   ++cnt;			/* encoding */
   ++cnt;			/* fontbb */
   if (sf->uniqueid != -1 && sf->use_uniqueid)
      ++cnt;
   ++cnt;			/* painttype */
   if (sf->strokedfont)
      ++cnt;			/* StrokeWidth */
   if (format==ff_ptype3) {
      ++cnt;			/* charprocs */
      ++cnt;			/* buildglyph */
      ++cnt;			/* buildchar */
   } else {
      ++cnt;			/* private */
      ++cnt;			/* chars */
   }
   if (sf->xuid != NULL && sf->use_xuid)
      ++cnt;
   if (format==ff_mma || format==ff_mmb)
      cnt += 7;

   if (sf->uniqueid==0)
      uniqueid=4000000 + (rand() & 0x3ffff);
   else
      uniqueid=sf->uniqueid;
   sf->tempuniqueid=uniqueid;

   if (format != ff_ptype3 && uniqueid != -1 && sf->use_uniqueid) {
      afprintf(f,
	    "FontDirectory/%s known{/%s findfont dup/UniqueID known{dup\n",
	    sf->fontname, sf->fontname);
      afprintf(f,
	    "/UniqueID get %d eq exch/FontType get 1 eq and}{pop false}ifelse\n",
	    uniqueid);
      afprintf(f,"{save true}{false}ifelse}{false}ifelse\n");
   }

   afprintf(f,"%d dict begin\n", cnt);
   afprintf(f,"/FontType %d def\n", format==ff_ptype3?3:1);
   fm[0]=fm[3]=1.0 / ((sf->ascent + sf->descent));
   fm[1]=fm[2]=fm[4]=fm[5]=0;
   dumpdblarray(f, "FontMatrix", fm, 6, "readonly ", false);
   if (sf->fontname != NULL)
      afprintf(f,"/FontName /%s def\n", sf->fontname);
   SplineFontLayerFindBounds(fullsf==NULL?sf:fullsf, layer, &b);
   fm[0]=floor(b.minx);
   fm[1]=floor(b.miny);
   fm[2]=ceil(b.maxx);
   fm[3]=ceil(b.maxy);
   dumpdblarray(f, "FontBBox", fm, 4, "readonly ", true);
   if (uniqueid != -1 && sf->use_uniqueid)
      afprintf(f,"/UniqueID %d def\n", uniqueid);
   if (sf->xuid != NULL && sf->use_xuid) {
      afprintf(f,"/XUID %s def\n", sf->xuid);
      if (sf->changed_since_xuidchanged)
	 SFIncrementXUID(sf);
   }
   afprintf(f,"/PaintType %d def\n", sf->strokedfont?2:0);
   if (sf->strokedfont)
      afprintf(f,"/StrokeWidth %g def\n",
	    (double) sf->strokewidth);
   dumpfontinfo(f, sf, format);
   if (format==ff_mma || format==ff_mmb) {
      MMSet *mm=sf->mm;
      int j, k;
      DBounds mb[16];
      extern const char *mmfindfont[], *makeblendedfont[];

      afputs(" /WeightVector [",f);
      for (j=0; j < mm->instance_count; ++j) {
	 afprintf(f,"%g ", (double) mm->defweights[j]);
      }
      afputs(" ] def\n",f);

      afputs(" /$Blend {",f);
      if (mm->instance_count==2)
	 afprintf(f,"%g mul add", (double) mm->defweights[1]);
      else {
	 afprintf(f,"%g mul exch", (double) mm->defweights[1]);
	 for (j=2; j < mm->instance_count - 1; ++j)
	    afprintf(f,"%g mul add exch",
		  (double) mm->defweights[j]);
	 afprintf(f,"%g mul add add", (double) mm->defweights[j]);
      }
      afputs(" } bind def\n",f);

      afputs(" /Blend 3 dict dup begin\n",f);
      for (j=0; j < mm->instance_count; ++j)
	 SplineFontLayerFindBounds(mm->instances[j], layer, &mb[j]);
      afputs("  /FontBBox{",f);
      for (k=0; k < 4; ++k) {
	 afputs("{",f);
	 for (j=0; j < mm->instance_count; ++j)
	    afprintf(f,"%g ", k==0?floor(mb[j].minx) :
		  k==1?floor(mb[j].miny) :
		  k==2?ceil(mb[j].maxx):ceil(mb[j].maxy));
	 afputs("}",f);
      }
      afputs("} def\n",f);

      afprintf(f,"  /Private %d dict def\n",
	    sf->private->next + 10);
      afputs(" end def		%End of Blend dict\n",f);

      for (j=0; makeblendedfont[j] != NULL; ++j) {
	 afputs(makeblendedfont[j],f);
	 aputc('\n',f);
      }

      afputs("\n /NormalizeDesignVector\n",f);
      afputs(mm->ndv,f);
      afputs(" bind def\n",f);

      afputs(" /ConvertDesignVector\n",f);
      afputs(mm->cdv,f);
      afputs(" bind def\n\n",f);

      for (j=0; mmfindfont[j] != NULL; ++j) {
	 afputs(mmfindfont[j],f);
	 aputc('\n',f);
      }
   }

   for (i=0; i < 256 && i < map->enccount; ++i)
      if (map->map[i] != -1 && SCWorthOutputting(sf->glyphs[map->map[i]]))
	 encoding[i]=sf->glyphs[map->map[i]]->name;
      else
	 encoding[i]=".notdef";
   for (; i < 256; ++i)
      encoding[i]=".notdef";
   if (isStdEncoding(encoding))
      afputs("/Encoding StandardEncoding def\n",f);
   else {
      afputs("/Encoding 256 array\n",f);
      /* older versions of dvipdfm assume the following line is present. */
      /*  Perhaps others do too? */
      afputs(" 0 1 255 { 1 index exch /.notdef put} for\n",f);
      for (i=0; i < 256; ++i)
	 if (strcmp(encoding[i], ".notdef") != 0)
	    afprintf(f,"dup %d/%s put\n", i, encoding[i]);
      afputs("readonly def\n",f);
   }
   if (format==ff_ptype3) {
      afputs("/BuildChar { 1 index /Encoding get exch get 1 index /BuildGlyph get exec } bind def\n",f);
      afputs("% I call all my CharProcs with two arguments, the top of the stack will be\n",f);
      afputs("%  0 and then next thing is the fontdict. If the tos is zero the char will\n",f);
      afputs("%  do a setcachedevice, otherwise (for referenced chars) it will not. The\n",f);
      afputs("%  fontdict argument is so a char can invoke a referenced char. BuildGlyph\n",f);
      afputs("%  itself will remove the arguments from the stack, the CharProc will leave 'em\n",f);
      if (sf->multilayer)
	 *buffer='\0';
      else if (sf->strokedfont)
	 sprintf(buffer, "%g setlinewidth stroke", (double) sf->strokewidth);
      else
	 strcpy(buffer, "fill");
      afprintf(f,
	    "/BuildGlyph { 2 copy exch /CharProcs get exch 2 copy known not { pop /.notdef} if get exch pop 0 exch exec pop pop %s} bind def\n",
	    buffer);
   }
}

static void dumpinitialascii(AFILE *f,SplineFont *sf, int format,
			     EncMap * map, SplineFont *fullsf, int layer) {
   dumprequiredfontinfo(f, sf, format, map, fullsf, layer);
   afputs("currentdict end\ncurrentfile eexec\n",f);
}

static void dumpencodedstuff(AFILE *f,SplineFont *sf, int format,
			     int flags, EncMap * map, int layer) {
   AFILE *obfs;

   obfs=ps_obfuscated_afile(f,(format==ff_pfb)||(format==ff_mmb));
   
   dumpprivatestuff(obfs,sf,NULL,flags,format,map,layer);
   if (format==ff_ptype0) {
      aputc('/',obfs);
      afputs(sf->fontname,obfs);
      afputs("Base exch definefont pop\n mark currentfile closefile\n",obfs);
   } else
      afputs("dup/FontName get exch definefont pop\n"
	    " mark currentfile closefile\n",obfs);
   afclose(obfs);
}

static void dumpfinalascii(AFILE *f,
			   SplineFont *sf, int format) {
   int i;
   int uniqueid=sf->uniqueid;

   /* output 512 zeros */
   aputc('\n',f);
   for (i=0; i < 8; ++i)
      afputs("0000000000000000000000000000000000000000000000000000000000000000\n",f);
   afputs("cleartomark\n",f);
   if (format != ff_ptype3 && uniqueid != -1 && sf->use_uniqueid)
      afputs("{restore}if\n",f);
}

static void mkheadercopyfile(AFILE *temp,AFILE *out,int headertype) {
   char buffer[8 * 1024];
   int len;

   /* output the file header */
   aputc('\200', out);
   aputc(headertype, out);
   len=aftell(temp);		/* output byte count */
   aputc(len & 0xff, out);
   aputc(((len >> 8) & 0xff), out);
   aputc(((len >> 16) & 0xff), out);
   aputc(((len >> 24) & 0xff), out);

   afseek(temp, 0, SEEK_SET);
   while ((len=afread(buffer, sizeof(char), sizeof(buffer), temp)) > 0)
      afwrite(buffer, sizeof(char), len, out);
   afclose(temp);		/* deletes the temporary file */
}

static void dumptype42(AFILE *out,SplineFont *sf,int format,int flags,
		       EncMap * map, int layer) {
   double fm[6];
   DBounds b;
   int uniqueid;
   int i, cnt, gid, hasnotdef;
   SplineFont *cidmaster;

   cidmaster=sf->cidmaster;
   if (sf->subfontcnt != 0) {
      cidmaster=sf;
      sf=sf->subfonts[0];
   }
   if (format==ff_type42)
      cidmaster=NULL;

   if (format==ff_type42cid) {
      afprintf(out, "%%!PS-Adobe-3.0 Resource-CIDFont\n");
      afprintf(out, "%%%%DocumentNeededResources: ProcSet (CIDInit)\n");
      afprintf(out, "%%%%IncludeResource: ProcSet (CIDInit)\n");
      afprintf(out, "%%%%BeginResource: CIDFont %s\n",
	      (cidmaster != NULL?cidmaster:sf)->fontname);
   } else
      afprintf(out, "%%!PS-TrueTypeFont\n");	/* Ignore the ttf version info */
   /* Too hard to do right, and if done right doesn't mean much to */
   /* a human observer */
   dumpfontcomments(out, cidmaster != NULL?cidmaster:sf,
		    format);

   if (format==ff_type42cid) {
      afprintf(out, "/CIDInit /ProcSet findresource begin\n\n");
      afprintf(out, "16 dict begin\n");
   } else
      afprintf(out, "12 dict begin\n");
   afprintf(out, "  /FontName /%s def\n", sf->fontname);
   if (format==ff_type42cid) {
      afprintf(out, "  /CIDFontType 2 def\n");
      /* Adobe Technical Note 5012.Type42_Spec.pdf Sec 5 CIDFontType 2 CID Fonts */
      /*  page 12 says that the FontType (not CIDFontType) of a TrueType CID font */
      /*  should be 42. The PLRM (v3) Chap 5 page 370 says the FontType should */
      /*  11.  Ain't that just grand? */
      afprintf(out, "  /FontType 11 def\n");
      afprintf(out, "  /CIDFontName /%s def\n", sf->fontname);
      /* 5012 doesn't mention this, but we probably need these... */
      afprintf(out, "  /CIDSystemInfo 3 dict dup begin\n");
      if (cidmaster != NULL) {
	 afprintf(out, "    /Registry (%s) def\n", cidmaster->cidregistry);
	 afprintf(out, "    /Ordering (%s) def\n", cidmaster->ordering);
	 afprintf(out, "    /Supplement %d def\n", cidmaster->supplement);
      } else {
	 afprintf(out, "    /Registry (Adobe) def\n");
	 afprintf(out, "    /Ordering (Identity) def\n");
	 afprintf(out, "    /Supplement 0 def\n");
      }
      afprintf(out, "  end def\n\n");
   } else
      afprintf(out, "  /FontType 42 def\n");
   afprintf(out, "  /FontMatrix [1 0 0 1 0 0] def\n");
   afprintf(out, "  /PaintType 0 def\n");
   SplineFontLayerFindBounds(sf, layer, &b);
/* The Type42 spec says that the bounding box should be scaled by the */
/*  1/emsize (to be numbers near 1.0). The example in the spec does not do */
/*  this and gives numbers you'd expect to see in a type1 font */
   fm[0]=b.minx / (sf->ascent + sf->descent);
   fm[1]=b.miny / (sf->ascent + sf->descent);
   fm[2]=b.maxx / (sf->ascent + sf->descent);
   fm[3]=b.maxy / (sf->ascent + sf->descent);
   afprintf(out, "  ");
   dumpdblarray(out, "FontBBox", fm, 4, "readonly ", true);
   dumpfontinfo(out, sf, format);

   if (sf->uniqueid==0)
      uniqueid=4000000 + (rand() & 0x3ffff);
   else
      uniqueid=sf->uniqueid;
   sf->tempuniqueid=uniqueid;
   if (uniqueid != -1 && sf->use_uniqueid)
      afprintf(out, "  /UniqueID %d def\n", uniqueid);
   if (sf->xuid != NULL && sf->use_xuid) {
      afprintf(out, "  /XUID %s def\n", sf->xuid);
      if (sf->changed_since_xuidchanged)
	 SFIncrementXUID(sf);
   }
   if (format==ff_type42) {
      afprintf(out, "  /Encoding 256 array\n");
      /* older versions of dvipdfm assume the following line is present. */
      /*  Perhaps others do too? */
      afprintf(out, "   0 1 255 { 1 index exch /.notdef put} for\n");
      for (i=0; i < 256 && i < map->enccount; ++i)
	 if ((gid=map->map[i]) != -1)
	    if (SCWorthOutputting(sf->glyphs[gid]))
	       afprintf(out, "    dup %d/%s put\n", i, sf->glyphs[gid]->name);
      afprintf(out, "  readonly def\n");
   }
   afprintf(out, "  /sfnts [\n");
   _WriteType42SFNTS(out, sf, format, flags, map, layer);
   afprintf(out, "  ] def\n");
   if (format==ff_type42) {
      hasnotdef=false;
      for (i=cnt=0; i < sf->glyphcnt; ++i) {
	 if (sf->glyphs[i] != NULL && SCWorthOutputting(sf->glyphs[i])) {
	    ++cnt;
	    if (strcmp(sf->glyphs[i]->name, ".notdef")==0)
	       hasnotdef=true;
	 }
      }
      afprintf(out, "  /CharStrings %d dict dup begin\n", cnt + 1);
      /* Why check to see if there's a notdef char in the font? If there is */
      /*  we can define the dictionary entry twice */
      /* We can, yes, but FreeType gets confused if we do. So let's check */
      if (!hasnotdef)
	 afprintf(out, "    /.notdef 0 def\n");
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL && SCWorthOutputting(sf->glyphs[i]))
	    afprintf(out, "    /%s %d def\n", sf->glyphs[i]->name,
		    sf->glyphs[i]->ttf_glyph);
      afprintf(out, "  end readonly def\n");
      afprintf(out, "FontName currentdict end definefont pop\n");
   } else {
      if (cidmaster != NULL) {
	 for (i=cnt=0; i < sf->glyphcnt; ++i)
	    if (sf->glyphs[i] != NULL && SCWorthOutputting(sf->glyphs[i]))
	       ++cnt;
	 afprintf(out, "  /CIDMap %d dict dup begin\n", cnt);
	 for (i=0; i < sf->glyphcnt; ++i)
	    if (sf->glyphs[i] != NULL && SCWorthOutputting(sf->glyphs[i]))
	       afprintf(out, "    %d %d def\n", i, sf->glyphs[i]->ttf_glyph);
	 afprintf(out, "  end readonly def\n");
	 afprintf(out, "  /CIDCount %d def\n", sf->glyphcnt);
	 afprintf(out, "  /GDBytes %d def\n", sf->glyphcnt > 65535?3:2);
      } else if (flags & ps_flag_identitycidmap) {
	 for (i=cnt=0; i < sf->glyphcnt; ++i)
	    if (sf->glyphs[i] != NULL && cnt < sf->glyphs[i]->ttf_glyph)
	       cnt=sf->glyphs[i]->ttf_glyph;
	 afprintf(out, "  /CIDCount %d def\n", cnt + 1);
	 afprintf(out, "  /GDBytes %d def\n", cnt + 1 > 65535?3:2);
	 afprintf(out, "  /CIDMap 0 def\n");
      } else {			/* Use unicode */
	 int maxu=0;

	 for (i=cnt=0; i < sf->glyphcnt; ++i)
	    if (sf->glyphs[i] != NULL && SCWorthOutputting(sf->glyphs[i]) &&
		sf->glyphs[i]->unicodeenc != -1
		&& sf->glyphs[i]->unicodeenc < 0x10000) {
	       ++cnt;
	       if (sf->glyphs[i]->unicodeenc > maxu)
		  maxu=sf->glyphs[i]->unicodeenc;
	    }
	 afprintf(out, "  /CIDMap %d dict dup begin\n", cnt);
	 afprintf(out, "    0 0 def\n");	/* .notdef doesn't have a unicode enc, will be missed. Needed */
	 if (map->enc->is_unicodebmp || map->enc->is_unicodefull) {
	    for (i=0; i < map->enccount && i < 0x10000; ++i)
	       if ((gid=map->map[i]) != -1) {
		  if (SCWorthOutputting(sf->glyphs[gid]))
		     afprintf(out, "    %d %d def\n", i,
			     sf->glyphs[gid]->ttf_glyph);
	       }
	 } else {
	    for (i=0; i < sf->glyphcnt; ++i)
	       if (sf->glyphs[i] != NULL && SCWorthOutputting(sf->glyphs[i])
		   && sf->glyphs[i]->unicodeenc != -1
		   && sf->glyphs[i]->unicodeenc < 0x10000)
		  afprintf(out, "    %d %d def\n", sf->glyphs[i]->unicodeenc,
			  sf->glyphs[i]->ttf_glyph);
	 }
	 afprintf(out, "  end readonly def\n");
	 afprintf(out, "  /GDBytes %d def\n", maxu > 65535?3:2);
	 afprintf(out, "  /CIDCount %d def\n", maxu + 1);
      }
      afprintf(out,
	      "currentdict end dup /CIDFontName get exch /CIDFont defineresource pop\nend\n");
      afprintf(out, "%%%%EndResource\n");
      afprintf(out, "%%%%EOF\n");
   }
}

static void dumpfontdict(AFILE *out,SplineFont *sf,int format,int flags,
			 EncMap * map, SplineFont *fullsf, int layer) {

/* a pfb header consists of 6 bytes, the first is 0200, the second is a */
/*  binary/ascii flag where 1=>ascii, 2=>binary, 3=>eof??, the next four */
/*  are a count of bytes between this header and the next one. First byte */
/*  is least significant */
   if (format==ff_pfb || format==ff_mmb) {
      AFILE *temp;

      temp=atmpfile();
      dumpinitialascii(temp, sf, format, map, fullsf,
		       layer);
      mkheadercopyfile(temp, out, 1);
      temp=atmpfile();
      dumpencodedstuff(temp, sf, format, flags, map, layer);
      mkheadercopyfile(temp, out, 2);
      temp=atmpfile();
      dumpfinalascii(temp, sf, format);
      mkheadercopyfile(temp, out, 1);
/* final header, 3=>eof??? */
      afputs("\200\003",out);
   } else if (format==ff_ptype3) {
      dumprequiredfontinfo(out, sf, ff_ptype3, map, NULL,
			   layer);
      dumpcharprocs(out, sf);
   } else if (format==ff_type42 || format==ff_type42cid) {
      dumptype42(out, sf, format, flags, map, layer);
   } else {
      dumpinitialascii(out, sf, format, map, fullsf,
		       layer);
      dumpencodedstuff(out, sf, format, flags, map,
		       layer);
      dumpfinalascii(out, sf, format);
   }
}

static void dumpreencodeproc(AFILE *out) {

   afprintf(out, "\n/reencodedict 10 dict def\n");
   afprintf(out, "/ReEncode\n");
   afprintf(out, "  { reencodedict begin\n");
   afprintf(out, "\t/newencoding exch def\n");
   afprintf(out, "\t/newfontname exch def\n");
   afprintf(out, "\tfindfont /basefontdict exch def\n");
   afprintf(out, "\t/newfont basefontdict maxlength dict def\n");
   afprintf(out, "\tbasefontdict\n");
   afprintf(out, "\t  { exch dup dup /FID ne exch /Encoding ne and\n");
   afprintf(out, "\t\t{ exch newfont 3 1 roll put }\n");
   afprintf(out, "\t\t{ pop pop }\n");
   afprintf(out, "\t\tifelse\n");
   afprintf(out, "\t  } forall\n");
   afprintf(out, "\tnewfont /FontName newfontname put\n");
   afprintf(out, "\tnewfont /Encoding newencoding put\n");
   afprintf(out, "\tnewfontname newfont definefont pop\n");
   afprintf(out, "\tend\n");
   afprintf(out, "  } def\n");
   afprintf(out, "\n");
}

static char *dumpnotdefenc(AFILE *out,SplineFont *sf) {
   char *notdefname;
   int i;

   /* At one point I thought the unicode replacement char 0xfffd */
   /*  was a good replacement for notdef if the font contained */
   /*  no notdef. Probably not a good idea for a PS font */
   notdefname=".notdef";
   afprintf(out, "/%sBase /%sNotDef [\n", sf->fontname, sf->fontname);
   for (i=0; i < 256; ++i)
      afprintf(out, " /%s\n", notdefname);
   afprintf(out, "] ReEncode\n\n");
   return (notdefname);
}

static int somecharsused(SplineFont *sf,int bottom,int top,EncMap *map) {
   int i;

   for (i=bottom; i <= top && i < map->enccount; ++i) {
      if (map->map[i] != -1 && SCWorthOutputting(sf->glyphs[map->map[i]]))
	 return (true);
   }
   return (false);
}

static void dumptype0stuff(AFILE *out,SplineFont *sf,EncMap *map) {
   char *notdefname;
   int i, j;
   extern char *zapfnomen[];
   extern int8_t zapfexists[];

   dumpreencodeproc(out);
   notdefname=dumpnotdefenc(out, sf);
   for (i=1; i < 256; ++i) {
      if (somecharsused(sf, i << 8, (i << 8) + 0xff, map)) {
	 afprintf(out, "/%sBase /%s%d [\n", sf->fontname, sf->fontname, i);
	 for (j=0; j < 256 && (i << 8) + j < map->enccount; ++j)
	    if (map->map[(i << 8) + j] != -1
		&& SCWorthOutputting(sf->glyphs[map->map[(i << 8) + j]]))
	       afprintf(out, " /%s\n",
		       sf->glyphs[map->map[(i << 8) + j]]->name);
	    else
	       afprintf(out, "/%s\n", notdefname);
	 for (; j < 256; ++j)
	    afprintf(out, " /%s\n", notdefname);
	 afprintf(out, "] ReEncode\n\n");
      } else if (i==0x27
		 && (map->enc->is_unicodebmp || map->enc->is_unicodefull)) {
	 afprintf(out, "%% Add Zapf Dingbats to unicode font at 0x2700\n");
	 afprintf(out, "%%  But only if on the printer, else use notdef\n");
	 afprintf(out,
		 "%%  gv, which has no Zapf, maps courier to the name\n");
	 afprintf(out,
		 "%%  so we must check a bit more than is it null or not...\n");
/* gv with no ZapfDingbats installed does weird stuff. */
/*  If I do "/ZapfDingbats findfont" then it returns "/Courier findfont" the */
/*  first time, but the second time it returns null */
/* So even if the printer thinks it's got Zapf we must check to make sure it's*/
/*  the real Zapf. We do that by examining the name. If it's ZapfDingbats all*/
/*  should be well, if it's Courier, then that counts as non-existant */
	 afprintf(out, "/ZapfDingbats findfont pop\n");
	 afprintf(out, "/ZapfDingbats findfont null eq\n");
	 afprintf(out, "{ true }\n");
	 afprintf(out,
		 " { /ZapfDingbats findfont /FontName get (ZapfDingbats) ne }\n");
	 afprintf(out, " ifelse\n");
	 afprintf(out, "{ /%s%d /%sNotDef findfont definefont pop }\n",
		 sf->fontname, i, sf->fontname);
	 afprintf(out, " { /ZapfDingbats /%s%d [\n", sf->fontname, i);
	 for (j=0; j < 0xc0; ++j)
	    afprintf(out, " /%s\n", zapfexists[j]?zapfnomen[j]:".notdef");
	 for (; j < 256; ++j)
	    afprintf(out, " /%s\n", ".notdef");
	 afprintf(out, "] ReEncode\n\n");
	 afprintf(out, "  } ifelse\n\n");
      }
   }

   afprintf(out, "/%s 21 dict dup begin\n", sf->fontname);
   afprintf(out, "/FontInfo /%sBase findfont /FontInfo get def\n",
	   sf->fontname);
   afprintf(out, "/PaintType %d def\n", sf->strokedfont?2:0);
   if (sf->strokedfont)
      afprintf(out, "/StrokeWidth %g def\n", (double) sf->strokewidth);
   afprintf(out, "/FontType 0 def\n");
   afprintf(out, "/LanguageLevel 2 def\n");
   afprintf(out, "/FontMatrix [1 0 0 1 0 0] readonly def\n");
   afprintf(out, "/FMapType 2 def\n");
   afprintf(out, "/Encoding [\n");
   for (i=0; i < 256; ++i)
      afprintf(out, " %d\n", i);
   afprintf(out, "] readonly def\n");
   afprintf(out, "/FDepVector [\n");
   afprintf(out, " /%sBase findfont\n", sf->fontname);
   for (i=1; i < 256; ++i)
      if (somecharsused(sf, i << 8, (i << 8) + 0xff, map) ||
	  (i==0x27
	   && (map->enc->is_unicodebmp || map->enc->is_unicodefull)))
	 afprintf(out, " /%s%d findfont\n", sf->fontname, i);
      else
	 afprintf(out, " /%sNotDef findfont\n", sf->fontname);
   afprintf(out, "  ] readonly def\n");
   afprintf(out, "end definefont pop\n");
   afprintf(out, "%%%%EOF\n");
}

static void dumpt1str(AFILE *binary,uint8_t *data,int len,int leniv) {
   if (leniv==-1)
      afwrite(data, sizeof(1), len, binary);
   else
      encodestrout(binary, data, len, leniv);
}

static void dump_index(AFILE *binary,int size,int val) {
   if (size >= 4)
      aputc((val >> 24) & 0xff, binary);
   if (size >= 3)
      aputc((val >> 16) & 0xff, binary);
   if (size >= 2)
      aputc((val >> 8) & 0xff, binary);
   if (size >= 1)		/* Yes, size may be 0 for the fd index */
      aputc((val) & 0xff, binary);
}

static AFILE *gencidbinarydata(SplineFont *cidmaster,
			      struct cidbytes *cidbytes, int flags,
			      EncMap * map, int layer) {
   int i, j, leniv, subrtot;
   SplineFont *sf;
   struct fddata *fd;
   AFILE *chrs, *subrs, *binary;
   char *buffer;
   long offset;
   char *pt;
   struct pschars *chars;
   int len;

   memset(cidbytes, '\0', sizeof(struct cidbytes));
   cidbytes->fdcnt=cidmaster->subfontcnt;
   cidbytes->fds=calloc(cidbytes->fdcnt, sizeof(struct fddata));
   for (i=0; i < cidbytes->fdcnt; ++i) {
      sf=cidmaster->subfonts[i];
      fd=&cidbytes->fds[i];
      fd->flexmax=SplineFontIsFlexible(sf, layer, flags);
      fd->subrs=initsubrs(fd->flexmax > 0, NULL);
      if (fd->subrs==NULL) {
	 int j;

	 for (j=0; j < i; ++j)
	    PSCharsFree(cidbytes->fds[j].subrs);
	 free(cidbytes->fds);
	 return (NULL);
      }
      fd->iscjk=SFIsCJK(sf, map);
      pt=PSDictHasEntry(sf->private, "lenIV");
      if (pt != NULL)
	 fd->leniv=strtol(pt, NULL, 10);
      else
	 fd->leniv=4;
   }
   if ((chars=CID2ChrsSubrs(cidmaster, cidbytes, flags, layer))==NULL)
      return (NULL);

   chrs=atmpfile();
   for (i=0; i < chars->next; ++i) {
      if (chars->lens[i] != 0) {
	 leniv=cidbytes->fds[cidbytes->fdind[i]].leniv;
	 dumpt1str(chrs, chars->values[i], chars->lens[i], leniv);
	 if (leniv > 0)
	    chars->lens[i] += leniv;
      }
   }
   subrs=atmpfile();
   subrtot=0;
   for (i=0; i < cidbytes->fdcnt; ++i) {
      fd=&cidbytes->fds[i];
      leniv=fd->leniv;
      for (j=0; j < fd->subrs->next; ++j) {
	 dumpt1str(subrs, fd->subrs->values[j], fd->subrs->lens[j], leniv);
	 if (leniv > 0)
	    fd->subrs->lens[j] += leniv;
      }
      fd->subrcnt=j;
      subrtot += j;
   }

   cidbytes->fdbytes=(cidbytes->fdcnt==1)?0 :
      (cidbytes->fdcnt < 256)?1:2;
   if ((cidbytes->cidcnt + 1) * (cidbytes->fdbytes + 3) +	/* size of the CID map region */
       (subrtot + 1) * 3 +	/* size of the Subr map region */
       aftell(subrs) +		/* size of the subr region */
       aftell(chrs) < 0x1000000)	/* size of the charstring region */
      /* Are all our offsets less than 3 bytes? */
      cidbytes->gdbytes=3;	/* Adobe's convention is to use 3, so don't bother checking for anything less */
   else
      cidbytes->gdbytes=4;	/* but I suppose we might need more... */

   cidbytes->errors=aferror(chrs) || aferror(subrs);

   offset=(cidbytes->cidcnt + 1) * (cidbytes->fdbytes + cidbytes->gdbytes) +
      (subrtot + 1) * cidbytes->gdbytes + aftell(subrs);
   binary=atmpfile();
   for (i=0; i < cidbytes->cidcnt; ++i) {
      dump_index(binary, cidbytes->fdbytes, cidbytes->fdind[i]);
      dump_index(binary, cidbytes->gdbytes, offset);
      offset += chars->lens[i];
   }
   dump_index(binary, cidbytes->fdbytes, -1);	/* Adobe says undefined */
   dump_index(binary, cidbytes->gdbytes, offset);
   if (aftell(binary) !=
       (cidbytes->cidcnt + 1) * (cidbytes->fdbytes + cidbytes->gdbytes))
      ErrorMsg(2,"CIDMap section the wrong length\n");

   offset=(cidbytes->cidcnt + 1) * (cidbytes->fdbytes + cidbytes->gdbytes) +
      (subrtot + 1) * cidbytes->gdbytes;
   for (i=0; i < cidbytes->fdcnt; ++i) {
      fd=&cidbytes->fds[i];
      fd->subrmapoff=aftell(binary);
      fd->sdbytes=cidbytes->gdbytes;
      fd->subrcnt=fd->subrs->next;
      for (j=0; j < fd->subrcnt; ++j) {
	 dump_index(binary, fd->sdbytes, offset);
	 offset += fd->subrs->lens[j];
      }
      PSCharsFree(fd->subrs);
   }
   dump_index(binary, cidbytes->gdbytes, offset);
   if (aftell(binary) !=
       (cidbytes->cidcnt + 1) * (cidbytes->fdbytes + cidbytes->gdbytes) +
       (subrtot + 1) * cidbytes->gdbytes)
      ErrorMsg(2,"SubrMap section the wrong length\n");

   buffer=malloc(8192);

   afseek(subrs,0,SEEK_SET);
   while ((len=afread(buffer, 1, 8192, subrs)) > 0)
      afwrite(buffer, 1, len, binary);
   afclose(subrs);

   afseek(chrs,0,SEEK_SET);
   while ((len=afread(buffer, 1, 8192, chrs)) > 0)
      afwrite(buffer, 1, len, binary);
   afclose(chrs);

   PSCharsFree(chars);
   free(cidbytes->fdind);
   cidbytes->fdind=NULL;
   free(buffer);

   cidbytes->errors |= aferror(binary);
   return (binary);
}

static int dumpcidstuff(AFILE *out,SplineFont *cidmaster,int flags,
			EncMap * map, int layer) {
   int i;
   DBounds res;
   AFILE *binary;
   SplineFont *sf;
   struct cidbytes cidbytes;
   char buffer[4096];
   long len;

   afprintf(out, "%%!PS-Adobe-3.0 Resource-CIDFont\n");
   afprintf(out, "%%%%DocumentNeededResources: ProcSet (CIDInit)\n");
/*  afprintf( out, "%%%%DocumentSuppliedResources: CIDFont (%s)\n", cidmaster->fontname ); */
/* Werner says this is inappropriate */
   afprintf(out, "%%%%IncludeResource: ProcSet (CIDInit)\n");
   afprintf(out, "%%%%BeginResource: CIDFont (%s)\n", cidmaster->fontname);
   dumpfontcomments(out, cidmaster, ff_cid);

   afprintf(out, "/CIDInit /ProcSet findresource begin\n\n");

   afprintf(out, "20 dict begin\n\n");

   afprintf(out, "/CIDFontName /%s def\n", cidmaster->fontname);
   afprintf(out, "/CIDFontVersion %g def\n", cidmaster->cidversion);
   afprintf(out, "/CIDFontType 0 def\n\n");

   afprintf(out, "/CIDSystemInfo 3 dict dup begin\n");
   afprintf(out, "  /Registry (%s) def\n", cidmaster->cidregistry);
   afprintf(out, "  /Ordering (%s) def\n", cidmaster->ordering);
   afprintf(out, "  /Supplement %d def\n", cidmaster->supplement);
   afprintf(out, "end def\n\n");

   CIDLayerFindBounds(cidmaster, layer, &res);
   afprintf(out, "/FontBBox [ %g %g %g %g ] def\n",
	   floor(res.minx), floor(res.miny), ceil(res.maxx), ceil(res.maxy));

   if (cidmaster->use_uniqueid) {
      afprintf(out, "/UIDBase %d def\n",
	      cidmaster->uniqueid?cidmaster->uniqueid:4000000 +
	      (rand() & 0x3ffff));
      if (cidmaster->xuid != NULL && cidmaster->use_xuid) {
	 afprintf(out, "/XUID %s def\n", cidmaster->xuid);
	 /* SFIncrementXUID(cidmaster); *//* Unique ID managment in CID fonts is too complex for this simple trick to work */
      }
   }

   dumpfontinfo(out, cidmaster, ff_cid);

   if ((binary =
	gencidbinarydata(cidmaster, &cidbytes, flags, map, layer))==NULL)
      return (0);

   afprintf(out, "\n/CIDMapOffset %d def\n", cidbytes.cidmapoffset);
   afprintf(out, "/FDBytes %d def\n", cidbytes.fdbytes);
   afprintf(out, "/GDBytes %d def\n", cidbytes.gdbytes);
   afprintf(out, "/CIDCount %d def\n\n", cidbytes.cidcnt);

   afprintf(out, "/FDArray %d array\n", cidbytes.fdcnt);
   for (i=0; i < cidbytes.fdcnt; ++i) {
      double factor;

      sf=cidmaster->subfonts[i];
      /* According to the PSRef Man, v3. only FontName, FontMatrix & Private */
      /*  should be defined here. But adobe's example fonts have a few */
      /*  extra entries, so I'll put them in */
      afprintf(out, "dup %d\n", i);
      afprintf(out, "\n%%ADOBeginFontDict\n");
      afprintf(out, "15 dict\n  begin\n");
      afprintf(out, "  /FontName /%s def\n", sf->fontname);
      afprintf(out, "  /FontType 1 def\n");
      factor=1.0 / (sf->ascent + sf->descent);
      afprintf(out, "  /FontMatrix [ %g 0 0 %g 0 0 ] def\n", factor, factor);
      afprintf(out, "/PaintType %d def\n", sf->strokedfont?2:0);
      if (sf->strokedfont)
	 afprintf(out, "/StrokeWidth %g def\n", (double) sf->strokewidth);
      afprintf(out, "\n  %%ADOBeginPrivateDict\n");
      dumpprivatestuff(out, sf, &cidbytes.fds[i], flags,
		       ff_cid, map, layer);
      afprintf(out, "\n  %%ADOEndPrivateDict\n");
      afprintf(out, "  currentdict end\n%%ADOEndFontDict\n put\n\n");
   }
   afprintf(out, "def\n\n");

   afseek(binary, 0, SEEK_END);
   len=aftell(binary);
   sprintf(buffer, "(Binary) %ld StartData ", len);
   afprintf(out, "%%%%BeginData: %ld Binary Bytes\n",
	   (long) (len + strlen(buffer)));
   afputs(buffer, out);

   afseek(binary, 0, SEEK_SET);
   while ((len=afread(buffer, 1, sizeof(buffer), binary)) > 0)
      afwrite(buffer, 1, len, out);
   cidbytes.errors |= aferror(binary);
   afclose(binary);
   free(cidbytes.fds);

   afprintf(out, "\n%%%%EndData\n%%%%EndResource\n%%%%EOF\n");
   return (!cidbytes.errors);
}

int _WritePSFont(AFILE *out, SplineFont *sf, enum fontformat format,
		 int flags, EncMap * map, SplineFont *fullsf, int layer) {
   char oldloc[24];
   int err=false;
   extern const char **othersubrs[];

   if (format != ff_cid && format != ff_ptype3 &&
       (othersubrs[0]==NULL || othersubrs[0][0]==NULL ||
	(othersubrs[0][1]==NULL && strcmp(othersubrs[0][0], "{}")==0)))
      flags &= ~ps_flag_noflex;

   /* make sure that all reals get output with '.' for decimal points */
   strcpy(oldloc, setlocale(LC_NUMERIC, NULL));
   setlocale(LC_NUMERIC, "C");
   if ((format==ff_mma || format==ff_mmb) && sf->mm != NULL)
      sf=sf->mm->normal;
   if (format==ff_cid)
      err =
	 !dumpcidstuff(out, sf->subfontcnt > 0?sf:sf->cidmaster, flags,
		       map, layer);
   else {
      dumpfontdict(out, sf, format, flags, map, fullsf, layer);
      if (format==ff_ptype0)
	 dumptype0stuff(out, sf, map);
   }
   setlocale(LC_NUMERIC, oldloc);
   if (aferror(out) || err)
      return (0);

   return (true);
}

int WritePSFont(char *fontname, SplineFont *sf, enum fontformat format,
		int flags, EncMap * map, SplineFont *fullsf, int layer) {
   AFILE *out;
   int ret;

   if ((out=afopen(fontname, "wb"))==NULL)
      return (0);
   ret=_WritePSFont(out, sf, format, flags, map, fullsf, layer);
   if (afclose(out)==-1)
      ret=0;
   return (ret);
}

static void dumpimageproc(AFILE *file,BDFChar *bdfc,BDFFont *font) {
   SplineFont *sf=font->sf;
   double scale=(sf->ascent + sf->descent) / font->pixelsize;
   int width=bdfc->xmax - bdfc->xmin + 1, height =
      bdfc->ymax - bdfc->ymin + 1;
   int i;
   AFILE *ps;

   /*                     wx wy ix iy urx ury setcachdevice */
   afprintf(file, "  /%s { %d 0 %d %d %d %d setcachedevice \n",
	   bdfc->sc->name, (int) rint(bdfc->width * scale),
	   (int) rint(bdfc->xmin * scale), (int) rint(bdfc->ymin * scale),
	   (int) rint((1 + bdfc->xmax) * scale),
	   (int) rint((1 + bdfc->ymax) * scale));
   afprintf(file, "\t%g %g translate %g %g scale %d %d true [%d 0 0 %d 0 0] {<~\n", bdfc->xmin * scale, bdfc->ymax * scale,	/* tx tx Translate */
	   width * scale, height * scale,	/* x y Scale */
	   width, height, width, -height);
   ps=base85_afile(file);
   if (bdfc->bytes_per_line==(width + 7) / 8)
     afwrite(bdfc->bitmap,1,height*bdfc->bytes_per_line,ps);
   else
      for (i=0; i < height; ++i)
       afwrite((bdfc->bitmap+i*bdfc->bytes_per_line),1,(width+7)/8,ps);
   afclose(ps);
   afprintf(file, "} imagemask } bind def\n");
}

int PSBitmapDump(char *filename, BDFFont * font, EncMap * map) {
   char buffer[300];
   AFILE *file;
   int i, notdefpos, cnt;
   int ret=0;
   SplineFont *sf=font->sf;

   if (filename==NULL) {
      sprintf(buffer, "%s-%d.pt3", sf->fontname, font->pixelsize);
      filename=buffer;
   }
   file=afopen(filename, "w");
   if (file==NULL)
      ErrorMsg(2,"Can't open %s\n", filename);
   else {
      for (i=0; i < font->glyphcnt; i++)
	 if (font->glyphs[i] != NULL)
	    BCPrepareForOutput(font->glyphs[i], true);
      dumprequiredfontinfo(file, sf, ff_ptype3, map, NULL,
			   ly_fore);

      cnt=0;
      notdefpos=SFFindNotdef(sf, -2);
      for (i=0; i < sf->glyphcnt; ++i)
	 if (font->glyphs[i] != NULL) {
	    if (strcmp(font->glyphs[i]->sc->name, ".notdef") != 0)
	       ++cnt;
	 }
      ++cnt;			/* one notdef entry */

      afprintf(file, "/CharProcs %d dict def\nCharProcs begin\n", cnt);

      if (notdefpos != -1 && font->glyphs[notdefpos] != NULL)
	 dumpimageproc(file, font->glyphs[notdefpos], font);
      else
	 afprintf(file,
		 "  /.notdef { %d 0 0 0 0 0 setcachedevice } bind def\n",
		 sf->ascent + sf->descent);

      for (i=0; i < sf->glyphcnt; ++i)
	 if (i != notdefpos) {
	    if (font->glyphs[i] != NULL)
	       dumpimageproc(file, font->glyphs[i], font);
	 }
      afprintf(file, "end\ncurrentdict end\n");
      afprintf(file, "/%s exch definefont\n", sf->fontname);
      ret=aferror(file)==0;
      if (afclose(file) != 0)
	 ret=false;
      for (i=0; i < font->glyphcnt; i++)
	 if (font->glyphs[i] != NULL)
	    BCRestoreAfterOutput(font->glyphs[i]);
   }
   return (ret);
}
