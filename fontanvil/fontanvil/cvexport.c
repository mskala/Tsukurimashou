/* $Id: cvexport.c 4464 2015-11-30 09:57:27Z mskala $ */
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
#include <string.h>
#include "gfile.h"
#include <time.h>
#include "ustring.h"
#include "print.h"		/* For pdf output routines */
#include <utype.h>

static void EpsGeneratePreview(AFILE *eps,SplineChar *sc,int layer,
			       DBounds * b) {
   double scale,temp;
   int pixelsize,depth;
   BDFChar *bdfc;
   int i,j;

   /* Try for a preview that fits within a 72x72 box */
   if (b->maxx==b->minx || b->maxy==b->miny)
      return;
   scale=72.0 / (b->maxx - b->minx);
   temp=72.0 / (b->maxy - b->miny);
   if (temp < scale)
      scale=temp;
   pixelsize=rint((sc->parent->ascent + sc->parent->descent) * scale);

   depth=4;
   bdfc=SplineCharFreeTypeRasterizeNoHints(sc, layer, pixelsize, 72, 4);
   if (bdfc==NULL)
      bdfc=SplineCharAntiAlias(sc, pixelsize, layer, 4);
   if (bdfc==NULL)
      return;

   afprintf(eps, "%%%%BeginPreview: %d %d %d %d\n",
	   bdfc->xmax - bdfc->xmin + 1, bdfc->ymax - bdfc->ymin + 1, depth,
	   bdfc->ymax - bdfc->ymin + 1);
   for (i=0; i <= bdfc->ymax - bdfc->ymin; ++i) {
      aputc('%', eps);
      for (j=0; j <= bdfc->xmax - bdfc->xmin; ++j)
	 afprintf(eps, "%X", bdfc->bitmap[i * bdfc->bytes_per_line + j]);
      if (!((bdfc->xmax - bdfc->xmin) & 1))
	 aputc('0', eps);
      aputc('\n', eps);
   }
   BDFCharFree(bdfc);
   afprintf(eps, "%%%%EndPreview\n");
}

int _ExportEPS(AFILE *eps, SplineChar * sc, int layer, int preview) {
   DBounds b;
   time_t now;
   struct tm *tm;
   int ret;
   char oldloc[24];

   strcpy(oldloc, setlocale(LC_NUMERIC, NULL));
   setlocale(LC_NUMERIC, "C");

   afprintf(eps, "%%!PS-Adobe-3.0 EPSF-3.0\n");
   SplineCharLayerFindBounds(sc, layer, &b);
   afprintf(eps, "%%%%BoundingBox: %g %g %g %g\n", (double) b.minx,
	   (double) b.miny, (double) b.maxx, (double) b.maxy);
   afprintf(eps, "%%%%Pages: 0\n");
   afprintf(eps, "%%%%Title: %s from %s\n", sc->name, sc->parent->fontname);
   afprintf(eps, "%%%%Creator: FontAnvil\n");
   time(&now);
   tm=localtime(&now);
   afprintf(eps, "%%%%CreationDate: %d:%02d %d-%d-%d\n", tm->tm_hour,
	   tm->tm_min, tm->tm_mday, tm->tm_mon + 1, 1900 + tm->tm_year);
   if (sc->parent->multilayer) {
      int ly, had_grad=0, had_pat=0;

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
      if (had_grad)
	 afprintf(eps, "%%%%LanguageLevel: 3\n");
      else if (had_pat)
	 afprintf(eps, "%%%%LanguageLevel: 2\n");
   }
   afprintf(eps, "%%%%EndComments\n");
   if (preview)
      EpsGeneratePreview(eps, sc, layer, &b);
   afprintf(eps, "%%%%EndProlog\n");
   afprintf(eps, "%%%%Page \"%s\" 1\n", sc->name);

   afprintf(eps, "gsave newpath\n");
   SC_PSDump(eps,sc,true,false,layer);
   if (sc->parent->multilayer)
      afprintf(eps, "grestore\n");
   else if (sc->parent->strokedfont)
      afprintf(eps, "%g setlinewidth stroke grestore\n",
	      (double) sc->parent->strokewidth);
   else
      afprintf(eps, "fill grestore\n");
   afprintf(eps, "%%%%EOF\n");
   ret=!aferror(eps);
   setlocale(LC_NUMERIC, oldloc);
   return (ret);
}

static int ExportEPS(char *filename,SplineChar *sc,int layer) {
   AFILE *eps;
   int ret;

   eps=afopen(filename, "w");
   if (eps==NULL) {
      return (0);
   }
   ret=_ExportEPS(eps, sc, layer, true);
   afclose(eps);
   return (ret);
}

int _ExportPDF(AFILE *pdf, SplineChar * sc, int layer) {
/* TODO: Note, maybe this routine can be combined with print.c dump_pdfprologue() */
   DBounds b;
   time_t now;
   struct tm *tm;
   int ret;
   char oldloc[24];
   int _objlocs[8], xrefloc, streamstart, streamlength, resid, nextobj;
   int *objlocs=_objlocs;
   int i;

   SFUntickAll(sc->parent);
   strcpy(oldloc, setlocale(LC_NUMERIC, NULL));
   setlocale(LC_NUMERIC, "C");

   afprintf(pdf, "%%PDF-1.4\n%%\201\342\202\203\n");	/* Header comment + binary comment */
   /* Every document contains a catalog which points to a page tree, which */
   /*  in our case, points to a single page */
   objlocs[1]=aftell(pdf);
   afprintf(pdf,
	   "1 0 obj\n << /Type /Catalog\n    /Pages 2 0 R\n    /PageMode /UseNone\n >>\nendobj\n");
   objlocs[2]=aftell(pdf);
   afprintf(pdf,
	   "2 0 obj\n << /Type /Pages\n    /Kids [ 3 0 R ]\n    /Count 1\n >>\nendobj\n");
   /* And our single page points to its contents */
   objlocs[3]=aftell(pdf);
   afprintf(pdf, "3 0 obj\n");
   afprintf(pdf, " << /Type /Page\n");
   afprintf(pdf, "    /Parent 2 0 R\n");
   afprintf(pdf, "    /Resources ");
   if (sc->parent->multilayer) {
      resid=aftell(pdf);
      afprintf(pdf, "000000 0 R\n");
   } else
      afprintf(pdf, "<< >>\n");
   SplineCharLayerFindBounds(sc, layer, &b);
   afprintf(pdf, "    /MediaBox [%g %g %g %g]\n", (double) b.minx,
	   (double) b.miny, (double) b.maxx, (double) b.maxy);
   afprintf(pdf, "    /Contents 4 0 R\n");
   afprintf(pdf, " >>\n");
   afprintf(pdf, "endobj\n");
   /* And the contents are the interesting stuff */
   objlocs[4]=aftell(pdf);
   afprintf(pdf, "4 0 obj\n");
   afprintf(pdf, " << /Length 5 0 R >> \n");
   afprintf(pdf, " stream \n");
   streamstart=aftell(pdf);
   SC_PSDump(pdf,sc,true,true,layer);
   if (sc->parent->multilayer)
      /* Already filled or stroked */ ;
   else if (sc->parent->strokedfont)
      afprintf(pdf, "%g w S\n", (double) sc->parent->strokewidth);
   else
      afprintf(pdf, "f\n");
   streamlength=aftell(pdf) - streamstart;
   afprintf(pdf, " endstream\n");
   afprintf(pdf, "endobj\n");
   objlocs[5]=aftell(pdf);
   afprintf(pdf, "5 0 obj\n");
   afprintf(pdf, " %d\n", (int) streamlength);
   afprintf(pdf, "endobj\n");

   /* Optional Info dict */
   objlocs[6]=aftell(pdf);
   afprintf(pdf, "6 0 obj\n");
   afprintf(pdf, " <<\n");
   afprintf(pdf, "    /Creator (FontAnvil)\n");
   time(&now);
   tm=localtime(&now);
   afprintf(pdf, "    /CreationDate (D:%04d%02d%02d%02d%02d%02d",
	   1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
	   tm->tm_hour, tm->tm_min, tm->tm_sec);
#ifdef _NO_TZSET
   afprintf(pdf, "Z)\n");
#else
   tzset();
   if (timezone==0)
      afprintf(pdf, "Z)\n");
   else {
      if (timezone < 0)		/* fprintf bug - this is a kludge to print +/- in front of a %02d-padded value */
	 afprintf(pdf, "-");
      else
	 afprintf(pdf, "+");
      afprintf(pdf, "%02d'%02d')\n", (int) (timezone / 3600),
	      (int) (timezone / 60 - (timezone / 3600) * 60));
   }
#endif
   afprintf(pdf, "    /Title (%s from %s)\n", sc->name, sc->parent->fontname);
   afprintf(pdf, " >>\n");

   nextobj=7;
   if (sc->parent->multilayer) {
      PI pi;
      int resobj;

      memset(&pi, 0, sizeof(pi));
      pi.out=pdf;
      pi.max_object=100;
      pi.object_offsets=malloc(pi.max_object * sizeof(int));
      memcpy(pi.object_offsets, objlocs, nextobj * sizeof(int));
      pi.next_object=nextobj;
      resobj=PdfDumpGlyphResources(&pi, sc);
      nextobj=pi.next_object;
      objlocs=pi.object_offsets;
      afseek(pdf, resid, SEEK_SET);
      afprintf(pdf, "%06d", resobj);
      afseek(pdf, 0, SEEK_END);
   }

   xrefloc=aftell(pdf);
   afprintf(pdf, "xref\n");
   afprintf(pdf, " 0 %d\n", nextobj);
   afprintf(pdf, "0000000000 65535 f \n");
   for (i=1; i < nextobj; ++i)
      afprintf(pdf, "%010d %05d n \n", (int) objlocs[i], 0);
   afprintf(pdf, "trailer\n");
   afprintf(pdf, " <<\n");
   afprintf(pdf, "    /Size %d\n", nextobj);
   afprintf(pdf, "    /Root 1 0 R\n");
   afprintf(pdf, "    /Info 6 0 R\n");
   afprintf(pdf, " >>\n");
   afprintf(pdf, "startxref\n");
   afprintf(pdf, "%d\n", (int) xrefloc);
   afprintf(pdf, "%%%%EOF\n");

   if (objlocs != _objlocs)
      free(objlocs);

   ret=!aferror(pdf);
   setlocale(LC_NUMERIC, oldloc);
   return (ret);
}

static int ExportPDF(char *filename,SplineChar *sc,int layer) {
   AFILE *eps;
   int ret;

   eps=afopen(filename, "w");
   if (eps==NULL) {
      return (0);
   }
   ret=_ExportPDF(eps, sc, layer);
   afclose(eps);
   return (ret);
}


int _ExportPlate(AFILE *plate, SplineChar * sc, int layer) {
   char oldloc[24];
   int do_open;
   SplineSet *ss;
   spiro_cp *spiros;
   int i, ret;

   strcpy(oldloc, setlocale(LC_NUMERIC, NULL));
   setlocale(LC_NUMERIC, "C");
   /* Output closed contours first, then open. Plate files can only handle */
   /*  one open contour (I think) and it must be at the end */
   afprintf(plate, "(plate\n");
   for (do_open=0; do_open < 2; ++do_open) {
      for (ss=sc->layers[layer].splines; ss != NULL; ss=ss->next) {
	 if (ss->first->prev==NULL) {
	    if (!do_open || ss->first->next==NULL)
	       continue;
	 } else {
	    if (do_open)
	       continue;
	 }
	 spiros=ss->spiros;
	 if (ss->spiro_cnt==0)
	    spiros=SplineSet2SpiroCP(ss, NULL);
	 for (i=0; spiros[i].ty != 'z'; ++i) {
	    if (spiros[i].ty==SPIRO_OPEN_CONTOUR)
	       afprintf(plate, "  (o ");
	    else
	       afprintf(plate, "  (%c ", spiros[i].ty & ~0x80);
	    /* Raph's plate files have the baseline way up in the air */
	    afprintf(plate, "%g %g)\n", spiros[i].x, 800. - spiros[i].y);
	 }
	 if (ss->first->prev != NULL)
	    afprintf(plate, "  (z)\n");
	 if (spiros != ss->spiros)
	    free(spiros);
      }
   }
   afprintf(plate, ")\n");
   ret=!aferror(plate);
   setlocale(LC_NUMERIC, oldloc);
   return (ret);
}

static int ExportPlate(char *filename,SplineChar *sc,int layer) {
   AFILE *plate;
   int ret;

   plate=afopen(filename, "w");
   if (plate==NULL) {
      return (0);
   }
   ret=_ExportPlate(plate, sc, layer);
   afclose(plate);
   return (ret);
}

static int ExportSVG(char *filename,SplineChar *sc,int layer) {
   AFILE *svg;
   int ret;

   svg=afopen(filename, "w");
   if (svg==NULL) {
      return (0);
   }
   ret=_ExportSVG(svg, sc, layer);
   afclose(svg);
   return (ret);
}

static int ExportGlif(char *filename,SplineChar *sc,int layer) {
   AFILE *glif;
   int ret;

   glif=afopen(filename, "w");
   if (glif==NULL) {
      return (0);
   }
   ret=_ExportGlif(glif, sc, layer);
   return (ret);
}

static void FigDumpPt(AFILE *fig,BasePoint *me,double scale,double ascent) {
   afprintf(fig, "%d %d ", (int) rint(me->x * scale),
	   (int) rint(ascent - me->y * scale));
}

static void FigSplineSet(AFILE *fig,SplineSet *spl,int spmax,int asc) {
   SplinePoint *sp;
   int cnt;
   double scale=7 * 1200.0 / spmax;
   double ascent=11 * 1200 * asc / spmax;

   while (spl != NULL) {
      /* type=3, SPline; sub_type=3, closed interpreted; linestyle=0(solid); thickness=1 */
      /*  colors (pen,fill)=0, black; depth=0(stacking order); pen_style(unused) */
      /*  area_fill=-1 (no fill) style_val (0.0 no dashes), capstyle=0 (don't care) */
      /*  forward arrow=0 (none) backarrow (none); point count */
      cnt=0;
      sp=spl->first;
      while (1) {
	 ++cnt;
	 if (!sp->noprevcp && sp->prev != NULL)
	    ++cnt;
	 if (!sp->nonextcp && sp->next != NULL)
	    ++cnt;
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==spl->first)
	    break;
      }
      if (spl->first->prev != NULL) {
	 /* Must end with the start point if it's closed */
	 ++cnt;
      }
      afprintf(fig, "3 %d 0 1 0 0 0 0 -1 0.0 0 0 0 %d\n",
	      spl->first->prev==NULL ? 4 : 5, cnt);
      /* line of coordinates pairs */
      sp=spl->first;
      aputc('\t', fig);
      while (1) {
	 if (!sp->noprevcp && sp->prev != NULL && sp != spl->first)
	    FigDumpPt(fig, &sp->prevcp, scale, ascent);
	 FigDumpPt(fig, &sp->me, scale, ascent);
	 if (!sp->nonextcp && sp->next != NULL)
	    FigDumpPt(fig, &sp->nextcp, scale, ascent);
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==spl->first)
	    break;
      }
      if (spl->first->prev != NULL) {
	 /* Must end with the start point if it's closed */
	 if (!sp->noprevcp && sp->prev != NULL)
	    FigDumpPt(fig, &sp->prevcp, scale, ascent);
	 FigDumpPt(fig, &sp->me, scale, ascent);
      }
      /* line of "shape factors", 0=> corner */
      aputc('\n', fig);
      sp=spl->first;
      aputc('\t', fig);
      while (1) {
	 if (!sp->noprevcp && sp->prev != NULL && sp != spl->first)
	    afprintf(fig, "1 ");
	 if ((sp->noprevcp && sp->nonextcp) || sp->pointtype==pt_corner)
	    afprintf(fig, "0 ");
	 else
	    afprintf(fig, "-1 ");
	 if (!sp->nonextcp && sp->next != NULL)
	    afprintf(fig, "1 ");
	 if (sp->next==NULL)
	    break;
	 sp=sp->next->to;
	 if (sp==spl->first)
	    break;
      }
      if (spl->first->prev != NULL) {
	 /* Must end with the start point if it's closed */
	 if (!sp->noprevcp && sp->prev != NULL)
	    afprintf(fig, "1 ");
	 if ((sp->noprevcp && sp->nonextcp) || sp->pointtype==pt_corner)
	    afprintf(fig, "0 ");
	 else
	    afprintf(fig, "-1 ");
      }
      aputc('\n', fig);
      spl=spl->next;
   }
}

static int ExportFig(char *filename,SplineChar *sc,int layer) {
   AFILE *fig;
   RefChar *rf;
   int ret;
   int spmax=sc->parent->ascent + sc->parent->descent;

   /* This is by no means perfect. but it is a reasonable approximation */

   fig=afopen(filename, "w");
   if (fig==NULL) {
      return (0);
   }

   afprintf(fig, "#FIG 3.2\n");
   afprintf(fig, "Portrait\n");
   afprintf(fig, "Center\n");
   afprintf(fig, "Inches\n");
   afprintf(fig, "Letter\n");
   afprintf(fig, "100.00\n");
   afprintf(fig, "Single\n");
   afprintf(fig, "-2\n");
   afprintf(fig, "1200 2\n");
   FigSplineSet(fig, sc->layers[layer].splines, spmax, sc->parent->ascent);
   for (rf=sc->layers[layer].refs; rf != NULL; rf=rf->next)
      FigSplineSet(fig, rf->layers[0].splines, spmax, sc->parent->ascent);
   ret=!aferror(fig);
   afclose(fig);
   return (ret);
}

int BCExportXBM(char *filename, BDFChar * bdfc, int format) {
   struct _GImage base;
   GImage gi;
   GClut clut;
   int ret;
   int tot;
   int scale, i;
   uint8_t *pt, *end;

   memset(&gi, '\0', sizeof(gi));
   memset(&base, '\0', sizeof(base));
   gi.u.image=&base;

   if (!bdfc->byte_data) {
      BCRegularizeBitmap(bdfc);
      /* Sigh. Bitmaps use a different defn of set than images do. make it consistant */
      tot=bdfc->bytes_per_line * (bdfc->ymax - bdfc->ymin + 1);
      for (pt=bdfc->bitmap, end=pt + tot; pt < end; *pt++ ^= 0xff);

      base.image_type=it_mono;
      base.data=bdfc->bitmap;
      base.bytes_per_line=bdfc->bytes_per_line;
      base.width=bdfc->xmax - bdfc->xmin + 1;
      base.height=bdfc->ymax - bdfc->ymin + 1;
      base.trans=-1;
      if (format==0)
	 ret=!GImageWriteXbm(&gi, filename);
#ifndef _NO_LIBPNG
      else if (format==2)
	 ret=GImageWritePng(&gi, filename, false);
#endif
      else if (format==3)
	 ret=!GImageWriteXpm(&gi, filename);
      else if (format==4)
	 ret=!GImageWriteGImage(&gi, filename);
      else
	 ret=GImageWriteBmp(&gi, filename);
      /* And back to normal */
      for (pt=bdfc->bitmap, end=pt + tot; pt < end; *pt++ ^= 0xff);
   } else {
      BCRegularizeGreymap(bdfc);
      base.image_type=it_index;
      base.data=bdfc->bitmap;
      base.bytes_per_line=bdfc->bytes_per_line;
      base.width=bdfc->xmax - bdfc->xmin + 1;
      base.height=bdfc->ymax - bdfc->ymin + 1;
      base.clut=&clut;
      clut.clut_len=1 << bdfc->depth;
      clut.is_grey=true;
      clut.trans_index=base.trans=-1;
      scale=255 / ((1 << bdfc->depth) - 1);
      scale=COLOR_CREATE(scale, scale, scale);
      for (i=0; i < 1 << bdfc->depth; ++i)
	 clut.clut[(1 << bdfc->depth) - 1 - i]=i * scale;
#ifndef _NO_LIBPNG
      if (format==2)
	 ret=GImageWritePng(&gi, filename, false);
      else
#endif
	 ret=GImageWriteBmp(&gi, filename);
   }
   return (ret);
}

static void MakeExportName(char *buffer,int blen,char *format_spec,
			   SplineChar * sc, EncMap * map) {
   char *end=buffer + blen - 3;
   char *pt, *bend;
   char unicode[8];
   int ch;

   while (*format_spec && buffer < end) {
      if (*format_spec != '%')
	 *buffer++=*format_spec++;
      else {
	 ++format_spec;
	 ch=*format_spec++;
	 if ((bend=buffer + 40) > end)
	    bend=end;
	 if (ch=='n') {
#if defined( __CygWin ) || defined(__Mac)
	    /* Windows file systems are not case conscious */
	    /*  nor is the default mac filesystem */
	    for (pt=sc->name; *pt != '\0' && buffer < bend;) {
	       if (isupper(*pt))
		  *buffer++='$';
	       *buffer++=*pt++;
	    }
#else
	    for (pt=sc->name; *pt != '\0' && buffer < bend;)
	       *buffer++=*pt++;
#endif
	 } else if (ch=='f') {
	    for (pt=sc->parent->fontname; *pt != '\0' && buffer < bend;)
	       *buffer++=*pt++;
	 } else if (ch=='u' || ch=='U') {
	    if (sc->unicodeenc==-1)
	       strcpy(unicode, "xxxx");
	    else
	       sprintf(unicode, ch=='u' ? "%04x" : "%04X", sc->unicodeenc);
	    for (pt=unicode; *pt != '\0' && buffer < bend;)
	       *buffer++=*pt++;
	 } else if (ch=='e') {
	    sprintf(unicode, "%d", (int) map->backmap[sc->orig_pos]);
	    for (pt=unicode; *pt != '\0' && buffer < bend;)
	       *buffer++=*pt++;
	 } else
	    *buffer++=ch;
      }
   }
   *buffer='\0';
}

void ScriptExport(SplineFont *sf, BDFFont * bdf, int format, int gid,
		  char *format_spec, EncMap * map) {
   char buffer[100];
   SplineChar *sc=sf->glyphs[gid];
   BDFChar *bc=bdf != NULL ? bdf->glyphs[gid] : NULL;
   int good=true;

   if (sc==NULL)
      return;

   MakeExportName(buffer, sizeof(buffer), format_spec, sc, map);

   if (format==0)
      good=ExportEPS(buffer, sc, ly_fore);
   else if (format==1)
      good=ExportFig(buffer, sc, ly_fore);
   else if (format==2)
      good=ExportSVG(buffer, sc, ly_fore);
   else if (format==3)
      good=ExportGlif(buffer, sc, ly_fore);
   else if (format==4)
      good=ExportPDF(buffer, sc, ly_fore);
   else if (format==5)
      good=ExportPlate(buffer, sc, ly_fore);
   else if (bc != NULL)
      good=BCExportXBM(buffer, bc, format - 6);
   if (!good)
      ErrorMsg(2,"Save failed\n");
}
