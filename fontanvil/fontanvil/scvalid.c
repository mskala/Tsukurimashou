/* $Id: scvalid.c 5734 2017-11-10 04:37:40Z mskala $ */
/* Copyright (C) 2000-2012  George Williams
 * Copyright (C) 2015, 2016  Matthew Skala
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

#include "fontanvilvw.h"
#include <math.h>
#include <ustring.h>
#include <utype.h>
#include <gresource.h>
#ifdef HAVE_IEEEFP_H
#   include <ieeefp.h> /* Solaris defines isnan in ieeefp rather than math.h */
#endif
#include "ttf.h"

/**********************************************************************/

static int UniMatch(int vs,int uni,SplineChar *sc) {
   struct altuni *alt;

   if (sc->unicodeenc != -1 && vs==-1 && uni==sc->unicodeenc)
      return (true);
   for (alt=sc->altuni; alt != NULL; alt=alt->next)
      if (alt->vs==vs && alt->unienc==uni)
	 return (true);

   return (false);
}

static int SFValidNameList(SplineFont *sf,char *list) {
   char *start, *pt;
   int ch;
   SplineChar *sc;

   for (start=list;;) {
      while (*start==' ')
	 ++start;
      if (*start=='\0')
	 return (true);
      for (pt=start; *pt != ':' && *pt != ' ' && *pt != '\0'; ++pt);
      ch=*pt;
      if (ch==' ' || ch=='\0')
	 return (-1);
      if (sf != NULL) {
	 *pt='\0';
	 sc=SFGetChar(sf, -1, start);
	 *pt=ch;
	 if (sc==NULL)
	    return (-1);
      }
      start=pt;
   }
}

StemInfo *SCHintOverlapInMask(SplineChar * sc, HintMask * hm) {
   int hi1, hi2, hcnt=0;
   StemInfo *h1, *h2;
   int v;

   for (v=0; v<2; ++v) {
      if (v==0) {
	 h1=sc->hstem;
	 hi1=0;
      } else {
	 h1=sc->vstem;
	 hi1=hcnt;
      }
      for (; h1 != NULL && hi1<HntMax; ++hi1, h1=h1->next) {
	 if (hm==NULL || ((*hm)[(hi1 >> 3)]&(0x80 >> (hi1&7)))) {
	    for (hi2=hi1+1, h2=h1->next; h2 != NULL && hi2<HntMax;
		 ++hi2, h2=h2->next) {
	       if (hm==NULL || ((*hm)[(hi2 >> 3)]&(0x80 >> (hi2&7)))) {
		  double start1, end1, start2, end2;

		  if (h1->width>0) {
		     start1=h1->start;
		     end1=start1+h1->width;
		  } else {
		     end1=h1->start;
		     start1=start1+h1->width;
		  }
		  if (h2->width>0) {
		     start2=h2->start;
		     end2=start2+h2->width;
		  } else {
		     end2=h2->start;
		     start2=start2+h2->width;
		  }
		  if (end1<start2 || start1>end2)
		     /* No overlap */ ;
		  else {
		     ErrorMsg(1,"Hint overlap between (%f,%f) and (%f,%f)\n",
			      start1,end1,start2,end2);
		     return h1;
		  }
	       }
	    }
	 }
      }
      hcnt=hi1;
   }
   return (NULL);
}

int SCValidate(SplineChar * sc, int layer, int force) {
   SplineSet *ss;
   Spline *s1, *s2, *s, *first;
   SplinePoint *sp;
   RefChar *ref;
   int lastscan=-1;
   int cnt, path_cnt, pt_cnt;
   StemInfo *h;
   SplineSet *base;
   double len2, bound2, x, y;
   double extrema[4];
   PST *pst;
   struct ttf_table *tab;
   extern int allow_utf8_glyphnames;
   RefChar *r;
   BasePoint lastpt;
   int gid, k;
   SplineFont *cid, *sf;
   SplineChar *othersc;
   struct altuni *alt;

   if ((sc->layers[layer].validation_state&vs_known) && !force)
      goto end;

   sc->layers[layer].validation_state=0;

   base=LayerAllSplines(&sc->layers[layer]);

   if (!allow_utf8_glyphnames) {
      if (strlen(sc->name)>31)
	 sc->layers[layer].validation_state |= vs_badglyphname|vs_known;
      else {
	 char *pt;

	 for (pt=sc->name; *pt; ++pt) {
	    if ((*pt >= 'A' && *pt <= 'Z') ||
		(*pt >= 'a' && *pt <= 'z') ||
		(*pt >= '0' && *pt <= '9') || *pt=='.' || *pt=='_')
	       /* That's ok */ ;
	    else {
	       sc->layers[layer].validation_state |=
		  vs_badglyphname|vs_known;
	       break;
	    }
	 }
      }
   }

   for (pst=sc->possub; pst != NULL; pst=pst->next) {
      if (pst->type==pst_substitution &&
	  !SCWorthOutputting(SFGetChar(sc->parent, -1, pst->u.subs.variant)))
      {
	 sc->layers[layer].validation_state |= vs_badglyphname|vs_known;
	 break;
      } else if (pst->type==pst_pair &&
		 !SCWorthOutputting(SFGetChar
				    (sc->parent, -1, pst->u.pair.paired))) {
	 sc->layers[layer].validation_state |= vs_badglyphname|vs_known;
	 break;
      } else
	 if ((pst->type==pst_alternate || pst->type==pst_multiple
	      || pst->type==pst_ligature)
	     && !SFValidNameList(sc->parent, pst->u.mult.components)) {
	 sc->layers[layer].validation_state |= vs_badglyphname|vs_known;
	 break;
      }
   }
   if (sc->vert_variants != NULL && sc->vert_variants->variants != NULL &&
       !SFValidNameList(sc->parent, sc->vert_variants->variants))
      sc->layers[layer].validation_state |= vs_badglyphname|vs_known;
   else if (sc->horiz_variants != NULL && sc->horiz_variants->variants != NULL
	    && !SFValidNameList(sc->parent, sc->horiz_variants->variants))
      sc->layers[layer].validation_state |= vs_badglyphname|vs_known;
   else {
      int i;

      if (sc->vert_variants != NULL) {
	 for (i=0; i<sc->vert_variants->part_cnt; ++i) {
	    if (!SCWorthOutputting
		(SFGetChar
		 (sc->parent, -1, sc->vert_variants->parts[i].component)))
	       sc->layers[layer].validation_state |=
		  vs_badglyphname|vs_known;
	    break;
	 }
      }
      if (sc->horiz_variants != NULL) {
	 for (i=0; i<sc->horiz_variants->part_cnt; ++i) {
	    if (!SCWorthOutputting
		(SFGetChar
		 (sc->parent, -1, sc->horiz_variants->parts[i].component)))
	       sc->layers[layer].validation_state |=
		  vs_badglyphname|vs_known;
	    break;
	 }
      }
   }

   for (ss=sc->layers[layer].splines; ss != NULL; ss=ss->next) {
      /* TrueType uses single points to move things around so ignore them */
      if (ss->first->next==NULL)
	 /* Do Nothing */ ;
      else if (ss->first->prev==NULL) {
	 sc->layers[layer].validation_state |= vs_opencontour|vs_known;
	 break;
      }
   }

   /* If there's an open contour we can't really tell whether it self-intersects */
   if (sc->layers[layer].validation_state&vs_opencontour)
      /* sc->layers[layer].validation_state |= vs_selfintersects */ ;
   else {
      if (SplineSetIntersect(base, &s1, &s2))
	 sc->layers[layer].validation_state |= vs_selfintersects|vs_known;
   }

   /* If there's a self-intersection we are guaranteed that both the self- */
   /*  intersecting contours will be in the wrong direction at some point */
   if (sc->layers[layer].validation_state&vs_selfintersects)
      /*sc->layers[layer].validation_state |= vs_wrongdirection */ ;
   else {
      if (SplineSetsDetectDir(&base, &lastscan) != NULL)
	 sc->layers[layer].validation_state |= vs_wrongdirection|vs_known;
   }

   /* Different kind of "wrong direction" */
   for (ref=sc->layers[layer].refs; ref != NULL; ref=ref->next) {
      if (ref->transform[0] * ref->transform[3]<0 ||
	  (ref->transform[0]==0
	   && ref->transform[1] * ref->transform[2]>0)) {
	 sc->layers[layer].validation_state |=
	    vs_flippedreferences|vs_known;
	 break;
      }
   }

   for (h=sc->hstem, cnt=0; h != NULL; h=h->next, ++cnt);
   for (h=sc->vstem; h != NULL; h=h->next, ++cnt);
   if (cnt >= 96)
      sc->layers[layer].validation_state |= vs_toomanyhints|vs_known;

   if (sc->layers[layer].splines != NULL) {
      int anyhm=0;

      h=NULL;
      for (ss=sc->layers[layer].splines; ss != NULL && h==NULL;
	   ss=ss->next) {
	 sp=ss->first;
	 do {
	    if (sp->hintmask != NULL) {
	       anyhm=true;
	       h=SCHintOverlapInMask(sc, sp->hintmask);
	       if (h != NULL)
		  break;
	    }
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	 } while (sp != ss->first);
      }
      if (!anyhm)
	 h=SCHintOverlapInMask(sc, NULL);
      if (h != NULL)
	 sc->layers[layer].validation_state |= vs_overlappedhints|vs_known;
   }

   memset(&lastpt, 0, sizeof(lastpt));
   for (ss=sc->layers[layer].splines, pt_cnt=path_cnt=0; ss != NULL;
	ss=ss->next, ++path_cnt) {
      for (sp=ss->first;;) {
	 /* If we're interpolating the point, it won't show up in the truetype */
	 /*  points list and it need not be integral (often it will end in .5) */
	 if ((!SPInterpolate(sp)
	      && (sp->me.x != rint(sp->me.x) || sp->me.y != rint(sp->me.y)))
	     || sp->nextcp.x != rint(sp->nextcp.x)
	     || sp->nextcp.y != rint(sp->nextcp.y)
	     || sp->prevcp.x != rint(sp->prevcp.x)
	     || sp->prevcp.y != rint(sp->prevcp.y))
	    sc->layers[layer].validation_state |= vs_nonintegral|vs_known;
	 if (BPTooFar(&lastpt, &sp->prevcp) ||
	     BPTooFar(&sp->prevcp, &sp->me) || BPTooFar(&sp->me, &sp->nextcp))
	    sc->layers[layer].validation_state |=
	       vs_pointstoofarapart|vs_known;
	 memcpy(&lastpt, &sp->nextcp, sizeof(lastpt));
	 ++pt_cnt;
	 if (sp->next==NULL)
	    break;
	 if (!sp->next->knownlinear) {
	    if (sp->next->order2)
	       ++pt_cnt;
	    else
	       pt_cnt += 2;
	 }
	 sp=sp->next->to;
	 if (sp==ss->first) {
	    memcpy(&lastpt, &sp->me, sizeof(lastpt));
	    break;
	 }
      }
   }
   if (pt_cnt>1500)
      sc->layers[layer].validation_state |= vs_toomanypoints|vs_known;

   LayerUnAllSplines(&sc->layers[layer]);

   /* Only check the splines in the glyph, not those in refs */
   bound2=sc->parent->extrema_bound;
   if (bound2 <= 0)
      bound2=(sc->parent->ascent+sc->parent->descent)/32.0;
   bound2 *= bound2;
   for (ss=sc->layers[layer].splines, cnt=0; ss != NULL; ss=ss->next) {
      first=NULL;
      for (s=ss->first->next; s != NULL && s != first; s=s->to->next) {
	 if (first==NULL)
	    first=s;
	 if (s->acceptableextrema)
	    continue;		/* If marked as good, don't check it */
	 /* rough appoximation to spline's length */
	 x=(s->to->me.x-s->from->me.x);
	 y=(s->to->me.y-s->from->me.y);
	 len2=x * x+y * y;
	 /* short splines (serifs) are not required to have points at their extrema */
	 if (len2>bound2 && Spline2DFindExtrema(s, extrema)>0) {
	    sc->layers[layer].validation_state |=
	       vs_missingextrema|vs_known;
	    goto break_2_loops;
	 }
      }
   }
 break_2_loops:;

   if ((tab=SFFindTable(sc->parent, CHR('m', 'a', 'x', 'p'))) != NULL
       && tab->len >= 32) {
      /* If we have a maxp table then do some truetype checks */
      /* these are only errors for fontlint, we'll fix them up when we */
      /*  generate the font -- but fontlint needs to know this stuff */
      int pt_max=memushort(tab->data, tab->len, 3*sizeof(uint16_t));
      int path_max=memushort(tab->data, tab->len, 4*sizeof(uint16_t));
      int composit_pt_max =
	 memushort(tab->data, tab->len, 5*sizeof(uint16_t));
      int composit_path_max =
	 memushort(tab->data, tab->len, 6*sizeof(uint16_t));
      int instr_len_max=memushort(tab->data, tab->len, 13*sizeof(uint16_t));
      int num_comp_max=memushort(tab->data, tab->len, 14*sizeof(uint16_t));
      int comp_depth_max =
	 memushort(tab->data, tab->len, 15*sizeof(uint16_t));
      int rd, rdtest;

      /* Already figured out two of these */
      if (sc->layers[layer].splines==NULL) {
	 if (pt_cnt>composit_pt_max)
	    sc->layers[layer].validation_state |=
	       vs_maxp_toomanycomppoints|vs_known;
	 if (path_cnt>composit_path_max)
	    sc->layers[layer].validation_state |=
	       vs_maxp_toomanycomppaths|vs_known;
      }

      for (ss=sc->layers[layer].splines, pt_cnt=path_cnt=0; ss != NULL;
	   ss=ss->next, ++path_cnt) {
	 for (sp=ss->first;;) {
	    ++pt_cnt;
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (sp==ss->first)
	       break;
	 }
      }
      if (pt_cnt>pt_max)
	 sc->layers[layer].validation_state |=
	    vs_maxp_toomanypoints|vs_known;
      if (path_cnt>path_max)
	 sc->layers[layer].validation_state |=
	    vs_maxp_toomanypaths|vs_known;

      if (sc->ttf_instrs_len>instr_len_max)
	 sc->layers[layer].validation_state |=
	    vs_maxp_instrtoolong|vs_known;

      rd=0;
      for (r=sc->layers[layer].refs, cnt=0; r != NULL; r=r->next, ++cnt) {
	 rdtest=RefDepth(r, layer);
	 if (rdtest>rd)
	    rd=rdtest;
      }
      if (cnt>num_comp_max)
	 sc->layers[layer].validation_state |= vs_maxp_toomanyrefs|vs_known;
      if (rd>comp_depth_max)
	 sc->layers[layer].validation_state |= vs_maxp_refstoodeep|vs_known;
   }

   k=0;
   cid=sc->parent;
   if (cid->cidmaster != NULL)
      cid=cid->cidmaster;
   do {
      sf=cid->subfontcnt==0?cid:cid->subfonts[k];
      for (gid=0; gid<sf->glyphcnt; ++gid)
	 if ((othersc=sf->glyphs[gid]) != NULL) {
	    if (othersc==sc)
	       continue;
	    if (strcmp(sc->name, othersc->name)==0)
	       sc->layers[layer].validation_state |= vs_dupname|vs_known;
	    if (sc->unicodeenc != -1 && UniMatch(-1, sc->unicodeenc, othersc))
	       sc->layers[layer].validation_state |= vs_dupunicode|vs_known;
	    for (alt=sc->altuni; alt != NULL; alt=alt->next)
	       if (UniMatch(alt->vs, alt->unienc, othersc))
		  sc->layers[layer].validation_state |=
		     vs_dupunicode|vs_known;
	 }
      ++k;
   } while (k<cid->subfontcnt);

 end:;
   /* This test is intentionally here and should be done even if the glyph */
   /*  hasn't changed. If the lookup changed it could make the glyph invalid */
   if (SCValidateAnchors(sc) != NULL)
      sc->layers[layer].validation_state |= vs_missinganchor;

   sc->layers[layer].validation_state |= vs_known;

   return (sc->layers[layer].validation_state&~vs_known);
}

int SFValidate(SplineFont *sf, int layer, int force) {
   int k, gid;
   SplineFont *sub;
   int any=0;
   SplineChar *sc;
   int cnt=0;

   if (sf->cidmaster)
      sf=sf->cidmaster;

   k=0;
   do {
      sub=sf->subfontcnt==0?sf:sf->subfonts[k];
      for (gid=0; gid<sub->glyphcnt; ++gid)
	 if ((sc=sub->glyphs[gid]) != NULL) {
	    if (force || !(sc->layers[layer].validation_state&vs_known)) {
	       SCValidate(sc, layer, true);
	    } else if (SCValidateAnchors(sc) != NULL)
	       sc->layers[layer].validation_state |= vs_missinganchor;

	    any |= sc->layers[layer].validation_state;
	 }
      ++k;
   } while (k<sf->subfontcnt);

   /* a lot of asian ttf files have a bad postscript fontname stored in the */
   /*  name table */
   return (any&~vs_known);
}

void SCTickValidationState(SplineChar * sc, int layer) {
   struct splinecharlist *dlist;

   sc->layers[layer].validation_state=vs_unknown;
   for (dlist=sc->dependents; dlist != NULL; dlist=dlist->next) {
      if (dlist->sc==sc)
	 ErrorMsg(2,"A glyph may not depend on itself in SCTickValidationState\n");
      else
	 SCTickValidationState(dlist->sc, layer);
   }
}

/**********************************************************************/

static int CheckBluePair(char *blues,char *others,int bluefuzz,
			 int magicpointsize) {
   int bound=2*bluefuzz+1;
   int bluevals[10+14], cnt, pos=0, maxzoneheight;
   int err=0;
   char *end;

   if (others != NULL) {
      while (*others==' ')
	 ++others;
      if (*others=='[' || *others=='{')
	 ++others;
      for (cnt=0;; ++cnt) {
	 double temp;

	 while (*others==' ')
	    ++others;
	 if (*others==']' || *others=='}')
	    break;
	 temp=strtod(others, &end);
	 if (temp != rint(temp))
	    err |= pds_notintegral;
	 else if (end==others) {
	    err |= pds_notintegral;
	    break;
	 }
	 others=end;
	 if (cnt >= 10)
	    err |= pds_toomany;
	 else
	    bluevals[pos++]=temp;
      }
      if (cnt&1)
	 err |= pds_odd;
   }

   while (*blues==' ')
      ++blues;
   if (*blues=='{' || *blues=='[')
      ++blues;
   for (cnt=0;; ++cnt) {
      double temp;

      while (*blues==' ')
	 ++blues;
      if (*blues==']' || *blues=='}')
	 break;
      temp=strtod(blues, &end);
      if (temp != rint(temp))
	 err |= pds_notintegral;
      else if (end==blues) {
	 err |= pds_notintegral;
	 break;
      }
      blues=end;
      if (cnt >= 14)
	 err |= pds_toomany;
      else
	 bluevals[pos++]=temp;
   }
   if (cnt&1)
      err |= pds_odd;

   /* Now there is nothing which says that otherblues must all be less than */
   /*  blues. But the examples suggest it. And I shall assume it */

   maxzoneheight=-1;
   for (cnt=0; cnt<pos; cnt += 2) {
      if (cnt+1<pos && bluevals[cnt]>bluevals[cnt+1])
	 err |= pds_outoforder;
      else if (cnt+1<pos
	       && maxzoneheight<bluevals[cnt+1]-bluevals[cnt])
	 maxzoneheight=bluevals[cnt+1]-bluevals[cnt];
      if (cnt != 0 && bluevals[cnt-1] >= bluevals[cnt])
	 err |= pds_outoforder;
      if (cnt != 0 && bluevals[cnt-1]+bound>bluevals[cnt])
	 err |= pds_tooclose;
   }

   if (maxzoneheight>0 && (magicpointsize-.49)*maxzoneheight >= 240)
      err |= pds_toobig;

   return (err);
}

static int CheckStdW(struct psdict *dict,char *key) {
   char *str_val, *end;
   double val;

   if ((str_val=PSDictHasEntry(dict, key))==NULL)
      return (true);
   while (*str_val==' ')
      ++str_val;
   if (*str_val != '[' && *str_val != '{')
      return (false);
   ++str_val;

   val=strtod(str_val, &end);
   while (*end==' ')
      ++end;
   if (*end != ']' && *end != '}')
      return (false);
   ++end;
   while (*end==' ')
      ++end;
   if (*end != '\0' || end==str_val || val <= 0)
      return (false);

   return (true);
}

static int CheckStemSnap(struct psdict *dict,char *snapkey,char *stdkey) {
   char *str_val, *end;
   double std_val=-1;
   double stems[12], temp;
   int cnt, found;

   /* At most 12 double values, in order, must include Std?W value, array */

   if ((str_val=PSDictHasEntry(dict, stdkey)) != NULL) {
      while (*str_val==' ')
	 ++str_val;
      if (*str_val=='[' && *str_val != '{')
	 ++str_val;
      std_val=strtod(str_val, &end);
   }

   if ((str_val=PSDictHasEntry(dict, snapkey))==NULL)
      return (true);		/* This entry is not required */
   while (*str_val==' ')
      ++str_val;
   if (*str_val != '[' && *str_val != '{')
      return (false);
   ++str_val;

   found=false;
   for (cnt=0;; ++cnt) {
      while (*str_val==' ')
	 ++str_val;
      if (*str_val==']' && *str_val != '}')
	 break;
      temp=strtod(str_val, &end);
      if (end==str_val)
	 return (false);
      str_val=end;
      if (cnt >= 12)
	 return (false);
      stems[cnt]=temp;
      if (cnt>0 && stems[cnt-1] >= stems[cnt])
	 return (false);
      if (stems[cnt]==std_val)
	 found=true;
   }
   if (!found && std_val>0)
      return (-1);

   return (true);
}

int ValidatePrivate(SplineFont *sf) {
   int errs=0;
   char *blues, *bf, *test, *end;
   int fuzz=1;
   double bluescale=.039625;
   int magicpointsize;

   if (sf->private==NULL)
      return (pds_missingblue);

   if ((bf=PSDictHasEntry(sf->private, "BlueFuzz")) != NULL) {
      fuzz=strtol(bf, &end, 10);
      if (*end != '\0' || fuzz<0)
	 errs |= pds_badbluefuzz;
   }

   if ((test=PSDictHasEntry(sf->private, "BlueScale")) != NULL) {
      bluescale=strtod(test, &end);
      if (*end != '\0' || end==test || bluescale<0)
	 errs |= pds_badbluescale;
   }
   magicpointsize=rint(bluescale*240+0.49);

   if ((blues=PSDictHasEntry(sf->private, "BlueValues"))==NULL)
      errs |= pds_missingblue;
   else
      errs |=
	 CheckBluePair(blues, PSDictHasEntry(sf->private, "OtherBlues"), fuzz,
		       magicpointsize);

   if ((blues=PSDictHasEntry(sf->private, "FamilyBlues")) != NULL)
      errs |=
	 CheckBluePair(blues, PSDictHasEntry(sf->private, "FamilyOtherBlues"),
		       fuzz, magicpointsize) << pds_shift;


   if ((test=PSDictHasEntry(sf->private, "BlueShift")) != NULL) {
      int val=strtol(test, &end, 10);

      if (*end != '\0' || end==test || val<0)
	 errs |= pds_badblueshift;
   }

   if (!CheckStdW(sf->private, "StdHW"))
      errs |= pds_badstdhw;
   if (!CheckStdW(sf->private, "StdVW"))
      errs |= pds_badstdvw;

   switch (CheckStemSnap(sf->private, "StemSnapH", "StdHW")) {
     case false:
	errs |= pds_badstemsnaph;
	break;
     case -1:
	errs |= pds_stemsnapnostdh;
	break;
   }
   switch (CheckStemSnap(sf->private, "StemSnapV", "StdVW")) {
     case false:
	errs |= pds_badstemsnapv;
	break;
     case -1:
	errs |= pds_stemsnapnostdv;
	break;
   }

   return (errs);
}
