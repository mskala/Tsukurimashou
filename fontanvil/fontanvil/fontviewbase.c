/* $Id: fontviewbase.c 4502 2015-12-16 14:11:53Z mskala $ */
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
#include "baseviews.h"
#include "psfont.h"
#include <gfile.h>
#include <ustring.h>
#include <utype.h>
#include <chardata.h>
#include <gresource.h>
#include <math.h>
#include <unistd.h>

static FontViewBase *fv_list=NULL;

extern int onlycopydisplayed;

float joinsnap=0;

static int SCUnselectedDependents(FontViewBase *fv,SplineChar *sc) {
   struct splinecharlist *dep;

   if (sc==NULL)
      return (false);

   for (dep=sc->dependents; dep != NULL; dep=dep->next) {
      if (!fv->selected[fv->map->backmap[dep->sc->orig_pos]])
	 return (true);
      if (SCUnselectedDependents(fv, dep->sc))
	 return (true);
   }
   return (false);
}

static int BCUnselectedDependents(FontViewBase *fv,BDFChar *bc) {
   struct bdfcharlist *dep;

   if (bc==NULL)
      return (false);

   for (dep=bc->dependents; dep != NULL; dep=dep->next) {
      if (!fv->selected[fv->map->backmap[dep->bc->orig_pos]])
	 return (true);
      if (BCUnselectedDependents(fv, dep->bc))
	 return (true);
   }
   return (false);
}

static int UnselectedDependents(FontViewBase *fv,int gid) {
   int ret=false;
   BDFFont *bdf;

   if (onlycopydisplayed && fv->active_bitmap==NULL) {
      ret=SCUnselectedDependents(fv, fv->sf->glyphs[gid]);
   } else if (onlycopydisplayed) {
      ret=BCUnselectedDependents(fv, fv->active_bitmap->glyphs[gid]);
   } else {
      ret=SCUnselectedDependents(fv, fv->sf->glyphs[gid]);
      for (bdf =
	   fv->sf->cidmaster ? fv->sf->cidmaster->bitmaps : fv->sf->bitmaps;
	   bdf != NULL; bdf=bdf->next)
	 ret |= BCUnselectedDependents(fv, bdf->glyphs[gid]);
   }
   return (ret);
}

void FVClear(FontViewBase * fv) {
   int i;
   BDFFont *bdf;
   int refstate=0;
   int yes, unsel, gid;

   /* refstate==0 => ask, refstate==1 => clearall, refstate==-1 => skip all */

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1) {
	 /* If we are messing with the outline character, check for dependencies */
	 if (refstate <= 0 && (unsel=UnselectedDependents(fv, gid))) {
	    if (refstate==0) {
	       yes=2;
	       refstate=-2;
	    }
	    if (refstate==-2) {
	       if (onlycopydisplayed && fv->active_bitmap==NULL)
		  UnlinkThisReference(fv, fv->sf->glyphs[gid],
				      fv->active_layer);
	       else if (onlycopydisplayed && fv->active_bitmap != NULL)
		  BCUnlinkThisReference(fv, fv->active_bitmap->glyphs[gid]);
	       else {
		  UnlinkThisReference(fv, fv->sf->glyphs[gid],
				      fv->active_layer);
		  for (bdf =
		       fv->sf->cidmaster ? fv->sf->cidmaster->bitmaps : fv->
		       sf->bitmaps; bdf != NULL; bdf=bdf->next)
		     BCUnlinkThisReference(fv, bdf->glyphs[gid]);
	       }
	    } else if (refstate==-1)
	       continue;
	 }

	 if (onlycopydisplayed && fv->active_bitmap==NULL) {
	    SCClearAll(fv->sf->glyphs[gid], fv->active_layer);
	 } else if (onlycopydisplayed) {
	    BCClearAll(fv->active_bitmap->glyphs[gid]);
	 } else {
	    SCClearAll(fv->sf->glyphs[gid], fv->active_layer);
	    for (bdf =
		 fv->sf->cidmaster ? fv->sf->cidmaster->bitmaps : fv->sf->
		 bitmaps; bdf != NULL; bdf=bdf->next)
	       BCClearAll(bdf->glyphs[gid]);
	 }
      }
}

void FVClearBackground(FontViewBase * fv) {
   SplineFont *sf=fv->sf;
   int i, gid;

   if (onlycopydisplayed && fv->active_bitmap != NULL)
      return;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1 && sf->glyphs[gid] != NULL) {
	 SCClearBackground(sf->glyphs[gid]);
      }
}

void FVCopyFgtoBg(FontViewBase * fv) {
   int i, gid;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  fv->sf->glyphs[gid] != NULL)
	 SCCopyLayerToLayer(fv->sf->glyphs[gid], fv->active_layer, ly_back,
			    true);
}

void FVUnlinkRef(FontViewBase * fv) {
   int i, layer, first, last, gid;
   SplineChar *sc;
   RefChar *rf, *next;
   BDFFont *bdf;
   BDFChar *bdfc;
   BDFRefChar *head, *cur;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1
	  && (sc=fv->sf->glyphs[gid]) != NULL) {
	 if ((fv->active_bitmap==NULL || !onlycopydisplayed)
	     && sc->layers[fv->active_layer].refs != NULL) {
	    SCPreserveLayer(sc, fv->active_layer, false);
	    if (sc->parent->multilayer) {
	       first=ly_fore;
	       last=sc->layer_cnt - 1;
	    } else
	       first=last=fv->active_layer;
	    for (layer=first; layer <= last; ++layer) {
	       for (rf=sc->layers[layer].refs; rf != NULL; rf=next) {
		  next=rf->next;
		  SCRefToSplines(sc, rf, layer);
	       }
	    }
	    SCCharChangedUpdate(sc, fv->active_layer, true);
	 }

	 for (bdf=fv->sf->bitmaps; bdf != NULL; bdf=bdf->next) {
	    if (bdf != fv->active_bitmap && onlycopydisplayed)
	       continue;

	    bdfc=gid==-1
	       || gid >= bdf->glyphcnt ? NULL : bdf->glyphs[gid];
	    if (bdfc != NULL && bdfc->refs != NULL) {
	       BCMergeReferences(bdfc, bdfc, 0, 0);
	       for (head=bdfc->refs; head != NULL;) {
		  cur=head;
		  head=cur->next;
		  free(cur);
	       }
	       bdfc->refs=NULL;
	       BCCharChangedUpdate(bdfc);
	    }
	 }
      }
}

void FVJoin(FontViewBase * fv) {
   SplineFont *sf=fv->sf;
   int i, changed, gid;
   extern float joinsnap;

   if (onlycopydisplayed && fv->active_bitmap != NULL)
      return;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1 && sf->glyphs[gid] != NULL) {
	 SCPreserveLayer(sf->glyphs[gid], fv->active_layer, false);
	 sf->glyphs[gid]->layers[fv->active_layer].splines =
	    SplineSetJoin(sf->glyphs[gid]->layers[fv->active_layer].splines,
			  true, joinsnap, &changed);
	 if (changed)
	    SCCharChangedUpdate(sf->glyphs[gid], fv->active_layer, true);
      }
}

static void LinkEncToGid(FontViewBase *fv,int enc,int gid) {
   EncMap *map=fv->map;
   int old_gid;
   int flags=-1;
   int j;

   if (map->map[enc] != -1 && map->map[enc] != gid) {
      SplineFont *sf=fv->sf;

      old_gid=map->map[enc];
      for (j=0; j < map->enccount; ++j)
	 if (j != enc && map->map[j]==old_gid)
	    break;
      /* If the glyph is used elsewhere in the encoding then reusing this */
      /* slot causes no problems */
      if (j==map->enccount) {
	 /* However if this is the only use and the glyph is interesting */
	 /*  then add it to the unencoded area. If it is uninteresting we */
	 /*  can just get rid of it */
	 if (SCWorthOutputting(sf->glyphs[old_gid]))
	    SFAddEncodingSlot(sf, old_gid);
	 else
	    SFRemoveGlyph(sf, sf->glyphs[old_gid], &flags);
      }
   }
   map->map[enc]=gid;
   if (map->backmap[gid]==-1)
      map->backmap[gid]=enc;
   if (map->enc != &custom) {
      int uni=UniFromEnc(enc, map->enc);

      AltUniAdd(fv->sf->glyphs[gid], uni);
   }
}

void FVSameGlyphAs(FontViewBase * fv) {
   SplineFont *sf=fv->sf;
   RefChar *base=CopyContainsRef(sf);
   int i;
   EncMap *map=fv->map;

   if (base==NULL || fv->cidmaster != NULL)
      return;
   for (i=0; i < map->enccount; ++i)
      if (fv->selected[i]) {
	 LinkEncToGid(fv, i, base->orig_pos);
      }
}

void FVBuildDuplicate(FontViewBase * fv) {
   extern const int cns14pua[], amspua[];
   const int *pua =
      fv->sf->uni_interp==ui_trad_chinese ? cns14pua : fv->sf->uni_interp ==
      ui_ams ? amspua : NULL;
   int i, cnt=0, gid;
   SplineChar dummy;
   const unichar_t *pt;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i])
	 ++cnt;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i]) {
	 SplineChar *sc;
	 int baseuni=0;

	 if ((gid=fv->map->map[i])==-1
	     || (sc=fv->sf->glyphs[gid])==NULL)
	    sc=SCBuildDummy(&dummy, fv->sf, fv->map, i);
	 if (pua != NULL && sc->unicodeenc >= 0xe000
	     && sc->unicodeenc <= 0xf8ff)
	    baseuni=pua[sc->unicodeenc - 0xe000];
	 if (baseuni==0
	     && (pt =
		 SFGetAlternate(fv->sf, sc->unicodeenc, sc, false)) != NULL
	     && pt[0] != '\0' && pt[1]=='\0')
	    baseuni=pt[0];

	 if (baseuni != 0
	     && (gid=SFFindExistingSlot(fv->sf, baseuni, NULL)) != -1)
	    LinkEncToGid(fv, i, gid);
      }
}

void TransHints(StemInfo * stem, double mul1, double off1, double mul2, double off2,
		int round_to_int) {
   HintInstance *hi;

   for (; stem != NULL; stem=stem->next) {
      stem->start=stem->start * mul1 + off1;
      stem->width *= mul1;
      if (round_to_int) {
	 stem->start=rint(stem->start);
	 stem->width=rint(stem->width);
      }
      if (mul1 < 0) {
	 stem->start += stem->width;
	 stem->width=-stem->width;
      }
      for (hi=stem->where; hi != NULL; hi=hi->next) {
	 hi->begin=hi->begin * mul2 + off2;
	 hi->end=hi->end * mul2 + off2;
	 if (round_to_int) {
	    hi->begin=rint(hi->begin);
	    hi->end=rint(hi->end);
	 }
	 if (mul2 < 0) {
	    double temp=hi->begin;

	    hi->begin=hi->end;
	    hi->end=temp;
	 }
      }
   }
}

/* added by akryukov 01/01/2008 to enable resizing and flipping DStem hints */
void TransDStemHints(DStemInfo * ds, double xmul, double xoff, double ymul,
		     double yoff, int round_to_int) {
   HintInstance *hi;
   double dmul, temp;

   for (; ds != NULL; ds=ds->next) {
      ds->left.x=xmul * ds->left.x + xoff;
      ds->left.y=ymul * ds->left.y + yoff;
      ds->right.x=xmul * ds->right.x + xoff;
      ds->right.y=ymul * ds->right.y + yoff;
      if (round_to_int) {
	 ds->left.x=rint(ds->left.x);
	 ds->left.y=rint(ds->left.y);
	 ds->right.x=rint(ds->right.x);
	 ds->right.y=rint(ds->right.y);
      }

      if ((xmul < 0 && ymul > 0) || (xmul > 0 && ymul < 0))
	 ds->unit.y=-ds->unit.y;
      ds->unit.x *= fabs(xmul);
      ds->unit.y *= fabs(ymul);
      dmul=sqrt(pow(ds->unit.x, 2) + pow(ds->unit.y, 2));
      ds->unit.x /= dmul;
      ds->unit.y /= dmul;
      if (xmul < 0)
	 dmul=-dmul;

      for (hi=ds->where; hi != NULL; hi=hi->next) {
	 if (dmul > 0) {
	    hi->begin=hi->begin * dmul;
	    hi->end=hi->end * dmul;
	 } else {
	    temp=hi->begin;
	    hi->begin=hi->end * dmul;
	    hi->end=temp * dmul;
	 }
      }
   }
}

void VrTrans(struct vr *vr, double transform[6]) {
   /* I'm interested in scaling and skewing. I think translation should */
   /*  not affect these guys (they are offsets, so offsets should be */
   /*  unchanged by translation */
   double x, y;

   x=vr->xoff;
   y=vr->yoff;
   vr->xoff=rint(transform[0] * x + transform[1] * y);
   vr->yoff=rint(transform[2] * x + transform[3] * y);
   x=vr->h_adv_off;
   y=vr->v_adv_off;
   vr->h_adv_off=rint(transform[0] * x + transform[1] * y);
   vr->v_adv_off=rint(transform[2] * x + transform[3] * y);
}

void BackgroundImageTransform(SplineChar * sc, ImageList * img,
			      double transform[6]) {
   if (transform[1]==0 && transform[2]==0 && transform[0] > 0
       && transform[3] > 0) {
      img->xoff=transform[0] * img->xoff + transform[4];
      img->yoff=transform[3] * img->yoff + transform[5];
      if ((img->xscale *= transform[0]) < 0)
	 img->xscale=-img->xscale;
      if ((img->yscale *= transform[3]) < 0)
	 img->yscale=-img->yscale;
      img->bb.minx=img->xoff;
      img->bb.maxy=img->yoff;
      img->bb.maxx=img->xoff + GImageGetWidth(img->image) * img->xscale;
      img->bb.miny=img->yoff - GImageGetHeight(img->image) * img->yscale;
   } else {
      /* Don't support rotating, flipping or skewing images */
      ;
   }
}

static void GV_Trans(struct glyphvariants *gv,double transform[6],int is_v) {
   int i;

   if (gv==NULL)
      return;
   gv->italic_correction=rint(gv->italic_correction * transform[0]);
   is_v=3 * is_v;
   for (i=0; i < gv->part_cnt; ++i) {
      gv->parts[i].startConnectorLength =
	 rint(gv->parts[i].startConnectorLength * transform[is_v]);
      gv->parts[i].endConnectorLength =
	 rint(gv->parts[i].endConnectorLength * transform[is_v]);
      gv->parts[i].fullAdvance =
	 rint(gv->parts[i].fullAdvance * transform[is_v]);
   }
}

static void MKV_Trans(struct mathkernvertex *mkv,double transform[6]) {
   int i;

   for (i=0; i < mkv->cnt; ++i) {
      mkv->mkd[i].kern=rint(mkv->mkd[i].kern * transform[0]);
      mkv->mkd[i].height=rint(mkv->mkd[i].height * transform[0]);
   }
}

static void MK_Trans(struct mathkern *mk,double transform[6]) {
   if (mk==NULL)
      return;
   MKV_Trans(&mk->top_right, transform);
   MKV_Trans(&mk->top_left, transform);
   MKV_Trans(&mk->bottom_right, transform);
   MKV_Trans(&mk->bottom_left, transform);
}

static void MATH_Trans(struct MATH *math,double transform[6]) {
   if (math==NULL)
      return;
   math->DelimitedSubFormulaMinHeight =
      rint(math->DelimitedSubFormulaMinHeight * transform[3]);
   math->DisplayOperatorMinHeight =
      rint(math->DisplayOperatorMinHeight * transform[3]);
   math->MathLeading=rint(math->MathLeading * transform[3]);
   math->AxisHeight=rint(math->AxisHeight * transform[3]);
   math->AccentBaseHeight=rint(math->AccentBaseHeight * transform[3]);
   math->FlattenedAccentBaseHeight =
      rint(math->FlattenedAccentBaseHeight * transform[3]);
   math->SubscriptShiftDown=rint(math->SubscriptShiftDown * transform[3]);
   math->SubscriptTopMax=rint(math->SubscriptTopMax * transform[3]);
   math->SubscriptBaselineDropMin =
      rint(math->SubscriptBaselineDropMin * transform[3]);
   math->SuperscriptShiftUp=rint(math->SuperscriptShiftUp * transform[3]);
   math->SuperscriptShiftUpCramped =
      rint(math->SuperscriptShiftUpCramped * transform[3]);
   math->SuperscriptBottomMin =
      rint(math->SuperscriptBottomMin * transform[3]);
   math->SuperscriptBaselineDropMax =
      rint(math->SuperscriptBaselineDropMax * transform[3]);
   math->SubSuperscriptGapMin =
      rint(math->SubSuperscriptGapMin * transform[3]);
   math->SuperscriptBottomMaxWithSubscript =
      rint(math->SuperscriptBottomMaxWithSubscript * transform[3]);
   /* SpaceAfterScript is horizontal and is below */
   math->UpperLimitGapMin=rint(math->UpperLimitGapMin * transform[3]);
   math->UpperLimitBaselineRiseMin =
      rint(math->UpperLimitBaselineRiseMin * transform[3]);
   math->LowerLimitGapMin=rint(math->LowerLimitGapMin * transform[3]);
   math->LowerLimitBaselineDropMin =
      rint(math->LowerLimitBaselineDropMin * transform[3]);
   math->StackTopShiftUp=rint(math->StackTopShiftUp * transform[3]);
   math->StackTopDisplayStyleShiftUp =
      rint(math->StackTopDisplayStyleShiftUp * transform[3]);
   math->StackBottomShiftDown =
      rint(math->StackBottomShiftDown * transform[3]);
   math->StackBottomDisplayStyleShiftDown =
      rint(math->StackBottomDisplayStyleShiftDown * transform[3]);
   math->StackGapMin=rint(math->StackGapMin * transform[3]);
   math->StackDisplayStyleGapMin =
      rint(math->StackDisplayStyleGapMin * transform[3]);
   math->StretchStackTopShiftUp =
      rint(math->StretchStackTopShiftUp * transform[3]);
   math->StretchStackBottomShiftDown =
      rint(math->StretchStackBottomShiftDown * transform[3]);
   math->StretchStackGapAboveMin =
      rint(math->StretchStackGapAboveMin * transform[3]);
   math->StretchStackGapBelowMin =
      rint(math->StretchStackGapBelowMin * transform[3]);
   math->FractionNumeratorShiftUp =
      rint(math->FractionNumeratorShiftUp * transform[3]);
   math->FractionNumeratorDisplayStyleShiftUp =
      rint(math->FractionNumeratorDisplayStyleShiftUp * transform[3]);
   math->FractionDenominatorShiftDown =
      rint(math->FractionDenominatorShiftDown * transform[3]);
   math->FractionDenominatorDisplayStyleShiftDown =
      rint(math->FractionDenominatorDisplayStyleShiftDown * transform[3]);
   math->FractionNumeratorGapMin =
      rint(math->FractionNumeratorGapMin * transform[3]);
   math->FractionNumeratorDisplayStyleGapMin =
      rint(math->FractionNumeratorDisplayStyleGapMin * transform[3]);
   math->FractionRuleThickness =
      rint(math->FractionRuleThickness * transform[3]);
   math->FractionDenominatorGapMin =
      rint(math->FractionDenominatorGapMin * transform[3]);
   math->FractionDenominatorDisplayStyleGapMin =
      rint(math->FractionDenominatorDisplayStyleGapMin * transform[3]);
   /* SkewedFractionHorizontalGap is horizontal and is below */
   math->SkewedFractionVerticalGap =
      rint(math->SkewedFractionVerticalGap * transform[3]);
   math->OverbarVerticalGap=rint(math->OverbarVerticalGap * transform[3]);
   math->OverbarRuleThickness =
      rint(math->OverbarRuleThickness * transform[3]);
   math->OverbarExtraAscender =
      rint(math->OverbarExtraAscender * transform[3]);
   math->UnderbarVerticalGap=rint(math->UnderbarVerticalGap * transform[3]);
   math->UnderbarRuleThickness =
      rint(math->UnderbarRuleThickness * transform[3]);
   math->UnderbarExtraDescender =
      rint(math->UnderbarExtraDescender * transform[3]);
   math->RadicalVerticalGap=rint(math->RadicalVerticalGap * transform[3]);
   math->RadicalDisplayStyleVerticalGap =
      rint(math->RadicalDisplayStyleVerticalGap * transform[3]);
   math->RadicalRuleThickness =
      rint(math->RadicalRuleThickness * transform[3]);
   math->RadicalExtraAscender =
      rint(math->RadicalExtraAscender * transform[3]);
   math->RadicalDegreeBottomRaisePercent =
      rint(math->RadicalDegreeBottomRaisePercent * transform[3]);

   /* Horizontals */
   math->SpaceAfterScript=rint(math->SpaceAfterScript * transform[0]);
   math->SkewedFractionHorizontalGap =
      rint(math->SkewedFractionHorizontalGap * transform[0]);
   math->RadicalKernBeforeDegree =
      rint(math->RadicalKernBeforeDegree * transform[0]);
   math->RadicalKernAfterDegree =
      rint(math->RadicalKernAfterDegree * transform[0]);

   /* This number is the same for both horizontal and vertical connections */
   /*  Use the vertical amount as a) will probably be the same and */
   /*   b) most are vertical anyway */
   math->RadicalKernAfterDegree =
      rint(math->RadicalKernAfterDegree * transform[0]);
}

static void KCTrans(KernClass *kc,double scale) {
   /* Again these are offsets, so I don't apply translation */
   int i;

   for (i=kc->first_cnt * kc->second_cnt - 1; i >= 0; --i)
      kc->offsets[i]=rint(scale * kc->offsets[i]);
}

static void SCTransLayer(FontViewBase *fv,SplineChar *sc,int flags,int i,
			 double transform[6], uint8_t * sel) {
   int j;
   RefChar *refs;
   double t[6];
   ImageList *img;

   SplinePointListTransform(sc->layers[i].splines, transform, tpt_AllPoints);
   for (refs=sc->layers[i].refs; refs != NULL; refs=refs->next) {
      if ((sel != NULL && sel[fv->map->backmap[refs->sc->orig_pos]]) ||
	  (flags & fvt_partialreftrans)) {
	 /* if the character referred to is selected then it's going to */
	 /*  be scaled too (or will have been) so we don't want to scale */
	 /*  it twice */
	 t[4]=refs->transform[4] * transform[0] +
	    refs->transform[5] * transform[2] +
	    /*transform[4] */ 0;
	 t[5]=refs->transform[4] * transform[1] +
	    refs->transform[5] * transform[3] +
	    /*transform[5] */ 0;
	 t[0]=refs->transform[4];
	 t[1]=refs->transform[5];
	 refs->transform[4]=t[4];
	 refs->transform[5]=t[5];
	 /* Now update the splines to match */
	 t[4] -= t[0];
	 t[5] -= t[1];
	 if (t[4] != 0 || t[5] != 0) {
	    t[0]=t[3]=1;
	    t[1]=t[2]=0;
	    for (j=0; j < refs->layer_cnt; ++j)
	       SplinePointListTransform(refs->layers[j].splines, t,
					tpt_AllPoints);
	 }
      } else {
	 for (j=0; j < refs->layer_cnt; ++j)
	    SplinePointListTransform(refs->layers[j].splines, transform,
				     tpt_AllPoints);
	 t[0] =
	    refs->transform[0] * transform[0] +
	    refs->transform[1] * transform[2];
	 t[1] =
	    refs->transform[0] * transform[1] +
	    refs->transform[1] * transform[3];
	 t[2] =
	    refs->transform[2] * transform[0] +
	    refs->transform[3] * transform[2];
	 t[3] =
	    refs->transform[2] * transform[1] +
	    refs->transform[3] * transform[3];
	 t[4] =
	    refs->transform[4] * transform[0] +
	    refs->transform[5] * transform[2] + transform[4];
	 t[5] =
	    refs->transform[4] * transform[1] +
	    refs->transform[5] * transform[3] + transform[5];
	 memcpy(refs->transform, t, sizeof(t));
      }
      RefCharFindBounds(refs);
   }
   for (img=sc->layers[i].images; img != NULL; img=img->next)
      BackgroundImageTransform(sc, img, transform);
}

/* If sel is specified then we decide how to transform references based on */
/*  whether the refered glyph is selected. (If we tranform a reference that */
/*  is selected we are, in effect, transforming it twice -- since the glyph */
/*  itself will be transformed -- so instead we just transform the offsets */
/*  of the reference */
/* If sel is NULL then we transform the reference */
/* if flags&fvt_partialreftrans then we always just transform the offsets */
void FVTrans(FontViewBase * fv, SplineChar * sc, double transform[6],
	     uint8_t * sel, enum fvtrans_flags flags) {
   AnchorPoint *ap;
   int i, first, last;
   KernPair *kp;
   PST *pst;

   if (sc->blended) {
      int j;
      MMSet *mm=sc->parent->mm;

      for (j=0; j < mm->instance_count; ++j)
	 FVTrans(fv, mm->instances[j]->glyphs[sc->orig_pos], transform, sel,
		 flags);
   }

   if (flags & fvt_alllayers) {
      for (i=0; i < sc->layer_cnt; ++i)
	 SCPreserveLayer(sc, i, fv->active_layer==i);
   } else if (fv->sf->multilayer)
      SCPreserveState(sc, true);
   else
      SCPreserveLayer(sc, fv->active_layer, true);
   if (!(flags & fvt_dontmovewidth))
      if (transform[0] > 0 && transform[3] > 0 && transform[1]==0
	  && transform[2]==0) {
	 int widthset=sc->widthset;

	 SCSynchronizeWidth(sc, sc->width * transform[0] + transform[4],
			    sc->width, fv);
	 if (!(flags & fvt_dontsetwidth))
	    sc->widthset=widthset;
	 sc->vwidth=sc->vwidth * transform[3] + transform[5];
      }
   if (flags & fvt_scalepstpos) {
      for (kp=sc->kerns; kp != NULL; kp=kp->next)
	 kp->off=rint(kp->off * transform[0]);
      for (kp=sc->vkerns; kp != NULL; kp=kp->next)
	 kp->off=rint(kp->off * transform[3]);
      for (pst=sc->possub; pst != NULL; pst=pst->next) {
	 if (pst->type==pst_position)
	    VrTrans(&pst->u.pos, transform);
	 else if (pst->type==pst_pair) {
	    VrTrans(&pst->u.pair.vr[0], transform);
	    VrTrans(&pst->u.pair.vr[1], transform);
	 } else if (pst->type==pst_lcaret) {
	    int j;

	    for (j=0; j < pst->u.lcaret.cnt; ++j)
	       pst->u.lcaret.carets[j] =
		  rint(pst->u.lcaret.carets[j] * transform[0] + transform[4]);
	 }
      }
   }

   if (sc->tex_height != TEX_UNDEF)
      sc->tex_height=rint(sc->tex_height * transform[3]);
   if (sc->tex_depth != TEX_UNDEF)
      sc->tex_depth=rint(sc->tex_depth * transform[3]);
   if (sc->italic_correction != TEX_UNDEF)
      sc->italic_correction=rint(sc->italic_correction * transform[0]);
   if (sc->top_accent_horiz != TEX_UNDEF)
      sc->top_accent_horiz=rint(sc->top_accent_horiz * transform[0]);
   GV_Trans(sc->vert_variants, transform, true);
   GV_Trans(sc->horiz_variants, transform, false);
   MK_Trans(sc->mathkern, transform);

   for (ap=sc->anchor; ap != NULL; ap=ap->next)
      ApTransform(ap, transform);
   if (flags & fvt_alllayers) {
      first=0;
      last=sc->layer_cnt - 1;
   } else if (sc->parent->multilayer) {
      first=ly_fore;
      last=sc->layer_cnt - 1;
   } else
      first=last=fv->active_layer;
   for (i=first; i <= last; ++i)
      SCTransLayer(fv, sc, flags, i, transform, sel);
   if (transform[1]==0 && transform[2]==0) {
      if (transform[0]==1 && transform[3]==1 &&
	  transform[5]==0 && transform[4] != 0 &&
	  sc->unicodeenc != -1 && sc->unicodeenc < 0x10000 &&
	  isalpha(sc->unicodeenc)) {
	 SCUndoSetLBearingChange(sc, (int) rint(transform[4]));
	 SCSynchronizeLBearing(sc, transform[4], fv->active_layer);	/* this moves the hints */
      } else {
	 TransHints(sc->hstem, transform[3], transform[5], transform[0],
		    transform[4], flags & fvt_round_to_int);
	 TransHints(sc->vstem, transform[0], transform[4], transform[3],
		    transform[5], flags & fvt_round_to_int);
	 TransDStemHints(sc->dstem, transform[0], transform[4], transform[3],
			 transform[5], flags & fvt_round_to_int);
      }
   }
   /*if ( flags&fvt_round_to_int ) */
   if ((flags & fvt_round_to_int) && (!sc->inspiro || !hasspiro())) {
      /* Rounding the spiros might be a bad idea. */
      /* Not rounding the spiros is also a bad idea. */
      /* Not sure which is worse */
      /* Barry thinks rounding them is a bad idea. */
      SCRound2Int(sc, fv->active_layer, 1.0);
   }
   SCCharChangedUpdate(sc, fv->active_layer, true);
}

void FVTransFunc(void *_fv, double transform[6], int otype, BVTFunc * bvts,
		 enum fvtrans_flags flags) {
   FontViewBase *fv=_fv;
   double transx=transform[4], transy=transform[5];
   DBounds bb;
   BasePoint base;
   int i, cnt=0, gid;
   BDFFont *bdf;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]))
	 ++cnt;


   SFUntickAll(fv->sf);
   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]) &&
	  !fv->sf->glyphs[gid]->ticked) {
	 SplineChar *sc=fv->sf->glyphs[gid];

	 if (onlycopydisplayed && fv->active_bitmap != NULL) {
	    if (fv->active_bitmap->glyphs[gid] != NULL)
	       BCTrans(fv->active_bitmap, fv->active_bitmap->glyphs[gid],
		       bvts, fv);
	 } else {
	    if (otype==1) {
	       SplineCharFindBounds(sc, &bb);
	       base.x=(bb.minx + bb.maxx) / 2;
	       base.y=(bb.miny + bb.maxy) / 2;
	       transform[4]=transx + base.x -
		  (transform[0] * base.x + transform[2] * base.y);
	       transform[5]=transy + base.y -
		  (transform[1] * base.x + transform[3] * base.y);
	    }
	    FVTrans(fv, sc, transform, fv->selected, flags);
	    if (!onlycopydisplayed) {
	       for (bdf=fv->sf->bitmaps; bdf != NULL; bdf=bdf->next)
		  if (gid < bdf->glyphcnt && bdf->glyphs[gid] != NULL)
		     BCTrans(bdf, bdf->glyphs[gid], bvts, fv);
	    }
	 }
	 sc->ticked=true;
      }
   if (flags & fvt_dogrid) {
      SplinePointListTransform(fv->sf->grid.splines, transform,
			       tpt_AllPoints);
   }

   if (flags & fvt_scalekernclasses) {
      KernClass *kc;
      SplineFont *sf=fv->cidmaster != NULL ? fv->cidmaster : fv->sf;

      for (kc=sf->kerns; kc != NULL; kc=kc->next)
	 KCTrans(kc, transform[0]);
      for (kc=sf->vkerns; kc != NULL; kc=kc->next)
	 KCTrans(kc, transform[3]);
      if (sf->MATH != NULL)
	 MATH_Trans(sf->MATH, transform);
   }
}

void FVOverlap(FontViewBase * fv, enum overlap_type ot) {
   int i, cnt=0, layer, first, last, gid;
   SplineChar *sc;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]))
	 ++cnt;

   SFUntickAll(fv->sf);
   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting((sc=fv->sf->glyphs[gid])) && !sc->ticked) {
	 sc->ticked=true;
	 if (!SCRoundToCluster(sc, ly_all, false, .03, .12))
	    SCPreserveLayer(sc, fv->active_layer, false);
	 MinimumDistancesFree(sc->md);
	 if (sc->parent->multilayer) {
	    first=ly_fore;
	    last=sc->layer_cnt - 1;
	 } else
	    first=last=fv->active_layer;
	 for (layer=first; layer <= last; ++layer)
	    sc->layers[layer].splines =
	       SplineSetRemoveOverlap(sc, sc->layers[layer].splines, ot);
	 SCCharChangedUpdate(sc, fv->active_layer, true);
      }
}

void FVAddExtrema(FontViewBase * fv, int force_adding) {
   int i, cnt=0, layer, first, last, gid;
   SplineChar *sc;
   SplineFont *sf=fv->sf;
   int emsize=sf->ascent + sf->descent;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]))
	 ++cnt;

   SFUntickAll(fv->sf);
   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting((sc=fv->sf->glyphs[gid])) && !sc->ticked) {
	 sc->ticked=true;
	 if (sc->parent->multilayer) {
	    first=ly_fore;
	    last=sc->layer_cnt - 1;
	 } else
	    first=last=fv->active_layer;
	 for (layer=first; layer <= last; ++layer) {
	    SCPreserveLayer(sc, layer, false);
	    SplineCharAddExtrema(sc, sc->layers[layer].splines,
				 force_adding ? ae_all : ae_only_good,
				 emsize);
	 }
	 SCCharChangedUpdate(sc, fv->active_layer, true);
      }
}

void _FVSimplify(FontViewBase * fv, struct simplifyinfo *smpl) {
   int i, cnt=0, layer, first, last, gid;
   SplineChar *sc;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]))
	 ++cnt;

   SFUntickAll(fv->sf);
   for (i=0; i < fv->map->enccount; ++i)
      if ((gid=fv->map->map[i]) != -1
	  && SCWorthOutputting((sc=fv->sf->glyphs[gid])) && fv->selected[i]
	  && !sc->ticked) {
	 sc->ticked=true;
	 SCPreserveLayer(sc, fv->active_layer, false);
	 if (sc->parent->multilayer) {
	    first=ly_fore;
	    last=sc->layer_cnt - 1;
	 } else
	    first=last=fv->active_layer;
	 for (layer=first; layer <= last; ++layer)
	    sc->layers[layer].splines =
	       SplineCharSimplify(sc, sc->layers[layer].splines, smpl);
	 SCCharChangedUpdate(sc, fv->active_layer, true);
      }
}

void FVAutoHint(FontViewBase * fv) {
   int i, cnt=0, gid;
   BlueData *bd=NULL, _bd;
   SplineChar *sc;

   if (fv->sf->mm==NULL) {
      QuickBlues(fv->sf, fv->active_layer, &_bd);
      bd=&_bd;
   }

   /* Tick the ones we don't want to AH, untick the ones that need AH */
   for (gid=0; gid < fv->sf->glyphcnt; ++gid)
      if ((sc=fv->sf->glyphs[gid]) != NULL)
	 sc->ticked=true;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(sc=fv->sf->glyphs[gid])) {
	 ++cnt;
	 sc->ticked=false;
      }

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1
	  && SCWorthOutputting(fv->sf->glyphs[gid])) {
	 sc=fv->sf->glyphs[gid];
	 sc->manualhints=false;
	 /* Hint undoes are done in _SplineCharAutoHint */
	 SFSCAutoHint(sc, fv->active_layer, bd);
      }
}

void FVAutoHintSubs(FontViewBase * fv) {
   int i, cnt=0, gid;

   if (fv->sf->mm != NULL && fv->sf->mm->apple)
      return;
   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]))
	 ++cnt;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1
	  && SCWorthOutputting(fv->sf->glyphs[gid])) {
	 SplineChar *sc=fv->sf->glyphs[gid];

	 SCFigureHintMasks(sc, fv->active_layer);
      }
}

void FVAutoCounter(FontViewBase * fv) {
   int i, cnt=0, gid;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]))
	 ++cnt;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1
	  && SCWorthOutputting(fv->sf->glyphs[gid])) {
	 SplineChar *sc=fv->sf->glyphs[gid];

	 SCFigureCounterMasks(sc);
      }
}

void FVDontAutoHint(FontViewBase * fv) {
   int i, gid;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1
	  && SCWorthOutputting(fv->sf->glyphs[gid])) {
	 SplineChar *sc=fv->sf->glyphs[gid];

	 sc->manualhints=true;
      }
}

static int AllGlyphsSelected(FontViewBase *fv) {
   SplineFont *sf=fv->sf;
   int gid, enc;
   SplineChar *sc;

   for (gid=0; gid < sf->glyphcnt; ++gid)
      if ((sc=sf->glyphs[gid]) != NULL)
	 sc->ticked=false;

   for (enc=0; enc < fv->map->enccount; ++enc) {
      if (fv->selected[enc] && (gid=fv->map->map[enc]) != -1 &&
	  (sc=sf->glyphs[gid]) != NULL)
	 sc->ticked=true;
   }
   for (gid=0; gid < sf->glyphcnt; ++gid)
      if ((sc=sf->glyphs[gid]) != NULL)
	 if (!sc->ticked)
	    return (false);

   return (true);
}

static void ClearFpgmPrepCvt(SplineFont *sf) {
   struct ttf_table *tab, *prev=NULL, *next;

   for (tab=sf->ttf_tables; tab != NULL; tab=next) {
      next=tab->next;
      if (tab->tag==CHR('c', 'v', 't', ' ') ||
	  tab->tag==CHR('f', 'p', 'g', 'm') ||
	  tab->tag==CHR('p', 'r', 'e', 'p')) {
	 if (prev==NULL)
	    sf->ttf_tables=next;
	 else
	    prev->next=next;
	 tab->next=NULL;
	 TtfTablesFree(tab);
      } else
	 prev=tab;
   }
}

void FVAutoInstr(FontViewBase * fv) {
   BlueData bd;
   int i, cnt=0, gid;
   GlobalInstrCt gic;

   /* If all glyphs are selected, then no legacy hint will remain after */
   /*  instructing, so we might as well clear all the legacy tables too */
   /* (This way the auto hinter won't complain if they existed) */
   if (fv->sf->ttf_tables != NULL && AllGlyphsSelected(fv))
      ClearFpgmPrepCvt(fv->sf);

   QuickBlues(fv->sf, fv->active_layer, &bd);

   InitGlobalInstrCt(&gic, fv->sf, fv->active_layer, &bd);

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]))
	 ++cnt;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1
	  && SCWorthOutputting(fv->sf->glyphs[gid])) {
	 SplineChar *sc=fv->sf->glyphs[gid];

	 NowakowskiSCAutoInstr(&gic, sc);
      }

   FreeGlobalInstrCt(&gic);

}

void FVClearInstrs(FontViewBase * fv) {
   SplineChar *sc;
   int i, gid;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1
	  && SCWorthOutputting((sc=fv->sf->glyphs[gid]))) {
	 if (sc->ttf_instrs_len != 0) {
	    free(sc->ttf_instrs);
	    sc->ttf_instrs=NULL;
	    sc->ttf_instrs_len=0;
	    sc->instructions_out_of_date=false;
	    SCCharChangedUpdate(sc, ly_none, true);
	    sc->complained_about_ptnums=false;
	 }
      }
}

void FVClearHints(FontViewBase * fv) {
   int i, gid;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] &&
	  (gid=fv->map->map[i]) != -1
	  && SCWorthOutputting(fv->sf->glyphs[gid])) {
	 SplineChar *sc=fv->sf->glyphs[gid];

	 sc->manualhints=true;
	 SCClearHints(sc);
      }
}

static int tester(SplineChar *sc,struct lookup_subtable *sub) {
   PST *pst;
   KernPair *kp;
   int isv;
   AnchorPoint *ap;

   if (sc==NULL)
      return false;

   for (ap=sc->anchor;ap!=NULL;ap=ap->next)
      if (ap->anchor->subtable==sub)
	 return true;
   for (pst=sc->possub;pst!=NULL;pst=pst->next)
      if (pst->subtable==sub)
	 return true;
   for (kp=sc->kerns;kp!=NULL;kp=kp->next)
     if (kp->subtable==sub)
       return true;
   for (kp=sc->vkerns;kp!=NULL;kp=kp->next)
     if (kp->subtable==sub)
       return true;

   return false;
}

int FVBParseSelectByPST(FontViewBase * fv, struct lookup_subtable *sub,
			int search_type) {
   int i;
   SplineFont *sf;
   int first;
   int gid;

   sf=fv->sf;
   first=-1;
   if (search_type==1) {	/* Select results */
      for (i=0; i < fv->map->enccount; ++i) {
	 gid=fv->map->map[i];
	 if ((fv->selected[i] =
	      tester(gid==-1 ? NULL : sf->glyphs[gid], sub)) && first==-1)
	    first=i;
      }
   } else if (search_type==2) {	/* merge results */
      for (i=0; i < fv->map->enccount; ++i)
	 if (!fv->selected[i]) {
	    gid=fv->map->map[i];
	    if ((fv->selected[i] =
		 tester(gid==-1 ? NULL : sf->glyphs[gid], sub))
		&& first==-1)
	       first=i;
	 }
   } else {			/* restrict selection */
      for (i=0; i < fv->map->enccount; ++i)
	 if (fv->selected[i]) {
	    gid=fv->map->map[i];
	    if ((fv->selected[i] =
		 tester(gid==-1 ? NULL : sf->glyphs[gid], sub))
		&& first==-1)
	       first=i;
	 }
   }
   return (first);
}

void FVBuildAccent(FontViewBase * fv, int onlyaccents) {
   int i, cnt=0, gid;
   SplineChar dummy;
   SplineChar *sc;

   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  SCWorthOutputting(fv->sf->glyphs[gid]))
	 ++cnt;

   SFUntickAll(fv->sf);
   for (i=0; i < fv->map->enccount; ++i)
      if (fv->selected[i]) {
	 gid=fv->map->map[i];
	 sc=NULL;
	 if (gid != -1) {
	    sc=fv->sf->glyphs[gid];
	    if (sc != NULL && sc->ticked)
	       continue;
	 }
	 if (sc==NULL)
	   sc=SCBuildDummy(&dummy, fv->sf, fv->map, i);
	 if (SFIsSomethingBuildable
	     (fv->sf, sc, fv->active_layer, onlyaccents)) {
	    sc=SFMakeChar(fv->sf, fv->map, i);
	    sc->ticked=true;
	    SCBuildComposite(fv->sf, sc, fv->active_layer, fv->active_bitmap,
			     onlycopydisplayed);
	 }
      }
}

void FVDetachGlyphs(FontViewBase * fv) {
   int i, j, gid;
   EncMap *map=fv->map;
   int altered=false;
   SplineFont *sf=fv->sf;

   for (i=0; i < map->enccount; ++i)
      if (fv->selected[i] && (gid=map->map[i]) != -1) {
	 altered=true;
	 map->map[i]=-1;
	 if (map->backmap[gid]==i) {
	    for (j=map->enccount - 1; j >= 0 && map->map[j] != gid; --j);
	    map->backmap[gid]=j;
	 }
	 if (sf->glyphs[gid] != NULL && sf->glyphs[gid]->altuni != NULL
	     && map->enc != &custom)
	    AltUniRemove(sf->glyphs[gid], UniFromEnc(i, map->enc));
      }
}

void FVDetachAndRemoveGlyphs(FontViewBase * fv) {
   int i, j, gid;
   EncMap *map=fv->map;
   SplineFont *sf=fv->sf;
   int flags=-1;
   int changed=false, altered=false;
   FontViewBase *fvs;

   for (i=0; i < map->enccount; ++i)
      if (fv->selected[i] && (gid=map->map[i]) != -1) {
	 altered=true;
	 map->map[i]=-1;
	 if (map->backmap[gid]==i) {
	    for (j=map->enccount - 1; j >= 0 && map->map[j] != gid; --j);
	    map->backmap[gid]=j;
	    if (j==-1) {
	       SFRemoveGlyph(sf, sf->glyphs[gid], &flags);
	       changed=true;
	    } else if (sf->glyphs[gid] != NULL
		       && sf->glyphs[gid]->altuni != NULL
		       && map->enc != &custom)
	       AltUniRemove(sf->glyphs[gid], UniFromEnc(i, map->enc));
	 }
      }
   if (changed && !fv->sf->changed) {
      fv->sf->changed=true;
   }
}

void FVMetricsCenter(FontViewBase * fv, int docenter) {
   int i, gid;
   SplineChar *sc;
   DBounds bb;
   IBounds ib;
   double transform[6], itransform[6];
   BVTFunc bvts[2];
   BDFFont *bdf;

   memset(transform, 0, sizeof(transform));
   memset(itransform, 0, sizeof(itransform));
   transform[0]=transform[3]=1.0;
   itransform[0]=itransform[3]=1.0;
   itransform[2]=tan(fv->sf->italicangle * M_PI / 180.0);
   bvts[1].func=bvt_none;
   bvts[0].func=bvt_transmove;
   bvts[0].y=0;
   if (!fv->sf->onlybitmaps) {
      for (i=0; i < fv->map->enccount; ++i) {
	 if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	     (sc=fv->sf->glyphs[gid]) != NULL) {
	    if (itransform[2]==0)
	       SplineCharFindBounds(sc, &bb);
	    else {
	       SplineSet *base, *temp;

	       base=LayerAllSplines(&sc->layers[fv->active_layer]);
	       temp =
		  SplinePointListTransform(SplinePointListCopy(base),
					   itransform, tpt_AllPoints);
	       LayerUnAllSplines(&sc->layers[fv->active_layer]);
	       SplineSetFindBounds(temp, &bb);
	       SplinePointListsFree(temp);
	    }
	    if (docenter)
	       transform[4]=(sc->width - (bb.maxx - bb.minx)) / 2 - bb.minx;
	    else
	       transform[4]=(sc->width - (bb.maxx - bb.minx)) / 3 - bb.minx;
	    if (transform[4] != 0) {
	       FVTrans(fv, sc, transform, NULL,
		       fvt_dontmovewidth | fvt_alllayers);
	       bvts[0].x=transform[4];
	       for (bdf=fv->sf->bitmaps; bdf != NULL; bdf=bdf->next)
		  if (gid < bdf->glyphcnt && bdf->glyphs[gid] != NULL)
		     BCTrans(bdf, bdf->glyphs[gid], bvts, fv);
	    }
	 }
      }
   } else {
      double scale =
	 (fv->sf->ascent +
	  fv->sf->descent) / (double) (fv->active_bitmap->pixelsize);
      for (i=0; i < fv->map->enccount; ++i) {
	 if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	     fv->sf->glyphs[gid] != NULL) {
	    BDFChar *bc=fv->active_bitmap->glyphs[gid];

	    if (bc==NULL)
	       bc=BDFMakeChar(fv->active_bitmap, fv->map, i);
	    BDFCharFindBounds(bc, &ib);
	    if (docenter)
	       transform[4] =
		  scale * ((bc->width - (ib.maxx - ib.minx)) / 2 - ib.minx);
	    else
	       transform[4] =
		  scale * ((bc->width - (ib.maxx - ib.minx)) / 3 - ib.minx);
	    if (transform[4] != 0) {
	       FVTrans(fv, fv->sf->glyphs[gid], transform, NULL,
		       fvt_dontmovewidth);
	       bvts[0].x=transform[4];
	       for (bdf=fv->sf->bitmaps; bdf != NULL; bdf=bdf->next)
		  if (gid < bdf->glyphcnt && bdf->glyphs[gid] != NULL)
		     BCTrans(bdf, bdf->glyphs[gid], bvts, fv);
	    }
	 }
      }
   }
}

static void _FVRevert(FontViewBase *fv,int tobackup) {
   SplineFont *temp,*old=fv->cidmaster?fv->cidmaster:fv->sf;
   BDFFont *bdf;
   int i;
   FontViewBase *fvs;
   EncMap *map;

   if (old->origname==NULL)
      return;

   if (tobackup) {
      /* we can only revert to backup if it's an sfd file. So we use filename */
      /*  here. In the normal case we revert to whatever file we read it from */
      /*  (sfd or not) so we use origname */
      char *buf=malloc(strlen(old->filename) + 20);

      strcpy(buf, old->filename);
      if (old->compression != 0) {
	 char *tmpfile;

	 strcat(buf, compressors[old->compression - 1].ext);
	 strcat(buf, "~");
	 tmpfile=Decompress(buf, old->compression - 1);
	 if (tmpfile==NULL)
	    temp=NULL;
	 else {
	    temp=ReadSplineFont(tmpfile, 0);
	    unlink(tmpfile);
	    free(tmpfile);
	 }
      } else {
	 strcat(buf, "~");
	 temp=ReadSplineFont(buf, 0);
      }
      free(buf);

   } else {
      if (old->compression!=0) {
	 char *tmpfile;
	 char *buf=malloc(strlen(old->filename)+20);

	 strcpy(buf,old->filename);
	 strcat(buf,compressors[old->compression-1].ext);
	 tmpfile=Decompress(buf,old->compression-1);
	 if (tmpfile==NULL)
	   temp=NULL;
	 else {
	    temp=ReadSplineFont(tmpfile,0);
	    unlink(tmpfile);
	    free(tmpfile);
	 }
      } else
	temp=ReadSplineFont(old->origname,0);
   }

   if (temp==NULL)
     return;

   if (temp->filename!=NULL) {
      free(temp->filename);
      temp->filename=fastrdup(old->filename);
   }
   if (temp->origname!=NULL) {
      free(temp->origname);
      temp->origname=fastrdup(old->origname);
   }

   temp->compression=old->compression;
   temp->fv=old->fv;

   for (fvs=fv->sf->fv;fvs!=NULL;fvs=fvs->nextsame) {
      if (fvs==fv)
	 map=temp->map;
      else
	 map=EncMapFromEncoding(fv->sf,fv->map->enc);
      if (map->enccount>fvs->map->enccount) {
	 fvs->selected=realloc(fvs->selected,map->enccount);
	 memset(fvs->selected+fvs->map->enccount,0,
		map->enccount-fvs->map->enccount);
      }
      EncMapFree(fv->map);
      fv->map=map;
      if (fvs->normal!=NULL) {
	 EncMapFree(fvs->normal);
	 fvs->normal=EncMapCopy(fvs->map);
	 CompactEncMap(fvs->map,temp);
      }
   }

   temp->fv=fv->sf->fv;
   for (fvs=fv->sf->fv;fvs!=NULL;fvs=fvs->nextsame)
      fvs->sf=temp;

   SplineFontFree(old);
}

void FVRevert(FontViewBase * fv) {
   _FVRevert(fv, false);
}

void FVRevertBackup(FontViewBase * fv) {
   _FVRevert(fv, true);
}

/*                             FV Interface                                   */

FontViewBase *_FontViewCreate(SplineFont *sf) {
   FontViewBase *fv=calloc(1, sizeof(FontViewBase));
   int i;

   fv->nextsame=sf->fv;
   fv->active_layer=ly_fore;
   sf->fv=fv;
   if (sf->mm != NULL) {
      sf->mm->normal->fv=fv;
      for (i=0; i < sf->mm->instance_count; ++i)
	 sf->mm->instances[i]->fv=fv;
   }
   if (sf->subfontcnt==0) {
      fv->sf=sf;
      if (fv->nextsame != NULL) {
	 fv->map=EncMapCopy(fv->nextsame->map);
	 fv->normal =
	    fv->nextsame->normal ==
	    NULL ? NULL : EncMapCopy(fv->nextsame->normal);
      } else if (sf->compacted) {
	 fv->normal=sf->map;
	 fv->map=CompactEncMap(EncMapCopy(sf->map), sf);
      } else {
	 fv->map=sf->map;
	 fv->normal=NULL;
      }
   } else {
      fv->cidmaster=sf;
      for (i=0; i < sf->subfontcnt; ++i)
	 sf->subfonts[i]->fv=fv;
      for (i=0; i < sf->subfontcnt; ++i)	/* Search for a subfont that contains more than ".notdef" (most significant in .gai fonts) */
	 if (sf->subfonts[i]->glyphcnt > 1) {
	    fv->sf=sf->subfonts[i];
	    break;
	 }
      if (fv->sf==NULL)
	 fv->sf=sf->subfonts[0];
      sf=fv->sf;
      if (fv->nextsame==NULL)
	 EncMapFree(sf->map);
      fv->map=EncMap1to1(sf->glyphcnt);
   }
   fv->selected=calloc(fv->map->enccount, sizeof(char));

   return (fv);
}

FontViewBase *FontViewCreate(SplineFont *sf, int hide) {
   FontViewBase *fv=_FontViewCreate(sf);

   return (fv);
}

FontViewBase *FVAppend(FontViewBase * fv) {
   /* Normally fontviews get added to the fv list when their windows are */
   /*  created. but we don't create any windows here, so... */
   FontViewBase *test;

   if (fv_list==NULL)
      fv_list=fv;
   else {
      for (test=fv_list; test->next != NULL; test=test->next);
      test->next=fv;
   }
   return (fv);
}

void FontViewFree(FontViewBase * fv) {
   int i;
   FontViewBase *prev;

   if (fv->nextsame==NULL && fv->sf->fv==fv) {
      EncMapFree(fv->map);
      SplineFontFree(fv->cidmaster ? fv->cidmaster : fv->sf);
   } else {
      EncMapFree(fv->map);
      if (fv->sf->fv==fv) {
	 if (fv->cidmaster==NULL)
	    fv->sf->fv=fv->nextsame;
	 else {
	    fv->cidmaster->fv=fv->nextsame;
	    for (i=0; i < fv->cidmaster->subfontcnt; ++i)
	       fv->cidmaster->subfonts[i]->fv=fv->nextsame;
	 }
      } else {
	 for (prev=fv->sf->fv; prev->nextsame != fv; prev=prev->nextsame);
	 prev->nextsame=fv->nextsame;
      }
   }
   DictionaryFree(fv->fontvars);
   free(fv->fontvars);
   free(fv->selected);
   free(fv);
}

int FVWinInfo(FontViewBase * fv, int *cc, int *rc) {
   *cc=16;
   *rc=4;
   return (-1);
}

FontViewBase *FontViewFirst(void) {
   return fv_list;
}

int SFIsActive(SplineFont *sf) {
   FontViewBase *fv;

   for (fv=fv_list; fv != NULL; fv=fv->next)
      if (fv->sf==sf)
	 return (true);

   return (false);
}

SplineFont *FontWithThisFilename(const char *filename) {
   char buffer[1025];
   FontViewBase *fv;

   GFileGetAbsoluteName((char *) filename, buffer, sizeof(buffer));
   for (fv=fv_list; fv != NULL; fv=fv->next) {
      if (fv->sf->filename != NULL && strcmp(fv->sf->filename, buffer)==0)
	 return (fv->sf);
      else if (fv->sf->origname != NULL
	       && strcmp(fv->sf->origname, buffer)==0)
	 return (fv->sf);
   }
   return (NULL);
}

void FontViewClose(FontViewBase * fv) {
   if (fv_list==fv)
      fv_list=fv->next;
   else {
      FontViewBase *n;

      for (n=fv_list; n->next != fv; n=n->next);
      n->next=fv->next;
   }
   FontViewFree(fv);
}

void FVDeselectAll(FontViewBase * fv) {
   memset(fv->selected, 0, fv->map->encmax);
}
