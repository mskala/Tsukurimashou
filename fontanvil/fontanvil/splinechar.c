/* $Id: splinechar.c 4484 2015-12-08 09:59:03Z mskala $ */
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

#include "fontanvilvw.h"
#include <math.h>
#include <locale.h>
#include <ustring.h>
#include <utype.h>
#include <gresource.h>
#ifdef HAVE_IEEEFP_H
#   include <ieeefp.h> /* Solaris defines isnan in ieeefp rather than math.h */
#endif
#include "ttf.h"

int adjustwidth=true;
int adjustlbearing=true;
int allow_utf8_glyphnames=false;
int clear_tt_instructions_when_needed=true;

void SCClearRounds(SplineChar * sc, int layer) {
   SplineSet *ss;
   SplinePoint *sp;

   for (ss=sc->layers[layer].splines; ss != NULL; ss=ss->next) {
      for (sp=ss->first;;) {
	 sp->roundx=sp->roundy=false;
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==ss->first)
	    break;
      }
   }
}

RefChar *HasUseMyMetrics(SplineChar * sc, int layer) {
   RefChar *r;

   if (layer==ly_grid)
      layer=ly_fore;

   for (r=sc->layers[layer].refs; r != NULL; r=r->next)
      if (r->use_my_metrics)
	 return (r);

   return (NULL);
}

/* if they changed the width, then change the width on all bitmap chars of */
/*  ours, and if we are a letter, then change the width on all chars linked */
/*  to us which had the same width that we used to have (so if we change the */
/*  width of A, we'll also change that of À and Ä and ... */
void SCSynchronizeWidth(SplineChar * sc, double newwidth, double oldwidth,
			FontViewBase * flagfv) {
   BDFFont *bdf;
   struct splinecharlist *dlist;
   RefChar *r=HasUseMyMetrics(sc, ly_fore);
   int isprobablybase;

   sc->widthset=true;
   if (r != NULL) {
      if (oldwidth==r->sc->width) {
	 sc->width=r->sc->width;
	 return;
      }
      newwidth=r->sc->width;
   }
   if (newwidth==oldwidth)
      return;
   sc->width=newwidth;
   for (bdf=sc->parent->bitmaps; bdf != NULL; bdf=bdf->next) {
      BDFChar *bc=bdf->glyphs[sc->orig_pos];

      if (bc != NULL) {
	 int width =
	    rint(sc->width * bdf->pixelsize /
		 (double) (sc->parent->ascent + sc->parent->descent));
	 if (bc->width != width) {
	    /*BCPreserveWidth(bc); *//* Bitmaps can't set width, so no undo for it */
	    bc->width=width;
	    BCCharChangedUpdate(bc);
	 }
      }
   }

   if (!adjustwidth)
      return;

   isprobablybase=true;
   if (sc->unicodeenc==-1 || sc->unicodeenc >= 0x10000 ||
       !isalpha(sc->unicodeenc) || iscombining(sc->unicodeenc))
      isprobablybase=false;

   for (dlist=sc->dependents; dlist != NULL; dlist=dlist->next) {
      RefChar *metrics=HasUseMyMetrics(dlist->sc, ly_fore);

      if (metrics != NULL && metrics->sc != sc)
	 continue;
      else if (metrics==NULL && !isprobablybase)
	 continue;
      if (dlist->sc->width==oldwidth &&
	  (metrics != NULL || flagfv==NULL ||
	   !flagfv->selected[flagfv->map->backmap[dlist->sc->orig_pos]])) {
	 SCSynchronizeWidth(dlist->sc, newwidth, oldwidth, flagfv);
	 if (!dlist->sc->changed) {
	    dlist->sc->changed=true;
	 }
      }
   }
}

/* If they change the left bearing of a character, then in all chars */
/*  that depend on it should be adjusted too. */
/* Also all vstem hints */
/* I deliberately don't set undoes in the dependants. The change is not */
/*  in them, after all */
void SCSynchronizeLBearing(SplineChar * sc, double off, int layer) {
   struct splinecharlist *dlist;
   RefChar *ref;
   DStemInfo *d;
   StemInfo *h;
   HintInstance *hi;
   int isprobablybase;

   for (h=sc->vstem; h != NULL; h=h->next)
      h->start += off;
   for (h=sc->hstem; h != NULL; h=h->next)
      for (hi=h->where; hi != NULL; hi=hi->next) {
	 hi->begin += off;
	 hi->end += off;
      }
   for (d=sc->dstem; d != NULL; d=d->next) {
      d->left.x += off;
      d->right.x += off;
   }

   if (!adjustlbearing)
      return;

   isprobablybase=true;
   if (sc->unicodeenc==-1 || sc->unicodeenc >= 0x10000 ||
       !isalpha(sc->unicodeenc) || iscombining(sc->unicodeenc))
      isprobablybase=false;

   for (dlist=sc->dependents; dlist != NULL; dlist=dlist->next) {
      RefChar *metrics=HasUseMyMetrics(dlist->sc, layer);

      if (metrics != NULL && metrics->sc != sc)
	 continue;
      else if (metrics==NULL && !isprobablybase)
	 continue;
      else if (metrics==NULL && sc->width != dlist->sc->width)
	 continue;
      SCPreserveLayer(dlist->sc, layer, false);
      SplinePointListShift(dlist->sc->layers[layer].splines, off,
			   tpt_AllPoints);
      for (ref=dlist->sc->layers[layer].refs; ref != NULL; ref=ref->next)
	 if (ref->sc != sc) {
	    SplinePointListShift(ref->layers[0].splines, off, tpt_AllPoints);
	    ref->transform[4] += off;
	    ref->bb.minx += off;
	    ref->bb.maxx += off;
	 }
      SCSynchronizeLBearing(dlist->sc, off, layer);
   }
}

static int _SCRefNumberPoints2(SplineSet ** _rss,SplineChar *sc,int pnum,
			       int layer) {
   SplineSet *ss, *rss=*_rss;
   SplinePoint *sp, *rsp;
   RefChar *r;
   int starts_with_cp, startcnt;

   for (ss=sc->layers[layer].splines; ss != NULL;
	ss=ss->next, rss=rss->next) {
      if (rss==NULL)		/* Can't happen */
	 break;
      starts_with_cp=!ss->first->noprevcp &&
	 ((ss->first->ttfindex==pnum + 1 && ss->first->prev != NULL &&
	   ss->first->prev->from->nextcpindex==pnum) ||
	  ((ss->first->ttfindex==0xffff || SPInterpolate(ss->first))));
      startcnt=pnum;
      if (starts_with_cp)
	 ++pnum;
      for (sp=ss->first, rsp=rss->first;;) {
	 if (sp->ttfindex==0xffff || SPInterpolate(sp))
	    rsp->ttfindex=0xffff;
	 else
	    rsp->ttfindex=pnum++;
	 if (sp->next==NULL)
	    break;
	 if (sp->next != NULL && sp->next->to==ss->first) {
	    if (sp->nonextcp)
	       rsp->nextcpindex=0xffff;
	    else if (starts_with_cp)
	       rsp->nextcpindex=startcnt;
	    else
	       rsp->nextcpindex=pnum++;
	    break;
	 }
	 if (sp->nonextcp)
	    rsp->nextcpindex=0xffff;
	 else
	    rsp->nextcpindex=pnum++;
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 rsp=rsp->next->to;
      }
   }

   *_rss=rss;
   for (r=sc->layers[layer].refs; r != NULL; r=r->next)
      pnum=_SCRefNumberPoints2(_rss, r->sc, pnum, layer);
   return (pnum);
}

static int SCRefNumberPoints2(RefChar *ref,int pnum,int layer) {
   SplineSet *rss;

   rss=ref->layers[0].splines;
   return (_SCRefNumberPoints2(&rss, ref->sc, pnum, layer));
}

int SSTtfNumberPoints(SplineSet * ss) {
   int pnum=0;
   SplinePoint *sp;
   int starts_with_cp;

   for (; ss != NULL; ss=ss->next) {
      starts_with_cp=!ss->first->noprevcp &&
	 ((ss->first->ttfindex==pnum + 1 && ss->first->prev != NULL &&
	   ss->first->prev->from->nextcpindex==pnum) ||
	  SPInterpolate(ss->first));
      if (starts_with_cp && ss->first->prev != NULL)
	 ss->first->prev->from->nextcpindex=pnum++;
      for (sp=ss->first;;) {
	 if (SPInterpolate(sp))
	    sp->ttfindex=0xffff;
	 else
	    sp->ttfindex=pnum++;
	 if (sp->nonextcp && sp->nextcpindex != pnum)
	    sp->nextcpindex=0xffff;
	 else if (!starts_with_cp
		  || (sp->next != NULL && sp->next->to != ss->first))
	    sp->nextcpindex=pnum++;
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==ss->first)
	    break;
      }
   }
   return (pnum);
}

static int SSPsNumberPoints(SplineChar *sc,SplineSet *splines,int pnum) {
   SplineSet *ss;
   SplinePoint *sp;

   for (ss=splines; ss != NULL; ss=ss->next) {
      for (sp=ss->first;;) {
	 sp->ttfindex=pnum++;
	 sp->nextcpindex=0xffff;
	 if (sc->numberpointsbackards) {
	    if (sp->prev==NULL)
	       break;
	    if (!sp->noprevcp || !sp->prev->from->nonextcp)
	       pnum += 2;
	    sp=sp->prev->from;
	 } else {
	    if (sp->next==NULL)
	       break;
	    if (!sp->nonextcp || !sp->next->to->noprevcp)
	       pnum += 2;
	    sp=sp->next->to;
	 }
	 if (sp==ss->first)
	    break;
      }
   }
   return (pnum);
}

int SCNumberPoints(SplineChar * sc, int layer) {
   int pnum=0;
   SplineSet *ss;
   SplinePoint *sp;
   RefChar *ref;

   if (sc->layers[layer].order2) {	/* TrueType and its complexities. I ignore svg here */
      if (sc->layers[layer].refs != NULL) {
	 /* if there are references there can't be splines. So if we've got */
	 /*  splines mark all point numbers on them as meaningless */
	 for (ss=sc->layers[layer].splines; ss != NULL; ss=ss->next) {
	    for (sp=ss->first;;) {
	       sp->ttfindex=0xfffe;
	       if (!sp->nonextcp)
		  sp->nextcpindex=0xfffe;
	       if (sp->next==NULL)
		  break;
	       sp=sp->next->to;
	       if (sp==ss->first)
		  break;
	    }
	 }
	 for (ref=sc->layers[layer].refs; ref != NULL; ref=ref->next)
	    pnum=SCRefNumberPoints2(ref, pnum, layer);
      } else {
	 pnum=SSTtfNumberPoints(sc->layers[layer].splines);
      }
   } else {			/* cubic (PostScript/SVG) splines */
      int first, last;

      if (sc->parent->multilayer) {
	 first=ly_fore;
	 last=sc->layer_cnt - 1;
      } else
	 first=last=layer;
      for (layer=first; layer <= last; ++layer) {
	 for (ref=sc->layers[layer].refs; ref != NULL; ref=ref->next)
	    pnum=SSPsNumberPoints(sc, ref->layers[0].splines, pnum);
	 pnum=SSPsNumberPoints(sc, sc->layers[layer].splines, pnum);
      }
   }
   return (pnum);
}

int SCPointsNumberedProperly(SplineChar * sc, int layer) {
   int pnum=0, skipit;
   SplineSet *ss;
   SplinePoint *sp;
   int starts_with_cp;
   int start_pnum;

   if (sc->layers[layer].splines != NULL && sc->layers[layer].refs != NULL)
      return (false);		/* TrueType can't represent this, so always remove instructions. They can't be meaningful */

   for (ss=sc->layers[layer].splines; ss != NULL; ss=ss->next) {
      starts_with_cp=(ss->first->ttfindex==pnum + 1
			|| ss->first->ttfindex==0xffff)
	 && !ss->first->noprevcp;
      start_pnum=pnum;
      if (starts_with_cp)
	 ++pnum;
      for (sp=ss->first;;) {
	 skipit=SPInterpolate(sp);
	 if (sp->nonextcp || sp->noprevcp)
	    skipit=false;
	 if (sp->ttfindex==0xffff && skipit)
	    /* Doesn't count */ ;
	 else if (sp->ttfindex != pnum)
	    return (false);
	 else
	    ++pnum;
	 if (sp->nonextcp && sp->nextcpindex==0xffff)
	    /* Doesn't count */ ;
	 else if (sp->nextcpindex==pnum)
	    ++pnum;
	 else if (sp->nextcpindex==start_pnum && starts_with_cp &&
		  (sp->next != NULL && sp->next->to==ss->first))
	    /* Ok */ ;
	 else
	    return (false);
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==ss->first)
	    break;
      }
      /* if ( starts_with_cp ) --pnum; */
   }
   return (true);
}

void SCClearLayer(SplineChar * sc, int layer) {
   RefChar *refs, *next;

   SplinePointListsFree(sc->layers[layer].splines);
   sc->layers[layer].splines=NULL;
   for (refs=sc->layers[layer].refs; refs != NULL; refs=next) {
      next=refs->next;
      SCRemoveDependent(sc, refs, layer);
   }
   sc->layers[layer].refs=NULL;
   ImageListsFree(sc->layers[layer].images);
   sc->layers[layer].images=NULL;
}

void SCClearContents(SplineChar * sc, int layer) {
   int ly_first, ly_last;

   if (sc==NULL)
     return;

   if (sc->parent != NULL && sc->parent->multilayer) {
      ly_first=ly_fore;
      ly_last=sc->layer_cnt - 1;
   } else
     ly_first=ly_last=layer;

   for (layer=ly_first; layer <= ly_last; ++layer)
     SCClearLayer(sc, layer);

   --layer;

   if (sc->parent!=NULL &&
       (sc->parent->multilayer ||
	   (!sc->parent->layers[layer].background && SCWasEmpty(sc,layer)))) {

      sc->widthset=false;

      if (sc->parent!=NULL && sc->width!=0) {
	 sc->width=sc->parent->ascent+sc->parent->descent;
	 sc->vwidth=sc->width;
      }

      AnchorPointsFree(sc->anchor);
      sc->anchor=NULL;
      StemInfosFree(sc->hstem);
      sc->hstem=NULL;
      StemInfosFree(sc->vstem);
      sc->vstem=NULL;
      DStemInfosFree(sc->dstem);
      sc->dstem=NULL;
      MinimumDistancesFree(sc->md);
      sc->md=NULL;

      free(sc->ttf_instrs);
      sc->ttf_instrs=NULL;
      sc->ttf_instrs_len=0;
   }
}

void SCClearAll(SplineChar * sc, int layer) {
   extern int copymetadata;

   if (sc==NULL)
      return;
   if (sc->layers[layer].splines==NULL && sc->layers[layer].refs==NULL
       && !sc->widthset && sc->hstem==NULL && sc->vstem==NULL
       && sc->anchor==NULL && !sc->parent->multilayer && (!copymetadata
							    || (sc->
								unicodeenc ==
								-1
								&& strcmp(sc->
									  name,
									  ".notdef")
								== 0)))
      return;
   SCPreserveLayer(sc, layer, 2);
   if (copymetadata) {
      sc->unicodeenc=-1;
      free(sc->name);
      sc->name=fastrdup(".notdef");
      PSTFree(sc->possub);
      sc->possub=NULL;
   }
   SCClearContents(sc, layer);
   SCCharChangedUpdate(sc, layer, true);
}

void SCClearBackground(SplineChar * sc) {

   if (sc==NULL)
      return;
   if (sc->layers[0].splines==NULL && sc->layers[ly_back].images==NULL &&
       sc->layers[0].refs==NULL)
      return;
   SCPreserveBackground(sc);
   SCClearLayer(sc, ly_back);
   SCCharChangedUpdate(sc, ly_back, true);
}

void SCCopyLayerToLayer(SplineChar * sc, int from, int to, int doclear) {
   SplinePointList *fore, *temp;
   RefChar *ref, *oldref;

   SCPreserveLayer(sc, to, false);
   if (doclear)
      SCClearLayer(sc, to);

   fore=SplinePointListCopy(sc->layers[from].splines);
   if (!sc->layers[from].order2 && sc->layers[to].order2) {
      temp=SplineSetsTTFApprox(fore);
      SplinePointListsFree(fore);
      fore=temp;
   } else if (sc->layers[from].order2 && !sc->layers[to].order2) {
      temp=SplineSetsPSApprox(fore);
      SplinePointListsFree(fore);
      fore=temp;
   }
   if (fore != NULL) {
      for (temp=fore; temp->next != NULL; temp=temp->next);
      temp->next=sc->layers[to].splines;
      sc->layers[to].splines=fore;
   }

   if (sc->layers[to].refs==NULL)
      sc->layers[to].refs=ref=RefCharsCopyState(sc, from);
   else {
      for (oldref=sc->layers[to].refs; oldref->next != NULL;
	   oldref=oldref->next);
      oldref->next=ref=RefCharsCopyState(sc, from);
   }
   for (; ref != NULL; ref=ref->next) {
      SCReinstantiateRefChar(sc, ref, to);
      SCMakeDependent(sc, ref->sc);
   }
   SCCharChangedUpdate(sc, to, true);
}

int BpColinear(BasePoint * first, BasePoint * mid, BasePoint * last) {
   BasePoint dist_f, unit_f, dist_l, unit_l;
   double len, off_l, off_f;

   dist_f.x=first->x - mid->x;
   dist_f.y=first->y - mid->y;
   len=sqrt(dist_f.x * dist_f.x + dist_f.y * dist_f.y);
   if (len==0)
      return (false);
   unit_f.x=dist_f.x / len;
   unit_f.y=dist_f.y / len;

   dist_l.x=last->x - mid->x;
   dist_l.y=last->y - mid->y;
   len=sqrt(dist_l.x * dist_l.x + dist_l.y * dist_l.y);
   if (len==0)
      return (false);
   unit_l.x=dist_l.x / len;
   unit_l.y=dist_l.y / len;

   off_f=dist_l.x * unit_f.y - dist_l.y * unit_f.x;
   off_l=dist_f.x * unit_l.y - dist_f.y * unit_l.x;
   if ((off_f < -1.5 || off_f > 1.5) && (off_l < -1.5 || off_l > 1.5))
      return (false);

   return (true);
}

int BpWithin(BasePoint * first, BasePoint * mid, BasePoint * last) {
   BasePoint dist_mf, unit_mf, dist_lf, unit_lf;
   double len, off_lf, off_mf, len2;

   dist_mf.x=mid->x - first->x;
   dist_mf.y=mid->y - first->y;
   len=sqrt(dist_mf.x * dist_mf.x + dist_mf.y * dist_mf.y);
   if (len==0)
      return (true);
   unit_mf.x=dist_mf.x / len;
   unit_mf.y=dist_mf.y / len;

   dist_lf.x=last->x - first->x;
   dist_lf.y=last->y - first->y;
   len=sqrt(dist_lf.x * dist_lf.x + dist_lf.y * dist_lf.y);
   if (len==0)
      return (false);
   unit_lf.x=dist_lf.x / len;
   unit_lf.y=dist_lf.y / len;

   off_mf=dist_lf.x * unit_mf.y - dist_lf.y * unit_mf.x;
   off_lf=dist_mf.x * unit_lf.y - dist_mf.y * unit_lf.x;
   if ((off_mf < -.1 || off_mf > .1) && (off_lf < -.1 || off_lf > .1))
      return (false);

   len2=dist_mf.x * unit_lf.x + dist_mf.y * unit_lf.y;
   return (len2 >= 0 && len2 <= len);
}

void SplinePointRound(SplinePoint * sp, double factor) {
   BasePoint noff, poff;

   if (sp->prev != NULL && sp->next != NULL && sp->next->order2 &&
       sp->ttfindex==0xffff) {
      /* For interpolated points we want to round the controls */
      /* and then interpolated based on that */
      sp->nextcp.x=rint(sp->nextcp.x * factor) / factor;
      sp->nextcp.y=rint(sp->nextcp.y * factor) / factor;
      sp->prevcp.x=rint(sp->prevcp.x * factor) / factor;
      sp->prevcp.y=rint(sp->prevcp.y * factor) / factor;
      sp->me.x=(sp->nextcp.x + sp->prevcp.x) / 2;
      sp->me.y=(sp->nextcp.y + sp->prevcp.y) / 2;
   } else {
      /* For normal points we want to round the distance of the controls */
      /*  from the base */
      noff.x=rint((sp->nextcp.x - sp->me.x) * factor) / factor;
      noff.y=rint((sp->nextcp.y - sp->me.y) * factor) / factor;
      poff.x=rint((sp->prevcp.x - sp->me.x) * factor) / factor;
      poff.y=rint((sp->prevcp.y - sp->me.y) * factor) / factor;

      sp->me.x=rint(sp->me.x * factor) / factor;
      sp->me.y=rint(sp->me.y * factor) / factor;

      sp->nextcp.x=sp->me.x + noff.x;
      sp->nextcp.y=sp->me.y + noff.y;
      sp->prevcp.x=sp->me.x + poff.x;
      sp->prevcp.y=sp->me.y + poff.y;
   }
   if (sp->next != NULL && sp->next->order2)
      sp->next->to->prevcp=sp->nextcp;
   if (sp->prev != NULL && sp->prev->order2)
      sp->prev->from->nextcp=sp->prevcp;
   if (sp->nextcp.x==sp->me.x && sp->nextcp.y==sp->me.y)
      sp->nonextcp=true;
   if (sp->prevcp.x==sp->me.x && sp->prevcp.y==sp->me.y)
      sp->noprevcp=true;
}

static void SpiroRound2Int(spiro_cp *cp,double factor) {
   cp->x=rint(cp->x * factor) / factor;
   cp->y=rint(cp->y * factor) / factor;
}

void SplineSetsRound2Int(SplineSet * spl, double factor, int inspiro,
			 int onlysel) {
   SplinePoint *sp;
   int i;

   for (; spl != NULL; spl=spl->next) {
      if (inspiro && spl->spiro_cnt != 0) {
	 for (i=0; i < spl->spiro_cnt - 1; ++i)
	    if (!onlysel || SPIRO_SELECTED(&spl->spiros[i]))
	       SpiroRound2Int(&spl->spiros[i], factor);
	 SSRegenerateFromSpiros(spl);
      } else {
	 SplineSetSpirosClear(spl);
	 for (sp=spl->first;;) {
	    if (sp->selected || !onlysel)
	       SplinePointRound(sp, factor);
	    if (sp->prev != NULL)
	       SplineRefigure(sp->prev);
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (sp==spl->first)
	       break;
	 }
	 if (spl->first->prev != NULL)
	    SplineRefigure(spl->first->prev);
      }
   }
}

static void SplineSetsChangeCoord(SplineSet *spl,double old,double new,
				  int isy, int inspiro) {
   SplinePoint *sp;
   int changed;
   int i;

   for (; spl != NULL; spl=spl->next) {
      changed=false;
      if (inspiro) {
	 for (i=0; i < spl->spiro_cnt - 1; ++i) {
	    if (isy && RealNear(spl->spiros[i].y, old)) {
	       spl->spiros[i].y=new;
	       changed=true;
	    } else if (!isy && RealNear(spl->spiros[i].x, old)) {
	       spl->spiros[i].x=new;
	       changed=true;
	    }
	 }
	 /* SSRegenerateFromSpiros will be done in Round2Int */
      } else {
	 for (sp=spl->first;;) {
	    if (isy) {
	       if (RealNear(sp->me.y, old)) {
		  if (RealNear(sp->nextcp.y, old))
		     sp->nextcp.y=new;
		  else
		     sp->nextcp.y += new - sp->me.y;
		  if (RealNear(sp->prevcp.y, old))
		     sp->prevcp.y=new;
		  else
		     sp->prevcp.y += new - sp->me.y;
		  sp->me.y=new;
		  changed=true;
		  /* we expect to be called before SplineSetRound2Int and will */
		  /*  allow it to do any SplineRefigures */
	       }
	    } else {
	       if (RealNear(sp->me.x, old)) {
		  if (RealNear(sp->nextcp.x, old))
		     sp->nextcp.x=new;
		  else
		     sp->nextcp.x += new - sp->me.x;
		  if (RealNear(sp->prevcp.x, old))
		     sp->prevcp.x=new;
		  else
		     sp->prevcp.x += new - sp->me.x;
		  sp->me.x=new;
		  changed=true;
	       }
	    }
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (sp==spl->first)
	       break;
	 }
	 if (changed)
	    SplineSetSpirosClear(spl);
      }
   }
}

void SCRound2Int(SplineChar * sc, int layer, double factor) {
   RefChar *r;
   AnchorPoint *ap;
   StemInfo *stems;
   double old, new;
   int first, last;

   for (stems=sc->hstem; stems != NULL; stems=stems->next) {
      old=stems->start + stems->width;
      stems->start=rint(stems->start * factor) / factor;
      stems->width=rint(stems->width * factor) / factor;
      new=stems->start + stems->width;
      if (old != new)
	 SplineSetsChangeCoord(sc->layers[ly_fore].splines, old, new, true,
			       sc->inspiro && hasspiro());
   }
   for (stems=sc->vstem; stems != NULL; stems=stems->next) {
      old=stems->start + stems->width;
      stems->start=rint(stems->start * factor) / factor;
      stems->width=rint(stems->width * factor) / factor;
      new=stems->start + stems->width;
      if (old != new)
	 SplineSetsChangeCoord(sc->layers[ly_fore].splines, old, new, false,
			       sc->inspiro && hasspiro());
   }

   if (sc->parent->multilayer) {
      first=ly_fore;
      last=sc->layer_cnt - 1;
   } else
      first=last=layer;
   for (layer=first; layer <= last; ++layer) {
      SplineSetsRound2Int(sc->layers[layer].splines, factor, sc->inspiro
			  && hasspiro(), false);
      for (r=sc->layers[layer].refs; r != NULL; r=r->next) {
	 r->transform[4]=rint(r->transform[4] * factor) / factor;
	 r->transform[5]=rint(r->transform[5] * factor) / factor;
	 RefCharFindBounds(r);
      }
   }
   if (sc->parent->multilayer)
      layer=ly_fore;
   else
      --layer;

   for (ap=sc->anchor; ap != NULL; ap=ap->next) {
      ap->me.x=rint(ap->me.x * factor) / factor;
      ap->me.y=rint(ap->me.y * factor) / factor;
   }
   SCCharChangedUpdate(sc, layer, true);
}

void AltUniRemove(SplineChar * sc, int uni) {
   struct altuni *altuni, *prev;

   if (sc==NULL || uni==-1)
      return;

   if (sc->unicodeenc==uni) {
      for (altuni=sc->altuni; altuni != NULL; altuni=altuni->next)
	 if (altuni->fid==0 && altuni->vs==-1)
	    break;
      if (altuni != NULL) {
	 sc->unicodeenc=altuni->unienc;
	 altuni->unienc=uni;
      }
   }

   if (sc->unicodeenc==uni)
      return;
   for (prev=NULL, altuni=sc->altuni;
	altuni != NULL && (altuni->unienc != uni || altuni->vs==-1
			   || altuni->fid != 0);
	prev=altuni, altuni=altuni->next);
   if (altuni) {
      if (prev==NULL)
	 sc->altuni=altuni->next;
      else
	 prev->next=altuni->next;
      altuni->next=NULL;
      AltUniFree(altuni);
   }
}

void AltUniAdd(SplineChar * sc, int uni) {
   struct altuni *altuni;

   if (sc != NULL && uni != -1 && uni != sc->unicodeenc) {
      for (altuni=sc->altuni; altuni != NULL && (altuni->unienc != uni ||
						   altuni->vs != -1 ||
						   altuni->fid);
	   altuni=altuni->next);
      if (altuni==NULL) {
	 altuni=chunkalloc(sizeof(struct altuni));
	 altuni->next=sc->altuni;
	 sc->altuni=altuni;
	 altuni->unienc=uni;
	 altuni->vs=-1;
	 altuni->fid=0;
      }
   }
}

void AltUniAdd_DontCheckDups(SplineChar * sc, int uni) {
   struct altuni *altuni;

   if (sc != NULL && uni != -1 && uni != sc->unicodeenc) {
      altuni=chunkalloc(sizeof(struct altuni));
      altuni->next=sc->altuni;
      sc->altuni=altuni;
      altuni->unienc=uni;
      altuni->vs=-1;
      altuni->fid=0;
   }
}

void SCOrderAP(SplineChar * sc) {
   int lc=0, cnt=0, out=false, i, j;
   AnchorPoint *ap, **array;

   /* Order so that first ligature index comes first */

   for (ap=sc->anchor; ap != NULL; ap=ap->next) {
      if (ap->lig_index < lc)
	 out=true;
      if (ap->lig_index > lc)
	 lc=ap->lig_index;
      ++cnt;
   }
   if (!out)
      return;

   array=malloc(cnt * sizeof(AnchorPoint *));
   for (i=0, ap=sc->anchor; ap != NULL; ++i, ap=ap->next)
      array[i]=ap;
   for (i=0; i < cnt - 1; ++i) {
      for (j=i + 1; j < cnt; ++j) {
	 if (array[i]->lig_index > array[j]->lig_index) {
	    ap=array[i];
	    array[i]=array[j];
	    array[j]=ap;
	 }
      }
   }
   sc->anchor=array[0];
   for (i=0; i < cnt - 1; ++i)
      array[i]->next=array[i + 1];
   array[cnt - 1]->next=NULL;
   free(array);
}

void UnlinkThisReference(FontViewBase * fv, SplineChar * sc, int layer) {
   /* We are about to clear out sc. But somebody refers to it and that we */
   /*  aren't going to delete. So (if the user asked us to) instantiate sc */
   /*  into all characters which refer to it and which aren't about to be */
   /*  cleared out */
   struct splinecharlist *dep, *dnext;

   for (dep=sc->dependents; dep != NULL; dep=dnext) {
      dnext=dep->next;
      if (fv==NULL || !fv->selected[fv->map->backmap[dep->sc->orig_pos]]) {
	 SplineChar *dsc=dep->sc;
	 RefChar *rf, *rnext;

	 /* May be more than one reference to us, colon has two refs to period */
	 /*  but only one dlist entry */
	 for (rf=dsc->layers[layer].refs; rf != NULL; rf=rnext) {
	    rnext=rf->next;
	    if (rf->sc==sc) {
	       /* Even if we were to preserve the state there would be no */
	       /*  way to undo the operation until we undid the delete... */
	       SCRefToSplines(dsc, rf, layer);
	    }
	 }
      }
   }
}

int SCSetMetaData(SplineChar * sc, char *name, int unienc,
		  const char *comment) {
   SplineFont *sf=sc->parent;
   int i, mv=0;
   int isnotdef, samename=false, sameuni=false;
   struct altuni *alt;

   if (sf->glyphs[sc->orig_pos] != sc)
      ErrorMsg(2,"Bad call to SCSetMetaData\n");

   for (alt=sc->altuni;
	alt != NULL && (alt->unienc != unienc || alt->vs != -1
			|| alt->fid != 0); alt=alt->next);
   if (unienc==sc->unicodeenc || alt != NULL)
      sameuni=true;
   if (sameuni && strcmp(name, sc->name)==0) {
      samename=true;		/* No change, it must be good */
   }
   if (alt != NULL || !samename) {
      isnotdef=strcmp(name, ".notdef")==0;
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL && sf->glyphs[i]->orig_pos != sc->orig_pos) {
	    if (unienc != -1 && sf->glyphs[i]->unicodeenc==unienc) {
	       mv=1;
	    } else if (!isnotdef && strcmp(name, sf->glyphs[i]->name)==0) {
	       free(sf->glyphs[i]->name);
	       sf->glyphs[i]->namechanged=true;
	       if (strncmp(sc->name, "uni", 3)==0
		   && sf->glyphs[i]->unicodeenc != -1) {
		  char buffer[12];

		  if (sf->glyphs[i]->unicodeenc < 0x10000)
		     sprintf(buffer, "uni%04X", sf->glyphs[i]->unicodeenc);
		  else
		     sprintf(buffer, "u%04X", sf->glyphs[i]->unicodeenc);
		  sf->glyphs[i]->name=fastrdup(buffer);
	       } else {
		  sf->glyphs[i]->name=sc->name;
		  sc->name=NULL;
	       }
	       break;
	    }
	 }
      if (sc->unicodeenc != unienc) {
	 struct splinecharlist *scl;
	 int layer;
	 RefChar *ref;

	 for (scl=sc->dependents; scl != NULL; scl=scl->next) {
	    for (layer=ly_back; layer < scl->sc->layer_cnt; ++layer)
	       for (ref=scl->sc->layers[layer].refs; ref != NULL;
		    ref=ref->next)
		  if (ref->sc==sc)
		     ref->unicode_enc=unienc;
	 }
      }
   }
   if (alt != NULL)
      alt->unienc=sc->unicodeenc;
   sc->unicodeenc=unienc;
   if (sc->name==NULL || strcmp(name, sc->name) != 0) {
      if (sc->name != NULL)
	 SFGlyphRenameFixup(sf, sc->name, name, false);
      free(sc->name);
      sc->name=fastrdup(name);
      sc->namechanged=true;
      GlyphHashFree(sf);
   }
   sf->changed=true;
   if (samename)
      /* Ok to name it itself */ ;
   else if (sameuni && (unienc >= 0xe000 && unienc <= 0xf8ff))
      /* Ok to name things in the private use area */ ;
   else {
      FontViewBase *fvs;

      for (fvs=sf->fv; fvs != NULL; fvs=fvs->nextsame) {
	 int enc=fvs->map->backmap[sc->orig_pos];

	 if (enc != -1 && ((fvs->map->enc->only_1byte && enc < 256) ||
			   (fvs->map->enc->has_2byte && enc < 65535))) {
	    fvs->map->enc=&custom;
	 }
      }
   }
   free(sc->comment);
   sc->comment=NULL;
   if (comment != NULL && *comment != '\0')
      sc->comment=fastrdup(comment);

   return (true);
}

int BPTooFar(BasePoint * bp1, BasePoint * bp2) {
   return (bp1->x - bp2->x > 32767 || bp2->x - bp1->x > 32767 ||
	   bp1->y - bp2->y > 32767 || bp2->y - bp1->y > 32767);
}

AnchorClass *SCValidateAnchors(SplineChar * sc) {
   SplineFont *sf=sc->parent;
   AnchorClass *ac;
   AnchorPoint *ap;

   if (sf==NULL)
      return (NULL);
   if (sf->cidmaster != NULL)
      sf=sf->cidmaster;

   for (ac=sf->anchor; ac != NULL; ac=ac->next) {
      ac->ticked=0;
      if (ac->subtable)
	 ac->subtable->ticked=0;
   }

   for (ap=sc->anchor; ap != NULL; ap=ap->next) {
      if (ap->type==at_basechar || ap->type==at_basemark) {
	 ac=ap->anchor;
	 ac->ticked=true;
	 if (ac->subtable)
	    ac->subtable->ticked=true;
      }
   }

   for (ac=sf->anchor; ac != NULL; ac=ac->next) {
      if (!ac->ticked && ac->subtable && ac->subtable->ticked)
	 return (ac);
   }
   return (NULL);
}

void SCClearInstrsOrMark(SplineChar * sc, int layer, int complain) {
   uint8_t *instrs=sc->ttf_instrs==NULL && sc->parent->mm != NULL
      && sc->parent->mm->apple ? sc->parent->mm->normal->glyphs[sc->
								orig_pos]->
      ttf_instrs : sc->ttf_instrs;
   struct splinecharlist *dep;
   SplineSet *ss;
   SplinePoint *sp;
   AnchorPoint *ap;
   int had_ap, had_dep, had_instrs;

   had_ap=had_dep=had_instrs=0;
   if (instrs != NULL) {
      if (clear_tt_instructions_when_needed) {
	 free(sc->ttf_instrs);
	 sc->ttf_instrs=NULL;
	 sc->ttf_instrs_len=0;
	 had_instrs=1;
      } else {
	 sc->instructions_out_of_date=true;
	 had_instrs=2;
      }
   }
   for (dep=sc->dependents; dep != NULL; dep=dep->next) {
      RefChar *ref;

      if (dep->sc->ttf_instrs_len != 0) {
	 if (clear_tt_instructions_when_needed) {
	    free(dep->sc->ttf_instrs);
	    dep->sc->ttf_instrs=NULL;
	    dep->sc->ttf_instrs_len=0;
	    had_instrs=1;
	 } else {
	    dep->sc->instructions_out_of_date=true;
	    had_instrs=2;
	 }
      }
      for (ref=dep->sc->layers[layer].refs; ref != NULL && ref->sc != sc;
	   ref=ref->next);
      for (; ref != NULL; ref=ref->next) {
	 if (ref->point_match) {
	    ref->point_match_out_of_date=true;
	    had_dep=true;
	 }
      }
   }
   SCNumberPoints(sc, layer);
   for (ap=sc->anchor; ap != NULL; ap=ap->next) {
      if (ap->has_ttf_pt) {
	 had_ap=true;
	 ap->has_ttf_pt=false;
	 for (ss=sc->layers[layer].splines; ss != NULL; ss=ss->next) {
	    for (sp=ss->first;;) {
	       if (sp->me.x==ap->me.x && sp->me.y==ap->me.y
		   && sp->ttfindex != 0xffff) {
		  ap->has_ttf_pt=true;
		  ap->ttf_pt_index=sp->ttfindex;
		  goto found;
	       } else if (sp->nextcp.x==ap->me.x && sp->nextcp.y==ap->me.y
			  && sp->nextcpindex != 0xffff) {
		  ap->has_ttf_pt=true;
		  ap->ttf_pt_index=sp->nextcpindex;
		  goto found;
	       }
	       if (sp->next==NULL)
		  break;
	       sp=sp->next->to;
	       if (sp==ss->first)
		  break;
	    }
	 }
       found:;
      }
   }
}

void PatternSCBounds(SplineChar * sc, DBounds * b) {
   if (sc==NULL)
      memset(b, 0, sizeof(DBounds));
   else if (sc->tile_margin != 0
	    || (sc->tile_bounds.minx==0 && sc->tile_bounds.maxx==0)) {
      SplineCharFindBounds(sc, b);
      b->minx -= sc->tile_margin;
      b->miny -= sc->tile_margin;
      b->maxx += sc->tile_margin;
      b->maxy += sc->tile_margin;
   } else
      *b=sc->tile_bounds;
   if (b->minx >= b->maxx)
      b->maxx=b->minx + 1;
   if (b->miny >= b->maxy)
      b->maxy=b->miny + 1;
}

void SCHintsChanged(SplineChar * sc) {
   sc->changedsincelasthinted=false;
   if (!sc->changed) {
      sc->changed=true;
      sc->parent->changed=true;
   }
}

static void instrcheck(SplineChar * sc, int layer) {
   uint8_t *instrs=sc->ttf_instrs==NULL && sc->parent->mm != NULL
      && sc->parent->mm->apple ? sc->parent->mm->normal->glyphs[sc->
								orig_pos]->
      ttf_instrs : sc->ttf_instrs;

   if (!sc->layers[layer].order2 || sc->layers[layer].background)
      return;

   if (sc->instructions_out_of_date && sc->anchor==NULL)
      return;
   if (instrs==NULL && sc->dependents==NULL && sc->anchor==NULL)
      return;
   /* If the points are no longer in order then the instructions are not valid */
   /*  (because they'll refer to the wrong points) and should be removed */
   /* Except that annoys users who don't expect it */
   if (!SCPointsNumberedProperly(sc, layer)) {
      SCClearInstrsOrMark(sc, layer, true);
   }
}

void TTFPointMatches(SplineChar * sc, int layer, int top) {
   AnchorPoint *ap;
   BasePoint here, there;
   struct splinecharlist *deps;
   RefChar *ref;

   if (!sc->layers[layer].order2 || sc->layers[layer].background)
      return;
   for (ap=sc->anchor; ap != NULL; ap=ap->next) {
      if (ap->has_ttf_pt)
	 if (ttfFindPointInSC(sc, layer, ap->ttf_pt_index, &ap->me, NULL) !=
	     -1)
	    ap->has_ttf_pt=false;
   }
   for (ref=sc->layers[layer].refs; ref != NULL; ref=ref->next) {
      if (ref->point_match) {
	 if (ttfFindPointInSC(sc, layer, ref->match_pt_base, &there, ref) ==
	     -1
	     && ttfFindPointInSC(ref->sc, layer, ref->match_pt_ref, &here,
				 NULL)==-1) {
	    if (ref->transform[4] != there.x - here.x
		|| ref->transform[5] != there.y - here.y) {
	       ref->transform[4]=there.x - here.x;
	       ref->transform[5]=there.y - here.y;
	       SCReinstantiateRefChar(sc, ref, layer);
	       if (!top)
		  SCCharChangedUpdate(sc, layer, true);
	    }
	 } else
	    ref->point_match=false;	/* one of the points no longer exists */
      }
   }
   for (deps=sc->dependents; deps != NULL; deps=deps->next)
      TTFPointMatches(deps->sc, layer, false);
}

void SCCharChangedUpdate(SplineChar * sc, int layer, int changed) {
   SplineFont *sf=sc->parent;

   if (layer >= sc->layer_cnt) {
      ErrorMsg(2,"Bad layer in SCCharChangedUpdate\n");
      layer=ly_fore;
   }
   if (layer >= 0 && !sc->layers[layer].background)
      TTFPointMatches(sc, layer, true);
   if (changed != -1) {
      SFSetModTime(sf);
      if ((sc->changed==0) != (changed==0)) {
	 sc->changed=(changed != 0);
	 if (changed
	     && (sc->layers[ly_fore].splines != NULL
		 || sc->layers[ly_fore].refs != NULL))
	    sc->parent->onlybitmaps=false;
      }
      if (changed && layer >= 0 && !sc->layers[layer].background)
	 instrcheck(sc, layer);
      sc->changedsincelasthinted=true;
      sc->changed_since_search=true;
      sf->changed=true;
      sf->changed_since_xuidchanged=true;
      if (layer >= 0)
	 SCTickValidationState(sc, layer);
   }
}
