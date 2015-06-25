/* $Id: sflayout.c 4064 2015-06-25 14:15:40Z mskala $ */
/* Copyright (C) 2007-2012 by George Williams */
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
#include <math.h>

#include "sflayoutP.h"

#include <ustring.h>
#include <utype.h>
#include <chardata.h>
#include <ffglib.h>

static uint32_t simple_stdfeatures[] =
   { CHR('c', 'c', 'm', 'p'), CHR('l', 'o', 'c', 'a'), CHR('k', 'e', 'r',
							   'n'), CHR('l', 'i',
								     'g',
								     'a'),
CHR('c', 'a', 'l', 't'), CHR('m', 'a', 'r', 'k'), CHR('m', 'k', 'm', 'k'), REQUIRED_FEATURE, 0 };
static uint32_t arab_stdfeatures[] =
   { CHR('c', 'c', 'm', 'p'), CHR('l', 'o', 'c', 'a'), CHR('i', 's', 'o',
							   'l'), CHR('i', 'n',
								     'i',
								     't'),
CHR('m', 'e', 'd', 'i'), CHR('f', 'i', 'n', 'a'), CHR('r', 'l', 'i', 'g'), CHR('l', 'i', 'g', 'a'),
CHR('c', 'a', 'l', 't'), CHR('k', 'e', 'r', 'n'), CHR('c', 'u', 'r', 's'), CHR('m', 'a', 'r', 'k'),
CHR('m', 'k', 'm', 'k'), REQUIRED_FEATURE, 0 };
static uint32_t hebrew_stdfeatures[] =
   { CHR('c', 'c', 'm', 'p'), CHR('l', 'o', 'c', 'a'), CHR('l', 'i', 'g',
							   'a'), CHR('c', 'a',
								     'l',
								     't'),
CHR('k', 'e', 'r', 'n'), CHR('m', 'a', 'r', 'k'), CHR('m', 'k', 'm', 'k'), REQUIRED_FEATURE, 0 };
static struct {
   uint32_t script, *stdfeatures;
} script_2_std[]={
   {
   CHR('l', 'a', 't', 'n'), simple_stdfeatures}, {
   CHR('D', 'F', 'L', 'T'), simple_stdfeatures}, {
   CHR('c', 'y', 'r', 'l'), simple_stdfeatures}, {
   CHR('g', 'r', 'e', 'k'), simple_stdfeatures}, {
   CHR('a', 'r', 'a', 'b'), arab_stdfeatures}, {
   CHR('h', 'e', 'b', 'r'), hebrew_stdfeatures}, {
   0, NULL}
};

uint32_t *StdFeaturesOfScript(uint32_t script) {
   int i;

   for (i=0; script_2_std[i].script != 0; ++i)
      if (script_2_std[i].script==script)
	 return (script_2_std[i].stdfeatures);

   return (simple_stdfeatures);
}

int LI_FDDrawChar(void *data,
		  void (*drawImage) (void *, GImage *, GRect *, int x, int y),
		  void (*drawRect) (void *, GRect *, Color col),
		  struct opentype_str *osc, int x, int y, Color col) {
   BDFChar *bdfc;
   int gid;
   FontData *fd;
   SplineChar *sc;

   if (osc==NULL)
      return (x);
   sc=osc->sc;
   fd=((struct fontlist *) (osc->fl))->fd;

   x += osc->vr.xoff;
   y -= osc->vr.yoff + osc->bsln_off;

   gid=sc->orig_pos;
   if (gid != -1 && fd->bdf->glyphs[gid]==NULL)
      BDFPieceMeal(fd->bdf, gid);
   if (gid==-1 || fd->bdf->glyphs[gid]==NULL) {
      if (col != -1) {
	 GRect r;

	 r.x=x + 1;
	 r.width=osc->advance_width - 2;
	 r.height=(2 * fd->bdf->ascent / 3);
	 r.y=y - r.height;
	 (drawRect) (data, &r, col);
      }
      x += fd->bdf->ascent / 2;
   } else {
      bdfc=fd->fonttype==sftf_bitmap ?
	 BDFGetMergedChar(fd->bdf->glyphs[gid]) : fd->bdf->glyphs[gid];
      if (col != -1) {
	 if (!fd->antialias)
	    fd->clut.clut[1]=col;	/* Only works for bitmaps */
	 if (fd->base.clut != NULL)
	    fd->base.clut->trans_index=0;
	 else
	    fd->base.trans=0;
	 fd->base.data=bdfc->bitmap;
	 fd->base.bytes_per_line=bdfc->bytes_per_line;
	 fd->base.width=bdfc->xmax - bdfc->xmin + 1;
	 fd->base.height=bdfc->ymax - bdfc->ymin + 1;
	 (drawImage) (data, &fd->gi, NULL, x + bdfc->xmin, y - bdfc->ymax);
	 fd->base.clut->trans_index=-1;
      }
      x += bdfc->width;
      if (fd->fonttype==sftf_bitmap)
	 BDFCharFree(bdfc);
   }
   return (x);
}

uint32_t *LI_TagsCopy(uint32_t * tags) {
   int i;

   uint32_t *ret;

   if (tags==NULL)
      return (NULL);
   for (i=0; tags[i] != 0; ++i);
   ret=malloc((i + 1) * sizeof(uint32_t));
   for (i=0; tags[i] != 0; ++i)
      ret[i]=tags[i];
   ret[i]=0;
   return (ret);
}

static int _FDMap(FontData *fd,int uenc) {
   /* given a unicode code point, find the encoding in this font */
   int gid;

   if (uenc >= fd->sfmap->map->enccount)
      return (-1);
   gid=fd->sfmap->map->map[uenc];
   if (gid==-1 || fd->sf->glyphs[gid]==NULL)
      return (-1);

   return (gid);
}

static SplineChar *FDMap(FontData *fd,int uenc) {
   /* given a unicode code point, find the encoding in this font */
   /* We've already converted arabic to its forms... but we did that to */
   /*  the deprecated unicode code points. If those don't work see if we */
   /*  can find a substitution lookup. */
   int gid;

   gid=_FDMap(fd, uenc);
   if (gid != -1 && fd->sf->glyphs[gid] != NULL)
      return (fd->sf->glyphs[gid]);
   gid=fd->sfmap->notdef_gid;
   if (gid != -1 && fd->sf->glyphs[gid] != NULL)
      return (fd->sf->glyphs[gid]);

   return (fd->sfmap->fake_notdef);
}

static int LinesInPara(LayoutInfo *li,struct opentype_str **paratext,
		       int width) {
   int start, end, break_pos, cnt;
   int len, pos;

   if (paratext==NULL)
      return (1);
   if (!li->wrap) {
      for (start=0; paratext[start] != NULL; ++start);
      paratext[start - 1]->line_break_after=true;
      return (1);
   }
   cnt=0;
   for (start=0; paratext[start] != NULL;) {
      break_pos=start;
      len=paratext[start]->advance_width + paratext[start]->vr.h_adv_off;
      for (end=start + 1; paratext[end] != NULL; ++end) {
	 len += paratext[end]->advance_width + paratext[end]->vr.h_adv_off;
	 if (len > width && break_pos != start) {
	    paratext[break_pos]->line_break_after=true;
	    start=break_pos + 1;
	    break;
	 }
	 pos=paratext[end]->orig_index +
	    ((struct fontlist *) (paratext[end]->fl))->start;
	 if (((li->text[pos + 1] < 0x10000 && li->text[pos] < 0x10000 &&
	       isbreakbetweenok(li->text[pos], li->text[pos + 1])) ||
	      (li->text[pos]==' ' && li->text[pos + 1] >= 0x10000)))
	    break_pos=end;
      }
      if (paratext[end]==NULL && end != 0) {
	 paratext[end - 1]->line_break_after=true;
	 start=end;
      }
      ++cnt;
   }
   if (cnt==0)
      cnt=1;
   return (cnt);
}

static struct opentype_str **LineFromPara(struct opentype_str **str,
					  int *_pos) {
   int len;
   struct opentype_str **ret;

   for (len=0; str[len] != NULL && !str[len]->line_break_after; ++len);
   if (str[len] != NULL)
      ++len;
   *_pos += len;
   ret=malloc((len + 1) * sizeof(struct opentype_str *));
   for (len=0; str[len] != NULL && !str[len]->line_break_after; ++len)
      ret[len]=str[len];
   if (str[len] != NULL) {
      ret[len]=str[len];
      ++len;
   }
   ret[len]=NULL;
   return (ret);
}

static struct basescript *FindBS(struct Base *base,struct opentype_str *ch,
				 LayoutInfo * li) {
   uint32_t script=SCScriptFromUnicode(ch->sc);
   struct basescript *bs;

   if (script==DEFAULT_SCRIPT) {
      struct fontlist *fl=ch->fl;

      SplineChar *sc=fl->sctext[ch->orig_index];

      script=SCScriptFromUnicode(sc);
   }
   for (bs=base->scripts; bs != NULL && bs->script != script;
	bs=bs->next);
   return (bs);
}

static uint32_t FigureBaselineTag(struct opentype_str *ch,LayoutInfo *li,
				struct Base *cur_base,
				struct Base *start_base) {
   struct basescript *bs;

   bs=FindBS(cur_base, ch, li);
   if (bs != NULL)
      return (cur_base->baseline_tags[bs->def_baseline]);

   bs=FindBS(start_base, ch, li);
   if (bs != NULL)
      return (start_base->baseline_tags[bs->def_baseline]);

   return (0);
}

static int BaselineOffset(struct Base *base,struct basescript *bs,
			  uint32_t cur_bsln_tag) {
   int i;

   for (i=0; i < base->baseline_cnt; ++i)
      if (base->baseline_tags[i]==cur_bsln_tag)
	 break;
   if (i==base->baseline_cnt)	/* No info on this baseline in this font */
      return (0);

   return (bs->baseline_pos[i]);
}

static void LIFigureLineHeight(LayoutInfo *li,int l,int p) {
   int i;
   struct opentype_str **line=li->lines[l];
   int as=0, ds=0, ld=0;
   int width=0;

   if (line[0] != NULL) {
      FontData *start_fd=((struct fontlist *) (line[0]->fl))->fd;
      struct Base *start_base=start_fd->sf->horiz_base;
      struct basescript *start_bs=NULL;
      uint32_t start_bsln_tag=0;

      for (i=0; line[i] != NULL; ++i)
	 line[i]->bsln_off=0;

      /* Do baseline processing (if we can figure out a baseline for the first */
      /*  glyph on the line, line the rest up with it) */
      if (start_base != NULL)
	 start_bs=FindBS(start_base, line[0], li);
      if (start_bs != NULL)
	 start_bsln_tag =
	    FigureBaselineTag(line[0], li, start_base, start_base);
      if (start_bsln_tag != 0) {
	 double scale =
	    start_fd->pointsize * li->dpi / (72.0 *
					     (start_fd->sf->ascent +
					      start_fd->sf->descent));
	 for (i=1; line[i] != NULL; ++i) {
	    FontData *fd=((struct fontlist *) (line[i]->fl))->fd;

	    struct Base *base=fd->sf->horiz_base;

	    uint32_t cur_bsln_tag;

	    if (fd->sf->horiz_base==NULL)
	       continue;
	    cur_bsln_tag=FigureBaselineTag(line[i], li, base, start_base);
	    if (cur_bsln_tag==start_bsln_tag)
	       continue;	/* Same baseline, offset 0 already set */
	    line[i]->bsln_off =
	       rint(scale *
		    BaselineOffset(start_base, start_bs, cur_bsln_tag));
	 }
      }
   }

   for (i=0; line[i] != NULL; ++i) {
      FontData *fd=((struct fontlist *) (line[i]->fl))->fd;
      BDFFont *bdf=fd->bdf;
      int off=line[i]->bsln_off;
      double scale =
	 fd->pointsize * li->dpi / (72.0 *
				    (fd->sf->ascent + fd->sf->descent));
      if (bdf != NULL) {
	 if (as < bdf->ascent + off)
	    as=bdf->ascent + off;
	 if (ds < bdf->descent - off)
	    ds=bdf->descent - off;
      } else {
	 if (as < scale * fd->sf->ascent + off)
	    as=scale * fd->sf->ascent + off;
	 if (ds < scale * fd->sf->descent - off)
	    ds=scale * fd->sf->descent - off;
      }
      if (fd->sf->pfminfo.pfmset
	  && ld < scale * fd->sf->pfminfo.os2_typolinegap)
	 ld=scale * fd->sf->pfminfo.os2_typolinegap;
      width += line[i]->advance_width + line[i]->vr.h_adv_off;
   }
   if (as + ds==0) {
      struct fontlist *fl, *last=li->fontlist;

      for (fl=li->fontlist;
	   fl != NULL && li->paras[p].start_pos >= fl->start; fl=fl->next)
	 last=fl;
      if (last != NULL) {
	 FontData *fd=last->fd;

	 double scale =
	    fd->pointsize * li->dpi / (72.0 *
				       (fd->sf->ascent + fd->sf->descent));
	 if (as < scale * fd->sf->ascent)
	    as=scale * fd->sf->ascent;
	 if (ds < scale * fd->sf->descent)
	    ds=scale * fd->sf->descent;
	 if (fd->sf->pfminfo.pfmset
	     && ld < scale * fd->sf->pfminfo.os2_typolinegap)
	    ld=scale * fd->sf->pfminfo.os2_typolinegap;
      }
   }
   li->lineheights[l].fh=as + ds + ld;
   li->lineheights[l].as=as;
   li->lineheights[l].linelen=width;
   if (l==0)
      li->lineheights[l].y=0;
   else
      li->lineheights[l].y =
	 li->lineheights[l - 1].y + li->lineheights[l - 1].fh;
   li->lineheights[l].p=p;
   if (line[0]==NULL)		/* Before bidir text */
      li->lineheights[l].start_pos=li->paras[p].start_pos;
   else
      li->lineheights[l].start_pos=line[0]->orig_index +
	 ((struct fontlist *) (line[0]->fl))->start;
}

static void SFDoBiText(struct opentype_str **line) {
   int i, j, start, end, inr;

   /* I'm going to make a huge simplification. Instead of doing the unicode */
   /*  algorithem to determine whether a glyph should be r2l or l2r, I'm */
   /*  just going to assume that the script tells us that. Each glyph is */
   /*  tagged with a script because each fontlist is. So things are easy */

   inr=0;
   for (i=0; line[i] != NULL; ++i) {
      if (ScriptIsRightToLeft(((struct fontlist *) (line[i]->fl))->script)) {
	 if (!inr) {
	    start=i;
	    inr=true;
	 }
      } else {
	 if (inr) {
	    end=i;
	    inr=false;
	    for (j=(end - start) / 2; j > 0; --j) {
	       struct opentype_str *chr=line[start + j - 1];

	       line[start + j - 1]=line[end - j];
	       line[end - j]=chr;
	    }
	    for (j=start; j < end; ++j)
	       line[j]->r2l=true;
	 }
      }
   }
   if (inr) {
      end=i;
      inr=false;
      for (j=(end - start) / 2; j > 0; --j) {
	 struct opentype_str *chr=line[start + j - 1];

	 line[start + j - 1]=line[end - j];
	 line[end - j]=chr;
      }
      for (j=start; j < end; ++j)
	 line[j]->r2l=true;
   }
}

static int ot_strlen(struct opentype_str *str) {
   int i;

   for (i=0; str[i].sc != NULL; ++i);
   return (i);
}

void LayoutInfoRefigureLines(LayoutInfo * li, int start_of_change,
			     int end_of_change, int width) {
   int i, j, p, ps, pe, l, ls, le, pdiff, ldiff;
   int len, start, pcnt, lcnt;
   struct fontlist *fl, *oldstart, *oldend, *curp;
   double scale;

   if (li->lines==NULL) {
      li->lines=malloc(10 * sizeof(struct opentype_str *));
      li->lineheights=malloc(10 * sizeof(struct lineheights));
      li->lines[0]=NULL;
      li->lmax=10;
      li->lcnt=0;
   }

   if (end_of_change==-1)
      end_of_change=start_of_change + u_strlen(li->text + start_of_change);
   if (li->ps==-1) {
      ps=0;
      pe=li->pcnt;
      ls=0;
      le=li->lcnt;
      oldstart=li->fontlist;
      oldend=NULL;
   } else {
      ps=li->ps;
      pe=li->pe;
      ls=li->ls;
      le=li->le;
      oldstart=li->oldstart;
      oldend=li->oldend;
   }

   /* Do transformations dictated by features on the changed region */
   /* while we're at it find the beginning of the changed paragraph, the */
   /* number of paragraphs (newlines) within the change, and the last paragraph */
   /*  of the change */
   pcnt=0;
   if (oldstart != NULL) {
      for (fl=oldstart, start=start_of_change - fl->start;
	   fl != NULL && fl != oldend; fl=fl->next, start=0) {
	 if (start < 0)
	    start=0;
	 if (fl->end - fl->start >= fl->scmax)
	    fl->sctext =
	       realloc(fl->sctext,
		       ((fl->scmax =
			 fl->end - fl->start + 4) +
			1) * sizeof(SplineChar *));
	 for (i=j=0; i < fl->end - fl->start; ++i) {
	    SplineChar *sc=FDMap(fl->fd, li->text[fl->start + i]);

	    if (sc != NULL && sc != (SplineChar *) - 1)
	       fl->sctext[j++]=sc;
	 }
	 fl->sctext[j]=NULL;

	 free(fl->ottext);
	 fl->ottext=ApplyTickedFeatures(fl->fd->sf, fl->feats,
					  fl->script, fl->lang,
					  rint((fl->fd->pointsize * li->dpi) /
					       72), fl->sctext);
	 scale =
	    fl->fd->pointsize * li->dpi / (72.0 *
					   (fl->fd->sf->ascent +
					    fl->fd->sf->descent));
	 for (i=0; fl->ottext[i].sc != NULL; ++i) {
	    fl->ottext[i].fl=fl;
	    if (fl->fd->bdf != NULL && fl->ottext[i].sc->orig_pos != -1) {
	       /* tt instructions might change the advance width fromt he expected value */
	       fl->ottext[i].advance_width =
		  BDFPieceMealCheck(fl->fd->bdf,
				    fl->ottext[i].sc->orig_pos)->width;
	    } else
	       fl->ottext[i].advance_width =
		  rint(fl->ottext[i].sc->width * scale);
	 }
	 if ((fl->next==NULL || fl->next->end != fl->end)
	     && (li->text[fl->end]=='\n' || li->text[fl->end]=='\0'))
	    ++pcnt;
      }
   }

   if (li->pmax <= li->pcnt + pcnt - (pe - ps + 1))
      li->paras =
	 realloc(li->paras,
		 (li->pmax =
		  li->pcnt + 30 + pcnt - (pe - ps +
					  1)) * sizeof(struct paras));
   /* move any old paragraphs around */
   pdiff=pcnt - (pe - ps);
   for (p=ps; p < pe; ++p)
      free(li->paras[p].para);
   if (pdiff < 0) {
      for (p=pe; p < li->pcnt; ++p)
	 li->paras[p + pdiff]=li->paras[p];
   } else if (pdiff > 0) {
      for (p=li->pcnt - 1; p >= pe; --p)
	 li->paras[p + pdiff]=li->paras[p];
   }
   /* Figure out the changed paragraphs */
   /* And the number of lines in each */
   lcnt=0;
   for (p=ps, curp=oldstart; p < ps + pcnt && curp != NULL; ++p) {
      len=0;
      /* Each para may be composed of several font segments */
      for (fl=curp; fl != NULL; fl=fl->next) {
	 len += ot_strlen(fl->ottext);
	 if ((fl->next==NULL || fl->next->end != fl->end)
	     && li->text[fl->end]=='\n')
	    break;		/* End of paragraph */
      }
      li->paras[p].para=malloc((len + 1) * sizeof(struct paras));
      li->paras[p].start_pos=curp->start;
      len=0;
      for (fl=curp; fl != NULL; fl=fl->next) {
	 for (i=0; fl->ottext[i].sc != NULL; ++i)
	    li->paras[p].para[len + i]=&fl->ottext[i];
	 len += i;
	 if ((fl->next==NULL || fl->next->end != fl->end)
	     && li->text[fl->end]=='\n') {
	    fl=fl->next;
	    break;		/* End of paragraph */
	 }
      }
      li->paras[p].para[len]=NULL;
      lcnt += LinesInPara(li, li->paras[p].para, width);
      curp=fl;
   }
   li->pcnt += pdiff;

   if (li->lmax <= li->lcnt + lcnt - (le - ls) + 1) {
      li->lines =
	 realloc(li->lines,
		 (li->lmax =
		  li->lcnt + 30 + lcnt - (le - ls +
					  1)) *
		 sizeof(struct openfont_str **));
      li->lineheights =
	 realloc(li->lineheights, li->lmax * sizeof(struct lineheights));
   }
   /* move any old lines around */
   ldiff=lcnt - (le - ls);
   for (l=ls; l < le; ++l)
      free(li->lines[l]);
   if (ldiff < 0) {
      for (l=le; l <= li->lcnt; ++l) {
	 li->lines[l + ldiff]=li->lines[l];
	 li->lineheights[l + ldiff]=li->lineheights[l];
      }
   } else if (ldiff > 0) {
      for (l=li->lcnt - 1; l >= le; --l) {
	 li->lines[l + ldiff]=li->lines[l];
	 li->lineheights[l + ldiff]=li->lineheights[l];
      }
   }
   for (l=ls, p=ps; l < ls + lcnt; ++p) {
      int eol=0;

      do {
	 li->lines[l]=LineFromPara(&li->paras[p].para[eol], &eol);
	 LIFigureLineHeight(li, l, p);	/* Must preceed BiText */
	 SFDoBiText(li->lines[l++]);
      } while (li->paras[p].para[eol] != NULL);
   }
   li->lcnt += ldiff;

   li->xmax=0;
   for (l=0; l < li->lcnt; ++l) {
      if (li->lineheights[l].linelen > li->xmax)
	 li->xmax=li->lineheights[l].linelen;
   }
   if (ls + lcnt==0)
      lcnt=1;			/* line 0 always starts at 0 */
   for (l=ls + lcnt; l < li->lcnt; ++l)
      li->lineheights[l].y =
	 li->lineheights[l - 1].y + li->lineheights[l - 1].fh;
   li->ps=-1;
}

static void fontlistfree(struct fontlist *fl) {
   struct fontlist *nfl;

   for (; fl != NULL; fl=nfl) {
      nfl=fl->next;
      free(fl->feats);
      free(fl->sctext);
      free(fl->ottext);
      chunkfree(fl, sizeof(struct fontlist));
   }
}

void LayoutInfo_Destroy(LayoutInfo * li) {
   struct sfmaps *m, *n;
   FontData *fd, *nfd;

   free(li->paras);
   free(li->lines);
   fontlistfree(li->fontlist);
   fontlistfree(li->oldfontlist);
   for (m=li->sfmaps; m != NULL; m=n) {
      n=m->next;
      SplineCharFree(m->fake_notdef);
      EncMapFree(m->map);
      chunkfree(m, sizeof(struct sfmaps));
   }
   for (fd=li->generated; fd != NULL; fd=nfd) {
      nfd=fd->next;
      if (fd->depends_on)
	 fd->bdf->freetype_context=NULL;
      if (fd->fonttype != sftf_bitmap)	/* If it's a bitmap font, we didn't create it (lives in sf) so we can't destroy it */
	 BDFFontFree(fd->bdf);
      free(fd);
   }
   free(li->oldtext);
   free(li->text);
}

void SFMapFill(struct sfmaps *sfmaps, SplineFont *sf) {
   sfmaps->map=EncMapFromEncoding(sf, FindOrMakeEncoding("UnicodeFull"));
   sfmaps->notdef_gid=SFFindGID(sf, -1, ".notdef");
   if (sfmaps->notdef_gid==-1) {
      SplineChar *notdef=SFSplineCharCreate(sf);

      sfmaps->fake_notdef=notdef;
      notdef->name=fastrdup(".notdef");
      notdef->parent=sf;
      notdef->width=(sf->ascent + sf->descent);
      if (sf->cidmaster==NULL)
	 notdef->width=6 * notdef->width / 10;
      notdef->searcherdummy=true;
      notdef->orig_pos=-1;
   }
}

struct sfmaps *SFMapOfSF(LayoutInfo * li, SplineFont *sf) {
   struct sfmaps *sfmaps;

   for (sfmaps=li->sfmaps; sfmaps != NULL; sfmaps=sfmaps->next)
      if (sfmaps->sf==sf)
	 return (sfmaps);

   sfmaps=chunkalloc(sizeof(struct sfmaps));
   sfmaps->sf=sf;
   sfmaps->next=li->sfmaps;
   li->sfmaps=sfmaps;
   SFMapFill(sfmaps, sf);
   return (sfmaps);
}

FontData *LI_RegenFontData(LayoutInfo * li, FontData * ret) {
   FontData *test;
   BDFFont *bdf, *ok, *old;
   void *ftc;
   int pixelsize;
   int freeold=ret->fonttype != sftf_bitmap, depends_on =
      ret->depends_on != NULL;
   extern Color default_background;

   pixelsize=rint((ret->pointsize * li->dpi) / 72.0);
   old=ret->bdf;
   ret->bdf=NULL;

   if (ret->fonttype==sftf_bitmap) {
      ok=NULL;
      for (bdf=ret->sf->bitmaps; bdf != NULL; bdf=bdf->next) {
	 if (bdf->pixelsize==pixelsize) {
	    if ((!ret->antialias && bdf->clut==NULL) ||
		(ret->antialias && bdf->clut != NULL
		 && bdf->clut->clut_len==256)) {
	       ok=bdf;
	       break;
	    }
	    if (ret->antialias && bdf->clut != NULL &&
		(ok==NULL || bdf->clut->clut_len > ok->clut->clut_len))
	       ok=bdf;
	 }
      }
      if (ok==NULL)
	 ret->fonttype=sftf_pfaedit;
      else
	 ret->bdf=ok;
   } else if (!hasFreeType() && ret->fonttype != sftf_pfaedit)
      ret->fonttype=sftf_pfaedit;
   else if ((ret->sf->multilayer || ret->sf->strokedfont)
	    && ret->fonttype != sftf_nohints)
      ret->fonttype=sftf_pfaedit;

   if (ret->bdf != NULL)
      /* Already done */ ;
   else if (ret->fonttype==sftf_pfaedit)
      ret->bdf =
	 SplineFontPieceMeal(ret->sf, ret->layer, ret->pointsize, li->dpi,
			     ret->antialias ? pf_antialias : 0, NULL);
   else if (ret->fonttype==sftf_nohints)
      ret->bdf =
	 SplineFontPieceMeal(ret->sf, ret->layer, ret->pointsize, li->dpi,
			     (ret->
			      antialias ? pf_antialias : 0) | pf_ft_nohints,
			     NULL);
   else {
      for (test=li->generated; test != NULL; test=test->next)
	 if (test != ret && test->bdf != NULL && test->sf==ret->sf &&
	     test->fonttype==ret->fonttype)
	    break;
      ret->depends_on=test;
      ftc=NULL;
      if (test && test->bdf) {
	 ftc=test->bdf->freetype_context;
	 depends_on=true;
      }
      if (ftc==NULL) {
	 int flags=0;

	 int ff=ret->fonttype==sftf_pfb ? ff_pfb :
	    ret->fonttype==sftf_ttf ? ff_ttf : ff_otf;
	 ftc =
	    _FreeTypeFontContext(ret->sf, NULL, NULL, ret->layer, ff, flags,
				 NULL);
      }
      if (ftc==NULL) {
	 if (old != NULL)
	    ret->bdf=old;
	 else {
	    free(ret);
	    ret=NULL;
	 }
	 return (ret);
      }
      ret->bdf =
	 SplineFontPieceMeal(ret->sf, ret->layer, ret->pointsize, li->dpi,
			     ret->antialias, ftc);
   }
   if (freeold) {
      if (depends_on && old != NULL)
	 old->freetype_context=NULL;
      BDFFontFree(old);
   }

   if (ret->bdf->clut) {
      ret->gi.u.image=&ret->base;
      ret->base.image_type=it_index;
      ret->base.clut=ret->bdf->clut;
      ret->base.trans=0;
   } else {
      memset(&ret->clut, '\0', sizeof(ret->clut));
      ret->gi.u.image=&ret->base;
      ret->base.image_type=it_mono;
      ret->base.clut=&ret->clut;
      ret->clut.clut_len=2;
      ret->clut.clut[0]=default_background;
      ret->base.trans=0;
   }
   return (ret);
}

FontData *LI_FindFontData(LayoutInfo * li, SplineFont *sf,
			  int layer, enum sftf_fonttype fonttype, int size,
			  int antialias) {
   FontData *test, *ret;

   for (test=li->generated; test != NULL; test=test->next)
      if (test->sf==sf && test->fonttype==fonttype &&
	  test->pointsize==size && test->antialias==antialias &&
	  test->layer==layer)
	 return (test);

   ret=calloc(1, sizeof(FontData));
   ret->sf=sf;
   ret->fonttype=fonttype;
   ret->pointsize=size;
   ret->antialias=antialias;
   ret->layer=layer;
   ret=LI_RegenFontData(li, ret);
   if (ret==NULL)
      return (NULL);

   ret->sfmap=SFMapOfSF(li, sf);
   ret->next=li->generated;
   li->generated=ret;
   return (ret);
}

#include "scripting.h"
static Array *SFDefaultScriptsLines(Array *arr,SplineFont *sf) {
   int pixelsize=24;
   uint32_t scripts[200], script;
   char *lines[209];
   int i, scnt, lcnt, gid;
   /* If the font has more than 200 scripts we can't give a good sample image */
   SplineChar *sc;
   char buffer[51 * 4 + 1], *pt;
   Array *ret;
   char *str;
   int start, end, anyscript=0, anyhere;

   if (arr != NULL && arr->argc==1)
      pixelsize=arr->vals[0].u.ival;

   scnt=0;
   lines[0]=fastrdup(sf->fullname != NULL ? sf->fullname : sf->fontname);
   lcnt=1;
   for (gid=0; gid < sf->glyphcnt; ++gid)
      if ((sc=sf->glyphs[gid]) != NULL) {
	 int uni=sc->unicodeenc;

	 if (uni==-1)
	    continue;
	 script=SCScriptFromUnicode(sc);
	 for (i=scnt - 1; i >= 0; --i)
	    if (scripts[i]==script)
	       break;
	 if (i >= 0)
	    continue;
	 switch (script) {
	      /* Some standard cases */
	   case DEFAULT_SCRIPT:
	      str="0123456789!?(){}[]&";
	      break;
	   case CHR('l', 'a', 't', 'n'):
	      str="ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz";
	      break;
	   case CHR('g', 'r', 'e', 'k'):
	      str =
		 "ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ αβγδεζηθικλμνξοπρστυφχψω";
	      break;
	   case CHR('c', 'y', 'r', 'l'):
	      str =
		 "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ абвгдежзийклмнопрстуфхцчшщъыьэюя";
	      break;
	   case CHR('h', 'e', 'b', 'r'):
	      str="אבגדהוזחטיךכלםמןנסעףפץצקרשת";
	      break;
	   case CHR('a', 'r', 'a', 'b'):	/* Contains ZWNJ between glyphs */
	      str =
		 "‌س‌ز‌ر‌ذ‌ت‌ء‌ا‌ب‌ث‌ج‌ح‌خ‌د‌ش‌ص‌ض‌ط‌ظ‌ع‌غ‌ف‌ق‌ك‌ل‌م‌ن‌ه‌و‌ي";
	      break;
	   case CHR('d', 'e', 'v', 'a'):
	      str =
		 "अ‌आ‌इ‌ई‌उ‌ऊ‌ऋ‌ऌ‌ऍ‌ऎ‌ए‌ऐ‌ऑ‌ऒ‌ओ‌औ‌क‌ख‌ग‌घ‌ङ‌च‌छ‌ज‌झ‌ञ‌ट‌ठ‌ड‌ढ‌ण‌त‌थ‌द‌ध‌न‌ऩ‌प‌फ‌ब‌म‌य‌ऱ‌ल‌ळ‌ऴ‌व‌श‌ष‌स‌ह‌र‌भ";
	      break;
	   case CHR('h', 'a', 'n', 'i'):
	      /* Chinese Tranditional */
	      lines[lcnt++] =
		 fastrdup("道可道非常道，名可名非常名。");
	      /* Japanese */
	      str =
		 "吾輩は猫である（夏目漱石）：吾輩は猫である";
	      break;
	   case CHR('k', 'a', 'n', 'a'):
	      /* Hiragana */
	      lines[lcnt++] =
		 fastrdup
		 ("あいうえおかがきぎくぐけこさざしじすせそただちぢつてとなにぬねのはばぱひふへほまみむ");
	      /* Katakana */
	      str =
		 "アイウエオカガキギクケコサザシジスセソタダチヂツテトナニヌネノハバパヒフヘホマミムメモ";
	      break;
	   case CHR('h', 'a', 'n', 'g'):
	      str="어버이 살아신 제 섬길 일란 다 하여라";
	      break;
	   default:
	      ScriptMainRange(script, &start, &end);
	      if (end - start > 50)
		 end=start + 50;
	      pt=buffer;
	      for (i=start; i <= end; ++i)
		 pt=utf8_idpb(pt, i, 0);
	      *pt='\0';
	      str=buffer;
	      break;
	 }
	 anyhere=false;
	 for (pt=str; *pt;) {
	    int ch=utf8_ildb((const char **) &pt);

	    if (ch==' ')
	       continue;
	    if (SFGetChar(sf, ch, NULL) != NULL) {
	       anyhere=true;
	       break;
	    }
	 }
	 if (anyhere) {
	    lines[lcnt++]=fastrdup(str);
	    scripts[scnt++]=script;
	    anyscript=true;
	 }
	 if (scnt==200)
	    break;
      }

   if (!anyscript) {
      /* For example, Apostolos's Phaistos Disk font. There is no OT script */
      /*  code assigned for those unicode points */
      pt=buffer;
      for (gid=i=0;
	   gid < sf->glyphcnt && pt < buffer + sizeof(buffer) - 4 && i < 50;
	   ++gid) {
	 if ((sc=sf->glyphs[gid]) != NULL && sc->unicodeenc != -1) {
	    pt=utf8_idpb(pt, sc->unicodeenc, 0);
	    ++i;
	 }
      }
      *pt='\0';
      if (i > 0) {
	 lines[lcnt++]=fastrdup(buffer);
	 scripts[scnt++]=DEFAULT_SCRIPT;
      }
   }

   ret=calloc(1, sizeof(Array));
   ret->argc=2 * lcnt;
   ret->vals=calloc(2 * lcnt, sizeof(Val));
   for (i=0; i < lcnt; ++i) {
      ret->vals[2 * i + 0].type=v_int;
      ret->vals[2 * i + 0].u.ival=pixelsize;
      ret->vals[2 * i + 1].type=v_str;
      ret->vals[2 * i + 1].u.sval=lines[i];
   }
   ret->vals[0].u.ival=3 * pixelsize / 2;	/* Use as a title, make bigger */
   return (ret);
}

void FontImage(SplineFont *sf, char *filename, Array * arr, int width,
	       int height) {
   LayoutInfo *li=calloc(1, sizeof(LayoutInfo));
   int cnt, len, i, j, ret, p, x;
   struct fontlist *last;
   enum sftf_fonttype type=sf->layers[ly_fore].order2 ? sftf_ttf : sftf_otf;
   GImage *image;
   struct _GImage *base;
   unichar_t *upt;
   uint32_t script;
   struct opentype_str **line;
   int ybase=0;
   Array *freeme=NULL;

   if (!hasFreeType())
      type=sftf_pfaedit;
   if (sf->onlybitmaps && sf->bitmaps != NULL)
      type=sftf_bitmap;

   li->wrap=true;
   li->dpi=72;
   li->ps=-1;
   SFMapOfSF(li, sf);

   if (arr==NULL || arr->argc < 2)
      arr=freeme=SFDefaultScriptsLines(arr, sf);

   cnt=arr->argc / 2;
   len=1;
   for (i=0; i < cnt; ++i)
      len += g_utf8_strlen(arr->vals[2 * i + 1].u.sval, -1) + 1;

   li->text=malloc(len * sizeof(unichar_t));
   len=0;
   last=NULL;
   for (i=0; i < cnt; ++i) {
      if (last==NULL)
	 last=li->fontlist=chunkalloc(sizeof(struct fontlist));
      else {
	 last->next=chunkalloc(sizeof(struct fontlist));
	 last=last->next;
      }
      last->fd =
	 LI_FindFontData(li, sf, ly_fore, type, arr->vals[2 * i].u.ival,
			 true);
      last->start=len;

      utf82u_strcpy(li->text + len, arr->vals[2 * i + 1].u.sval);
      script=DEFAULT_SCRIPT;
      for (upt=li->text + len; *upt && script==DEFAULT_SCRIPT; ++upt)
	 script=ScriptFromUnicode(*upt, NULL);
      len += g_utf8_strlen(arr->vals[2 * i + 1].u.sval, -1);
      li->text[len++]='\n';

      last->end=len - 1;

      last->script=script;
      last->lang=DEFAULT_LANG;
      last->feats=LI_TagsCopy(StdFeaturesOfScript(script));
   }
   li->text[len++]='\0';

   LayoutInfoRefigureLines(li, 0, -1, width==-1 ? 0xff00 : width);
   if (width==-1)
      width=li->xmax + 2;
   if (li->lcnt != 0)
      ybase=li->lineheights[0].as;
   if (height==-1 && li->lcnt != 0)
      height =
	 li->lineheights[li->lcnt - 1].y + li->lineheights[li->lcnt - 1].fh +
	 2 + ybase;

   image=GImageCreate(it_index, width, height);
   base=image->u.image;
   memset(base->data, 0, base->bytes_per_line * base->height);
   for (i=0; i < 256; ++i)
      base->clut->clut[i]=(255 - i) * 0x010101;
   base->clut->is_grey=true;
   base->clut->clut_len=256;

   for (i=0; i < li->lcnt; ++i) {
      /* Does this para start out r2l or l2r? */
      p=li->lineheights[i].p;
      if (li->paras[p].para[0] != NULL &&
	  ScriptIsRightToLeft(((struct fontlist *) (li->paras[p].para[0]->
						    fl))->script))
	 x=li->xmax - li->lineheights[i].linelen;
      else
	 x=0;
      line=li->lines[i];
      for (j=0; line[j] != NULL; ++j) {
	 LI_FDDrawChar(image,
		       (void (*)(void *, GImage *, GRect *, int, int))
		       GImageDrawImage,
		       (void (*)(void *, GRect *, Color)) GImageDrawRect,
		       line[j], x, li->lineheights[i].y + ybase, 0x000000);
	 x += line[j]->advance_width + line[j]->vr.h_adv_off;
      }
   }
#ifndef _NO_LIBPNG
   if (strstrmatch(filename, ".png") != NULL)
      ret=GImageWritePng(image, filename, false);
   else
#endif
   if (strstrmatch(filename, ".bmp") != NULL)
      ret=GImageWriteBmp(image, filename);
   else
#ifndef _NO_LIBPNG
      ErrorMsg(2,"Unsupported image format, must be bmp or png.\n");
#else
      ErrorMsg(2,"Unsupported image format, must be bmp.\n");
#endif
   if (!ret)
      ErrorMsg(2,"Could not write %.100s\n",filename);
   GImageDestroy(image);

   LayoutInfo_Destroy(li);
   if (freeme != NULL)
      arrayfree(freeme);
}
