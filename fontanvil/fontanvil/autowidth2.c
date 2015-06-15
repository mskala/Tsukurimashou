/* $Id: autowidth2.c 4020 2015-06-14 18:15:09Z mskala $ */
/* Copyright (C) 2009-2012  George Williams
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
#include <ustring.h>
#include <utype.h>

#define DENOM_FACTOR_OF_EMSIZE	50.0

#include "autowidth2.h"
#include "edgelist2.h"

static int aw2_bbox_separation(AW_Glyph *g1,AW_Glyph *g2,AW_Data *all) {
   int j;

   int imin_y, imax_y;

   real tot, cnt;

   real denom;

   /* the goal is to give a weighted average that expresses the visual */
   /*  separation between two glyphs when they are placed so their bounding */
   /*  boxes are adjacent. The separation between two rectangles would be 0 */
   /*  While the separation between "T" and "o" would be fairly large */
   /* The trick is to guess a good weighting function. My guess is that */
   /*  things that look close are more important than those which look far */
   /*  So "T" and "O" should be dominated by the crossbar of the "T"... */

   imin_y=g2->imin_y > g1->imin_y ? g2->imin_y : g1->imin_y;
   imax_y=g2->imax_y < g1->imax_y ? g2->imax_y : g1->imax_y;
   if (imax_y < imin_y)		/* no overlap. ie grave and "a" */
      return (0);
   denom=all->denom;
   tot=cnt=0;
   for (j=imin_y; j < imax_y; ++j) {
      if (g2->left[j - g2->imin_y] < 32767
	  && g1->right[j - g1->imin_y] > -32767) {
	 /* beware of gaps such as those in "i" or "aaccute" */
	 real sep=g2->left[j - g2->imin_y] - g1->right[j - g1->imin_y];

	 real weight=1.0 / (sep + denom);

	 weight *= weight;

	 tot += weight * sep;
	 cnt += weight;
      }
   }
   if (cnt != 0)
      tot /= cnt;
   return (rint(tot));
}

static void aw2_figure_lsb(int right_index,AW_Data *all) {
   int i;

   AW_Glyph *me, *other;

   int lsb, tot;

   int *vpt=all->visual_separation + right_index;

   lsb=0;
   me=&all->glyphs[right_index];
   for (i=0; i < all->gcnt; ++i) {
      other=&all->glyphs[i];
      tot=all->desired_separation - vpt[i * all->gcnt] - other->rsb;
      if (tot < all->min_sidebearing)
	 tot=all->min_sidebearing;
      else if (tot > all->max_sidebearing)
	 tot=all->max_sidebearing;
      lsb += tot;
   }
   if (i != 0)
      lsb=(lsb + i / 2) / i;
   lsb=rint((3 * lsb + me->lsb) / 4.0);
   me->nlsb=lsb;
}

static void aw2_figure_rsb(int left_index,AW_Data *all) {
   int i;

   AW_Glyph *me, *other;

   int rsb, tot;

   int *vpt=all->visual_separation + left_index * all->gcnt;

   rsb=0;
   me=&all->glyphs[left_index];
   for (i=0; i < all->gcnt; ++i) {
      other=&all->glyphs[i];
      tot=all->desired_separation - vpt[i] - other->lsb;
      if (tot < all->min_sidebearing)
	 tot=all->min_sidebearing;
      else if (tot > all->max_sidebearing)
	 tot=all->max_sidebearing;
      rsb += tot;
   }
   if (i != 0)
      rsb=(rsb + i / 2) / i;
   rsb=rint((3 * rsb + me->rsb) / 4.0);
   me->nrsb=rsb;
}

static void aw2_figure_all_sidebearing(AW_Data *all) {
   int i, j;

   AW_Glyph *me, *other;

   real transform[6], half;

   int width, changed;

   uint8_t *rsel=calloc(all->fv->map->enccount, sizeof(char));

   real denom=(all->sf->ascent + all->sf->descent) / DENOM_FACTOR_OF_EMSIZE;

   int ldiff, rdiff;

   all->denom=denom;
   all->visual_separation=malloc(all->gcnt * all->gcnt * sizeof(int));
   for (i=0; i < all->gcnt; ++i) {
      int *vpt=all->visual_separation + i * all->gcnt;

      me=&all->glyphs[i];
      for (j=0; j < all->gcnt; ++j) {
	 other=&all->glyphs[j];
	 vpt[j]=aw2_bbox_separation(me, other, all);
      }
   }

   half=all->desired_separation / 2;
   for (i=0; i < all->gcnt; ++i) {
      me=&all->glyphs[i];
      me->lsb=me->rsb=half;
   }

   for (j=0; j < all->loop_cnt; ++j) {
      for (i=0; i < all->gcnt; ++i)
	 aw2_figure_lsb(i, all);
      for (i=0; i < all->gcnt; ++i)
	 aw2_figure_rsb(i, all);
      for (i=0; i < all->gcnt; ++i) {
	 AW_Glyph *me=&all->glyphs[i];

	 me->rsb=me->nrsb;
	 me->lsb=me->nlsb;
      }
   }
   free(all->visual_separation);
   all->visual_separation=NULL;

   if (all->normalize) {
      /* This is the dummy flat edge we added. We want the separation between */
      /*  two adjacent flat edges to be desired_separation */
      me=&all->glyphs[all->gcnt - 1];
      if (me->lsb + me->rsb != all->desired_separation && me->sc==NULL) {
	 if (me->lsb + me->rsb != 0) {
	    ldiff =
	       (all->desired_separation -
		(me->lsb + me->rsb)) * me->lsb / (me->lsb + me->rsb);
	 } else {
	    ldiff=all->desired_separation / 2;
	 }
	 rdiff=(all->desired_separation - (me->lsb + me->rsb)) - ldiff;
	 for (i=0; (me=&all->glyphs[i])->sc != NULL; ++i) {
	    me->lsb += ldiff;
	    me->rsb += rdiff;
	 }
      }
   }

   transform[0]=transform[3]=1.0;
   transform[1]=transform[2]=transform[5]=0;
   for (i=0; (me=&all->glyphs[i])->sc != NULL; ++i) {
      changed=0;
      if (me->lsb != me->bb.minx) {
	 transform[4]=me->lsb - me->bb.minx;
	 FVTrans(all->fv, me->sc, transform, rsel, false);
	 changed=true;
      }
      width=me->lsb + me->rsb + rint(me->bb.maxx - me->bb.minx);
      if (me->sc->width != width) {
	 SCPreserveWidth(me->sc);
	 SCSynchronizeWidth(me->sc, width, me->sc->width, all->fv);
	 changed=true;
      }
      if (changed)
	 SCCharChangedUpdate(me->sc, ly_none, true);
   }
   free(rsel);
}

static double MonotonicFindY(Monotonic *m,double test,double old_t) {
   double tstart, tend, t;

   tstart=m->tstart;
   tend=m->tend;
   if (old_t != -1) {
      if (m->yup)
	 tstart=old_t;
      else
	 tend=old_t;
   }
   t=IterateSplineSolve(&m->s->splines[1], tstart, tend, test);
   return (t);
}

static void aw2_findedges(AW_Glyph *me,AW_Data *all) {
   Monotonic *ms, *m;

   real ytop, ybottom;

   real x, xmin, xmax;

   int i;

   double t;

   Spline1D *msp;

   SplineSet *base;

   me->imin_y=floor(me->bb.miny / all->sub_height);
   me->imax_y=ceil(me->bb.maxy / all->sub_height);
   me->left=malloc((me->imax_y - me->imin_y + 1) * sizeof(short));
   me->right=malloc((me->imax_y - me->imin_y + 1) * sizeof(short));

   base=LayerAllSplines(&me->sc->layers[all->layer]);
   ms=SSsToMContours(base, over_remove);	/* over_remove is an arcane way of saying: Look at all contours, not just selected ones */
   LayerUnAllSplines(&me->sc->layers[all->layer]);

   ytop=me->imin_y * all->sub_height;
   for (m=ms; m != NULL; m=m->linked) {
      m->t=-1;
      if (m->b.miny <= ytop)	/* can't be less than, but... */
	 m->t=MonotonicFindY(m, ytop, -1);
   }
   for (i=me->imin_y; i <= me->imax_y; ++i) {
      ybottom=ytop;
      ytop += all->sub_height;
      xmin=1e10;
      xmax=-1e10;
      for (m=ms; m != NULL; m=m->linked) {
	 if (m->b.maxy < ybottom || m->b.miny > ytop
	     || m->b.maxy==m->b.miny)
	    continue;
	 if ((t=m->t)==-1)
	    t=MonotonicFindY(m, m->b.miny, -1);
	 msp=&m->s->splines[0];
	 if (t != -1) {
	    x=((msp->a * t + msp->b) * t + msp->c) * t + msp->d;
	    if (x > xmax)
	       xmax=x;
	    if (x < xmin)
	       xmin=x;
	 }
	 if (ytop < m->b.maxy)
	    t=m->t=MonotonicFindY(m, ytop, t);
	 else {
	    m->t=-1;
	    t=MonotonicFindY(m, m->b.maxy, t);
	 }
	 if (t != -1) {
	    x=((msp->a * t + msp->b) * t + msp->c) * t + msp->d;
	    if (x > xmax)
	       xmax=x;
	    if (x < xmin)
	       xmin=x;
	 }
      }
      if (xmin > 1e9) {
	 /* Glyph might have a gap (as "i" or ":" do) */
	 me->left[i - me->imin_y] =
	    32767 /* floor((me->bb.maxx - me->bb.minx)/2) */ ;
	 me->right[i - me->imin_y] =
	    -32767 /* floor(-(me->bb.maxx - me->bb.minx)/2) */ ;
      } else {
	 me->left[i - me->imin_y]=floor(xmin - me->bb.minx);
	 me->right[i - me->imin_y]=floor(xmax - me->bb.maxx);	/* This is always non-positive, so floor will give the bigger absolute value */
      }
   }
   FreeMonotonics(ms);
}

static void aw2_dummyedges(AW_Glyph *flat,AW_Data *all) {
   int i;

   int imin_y=32000, imax_y=-32000;

   if (all != NULL) {
      for (i=0; i < all->gcnt; ++i) {
	 AW_Glyph *test=&all->glyphs[i];

	 if (test->imin_y < imin_y)
	    imin_y=test->imin_y;
	 if (test->imax_y > imax_y)
	    imax_y=test->imax_y;
      }
      if (imin_y==32000) {
	 imin_y=floor(-all->sf->descent / all->sub_height);
	 imax_y=ceil(all->sf->ascent / all->sub_height);
      }
      flat->imin_y=imin_y;
      flat->imax_y=imax_y;
   }
   flat->left=calloc((flat->imax_y - flat->imin_y + 1), sizeof(short));
   flat->right=calloc((flat->imax_y - flat->imin_y + 1), sizeof(short));
}

static void AWGlyphFree(AW_Glyph *me) {
   free(me->left);
   free(me->right);
}

static void aw2_handlescript(AW_Data *all) {
   int i;

   AW_Glyph *me;

   for (i=0; (me=&all->glyphs[i])->sc != NULL; ++i)
      aw2_findedges(me, all);
   aw2_dummyedges(me, all);
   ++all->gcnt;
   aw2_figure_all_sidebearing(all);
   for (i=0; i < all->gcnt; ++i)
      AWGlyphFree(&all->glyphs[i]);
}

void AutoWidth2(FontViewBase * fv, int separation, int min_side, int max_side,
		int chunk_height, int loop_cnt) {
   struct scriptlist {
      uint32_t script;
      AW_Glyph *glyphs;
      int gcnt;
   } *scripts;

   int scnt, smax;

   int enc, gid, s, i;

   SplineFont *sf=fv->sf;

   SplineChar *sc;

   AW_Data all;

   if (chunk_height <= 0)
      chunk_height=(sf->ascent + sf->descent) / 100;
   if (loop_cnt <= 0)
      loop_cnt=4;

   scnt=0;
   smax=10;
   scripts=malloc(smax * sizeof(struct scriptlist));

   for (gid=0; gid < sf->glyphcnt; ++gid) {
      if ((sc=sf->glyphs[gid]) != NULL)
	 sc->ticked=false;
   }
   for (enc=0; enc < fv->map->enccount; ++enc) {
      if (fv->selected[enc] && (gid=fv->map->map[enc]) != -1 &&
	  (sc=sf->glyphs[gid]) != NULL && !sc->ticked &&
	  HasUseMyMetrics(sc, fv->active_layer)==NULL) {
	 /* If Use My Metrics is set, then we can't change the width (which we grab from a refchar) */
	 uint32_t script;

	 script=SCScriptFromUnicode(sc);
	 for (s=0; s < scnt; ++s) {
	    if (scripts[s].script==script)
	       break;
	 }
	 if (s==scnt) {
	    if (scnt >= smax)
	       scripts =
		  realloc(scripts, (smax += 10) * sizeof(struct scriptlist));
	    memset(&scripts[scnt], 0, sizeof(struct scriptlist));
	    scripts[scnt].script=script;
	    scripts[scnt].glyphs=calloc(sf->glyphcnt + 1, sizeof(AW_Glyph));
	    ++scnt;
	 }
	 i=scripts[s].gcnt;
	 scripts[s].glyphs[i].sc=sc;
	 SplineCharLayerFindBounds(sc, fv->active_layer,
				   &scripts[s].glyphs[i].bb);
	 if (scripts[s].glyphs[i].bb.minx < -16000
	     || scripts[s].glyphs[i].bb.maxx > 16000
	     || scripts[s].glyphs[i].bb.miny < -16000
	     || scripts[s].glyphs[i].bb.maxy > 16000)
	    ErrorMsg(1,"Glyph too big:  %s has a bounding box which is too "
	               "big for this algorithm to work.  Ignored.\n",sc->name);
	 else
	    ++scripts[s].gcnt;
      }
   }

   memset(&all, 0, sizeof(all));
   all.sf=sf;
   all.fv=fv;
   all.layer=fv->active_layer;
   all.normalize=true;

   all.sub_height=chunk_height;
   all.loop_cnt=loop_cnt;
   all.desired_separation=separation;
   all.min_sidebearing=min_side;
   all.max_sidebearing=max_side;

   for (s=0; s < scnt; ++s) {
      memset(&scripts[s].glyphs[scripts[s].gcnt], 0, sizeof(AW_Glyph));
      all.glyphs=scripts[s].glyphs;
      all.gcnt=scripts[s].gcnt;
      aw2_handlescript(&all);
      free(all.glyphs);
   }
   free(scripts);
}
