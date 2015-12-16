/* $Id: search.c 4501 2015-12-16 13:47:38Z mskala $ */
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
#include <ustring.h>
#include <utype.h>

typedef struct searchdata {
   SplineChar sc_srch, sc_rpl;
   SplineSet *path, *revpath, *replacepath, *revreplace;
   int pointcnt, rpointcnt;
   double fudge;
   double fudge_percent;		/* a value of .05 here represents 5% (we don't store the integer) */
   unsigned int subpatternsearch:1;
   unsigned int doreplace:1;
   unsigned int already_complained:1;	/* User has already been alerted to the fact that we've converted splines to refs and lost the instructions */
   SplineSet *matched_spl;
   SplinePoint *matched_sp, *last_sp;
   double matched_rot, matched_scale;
   double matched_x, matched_y;
   double matched_co, matched_si;	/* Precomputed sin, cos */
   enum flipset matched_flip;
   unsigned long long matched_refs;	/* Bit map of which refs in the char were matched */
   unsigned long long matched_ss;	/* Bit map of which splines in the char were matched */
   /* In multi-path mode */
   unsigned long long matched_ss_start;	/* Bit map of which splines we tried to start matches with */
   FontViewBase *fv;
   SplineChar *curchar;
   int last_gid;
} SearchData;

static int CoordMatches(double real_off,double search_off,SearchData *s) {
   double fudge;

   if (real_off >= search_off - s->fudge && real_off <= search_off + s->fudge)
      return (true);
   fudge=s->fudge_percent * search_off;
   if (fudge < 0)
      fudge=-fudge;
   if (real_off >= search_off - fudge && real_off <= search_off + fudge)
      return (true);
   return (false);
}

static int BPMatches(BasePoint *sc_p1,BasePoint *sc_p2,BasePoint *p_p1,
		     BasePoint * p_p2, int flip, double rot, double scale,
		     SearchData * s) {
   double sxoff, syoff, pxoff, pyoff;

   sxoff=sc_p1->x - sc_p2->x;
   syoff=sc_p1->y - sc_p2->y;
   pxoff=p_p1->x - p_p2->x;
   pyoff=p_p1->y - p_p2->y;
   if (flip & 1)
      sxoff=-sxoff;
   if (flip & 2)
      syoff=-syoff;
   sxoff *= scale;
   syoff *= scale;
   if (rot==0)
      return (CoordMatches(sxoff, pxoff, s) && CoordMatches(syoff, pyoff, s));

   return (CoordMatches
	   (sxoff * s->matched_co + syoff * s->matched_si, pxoff, s)
	   && CoordMatches(-sxoff * s->matched_si + syoff * s->matched_co,
			   pyoff, s));
}

static int SPMatchesF(SplinePoint *sp,SearchData *s,SplineSet *path,
		      SplinePoint * sc_path_first, int substring) {
   SplinePoint *sc_sp, *nsc_sp, *p_sp, *np_sp;
   int flip, flipmax;
   double rot, scale;
   int saw_sc_first=false, first_of_path;
   BasePoint p_unit, pend_unit, sc_unit;
   double len, temp;

   s->matched_sp=sp;
   s->matched_rot=0;
   s->matched_scale=1.0;
   s->matched_flip=flip_none;
   s->matched_co=1;
   s->matched_si=0;

   first_of_path=true;
   p_sp=path->first;

/* ******************* Match with no transformations applied **************** */
   first_of_path=true;
   for (sc_sp=sp;;) {
      if (sc_sp->ticked)	/* Don't search within stuff we have just replaced */
	 return (false);

      if (p_sp->next==NULL) {
	 if (substring || sc_sp->next==NULL) {
	    s->last_sp=saw_sc_first ? NULL : sp;
	    return (true);
	 }
	 break;
      }
      np_sp=p_sp->next->to;
      if (sc_sp->next==NULL)
	 break;
      nsc_sp=sc_sp->next->to;

      if (!CoordMatches
	  (sc_sp->nextcp.x - sc_sp->me.x, p_sp->nextcp.x - p_sp->me.x, s)
	  || !CoordMatches(sc_sp->nextcp.y - sc_sp->me.y,
			   p_sp->nextcp.y - p_sp->me.y, s)
	  || !CoordMatches(nsc_sp->me.x - sc_sp->me.x,
			   np_sp->me.x - p_sp->me.x, s)
	  || !CoordMatches(nsc_sp->me.y - sc_sp->me.y,
			   np_sp->me.y - p_sp->me.y, s)
	  || !CoordMatches(nsc_sp->prevcp.x - nsc_sp->me.x,
			   np_sp->prevcp.x - np_sp->me.x, s)
	  || !CoordMatches(nsc_sp->prevcp.y - nsc_sp->me.y,
			   np_sp->prevcp.y - np_sp->me.y, s))
	 break;
      if (np_sp==path->first) {
	 if (nsc_sp==sp) {
	    s->last_sp=saw_sc_first ? NULL : sp;
	    return (true);
	 }
	 break;
      }
      sc_sp=nsc_sp;
      if (sc_sp==sc_path_first)
	 saw_sc_first=true;
      p_sp=np_sp;
   }

   return (false);
}

static int SPMatchesO(SplinePoint *sp,SearchData *s,SplineSet *path) {
   SplinePoint *sc_sp, *nsc_sp, *p_sp, *np_sp;

   s->matched_sp=sp;
   if (s->matched_rot==0 && s->matched_scale==1
       && s->matched_flip==flip_none) {
      for (sc_sp=sp, p_sp=path->first;;) {
	 if (p_sp->next==NULL)
	    return (sc_sp->next==NULL);
	 np_sp=p_sp->next->to;
	 if (sc_sp->next==NULL)
	    return (false);
	 nsc_sp=sc_sp->next->to;
	 if (!CoordMatches
	     (sc_sp->nextcp.x - sc_sp->me.x, p_sp->nextcp.x - p_sp->me.x, s)
	     || !CoordMatches(sc_sp->nextcp.y - sc_sp->me.y,
			      p_sp->nextcp.y - p_sp->me.y, s)
	     || !CoordMatches(nsc_sp->me.x - sc_sp->me.x,
			      np_sp->me.x - p_sp->me.x, s)
	     || !CoordMatches(nsc_sp->me.y - sc_sp->me.y,
			      np_sp->me.y - p_sp->me.y, s)
	     || !CoordMatches(nsc_sp->prevcp.x - nsc_sp->me.x,
			      np_sp->prevcp.x - np_sp->me.x, s)
	     || !CoordMatches(nsc_sp->prevcp.y - nsc_sp->me.y,
			      np_sp->prevcp.y - np_sp->me.y, s))
	    return (false);
	 if (np_sp==path->first)
	    return (nsc_sp==sp);
	 sc_sp=nsc_sp;
	 p_sp=np_sp;
      }
   } else if (s->matched_rot==0 && s->matched_scale==1) {
      int xsign=(s->matched_flip & 1) ? -1 : 1, ysign =
	 (s->matched_flip & 2) ? -1 : 1;
      for (sc_sp=sp, p_sp=path->first;;) {
	 if (p_sp->next==NULL)
	    return (sc_sp->next==NULL);
	 np_sp=p_sp->next->to;
	 if (sc_sp->next==NULL)
	    return (false);
	 nsc_sp=sc_sp->next->to;
	 if (!CoordMatches
	     (sc_sp->nextcp.x - sc_sp->me.x,
	      xsign * (p_sp->nextcp.x - p_sp->me.x), s)
	     || !CoordMatches(sc_sp->nextcp.y - sc_sp->me.y,
			      ysign * (p_sp->nextcp.y - p_sp->me.y), s)
	     || !CoordMatches(nsc_sp->me.x - sc_sp->me.x,
			      xsign * (np_sp->me.x - p_sp->me.x), s)
	     || !CoordMatches(nsc_sp->me.y - sc_sp->me.y,
			      ysign * (np_sp->me.y - p_sp->me.y), s)
	     || !CoordMatches(nsc_sp->prevcp.x - nsc_sp->me.x,
			      xsign * (np_sp->prevcp.x - np_sp->me.x), s)
	     || !CoordMatches(nsc_sp->prevcp.y - nsc_sp->me.y,
			      ysign * (np_sp->prevcp.y - np_sp->me.y), s))
	    return (false);
	 if (np_sp==path->first)
	    return (nsc_sp==sp);
	 sc_sp=nsc_sp;
	 p_sp=np_sp;
      }
   } else {
      p_sp=path->first;
      for (sc_sp=sp, p_sp=path->first;;) {
	 if (p_sp->next==NULL)
	    return (sc_sp->next==NULL);
	 np_sp=p_sp->next->to;
	 if (sc_sp->next==NULL)
	    return (false);
	 nsc_sp=sc_sp->next->to;
	 if (!BPMatches(&sc_sp->nextcp, &sc_sp->me, &p_sp->nextcp, &p_sp->me,
			s->matched_flip, s->matched_rot, s->matched_scale, s)
	     || !BPMatches(&nsc_sp->me, &sc_sp->me, &np_sp->me, &p_sp->me,
			   s->matched_flip, s->matched_rot, s->matched_scale,
			   s)
	     || !BPMatches(&nsc_sp->prevcp, &nsc_sp->me, &np_sp->prevcp,
			   &np_sp->me, s->matched_flip, s->matched_rot,
			   s->matched_scale, s))
	    return (false);
	 if (np_sp==path->first)
	    return (nsc_sp==sp);
	 sc_sp=nsc_sp;
	 p_sp=np_sp;
      }
   }
   return (false);
}

static void SVBuildTrans(SearchData *s,double transform[6]) {
   memset(transform, 0, sizeof(double[6]));
   transform[0]=transform[3]=1;
   if (s->matched_flip & 1)
      transform[0]=-1;
   if (s->matched_flip & 2)
      transform[3]=-1;
   transform[0] /= s->matched_scale;
   transform[3] /= s->matched_scale;
   transform[1]=-transform[0] * s->matched_si;
   transform[0] *= s->matched_co;
   transform[2]=transform[3] * s->matched_si;
   transform[3] *= s->matched_co;
   transform[4]=s->matched_x;
   transform[5]=s->matched_y;
}

static void SVFigureTranslation(SearchData *s,BasePoint *p,
				SplinePoint * sp) {
   double transform[6];
   BasePoint res;

   SVBuildTrans(s, transform);
   res.x=transform[0] * p->x + transform[2] * p->y + transform[4];
   res.y=transform[1] * p->x + transform[3] * p->y + transform[5];
   s->matched_x=sp->me.x - res.x;
   s->matched_y=sp->me.y - res.y;
}

static int SPMatches(SplinePoint *sp,SearchData *s,SplineSet *path,
		     SplinePoint * sc_path_first, int oriented) {
   double transform[6];
   BasePoint *p, res;

   if (oriented) {
      double fudge=s->fudge < .1 ? 10 * s->fudge : s->fudge;

      SVBuildTrans(s, transform);
      p=&path->first->me;
      res.x=transform[0] * p->x + transform[2] * p->y + transform[4];
      res.y=transform[1] * p->x + transform[3] * p->y + transform[5];
      if (sp->me.x > res.x + fudge || sp->me.x < res.x - fudge ||
	  sp->me.y > res.y + fudge || sp->me.y < res.y - fudge)
	 return (false);

      return (SPMatchesO(sp, s, path));
   } else {
      if (!SPMatchesF(sp, s, path, sc_path_first, false))
	 return (false);
      SVFigureTranslation(s, &path->first->me, sp);
      return (true);
   }
}

/* We are given a single, unclosed path to match. It is a match if it */
/*  corresponds to any subset of a path in the character */
static int SCMatchesIncomplete(SplineChar *sc,SearchData *s,
			       int startafter) {
   /* don't look in refs because we can't do a replace there */
   SplineSet *spl;
   SplinePoint *sp;
   int layer=s->fv->active_layer;

   for (spl=startafter ? s->matched_spl : sc->layers[layer].splines;
	spl != NULL; spl=spl->next) {
      s->matched_spl=spl;
      for (sp=startafter ? s->last_sp : spl->first; sp != NULL;) {
	 if (SPMatchesF(sp, s, s->path, spl->first, true)) {
	    SVFigureTranslation(s, &s->path->first->me, sp);
	    return (true);
	 }
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==spl->first)
	    break;
      }
      startafter=false;
   }
   return (false);
}

/* We are given several paths/refs to match. We have a match if each path */
/*  matches a path in the character exactly, and each ref also. A searched for*/
/*  path can not match a subset of a path */
static int SCMatchesFull(SplineChar *sc,SearchData *s) {
   /* don't look to match paths in refs because we can't do a replace there */
   SplineSet *spl, *s_spl, *s_r_spl;
   SplinePoint *sp;
   RefChar *r, *s_r;
   int i, first, ref_first;
   int layer=s->fv->active_layer;

   s->matched_ss=s->matched_refs=s->matched_ss_start=0;
   first=true;
   for (s_r=s->sc_srch.layers[ly_fore].refs; s_r != NULL; s_r=s_r->next) {
      for (r=sc->layers[layer].refs, i=0; r != NULL; r=r->next, ++i)
	 if (!(s->matched_refs & (1 << i))) {
	    if (r->sc==s_r->sc) {
	       /* I should check the transform to see if the tryflips (etc) flags would make this not a match */
	       if (r->transform[0]==s_r->transform[0]
		   && r->transform[1]==s_r->transform[1]
		   && r->transform[2]==s_r->transform[2]
		   && r->transform[3]==s_r->transform[3]) {
		  if (first) {
		     s->matched_scale=1.0;
		     s->matched_x=r->transform[4] - s_r->transform[4];
		     s->matched_y=r->transform[5] - s_r->transform[5];
		     first=false;
		     break;
		  } else if (r->transform[4] - s_r->transform[4] ==
			     s->matched_x
			     && r->transform[5] - s_r->transform[5] ==
			     s->matched_y)
		     break;
	       }
	    }
	 }
      if (r==NULL)
	 return (false);
      s->matched_refs |= 1 << i;
   }
   ref_first=first;

 retry:
   if (ref_first)
      s->matched_x=s->matched_y=0;
   s->matched_ss=s->matched_ss_start;	/* Don't use any of these contours, they don't work */
   first=ref_first;
   for (s_spl=s->path, s_r_spl=s->revpath; s_spl != NULL;
	s_spl=s_spl->next, s_r_spl=s_r_spl->next) {
      for (spl=sc->layers[layer].splines, i=0; spl != NULL;
	   spl=spl->next, ++i)
	 if (!(s->matched_ss & (1 << i))) {
	    s->matched_spl=spl;
	    if (spl->first->prev==NULL) {	/* Open */
	       if (s_spl->first != s_spl->last) {
		  if (SPMatches(spl->first, s, s_spl, spl->first, 1 - first))
		     break;
	       }
	    } else {
	       if (s_spl->first==s_spl->last) {
		  int found=false;

		  for (sp=spl->first;;) {
		     if (SPMatches(sp, s, s_spl, spl->first, 1 - first)) {
			found=true;
			break;
		     }
		     sp=sp->next->to;
		     if (sp==spl->first)
			break;
		  }
		  if (found)
		     break;
	       }
	    }
	 }
      if (spl==NULL) {
	 if (s_spl==s->path)
	    return (false);
	 /* Ok, we could not find a match starting from the contour */
	 /*  we started with. However if there are multiple contours */
	 /*  in the search pattern, that might just mean that we a bad */
	 /*  transform, so start from scratch and try some other contours */
	 /*  but don't test anything we've already ruled out */
	 goto retry;
      }
      if (s_spl==s->path) {
	 s->matched_ss_start |= 1 << i;
	 s->matched_ss=1 << i;	/* Ok, the contours in matched_ss_start didn't work as starting points, but we still must test them with the current transform against other contours */
      } else
	 s->matched_ss |= 1 << i;
      first=false;
   }
   return true;
}

static int AdjustBP(BasePoint *changeme,BasePoint *rel,
		    BasePoint * shouldbe, BasePoint * shouldberel,
		    BasePoint * fudge, SearchData * s) {
   double xoff, yoff;

   xoff=(shouldbe->x - shouldberel->x);
   yoff=(shouldbe->y - shouldberel->y);
   if (s->matched_flip & 1)
      xoff=-xoff;
   if (s->matched_flip & 2)
      yoff=-yoff;
   xoff *= s->matched_scale;
   yoff *= s->matched_scale;
   changeme->x =
      xoff * s->matched_co - yoff * s->matched_si + fudge->x + rel->x;
   changeme->y =
      yoff * s->matched_co + xoff * s->matched_si + fudge->y + rel->y;
   return (changeme->x==rel->x && changeme->y==rel->y);
}

static void AdjustAll(SplinePoint *change,BasePoint *rel,
		      BasePoint * shouldbe, BasePoint * shouldberel,
		      BasePoint * fudge, SearchData * s) {
   BasePoint old;

   old=change->me;
   AdjustBP(&change->me, rel, shouldbe, shouldberel, fudge, s);
   change->nextcp.x += change->me.x - old.x;
   change->nextcp.y += change->me.y - old.y;
   change->prevcp.x += change->me.x - old.x;
   change->prevcp.y += change->me.y - old.y;

   change->nonextcp=(change->nextcp.x==change->me.x
		       && change->nextcp.y==change->me.y);
   change->noprevcp=(change->prevcp.x==change->me.x
		       && change->prevcp.y==change->me.y);
}

static SplinePoint *RplInsertSP(SplinePoint *after,SplinePoint *nrpl,
				SplinePoint * rpl, SearchData * s,
				BasePoint * fudge) {
   SplinePoint *new=chunkalloc(sizeof(SplinePoint));
   double transform[6];

   SVBuildTrans(s, transform);
   /*transform[4] += fudge->x; transform[5] += fudge->y; */
   new->me.x =
      after->me.x + transform[0] * (nrpl->me.x - rpl->me.x) +
      transform[1] * (nrpl->me.y - rpl->me.y) + fudge->x;
   new->me.y =
      after->me.y + transform[2] * (nrpl->me.x - rpl->me.x) +
      transform[3] * (nrpl->me.y - rpl->me.y) + fudge->y;
   new->nextcp.x =
      after->me.x + transform[0] * (nrpl->nextcp.x - rpl->me.x) +
      transform[1] * (nrpl->nextcp.y - rpl->me.y) + fudge->x;
   new->nextcp.y =
      after->me.y + transform[2] * (nrpl->nextcp.x - rpl->me.x) +
      transform[3] * (nrpl->nextcp.y - rpl->me.y) + fudge->y;
   new->prevcp.x =
      after->me.x + transform[0] * (nrpl->prevcp.x - rpl->me.x) +
      transform[1] * (nrpl->prevcp.y - rpl->me.y) + fudge->x;
   new->prevcp.y =
      after->me.y + transform[2] * (nrpl->prevcp.x - rpl->me.x) +
      transform[3] * (nrpl->prevcp.y - rpl->me.y) + fudge->y;
   new->nonextcp=(new->nextcp.x==new->me.x && new->nextcp.y==new->me.y);
   new->noprevcp=(new->prevcp.x==new->me.x && new->prevcp.y==new->me.y);
   new->pointtype=rpl->pointtype;
   new->selected=true;
   new->ticked=true;
   if (after->next==NULL) {
      SplineMake(after, new, after->prev->order2);
      s->matched_spl->last=new;
   } else {
      SplinePoint *nsp=after->next->to;

      after->next->to=new;
      new->prev=after->next;
      SplineRefigure(after->next);
      SplineMake(new, nsp, after->next->order2);
   }
   return (new);
}

static void FudgeFigure(SplineChar *sc,SearchData *s,SplineSet *path,
			BasePoint * fudge) {
   SplinePoint *search, *searchrel, *found, *foundrel;
   double xoff, yoff;

   fudge->x=fudge->y=0;
   if (path->first->prev != NULL)	/* closed path, should end where it began */
      return;			/*  => no fudge */

   foundrel=s->matched_sp;
   searchrel=path->first;
   for (found=foundrel, search=searchrel;;) {
      if (found->next==NULL || search->next==NULL)
	 break;
      found=found->next->to;
      search=search->next->to;
   }

   xoff=(found->me.x - foundrel->me.x);
   yoff=(found->me.y - foundrel->me.y);
   if (s->matched_flip & 1)
      xoff=-xoff;
   if (s->matched_flip & 2)
      yoff=-yoff;
   xoff *= s->matched_scale;
   yoff *= s->matched_scale;
   fudge->x =
      xoff * s->matched_co + yoff * s->matched_si - (search->me.x -
						     searchrel->me.x);
   fudge->y =
      yoff * s->matched_co - xoff * s->matched_si - (search->me.y -
						     searchrel->me.y);
}

static void DoReplaceIncomplete(SplineChar *sc,SearchData *s) {
   SplinePoint *sc_p, *nsc_p, *p_p, *np_p, *r_p, *nr_p;
   BasePoint fudge;
   SplineSet *path, *rpath;
   SplinePoint dummy;
   Spline dummysp;

   path=s->path;
   rpath=s->replacepath;

   /* Total "fudge" amount should be spread evenly over each point */
   FudgeFigure(sc, s, path, &fudge);
   if (s->pointcnt != s->rpointcnt)
      MinimumDistancesFree(sc->md);
   sc->md=NULL;

   sc_p=s->matched_sp;
   p_p=path->first, r_p=rpath->first;
   while (1) {
      if ((p_p->next==NULL) && (r_p->next==NULL)) {
	 s->last_sp=s->last_sp==NULL ? NULL : sc_p;	/* If we crossed the contour start, move to next contour */
	 return;		/* done */
      } else if (p_p->next==NULL) {
	 /* The search pattern is shorter that the replace pattern */
	 /*  Need to add some extra points */
	 nr_p=r_p->next->to;
	 sc_p=RplInsertSP(sc_p, nr_p, r_p, s, &fudge);
	 r_p=nr_p;
      } else if (r_p->next==NULL) {
	 /* The replace pattern is shorter than the search pattern */
	 /*  Need to remove some points */
	 nsc_p=sc_p->next->to;
	 if (nsc_p->next==NULL) {
	    SplinePointFree(nsc_p);
	    SplineFree(sc_p->next);
	    sc_p->next=NULL;
	    s->matched_spl->last=sc_p;
	    s->last_sp=s->last_sp==NULL ? NULL : sc_p;
	    return;
	 } else {
	    nsc_p=nsc_p->next->to;
	    SplinePointFree(sc_p->next->to);
	    SplineFree(sc_p->next);
	    sc_p->next=nsc_p->prev;
	    nsc_p->prev->from=sc_p;
	    SplineRefigure(nsc_p->prev);
	 }
	 p_p=p_p->next->to;
	 sc_p=nsc_p;
      } else {
	 if (sc_p->next==NULL) {
	    ErrorMsg(2,"Unexpected point mismatch in replace\n");
	    return;
	 }
	 np_p=p_p->next->to;
	 nsc_p=sc_p->next->to;
	 nr_p=r_p->next->to;
	 if (p_p==path->first) {
	    sc_p->nonextcp =
	       AdjustBP(&sc_p->nextcp, &sc_p->me, &r_p->nextcp, &r_p->me,
			&fudge, s);
	    if (p_p->prev != NULL)
	       sc_p->noprevcp =
		  AdjustBP(&sc_p->prevcp, &sc_p->me, &r_p->prevcp, &r_p->me,
			   &fudge, s);
	    if (sc_p->prev != NULL)
	       SplineRefigure(sc_p->prev);
	    sc_p->ticked=true;
	 }
	 if (np_p==path->first)
	    return;
	 if (np_p->next != NULL)
	    nsc_p->nonextcp =
	       AdjustBP(&nsc_p->nextcp, &nsc_p->me, &nr_p->nextcp, &nr_p->me,
			&fudge, s);
	 nsc_p->noprevcp =
	    AdjustBP(&nsc_p->prevcp, &nsc_p->me, &nr_p->prevcp, &nr_p->me,
		     &fudge, s);
	 AdjustAll(nsc_p, &sc_p->me, &nr_p->me, &r_p->me, &fudge, s);
	 nsc_p->ticked=true;
	 nsc_p->pointtype=nr_p->pointtype;
	 if (nsc_p->next != NULL) {
	    if (nsc_p->next->order2)
	       nsc_p->next->to->prevcp=nsc_p->nextcp;
	    SplineRefigure(nsc_p->next);
	 }
	 if (nsc_p->prev != NULL) {
	    if (nsc_p->prev->order2)
	       nsc_p->prev->from->nextcp=nsc_p->prevcp;
	    SplineRefigure(nsc_p->prev);
	 }
	 p_p=np_p;
	 sc_p=nsc_p;
	 r_p=nr_p;
      }
   }
}

static int HeuristiclyBadMatch(SplineChar *sc,SearchData *s) {
   /* Consider the case of a closed circle and an open circle, where the */
   /*  open circle looks just like the closed except that the open circle */
   /*  has an internal counter-clockwise contour. We don't want to match here */
   /*  we'd get a reference and a counter-clockwise contour which would make */
   /*  no sense. */
   /* so if, after removing matched contours we are left with a single counter */
   /*  clockwise contour, don't accept the match */
   int contour_cnt, i;
   SplineSet *spl;
   int layer=s->fv->active_layer;

   contour_cnt=0;
   for (spl=sc->layers[layer].splines, i=0; spl != NULL;
	spl=spl->next, ++i) {
      if (!(s->matched_ss & (1 << i))) {
	 if (SplinePointListIsClockwise(spl)==1)
	    return (false);
	 ++contour_cnt;
      }
   }
   if (contour_cnt==0)
      return (false);		/* Exact match */

   /* Everything remaining is counter-clockwise */
   return (true);
}

static void DoReplaceFull(SplineChar *sc,SearchData *s) {
   int i;
   RefChar *r, *rnext, *new;
   SplinePointList *spl, *snext, *sprev, *temp;
   double transform[6], subtrans[6];
   SplinePoint *sp;
   int layer=s->fv->active_layer;

   /* first remove those bits that matched */
   for (r=sc->layers[layer].refs, i=0; r != NULL; r=rnext, ++i) {
      rnext=r->next;
      if (s->matched_refs & (1 << i))
	 SCRemoveDependent(sc, r, layer);
   }
   sprev=NULL;
   for (spl=sc->layers[layer].splines, i=0; spl != NULL; spl=snext, ++i) {
      snext=spl->next;
      if (s->matched_ss & (1 << i)) {
	 if (sprev==NULL)
	    sc->layers[layer].splines=snext;
	 else
	    sprev->next=snext;
	 spl->next=NULL;
	 SplinePointListMDFree(sc, spl);
      } else
	 sprev=spl;
   }

   /* Then insert the replace stuff */
   SVBuildTrans(s, transform);
   for (r=s->sc_rpl.layers[ly_fore].refs; r != NULL; r=r->next) {
      subtrans[0] =
	 transform[0] * r->transform[0] + transform[1] * r->transform[2];
      subtrans[1] =
	 transform[0] * r->transform[1] + transform[1] * r->transform[3];
      subtrans[2] =
	 transform[2] * r->transform[0] + transform[3] * r->transform[2];
      subtrans[3] =
	 transform[2] * r->transform[1] + transform[3] * r->transform[3];
      subtrans[4] =
	 transform[4] * r->transform[0] + transform[5] * r->transform[2] +
	 r->transform[4];
      subtrans[5] =
	 transform[4] * r->transform[1] + transform[5] * r->transform[3] +
	 r->transform[5];
      new=RefCharCreate();
      free(new->layers);
      *new=*r;
      memcpy(new->transform, subtrans, sizeof(subtrans));
      new->layers=NULL;
      new->layer_cnt=0;
      new->next=sc->layers[layer].refs;
      new->selected=true;
      sc->layers[layer].refs=new;
      SCReinstantiateRefChar(sc, new, layer);
      SCMakeDependent(sc, new->sc);
      if (sc->layers[layer].order2 &&
	  !sc->layers[layer].background &&
	  !sc->instructions_out_of_date && sc->ttf_instrs != NULL) {
	 /* The normal change check doesn't respond properly to pasting a reference */
	 SCClearInstrsOrMark(sc, layer, !s->already_complained);
	 s->already_complained=true;
      }
   }
   temp =
      SplinePointListTransform(SplinePointListCopy
			       (s->sc_rpl.layers[ly_fore].splines), transform,
			       tpt_AllPoints);
   if (sc->layers[layer].splines==NULL)
      sc->layers[layer].splines=temp;
   else {
      for (spl=sc->layers[layer].splines; spl->next != NULL;
	   spl=spl->next);
      spl->next=temp;
      for (; temp != NULL; temp=temp->next) {
	 for (sp=temp->first;;) {
	    sp->selected=true;
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (sp==temp->first)
	       break;
	 }
      }
   }
}

/* ************************************************************************** */

static void SVResetPaths(SearchData * sv) {
   SplineSet *spl;

   /* Only do a sub pattern search if we have a single path and it is open */
   /*  and there is either no replace pattern, or it is also a single open */
   /*  path */
   sv->subpatternsearch=sv->path != NULL && sv->path->next==NULL &&
      sv->path->first->prev==NULL
      && sv->sc_srch.layers[ly_fore].refs==NULL;
   if (sv->replacepath != NULL
       && (sv->replacepath->next != NULL
	   || sv->replacepath->first->prev != NULL))
      sv->subpatternsearch=false;
   else if (sv->sc_rpl.layers[ly_fore].refs != NULL)
      sv->subpatternsearch=false;

   if (sv->subpatternsearch) {
      int i;
      SplinePoint *sp;

      for (sp=sv->path->first, i=0;;) {
	 ++i;
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
      }
      sv->pointcnt=i;
      if (sv->replacepath != NULL) {
	 for (sp=sv->replacepath->first, i=0;;) {
	    ++i;
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	 }
	 sv->rpointcnt=i;
      }
   }
}

static void SplinePointsUntick(SplineSet *spl) {
   SplinePoint *sp;

   while (spl != NULL) {
      for (sp=spl->first;;) {
	 sp->ticked=false;
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==spl->first)
	    break;
      }
      spl=spl->next;
   }
}

void SCSplinePointsUntick(SplineChar * sc, int layer) {
   SplinePointsUntick(sc->layers[layer].splines);
}

static int SearchChar(SearchData * sv, int gid, int startafter) {

   sv->curchar=sv->fv->sf->glyphs[gid];

   sv->matched_rot=0;
   sv->matched_scale=1;
   sv->matched_co=1;
   sv->matched_si=0;
   sv->matched_flip=flip_none;
   sv->matched_refs=sv->matched_ss=0;
   sv->matched_x=sv->matched_y=0;

   if (sv->subpatternsearch)
      return (SCMatchesIncomplete(sv->curchar, sv, startafter));
   else
      return (SCMatchesFull(sv->curchar, sv));
}

static int DoRpl(SearchData * sv) {
   RefChar *r;
   int layer=sv->fv->active_layer;

   /* Make sure we don't generate any self referential characters... */
   for (r=sv->sc_rpl.layers[ly_fore].refs; r != NULL; r=r->next) {
      if (SCDependsOnSC(r->sc, sv->curchar))
	 return (false);
   }

   if (!sv->subpatternsearch &&
       HeuristiclyBadMatch(sv->curchar, sv))
      return (false);

   SCPreserveLayer(sv->curchar, layer, false);
   if (sv->subpatternsearch)
      DoReplaceIncomplete(sv->curchar, sv);
   else
      DoReplaceFull(sv->curchar, sv);
   SCCharChangedUpdate(sv->curchar, layer, true);
   return (true);
}

static int _DoFindAll(SearchData * sv) {
   int i, any=0, gid;
   SplineChar *startcur=sv->curchar;

   for (i=0; i < sv->fv->map->enccount; ++i) {
      if ((gid=sv->fv->map->map[i]) != -1
	  && sv->fv->sf->glyphs[gid] != NULL) {
	 SCSplinePointsUntick(sv->fv->sf->glyphs[gid], sv->fv->active_layer);
	 if ((sv->fv->selected[i]=SearchChar(sv, gid, false))) {
	    any=true;
	    do {
	       if (!DoRpl(sv))
		 break;
	    } while (SearchChar(sv, gid, true));
	 }
      } else
	 sv->fv->selected[i]=false;
   }
   sv->curchar=startcur;
   return (any);
}

static void SDDestroy(SearchData * sv) {
   int i;

   if (sv==NULL)
      return;

   SCClearContents(&sv->sc_srch, ly_fore);
   SCClearContents(&sv->sc_rpl, ly_fore);
   for (i=0; i < sv->sc_srch.layer_cnt; ++i)
      UndoesFree(sv->sc_srch.layers[i].undoes);
   for (i=0; i < sv->sc_rpl.layer_cnt; ++i)
      UndoesFree(sv->sc_rpl.layers[i].undoes);
   free(sv->sc_srch.layers);
   free(sv->sc_rpl.layers);
   SplinePointListsFree(sv->revpath);
}

static SearchData *SDFillup(SearchData * sv, FontViewBase * fv) {

   sv->sc_srch.orig_pos=0;
   sv->sc_srch.unicodeenc=-1;
   sv->sc_srch.name="Search";
   sv->sc_rpl.orig_pos=1;
   sv->sc_rpl.unicodeenc=-1;
   sv->sc_rpl.name="Replace";
   sv->sc_srch.layer_cnt=sv->sc_rpl.layer_cnt=2;
   sv->sc_srch.layers=calloc(2, sizeof(Layer));
   sv->sc_rpl.layers=calloc(2, sizeof(Layer));
   LayerDefault(&sv->sc_srch.layers[0]);
   LayerDefault(&sv->sc_srch.layers[1]);
   LayerDefault(&sv->sc_rpl.layers[0]);
   LayerDefault(&sv->sc_rpl.layers[1]);

   sv->fv=fv;
   return (sv);
}

static int IsASingleReferenceOrEmpty(SplineChar *sc,int layer) {
   int i, empty=true, last, first;

   if (sc->parent->multilayer) {
      first=ly_fore;
      last=sc->layer_cnt - 1;
   } else
      first=last=layer;
   for (i=first; i <= last; ++i) {
      if (sc->layers[i].splines != NULL)
	 return (false);
      if (sc->layers[i].images != NULL)
	 return (false);
      if (sc->layers[i].refs != NULL) {
	 if (!empty)
	    return (false);
	 if (sc->layers[i].refs->next != NULL)
	    return (false);
	 empty=false;
      }
   }

   return (true);
}

static void SDCopyToSC(SplineChar *checksc,SplineChar *into,
		       enum fvcopy_type full) {
   int i;
   RefChar *ref;

   for (i=0; i < into->layer_cnt; ++i) {
      SplinePointListsFree(into->layers[i].splines);
      RefCharsFree(into->layers[i].refs);
      into->layers[i].splines=NULL;
      into->layers[i].refs=NULL;
   }
   if (full==ct_fullcopy) {
      into->layers[ly_fore].splines =
	 SplinePointListCopy(checksc->layers[ly_fore].splines);
      into->layers[ly_fore].refs=RefCharsCopyState(checksc, ly_fore);
   } else {
      into->layers[ly_fore].refs=ref=RefCharCreate();
      ref->unicode_enc=checksc->unicodeenc;
      ref->orig_pos=checksc->orig_pos;
      ref->adobe_enc=getAdobeEnc(checksc->name);
      ref->transform[0]=ref->transform[3]=1.0;
      ref->sc=checksc;
   }
   /* This is used to fill up the search/rpl patterns, which can't have */
   /*  instructions, so I don't bother to check for instructions out of */
   /*  date */
}

void FVBReplaceOutlineWithReference(FontViewBase * fv, double fudge) {
   SearchData *sv;
   uint8_t *selected, *changed;
   SplineFont *sf=fv->sf;
   int i, j, selcnt=0, gid;
   SplineChar *checksc;

   sv=SDFillup(calloc(1, sizeof(SearchData)), fv);
   sv->fudge_percent=.001;
   sv->fudge=fudge;

   selected=malloc(fv->map->enccount);
   memcpy(selected, fv->selected, fv->map->enccount);
   changed=calloc(fv->map->enccount, 1);

   selcnt=0;
   for (i=0; i < fv->map->enccount; ++i)
      if (selected[i] && (gid=fv->map->map[i]) != -1 &&
	  sf->glyphs[gid] != NULL)
	 ++selcnt;

   for (i=0; i < fv->map->enccount; ++i)
      if (selected[i] && (gid=fv->map->map[i]) != -1 &&
	  (checksc=sf->glyphs[gid]) != NULL) {
	 if (IsASingleReferenceOrEmpty(sf->glyphs[gid], fv->active_layer))
	    continue;		/* No point in replacing something which is itself a ref with a ref to a ref */
	 memset(fv->selected, 0, fv->map->enccount);
	 SDCopyToSC(checksc, &sv->sc_srch, ct_fullcopy);
	 SDCopyToSC(checksc, &sv->sc_rpl, ct_reference);
	 SVResetPaths(sv);
	 if (!_DoFindAll(sv) && selcnt==1)
	    ErrorMsg(2,"The outlines of glyph %2$.30s were not found in the font %1$.60s\n",
                     sf->fontname,sf->glyphs[gid]->name);
	 for (j=0; j < fv->map->enccount; ++j)
	    if (fv->selected[j])
	       changed[j]=1;
      }

   SDDestroy(sv);
   free(sv);

   free(selected);
   memcpy(fv->selected, changed, fv->map->enccount);
   free(changed);
}
