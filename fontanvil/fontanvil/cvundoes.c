/* $Id: cvundoes.c 3326 2014-09-29 07:28:28Z mskala $ */
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
#include "fontanvilvw.h"
#include "views.h"
#include <math.h>
#include <ustring.h>
#include <utype.h>
#include "gfile.h"

#if defined(__MINGW32__)||defined(__CYGWIN__)
// no backtrace on windows yet
#else
#   include <execinfo.h>
#endif
/* #include "collabclient.h" */

extern char *coord_sep;

int onlycopydisplayed = 0;

int copymetadata = 0;

int copyttfinstr = 0;

static void *UHintCopy(SplineChar * sc, int docopy);

static void ExtractHints(SplineChar * sc, void *hints, int docopy);

static void UndoesFreeButRetainFirstN(Undoes ** undopp, int retainAmount);

/* ********************************* Undoes ********************************* */

int maxundoes = 120;		/* -1 is infinite */

int preserve_hint_undoes = true;

static uint8 *bmpcopy(uint8 * bitmap, int bytes_per_line, int lines) {
   uint8 *ret = malloc(bytes_per_line * lines);

   memcpy(ret, bitmap, bytes_per_line * lines);
   return (ret);
}

RefChar *RefCharsCopyState(SplineChar * sc, int layer) {
   RefChar *head = NULL, *last = NULL, *new, *crefs;

   if (layer < 0 || sc->layers[layer].refs == NULL)
      return (NULL);
   for (crefs = sc->layers[layer].refs; crefs != NULL; crefs = crefs->next) {
      new = RefCharCreate();
      free(new->layers);
      *new = *crefs;
      new->layers = calloc(new->layer_cnt, sizeof(struct reflayer));
      new->next = NULL;
      if (last == NULL)
	 head = last = new;
      else {
	 last->next = new;
	 last = new;
      }
   }
   return (head);
}

static SplinePointList *RefCharsCopyUnlinked(SplinePointList * sofar,
					     SplineChar * sc, int layer) {
   RefChar *crefs;

   SplinePointList *last = NULL, *new;

   int l;

   if (layer < 0 || sc->layers[layer].refs == NULL)
      return (sofar);
   if (sofar != NULL)
      for (last = sofar; last->next != NULL; last = last->next);
   for (crefs = sc->layers[layer].refs; crefs != NULL; crefs = crefs->next) {
      for (l = 0; l < crefs->layer_cnt; ++l) {
	 new = SplinePointListCopy(crefs->layers[l].splines);
	 if (sofar != NULL) {
	    last->next = new;
	    for (; last->next != NULL; last = last->next);
	 } else {
	    sofar = new;
	    if (new != NULL)
	       for (last = sofar; last->next != NULL; last = last->next);
	 }
      }
   }
   return (sofar);
}

static int RefCharsMatch(RefChar * urefs, RefChar * crefs) {
   /* I assume they are in the same order */
   while (urefs != NULL && crefs != NULL) {
      if (urefs->sc != crefs->sc ||
	  urefs->transform[0] != crefs->transform[0] ||
	  urefs->transform[1] != crefs->transform[1] ||
	  urefs->transform[2] != crefs->transform[2] ||
	  urefs->transform[3] != crefs->transform[3] ||
	  urefs->transform[4] != crefs->transform[4] ||
	  urefs->transform[5] != crefs->transform[5])
	 return (false);
      urefs = urefs->next;
      crefs = crefs->next;
   }
   if (urefs == NULL && crefs == NULL)
      return (true);

   return (false);
}

static int ImagesMatch(ImageList * uimgs, ImageList * cimgs) {
   /* I assume they are in the same order */
   while (uimgs != NULL && cimgs != NULL) {
      if (uimgs->image != cimgs->image ||
	  uimgs->xoff != cimgs->xoff ||
	  uimgs->yoff != cimgs->yoff ||
	  uimgs->xscale != cimgs->xscale || uimgs->yscale != cimgs->yscale)
	 return (false);
      uimgs = uimgs->next;
      cimgs = cimgs->next;
   }
   if (uimgs == NULL && cimgs == NULL)
      return (true);

   return (false);
}

static RefChar *RefCharInList(RefChar * search, RefChar * list) {
   while (list != NULL) {
      if (search->sc == list->sc &&
	  search->transform[0] == list->transform[0] &&
	  search->transform[1] == list->transform[1] &&
	  search->transform[2] == list->transform[2] &&
	  search->transform[3] == list->transform[3] &&
	  search->transform[4] == list->transform[4] &&
	  search->transform[5] == list->transform[5])
	 return (list);
      list = list->next;
   }
   return (NULL);
}

static ImageList *ImageInList(ImageList * search, ImageList * list) {
   while (list != NULL) {
      if (search->image != list->image ||
	  search->xoff != list->xoff ||
	  search->yoff != list->yoff ||
	  search->xscale != list->xscale || search->yscale != list->yscale)
	 return (list);
      list = list->next;
   }
   return (NULL);
}

static void FixupRefChars(SplineChar * sc, RefChar * urefs, int layer) {
   RefChar *crefs, *cend, *cprev, *unext, *cnext;

   if (layer == ly_grid)
      return;

   crefs = sc->layers[layer].refs;

   cprev = NULL;
   while (crefs != NULL && urefs != NULL) {
      if (urefs->sc == crefs->sc &&
	  urefs->transform[0] == crefs->transform[0] &&
	  urefs->transform[1] == crefs->transform[1] &&
	  urefs->transform[2] == crefs->transform[2] &&
	  urefs->transform[3] == crefs->transform[3] &&
	  urefs->transform[4] == crefs->transform[4] &&
	  urefs->transform[5] == crefs->transform[5]) {
	 unext = urefs->next;
	 crefs->selected = urefs->selected;
	 RefCharFree(urefs);
	 urefs = unext;
	 cprev = crefs;
	 crefs = crefs->next;
      } else if ((cend = RefCharInList(urefs, crefs->next)) != NULL) {
	 /* if the undo refchar matches something further down the char's */
	 /*  ref list, then than means we need to delete everything on the */
	 /*  char's list between the two */
	 while (crefs != cend) {
	    cnext = crefs->next;
	    SCRemoveDependent(sc, crefs, layer);
	    crefs = cnext;
	 }
      } else {			/* urefs isn't on the list. Add it here */
	 unext = urefs->next;
	 urefs->next = crefs;
	 if (cprev == NULL)
	    sc->layers[layer].refs = urefs;
	 else
	    cprev->next = urefs;
	 cprev = urefs;
	 SCReinstanciateRefChar(sc, urefs, layer);
	 SCMakeDependent(sc, urefs->sc);
	 urefs = unext;
      }
   }
   if (crefs != NULL) {
      while (crefs != NULL) {
	 cnext = crefs->next;
	 SCRemoveDependent(sc, crefs, layer);
	 crefs = cnext;
      }
   } else if (urefs != NULL) {
      if (cprev == NULL)
	 sc->layers[layer].refs = urefs;
      else
	 cprev->next = urefs;
      while (urefs != NULL) {
	 SCReinstanciateRefChar(sc, urefs, layer);
	 SCMakeDependent(sc, urefs->sc);
	 urefs = urefs->next;
      }
   }
}

static int BDFRefCharsMatch(BDFRefChar * urefs, BDFRefChar * crefs) {
   /* I assume they are in the same order */
   while (urefs != NULL && crefs != NULL) {
      if (urefs->bdfc != crefs->bdfc ||
	  urefs->xoff != crefs->xoff || urefs->yoff != crefs->yoff)
	 return (false);
      urefs = urefs->next;
      crefs = crefs->next;
   }
   if (urefs == NULL && crefs == NULL)
      return (true);

   return (false);
}

static BDFRefChar *BDFRefCharInList(BDFRefChar * search, BDFRefChar * list) {
   while (list != NULL) {
      if (search->bdfc == list->bdfc &&
	  search->xoff == list->xoff && search->yoff == list->yoff)
	 return (list);
      list = list->next;
   }
   return (NULL);
}

static void FixupBDFRefChars(BDFChar * bc, BDFRefChar * urefs) {
   BDFRefChar *crefs, *cend, *cprev, *unext, *cnext;

   crefs = bc->refs;
   cprev = NULL;
   while (crefs != NULL && urefs != NULL) {
      if (urefs->bdfc == crefs->bdfc &&
	  urefs->xoff == crefs->xoff && urefs->yoff == crefs->yoff) {
	 unext = urefs->next;
	 crefs->selected = urefs->selected;
	 free(urefs);
	 urefs = unext;
	 cprev = crefs;
	 crefs = crefs->next;
      } else if ((cend = BDFRefCharInList(urefs, crefs->next)) != NULL) {
	 /* if the undo refchar matches something further down the char's */
	 /*  ref list, then that means we need to delete everything on the */
	 /*  char's list between the two */
	 while (crefs != cend) {
	    cnext = crefs->next;
	    BCRemoveDependent(bc, crefs);
	    crefs = cnext;
	 }
      } else {			/* urefs isn't on the list. Add it here */
	 unext = urefs->next;
	 urefs->next = crefs;
	 if (cprev == NULL)
	    bc->refs = urefs;
	 else
	    cprev->next = urefs;
	 cprev = urefs;
	 BCMakeDependent(bc, urefs->bdfc);
	 urefs = unext;
      }
   }
   if (crefs != NULL) {
      while (crefs != NULL) {
	 cnext = crefs->next;
	 BCRemoveDependent(bc, crefs);
	 crefs = cnext;
      }
   } else if (urefs != NULL) {
      if (cprev == NULL)
	 bc->refs = urefs;
      else
	 cprev->next = urefs;
      while (urefs != NULL) {
	 BCMakeDependent(bc, urefs->bdfc);
	 urefs = urefs->next;
      }
   }
}

static void FixupImages(SplineChar * sc, ImageList * uimgs, int layer) {
   ImageList *cimgs =
      layer == -1 ? sc->parent->grid.images : sc->layers[layer].images, *cend,
      *cprev, *unext, *cnext;

   cprev = NULL;
   while (cimgs != NULL && uimgs != NULL) {
      if (uimgs->image == cimgs->image &&
	  uimgs->xoff == cimgs->xoff &&
	  uimgs->yoff == cimgs->yoff &&
	  uimgs->xscale == cimgs->xscale && uimgs->yscale == cimgs->yscale) {
	 unext = uimgs->next;
	 cimgs->selected = uimgs->selected;
	 free(uimgs);
	 uimgs = unext;
	 cprev = cimgs;
	 cimgs = cimgs->next;
      } else if ((cend = ImageInList(uimgs, cimgs->next)) != NULL) {
	 /* if the undo image matches something further down the char's */
	 /*  img list, then than means we need to delete everything on the */
	 /*  char's list between the two */
	 if (cprev == NULL)
	    sc->layers[layer].images = cend;
	 else
	    cprev->next = cend;
	 while (cimgs != cend) {
	    cnext = cimgs->next;
	    free(cimgs);
	    cimgs = cnext;
	 }
      } else {			/* uimgs isn't on the list. Add it here */
	 unext = uimgs->next;
	 uimgs->next = cimgs;
	 if (cprev == NULL)
	    sc->layers[layer].images = uimgs;
	 else
	    cprev->next = uimgs;
	 cprev = uimgs;
	 uimgs = unext;
      }
   }
   if (cimgs != NULL) {
      ImageListsFree(cimgs);
      if (cprev == NULL)
	 sc->layers[layer].images = NULL;
      else
	 cprev->next = NULL;
   } else if (uimgs != NULL) {
      if (cprev == NULL)
	 sc->layers[layer].images = uimgs;
      else
	 cprev->next = uimgs;
   }
}

static void UHintListFree(void *hints) {
   StemInfo *h, *t, *p;

   if (hints == NULL)
      return;
   if (((StemInfo *) hints)->hinttype == ht_d)
      DStemInfosFree(hints);
   else {
      h = t = hints;
      p = NULL;
      while (t != NULL && t->hinttype != ht_d) {
	 p = t;
	 t = t->next;
      }
      p->next = NULL;
      StemInfosFree(h);
      DStemInfosFree((DStemInfo *) t);
   }
}

static void *UHintCopy(SplineChar * sc, int docopy) {
   StemInfo *h = sc->hstem, *v = sc->vstem, *last = NULL;

   DStemInfo *d = sc->dstem;

   void *ret = NULL;

   if (docopy) {
      h = StemInfoCopy(h);
      v = StemInfoCopy(v);
      d = DStemInfoCopy(d);
   } else {
      sc->hstem = NULL;
      sc->vstem = NULL;
      sc->dstem = NULL;
      sc->hconflicts = sc->vconflicts = false;
   }
   ret = h;
   if (h != NULL) {
      h->hinttype = ht_h;
      for (last = h; last->next != NULL; last = last->next)
	 last->next->hinttype = ht_unspecified;
      last->next = v;
   } else
      ret = v;
   if (v != NULL) {
      v->hinttype = ht_v;
      for (last = v; last->next != NULL; last = last->next)
	 last->next->hinttype = ht_unspecified;
   }
   if (last != NULL)
      last->next = (StemInfo *) d;
   else
      ret = d;
   if (d != NULL) {
      d->hinttype = ht_d;
      for (d = d->next; d != NULL; d = d->next)
	 d->hinttype = ht_unspecified;
   }
   return (ret);
}

static void ExtractHints(SplineChar * sc, void *hints, int docopy) {
   StemInfo *h = NULL, *v = NULL, *p;

   DStemInfo *d = NULL;

   StemInfo *pv = NULL, *pd = NULL;

   p = NULL;
   while (hints != NULL) {
      if (((StemInfo *) hints)->hinttype == ht_h)
	 h = hints;
      else if (((StemInfo *) hints)->hinttype == ht_v) {
	 v = hints;
	 pv = p;
      } else if (((StemInfo *) hints)->hinttype == ht_d) {
	 d = hints;
	 pd = p;
	 break;
      }
      p = hints;
      hints = ((StemInfo *) hints)->next;
   }

   if (pv != NULL)
      pv->next = NULL;
   if (pd != NULL)
      pd->next = NULL;
   if (docopy) {
      h = StemInfoCopy(h);
      if (pv != NULL)
	 pv->next = v;
      v = StemInfoCopy(v);
      if (pd != NULL)
	 pd->next = (StemInfo *) d;
      d = DStemInfoCopy(d);
   }

   StemInfosFree(sc->hstem);
   StemInfosFree(sc->vstem);
   DStemInfosFree(sc->dstem);
   sc->hstem = h;
   sc->vstem = v;
   sc->dstem = d;
   sc->hconflicts = StemInfoAnyOverlaps(h);
   sc->vconflicts = StemInfoAnyOverlaps(v);
}

static void UndoesFreeButRetainFirstN(Undoes ** undopp, int retainAmount) {
   if (!undopp || !*undopp)
      return;
   Undoes *undo = *undopp;

   // wipe them all will change the list header pointer too
   if (!retainAmount) {
      UndoesFree(undo);
      *undopp = 0;
      return;
   }

   Undoes *undoprev = undo;

   for (; retainAmount > 0 && undo; retainAmount--) {
      undoprev = undo;
      undo = undo->next;
   }
   // not enough items to need to do a trim.
   if (retainAmount > 0)
      return;

   // break off and free the tail
   UndoesFree(undo);
   undoprev->next = 0;
}


void UndoesFree(Undoes * undo) {
   Undoes *unext;

   BDFRefChar *head, *next;

   while (undo != NULL) {
      unext = undo->next;
      switch (undo->undotype) {
	case ut_noop:
	case ut_width:
	case ut_vwidth:
	case ut_lbearing:
	case ut_rbearing:
	   /* Nothing else to free */ ;
	   break;
	case ut_state:
	case ut_tstate:
	case ut_statehint:
	case ut_statename:
	case ut_hints:
	case ut_anchors:
	case ut_statelookup:
	   SplinePointListsFree(undo->u.state.splines);
	   RefCharsFree(undo->u.state.refs);
	   UHintListFree(undo->u.state.hints);
	   free(undo->u.state.instrs);
	   ImageListsFree(undo->u.state.images);
	   if (undo->undotype == ut_statename) {
	      free(undo->u.state.charname);
	      free(undo->u.state.comment);
	      PSTFree(undo->u.state.possub);
	   }
	   AnchorPointsFree(undo->u.state.anchor);
	   GradientFree(undo->u.state.fill_brush.gradient);
	   PatternFree(undo->u.state.fill_brush.pattern);
	   GradientFree(undo->u.state.stroke_pen.brush.gradient);
	   PatternFree(undo->u.state.stroke_pen.brush.pattern);
	   break;
	case ut_bitmap:
	   for (head = undo->u.bmpstate.refs; head != NULL;) {
	      next = head->next;
	      free(head);
	      head = next;
	   }
	   free(undo->u.bmpstate.bitmap);
	   BDFFloatFree(undo->u.bmpstate.selection);
	   break;
	case ut_multiple:
	case ut_layers:
	   UndoesFree(undo->u.multiple.mult);
	   break;
	case ut_composit:
	   UndoesFree(undo->u.composit.state);
	   UndoesFree(undo->u.composit.bitmaps);
	   break;
	default:
	   IError("Unknown undo type in UndoesFree: %d", undo->undotype);
	   break;
      }
      chunkfree(undo, sizeof(Undoes));
      undo = unext;
   }
}

static Undoes *AddUndo(Undoes * undo, Undoes ** uhead, Undoes ** rhead) {
   int ucnt;

   Undoes *u, *prev;

   UndoesFree(*rhead);
   *rhead = NULL;
   if (maxundoes == 0)
      maxundoes = 1;		/* Must be at least one or snap to breaks */
   if (maxundoes > 0) {
      ucnt = 0;
      prev = NULL;
      for (u = *uhead; u != NULL; u = u->next) {
	 if (++ucnt >= maxundoes)
	    break;
	 prev = u;
      }
      if (u != NULL) {
	 UndoesFree(u);
	 if (prev != NULL)
	    prev->next = NULL;
	 else
	    *uhead = NULL;
      }
   }
   undo->next = *uhead;
   *uhead = undo;

   return (undo);
}

static Undoes *CVAddUndo(CharViewBase * cv, Undoes * undo) {

   Undoes *ret = AddUndo(undo,
			 &cv->layerheads[cv->drawmode]->undoes,
			 &cv->layerheads[cv->drawmode]->redoes);

   /* Let collab system know that a new undo state */
   /* was pushed now since it last sent a message. */
/*    collabclient_CVPreserveStateCalled( cv ); */
   return (ret);
}

int CVLayer(CharViewBase * cv) {
   if (cv->drawmode == dm_grid)
      return (ly_grid);

   return (cv->layerheads[cv->drawmode] - cv->sc->layers);
}

/* This routine does not allow for undoes in scripting */
Undoes *SCPreserveLayer(SplineChar * sc, int layer, int dohints) {

      return (NULL);
}


Undoes *SCPreserveState(SplineChar * sc, int dohints) {
   int i;

   if (sc->parent->multilayer)
      for (i = ly_fore + 1; i < sc->layer_cnt; ++i)
	 SCPreserveLayer(sc, i, false);

   Undoes *ret = SCPreserveLayer(sc, ly_fore, dohints);

/*     collabclient_SCPreserveStateCalled( sc ); */
   return (ret);
}

Undoes *SCPreserveBackground(SplineChar * sc) {
   return (SCPreserveLayer(sc, ly_back, false));
}

Undoes *SFPreserveGuide(SplineFont * sf) {
      return (NULL);
}

void SCUndoSetLBearingChange(SplineChar * sc, int lbc) {
   Undoes *undo = sc->layers[ly_fore].undoes;

   if (undo == NULL || undo->undotype != ut_state)
      return;
   undo->u.state.lbearingchange = lbc;
}

Undoes *SCPreserveWidth(SplineChar * sc) {
   Undoes *undo;

      return (NULL);
}

Undoes *SCPreserveVWidth(SplineChar * sc) {
   Undoes *undo;

      return (NULL);
}

Undoes *BCPreserveState(BDFChar * bc) {
      return (NULL);
}

static void SCUndoAct(SplineChar * sc, int layer, Undoes * undo) {

   switch (undo->undotype) {
     case ut_noop:
	break;
     case ut_width:{
	   int width = sc->width;

	   if (sc->width != undo->u.width)
	      SCSynchronizeWidth(sc, undo->u.width, width, NULL);
	   undo->u.width = width;
	}
	break;
     case ut_vwidth:{
	   int vwidth = sc->vwidth;

	   sc->vwidth = undo->u.width;
	   undo->u.width = vwidth;
	} break;
     case ut_hints:{
	   void *hints = UHintCopy(sc, false);

	   uint8 *instrs = sc->ttf_instrs;

	   int instrs_len = sc->ttf_instrs_len;

	   ExtractHints(sc, undo->u.state.hints, false);
	   sc->ttf_instrs = undo->u.state.instrs;
	   sc->ttf_instrs_len = undo->u.state.instrs_len;
	   undo->u.state.hints = hints;
	   undo->u.state.instrs = instrs;
	   undo->u.state.instrs_len = instrs_len;
	} break;
     case ut_state:
     case ut_tstate:
     case ut_statehint:
     case ut_statename:{
	   Layer *head =
	      layer == ly_grid ? &sc->parent->grid : &sc->layers[layer];
	   SplinePointList *spl = head->splines;

	   if (layer == ly_fore) {
	      int width = sc->width;

	      int vwidth = sc->vwidth;

	      if (sc->width != undo->u.state.width)
		 SCSynchronizeWidth(sc, undo->u.state.width, width, NULL);
	      sc->vwidth = undo->u.state.vwidth;
	      undo->u.state.width = width;
	      undo->u.state.vwidth = vwidth;
	   }
	   head->splines = undo->u.state.splines;
	   if (layer == ly_fore) {
	      AnchorPoint *ap = sc->anchor;

	      sc->anchor = undo->u.state.anchor;
	      undo->u.state.anchor = ap;
	   }
	   if (layer != ly_grid
	       && !RefCharsMatch(undo->u.state.refs, head->refs)) {
	      RefChar *refs = RefCharsCopyState(sc, layer);

	      FixupRefChars(sc, undo->u.state.refs, layer);
	      undo->u.state.refs = refs;
	   }
	   if (layer == ly_fore &&
	       (undo->undotype == ut_statehint
		|| undo->undotype == ut_statename)) {
	      void *hints = UHintCopy(sc, false);

	      uint8 *instrs = sc->ttf_instrs;

	      int instrs_len = sc->ttf_instrs_len;

	      ExtractHints(sc, undo->u.state.hints, false);
	      sc->ttf_instrs = undo->u.state.instrs;
	      sc->ttf_instrs_len = undo->u.state.instrs_len;
	      undo->u.state.hints = hints;
	      undo->u.state.instrs = instrs;
	      undo->u.state.instrs_len = instrs_len;
	   }
	   if (!ImagesMatch(undo->u.state.images, head->images)) {
	      ImageList *images = ImageListCopy(head->images);

	      FixupImages(sc, undo->u.state.images, layer);
	      undo->u.state.images = images;
	   }
	   undo->u.state.splines = spl;
	   if (undo->u.state.lbearingchange) {
	      undo->u.state.lbearingchange = -undo->u.state.lbearingchange;
	      SCSynchronizeLBearing(sc, undo->u.state.lbearingchange, layer);
	   }
	   if (layer == ly_fore && undo->undotype == ut_statename) {
	      char *temp = sc->name;

	      int uni = sc->unicodeenc;

	      PST *possub = sc->possub;

	      char *comment = sc->comment;

	      sc->name = undo->u.state.charname;
	      undo->u.state.charname = temp;
	      sc->unicodeenc = undo->u.state.unicodeenc;
	      undo->u.state.unicodeenc = uni;
	      sc->possub = undo->u.state.possub;
	      undo->u.state.possub = possub;
	      sc->comment = undo->u.state.comment;
	      undo->u.state.comment = comment;
	   }
	} break;
     default:
	IError("Unknown undo type in SCUndoAct: %d", undo->undotype);
	break;
   }
}

void SCDoUndo(SplineChar * sc, int layer) {
   Undoes *undo = sc->layers[layer].undoes;

   if (undo == NULL)		/* Shouldn't happen */
      return;
   sc->layers[layer].undoes = undo->next;
   undo->next = NULL;
   SCUndoAct(sc, layer, undo);
   undo->next = sc->layers[layer].redoes;
   sc->layers[layer].redoes = undo;
   SCCharChangedUpdate(sc, layer, undo->was_modified);
   return;
}

static void BCUndoAct(BDFChar * bc, Undoes * undo) {
   uint8 *b;

   int temp;

   BDFFloat *sel;

   BDFRefChar *ref, *head, *prev = NULL, *uhead = NULL;

   switch (undo->undotype) {
     case ut_bitmap:{
	   temp = bc->width;
	   bc->width = undo->u.bmpstate.width;
	   undo->u.bmpstate.width = temp;
	   temp = bc->xmin;
	   bc->xmin = undo->u.bmpstate.xmin;
	   undo->u.bmpstate.xmin = temp;
	   temp = bc->xmax;
	   bc->xmax = undo->u.bmpstate.xmax;
	   undo->u.bmpstate.xmax = temp;
	   temp = bc->ymin;
	   bc->ymin = undo->u.bmpstate.ymin;
	   undo->u.bmpstate.ymin = temp;
	   temp = bc->ymax;
	   bc->ymax = undo->u.bmpstate.ymax;
	   undo->u.bmpstate.ymax = temp;
	   temp = bc->bytes_per_line;
	   bc->bytes_per_line = undo->u.bmpstate.bytes_per_line;
	   undo->u.bmpstate.bytes_per_line = temp;
	   b = bc->bitmap;
	   bc->bitmap = undo->u.bmpstate.bitmap;
	   undo->u.bmpstate.bitmap = b;
	   sel = bc->selection;
	   bc->selection = undo->u.bmpstate.selection;
	   undo->u.bmpstate.selection = sel;

	   if (!BDFRefCharsMatch(undo->u.bmpstate.refs, bc->refs)) {
	      for (head = bc->refs; head != NULL; head = head->next) {
		 ref = calloc(1, sizeof(BDFRefChar));
		 memcpy(ref, head, sizeof(BDFRefChar));
		 if (prev != NULL)
		    prev->next = ref;
		 else
		    uhead = ref;
		 prev = ref;
	      }
	      FixupBDFRefChars(bc, undo->u.bmpstate.refs);
	      undo->u.bmpstate.refs = uhead;
	   }
	}
	break;
     default:
	IError("Unknown undo type in BCUndoAct: %d", undo->undotype);
	break;
   }
}

/* **************************** Cut, Copy & Paste *************************** */

static Undoes copybuffer;

static void CopyBufferFree(void) {
   BDFRefChar *brhead, *brnext;

   switch (copybuffer.undotype) {
     case ut_hints:
	UHintListFree(copybuffer.u.state.hints);
	free(copybuffer.u.state.instrs);
	break;
     case ut_state:
     case ut_statehint:
     case ut_anchors:
     case ut_statelookup:
	SplinePointListsFree(copybuffer.u.state.splines);
	RefCharsFree(copybuffer.u.state.refs);
	AnchorPointsFree(copybuffer.u.state.anchor);
	UHintListFree(copybuffer.u.state.hints);
	free(copybuffer.u.state.instrs);
	ImageListsFree(copybuffer.u.state.images);
	GradientFree(copybuffer.u.state.fill_brush.gradient);
	PatternFree(copybuffer.u.state.fill_brush.pattern);
	GradientFree(copybuffer.u.state.stroke_pen.brush.gradient);
	PatternFree(copybuffer.u.state.stroke_pen.brush.pattern);
	break;
     case ut_bitmapsel:
	BDFFloatFree(copybuffer.u.bmpstate.selection);
	break;
     case ut_bitmap:
	for (brhead = copybuffer.u.bmpstate.refs; brhead != NULL;
	     brhead = brnext) {
	   brnext = brhead->next;
	   free(brhead);
	}
	free(copybuffer.u.bmpstate.bitmap);
	break;
     case ut_multiple:
     case ut_layers:
	UndoesFree(copybuffer.u.multiple.mult);
	break;
     case ut_composit:
	UndoesFree(copybuffer.u.composit.state);
	UndoesFree(copybuffer.u.composit.bitmaps);
	break;
   }
   memset(&copybuffer, '\0', sizeof(copybuffer));
   copybuffer.undotype = ut_none;
}

static void CopyBufferFreeGrab(void) {
   CopyBufferFree();
}

static void noop(void *_copybuffer) {
}

static void *copybufferPt2str(void *_copybuffer, int32 * len) {
   Undoes *cur = &copybuffer;

   SplinePoint *sp;

   char buffer[100];

   while (cur) {
      switch (cur->undotype) {
	case ut_multiple:
	   cur = cur->u.multiple.mult;
	   break;
	case ut_composit:
	   cur = cur->u.composit.state;
	   break;
	case ut_state:
	case ut_statehint:
	case ut_statename:
	case ut_statelookup:
	   goto out;
	default:
	   cur = NULL;
	   break;
      }
   }
 out:
   if (cur == NULL || FontViewFirst() == NULL ||
       cur->u.state.splines == NULL || cur->u.state.refs != NULL ||
       cur->u.state.splines->next != NULL ||
       cur->u.state.splines->first->next != NULL) {
      *len = 0;
      return (copy(""));
   }

   sp = cur->u.state.splines->first;
   sprintf(buffer, "(%g%s%g)", (double) sp->me.x, coord_sep,
	   (double) sp->me.y);
   *len = strlen(buffer);
   return (copy(buffer));
}

static void *copybufferName2str(void *_copybuffer, int32 * len) {
   Undoes *cur = &copybuffer;

   while (cur) {
      switch (cur->undotype) {
	case ut_multiple:
	   cur = cur->u.multiple.mult;
	   break;
	case ut_composit:
	   cur = cur->u.composit.state;
	   break;
	case ut_statename:
	   goto out;
	default:
	   cur = NULL;
	   break;
      }
   }
 out:
   if (cur == NULL || FontViewFirst() == NULL
       || cur->u.state.charname == NULL) {
      *len = 0;
      return (copy(""));
   }
   *len = strlen(cur->u.state.charname);
   return (copy(cur->u.state.charname));
}

static RefChar *XCopyInstanciateRefs(RefChar * refs, SplineChar * container,
				     int layer) {
   /* References in the copybuffer don't include the translated splines */
   RefChar *head = NULL, *last, *cur;

   while (refs != NULL) {
      cur = RefCharCreate();
      free(cur->layers);
      *cur = *refs;
      cur->layers = NULL;
      cur->layer_cnt = 0;
      cur->next = NULL;
      SCReinstanciateRefChar(container, cur, layer);
      if (head == NULL)
	 head = cur;
      else
	 last->next = cur;
      last = cur;
      refs = refs->next;
   }
   return (head);
}

#ifndef _NO_LIBXML
static int FFClipToSC(SplineChar * dummy, Undoes * cur) {
   int lcnt;

   if (cur == NULL)
      return (false);

   dummy->name = "dummy";
   if (cur->undotype != ut_layers)
      dummy->parent = cur->copied_from;
   else if (cur->u.multiple.mult != NULL
	    && cur->u.multiple.mult->undotype == ut_state)
      dummy->parent = cur->u.multiple.mult->copied_from;
   if (dummy->parent == NULL)
      dummy->parent = FontViewFirst()->sf;	/* Might not be right, but we need something */
   dummy->width = cur->u.state.width;
   if (cur->undotype == ut_layers) {
      Undoes *ulayer;

      for (ulayer = cur->u.multiple.mult, lcnt = 0; ulayer != NULL;
	   ulayer = ulayer->next, ++lcnt);
      dummy->layer_cnt = lcnt + 1;
      if (lcnt != 1)
	 dummy->layers = calloc((lcnt + 1), sizeof(Layer));
      for (ulayer = cur->u.multiple.mult, lcnt = 1; ulayer != NULL;
	   ulayer = ulayer->next, ++lcnt) {
	 if (ulayer->undotype == ut_state || ulayer->undotype == ut_statehint) {
	    dummy->layers[lcnt].fill_brush = ulayer->u.state.fill_brush;
	    dummy->layers[lcnt].stroke_pen = ulayer->u.state.stroke_pen;
	    dummy->layers[lcnt].dofill = ulayer->u.state.dofill;
	    dummy->layers[lcnt].dostroke = ulayer->u.state.dostroke;
	    dummy->layers[lcnt].splines = ulayer->u.state.splines;
	    dummy->layers[lcnt].refs =
	       XCopyInstanciateRefs(ulayer->u.state.refs, dummy, ly_fore);
	 }
      }
   } else {
      dummy->layers[ly_fore].fill_brush = cur->u.state.fill_brush;
      dummy->layers[ly_fore].stroke_pen = cur->u.state.stroke_pen;
      dummy->layers[ly_fore].dofill = cur->u.state.dofill;
      dummy->layers[ly_fore].dostroke = cur->u.state.dostroke;
      dummy->layers[ly_fore].splines = cur->u.state.splines;
      dummy->layers[ly_fore].refs =
	 XCopyInstanciateRefs(cur->u.state.refs, dummy, ly_fore);
   }
   return (true);
}

static void *copybuffer2svg(void *_copybuffer, int32 * len) {
   Undoes *cur = &copybuffer;

   SplineChar dummy;

   static Layer layers[2];

   FILE *svg;

   char *ret;

   int old_order2;

   int lcnt;

   while (cur) {
      switch (cur->undotype) {
	case ut_multiple:
	   cur = cur->u.multiple.mult;	/* will only handle one char in an "svg" file */
	   break;
	case ut_composit:
	   cur = cur->u.composit.state;
	   break;
	case ut_state:
	case ut_statehint:
	case ut_layers:
	case ut_statelookup:
	   goto out;
	default:
	   cur = NULL;
	   break;
      }
   }
 out:
   if (FontViewFirst() == NULL || cur == NULL) {
      *len = 0;
      return (copy(""));
   }

   svg = tmpfile();
   if (svg == NULL) {
      *len = 0;
      return (copy(""));
   }

   memset(&dummy, 0, sizeof(dummy));
   dummy.layers = layers;
   dummy.layer_cnt = 2;

   if (!FFClipToSC(&dummy, cur)) {
      fclose(svg);
      *len = 0;
      return (copy(""));
   }

   old_order2 = dummy.parent->layers[ly_fore].order2;
   dummy.parent->layers[ly_fore].order2 = cur->was_order2;
   dummy.layers[ly_fore].order2 = cur->was_order2;
   _ExportSVG(svg, &dummy, ly_fore);
   dummy.parent->layers[ly_fore].order2 = old_order2;

   for (lcnt = ly_fore; lcnt < dummy.layer_cnt; ++lcnt)
      RefCharsFree(dummy.layers[lcnt].refs);
   if (dummy.layer_cnt != 2)
      free(dummy.layers);

   fseek(svg, 0, SEEK_END);
   *len = ftell(svg);
   ret = malloc(*len);
   rewind(svg);
   fread(ret, 1, *len, svg);
   fclose(svg);
   return (ret);
}

/* When a selection contains multiple glyphs, save them into an svg font */
static void *copybuffer2svgmult(void *_copybuffer, int32 * len) {
   Undoes *cur = &copybuffer, *c, *c2;

   SplineFont *sf;

   int cnt, i;

   char *ret;

   Layer *ly;

   SplineChar *sc = NULL;

   int old_order2, o2 = false;

   FILE *svg;

   if (cur->undotype != ut_multiple || !CopyContainsVectors()
       || FontViewFirst() == NULL) {
      *len = 0;
      return (copy(""));
   }

   svg = tmpfile();
   if (svg == NULL) {
      *len = 0;
      return (copy(""));
   }

   cur = cur->u.multiple.mult;
   for (cnt = 0, c = cur; c != NULL; c = c->next, ++cnt);

   sf = SplineFontBlank(cnt);
   sf->glyphcnt = cnt;
   for (i = 0, c = cur; c != NULL; c = c->next, ++i) {
      sf->glyphs[i] = sc = SFSplineCharCreate(sf);
      sc->orig_pos = i;
      ly = sc->layers;
      if ((c2 = c)->undotype == ut_composit)
	 c2 = c2->u.composit.state;
      FFClipToSC(sc, c2);
      if (ly != sc->layers)
	 free(ly);
      o2 = c2->was_order2;
   }

   if (sc != NULL) {
      old_order2 = sc->parent->layers[ly_fore].order2;
      sc->parent->layers[ly_fore].order2 = o2;
      sc->layers[ly_fore].order2 = o2;
      sf->ascent = sc->parent->ascent;
      sf->descent = sc->parent->descent;
   }
   _WriteSVGFont(svg, sf, ff_svg, 0, NULL, ly_fore);
   if (sc != NULL)
      sc->parent->layers[ly_fore].order2 = old_order2;

   for (i = 0, c = cur; c != NULL; c = c->next, ++i) {
      sc = sf->glyphs[i];
      sc->layers[ly_fore].splines = NULL;
      sc->layers[ly_fore].refs = NULL;
      sc->name = NULL;
   }
   SplineFontFree(sf);

   fseek(svg, 0, SEEK_END);
   *len = ftell(svg);
   ret = malloc(*len);
   rewind(svg);
   fread(ret, 1, *len, svg);
   fclose(svg);
   return (ret);
}
#endif

static void *copybuffer2eps(void *_copybuffer, int32 * len) {
   Undoes *cur = &copybuffer;

   SplineChar dummy;

   static Layer layers[2];

   FILE *eps;

   char *ret;

   int old_order2;

   int lcnt;

   while (cur) {
      switch (cur->undotype) {
	case ut_multiple:
	   cur = cur->u.multiple.mult;	/* Can only handle one char in an "eps" file */
	   break;
	case ut_composit:
	   cur = cur->u.composit.state;
	   break;
	case ut_state:
	case ut_statehint:
	case ut_layers:
	case ut_statelookup:
	   goto out;
	default:
	   cur = NULL;
	   break;
      }
   }
 out:
   if (cur == NULL || FontViewFirst() == NULL) {
      *len = 0;
      return (copy(""));
   }

   memset(&dummy, 0, sizeof(dummy));
   dummy.layers = layers;
   dummy.layer_cnt = 2;
   dummy.name = "dummy";
   if (cur->undotype != ut_layers)
      dummy.parent = cur->copied_from;
   else if (cur->u.multiple.mult != NULL
	    && cur->u.multiple.mult->undotype == ut_state)
      dummy.parent = cur->u.multiple.mult->copied_from;
   if (dummy.parent == NULL)
      dummy.parent = FontViewFirst()->sf;	/* Might not be right, but we need something */
   if (cur->undotype == ut_layers) {
      Undoes *ulayer;

      for (ulayer = cur->u.multiple.mult, lcnt = 0; ulayer != NULL;
	   ulayer = ulayer->next, ++lcnt);
      dummy.layer_cnt = lcnt + 1;
      if (lcnt != 1)
	 dummy.layers = calloc((lcnt + 1), sizeof(Layer));
      for (ulayer = cur->u.multiple.mult, lcnt = 1; ulayer != NULL;
	   ulayer = ulayer->next, ++lcnt) {
	 if (ulayer->undotype == ut_state || ulayer->undotype == ut_statehint) {
	    dummy.layers[lcnt].fill_brush = ulayer->u.state.fill_brush;
	    dummy.layers[lcnt].stroke_pen = ulayer->u.state.stroke_pen;
	    dummy.layers[lcnt].dofill = ulayer->u.state.dofill;
	    dummy.layers[lcnt].dostroke = ulayer->u.state.dostroke;
	    dummy.layers[lcnt].splines = ulayer->u.state.splines;
	    dummy.layers[lcnt].refs =
	       XCopyInstanciateRefs(ulayer->u.state.refs, &dummy, ly_fore);
	 }
      }
   } else {
      dummy.layers[ly_fore].fill_brush = cur->u.state.fill_brush;
      dummy.layers[ly_fore].stroke_pen = cur->u.state.stroke_pen;
      dummy.layers[ly_fore].dofill = cur->u.state.dofill;
      dummy.layers[ly_fore].dostroke = cur->u.state.dostroke;
      dummy.layers[ly_fore].splines = cur->u.state.splines;
      dummy.layers[ly_fore].refs =
	 XCopyInstanciateRefs(cur->u.state.refs, &dummy, ly_fore);
   }

   eps = tmpfile();
   if (eps == NULL) {
      *len = 0;
      return (copy(""));
   }

   old_order2 = dummy.parent->layers[ly_fore].order2;
   dummy.parent->layers[ly_fore].order2 = cur->was_order2;
   dummy.layers[ly_fore].order2 = cur->was_order2;
   /* Don't bother to generate a preview here, that can take too long and */
   /*  cause the paster to time out */
   _ExportEPS(eps, &dummy, false, ly_fore);
   dummy.parent->layers[ly_fore].order2 = old_order2;

   for (lcnt = ly_fore; lcnt < dummy.layer_cnt; ++lcnt)
      RefCharsFree(dummy.layers[lcnt].refs);
   if (dummy.layer_cnt != 2)
      free(dummy.layers);

   fseek(eps, 0, SEEK_END);
   *len = ftell(eps);
   ret = malloc(*len);
   rewind(eps);
   fread(ret, 1, *len, eps);
   fclose(eps);
   return (ret);
}

static void XClipCheckEps(void) {
      return;
}

int CopyContainsVectors(void) {
   Undoes *cur = &copybuffer;

   if (cur->undotype == ut_multiple)
      cur = cur->u.multiple.mult;
   if (cur->undotype == ut_composit)
      return (cur->u.composit.state != NULL);

   return (cur->undotype == ut_state || cur->undotype == ut_statehint ||
	   cur->undotype == ut_statename || cur->undotype == ut_layers);
}

RefChar *CopyContainsRef(SplineFont * sf) {
   Undoes *cur = &copybuffer;

   if (cur->undotype == ut_multiple) {
      cur = cur->u.multiple.mult;
      if (cur->next != NULL)
	 return (NULL);
   }
   if (cur->undotype == ut_composit)
      cur = cur->u.composit.state;
   if (cur == NULL
       || (cur->undotype != ut_state && cur->undotype != ut_tstate
	   && cur->undotype != ut_statehint && cur->undotype != ut_statename))
      return (NULL);
   if (cur->u.state.splines != NULL || cur->u.state.refs == NULL ||
       cur->u.state.refs->next != NULL)
      return (NULL);
   if (sf != cur->copied_from)
      return (NULL);

   return (cur->u.state.refs);
}

const Undoes *CopyBufferGet(void) {
   return (&copybuffer);
}

static void _CopyBufferClearCopiedFrom(Undoes * cb, SplineFont * dying) {
   switch (cb->undotype) {
     case ut_noop:
	break;
     case ut_state:
     case ut_statehint:
     case ut_statename:
     case ut_statelookup:
	if (cb->copied_from == dying)
	   cb->copied_from = NULL;
	break;
     case ut_width:
     case ut_vwidth:
     case ut_rbearing:
     case ut_lbearing:
	break;
     case ut_composit:
	if (cb->copied_from == dying)
	   cb->copied_from = NULL;
	_CopyBufferClearCopiedFrom(cb->u.composit.state, dying);
	break;
     case ut_multiple:
     case ut_layers:
	if (cb->copied_from == dying)
	   cb->copied_from = NULL;
	for (cb = cb->u.multiple.mult; cb != NULL; cb = cb->next)
	   _CopyBufferClearCopiedFrom(cb, dying);
	break;
   }
}

void CopyBufferClearCopiedFrom(SplineFont * dying) {
   _CopyBufferClearCopiedFrom(&copybuffer, dying);
}

int getAdobeEnc(char *name) {
   extern char *AdobeStandardEncoding[256];

   int i;

   for (i = 0; i < 256; ++i)
      if (strcmp(name, AdobeStandardEncoding[i]) == 0)
	 break;
   if (i == 256)
      i = -1;
   return (i);
}

static Undoes *SCCopyAllLayer(SplineChar * sc, enum fvcopy_type full,
			      int layer) {
   Undoes *cur;

   RefChar *ref;

   extern int copymetadata, copyttfinstr;

   /* If full==ct_fullcopy copy the glyph as is. */
   /* If full==ct_reference put a reference to the glyph in the clipboard */
   /* If full==ct_unlinkrefs copy the glyph, but unlink any references it contains */
   /*  so we end up with no references and a bunch of splines */

   cur = chunkalloc(sizeof(Undoes));
   if (sc == NULL) {
      cur->undotype = ut_noop;
   } else {
      cur->was_order2 = sc->layers[ly_fore].order2;
      cur->u.state.width = sc->width;
      cur->u.state.vwidth = sc->vwidth;
      if (full == ct_fullcopy || full == ct_unlinkrefs) {
	 cur->undotype = copymetadata ? ut_statename : ut_statehint;
	 cur->u.state.splines =
	    SplinePointListCopy(sc->layers[layer].splines);
	 if (full == ct_unlinkrefs)
	    cur->u.state.splines =
	       RefCharsCopyUnlinked(cur->u.state.splines, sc, layer);
	 else
	    cur->u.state.refs = RefCharsCopyState(sc, layer);
	 cur->u.state.anchor = AnchorPointsCopy(sc->anchor);
	 cur->u.state.hints = UHintCopy(sc, true);
	 if (copyttfinstr) {
	    cur->u.state.instrs =
	       (uint8 *) copyn((char *) sc->ttf_instrs, sc->ttf_instrs_len);
	    cur->u.state.instrs_len = sc->ttf_instrs_len;
	 }
	 cur->u.state.unicodeenc = sc->unicodeenc;
	 if (copymetadata && layer == ly_fore) {
	    cur->u.state.charname = copy(sc->name);
	    cur->u.state.comment = copy(sc->comment);
	    cur->u.state.possub = PSTCopy(sc->possub, sc, NULL);
	 } else {
	    cur->u.state.charname = NULL;
	    cur->u.state.comment = NULL;
	    cur->u.state.possub = NULL;
	 }
      } else {			/* Or just make a reference */
	 cur->undotype = full == ct_reference ? ut_state : ut_statelookup;
	 cur->u.state.refs = ref = RefCharCreate();
	 ref->unicode_enc = sc->unicodeenc;
	 ref->orig_pos = sc->orig_pos;
	 ref->adobe_enc = getAdobeEnc(sc->name);
	 ref->transform[0] = ref->transform[3] = 1.0;
      }
      if (layer < sc->layer_cnt) {
	 cur->u.state.images = ImageListCopy(sc->layers[layer].images);
	 BrushCopy(&cur->u.state.fill_brush, &sc->layers[layer].fill_brush,
		   NULL);
	 PenCopy(&cur->u.state.stroke_pen, &sc->layers[layer].stroke_pen,
		 NULL);
	 cur->u.state.dofill = sc->layers[layer].dofill;
	 cur->u.state.dostroke = sc->layers[layer].dostroke;
	 cur->u.state.fillfirst = sc->layers[layer].fillfirst;
      }
      cur->copied_from = sc->parent;
   }
   return (cur);
}

static Undoes *SCCopyAll(SplineChar * sc, int layer, enum fvcopy_type full) {
   Undoes *ret, *cur, *last = NULL;

   if (sc != NULL && sc->parent != NULL && sc->parent->multilayer) {
      ret = chunkalloc(sizeof(Undoes));
      if (sc == NULL) {
	 ret->undotype = ut_noop;
      } else if (full == ct_reference || full == ct_lookups || !sc->parent->multilayer) {	/* Make a reference */
	 chunkfree(ret, sizeof(Undoes));
	 ret = SCCopyAllLayer(sc, full, ly_fore);
      } else {
	 ret->undotype = ut_layers;
	 for (layer = ly_fore; layer < sc->layer_cnt; ++layer) {
	    cur = SCCopyAllLayer(sc, full, layer);
	    if (ret->u.multiple.mult == NULL)
	       ret->u.multiple.mult = cur;
	    else
	       last->next = cur;
	    last = cur;
	    /* full = ct_reference;         Hunh? What was I thinking? */
	 }
      }
      return (ret);
   } else
      return (SCCopyAllLayer(sc, full, layer));
}

static SplineChar *FindCharacter(SplineFont * into, SplineFont * from,
				 RefChar * rf, SplineChar ** fromsc) {
   char *fromname = NULL;

   if (!SFIsActive(from))
      from = NULL;
   /* A subtler error: If we've closed the "from" font and subsequently */
   /*  opened the "into" font, there is a good chance they have the same */
   /*  address, and we just found ourselves. */
   /* More complicated cases are possible too, where from and into might */
   /*  be different -- but from has still been closed and reopened as something */
   /*  else */
   /* Should be fixed now. We clear copied_from when we close a font */
   if (from != NULL
       && (rf->orig_pos >= from->glyphcnt
	   || from->glyphs[rf->orig_pos] == NULL
	   || from->glyphs[rf->orig_pos]->unicodeenc != rf->unicode_enc))
      from = NULL;

   if (fromsc != NULL)
      *fromsc = NULL;

   if (from != NULL && rf->orig_pos < from->glyphcnt
       && from->glyphs[rf->orig_pos] != NULL) {
      fromname = from->glyphs[rf->orig_pos]->name;
      if (fromsc != NULL)
	 *fromsc = from->glyphs[rf->orig_pos];
   }

   if (rf->orig_pos < into->glyphcnt && into->glyphs[rf->orig_pos] != NULL &&
       ((into->glyphs[rf->orig_pos]->unicodeenc == rf->unicode_enc
	 && rf->unicode_enc != -1) || (rf->unicode_enc == -1
				       && fromname != NULL
				       && strcmp(into->glyphs[rf->orig_pos]->
						 name, fromname) == 0)))
      return (into->glyphs[rf->orig_pos]);

   return (SFGetChar(into, rf->unicode_enc, fromname));
}

int SCDependsOnSC(SplineChar * parent, SplineChar * child) {
   RefChar *ref;

   if (parent == child)
      return (true);
   for (ref = parent->layers[ly_fore].refs; ref != NULL; ref = ref->next) {
      if (SCDependsOnSC(ref->sc, child))
	 return (true);
   }
   return (false);
}

static int BCRefersToBC(BDFChar * parent, BDFChar * child) {
   BDFRefChar *head;

   if (parent == child)
      return (true);
   for (head = child->refs; head != NULL; head = head->next) {
      if (BCRefersToBC(parent, head->bdfc))
	 return (true);
   }
   return (false);
}

static void PasteNonExistantRefCheck(SplineChar * sc, Undoes * paster,
				     RefChar * ref, int *refstate) {
   SplineChar *rsc = NULL, *fromsc;

   SplineSet *new, *spl;

   int yes = 3;

   rsc = FindCharacter(sc->parent, paster->copied_from, ref, &fromsc);
   if (rsc != NULL)
      IError
	 ("We should never have called PasteNonExistantRefCheck if we had a glyph");
   if (fromsc == NULL) {
      if (!(*refstate & 0x4)) {
	 char *buts[3];

	 char buf[80];

	 const char *name;

	 if (ref->unicode_enc == -1)
	    name = "<Unknown>";
	 else
	    name =
	       StdGlyphName(buf, ref->unicode_enc, ui_none, (NameList *) - 1);
	 buts[0] = _("Don't Warn Again");
	 buts[1] = _("_OK");
	 buts[2] = NULL;
	 yes =
	    ff_ask(_("Bad Reference"), (const char **) buts, 1, 1,
		   _
		   ("You are attempting to paste a reference to %1$s into %2$s.\nBut %1$s does not exist in this font, nor can I find the original character referred to.\nIt will not be copied."),
		   name, sc->name);
	 if (yes == 0)
	    *refstate |= 0x4;
      }
   } else {
      if (!(*refstate & 0x3)) {
	 char *buts[5];

	 buts[0] = _("_Yes");
	 buts[1] = _("Yes to _All");
	 buts[2] = _("No _to All");
	 buts[3] = _("_No");
	 buts[4] = NULL;
	 yes =
	    ff_ask(_("Bad Reference"), (const char **) buts, 0, 3,
		   _
		   ("You are attempting to paste a reference to %1$s into %2$s.\nBut %1$s does not exist in this font.\nWould you like to copy the original splines (or delete the reference)?"),
		   fromsc->name, sc->name);
	 if (yes == 1)
	    *refstate |= 1;
	 else if (yes == 2)
	    *refstate |= 2;
      }
      if ((*refstate & 1) || yes <= 1) {
	 new =
	    SplinePointListTransform(SplinePointListCopy
				     (fromsc->layers[ly_fore].splines),
				     ref->transform, tpt_AllPoints);
	 SplinePointListSelect(new, true);
	 if (new != NULL) {
	    for (spl = new; spl->next != NULL; spl = spl->next);
	    spl->next = sc->layers[ly_fore].splines;
	    sc->layers[ly_fore].splines = new;
	 }
      }
   }
}

static void SCCheckXClipboard(SplineChar * sc, int layer, int doclear) {
      return;
}

#ifndef _NO_LIBXML
static void XClipFontToFFClip(void) {
   int32 len;

   int i;

   char *paste;

   SplineFont *sf;

   SplineChar *sc;

   Undoes *head = NULL, *last = NULL, *cur;

   paste = ClipboardRequest("application/x-font-svg", &len);
   if (paste == NULL)
      return;
   sf = SFReadSVGMem(paste, 0);
   if (sf == NULL)
      return;
   for (i = 0; i < sf->glyphcnt; ++i)
      if ((sc = sf->glyphs[i]) != NULL) {
	 if (strcmp(sc->name, ".notdef") == 0)
	    continue;
	 cur = SCCopyAll(sc, ly_fore, ct_fullcopy);
	 if (cur != NULL) {
	    if (head == NULL)
	       head = cur;
	    else
	       last->next = cur;
	    last = cur;
	 }
      }

   SplineFontFree(sf);
   free(paste);

   if (head == NULL)
      return;

   CopyBufferFree();
   copybuffer.undotype = ut_multiple;
   copybuffer.u.multiple.mult = head;
   copybuffer.copied_from = NULL;
}
#endif

static double PasteFigureScale(SplineFont * newsf, SplineFont * oldsf) {

   if (newsf == oldsf)
      return (1.0);
   if (!SFIsActive(oldsf))	/* Font we copied from has been closed */
      return (1.0);

   return ((newsf->ascent + newsf->descent) / (double) (oldsf->ascent +
							oldsf->descent));
}

static int anchor_lost_warning = false;

static void APMerge(SplineChar * sc, AnchorPoint * anchor) {
   AnchorPoint *ap, *prev, *next, *test;

   AnchorClass *ac;

   if (anchor == NULL)
      return;
   anchor = AnchorPointsCopy(anchor);
   /* If we pasted from one font to another, the anchor class list will be */
   /*  different. */
   for (ac = sc->parent->anchor; ac != NULL && ac != anchor->anchor;
	ac = ac->next);
   if (ac == NULL) {		/* Into a different font. See if we can find a class with same name in new font */
      prev = NULL;
      for (ap = anchor; ap != NULL; ap = next) {
	 next = ap->next;
	 for (ac = sc->parent->anchor;
	      ac != NULL && strcmp(ac->name, ap->anchor->name) != 0;
	      ac = ac->next);
	 if (ac != NULL) {
	    ap->anchor = ac;
	    prev = ap;
	 } else {
	    if (prev == NULL)
	       anchor = next;
	    else
	       prev->next = next;
	    ap->next = NULL;
	    AnchorPointsFree(ap);
	    anchor_lost_warning = true;
	 }
      }
      if (anchor_lost_warning)
	 ff_post_error(_("Anchor Lost"),
		       _
		       ("At least one anchor point was lost when pasting from one font to another because no matching anchor class could be found in the new font."));
      if (anchor == NULL)
	 return;
   }
   if (sc->anchor == NULL) {
      sc->anchor = anchor;
      return;
   }

   prev = NULL;
   for (ap = anchor; ap != NULL; ap = next) {
      next = ap->next;
      for (test = sc->anchor; test != NULL; test = test->next)
	 if (test->anchor == ap->anchor) {
	    if ((test->type == at_centry && ap->type == at_cexit) ||
		(test->type == at_cexit && ap->type == at_centry))
	       /* It's ok */ ;
	    else if (test->type != at_baselig || ap->type != at_baselig ||
		     test->lig_index == ap->lig_index)
	       break;
	 }
      if (test != NULL) {
	 ff_post_error(_("Duplicate Anchor"),
		       _
		       ("There is already an anchor point named %1$.40s in %2$.40s."),
		       test->anchor->name, sc->name);
	 if (prev == NULL)
	    anchor = next;
	 else
	    prev->next = next;
	 ap->next = NULL;
	 AnchorPointsFree(ap);
      } else
	 prev = ap;
   }
   if (prev != NULL) {
      prev->next = sc->anchor;
      sc->anchor = anchor;
   }
}

static int InstrsSameParent(SplineChar * sc, SplineFont * copied_from) {
   static SplineFont *dontask_parent = NULL, *dontask_copied_from;

   static int dontask_ret = 0;

   char *buts[5];

   int ret;

   if (sc->parent == copied_from)
      return (true);
   if (sc->parent == dontask_parent && copied_from == dontask_copied_from)
      return (dontask_ret);
   buts[0] = _("_Yes");
   buts[3] = _("_No");
   buts[1] = _("Yes to _All");
   buts[2] = _("No _to All");
   buts[4] = NULL;
   ret =
      ff_ask(_("Different Fonts"), (const char **) buts, 0, 3,
	     _
	     ("You are attempting to paste glyph instructions from one font to another. Generally this will not work unless the 'prep', 'fpgm' and 'cvt ' tables are the same.\nDo you want to continue anyway?"));
   if (ret == 0)
      return (true);
   if (ret == 3)
      return (false);
   dontask_parent = sc->parent;
   dontask_copied_from = copied_from;
   dontask_ret = ret == 1;
   return (dontask_ret);
}

int SCWasEmpty(SplineChar * sc, int skip_this_layer) {
   int i;

   for (i = ly_fore; i < sc->layer_cnt; ++i)
      if (i != skip_this_layer && !sc->layers[i].background) {
	 if (sc->layers[i].refs != NULL)
	    return (false);
	 else if (sc->layers[i].splines != NULL) {
	    SplineSet *ss;

	    for (ss = sc->layers[i].splines; ss != NULL; ss = ss->next) {
	       if (ss->first->prev != NULL)
		  return (false);	/* Closed contour */
	    }
	 }
      }
   return (true);
}

/* when pasting from the fontview we do a clear first */
static void _PasteToSC(SplineChar * sc, Undoes * paster, FontViewBase * fv,
		       int pasteinto, int layer, real trans[6],
		       struct sfmergecontext *mc, int *refstate,
		       int *already_complained) {
   DBounds bb;

   real transform[6];

   int width, vwidth;

   int xoff = 0, yoff = 0;

   int was_empty;

   RefChar *ref;

   switch (paster->undotype) {
     case ut_noop:
	break;
     case ut_anchors:
	if (!sc->searcherdummy)
	   APMerge(sc, paster->u.state.anchor);
	break;
     case ut_state:
     case ut_statehint:
     case ut_statename:
	if (paster->u.state.splines != NULL || paster->u.state.refs != NULL)
	   sc->parent->onlybitmaps = false;
	SCPreserveLayer(sc, layer, paster->undotype == ut_statehint);
	width = paster->u.state.width;
	vwidth = paster->u.state.vwidth;
	was_empty = sc->hstem == NULL && sc->vstem == NULL
	   && sc->layers[ly_fore].splines == NULL
	   && sc->layers[ly_fore].refs == NULL;
	if (!pasteinto) {
	   if (!sc->layers[layer].background &&
	       SCWasEmpty(sc, pasteinto == 0 ? layer : -1)) {
	      if (!sc->parent->onlybitmaps)
		 SCSynchronizeWidth(sc, width, sc->width, fv);
	      sc->vwidth = vwidth;
	   }
	   SplinePointListsFree(sc->layers[layer].splines);
	   sc->layers[layer].splines = NULL;
	   ImageListsFree(sc->layers[layer].images);
	   sc->layers[layer].images = NULL;
	   SCRemoveLayerDependents(sc, layer);
	   AnchorPointsFree(sc->anchor);
	   sc->anchor = NULL;
	   if (paster->undotype == ut_statehint) {
	      StemInfosFree(sc->hstem);
	      StemInfosFree(sc->vstem);
	      sc->hstem = sc->vstem = NULL;
	      sc->hconflicts = sc->vconflicts = false;
	   }
	   GradientFree(sc->layers[layer].fill_brush.gradient);
	   sc->layers[layer].fill_brush.gradient = NULL;
	   PatternFree(sc->layers[layer].fill_brush.pattern);
	   sc->layers[layer].fill_brush.pattern = NULL;
	   GradientFree(sc->layers[layer].stroke_pen.brush.gradient);
	   sc->layers[layer].stroke_pen.brush.gradient = NULL;
	   PatternFree(sc->layers[layer].stroke_pen.brush.pattern);
	   sc->layers[layer].stroke_pen.brush.pattern = NULL;
	   was_empty = true;
	} else if (pasteinto == 2) {
	   if (sc->parent->hasvmetrics) {
	      yoff = -sc->vwidth;
	      sc->vwidth += vwidth;
	   } else if (SCRightToLeft(sc)) {
	      xoff = 0;
	      SCSynchronizeWidth(sc, sc->width + width, sc->width, fv);
	      transform[0] = transform[3] = 1;
	      transform[1] = transform[2] = transform[5] = 0;
	      transform[4] = width;
	      sc->layers[layer].splines =
		 SplinePointListTransform(sc->layers[layer].splines,
					  transform, tpt_AllPoints);
	      for (ref = sc->layers[layer].refs; ref != NULL; ref = ref->next) {
		 ref->transform[4] += width;
		 SCReinstanciateRefChar(sc, ref, layer);
	      }
	   } else {
	      xoff = sc->width;
	      SCSynchronizeWidth(sc, sc->width + width, sc->width, fv);
	   }
	} else if (pasteinto == 3 && trans != NULL) {
	   xoff = trans[4];
	   yoff = trans[5];
	}
	if (layer >= ly_fore && sc->layers[layer].splines == NULL &&
	    sc->layers[layer].refs == NULL && sc->layers[layer].images == NULL
	    && sc->parent->multilayer) {
	   /* pasting into an empty layer sets the fill/stroke */
	   BrushCopy(&sc->layers[layer].fill_brush,
		     &paster->u.state.fill_brush, NULL);
	   PenCopy(&sc->layers[layer].stroke_pen, &paster->u.state.stroke_pen,
		   NULL);
	   sc->layers[layer].dofill = paster->u.state.dofill;
	   sc->layers[layer].dostroke = paster->u.state.dostroke;
	   sc->layers[layer].fillfirst = paster->u.state.fillfirst;
	}
	if (sc->layers[layer].order2 && !sc->layers[layer].background) {
	   if (paster->undotype == ut_statehint) {
	      /* if they are pasting instructions, I hope they know what */
	      /*  they are doing... */
	   } else
	      if ((paster->u.state.splines != NULL
		   || paster->u.state.refs != NULL || pasteinto == 0)
		  && !sc->instructions_out_of_date
		  && sc->ttf_instrs != NULL) {
	      /* The normal change check doesn't respond properly to pasting a reference */
	      SCClearInstrsOrMark(sc, layer, !*already_complained);
	      *already_complained = true;
	   }
	}
	if (paster->u.state.splines != NULL) {
	   SplinePointList *temp =
	      SplinePointListCopy(paster->u.state.splines);
	   if ((pasteinto == 2 || pasteinto == 3) && (xoff != 0 || yoff != 0)) {
	      transform[0] = transform[3] = 1;
	      transform[1] = transform[2] = 0;
	      transform[4] = xoff;
	      transform[5] = yoff;
	      temp = SplinePointListTransform(temp, transform, tpt_AllPoints);
	   }
	   if (paster->was_order2 != sc->layers[layer].order2)
	      temp = SplineSetsConvertOrder(temp, sc->layers[layer].order2);
	   if (sc->layers[layer].splines != NULL) {
	      SplinePointList *e = sc->layers[layer].splines;

	      while (e->next != NULL)
		 e = e->next;
	      e->next = temp;
	   } else
	      sc->layers[layer].splines = temp;
	}
	if (!sc->searcherdummy)
	   APMerge(sc, paster->u.state.anchor);
	if (paster->u.state.images != NULL && sc->parent->multilayer) {
	   ImageList *new, *cimg;

	   for (cimg = paster->u.state.images; cimg != NULL;
		cimg = cimg->next) {
	      new = malloc(sizeof(ImageList));
	      *new = *cimg;
	      new->selected = true;
	      new->next = sc->layers[layer].images;
	      sc->layers[layer].images = new;
	   }
	}
	if ((paster->undotype == ut_statehint
	     || paster->undotype == ut_statename)
	    && !sc->layers[layer].background) {
	   if (!pasteinto) {	/* Hints aren't meaningful unless we've cleared first */
	      ExtractHints(sc, paster->u.state.hints, true);
	      if (sc->layers[layer].order2) {
		 free(sc->ttf_instrs);
		 if (paster->u.state.instrs_len != 0
		     && sc->layers[layer].order2
		     && InstrsSameParent(sc, paster->copied_from)) {
		    sc->ttf_instrs =
		       (uint8 *) copyn((char *) paster->u.state.instrs,
				       paster->u.state.instrs_len);
		    sc->ttf_instrs_len = paster->u.state.instrs_len;
		 } else {
		    sc->ttf_instrs = NULL;
		    sc->ttf_instrs_len = 0;
		 }
		 sc->instructions_out_of_date = false;
	      }
	   }
	}
	if (paster->undotype == ut_statename) {
	   SCSetMetaData(sc, paster->u.state.charname,
			 paster->u.state.unicodeenc ==
			 0xffff ? -1 : paster->u.state.unicodeenc,
			 paster->u.state.comment);
	   if (SFIsActive(paster->copied_from)) {
	      /* Only copy PSTs if we can find and translate their lookups */
	      PSTFree(sc->possub);
	      mc->sf_from = paster->copied_from;
	      mc->sf_to = sc->parent;
	      sc->possub = PSTCopy(paster->u.state.possub, sc, mc);
	   }
	}
	if (paster->u.state.refs != NULL) {
	   RefChar *new, *refs;

	   SplineChar *rsc;

	   double scale = PasteFigureScale(sc->parent, paster->copied_from);

	   for (refs = paster->u.state.refs; refs != NULL; refs = refs->next) {
	      if (sc->views != NULL && sc->views->container != NULL) {
		 if (sc->views->container->funcs->type == cvc_searcher ||
		     sc->views->container->funcs->type == cvc_multiplepattern)
		    rsc =
		       FindCharacter((sc->views->container->funcs->
				      sf_of_container) (sc->views->container),
				     paster->copied_from, refs, NULL);
		 else {
		    ff_post_error(_("Please don't do that"),
				  _
				  ("You may not paste a reference into this window"));
		    rsc = (SplineChar *) - 1;
		 }
	      } else
		 rsc =
		    FindCharacter(sc->parent, paster->copied_from, refs,
				  NULL);
	      if (rsc == (SplineChar *) - 1)
		 /* Error above */ ;
	      else if (rsc != NULL && SCDependsOnSC(rsc, sc))
		 ff_post_error(_("Self-referential glyph"),
			       _
			       ("Attempt to make a glyph that refers to itself"));
	      else if (rsc != NULL) {
		 new = RefCharCreate();
		 free(new->layers);
		 *new = *refs;
		 new->transform[4] *= scale;
		 new->transform[5] *= scale;
		 new->transform[4] += xoff;
		 new->transform[5] += yoff;
		 new->layers = NULL;
		 new->layer_cnt = 0;
		 new->sc = rsc;
		 new->next = sc->layers[layer].refs;
		 sc->layers[layer].refs = new;
		 SCReinstanciateRefChar(sc, new, layer);
		 SCMakeDependent(sc, rsc);
	      } else {
		 PasteNonExistantRefCheck(sc, paster, refs, refstate);
	      }
	   }
	}
	SCCharChangedUpdate(sc, layer, true);
	/* Bug here. we are assuming that the pasted hints are up to date */
	if (was_empty && (sc->hstem != NULL || sc->vstem != NULL))
	   sc->changedsincelasthinted = false;
	break;
     case ut_width:
	SCPreserveWidth(sc);
	SCSynchronizeWidth(sc, paster->u.width, sc->width, fv);
	SCCharChangedUpdate(sc, layer, true);
	break;
     case ut_vwidth:
	if (!sc->parent->hasvmetrics)
	   ff_post_error(_("No Vertical Metrics"),
			 _
			 ("This font does not have vertical metrics enabled.\nUse Element->Font Info to enable them."));
	else {
	   SCPreserveVWidth(sc);
	   sc->vwidth = paster->u.width;
	   SCCharChangedUpdate(sc, layer, true);
	}
	break;
     case ut_rbearing:
	SCPreserveWidth(sc);
	SplineCharFindBounds(sc, &bb);
	SCSynchronizeWidth(sc, bb.maxx + paster->u.rbearing, sc->width, fv);
	SCCharChangedUpdate(sc, layer, true);
	break;
     case ut_lbearing:
	SplineCharFindBounds(sc, &bb);
	transform[0] = transform[3] = 1.0;
	transform[1] = transform[2] = transform[5] = 0;
	transform[4] = paster->u.lbearing - bb.minx;
	if (transform[4] != 0)
	   FVTrans(fv, sc, transform, NULL, false);
	/* FVTrans will preserve the state and update the chars */
	break;
   }
}

static void PasteToSC(SplineChar * sc, int layer, Undoes * paster,
		      FontViewBase * fv, int pasteinto, real trans[6],
		      struct sfmergecontext *mc, int *refstate,
		      int *already_complained) {
   if (paster->undotype == ut_layers && sc->parent->multilayer) {
      int lc, start, layer;

      Undoes *pl;

      Layer *old = sc->layers;

      for (lc = 0, pl = paster->u.multiple.mult; pl != NULL;
	   pl = pl->next, ++lc);
      if (!pasteinto) {
	 start = ly_fore;
	 for (layer = ly_fore; layer < sc->layer_cnt; ++layer) {
	    SplinePointListsFree(sc->layers[layer].splines);
	    sc->layers[layer].splines = NULL;
	    ImageListsFree(sc->layers[layer].images);
	    sc->layers[layer].images = NULL;
	    SCRemoveLayerDependents(sc, layer);
	    GradientFree(sc->layers[layer].fill_brush.gradient);
	    sc->layers[layer].fill_brush.gradient = NULL;
	    PatternFree(sc->layers[layer].fill_brush.pattern);
	    sc->layers[layer].fill_brush.pattern = NULL;
	    GradientFree(sc->layers[layer].stroke_pen.brush.gradient);
	    sc->layers[layer].stroke_pen.brush.gradient = NULL;
	    PatternFree(sc->layers[layer].stroke_pen.brush.pattern);
	    sc->layers[layer].stroke_pen.brush.pattern = NULL;
	 }
      } else
	 start = sc->layer_cnt;
      if (start + lc > sc->layer_cnt) {
	 sc->layers = realloc(sc->layers, (start + lc) * sizeof(Layer));
	 for (layer = sc->layer_cnt; layer < start + lc; ++layer)
	    LayerDefault(&sc->layers[layer]);
	 sc->layer_cnt = start + lc;
      }
      for (lc = 0, pl = paster->u.multiple.mult; pl != NULL;
	   pl = pl->next, ++lc)
	 _PasteToSC(sc, pl, fv, pasteinto, start + lc, trans, mc, refstate,
		    already_complained);
   } else if (paster->undotype == ut_layers) {
      Undoes *pl;

      for (pl = paster->u.multiple.mult; pl != NULL; pl = pl->next) {
	 _PasteToSC(sc, pl, fv, pasteinto, ly_fore, trans, mc, refstate,
		    already_complained);
	 pasteinto = true;	/* Merge other layers in */
      }
   } else
      _PasteToSC(sc, paster, fv, pasteinto, layer, trans, mc, refstate,
		 already_complained);
}

static void DevTabInto(struct vr *vr) {
   ValDevTab *adjust;

   if (vr->adjust == NULL)
      return;			/* Nothing to do */
   adjust = chunkalloc(sizeof(ValDevTab));
   *adjust = *vr->adjust;
   if (adjust->xadjust.corrections != NULL) {
      adjust->xadjust.corrections =
	 malloc(adjust->xadjust.last_pixel_size -
		adjust->xadjust.first_pixel_size + 1);
      memcpy(adjust->xadjust.corrections, vr->adjust->xadjust.corrections,
	     adjust->xadjust.last_pixel_size -
	     adjust->xadjust.first_pixel_size + 1);
   }
   if (adjust->yadjust.corrections != NULL) {
      adjust->yadjust.corrections =
	 malloc(adjust->yadjust.last_pixel_size -
		adjust->yadjust.first_pixel_size + 1);
      memcpy(adjust->yadjust.corrections, vr->adjust->yadjust.corrections,
	     adjust->yadjust.last_pixel_size -
	     adjust->yadjust.first_pixel_size + 1);
   }
   if (adjust->xadv.corrections != NULL) {
      adjust->xadv.corrections =
	 malloc(adjust->xadv.last_pixel_size - adjust->xadv.first_pixel_size +
		1);
      memcpy(adjust->xadv.corrections, vr->adjust->xadv.corrections,
	     adjust->xadv.last_pixel_size - adjust->xadv.first_pixel_size +
	     1);
   }
   if (adjust->yadv.corrections != NULL) {
      adjust->yadv.corrections =
	 malloc(adjust->yadv.last_pixel_size - adjust->yadv.first_pixel_size +
		1);
      memcpy(adjust->yadv.corrections, vr->adjust->yadv.corrections,
	     adjust->yadv.last_pixel_size - adjust->yadv.first_pixel_size +
	     1);
   }
}

static void PSTInto(SplineChar * sc, PST * pst, PST * frompst,
		    struct lookup_subtable *sub) {
   if (pst == NULL) {
      pst = chunkalloc(sizeof(PST));
      *pst = *frompst;
      pst->subtable = sub;
      pst->next = sc->possub;
      sc->possub = pst;
   } else {
      if (pst->type == pst_pair) {
	 free(pst->u.pair.paired);
	 chunkfree(pst->u.pair.vr, sizeof(struct vr[2]));	/* We fail to free device tables */
      } else if (pst->type == pst_substitution || pst->type == pst_alternate
		 || pst->type == pst_multiple || pst->type == pst_ligature)
	 free(pst->u.subs.variant);
   }
   if (pst->type == pst_substitution || pst->type == pst_alternate ||
       pst->type == pst_multiple)
      pst->u.subs.variant = copy(frompst->u.subs.variant);
   else if (pst->type == pst_ligature) {
      pst->u.lig.components = copy(frompst->u.lig.components);
      pst->u.lig.lig = sc;
   } else if (pst->type == pst_pair) {
      pst->u.pair.paired = copy(frompst->u.pair.paired);
      pst->u.pair.vr = chunkalloc(sizeof(struct vr[2]));
      memcpy(pst->u.pair.vr, frompst->u.pair.vr, sizeof(struct vr[2]));
      DevTabInto(&pst->u.pair.vr[0]);
      DevTabInto(&pst->u.pair.vr[1]);
   } else if (pst->type == pst_position) {
      memcpy(&pst->u.pos, &frompst->u.pos, sizeof(struct vr));
      DevTabInto(&pst->u.pos);
   }
}

static void APInto(SplineChar * sc, AnchorPoint * ap, AnchorPoint * fromap,
		   AnchorClass * ac) {
   if (ap == NULL) {
      ap = chunkalloc(sizeof(AnchorPoint));
      *ap = *fromap;
      ap->anchor = ac;
      ap->next = sc->anchor;
      sc->anchor = ap;
   } else {
      free(ap->xadjust.corrections);
      free(ap->yadjust.corrections);
      ap->xadjust = fromap->xadjust;
      ap->yadjust = fromap->yadjust;
      ap->me = fromap->me;
   }
   if (fromap->xadjust.corrections != NULL) {
      ap->xadjust.corrections =
	 malloc(ap->xadjust.last_pixel_size - ap->xadjust.first_pixel_size +
		1);
      memcpy(ap->xadjust.corrections, fromap->xadjust.corrections,
	     ap->xadjust.last_pixel_size - ap->xadjust.first_pixel_size + 1);
   }
   if (fromap->yadjust.corrections != NULL) {
      ap->yadjust.corrections =
	 malloc(ap->yadjust.last_pixel_size - ap->yadjust.first_pixel_size +
		1);
      memcpy(ap->yadjust.corrections, fromap->yadjust.corrections,
	     ap->yadjust.last_pixel_size - ap->xadjust.first_pixel_size + 1);
   }
}

static void KPInto(SplineChar * owner, KernPair * kp, KernPair * fromkp,
		   int isv, SplineChar * other, struct lookup_subtable *sub) {
   if (kp == NULL) {
      kp = chunkalloc(sizeof(KernPair));
      *kp = *fromkp;
      kp->subtable = sub;
      if (isv) {
	 kp->next = owner->vkerns;
	 owner->vkerns = kp;
      } else {
	 kp->next = owner->kerns;
	 owner->kerns = kp;
      }
   }
   kp->sc = other;
   kp->off = fromkp->off;
   if (kp->adjust != NULL)
      DeviceTableFree(kp->adjust);
   if (fromkp->adjust != NULL)
      kp->adjust = DeviceTableCopy(fromkp->adjust);
   else
      kp->adjust = NULL;
}

static void SCPasteLookups(SplineChar * sc, SplineChar * fromsc,
			   int pasteinto, OTLookup ** list,
			   OTLookup ** backpairlist,
			   struct sfmergecontext *mc) {
   PST *frompst, *pst;

   int isv, gid;

   KernPair *fromkp, *kp;

   AnchorPoint *fromap, *ap;

   AnchorClass *ac;

   int i;

   OTLookup *otl;

   struct lookup_subtable *sub;

   SplineFont *fromsf;

   SplineChar *othersc;

   SplineChar *test, *test2;

   int changed = false;

   for (frompst = fromsc->possub; frompst != NULL; frompst = frompst->next) {
      if (frompst->subtable == NULL)
	 continue;
      if (frompst->type == pst_ligature && fromsc->parent == sc->parent)
	 continue;
      otl = frompst->subtable->lookup;
      for (i = 0; list[i] != NULL && list[i] != otl; ++i);
      if (list[i] == NULL)
	 continue;
      sub = MCConvertSubtable(mc, frompst->subtable);
      if (otl->lookup_type != gpos_pair) {
	 for (pst = sc->possub; pst != NULL && pst->subtable != sub;
	      pst = pst->next);
      } else {
	 for (pst = sc->possub; pst != NULL; pst = pst->next) {
	    if (pst->subtable == sub &&
		strcmp(frompst->u.pair.paired, pst->u.pair.paired) == 0)
	       break;
	 }
      }
      PSTInto(sc, pst, frompst, sub);
      changed = true;
   }

   for (fromap = fromsc->anchor; fromap != NULL; fromap = fromap->next) {
      otl = fromap->anchor->subtable->lookup;
      for (i = 0; list[i] != NULL && list[i] != otl; ++i);
      if (list[i] == NULL)
	 continue;
      ac = MCConvertAnchorClass(mc, fromap->anchor);
      for (ap = sc->anchor; ap != NULL &&
	   !(ap->anchor == ac && ap->type == fromap->type
	     && ap->lig_index == fromap->lig_index); ap = ap->next);
      APInto(sc, ap, fromap, ac);
      changed = true;
   }

   for (isv = 0; isv < 2; ++isv) {
      for (fromkp = isv ? fromsc->vkerns : fromsc->kerns; fromkp != NULL;
	   fromkp = fromkp->next) {
	 otl = fromkp->subtable->lookup;
	 for (i = 0; list[i] != NULL && list[i] != otl; ++i);
	 if (list[i] == NULL)
	    continue;
	 sub = MCConvertSubtable(mc, fromkp->subtable);
	 if (sub == NULL)
	    continue;
	 if (fromsc->parent == sc->parent)
	    othersc = fromkp->sc;
	 else
	    othersc =
	       SFGetChar(sc->parent, fromkp->sc->unicodeenc,
			 fromkp->sc->name);
	 if (othersc != NULL) {
	    for (kp = isv ? sc->vkerns : sc->kerns; kp != NULL; kp = kp->next) {
	       if (kp->subtable == sub && kp->sc == othersc)
		  break;
	    }
	    KPInto(sc, kp, fromkp, isv, othersc, sub);
	    changed = true;
	 }
      }
      if (backpairlist == NULL)
	 continue;
      fromsf = fromsc->parent;
      for (gid = fromsf->glyphcnt - 1; gid >= 0; --gid)
	 if ((test = fromsf->glyphs[gid]) != NULL) {
	    for (fromkp = isv ? test->vkerns : test->kerns; fromkp != NULL;
		 fromkp = fromkp->next) {
	       if (fromkp->sc != fromsc)
		  continue;
	       otl = fromkp->subtable->lookup;
	       for (i = 0; backpairlist[i] != NULL && backpairlist[i] != otl;
		    ++i);
	       if (backpairlist[i] == NULL)
		  continue;
	       sub = MCConvertSubtable(mc, fromkp->subtable);
	       if (fromsf == sc->parent)
		  test2 = test;
	       else
		  test2 = SFGetChar(sc->parent, test->unicodeenc, test->name);
	       if (test2 == NULL || sub == NULL)
		  continue;
	       for (kp = isv ? test2->vkerns : test2->kerns; kp != NULL;
		    kp = kp->next) {
		  if (kp->subtable == sub && kp->sc == sc)
		     break;
	       }
	       KPInto(test2, kp, fromkp, isv, sc, sub);
	       SCCharChangedUpdate(test2, ly_none, 2);
	    }
	 }
   }
   if (changed)
      SCCharChangedUpdate(sc, ly_none, 2);
}

static void SCPasteLookupsMid(SplineChar * sc, Undoes * paster, int pasteinto,
			      OTLookup ** list, OTLookup ** backpairlist,
			      struct sfmergecontext *mc) {
   SplineChar *fromsc;

   (void) FindCharacter(sc->parent, paster->copied_from,
			paster->u.state.refs, &fromsc);
   if (fromsc == NULL) {
      ff_post_error(_("Missing glyph"), _("Could not find original glyph"));
      return;
   }
   SCPasteLookups(sc, fromsc, pasteinto, list, backpairlist, mc);
}

static int HasNonClass(OTLookup * otl) {
   struct lookup_subtable *sub;

   for (sub = otl->subtables; sub != NULL; sub = sub->next)
      if (sub->kc == NULL)
	 return (true);

   return (false);
}

static OTLookup **GetLookupsToCopy(SplineFont * sf, OTLookup *** backpairlist,
				   int is_same) {
   int cnt, bcnt, ftot = 0, doit, isgpos, i, ret;

   char **choices = NULL, *sel;

   OTLookup *otl, **list1 = NULL, **list2 = NULL, **list, **blist;

   char *buttons[3];

   buttons[0] = _("_OK");
   buttons[1] = _("_Cancel");
   buttons[2] = NULL;

   *backpairlist = NULL;

   for (doit = 0; doit < 2; ++doit) {
      bcnt = cnt = 0;
      for (isgpos = 0; isgpos < 2; ++isgpos) {
	 for (otl = isgpos ? sf->gpos_lookups : sf->gsub_lookups; otl != NULL;
	      otl = otl->next) {
	    if (otl->lookup_type == gsub_single
		|| otl->lookup_type == gsub_multiple
		|| otl->lookup_type == gsub_alternate
		|| otl->lookup_type == gsub_ligature
		|| otl->lookup_type == gpos_single
		|| otl->lookup_type == gpos_cursive
		|| otl->lookup_type == gpos_mark2base
		|| otl->lookup_type == gpos_mark2ligature
		|| otl->lookup_type == gpos_mark2mark
		|| (otl->lookup_type == gpos_pair && HasNonClass(otl))) {
	       if (doit) {
		  list1[cnt] = otl;
		  choices[cnt++] = copy(otl->lookup_name);
		  if (otl->lookup_type == gpos_pair) {
/* GT: I'm not happy with this phrase. Suggestions for improvements are welcome */
/* GT:  Here I am generating a list of lookup names representing data that can */
/* GT:  be copied from one glyph to another. For a kerning (pairwise) lookup */
/* GT:  the first entry in the list (marked by the lookup name by itself) will */
/* GT:  mean all data where the current glyph is the first glyph in a kerning */
/* GT:  pair. But we can also (separatedly) copy data where the current glyph */
/* GT:  is the second glyph in the kerning pair, and that's what this line */
/* GT:  refers to. The "%s" will be filled in with the lookup name */
		     char *format = _("Second glyph of %s");

		     char *space =
			malloc(strlen(format) + strlen(otl->lookup_name) + 1);
		     sprintf(space, format, otl->lookup_name);
		     list2[bcnt] = otl;
		     choices[ftot + 1 + bcnt++] = space;
		  }
	       } else {
		  ++cnt;
		  if (otl->lookup_type == gpos_pair)
		     ++bcnt;
	       }
	    }
	 }
      }
      if (cnt == 0) {		/* If cnt==0 then bcnt must be too */
	 ff_post_error(_("No Lookups"), _("No lookups to copy"));
	 return (NULL);
      }
      if (!doit) {
	 ftot = cnt;
	 choices = malloc((cnt + bcnt + 2) * sizeof(char *));
	 sel = calloc(cnt + bcnt + 1, 1);
	 list1 = malloc(cnt * sizeof(OTLookup *));
	 if (bcnt == 0) {
	    choices[cnt] = NULL;
	    list2 = NULL;
	 } else {
	    choices[cnt] = copy("-");
	    choices[bcnt + cnt + 1] = NULL;
	    list2 = malloc(bcnt * sizeof(OTLookup *));
	 }
      }
   }
   ret =
      ff_choose_multiple(_("Lookups"), (const char **) choices, sel,
			 bcnt == 0 ? cnt : cnt + bcnt + 1, buttons,
			 _("Choose which lookups to copy"));
   list = NULL;
   if (ret >= 0) {
      for (i = cnt = 0; i < ftot; ++i) {
	 if (sel[i])
	    ++cnt;
      }
      list = malloc((cnt + 1) * sizeof(OTLookup *));
      for (i = cnt = 0; i < ftot; ++i) {
	 if (sel[i])
	    list[cnt++] = list1[i];
      }
      list[cnt] = NULL;
      blist = NULL;
      if (bcnt != 0) {
	 for (i = cnt = 0; i < bcnt; ++i) {
	    if (sel[i + ftot + 1])
	       ++cnt;
	 }
	 if (cnt != 0) {
	    blist = malloc((cnt + 1) * sizeof(OTLookup *));
	    for (i = cnt = 0; i < bcnt; ++i) {
	       if (sel[i + ftot + 1])
		  blist[cnt++] = list2[i];
	    }
	    blist[cnt] = NULL;
	 }
	 *backpairlist = blist;
      }
      if (blist == NULL && list[0] == NULL) {
	 free(list);
	 list = NULL;
      }
   }
   free(sel);
   for (i = 0; choices[i] != NULL; ++i)
      free(choices[i]);
   free(choices);
   free(list1);
   free(list2);
   return (list);
}

static Undoes *BCCopyAll(BDFChar * bc, int pixelsize, int depth,
			 enum fvcopy_type full) {
   Undoes *cur;

   BDFRefChar *ref, *head;

   cur = chunkalloc(sizeof(Undoes));
   memset(&cur->u.bmpstate, '\0', sizeof(BDFChar));
   if (bc == NULL)
      cur->undotype = ut_noop;
   else {
      BCCompressBitmap(bc);
      cur->undotype = ut_bitmap;
      cur->u.bmpstate.width = bc->width;
      if (full == ct_fullcopy || full == ct_unlinkrefs) {
	 cur->u.bmpstate.xmin = bc->xmin;
	 cur->u.bmpstate.xmax = bc->xmax;
	 cur->u.bmpstate.ymin = bc->ymin;
	 cur->u.bmpstate.ymax = bc->ymax;
	 cur->u.bmpstate.bytes_per_line = bc->bytes_per_line;
	 cur->u.bmpstate.bitmap = bmpcopy(bc->bitmap, bc->bytes_per_line,
					  bc->ymax - bc->ymin + 1);
	 cur->u.bmpstate.selection = BDFFloatCopy(bc->selection);

	 for (head = bc->refs; head != NULL; head = head->next) {
	    ref = calloc(1, sizeof(BDFRefChar));
	    memcpy(ref, head, sizeof(BDFRefChar));
	    ref->next = cur->u.bmpstate.refs;
	    cur->u.bmpstate.refs = ref;
	 }
      } else {			/* Or just make a reference */
	 cur->u.bmpstate.bytes_per_line = 1;
	 cur->u.bmpstate.bitmap = calloc(1, sizeof(uint8));

	 ref = calloc(1, sizeof(BDFRefChar));
	 ref->bdfc = bc;
	 ref->xoff = 0;
	 ref->yoff = 0;
	 cur->u.bmpstate.refs = ref;
      }
   }
   cur->u.bmpstate.pixelsize = pixelsize;
   cur->u.bmpstate.depth = depth;
   return (cur);
}

static void _PasteToBC(BDFChar * bc, int pixelsize, int depth,
		       Undoes * paster, int clearfirst) {
   BDFRefChar *head, *cur;

   switch (paster->undotype) {
     case ut_noop:
	break;
     case ut_bitmapsel:
	BCPreserveState(bc);
	BCFlattenFloat(bc);
	if (clearfirst)
	   memset(bc->bitmap, '\0',
		  bc->bytes_per_line * (bc->ymax - bc->ymin + 1));
	bc->selection =
	   BDFFloatConvert(paster->u.bmpstate.selection, depth,
			   paster->u.bmpstate.depth);
	BCCharChangedUpdate(bc);
	break;
     case ut_bitmap:
	BCPreserveState(bc);
	BCFlattenFloat(bc);
	if (clearfirst) {
	   for (head = bc->refs; head != NULL;) {
	      cur = head;
	      head = head->next;
	      free(cur);
	   }
	   bc->refs = NULL;
	   memset(bc->bitmap, 0,
		  bc->bytes_per_line * (bc->ymax - bc->ymin + 1));
	   bc->width = paster->u.bmpstate.width;
	}
	BCPasteInto(bc, &paster->u.bmpstate, 0, 0, false, false);
	for (head = paster->u.bmpstate.refs; head != NULL; head = head->next) {
	   if (BCRefersToBC(bc, head->bdfc)) {
	      ff_post_error(_("Self-referential glyph"),
			    _
			    ("Attempt to make a glyph that refers to itself"));
	   } else {
	      cur = calloc(1, sizeof(BDFRefChar));
	      memcpy(cur, head, sizeof(BDFRefChar));
	      cur->next = bc->refs;
	      bc->refs = cur;
	      BCMakeDependent(bc, head->bdfc);
	   }
	}

	BCCompressBitmap(bc);
	bc->selection =
	   BDFFloatConvert(paster->u.bmpstate.selection, depth,
			   paster->u.bmpstate.depth);
	BCCharChangedUpdate(bc);
	break;
     case ut_composit:
	/* if there's only one bitmap and no outline state (so we only copied a bitmap) */
	/*  then paste that thing with no questions. Otherwise search for a */
	/*  bitmap with the right pixel size. If we find it, paste it, else */
	/*  noop */
	if (paster->u.composit.bitmaps == NULL)
	   /* Nothing to be done */ ;
	else if (paster->u.composit.state == NULL
		 && paster->u.composit.bitmaps->next == NULL)
	   _PasteToBC(bc, pixelsize, depth, paster->u.composit.bitmaps,
		      clearfirst);
	else {
	   Undoes *b;

	   for (b = paster->u.composit.bitmaps;
		b != NULL && b->u.bmpstate.pixelsize != pixelsize;
		b = b->next);
	   if (b != NULL)
	      _PasteToBC(bc, pixelsize, depth, b, clearfirst);
	}
	break;
     case ut_multiple:
	_PasteToBC(bc, pixelsize, depth, paster->u.multiple.mult, clearfirst);
	break;
   }
}

void FVCopyAnchors(FontViewBase * fv) {
   Undoes *head = NULL, *last = NULL, *cur;

   int i, any = false, gid;

   SplineChar *sc;

   CopyBufferFreeGrab();

   for (i = 0; i < fv->map->enccount; ++i)
      if (fv->selected[i]) {
	 any = true;
	 cur = chunkalloc(sizeof(Undoes));
	 if ((gid = fv->map->map[i]) != -1
	     && (sc = fv->sf->glyphs[gid]) != NULL) {
	    cur->undotype = ut_anchors;
	    cur->u.state.anchor = AnchorPointsCopy(sc->anchor);
	 } else
	    cur->undotype = ut_noop;
	 if (head == NULL)
	    head = cur;
	 else
	    last->next = cur;
	 last = cur;
      }
   copybuffer.undotype = ut_multiple;
   copybuffer.u.multiple.mult = head;
   copybuffer.copied_from = fv->sf;
   if (!any)
      LogError(_("No selection\n"));
}

void FVCopy(FontViewBase * fv, enum fvcopy_type fullcopy) {
   int i, any = false;

   BDFFont *bdf;

   Undoes *head = NULL, *last = NULL, *cur;

   Undoes *bhead = NULL, *blast = NULL, *bcur;

   Undoes *state;

   extern int onlycopydisplayed;

   int gid;

   SplineChar *sc;

   /* If fullcopy==ct_fullcopy copy the glyph as is. */
   /* If fullcopy==ct_reference put a reference to the glyph in the clipboard */
   /* If fullcopy==ct_lookups put a reference to the glyph in the clip but mark that we are only interested in its lookups */
   /* If fullcopy==ct_unlinkrefs copy the glyph, but unlink any references it contains */
   /*  so we end up with no references and a bunch of splines */

   for (i = 0; i < fv->map->enccount; ++i)
      if (fv->selected[i]) {
	 any = true;
	 sc = (gid = fv->map->map[i]) == -1 ? NULL : fv->sf->glyphs[gid];
	 if ((onlycopydisplayed && fv->active_bitmap == NULL)
	     || fullcopy == ct_lookups) {
	    cur = SCCopyAll(sc, fv->active_layer, fullcopy);
	 } else if (onlycopydisplayed) {
	    cur =
	       BCCopyAll(gid == -1 ? NULL : fv->active_bitmap->glyphs[gid],
			 fv->active_bitmap->pixelsize,
			 BDFDepth(fv->active_bitmap), fullcopy);
	 } else {
	    state = SCCopyAll(sc, fv->active_layer, fullcopy);
	    bhead = NULL;
	    for (bdf = fv->sf->bitmaps; bdf != NULL; bdf = bdf->next) {
	       BDFChar *bdfc = gid == -1
		  || gid >= bdf->glyphcnt ? NULL : bdf->glyphs[gid];
	       bcur =
		  BCCopyAll(bdfc, bdf->pixelsize, BDFDepth(bdf), fullcopy);
	       if (bhead == NULL)
		  bhead = bcur;
	       else
		  blast->next = bcur;
	       blast = bcur;
	    }
	    if (bhead != NULL || state != NULL) {
	       cur = chunkalloc(sizeof(Undoes));
	       cur->undotype = ut_composit;
	       cur->u.composit.state = state;
	       cur->u.composit.bitmaps = bhead;
	    } else
	       cur = NULL;
	 }
	 if (cur != NULL) {
	    if (head == NULL)
	       head = cur;
	    else
	       last->next = cur;
	    last = cur;
	 }
      }

   if (!any)
      fprintf(stderr, "No selection\n");

   if (head == NULL)
      return;
   CopyBufferFreeGrab();
   copybuffer.undotype = ut_multiple;
   copybuffer.u.multiple.mult = head;
   copybuffer.copied_from = fv->sf;

   XClipCheckEps();
}

static BDFFont *BitmapCreateCheck(FontViewBase * fv, int *yestoall, int first,
				  int pixelsize, int depth) {
   int yes = 0;

   BDFFont *bdf = NULL;

   if (*yestoall > 0 && first) {
      char *buts[5];

      char buf[20];

      if (depth != 1)
	 sprintf(buf, "%d@%d", pixelsize, depth);
      else
	 sprintf(buf, "%d", pixelsize);
      buts[0] = _("_Yes");
      buts[1] = _("Yes to _All");
      buts[2] = _("No _to All");
      buts[3] = _("_No");
      buts[4] = NULL;
      yes =
	 ff_ask(_("Bitmap Paste"), (const char **) buts, 0, 3,
		"The clipboard contains a bitmap character of size %s,\na size which is not in your database.\nWould you like to create a bitmap font of that size,\nor ignore this character?",
		buf);
      if (yes == 1)
	 *yestoall = true;
      else if (yes == 2)
	 *yestoall = -1;
      else
	 yes = yes != 3;
   }
   if (yes == 1 || *yestoall) {
      void *freetypecontext =
	 FreeTypeFontContext(fv->sf, NULL, NULL, fv->active_layer);
      if (freetypecontext)
	 bdf = SplineFontFreeTypeRasterize(freetypecontext, pixelsize, depth);
      else
	 bdf =
	    SplineFontAntiAlias(fv->sf, fv->active_layer, pixelsize,
				1 << (depth / 2));
      bdf->next = fv->sf->bitmaps;
      fv->sf->bitmaps = bdf;
      fv->sf->changed = true;
      SFOrderBitmapList(fv->sf);
   }
   return (bdf);
}

static int copybufferHasLookups(Undoes * cb) {
   if (cb->undotype == ut_multiple)
      cb = cb->u.multiple.mult;
   return (cb->undotype == ut_statelookup);
}

void PasteIntoFV(FontViewBase * fv, int pasteinto, real trans[6]) {
   Undoes *cur = NULL, *bmp;

   BDFFont *bdf;

   int i, j, cnt = 0, gid;

   int yestoall = 0, first = true;

   uint8 *oldsel = fv->selected;

   extern int onlycopydisplayed;

   SplineFont *sf = fv->sf, *origsf = sf;

   MMSet *mm = sf->mm;

   struct sfmergecontext mc;

   OTLookup **list = NULL, **backpairlist = NULL;

   int refstate = 0, already_complained = 0;

   memset(&mc, 0, sizeof(mc));
   mc.sf_to = fv->sf;
   mc.sf_from = copybuffer.copied_from;

   cur = &copybuffer;
   for (i = 0; i < fv->map->enccount; ++i)
      if (fv->selected[i])
	 ++cnt;
   if (cnt == 0) {
      fprintf(stderr, "No Selection\n");
      return;
   }

   if (copybufferHasLookups(&copybuffer)) {
      list = GetLookupsToCopy(copybuffer.copied_from, &backpairlist,
			      copybuffer.copied_from == fv->sf);
      if (list == NULL)
	 return;
   }
#ifndef _NO_LIBXML
   if (copybuffer.undotype == ut_none
       && ClipboardHasType("application/x-font-svg"))
      XClipFontToFFClip();
#endif

   if (copybuffer.undotype == ut_none) {
      j = -1;
      while (1) {
	 for (i = 0; i < fv->map->enccount; ++i)
	    if (fv->selected[i])
	       SCCheckXClipboard(SFMakeChar(sf, fv->map, i), ly_fore,
				 !pasteinto);
	 ++j;
	 if (mm == NULL || mm->normal != origsf || j >= mm->instance_count)
	    break;
	 sf = mm->instances[j];
      }
      return;
   }

   /* If they select exactly one character but there are more things in the */
   /*  copy buffer, then temporarily change the selection so that everything */
   /*  in the copy buffer gets pasted (into chars immediately following sele */
   /*  cted one (unless we run out of chars...)) */
   if (cnt == 1 && cur->undotype == ut_multiple
       && cur->u.multiple.mult->next != NULL) {
      Undoes *tot;

      int j;

      for (cnt = 0, tot = cur->u.multiple.mult; tot != NULL;
	   ++cnt, tot = tot->next);
      fv->selected = malloc(fv->map->enccount);
      memcpy(fv->selected, oldsel, fv->map->enccount);
      for (i = 0; i < fv->map->enccount && !fv->selected[i]; ++i);
      for (j = 0; j < cnt && i + j < fv->map->enccount; ++j)
	 fv->selected[i + j] = 1;
      cnt = j;
   }

   anchor_lost_warning = false;

   if (cur->undotype == ut_multiple)
      cur = cur->u.multiple.mult;
   /* This little gem of code is to keep us from throwing out forward */
   /*  references. Say we are pasting into both "i" and dotlessi (and */
   /*  dotlessi isn't defined yet) without this the paste to "i" will */
   /*  search for dotlessi, not find it and ignore the reference */
   if (cur->undotype == ut_state || cur->undotype == ut_statehint
       || cur->undotype == ut_statename || (cur->undotype == ut_composit
					    && cur->u.composit.state !=
					    NULL)) {
      for (i = 0; i < fv->map->enccount; ++i)
	 if (fv->selected[i]
	     && ((gid = fv->map->map[i]) == -1 || sf->glyphs[gid] == NULL))
	    SFMakeChar(sf, fv->map, i);
   }
   cur = NULL;

   for (i = 0; i < fv->map->enccount; ++i)
      if (fv->selected[i]) {
	 j = -1;
	 if (cur == NULL) {
	    cur = &copybuffer;
	    if (cur->undotype == ut_multiple)
	       cur = cur->u.multiple.mult;
	 }
	 while (1) {
	    switch (cur->undotype) {
	      case ut_noop:
		 break;
	      case ut_statelookup:
		 SCPasteLookupsMid(SFMakeChar(sf, fv->map, i), cur, pasteinto,
				   list, backpairlist, &mc);
		 break;
	      case ut_state:
	      case ut_width:
	      case ut_vwidth:
	      case ut_lbearing:
	      case ut_rbearing:
	      case ut_statehint:
	      case ut_statename:
	      case ut_layers:
	      case ut_anchors:
		 if (!sf->hasvmetrics && cur->undotype == ut_vwidth) {
		    ff_post_error(_("No Vertical Metrics"),
				  _
				  ("This font does not have vertical metrics enabled.\nUse Element->Font Info to enable them."));
		    goto err;
		 }
		 PasteToSC(SFMakeChar(sf, fv->map, i), fv->active_layer, cur,
			   fv, pasteinto, trans, &mc, &refstate,
			   &already_complained);
		 break;
	      case ut_bitmapsel:
	      case ut_bitmap:
		 if (onlycopydisplayed && fv->active_bitmap != NULL)
		    _PasteToBC(BDFMakeChar(fv->active_bitmap, fv->map, i),
			       fv->active_bitmap->pixelsize,
			       BDFDepth(fv->active_bitmap), cur, !pasteinto);
		 else {
		    for (bdf = sf->bitmaps;
			 bdf != NULL
			 && (bdf->pixelsize != cur->u.bmpstate.pixelsize
			     || BDFDepth(bdf) != cur->u.bmpstate.depth);
			 bdf = bdf->next);
		    if (bdf == NULL) {
		       bdf =
			  BitmapCreateCheck(fv, &yestoall, first,
					    cur->u.bmpstate.pixelsize,
					    cur->u.bmpstate.depth);
		       first = false;
		    }
		    if (bdf != NULL)
		       _PasteToBC(BDFMakeChar(bdf, fv->map, i),
				  bdf->pixelsize, BDFDepth(bdf), cur,
				  !pasteinto);
		 }
		 break;
	      case ut_composit:
		 if (cur->u.composit.state != NULL)
		    PasteToSC(SFMakeChar(sf, fv->map, i), fv->active_layer,
			      cur->u.composit.state, fv, pasteinto, trans,
			      &mc, &refstate, &already_complained);
		 for (bmp = cur->u.composit.bitmaps; bmp != NULL;
		      bmp = bmp->next) {
		    for (bdf = sf->bitmaps;
			 bdf != NULL
			 && (bdf->pixelsize != bmp->u.bmpstate.pixelsize
			     || BDFDepth(bdf) != bmp->u.bmpstate.depth);
			 bdf = bdf->next);
		    if (bdf == NULL)
		       bdf =
			  BitmapCreateCheck(fv, &yestoall, first,
					    bmp->u.bmpstate.pixelsize,
					    bmp->u.bmpstate.depth);
		    if (bdf != NULL)
		       _PasteToBC(BDFMakeChar(bdf, fv->map, i),
				  bdf->pixelsize, BDFDepth(bdf), bmp,
				  !pasteinto);
		 }
		 first = false;
		 break;
	    }
	    ++j;
	    if (mm == NULL || mm->normal != origsf || j >= mm->instance_count)
	       break;
	    sf = mm->instances[j];
	 }
	 cur = cur->next;
      }
   /* If we copy glyphs from one font to another, and if some of those glyphs */
   /*  contain references, and the width of the original glyph is the same as */
   /*  the width of the original referred character, then we should make sure */
   /*  that the new width of the glyph is the same as the current width of   */
   /*  the referred char. We can't do this earlier because of foreward refs.  */
   for (i = 0; i < fv->map->enccount; ++i)
      if (fv->selected[i]) {
	 SplineChar *sc = SFMakeChar(sf, fv->map, i);

	 if (sc->layers[ly_fore].refs != NULL
	     && sc->layers[ly_fore].splines == NULL) {
	    RefChar *r;

	    for (r = sc->layers[ly_fore].refs; r != NULL; r = r->next) {
	       if (r->use_my_metrics) {
		  sc->vwidth = r->sc->vwidth;
		  if (sc->width != r->sc->width)
		     SCSynchronizeWidth(sc, r->sc->width, sc->width, NULL);
	       }
	    }
	 }
      }
 err:
   if (oldsel != fv->selected)
      free(oldsel);
   SFFinishMergeContext(&mc);
   free(list);
   free(backpairlist);
}

/* Look through the copy buffer. If it wasn't copied from the given font, then */
/*  we can stop. Otherwise: */
/*	If "from" is NULL, then remove all anchorpoints from the buffer */
/*	If "into" is NULL, then remove all anchorpoints with class "from" */
/*	Else replace the anchor class of all anchorpoints with class "from" with "info" */
static void _PasteAnchorClassManip(SplineFont * sf, AnchorClass * into,
				   AnchorClass * from) {
   Undoes *cur = &copybuffer, *temp;

   if (cur->undotype == ut_multiple)
      cur = cur->u.multiple.mult;
   while (cur != NULL) {
      temp = cur;
      switch (temp->undotype) {
	case ut_composit:
	   if (temp->u.composit.state == NULL)
	      break;
	   temp = temp->u.composit.state;
	   /* Fall through */ ;
	case ut_state:
	case ut_statehint:
	case ut_statename:
	   if (temp->copied_from != sf)
	      return;
	   if (from == NULL) {
	      AnchorPointsFree(temp->u.state.anchor);
	      temp->u.state.anchor = NULL;
	   } else
	      temp->u.state.anchor =
		 APAnchorClassMerge(temp->u.state.anchor, into, from);
	   break;
      }
      cur = cur->next;
   }
}

void PasteRemoveSFAnchors(SplineFont * sf) {
   _PasteAnchorClassManip(sf, NULL, NULL);
}

void PasteRemoveAnchorClass(SplineFont * sf, AnchorClass * dying) {
   _PasteAnchorClassManip(sf, NULL, dying);
}
