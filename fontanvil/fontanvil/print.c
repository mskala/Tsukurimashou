/* $Id: print.c 4532 2015-12-22 13:18:53Z mskala $ */
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
#include "sflayoutP.h"
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <ustring.h>
#include "utype.h"
#include <sys/types.h>
#if !defined(__MINGW32__)
#   include <sys/wait.h>
#endif
#include "print.h"

int pagewidth=0, pageheight=0;	/* In points */
char *printlazyprinter=NULL;
char *printcommand=NULL;
int printtype=pt_unknown;



/* ************************************************************************** */
/* ***************************** Printing Stuff ***************************** */
/* ************************************************************************** */

static int pdf_addobject(PI *pi) {
   if (pi->next_object==0) {
      pi->max_object=100;
      pi->object_offsets=malloc(pi->max_object * sizeof(int));
      pi->object_offsets[pi->next_object++]=0;	/* Object 0 is magic */
   } else if (pi->next_object >= pi->max_object) {
      pi->max_object += 100;
      pi->object_offsets =
	 realloc(pi->object_offsets, pi->max_object * sizeof(int));
   }
   pi->object_offsets[pi->next_object]=aftell(pi->out);
   afprintf(pi->out, "%d 0 obj\n", pi->next_object++);
   return (pi->next_object-1);
}

struct fontdesc {
   DBounds bb;
   double ascent, descent, capheight, xheight, avgwidth, maxwidth;
   double stemh, stemv;
   int flags;
};

struct opac_state {
   int isfill;
   float opacity;
   int obj;
};

struct glyph_res {
   int pattern_cnt, pattern_max;
   char **pattern_names;
   int *pattern_objs;
   int image_cnt, image_max;
   char **image_names;
   int *image_objs;
   int opacity_cnt, opacity_max;
   struct opac_state *opac_state;
};

#define GLYPH_RES_EMPTY { 0, 0, NULL, NULL, 0, 0, NULL, NULL, 0, 0, NULL }


void makePatName(char *buffer,
		 RefChar * ref, SplineChar * sc, int layer, int isstroke,
		 int isgrad) {
   /* In PDF patterns (which include gradients) are fixed to the page. They */
   /*  do not alter with the Current Transformation Matrix. So if we have */
   /*  a reference to a glyph, then every reference to the same glyph will */
   /*  need a different pattern description where that description involves */
   /*  the reference's transform matrix */

   if (ref==NULL)
      sprintf(buffer, "%s_ly%d_%s_%s", sc->name, layer,
	      isstroke?"stroke":"fill", isgrad?"grad":"pattern");
   else {
      /* PDF names are significant up to 127 chars long and can contain */
      /*  all kinds of odd characters, just no spaces or slashes, so this */
      /*  name should be legal */
      sprintf(buffer, "%s_trans_%g,%g,%g,%g,%g,%g_ly%d_%s_%s", sc->name,
	      (double) ref->transform[0], (double) ref->transform[1],
	      (double) ref->transform[2], (double) ref->transform[3],
	      (double) ref->transform[4], (double) ref->transform[5], layer,
	      isstroke?"stroke":"fill", isgrad?"grad":"pattern");
   }
}

static void pdf_BrushCheck(PI *pi,struct glyph_res *gr,struct brush *brush,
			   int isfill, int layer, SplineChar * sc,
			   RefChar * ref) {
   char buffer[400];
   int function_obj, shade_obj;
   int i, j;
   struct gradient *grad=brush->gradient;
   struct pattern *pat;

   if (grad != NULL) {
      function_obj=pdf_addobject(pi);
      afprintf(pi->out, "<<\n");
      afprintf(pi->out, "  /FunctionType 0\n");	/* Iterpolation between samples */
      afprintf(pi->out, "  /Domain [%g %g]\n",
	      (double) grad->grad_stops[0].offset,
	      (double) grad->grad_stops[grad->stop_cnt-1].offset);
      afprintf(pi->out, "  /Range [0 1.0 0 1.0 0 1.0]\n");
      afprintf(pi->out, "  /Size [%d]\n", grad->stop_cnt==2?2:101);
      afprintf(pi->out, "  /BitsPerSample 8\n");
      afprintf(pi->out, "  /Decode [0 1.0 0 1.0 0 1.0]\n");
      afprintf(pi->out, "  /Length %d\n", 3*(grad->stop_cnt==2?2:101));
      afprintf(pi->out, ">>\n");
      afprintf(pi->out, "stream\n");
      if (grad->stop_cnt==2) {
	 int col=grad->grad_stops[0].col;

	 if (col==COLOR_INHERITED)
	    col=0x000000;
	 aputc((col >> 16)&0xff, pi->out);
	 aputc((col >> 8)&0xff, pi->out);
	 aputc((col)&0xff, pi->out);
	 col=grad->grad_stops[1].col;
	 if (col==COLOR_INHERITED)
	    col=0x000000;
	 aputc((col >> 16)&0xff, pi->out);
	 aputc((col >> 8)&0xff, pi->out);
	 aputc((col)&0xff, pi->out);
      } else {
	 /* Rather than try and figure out the minimum common divisor */
	 /*  off all the offsets, I'll just assume they are all percent */
	 for (i=0; i <= 100; ++i) {
	    int col;
	    double t=grad->grad_stops[0].offset +
	       (grad->grad_stops[grad->stop_cnt-1].offset -
		grad->grad_stops[0].offset)*i/100.0;
	    for (j=0; j<grad->stop_cnt; ++j)
	       if (t <= grad->grad_stops[j].offset)
		  break;
	    if (j==grad->stop_cnt)
	       col=grad->grad_stops[j-1].col;
	    else if (t==grad->grad_stops[j].offset)
	       col=grad->grad_stops[j].col;
	    else {
	       double percent =
		  (t -
		   grad->grad_stops[j -
				    1].offset)/(grad->grad_stops[j].offset -
						  grad->grad_stops[j -
								   1].offset);
	       uint32_t col1=grad->grad_stops[j-1].col;
	       uint32_t col2=grad->grad_stops[j].col;

	       if (col1==COLOR_INHERITED)
		  col1=0x000000;
	       if (col2==COLOR_INHERITED)
		  col2=0x000000;
	       int red =
		  ((col1 >> 16)&0xff)*(1-percent) +
		  ((col2 >> 16)&0xff)*percent;
	       int green =
		  ((col1 >> 8)&0xff)*(1-percent) +
		  ((col2 >> 8)&0xff)*percent;
	       int blue =
		  ((col1)&0xff)*(1-percent)+((col2)&0xff)*percent;
	       col=(red << 16)|(green << 8)|blue;
	    }
	    if (col==COLOR_INHERITED)
	       col=0x000000;
	    aputc((col >> 16)&0xff, pi->out);
	    aputc((col >> 8)&0xff, pi->out);
	    aputc((col)&0xff, pi->out);
	 }
      }
      afprintf(pi->out, "\nendstream\n");
      afprintf(pi->out, "endobj\n");

      shade_obj=pdf_addobject(pi);
      afprintf(pi->out, "<<\n");
      afprintf(pi->out, "  /ShadingType %d\n", grad->radius==0?2:3);
      afprintf(pi->out, "  /ColorSpace /DeviceRGB\n");
      if (grad->radius==0) {
	 afprintf(pi->out, "  /Coords [%g %g %g %g]\n",
		 (double) grad->start.x, (double) grad->start.y,
		 (double) grad->stop.x, (double) grad->stop.y);
      } else {
	 afprintf(pi->out, "  /Coords [%g %g 0 %g %g %g]\n",
		 (double) grad->start.x, (double) grad->start.y,
		 (double) grad->stop.x, (double) grad->stop.y,
		 (double) grad->radius);
      }
      afprintf(pi->out, "  /Function %d 0 R\n", function_obj);
      afprintf(pi->out, "  /Extend [true true]\n");	/* implies pad */
      afprintf(pi->out, ">>\n");
      afprintf(pi->out, "endobj\n");

      if (gr->pattern_cnt >= gr->pattern_max) {
	 gr->pattern_names =
	    realloc(gr->pattern_names,
		    (gr->pattern_max += 100)*sizeof(char *));
	 gr->pattern_objs =
	    realloc(gr->pattern_objs, (gr->pattern_max)*sizeof(int));
      }
      makePatName(buffer, ref, sc, layer, !isfill, true);
      gr->pattern_names[gr->pattern_cnt]=fastrdup(buffer);
      gr->pattern_objs[gr->pattern_cnt++]=pdf_addobject(pi);
      afprintf(pi->out, "<<\n");
      afprintf(pi->out, "  /Type /Pattern\n");
      afprintf(pi->out, "  /PatternType 2\n");
      afprintf(pi->out, "  /Shading %d 0 R\n", shade_obj);
      afprintf(pi->out, ">>\n");
      afprintf(pi->out, "endobj\n");
   } else if ((pat=brush->pattern) != NULL) {
      SplineChar *pattern_sc=SFGetChar(sc->parent, -1, pat->pattern);
      DBounds b;
      double scale[6], result[6];
      int respos, resobj;
      int lenpos, lenstart, len;

      if (pattern_sc==NULL)
	 ErrorMsg(2,"No glyph named %s, used as a pattern in %s\n",
		  pat->pattern, sc->name);
      PatternSCBounds(pattern_sc, &b);

      if (gr->pattern_cnt >= gr->pattern_max) {
	 gr->pattern_names =
	    realloc(gr->pattern_names,
		    (gr->pattern_max += 100)*sizeof(char *));
	 gr->pattern_objs =
	    realloc(gr->pattern_objs, (gr->pattern_max)*sizeof(int));
      }
      makePatName(buffer, ref, sc, layer, !isfill, false);
      gr->pattern_names[gr->pattern_cnt]=fastrdup(buffer);
      gr->pattern_objs[gr->pattern_cnt++]=pdf_addobject(pi);
      afprintf(pi->out, "<<\n");
      afprintf(pi->out, "  /Type /Pattern\n");
      afprintf(pi->out, "  /PatternType 1\n");
      afprintf(pi->out, "  /PaintType 1\n");	/* The intricacies of uncolored tiles are not something into which I wish to delve */
      afprintf(pi->out, "  /TilingType 1\n");
      afprintf(pi->out, "  /BBox [%g %g %g %g]\n", (double) b.minx,
	      (double) b.miny, (double) b.maxx, (double) b.maxy);
      afprintf(pi->out, "  /XStep %g\n", (double) (b.maxx-b.minx));
      afprintf(pi->out, "  /YStep %g\n", (double) (b.maxy-b.miny));
      memset(scale, 0, sizeof(scale));
      scale[0]=pat->width/(b.maxx-b.minx);
      scale[3]=pat->height/(b.maxy-b.miny);
      MatMultiply(scale, pat->transform, result);
      afprintf(pi->out, "  /Matrix [%g %g %g %g %g %g]\n", (double) result[0],
	      (double) result[1], (double) result[2], (double) result[3],
	      (double) result[4], (double) result[5]);
      afprintf(pi->out, "    /Resources ");
      respos=aftell(pi->out);
      afprintf(pi->out, "000000 0 R\n");
      afprintf(pi->out, "    /Length ");
      lenpos=aftell(pi->out);
      afprintf(pi->out, "00000000\n");
      afprintf(pi->out, ">>\n");
      afprintf(pi->out, " stream \n");
      lenstart=aftell(pi->out);
      SC_PSDump(pi->out,pattern_sc,true,true,ly_all);
      len=aftell(pi->out)-lenstart;
      afprintf(pi->out, " endstream\n");
      afprintf(pi->out, "endobj\n");

      resobj=PdfDumpGlyphResources(pi, pattern_sc);
      afseek(pi->out, respos, SEEK_SET);
      afprintf(pi->out, "%6d", resobj);
      afseek(pi->out, lenpos, SEEK_SET);
      afprintf(pi->out, "%8d", len);
      afseek(pi->out, 0, SEEK_END);
   }
   if (brush->opacity<1.0 && brush->opacity >= 0) {
      for (i=gr->opacity_cnt-1; i >= 0; --i) {
	 if (brush->opacity==gr->opac_state[i].opacity
	     && isfill==gr->opac_state[i].opacity)
	    break;		/* Already done */
      }
      if (i==-1) {
	 if (gr->opacity_cnt >= gr->opacity_max) {
	    gr->opac_state =
	       realloc(gr->opac_state,
		       (gr->opacity_max += 100)*sizeof(struct opac_state));
	 }
	 gr->opac_state[gr->opacity_cnt].opacity=brush->opacity;
	 gr->opac_state[gr->opacity_cnt].isfill=isfill;
	 gr->opac_state[gr->opacity_cnt].obj=function_obj =
	    pdf_addobject(pi);
	 ++gr->opacity_cnt;
	 afprintf(pi->out, "<<\n");
	 afprintf(pi->out, "  /Type /ExtGState\n");
	 if (isfill)
	    afprintf(pi->out, "  /ca %g\n", brush->opacity);
	 else
	    afprintf(pi->out, "  /CA %g\n", brush->opacity);
	 afprintf(pi->out, "  /AIS false\n");	/* alpha value */
	 afprintf(pi->out, ">>\n");
	 afprintf(pi->out, "endobj\n\n");
      }
   }
}

static void pdf_ImageCheck(PI *pi,struct glyph_res *gr,ImageList *images,
			   int layer, SplineChar * sc) {
   char buffer[400];
   int icnt=0;
   GImage *img;
   struct _GImage *base;
   int i;

   while (images != NULL) {
      img=images->image;
      base=img->list_len==0?img->u.image:img->u.images[1];

      if (gr->image_cnt >= gr->image_max) {
	 gr->image_names =
	    realloc(gr->image_names, (gr->image_max += 100)*sizeof(char *));
	 gr->image_objs =
	    realloc(gr->image_objs, (gr->image_max)*sizeof(int));
      }
      sprintf(buffer, "%s_ly%d_%d_image", sc->name, layer, icnt);
      gr->image_names[gr->image_cnt]=fastrdup(buffer);
      gr->image_objs[gr->image_cnt++]=pdf_addobject(pi);
      ++icnt;

      afprintf(pi->out, "<<\n");
      afprintf(pi->out, "  /Type /XObject\n");
      afprintf(pi->out, "  /Subtype /Image\n");
      afprintf(pi->out, "  /Width %d\n", base->width);
      afprintf(pi->out, "  /Height %d\n", base->height);
      if (base->image_type==it_mono) {
	 afprintf(pi->out, "  /BitsPerComponent 1\n");
	 afprintf(pi->out, "  /ImageMask true\n");
	 afprintf(pi->out, "  /Length %d\n",
		 base->height * base->bytes_per_line);
      } else if (base->image_type==it_true) {
	 afprintf(pi->out, "  /BitsPerComponent 8\n");
	 afprintf(pi->out, "  /ColorSpace /DeviceRGB\n");
	 afprintf(pi->out, "  /Length %d\n", base->height * base->width*3);
      } else if (base->image_type==it_index) {
	 afprintf(pi->out, "  /BitsPerComponent 8\n");
	 afprintf(pi->out, "  /ColorSpace [/Indexed /DeviceRGB %d\n<",
		 base->clut->clut_len);
	 for (i=0; i<base->clut->clut_len; ++i)
	    afprintf(pi->out, "%06x ", base->clut->clut[i]);
	 afprintf(pi->out, ">\n");
	 afprintf(pi->out, "  /Length %d\n", base->height * base->width);
      }
      afprintf(pi->out, ">>\n");
      afprintf(pi->out, "stream\n");
      if (base->image_type != it_true) {
	 afwrite(base->data, 1, base->height * base->bytes_per_line, pi->out);
      } else {
	 /* My image representation of colors includes a pad byte, pdf's does not */
	 uint32_t *pt=(uint32_t *) base->data;

	 for (i=0; i<base->width * base->height; ++i, ++pt) {
	    int red=(*pt >> 16)&0xff;
	    int green=(*pt >> 8)&0xff;
	    int blue=(*pt)&0xff;

	    aputc(red, pi->out);
	    aputc(green, pi->out);
	    aputc(blue, pi->out);
	 }
      }
      afprintf(pi->out, "\nendstream\n");
      afprintf(pi->out, "endobj\n");
      images=images->next;
   }
}

/* We need different gradients and patterns for different transform */
/*  matrices of references to the same glyph. Sigh. */
int PdfDumpGlyphResources(PI * pi, SplineChar * sc) {
   int resobj;
   struct glyph_res gr=GLYPH_RES_EMPTY;
   int i;
   int layer;
   RefChar *ref;

   for (layer=ly_fore; layer<sc->layer_cnt; ++layer) {
      if (sc->layers[layer].dofill)
	 pdf_BrushCheck(pi, &gr, &sc->layers[layer].fill_brush, true, layer,
			sc, NULL);
      if (sc->layers[layer].dostroke)
	 pdf_BrushCheck(pi, &gr, &sc->layers[layer].stroke_pen.brush, false,
			layer, sc, NULL);
      pdf_ImageCheck(pi, &gr, sc->layers[layer].images, layer, sc);
      for (ref=sc->layers[layer].refs; ref != NULL; ref=ref->next) {
	 for (i=0; i<ref->layer_cnt; ++i) {
	    if (ref->layers[i].dofill)
	       pdf_BrushCheck(pi, &gr, &ref->layers[i].fill_brush, true, i,
			      ref->sc, ref);
	    if (ref->layers[i].dostroke)
	       pdf_BrushCheck(pi, &gr, &ref->layers[i].stroke_pen.brush,
			      false, i, ref->sc, ref);
	    pdf_ImageCheck(pi, &gr, ref->layers[i].images, i, ref->sc);
	 }
      }
   }
   resobj=pdf_addobject(pi);
   afprintf(pi->out, "<<\n");
   if (gr.pattern_cnt != 0) {
      afprintf(pi->out, "  /Pattern <<\n");
      for (i=0; i<gr.pattern_cnt; ++i) {
	 afprintf(pi->out, "    /%s %d 0 R\n", gr.pattern_names[i],
		 gr.pattern_objs[i]);
	 free(gr.pattern_names[i]);
      }
      free(gr.pattern_names);
      free(gr.pattern_objs);
      afprintf(pi->out, "  >>\n");
   }
   if (gr.image_cnt != 0) {
      afprintf(pi->out, "  /XObject <<\n");
      for (i=0; i<gr.image_cnt; ++i) {
	 afprintf(pi->out, "    /%s %d 0 R\n", gr.image_names[i],
		 gr.image_objs[i]);
	 free(gr.image_names[i]);
      }
      free(gr.image_names);
      free(gr.image_objs);
      afprintf(pi->out, "  >>\n");
   }
   if (gr.opacity_cnt != 0) {
      afprintf(pi->out, "  /ExtGState <<\n");
      for (i=0; i<gr.opacity_cnt; ++i) {
	 afprintf(pi->out, "    /gs_%s_opacity_%g %d 0 R\n",
		 gr.opac_state[i].isfill?"fill":"stroke",
		 gr.opac_state[i].opacity, gr.opac_state[i].obj);
      }
      free(gr.opac_state);
      afprintf(pi->out, "  >>\n");
   }
   afprintf(pi->out, ">>\n");
   afprintf(pi->out, "endobj\n\n");
   return (resobj);
}
