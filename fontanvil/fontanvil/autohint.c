/* $Id: autohint.c 4477 2015-12-06 11:35:32Z mskala $ */
/* Copyright (C) 2000-2012  George Williams
 * Copyright (C) 2015  Matthew Skala
 *
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
#include "splinefont.h"
#include "views.h"
#include "stemdb.h"
#include <utype.h>
#include <chardata.h>
#include "edgelist.h"
#include "hinttab.h"

/* to create a type 1 font we must come up with the following entries for the
  private dictionary:
    BlueValues	-- an array of 2n entries where Blue[2i]<Blue[2i+1] max n=7, Blue[i]>0
    OtherBlues	-- (optional) OtherBlue[i]<0
    	(blue zones should be at least 3 units appart)
    StdHW	-- (o) array with one entry, standard hstem height
    StdVW	-- (o) ditto vstem width
    StemSnapH	-- (o) up to 12 numbers containing various hstem heights (includes StdHW), small widths first
    StemSnapV	-- (o) ditto, vstem
This file has routines to figure out at least some of these

Also other routines to guess at good per-character hints
*/

static void AddBlue(double val,double array[5],int force) {
   val=rint(val);
   if (!force && (val < array[0] - array[1] || val > array[0] + array[1]))
      return;			/* Outside of one sd */
   if (array[3]==0 && array[4]==0)
      array[3]=array[4]=val;
   else if (val > array[4])
      array[4]=val;
   else if (val < array[3])
      array[3]=val;
}

static void MergeZones(double zone1[5],double zone2[5]) {
   if (zone1[2] != 0 && zone2[2] != 0 &&
       ((zone1[4] + 3 > zone2[3] && zone1[3] <= zone2[3]) ||
	(zone2[4] + 3 > zone1[3] && zone2[3] <= zone1[3]))) {
      if ((zone2[0] < zone1[0] - zone1[1] || zone2[0] > zone1[0] + zone1[1])
	  && (zone1[0] < zone2[0] - zone2[1]
	      || zone1[0] > zone2[0] + zone2[1]))
	 /* the means of the zones are too far appart, don't merge em */ ;
      else {
	 if (zone1[0] < zone2[0])
	    zone2[0]=zone1[0];
	 if (zone1[1] > zone2[1])
	    zone2[1]=zone1[1];
      }
      zone1[2]=0;
   }
}

/* I can deal with latin, greek and cyrillic because the they all come from */
/*  the same set of letter shapes and have all evolved together and have */
/*  various common features (ascenders, descenders, lower case, etc.). Other */
/*  scripts don't fit */
void FindBlues(SplineFont *sf,int layer,double blues[14],double otherblues[10]) {
   double zone[7][5];
   int i,j,k;
   DBounds b;
   
   /* zero out all zones */
   for (i=0;i<7;i++)
     for (j=0;j<5;j++)
       zone[i][j]=0;
   
   /* first pass:  compute statistics on things that might define the zones */
   for (i=0;i<sf->glyphcnt;i++)
     if ((sf->glyphs[i]!=NULL) &&
	 (sf->glyphs[i]->layers[layer].splines!=NULL)) {
	int enc,blue_class;

	enc=sf->glyphs[i]->unicodeenc;
	if ((enc<32) || (enc>0x4E9))
	  continue; /* FIXME only until Icemap handles ranges properly */
	blue_class=blue_zone_class_lookup(enc);
	
	if (blue_class==0)
	  continue;
	SplineCharFindBounds(sf->glyphs[i],&b);
	if ((b.miny==0) && (b.maxy==0))
	  continue;

	/* check all seven proto-blue zones */
	for (j=0;j<7;j++)
	  if ((blue_class&(1<<j))!=0) {
	     if ((j==bzci_base) || (j==bzci_descenth)) {
		zone[j][0]+=b.miny;
		zone[j][1]+=(b.miny*b.miny);
	     } else {
		zone[j][0]+=b.maxy;
		zone[j][1]+=(b.maxy*b.maxy);
	     }
	     zone[j][2]++;
	  }
     }
   
   /* check whether numerals are old style */
   if ((zone[bzci_digith][2]>0) && (zone[bzci_otherdigits][2]>0) &&
       ((zone[bzci_otherdigits][0]/zone[bzci_otherdigits][2])>
	   0.95*(zone[bzci_digith][0]/zone[bzci_digith][2]))) {
      /* no, 6 and 8 are about the same height as the others */
      /* in that case, accumulate others with 6 and 8 */
      zone[bzci_digith][0]+=zone[bzci_otherdigits][0];
      zone[bzci_digith][1]+=zone[bzci_otherdigits][1];
      zone[bzci_digith][2]+=zone[bzci_otherdigits][2];
   }
   /* note "other digits" are not further used */
   
   /* compute sample mean and std. dev., for samples of 2 or more items */
   for (j=0;j<6;j++)
     if (zone[j][2]>1) {
	zone[j][1]=sqrt((zone[j][1]-zone[j][0]*zone[j][0]/zone[j][2])
			/(zone[j][2]-1));
	zone[j][0]/=zone[j][2];
     }
   /* initial acceptance range is +-1 sigma from mean */

   /* force zero to be included in base acceptance range */
   if (zone[bzci_base][0]+zone[bzci_base][1]<0)
     zone[bzci_base][1]=-zone[bzci_base][0];
   if (zone[bzci_base][0]-zone[bzci_base][1]>0)
     zone[bzci_base][1]=zone[bzci_base][0];

   /* second pass:  find range of accepted values */
   for (i=0;i<sf->glyphcnt;i++)
     if ((sf->glyphs[i]!=NULL) &&
	 (sf->glyphs[i]->layers[layer].splines!=NULL)) {
	int enc,blue_class;

	enc=sf->glyphs[i]->unicodeenc;
	blue_class=blue_zone_class_lookup(enc);
	
	if (blue_class==0)
	  continue;
	SplineCharFindBounds(sf->glyphs[i],&b);
	if ((b.miny==0) && (b.maxy==0))
	  continue;
	
	/* "other" digits are now counted as digits */
	if ((blue_class&bzcm_otherdigits)!=0)
	  blue_class|=bzcm_digith;

	/* check six remaining proto-blue zones */
	for (j=0;j<6;j++)
	  AddBlue(((j==bzci_base) || (j==bzci_descenth))?b.miny:b.maxy,
		  zone[j],
		  ((j==bzci_base) && ((enc=='O') || (enc=='o'))) ||
		  ((j==bzci_xh) && ((enc=='x') || (enc=='o'))));
     }
   
   /* GW: "the descent blue zone merges into the base zone" */
   MergeZones(zone[bzci_descenth],zone[bzci_base]);
   MergeZones(zone[bzci_xh],zone[bzci_base]);
   MergeZones(zone[bzci_ascenth],zone[bzci_caph]);
   MergeZones(zone[bzci_digith],zone[bzci_caph]);
   MergeZones(zone[bzci_xh],zone[bzci_caph]);
   MergeZones(zone[bzci_ascenth],zone[bzci_digith]);
   MergeZones(zone[bzci_xh],zone[bzci_digith]);

   /* empty output arrays */
   if (otherblues!=NULL)
     for (i=0;i<10;i++)
       otherblues[i]=0;
   for (i=0;i<14;i++)
     blues[i]=0;

   /* copy descent zone into "other blues" array, if both exist */
   if ((otherblues!=NULL) && (zone[bzci_descenth][2]!=0)) {
      otherblues[0]=zone[bzci_descenth][3];
      otherblues[1]=zone[bzci_descenth][4];
   }

   /* copy five standard blue zones into output array if they exist */
   i=0;
   if ((zone[bzci_base][2]==0) &&
       ((zone[bzci_xh][2]!=0) ||
	   (zone[bzci_caph][2]!=0) ||
	   (zone[bzci_digith][2]!=0) ||
	   (zone[bzci_ascenth][2]!=0))) {
      /* must have a "base" blue zone if any of these other four are
       * present, so supply a fake one */
      blues[0]=-20;
      blues[1]=0;
      i=2;
   }
   for (j=0;j<5;j++)
     if (zone[j][2]!=0) {
	blues[i++]=zone[j][3];
	blues[i++]=zone[j][4];
     }

   /* sort */
   for (j=0;j<i;j+=2)
     for (k=j+2;k<i;k+=2) {
	if (blues[j]>blues[k]) {
	   double temp;
	   
	   temp=blues[j];
	   blues[j]=blues[k];
	   blues[k]=temp;

	   temp=blues[j+1];
	   blues[j+1]=blues[k+1];
	   blues[k+1]=temp;
	}
     }
}

static int PVAddBlues(BlueData *bd,int bcnt,char *pt) {
   char *end;
   double val1, val2;
   int i, j;

   if (pt==NULL)
      return (bcnt);

   while (isspace(*pt) || *pt=='[')
      ++pt;
   while (*pt != ']' && *pt != '\0') {
      val1=strtod(pt, &end);
      if (*end=='\0' || end==pt)
	 break;
      for (pt=end; isspace(*pt); ++pt);
      val2=strtod(pt, &end);
      if (end==pt)
	 break;
      if (bcnt==0 || val1 > bd->blues[bcnt - 1][0])
	 i=bcnt;
      else {
	 for (i=0; i < bcnt && val1 > bd->blues[i][0]; ++i);
	 for (j=bcnt; j > i; --j) {
	    bd->blues[j][0]=bd->blues[j - 1][0];
	    bd->blues[j][1]=bd->blues[j - 1][1];
	 }
      }
      bd->blues[i][0]=val1;
      bd->blues[i][1]=val2;
      ++bcnt;
      if (bcnt >= sizeof(bd->blues) / sizeof(bd->blues[0]))
	 break;
      for (pt=end; isspace(*pt); ++pt);
   }
   return (bcnt);
}

/* Quick and dirty (and sometimes wrong) approach to figure out the common */
/* alignment zones in latin (greek, cyrillic) alphabets */
void QuickBlues(SplineFont *_sf, int layer, BlueData * bd) {
   double xheight=-1e10, caph=-1e10, ascent=-1e10, descent =
      1e10, max, min;
   double xheighttop=-1e10, caphtop=-1e10;
   double numh=-1e10, numhtop=-1e10;
   double base=-1e10, basebelow=1e10;
   SplineFont *sf;
   SplinePoint *sp;
   SplineSet *spl;
   int i, j, bcnt;
   SplineChar *t;
   char *pt;

   /* Get the alignment zones we care most about */

   /* be careful of cid fonts */
   if (_sf->cidmaster != NULL)
      _sf=_sf->cidmaster;

   j=0;
   do {
      sf=(_sf->subfontcnt==0) ? _sf : _sf->subfonts[j];
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL) {
	    int enc=sf->glyphs[i]->unicodeenc;

	    if (enc=='I' || enc=='O' || enc=='x' || enc=='o'
		|| enc=='p' || enc=='l' ||
/* Jean-Christophe Dubacq points out that x-height should be calculated from */
/*  various characters and not just x and o. Italic "x"s often have strange */
/*  shapes */
		enc=='A' || enc==0x391 || enc==0x410 || enc=='V' || enc=='u' || enc=='v' || enc=='w' || enc=='y' || enc=='z' || enc=='7' || enc=='8' ||	/* numbers with ascenders */
		enc==0x399 || enc==0x39f || enc==0x3ba || enc==0x3bf
		|| enc==0x3c1 || enc==0x3be || enc==0x3c7
		|| enc==0x41f || enc==0x41e || enc==0x43e
		|| enc==0x43f || enc==0x440 || enc==0x452
		|| enc==0x445) {
	       t=sf->glyphs[i];
	       while (t->layers[layer].splines==NULL
		      && t->layers[layer].refs != NULL)
		  t=t->layers[layer].refs->sc;
	       max=-1e10;
	       min=1e10;
	       if (t->layers[layer].splines != NULL) {
		  for (spl=t->layers[layer].splines; spl != NULL;
		       spl=spl->next) {
		     for (sp=spl->first;;) {
			if (sp->me.y > max)
			   max=sp->me.y;
			if (sp->me.y < min)
			   min=sp->me.y;
			if (sp->next==NULL)
			   break;
			sp=sp->next->to;
			if (sp==spl->first)
			   break;
		     }
		  }
		  if (enc > 0x400) {
		     /* Only use ascent and descent here if we don't have anything better */
		     if (enc==0x41f) {
			caph=max;
			base=min;
		     } else if (enc==0x41e) {
			if (max > caphtop)
			   caphtop=max;
			basebelow=min;
		     } else if (enc==0x410) {
			if (max > caphtop)
			   caphtop=max;
		     } else if (enc==0x43f && xheight < 0)
			xheight=max;
		     else if (enc==0x445 && xheight < 0)
			xheight=max;
		     else if (enc==0x43e)
			xheighttop=max;
		     else if (enc==0x452 && ascent < 0)
			ascent=max;
		     else if (enc==0x440 && descent > 0)
			descent=min;
		  } else if (enc > 0x300) {
		     if (enc==0x399) {
			caph=max;
			base=min;
		     } else if (enc==0x391) {
			if (max > caphtop)
			   caphtop=max;
		     } else if (enc==0x39f) {
			if (max > caphtop)
			   caphtop=max;
			basebelow=min;
		     } else if (enc==0x3ba && xheight < 0)
			xheight=max;
		     else if (enc==0x3c7 && xheight < 0)
			xheight=max;
		     else if (enc==0x3bf)
			xheighttop=max;
		     else if (enc==0x3be && ascent < 0)
			ascent=max;
		     else if (enc==0x3c1 && descent > 0)
			descent=min;
		  } else {
		     if (enc=='I') {
			caph=max;
			base=min;
		     } else if (enc=='O') {
			if (max > caphtop)
			   caphtop=max;
			if (basebelow < min)
			   basebelow=min;
		     } else if (enc=='V') {
			if (basebelow < min)
			   basebelow=min;
		     } else if (enc=='A') {
			if (max > caphtop)
			   caphtop=max;
		     } else if (enc=='7')
			numh=max;
		     else if (enc=='0')
			numhtop=max;
		     else if (enc=='x' || enc=='o' || enc=='u'
			      || enc=='v' || enc=='w' || enc=='y'
			      || enc=='z') {
			if (xheighttop==-1e10)
			   xheighttop=max;
			if (xheight==-1e10)
			   xheight=max;
			if (max > xheighttop)
			   xheighttop=max;
			else if (max < xheight && max > 20)
			   xheight=max;
			if (enc=='y' && descent==1e10)
			   descent=min;
		     } else if (enc=='l')
			ascent=max;
		     else
			descent=min;
		  }
	       }
	    }
	 }
      ++j;
   } while (j < _sf->subfontcnt);

   if (basebelow==1e10)
      basebelow=-1e10;

   if (caphtop < caph)
      caphtop=caph;
   else if (caph==-1e10)
      caph=caphtop;
   if (basebelow > base)
      basebelow=base;
   else if (base==-1e10)
      base=basebelow;
   if (base==-1e10) {
      base=basebelow=0;
   }
   if (xheighttop < xheight)
      xheighttop=xheight;
   else if (xheight==-1e10)
      xheight=xheighttop;
   bd->xheight=xheight;
   bd->xheighttop=xheighttop;
   bd->caph=caph;
   bd->caphtop=caphtop;
   bd->numh=numh;
   bd->numhtop=numhtop;
   bd->ascent=ascent;
   bd->descent=descent;
   bd->base=base;
   bd->basebelow=basebelow;

   bcnt=0;
   if ((pt=PSDictHasEntry(sf->private, "BlueValues")) != NULL)
      bcnt=PVAddBlues(bd, bcnt, pt);
   if ((pt=PSDictHasEntry(sf->private, "OtherBlues")) != NULL)
      bcnt=PVAddBlues(bd, bcnt, pt);
   if (bcnt==0) {
      if (basebelow==-1e10)
	 basebelow=base;
      if (base==-1e10)
	 base=basebelow;
      if (xheight==-1e10)
	 xheight=xheighttop;
      if (xheighttop==-1e10)
	 xheighttop=xheight;
      if (caph==-1e10)
	 caph=caphtop;
      if (caphtop==-1e10)
	 caphtop=caph;
      if (numh==-1e10)
	 numh=numhtop;
      if (numhtop==-1e10)
	 numhtop=numh;
      if (numh != -1e10 && (numhtop > caph - 2 && numh < caphtop + 2)) {
	 if (numh < caph)
	    caph=numh;
	 if (numhtop > caphtop)
	    caphtop=numhtop;
	 numh=numhtop=-1e10;
      }
      if (ascent != -1e10 && (ascent > caph - 2 && ascent < caphtop + 2)) {
	 if (ascent < caph)
	    caph=ascent;
	 if (ascent > caphtop)
	    caphtop=ascent;
	 ascent=-1e10;
      }
      if (ascent != -1e10 && (ascent > numh - 2 && ascent < numhtop + 2)) {
	 if (ascent < numh)
	    numh=ascent;
	 if (ascent > numhtop)
	    numhtop=ascent;
	 ascent=-1e10;
	 if (numhtop > caph - 2 && numh < caphtop + 2) {
	    if (numh < caph)
	       caph=numh;
	    if (numhtop > caphtop)
	       caphtop=numhtop;
	    numh=numhtop=-1e10;
	 }
      }

      if (descent != 1e10) {
	 bd->blues[0][0]=bd->blues[0][1]=descent;
	 ++bcnt;
      }
      if (basebelow != -1e10) {
	 bd->blues[bcnt][0]=basebelow;
	 bd->blues[bcnt][1]=base;
	 ++bcnt;
      }
      if (xheight != -1e10) {
	 bd->blues[bcnt][0]=xheight;
	 bd->blues[bcnt][1]=xheighttop;
	 ++bcnt;
      }
      if (numh != -1e10) {
	 bd->blues[bcnt][0]=numh;
	 bd->blues[bcnt][1]=numhtop;
	 ++bcnt;
      }
      if (caph != -1e10) {
	 bd->blues[bcnt][0]=caph;
	 bd->blues[bcnt][1]=caphtop;
	 ++bcnt;
      }
      if (ascent != -1e10) {
	 bd->blues[bcnt][0]=bd->blues[bcnt][1]=ascent;
	 ++bcnt;
      }
   }
   bd->bluecnt=bcnt;
}

void ElFreeEI(EIList * el) {
   EI *e, *next;

   for (e=el->edges; e != NULL; e=next) {
      next=e->next;
      free(e);
   }
}

static int EIAddEdge(Spline *spline,double tmin,double tmax,EIList *el) {
   EI *new=calloc(1, sizeof(EI));
   double min, max, temp;
   Spline1D *s;
   double dxdtmin, dxdtmax, dydtmin, dydtmax;

   new->spline=spline;
   new->tmin=tmin;
   new->tmax=tmax;

   s=&spline->splines[1];
   if ((dydtmin=(3 * s->a * tmin + 2 * s->b) * tmin + s->c) < 0)
      dydtmin=-dydtmin;
   if ((dydtmax=(3 * s->a * tmax + 2 * s->b) * tmax + s->c) < 0)
      dydtmax=-dydtmax;
   s=&spline->splines[0];
   if ((dxdtmin=(3 * s->a * tmin + 2 * s->b) * tmin + s->c) < 0)
      dxdtmin=-dxdtmin;
   if ((dxdtmax=(3 * s->a * tmax + 2 * s->b) * tmax + s->c) < 0)
      dxdtmax=-dxdtmax;

   /*s=&spline->splines[0]; */
   min=((s->a * tmin + s->b) * tmin + s->c) * tmin + s->d;
   max=((s->a * tmax + s->b) * tmax + s->c) * tmax + s->d;
   if (tmax==1)
      max=spline->to->me.x;	/* beware rounding errors */
   if (!el->leavetiny && floor(min)==floor(max)) {	/* If it doesn't cross a pixel boundary then it might as well be vertical */
      if (tmin==0)
	 max=min;
      else if (tmax==1)
	 min=max;
      else
	 max=min;
   }
   if (min==max)
      new->vert=true;
   else if (min < max)
      new->hup=true;
   else {
      temp=min;
      min=max;
      max=temp;
   }
   if (!el->leavetiny && min + 1 > max)
      new->almostvert=true;
   if (40 * dxdtmin < dydtmin)
      new->vertattmin=true;
   if (40 * dxdtmax < dydtmax)
      new->vertattmax=true;
   /*if ( new->vertattmin && new->vertattmax && s->a==0 && s->b==0 ) new->almostvert=true; */
   new->coordmin[0]=min;
   new->coordmax[0]=max;
   if (el->coordmin[0] > min)
      el->coordmin[0]=min;
   if (el->coordmax[0] < max)
      el->coordmax[0]=max;

   s=&spline->splines[1];
   min=((s->a * tmin + s->b) * tmin + s->c) * tmin + s->d;
   max=((s->a * tmax + s->b) * tmax + s->c) * tmax + s->d;
   if (tmax==1)
      max=spline->to->me.y;
   if (!el->leavetiny && floor(min)==floor(max)) {	/* If it doesn't cross a pixel boundary then it might as well be horizontal */
      if (tmin==0)
	 max=min;
      else if (tmax==1)
	 min=max;
      else
	 max=min;
   }
   if (min==max)
      new->hor=true;
   else if (min < max)
      new->vup=true;
   else {
      temp=min;
      min=max;
      max=temp;
   }
   if (!el->leavetiny && min + 1 > max)
      new->almosthor=true;
   if (40 * dydtmin < dxdtmin)
      new->horattmin=true;
   if (40 * dydtmax < dxdtmax)
      new->horattmax=true;
   /*if ( new->horattmin && new->horattmax && s->a==0 && s->b==0 ) new->almosthor=true; */
   new->coordmin[1]=min;
   new->coordmax[1]=max;
   if (el->coordmin[1] > min)
      el->coordmin[1]=min;
   if (el->coordmax[1] < max)
      el->coordmax[1]=max;

   if (new->hor && new->vert) {
      /* This spline is too small for us to notice */
      free(new);
      return (false);
   } else {
      new->next=el->edges;
      el->edges=new;

      if (el->splinelast != NULL)
	 el->splinelast->splinenext=new;
      el->splinelast=new;
      if (el->splinefirst==NULL)
	 el->splinefirst=new;

      return (true);
   }
}

static void EIAddSpline(Spline *spline,EIList *el) {
   double ts[6], temp;
   int i, j, base, last;

   ts[0]=0;
   ts[5]=1.0;
   SplineFindExtrema(&spline->splines[0], &ts[1], &ts[2]);
   SplineFindExtrema(&spline->splines[1], &ts[3], &ts[4]);
   /* avoid teeny tiny segments, they just confuse us */
   SplineRemoveExtremaTooClose(&spline->splines[0], &ts[1], &ts[2]);
   SplineRemoveExtremaTooClose(&spline->splines[1], &ts[3], &ts[4]);
   for (i=0; i < 4; ++i)
      for (j=i + 1; j < 5; ++j) {
	 if (ts[i] > ts[j]) {
	    temp=ts[i];
	    ts[i]=ts[j];
	    ts[j]=temp;
	 }
      }
   for (base=0; ts[base]==-1; ++base);
   for (i=5; i > base; --i) {
      if (ts[i]==ts[i - 1]) {
	 for (j=i - 1; j > base; --j)
	    ts[j]=ts[j - 1];
	 ts[j]=-1;
	 ++base;
      }
   }
   last=base;
   for (i=base; i < 5; ++i)
      if (EIAddEdge(spline, ts[last], ts[i + 1], el))
	 last=i + 1;
}

void ELFindEdges(SplineChar * sc, EIList * el) {
   Spline *spline, *first;
   SplineSet *spl;

   el->sc=sc;
   if (sc->layers[el->layer].splines==NULL)
      return;

   el->coordmin[0]=el->coordmax[0] =
      sc->layers[el->layer].splines->first->me.x;
   el->coordmin[1]=el->coordmax[1] =
      sc->layers[el->layer].splines->first->me.y;

   for (spl=sc->layers[el->layer].splines; spl != NULL; spl=spl->next)
      if (spl->first->prev != NULL && spl->first->prev->from != spl->first) {
	 first=NULL;
	 for (spline=spl->first->next; spline != NULL && spline != first;
	      spline=spline->to->next) {
	    EIAddSpline(spline, el);
	    if (first==NULL)
	       first=spline;
	 }
	 if (el->splinefirst != NULL && spl->first->prev != NULL)
	    el->splinelast->splinenext=el->splinefirst;
	 el->splinelast=NULL;
	 el->splinefirst=NULL;
      }
}

static int IsBiggerSlope(EI *test,EI *base,int major) {
   int other=!major;
   double tdo, tdm, bdo, bdm, t;

   if ((major && test->vup) || (!major && test->hup))
      t=test->tmin;
   else
      t=test->tmax;
   tdm =
      (3 * test->spline->splines[major].a * t +
       2 * test->spline->splines[major].b) * t +
      test->spline->splines[major].c;
   tdo =
      (3 * test->spline->splines[other].a * t +
       2 * test->spline->splines[other].b) * t +
      test->spline->splines[other].c;

   if ((major && base->vup) || (!major && base->hup))
      t=base->tmin;
   else
      t=base->tmax;
   bdm =
      (3 * base->spline->splines[major].a * t +
       2 * base->spline->splines[major].b) * t +
      base->spline->splines[major].c;
   bdo =
      (3 * base->spline->splines[other].a * t +
       2 * base->spline->splines[other].b) * t +
      base->spline->splines[other].c;

   if (tdm==0 && bdm==0)
      return (tdo > bdo);
   if (tdo==0)
      return (tdo > 0);
   else if (bdo==0)
      return (bdo > 0);

   return (tdo / tdm > bdo / bdm);
}

void ELOrder(EIList * el, int major) {
   int other=!major;
   int pos;
   EI *ei, *prev, *test;

   el->low=floor(el->coordmin[major]);
   el->high=ceil(el->coordmax[major]);
   el->cnt=el->high - el->low + 1;
   el->ordered=calloc(el->cnt, sizeof(EI *));
   el->ends=calloc(el->cnt, 1);

   for (ei=el->edges; ei != NULL; ei=ei->next) {
      pos=ceil(ei->coordmax[major]) - el->low;
      el->ends[pos]=true;
      pos=floor(ei->coordmin[major]) - el->low;
      ei->ocur =
	 (ei->hup==ei->vup) ? ei->coordmin[other] : ei->coordmax[other];
      ei->tcur=((major && ei->vup)
		  || (!major && ei->hup)) ? ei->tmin : ei->tmax;
      if (major) {
	 ei->up=ei->vup;
	 ei->hv=(ei->vert || ei->almostvert);
	 ei->hvbottom=ei->vup ? ei->vertattmin : ei->vertattmax;
	 ei->hvtop=!ei->vup ? ei->vertattmin : ei->vertattmax;
	 if (ei->hor || ei->almosthor)
	    continue;
      } else {
	 ei->up=ei->hup;
	 ei->hv=(ei->hor || ei->almosthor);
	 ei->hvbottom=ei->hup ? ei->horattmin : ei->horattmax;
	 ei->hvtop=!ei->hup ? ei->horattmin : ei->horattmax;
	 if (ei->vert || ei->almostvert)
	    continue;
      }
      if (el->ordered[pos]==NULL || ei->ocur < el->ordered[pos]->ocur) {
	 ei->ordered=el->ordered[pos];
	 el->ordered[pos]=ei;
      } else {
	 for (prev=el->ordered[pos], test=prev->ordered; test != NULL;
	      prev=test, test=test->ordered) {
	    if (test->ocur > ei->ocur ||
		(test->ocur==ei->ocur && IsBiggerSlope(test, ei, major)))
	       break;
	 }
	 ei->ordered=test;
	 prev->ordered=ei;
      }
   }
}

static HintInstance *HIMerge(HintInstance *into,HintInstance *hi) {
   HintInstance *n, *first=NULL, *last;

   while (into != NULL && hi != NULL) {
      if (into->begin < hi->begin) {
	 n=into;
	 into=into->next;
      } else {
	 n=hi;
	 hi=hi->next;
      }
      if (first==NULL)
	 first=n;
      else
	 last->next=n;
      last=n;
   }
   if (into != NULL) {
      if (first==NULL)
	 first=into;
      else
	 last->next=into;
   } else if (hi != NULL) {
      if (first==NULL)
	 first=hi;
      else
	 last->next=hi;
   }
   return (first);
}

StemInfo *HintCleanup(StemInfo * stem, int dosort, int instance_count) {
   StemInfo *s, *p=NULL, *t, *pt, *sn;
   int swap;

   for (s=stem; s != NULL; p=s, s=s->next) {
      if (s->width < 0) {
	 s->start += s->width;
	 s->width=-s->width;
	 s->ghost=true;
      }
      s->reordered=false;
      if (p != NULL && p->start > s->start)
	 dosort=true;
   }
   if (dosort) {
      for (p=NULL, s=stem; s != NULL; p=s, s=sn) {
	 sn=s->next;
	 for (pt=s, t=sn; t != NULL; pt=t, t=t->next) {
	    if (instance_count > 1 &&
		t->u.unblended != NULL && s->u.unblended != NULL) {
	       int temp =
		  UnblendedCompare((*t->u.unblended)[0], (*s->u.unblended)[0],
				   instance_count);
	       if (temp==0)
		  swap =
		     UnblendedCompare((*t->u.unblended)[1],
				      (*s->u.unblended)[1], instance_count);
	       else
		  swap=temp < 0;
	    } else if (t->start < s->start)
	       swap=true;
	    else if (t->start > s->start)
	       swap=false;
	    else
	       swap=(t->width < s->width);
	    if (swap) {
	       s->next=t->next;
	       if (pt==s) {
		  t->next=s;
		  sn=s;
	       } else {
		  t->next=sn;
		  pt->next=s;
	       }
	       if (p==NULL)
		  stem=t;
	       else
		  p->next=t;
	       pt=s;		/* swap s and t */
	       s=t;
	       t=pt;
	    }
	 }
      }
      /* Remove duplicates */
      if (stem != NULL)
	 for (p=stem, s=stem->next; s != NULL; s=sn) {
	    sn=s->next;
	    if (p->start==s->start && p->width==s->width
		&& p->hintnumber==s->hintnumber) {
	       p->where=HIMerge(p->where, s->where);
	       s->where=NULL;
	       p->next=sn;
	       StemInfoFree(s);
	    } else
	       p=s;
	 }
   }
   return (stem);
}

double EITOfNextMajor(EI * e, EIList * el, double sought_m) {
   /* We want to find t so that Mspline(t)=sought_m */
   /*  the curve is monotonic */
   Spline1D *msp=&e->spline->splines[el->major];
   double new_t;
   double found_m;
   double t_mmax, t_mmin;

   if (msp->a==0 && msp->b==0) {
      if (msp->c==0) {
	 ErrorMsg(2,"Hor/Vert line when not expected\n");
	 return (0);
      }
      new_t=(sought_m - msp->d) / (msp->c);
      return (new_t);
   }

   t_mmax=e->up ? e->tmax : e->tmin;
   t_mmin=e->up ? e->tmin : e->tmax;
   /* sought_m += el->low; */

   while (1) {
      new_t=(t_mmin + t_mmax) / 2;
      found_m =
	 (((msp->a * new_t + msp->b) * new_t + msp->c) * new_t + msp->d);
      if (found_m > sought_m - .001 && found_m < sought_m + .001)
	 return (new_t);
      if (found_m > sought_m) {
	 t_mmax=new_t;
      } else {
	 t_mmin=new_t;
      }
      if (t_mmax==t_mmin) {
	 ErrorMsg(2,"EITOfNextMajor failed! on %s\n",
		el->sc != NULL ? el->sc->name : "Unknown");
	 return (new_t);
      }
   }
}

EI *EIActiveListReorder(EI * active, int *change) {
   int any;
   EI *pr, *apt;

   *change=false;
   if (active != NULL) {
      any=true;
      while (any) {
	 any=false;
	 for (pr=NULL, apt=active; apt->aenext != NULL;) {
	    if (apt->ocur <= apt->aenext->ocur) {
	       /* still ordered */ ;
	       pr=apt;
	       apt=apt->aenext;
	    } else if (pr==NULL) {
	       active=apt->aenext;
	       apt->aenext=apt->aenext->aenext;
	       active->aenext=apt;
	       *change=true;
	       /* don't need to set any, since this reorder can't disorder the list */
	       pr=active;
	    } else {
	       pr->aenext=apt->aenext;
	       apt->aenext=apt->aenext->aenext;
	       pr->aenext->aenext=apt;
	       any=*change=true;
	       pr=pr->aenext;
	    }
	 }
      }
   }
   return (active);
}

EI *EIActiveEdgesRefigure(EIList * el, EI * active, double i, int major,
			  int *_change) {
   EI *apt, *pr, *npt;
   int change=false, subchange;
   int other=!major;

   /* first remove any entry which doesn't intersect the new scan line */
   /*  (ie. stopped on last line) */
   for (pr=NULL, apt=active; apt != NULL; apt=apt->aenext) {
      if (apt->coordmax[major] < i + el->low) {
	 if (pr==NULL)
	    active=apt->aenext;
	 else
	    pr->aenext=apt->aenext;
	 change=true;
      } else
	 pr=apt;
   }
   /* then move the active list to the next line */
   for (apt=active; apt != NULL; apt=apt->aenext) {
      Spline1D *osp=&apt->spline->splines[other];

      apt->tcur=EITOfNextMajor(apt, el, i + el->low);
      apt->ocur =
	 (((osp->a * apt->tcur + osp->b) * apt->tcur + osp->c) * apt->tcur +
	  osp->d);
   }
   /* reorder list */
   active=EIActiveListReorder(active, &subchange);
   if (subchange)
      change=true;

   /* Insert new nodes */
   if (el->ordered[(int) i] != NULL)
      change=true;
   for (pr=NULL, apt=active, npt=el->ordered[(int) i];
	apt != NULL && npt != NULL;) {
      if (npt->ocur < apt->ocur) {
	 npt->aenext=apt;
	 if (pr==NULL)
	    active=npt;
	 else
	    pr->aenext=npt;
	 pr=npt;
	 npt=npt->ordered;
      } else {
	 pr=apt;
	 apt=apt->aenext;
      }
   }
   while (npt != NULL) {
      npt->aenext=NULL;
      if (pr==NULL)
	 active=npt;
      else
	 pr->aenext=npt;
      pr=npt;
      npt=npt->ordered;
   }
   *_change=change;
   return (active);
}

/* Should I consider e and n to be a continuation of the same spline? */
/*  If we are at an intersection (and it's the same intersection on both) */
/*  and they go in vaguely the same direction then we should */
/* Ah, but also if they are at different intersections and are connected */
/*  by a series of horizontal/vertical lines (whichever are invisible to major)*/
/*  then we still should. */
int EISameLine(EI * e, EI * n, double i, int major) {
   EI *t;

   if (n != NULL &&		/*n->up==e->up && */
       (ceil(e->coordmin[major])==i || floor(e->coordmin[major])==i
	|| floor(e->coordmax[major])==i || ceil(e->coordmax[major])==i)
       && (ceil(n->coordmin[major])==i || floor(n->coordmin[major])==i
	   || floor(n->coordmax[major])==i
	   || ceil(n->coordmax[major])==i)) {
      if ((n==e->splinenext && n->tmin==e->tmax && n->tcur < n->tmin + .2
	   && e->tcur > e->tmax - .2) || (n->splinenext==e
					  && n->tmax==e->tmin
					  && n->tcur > n->tmax - .2
					  && e->tcur < e->tmin + .2))
	 return (true);
      /* can be separated by a horizontal/vertical line in the other direction */
      if (n->tmax==1 && e->tmin==0 && n->tcur > .8 && e->tcur < .2) {
	 t=n;
	 while ((t=t->splinenext) != e) {
	    if (t==NULL || t==n ||
		(major && !t->hor) || (!major && !t->vert))
	       return (false);
	 }
	 return (n->up==e->up);
      } else if (n->tmin==0 && e->tmax==1 && n->tcur < .2 && e->tcur > .8) {
	 t=e;
	 while ((t=t->splinenext) != n) {
	    if (t==NULL || t==e ||
		(major && !t->hor) || (!major && !t->vert))
	       return (false);
	 }
	 return (n->up==e->up);
      }
   }
   return (false);
}

int EISkipExtremum(EI * e, double i, int major) {
   EI *n=e->aenext, *t;

   if (n==NULL)
      return (false);
   if ((ceil(e->coordmin[major])==i || floor(e->coordmin[major])==i
	|| floor(e->coordmax[major])==i || ceil(e->coordmax[major])==i)
       && (ceil(n->coordmin[major])==i || floor(n->coordmin[major])==i
	   || floor(n->coordmax[major])==i
	   || ceil(n->coordmax[major])==i)) {
      if ((n==e->splinenext && n->tmin==e->tmax && n->tcur < n->tmin + .2
	   && e->tcur > e->tmax - .2) || (n->splinenext==e
					  && n->tmax==e->tmin
					  && n->tcur > n->tmax - .2
					  && e->tcur < e->tmin + .2))
	 return (n->up != e->up);
      /* can be separated by a horizontal/vertical line in the other direction */
      if (n->tmax==1 && e->tmin==0 && n->tcur > .8 && e->tcur < .2) {
	 t=n;
	 while ((t=t->splinenext) != e) {
	    if (t==NULL || t==n ||
		(major && !t->hor) || (!major && !t->vert))
	       return (false);
	 }
	 return (n->up != e->up);
      } else if (n->tmin==0 && e->tmax==1 && n->tcur < .2 && e->tcur > .8) {
	 t=e;
	 while ((t=t->splinenext) != n) {
	    if (t==NULL || t==e ||
		(major && !t->hor) || (!major && !t->vert))
	       return (false);
	 }
	 return (n->up != e->up);
      }
   }
   return (false);
}

static StemInfo *StemRemoveFlexCandidates(StemInfo *stems) {
   StemInfo *s, *t, *sn;
   const double BlueShift=7;

   /* Suppose we have something that is a flex candidate */
   /* We might get two hints from it... one from the two end points */
   /* and one from the internal point */

   if (stems==NULL)
      return (NULL);

   for (s=stems; (sn=s->next) != NULL; s=sn) {
      if (s->start + BlueShift > sn->start && s->width > 0 && sn->width > 0 &&
	  s->start + s->width - BlueShift < sn->start + sn->width &&
	  s->start + s->width + BlueShift > sn->start + sn->width &&
	  s->where != NULL && sn->where != NULL &&
	  s->where->next != NULL && sn->where->next==NULL) {
	 t=sn->next;
	 sn->next=NULL;
	 StemInfoFree(sn);
	 s->next=t;
	 sn=t;
	 if (t==NULL)
	    break;
      }
   }
   return (stems);
}

double HIlen(StemInfo * stems) {
   HintInstance *hi;
   double len=0;

   for (hi=stems->where; hi != NULL; hi=hi->next)
      len += hi->end - hi->begin;
   return (len);
}

double HIoverlap(HintInstance * mhi, HintInstance * thi) {
   HintInstance *hi;
   double len=0;
   double s, e;

   for (; mhi != NULL; mhi=mhi->next) {
      for (hi=thi; hi != NULL && hi->begin <= mhi->end; hi=hi->next) {
	 if (hi->end < mhi->begin) {
	    thi=hi;
	    continue;
	 }
	 s=hi->begin < mhi->begin ? mhi->begin : hi->begin;
	 e=hi->end > mhi->end ? mhi->end : hi->end;
	 if (e < s)
	    continue;		/* Shouldn't happen */
	 len += e - s;
      }
   }
   return (len);
}

int StemInfoAnyOverlaps(StemInfo * stems) {
   while (stems != NULL) {
      if (stems->hasconflicts)
	 return (true);
      stems=stems->next;
   }
   return (false);
}

int StemListAnyConflicts(StemInfo * stems) {
   StemInfo *s;
   int any=false;
   double end;

   for (s=stems; s != NULL; s=s->next)
      s->hasconflicts=false;
   while (stems != NULL) {
      end=stems->width < 0 ? stems->start : stems->start + stems->width;
      for (s=stems->next;
	   s != NULL
	   && (s->width > 0 ? s->start : s->start + s->width) <= end;
	   s=s->next) {
	 stems->hasconflicts=true;
	 s->hasconflicts=true;
	 any=true;
      }
      stems=stems->next;
   }
   return (any);
}

HintInstance *HICopyTrans(HintInstance * hi, double mul, double offset) {
   HintInstance *first=NULL, *last, *cur, *p;

   while (hi != NULL) {
      cur=chunkalloc(sizeof(HintInstance));
      if (mul > 0) {
	 cur->begin=hi->begin * mul + offset;
	 cur->end=hi->end * mul + offset;
	 if (first==NULL)
	    first=cur;
	 else
	    last->next=cur;
	 last=cur;
      } else {
	 cur->begin=hi->end * mul + offset;
	 cur->end=hi->begin * mul + offset;
	 if (first==NULL || cur->begin < first->begin) {
	    cur->next=first;
	    first=cur;
	 } else {
	    for (p=first, last=p->next;
		 last != NULL && cur->begin > last->begin; last=last->next);
	    p->next=cur;
	    cur->next=last;
	 }
      }
      hi=hi->next;
   }
   return (first);
}

static HintInstance *SCGuessHintPoints(SplineChar *sc,int layer,
				       StemInfo * stem, int major, int off) {
   SplinePoint *starts[20], *ends[20];
   int spt=0, ept=0;
   SplinePointList *spl;
   SplinePoint *sp, *np;
   int sm, wm, i, j, val;
   double coord;
   HintInstance *head, *test, *cur, *prev;

   for (spl=sc->layers[layer].splines; spl != NULL; spl=spl->next) {
      for (sp=spl->first;; sp=np) {
	 coord=(major ? sp->me.x : sp->me.y);
	 sm=coord >= stem->start - off && coord <= stem->start + off;
	 wm=coord >= stem->start + stem->width - off
	    && coord <= stem->start + stem->width + off;
	 if (sm && spt < 20)
	    starts[spt++]=sp;
	 if (wm && ept < 20)
	    ends[ept++]=sp;
	 if (sp->next==NULL)
	    break;
	 np=sp->next->to;
	 if (np==spl->first)
	    break;
      }
   }

   head=NULL;
   for (i=0; i < spt; ++i) {
      val=0x80000000;
      for (j=0; j < ept; ++j) {
	 if (major && starts[i]->me.y >= ends[j]->me.y - 1
	     && starts[i]->me.y <= ends[j]->me.y + 1) {
	    val=starts[i]->me.y;
	    break;
	 } else if (!major && starts[i]->me.x >= ends[j]->me.x - 1
		    && starts[i]->me.x <= ends[j]->me.x + 1) {
	    val=starts[i]->me.x;
	    break;
	 }
      }
      if (val != 0x80000000) {
	 for (prev=NULL, test=head; test != NULL && val > test->begin;
	      prev=test, test=test->next);
	 if (test==NULL || val != test->begin) {
	    cur=chunkalloc(sizeof(HintInstance));
	    cur->begin=cur->end=val;
	    cur->next=test;
	    if (prev==NULL)
	       head=cur;
	    else
	       prev->next=cur;
	 }
      }
   }
   return (head);
}

static HintInstance *StemAddHIFromActive(struct stemdata *stem,int major) {
   int i;
   HintInstance *head=NULL, *cur, *t;
   double mino, maxo;
   double dir=((double *) & stem->unit.x)[major] < 0 ? -1 : 1;

   for (i=0; i < stem->activecnt; ++i) {
      mino=dir * stem->active[i].start + ((double *) & stem->left.x)[major];
      maxo=dir * stem->active[i].end + ((double *) & stem->left.x)[major];
      cur=chunkalloc(sizeof(HintInstance));
      if (dir > 0) {
	 cur->begin=mino;
	 cur->end=maxo;
	 if (head==NULL)
	    head=cur;
	 else
	    t->next=cur;
	 t=cur;
      } else {
	 cur->begin=maxo;
	 cur->end=mino;
	 cur->next=head;
	 head=cur;
      }
   }
   return (head);
}

static HintInstance *DStemAddHIFromActive(struct stemdata *stem) {
   int i;
   HintInstance *head=NULL, *cur, *t;

   for (i=0; i < stem->activecnt; ++i) {
      cur=chunkalloc(sizeof(HintInstance));
      cur->begin=stem->active[i].start;
      cur->end=stem->active[i].end;
      if (head==NULL)
	 head=cur;
      else
	 t->next=cur;
      t=cur;
   }
   return (head);
}

static void SCGuessHVHintInstances(SplineChar *sc,int layer,StemInfo *si,
				   int is_v) {
   struct glyphdata *gd;
   struct stemdata *sd;
   double em_size=(sc->parent != NULL) ?
      sc->parent->ascent + sc->parent->descent : 1000;

   gd=GlyphDataInit(sc, layer, em_size, true);
   if (gd==NULL)
      return;
   StemInfoToStemData(gd, si, is_v);
   if (gd->stemcnt > 0) {
      sd=&gd->stems[0];
      si->where=StemAddHIFromActive(sd, is_v);
   }
   GlyphDataFree(gd);
}

static void SCGuessHintInstancesLight(SplineChar *sc,int layer,
				      StemInfo * stem, int major) {
   SplinePointList *spl;
   SplinePoint *sp, *np;
   int sm, wm, off;
   double ob, oe;
   HintInstance *s=NULL, *w=NULL, *cur, *p, *t, *n, *w2;

   /* We've got a hint (from somewhere, old data, reading in a font, user specified etc.) */
   /*  but we don't have HintInstance info. So see if we can find those data */
   /* Will get confused by stems with holes in them (for example if you make */
   /*  a hint from one side of an H to the other, it will get the whole thing */
   /*  not just the cross stem) */

   for (spl=sc->layers[layer].splines; spl != NULL; spl=spl->next) {
      for (sp=spl->first;; sp=np) {
	 sm=(major ? sp->me.x : sp->me.y)==stem->start;
	 wm=(major ? sp->me.x : sp->me.y)==stem->start + stem->width;
	 if (sp->next==NULL)
	    break;
	 np=sp->next->to;
	 if (sm || wm) {
	    if (!major) {
	       if (np->me.y==sp->me.y) {
		  ob=sp->me.x;
		  oe=np->me.x;
	       } else if (sp->nextcp.y==sp->me.y) {
		  ob=sp->me.x;
		  oe=(sp->me.x + sp->nextcp.x) / 2;
		  if (sp->prevcp.y==sp->me.y)
		     ob=(sp->prevcp.x + sp->me.x) / 2;
	       } else if (sp->prevcp.y==sp->me.y) {
		  ob=sp->me.x;
		  oe=(sp->prevcp.x + sp->me.x) / 2;
	       } else
		  sm=wm=false;
	    } else {
	       if (np->me.x==sp->me.x) {
		  ob=sp->me.y;
		  oe=np->me.y;
	       } else if (sp->nextcp.x==sp->me.x) {
		  ob=sp->me.y;
		  oe=(sp->nextcp.y + sp->me.y) / 2;
		  if (sp->prevcp.x==sp->me.x)
		     ob=(sp->prevcp.y + sp->me.y) / 2;
	       } else if (sp->prevcp.x==sp->me.x) {
		  ob=sp->me.y;
		  oe=(sp->prevcp.y + sp->me.y) / 2;
	       } else
		  sm=wm=false;
	    }
	 }
	 if (sm || wm) {
	    cur=chunkalloc(sizeof(HintInstance));
	    if (ob > oe) {
	       double temp=ob;

	       ob=oe;
	       oe=temp;
	    }
	    cur->begin=ob;
	    cur->end=oe;
	    if (sm) {
	       if (s==NULL || s->begin > cur->begin) {
		  cur->next=s;
		  s=cur;
	       } else {
		  p=s;
		  for (t=s->next; t != NULL && t->begin < cur->begin;
		       p=t, t=t->next);
		  p->next=cur;
		  cur->next=t;
	       }
	    } else {
	       if (w==NULL || w->begin > cur->begin) {
		  cur->next=w;
		  w=cur;
	       } else {
		  p=w;
		  for (t=w->next; t != NULL && t->begin < cur->begin;
		       p=t, t=t->next);
		  p->next=cur;
		  cur->next=t;
	       }
	    }
	 }
	 if (np==spl->first)
	    break;
      }
   }

   /* Now we know what the right side of the stem looks like, and we know */
   /*  what the left side looks like. They may not look the same (H for example) */
   /*  Figure out the set where both are active */
   /* Unless it's a ghost hint */
   if (stem->width==20 && s==NULL && w != NULL) {
      s=w;
      w=NULL;
   } else if (stem->width==21 && s != NULL && w==NULL) {
      /* Just use s */ ;
   } else
      for (p=NULL, t=s; t != NULL; t=n) {
	 n=t->next;
	 for (w2=w; w2 != NULL && w2->begin < t->end; w2=w2->next) {
	    if (w2->end <= t->begin)
	       continue;
	    if (w2->begin <= t->begin && w2->end >= t->end) {
	       /* Perfect match */
	       break;
	    }
	    if (w2->begin >= t->begin)
	       t->begin=w2->begin;
	    if (w2->end <= t->end) {
	       cur=chunkalloc(sizeof(HintInstance));
	       cur->begin=w2->end;
	       cur->end=t->end;
	       cur->next=n;
	       t->next=cur;
	       n=cur;
	       t->end=w2->end;
	    }
	    break;
	 }
	 if (w2 != NULL && w2->begin >= t->end)
	    w2=NULL;
	 if (w2==NULL && w != NULL) {
	    HintInstance *best=NULL;
	    double best_off=1e10, off;

	    for (w2=w; w2 != NULL; w2=w2->next) {
	       if (w2->end <= t->begin)
		  off=t->begin - w2->end;
	       else
		  off=w2->begin - t->end;
	       if (best==NULL && off < best_off) {
		  best=w2;
		  best_off=off;
	       }
	    }
	    if (best != NULL && best_off < stem->width) {
	       w2=best;
	       if (w2->begin < t->begin)
		  t->begin=w2->begin;
	       if (w2->end > t->end)
		  t->end=w2->end;
	    }
	 }
	 if (w2==NULL) {
	    /* No match for t (or if there were it wasn't complete) get rid */
	    /*  of what's left of t */
	    chunkfree(t, sizeof(*t));
	    if (p==NULL)
	       s=n;
	    else
	       p->next=n;
	 } else
	    p=t;
      }
   while (w != NULL) {
      n=w->next;
      chunkfree(w, sizeof(*w));
      w=n;
   }

   /* If we couldn't find anything, then see if there are two points which */
   /*  have the same x or y value and whose other coordinates match those of */
   /*  the hint */
   /* Surprisingly many fonts have hints which don't accurately match the */
   /*  points. Perhaps BlueFuzz (default 1) applies here too */
   for (off=0; off < 1 && s==NULL; ++off)
      s=SCGuessHintPoints(sc, layer, stem, major, off);

   stem->where=s;
}

static StemInfo *StemInfoAdd(StemInfo *list,StemInfo *new) {
   StemInfo *prev, *test;

   for (prev=NULL, test=list; test != NULL && new->start > test->start;
	prev=test, test=test->next);
   if (test != NULL && test->start==new->start && test->width==new->width) {
      /* Replace the old with the new */
      /* can't just free the new, because the Guess routines depend on it */
      /*  being around */
      new->next=test->next;
      StemInfoFree(test);
   } else
      new->next=test;
   if (prev==NULL)
      list=new;
   else
      prev->next=new;
   return (list);
}

void SCGuessHintInstancesList(SplineChar * sc, int layer, StemInfo * hstem,
			      StemInfo * vstem, DStemInfo * dstem,
			      int hvforce, int dforce) {
   struct glyphdata *gd;
   struct stemdata *sd;
   int i, cnt=0, hneeds_gd=false, vneeds_gd=false, dneeds_gd=false;
   StemInfo *test;
   DStemInfo *dtest;
   double em_size=(sc->parent != NULL) ?
      sc->parent->ascent + sc->parent->descent : 1000;

   if (hstem==NULL && vstem==NULL && dstem==NULL)
      return;
   /* If all stems already have active zones assigned (actual for .sfd */
   /* files), then there is no need to wast time generating glyph data for */
   /* this glyph */
   test=hstem;
   while (!hneeds_gd && test != NULL) {
      if (test->where==NULL || hvforce)
	 hneeds_gd=true;
      test=test->next;
   }
   test=vstem;
   while (!vneeds_gd && test != NULL) {
      if (test->where==NULL || hvforce)
	 vneeds_gd=true;
      test=test->next;
   }
   dtest=dstem;
   while (!dneeds_gd && dtest != NULL) {
      if (dtest->where==NULL || dforce)
	 dneeds_gd=true;
      dtest=dtest->next;
   }
   if (!hneeds_gd && !vneeds_gd && !dneeds_gd)
      return;

   gd=GlyphDataInit(sc, layer, em_size, !dneeds_gd);
   if (gd==NULL)
      return;

   cnt=0;
   if (hstem != NULL && hneeds_gd) {
      gd=StemInfoToStemData(gd, hstem, false);
      for (i=cnt; i < gd->stemcnt; i++) {
	 sd=&gd->stems[i];
	 if (hstem==NULL)
	    break;
	 if (hstem->where==NULL || hvforce)
	    hstem->where=StemAddHIFromActive(sd, false);
	 hstem=hstem->next;
      }
   }
   cnt=gd->stemcnt;
   if (vstem != NULL && vneeds_gd) {
      gd=StemInfoToStemData(gd, vstem, true);
      for (i=cnt; i < gd->stemcnt; i++) {
	 sd=&gd->stems[i];
	 if (vstem==NULL)
	    break;
	 if (vstem->where==NULL || hvforce)
	    vstem->where=StemAddHIFromActive(sd, true);
	 vstem=vstem->next;
      }
   }
   cnt=gd->stemcnt;
   if (dstem != NULL && dneeds_gd) {
      gd=DStemInfoToStemData(gd, dstem);
      for (i=cnt; i < gd->stemcnt; i++) {
	 sd=&gd->stems[i];
	 if (dstem==NULL)
	    break;
	 dstem->left=sd->left;
	 dstem->right=sd->right;
	 if (dstem->where==NULL || dforce)
	    dstem->where=DStemAddHIFromActive(sd);
	 dstem=dstem->next;
      }
   }
   GlyphDataFree(gd);
   return;
}

void SCGuessDHintInstances(SplineChar * sc, int layer, DStemInfo * ds) {
   struct glyphdata *gd;
   struct stemdata *sd;
   double em_size=(sc->parent != NULL) ?
      sc->parent->ascent + sc->parent->descent : 1000;

   gd=GlyphDataInit(sc, layer, em_size, false);
   if (gd==NULL)
      return;
   DStemInfoToStemData(gd, ds);
   if (gd->stemcnt > 0) {
      sd=&gd->stems[0];
      ds->left=sd->left;
      ds->right=sd->right;
      ds->where=DStemAddHIFromActive(sd);
      if (ds->where==NULL)
	 ErrorMsg(2,"Couldn't figure out where this hint is active\n");
   }
   GlyphDataFree(gd);
}

void SCGuessHHintInstancesAndAdd(SplineChar * sc, int layer, StemInfo * stem,
				 double guess1, double guess2) {
   SCGuessHVHintInstances(sc, layer, stem, 0);
   sc->hstem=StemInfoAdd(sc->hstem, stem);
   if (stem->where==NULL && guess1 != 0x80000000) {
      if (guess1 > guess2) {
	 double temp=guess1;

	 guess1=guess2;
	 guess2=temp;
      }
      stem->where=chunkalloc(sizeof(HintInstance));
      stem->where->begin=guess1;
      stem->where->end=guess2;
   }
   sc->hconflicts=StemListAnyConflicts(sc->hstem);
   if (stem->hasconflicts) {
      /*StemInfoReduceOverlap(sc->hstem,stem); *//* User asked for it, assume he knows what he's doing */
      if (stem->where==NULL)
	 ErrorMsg(2,"Couldn't figure out where this hint is active\n");
   }
}

void SCGuessVHintInstancesAndAdd(SplineChar * sc, int layer, StemInfo * stem,
				 double guess1, double guess2) {
   SCGuessHVHintInstances(sc, layer, stem, 1);
   sc->vstem=StemInfoAdd(sc->vstem, stem);
   if (stem->where==NULL && guess1 != 0x80000000) {
      if (guess1 > guess2) {
	 double temp=guess1;

	 guess1=guess2;
	 guess2=temp;
      }
      stem->where=chunkalloc(sizeof(HintInstance));
      stem->where->begin=guess1;
      stem->where->end=guess2;
   }
   sc->vconflicts=StemListAnyConflicts(sc->vstem);
   if (stem->hasconflicts) {
      /*StemInfoReduceOverlap(sc->vstem,stem); *//* User asked for it, assume he knows what he's doing */
      if (stem->where==NULL)
	 ErrorMsg(2,"Couldn't figure out where this hint is active\n");
   }
}

void SCGuessHHintInstancesList(SplineChar * sc, int layer) {
   StemInfo *h;

   for (h=sc->hstem; h != NULL; h=h->next) {
      if (h->where==NULL) {
	 SCGuessHintInstancesLight(sc, layer, h, false);
      }
   }
}

void SCGuessVHintInstancesList(SplineChar * sc, int layer) {
   StemInfo *h;

   for (h=sc->vstem; h != NULL; h=h->next) {
      if (h->where==NULL) {
	 SCGuessHintInstancesLight(sc, layer, h, true);
      }
   }
}

/* We have got (either from a file or user specified) a diagonal stem, 
   described by 4 base points (pairs of x and y coordinates). Some additional 
   tests are required before we can add this stem to the given glyph. */
int MergeDStemInfo(SplineFont *sf, DStemInfo ** ds, DStemInfo * test) {
   DStemInfo *dn, *cur, *prev, *next, *temp;
   double dot, loff, roff, soff, dist_error_diag;
   double ibegin, iend;
   int overlap;
   BasePoint *base, *nbase, *pbase;
   HintInstance *hi;

   if (*ds==NULL) {
      *ds=test;
      return (true);
   }
   dist_error_diag=(sf->ascent + sf->descent) * 0.0065;

   cur=prev=NULL;
   for (dn=*ds; dn != NULL; dn=dn->next) {
      prev=cur;
      cur=dn;

      /* Compare the given stem with each of the existing diagonal stem
       * hints. First ensure that it is not an exact duplicate of an already
       * added stem. Then test if unit vectors are parallel and edges colinear.
       * In this case we should either preserve the existing stem or replace
       * it with the new one, but not keep them both */
      if (test->unit.x==dn->unit.x && test->unit.y==dn->unit.y &&
	  test->left.x==dn->left.x && test->left.y==dn->left.y &&
	  test->right.x==dn->right.x && test->right.y==dn->right.y) {
	 DStemInfoFree(test);
	 return (false);
      }
      dot=(test->unit.x * dn->unit.y) - (test->unit.y * dn->unit.x);
      if (dot <= -0.5 || dot >= 0.5)
	 continue;

      loff=(test->left.x - dn->left.x) * dn->unit.y -
	 (test->left.y - dn->left.y) * dn->unit.x;
      roff=(test->right.x - dn->right.x) * dn->unit.y -
	 (test->right.y - dn->right.y) * dn->unit.x;
      if (loff <= -dist_error_diag || loff >= dist_error_diag ||
	  roff <= -dist_error_diag || loff >= dist_error_diag)
	 continue;
      soff=(test->left.x - dn->left.x) * dn->unit.x +
	 (test->left.y - dn->left.y) * dn->unit.y;
      overlap=false;
      if (dn->where != NULL && test->where != NULL
	  && test->where->next==NULL) {
	 ibegin=test->where->begin + soff;
	 iend=test->where->end + soff;
	 for (hi=dn->where; hi != NULL; hi=hi->next) {
	    if ((hi->begin <= ibegin && ibegin <= hi->end) ||
		(hi->begin <= iend && iend <= hi->end) ||
		(ibegin <= hi->begin && hi->end <= iend)) {
	       overlap=true;
	       break;
	    }
	 }
      } else
	 overlap=true;
      /* It's probably a colinear dstem, as in older SFD files. Treat */
      /* it as one more instance for the already added stem */
      if (!overlap) {
	 for (hi=dn->where; hi->next != NULL; hi=hi->next);
	 hi->next=chunkalloc(sizeof(HintInstance));
	 hi->next->begin=ibegin;
	 hi->next->end=iend;
	 DStemInfoFree(test);
	 return (false);
	 /* The found stem is close but not identical to the stem we  */
	 /* are going to add. So just replace the older stem with the */
	 /* new one */
      } else {
	 test->next=dn->next;
	 if (prev==NULL)
	    *ds=test;
	 else
	    prev->next=test;
	 DStemInfoFree(dn);
	 return (true);
      }
   }

   /* Insert the given stem to the list by such a way that diagonal 
    * stems are ordered by the X coordinate of the left edge key point, and 
    * by Y if X is the same. The order is arbitrary, but may be essential for
    * things like "W". So we should be sure that the autoinstructor will 
    * process diagonals from left to right. */
   base=(test->unit.y < 0) ? &test->right : &test->left;
   nbase=((*ds)->unit.y < 0) ? &(*ds)->right : &(*ds)->left;

   if (base->x < nbase->x || (base->x==nbase->x && base->y >= nbase->y)) {
      temp=*ds;
      *ds=test;
      (*ds)->next=temp;
   } else {
      for (dn=*ds; dn != NULL && dn != test; dn=dn->next) {
	 next=dn->next;
	 pbase=(dn->unit.y < 0) ? &dn->right : &dn->left;
	 if (next != NULL)
	    nbase=(next->unit.y < 0) ? &next->right : &next->left;

	 if ((pbase->x < base->x ||
	      (pbase->x==base->x && pbase->y >= base->y)) &&
	     (next==NULL || base->x < nbase->x ||
	      (base->x==nbase->x && base->y >= nbase->y))) {

	    test->next=next;
	    dn->next=test;
	    break;
	 }

      }
   }
   return (true);
}

static StemInfo *RefHintsMerge(StemInfo *into,StemInfo *rh,double mul,
			       double offset, double omul, double oofset) {
   StemInfo *prev, *h, *n;
   double start, width;

   for (; rh != NULL; rh=rh->next) {
      start=rh->start * mul + offset;
      width=rh->width * mul;
      if (width < 0) {
	 start += width;
	 width=-width;
      }
      for (h=into, prev=NULL;
	   h != NULL && (start > h->start
			 || (start==h->start && width > h->width));
	   prev=h, h=h->next);
      if (h==NULL || start != h->start || width != h->width) {
	 n=chunkalloc(sizeof(StemInfo));
	 n->start=start;
	 n->width=width;
	 n->next=h;
	 if (prev==NULL)
	    into=n;
	 else
	    prev->next=n;
	 n->where=HICopyTrans(rh->where, omul, oofset);
      } else
	 h->where=HIMerge(h->where, HICopyTrans(rh->where, omul, oofset));
   }
   return (into);
}

static DStemInfo *RefDHintsMerge(SplineFont *sf,DStemInfo *into,
				 DStemInfo * rh, double xmul, double xoffset,
				 double ymul, double yoffset) {
   DStemInfo *new;
   double dmul;

   for (; rh != NULL; rh=rh->next) {
      new=chunkalloc(sizeof(DStemInfo));
      *new=*rh;
      new->left.x=xmul * new->left.x + xoffset;
      new->right.x=xmul * new->right.x + xoffset;
      new->left.y=ymul * new->left.y + yoffset;
      new->right.y=ymul * new->right.y + yoffset;
      new->next=NULL;
      if ((xmul < 0 && ymul > 0) || (xmul > 0 && ymul < 0))
	 new->unit.y=-new->unit.y;
      new->unit.x *= fabs(xmul);
      new->unit.y *= fabs(ymul);
      dmul=sqrt(pow(new->unit.x, 2) + pow(new->unit.y, 2));
      new->unit.x /= dmul;
      new->unit.y /= dmul;
      if (xmul < 0)
	 dmul=-dmul;
      new->where=HICopyTrans(rh->where, dmul, 0);

      MergeDStemInfo(sf, &into, new);
   }
   return (into);
}

static void __SplineCharAutoHint(SplineChar *sc,int layer,BlueData *bd);

static void AutoHintRefs(SplineChar *sc,int layer,BlueData *bd,
			 int picky) {
   RefChar *ref;

   /* Add hints for base characters before accent hints => if there are any */
   /*  conflicts, the base characters win */
   for (ref=sc->layers[layer].refs; ref != NULL; ref=ref->next) {
      if (ref->transform[1]==0 && ref->transform[2]==0) {
	 if (picky) {
	    if (!ref->sc->manualhints && ref->sc->changedsincelasthinted &&
		(ref->sc->layers[layer].refs != NULL &&
		 ref->sc->layers[layer].splines==NULL))
	       AutoHintRefs(ref->sc, layer, bd, true);
	 } else if (!ref->sc->manualhints && ref->sc->changedsincelasthinted)
	    __SplineCharAutoHint(ref->sc, layer, bd);
	 if (ref->sc->unicodeenc != -1 && ref->sc->unicodeenc < 0x10000 &&
	     isalnum(ref->sc->unicodeenc)) {
	    sc->hstem =
	       RefHintsMerge(sc->hstem, ref->sc->hstem, ref->transform[3],
			     ref->transform[5], ref->transform[0],
			     ref->transform[4]);
	    sc->vstem =
	       RefHintsMerge(sc->vstem, ref->sc->vstem, ref->transform[0],
			     ref->transform[4], ref->transform[3],
			     ref->transform[5]);
	    sc->dstem =
	       RefDHintsMerge(sc->parent, sc->dstem, ref->sc->dstem,
			      ref->transform[0], ref->transform[4],
			      ref->transform[3], ref->transform[5]);
	 }
      }
   }

   for (ref=sc->layers[layer].refs; ref != NULL; ref=ref->next) {
      if (ref->transform[1]==0 && ref->transform[2]==0 &&
	  (ref->sc->unicodeenc==-1 || ref->sc->unicodeenc >= 0x10000 ||
	   !isalnum(ref->sc->unicodeenc))) {
	 sc->hstem =
	    RefHintsMerge(sc->hstem, ref->sc->hstem, ref->transform[3],
			  ref->transform[5], ref->transform[0],
			  ref->transform[4]);
	 sc->vstem =
	    RefHintsMerge(sc->vstem, ref->sc->vstem, ref->transform[0],
			  ref->transform[4], ref->transform[3],
			  ref->transform[5]);
	 sc->dstem =
	    RefDHintsMerge(sc->parent, sc->dstem, ref->sc->dstem,
			   ref->transform[0], ref->transform[4],
			   ref->transform[3], ref->transform[5]);
      }
   }

   sc->vconflicts=StemListAnyConflicts(sc->vstem);
   sc->hconflicts=StemListAnyConflicts(sc->hstem);

   SCHintsChanged(sc);
}

void SCClearHints(SplineChar * sc) {
   int any=sc->hstem != NULL || sc->vstem != NULL || sc->dstem != NULL;
   int layer;

   for (layer=ly_fore; layer < sc->layer_cnt; ++layer) {
      SCClearHintMasks(sc, layer, true);
      SCClearRounds(sc, layer);
   }
   StemInfosFree(sc->hstem);
   StemInfosFree(sc->vstem);
   sc->hstem=sc->vstem=NULL;
   sc->hconflicts=sc->vconflicts=false;
   DStemInfosFree(sc->dstem);
   sc->dstem=NULL;
   MinimumDistancesFree(sc->md);
   sc->md=NULL;
   if (any)
      SCHintsChanged(sc);
}

static void _SCClearHintMasks(SplineChar *sc,int layer,int counterstoo) {
   SplineSet *spl;
   SplinePoint *sp;
   RefChar *ref;

   if (counterstoo) {
      free(sc->countermasks);
      sc->countermasks=NULL;
      sc->countermask_cnt=0;
   }

   for (spl=sc->layers[layer].splines; spl != NULL; spl=spl->next) {
      for (sp=spl->first;;) {
	 chunkfree(sp->hintmask, sizeof(HintMask));
	 sp->hintmask=NULL;
	 if (sp->next==NULL)
	    break;
	 if (sp->next->to==sp)
	   break;
	 sp=sp->next->to;
	 if (sp==spl->first)
	    break;
      }
   }

   for (ref=sc->layers[layer].refs; ref != NULL; ref=ref->next) {
      for (spl=ref->layers[0].splines; spl != NULL; spl=spl->next) {
	 for (sp=spl->first;;) {
	    chunkfree(sp->hintmask, sizeof(HintMask));
	    sp->hintmask=NULL;
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (sp==spl->first)
	       break;
	 }
      }
   }
}

static void SCFigureSimpleCounterMasks(SplineChar *sc) {
   SplineChar *scs[MmMax];
   int hadh3, hadv3, i, vbase;
   HintMask mask;
   StemInfo *h;

   if (sc->countermask_cnt != 0)
      return;

   scs[0]=sc;
   hadh3=CvtPsStem3(NULL, scs, 1, true, false);
   hadv3=CvtPsStem3(NULL, scs, 1, false, false);
   if (hadh3 || hadv3) {
      memset(mask, 0, sizeof(mask));
      if (hadh3)
	 mask[0]=0x80 | 0x40 | 0x20;
      if (hadv3) {
	 for (h=sc->hstem, vbase=0; h != NULL; h=h->next, ++vbase);
	 for (i=0; i < 3; ++i) {
	    int j=i + vbase;

	    mask[j >> 3] |= (0x80 >> (j & 7));
	 }
      }
      sc->countermask_cnt=1;
      sc->countermasks=malloc(sizeof(HintMask));
      memcpy(sc->countermasks[0], mask, sizeof(HintMask));
      return;
   }
}

/* find all the other stems (after main) which seem to form a counter group */
/*  with main. That is their stems have a considerable overlap (in the other */
/*  coordinate) with main */
static int stemmatches(StemInfo *main) {
   StemInfo *last=main, *test;
   double mlen, olen;
   int cnt;

   cnt=1;			/* for the main stem */
   main->tobeused=true;
   mlen=HIlen(main);
   for (test=main->next; test != NULL; test=test->next)
      test->tobeused=false;
   for (test=main->next; test != NULL; test=test->next) {
      if (test->used || last->start + last->width > test->start
	  || test->hintnumber==-1)
	 continue;
      olen=HIoverlap(main->where, test->where);
      if (olen > mlen / 3 && olen > HIlen(test) / 3) {
	 test->tobeused=true;
	 ++cnt;
      }
   }
   return (cnt);
}

static int FigureCounters(StemInfo *stems,HintMask mask) {
   StemInfo *h, *first;

   while (stems != NULL) {
      for (first=stems; first != NULL && first->used; first=first->next);
      if (first==NULL)
	 break;
      if (first->where==NULL || first->hintnumber==-1
	  || stemmatches(first) <= 2) {
	 first->used=true;
	 stems=first->next;
	 continue;
      }
      for (h=first; h != NULL; h=h->next) {
	 if (h->tobeused) {
	    mask[h->hintnumber >> 3] |= (0x80 >> (h->hintnumber & 7));
	    h->used=true;
	 }
      }
      return (true);
   }
   return (false);
}

void SCFigureCounterMasks(SplineChar * sc) {
   HintMask masks[30];
   uint32_t script;
   StemInfo *h;
   int mc=0, i;

   /* I'm not supporting counter hints for mm fonts */

   if (sc==NULL)
      return;

   free(sc->countermasks);
   sc->countermask_cnt=0;
   sc->countermasks=NULL;

   /* Check for h/vstem3 case */
   /* Which is allowed even for non-CJK letters */
   script=SCScriptFromUnicode(sc);
   if (script==CHR('l', 'a', 't', 'n') || script==CHR('c', 'y', 'r', 'l')
       || script==CHR('g', 'r', 'e', 'k')) {
      SCFigureSimpleCounterMasks(sc);
      return;
   }

   for (h=sc->hstem, i=0; h != NULL; h=h->next, ++i) {
      h->used=false;
      h->hintnumber=i;
   }
   for (h=sc->vstem; h != NULL; h=h->next, ++i) {
      h->used=false;
      h->hintnumber=i;
   }

   mc=0;

   while (mc < sizeof(masks) / sizeof(masks[0])) {
      memset(masks[mc], '\0', sizeof(HintMask));
      if (!FigureCounters(sc->hstem, masks[mc])
	  && !FigureCounters(sc->vstem, masks[mc]))
	 break;
      ++mc;
   }
   if (mc != 0) {
      sc->countermask_cnt=mc;
      sc->countermasks=malloc(mc * sizeof(HintMask));
      for (i=0; i < mc; ++i)
	 memcpy(sc->countermasks[i], masks[i], sizeof(HintMask));
   }
}

void SCClearHintMasks(SplineChar * sc, int layer, int counterstoo) {
   MMSet *mm=sc->parent->mm;
   int i;

   if (mm==NULL)
      _SCClearHintMasks(sc, layer, counterstoo);
   else {
      for (i=0; i < mm->instance_count; ++i) {
	 if (sc->orig_pos < mm->instances[i]->glyphcnt)
	    _SCClearHintMasks(mm->instances[i]->glyphs[sc->orig_pos], layer,
			      counterstoo);
      }
      if (sc->orig_pos < mm->normal->glyphcnt)
	 _SCClearHintMasks(mm->normal->glyphs[sc->orig_pos], layer,
			   counterstoo);
   }
}

static StemInfo *OnHHint(SplinePoint *sp,StemInfo *s) {
   StemInfo *possible=NULL;
   HintInstance *hi;

   if (sp==NULL)
      return (NULL);

   for (; s != NULL; s=s->next) {
      if (sp->me.y < s->start)
	 return (possible);
      if (s->start==sp->me.y || s->start + s->width==sp->me.y) {
	 if (!s->hasconflicts)
	    return (s);
	 for (hi=s->where; hi != NULL; hi=hi->next) {
	    if (hi->begin <= sp->me.x && hi->end >= sp->me.x)
	       return (s);
	 }
	 if (!s->used)
	    possible=s;
      }
   }
   return (possible);
}

static StemInfo *OnVHint(SplinePoint *sp,StemInfo *s) {
   StemInfo *possible=NULL;
   HintInstance *hi;

   if (sp==NULL)
      return (NULL);

   for (; s != NULL; s=s->next) {
      if (sp->me.x < s->start)
	 return (possible);
      if (s->start==sp->me.x || s->start + s->width==sp->me.x) {
	 if (!s->hasconflicts)
	    return (s);
	 for (hi=s->where; hi != NULL; hi=hi->next) {
	    if (hi->begin <= sp->me.y && hi->end >= sp->me.y)
	       return (s);
	 }
	 if (!s->used)
	    possible=s;
      }
   }
   return (possible);
}

/* Does h have a conflict with any of the stems in the list which have bits */
/*  set in the mask */
static int ConflictsWithMask(StemInfo *stems,HintMask mask,StemInfo *h) {
   while (stems != NULL && stems->start <= h->start + h->width) {
      if (stems->start + stems->width >= h->start && stems != h) {
	 if (stems->hintnumber != -1 &&
	     (mask[stems->hintnumber >> 3] &
	      (0x80 >> (stems->hintnumber & 7))))
	    return (true);
      }
      stems=stems->next;
   }
   return (false);
}

/* All instances of a MM set must have the same hint mask at all points */
static void FigureHintMask(SplineChar *scs[MmMax],SplinePoint *to[MmMax],
			   int instance_count, HintMask mask) {
   StemInfo *s;
   int i;
   SplinePoint *sp;

   memset(mask, '\0', sizeof(HintMask));

   /* Install all hints that are always active */
   i=0; {
      SplineChar *sc=scs[i];

      if (sc==NULL)
	 return;

      for (s=sc->hstem; s != NULL; s=s->next)
	 if (s->hintnumber != -1 && !s->hasconflicts)
	    mask[s->hintnumber >> 3] |= (0x80 >> (s->hintnumber & 7));
      for (s=sc->vstem; s != NULL; s=s->next)
	 if (s->hintnumber != -1 && !s->hasconflicts)
	    mask[s->hintnumber >> 3] |= (0x80 >> (s->hintnumber & 7));

      if (sc->hconflicts) {
	 for (sp=to[i]; sp != NULL;) {
	    s=OnHHint(sp, sc->hstem);
	    if (s != NULL && s->hintnumber != -1) {
	       if (ConflictsWithMask(scs[i]->hstem, mask, s))
		  break;
	       mask[s->hintnumber >> 3] |= (0x80 >> (s->hintnumber & 7));
	    }
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (to[i]==sp)
	       break;
	 }
      }
      if (sc->vconflicts) {
	 for (sp=to[i]; sp != NULL;) {
	    s=OnVHint(sp, sc->vstem);
	    if (s != NULL && s->hintnumber != -1) {
	       if (ConflictsWithMask(scs[i]->vstem, mask, s))
		  break;
	       mask[s->hintnumber >> 3] |= (0x80 >> (s->hintnumber & 7));
	    }
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (to[i]==sp)
	       break;
	 }
      }
   }
   for (i=0; i < instance_count; ++i)
      if (to[i] != NULL) {
	 chunkfree(to[i]->hintmask, sizeof(HintMask));
	 to[i]->hintmask=chunkalloc(sizeof(HintMask));
	 memcpy(to[i]->hintmask, mask, sizeof(HintMask));
      }
}

static int TestHintMask(SplineChar *scs[MmMax],SplinePoint *to[MmMax],
			int instance_count, HintMask mask) {
   StemInfo *h=NULL, *v=NULL;
   int i;

   for (i=0; i < instance_count; ++i) {
      SplineChar *sc=scs[i];

      if (sc==NULL || (!sc->hconflicts && !sc->vconflicts))
	 continue;

      /* Does this point lie on any hints? */
      if (scs[i]->hconflicts)
	 h=OnHHint(to[i], sc->hstem);
      if (scs[i]->vconflicts)
	 v=OnVHint(to[i], sc->vstem);

      /* Need to set this hint */
      if ((h != NULL && h->hintnumber != -1
	   && (mask[h->hintnumber >> 3] & (0x80 >> (h->hintnumber & 7)))==0)
	  || (v != NULL && v->hintnumber != -1
	      && (mask[v->hintnumber >> 3] & (0x80 >> (v->hintnumber & 7))) ==
	      0))
	 break;
   }
   if (i==instance_count)	/* All hint masks were ok */
      return (false);

   FigureHintMask(scs, to, instance_count, mask);
   return (true);
}

static void UnnumberHints(SplineChar *sc) {
   StemInfo *h;

   for (h=sc->hstem; h != NULL; h=h->next)
      h->hintnumber=-1;
   for (h=sc->vstem; h != NULL; h=h->next)
      h->hintnumber=-1;
}

static int NumberHints(SplineChar *sc) {
   StemInfo *h;
   int hcnt=0;

   for (h=sc->hstem; h != NULL; h=h->next)
      h->hintnumber=hcnt >= HntMax ? -1 : hcnt++;
   for (h=sc->vstem; h != NULL; h=h->next)
      h->hintnumber=hcnt >= HntMax ? -1 : hcnt++;
   return (hcnt);
}

static void UntickHints(SplineChar *sc) {
   StemInfo *h;

   for (h=sc->hstem; h != NULL; h=h->next)
      h->used=false;
   for (h=sc->vstem; h != NULL; h=h->next)
      h->used=false;
}

struct coords {
   double coords[MmMax];
   struct coords *next;
};

typedef struct mmh {
   StemInfo *hints[MmMax], *map[MmMax];
   struct coords *where;
   struct mmh *next;
} MMH;

static void AddCoord(MMH *mmh,SplinePoint *sps[MmMax],int instance_count,
		     int ish) {
   struct coords *coords;
   int i;

   coords=chunkalloc(sizeof(struct coords));
   coords->next=mmh->where;
   mmh->where=coords;
   if (ish)
      for (i=0; i < instance_count; ++i)
	 coords->coords[i]=sps[i]->me.x;
   else
      for (i=0; i < instance_count; ++i)
	 coords->coords[i]=sps[i]->me.y;
}

static MMH *AddHintSet(MMH *hints,StemInfo *h[MmMax],int instance_count,
		       SplinePoint * sps[MmMax], int ish) {
   int i, cnt, bestc;
   MMH *test, *best;

   for (i=0; i < instance_count; ++i)
      if (h[i]==NULL)
	 return (hints);

   best=NULL;
   bestc=0;
   for (test=hints; test != NULL; test=test->next) {
      cnt=0;
      for (i=0; i < instance_count; ++i)
	 if (test->hints[i]==h[i])
	    ++cnt;
      if (cnt==instance_count) {
	 AddCoord(test, sps, instance_count, ish);
	 return (hints);
      }
      if (cnt > bestc) {
	 bestc=cnt;
	 best=test;
      }
   }
   test=chunkalloc(sizeof(MMH));
   test->next=hints;
   AddCoord(test, sps, instance_count, ish);
   for (i=0; i < instance_count; ++i)
      test->hints[i]=h[i];
   if (bestc != 0) {
      for (i=0; i < instance_count; ++i) {
	 if (best->hints[i]==h[i]) {
	    h[i]->hasconflicts=true;
	    test->map[i]=chunkalloc(sizeof(StemInfo));
	    *test->map[i]=*h[i];
	    test->map[i]->where=NULL;
	    test->map[i]->used=true;
	    h[i]->next=test->map[i];
	 } else
	    test->map[i]=h[i];
      }
   } else {
      for (i=0; i < instance_count; ++i)
	 test->map[i]=h[i];
   }
   return (test);
}

static int CompareMMH(MMH *mmh1,MMH *mmh2,int instance_count) {
   int i;

   if (mmh1->map[0]==NULL)
      return (1);
   if (mmh2->map[0]==NULL)
      return (-1);

   for (i=0; i < instance_count; ++i) {
      if (mmh1->map[i]->start != mmh2->map[i]->start) {
	 if (mmh1->map[i]->start > mmh2->map[i]->start)
	    return (1);
	 else
	    return (-1);
      }
   }
   for (i=0; i < instance_count; ++i) {
      if (mmh1->map[i]->width != mmh2->map[i]->width) {
	 if (mmh1->map[i]->width > mmh2->map[i]->width)
	    return (1);
	 else
	    return (-1);
      }
   }
   return (0);
}

static MMH *SortMMH(MMH *head,int instance_count) {
   MMH *mmh, *p, *smallest, *psmallest, *test, *ptest;

   for (mmh=head, p=NULL; mmh != NULL;) {
      smallest=mmh;
      psmallest=p;
      ptest=mmh;
      test=mmh->next;
      while (test != NULL) {
	 if (CompareMMH(test, smallest, instance_count) < 0) {
	    smallest=test;
	    psmallest=ptest;
	 }
	 ptest=test;
	 test=test->next;
      }
      if (smallest != mmh) {
	 if (p==NULL)
	    head=smallest;
	 else
	    p->next=smallest;
	 if (mmh->next==smallest) {
	    mmh->next=smallest->next;
	    smallest->next=mmh;
	 } else {
	    test=mmh->next;
	    mmh->next=smallest->next;
	    smallest->next=test;
	    psmallest->next=mmh;
	 }
      }
      p=smallest;
      mmh=smallest->next;
   }
   return (head);
}

static int NumberMMH(MMH *mmh,int hstart,int instance_count) {
   int i;
   HintInstance *hi, *n;
   struct coords *coords;

   while (mmh != NULL) {
      for (i=0; i < instance_count; ++i) {
	 StemInfo *h=mmh->map[i];

	 if (h==NULL)
	    continue;

	 h->hintnumber=hstart;

	 for (hi=h->where; hi != NULL; hi=n) {
	    n=hi->next;
	    chunkfree(hi, sizeof(HintInstance));
	 }
	 h->where=NULL;
	 for (coords=mmh->where; coords != NULL; coords=coords->next) {
	    hi=chunkalloc(sizeof(HintInstance));
	    hi->next=h->where;
	    h->where=hi;
	    hi->begin=coords->coords[i] - 1;
	    hi->end=coords->coords[i] + 1;
	 }
      }
      if (mmh->map[0] != NULL)
	 ++hstart;
      mmh=mmh->next;
   }
   return (hstart);
}

static void SortMMH2(SplineChar *scs[MmMax],MMH *mmh,int instance_count,
		     int ish) {
   int i;
   StemInfo *h, *n;
   MMH *m;

   for (i=0; i < instance_count; ++i) {
      for (h=ish ? scs[i]->hstem : scs[i]->vstem; h != NULL; h=n) {
	 n=h->next;
	 if (h->hintnumber==-1)
	    StemInfoFree(h);
      }
      n=NULL;
      for (m=mmh; m != NULL; m=m->next) {
	 h=m->map[i];
	 if (n != NULL)
	    n->next=h;
	 else if (ish)
	    scs[i]->hstem=h;
	 else
	    scs[i]->vstem=h;
	 n=h;
      }
      if (n != NULL)
	 n->next=NULL;
      else if (ish)
	 scs[i]->hstem=NULL;
      else
	 scs[i]->vstem=NULL;
   }
}

static void MMHFreeList(MMH *mmh) {
   MMH *mn;
   struct coords *c, *n;

   for (; mmh != NULL; mmh=mn) {
      mn=mmh->next;
      for (c=mmh->where; c != NULL; c=n) {
	 n=c->next;
	 chunkfree(c, sizeof(struct coords));
      }
      chunkfree(mmh, sizeof(struct coords));
   }
}

static void SplResolveSplitHints(SplineChar *scs[MmMax],
				 SplineSet * spl[MmMax], int instance_count,
				 MMH ** hs, MMH ** vs) {
   SplinePoint *to[MmMax];
   StemInfo *h[MmMax], *v[MmMax];
   int i, anymore;

   while (1) {
      for (i=0; i < instance_count; ++i) {
	 if (spl[i] != NULL)
	    to[i]=spl[i]->first;
	 else
	    to[i]=NULL;
      }
      while (1) {
	 for (i=0; i < instance_count; ++i) {
	    h[i]=OnHHint(to[i], scs[i]->hstem);
	    v[i]=OnVHint(to[i], scs[i]->vstem);
	 }
	 *hs=AddHintSet(*hs, h, instance_count, to, true);
	 *vs=AddHintSet(*vs, v, instance_count, to, false);
	 anymore=false;
	 for (i=0; i < instance_count; ++i)
	    if (to[i] != NULL) {
	       if (to[i]->next==NULL)
		  to[i]=NULL;
	       else {
		  to[i]=to[i]->next->to;
		  if (to[i]==spl[i]->first)
		     to[i]=NULL;
	       }
	       if (to[i] != NULL)
		  anymore=true;
	    }
	 if (!anymore)
	    break;
      }
      anymore=false;
      for (i=0; i < instance_count; ++i) {
	 if (spl[i] != NULL)
	    spl[i]=spl[i]->next;
	 if (spl[i] != NULL)
	    anymore=true;
      }
      if (!anymore)
	 break;
   }
}

static void ResolveSplitHints(SplineChar *scs[16],int layer,
			      int instance_count) {
   /* It is possible for a single hint in one mm instance to split into two */
   /*  in a different MM set. For example, we have two stems which happen */
   /*  to line up in one instance but which do not in another instance. */
   /* It is even possible that there could be no instance with any conflicts */
   /*  but some of the intermediate forms might conflict. */
   /* We can't deal (nor can postscript) with the case where hints change order */
   SplinePointList *spl[MmMax];
   RefChar *ref[MmMax];
   int i, hcnt, hmax=0, anymore;
   MMH *hs=NULL, *vs=NULL;

   for (i=0; i < instance_count; ++i) {
      hcnt=NumberHints(scs[i]);
      UntickHints(scs[i]);
      if (hcnt > hmax)
	 hmax=hcnt;
      spl[i]=scs[i]->layers[layer].splines;
   }
   if (hmax==0)
      return;

   SplResolveSplitHints(scs, spl, instance_count, &hs, &vs);
   anymore=false;
   for (i=0; i < instance_count; ++i) {
      ref[i]=scs[i]->layers[layer].refs;
      if (ref[i] != NULL)
	 anymore=true;
   }
   while (anymore) {
      for (i=0; i < instance_count; ++i)
	 spl[i]=(ref[i] != NULL) ? ref[i]->layers[0].splines : NULL;
      SplResolveSplitHints(scs, spl, instance_count, &hs, &vs);
      anymore=false;
      for (i=0; i < instance_count; ++i) {
	 if (ref[i] != NULL) {
	    ref[i]=ref[i]->next;
	    if (ref[i] != NULL)
	       anymore=true;
	 }
      }
   }

   for (i=0; i < instance_count; ++i)
      UnnumberHints(scs[i]);
   hs=SortMMH(hs, instance_count);
   vs=SortMMH(vs, instance_count);
   hcnt=NumberMMH(hs, 0, instance_count);
   hcnt=NumberMMH(vs, hcnt, instance_count);
   SortMMH2(scs, hs, instance_count, true);
   SortMMH2(scs, vs, instance_count, false);
   MMHFreeList(hs);
   MMHFreeList(vs);
}

static int SplFigureHintMasks(SplineChar *scs[MmMax],SplineSet *spl[MmMax],
			      int instance_count, HintMask mask, int inited) {
   SplinePoint *to[MmMax];
   int i, anymore;

   anymore=false;
   for (i=0; i < instance_count; ++i) {
      if (spl[i] != NULL) {
	 SplineSetReverse(spl[i]);
	 to[i]=spl[i]->first;
	 anymore=true;
      } else
	 to[i]=NULL;
   }

   /* Assign the initial hint mask */
   if (anymore && !inited) {
      FigureHintMask(scs, to, instance_count, mask);
      inited=true;
   }

   while (1) {
      for (i=0; i < instance_count; ++i) {
	 if (spl[i] != NULL)
	    to[i]=spl[i]->first;
	 else
	    to[i]=NULL;
      }
      while (1) {
	 TestHintMask(scs, to, instance_count, mask);
	 anymore=false;
	 for (i=0; i < instance_count; ++i)
	    if (to[i] != NULL) {
	       if (to[i]->next==NULL)
		  to[i]=NULL;
	       else {
		  to[i]=to[i]->next->to;
		  if (to[i]==spl[i]->first)
		     to[i]=NULL;
	       }
	       if (to[i] != NULL)
		  anymore=true;
	    }
	 if (!anymore)
	    break;
      }
      anymore=false;
      for (i=0; i < instance_count; ++i) {
	 if (spl[i] != NULL) {
	    SplineSetReverse(spl[i]);
	    spl[i]=spl[i]->next;
	 }
	 if (spl[i] != NULL) {
	    anymore=true;
	    SplineSetReverse(spl[i]);
	 }
      }
      if (!anymore)
	 break;
   }
   return (inited);
}

void SCFigureHintMasks(SplineChar * sc, int layer) {
   SplineChar *scs[MmMax];
   SplinePointList *spl[MmMax];
   RefChar *ref[MmMax];
   MMSet *mm=sc->parent->mm;
   int i, instance_count, conflicts, anymore, inited;
   HintMask mask;

   if (mm==NULL) {
      scs[0]=sc;
      instance_count=1;
      SCClearHintMasks(sc, layer, false);
   } else {
      if (mm->apple)
	 return;
      instance_count=mm->instance_count;
      for (i=0; i < instance_count; ++i)
	 if (sc->orig_pos < mm->instances[i]->glyphcnt) {
	    scs[i]=mm->instances[i]->glyphs[sc->orig_pos];
	    SCClearHintMasks(scs[i], layer, false);
	 }
      ResolveSplitHints(scs, layer, instance_count);
   }
   conflicts=false;
   for (i=0; i < instance_count; ++i) {
      NumberHints(scs[i]);
      if (scs[i]->hconflicts || scs[i]->vconflicts)
	 conflicts=true;
   }
   if (!conflicts && instance_count==1) {	/* All hints always active */
      SCFigureSimpleCounterMasks(sc);
      return;			/* In an MM font we may still need to resolve things like different numbers of hints */
   }

   for (i=0; i < instance_count; ++i) {
      spl[i]=scs[i]->layers[layer].splines;
      ref[i]=scs[i]->layers[layer].refs;
   }
   inited=SplFigureHintMasks(scs, spl, instance_count, mask, false);
   while (1) {
      for (i=0; i < instance_count; ++i) {
	 if (ref[i] != NULL)
	    spl[i]=ref[i]->layers[0].splines;
      }
      inited=SplFigureHintMasks(scs, spl, instance_count, mask, inited);
      anymore=false;
      for (i=0; i < instance_count; ++i) {
	 if (ref[i] != NULL) {
	    ref[i]=ref[i]->next;
	    if (ref[i] != NULL)
	       anymore=true;
	 }
      }
      if (!anymore)
	 break;
   }
   if (instance_count==1)
      SCFigureSimpleCounterMasks(sc);
}

static StemInfo *GDFindStems(struct glyphdata *gd,int major) {
   int i;
   StemInfo *head=NULL, *cur, *p, *t;
   StemBundle *bundle=major ? gd->vbundle : gd->hbundle;
   StemData *stem;
   int other=!major;
   double l, r;

   for (i=0; i < bundle->cnt; ++i) {
      stem=bundle->stemlist[i];
      l=(&stem->left.x)[other];
      r=(&stem->right.x)[other];
      cur=chunkalloc(sizeof(StemInfo));
      if (l < r) {
	 cur->start=l;
	 cur->width=r - l;
	 cur->haspointleft=stem->lpcnt > 0;
	 cur->haspointright=stem->rpcnt > 0;
      } else {
	 cur->start=r;
	 cur->width=l - r;
	 cur->haspointleft=stem->rpcnt > 0;
	 cur->haspointright=stem->lpcnt > 0;
      }
      cur->ghost=stem->ghost;
      for (p=NULL, t=head; t != NULL; p=t, t=t->next) {
	 if (cur->start <= t->start)
	    break;
      }
      cur->next=t;
      if (p==NULL)
	 head=cur;
      else
	 p->next=cur;
      cur->where=StemAddHIFromActive(stem, major);
   }
   head=StemRemoveFlexCandidates(head);
   return (head);
}

static DStemInfo *GDFindDStems(struct glyphdata *gd) {
   int i;
   DStemInfo *head=NULL, *cur;
   struct stemdata *stem;

   for (i=0; i < gd->stemcnt; ++i) {
      stem=&gd->stems[i];
      /* A real diagonal stem should consist of one or more continuous
       * ranges. Thus the number of active zones should be less then the
       * number of stem chunks (i. e. pairs of the opposite points). If
       * each chunk has its own active zone, then we probably have got
       * not a real stem, but rather two (or more) separate point pairs,
       * which occasionally happened to have nearly the same vectors and 
       * to be positioned on the same lines */
      if (stem->toobig)
	 continue;

      if ((stem->unit.y > -.05 && stem->unit.y < .05) ||
	  (stem->unit.x > -.05 && stem->unit.x < .05))
	 continue;

      if (stem->lpcnt < 2 || stem->rpcnt < 2)
	 continue;
      cur=chunkalloc(sizeof(DStemInfo));
      cur->left=stem->left;
      cur->right=stem->right;
      cur->unit=stem->unit;
      MergeDStemInfo(gd->sf, &head, cur);
      cur->where=DStemAddHIFromActive(stem);
   }
   return (head);
}

void _SplineCharAutoHint(SplineChar *sc,int layer,BlueData * bd,
			 struct glyphdata *gd2) {
   struct glyphdata *gd;

   StemInfosFree(sc->vstem);
   sc->vstem=NULL;
   StemInfosFree(sc->hstem);
   sc->hstem=NULL;
   DStemInfosFree(sc->dstem);
   sc->dstem=NULL;
   MinimumDistancesFree(sc->md);
   sc->md=NULL;

   free(sc->countermasks);
   sc->countermasks=NULL;
   sc->countermask_cnt=0;
   /* We'll free the hintmasks when we call SCFigureHintMasks */

   sc->changedsincelasthinted=false;
   sc->manualhints=false;

   if ((gd=gd2)==NULL)
      gd=GlyphDataBuild(sc, layer, bd, false);
   if (gd != NULL) {
      sc->vstem=GDFindStems(gd, 1);
      sc->hstem=GDFindStems(gd, 0);
      if (!gd->only_hv)
	 sc->dstem=GDFindDStems(gd);
      if (gd2==NULL)
	 GlyphDataFree(gd);
   }

   AutoHintRefs(sc, layer, bd, false);
}

static void __SplineCharAutoHint(SplineChar *sc,int layer,BlueData *bd) {
   MMSet *mm=sc->parent->mm;
   int i;

   if (mm==NULL)
      _SplineCharAutoHint(sc, layer, bd, NULL);
   else {
      for (i=0; i < mm->instance_count; ++i)
	 if (sc->orig_pos < mm->instances[i]->glyphcnt)
	    _SplineCharAutoHint(mm->instances[i]->glyphs[sc->orig_pos], layer,
				NULL, NULL);
      if (sc->orig_pos < mm->normal->glyphcnt)
	 _SplineCharAutoHint(mm->normal->glyphs[sc->orig_pos], layer, NULL,
			     NULL);
   }
   SCFigureHintMasks(sc, layer);
}

void SplineCharAutoHint(SplineChar *sc,int layer,BlueData *bd) {
   __SplineCharAutoHint(sc, layer, bd);
}

void SFSCAutoHint(SplineChar * sc, int layer, BlueData * bd) {
   RefChar *ref;

   if (sc->ticked)
      return;
   for (ref=sc->layers[ly_fore].refs; ref != NULL; ref=ref->next) {
      if (!ref->sc->ticked)
	 SFSCAutoHint(ref->sc, layer, bd);
   }
   sc->ticked=true;
   SplineCharAutoHint(sc, layer, bd);
}

int SFNeedsAutoHint(SplineFont *_sf, int layer) {
   int i, k;
   SplineFont *sf;

   k=0;
   do {
      sf=_sf->subfontcnt==0 ? _sf : _sf->subfonts[k];
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL) {
	    if (sf->glyphs[i]->changedsincelasthinted &&
		!sf->glyphs[i]->manualhints)
	       return (true);
	 }
      ++k;
   } while (k < _sf->subfontcnt);
   return (false);
}

void SplineFontAutoHint(SplineFont *_sf, int layer) {
   int i, k;
   SplineFont *sf;
   BlueData *bd=NULL, _bd;
   SplineChar *sc;

   if (_sf->mm==NULL) {
      QuickBlues(_sf, layer, &_bd);
      bd=&_bd;
   }

   /* Tick the ones we don't want to AH, untick the ones that need AH */
   k=0;
   do {
      sf=_sf->subfontcnt==0 ? _sf : _sf->subfonts[k];
      for (i=0; i < sf->glyphcnt; ++i)
	 if ((sc=sf->glyphs[i]) != NULL)
	    sc->ticked=(!sc->changedsincelasthinted || sc->manualhints);
      ++k;
   } while (k < _sf->subfontcnt);

   k=0;
   do {
      sf=_sf->subfontcnt==0 ? _sf : _sf->subfonts[k];
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL) {
	    if (sf->glyphs[i]->changedsincelasthinted &&
		!sf->glyphs[i]->manualhints)
	       SFSCAutoHint(sf->glyphs[i], layer, bd);
	 }
      ++k;
   } while (k < _sf->subfontcnt);
}

void SplineFontAutoHintRefs(SplineFont *_sf, int layer) {
   int i, k;
   SplineFont *sf;
   BlueData *bd=NULL, _bd;
   SplineChar *sc;

   if (_sf->mm==NULL) {
      QuickBlues(_sf, layer, &_bd);
      bd=&_bd;
   }

   k=0;
   do {
      sf=_sf->subfontcnt==0 ? _sf : _sf->subfonts[k];
      for (i=0; i < sf->glyphcnt; ++i)
	 if ((sc=sf->glyphs[i]) != NULL) {
	    if (sc->changedsincelasthinted &&
		!sc->manualhints &&
		(sc->layers[layer].refs != NULL
		 && sc->layers[layer].splines==NULL)) {
	       StemInfosFree(sc->vstem);
	       sc->vstem=NULL;
	       StemInfosFree(sc->hstem);
	       sc->hstem=NULL;
	       AutoHintRefs(sc, layer, bd, true);
	    }
	 }
      ++k;
   } while (k < _sf->subfontcnt);
}

static void FigureStems(SplineFont *sf,double snaps[12],double cnts[12],
			int which) {
   int i, j, k, cnt, smax=0, smin=2000;
   double stemwidths[2000];
   StemInfo *stems, *test;
   int len;
   HintInstance *hi;

   memset(stemwidths, '\0', sizeof(stemwidths));

   for (i=0; i < sf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL) {
	 stems=which ? sf->glyphs[i]->hstem : sf->glyphs[i]->vstem;
	 for (test=stems; test != NULL; test=test->next)
	    if (!test->ghost) {
	       if ((j=test->width) < 0)
		  j=-j;
	       if (j < 2000) {
		  len=0;
		  for (hi=test->where; hi != NULL; hi=hi->next)
		     len += hi->end - hi->begin;
		  if (len==0)
		     len=100;
		  stemwidths[j] += len;
		  if (smax < j)
		     smax=j;
		  if (smin > j)
		     smin=j;
	       }
	    }
      }

   for (i=smin, cnt=0; i <= smax; ++i) {
      if (stemwidths[i] != 0)
	 ++cnt;
   }

   if (cnt > 12) {
      /* Merge width windows */
      int windsize=3, j;

      for (i=smin; i <= smax; ++i)
	 if (stemwidths[i] != 0) {
	    if ((j=i - windsize) < 0)
	       j=0;
	    for (; j < smax && j <= i + windsize; ++j)
	       if (stemwidths[i] < stemwidths[j])
		  break;
	    if (j==smax || j > i + windsize) {
	       if ((j=i - windsize) < 0)
		  j=0;
	       for (; j < smax && j <= i + windsize; ++j)
		  if (j != i) {
		     stemwidths[i] += stemwidths[j];
		     stemwidths[j]=0;
		  }
	    }
	 }
      /* Merge adjacent widths */
      for (i=smin; i <= smax; ++i) {
	 if (stemwidths[i] != 0 && i <= smax - 1 && stemwidths[i + 1] != 0) {
	    if (stemwidths[i] > stemwidths[i + 1]) {
	       stemwidths[i] += stemwidths[i + 1];
	       stemwidths[i + 1]=0;
	    } else {
	       if (i <= smax - 2 && stemwidths[i + 2]
		   && stemwidths[i + 2] < stemwidths[i + 1]) {
		  stemwidths[i + 1] += stemwidths[i + 2];
		  stemwidths[i + 2]=0;
	       }
	       stemwidths[i + 1] += stemwidths[i];
	       stemwidths[i]=0;
	       ++i;
	    }
	 }
      }
      for (i=smin, cnt=0; i <= smax; ++i) {
	 if (stemwidths[i] != 0)
	    ++cnt;
      }
   }
   if (cnt <= 12) {
      for (i=smin, cnt=0; i <= smax; ++i) {
	 if (stemwidths[i] != 0) {
	    snaps[cnt]=i;
	    cnts[cnt++]=stemwidths[i];
	 }
      }
   } else {
      double firstbiggest=0;

      for (cnt=0; cnt < 12; ++cnt) {
	 int biggesti=0;
	 double biggest=0;

	 for (i=smin; i <= smax; ++i) {
	    if (stemwidths[i] > biggest) {
	       biggest=stemwidths[i];
	       biggesti=i;
	    }
	 }
	 /* array must be sorted */
	 if (biggest < firstbiggest / 6)
	    break;
	 for (j=0; j < cnt; ++j)
	    if (snaps[j] > biggesti)
	       break;
	 for (k=cnt - 1; k >= j; --k) {
	    snaps[k + 1]=snaps[k];
	    cnts[k + 1]=cnts[k];
	 }
	 snaps[j]=biggesti;
	 cnts[j]=biggest;
	 stemwidths[biggesti]=0;
	 if (firstbiggest==0)
	    firstbiggest=biggest;
      }
   }
   for (; cnt < 12; ++cnt) {
      snaps[cnt]=0;
      cnts[cnt]=0;
   }
}

void FindHStems(SplineFont *sf, double snaps[12], double cnt[12]) {
   FigureStems(sf, snaps, cnt, 1);
}

void FindVStems(SplineFont *sf, double snaps[12], double cnt[12]) {
   FigureStems(sf, snaps, cnt, 0);
}

static int IsFlexSmooth(SplinePoint *sp) {
   BasePoint nvec, pvec;
   double proj_same, proj_normal;

   if (sp->nonextcp || sp->noprevcp)
      return (false);		/* No continuity of slopes */

   nvec.x=sp->nextcp.x - sp->me.x;
   nvec.y=sp->nextcp.y - sp->me.y;
   pvec.x=sp->me.x - sp->prevcp.x;
   pvec.y=sp->me.y - sp->prevcp.y;

   /* Avoid cases where the slopes are 180 out of phase */
   if ((proj_same=nvec.x * pvec.x + nvec.y * pvec.y) <= 0)
      return (false);
   if ((proj_normal=nvec.x * pvec.y - nvec.y * pvec.x) < 0)
      proj_normal=-proj_normal;

   /* Something is smooth if the normal projection is 0. Let's allow for */
   /*  some rounding errors */
   if (proj_same >= 16 * proj_normal)
      return (true);

   return (false);
}

static int _SplineCharIsFlexible(SplineChar *sc,int layer,int blueshift) {
   /* Need two splines
      outer endpoints have same x (or y) values
      inner point must be less than 20 horizontal (v) units from the outer points
      inner point must also be less than BlueShift units (defaults to 7=>6)
      (can increase BlueShift up to 21)
      the inner point must be a local extremum
      the inner point's cps must be at the x (or y) value as the extremum
      (I think)
    */
   /* We want long, nearly straight stems. If the end-points should not have
      continuous slopes, or if they do, they must be horizontal/vertical.
      This is an heuristic requirement, not part of Adobe's spec.
    */
   SplineSet *spl;
   SplinePoint *sp, *np, *pp;
   int max=0, val;
   RefChar *r;

   if (sc==NULL)
      return (false);

   for (spl=sc->layers[layer].splines; spl != NULL; spl=spl->next) {
      if (spl->first->prev==NULL) {
	 /* Mark everything on the open path as inflexible */
	 sp=spl->first;
	 while (1) {
	    sp->flexx=sp->flexy=false;
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	 }
	 continue;		/* Ignore open paths */
      }
      sp=spl->first;
      do {
	 if (sp->next==NULL || sp->prev==NULL)
	    break;
	 np=sp->next->to;
	 pp=sp->prev->from;
	 if (!pp->flexx && !pp->flexy) {
	    sp->flexy=sp->flexx=0;
	    val=0;
	    if (RealNear(sp->nextcp.x, sp->me.x) &&
		RealNear(sp->prevcp.x, sp->me.x) &&
		RealNear(np->me.x, pp->me.x) &&
		!RealNear(np->me.x, sp->me.x) &&
		(!IsFlexSmooth(pp) || RealNear(pp->nextcp.x, pp->me.x)) &&
		(!IsFlexSmooth(np) || RealNear(np->prevcp.x, np->me.x)) &&
		np->me.x - sp->me.x < blueshift &&
		np->me.x - sp->me.x > -blueshift) {
	       if ((np->me.x > sp->me.x &&
		    np->prevcp.x <= np->me.x && np->prevcp.x >= sp->me.x &&
		    pp->nextcp.x <= pp->me.x && pp->prevcp.x >= sp->me.x) ||
		   (np->me.x < sp->me.x &&
		    np->prevcp.x >= np->me.x && np->prevcp.x <= sp->me.x &&
		    pp->nextcp.x >= pp->me.x && pp->prevcp.x <= sp->me.x)) {
		  sp->flexx=true;
		  val=np->me.x - sp->me.x;
	       }
	    }
	    if (RealNear(sp->nextcp.y, sp->me.y) &&
		RealNear(sp->prevcp.y, sp->me.y) &&
		RealNear(np->me.y, pp->me.y) &&
		!RealNear(np->me.y, sp->me.y) &&
		(!IsFlexSmooth(pp) || RealNear(pp->nextcp.y, pp->me.y)) &&
		(!IsFlexSmooth(np) || RealNear(np->prevcp.y, np->me.y)) &&
		np->me.y - sp->me.y < blueshift &&
		np->me.y - sp->me.y > -blueshift) {
	       if ((np->me.y > sp->me.y &&
		    np->prevcp.y <= np->me.y && np->prevcp.y >= sp->me.y &&
		    pp->nextcp.y <= pp->me.y && pp->nextcp.y >= sp->me.y) ||
		   (np->me.y < sp->me.y &&
		    np->prevcp.y >= np->me.y && np->prevcp.y <= sp->me.y &&
		    pp->nextcp.y >= pp->me.y && pp->nextcp.y <= sp->me.y)) {
		  sp->flexy=true;
		  val=np->me.y - sp->me.y;
	       }
	    }
	    if (val < 0)
	       val=-val;
	    if (val > max)
	       max=val;
	 }
	 sp=np;
      } while (sp != spl->first);
   }
   sc->layers[layer].anyflexes=max > 0;
   if (max==0)
      for (r=sc->layers[layer].refs; r != NULL; r=r->next)
	 if (r->sc->layers[layer].anyflexes) {
	    sc->layers[layer].anyflexes=true;
	    break;
	 }
   return (max);
}

static void SCUnflex(SplineChar *sc,int layer) {
   SplineSet *spl;
   SplinePoint *sp;

   for (spl=sc->layers[layer].splines; spl != NULL; spl=spl->next) {
      /* Mark everything on the path as inflexible */
      sp=spl->first;
      while (1) {
	 sp->flexx=sp->flexy=false;
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==spl->first)
	    break;
      }
   }
   sc->layers[layer].anyflexes=false;
}

static void FlexDependents(SplineChar *sc,int layer) {
   struct splinecharlist *scl;

   sc->layers[layer].anyflexes=true;
   for (scl=sc->dependents; scl != NULL; scl=scl->next)
      FlexDependents(scl->sc, layer);
}

int SplineFontIsFlexible(SplineFont *sf, int layer, int flags) {
   int i;
   int max=0, val;
   char *pt;
   int blueshift;

   /* if the return value is bigger than 6 and we don't have a BlueShift */
   /*  then we must set BlueShift to ret+1 before saving private dictionary */
   /* If the first point in a spline set is flexible, then we must rotate */
   /*  the splineset */

   if (flags & (ps_flag_nohints | ps_flag_noflex)) {
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL)
	    SCUnflex(sf->glyphs[i], layer);
      return (0);
   }

   pt=PSDictHasEntry(sf->private, "BlueShift");
   blueshift=21;		/* maximum posible flex, not default */
   if (pt != NULL) {
      blueshift=strtol(pt, NULL, 10);
      if (blueshift > 21)
	 blueshift=21;
   } else if (PSDictHasEntry(sf->private, "BlueValues") != NULL)
      blueshift=7;		/* The BlueValues array may depend on BlueShift having its default value */

   for (i=0; i < sf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL)
	 if (sf->glyphs[i] != NULL) {
	    val=_SplineCharIsFlexible(sf->glyphs[i], layer, blueshift);
	    if (val > max)
	       max=val;
	    if (sf->glyphs[i]->layers[layer].anyflexes)
	       FlexDependents(sf->glyphs[i], layer);
	 }
   return (max);
}
