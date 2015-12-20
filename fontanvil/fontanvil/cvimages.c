/* $Id: cvimages.c 4525 2015-12-20 19:51:59Z mskala $ */
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
#include <sys/types.h>
#include <dirent.h>
#include "sd.h"
#include <ustring.h>
#include <utype.h>

void SCAppendEntityLayers(SplineChar * sc, Entity * ent) {
   int cnt, pos;
   Entity *e, *enext;
   Layer *old=sc->layers;
   SplineSet *ss;

   for (e=ent, cnt=0; e != NULL; e=e->next, ++cnt);
   pos=sc->layer_cnt;
   if (cnt==0)
      return;
   EntityDefaultStrokeFill(ent);

   sc->layers=realloc(sc->layers, (sc->layer_cnt+cnt) * sizeof(Layer));
   for (pos=sc->layer_cnt, e=ent; e != NULL; e=enext, ++pos) {
      enext=e->next;
      LayerDefault(&sc->layers[pos]);
      sc->layers[pos].splines=NULL;
      sc->layers[pos].refs=NULL;
      sc->layers[pos].images=NULL;
      if (e->type==et_splines) {
	 sc->layers[pos].dofill=e->u.splines.fill.col != 0xffffffff;
	 sc->layers[pos].dostroke=e->u.splines.stroke.col != 0xffffffff;
	 if (!sc->layers[pos].dofill && !sc->layers[pos].dostroke)
	    sc->layers[pos].dofill=true;	/* If unspecified, assume an implied fill in BuildGlyph */
	 sc->layers[pos].fill_brush.col =
	    e->u.splines.fill.col ==
	    0xffffffff?COLOR_INHERITED:e->u.splines.fill.col;
	 sc->layers[pos].fill_brush.gradient=e->u.splines.fill.grad;
	 /*!!!!!! pattern? */
	 sc->layers[pos].stroke_pen.brush.col =
	    e->u.splines.stroke.col ==
	    0xffffffff?COLOR_INHERITED:e->u.splines.stroke.col;
	 sc->layers[pos].stroke_pen.brush.gradient=e->u.splines.stroke.grad;
	 sc->layers[pos].stroke_pen.width=e->u.splines.stroke_width;
	 sc->layers[pos].stroke_pen.linejoin=e->u.splines.join;
	 sc->layers[pos].stroke_pen.linecap=e->u.splines.cap;
	 memcpy(sc->layers[pos].stroke_pen.trans, e->u.splines.transform,
		4 * sizeof(double));
	 sc->layers[pos].splines=e->u.splines.splines;
      } else if (e->type==et_image) {
	 ImageList *ilist=chunkalloc(sizeof(ImageList));

	 struct _GImage *base=e->u.image.image->list_len==0 ?
	    e->u.image.image->u.image:e->u.image.image->u.images[0];
	 sc->layers[pos].images=ilist;
	 sc->layers[pos].dofill=base->image_type==it_mono
	    && base->trans != -1;
	 sc->layers[pos].fill_brush.col =
	    e->u.image.col==0xffffffff?COLOR_INHERITED:e->u.image.col;
	 ilist->image=e->u.image.image;
	 ilist->xscale=e->u.image.transform[0];
	 ilist->yscale=e->u.image.transform[3];
	 ilist->xoff=e->u.image.transform[4];
	 ilist->yoff=e->u.image.transform[5];
	 ilist->bb.minx=ilist->xoff;
	 ilist->bb.maxy=ilist->yoff;
	 ilist->bb.maxx=ilist->xoff+base->width * ilist->xscale;
	 ilist->bb.miny=ilist->yoff-base->height * ilist->yscale;
      }
      if (e->clippath) {
	 for (ss=e->clippath; ss->next != NULL; ss=ss->next)
	    ss->is_clip_path=true;
	 ss->is_clip_path=true;
	 ss->next=sc->layers[pos].splines;
	 sc->layers[pos].splines=e->clippath;
      }
      free(e);
   }
   sc->layer_cnt += cnt;
}

void SCImportPSFile(SplineChar * sc, int layer, AFILE *ps, int doclear,
		    int flags) {
   SplinePointList *spl, *espl;
   SplineSet **head;
   int empty, width;

   if (ps==NULL)
      return;
   width=UNDEFINED_WIDTH;
   empty=sc->layers[layer].splines==NULL
      && sc->layers[layer].refs==NULL;
   if (sc->parent->multilayer && layer>ly_back) {
      SCAppendEntityLayers(sc, EntityInterpretPS(ps, &width));
   } else {
      spl =
	 SplinePointListInterpretPS(ps, flags, sc->parent->strokedfont,
				    &width);
      if (spl==NULL) {
	 ErrorMsg(2,"File is too complex, or bad\n");
	 return;
      }
      if (sc->layers[layer].order2)
	 spl=SplineSetsConvertOrder(spl, true);
      for (espl=spl; espl->next != NULL; espl=espl->next);
      if (layer==ly_grid)
	 head=&sc->parent->grid.splines;
      else {
	 SCPreserveLayer(sc, layer, false);
	 head=&sc->layers[layer].splines;
      }
      if (doclear) {
	 SplinePointListsFree(*head);
	 *head=NULL;
      }
      espl->next=*head;
      *head=spl;
   }
   if ((empty || doclear) && width != UNDEFINED_WIDTH)
      SCSynchronizeWidth(sc, width, sc->width, NULL);
   SCCharChangedUpdate(sc, layer, true);
}

void SCImportPS(SplineChar * sc, int layer, char *path, int doclear,
		int flags) {
   AFILE *ps=afopen(path, "r");

   if (ps==NULL)
      return;
   SCImportPSFile(sc, layer, ps, doclear, flags);
   afclose(ps);
}

void SCImportPDFFile(SplineChar * sc, int layer, AFILE *pdf, int doclear,
		     int flags) {
   SplinePointList *spl, *espl;
   SplineSet **head;

   if (pdf==NULL)
      return;

   if (sc->parent->multilayer && layer>ly_back) {
      SCAppendEntityLayers(sc, EntityInterpretPDFPage(pdf, -1));
   } else {
      spl =
	 SplinesFromEntities(EntityInterpretPDFPage(pdf, -1), &flags,
			     sc->parent->strokedfont);
      if (spl==NULL) {
	 ErrorMsg(2,"File is too complex, or bad\n");
	 return;
      }
      if (sc->layers[layer].order2)
	 spl=SplineSetsConvertOrder(spl, true);
      for (espl=spl; espl->next != NULL; espl=espl->next);
      if (layer==ly_grid)
	 head=&sc->parent->grid.splines;
      else {
	 SCPreserveLayer(sc, layer, false);
	 head=&sc->layers[layer].splines;
      }
      if (doclear) {
	 SplinePointListsFree(*head);
	 *head=NULL;
      }
      espl->next=*head;
      *head=spl;
   }
   SCCharChangedUpdate(sc, layer, true);
}

void SCImportPDF(SplineChar * sc, int layer, char *path, int doclear,
		 int flags) {
   AFILE *pdf=afopen(path, "r");

   if (pdf==NULL)
      return;
   SCImportPDFFile(sc, layer, pdf, doclear, flags);
   afclose(pdf);
}

#ifndef _NO_LIBXML
void SCImportSVG(SplineChar * sc, int layer, char *path, char *memory,
		 int memlen, int doclear) {
   SplinePointList *spl, *espl, **head;

   if (sc->parent->multilayer && layer>ly_back) {
      SCAppendEntityLayers(sc,
			   EntityInterpretSVG(path, memory, memlen,
					      sc->parent->ascent +
					      sc->parent->descent,
					      sc->parent->ascent));
   } else {
      spl =
	 SplinePointListInterpretSVG(path, memory, memlen,
				     sc->parent->ascent+sc->parent->descent,
				     sc->parent->ascent,
				     sc->parent->strokedfont);
      for (espl=spl; espl != NULL && espl->first->next==NULL;
	   espl=espl->next);
      if (espl != NULL)
	 if (espl->first->next->order2 != sc->layers[layer].order2)
	    spl=SplineSetsConvertOrder(spl, sc->layers[layer].order2);
      if (spl==NULL) {
	 ErrorMsg(2,"File is too complex, or bad\n");
	 return;
      }
      for (espl=spl; espl->next != NULL; espl=espl->next);
      if (layer==ly_grid)
	 head=&sc->parent->grid.splines;
      else {
	 SCPreserveLayer(sc, layer, false);
	 head=&sc->layers[layer].splines;
      }
      if (doclear) {
	 SplinePointListsFree(*head);
	 *head=NULL;
      }
      espl->next=*head;
      *head=spl;
   }
   SCCharChangedUpdate(sc, layer, true);
}

void SCImportGlif(SplineChar * sc, int layer, char *path, char *memory,
		  int memlen, int doclear) {
   SplinePointList *spl, *espl, **head;

   spl =
      SplinePointListInterpretGlif(sc->parent, path, memory, memlen,
				   sc->parent->ascent+sc->parent->descent,
				   sc->parent->ascent,
				   sc->parent->strokedfont);
   for (espl=spl; espl != NULL && espl->first->next==NULL;
	espl=espl->next);
   if (espl != NULL)
      if (espl->first->next->order2 != sc->layers[layer].order2)
	 spl=SplineSetsConvertOrder(spl, sc->layers[layer].order2);
   if (spl==NULL) {
	 ErrorMsg(2,"File is too complex, or bad\n");
      return;
   }
   for (espl=spl; espl->next != NULL; espl=espl->next);
   if (layer==ly_grid)
      head=&sc->parent->grid.splines;
   else {
      SCPreserveLayer(sc, layer, false);
      head=&sc->layers[layer].splines;
   }
   if (doclear) {
      SplinePointListsFree(*head);
      *head=NULL;
   }
   espl->next=*head;
   *head=spl;

   SCCharChangedUpdate(sc, layer, true);
}
#endif

/************************** Normal Image Import *******************************/

GImage *ImageAlterClut(GImage * image) {
   struct _GImage *base =
      image->list_len==0?image->u.image:image->u.images[0];
   GClut *clut;

   if (base->image_type != it_mono) {
      /* png b&w images come through as indexed, not mono */
      if (base->clut != NULL && base->clut->clut_len==2) {
	 GImage *new=GImageCreate(it_mono, base->width, base->height);

	 struct _GImage *nbase=new->u.image;
	 int i, j;

	 memset(nbase->data, 0, nbase->height * nbase->bytes_per_line);
	 for (i=0; i<base->height; ++i)
	    for (j=0; j<base->width; ++j)
	       if (base->data[i * base->bytes_per_line+j])
		  nbase->data[i * nbase->bytes_per_line+(j >> 3)] |=
		     (0x80 >> (j & 7));
	 nbase->clut=base->clut;
	 base->clut=NULL;
	 nbase->trans=base->trans;
	 GImageDestroy(image);
	 image=new;
	 base=nbase;
      } else
	 return (image);
   }

   clut=base->clut;
   if (clut==NULL) {
      clut=base->clut=calloc(1, sizeof(GClut));
      clut->clut_len=2;
      clut->clut[0]=0x808080;
      clut->clut[1]=0xb0b0b0;
      clut->trans_index=1;
      base->trans=1;
   } else if (base->trans != -1) {
      clut->clut[!base->trans]=0x808080;
   } else if (clut->clut[0]<clut->clut[1]) {
      clut->clut[0]=0x808080;
      clut->trans_index=1;
      base->trans=1;
   } else {
      clut->clut[1]=0x808080;
      clut->trans_index=0;
      base->trans=0;
   }
   return (image);
}

void SCInsertImage(SplineChar * sc, GImage * image, double scale, double yoff,
		   double xoff, int layer) {
   ImageList *im;

   SCPreserveLayer(sc, layer, false);
   im=malloc(sizeof(ImageList));
   im->image=image;
   im->xoff=xoff;
   im->yoff=yoff;
   im->xscale=im->yscale=scale;
   im->selected=true;
   im->next=sc->layers[layer].images;
   im->bb.minx=im->xoff;
   im->bb.maxy=im->yoff;
   im->bb.maxx=im->xoff+GImageGetWidth(im->image) * im->xscale;
   im->bb.miny=im->yoff-GImageGetHeight(im->image) * im->yscale;
   sc->layers[layer].images=im;
   sc->parent->onlybitmaps=false;
   SCCharChangedUpdate(sc, layer, true);
}

void SCAddScaleImage(SplineChar * sc, GImage * image, int doclear, int layer) {
   double scale;

   image=ImageAlterClut(image);
   scale =
      (sc->parent->ascent +
       sc->parent->descent)/(double) GImageGetHeight(image);
   if (doclear) {
      ImageListsFree(sc->layers[layer].images);
      sc->layers[layer].images=NULL;
   }
   SCInsertImage(sc, image, scale, sc->parent->ascent, 0, layer);
}

int FVImportImages(FontViewBase * fv, char *path, int format, int toback,
		   int flags) {
   GImage *image;

   /*struct _GImage *base; */
   int tot;
   char *start=path, *endpath=path;
   int i;
   SplineChar *sc;

   tot=0;
   for (i=0; i<fv->map->enccount; ++i)
      if (fv->selected[i]) {
	 sc=SFMakeChar(fv->sf, fv->map, i);
	 endpath=strchr(start, ';');
	 if (endpath != NULL)
	    *endpath='\0';
	 if (format==fv_image) {
	    image=GImageRead(start);
	    if (image==NULL) {
	       ErrorMsg(2,"Bad image file %.100s\n",start);
	       return (false);
	    }
	    ++tot;
	    SCAddScaleImage(sc, image, true, toback?ly_back:ly_fore);
#ifndef _NO_LIBXML
	 } else if (format==fv_svg) {
	    SCImportSVG(sc, toback?ly_back:fv->active_layer, start, NULL,
			0, flags & sf_clearbeforeinput);
	    ++tot;
	 } else if (format==fv_glif) {
	    SCImportGlif(sc, toback?ly_back:fv->active_layer, start, NULL,
			 0, flags & sf_clearbeforeinput);
	    ++tot;
#endif
	 } else if (format==fv_eps) {
	    SCImportPS(sc, toback?ly_back:fv->active_layer, start,
		       flags & sf_clearbeforeinput,
		       flags & ~sf_clearbeforeinput);
	    ++tot;
	 } else if (format==fv_pdf) {
	    SCImportPDF(sc, toback?ly_back:fv->active_layer, start,
			flags & sf_clearbeforeinput,
			flags & ~sf_clearbeforeinput);
	    ++tot;
	 }
	 if (endpath==NULL)
	    break;
	 start=endpath+1;
      }
   if (tot==0)
      ErrorMsg(2,"Nothing selected\n");
   else if (endpath != NULL)
      ErrorMsg(2,"More images than selected glyphs\n");
   return (true);
}

int FVImportImageTemplate(FontViewBase * fv, char *path, int format,
			  int toback, int flags) {
   GImage *image;
   struct _GImage *base;
   int tot;
   char *ext, *name, *dirname, *pt, *end;
   int i, val;
   int isu=false, ise=false, isc=false;
   DIR *dir;
   struct dirent *entry;
   SplineChar *sc;
   char start[1025];

   ext=strrchr(path, '.');
   name=strrchr(path, '/');
   if (ext==NULL) {
      ErrorMsg(2,"Bad template, no extension\n");
      return (false);
   }
   if (name==NULL)
      name=path-1;
   if (name[1]=='u')
      isu=true;
   else if (name[1]=='c')
      isc=true;
   else if (name[1]=='e')
      ise=true;
   else {
      ErrorMsg(2,"Bad template, unrecognized format\n");
      return (false);
   }
   if (name<path)
      dirname=".";
   else {
      dirname=path;
      *name='\0';
   }

   if ((dir=opendir(dirname))==NULL) {
      ErrorMsg(2,"Nothing loaded\n");
      return (false);
   }

   tot=0;
   while ((entry=readdir(dir)) != NULL) {
      pt=strrchr(entry->d_name, '.');
      if (pt==NULL)
	 continue;
      if (strmatch(pt, ext) != 0)
	 continue;
      if (!((isu && entry->d_name[0]=='u' && entry->d_name[1]=='n'
	     && entry->d_name[2]=='i'
	     && (val=strtol(entry->d_name+3, &end, 16), end==pt))
	    || (isu && entry->d_name[0]=='u'
		&& (val=strtol(entry->d_name+1, &end, 16), end==pt))
	    || (isc && entry->d_name[0]=='c' && entry->d_name[1]=='i'
		&& entry->d_name[2]=='d'
		&& (val=strtol(entry->d_name+3, &end, 10), end==pt))
	    || (ise && entry->d_name[0]=='e' && entry->d_name[1]=='n'
		&& entry->d_name[2]=='c'
		&& (val=strtol(entry->d_name+3, &end, 10), end==pt))))
	 continue;
      sprintf(start, "%s/%s", dirname, entry->d_name);
      if (isu) {
	 i=SFFindSlot(fv->sf, fv->map, val, NULL);
	 if (i==-1) {
            ErrorMsg(1,"Unicode value (%x) not in font, ignored\n",val);
	    continue;
	 }
	 sc=SFMakeChar(fv->sf, fv->map, i);
      } else {
	 if (val<fv->map->enccount) {
	    /* It's there */ ;
	 } else {
            ErrorMsg(1,"Encoding value (%x) not in font, ignored\n",val);
	    continue;
	 }
	 sc=SFMakeChar(fv->sf, fv->map, val);
      }
      if (format==fv_imgtemplate) {
	 image=GImageRead(start);
	 if (image==NULL) {
	    ErrorMsg(2,"Bad image file: %.100s\n",start);
	    continue;
	 }
	 base=image->list_len==0?image->u.image:image->u.images[0];
	 if (base->image_type != it_mono) {
            ErrorMsg(2,"Bad image file, not a bitmap: %.100s\n",start);
	    GImageDestroy(image);
	    continue;
	 }
	 ++tot;
	 SCAddScaleImage(sc, image, true, toback?ly_back:ly_fore);
#ifndef _NO_LIBXML
      } else if (format==fv_svgtemplate) {
	 SCImportSVG(sc, toback?ly_back:fv->active_layer, start, NULL, 0,
		     flags & sf_clearbeforeinput);
	 ++tot;
      } else if (format==fv_gliftemplate) {
	 SCImportGlif(sc, toback?ly_back:fv->active_layer, start, NULL, 0,
		      flags & sf_clearbeforeinput);
	 ++tot;
#endif
      } else if (format==fv_pdftemplate) {
	 SCImportPDF(sc, toback?ly_back:fv->active_layer, start,
		     flags & sf_clearbeforeinput,
		     flags & ~sf_clearbeforeinput);
	 ++tot;
      } else {
	 SCImportPS(sc, toback?ly_back:fv->active_layer, start,
		    flags & sf_clearbeforeinput,
		    flags & ~sf_clearbeforeinput);
	 ++tot;
      }
   }
   closedir(dir);
   if (tot==0)
      ErrorMsg(2,"Nothing loaded\n");
   return (true);
}
