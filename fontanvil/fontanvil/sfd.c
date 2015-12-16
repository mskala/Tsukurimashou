/* $Id: sfd.c 4494 2015-12-12 08:13:24Z mskala $ */
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
#include "splinefont.h"
#include "baseviews.h"
#include "views.h"
#include <gimage.h>
#include <ustring.h>
#include <math.h>
#include <utype.h>
#include <unistd.h>
#include <gfile.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <limits.h>		/* For NAME_MAX or _POSIX_NAME_MAX */
#include <time.h>

#ifndef NAME_MAX
#   ifndef  _POSIX_NAME_MAX
#      define _POSIX_NAME_MAX 512
#   endif
#   define NAME_MAX _POSIX_NAME_MAX
#endif

static char *joins[]={ "miter","round","bevel","inher",NULL };
static char *caps[]={ "butt","round","square","inher",NULL };
static char *spreads[]={ "pad","reflect","repeat",NULL };

static int prefRevisionsToRetain=0;


#define SFD_PTFLAG_TYPE_MASK          0x3
#define SFD_PTFLAG_IS_SELECTED        0x4
#define SFD_PTFLAG_NEXTCP_IS_DEFAULT  0x8
#define SFD_PTFLAG_PREVCP_IS_DEFAULT  0x10
#define SFD_PTFLAG_ROUND_IN_X         0x20
#define SFD_PTFLAG_ROUND_IN_Y         0x40
#define SFD_PTFLAG_INTERPOLATE        0x80
#define SFD_PTFLAG_INTERPOLATE_NEVER  0x100
#define SFD_PTFLAG_PREV_EXTREMA_MARKED_ACCEPTABLE  0x200
#define SFD_PTFLAG_FORCE_OPEN_PATH    0x400




/* I will retain this list in case there are still some really old sfd files */
/*  including numeric encodings.  This table maps them to string encodings */
static const char *charset_names[]={
   "custom",
   "iso8859-1", "iso8859-2", "iso8859-3", "iso8859-4", "iso8859-5",
   "iso8859-6", "iso8859-7", "iso8859-8", "iso8859-9", "iso8859-10",
   "iso8859-11", "iso8859-13", "iso8859-14", "iso8859-15",
   "koi8-r",
   "jis201",
   "win", "mac", "symbol", "zapfding", "adobestandard",
   "jis208", "jis212", "ksc5601", "gb2312", "big5", "big5hkscs", "johab",
   "unicode", "unicode4", "sjis", "wansung", "gb2312pk", NULL
};

static const char *unicode_interp_names[]={ "none","adobe","greek",
   "japanese", "tradchinese", "simpchinese", "korean", "ams", NULL
};

/* sfdir files and extensions */
#define FONT_PROPS	"font.props"
#define STRIKE_PROPS	"strike.props"
#define EXT_CHAR	'.'
#define GLYPH_EXT	".glyph"
#define BITMAP_EXT	".bitmap"
#define STRIKE_EXT	".strike"
#define SUBFONT_EXT	".subfont"
#define INSTANCE_EXT	".instance"

static signed char inbase64[256]={
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
   52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
   -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
   15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
   -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
   41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
   -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
};

static char base64[64]={
   'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
      'P',
   'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e',
      'f',
   'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
      'v',
   'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+',
      '/'
};

static const char *end_tt_instrs="EndTTInstrs";

static void SFDDumpRefs(AFILE *sfd,RefChar *refs,char *name,EncMap *map,
			int *newgids);
static RefChar *SFDGetRef(AFILE *sfd,int was_enc);

static void SFDDumpImage(AFILE *sfd,ImageList *img);

static AnchorPoint *SFDReadAnchorPoints(AFILE *sfd,SplineChar *sc,
					AnchorPoint ** alist,
					AnchorPoint * lastap);
static void SFDDumpTtfInstrs(AFILE *sfd,SplineChar *sc);

static void SFDDumpTtfInstrsExplicit(AFILE *sfd,SplineChar *sc,
				     uint8_t * ttf_instrs,
				     int16_t ttf_instrs_len);
static void SFDDumpHintList(AFILE *sfd,char *key,StemInfo *h);

static void SFDDumpDHintList(AFILE *sfd,char *key,DStemInfo *d);

static StemInfo *SFDReadHints(AFILE *sfd);

static DStemInfo *SFDReadDHints(SplineFont *sf,AFILE *sfd,int old);

static void utf7_encode(AFILE *sfd,long ch) {

   aputc(base64[(ch >> 18) & 0x3f], sfd);
   aputc(base64[(ch >> 12) & 0x3f], sfd);
   aputc(base64[(ch >> 6) & 0x3f], sfd);
   aputc(base64[ch & 0x3f], sfd);
}

static void SFDDumpUTF7Str(AFILE *sfd,const char *_str) {
   int ch, prev_cnt=0, prev=0, in=0;
   const unsigned char *str=(const unsigned char *) _str;

   aputc('"', sfd);
   if (str != NULL)
      while ((ch=*str++) != '\0') {
	 /* Convert from utf8 to ucs4 */
	 if (ch <= 127)
	    /* Done */ ;
	 else if (ch <= 0xdf && *str != '\0') {
	    ch=((ch & 0x1f) << 6) | (*str++ & 0x3f);
	 } else if (ch <= 0xef && *str != '\0' && str[1] != '\0') {
	    ch =
	       ((ch & 0xf) << 12) | ((str[0] & 0x3f) << 6) | (str[1] & 0x3f);
	    str += 2;
	 } else if (*str != '\0' && str[1] != '\0' && str[2] != '\0') {
	    int w=(((ch & 0x7) << 2) | ((str[0] & 0x30) >> 4)) - 1;
	    int s1, s2;

	    s1=(w << 6) | ((str[0] & 0xf) << 2) | ((str[1] & 0x30) >> 4);
	    s2=((str[1] & 0xf) << 6) | (str[2] & 0x3f);
	    ch=(s1 * 0x400) + s2 + 0x10000;
	    str += 3;
	 } else {
	    /* illegal */
	 }
	 if (ch < 127 && ch != '\n' && ch != '\r' && ch != '\\' && ch != '~'
	     && ch != '+' && ch != '=' && ch != '"') {
	    if (prev_cnt != 0) {
	       prev <<= (prev_cnt==1 ? 16 : 8);
	       utf7_encode(sfd, prev);
	       prev_cnt=prev=0;
	    }
	    if (in) {
	       if (inbase64[ch] != -1 || ch=='-')
		  aputc('-', sfd);
	       in=0;
	    }
	    aputc(ch, sfd);
	 } else if (ch=='+' && !in) {
	    aputc('+', sfd);
	    aputc('-', sfd);
	 } else if (prev_cnt==0) {
	    if (!in) {
	       aputc('+', sfd);
	       in=1;
	    }
	    prev=ch;
	    prev_cnt=2;	/* 2 bytes */
	 } else if (prev_cnt==2) {
	    prev <<= 8;
	    prev += (ch >> 8) & 0xff;
	    utf7_encode(sfd, prev);
	    prev=(ch & 0xff);
	    prev_cnt=1;
	 } else {
	    prev <<= 16;
	    prev |= ch;
	    utf7_encode(sfd, prev);
	    prev_cnt=prev=0;
	 }
      }
   if (prev_cnt==2) {
      prev <<= 8;
      utf7_encode(sfd, prev);
   } else if (prev_cnt==1) {
      prev <<= 16;
      utf7_encode(sfd, prev);
   }
   aputc('"', sfd);
   aputc(' ', sfd);
}

/* Long lines can be broken by inserting \\\n (backslash newline) */
/*  into the line. I don't think this is ever ambiguous as I don't */
/*  think a line can end with backslash */
/* UPDATE: it can... that's handled in getquotedeol() below. */
static int nlgetc(AFILE *sfd) {
   int ch, ch2;

   ch=agetc(sfd);
   if (ch != '\\')
      return (ch);
   ch2=agetc(sfd);
   if (ch2=='\n')
      return (nlgetc(sfd));
   aungetc(ch2, sfd);
   return (ch);
}

static char *SFDReadUTF7Str(AFILE *sfd) {
   char *buffer=NULL, *pt, *end=NULL;
   int ch1, ch2, ch3, ch4, done, c;
   int prev_cnt=0, prev=0, in=0;

   ch1=nlgetc(sfd);
   while (isspace(ch1) && ch1 != '\n' && ch1 != '\r')
      ch1=nlgetc(sfd);
   if (ch1=='\n' || ch1=='\r')
      aungetc(ch1, sfd);
   if (ch1 != '"')
      return (NULL);
   pt=0;
   while ((ch1=nlgetc(sfd)) != EOF && ch1 != '"') {
      done=0;
      if (!done && !in) {
	 if (ch1=='+') {
	    ch1=nlgetc(sfd);
	    if (ch1=='-') {
	       ch1='+';
	       done=true;
	    } else {
	       in=true;
	       prev_cnt=0;
	    }
	 } else
	    done=true;
      }
      if (!done) {
	 if (ch1=='-') {
	    in=false;
	 } else if (inbase64[ch1]==-1) {
	    in=false;
	    done=true;
	 } else {
	    ch1=inbase64[ch1];
	    ch2=inbase64[c=nlgetc(sfd)];
	    if (ch2==-1) {
	       aungetc(c, sfd);
	       ch2=ch3=ch4=0;
	    } else {
	       ch3=inbase64[c=nlgetc(sfd)];
	       if (ch3==-1) {
		  aungetc(c, sfd);
		  ch3=ch4=0;
	       } else {
		  ch4=inbase64[c=nlgetc(sfd)];
		  if (ch4==-1) {
		     aungetc(c, sfd);
		     ch4=0;
		  }
	       }
	    }
	    ch1=(ch1 << 18) | (ch2 << 12) | (ch3 << 6) | ch4;
	    if (prev_cnt==0) {
	       prev=ch1 & 0xff;
	       ch1 >>= 8;
	       prev_cnt=1;
	    } else {		/* if ( prev_cnt==1 ) */

	       ch1 |= (prev << 24);
	       prev=(ch1 & 0xffff);
	       ch1=(ch1 >> 16) & 0xffff;
	       prev_cnt=2;
	    }
	    done=true;
	 }
      }
      if (pt + 10 >= end) {
	 if (buffer==NULL) {
	    pt=buffer=malloc(400);
	    end=buffer + 400;
	 } else if (pt) {
	    char *temp=realloc(buffer, end - buffer + 400);

	    pt=temp + (pt - buffer);
	    end=temp + (end - buffer + 400);
	    buffer=temp;
	 }
      }
      if (pt && done)
	 pt=utf8_idpb(pt, ch1, 0);
      if (prev_cnt==2) {
	 prev_cnt=0;
	 if (pt && prev != 0)
	    pt=utf8_idpb(pt, prev, 0);
      }
      if (pt==0) {
	 free(buffer);
	 return (NULL);
      }
   }
   if (buffer==NULL)
      return (NULL);
   *pt='\0';
   pt=fastrdup(buffer);
   free(buffer);
   return (pt);
}

struct enc85 {
   AFILE *sfd;
   unsigned char sofar[4];
   int pos;
   int ccnt;
};

static void SFDEnc85(struct enc85 *enc,int ch) {
   enc->sofar[enc->pos++]=ch;
   if (enc->pos==4) {
      unsigned int val =
	 (enc->sofar[0] << 24) | (enc->sofar[1] << 16) | (enc->
							  sofar[2] << 8) |
	 enc->sofar[3];
      if (val==0) {
	 aputc('z', enc->sfd);
	 ++enc->ccnt;
      } else {
	 int ch2, ch3, ch4, ch5;

	 ch5=val % 85;
	 val /= 85;
	 ch4=val % 85;
	 val /= 85;
	 ch3=val % 85;
	 val /= 85;
	 ch2=val % 85;
	 val /= 85;
	 aputc('!' + val, enc->sfd);
	 aputc('!' + ch2, enc->sfd);
	 aputc('!' + ch3, enc->sfd);
	 aputc('!' + ch4, enc->sfd);
	 aputc('!' + ch5, enc->sfd);
	 enc->ccnt += 5;
	 if (enc->ccnt > 70) {
	    aputc('\n', enc->sfd);
	    enc->ccnt=0;
	 }
      }
      enc->pos=0;
   }
}

static void SFDEnc85EndEnc(struct enc85 *enc) {
   int i;
   int ch2, ch3, ch4, ch5;
   unsigned val;

   if (enc->pos==0)
      return;
   for (i=enc->pos; i < 4; ++i)
      enc->sofar[i]=0;
   val =
      (enc->sofar[0] << 24) | (enc->sofar[1] << 16) | (enc->
						       sofar[2] << 8) | enc->
      sofar[3];
   if (val==0) {
      aputc('z', enc->sfd);
   } else {
      ch5=val % 85;
      val /= 85;
      ch4=val % 85;
      val /= 85;
      ch3=val % 85;
      val /= 85;
      ch2=val % 85;
      val /= 85;
      aputc('!' + val, enc->sfd);
      aputc('!' + ch2, enc->sfd);
      aputc('!' + ch3, enc->sfd);
      aputc('!' + ch4, enc->sfd);
      aputc('!' + ch5, enc->sfd);
   }
   enc->pos=0;
}

static void SFDDumpHintMask(AFILE *sfd,HintMask *hintmask) {
   int i, j;

   for (i=HntMax / 8 - 1; i > 0; --i)
      if ((*hintmask)[i] != 0)
	 break;
   for (j=0; j <= i; ++j) {
      if (((*hintmask)[j] >> 4) < 10)
	 aputc('0' + ((*hintmask)[j] >> 4), sfd);
      else
	 aputc('a' - 10 + ((*hintmask)[j] >> 4), sfd);
      if (((*hintmask)[j] & 0xf) < 10)
	 aputc('0' + ((*hintmask)[j] & 0xf), sfd);
      else
	 aputc('a' - 10 + ((*hintmask)[j] & 0xf), sfd);
   }
}

static void SFDDumpSplineSet(AFILE *sfd,SplineSet *spl) {
   SplinePoint *first, *sp;
   int order2=spl->first->next==NULL || spl->first->next->order2;

   for (; spl != NULL; spl=spl->next) {
      first=NULL;
      for (sp=spl->first;; sp=sp->next->to) {
	 if (first==NULL)
	    afprintf(sfd, "%.12g %.12g m ", (double) sp->me.x,
		    (double) sp->me.y);
	 else if (sp->prev->islinear && sp->noprevcp)	/* Don't use known linear here. save control points if there are any */
	    afprintf(sfd, " %.12g %.12g l ", (double) sp->me.x,
		    (double) sp->me.y);
	 else
	    afprintf(sfd, " %.12g %.12g %.12g %.12g %.12g %.12g c ",
		    (double) sp->prev->from->nextcp.x,
		    (double) sp->prev->from->nextcp.y, (double) sp->prevcp.x,
		    (double) sp->prevcp.y, (double) sp->me.x,
		    (double) sp->me.y);
	 int ptflags=0;

	 ptflags=sp->pointtype | (sp->selected << 2) |
	    (sp->nextcpdef << 3) | (sp->prevcpdef << 4) |
	    (sp->roundx << 5) | (sp->roundy << 6) |
	    (sp->ttfindex==0xffff ? (1 << 7) : 0) |
	    (sp->dontinterpolate << 8) |
	    ((sp->prev && sp->prev->acceptableextrema) << 9);

	 // Last point in the splineset, and we are an open path.
	 if (!sp->next && spl->first && !spl->first->prev) {
	    ptflags |= SFD_PTFLAG_FORCE_OPEN_PATH;
	 }


	 afprintf(sfd, "%d", ptflags);
	 if (order2) {
	    if (sp->ttfindex != 0xfffe && sp->nextcpindex != 0xfffe) {
	       aputc(',', sfd);
	       if (sp->ttfindex==0xffff)
		  afprintf(sfd, "-1");
	       else if (sp->ttfindex != 0xfffe)
		  afprintf(sfd, "%d", sp->ttfindex);
	       if (sp->nextcpindex==0xffff)
		  afprintf(sfd, ",-1");
	       else if (sp->nextcpindex != 0xfffe)
		  afprintf(sfd, ",%d", sp->nextcpindex);
	    }
	 } else {
	    if (sp->hintmask != NULL) {
	       aputc('x', sfd);
	       SFDDumpHintMask(sfd, sp->hintmask);
	    }
	 }
	 aputc('\n', sfd);
	 if (sp->name!=NULL) {
	    afputs("NamedP: ", sfd);
	    SFDDumpUTF7Str(sfd, sp->name);
	    aputc('\n', sfd);
	 }
	 if (sp==first)
	    break;
	 if (first==NULL)
	    first=sp;
	 if (sp->next==NULL)
	    break;
      }
      if (spl->spiro_cnt != 0) {
	 int i;

	 afprintf(sfd, "  Spiro\n");
	 for (i=0; i < spl->spiro_cnt; ++i) {
	    afprintf(sfd, "    %g %g %c\n", spl->spiros[i].x, spl->spiros[i].y,
		    spl->spiros[i].ty & 0x7f);
	 }
	 afprintf(sfd, "  EndSpiro\n");
      }
      if (spl->contour_name != NULL) {
	 afprintf(sfd, "  Named: ");
	 SFDDumpUTF7Str(sfd, spl->contour_name);
	 aputc('\n', sfd);
      }
      if (spl->is_clip_path) {
	 afprintf(sfd, "  PathFlags: %d\n", spl->is_clip_path);
      }
   }
   afprintf(sfd, "EndSplineSet\n");
}

static void SFDDumpDeviceTable(AFILE *sfd,DeviceTable *adjust) {
   int i;

   if (adjust==NULL)
      return;
   afprintf(sfd, "{");
   if (adjust->corrections != NULL) {
      afprintf(sfd, "%d-%d ", adjust->first_pixel_size,
	      adjust->last_pixel_size);
      for (i=0; i <= adjust->last_pixel_size - adjust->first_pixel_size;
	   ++i)
	 afprintf(sfd, "%s%d", i==0 ? "" : ",", adjust->corrections[i]);
   }
   afprintf(sfd, "}");
}

static void SFDDumpValDevTab(AFILE *sfd,ValDevTab *adjust) {
   if (adjust==NULL)
      return;
   afprintf(sfd, " [ddx=");
   SFDDumpDeviceTable(sfd, &adjust->xadjust);
   afprintf(sfd, " ddy=");
   SFDDumpDeviceTable(sfd, &adjust->yadjust);
   afprintf(sfd, " ddh=");
   SFDDumpDeviceTable(sfd, &adjust->xadv);
   afprintf(sfd, " ddv=");
   SFDDumpDeviceTable(sfd, &adjust->yadv);
   aputc(']', sfd);
}

static void SFDDumpAnchorPoints(AFILE *sfd,AnchorPoint *ap) {
   if (ap==NULL) {
      return;
   }

   for (; ap != NULL; ap=ap->next) {
      afprintf(sfd, "AnchorPoint: ");
      SFDDumpUTF7Str(sfd, ap->anchor->name);
      afprintf(sfd, "%g %g %s %d",
	      (double) ap->me.x, (double) ap->me.y,
	      ap->type==at_centry ? "entry" :
	      ap->type==at_cexit ? "exit" :
	      ap->type==at_mark ? "mark" :
	      ap->type==at_basechar ? "basechar" :
	      ap->type==at_baselig ? "baselig" : "basemark", ap->lig_index);
      if (ap->xadjust.corrections != NULL || ap->yadjust.corrections != NULL) {
	 aputc(' ', sfd);
	 SFDDumpDeviceTable(sfd, &ap->xadjust);
	 aputc(' ', sfd);
	 SFDDumpDeviceTable(sfd, &ap->yadjust);
      } else if (ap->has_ttf_pt)
	 afprintf(sfd, " %d", ap->ttf_pt_index);
      aputc('\n', sfd);
   }
}

/* Run length encoding */
/* We always start with a background pixel(1), each line is a series of counts */
/*  we alternate background/foreground. If we can't represent an entire run */
/*  as one count, then we can split it up into several smaller runs and put */
/*  0 counts in between */
/* counts 0-254 mean 0-254 pixels of the current color */
/* count 255 means that the next two bytes (bigendian) provide a two byte count */
/* count 255 0 n (n<255) means that the previous line should be repeated n+1 times */
/* count 255 0 255 means 255 pixels of the current color */
static uint8_t *image2rle(struct _GImage *img,int *len) {
   int max=img->height * img->bytes_per_line;
   uint8_t *rle, *pt, *end;
   int cnt, set;
   int i, j, k;

   *len=0;
   if (img->image_type != it_mono || img->bytes_per_line < 5)
      return (NULL);
   rle=calloc(max, sizeof(uint8_t)), pt=rle, end=rle + max - 3;

   for (i=0; i < img->height; ++i) {
      if (i != 0) {
	 if (memcmp(img->data + i * img->bytes_per_line,
		    img->data + (i - 1) * img->bytes_per_line,
		    img->bytes_per_line)==0) {
	    for (k=1; k < img->height - i; ++k) {
	       if (memcmp(img->data + (i + k) * img->bytes_per_line,
			  img->data + i * img->bytes_per_line,
			  img->bytes_per_line) != 0)
		  break;
	    }
	    i += k;
	    while (k > 0) {
	       if (pt > end) {
		  free(rle);
		  return (NULL);
	       }
	       *pt++=255;
	       *pt++=0;
	       *pt++=k > 254 ? 254 : k;
	       k -= 254;
	    }
	    if (i >= img->height)
	       break;
	 }
      }

      set=1;
      cnt=0;
      j=0;
      while (j < img->width) {
	 for (k=j; k < img->width; ++k) {
	    if ((set
		 && !(img->
		      data[i * img->bytes_per_line +
			   (k >> 3)] & (0x80 >> (k & 7)))) || (!set
							       && (img->
								   data[i *
									img->
									bytes_per_line
									+
									(k >>
									 3)] &
								   (0x80 >>
								    (k &
								     7)))))
	       break;
	 }
	 cnt=k - j;
	 j=k;
	 do {
	    if (pt >= end) {
	       free(rle);
	       return (NULL);
	    }
	    if (cnt <= 254)
	       *pt++=cnt;
	    else {
	       *pt++=255;
	       if (cnt > 65535) {
		  *pt++=255;
		  *pt++=255;
		  *pt++=0;	/* nothing of the other color, we've still got more of this one */
	       } else {
		  *pt++=cnt >> 8;
		  *pt++=cnt & 0xff;
	       }
	    }
	    cnt -= 65535;
	 } while (cnt > 0);
	 set=1 - set;
      }
   }
   *len=pt - rle;
   return (rle);
}

static void SFDDumpImage(AFILE *sfd,ImageList *img) {
   GImage *image=img->image;

   struct _GImage *base =
      image->list_len==0 ? image->u.image : image->u.images[0];
   struct enc85 enc;
   int rlelen;
   uint8_t *rle;
   int i;

   rle=image2rle(base, &rlelen);
   afprintf(sfd, "Image: %d %d %d %d %d %x %g %g %g %g %d\n",
	   (int) base->width, (int) base->height, base->image_type,
	   (int) (base->image_type ==
		  it_true ? 3 * base->width : base->bytes_per_line),
	   base->clut==NULL ? 0 : base->clut->clut_len, (int) base->trans,
	   (double) img->xoff, (double) img->yoff, (double) img->xscale,
	   (double) img->yscale, rlelen);
   memset(&enc, '\0', sizeof(enc));
   enc.sfd=sfd;
   if (base->clut != NULL) {
      for (i=0; i < base->clut->clut_len; ++i) {
	 SFDEnc85(&enc, base->clut->clut[i] >> 16);
	 SFDEnc85(&enc, (base->clut->clut[i] >> 8) & 0xff);
	 SFDEnc85(&enc, base->clut->clut[i] & 0xff);
      }
   }
   if (rle != NULL) {
      uint8_t *pt=rle, *end=rle + rlelen;

      while (pt < end)
	 SFDEnc85(&enc, *pt++);
      free(rle);
   } else {
      for (i=0; i < base->height; ++i) {
	 if (base->image_type==it_rgba) {
	    uint32_t *ipt=(uint32_t *) (base->data + i * base->bytes_per_line);
	    uint32_t *iend =
	       (uint32_t *) (base->data + (i + 1) * base->bytes_per_line);
	    while (ipt < iend) {
	       SFDEnc85(&enc, *ipt >> 24);
	       SFDEnc85(&enc, (*ipt >> 16) & 0xff);
	       SFDEnc85(&enc, (*ipt >> 8) & 0xff);
	       SFDEnc85(&enc, *ipt & 0xff);
	       ++ipt;
	    }
	 } else if (base->image_type==it_true) {
	    int *ipt=(int *) (base->data + i * base->bytes_per_line);
	    int *iend=(int *) (base->data + (i + 1) * base->bytes_per_line);

	    while (ipt < iend) {
	       SFDEnc85(&enc, *ipt >> 16);
	       SFDEnc85(&enc, (*ipt >> 8) & 0xff);
	       SFDEnc85(&enc, *ipt & 0xff);
	       ++ipt;
	    }
	 } else {
	    uint8_t *pt=(uint8_t *) (base->data + i * base->bytes_per_line);
	    uint8_t *end =
	       (uint8_t *) (base->data + (i + 1) * base->bytes_per_line);
	    while (pt < end) {
	       SFDEnc85(&enc, *pt);
	       ++pt;
	    }
	 }
      }
   }
   SFDEnc85EndEnc(&enc);
   afprintf(sfd, "\nEndImage\n");
}

static void SFDDumpHintList(AFILE *sfd,char *key,StemInfo *h) {
   HintInstance *hi;

   if (h==NULL)
      return;
   afprintf(sfd, "%s", key);
   for (; h != NULL; h=h->next) {
      afprintf(sfd, "%g %g", (double) h->start, (double) h->width);
      if (h->ghost)
	 aputc('G', sfd);
      if (h->where != NULL) {
	 aputc('<', sfd);
	 for (hi=h->where; hi != NULL; hi=hi->next)
	    afprintf(sfd, "%g %g%c", (double) hi->begin, (double) hi->end,
		    hi->next ? ' ' : '>');
      }
      aputc(h->next ? ' ' : '\n', sfd);
   }
}

static void SFDDumpDHintList(AFILE *sfd,char *key,DStemInfo *d) {
   HintInstance *hi;

   if (d==NULL)
      return;
   afprintf(sfd, "%s", key);
   for (; d != NULL; d=d->next) {
      afprintf(sfd, "%g %g %g %g %g %g",
	      (double) d->left.x, (double) d->left.y,
	      (double) d->right.x, (double) d->right.y,
	      (double) d->unit.x, (double) d->unit.y);
      if (d->where != NULL) {
	 aputc('<', sfd);
	 for (hi=d->where; hi != NULL; hi=hi->next)
	    afprintf(sfd, "%g %g%c", (double) hi->begin, (double) hi->end,
		    hi->next ? ' ' : '>');
      }
      aputc(d->next ? ' ' : '\n', sfd);
   }
}

static void SFDDumpTtfInstrsExplicit(AFILE *sfd,SplineChar *sc,
				     uint8_t * ttf_instrs,
				     int16_t ttf_instrs_len) {
   char *instrs=_IVUnParseInstrs(ttf_instrs, ttf_instrs_len);
   char *pt;

   afprintf(sfd, "TtInstrs:\n");
   for (pt=instrs; *pt != '\0'; ++pt)
      aputc(*pt, sfd);
   if (pt[-1] != '\n')
      aputc('\n', sfd);
   free(instrs);
   afprintf(sfd, "%s\n", end_tt_instrs);
}
static void SFDDumpTtfInstrs(AFILE *sfd,SplineChar *sc) {
   SFDDumpTtfInstrsExplicit(sfd, sc, sc->ttf_instrs, sc->ttf_instrs_len);
}

static void SFDDumpTtfTable(AFILE *sfd,struct ttf_table *tab,
			    SplineFont *sf) {
   if (tab->tag==CHR('p', 'r', 'e', 'p')
       || tab->tag==CHR('f', 'p', 'g', 'm')) {
      /* These are tables of instructions and should be dumped as such */
      char *instrs;
      char *pt;

      afprintf(sfd, "TtTable: %c%c%c%c\n",
	      (int) (tab->tag >> 24), (int) ((tab->tag >> 16) & 0xff),
	      (int) ((tab->tag >> 8) & 0xff), (int) (tab->tag & 0xff));
      instrs=_IVUnParseInstrs(tab->data, tab->len);
      for (pt=instrs; *pt != '\0'; ++pt)
	 aputc(*pt, sfd);
      if (pt[-1] != '\n')
	 aputc('\n', sfd);
      free(instrs);
      afprintf(sfd, "%s\n", end_tt_instrs);
   } else
      if ((tab->tag==CHR('c', 'v', 't', ' ')
	   || tab->tag==CHR('m', 'a', 'x', 'p')) && (tab->len & 1)==0) {
      int i, ended;
      uint8_t *pt;

      afprintf(sfd, "ShortTable: %c%c%c%c %d\n",
	      (int) (tab->tag >> 24), (int) ((tab->tag >> 16) & 0xff),
	      (int) ((tab->tag >> 8) & 0xff), (int) (tab->tag & 0xff),
	      (int) (tab->len >> 1));
      pt=(uint8_t *) tab->data;
      ended=tab->tag != CHR('c', 'v', 't', ' ') || sf->cvt_names==NULL;
      for (i=0; i < (tab->len >> 1); ++i) {
	 int num=(int16_t) ((pt[0] << 8) | pt[1]);

	 afprintf(sfd, "  %d", num);
	 if (!ended) {
	    if (sf->cvt_names[i]==END_CVT_NAMES)
	       ended=true;
	    else if (sf->cvt_names[i] != NULL) {
	       aputc(' ', sfd);
	       SFDDumpUTF7Str(sfd, sf->cvt_names[i]);
	    }
	 }
	 aputc('\n', sfd);
	 pt += 2;
      }
      afprintf(sfd, "EndShort\n");
   } else {
      /* maxp, who knows what. Dump 'em as binary for now */
      struct enc85 enc;
      int i;

      memset(&enc, '\0', sizeof(enc));
      enc.sfd=sfd;

      afprintf(sfd, "TtfTable: %c%c%c%c %d\n",
	      (int) (tab->tag >> 24), (int) ((tab->tag >> 16) & 0xff),
	      (int) ((tab->tag >> 8) & 0xff), (int) (tab->tag & 0xff),
	      (int) tab->len);
      for (i=0; i < tab->len; ++i)
	 SFDEnc85(&enc, tab->data[i]);
      SFDEnc85EndEnc(&enc);
      afprintf(sfd, "\nEndTtf\n");
   }
}

static int SFDOmit(SplineChar *sc) {
   int layer;
   BDFFont *bdf;

   if (sc==NULL)
      return (true);
   if (sc->comment != NULL || sc->color != COLOR_DEFAULT)
      return (false);
   for (layer=ly_back; layer < sc->layer_cnt; ++layer) {
      if (sc->layers[layer].splines != NULL ||
	  sc->layers[layer].refs != NULL || sc->layers[layer].images != NULL)
	 return (false);
   }
   if (sc->parent->onlybitmaps) {
      for (bdf=sc->parent->bitmaps; bdf != NULL; bdf=bdf->next) {
	 if (sc->orig_pos < bdf->glyphcnt
	     && bdf->glyphs[sc->orig_pos] != NULL)
	    return (false);
      }
   }
   if (!sc->widthset)
      return (true);

   return (false);
}

static void SFDDumpRefs(AFILE *sfd,RefChar *refs,char *name,EncMap *map,
			int *newgids) {
   RefChar *ref;

   for (ref=refs; ref != NULL; ref=ref->next)
      if (ref->sc != NULL) {
	 afprintf(sfd, "Refer: %d %d %c %g %g %g %g %g %g %d",
		 newgids !=
		 NULL ? newgids[ref->sc->orig_pos] : ref->sc->orig_pos,
		 ref->sc->unicodeenc, ref->selected ? 'S' : 'N',
		 (double) ref->transform[0], (double) ref->transform[1],
		 (double) ref->transform[2], (double) ref->transform[3],
		 (double) ref->transform[4], (double) ref->transform[5],
		 ref->use_my_metrics | (ref->
					round_translation_to_grid << 1) |
		 (ref->point_match << 2));
	 if (ref->point_match) {
	    afprintf(sfd, " %d %d", ref->match_pt_base, ref->match_pt_ref);
	    if (ref->point_match_out_of_date)
	       afprintf(sfd, " O");
	 }
	 aputc('\n', sfd);
      }
}

static void SFDDumpMathVertex(AFILE *sfd,struct mathkernvertex *vert,
			      char *name) {
   int i;

   if (vert==NULL || vert->cnt==0)
      return;

   afprintf(sfd, "%s %d ", name, vert->cnt);
   for (i=0; i < vert->cnt; ++i) {
      afprintf(sfd, " %d", vert->mkd[i].height);
      SFDDumpDeviceTable(sfd, vert->mkd[i].height_adjusts);
      afprintf(sfd, ",%d", vert->mkd[i].kern);
      SFDDumpDeviceTable(sfd, vert->mkd[i].kern_adjusts);
   }
   aputc('\n', sfd);
}

static void SFDDumpGlyphVariants(AFILE *sfd,struct glyphvariants *gv,
				 char *name) {
   int i;

   if (gv==NULL)
      return;

   if (gv->variants != NULL)
      afprintf(sfd, "GlyphVariants%s: %s\n", name, gv->variants);
   if (gv->part_cnt != 0) {
      if (gv->italic_correction != 0) {
	 afprintf(sfd, "GlyphComposition%sIC: %d", name,
		 gv->italic_correction);
	 if (gv->italic_adjusts != NULL) {
	    aputc(' ', sfd);
	    SFDDumpDeviceTable(sfd, gv->italic_adjusts);
	 }
	 aputc('\n', sfd);
      }
      afprintf(sfd, "GlyphComposition%s: %d ", name, gv->part_cnt);
      for (i=0; i < gv->part_cnt; ++i) {
	 afprintf(sfd, " %s%%%d,%d,%d,%d", gv->parts[i].component,
		 gv->parts[i].is_extender,
		 gv->parts[i].startConnectorLength,
		 gv->parts[i].endConnectorLength, gv->parts[i].fullAdvance);
      }
      aputc('\n', sfd);
   }
}

static void SFDDumpCharMath(AFILE *sfd,SplineChar *sc) {
   if (sc->italic_correction != TEX_UNDEF && sc->italic_correction != 0) {
      afprintf(sfd, "ItalicCorrection: %d", sc->italic_correction);
      if (sc->italic_adjusts != NULL) {
	 aputc(' ', sfd);
	 SFDDumpDeviceTable(sfd, sc->italic_adjusts);
      }
      aputc('\n', sfd);
   }
   if (sc->top_accent_horiz != TEX_UNDEF) {
      afprintf(sfd, "TopAccentHorizontal: %d", sc->top_accent_horiz);
      if (sc->top_accent_adjusts != NULL) {
	 aputc(' ', sfd);
	 SFDDumpDeviceTable(sfd, sc->top_accent_adjusts);
      }
      aputc('\n', sfd);
   }
   if (sc->is_extended_shape)
      afprintf(sfd, "IsExtendedShape: %d\n", sc->is_extended_shape);
   SFDDumpGlyphVariants(sfd, sc->vert_variants, "Vertical");
   SFDDumpGlyphVariants(sfd, sc->horiz_variants, "Horizontal");
   if (sc->mathkern != NULL) {
      SFDDumpMathVertex(sfd, &sc->mathkern->top_right, "TopRightVertex:");
      SFDDumpMathVertex(sfd, &sc->mathkern->top_left, "TopLeftVertex:");
      SFDDumpMathVertex(sfd, &sc->mathkern->bottom_right,
			"BottomRightVertex:");
      SFDDumpMathVertex(sfd, &sc->mathkern->bottom_left, "BottomLeftVertex:");
   }
}

static void SFDPickleMe(AFILE *sfd,void *python_data) {
   char *string, *pt;

   string=(char *) python_data;
   if (string==NULL)
      return;
   afprintf(sfd, "PickledData: \"");
   for (pt=string; *pt; ++pt) {
      if (*pt=='\\' || *pt=='"')
	 aputc('\\', sfd);
      aputc(*pt, sfd);
   }
   afprintf(sfd, "\"\n");
}

static void *SFDUnPickle(AFILE *sfd) {
   int ch, quoted;
   static int max=0;
   static char *buf=NULL;
   char *pt, *end;
   int cnt;

   pt=buf;
   end=buf + max;
   while ((ch=nlgetc(sfd)) != '"' && ch != '\n' && ch != EOF);
   if (ch != '"')
      return (NULL);

   quoted=false;
   while (((ch=nlgetc(sfd)) != '"' || quoted) && ch != EOF) {
      if (!quoted && ch=='\\')
	 quoted=true;
      else {
	 if (pt >= end) {
	    cnt=pt - buf;
	    buf=realloc(buf, (max += 200) + 1);
	    pt=buf + cnt;
	    end=buf + max;
	 }
	 *pt++=ch;
	 quoted=false;
      }
   }
   if (pt==buf)
      return (NULL);
   *pt='\0';
   return (fastrdup(buf));
   /* buf is a static buffer,I don't free it,I'll reuse it next time */
}


static void SFDDumpGradient(AFILE *sfd,char *keyword,
			    struct gradient *gradient) {
   int i;

   /* Use ";" as a coord separator because we treat "," as a potential decimal point */
   afprintf(sfd, "%s %g;%g %g;%g %g %s %d ", keyword,
	   (double) gradient->start.x, (double) gradient->start.y,
	   (double) gradient->stop.x, (double) gradient->stop.y,
	   (double) gradient->radius,
	   spreads[gradient->sm], gradient->stop_cnt);
   for (i=0; i < gradient->stop_cnt; ++i) {
      afprintf(sfd, "{%g #%06x %g} ", (double) gradient->grad_stops[i].offset,
	      gradient->grad_stops[i].col,
	      (double) gradient->grad_stops[i].opacity);
   }
   aputc('\n', sfd);
}

static void SFDDumpPattern(AFILE *sfd,char *keyword,struct pattern *pattern) {

   afprintf(sfd, "%s %s %g;%g [%g %g %g %g %g %g]\n", keyword,
	   pattern->pattern,
	   (double) pattern->width, (double) pattern->height,
	   (double) pattern->transform[0], (double) pattern->transform[1],
	   (double) pattern->transform[2], (double) pattern->transform[3],
	   (double) pattern->transform[4], (double) pattern->transform[5]);
}

static void SFDDumpCharStartingMarker(AFILE *sfd,SplineChar *sc) {
   if (AllAscii(sc->name))
      afprintf(sfd, "StartChar: %s\n", sc->name);
   else {
      afprintf(sfd, "StartChar: ");
      SFDDumpUTF7Str(sfd, sc->name);
      aputc('\n', sfd);
   }
}


static void SFDDumpChar(AFILE *sfd,SplineChar *sc,EncMap *map,
			int *newgids, int saveUndoes) {
   ImageList *img;
   KernPair *kp;
   PST *pst;
   int i, v, enc;
   struct altuni *altuni;

   aputc('\n', sfd);

   SFDDumpCharStartingMarker(sfd, sc);
   if ((enc=map->backmap[sc->orig_pos]) >= map->enccount) {
      if (sc->parent->cidmaster==NULL)
	 ErrorMsg(2,"Bad reverse encoding\n");
      enc=-1;
   }
   if (sc->unicodeenc != -1 &&
       ((map->enc->is_unicodebmp && sc->unicodeenc < 0x10000) ||
	(map->enc->is_unicodefull && sc->unicodeenc < unicode4_size)))
      /* If we have altunis, then the backmap may not give the primary */
      /*  unicode code point, which is what we need here */
      afprintf(sfd, "Encoding: %d %d %d\n", sc->unicodeenc, sc->unicodeenc,
	      newgids != NULL ? newgids[sc->orig_pos] : sc->orig_pos);
   else
      afprintf(sfd, "Encoding: %d %d %d\n", (int) enc, sc->unicodeenc,
	      newgids != NULL ? newgids[sc->orig_pos] : sc->orig_pos);
   if (sc->altuni) {
      afprintf(sfd, "AltUni2:");
      for (altuni=sc->altuni; altuni != NULL; altuni=altuni->next)
	 afprintf(sfd, " %06x.%06x.%x", altuni->unienc, altuni->vs,
		 altuni->fid);
      aputc('\n', sfd);
   }
   afprintf(sfd, "Width: %d\n", sc->width);
   if (sc->vwidth != sc->parent->ascent + sc->parent->descent)
      afprintf(sfd, "VWidth: %d\n", sc->vwidth);
   if (sc->glyph_class != 0)
      afprintf(sfd, "GlyphClass: %d\n", sc->glyph_class);
   if (sc->unlink_rm_ovrlp_save_undo)
      afprintf(sfd, "UnlinkRmOvrlpSave: %d\n", sc->unlink_rm_ovrlp_save_undo);
   if (sc->inspiro)
      afprintf(sfd, "InSpiro: %d\n", sc->inspiro);
   if (sc->lig_caret_cnt_fixed)
      afprintf(sfd, "LigCaretCntFixed: %d\n", sc->lig_caret_cnt_fixed);
   if (sc->changedsincelasthinted || sc->manualhints || sc->widthset)
      afprintf(sfd, "Flags: %s%s%s%s%s\n",
	      sc->changedsincelasthinted ? "H" : "",
	      sc->manualhints ? "M" : "",
	      sc->widthset ? "W" : "",
	      sc->views != NULL ? "O" : "",
	      sc->instructions_out_of_date ? "I" : "");
   if (sc->tex_height != TEX_UNDEF || sc->tex_depth != TEX_UNDEF)
      afprintf(sfd, "TeX: %d %d\n", sc->tex_height, sc->tex_depth);
   if (sc->is_extended_shape || sc->italic_correction != TEX_UNDEF ||
       sc->top_accent_horiz != TEX_UNDEF || sc->vert_variants != NULL ||
       sc->horiz_variants != NULL || sc->mathkern != NULL)
      SFDDumpCharMath(sfd, sc);
   if (sc->python_persistent != NULL)
      SFDPickleMe(sfd, sc->python_persistent);
#if HANYANG
   if (sc->compositionunit)
      afprintf(sfd, "CompositionUnit: %d %d\n", sc->jamo, sc->varient);
#endif
   SFDDumpHintList(sfd, "HStem: ", sc->hstem);
   SFDDumpHintList(sfd, "VStem: ", sc->vstem);
   SFDDumpDHintList(sfd, "DStem2: ", sc->dstem);
   if (sc->countermask_cnt != 0) {
      afprintf(sfd, "CounterMasks: %d", sc->countermask_cnt);
      for (i=0; i < sc->countermask_cnt; ++i) {
	 aputc(' ', sfd);
	 SFDDumpHintMask(sfd, &sc->countermasks[i]);
      }
      aputc('\n', sfd);
   }
   if (sc->ttf_instrs_len != 0)
      SFDDumpTtfInstrs(sfd, sc);
   SFDDumpAnchorPoints(sfd, sc->anchor);
   afprintf(sfd, "LayerCount: %d\n", sc->layer_cnt);
   for (i=0; i < sc->layer_cnt; ++i) {
      if (sc->parent->multilayer) {
	 afprintf(sfd,
		 "Layer: %d  %d %d %d  #%06x %g  #%06x %g %g %s %s [%g %g %g %g] [",
		 i, sc->layers[i].dofill, sc->layers[i].dostroke,
		 sc->layers[i].fillfirst, sc->layers[i].fill_brush.col,
		 sc->layers[i].fill_brush.opacity,
		 sc->layers[i].stroke_pen.brush.col,
		 sc->layers[i].stroke_pen.brush.opacity,
		 sc->layers[i].stroke_pen.width,
		 joins[sc->layers[i].stroke_pen.linejoin],
		 caps[sc->layers[i].stroke_pen.linecap],
		 (double) sc->layers[i].stroke_pen.trans[0],
		 (double) sc->layers[i].stroke_pen.trans[1],
		 (double) sc->layers[i].stroke_pen.trans[2],
		 (double) sc->layers[i].stroke_pen.trans[3]);
	 if (sc->layers[i].stroke_pen.dashes[0]==0
	     && sc->layers[i].stroke_pen.dashes[1]==DASH_INHERITED)
	    afprintf(sfd, "0 %d]\n", DASH_INHERITED);
	 else {
	    int j;

	    for (j=0;
		 j < DASH_MAX && sc->layers[i].stroke_pen.dashes[j] != 0; ++j)
	       afprintf(sfd, "%d ", sc->layers[i].stroke_pen.dashes[j]);
	    afprintf(sfd, "]\n");
	 }
	 if (sc->layers[i].fill_brush.gradient != NULL)
	    SFDDumpGradient(sfd, "FillGradient:",
			    sc->layers[i].fill_brush.gradient);
	 else if (sc->layers[i].fill_brush.pattern != NULL)
	    SFDDumpPattern(sfd, "FillPattern:",
			   sc->layers[i].fill_brush.pattern);
	 if (sc->layers[i].stroke_pen.brush.gradient != NULL)
	    SFDDumpGradient(sfd, "StrokeGradient:",
			    sc->layers[i].stroke_pen.brush.gradient);
	 else if (sc->layers[i].stroke_pen.brush.pattern != NULL)
	    SFDDumpPattern(sfd, "StrokePattern:",
			   sc->layers[i].stroke_pen.brush.pattern);
      } else {
	 if (sc->layers[i].images==NULL && sc->layers[i].splines==NULL &&
	     sc->layers[i].refs==NULL)
	    continue;
	 if (i==ly_back)
	    afprintf(sfd, "Back\n");
	 else if (i==ly_fore)
	    afprintf(sfd, "Fore\n");
	 else
	    afprintf(sfd, "Layer: %d\n", i);
      }
      for (img=sc->layers[i].images; img != NULL; img=img->next)
	 SFDDumpImage(sfd, img);
      if (sc->layers[i].splines != NULL) {
	 afprintf(sfd, "SplineSet\n");
	 SFDDumpSplineSet(sfd, sc->layers[i].splines);
      }
      SFDDumpRefs(sfd, sc->layers[i].refs, sc->name, map, newgids);
      if (sc->layers[i].validation_state & vs_known)
	 afprintf(sfd, "Validated: %d\n", sc->layers[i].validation_state);
   }
   for (v=0; v < 2; ++v) {
      kp=v ? sc->vkerns : sc->kerns;
      if (kp != NULL) {
	 afprintf(sfd, v ? "VKerns2:" : "Kerns2:");
	 for (; kp != NULL; kp=kp->next) {
	    if (!SFDOmit(kp->sc)) {
	       afprintf(sfd, " %d %d ",
		       newgids !=
		       NULL ? newgids[kp->sc->orig_pos] : kp->sc->orig_pos,
		       kp->off);
	       SFDDumpUTF7Str(sfd, kp->subtable->subtable_name);
	       if (kp->adjust != NULL)
		  aputc(' ', sfd);
	       SFDDumpDeviceTable(sfd, kp->adjust);
	    }
	 }
	 afprintf(sfd, "\n");
      }
   }
   for (pst=sc->possub; pst != NULL; pst=pst->next) {
      if ((pst->subtable==NULL && pst->type != pst_lcaret)
	  || pst->type==pst_null)
	 /* Skip it */ ;
      else {
	 static char *keywords[]={ "Null:","Position2:","PairPos2:",
	    "Substitution2:",
	    "AlternateSubs2:", "MultipleSubs2:", "Ligature2:",
	    "LCarets2:", NULL
	 };
	 afprintf(sfd, "%s ", keywords[pst->type]);
	 if (pst->subtable != NULL)
	    SFDDumpUTF7Str(sfd, pst->subtable->subtable_name);
	 if (pst->type==pst_position) {
	    afprintf(sfd, "dx=%d dy=%d dh=%d dv=%d",
		    pst->u.pos.xoff, pst->u.pos.yoff,
		    pst->u.pos.h_adv_off, pst->u.pos.v_adv_off);
	    SFDDumpValDevTab(sfd, pst->u.pos.adjust);
	    aputc('\n', sfd);
	 } else if (pst->type==pst_pair) {
	    afprintf(sfd, "%s dx=%d dy=%d dh=%d dv=%d",
		    pst->u.pair.paired,
		    pst->u.pair.vr[0].xoff, pst->u.pair.vr[0].yoff,
		    pst->u.pair.vr[0].h_adv_off, pst->u.pair.vr[0].v_adv_off);
	    SFDDumpValDevTab(sfd, pst->u.pair.vr[0].adjust);
	    afprintf(sfd, " dx=%d dy=%d dh=%d dv=%d",
		    pst->u.pair.vr[1].xoff, pst->u.pair.vr[1].yoff,
		    pst->u.pair.vr[1].h_adv_off, pst->u.pair.vr[1].v_adv_off);
	    SFDDumpValDevTab(sfd, pst->u.pair.vr[1].adjust);
	    aputc('\n', sfd);
	 } else if (pst->type==pst_lcaret) {
	    int i;

	    afprintf(sfd, "%d ", pst->u.lcaret.cnt);
	    for (i=0; i < pst->u.lcaret.cnt; ++i)
	       afprintf(sfd, "%d ", pst->u.lcaret.carets[i]);
	    afprintf(sfd, "\n");
	 } else
	    afprintf(sfd, "%s\n", pst->u.lig.components);
      }
   }
   if (sc->comment != NULL) {
      afprintf(sfd, "Comment: ");
      SFDDumpUTF7Str(sfd, sc->comment);
      aputc('\n', sfd);
   }
   if (sc->color != COLOR_DEFAULT)
      afprintf(sfd, "Colour: %x\n", (int) sc->color);
   if (sc->parent->multilayer) {
      if (sc->tile_margin != 0)
	 afprintf(sfd, "TileMargin: %g\n", (double) sc->tile_margin);
      else if (sc->tile_bounds.minx != 0 || sc->tile_bounds.maxx != 0)
	 afprintf(sfd, "TileBounds: %g %g %g %g\n",
		 (double) sc->tile_bounds.minx, (double) sc->tile_bounds.miny,
		 (double) sc->tile_bounds.maxx,
		 (double) sc->tile_bounds.maxy);
   }
   afprintf(sfd, "EndChar\n");
}

static void SFDDumpBitmapChar(AFILE *sfd,BDFChar *bfc,int enc,
			      int *newgids) {
   struct enc85 encrypt;
   int i;

   afprintf(sfd, "BDFChar: %d %d %d %d %d %d %d",
	   newgids != NULL ? newgids[bfc->orig_pos] : bfc->orig_pos, enc,
	   bfc->width, bfc->xmin, bfc->xmax, bfc->ymin, bfc->ymax);
   if (bfc->sc->parent->hasvmetrics)
      afprintf(sfd, " %d", bfc->vwidth);
   aputc('\n', sfd);
   memset(&encrypt, '\0', sizeof(encrypt));
   encrypt.sfd=sfd;
   for (i=0; i <= bfc->ymax - bfc->ymin; ++i) {
      uint8_t *pt=(uint8_t *) (bfc->bitmap + i * bfc->bytes_per_line);
      uint8_t *end=pt + bfc->bytes_per_line;

      while (pt < end) {
	 SFDEnc85(&encrypt, *pt);
	 ++pt;
      }
   }
   SFDEnc85EndEnc(&encrypt);
   aputc('\n', sfd);
}

static int SFDDumpBitmapFont(AFILE *sfd,BDFFont *bdf,EncMap *encm,
			     int *newgids) {
   int i;
   int err=false;
   BDFChar *bc;
   BDFRefChar *ref;

   afprintf(sfd, "BitmapFont: %d %d %d %d %d %s\n", bdf->pixelsize,
	   bdf->glyphcnt, bdf->ascent, bdf->descent, BDFDepth(bdf),
	   bdf->foundry ? bdf->foundry : "");
   if (bdf->prop_cnt > 0) {
      afprintf(sfd, "BDFStartProperties: %d\n", bdf->prop_cnt);
      for (i=0; i < bdf->prop_cnt; ++i) {
	 afprintf(sfd, "%s %d ", bdf->props[i].name, bdf->props[i].type);
	 switch (bdf->props[i].type & ~prt_property) {
	   case prt_int:
	   case prt_uint:
	      afprintf(sfd, "%d\n", bdf->props[i].u.val);
	      break;
	   case prt_string:
	   case prt_atom:
	      afprintf(sfd, "\"%s\"\n", bdf->props[i].u.str);
	      break;
	 }
      }
      afprintf(sfd, "BDFEndProperties\n");
   }
   if (bdf->res > 20)
      afprintf(sfd, "Resolution: %d\n", bdf->res);
   for (i=0; i < bdf->glyphcnt; ++i) {
      if (bdf->glyphs[i] != NULL) {
	 SFDDumpBitmapChar(sfd, bdf->glyphs[i], encm->backmap[i], newgids);
      }
   }
   for (i=0; i < bdf->glyphcnt; ++i)
      if ((bc=bdf->glyphs[i]) != NULL) {
	 for (ref=bc->refs; ref != NULL; ref=ref->next)
	    afprintf(sfd, "BDFRefChar: %d %d %d %d %c\n",
		    newgids != NULL ? newgids[bc->orig_pos] : bc->orig_pos,
		    newgids !=
		    NULL ? newgids[ref->bdfc->orig_pos] : ref->bdfc->orig_pos,
		    ref->xoff, ref->yoff, ref->selected ? 'S' : 'N');
      }
   afprintf(sfd, "EndBitmapFont\n");
   return (err);
}

static void SFDDumpPrivate(AFILE *sfd,struct psdict *private) {
   int i;
   char *pt;

   /* These guys should all be ascii text */
   afprintf(sfd, "BeginPrivate: %d\n", private->next);
   for (i=0; i < private->next; ++i) {
      afprintf(sfd, "%s %d ", private->keys[i],
	      (int) strlen(private->values[i]));
      for (pt=private->values[i]; *pt; ++pt)
	 aputc(*pt, sfd);
      aputc('\n', sfd);
   }
   afprintf(sfd, "EndPrivate\n");
}

static void SFDDumpLangName(AFILE *sfd,struct ttflangname *ln) {
   int i, end;

   afprintf(sfd, "LangName: %d ", ln->lang);
   for (end=ttf_namemax; end > 0 && ln->names[end - 1]==NULL; --end);
   for (i=0; i < end; ++i)
      SFDDumpUTF7Str(sfd, ln->names[i]);
   aputc('\n', sfd);
}

static void SFDDumpGasp(AFILE *sfd,SplineFont *sf) {
   int i;

   if (sf->gasp_cnt==0)
      return;

   afprintf(sfd, "GaspTable: %d", sf->gasp_cnt);
   for (i=0; i < sf->gasp_cnt; ++i)
      afprintf(sfd, " %d %d", sf->gasp[i].ppem, sf->gasp[i].flags);
   afprintf(sfd, " %d", sf->gasp_version);
   aputc('\n', sfd);
}

static void SFDDumpDesignSize(AFILE *sfd,SplineFont *sf) {
   struct otfname *on;

   if (sf->design_size==0)
      return;

   afprintf(sfd, "DesignSize: %d", sf->design_size);
   if (sf->fontstyle_id != 0 || sf->fontstyle_name != NULL ||
       sf->design_range_bottom != 0 || sf->design_range_top != 0) {
      afprintf(sfd, " %d-%d %d",
	      sf->design_range_bottom, sf->design_range_top,
	      sf->fontstyle_id);
      for (on=sf->fontstyle_name; on != NULL; on=on->next) {
	 afprintf(sfd, " %d ", on->lang);
	 SFDDumpUTF7Str(sfd, on->name);
      }
   }
   aputc('\n', sfd);
}

static void SFDDumpOtfFeatNames(AFILE *sfd,SplineFont *sf) {
   struct otffeatname *fn;
   struct otfname *on;

   for (fn=sf->feat_names; fn != NULL; fn=fn->next) {
      afprintf(sfd, "OtfFeatName: '%c%c%c%c' ",
	      fn->tag >> 24, fn->tag >> 16, fn->tag >> 8, fn->tag);
      for (on=fn->names; on != NULL; on=on->next) {
	 afprintf(sfd, "%d ", on->lang);
	 SFDDumpUTF7Str(sfd, on->name);
      }
      aputc('\n', sfd);
   }
}

static void putstring(AFILE *sfd,char *header,char *body) {
   afprintf(sfd, "%s", header);
   while (*body) {
      if (*body=='\n' || *body=='\\' || *body=='\r') {
	 aputc('\\', sfd);
	 if (*body=='\\')
	    aputc('\\', sfd);
	 else {
	    aputc('n', sfd);
	    if (*body=='\r' && body[1]=='\n')
	       ++body;
	 }
      } else
	 aputc(*body, sfd);
      ++body;
   }
   aputc('\n', sfd);
}

static void SFDDumpEncoding(AFILE *sfd,Encoding *encname,char *keyword) {
   afprintf(sfd, "%s: %s\n", keyword, encname->enc_name);
}

static void SFDDumpMacName(AFILE *sfd,struct macname *mn) {
   char *pt;

   while (mn != NULL) {
      afprintf(sfd, "MacName: %d %d %d \"", mn->enc, mn->lang,
	      (int) strlen(mn->name));
      for (pt=mn->name; *pt; ++pt) {
	 if (*pt < ' ' || *pt >= 0x7f || *pt=='\\' || *pt=='"')
	    afprintf(sfd, "\\%03o", *(uint8_t *) pt);
	 else
	    aputc(*pt, sfd);
      }
      afprintf(sfd, "\"\n");
      mn=mn->next;
   }
}

static void SFDDumpMacFeat(AFILE *sfd,MacFeat *mf) {
   struct macsetting *ms;

   if (mf==NULL)
      return;

   while (mf != NULL) {
      if (mf->featname != NULL) {
	 afprintf(sfd, "MacFeat: %d %d %d\n", mf->feature, mf->ismutex,
		 mf->default_setting);
	 SFDDumpMacName(sfd, mf->featname);
	 for (ms=mf->settings; ms != NULL; ms=ms->next) {
	    if (ms->setname != NULL) {
	       afprintf(sfd, "MacSetting: %d\n", ms->setting);
	       SFDDumpMacName(sfd, ms->setname);
	    }
	 }
      }
      mf=mf->next;
   }
   afprintf(sfd, "EndMacFeatures\n");
}

static void SFDDumpBaseLang(AFILE *sfd,struct baselangextent *bl) {

   if (bl->lang==0)
      afprintf(sfd, " { %d %d", bl->descent, bl->ascent);
   else
      afprintf(sfd, " { '%c%c%c%c' %d %d",
	      bl->lang >> 24, bl->lang >> 16, bl->lang >> 8, bl->lang,
	      bl->descent, bl->ascent);
   for (bl=bl->features; bl != NULL; bl=bl->next)
      SFDDumpBaseLang(sfd, bl);
   aputc('}', sfd);
}

static void SFDDumpBase(AFILE *sfd,char *keyword,struct Base *base) {
   int i;
   struct basescript *bs;
   struct baselangextent *bl;

   afprintf(sfd, "%s %d", keyword, base->baseline_cnt);
   for (i=0; i < base->baseline_cnt; ++i) {
      afprintf(sfd, " '%c%c%c%c'",
	      base->baseline_tags[i] >> 24,
	      base->baseline_tags[i] >> 16,
	      base->baseline_tags[i] >> 8, base->baseline_tags[i]);
   }
   aputc('\n', sfd);

   for (bs=base->scripts; bs != NULL; bs=bs->next) {
      afprintf(sfd, "BaseScript: '%c%c%c%c' %d ",
	      bs->script >> 24, bs->script >> 16, bs->script >> 8, bs->script,
	      bs->def_baseline);
      for (i=0; i < base->baseline_cnt; ++i)
	 afprintf(sfd, " %d", bs->baseline_pos[i]);
      for (bl=bs->langs; bl != NULL; bl=bl->next)
	 SFDDumpBaseLang(sfd, bl);
      aputc('\n', sfd);
   }
}

static void SFDDumpJSTFLookups(AFILE *sfd,char *keyword,OTLookup ** list) {
   int i;

   if (list==NULL || list[0]==NULL)
      return;

   afprintf(sfd, "%s ", keyword);
   for (i=0; list[i] != NULL; ++i) {
      SFDDumpUTF7Str(sfd, list[i]->lookup_name);
      aputc(' ', sfd);
   }
   aputc('\n', sfd);
}

static void SFDDumpJustify(AFILE *sfd,SplineFont *sf) {
   Justify *jscript;
   struct jstf_lang *jlang;
   int i;

   for (jscript=sf->justify; jscript != NULL; jscript=jscript->next) {
      afprintf(sfd, "Justify: '%c%c%c%c'\n",
	      jscript->script >> 24,
	      jscript->script >> 16, jscript->script >> 8, jscript->script);
      if (jscript->extenders != NULL)
	 afprintf(sfd, "JstfExtender: %s\n", jscript->extenders);
      for (jlang=jscript->langs; jlang != NULL; jlang=jlang->next) {
	 afprintf(sfd, "JstfLang: '%c%c%c%c' %d\n",
		 jlang->lang >> 24,
		 jlang->lang >> 16,
		 jlang->lang >> 8, jlang->lang, jlang->cnt);
	 for (i=0; i < jlang->cnt; ++i) {
	    afprintf(sfd, "JstfPrio:\n");
	    SFDDumpJSTFLookups(sfd, "JstfEnableShrink:",
			       jlang->prios[i].enableShrink);
	    SFDDumpJSTFLookups(sfd, "JstfDisableShrink:",
			       jlang->prios[i].disableShrink);
	    SFDDumpJSTFLookups(sfd, "JstfMaxShrink:",
			       jlang->prios[i].maxShrink);
	    SFDDumpJSTFLookups(sfd, "JstfEnableExtend:",
			       jlang->prios[i].enableExtend);
	    SFDDumpJSTFLookups(sfd, "JstfDisableExtend:",
			       jlang->prios[i].disableExtend);
	    SFDDumpJSTFLookups(sfd, "JstfMaxExtend:",
			       jlang->prios[i].maxExtend);
	 }
      }
   }
   if (sf->justify != NULL)
      afprintf(sfd, "EndJustify\n");
}

static void SFDFpstClassNamesOut(AFILE *sfd,int class_cnt,char **classnames,
				 char *keyword) {
   char buffer[20];
   int i;

   if (class_cnt > 0 && classnames != NULL) {
      afprintf(sfd, "  %s: ", keyword);
      for (i=0; i < class_cnt; ++i) {
	 if (classnames[i]==NULL) {
	    sprintf(buffer, "%d", i);
	    SFDDumpUTF7Str(sfd, buffer);
	 } else
	    SFDDumpUTF7Str(sfd, classnames[i]);
	 aputc(' ', sfd);
      }
      aputc('\n', sfd);
   }
}

static int SFD_DumpSplineFontMetadata(AFILE *sfd,SplineFont *sf) {
   int i, j;
   struct ttflangname *ln;
   struct ttf_table *tab;
   KernClass *kc;
   FPST *fpst;
   ASM *sm;
   int isv;
   int err=false;
   int isgpos;
   OTLookup *otl;
   struct lookup_subtable *sub;
   FeatureScriptLangList *fl;
   struct scriptlanglist *sl;

   afprintf(sfd, "FontName: %s\n", sf->fontname);
   if (sf->fullname != NULL)
      afprintf(sfd, "FullName: %s\n", sf->fullname);
   if (sf->familyname != NULL)
      afprintf(sfd, "FamilyName: %s\n", sf->familyname);
   if (sf->weight != NULL)
      afprintf(sfd, "Weight: %s\n", sf->weight);
   if (sf->copyright != NULL)
      putstring(sfd, "Copyright: ", sf->copyright);
   if (sf->comments != NULL) {
      afprintf(sfd, "UComments: ");
      SFDDumpUTF7Str(sfd, sf->comments);
      aputc('\n', sfd);
   }
   if (sf->fontlog != NULL) {
      afprintf(sfd, "FontLog: ");
      SFDDumpUTF7Str(sfd, sf->fontlog);
      aputc('\n', sfd);
   }

   if (sf->version != NULL)
      afprintf(sfd, "Version: %s\n", sf->version);
   if (sf->fondname != NULL)
      afprintf(sfd, "FONDName: %s\n", sf->fondname);
   if (sf->defbasefilename != NULL)
      afprintf(sfd, "DefaultBaseFilename: %s\n", sf->defbasefilename);
   if (sf->strokewidth != 0)
      afprintf(sfd, "StrokeWidth: %g\n", (double) sf->strokewidth);
   afprintf(sfd, "ItalicAngle: %g\n", (double) sf->italicangle);
   afprintf(sfd, "UnderlinePosition: %g\n", (double) sf->upos);
   afprintf(sfd, "UnderlineWidth: %g\n", (double) sf->uwidth);
   afprintf(sfd, "Ascent: %d\n", sf->ascent);
   afprintf(sfd, "Descent: %d\n", sf->descent);
   if (sf->sfntRevision != sfntRevisionUnset)
      afprintf(sfd, "sfntRevision: 0x%08x\n", sf->sfntRevision);
   if (sf->woffMajor != woffUnset) {
      afprintf(sfd, "woffMajor: %d\n", sf->woffMajor);
      afprintf(sfd, "woffMinor: %d\n", sf->woffMinor);
   }
   if (sf->woffMetadata != NULL) {
      afprintf(sfd, "woffMetadata: ");
      SFDDumpUTF7Str(sfd, sf->woffMetadata);
      aputc('\n', sfd);
   }
   if (sf->ufo_ascent != 0)
      afprintf(sfd, "UFOAscent: %g\n", (double) sf->ufo_ascent);
   if (sf->ufo_descent != 0)
      afprintf(sfd, "UFODescent: %g\n", (double) sf->ufo_descent);
   afprintf(sfd, "LayerCount: %d\n", sf->layer_cnt);
   for (i=0; i < sf->layer_cnt; ++i) {
      afprintf(sfd, "Layer: %d %d ", i,
	      sf->layers[i].order2 /*, sf->layers[i].background */ );
      SFDDumpUTF7Str(sfd, sf->layers[i].name);
      afprintf(sfd, " %d\n", sf->layers[i].background);
   }
   if (sf->strokedfont)
      afprintf(sfd, "StrokedFont: %d\n", sf->strokedfont);
   else if (sf->multilayer)
      afprintf(sfd, "MultiLayer: %d\n", sf->multilayer);
   if (sf->hasvmetrics)
      afprintf(sfd, "HasVMetrics: %d\n", sf->hasvmetrics);
   if (sf->use_xuid && sf->changed_since_xuidchanged)
      afprintf(sfd, "NeedsXUIDChange: 1\n");
   if (sf->xuid != NULL)
      afprintf(sfd, "XUID: %s\n", sf->xuid);
   if (sf->uniqueid != 0)
      afprintf(sfd, "UniqueID: %d\n", sf->uniqueid);
   if (sf->use_xuid)
      afprintf(sfd, "UseXUID: 1\n");
   if (sf->use_uniqueid)
      afprintf(sfd, "UseUniqueID: 1\n");
   if (sf->horiz_base != NULL)
      SFDDumpBase(sfd, "BaseHoriz:", sf->horiz_base);
   if (sf->vert_base != NULL)
      SFDDumpBase(sfd, "BaseVert:", sf->vert_base);
   if (sf->pfminfo.fstype != -1)
      afprintf(sfd, "FSType: %d\n", sf->pfminfo.fstype);
   afprintf(sfd, "OS2Version: %d\n", sf->os2_version);
   afprintf(sfd, "OS2_WeightWidthSlopeOnly: %d\n",
	   sf->weight_width_slope_only);
   afprintf(sfd, "OS2_UseTypoMetrics: %d\n", sf->use_typo_metrics);
   afprintf(sfd, "CreationTime: %lld\n", sf->creationtime);
   afprintf(sfd, "ModificationTime: %lld\n", sf->modificationtime);
   if (sf->pfminfo.pfmset) {
      afprintf(sfd, "PfmFamily: %d\n", sf->pfminfo.pfmfamily);
      afprintf(sfd, "TTFWeight: %d\n", sf->pfminfo.weight);
      afprintf(sfd, "TTFWidth: %d\n", sf->pfminfo.width);
      afprintf(sfd, "LineGap: %d\n", sf->pfminfo.linegap);
      afprintf(sfd, "VLineGap: %d\n", sf->pfminfo.vlinegap);
      /*aputc('\n',sfd); */
   }
   if (sf->pfminfo.panose_set) {
      afprintf(sfd, "Panose:");
      for (i=0; i < 10; ++i)
	 afprintf(sfd, " %d", sf->pfminfo.panose[i]);
      aputc('\n', sfd);
   }
   afprintf(sfd, "OS2TypoAscent: %d\n", sf->pfminfo.os2_typoascent);
   afprintf(sfd, "OS2TypoAOffset: %d\n", sf->pfminfo.typoascent_add);
   afprintf(sfd, "OS2TypoDescent: %d\n", sf->pfminfo.os2_typodescent);
   afprintf(sfd, "OS2TypoDOffset: %d\n", sf->pfminfo.typodescent_add);
   afprintf(sfd, "OS2TypoLinegap: %d\n", sf->pfminfo.os2_typolinegap);
   afprintf(sfd, "OS2WinAscent: %d\n", sf->pfminfo.os2_winascent);
   afprintf(sfd, "OS2WinAOffset: %d\n", sf->pfminfo.winascent_add);
   afprintf(sfd, "OS2WinDescent: %d\n", sf->pfminfo.os2_windescent);
   afprintf(sfd, "OS2WinDOffset: %d\n", sf->pfminfo.windescent_add);
   afprintf(sfd, "HheadAscent: %d\n", sf->pfminfo.hhead_ascent);
   afprintf(sfd, "HheadAOffset: %d\n", sf->pfminfo.hheadascent_add);
   afprintf(sfd, "HheadDescent: %d\n", sf->pfminfo.hhead_descent);
   afprintf(sfd, "HheadDOffset: %d\n", sf->pfminfo.hheaddescent_add);
   if (sf->pfminfo.subsuper_set) {
      afprintf(sfd, "OS2SubXSize: %d\n", sf->pfminfo.os2_subxsize);
      afprintf(sfd, "OS2SubYSize: %d\n", sf->pfminfo.os2_subysize);
      afprintf(sfd, "OS2SubXOff: %d\n", sf->pfminfo.os2_subxoff);
      afprintf(sfd, "OS2SubYOff: %d\n", sf->pfminfo.os2_subyoff);
      afprintf(sfd, "OS2SupXSize: %d\n", sf->pfminfo.os2_supxsize);
      afprintf(sfd, "OS2SupYSize: %d\n", sf->pfminfo.os2_supysize);
      afprintf(sfd, "OS2SupXOff: %d\n", sf->pfminfo.os2_supxoff);
      afprintf(sfd, "OS2SupYOff: %d\n", sf->pfminfo.os2_supyoff);
      afprintf(sfd, "OS2StrikeYSize: %d\n", sf->pfminfo.os2_strikeysize);
      afprintf(sfd, "OS2StrikeYPos: %d\n", sf->pfminfo.os2_strikeypos);
   }
   if (sf->pfminfo.os2_family_class != 0)
      afprintf(sfd, "OS2FamilyClass: %d\n", sf->pfminfo.os2_family_class);
   if (sf->pfminfo.os2_vendor[0] != '\0') {
      afprintf(sfd, "OS2Vendor: '%c%c%c%c'\n",
	      sf->pfminfo.os2_vendor[0], sf->pfminfo.os2_vendor[1],
	      sf->pfminfo.os2_vendor[2], sf->pfminfo.os2_vendor[3]);
   }
   if (sf->pfminfo.hascodepages)
      afprintf(sfd, "OS2CodePages: %08x.%08x\n", sf->pfminfo.codepages[0],
	      sf->pfminfo.codepages[1]);
   if (sf->pfminfo.hasunicoderanges)
      afprintf(sfd, "OS2UnicodeRanges: %08x.%08x.%08x.%08x\n",
	      sf->pfminfo.unicoderanges[0], sf->pfminfo.unicoderanges[1],
	      sf->pfminfo.unicoderanges[2], sf->pfminfo.unicoderanges[3]);
   if (sf->macstyle != -1)
      afprintf(sfd, "MacStyle: %d\n", sf->macstyle);
   /* Must come before any kerning classes, anchor classes, conditional psts */
   /* state machines, psts, kerning pairs, etc. */
   for (isgpos=0; isgpos < 2; ++isgpos) {
      for (otl=sf->gsplookups[isgpos];otl!=NULL;otl=otl->next) {
	 afprintf(sfd, "Lookup: %d %d %d ", otl->lookup_type,
		 otl->lookup_flags, otl->store_in_afm);
	 SFDDumpUTF7Str(sfd, otl->lookup_name);
	 afprintf(sfd, " {");
	 for (sub=otl->subtables; sub != NULL; sub=sub->next) {
	    SFDDumpUTF7Str(sfd, sub->subtable_name);
	    if (otl->lookup_type==gsub_single && sub->suffix != NULL) {
	       aputc('(', sfd);
	       SFDDumpUTF7Str(sfd, sub->suffix);
	       aputc(')', sfd);
	    } else if (otl->lookup_type==gpos_pair && sub->vertical_kerning)
	       afprintf(sfd, "(1)");
	    if (otl->lookup_type==gpos_pair
		&& (sub->separation != 0 || sub->kerning_by_touch))
	       afprintf(sfd, "[%d,%d,%d]", sub->separation, sub->minkern,
		       sub->kerning_by_touch + 2 * sub->onlyCloser +
		       4 * sub->dontautokern);
	    aputc(' ', sfd);
	 }
	 afprintf(sfd, "} [");
	 for (fl=otl->features; fl != NULL; fl=fl->next) {
	    if (fl->ismac)
	       afprintf(sfd, "<%d,%d> (",
		       (int) (fl->featuretag >> 16),
		       (int) (fl->featuretag & 0xffff));
	    else
	       afprintf(sfd, "'%c%c%c%c' (",
		       (int) (fl->featuretag >> 24),
		       (int) ((fl->featuretag >> 16) & 0xff),
		       (int) ((fl->featuretag >> 8) & 0xff),
		       (int) (fl->featuretag & 0xff));
	    for (sl=fl->scripts; sl != NULL; sl=sl->next) {
	       afprintf(sfd, "'%c%c%c%c' <",
		       (int) (sl->script >> 24),
		       (int) ((sl->script >> 16) & 0xff),
		       (int) ((sl->script >> 8) & 0xff),
		       (int) (sl->script & 0xff));
	       for (i=0; i < sl->lang_cnt; ++i) {
		  uint32_t lang =
		     i <
		     MAX_LANG ? sl->langs[i] : sl->morelangs[i - MAX_LANG];
		  afprintf(sfd, "'%c%c%c%c' ", (int) (lang >> 24),
			  (int) ((lang >> 16) & 0xff),
			  (int) ((lang >> 8) & 0xff), (int) (lang & 0xff));
	       }
	       afprintf(sfd, "> ");
	    }
	    afprintf(sfd, ") ");
	 }
	 afprintf(sfd, "]\n");
      }
   }

   if (sf->mark_class_cnt != 0) {
      afprintf(sfd, "MarkAttachClasses: %d\n", sf->mark_class_cnt);
      for (i=1; i < sf->mark_class_cnt; ++i) {	/* Class 0 is unused */
	 SFDDumpUTF7Str(sfd, sf->mark_class_names[i]);
	 if (sf->mark_classes[i] != NULL)
	    afprintf(sfd, "%d %s\n", (int) strlen(sf->mark_classes[i]),
		    sf->mark_classes[i]);
	 else
	    afprintf(sfd, "0 \n");
      }
   }
   if (sf->mark_set_cnt != 0) {
      afprintf(sfd, "MarkAttachSets: %d\n", sf->mark_set_cnt);
      for (i=0; i < sf->mark_set_cnt; ++i) {	/* Set 0 is used */
	 SFDDumpUTF7Str(sfd, sf->mark_set_names[i]);
	 if (sf->mark_sets[i] != NULL)
	    afprintf(sfd, "%d %s\n", (int) strlen(sf->mark_sets[i]),
		    sf->mark_sets[i]);
	 else
	    afprintf(sfd, "0 \n");
      }
   }

   afprintf(sfd, "DEI: 91125\n");
   for (isv=0; isv < 2; ++isv) {
      for (kc=isv ? sf->vkerns : sf->kerns; kc != NULL; kc=kc->next) {
	 afprintf(sfd, "%s: %d%s %d ", isv ? "VKernClass2" : "KernClass2",
		 kc->first_cnt, kc->firsts[0] != NULL ? "+" : "",
		 kc->second_cnt);
	 SFDDumpUTF7Str(sfd, kc->subtable->subtable_name);
	 afprintf(sfd, "\n");
	 if (kc->firsts[0] != NULL)
	    afprintf(sfd, " %d %s\n", (int) strlen(kc->firsts[0]),
		    kc->firsts[0]);
	 for (i=1; i < kc->first_cnt; ++i)
	    afprintf(sfd, " %d %s\n", (int) strlen(kc->firsts[i]),
		    kc->firsts[i]);
	 for (i=1; i < kc->second_cnt; ++i)
	    afprintf(sfd, " %d %s\n", (int) strlen(kc->seconds[i]),
		    kc->seconds[i]);
	 for (i=0; i < kc->first_cnt * kc->second_cnt; ++i) {
	    afprintf(sfd, " %d", kc->offsets[i]);
	    aputc(' ', sfd);
	    SFDDumpDeviceTable(sfd, &kc->adjusts[i]);
	 }
	 afprintf(sfd, "\n");
      }
   }
   for (fpst=sf->possub; fpst != NULL; fpst=fpst->next) {
      static char *keywords[] =
	 { "ContextPos2:", "ContextSub2:", "ChainPos2:", "ChainSub2:",
"ReverseChain2:", NULL };
      static char *formatkeys[] =
	 { "glyph", "class", "coverage", "revcov", NULL };
      afprintf(sfd, "%s %s ", keywords[fpst->type - pst_contextpos],
	      formatkeys[fpst->format]);
      SFDDumpUTF7Str(sfd, fpst->subtable->subtable_name);
      afprintf(sfd, " %d %d %d %d\n",
	      fpst->nccnt, fpst->bccnt, fpst->fccnt, fpst->rule_cnt);
      if (fpst->nccnt > 0 && fpst->nclass[0] != NULL)
	 afprintf(sfd, "  Class0: %d %s\n", (int) strlen(fpst->nclass[0]),
		 fpst->nclass[0]);
      for (i=1; i < fpst->nccnt; ++i)
	 afprintf(sfd, "  Class: %d %s\n", (int) strlen(fpst->nclass[i]),
		 fpst->nclass[i]);
      for (i=1; i < fpst->bccnt; ++i)
	 afprintf(sfd, "  BClass: %d %s\n", (int) strlen(fpst->bclass[i]),
		 fpst->bclass[i]);
      for (i=1; i < fpst->fccnt; ++i)
	 afprintf(sfd, "  FClass: %d %s\n", (int) strlen(fpst->fclass[i]),
		 fpst->fclass[i]);
      for (i=0; i < fpst->rule_cnt; ++i) {
	 switch (fpst->format) {
	   case pst_glyphs:
	      afprintf(sfd, " String: %d %s\n",
		      (int) strlen(fpst->rules[i].u.glyph.names),
		      fpst->rules[i].u.glyph.names);
	      if (fpst->rules[i].u.glyph.back != NULL)
		 afprintf(sfd, " BString: %d %s\n",
			 (int) strlen(fpst->rules[i].u.glyph.back),
			 fpst->rules[i].u.glyph.back);
	      else
		 afprintf(sfd, " BString: 0\n");
	      if (fpst->rules[i].u.glyph.fore != NULL)
		 afprintf(sfd, " FString: %d %s\n",
			 (int) strlen(fpst->rules[i].u.glyph.fore),
			 fpst->rules[i].u.glyph.fore);
	      else
		 afprintf(sfd, " FString: 0\n");
	      break;
	   case pst_class:
	      afprintf(sfd, " %d %d %d\n  ClsList:",
		      fpst->rules[i].u.class.ncnt,
		      fpst->rules[i].u.class.bcnt,
		      fpst->rules[i].u.class.fcnt);
	      for (j=0; j < fpst->rules[i].u.class.ncnt; ++j)
		 afprintf(sfd, " %d", fpst->rules[i].u.class.nclasses[j]);
	      afprintf(sfd, "\n  BClsList:");
	      for (j=0; j < fpst->rules[i].u.class.bcnt; ++j)
		 afprintf(sfd, " %d", fpst->rules[i].u.class.bclasses[j]);
	      afprintf(sfd, "\n  FClsList:");
	      for (j=0; j < fpst->rules[i].u.class.fcnt; ++j)
		 afprintf(sfd, " %d", fpst->rules[i].u.class.fclasses[j]);
	      afprintf(sfd, "\n");
	      break;
	   case pst_coverage:
	   case pst_reversecoverage:
	      afprintf(sfd, " %d %d %d\n", fpst->rules[i].u.coverage.ncnt,
		      fpst->rules[i].u.coverage.bcnt,
		      fpst->rules[i].u.coverage.fcnt);
	      for (j=0; j < fpst->rules[i].u.coverage.ncnt; ++j)
		 afprintf(sfd, "  Coverage: %d %s\n",
			 (int) strlen(fpst->rules[i].u.coverage.ncovers[j]),
			 fpst->rules[i].u.coverage.ncovers[j]);
	      for (j=0; j < fpst->rules[i].u.coverage.bcnt; ++j)
		 afprintf(sfd, "  BCoverage: %d %s\n",
			 (int) strlen(fpst->rules[i].u.coverage.bcovers[j]),
			 fpst->rules[i].u.coverage.bcovers[j]);
	      for (j=0; j < fpst->rules[i].u.coverage.fcnt; ++j)
		 afprintf(sfd, "  FCoverage: %d %s\n",
			 (int) strlen(fpst->rules[i].u.coverage.fcovers[j]),
			 fpst->rules[i].u.coverage.fcovers[j]);
	      break;
	 }
	 switch (fpst->format) {
	   case pst_glyphs:
	   case pst_class:
	   case pst_coverage:
	      afprintf(sfd, " %d\n", fpst->rules[i].lookup_cnt);
	      for (j=0; j < fpst->rules[i].lookup_cnt; ++j) {
		 afprintf(sfd, "  SeqLookup: %d ",
			 fpst->rules[i].lookups[j].seq);
		 SFDDumpUTF7Str(sfd,
				fpst->rules[i].lookups[j].lookup->
				lookup_name);
		 aputc('\n', sfd);
	      }
	      break;
	   case pst_reversecoverage:
	      afprintf(sfd, "  Replace: %d %s\n",
		      (int) strlen(fpst->rules[i].u.rcoverage.replacements),
		      fpst->rules[i].u.rcoverage.replacements);
	      break;
	 }
      }
      /* It would make more sense to output these up near the classes */
      /*  but that would break backwards compatibility (old parsers will */
      /*  ignore these entries if they are at the end, new parsers will */
      /*  read them */
      SFDFpstClassNamesOut(sfd, fpst->nccnt, fpst->nclassnames, "ClassNames");
      SFDFpstClassNamesOut(sfd, fpst->bccnt, fpst->bclassnames,
			   "BClassNames");
      SFDFpstClassNamesOut(sfd, fpst->fccnt, fpst->fclassnames,
			   "FClassNames");
      afprintf(sfd, "EndFPST\n");
   }
   for (sm=sf->sm; sm != NULL; sm=sm->next) {
      static char *keywords[] =
	 { "MacIndic2:", "MacContext2:", "MacLigature2:", "unused",
"MacSimple2:", "MacInsert2:",
	 "unused", "unused", "unused", "unused", "unused", "unused",
	 "unused", "unused", "unused", "unused", "unused", "MacKern2:",
	 NULL
      };
      afprintf(sfd, "%s ", keywords[sm->type - asm_indic]);
      SFDDumpUTF7Str(sfd, sm->subtable->subtable_name);
      afprintf(sfd, " %d %d %d\n", sm->flags, sm->class_cnt, sm->state_cnt);
      for (i=4; i < sm->class_cnt; ++i)
	 afprintf(sfd, "  Class: %d %s\n", (int) strlen(sm->classes[i]),
		 sm->classes[i]);
      for (i=0; i < sm->class_cnt * sm->state_cnt; ++i) {
	 afprintf(sfd, " %d %d ", sm->state[i].next_state, sm->state[i].flags);
	 if (sm->type==asm_context) {
	    if (sm->state[i].u.context.mark_lookup==NULL)
	       aputc('~', sfd);
	    else
	       SFDDumpUTF7Str(sfd,
			      sm->state[i].u.context.mark_lookup->
			      lookup_name);
	    aputc(' ', sfd);
	    if (sm->state[i].u.context.cur_lookup==0)
	       aputc('~', sfd);
	    else
	       SFDDumpUTF7Str(sfd,
			      sm->state[i].u.context.cur_lookup->lookup_name);
	    aputc(' ', sfd);
	 } else if (sm->type==asm_insert) {
	    if (sm->state[i].u.insert.mark_ins==NULL)
	       afprintf(sfd, "0 ");
	    else
	       afprintf(sfd, "%d %s ",
		       (int) strlen(sm->state[i].u.insert.mark_ins),
		       sm->state[i].u.insert.mark_ins);
	    if (sm->state[i].u.insert.cur_ins==NULL)
	       afprintf(sfd, "0 ");
	    else
	       afprintf(sfd, "%d %s ",
		       (int) strlen(sm->state[i].u.insert.cur_ins),
		       sm->state[i].u.insert.cur_ins);
	 } else if (sm->type==asm_kern) {
	    afprintf(sfd, "%d ", sm->state[i].u.kern.kcnt);
	    for (j=0; j < sm->state[i].u.kern.kcnt; ++j)
	       afprintf(sfd, "%d ", sm->state[i].u.kern.kerns[j]);
	 }
	 aputc('\n', sfd);
      }
      afprintf(sfd, "EndASM\n");
   }
   SFDDumpMacFeat(sfd, sf->features);
   SFDDumpJustify(sfd, sf);
   for (tab=sf->ttf_tables; tab != NULL; tab=tab->next)
      SFDDumpTtfTable(sfd, tab, sf);
   for (tab=sf->ttf_tab_saved; tab != NULL; tab=tab->next)
      SFDDumpTtfTable(sfd, tab, sf);
   for (ln=sf->names; ln != NULL; ln=ln->next)
      SFDDumpLangName(sfd, ln);
   if (sf->gasp_cnt != 0)
      SFDDumpGasp(sfd, sf);
   if (sf->design_size != 0)
      SFDDumpDesignSize(sfd, sf);
   if (sf->feat_names != NULL)
      SFDDumpOtfFeatNames(sfd, sf);

   return (err);
}


static int SFD_Dump(AFILE *sfd,SplineFont *sf,EncMap *map,
		    EncMap * normal) {
   int i, realcnt;
   BDFFont *bdf;
   int *newgids=NULL;
   int err=false;

   if (normal != NULL)
      map=normal;

   SFD_DumpSplineFontMetadata(sfd, sf);

   if (sf->MATH != NULL) {
      struct MATH *math=sf->MATH;

      for (i=0; math_constants_descriptor[i].script_name != NULL; ++i) {
	 afprintf(sfd, "MATH:%s: %d", math_constants_descriptor[i].script_name,
		 *((int16_t *) (((char *) (math)) +
			      math_constants_descriptor[i].offset)));
	 if (math_constants_descriptor[i].devtab_offset >= 0) {
	    DeviceTable **devtab =
	       (DeviceTable **) (((char *) (math)) +
				 math_constants_descriptor[i].devtab_offset);
	    aputc(' ', sfd);
	    SFDDumpDeviceTable(sfd, *devtab);
	 }
	 aputc('\n', sfd);
      }
   }
   if (sf->python_persistent != NULL)
      SFDPickleMe(sfd, sf->python_persistent);
   if (sf->subfontcnt != 0) {
      /* CID fonts have no encodings, they have registry info instead */
      afprintf(sfd, "Registry: %s\n", sf->cidregistry);
      afprintf(sfd, "Ordering: %s\n", sf->ordering);
      afprintf(sfd, "Supplement: %d\n", sf->supplement);
      afprintf(sfd, "CIDVersion: %g\n", sf->cidversion);	/* This is a number whereas "version" is a string */
   } else
      SFDDumpEncoding(sfd, map->enc, "Encoding");
   if (normal != NULL)
      afprintf(sfd, "Compacted: 1\n");
   afprintf(sfd, "UnicodeInterp: %s\n", unicode_interp_names[sf->uni_interp]);
   afprintf(sfd, "NameList: %s\n", sf->for_new_glyphs->title);

   if (map->remap != NULL) {
      struct remap *remap;
      int n;

      for (n=0, remap=map->remap; remap->infont != -1; ++n, ++remap);
      afprintf(sfd, "RemapN: %d\n", n);
      for (remap=map->remap; remap->infont != -1; ++remap)
	 afprintf(sfd, "Remap: %x %x %d\n", (int) remap->firstenc,
		 (int) remap->lastenc, (int) remap->infont);
   }
   if (sf->display_size != 0)
      afprintf(sfd, "DisplaySize: %d\n", sf->display_size);
   if (sf->display_layer != ly_fore)
      afprintf(sfd, "DisplayLayer: %d\n", sf->display_layer);
   afprintf(sfd, "AntiAlias: %d\n", sf->display_antialias);
   afprintf(sfd, "FitToEm: %d\n", sf->display_bbsized);
   if (sf->extrema_bound != 0)
      afprintf(sfd, "ExtremaBound: %d\n", sf->extrema_bound);
   if (sf->width_separation != 0)
      afprintf(sfd, "WidthSeparation: %d\n", sf->width_separation);
   {
      int rc, cc, te;

      if ((te=FVWinInfo(sf->fv, &cc, &rc)) != -1)
	 afprintf(sfd, "WinInfo: %d %d %d\n", te, cc, rc);
      else if (sf->top_enc != -1)
	 afprintf(sfd, "WinInfo: %d %d %d\n", sf->top_enc, sf->desired_col_cnt,
		 sf->desired_row_cnt);
   }
   if (sf->onlybitmaps != 0)
      afprintf(sfd, "OnlyBitmaps: %d\n", sf->onlybitmaps);
   if (sf->private != NULL)
      SFDDumpPrivate(sfd, sf->private);
#if HANYANG
   if (sf->rules != NULL)
      SFDDumpCompositionRules(sfd, sf->rules);
#endif
   if (sf->grid.splines != NULL) {
      if (sf->grid.order2)
	 afprintf(sfd, "GridOrder2: %d\n", sf->grid.order2);
      afprintf(sfd, "Grid\n");
      SFDDumpSplineSet(sfd, sf->grid.splines);
   }
   if (sf->texdata.type != tex_unset) {
      afprintf(sfd, "TeXData: %d %d", (int) sf->texdata.type,
	      (int) ((sf->design_size << 19) + 2) / 5);
      for (i=0; i < 22; ++i)
	 afprintf(sfd, " %d", (int) sf->texdata.params[i]);
      aputc('\n', sfd);
   }
   if (sf->anchor != NULL) {
      AnchorClass *an;

      afprintf(sfd, "AnchorClass2: ");
      for (an=sf->anchor; an != NULL; an=an->next) {
	 SFDDumpUTF7Str(sfd, an->name);
	 if (an->subtable != NULL) {
	    aputc(' ', sfd);
	    SFDDumpUTF7Str(sfd, an->subtable->subtable_name);
	 }
      }
      aputc('\n', sfd);
   }

   if (sf->subfontcnt != 0) {
	 int max;

	 for (i=max=0; i < sf->subfontcnt; ++i)
	    if (max < sf->subfonts[i]->glyphcnt)
	       max=sf->subfonts[i]->glyphcnt;
	 afprintf(sfd, "BeginSubFonts: %d %d\n", sf->subfontcnt, max);
	 for (i=0; i < sf->subfontcnt; ++i)
	    SFD_Dump(sfd, sf->subfonts[i], map, NULL);
	 afprintf(sfd, "EndSubFonts\n");
   } else {
      int enccount=map->enccount;

      if (sf->cidmaster != NULL) {
	 realcnt=-1;
	 enccount=sf->glyphcnt;
      } else {
	 realcnt=0;
	 for (i=0; i < sf->glyphcnt; ++i)
	    if (!SFDOmit(sf->glyphs[i]))
	       ++realcnt;
	 if (realcnt != sf->glyphcnt) {
	    newgids=malloc(sf->glyphcnt * sizeof(int));
	    realcnt=0;
	    for (i=0; i < sf->glyphcnt; ++i)
	       if (SFDOmit(sf->glyphs[i]))
		  newgids[i]=-1;
	       else
		  newgids[i]=realcnt++;
	 }
      }
	 afprintf(sfd, "BeginChars: %d %d\n",
		 enccount <
		 map->enc->char_cnt ? map->enc->char_cnt : enccount, realcnt);
      for (i=0; i < sf->glyphcnt; ++i) {
	 if (!SFDOmit(sf->glyphs[i]))
	       SFDDumpChar(sfd, sf->glyphs[i], map, newgids, 1);
      }
	 afprintf(sfd, "EndChars\n");
   }

   for (bdf=sf->bitmaps; bdf != NULL; bdf=bdf->next) {
	 SFDDumpBitmapFont(sfd, bdf, map, newgids);
   }
   afprintf(sfd,
	   sf->cidmaster==NULL ? "EndSplineFont\n" : "EndSubSplineFont\n");
   free(newgids);
   return (err);
}

static int SFD_MMDump(AFILE *sfd,SplineFont *sf,EncMap *map,
		      EncMap * normal) {
   MMSet *mm=sf->mm;
   int max, i, j;
   int err=false;

   afprintf(sfd, "MMCounts: %d %d %d %d\n", mm->instance_count, mm->axis_count,
	   mm->apple, mm->named_instance_count);
   afprintf(sfd, "MMAxis:");
   for (i=0; i < mm->axis_count; ++i)
      afprintf(sfd, " %s", mm->axes[i]);
   aputc('\n', sfd);
   afprintf(sfd, "MMPositions:");
   for (i=0; i < mm->axis_count * mm->instance_count; ++i)
      afprintf(sfd, " %g", (double) mm->positions[i]);
   aputc('\n', sfd);
   afprintf(sfd, "MMWeights:");
   for (i=0; i < mm->instance_count; ++i)
      afprintf(sfd, " %g", (double) mm->defweights[i]);
   aputc('\n', sfd);
   for (i=0; i < mm->axis_count; ++i) {
      afprintf(sfd, "MMAxisMap: %d %d", i, mm->axismaps[i].points);
      for (j=0; j < mm->axismaps[i].points; ++j)
	 afprintf(sfd, " %g=>%g", (double) mm->axismaps[i].blends[j],
		 (double) mm->axismaps[i].designs[j]);
      aputc('\n', sfd);
      SFDDumpMacName(sfd, mm->axismaps[i].axisnames);
   }
   if (mm->cdv != NULL) {
      afprintf(sfd, "MMCDV:\n");
      afputs(mm->cdv, sfd);
      afprintf(sfd, "\nEndMMSubroutine\n");
   }
   if (mm->ndv != NULL) {
      afprintf(sfd, "MMNDV:\n");
      afputs(mm->ndv, sfd);
      afprintf(sfd, "\nEndMMSubroutine\n");
   }
   for (i=0; i < mm->named_instance_count; ++i) {
      afprintf(sfd, "MMNamedInstance: %d ", i);
      for (j=0; j < mm->axis_count; ++j)
	 afprintf(sfd, " %g", (double) mm->named_instances[i].coords[j]);
      aputc('\n', sfd);
      SFDDumpMacName(sfd, mm->named_instances[i].names);
   }

   for (i=max=0; i < mm->instance_count; ++i)
     if (max < mm->instances[i]->glyphcnt)
       max=mm->instances[i]->glyphcnt;
   afprintf(sfd, "BeginMMFonts: %d %d\n", mm->instance_count + 1, max);
   for (i=0; i < mm->instance_count; ++i)
     SFD_Dump(sfd, mm->instances[i], map, normal);
   SFD_Dump(sfd, mm->normal, map, normal);
   afprintf(sfd, "EndMMFonts\n");
   return (err);
}

static int SFDDump(AFILE *sfd,SplineFont *sf,EncMap *map,EncMap *normal) {
   int i, realcnt;
   BDFFont *bdf;
   int err=false;

   realcnt=sf->glyphcnt;
   if (sf->subfontcnt != 0) {
      for (i=0; i < sf->subfontcnt; ++i)
	 if (realcnt < sf->subfonts[i]->glyphcnt)
	    realcnt=sf->subfonts[i]->glyphcnt;
   }
   for (i=0, bdf=sf->bitmaps; bdf != NULL; bdf=bdf->next, ++i);
   double version=3.0;

   afprintf(sfd, "SplineFontDB: %.1f\n", version);
   if (sf->mm != NULL)
      err=SFD_MMDump(sfd, sf->mm->normal, map, normal);
   else
      err=SFD_Dump(sfd, sf, map, normal);
   return (err);
}

static int SFDWrite(char *filename,SplineFont *sf,EncMap *map,
		    EncMap *normal) {
   AFILE *sfd;
   int i, gc;
   char *tempfilename=filename;
   int err=false;

   sfd=afopen(tempfilename, "w");
   if (tempfilename != filename)
      free(tempfilename);
   if (sfd==NULL)
      return (0);

   if (sf->cidmaster != NULL) {
      sf=sf->cidmaster;
      gc=1;
      for (i=0; i < sf->subfontcnt; ++i)
	 if (sf->subfonts[i]->glyphcnt > gc)
	    gc=sf->subfonts[i]->glyphcnt;
      map=EncMap1to1(gc);
      err=SFDDump(sfd, sf, map, NULL);
      EncMapFree(map);
   } else
      err=SFDDump(sfd, sf, map, normal);
   if (aferror(sfd))
      err=true;
   if (afclose(sfd))
      err=true;
   return !err;
}

static int SFDDoesAnyBackupExist(char *filename) {
   char path[PATH_MAX];
   int idx=1;

   snprintf(path, PATH_MAX, "%s-%02d", filename, idx);
   return GFileExists(path);
}


static int SFDWriteBak(SplineFont *sf,EncMap *map,EncMap *normal) {
   char *buf=0, *buf2=NULL;
   int ret;

   if (sf->cidmaster != NULL)
      sf=sf->cidmaster;
   buf=malloc(strlen(sf->filename) + 10);
   if (sf->compression != 0) {
      buf2=malloc(strlen(sf->filename) + 10);
      strcpy(buf2, sf->filename);
      strcat(buf2, compressors[sf->compression - 1].ext);
      strcpy(buf, buf2);
      strcat(buf, "~");
      if (rename(buf2, buf)==0)
	 sf->backedup=bs_backedup;
   } else {
      sf->backedup=bs_dontknow;

      if (prefRevisionsToRetain) {
	 char path[PATH_MAX];
	 char pathnew[PATH_MAX];
	 int idx=0;
	 int rc=0;

	 snprintf(path, PATH_MAX, "%s", sf->filename);
	 snprintf(pathnew, PATH_MAX, "%s-%02d", sf->filename, idx);
	 rc=rename(path, pathnew);

	 for (idx=prefRevisionsToRetain; idx > 0; idx--) {
	    snprintf(path, PATH_MAX, "%s-%02d", sf->filename, idx - 1);
	    snprintf(pathnew, PATH_MAX, "%s-%02d", sf->filename, idx);
	    int rc=rename(path, pathnew);

	    if (!idx && !rc)
	       sf->backedup=bs_backedup;
	 }
	 idx=prefRevisionsToRetain + 1;
	 snprintf(path, PATH_MAX, "%s-%02d", sf->filename, idx);
	 unlink(path);
      }

   }
   free(buf);

   ret=SFDWrite(sf->filename, sf, map, normal);
   if (ret && sf->compression != 0) {
      unlink(buf2);
      buf=malloc(strlen(sf->filename) + 40);
      sprintf(buf, "%s %s", compressors[sf->compression - 1].recomp,
	      sf->filename);
      if (system(buf) != 0)
	 sf->compression=0;
      free(buf);
   }
   free(buf2);
   return (ret);
}

/*
 * Handle creation of potential implicit revisions when saving.
 *
 * If localRevisionsToRetain==0 then no revisions are made.
 *
 * If localRevisionsToRetain > 0 then it is taken as an explict number
 * of revisions to make, and revisions are made
 *
 * If localRevisionsToRetain==-1 then it is "not set".
 * In that case, revisions are only made if there are already revisions
 * for the locfilename.
 *
 */
int SFDWriteBakExtended(char *locfilename,
			SplineFont *sf, EncMap * map, EncMap * normal,
			int localRevisionsToRetain) {
   int rc=0;
   int cacheRevisionsToRetain=prefRevisionsToRetain;
   char *cacheSFFilename=sf->filename;

   sf->filename=locfilename;

   if (localRevisionsToRetain < 0) {
      // If there are no backups, then don't start creating any
      if (!SFDDoesAnyBackupExist(sf->filename))
	 prefRevisionsToRetain=0;
   } else {
      prefRevisionsToRetain=localRevisionsToRetain;
   }

   rc=SFDWriteBak(sf, map, normal);

   sf->filename=cacheSFFilename;
   prefRevisionsToRetain=cacheRevisionsToRetain;

   return rc;
}

/* ********************************* INPUT ********************************** */
#include "sfd1.h"

static char *getquotedeol(AFILE *sfd) {
   char *pt, *str, *end;
   int ch;

   pt=str=malloc(101);
   end=str + 100;
   while (isspace(ch=nlgetc(sfd)) && ch != '\r' && ch != '\n');
   while (ch != '\n' && ch != '\r' && ch != EOF) {
      if (ch=='\\') {
	 /* We can't use nlgetc() here, because it would misinterpret */
	 /* double backslash at the end of line. Multiline strings,   */
	 /* broken with backslash + newline, are just handled above.  */
	 ch=agetc(sfd);
	 if (ch=='n')
	    ch='\n';
	 /* else if ( ch=='\\' ) ch=='\\'; *//* second backslash of '\\' */

	 /* FontAnvil doesn't write other escape sequences in this context. */
	 /* So any other value of ch is assumed impossible. */
      }
      if (pt >= end) {
	 pt=realloc(str, end - str + 101);
	 end=pt + (end - str) + 100;
	 str=pt;
	 pt=end - 100;
      }
      *pt++=ch;
      ch=nlgetc(sfd);
   }
   *pt='\0';
   /* these strings should be in utf8 now, but some old sfd files might have */
   /* latin1. Not a severe problems because they SHOULD be in ASCII. So any */
   /* non-ascii strings are erroneous anyway */
   if (!utf8_valid(str)) {
      pt=latin1_2_utf8_copy(str);
      free(str);
      str=pt;
   }
   return (str);
}

static int geteol(AFILE *sfd,char *tokbuf) {
   char *pt=tokbuf, *end=tokbuf + 2000 - 2;
   int ch;

   while (isspace(ch=nlgetc(sfd)) && ch != '\r' && ch != '\n');
   while (ch != '\n' && ch != '\r' && ch != EOF) {
      if (pt < end)
	 *pt++=ch;
      ch=nlgetc(sfd);
   }
   *pt='\0';
   return (pt != tokbuf ? 1 : ch==EOF ? -1 : 0);
}

static int getprotectedname(AFILE *sfd,char *tokbuf) {
   char *pt=tokbuf, *end=tokbuf + 100 - 2;
   int ch;

   while ((ch=nlgetc(sfd))==' ' || ch=='\t');
   while (ch != EOF && !isspace(ch) && ch != '[' && ch != ']' && ch != '{'
	  && ch != '}' && ch != '<' && ch != '%') {
      if (pt < end)
	 *pt++=ch;
      ch=nlgetc(sfd);
   }
   if (pt==tokbuf && ch != EOF)
      *pt++=ch;
   else
      aungetc(ch, sfd);
   *pt='\0';
   return (pt != tokbuf ? 1 : ch==EOF ? -1 : 0);
}

static int getname(AFILE *sfd,char *tokbuf) {
   int ch;

   while (isspace(ch=nlgetc(sfd)));
   aungetc(ch, sfd);
   return (getprotectedname(sfd, tokbuf));
}

static uint32_t gettag(AFILE *sfd) {
   int ch, quoted;
   uint32_t tag;

   while ((ch=nlgetc(sfd))==' ');
   if ((quoted=(ch=='\'')))
      ch=nlgetc(sfd);
   tag=(ch << 24) | (nlgetc(sfd) << 16);
   tag |= nlgetc(sfd) << 8;
   tag |= nlgetc(sfd);
   if (quoted)
      (void) nlgetc(sfd);
   return (tag);
}

static int getint(AFILE *sfd,int *val) {
   char tokbuf[100];
   int ch;
   char *pt=tokbuf, *end=tokbuf + 100 - 2;

   while (isspace(ch=nlgetc(sfd)));
   if (ch=='-' || ch=='+') {
      *pt++=ch;
      ch=nlgetc(sfd);
   }
   while (isdigit(ch)) {
      if (pt < end)
	 *pt++=ch;
      ch=nlgetc(sfd);
   }
   *pt='\0';
   aungetc(ch, sfd);
   *val=strtol(tokbuf, NULL, 10);
   return (pt != tokbuf ? 1 : ch==EOF ? -1 : 0);
}

static int getlonglong(AFILE *sfd,long long *val) {
   char tokbuf[100];
   int ch;
   char *pt=tokbuf, *end=tokbuf + 100 - 2;

   while (isspace(ch=nlgetc(sfd)));
   if (ch=='-' || ch=='+') {
      *pt++=ch;
      ch=nlgetc(sfd);
   }
   while (isdigit(ch)) {
      if (pt < end)
	 *pt++=ch;
      ch=nlgetc(sfd);
   }
   *pt='\0';
   aungetc(ch, sfd);
   *val=strtoll(tokbuf, NULL, 10);
   return (pt != tokbuf ? 1 : ch==EOF ? -1 : 0);
}

static int gethex(AFILE *sfd,uint32_t *val) {
   char tokbuf[100];
   int ch;
   char *pt=tokbuf, *end=tokbuf + 100 - 2;

   while (isspace(ch=nlgetc(sfd)));
   if (ch=='#')
      ch=nlgetc(sfd);
   if (ch=='-' || ch=='+') {
      *pt++=ch;
      ch=nlgetc(sfd);
   }
   if (ch=='0') {
      ch=nlgetc(sfd);
      if (ch=='x' || ch=='X')
	 ch=nlgetc(sfd);
      else {
	 aungetc(ch, sfd);
	 ch='0';
      }
   }
   while (isdigit(ch) || (ch >= 'a' && ch <= 'f') || (ch >= 'A' && ch <= 'F')) {
      if (pt < end)
	 *pt++=ch;
      ch=nlgetc(sfd);
   }
   *pt='\0';
   aungetc(ch, sfd);
   *val=strtoul(tokbuf, NULL, 16);
   return (pt != tokbuf ? 1 : ch==EOF ? -1 : 0);
}

static int gethexints(AFILE *sfd,uint32_t *val,int cnt) {
   int i, ch;

   for (i=0; i < cnt; ++i) {
      if (i != 0) {
	 ch=nlgetc(sfd);
	 if (ch != '.')
	    aungetc(ch, sfd);
      }
      if (!gethex(sfd, &val[i]))
	 return (false);
   }
   return (true);
}

static int getsint(AFILE *sfd,int16_t *val) {
   int val2;
   int ret=getint(sfd, &val2);

   *val=val2;
   return (ret);
}

static int getusint(AFILE *sfd,uint16_t *val) {
   int val2;
   int ret=getint(sfd, &val2);

   *val=val2;
   return (ret);
}

static int getreal(AFILE *sfd,double *val) {
   char tokbuf[100];
   int ch;
   char *pt=tokbuf, *end=tokbuf + 100 - 2, *nend;

   while (isspace(ch=nlgetc(sfd)));
   if (ch != 'e' && ch != 'E')	/* real's can't begin with exponants */
      while (isdigit(ch) || ch=='-' || ch=='+' || ch=='e' || ch=='E'
	     || ch=='.' || ch==',') {
	 if (pt < end)
	    *pt++=ch;
	 ch=nlgetc(sfd);
      }
   *pt='\0';
   aungetc(ch, sfd);
   *val=strtod(tokbuf, &nend);
   /* Beware of different locals! */
   if (*nend != '\0') {
      if (*nend=='.')
	 *nend=',';
      else if (*nend==',')
	 *nend='.';
      *val=strtod(tokbuf, &nend);
   }
   return (pt != tokbuf && *nend=='\0' ? 1 : ch==EOF ? -1 : 0);
}

/* Don't use nlgetc here. We carefully control newlines when dumping in 85 */
/*  but backslashes can occur at end of line. */
static int Dec85(struct enc85 *dec) {
   int ch1, ch2, ch3, ch4, ch5;
   unsigned int val;

   if (dec->pos < 0) {
      while (isspace(ch1=agetc(dec->sfd)));
      if (ch1=='z') {
	 dec->sofar[0]=dec->sofar[1]=dec->sofar[2]=dec->sofar[3]=0;
	 dec->pos=3;
      } else {
	 while (isspace(ch2=agetc(dec->sfd)));
	 while (isspace(ch3=agetc(dec->sfd)));
	 while (isspace(ch4=agetc(dec->sfd)));
	 while (isspace(ch5=agetc(dec->sfd)));
	 val =
	    ((((ch1 - '!') * 85 + ch2 - '!') * 85 + ch3 - '!') * 85 + ch4 -
	     '!') * 85 + ch5 - '!';
	 dec->sofar[3]=val >> 24;
	 dec->sofar[2]=val >> 16;
	 dec->sofar[1]=val >> 8;
	 dec->sofar[0]=val;
	 dec->pos=3;
      }
   }
   return (dec->sofar[dec->pos--]);
}

static void rle2image(struct enc85 *dec,int rlelen,struct _GImage *base) {
   uint8_t *pt, *end;
   int r, c, set, cnt, ch, ch2;
   int i;

   r=c=0;
   set=1;
   pt=base->data;
   end=pt + base->bytes_per_line * base->height;
   memset(base->data, 0xff, end - pt);
   while (rlelen > 0) {
      if (pt >= end) {
	 ErrorMsg(2,"RLE failure\n");
	 while (rlelen > 0) {
	    Dec85(dec);
	    --rlelen;
	 }
	 break;
      }
      ch=Dec85(dec);
      --rlelen;
      if (ch==255) {
	 ch2=Dec85(dec);
	 cnt=(ch2 << 8) + Dec85(dec);
	 rlelen -= 2;
      } else
	 cnt=ch;
      if (ch==255 && ch2==0 && cnt < 255) {
	 /* Line duplication */
	 for (i=0; i < cnt && pt < end; ++i) {
	    memcpy(pt, base->data + (r - 1) * base->bytes_per_line,
		   base->bytes_per_line);
	    ++r;
	    pt += base->bytes_per_line;
	 }
	 set=1;
      } else {
	 if (pt + ((c + cnt) >> 3) > end) {
	    ErrorMsg(2,"Run length encoded image has been corrupted.\n");
	    break;
	 }
	 if (!set) {
	    for (i=0; i < cnt; ++i)
	       pt[(c + i) >> 3] &= ((~0x80) >> ((c + i) & 7));
	 }
	 c += cnt;
	 set=1 - set;
	 if (c >= base->width) {
	    ++r;
	    pt += base->bytes_per_line;
	    c=0;
	    set=1;
	 }
      }
   }
}

static ImageList *SFDGetImage(AFILE *sfd) {
   /* We've read the image token */
   int width, height, image_type, bpl, clutlen, rlelen;
   uint32_t trans;

   struct _GImage *base;
   GImage *image;
   ImageList *img;
   struct enc85 dec;
   int i, ch;

   memset(&dec, '\0', sizeof(dec));
   dec.pos=-1;
   dec.sfd=sfd;

   getint(sfd, &width);
   getint(sfd, &height);
   getint(sfd, &image_type);
   getint(sfd, &bpl);
   getint(sfd, &clutlen);
   gethex(sfd, &trans);
   image=GImageCreate(image_type, width, height);
   base=image->list_len==0 ? image->u.image : image->u.images[0];
   img=calloc(1, sizeof(ImageList));
   img->image=image;
   getreal(sfd, &img->xoff);
   getreal(sfd, &img->yoff);
   getreal(sfd, &img->xscale);
   getreal(sfd, &img->yscale);
   while ((ch=nlgetc(sfd))==' ' || ch=='\t');
   aungetc(ch, sfd);
   rlelen=0;
   if (isdigit(ch))
      getint(sfd, &rlelen);
   base->trans=trans;
   if (clutlen != 0) {
      if (base->clut==NULL)
	 base->clut=calloc(1, sizeof(GClut));
      base->clut->clut_len=clutlen;
      base->clut->trans_index=trans;
      for (i=0; i < clutlen; ++i) {
	 int r, g, b;

	 r=Dec85(&dec);
	 g=Dec85(&dec);
	 b=Dec85(&dec);
	 base->clut->clut[i]=(r << 16) | (g << 8) | b;
      }
   }
   if (rlelen != 0) {
      rle2image(&dec, rlelen, base);
   } else {
      for (i=0; i < height; ++i) {
	 if (image_type==it_rgba) {
	    uint32_t *ipt=(uint32_t *) (base->data + i * base->bytes_per_line);
	    uint32_t *iend =
	       (uint32_t *) (base->data + (i + 1) * base->bytes_per_line);
	    int r, g, b, a;

	    while (ipt < iend) {
	       a=Dec85(&dec);
	       r=Dec85(&dec);
	       g=Dec85(&dec);
	       b=Dec85(&dec);
	       *ipt++=(a << 24) | (r << 16) | (g << 8) | b;
	    }
	 } else if (image_type==it_true) {
	    int *ipt=(int *) (base->data + i * base->bytes_per_line);
	    int *iend=(int *) (base->data + (i + 1) * base->bytes_per_line);
	    int r, g, b;

	    while (ipt < iend) {
	       r=Dec85(&dec);
	       g=Dec85(&dec);
	       b=Dec85(&dec);
	       *ipt++=(r << 16) | (g << 8) | b;
	    }
	 } else {
	    uint8_t *pt=(uint8_t *) (base->data + i * base->bytes_per_line);
	    uint8_t *end =
	       (uint8_t *) (base->data + (i + 1) * base->bytes_per_line);
	    while (pt < end) {
	       *pt++=Dec85(&dec);
	    }
	 }
      }
   }
   img->bb.minx=img->xoff;
   img->bb.maxy=img->yoff;
   img->bb.maxx=img->xoff + GImageGetWidth(img->image) * img->xscale;
   img->bb.miny=img->yoff - GImageGetHeight(img->image) * img->yscale;
   /* In old sfd files I failed to recognize bitmap pngs as bitmap, so put */
   /*  in a little check here that converts things which should be bitmap to */
   /*  bitmap *//* Eventually it can be removed as all old sfd files get */
   /*  converted. 22/10/2002 */
   if (base->image_type==it_index && base->clut != NULL
       && base->clut->clut_len==2)
      img->image=ImageAlterClut(img->image);
   return (img);
}

static void SFDGetType1(AFILE *sfd,SplineChar *sc) {
   /* We've read the OrigType1 token (this is now obselete, but parse it in case there are any old sfds) */
   int len;
   struct enc85 dec;

   memset(&dec, '\0', sizeof(dec));
   dec.pos=-1;
   dec.sfd=sfd;

   getint(sfd, &len);
   while (--len >= 0)
      Dec85(&dec);
}

static void SFDGetTtfInstrs(AFILE *sfd,SplineChar *sc) {
   /* We've read the TtfInstr token, it is followed by a byte count */
   /* and then the instructions in enc85 format */
   int i, len;
   struct enc85 dec;

   memset(&dec, '\0', sizeof(dec));
   dec.pos=-1;
   dec.sfd=sfd;

   getint(sfd, &len);
   sc->ttf_instrs=malloc(len);
   sc->ttf_instrs_len=len;
   for (i=0; i < len; ++i)
      sc->ttf_instrs[i]=Dec85(&dec);
}

static void tterr(void *rubbish,char *message,int pos) {
   ErrorMsg(2,"When loading tt instrs from sfd: %s\n", message);
}

static void SFDGetTtInstrs(AFILE *sfd,SplineChar *sc) {
   /* We've read the TtInstr token, it is followed by text versions of */
   /*  the instructions, slurp it all into a big buffer, and then parse that */
   char *buf=NULL, *pt=buf, *end=buf;
   int ch;
   int backlen=strlen(end_tt_instrs);
   int instr_len;

   while ((ch=nlgetc(sfd)) != EOF) {
      if (pt >= end) {
	 char *newbuf=realloc(buf, (end - buf + 200));

	 pt=newbuf + (pt - buf);
	 end=newbuf + (end + 200 - buf);
	 buf=newbuf;
      }
      *pt++=ch;
      if (pt - buf > backlen
	  && strncmp(pt - backlen, end_tt_instrs, backlen)==0) {
	 pt -= backlen;
	 break;
      }
   }
   *pt='\0';

   sc->ttf_instrs=_IVParse(sc->parent, buf, &instr_len, tterr, NULL);
   sc->ttf_instrs_len=instr_len;

   free(buf);
}

static struct ttf_table *SFDGetTtfTable(AFILE *sfd,SplineFont *sf,
					struct ttf_table *lasttab[2]) {
   /* We've read the TtfTable token, it is followed by a tag and a byte count */
   /* and then the instructions in enc85 format */
   int i, len;
   int which;
   struct enc85 dec;
   struct ttf_table *tab=chunkalloc(sizeof(struct ttf_table));

   memset(&dec, '\0', sizeof(dec));
   dec.pos=-1;
   dec.sfd=sfd;

   tab->tag=gettag(sfd);

   if (tab->tag==CHR('f', 'p', 'g', 'm')
       || tab->tag==CHR('p', 'r', 'e', 'p')
       || tab->tag==CHR('c', 'v', 't', ' ')
       || tab->tag==CHR('m', 'a', 'x', 'p'))
      which=0;
   else
      which=1;

   getint(sfd, &len);
   tab->data=malloc(len);
   tab->len=len;
   for (i=0; i < len; ++i)
      tab->data[i]=Dec85(&dec);

   if (lasttab[which] != NULL)
      lasttab[which]->next=tab;
   else if (which==0)
      sf->ttf_tables=tab;
   else
      sf->ttf_tab_saved=tab;
   lasttab[which]=tab;
   return (tab);
}

static struct ttf_table *SFDGetShortTable(AFILE *sfd,SplineFont *sf,
					  struct ttf_table *lasttab[2]) {
   /* We've read the ShortTable token, it is followed by a tag and a word count */
   /* and then the (text) values of the words that make up the cvt table */
   int i, len, ch;
   uint8_t *pt;
   int which, iscvt, started;
   struct ttf_table *tab=chunkalloc(sizeof(struct ttf_table));

   tab->tag=gettag(sfd);

   if (tab->tag==CHR('f', 'p', 'g', 'm')
       || tab->tag==CHR('p', 'r', 'e', 'p')
       || tab->tag==CHR('c', 'v', 't', ' ')
       || tab->tag==CHR('m', 'a', 'x', 'p'))
      which=0;
   else
      which=1;
   iscvt=tab->tag==CHR('c', 'v', 't', ' ');

   getint(sfd, &len);
   pt=tab->data=malloc(2 * len);
   tab->len=2 * len;
   started=false;
   for (i=0; i < len; ++i) {
      int num;

      getint(sfd, &num);
      *pt++=num >> 8;
      *pt++=num & 0xff;
      if (iscvt) {
	 ch=nlgetc(sfd);
	 if (ch==' ') {
	    if (!started) {
	       sf->cvt_names=calloc(len + 1, sizeof(char *));
	       sf->cvt_names[len]=END_CVT_NAMES;
	       started=true;
	    }
	    sf->cvt_names[i]=SFDReadUTF7Str(sfd);
	 } else
	    aungetc(ch, sfd);
      }
   }

   if (lasttab[which] != NULL)
      lasttab[which]->next=tab;
   else if (which==0)
      sf->ttf_tables=tab;
   else
      sf->ttf_tab_saved=tab;
   lasttab[which]=tab;
   return (tab);
}

static struct ttf_table *SFDGetTtTable(AFILE *sfd,SplineFont *sf,
				       struct ttf_table *lasttab[2]) {
   /* We've read the TtTable token, it is followed by a tag */
   /* and then the instructions in text format */
   int ch;
   int which;
   struct ttf_table *tab=chunkalloc(sizeof(struct ttf_table));
   char *buf=NULL, *pt=buf, *end=buf;
   int backlen=strlen(end_tt_instrs);

   tab->tag=gettag(sfd);

   if (tab->tag==CHR('f', 'p', 'g', 'm')
       || tab->tag==CHR('p', 'r', 'e', 'p')
       || tab->tag==CHR('c', 'v', 't', ' ')
       || tab->tag==CHR('m', 'a', 'x', 'p'))
      which=0;
   else
      which=1;

   while ((ch=nlgetc(sfd)) != EOF) {
      if (pt >= end) {
	 char *newbuf=realloc(buf, (end - buf + 200));

	 pt=newbuf + (pt - buf);
	 end=newbuf + (end + 200 - buf);
	 buf=newbuf;
      }
      *pt++=ch;
      if (pt - buf > backlen
	  && strncmp(pt - backlen, end_tt_instrs, backlen)==0) {
	 pt -= backlen;
	 break;
      }
   }
   *pt='\0';
   tab->data=_IVParse(sf, buf, &tab->len, tterr, NULL);
   free(buf);

   if (lasttab[which] != NULL)
      lasttab[which]->next=tab;
   else if (which==0)
      sf->ttf_tables=tab;
   else
      sf->ttf_tab_saved=tab;
   lasttab[which]=tab;
   return (tab);
}

static int SFDCloseCheck(SplinePointList *spl,int order2) {
   if (spl->first != spl->last &&
       RealNear(spl->first->me.x, spl->last->me.x) &&
       RealNear(spl->first->me.y, spl->last->me.y)) {
      SplinePoint *oldlast=spl->last;

      spl->first->prevcp=oldlast->prevcp;
      spl->first->noprevcp=false;
      oldlast->prev->from->next=NULL;
      spl->last=oldlast->prev->from;
      chunkfree(oldlast->prev, sizeof(*oldlast));
      chunkfree(oldlast->hintmask, sizeof(HintMask));
      chunkfree(oldlast, sizeof(*oldlast));
      SplineMake(spl->last, spl->first, order2);
      spl->last=spl->first;
      return (true);
   }
   return (false);
}

static void SFDGetHintMask(AFILE *sfd,HintMask *hintmask) {
   int nibble=0, ch;

   memset(hintmask, 0, sizeof(HintMask));
   while (1) {
      ch=nlgetc(sfd);
      if (isdigit(ch))
	 ch -= '0';
      else if (ch >= 'a' && ch <= 'f')
	 ch -= 'a' - 10;
      else if (ch >= 'A' && ch <= 'F')
	 ch -= 'A' - 10;
      else {
	 aungetc(ch, sfd);
	 break;
      }
      if (nibble < 2 * HntMax / 8)
	 (*hintmask)[nibble >> 1] |= ch << (4 * (1 - (nibble & 1)));
      ++nibble;
   }
}

static void SFDGetSpiros(AFILE *sfd,SplineSet *cur) {
   int ch;
   spiro_cp cp;

   ch=nlgetc(sfd);		/* S */
   ch=nlgetc(sfd);		/* p */
   ch=nlgetc(sfd);		/* i */
   ch=nlgetc(sfd);		/* r */
   ch=nlgetc(sfd);		/* o */
   while (afscanf(sfd, "%lg %lg %c", &cp.x, &cp.y, &cp.ty)==3) {
      if (cur != NULL) {
	 if (cur->spiro_cnt >= cur->spiro_max)
	    cur->spiros =
	       realloc(cur->spiros,
		       (cur->spiro_max += 10) * sizeof(spiro_cp));
	 cur->spiros[cur->spiro_cnt++]=cp;
      }
   }
   if (cur != NULL
       && (cur->spiros[cur->spiro_cnt - 1].ty & 0x7f) != SPIRO_END) {
      if (cur->spiro_cnt >= cur->spiro_max)
	 cur->spiros =
	    realloc(cur->spiros, (cur->spiro_max += 1) * sizeof(spiro_cp));
      memset(&cur->spiros[cur->spiro_cnt], 0, sizeof(spiro_cp));
      cur->spiros[cur->spiro_cnt++].ty=SPIRO_END;
   }
   ch=nlgetc(sfd);
   if (ch=='E') {
      ch=nlgetc(sfd);		/* n */
      ch=nlgetc(sfd);		/* d */
      ch=nlgetc(sfd);		/* S */
      ch=nlgetc(sfd);		/* p */
      ch=nlgetc(sfd);		/* i */
      ch=nlgetc(sfd);		/* r */
      ch=nlgetc(sfd);		/* o */
   } else
      aungetc(ch, sfd);
}

static SplineSet *SFDGetSplineSet(SplineFont *sf,AFILE *sfd,int order2) {
   SplinePointList *cur=NULL, *head=NULL;
   BasePoint current;
   double stack[100];
   int sp=0;
   SplinePoint *pt=NULL;
   int ch;
   int ch2;
   char tok[100];
   int ttfindex=0;
   int lastacceptable;

   current.x=current.y=0;
   lastacceptable=0;

   while (1) {
      int have_read_val=0;
      int val=0;

      while (getreal(sfd, &stack[sp])==1)
	if (sp < 99)
	  ++sp;

      while (isspace(ch=nlgetc(sfd)));

      if (ch=='E' || ch=='e' || ch==EOF)
	break;

      if (ch=='S') {
	 aungetc(ch, sfd);
	 SFDGetSpiros(sfd, cur);
	 continue;

      } else if ((ch=='N') && nlgetc(sfd)=='a' &&	/* a */
		 nlgetc(sfd)=='m' &&	/* m */
		 nlgetc(sfd)=='e' &&	/* e */
		 nlgetc(sfd)=='d') {	/* d */

	 ch2=nlgetc(sfd);	/* : */

	 // We are either fetching a splineset name (Named:) or a point name (NamedP:).
	 if (ch2=='P') {
	    if ((nlgetc(sfd)==':') && (pt != NULL)) {
	       if (pt->name != NULL) {
		  free(pt->name);
	       }
	       pt->name=SFDReadUTF7Str(sfd);
	    }

	 } else if (ch2==':')
	      cur->contour_name=SFDReadUTF7Str(sfd);

	 continue;

      } else if (ch=='P') {
	 int flags;

	 nlgetc(sfd);		/* a */
	 nlgetc(sfd);		/* t */
	 nlgetc(sfd);		/* h */
	 nlgetc(sfd);		/* F */
	 nlgetc(sfd);		/* l */
	 nlgetc(sfd);		/* a */
	 nlgetc(sfd);		/* g */
	 nlgetc(sfd);		/* s */
	 nlgetc(sfd);		/* : */
	 getint(sfd, &flags);
	 cur->is_clip_path=flags & 1;
      }

      pt=NULL;
      if (ch=='l' || ch=='m') {
	 if (sp >= 2) {
	    current.x=stack[sp - 2];
	    current.y=stack[sp - 1];
	    sp -= 2;
	    pt=chunkalloc(sizeof(SplinePoint));
	    pt->me=current;
	    pt->noprevcp=true;
	    pt->nonextcp=true;

	    if (ch=='m') {
	       SplinePointList *spl=chunkalloc(sizeof(SplinePointList));

	       spl->first=spl->last=pt;
	       if (cur != NULL) {
		  if (SFDCloseCheck(cur, order2))
		    --ttfindex;
		  cur->next=spl;
	       } else
		 head=spl;
	       cur=spl;

	    } else {
	       if (cur != NULL && cur->first != NULL
		   && (cur->first != cur->last || cur->first->next==NULL)) {
		  if (cur->last->nextcpindex==0xfffe)
		    cur->last->nextcpindex=0xffff;
		  SplineMake(cur->last, pt, order2);
		  cur->last=pt;
	       }
	    }

	 } else
	    sp=0;

      } else if (ch=='c') {
	 if (sp >= 6) {
	    getint(sfd, &val);
	    have_read_val=1;

	    current.x=stack[sp - 2];
	    current.y=stack[sp - 1];
	    double original_current_x=current.x;

	    if (val & SFD_PTFLAG_FORCE_OPEN_PATH) {
	       // Find somewhere vacant to put the point.x for now
	       // we need to do this check in case we choose a point that is already
	       // on the spline and this connect back to that point instead of creating
	       // an open path
	       while (1) {
		  double offset=0.1;

		  current.x += offset;
		  if (!SplinePointListContainsPointAtX(cur, current.x)) {
		     break;
		  }
	       }
	    }

	    if (cur != NULL && cur->first != NULL
		&& (cur->first != cur->last || cur->first->next==NULL)) {

	       cur->last->nextcp.x=stack[sp - 6];
	       cur->last->nextcp.y=stack[sp - 5];
	       cur->last->nonextcp=false;

	       pt=chunkalloc(sizeof(SplinePoint));
	       pt->prevcp.x=stack[sp - 4];
	       pt->prevcp.y=stack[sp - 3];
	       pt->me=current;
	       pt->nonextcp=true;

	       if (cur->last->nextcpindex==0xfffe)
		 cur->last->nextcpindex=ttfindex++;
	       else if (cur->last->nextcpindex != 0xffff)
		 ttfindex=cur->last->nextcpindex + 1;

	       SplineMake(cur->last, pt, order2);
	       cur->last=pt;

	       /* pt->me is a copy of 'current' so we should now move
		* the x coord of pt->me back to where it should be.
		* The whole aim here is that this spline remains an open path
		* when PTFLAG_FORCE_OPEN_PATH is set. */
	       pt->me.x=original_current_x;
	    }

	    // Move the point back to the same location it was
	    // but do not connect it back to the point that is
	    // already there.
	    if (val & SFD_PTFLAG_FORCE_OPEN_PATH)
	       current.x=original_current_x;

	    sp -= 6;

	 } else
	    sp=0;
      }

      if (pt != NULL) {
	 if (!have_read_val)
	    getint(sfd, &val);

	 pt->pointtype=(val & SFD_PTFLAG_TYPE_MASK);
	 pt->selected=(val & SFD_PTFLAG_IS_SELECTED) > 0;
	 pt->nextcpdef=(val & SFD_PTFLAG_NEXTCP_IS_DEFAULT) > 0;
	 pt->prevcpdef=(val & SFD_PTFLAG_PREVCP_IS_DEFAULT) > 0;
	 pt->roundx=(val & SFD_PTFLAG_ROUND_IN_X) > 0;
	 pt->roundy=(val & SFD_PTFLAG_ROUND_IN_Y) > 0;
	 pt->dontinterpolate=(val & SFD_PTFLAG_INTERPOLATE_NEVER) > 0;

	 if (pt->prev != NULL)
	   pt->prev->acceptableextrema =
	   (val & SFD_PTFLAG_PREV_EXTREMA_MARKED_ACCEPTABLE) > 0;
	 else
	   lastacceptable =
	   (val & SFD_PTFLAG_PREV_EXTREMA_MARKED_ACCEPTABLE) > 0;
	 if (val & 0x80)
	   pt->ttfindex=0xffff;
	 else
	   pt->ttfindex=ttfindex++;
	 pt->nextcpindex=0xfffe;
	 ch=nlgetc(sfd);
	 if (ch=='x') {
	    pt->hintmask=chunkalloc(sizeof(HintMask));
	    SFDGetHintMask(sfd, pt->hintmask);
	 } else if (ch != ',')
	      aungetc(ch, sfd);
	 else {
	    ch=nlgetc(sfd);
	    if (ch==',')
	      pt->ttfindex=0xfffe;
	    else {
	       aungetc(ch, sfd);
	       getint(sfd, &val);
	       pt->ttfindex=val;
	       nlgetc(sfd);	/* skip comma */
	       if (val != -1)
		 ttfindex=val + 1;
	    }
	    ch=nlgetc(sfd);
	    if (ch=='\r' || ch=='\n')
	      aungetc(ch, sfd);
	    else {
	       aungetc(ch, sfd);
	       getint(sfd, &val);
	       pt->nextcpindex=val;
	       if (val != -1)
		 ttfindex=val + 1;
	    }
	 }
      }
   }

   if (cur != NULL)
     SFDCloseCheck(cur, order2);

   if (lastacceptable && cur->last->prev != NULL)
      cur->last->prev->acceptableextrema=true;

   getname(sfd, tok);

   return (head);
}

static void SFDGetMinimumDistances(AFILE *sfd,SplineChar *sc) {
   SplineSet *ss;
   SplinePoint *sp;
   int pt, i, val, err;
   int ch;
   SplinePoint **mapping=NULL;
   MinimumDistance *last, *md, *mdhead=NULL;

   for (i=0; i < 2; ++i) {
      pt=0;
      for (ss=sc->layers[ly_fore].splines; ss != NULL; ss=ss->next) {
	 for (sp=ss->first;;) {
	    if (mapping != NULL)
	       mapping[pt]=sp;
	    pt++;
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (sp==ss->first)
	       break;
	 }
      }
      if (mapping==NULL)
	 mapping=calloc(pt, sizeof(SplinePoint *));
   }

   last=NULL;
   for (ch=nlgetc(sfd); ch != EOF && ch != '\n'; ch=nlgetc(sfd)) {
      err=false;
      while (isspace(ch) && ch != '\n')
	 ch=nlgetc(sfd);
      if (ch=='\n')
	 break;
      md=chunkalloc(sizeof(MinimumDistance));
      if (ch=='x')
	 md->x=true;
      getint(sfd, &val);
      if (val < -1 || val >= pt) {
	 ErrorMsg(2,"Minimum Distance specifies bad point (%d) in sfd file\n",
		val);
	 err=true;
      } else if (val != -1) {
	 md->sp1=mapping[val];
	 md->sp1->dontinterpolate=true;
      }
      ch=nlgetc(sfd);
      if (ch != ',') {
	 ErrorMsg(2,"Minimum Distance lacks a comma where expected\n");
	 err=true;
      }
      getint(sfd, &val);
      if (val < -1 || val >= pt) {
	 ErrorMsg(2,"Minimum Distance specifies bad point (%d) in sfd file\n",
		val);
	 err=true;
      } else if (val != -1) {
	 md->sp2=mapping[val];
	 md->sp2->dontinterpolate=true;
      }
      if (!err) {
	 if (last==NULL)
	    mdhead=md;
	 else
	    last->next=md;
	 last=md;
      } else
	 chunkfree(md, sizeof(MinimumDistance));
   }
   free(mapping);

   /* Obsolete concept */
   MinimumDistancesFree(mdhead);
}

static HintInstance *SFDReadHintInstances(AFILE *sfd,StemInfo *stem) {
   HintInstance *head=NULL, *last=NULL, *cur;
   double begin, end;
   int ch;

   while ((ch=nlgetc(sfd))==' ' || ch=='\t');
   if (ch=='G' && stem != NULL) {
      stem->ghost=true;
      while ((ch=nlgetc(sfd))==' ' || ch=='\t');
   }
   if (ch != '<') {
      aungetc(ch, sfd);
      return (NULL);
   }
   while (getreal(sfd, &begin)==1 && getreal(sfd, &end)) {
      cur=chunkalloc(sizeof(HintInstance));
      cur->begin=begin;
      cur->end=end;
      if (head==NULL)
	 head=cur;
      else
	 last->next=cur;
      last=cur;
   }
   while ((ch=nlgetc(sfd))==' ' || ch=='\t');
   if (ch != '>')
      aungetc(ch, sfd);
   return (head);
}

static StemInfo *SFDReadHints(AFILE *sfd) {
   StemInfo *head=NULL, *last=NULL, *cur;
   double start, width;

   while (getreal(sfd, &start)==1 && getreal(sfd, &width)) {
      cur=chunkalloc(sizeof(StemInfo));
      cur->start=start;
      cur->width=width;
      cur->where=SFDReadHintInstances(sfd, cur);
      if (head==NULL)
	 head=cur;
      else
	 last->next=cur;
      last=cur;
   }
   return (head);
}

static DStemInfo *SFDReadDHints(SplineFont *sf,AFILE *sfd,int old) {
   DStemInfo *head=NULL, *last=NULL, *cur;
   int i;
   BasePoint bp[4], *bpref[4], left, right, unit;
   double rstartoff, rendoff, lendoff;

   if (old) {
      for (i=0; i < 4; i++)
	 bpref[i]=&bp[i];

      while (getreal(sfd, &bp[0].x) && getreal(sfd, &bp[0].y) &&
	     getreal(sfd, &bp[1].x) && getreal(sfd, &bp[1].y) &&
	     getreal(sfd, &bp[2].x) && getreal(sfd, &bp[2].y) &&
	     getreal(sfd, &bp[3].x) && getreal(sfd, &bp[3].y)) {

	 /* Ensure point coordinates specified in the sfd file do */
	 /* form a diagonal line */
	 if (PointsDiagonalable(sf, bpref, &unit)) {
	    cur=chunkalloc(sizeof(DStemInfo));
	    cur->left=*bpref[0];
	    cur->right=*bpref[1];
	    cur->unit=unit;
	    /* Generate a temporary hint instance, so that the hint can */
	    /* be visible in charview even if subsequent rebuilding instances */
	    /* fails (e. g. for composite characters) */
	    cur->where=chunkalloc(sizeof(HintInstance));
	    rstartoff=(cur->right.x - cur->left.x) * cur->unit.x +
	       (cur->right.y - cur->left.y) * cur->unit.y;
	    rendoff=(bpref[2]->x - cur->left.x) * cur->unit.x +
	       (bpref[2]->y - cur->left.y) * cur->unit.y;
	    lendoff=(bpref[3]->x - cur->left.x) * cur->unit.x +
	       (bpref[3]->y - cur->left.y) * cur->unit.y;
	    cur->where->begin=(rstartoff > 0) ? rstartoff : 0;
	    cur->where->end=(rendoff > lendoff) ? lendoff : rendoff;
	    MergeDStemInfo(sf, &head, cur);
	 }
      }
   } else {
      while (getreal(sfd, &left.x) && getreal(sfd, &left.y) &&
	     getreal(sfd, &right.x) && getreal(sfd, &right.y) &&
	     getreal(sfd, &unit.x) && getreal(sfd, &unit.y)) {
	 cur=chunkalloc(sizeof(DStemInfo));
	 cur->left=left;
	 cur->right=right;
	 cur->unit=unit;
	 cur->where=SFDReadHintInstances(sfd, NULL);
	 if (head==NULL)
	    head=cur;
	 else
	    last->next=cur;
	 last=cur;
      }
   }
   return (head);
}

static DeviceTable *SFDReadDeviceTable(AFILE *sfd,DeviceTable *adjust) {
   int i, junk, first, last, ch, len;

   while ((ch=nlgetc(sfd))==' ');
   if (ch=='{') {
      while ((ch=nlgetc(sfd))==' ');
      if (ch=='}')
	 return (NULL);
      else
	 aungetc(ch, sfd);
      if (adjust==NULL)
	 adjust=chunkalloc(sizeof(DeviceTable));
      getint(sfd, &first);
      ch=nlgetc(sfd);		/* Should be '-' */
      getint(sfd, &last);
      len=last - first + 1;
      if (len <= 0) {
	 ErrorMsg(2,"Bad device table, invalid length.\n");
	 return (NULL);
      }
      adjust->first_pixel_size=first;
      adjust->last_pixel_size=last;
      adjust->corrections=malloc(len);
      for (i=0; i < len; ++i) {
	 while ((ch=nlgetc(sfd))==' ');
	 if (ch != ',')
	    aungetc(ch, sfd);
	 getint(sfd, &junk);
	 adjust->corrections[i]=junk;
      }
      while ((ch=nlgetc(sfd))==' ');
      if (ch != '}')
	 aungetc(ch, sfd);
   } else
      aungetc(ch, sfd);
   return (adjust);
}

static ValDevTab *SFDReadValDevTab(AFILE *sfd) {
   int i, j, ch;
   ValDevTab vdt;
   char buf[4];

   memset(&vdt, 0, sizeof(vdt));
   buf[3]='\0';
   while ((ch=nlgetc(sfd))==' ');
   if (ch=='[') {
      for (i=0; i < 4; ++i) {
	 while ((ch=nlgetc(sfd))==' ');
	 if (ch==']')
	    break;
	 buf[0]=ch;
	 for (j=1; j < 3; ++j)
	    buf[j]=nlgetc(sfd);
	 while ((ch=nlgetc(sfd))==' ');
	 if (ch != '=')
	    aungetc(ch, sfd);
	 SFDReadDeviceTable(sfd,
			    strcmp(buf, "ddx")==0 ? &vdt.xadjust :
			    strcmp(buf, "ddy")==0 ? &vdt.yadjust :
			    strcmp(buf, "ddh")==0 ? &vdt.xadv :
			    strcmp(buf, "ddv")==0 ? &vdt.yadv :
			    (&vdt.xadjust) + i);
	 while ((ch=nlgetc(sfd))==' ');
	 if (ch != ']')
	    aungetc(ch, sfd);
	 else
	    break;
      }
      if (vdt.xadjust.corrections != NULL || vdt.yadjust.corrections != NULL
	  || vdt.xadv.corrections != NULL || vdt.yadv.corrections != NULL) {
	 ValDevTab *v=chunkalloc(sizeof(ValDevTab));

	 *v=vdt;
	 return (v);
      }
   } else
      aungetc(ch, sfd);
   return (NULL);
}

static AnchorPoint *SFDReadAnchorPoints(AFILE *sfd,SplineChar *sc,
					AnchorPoint ** alist,
					AnchorPoint * lastap) {
   AnchorPoint *ap=chunkalloc(sizeof(AnchorPoint));
   AnchorClass *an;
   char *name;
   char tok[200];
   int ch;

   name=SFDReadUTF7Str(sfd);
   if (name==NULL) {
      ErrorMsg(2,"Anchor Point with no class name: %s\n", sc->name);
      return (lastap);
   }
   for (an=sc->parent->anchor; an != NULL && strcmp(an->name, name) != 0;
	an=an->next);
   free(name);
   ap->anchor=an;
   getreal(sfd, &ap->me.x);
   getreal(sfd, &ap->me.y);
   ap->type=-1;
   if (getname(sfd, tok)==1) {
      if (strcmp(tok, "mark")==0)
	 ap->type=at_mark;
      else if (strcmp(tok, "basechar")==0)
	 ap->type=at_basechar;
      else if (strcmp(tok, "baselig")==0)
	 ap->type=at_baselig;
      else if (strcmp(tok, "basemark")==0)
	 ap->type=at_basemark;
      else if (strcmp(tok, "entry")==0)
	 ap->type=at_centry;
      else if (strcmp(tok, "exit")==0)
	 ap->type=at_cexit;
   }
   getsint(sfd, &ap->lig_index);
   ch=nlgetc(sfd);
   aungetc(ch, sfd);
   if (ch==' ') {
      SFDReadDeviceTable(sfd, &ap->xadjust);
      SFDReadDeviceTable(sfd, &ap->yadjust);
      ch=nlgetc(sfd);
      aungetc(ch, sfd);
      if (isdigit(ch)) {
	 getsint(sfd, (int16_t *) & ap->ttf_pt_index);
	 ap->has_ttf_pt=true;
      }
   }
   if (ap->anchor==NULL || ap->type==-1) {
      ErrorMsg(2,"Bad Anchor Point: %s\n", sc->name);
      AnchorPointsFree(ap);
      return (lastap);
   }
   if (lastap==NULL)
      (*alist)=ap;
   else
      lastap->next=ap;

   return (ap);
}

static RefChar *SFDGetRef(AFILE *sfd,int was_enc) {
   RefChar *rf;
   int temp=0, ch;

   rf=RefCharCreate();
   getint(sfd, &rf->orig_pos);
   rf->encoded=was_enc;
   if (getint(sfd, &temp))
      rf->unicode_enc=temp;
   while (isspace(ch=nlgetc(sfd)));
   if (ch=='S')
      rf->selected=true;
   getreal(sfd, &rf->transform[0]);
   getreal(sfd, &rf->transform[1]);
   getreal(sfd, &rf->transform[2]);
   getreal(sfd, &rf->transform[3]);
   getreal(sfd, &rf->transform[4]);
   getreal(sfd, &rf->transform[5]);
   while ((ch=nlgetc(sfd))==' ');
   aungetc(ch, sfd);
   if (isdigit(ch)) {
      getint(sfd, &temp);
      rf->use_my_metrics=temp & 1;
      rf->round_translation_to_grid=(temp & 2) ? 1 : 0;
      rf->point_match=(temp & 4) ? 1 : 0;
      if (rf->point_match) {
	 getsint(sfd, (int16_t *) & rf->match_pt_base);
	 getsint(sfd, (int16_t *) & rf->match_pt_ref);
	 while ((ch=nlgetc(sfd))==' ');
	 if (ch=='O')
	    rf->point_match_out_of_date=true;
	 else
	    aungetc(ch, sfd);
      }
   }
   return (rf);
}

/* I used to create multiple ligatures by putting ";" between them */
/* that is the component string for "ffi" was "ff i ; f f i" */
/* Now I want to have separate ligature structures for each */
static PST1 *LigaCreateFromOldStyleMultiple(PST1 *liga) {
   char *pt;
   PST1 *new, *last=liga;

   while ((pt=strrchr(liga->pst.u.lig.components, ';')) != NULL) {
      new=chunkalloc(sizeof(PST1));
      *new=*liga;
      new->pst.u.lig.components=fastrdup(pt + 1);
      last->pst.next=(PST *) new;
      last=new;
      *pt='\0';
   }
   return (last);
}

static void SFDSetEncMap(SplineFont *sf,int orig_pos,int enc) {
   EncMap *map=sf->map;

   if (map==NULL)
      return;

   if (orig_pos >= map->backmax) {
      int old=map->backmax;

      map->backmax=orig_pos + 10;
      map->backmap=realloc(map->backmap, map->backmax * sizeof(int));
      memset(map->backmap + old, -1, (map->backmax - old) * sizeof(int));
   }
   if (map->backmap[orig_pos]==-1)	/* backmap will not be unique if multiple encodings come from same glyph */
      map->backmap[orig_pos]=enc;
   if (enc >= map->encmax) {
      int old=map->encmax;

      map->encmax=enc + 10;
      map->map=realloc(map->map, map->encmax * sizeof(int));
      memset(map->map + old, -1, (map->encmax - old) * sizeof(int));
   }
   if (enc >= map->enccount)
      map->enccount=enc + 1;
   if (enc != -1)
      map->map[enc]=orig_pos;
}

static void SCDefaultInterpolation(SplineChar *sc) {
   SplineSet *cur;
   SplinePoint *sp;

   /* We used not to store the dontinterpolate bit. We used to use the */
   /* presence or absence of instructions as that flag */

   if (sc->ttf_instrs_len != 0) {
      for (cur=sc->layers[ly_fore].splines; cur != NULL; cur=cur->next) {
	 for (sp=cur->first;;) {
	    if (sp->ttfindex != 0xffff && SPInterpolate(sp))
	       sp->dontinterpolate=true;
	    if (sp->next==NULL)
	       break;
	    sp=sp->next->to;
	    if (sp==cur->first)
	       break;
	 }
      }
   }
}

static void SFDParseMathValueRecord(AFILE *sfd,int16_t *value,
				    DeviceTable ** devtab) {
   getsint(sfd, value);
   *devtab=SFDReadDeviceTable(sfd, NULL);
}

static struct glyphvariants *SFDParseGlyphComposition(AFILE *sfd,
						      struct glyphvariants
						      *gv, char *tok) {
   int i;

   if (gv==NULL)
      gv=chunkalloc(sizeof(struct glyphvariants));
   getint(sfd, &gv->part_cnt);
   gv->parts=calloc(gv->part_cnt, sizeof(struct gv_part));
   for (i=0; i < gv->part_cnt; ++i) {
      int temp, ch;

      getname(sfd, tok);
      gv->parts[i].component=fastrdup(tok);
      while ((ch=nlgetc(sfd))==' ');
      if (ch != '%')
	 aungetc(ch, sfd);
      getint(sfd, &temp);
      gv->parts[i].is_extender=temp;
      while ((ch=nlgetc(sfd))==' ');
      if (ch != ',')
	 aungetc(ch, sfd);
      getint(sfd, &temp);
      gv->parts[i].startConnectorLength=temp;
      while ((ch=nlgetc(sfd))==' ');
      if (ch != ',')
	 aungetc(ch, sfd);
      getint(sfd, &temp);
      gv->parts[i].endConnectorLength=temp;
      while ((ch=nlgetc(sfd))==' ');
      if (ch != ',')
	 aungetc(ch, sfd);
      getint(sfd, &temp);
      gv->parts[i].fullAdvance=temp;
   }
   return (gv);
}

static void SFDParseVertexKern(AFILE *sfd,struct mathkernvertex *vertex) {
   int i, ch;

   getint(sfd, &vertex->cnt);
   vertex->mkd=calloc(vertex->cnt, sizeof(struct mathkerndata));
   for (i=0; i < vertex->cnt; ++i) {
      SFDParseMathValueRecord(sfd, &vertex->mkd[i].height,
			      &vertex->mkd[i].height_adjusts);
      while ((ch=nlgetc(sfd))==' ');
      if (ch != EOF && ch != ',')
	 aungetc(ch, sfd);
      SFDParseMathValueRecord(sfd, &vertex->mkd[i].kern,
			      &vertex->mkd[i].kern_adjusts);
   }
}

static struct gradient *SFDParseGradient(AFILE *sfd,char *tok) {
   struct gradient *grad=chunkalloc(sizeof(struct gradient));
   int ch, i;

   getreal(sfd, &grad->start.x);
   while (isspace(ch=nlgetc(sfd)));
   if (ch != ';')
      aungetc(ch, sfd);
   getreal(sfd, &grad->start.y);

   getreal(sfd, &grad->stop.x);
   while (isspace(ch=nlgetc(sfd)));
   if (ch != ';')
      aungetc(ch, sfd);
   getreal(sfd, &grad->stop.y);

   getreal(sfd, &grad->radius);

   getname(sfd, tok);
   for (i=0; spreads[i] != NULL; ++i)
      if (strmatch(spreads[i], tok)==0)
	 break;
   if (spreads[i]==NULL)
      i=0;
   grad->sm=i;

   getint(sfd, &grad->stop_cnt);
   grad->grad_stops=calloc(grad->stop_cnt, sizeof(struct grad_stops));
   for (i=0; i < grad->stop_cnt; ++i) {
      while (isspace(ch=nlgetc(sfd)));
      if (ch != '{')
	 aungetc(ch, sfd);
      getreal(sfd, &grad->grad_stops[i].offset);
      gethex(sfd, &grad->grad_stops[i].col);
      getreal(sfd, &grad->grad_stops[i].opacity);
      while (isspace(ch=nlgetc(sfd)));
      if (ch != '}')
	 aungetc(ch, sfd);
   }
   return (grad);
}

static struct pattern *SFDParsePattern(AFILE *sfd,char *tok) {
   struct pattern *pat=chunkalloc(sizeof(struct pattern));
   int ch;

   getname(sfd, tok);
   pat->pattern=fastrdup(tok);

   getreal(sfd, &pat->width);
   while (isspace(ch=nlgetc(sfd)));
   if (ch != ';')
      aungetc(ch, sfd);
   getreal(sfd, &pat->height);

   while (isspace(ch=nlgetc(sfd)));
   if (ch != '[')
      aungetc(ch, sfd);
   getreal(sfd, &pat->transform[0]);
   getreal(sfd, &pat->transform[1]);
   getreal(sfd, &pat->transform[2]);
   getreal(sfd, &pat->transform[3]);
   getreal(sfd, &pat->transform[4]);
   getreal(sfd, &pat->transform[5]);
   while (isspace(ch=nlgetc(sfd)));
   if (ch != ']')
      aungetc(ch, sfd);
   return (pat);
}


static void SFDConsumeUntil(AFILE *sfd,char **terminators) {
   char *line=0;

   while ((line=getquotedeol(sfd))) {
      char **tp=terminators;

      for (; tp && *tp; ++tp) {
	 if (!strnmatch(line, *tp, strlen(*tp))) {
	    return;
	 }
      }
   }
}

static int orig_pos;

static SplineChar *SFDGetChar(AFILE *sfd,SplineFont *sf,
			      int had_sf_layer_cnt) {
   SplineChar *sc;
   char tok[2000], ch;
   RefChar *lastr=NULL, *ref;
   ImageList *lasti=NULL, *img;
   AnchorPoint *lastap=NULL;
   int isliga, ispos, issubs, ismult, islcar, ispair, temp, i;
   PST *last=NULL;
   uint32_t script=0;
   int current_layer=ly_fore;
   int multilayer=sf->multilayer;
   int had_old_dstems=false;
   SplineFont *sli_sf=sf->cidmaster ? sf->cidmaster : sf;
   struct altuni *altuni;
   int oldback=false;

   if (getname(sfd, tok) != 1)
      return (NULL);
   if (strcmp(tok, "StartChar:") != 0)
      return (NULL);
   while (isspace(ch=nlgetc(sfd)));
   aungetc(ch, sfd);
   sc=SFSplineCharCreate(sf);
   if (ch != '"') {
      if (getname(sfd, tok) != 1) {
	 SplineCharFree(sc);
	 return (NULL);
      }
      sc->name=fastrdup(tok);
   } else {
      sc->name=SFDReadUTF7Str(sfd);
      if (sc->name==NULL) {
	 SplineCharFree(sc);
	 return (NULL);
      }
   }
   sc->vwidth=sf->ascent + sf->descent;
   sc->parent=sf;
   while (1) {
      if (getname(sfd, tok) != 1) {
	 SplineCharFree(sc);
	 return (NULL);
      }
      if (strmatch(tok, "Encoding:")==0) {
	 int enc;

	 getint(sfd, &enc);
	 getint(sfd, &sc->unicodeenc);
	 while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	 aungetc(ch, sfd);
	 if (ch != '\n' && ch != '\r') {
	    getint(sfd, &sc->orig_pos);
	    if (sc->orig_pos==65535)
	       sc->orig_pos=orig_pos++;
	    /* An old mark meaning: "I don't know" */
	    if (sc->orig_pos < sf->glyphcnt
		&& sf->glyphs[sc->orig_pos] != NULL)
	       sc->orig_pos=sf->glyphcnt;
	    if (sc->orig_pos >= sf->glyphcnt) {
	       if (sc->orig_pos >= sf->glyphmax)
		  sf->glyphs =
		     realloc(sf->glyphs,
			     (sf->glyphmax =
			      sc->orig_pos + 10) * sizeof(SplineChar *));
	       memset(sf->glyphs + sf->glyphcnt, 0,
		      (sc->orig_pos + 1 -
		       sf->glyphcnt) * sizeof(SplineChar *));
	       sf->glyphcnt=sc->orig_pos + 1;
	    }
	    if (sc->orig_pos + 1 > orig_pos)
	       orig_pos=sc->orig_pos + 1;
	 } else if (sf->cidmaster != NULL) {	/* In cid fonts the orig_pos is just the cid */
	    sc->orig_pos=enc;
	 } else {
	    sc->orig_pos=orig_pos++;
	 }
	 SFDSetEncMap(sf, sc->orig_pos, enc);
      } else if (strmatch(tok, "AltUni:")==0) {
	 int uni;

	 while (getint(sfd, &uni)==1) {
	    altuni=chunkalloc(sizeof(struct altuni));
	    altuni->unienc=uni;
	    altuni->vs=-1;
	    altuni->fid=0;
	    altuni->next=sc->altuni;
	    sc->altuni=altuni;
	 }
      } else if (strmatch(tok, "AltUni2:")==0) {
	 uint32_t uni[3];

	 while (gethexints(sfd, uni, 3)) {
	    altuni=chunkalloc(sizeof(struct altuni));
	    altuni->unienc=uni[0];
	    altuni->vs=uni[1];
	    altuni->fid=uni[2];
	    altuni->next=sc->altuni;
	    sc->altuni=altuni;
	 }
      } else if (strmatch(tok, "OldEncoding:")==0) {
	 int old_enc;		/* Obsolete info */

	 getint(sfd, &old_enc);
      } else if (strmatch(tok, "Script:")==0) {
	 /* Obsolete. But still used for parsing obsolete ligature/subs tags */
	 while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	 if (ch=='\n' || ch=='\r')
	    script=0;
	 else {
	    aungetc(ch, sfd);
	    script=gettag(sfd);
	 }
      } else if (strmatch(tok, "Width:")==0) {
	 getsint(sfd, &sc->width);
      } else if (strmatch(tok, "VWidth:")==0) {
	 getsint(sfd, &sc->vwidth);
      } else if (strmatch(tok, "GlyphClass:")==0) {
	 getint(sfd, &temp);
	 sc->glyph_class=temp;
      } else if (strmatch(tok, "UnlinkRmOvrlpSave:")==0) {
	 getint(sfd, &temp);
	 sc->unlink_rm_ovrlp_save_undo=temp;
      } else if (strmatch(tok, "InSpiro:")==0) {
	 getint(sfd, &temp);
	 sc->inspiro=temp;
      } else if (strmatch(tok, "LigCaretCntFixed:")==0) {
	 getint(sfd, &temp);
	 sc->lig_caret_cnt_fixed=temp;
      } else if (strmatch(tok, "Flags:")==0) {
	 while (isspace(ch=nlgetc(sfd)) && ch != '\n' && ch != '\r');
	 while (ch != '\n' && ch != '\r') {
	    if (ch=='H')
	       sc->changedsincelasthinted=true;
	    else if (ch=='M')
	       sc->manualhints=true;
	    else if (ch=='W')
	       sc->widthset=true;
	    else if (ch=='O')
	       sc->wasopen=true;
	    else if (ch=='I')
	       sc->instructions_out_of_date=true;
	    ch=nlgetc(sfd);
	 }
	 if (sf->multilayer || sf->onlybitmaps || sf->strokedfont
	     || sc->layers[ly_fore].order2)
	    sc->changedsincelasthinted=false;
      } else if (strmatch(tok, "TeX:")==0) {
	 getsint(sfd, &sc->tex_height);
	 getsint(sfd, &sc->tex_depth);
	 while (isspace(ch=nlgetc(sfd)) && ch != '\n' && ch != '\r');
	 aungetc(ch, sfd);
	 if (ch != '\n' && ch != '\r') {
	    int16_t old_tex;

	    /* Used to store two extra values here */
	    getsint(sfd, &old_tex);
	    getsint(sfd, &old_tex);
	    if (sc->tex_height==0 && sc->tex_depth==0)	/* Fixup old bug */
	       sc->tex_height=sc->tex_depth=TEX_UNDEF;
	 }
      } else if (strmatch(tok, "ItalicCorrection:")==0) {
	 SFDParseMathValueRecord(sfd, &sc->italic_correction,
				 &sc->italic_adjusts);
      } else if (strmatch(tok, "TopAccentHorizontal:")==0) {
	 SFDParseMathValueRecord(sfd, &sc->top_accent_horiz,
				 &sc->top_accent_adjusts);
      } else if (strmatch(tok, "GlyphCompositionVerticalIC:")==0) {
	 if (sc->vert_variants==NULL)
	    sc->vert_variants=chunkalloc(sizeof(struct glyphvariants));
	 SFDParseMathValueRecord(sfd, &sc->vert_variants->italic_correction,
				 &sc->vert_variants->italic_adjusts);
      } else if (strmatch(tok, "GlyphCompositionHorizontalIC:")==0) {
	 if (sc->horiz_variants==NULL)
	    sc->horiz_variants=chunkalloc(sizeof(struct glyphvariants));
	 SFDParseMathValueRecord(sfd, &sc->horiz_variants->italic_correction,
				 &sc->horiz_variants->italic_adjusts);
      } else if (strmatch(tok, "IsExtendedShape:")==0) {
	 int temp;

	 getint(sfd, &temp);
	 sc->is_extended_shape=temp;
      } else if (strmatch(tok, "GlyphVariantsVertical:")==0) {
	 if (sc->vert_variants==NULL)
	    sc->vert_variants=chunkalloc(sizeof(struct glyphvariants));
	 geteol(sfd, tok);
	 sc->vert_variants->variants=fastrdup(tok);
      } else if (strmatch(tok, "GlyphVariantsHorizontal:")==0) {
	 if (sc->horiz_variants==NULL)
	    sc->horiz_variants=chunkalloc(sizeof(struct glyphvariants));
	 geteol(sfd, tok);
	 sc->horiz_variants->variants=fastrdup(tok);
      } else if (strmatch(tok, "GlyphCompositionVertical:")==0) {
	 sc->vert_variants =
	    SFDParseGlyphComposition(sfd, sc->vert_variants, tok);
      } else if (strmatch(tok, "GlyphCompositionHorizontal:")==0) {
	 sc->horiz_variants =
	    SFDParseGlyphComposition(sfd, sc->horiz_variants, tok);
      } else if (strmatch(tok, "TopRightVertex:")==0) {
	 if (sc->mathkern==NULL)
	    sc->mathkern=chunkalloc(sizeof(struct mathkern));
	 SFDParseVertexKern(sfd, &sc->mathkern->top_right);
      } else if (strmatch(tok, "TopLeftVertex:")==0) {
	 if (sc->mathkern==NULL)
	    sc->mathkern=chunkalloc(sizeof(struct mathkern));
	 SFDParseVertexKern(sfd, &sc->mathkern->top_left);
      } else if (strmatch(tok, "BottomRightVertex:")==0) {
	 if (sc->mathkern==NULL)
	    sc->mathkern=chunkalloc(sizeof(struct mathkern));
	 SFDParseVertexKern(sfd, &sc->mathkern->bottom_right);
      } else if (strmatch(tok, "BottomLeftVertex:")==0) {
	 if (sc->mathkern==NULL)
	    sc->mathkern=chunkalloc(sizeof(struct mathkern));
	 SFDParseVertexKern(sfd, &sc->mathkern->bottom_left);
#if HANYANG
      } else if (strmatch(tok, "CompositionUnit:")==0) {
	 getsint(sfd, &sc->jamo);
	 getsint(sfd, &sc->varient);
	 sc->compositionunit=true;
#endif
      } else if (strmatch(tok, "HStem:")==0) {
	 sc->hstem=SFDReadHints(sfd);
	 sc->hconflicts=StemListAnyConflicts(sc->hstem);
      } else if (strmatch(tok, "VStem:")==0) {
	 sc->vstem=SFDReadHints(sfd);
	 sc->vconflicts=StemListAnyConflicts(sc->vstem);
      } else if (strmatch(tok, "DStem:")==0) {
	 sc->dstem=SFDReadDHints(sc->parent, sfd, true);
	 had_old_dstems=true;
      } else if (strmatch(tok, "DStem2:")==0) {
	 sc->dstem=SFDReadDHints(sc->parent, sfd, false);
      } else if (strmatch(tok, "CounterMasks:")==0) {
	 getsint(sfd, &sc->countermask_cnt);
	 sc->countermasks=calloc(sc->countermask_cnt, sizeof(HintMask));
	 for (i=0; i < sc->countermask_cnt; ++i) {
	    int ch;

	    while ((ch=nlgetc(sfd))==' ');
	    aungetc(ch, sfd);
	    SFDGetHintMask(sfd, &sc->countermasks[i]);
	 }
      } else if (strmatch(tok, "AnchorPoint:")==0) {
	 lastap=SFDReadAnchorPoints(sfd, sc, &sc->anchor, lastap);
      } else if (strmatch(tok, "Fore")==0) {
	 while (isspace(ch=nlgetc(sfd)));
	 aungetc(ch, sfd);
	 if (ch != 'I' && ch != 'R' && ch != 'S' && ch != 'V') {
	    /* Old format, without a SplineSet token */
	    sc->layers[ly_fore].splines =
	       SFDGetSplineSet(sf, sfd, sc->layers[ly_fore].order2);
	 }
	 current_layer=ly_fore;
      } else if (strmatch(tok, "MinimumDistance:")==0) {
	 SFDGetMinimumDistances(sfd, sc);
      } else if (strmatch(tok, "Validated:")==0) {
	 getsint(sfd, (int16_t *) & sc->layers[current_layer].validation_state);
      } else if (strmatch(tok, "PickledData:")==0) {
	 sc->python_persistent=SFDUnPickle(sfd);
      } else if (strmatch(tok, "Back")==0) {
	 while (isspace(ch=nlgetc(sfd)));
	 aungetc(ch, sfd);
	 if (ch != 'I' && ch != 'R' && ch != 'S' && ch != 'V') {
	    /* Old format, without a SplineSet token */
	    sc->layers[ly_back].splines =
	       SFDGetSplineSet(sf, sfd, sc->layers[ly_back].order2);
	    oldback=true;
	 }
	 current_layer=ly_back;
      } else if (strmatch(tok, "LayerCount:")==0) {
	 getint(sfd, &temp);
	 if (temp > sc->layer_cnt) {
	    sc->layers=realloc(sc->layers, temp * sizeof(Layer));
	    memset(sc->layers + sc->layer_cnt, 0,
		   (temp - sc->layer_cnt) * sizeof(Layer));
	 }
	 sc->layer_cnt=temp;
	 current_layer=ly_fore;
      } else if (strmatch(tok, "Layer:")==0) {
	 int layer;
	 int dofill, dostroke, fillfirst, linejoin, linecap;
	 uint32_t fillcol, strokecol;
	 double fillopacity, strokeopacity, strokewidth, trans[4];
	 DashType dashes[DASH_MAX];
	 int i;

	 getint(sfd, &layer);
	 if (layer >= sc->layer_cnt) {
	    sc->layers=realloc(sc->layers, (layer + 1) * sizeof(Layer));
	    memset(sc->layers + sc->layer_cnt, 0,
		   (layer + 1 - sc->layer_cnt) * sizeof(Layer));
	 }
	 if (sc->parent->multilayer) {
	    getint(sfd, &dofill);
	    getint(sfd, &dostroke);
	    getint(sfd, &fillfirst);
	    gethex(sfd, &fillcol);
	    getreal(sfd, &fillopacity);
	    gethex(sfd, &strokecol);
	    getreal(sfd, &strokeopacity);
	    getreal(sfd, &strokewidth);
	    getname(sfd, tok);
	    for (i=0; joins[i] != NULL; ++i)
	       if (strmatch(joins[i], tok)==0)
		  break;
	    if (joins[i]==NULL)
	       --i;
	    linejoin=i;
	    getname(sfd, tok);
	    for (i=0; caps[i] != NULL; ++i)
	       if (strmatch(caps[i], tok)==0)
		  break;
	    if (caps[i]==NULL)
	       --i;
	    linecap=i;
	    while ((ch=nlgetc(sfd))==' ' || ch=='[');
	    aungetc(ch, sfd);
	    getreal(sfd, &trans[0]);
	    getreal(sfd, &trans[1]);
	    getreal(sfd, &trans[2]);
	    getreal(sfd, &trans[3]);
	    while ((ch=nlgetc(sfd))==' ' || ch==']');
	    if (ch=='[') {
	       for (i=0;; ++i) {
		  int temp;

		  if (!getint(sfd, &temp))
		     break;
		  else if (i < DASH_MAX)
		     dashes[i]=temp;
	       }
	       if (i < DASH_MAX)
		  dashes[i]=0;
	    } else {
	       aungetc(ch, sfd);
	       memset(dashes, 0, sizeof(dashes));
	    }
	    sc->layers[layer].dofill=dofill;
	    sc->layers[layer].dostroke=dostroke;
	    sc->layers[layer].fillfirst=fillfirst;
	    sc->layers[layer].fill_brush.col=fillcol;
	    sc->layers[layer].fill_brush.opacity=fillopacity;
	    sc->layers[layer].stroke_pen.brush.col=strokecol;
	    sc->layers[layer].stroke_pen.brush.opacity=strokeopacity;
	    sc->layers[layer].stroke_pen.width=strokewidth;
	    sc->layers[layer].stroke_pen.linejoin=linejoin;
	    sc->layers[layer].stroke_pen.linecap=linecap;
	    memcpy(sc->layers[layer].stroke_pen.dashes, dashes,
		   sizeof(dashes));
	    memcpy(sc->layers[layer].stroke_pen.trans, trans, sizeof(trans));
	 }
	 current_layer=layer;
	 lasti=NULL;
	 lastr=NULL;
      } else if (strmatch(tok, "FillGradient:")==0) {
	 sc->layers[current_layer].fill_brush.gradient =
	    SFDParseGradient(sfd, tok);
      } else if (strmatch(tok, "FillPattern:")==0) {
	 sc->layers[current_layer].fill_brush.pattern =
	    SFDParsePattern(sfd, tok);
      } else if (strmatch(tok, "StrokeGradient:")==0) {
	 sc->layers[current_layer].stroke_pen.brush.gradient =
	    SFDParseGradient(sfd, tok);
      } else if (strmatch(tok, "StrokePattern:")==0) {
	 sc->layers[current_layer].stroke_pen.brush.pattern =
	    SFDParsePattern(sfd, tok);
      } else if (strmatch(tok, "UndoRedoHistory")==0) {
	 getname(sfd, tok);
	 if (!strmatch(tok, "Layer:")) {
	    int layer;

	    getint(sfd, &layer);
	 }

	 getname(sfd, tok);
	 if (!strmatch(tok, "Undoes")) {
	    char *terminators[]={ "EndUndoes", "EndRedoes", 0 };
	    SFDConsumeUntil(sfd, terminators);
	 }
	 getname(sfd, tok);
	 if (!strmatch(tok, "Redoes")) {
	    char *terminators[]={ "EndUndoes", "EndRedoes", 0 };
	    SFDConsumeUntil(sfd, terminators);
	 }
      } else if (strmatch(tok, "SplineSet")==0) {
	 sc->layers[current_layer].splines =
	    SFDGetSplineSet(sf, sfd, sc->layers[current_layer].order2);
      } else if (strmatch(tok, "Ref:")==0 || strmatch(tok, "Refer:")==0) {
	 /* I should be depending on the version number here, but I made */
	 /*  a mistake and bumped the version too late. So the version is */
	 /*  not an accurate mark, but the presence of a LayerCount keyword */
	 /*  in the font is an good mark. Before the LayerCount was added */
	 /*  (version 2) only the foreground layer could have references */
	 /*  after that (eventually version 3) any layer could. */
	 if (oldback || !had_sf_layer_cnt)
	    current_layer=ly_fore;
	 ref=SFDGetRef(sfd, strmatch(tok, "Ref:")==0);
	 if (sc->layers[current_layer].refs==NULL)
	    sc->layers[current_layer].refs=ref;
	 else
	    lastr->next=ref;
	 lastr=ref;
      } else if (strmatch(tok, "Image:")==0) {
	 int ly=current_layer;

	 if (!multilayer && !sc->layers[ly].background)
	    ly=ly_back;
	 img=SFDGetImage(sfd);
	 if (sc->layers[ly].images==NULL)
	    sc->layers[ly].images=img;
	 else
	    lasti->next=img;
	 lasti=img;
      } else if (strmatch(tok, "OrigType1:")==0) {	/* Accept, slurp, ignore contents */
	 SFDGetType1(sfd, sc);
      } else if (strmatch(tok, "TtfInstrs:")==0) {	/* Binary format */
	 SFDGetTtfInstrs(sfd, sc);
      } else if (strmatch(tok, "TtInstrs:")==0) {	/* ASCII format */
	 SFDGetTtInstrs(sfd, sc);
      } else if (strmatch(tok, "Kerns2:")==0 ||
		 strmatch(tok, "VKerns2:")==0) {
	 KernPair *kp, *last=NULL;
	 int isv=*tok=='V';
	 int off, index;
	 struct lookup_subtable *sub;

	 if (sf->sfd_version < 2)
	    ErrorMsg(2,"Found an new style kerning pair inside a version 1 (or lower) sfd file.\n");
	 while (afscanf(sfd, "%d %d", &index, &off)==2) {
	    sub=SFFindLookupSubtableAndFreeName(sf, SFDReadUTF7Str(sfd));
	    if (sub==NULL) {
	       ErrorMsg(2,"KernPair with no subtable name.\n");
	       break;
	    }
	    kp=chunkalloc(sizeof(KernPair1));
	    kp->sc=(SplineChar *) (intptr_t) index;
	    kp->kcid=true;
	    kp->off=off;
	    kp->subtable=sub;
	    kp->next=NULL;
	    while ((ch=nlgetc(sfd))==' ');
	    aungetc(ch, sfd);
	    if (ch=='{') {
	       kp->adjust=chunkalloc(sizeof(DeviceTable));
	       SFDReadDeviceTable(sfd, kp->adjust);
	    }
	    if (last != NULL)
	       last->next=kp;
	    else if (isv)
	       sc->vkerns=kp;
	    else
	       sc->kerns=kp;
	    last=kp;
	 }
      } else if (strmatch(tok, "Kerns:")==0 ||
		 strmatch(tok, "KernsSLI:")==0 ||
		 strmatch(tok, "KernsSLIF:")==0 ||
		 strmatch(tok, "VKernsSLIF:")==0 ||
		 strmatch(tok, "KernsSLIFO:")==0 ||
		 strmatch(tok, "VKernsSLIFO:")==0) {
	 KernPair1 *kp, *last=NULL;
	 int index, off, sli, flags=0;
	 int hassli=(strmatch(tok, "KernsSLI:")==0);
	 int isv=*tok=='V';
	 int has_orig=strstr(tok, "SLIFO:") != NULL;

	 if (sf->sfd_version >= 2) {
	    ErrorMsg(3,"Found an old style kerning pair inside a version 2 (or higher) sfd file.\n");
	    exit(1);
	 }
	 if (strmatch(tok, "KernsSLIF:")==0
	     || strmatch(tok, "KernsSLIFO:")==0
	     || strmatch(tok, "VKernsSLIF:")==0
	     || strmatch(tok, "VKernsSLIFO:")==0)
	    hassli=2;
	 while ((hassli==1
		 && afscanf(sfd, "%d %d %d", &index, &off, &sli)==3)
		|| (hassli==2
		    && afscanf(sfd, "%d %d %d %d", &index, &off, &sli,
			      &flags)==4) || (hassli==0
						&& afscanf(sfd, "%d %d",
							  &index,
							  &off)==2)) {
	    if (!hassli)
	       sli=SFFindBiggestScriptLangIndex(sli_sf,
						  script !=
						  0 ? script :
						  SCScriptFromUnicode(sc),
						  DEFAULT_LANG);
	    if (sli >= ((SplineFont1 *) sli_sf)->sli_cnt && sli != SLI_NESTED) {
	       static int complained=false;

	       if (!complained)
		  ErrorMsg(2,"'%s' in %s has a script index out of bounds: %d\n",
			 isv ? "vkrn" : "kern", sc->name, sli);
	       else
		  ErrorMsg(2,"'%s' in %s has a script index out of bounds: %d\n",
			 isv ? "vkrn" : "kern", sc->name, sli);
	       sli=SFFindBiggestScriptLangIndex(sli_sf,
						  SCScriptFromUnicode(sc),
						  DEFAULT_LANG);
	       complained=true;
	    }
	    kp=chunkalloc(sizeof(KernPair1));
	    kp->kp.sc=(SplineChar *) (intptr_t) index;
	    kp->kp.kcid=has_orig;
	    kp->kp.off=off;
	    kp->sli=sli;
	    kp->flags=flags;
	    kp->kp.next=NULL;
	    while ((ch=nlgetc(sfd))==' ');
	    aungetc(ch, sfd);
	    if (ch=='{') {
	       kp->kp.adjust=chunkalloc(sizeof(DeviceTable));
	       SFDReadDeviceTable(sfd, kp->kp.adjust);
	    }
	    if (last != NULL)
	       last->kp.next=(KernPair *) kp;
	    else if (isv)
	       sc->vkerns=(KernPair *) kp;
	    else
	       sc->kerns=(KernPair *) kp;
	    last=kp;
	 }
      } else if ((ispos=(strmatch(tok, "Position:")==0)) ||
		 (ispos=(strmatch(tok, "Position2:")==0)) ||
		 (ispair=(strmatch(tok, "PairPos:")==0)) ||
		 (ispair=(strmatch(tok, "PairPos2:")==0)) ||
		 (islcar=(strmatch(tok, "LCarets:")==0)) ||
		 (islcar=(strmatch(tok, "LCarets2:")==0)) ||
		 (isliga=(strmatch(tok, "Ligature:")==0)) ||
		 (isliga=(strmatch(tok, "Ligature2:")==0)) ||
		 (issubs=(strmatch(tok, "Substitution:")==0)) ||
		 (issubs=(strmatch(tok, "Substitution2:")==0)) ||
		 (ismult=(strmatch(tok, "MultipleSubs:")==0)) ||
		 (ismult=(strmatch(tok, "MultipleSubs2:")==0)) ||
		 strmatch(tok, "AlternateSubs:")==0 ||
		 strmatch(tok, "AlternateSubs2:")==0) {
	 PST *pst;
	 int old, type;

	 type=ispos ? pst_position :
	    ispair ? pst_pair :
	    islcar ? pst_lcaret :
	    isliga ? pst_ligature :
	    issubs ? pst_substitution : ismult ? pst_multiple : pst_alternate;
	 if (strchr(tok, '2') != NULL) {
	    old=false;
	    pst=chunkalloc(sizeof(PST));
	    if (type != pst_lcaret)
	       pst->subtable =
		  SFFindLookupSubtableAndFreeName(sf, SFDReadUTF7Str(sfd));
	 } else {
	    old=true;
	    pst=chunkalloc(sizeof(PST1));
	    ((PST1 *) pst)->tag=CHR('l', 'i', 'g', 'a');
	    ((PST1 *) pst)->script_lang_index=0xffff;
	    while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	    if (isdigit(ch)) {
	       int temp;

	       aungetc(ch, sfd);
	       getint(sfd, &temp);
	       ((PST1 *) pst)->flags=temp;
	       while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	    } else
	       ((PST1 *) pst)->flags=0 /*PSTDefaultFlags(type,sc) */ ;
	    if (isdigit(ch)) {
	       aungetc(ch, sfd);
	       getusint(sfd, &((PST1 *) pst)->script_lang_index);
	       while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	    } else
	       ((PST1 *) pst)->script_lang_index =
		  SFFindBiggestScriptLangIndex(sf,
					       script !=
					       0 ? script :
					       SCScriptFromUnicode(sc),
					       DEFAULT_LANG);
	    if (ch=='\'') {
	       aungetc(ch, sfd);
	       ((PST1 *) pst)->tag=gettag(sfd);
	    } else if (ch=='<') {
	       getint(sfd, &temp);
	       ((PST1 *) pst)->tag=temp << 16;
	       nlgetc(sfd);	/* comma */
	       getint(sfd, &temp);
	       ((PST1 *) pst)->tag |= temp;
	       nlgetc(sfd);	/* close '>' */
	       ((PST1 *) pst)->macfeature=true;
	    } else
	       aungetc(ch, sfd);
	    if (type==pst_lcaret) {
	       /* These are meaningless for lcarets, set them to innocuous values */
	       ((PST1 *) pst)->script_lang_index=SLI_UNKNOWN;
	       ((PST1 *) pst)->tag=CHR(' ', ' ', ' ', ' ');
	    } else if (((PST1 *) pst)->script_lang_index >=
		       ((SplineFont1 *) sli_sf)->sli_cnt
		       && ((PST1 *) pst)->script_lang_index != SLI_NESTED) {
	       static int complained=false;

	       if (!complained)
		  ErrorMsg(2,"'%c%c%c%c' in %s has a script index out of bounds: %d\n",
		      (((PST1 *) pst)->tag >> 24),
		      (((PST1 *) pst)->tag >> 16) & 0xff,
		      (((PST1 *) pst)->tag >> 8) & 0xff,
		      ((PST1 *) pst)->tag & 0xff, sc->name,
		      ((PST1 *) pst)->script_lang_index);
	       else
		  ErrorMsg(2,"'%c%c%c%c' in %s has a script index out of bounds: %d\n",
		      (((PST1 *) pst)->tag >> 24),
		      (((PST1 *) pst)->tag >> 16) & 0xff,
		      (((PST1 *) pst)->tag >> 8) & 0xff,
		      ((PST1 *) pst)->tag & 0xff, sc->name,
		      ((PST1 *) pst)->script_lang_index);
	       ((PST1 *) pst)->script_lang_index =
		  SFFindBiggestScriptLangIndex(sli_sf,
					       SCScriptFromUnicode(sc),
					       DEFAULT_LANG);
	       complained=true;
	    }
	 }
	 if ((sf->sfd_version < 2) != old) {
	    ErrorMsg(3,"Version mixup in PST of sfd file.\n");
	    exit(1);
	 }
	 if (last==NULL)
	    sc->possub=pst;
	 else
	    last->next=pst;
	 last=pst;
	 pst->type=type;
	 if (pst->type==pst_position) {
	    afscanf(sfd, " dx=%hd dy=%hd dh=%hd dv=%hd",
		   &pst->u.pos.xoff, &pst->u.pos.yoff,
		   &pst->u.pos.h_adv_off, &pst->u.pos.v_adv_off);
	    pst->u.pos.adjust=SFDReadValDevTab(sfd);
	    ch=nlgetc(sfd);	/* Eat new line */
	 } else if (pst->type==pst_pair) {
	    getname(sfd, tok);
	    pst->u.pair.paired=fastrdup(tok);
	    pst->u.pair.vr=chunkalloc(sizeof(struct vr[2]));
	    afscanf(sfd, " dx=%hd dy=%hd dh=%hd dv=%hd",
		   &pst->u.pair.vr[0].xoff, &pst->u.pair.vr[0].yoff,
		   &pst->u.pair.vr[0].h_adv_off,
		   &pst->u.pair.vr[0].v_adv_off);
	    pst->u.pair.vr[0].adjust=SFDReadValDevTab(sfd);
	    afscanf(sfd, " dx=%hd dy=%hd dh=%hd dv=%hd",
		   &pst->u.pair.vr[1].xoff, &pst->u.pair.vr[1].yoff,
		   &pst->u.pair.vr[1].h_adv_off,
		   &pst->u.pair.vr[1].v_adv_off);
	    pst->u.pair.vr[0].adjust=SFDReadValDevTab(sfd);
	    ch=nlgetc(sfd);
	 } else if (pst->type==pst_lcaret) {
	    int i;

	    afscanf(sfd, " %d", &pst->u.lcaret.cnt);
	    pst->u.lcaret.carets=malloc(pst->u.lcaret.cnt * sizeof(int16_t));
	    for (i=0; i < pst->u.lcaret.cnt; ++i)
	       afscanf(sfd, " %hd", &pst->u.lcaret.carets[i]);
	    geteol(sfd, tok);
	 } else {
	    geteol(sfd, tok);
	    pst->u.lig.components=fastrdup(tok);	/* it's in the same place for all formats */
	    if (isliga) {
	       pst->u.lig.lig=sc;
	       if (old)
		  last=(PST *) LigaCreateFromOldStyleMultiple((PST1 *) pst);
	    }
	 }
      } else if (strmatch(tok, "Colour:")==0) {
	 uint32_t temp;

	 gethex(sfd, &temp);
	 sc->color=temp;
      } else if (strmatch(tok, "Comment:")==0) {
	 sc->comment=SFDReadUTF7Str(sfd);
      } else if (strmatch(tok, "TileMargin:")==0) {
	 getreal(sfd, &sc->tile_margin);
      } else if (strmatch(tok, "TileBounds:")==0) {
	 getreal(sfd, &sc->tile_bounds.minx);
	 getreal(sfd, &sc->tile_bounds.miny);
	 getreal(sfd, &sc->tile_bounds.maxx);
	 getreal(sfd, &sc->tile_bounds.maxy);
      } else if (strmatch(tok, "EndChar")==0) {
	 if (sc->orig_pos < sf->glyphcnt)
	    sf->glyphs[sc->orig_pos]=sc;
	 /* Recalculating hint active zones may be needed for old .sfd files. */
	 /* Do this when we have finished with other glyph components, */
	 /* so that splines are already available */
	 if (sf->sfd_version < 2)
	    SCGuessHintInstancesList(sc, ly_fore, sc->hstem, sc->vstem,
				     sc->dstem, false, false);
	 else if (had_old_dstems && sc->layers[ly_fore].splines != NULL)
	    SCGuessHintInstancesList(sc, ly_fore, NULL, NULL, sc->dstem,
				     false, true);
	 if (sc->layers[ly_fore].order2)
	    SCDefaultInterpolation(sc);
	 return (sc);
      } else {
	 geteol(sfd, tok);
      }
   }
}

static int SFDGetBitmapProps(AFILE *sfd,BDFFont *bdf,char *tok) {
   int pcnt;
   int i;

   if (getint(sfd, &pcnt) != 1 || pcnt <= 0)
      return (0);
   bdf->prop_cnt=pcnt;
   bdf->props=malloc(pcnt * sizeof(BDFProperties));
   for (i=0; i < pcnt; ++i) {
      if (getname(sfd, tok) != 1)
	 break;
      if (strcmp(tok, "BDFEndProperties")==0)
	 break;
      bdf->props[i].name=fastrdup(tok);
      getint(sfd, &bdf->props[i].type);
      switch (bdf->props[i].type & ~prt_property) {
	case prt_int:
	case prt_uint:
	   getint(sfd, &bdf->props[i].u.val);
	   break;
	case prt_string:
	case prt_atom:
	   geteol(sfd, tok);
	   if (tok[strlen(tok) - 1]=='"')
	      tok[strlen(tok) - 1]='\0';
	   bdf->props[i].u.str=fastrdup(tok[0]=='"' ? tok + 1 : tok);
	   break;
      }
   }
   bdf->prop_cnt=i;
   return (1);
}

static int SFDGetBitmapChar(AFILE *sfd,BDFFont *bdf) {
   BDFChar *bfc;
   struct enc85 dec;
   int i, enc, orig;
   int width, xmax, xmin, ymax, ymin, vwidth=-1;
   EncMap *map;
   int ch;

   bfc=chunkalloc(sizeof(BDFChar));
   memset(bfc, '\0', sizeof(BDFChar));
   map=bdf->sf->map;

   if (getint(sfd, &orig) != 1 || orig < 0)
      return (0);
   if (getint(sfd, &enc) != 1)
      return (0);
   if (getint(sfd, &width) != 1)
      return (0);
   if (getint(sfd, &xmin) != 1)
      return (0);
   if (getint(sfd, &xmax) != 1)
      return (0);
   if (getint(sfd, &ymin) != 1)
      return (0);
   while ((ch=nlgetc(sfd))==' ');
   aungetc(ch, sfd);
   if (ch=='\n' || ch=='\r' || getint(sfd, &ymax) != 1) {
      /* Old style format, no orig_pos given, shift everything by 1 */
      ymax=ymin;
      ymin=xmax;
      xmax=xmin;
      xmin=width;
      width=enc;
      enc=orig;
      orig=map->map[enc];
   } else {
      while ((ch=nlgetc(sfd))==' ');
      aungetc(ch, sfd);
      if (ch != '\n' && ch != '\r')
	 getint(sfd, &vwidth);
   }
   if (enc < 0 || xmax < xmin || ymax < ymin)
      return (0);
   if (orig==-1) {
      bfc->sc=SFMakeChar(bdf->sf, map, enc);
      orig=bfc->sc->orig_pos;
   }

   bfc->orig_pos=orig;
   bfc->width=width;
   bfc->ymax=ymax;
   bfc->ymin=ymin;
   bfc->xmax=xmax;
   bfc->xmin=xmin;
   bdf->glyphs[orig]=bfc;
   bfc->sc=bdf->sf->glyphs[orig];
   bfc->vwidth=vwidth != -1 ? vwidth :
      rint(bfc->sc->vwidth * bdf->pixelsize /
	   (double) (bdf->sf->ascent + bdf->sf->descent));
   if (bdf->clut==NULL) {
      bfc->bytes_per_line=(bfc->xmax - bfc->xmin) / 8 + 1;
      bfc->depth=1;
   } else {
      bfc->bytes_per_line=bfc->xmax - bfc->xmin + 1;
      bfc->byte_data=true;
      bfc->depth =
	 bdf->clut->clut_len==4 ? 2 : bdf->clut->clut_len==16 ? 4 : 8;
   }
   bfc->bitmap =
      calloc((bfc->ymax - bfc->ymin + 1) * bfc->bytes_per_line, sizeof(char));

   memset(&dec, '\0', sizeof(dec));
   dec.pos=-1;
   dec.sfd=sfd;
   for (i=0; i <= bfc->ymax - bfc->ymin; ++i) {
      uint8_t *pt=(uint8_t *) (bfc->bitmap + i * bfc->bytes_per_line);
      uint8_t *end=(uint8_t *) (bfc->bitmap + (i + 1) * bfc->bytes_per_line);

      while (pt < end) {
	 *pt++=Dec85(&dec);
      }
   }
   if (bfc->sc==NULL) {
      bdf->glyphs[bfc->orig_pos]=NULL;
      BDFCharFree(bfc);
   }
/* This fixes a bug: We didn't set "widthset" on splinechars when reading in */
/*  winfonts. We should set it now on any bitmaps worth outputting to make up*/
/*  for that. Eventually we should have good sfd files and can remove this */
   else if (bfc->sc->width != bdf->sf->ascent + bdf->sf->descent)
      bfc->sc->widthset=true;
   return (1);
}

static int SFDGetBitmapReference(AFILE *sfd,BDFFont *bdf) {
   BDFChar *bc;
   BDFRefChar *ref, *head;
   int gid, rgid, xoff, yoff;
   char ch;

   /* 'BDFRefChar:' elements should not occur in the file before the corresponding */
   /* 'BDFChar:'. However it is possible that the glyphs they refer to are not yet */
   /* available. So we will find them later */
   if (getint(sfd, &gid) != 1 || gid <= 0 || gid >= bdf->glyphcnt
       || (bc=bdf->glyphs[gid])==NULL)
      return (0);
   if (getint(sfd, &rgid) != 1 || rgid < 0)
      return (0);
   if (getint(sfd, &xoff) != 1)
      return (0);
   if (getint(sfd, &yoff) != 1)
      return (0);
   while (isspace(ch=nlgetc(sfd)) && ch != '\r' && ch != '\n');

   ref=calloc(1, sizeof(BDFRefChar));
   ref->gid=rgid;
   ref->xoff=xoff, ref->yoff=yoff;
   if (ch=='S')
      ref->selected=true;
   for (head=bc->refs; head != NULL && head->next != NULL;
	head=head->next);
   if (head==NULL)
      bc->refs=ref;
   else
      head->next=ref;
   return (1);
}

static void SFDFixupBitmapRefs(BDFFont *bdf) {
   BDFChar *bc, *rbc;
   BDFRefChar *head, *next, *prev;
   int i;

   for (i=0; i < bdf->glyphcnt; i++)
      if ((bc=bdf->glyphs[i]) != NULL) {
	 prev=NULL;
	 for (head=bc->refs; head != NULL; head=next) {
	    next=head->next;
	    if ((rbc=bdf->glyphs[head->gid]) != NULL) {
	       head->bdfc=rbc;
	       BCMakeDependent(bc, rbc);
	       prev=head;
	    } else {
	       ErrorMsg(2,"Glyph %d in bitmap strike %d pixels refers to a missing glyph (%d)\n",
			bc->orig_pos, bdf->pixelsize, head->gid);
	       if (prev==NULL)
		  bc->refs=next;
	       else
		  prev->next=next;
	    }
	 }
      }

}

static int SFDGetBitmapFont(AFILE *sfd,SplineFont *sf) {
   BDFFont *bdf, *prev;
   char tok[200];
   int pixelsize, ascent, descent, depth=1;
   int ch, enccount;

   bdf=calloc(1, sizeof(BDFFont));

   if (getint(sfd, &pixelsize) != 1 || pixelsize <= 0)
      return (0);
   if (getint(sfd, &enccount) != 1 || enccount < 0)
      return (0);
   if (getint(sfd, &ascent) != 1 || ascent < 0)
      return (0);
   if (getint(sfd, &descent) != 1 || descent < 0)
      return (0);
   if (getint(sfd, &depth) != 1)
      depth=1;		/* old sfds don't have a depth here */
   else if (depth != 1 && depth != 2 && depth != 4 && depth != 8)
      return (0);
   while ((ch=nlgetc(sfd))==' ');
   aungetc(ch, sfd);		/* old sfds don't have a foundry */
   if (ch != '\n' && ch != '\r') {
      getname(sfd, tok);
      bdf->foundry=fastrdup(tok);
   }
   bdf->pixelsize=pixelsize;
   bdf->ascent=ascent;
   bdf->descent=descent;
   if (depth != 1)
      BDFClut(bdf, (1 << (depth / 2)));

   if (sf->bitmaps==NULL)
      sf->bitmaps=bdf;
   else {
      for (prev=sf->bitmaps; prev->next != NULL; prev=prev->next);
      prev->next=bdf;
   }
   bdf->sf=sf;
   bdf->glyphcnt=bdf->glyphmax=sf->glyphcnt;
   bdf->glyphs=calloc(bdf->glyphcnt, sizeof(BDFChar *));

   while (getname(sfd, tok)==1) {
      if (strcmp(tok, "BDFStartProperties:")==0)
	 SFDGetBitmapProps(sfd, bdf, tok);
      else if (strcmp(tok, "BDFEndProperties")==0)
	 /* Do Nothing */ ;
      else if (strcmp(tok, "Resolution:")==0)
	 getint(sfd, &bdf->res);
      else if (strcmp(tok, "BDFChar:")==0)
	 SFDGetBitmapChar(sfd, bdf);
      else if (strcmp(tok, "BDFRefChar:")==0)
	 SFDGetBitmapReference(sfd, bdf);
      else if (strcmp(tok, "EndBitmapFont")==0)
	 break;
   }
   SFDFixupBitmapRefs(bdf);
   return (1);
}

static void SFDFixupRef(SplineChar *sc,RefChar *ref,int layer) {
   RefChar *rf;
   int ly;

   if (sc->parent->multilayer) {
      for (ly=ly_fore; ly < ref->sc->layer_cnt; ++ly) {
	 for (rf=ref->sc->layers[ly].refs; rf != NULL; rf=rf->next) {
	    if (rf->sc==sc) {	/* Huh? */
	       ref->sc->layers[ly].refs=NULL;
	       break;
	    }
	    if (rf->layers[0].splines==NULL)
	       SFDFixupRef(ref->sc, rf, layer);
	 }
      }
   } else {
      for (rf=ref->sc->layers[layer].refs; rf != NULL; rf=rf->next) {
	 if (rf->sc==sc) {	/* Huh? */
	    ref->sc->layers[layer].refs=NULL;
	    break;
	 }
	 if (rf->layers[0].splines==NULL)
	    SFDFixupRef(ref->sc, rf, layer);
      }
   }
   SCReinstantiateRefChar(sc, ref, layer);
   SCMakeDependent(sc, ref->sc);
}

/* Look for character duplicates, such as might be generated by having the same */
/*  glyph at two encoding slots */
/* This is an obsolete convention, supported now only in sfd files */
/* I think it is ok if something depends on this character, because the */
/*  code that handles references will automatically unwrap it down to be base */
static SplineChar *SCDuplicate(SplineChar *sc) {
   SplineChar *matched=sc;

   if (sc==NULL || sc->parent==NULL || sc->parent->cidmaster != NULL)
      return (sc);		/* Can't do this in CID keyed fonts */

   if (sc->layer_cnt != 2)
      return (sc);

   while (sc->layers[ly_fore].refs != NULL && sc->layers[ly_fore].refs->sc != NULL &&	/* Can happen if we are called during font loading before references are fixed up */
	  sc->layers[ly_fore].refs->next==NULL &&
	  sc->layers[ly_fore].refs->transform[0]==1
	  && sc->layers[ly_fore].refs->transform[1]==0
	  && sc->layers[ly_fore].refs->transform[2]==0
	  && sc->layers[ly_fore].refs->transform[3]==1
	  && sc->layers[ly_fore].refs->transform[4]==0
	  && sc->layers[ly_fore].refs->transform[5]==0) {
      char *basename=sc->layers[ly_fore].refs->sc->name;

      if (strcmp(sc->name, basename) != 0)
	 break;
      matched=sc->layers[ly_fore].refs->sc;
      sc=sc->layers[ly_fore].refs->sc;
   }
   return (matched);
}

static void SFDFixupUndoRefsUndoList(SplineFont *sf,Undoes *undo) {
   for (; undo; undo=undo->next) {
      if (undo->undotype==ut_state && undo->u.state.refs) {
	 RefChar *ref=NULL;

	 for (ref=undo->u.state.refs; ref != NULL; ref=ref->next) {

	    ref->sc=sf->glyphs[ref->orig_pos];
	 }
      }
   }
}

static void SFDFixupUndoRefs(SplineFont *sf) {
   int i=0;
   Undoes *undo=0;

   for (i=0; i < sf->glyphcnt; ++i) {
      if (sf->glyphs[i] != NULL) {
	 SplineChar *sc=sf->glyphs[i];
	 int layer=0;

	 for (layer=0; layer < sc->layer_cnt; ++layer) {
	    if (sc->layers[layer].undoes) {
	       undo=sc->layers[layer].undoes;
	       SFDFixupUndoRefsUndoList(sf, undo);
	    }
	    if (sc->layers[layer].redoes) {
	       undo=sc->layers[layer].redoes;
	       SFDFixupUndoRefsUndoList(sf, undo);
	    }
	 }
      }
   }


}

/*
 * Some references in the SFD file are to a numeric glyph ID. As a
 * sneaky method to handle that, fontanvil will load these glyph
 * numbers into the pointers which should refer to the glyph. For
 * example, in kerning, instead of pointing to the splinechar for the
 * "v" glyph, the ID might be stored there, say the number 143. This
 * fixup function will convert such 143 references to being pointers
 * to the splinechar with a numeric ID of 143. It is generally a good
 * idea to do this, as some fontanvil code will of course assume a
 * pointer to a splinechar is a pointer to a splinechar and not just
 * the glyph index of that splinechar.
 *
 * MIQ updated this in Oct 2012 to be more forgiving when called twice
 * or on a splinefont which has some of its references already fixed.
 * This was to allow partial updates of data structures from SFD
 * fragments and the fixup to operate just on those references which
 * need to be fixed.
 */
static void SFDFixupRefs(SplineFont *sf) {
   int i, isv;
   RefChar *refs, *rnext, *rprev;

   /*int isautorecovery=sf->changed; */
   KernPair *kp, *prev, *next;
   EncMap *map=sf->map;
   int layer;
   int k, l;
   SplineFont *cidmaster=sf, *ksf;

   k=1;
   if (sf->subfontcnt != 0)
      sf=sf->subfonts[0];

   while (1) {
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL) {
	    SplineChar *sc=sf->glyphs[i];

	    /* A changed character is one that has just been recovered */
	    /*  unchanged characters will already have been fixed up */
	    /* Er... maybe not. If the character being recovered is refered to */
	    /*  by another character then we need to fix up that other char too */
	    /*if ( isautorecovery && !sc->changed ) */
	    /*continue; */
	    for (layer=0; layer < sc->layer_cnt; ++layer) {
	       rprev=NULL;
	       for (refs=sc->layers[layer].refs; refs != NULL; refs=rnext) {
		  rnext=refs->next;
		  if (refs->encoded) {	/* Old sfd format */
		     if (refs->orig_pos < map->encmax
			 && map->map[refs->orig_pos] != -1)
			refs->orig_pos=map->map[refs->orig_pos];
		     else
			refs->orig_pos=sf->glyphcnt;
		     refs->encoded=false;
		  }
		  if (refs->orig_pos < sf->glyphcnt && refs->orig_pos >= 0)
		     refs->sc=sf->glyphs[refs->orig_pos];
		  if (refs->sc != NULL) {
		     refs->unicode_enc=refs->sc->unicodeenc;
		     refs->adobe_enc=getAdobeEnc(refs->sc->name);
		     rprev=refs;
		     if (refs->use_my_metrics) {
			if (sc->width != refs->sc->width) {
			   ErrorMsg(2,"Bad sfd file. Glyph %s has width %d even though it should be\n  bound to the width of %s which is %d.\n",
				    sc->name, sc->width, refs->sc->name,
				    refs->sc->width);
			   sc->width=refs->sc->width;
			}
		     }
		  } else {
		     RefCharFree(refs);
		     if (rprev != NULL)
			rprev->next=rnext;
		     else
			sc->layers[layer].refs=rnext;
		  }
	       }
	    }
	    /* In old sfd files we used a peculiar idiom to represent a multiply */
	    /*  encoded glyph. Fix it up now. Remove the fake glyph and adjust the */
	    /*  map */
	    /*if ( isautorecovery && !sc->changed ) */
	    /*continue; */
	    for (isv=0; isv < 2; ++isv) {
	       for (prev=NULL, kp=isv ? sc->vkerns : sc->kerns;
		    kp != NULL; kp=next) {
		  int index=(intptr_t) (kp->sc);

		  next=kp->next;
		  // be impotent if the reference is already to the correct location
		  if (!kp->kcid) {	/* It's encoded (old sfds), else orig */
		     if (index >= map->encmax || map->map[index]==-1)
			index=sf->glyphcnt;
		     else
			index=map->map[index];
		  }
		  kp->kcid=false;
		  ksf=sf;
		  if (cidmaster != sf) {
		     for (l=0; l < cidmaster->subfontcnt; ++l) {
			ksf=cidmaster->subfonts[l];
			if (index < ksf->glyphcnt
			    && ksf->glyphs[index] != NULL)
			   break;
		     }
		  }
		  if (index >= ksf->glyphcnt || ksf->glyphs[index]==NULL) {
		     ErrorMsg(2,"Bad kerning information in glyph %s\n",
			    sc->name);
		     kp->sc=NULL;
		  } else {
		     kp->sc=ksf->glyphs[index];
		  }

		  if (kp->sc != NULL)
		     prev=kp;
		  else {
		     if (prev != NULL)
			prev->next=next;
		     else if (isv)
			sc->vkerns=next;
		     else
			sc->kerns=next;
		     chunkfree(kp, sizeof(KernPair));
		  }
	       }
	    }
	    if (SCDuplicate(sc) != sc) {
	       SplineChar *base=SCDuplicate(sc);
	       int orig=sc->orig_pos, enc=sf->map->backmap[orig], uni =
		  sc->unicodeenc;
	       SplineCharFree(sc);
	       sf->glyphs[i]=NULL;
	       sf->map->backmap[orig]=-1;
	       sf->map->map[enc]=base->orig_pos;
	       AltUniAdd(base, uni);
	    }
	 }
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL) {
	    SplineChar *sc=sf->glyphs[i];

	    for (layer=0; layer < sc->layer_cnt; ++layer) {
	       for (refs=sf->glyphs[i]->layers[layer].refs; refs != NULL;
		    refs=refs->next) {
		  SFDFixupRef(sf->glyphs[i], refs, layer);
	       }
	    }
	 }
      if (sf->cidmaster==NULL)
	 for (i=sf->glyphcnt - 1; i >= 0 && sf->glyphs[i]==NULL; --i)
	    sf->glyphcnt=i;
      if (k >= cidmaster->subfontcnt)
	 break;
      sf=cidmaster->subfonts[k++];
   }
}

static void SFDGetPrivate(AFILE *sfd,SplineFont *sf) {
   int i, cnt, len;
   char name[200];
   char *pt, *end;

   sf->private=calloc(1, sizeof(struct psdict));
   getint(sfd, &cnt);
   sf->private->next=sf->private->cnt=cnt;
   sf->private->values=calloc(cnt, sizeof(char *));
   sf->private->keys=calloc(cnt, sizeof(char *));
   for (i=0; i < cnt; ++i) {
      getname(sfd, name);
      sf->private->keys[i]=fastrdup(name);
      getint(sfd, &len);
      nlgetc(sfd);		/* skip space */
      pt=sf->private->values[i]=malloc(len + 1);
      for (end=pt + len; pt < end; ++pt)
	 *pt=nlgetc(sfd);
      *pt='\0';
   }
}

static void SFDGetSubrs(AFILE *sfd,SplineFont *sf) {
   /* Obselete, parse it in case there are any old sfds */
   int i, cnt, tot, len;
   struct enc85 dec;

   getint(sfd, &cnt);
   tot=0;
   for (i=0; i < cnt; ++i) {
      getint(sfd, &len);
      tot += len;
   }

   memset(&dec, '\0', sizeof(dec));
   dec.pos=-1;
   dec.sfd=sfd;
   for (i=0; i < tot; ++i)
      Dec85(&dec);
}

static struct ttflangname *SFDGetLangName(AFILE *sfd,struct ttflangname *old) {
   struct ttflangname *cur=chunkalloc(sizeof(struct ttflangname)), *prev;
   int i;

   getint(sfd, &cur->lang);
   for (i=0; i < ttf_namemax; ++i)
      cur->names[i]=SFDReadUTF7Str(sfd);
   if (old==NULL)
      return (cur);
   for (prev=old; prev->next != NULL; prev=prev->next);
   prev->next=cur;
   return (old);
}

static void SFDGetGasp(AFILE *sfd,SplineFont *sf) {
   int i;

   getsint(sfd, (int16_t *) & sf->gasp_cnt);
   sf->gasp=malloc(sf->gasp_cnt * sizeof(struct gasp));
   for (i=0; i < sf->gasp_cnt; ++i) {
      getsint(sfd, (int16_t *) & sf->gasp[i].ppem);
      getsint(sfd, (int16_t *) & sf->gasp[i].flags);
   }
   getsint(sfd, (int16_t *) & sf->gasp_version);
}

static void SFDGetDesignSize(AFILE *sfd,SplineFont *sf) {
   int ch;
   struct otfname *cur;

   getsint(sfd, (int16_t *) & sf->design_size);
   while ((ch=nlgetc(sfd))==' ');
   aungetc(ch, sfd);
   if (isdigit(ch)) {
      getsint(sfd, (int16_t *) & sf->design_range_bottom);
      while ((ch=nlgetc(sfd))==' ');
      if (ch != '-')
	 aungetc(ch, sfd);
      getsint(sfd, (int16_t *) & sf->design_range_top);
      getsint(sfd, (int16_t *) & sf->fontstyle_id);
      while (1) {
	 while ((ch=nlgetc(sfd))==' ');
	 aungetc(ch, sfd);
	 if (!isdigit(ch))
	    break;
	 cur=chunkalloc(sizeof(struct otfname));
	 cur->next=sf->fontstyle_name;
	 sf->fontstyle_name=cur;
	 getsint(sfd, (int16_t *) & cur->lang);
	 cur->name=SFDReadUTF7Str(sfd);
      }
   }
}

static void SFDGetOtfFeatName(AFILE *sfd,SplineFont *sf) {
   int ch;
   struct otfname *cur;
   struct otffeatname *fn;

   fn=chunkalloc(sizeof(struct otffeatname));
   fn->tag=gettag(sfd);
   while (1) {
      while ((ch=nlgetc(sfd))==' ');
      aungetc(ch, sfd);
      if (!isdigit(ch))
	 break;
      cur=chunkalloc(sizeof(struct otfname));
      cur->next=fn->names;
      fn->names=cur;
      getsint(sfd, (int16_t *) & cur->lang);
      cur->name=SFDReadUTF7Str(sfd);
   }
   fn->next=sf->feat_names;
   sf->feat_names=fn;
}

static Encoding *SFDGetEncoding(AFILE *sfd,char *tok,SplineFont *sf) {
   Encoding *enc=NULL;
   int encname;

   if (getint(sfd, &encname)) {
      if (encname < sizeof(charset_names) / sizeof(charset_names[0]) - 1)
	 enc=FindOrMakeEncoding(charset_names[encname]);
   } else {
      geteol(sfd, tok);
      enc=FindOrMakeEncoding(tok);
   }
   if (enc==NULL)
      enc=&custom;
   return (enc);
}

static enum uni_interp SFDGetUniInterp(AFILE *sfd,char *tok,SplineFont *sf) {
   int uniinterp=ui_none;
   int i;

   geteol(sfd, tok);
   for (i=0; unicode_interp_names[i] != NULL; ++i)
      if (strcmp(tok, unicode_interp_names[i])==0) {
	 uniinterp=i;
	 break;
      }
   /* These values are now handled by namelists */
   if (uniinterp==ui_adobe) {
      sf->for_new_glyphs=NameListByName("AGL with PUA");
      uniinterp=ui_none;
   } else if (uniinterp==ui_greek) {
      sf->for_new_glyphs=NameListByName("Greek small caps");
      uniinterp=ui_none;
   } else if (uniinterp==ui_ams) {
      sf->for_new_glyphs=NameListByName("AMS Names");
      uniinterp=ui_none;
   }

   return (uniinterp);
}

static void SFDGetNameList(AFILE *sfd,char *tok,SplineFont *sf) {
   NameList *nl;

   geteol(sfd, tok);
   nl=NameListByName(tok);
   if (nl==NULL)
      ErrorMsg(2,"Failed to find NameList: %s\n", tok);
   else
      sf->for_new_glyphs=nl;
}


static OTLookup *SFD_ParseNestedLookup(AFILE *sfd,SplineFont *sf,int old) {
   uint32_t tag;
   int ch,isgpos;
   OTLookup *otl;
   char *name;

   while ((ch=nlgetc(sfd))==' ');
   if (ch=='~')
      return (NULL);

   else if (old) {
      if (ch!='\'')
	 return (NULL);

      aungetc(ch,sfd);
      tag=gettag(sfd);
      return ((OTLookup *)(intptr_t)tag);

   } else {
      aungetc(ch,sfd);
      name=SFDReadUTF7Str(sfd);
      if (name==NULL)
	 return NULL;

      for (isgpos=0;isgpos<0;isgpos++)
	for (otl=sf->gsplookups[isgpos];otl!=NULL;otl=otl->next)
	  if (strcmp(name,otl->lookup_name)==0)
	    break;
      
      free(name);
      return otl;
   }
}

static void SFDParseChainContext(AFILE *sfd,SplineFont *sf,FPST *fpst,
				 char *tok, int old) {
   int ch, i, j, k, temp;
   SplineFont *sli_sf=sf->cidmaster ? sf->cidmaster : sf;

   fpst->type=strnmatch(tok, "ContextPos", 10)==0 ? pst_contextpos :
      strnmatch(tok, "ContextSub", 10)==0 ? pst_contextsub :
      strnmatch(tok, "ChainPos", 8)==0 ? pst_chainpos :
      strnmatch(tok, "ChainSub", 8)==0 ? pst_chainsub : pst_reversesub;
   getname(sfd, tok);
   fpst->format=strmatch(tok, "glyph")==0 ? pst_glyphs :
      strmatch(tok, "class")==0 ? pst_class :
      strmatch(tok, "coverage")==0 ? pst_coverage : pst_reversecoverage;
   if (old) {
      afscanf(sfd, "%hu %hu", &((FPST1 *) fpst)->flags,
	     &((FPST1 *) fpst)->script_lang_index);
      if (((FPST1 *) fpst)->script_lang_index >=
	  ((SplineFont1 *) sli_sf)->sli_cnt
	  && ((FPST1 *) fpst)->script_lang_index != SLI_NESTED) {
	 static int complained=false;

	 if (((SplineFont1 *) sli_sf)->sli_cnt==0)
	    ErrorMsg(2,"'%c%c%c%c' has a script index out of bounds: %d\nYou MUST fix this manually\n",
		(((FPST1 *) fpst)->tag >> 24),
		(((FPST1 *) fpst)->tag >> 16) & 0xff,
		(((FPST1 *) fpst)->tag >> 8) & 0xff,
		((FPST1 *) fpst)->tag & 0xff,
		((FPST1 *) fpst)->script_lang_index);
	 else if (!complained)
	    ErrorMsg(2,"'%c%c%c%c' has a script index out of bounds: %d\n",
		   (((FPST1 *) fpst)->tag >> 24),
		   (((FPST1 *) fpst)->tag >> 16) & 0xff,
		   (((FPST1 *) fpst)->tag >> 8) & 0xff,
		   ((FPST1 *) fpst)->tag & 0xff,
		   ((FPST1 *) fpst)->script_lang_index);
	 else
	    ErrorMsg(2,"'%c%c%c%c' has a script index out of bounds: %d\n",
		   (((FPST1 *) fpst)->tag >> 24),
		   (((FPST1 *) fpst)->tag >> 16) & 0xff,
		   (((FPST1 *) fpst)->tag >> 8) & 0xff,
		   ((FPST1 *) fpst)->tag & 0xff,
		   ((FPST1 *) fpst)->script_lang_index);
	 if (((SplineFont1 *) sli_sf)->sli_cnt != 0)
	    ((FPST1 *) fpst)->script_lang_index =
	       ((SplineFont1 *) sli_sf)->sli_cnt - 1;
	 complained=true;
      }
      while ((ch=nlgetc(sfd))==' ' || ch=='\t');
      if (ch=='\'') {
	 aungetc(ch, sfd);
	 ((FPST1 *) fpst)->tag=gettag(sfd);
      } else
	 aungetc(ch, sfd);
   } else {
      fpst->subtable =
	 SFFindLookupSubtableAndFreeName(sf, SFDReadUTF7Str(sfd));
      if (!fpst->subtable)
	 ErrorMsg(2,"Missing Subtable definition found in chained context\n");
      else
	 fpst->subtable->fpst=fpst;
   }
   afscanf(sfd, "%hu %hu %hu %hu", &fpst->nccnt, &fpst->bccnt, &fpst->fccnt,
	  &fpst->rule_cnt);
   if (fpst->nccnt != 0 || fpst->bccnt != 0 || fpst->fccnt != 0) {
      fpst->nclass=malloc(fpst->nccnt * sizeof(char *));
      fpst->nclassnames=calloc(fpst->nccnt, sizeof(char *));
      if (fpst->nccnt != 0)
	 fpst->nclass[0]=NULL;
      if (fpst->bccnt != 0 || fpst->fccnt != 0) {
	 fpst->bclass=malloc(fpst->bccnt * sizeof(char *));
	 fpst->bclassnames=calloc(fpst->bccnt, sizeof(char *));
	 if (fpst->bccnt != 0)
	    fpst->bclass[0]=NULL;
	 fpst->fclass=malloc(fpst->fccnt * sizeof(char *));
	 fpst->fclassnames=calloc(fpst->fccnt, sizeof(char *));
	 if (fpst->fccnt != 0)
	    fpst->fclass[0]=NULL;
      }
   }

   for (j=0; j < 3; ++j) {
      for (i=1; i < (&fpst->nccnt)[j]; ++i) {
	 getname(sfd, tok);
	 if (i==1 && j==0 && strcmp(tok, "Class0:")==0)
	    i=0;
	 getint(sfd, &temp);
	 (&fpst->nclass)[j][i]=malloc(temp + 1);
	 (&fpst->nclass)[j][i][temp]='\0';
	 nlgetc(sfd);		/* skip space */
	 afread((&fpst->nclass)[j][i], 1, temp, sfd);
      }
   }

   fpst->rules=calloc(fpst->rule_cnt, sizeof(struct fpst_rule));
   for (i=0; i < fpst->rule_cnt; ++i) {
      switch (fpst->format) {
	case pst_glyphs:
	   for (j=0; j < 3; ++j) {
	      getname(sfd, tok);
	      getint(sfd, &temp);
	      (&fpst->rules[i].u.glyph.names)[j]=malloc(temp + 1);
	      (&fpst->rules[i].u.glyph.names)[j][temp]='\0';
	      nlgetc(sfd);	/* skip space */
	      afread((&fpst->rules[i].u.glyph.names)[j], 1, temp, sfd);
	   }
	   break;
	case pst_class:
	   afscanf(sfd, "%d %d %d", &fpst->rules[i].u.class.ncnt,
		  &fpst->rules[i].u.class.bcnt, &fpst->rules[i].u.class.fcnt);
	   for (j=0; j < 3; ++j) {
	      getname(sfd, tok);
	      (&fpst->rules[i].u.class.nclasses)[j] =
		 malloc((&fpst->rules[i].u.class.ncnt)[j] * sizeof(uint16_t));
	      for (k=0; k < (&fpst->rules[i].u.class.ncnt)[j]; ++k) {
		 getusint(sfd, &(&fpst->rules[i].u.class.nclasses)[j][k]);
	      }
	   }
	   break;
	case pst_coverage:
	case pst_reversecoverage:
	   afscanf(sfd, "%d %d %d", &fpst->rules[i].u.coverage.ncnt,
		  &fpst->rules[i].u.coverage.bcnt,
		  &fpst->rules[i].u.coverage.fcnt);
	   for (j=0; j < 3; ++j) {
	      (&fpst->rules[i].u.coverage.ncovers)[j] =
		 malloc((&fpst->rules[i].u.coverage.ncnt)[j] *
			sizeof(char *));
	      for (k=0; k < (&fpst->rules[i].u.coverage.ncnt)[j]; ++k) {
		 getname(sfd, tok);
		 getint(sfd, &temp);
		 (&fpst->rules[i].u.coverage.ncovers)[j][k] =
		    malloc(temp + 1);
		 (&fpst->rules[i].u.coverage.ncovers)[j][k][temp]='\0';
		 nlgetc(sfd);	/* skip space */
		 afread((&fpst->rules[i].u.coverage.ncovers)[j][k], 1, temp,
		       sfd);
	      }
	   }
	   break;
      }
      switch (fpst->format) {
	case pst_glyphs:
	case pst_class:
	case pst_coverage:
	   getint(sfd, &fpst->rules[i].lookup_cnt);
	   fpst->rules[i].lookups =
	      malloc(fpst->rules[i].lookup_cnt * sizeof(struct seqlookup));
	   for (j=k=0; j < fpst->rules[i].lookup_cnt; ++j) {
	      getname(sfd, tok);
	      getint(sfd, &fpst->rules[i].lookups[j].seq);
	      fpst->rules[i].lookups[k].lookup =
		 SFD_ParseNestedLookup(sfd, sf, old);
	      if (fpst->rules[i].lookups[k].lookup != NULL)
		 ++k;
	   }
	   fpst->rules[i].lookup_cnt=k;
	   break;
	case pst_reversecoverage:
	   getname(sfd, tok);
	   getint(sfd, &temp);
	   fpst->rules[i].u.rcoverage.replacements=malloc(temp + 1);
	   fpst->rules[i].u.rcoverage.replacements[temp]='\0';
	   nlgetc(sfd);		/* skip space */
	   afread(fpst->rules[i].u.rcoverage.replacements, 1, temp, sfd);
	   break;
      }
   }
   getname(sfd, tok);		/* EndFPST, or one of the ClassName tokens (in newer sfds) */
   while (strcmp(tok, "ClassNames:")==0 || strcmp(tok, "BClassNames:")==0
	  || strcmp(tok, "FClassNames:")==0) {
      int which =
	 strcmp(tok, "ClassNames:")==0 ? 0 : strcmp(tok,
						      "BClassNames:") ==
	 0 ? 1 : 2;
      int cnt=(&fpst->nccnt)[which];
      char **classnames=(&fpst->nclassnames)[which];
      int i;

      for (i=0; i < cnt; ++i)
	 classnames[i]=SFDReadUTF7Str(sfd);
      getname(sfd, tok);	/* EndFPST, or one of the ClassName tokens (in newer sfds) */
   }

}

static void SFDParseStateMachine(AFILE *sfd,SplineFont *sf,ASM *sm,
				 char *tok, int old) {
   int i, temp;

   sm->type=strnmatch(tok, "MacIndic", 8)==0 ? asm_indic :
      strnmatch(tok, "MacContext", 10)==0 ? asm_context :
      strnmatch(tok, "MacLigature", 11)==0 ? asm_lig :
      strnmatch(tok, "MacSimple", 9)==0 ? asm_simple :
      strnmatch(tok, "MacKern", 7)==0 ? asm_kern : asm_insert;
   if (old) {
      getusint(sfd, &((ASM1 *) sm)->feature);
      nlgetc(sfd);		/* Skip comma */
      getusint(sfd, &((ASM1 *) sm)->setting);
   } else {
      sm->subtable=SFFindLookupSubtableAndFreeName(sf, SFDReadUTF7Str(sfd));
      sm->subtable->sm=sm;
   }
   getusint(sfd, &sm->flags);
   getusint(sfd, &sm->class_cnt);
   getusint(sfd, &sm->state_cnt);

   sm->classes=malloc(sm->class_cnt * sizeof(char *));
   sm->classes[0]=sm->classes[1]=sm->classes[2]=sm->classes[3]=NULL;
   for (i=4; i < sm->class_cnt; ++i) {
      getname(sfd, tok);
      getint(sfd, &temp);
      sm->classes[i]=malloc(temp + 1);
      sm->classes[i][temp]='\0';
      nlgetc(sfd);		/* skip space */
      afread(sm->classes[i], 1, temp, sfd);
   }

   sm->state =
      malloc(sm->class_cnt * sm->state_cnt * sizeof(struct asm_state));
   for (i=0; i < sm->class_cnt * sm->state_cnt; ++i) {
      getusint(sfd, &sm->state[i].next_state);
      getusint(sfd, &sm->state[i].flags);
      if (sm->type==asm_context) {
	 sm->state[i].u.context.mark_lookup =
	    SFD_ParseNestedLookup(sfd, sf, old);
	 sm->state[i].u.context.cur_lookup =
	    SFD_ParseNestedLookup(sfd, sf, old);
      } else if (sm->type==asm_insert) {
	 getint(sfd, &temp);
	 if (temp==0)
	    sm->state[i].u.insert.mark_ins=NULL;
	 else {
	    sm->state[i].u.insert.mark_ins=malloc(temp + 1);
	    sm->state[i].u.insert.mark_ins[temp]='\0';
	    nlgetc(sfd);	/* skip space */
	    afread(sm->state[i].u.insert.mark_ins, 1, temp, sfd);
	 }
	 getint(sfd, &temp);
	 if (temp==0)
	    sm->state[i].u.insert.cur_ins=NULL;
	 else {
	    sm->state[i].u.insert.cur_ins=malloc(temp + 1);
	    sm->state[i].u.insert.cur_ins[temp]='\0';
	    nlgetc(sfd);	/* skip space */
	    afread(sm->state[i].u.insert.cur_ins, 1, temp, sfd);
	 }
      } else if (sm->type==asm_kern) {
	 int j;

	 getint(sfd, &sm->state[i].u.kern.kcnt);
	 if (sm->state[i].u.kern.kcnt != 0)
	    sm->state[i].u.kern.kerns =
	       malloc(sm->state[i].u.kern.kcnt * sizeof(int16_t));
	 for (j=0; j < sm->state[i].u.kern.kcnt; ++j) {
	    getint(sfd, &temp);
	    sm->state[i].u.kern.kerns[j]=temp;
	 }
      }
   }
   getname(sfd, tok);		/* EndASM */
}

static struct macname *SFDParseMacNames(AFILE *sfd,char *tok) {
   struct macname *head=NULL, *last=NULL, *cur;
   int enc, lang, len;
   char *pt;
   int ch;

   while (strcmp(tok, "MacName:")==0) {
      cur=chunkalloc(sizeof(struct macname));
      if (last==NULL)
	 head=cur;
      else
	 last->next=cur;
      last=cur;

      getint(sfd, &enc);
      getint(sfd, &lang);
      getint(sfd, &len);
      cur->enc=enc;
      cur->lang=lang;
      cur->name=pt=malloc(len + 1);

      while ((ch=nlgetc(sfd))==' ');
      if (ch=='"')
	 ch=nlgetc(sfd);
      while (ch != '"' && ch != EOF && pt < cur->name + len) {
	 if (ch=='\\') {
	    *pt=(nlgetc(sfd) - '0') << 6;
	    *pt |= (nlgetc(sfd) - '0') << 3;
	    *pt |= (nlgetc(sfd) - '0');
	 } else
	    *pt++=ch;
	 ch=nlgetc(sfd);
      }
      *pt='\0';
      getname(sfd, tok);
   }
   return (head);
}

static MacFeat *SFDParseMacFeatures(AFILE *sfd,char *tok) {
   MacFeat *cur, *head=NULL, *last=NULL;
   struct macsetting *slast, *scur;
   int feat, ism, def, set;

   while (strcmp(tok, "MacFeat:")==0) {
      cur=chunkalloc(sizeof(MacFeat));
      if (last==NULL)
	 head=cur;
      else
	 last->next=cur;
      last=cur;

      getint(sfd, &feat);
      getint(sfd, &ism);
      getint(sfd, &def);
      cur->feature=feat;
      cur->ismutex=ism;
      cur->default_setting=def;
      getname(sfd, tok);
      cur->featname=SFDParseMacNames(sfd, tok);
      slast=NULL;
      while (strcmp(tok, "MacSetting:")==0) {
	 scur=chunkalloc(sizeof(struct macsetting));
	 if (slast==NULL)
	    cur->settings=scur;
	 else
	    slast->next=scur;
	 slast=scur;

	 getint(sfd, &set);
	 scur->setting=set;
	 getname(sfd, tok);
	 scur->setname=SFDParseMacNames(sfd, tok);
      }
   }
   return (head);
}

static char *SFDParseMMSubroutine(AFILE *sfd) {
   char buffer[400], *sofar=calloc(1, 1);
   const char *endtok="EndMMSubroutine";
   int len=0, blen, first=true;

   while (afgets(buffer, sizeof(buffer), sfd) != NULL) {
      if (strncmp(buffer, endtok, strlen(endtok))==0)
	 break;
      if (first) {
	 first=false;
	 if (strcmp(buffer, "\n")==0)
	    continue;
      }
      blen=strlen(buffer);
      sofar=realloc(sofar, len + blen + 1);
      strcpy(sofar + len, buffer);
      len += blen;
   }
   if (len > 0 && sofar[len - 1]=='\n')
      sofar[len - 1]='\0';
   return (sofar);
}

static void MMInferStuff(MMSet *mm) {
   int i, j;

   if (mm==NULL)
      return;
   if (mm->apple) {
      for (i=0; i < mm->axis_count; ++i) {
	 for (j=0; j < mm->axismaps[i].points; ++j) {
	    double val=mm->axismaps[i].blends[j];

	    if (val==-1.)
	       mm->axismaps[i].min=mm->axismaps[i].designs[j];
	    else if (val==0)
	       mm->axismaps[i].def=mm->axismaps[i].designs[j];
	    else if (val==1)
	       mm->axismaps[i].max=mm->axismaps[i].designs[j];
	 }
      }
   }
}

static void SFDSizeMap(EncMap *map,int glyphcnt,int enccnt) {
   if (glyphcnt > map->backmax) {
      map->backmap=realloc(map->backmap, glyphcnt * sizeof(int));
      memset(map->backmap + map->backmax, -1,
	     (glyphcnt - map->backmax) * sizeof(int));
      map->backmax=glyphcnt;
   }
   if (enccnt > map->encmax) {
      map->map=realloc(map->map, enccnt * sizeof(int));
      memset(map->map + map->backmax, -1,
	     (enccnt - map->encmax) * sizeof(int));
      map->encmax=map->enccount=enccnt;
   }
}

static void SFD_DoAltUnis(SplineFont *sf) {
   int i;
   struct altuni *alt;
   SplineChar *sc;

   for (i=0; i < sf->glyphcnt; ++i)
      if ((sc=sf->glyphs[i]) != NULL) {
	 for (alt=sc->altuni; alt != NULL; alt=alt->next) {
	    if (alt->vs==-1 && alt->fid==0) {
	       int enc=EncFromUni(alt->unienc, sf->map->enc);

	       if (enc != -1)
		  SFDSetEncMap(sf, sc->orig_pos, enc);
	    }
	 }
      }
}

static void SFDParseLookup(AFILE *sfd,SplineFont *sf,OTLookup *otl) {
   int ch;
   struct lookup_subtable *sub, *lastsub;
   FeatureScriptLangList *fl, *lastfl;
   struct scriptlanglist *sl, *lastsl;
   int i, lcnt, lmax=0;
   uint32_t *langs=NULL;
   char *subname;

   while ((ch=nlgetc(sfd))==' ');
   if (ch=='{') {
      lastsub=NULL;
      while ((subname=SFDReadUTF7Str(sfd)) != NULL) {
	 while ((ch=nlgetc(sfd))==' ');
	 aungetc(ch, sfd);
	 sub=chunkalloc(sizeof(struct lookup_subtable));
	 sub->subtable_name=subname;
	 sub->lookup=otl;
	 switch (otl->lookup_type) {
	   case gsub_single:
	      while ((ch=nlgetc(sfd))==' ');
	      if (ch=='(') {
		 sub->suffix=SFDReadUTF7Str(sfd);
		 while ((ch=nlgetc(sfd))==' ');
		 /* slurp final paren */
	      } else
		 aungetc(ch, sfd);
	      sub->per_glyph_pst_or_kern=true;
	      break;
	   case gsub_multiple:
	   case gsub_alternate:
	   case gsub_ligature:
	   case gpos_single:
	      sub->per_glyph_pst_or_kern=true;
	      break;
	   case gpos_pair:
	      if ((ch=nlgetc(sfd))=='(') {
		 ch=nlgetc(sfd);
		 sub->vertical_kerning=(ch=='1');
		 nlgetc(sfd);	/* slurp final paren */
		 ch=nlgetc(sfd);
	      }
	      if (ch=='[') {
		 getsint(sfd, &sub->separation);
		 nlgetc(sfd);	/* slurp comma */
		 getsint(sfd, &sub->minkern);
		 nlgetc(sfd);	/* slurp comma */
		 ch=nlgetc(sfd);
		 sub->kerning_by_touch=((ch - '0') & 1) ? 1 : 0;
		 sub->onlyCloser=((ch - '0') & 2) ? 1 : 0;
		 sub->dontautokern=((ch - '0') & 4) ? 1 : 0;
		 nlgetc(sfd);	/* slurp final bracket */
	      } else {
		 aungetc(ch, sfd);
	      }
	      sub->per_glyph_pst_or_kern=true;
	      break;
	   case gpos_cursive:
	   case gpos_mark2base:
	   case gpos_mark2ligature:
	   case gpos_mark2mark:
	      sub->anchor_classes=true;
	      break;
	 }
	 if (lastsub==NULL)
	    otl->subtables=sub;
	 else
	    lastsub->next=sub;
	 lastsub=sub;
      }
      while ((ch=nlgetc(sfd))==' ');
      if (ch=='}')
	 ch=nlgetc(sfd);
   }
   while (ch==' ')
      ch=nlgetc(sfd);
   if (ch=='[') {
      lastfl=NULL;
      while (1) {
	 while ((ch=nlgetc(sfd))==' ');
	 if (ch==']')
	    break;
	 fl=chunkalloc(sizeof(FeatureScriptLangList));
	 if (lastfl==NULL)
	    otl->features=fl;
	 else
	    lastfl->next=fl;
	 lastfl=fl;
	 if (ch=='<') {
	    int ft=0, fs=0;

	    afscanf(sfd, "%d,%d>", &ft, &fs);
	    fl->ismac=true;
	    fl->featuretag=(ft << 16) | fs;
	 } else if (ch=='\'') {
	    aungetc(ch, sfd);
	    fl->featuretag=gettag(sfd);
	 }
	 while ((ch=nlgetc(sfd))==' ');
	 if (ch=='(') {
	    lastsl=NULL;
	    while (1) {
	       while ((ch=nlgetc(sfd))==' ');
	       if (ch==')')
		  break;
	       sl=chunkalloc(sizeof(struct scriptlanglist));
	       if (lastsl==NULL)
		  fl->scripts=sl;
	       else
		  lastsl->next=sl;
	       lastsl=sl;
	       if (ch=='\'') {
		  aungetc(ch, sfd);
		  sl->script=gettag(sfd);
	       }
	       while ((ch=nlgetc(sfd))==' ');
	       if (ch=='<') {
		  lcnt=0;
		  while (1) {
		     while ((ch=nlgetc(sfd))==' ');
		     if (ch=='>')
			break;
		     if (ch=='\'') {
			aungetc(ch, sfd);
			if (lcnt >= lmax)
			   langs =
			      realloc(langs, (lmax += 10) * sizeof(uint32_t));
			langs[lcnt++]=gettag(sfd);
		     }
		  }
		  sl->lang_cnt=lcnt;
		  if (lcnt > MAX_LANG)
		     sl->morelangs =
			malloc((lcnt - MAX_LANG) * sizeof(uint32_t));
		  for (i=0; i < lcnt; ++i) {
		     if (i < MAX_LANG)
			sl->langs[i]=langs[i];
		     else
			sl->morelangs[i - MAX_LANG]=langs[i];
		  }
	       }
	    }
	 }
      }
   }
   free(langs);
}

static void SFDParseMathItem(AFILE *sfd,SplineFont *sf,char *tok) {
   /* The first five characters of a math item's keyword will be "MATH:" */
   /*  the rest will be one of the entries in math_constants_descriptor */
   int i;
   struct MATH *math;

   if ((math=sf->MATH)==NULL)
      math=sf->MATH=calloc(1, sizeof(struct MATH));
   for (i=0; math_constants_descriptor[i].script_name != NULL; ++i) {
      char *name=math_constants_descriptor[i].script_name;
      int len=strlen(name);

      if (strncmp(tok + 5, name, len)==0 && tok[5 + len]==':'
	  && tok[6 + len]=='\0') {
	 int16_t *pos =
	    (int16_t *) (((char *) (math)) +
		       math_constants_descriptor[i].offset);
	 getsint(sfd, pos);
	 if (math_constants_descriptor[i].devtab_offset != -1) {
	    DeviceTable **devtab =
	       (DeviceTable **) (((char *) (math)) +
				 math_constants_descriptor[i].devtab_offset);
	    *devtab=SFDReadDeviceTable(sfd, *devtab);
	    break;
	 }
      }
   }
}

static struct baselangextent *ParseBaseLang(AFILE *sfd) {
   struct baselangextent *bl;
   struct baselangextent *cur, *last;
   int ch;

   while ((ch=nlgetc(sfd))==' ');
   if (ch=='{') {
      bl=chunkalloc(sizeof(struct baselangextent));
      while ((ch=nlgetc(sfd))==' ');
      aungetc(ch, sfd);
      if (ch=='\'')
	 bl->lang=gettag(sfd);	/* Lang or Feature tag, or nothing */
      getsint(sfd, &bl->descent);
      getsint(sfd, &bl->ascent);
      last=NULL;
      while ((ch=nlgetc(sfd))==' ');
      while (ch=='{') {
	 aungetc(ch, sfd);
	 cur=ParseBaseLang(sfd);
	 if (last==NULL)
	    bl->features=cur;
	 else
	    last->next=cur;
	 last=cur;
	 while ((ch=nlgetc(sfd))==' ');
      }
      if (ch != '}')
	 aungetc(ch, sfd);
      return (bl);
   }
   return (NULL);
}

static struct basescript *SFDParseBaseScript(AFILE *sfd,struct Base *base,
					     char *tok) {
   struct basescript *bs;
   int i, ch;
   struct baselangextent *last, *cur;

   if (base==NULL)
      return (NULL);

   bs=chunkalloc(sizeof(struct basescript));

   bs->script=gettag(sfd);
   getint(sfd, &bs->def_baseline);
   if (base->baseline_cnt != 0) {
      bs->baseline_pos=calloc(base->baseline_cnt, sizeof(int16_t));
      for (i=0; i < base->baseline_cnt; ++i)
	 getsint(sfd, &bs->baseline_pos[i]);
   }
   while ((ch=nlgetc(sfd))==' ');
   last=NULL;
   while (ch=='{') {
      aungetc(ch, sfd);
      cur=ParseBaseLang(sfd);
      if (last==NULL)
	 bs->langs=cur;
      else
	 last->next=cur;
      last=cur;
      while ((ch=nlgetc(sfd))==' ');
   }
   return (bs);
}

static struct Base *SFDParseBase(AFILE *sfd) {
   struct Base *base=chunkalloc(sizeof(struct Base));
   int i;

   getint(sfd, &base->baseline_cnt);
   if (base->baseline_cnt != 0) {
      base->baseline_tags=malloc(base->baseline_cnt * sizeof(uint32_t));
      for (i=0; i < base->baseline_cnt; ++i)
	 base->baseline_tags[i]=gettag(sfd);
   }
   return (base);
}

static OTLookup **SFDLookupList(AFILE *sfd,SplineFont *sf) {
   int ch;
   OTLookup *space[100], **buf=space, *otl, **ret;
   int lcnt=0, lmax=100;
   char *name;

   while (1) {
      while ((ch=nlgetc(sfd))==' ');
      if (ch=='\n' || ch==EOF)
	 break;
      aungetc(ch, sfd);
      name=SFDReadUTF7Str(sfd);
      otl=SFFindLookup(sf, name);
      free(name);
      if (otl != NULL) {
	 if (lcnt > lmax) {
	    if (buf==space) {
	       buf=malloc((lmax=lcnt + 50) * sizeof(OTLookup *));
	       memcpy(buf, space, sizeof(space));
	    } else
	       buf=realloc(buf, (lmax += 50) * sizeof(OTLookup *));
	 }
	 buf[lcnt++]=otl;
      }
   }
   if (lcnt==0)
      return (NULL);

   ret=malloc((lcnt + 1) * sizeof(OTLookup *));
   memcpy(ret, buf, lcnt * sizeof(OTLookup *));
   ret[lcnt]=NULL;
   return (ret);
}

static void SFDParseJustify(AFILE *sfd,SplineFont *sf,char *tok) {
   Justify *last=NULL, *cur;
   struct jstf_lang *jlang, *llast;
   int p, ch;

   while (strcmp(tok, "Justify:")==0) {
      cur=chunkalloc(sizeof(Justify));
      if (last==NULL)
	 sf->justify=cur;
      else
	 last->next=cur;
      last=cur;
      llast=jlang=NULL;
      cur->script=gettag(sfd);
      while (getname(sfd, tok) > 0) {
	 if (strcmp(tok, "Justify:")==0 || strcmp(tok, "EndJustify")==0)
	    break;
	 if (strcmp(tok, "JstfExtender:")==0) {
	    while ((ch=nlgetc(sfd))==' ');
	    aungetc(ch, sfd);
	    geteol(sfd, tok);
	    cur->extenders=fastrdup(tok);
	 } else if (strcmp(tok, "JstfLang:")==0) {
	    jlang=chunkalloc(sizeof(struct jstf_lang));
	    if (llast==NULL)
	       cur->langs=jlang;
	    else
	       llast->next=jlang;
	    llast=jlang;
	    jlang->lang=gettag(sfd);
	    p=-1;
	    getint(sfd, &jlang->cnt);
	    if (jlang->cnt != 0)
	       jlang->prios=calloc(jlang->cnt, sizeof(struct jstf_prio));
	 } else if (strcmp(tok, "JstfPrio:")==0) {
	    if (jlang != NULL) {
	       ++p;
	       if (p >= jlang->cnt) {
		  jlang->prios =
		     realloc(jlang->prios,
			     (p + 1) * sizeof(struct jstf_prio));
		  memset(jlang->prios + jlang->cnt, 0,
			 (p + 1 - jlang->cnt) * sizeof(struct jstf_prio));
		  jlang->cnt=p + 1;
	       }
	    }
	 } else if (strcmp(tok, "JstfEnableShrink:")==0) {
	    if (p < 0)
	       p=0;
	    if (jlang != NULL && p < jlang->cnt)
	       jlang->prios[p].enableShrink=SFDLookupList(sfd, sf);
	 } else if (strcmp(tok, "JstfDisableShrink:")==0) {
	    if (p < 0)
	       p=0;
	    if (jlang != NULL && p < jlang->cnt)
	       jlang->prios[p].disableShrink=SFDLookupList(sfd, sf);
	 } else if (strcmp(tok, "JstfMaxShrink:")==0) {
	    if (p < 0)
	       p=0;
	    if (jlang != NULL && p < jlang->cnt)
	       jlang->prios[p].maxShrink=SFDLookupList(sfd, sf);
	 } else if (strcmp(tok, "JstfEnableExtend:")==0) {
	    if (p < 0)
	       p=0;
	    if (jlang != NULL && p < jlang->cnt)
	       jlang->prios[p].enableExtend=SFDLookupList(sfd, sf);
	 } else if (strcmp(tok, "JstfDisableExtend:")==0) {
	    if (p < 0)
	       p=0;
	    if (jlang != NULL && p < jlang->cnt)
	       jlang->prios[p].disableExtend=SFDLookupList(sfd, sf);
	 } else if (strcmp(tok, "JstfMaxExtend:")==0) {
	    if (p < 0)
	       p=0;
	    if (jlang != NULL && p < jlang->cnt)
	       jlang->prios[p].maxExtend=SFDLookupList(sfd, sf);
	 } else
	    geteol(sfd, tok);
      }
   }
}



static void SFD_GetFontMetaDataData_Init(SFD_GetFontMetaDataData *d) {
   memset(d, 0, sizeof(SFD_GetFontMetaDataData));
}

/**
 *
 * @return true if the function matched the current token. If true
 *         is returned the caller should avoid further processing of 'tok'
 *         a return of false means that the caller might try
 *         to handle the token with another function or drop it.
 */
static int SFD_GetFontMetaData(AFILE *sfd,
			 char *tok,
			 SplineFont *sf, SFD_GetFontMetaDataData * d) {
   int ch;
   int i;
   KernClass *kc=0;
   int old;
   char val[2000];

   // This allows us to assume we can dereference d
   // at all times
   static SFD_GetFontMetaDataData my_static_d;
   static int my_static_d_is_virgin=1;

   if (!d) {
      if (my_static_d_is_virgin) {
	 my_static_d_is_virgin=0;
	 SFD_GetFontMetaDataData_Init(&my_static_d);
      }
      d=&my_static_d;
   }

   if (strmatch(tok, "FontName:")==0) {
      geteol(sfd, val);
      sf->fontname=fastrdup(val);
   } else if (strmatch(tok, "FullName:")==0) {
      geteol(sfd, val);
      sf->fullname=fastrdup(val);
   } else if (strmatch(tok, "FamilyName:")==0) {
      geteol(sfd, val);
      sf->familyname=fastrdup(val);
   } else if (strmatch(tok, "DefaultBaseFilename:")==0) {
      geteol(sfd, val);
      sf->defbasefilename=fastrdup(val);
   } else if (strmatch(tok, "Weight:")==0) {
      getprotectedname(sfd, val);
      sf->weight=fastrdup(val);
   } else if (strmatch(tok, "Copyright:")==0) {
      sf->copyright=getquotedeol(sfd);
   } else if (strmatch(tok, "Comments:")==0) {
      char *temp=getquotedeol(sfd);

      sf->comments=latin1_2_utf8_copy(temp);
      free(temp);
   } else if (strmatch(tok, "UComments:")==0) {
      sf->comments=SFDReadUTF7Str(sfd);
   } else if (strmatch(tok, "FontLog:")==0) {
      sf->fontlog=SFDReadUTF7Str(sfd);
   } else if (strmatch(tok, "Version:")==0) {
      geteol(sfd, val);
      sf->version=fastrdup(val);
   } else if (strmatch(tok, "FONDName:")==0) {
      geteol(sfd, val);
      sf->fondname=fastrdup(val);
   } else if (strmatch(tok, "ItalicAngle:")==0) {
      getreal(sfd, &sf->italicangle);
   } else if (strmatch(tok, "StrokeWidth:")==0) {
      getreal(sfd, &sf->strokewidth);
   } else if (strmatch(tok, "UnderlinePosition:")==0) {
      getreal(sfd, &sf->upos);
   } else if (strmatch(tok, "UnderlineWidth:")==0) {
      getreal(sfd, &sf->uwidth);
   } else if (strmatch(tok, "ModificationTime:")==0) {
      getlonglong(sfd, &sf->modificationtime);
   } else if (strmatch(tok, "CreationTime:")==0) {
      getlonglong(sfd, &sf->creationtime);
      d->hadtimes=true;
   } else if (strmatch(tok, "PfmFamily:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.pfmfamily=temp;
      sf->pfminfo.pfmset=true;
   } else if (strmatch(tok, "LangName:")==0) {
      sf->names=SFDGetLangName(sfd, sf->names);
   } else if (strmatch(tok, "GaspTable:")==0) {
      SFDGetGasp(sfd, sf);
   } else if (strmatch(tok, "DesignSize:")==0) {
      SFDGetDesignSize(sfd, sf);
   } else if (strmatch(tok, "OtfFeatName:")==0) {
      SFDGetOtfFeatName(sfd, sf);
   } else if (strmatch(tok, "PfmWeight:")==0
	      || strmatch(tok, "TTFWeight:")==0) {
      getsint(sfd, &sf->pfminfo.weight);
      sf->pfminfo.pfmset=true;
   } else if (strmatch(tok, "TTFWidth:")==0) {
      getsint(sfd, &sf->pfminfo.width);
      sf->pfminfo.pfmset=true;
   } else if (strmatch(tok, "Panose:")==0) {
      int temp, i;

      for (i=0; i < 10; ++i) {
	 getint(sfd, &temp);
	 sf->pfminfo.panose[i]=temp;
      }
      sf->pfminfo.panose_set=true;
   } else if (strmatch(tok, "LineGap:")==0) {
      getsint(sfd, &sf->pfminfo.linegap);
      sf->pfminfo.pfmset=true;
   } else if (strmatch(tok, "VLineGap:")==0) {
      getsint(sfd, &sf->pfminfo.vlinegap);
      sf->pfminfo.pfmset=true;
   } else if (strmatch(tok, "HheadAscent:")==0) {
      getsint(sfd, &sf->pfminfo.hhead_ascent);
   } else if (strmatch(tok, "HheadAOffset:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.hheadascent_add=temp;
   } else if (strmatch(tok, "HheadDescent:")==0) {
      getsint(sfd, &sf->pfminfo.hhead_descent);
   } else if (strmatch(tok, "HheadDOffset:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.hheaddescent_add=temp;
   } else if (strmatch(tok, "OS2TypoLinegap:")==0) {
      getsint(sfd, &sf->pfminfo.os2_typolinegap);
   } else if (strmatch(tok, "OS2TypoAscent:")==0) {
      getsint(sfd, &sf->pfminfo.os2_typoascent);
   } else if (strmatch(tok, "OS2TypoAOffset:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.typoascent_add=temp;
   } else if (strmatch(tok, "OS2TypoDescent:")==0) {
      getsint(sfd, &sf->pfminfo.os2_typodescent);
   } else if (strmatch(tok, "OS2TypoDOffset:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.typodescent_add=temp;
   } else if (strmatch(tok, "OS2WinAscent:")==0) {
      getsint(sfd, &sf->pfminfo.os2_winascent);
   } else if (strmatch(tok, "OS2WinDescent:")==0) {
      getsint(sfd, &sf->pfminfo.os2_windescent);
   } else if (strmatch(tok, "OS2WinAOffset:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.winascent_add=temp;
   } else if (strmatch(tok, "OS2WinDOffset:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.windescent_add=temp;
   } else if (strmatch(tok, "HHeadAscent:")==0) {
      // DUPLICATE OF ABOVE
      getsint(sfd, &sf->pfminfo.hhead_ascent);
   } else if (strmatch(tok, "HHeadDescent:")==0) {
      // DUPLICATE OF ABOVE
      getsint(sfd, &sf->pfminfo.hhead_descent);
   }
   else if (strmatch(tok, "HHeadAOffset:")==0) {
      // DUPLICATE OF ABOVE
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.hheadascent_add=temp;
   } else if (strmatch(tok, "HHeadDOffset:")==0) {
      // DUPLICATE OF ABOVE
      int temp;

      getint(sfd, &temp);
      sf->pfminfo.hheaddescent_add=temp;
   } else if (strmatch(tok, "MacStyle:")==0) {
      getsint(sfd, &sf->macstyle);
   } else if (strmatch(tok, "OS2SubXSize:")==0) {
      getsint(sfd, &sf->pfminfo.os2_subxsize);
      sf->pfminfo.subsuper_set=true;
   } else if (strmatch(tok, "OS2SubYSize:")==0) {
      getsint(sfd, &sf->pfminfo.os2_subysize);
   } else if (strmatch(tok, "OS2SubXOff:")==0) {
      getsint(sfd, &sf->pfminfo.os2_subxoff);
   } else if (strmatch(tok, "OS2SubYOff:")==0) {
      getsint(sfd, &sf->pfminfo.os2_subyoff);
   } else if (strmatch(tok, "OS2SupXSize:")==0) {
      getsint(sfd, &sf->pfminfo.os2_supxsize);
   } else if (strmatch(tok, "OS2SupYSize:")==0) {
      getsint(sfd, &sf->pfminfo.os2_supysize);
   } else if (strmatch(tok, "OS2SupXOff:")==0) {
      getsint(sfd, &sf->pfminfo.os2_supxoff);
   } else if (strmatch(tok, "OS2SupYOff:")==0) {
      getsint(sfd, &sf->pfminfo.os2_supyoff);
   } else if (strmatch(tok, "OS2StrikeYSize:")==0) {
      getsint(sfd, &sf->pfminfo.os2_strikeysize);
   } else if (strmatch(tok, "OS2StrikeYPos:")==0) {
      getsint(sfd, &sf->pfminfo.os2_strikeypos);
   } else if (strmatch(tok, "OS2FamilyClass:")==0) {
      getsint(sfd, &sf->pfminfo.os2_family_class);
   } else if (strmatch(tok, "OS2Vendor:")==0) {
      while (isspace(nlgetc(sfd)));
      sf->pfminfo.os2_vendor[0]=nlgetc(sfd);
      sf->pfminfo.os2_vendor[1]=nlgetc(sfd);
      sf->pfminfo.os2_vendor[2]=nlgetc(sfd);
      sf->pfminfo.os2_vendor[3]=nlgetc(sfd);
      (void) nlgetc(sfd);
   } else if (strmatch(tok, "OS2CodePages:")==0) {
      gethexints(sfd, sf->pfminfo.codepages, 2);
      sf->pfminfo.hascodepages=true;
   } else if (strmatch(tok, "OS2UnicodeRanges:")==0) {
      gethexints(sfd, sf->pfminfo.unicoderanges, 4);
      sf->pfminfo.hasunicoderanges=true;
   } else if (strmatch(tok, "TopEncoding:")==0) {
      /* Obsolete */
      getint(sfd, &sf->top_enc);
   } else if (strmatch(tok, "Ascent:")==0) {
      getint(sfd, &sf->ascent);
   } else if (strmatch(tok, "Descent:")==0) {
      getint(sfd, &sf->descent);
   } else if (strmatch(tok, "woffMajor:")==0) {
      getint(sfd, &sf->woffMajor);
   } else if (strmatch(tok, "woffMinor:")==0) {
      getint(sfd, &sf->woffMinor);
   } else if (strmatch(tok, "woffMetadata:")==0) {
      sf->woffMetadata=SFDReadUTF7Str(sfd);
   } else if (strmatch(tok, "UFOAscent:")==0) {
      getreal(sfd, &sf->ufo_ascent);
   } else if (strmatch(tok, "UFODescent:")==0) {
      getreal(sfd, &sf->ufo_descent);
   } else if (strmatch(tok, "sfntRevision:")==0) {
      gethex(sfd, &sf->sfntRevision);
   } else if (strmatch(tok, "LayerCount:")==0) {
      d->had_layer_cnt=true;
      getint(sfd, &sf->layer_cnt);
      if (sf->layer_cnt > 2) {
	 sf->layers=realloc(sf->layers, sf->layer_cnt * sizeof(LayerInfo));
	 memset(sf->layers + 2, 0, (sf->layer_cnt - 2) * sizeof(LayerInfo));
      }
   } else if (strmatch(tok, "Layer:")==0) {
      int layer, o2, bk;

      getint(sfd, &layer);
      if (layer >= sf->layer_cnt) {
	 sf->layers=realloc(sf->layers, (layer + 1) * sizeof(LayerInfo));
	 memset(sf->layers + sf->layer_cnt, 0,
		((layer + 1) - sf->layer_cnt) * sizeof(LayerInfo));
	 sf->layer_cnt=layer + 1;
      }
      getint(sfd, &o2);
      sf->layers[layer].order2=o2;
      sf->layers[layer].background=layer==ly_back;
      /* Used briefly, now background is after layer name */
      while ((ch=nlgetc(sfd))==' ');
      aungetc(ch, sfd);
      if (ch != '"') {
	 getint(sfd, &bk);
	 sf->layers[layer].background=bk;
      }
      /* end of section for obsolete format */
      sf->layers[layer].name=SFDReadUTF7Str(sfd);
      while ((ch=nlgetc(sfd))==' ');
      aungetc(ch, sfd);
      if (ch != '\n') {
	 getint(sfd, &bk);
	 sf->layers[layer].background=bk;
      }
   } else if (strmatch(tok, "StrokedFont:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->strokedfont=temp;
   } else if (strmatch(tok, "MultiLayer:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->multilayer=temp;
   } else if (strmatch(tok, "NeedsXUIDChange:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->changed_since_xuidchanged=temp;
   } else if (strmatch(tok, "VerticalOrigin:")==0) {
      // this doesn't seem to be written ever.
      int temp;

      getint(sfd, &temp);
      sf->hasvmetrics=true;
   } else if (strmatch(tok, "HasVMetrics:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->hasvmetrics=temp;
   } else if (strmatch(tok, "Justify:")==0) {
      SFDParseJustify(sfd, sf, tok);
   } else if (strmatch(tok, "BaseHoriz:")==0) {
      sf->horiz_base=SFDParseBase(sfd);
      d->last_base=sf->horiz_base;
      d->last_base_script=NULL;
   } else if (strmatch(tok, "BaseVert:")==0) {
      sf->vert_base=SFDParseBase(sfd);
      d->last_base=sf->vert_base;
      d->last_base_script=NULL;
   } else if (strmatch(tok, "BaseScript:")==0) {
      struct basescript *bs=SFDParseBaseScript(sfd, d->last_base, tok);

      if (d->last_base==NULL) {
	 BaseScriptFree(bs);
	 bs=NULL;
      } else if (d->last_base_script != NULL)
	 d->last_base_script->next=bs;
      else
	 d->last_base->scripts=bs;
      d->last_base_script=bs;
   } else if (strmatch(tok, "FSType:")==0) {
      getsint(sfd, &sf->pfminfo.fstype);
   } else if (strmatch(tok, "OS2Version:")==0) {
      getsint(sfd, &sf->os2_version);
   } else if (strmatch(tok, "OS2_WeightWidthSlopeOnly:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->weight_width_slope_only=temp;
   } else if (strmatch(tok, "OS2_UseTypoMetrics:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->use_typo_metrics=temp;
   } else if (strmatch(tok, "UseUniqueID:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->use_uniqueid=temp;
   } else if (strmatch(tok, "UseXUID:")==0) {
      int temp;

      getint(sfd, &temp);
      sf->use_xuid=temp;
   } else if (strmatch(tok, "UniqueID:")==0) {
      getint(sfd, &sf->uniqueid);
   } else if (strmatch(tok, "XUID:")==0) {
      geteol(sfd, tok);
      sf->xuid=fastrdup(tok);
   } else if (strmatch(tok, "Lookup:")==0) {
      OTLookup *otl;
      int temp;

      if (sf->sfd_version < 2) {
	 ErrorMsg(3,"Lookups should not happen in version 1 sfd files.\n");
	 exit(1);
      }
      otl=chunkalloc(sizeof(OTLookup));
      getint(sfd, &temp);
      otl->lookup_type=temp;
      getint(sfd, &temp);
      otl->lookup_flags=temp;
      getint(sfd, &temp);
      otl->store_in_afm=temp;
      otl->lookup_name=SFDReadUTF7Str(sfd);
      if (d->lastsotl==NULL)
	sf->gsplookups[(otl->lookup_type<gpos_single)?0:1]=otl;
      else
	d->lastsotl->next=otl;
      d->lastsotl=otl;
      SFDParseLookup(sfd, sf, otl);
   } else if (strmatch(tok, "MarkAttachClasses:")==0) {
      getint(sfd, &sf->mark_class_cnt);
      sf->mark_classes=malloc(sf->mark_class_cnt * sizeof(char *));
      sf->mark_class_names=malloc(sf->mark_class_cnt * sizeof(char *));
      sf->mark_classes[0]=NULL;
      sf->mark_class_names[0]=NULL;
      for (i=1; i < sf->mark_class_cnt; ++i) {
	 /* Class 0 is unused */
	 int temp;

	 while ((temp=nlgetc(sfd))=='\n' || temp=='\r');
	 aungetc(temp, sfd);
	 sf->mark_class_names[i]=SFDReadUTF7Str(sfd);
	 getint(sfd, &temp);
	 sf->mark_classes[i]=malloc(temp + 1);
	 sf->mark_classes[i][temp]='\0';
	 nlgetc(sfd);		/* skip space */
	 afread(sf->mark_classes[i], 1, temp, sfd);
      }
   } else if (strmatch(tok, "MarkAttachSets:")==0) {
      getint(sfd, &sf->mark_set_cnt);
      sf->mark_sets=malloc(sf->mark_set_cnt * sizeof(char *));
      sf->mark_set_names=malloc(sf->mark_set_cnt * sizeof(char *));
      for (i=0; i < sf->mark_set_cnt; ++i) {
	 /* Set 0 is used */
	 int temp;

	 while ((temp=nlgetc(sfd))=='\n' || temp=='\r');
	 aungetc(temp, sfd);
	 sf->mark_set_names[i]=SFDReadUTF7Str(sfd);
	 getint(sfd, &temp);
	 sf->mark_sets[i]=malloc(temp + 1);
	 sf->mark_sets[i][temp]='\0';
	 nlgetc(sfd);		/* skip space */
	 afread(sf->mark_sets[i], 1, temp, sfd);
      }
   } else if (strmatch(tok, "KernClass2:")==0
	      || strmatch(tok, "VKernClass2:")==0
	      || strmatch(tok, "KernClass:")==0
	      || strmatch(tok, "VKernClass:")==0) {
      int temp, classstart=1;
      int isv=tok[0]=='V';
      int old=strchr(tok, '2')==NULL;

      if ((sf->sfd_version < 2) != old) {
	 ErrorMsg(3,"Version mixup in Kerning Classes of sfd file.\n");
	 exit(1);
      }
      kc=chunkalloc(old ? sizeof(KernClass1) : sizeof(KernClass));
      getint(sfd, &kc->first_cnt);
      ch=nlgetc(sfd);
      if (ch=='+')
	 classstart=0;
      else
	 aungetc(ch, sfd);
      getint(sfd, &kc->second_cnt);
      if (old) {
	 getint(sfd, &temp);
	 ((KernClass1 *) kc)->sli=temp;
	 getint(sfd, &temp);
	 ((KernClass1 *) kc)->flags=temp;
      } else {
	 kc->subtable =
	    SFFindLookupSubtableAndFreeName(sf, SFDReadUTF7Str(sfd));
	 if (kc->subtable != NULL && kc->subtable->kc==NULL)
	    kc->subtable->kc=kc;
	 else {
	    if (kc->subtable==NULL)
	       ErrorMsg(2,"Bad SFD file, missing subtable in kernclass defn.\n");
	    else
	       ErrorMsg(2,"Bad SFD file, two kerning classes assigned to the same subtable: %s\n",
			kc->subtable->subtable_name);
	    kc->subtable=NULL;
	 }
      }
      kc->firsts=malloc(kc->first_cnt * sizeof(char *));
      kc->seconds=malloc(kc->second_cnt * sizeof(char *));
      kc->offsets=malloc(kc->first_cnt * kc->second_cnt * sizeof(int16_t));
      kc->adjusts =
	 calloc(kc->first_cnt * kc->second_cnt, sizeof(DeviceTable));
      kc->firsts[0]=NULL;
      for (i=classstart; i < kc->first_cnt; ++i) {
	 getint(sfd, &temp);
	 kc->firsts[i]=malloc(temp + 1);
	 kc->firsts[i][temp]='\0';
	 nlgetc(sfd);		/* skip space */
	 afread(kc->firsts[i], 1, temp, sfd);
      }
      kc->seconds[0]=NULL;
      for (i=1; i < kc->second_cnt; ++i) {
	 getint(sfd, &temp);
	 kc->seconds[i]=malloc(temp + 1);
	 kc->seconds[i][temp]='\0';
	 nlgetc(sfd);		/* skip space */
	 afread(kc->seconds[i], 1, temp, sfd);
      }
      for (i=0; i < kc->first_cnt * kc->second_cnt; ++i) {
	 getint(sfd, &temp);
	 kc->offsets[i]=temp;
	 SFDReadDeviceTable(sfd, &kc->adjusts[i]);
      }
      if (!old && kc->subtable==NULL) {
	 /* Error. Ignore it. Free it. Whatever */ ;
      } else if (!isv) {
	 if (d->lastkc==NULL)
	    sf->kerns=kc;
	 else
	    d->lastkc->next=kc;
	 d->lastkc=kc;
      } else {
	 if (d->lastvkc==NULL)
	    sf->vkerns=kc;
	 else
	    d->lastvkc->next=kc;
	 d->lastvkc=kc;
      }
   } else if (strmatch(tok, "ContextPos2:")==0
	      || strmatch(tok, "ContextSub2:")==0
	      || strmatch(tok, "ChainPos2:")==0
	      || strmatch(tok, "ChainSub2:")==0
	      || strmatch(tok, "ReverseChain2:")==0
	      || strmatch(tok, "ContextPos:")==0
	      || strmatch(tok, "ContextSub:")==0
	      || strmatch(tok, "ChainPos:")==0
	      || strmatch(tok, "ChainSub:")==0
	      || strmatch(tok, "ReverseChain:")==0) {
      FPST *fpst;
      int old;

      if (strchr(tok, '2') != NULL) {
	 old=false;
	 fpst=chunkalloc(sizeof(FPST));
      } else {
	 old=true;
	 fpst=chunkalloc(sizeof(FPST1));
      }
      if ((sf->sfd_version < 2) != old) {
	 ErrorMsg(3,"Version mixup in FPST of sfd file.\n");
	 exit(1);
      }
      if (d->lastfp==NULL)
	 sf->possub=fpst;
      else
	 d->lastfp->next=fpst;
      d->lastfp=fpst;
      SFDParseChainContext(sfd, sf, fpst, tok, old);
   } else if (strmatch(tok, "MacIndic2:")==0
	      || strmatch(tok, "MacContext2:")==0
	      || strmatch(tok, "MacLigature2:")==0
	      || strmatch(tok, "MacSimple2:")==0
	      || strmatch(tok, "MacKern2:")==0
	      || strmatch(tok, "MacInsert2:")==0
	      || strmatch(tok, "MacIndic:")==0
	      || strmatch(tok, "MacContext:")==0
	      || strmatch(tok, "MacLigature:")==0
	      || strmatch(tok, "MacSimple:")==0
	      || strmatch(tok, "MacKern:")==0
	      || strmatch(tok, "MacInsert:")==0) {
      ASM *sm;

      if (strchr(tok, '2') != NULL) {
	 old=false;
	 sm=chunkalloc(sizeof(ASM));
      } else {
	 old=true;
	 sm=chunkalloc(sizeof(ASM1));
      }
      if ((sf->sfd_version < 2) != old) {
	 ErrorMsg(3,"Version mixup in state machine of sfd file.\n");
	 exit(1);
      }
      if (d->lastsm==NULL)
	 sf->sm=sm;
      else
	 d->lastsm->next=sm;
      d->lastsm=sm;
      SFDParseStateMachine(sfd, sf, sm, tok, old);
   } else if (strmatch(tok, "MacFeat:")==0) {
      sf->features=SFDParseMacFeatures(sfd, tok);
   } else if (strmatch(tok, "TtfTable:")==0) {
      /* Old, binary format */
      /* still used for maxp and unknown tables */
      SFDGetTtfTable(sfd, sf, d->lastttf);
   } else if (strmatch(tok, "TtTable:")==0) {
      /* text instruction format */
      SFDGetTtTable(sfd, sf, d->lastttf);
   }

   ///////////////////
   else if (strmatch(tok, "ShortTable:")==0) {
      // only read, not written.
      /* text number format */
      SFDGetShortTable(sfd, sf, d->lastttf);
   } else {
      //
      // We didn't have a match ourselves.
      //
      return false;
   }
   return true;
}

static SplineFont *SFD_GetFont(AFILE *sfd,SplineFont *cidmaster,char *tok,
			       char *dirname, float sfdversion) {
   SplineFont *sf;
   int realcnt, i, eof, mappos=-1, ch;
   struct table_ordering *lastord=NULL;
   struct axismap *lastaxismap=NULL;
   struct named_instance *lastnamedinstance=NULL;
   int pushedbacktok=false;
   Encoding *enc=&custom;
   struct remap *remap=NULL;
   int hadtimes=false, haddupenc;
   int old_style_order2=false;
   int had_layer_cnt=false;
   orig_pos=0;		/* Only used for compatibility with extremely old sfd files */

   sf=SplineFontEmpty();
   if (sfdversion < 2) {
      /* If it's an old style sfd file with old style features we need some */
      /*  extra data space to do the conversion from old to new */
      sf=realloc(sf, sizeof(SplineFont1));
      memset(((uint8_t *) sf) + sizeof(SplineFont), 0,
	     sizeof(SplineFont1) - sizeof(SplineFont));
   }
   sf->sfd_version=sfdversion;
   sf->cidmaster=cidmaster;
   sf->uni_interp=ui_unset;
   SFD_GetFontMetaDataData d;

   SFD_GetFontMetaDataData_Init(&d);
   while (1) {
      if (pushedbacktok)
	 pushedbacktok=false;
      else if ((eof=getname(sfd, tok)) != 1) {
	 if (eof==-1)
	    break;
	 geteol(sfd, tok);
	 continue;
      }
      int wasMetadata=SFD_GetFontMetaData(sfd, tok, sf, &d);

      had_layer_cnt=d.had_layer_cnt;
      if (wasMetadata) {
	 // we have handled the token entirely
	 // inside SFD_GetFontMetaData() move to next token.
	 continue;
      }


      if (strmatch(tok, "DisplaySize:")==0) {
	 getint(sfd, &sf->display_size);
      } else if (strmatch(tok, "DisplayLayer:")==0) {
	 getint(sfd, &sf->display_layer);
      } else if (strmatch(tok, "ExtremaBound:")==0) {
	 getint(sfd, &sf->extrema_bound);
      } else if (strmatch(tok, "WidthSeparation:")==0) {
	 getint(sfd, &sf->width_separation);
      } else if (strmatch(tok, "WinInfo:")==0) {
	 int temp1, temp2;

	 getint(sfd, &sf->top_enc);
	 getint(sfd, &temp1);
	 getint(sfd, &temp2);
	 if (sf->top_enc <= 0)
	    sf->top_enc=-1;
	 if (temp1 <= 0)
	    temp1=16;
	 if (temp2 <= 0)
	    temp2=4;
	 sf->desired_col_cnt=temp1;
	 sf->desired_row_cnt=temp2;
      } else if (strmatch(tok, "AntiAlias:")==0) {
	 int temp;

	 getint(sfd, &temp);
	 sf->display_antialias=temp;
      } else if (strmatch(tok, "FitToEm:")==0) {
	 int temp;

	 getint(sfd, &temp);
	 sf->display_bbsized=temp;
      } else if (strmatch(tok, "OnlyBitmaps:")==0) {
	 int temp;

	 getint(sfd, &temp);
	 sf->onlybitmaps=temp;
      } else if (strmatch(tok, "Order2:")==0) {
	 getint(sfd, &old_style_order2);
	 sf->grid.order2=old_style_order2;
	 sf->layers[ly_back].order2=old_style_order2;
	 sf->layers[ly_fore].order2=old_style_order2;
      } else if (strmatch(tok, "GridOrder2:")==0) {
	 int o2;

	 getint(sfd, &o2);
	 sf->grid.order2=o2;
      } else if (strmatch(tok, "Encoding:")==0) {
	 enc=SFDGetEncoding(sfd, tok, sf);
	 if (sf->map != NULL)
	    sf->map->enc=enc;
      } else if (strmatch(tok, "OldEncoding:")==0) {
	 /* old_encname=*/ (void) SFDGetEncoding(sfd, tok, sf);
      } else if (strmatch(tok, "UnicodeInterp:")==0) {
	 sf->uni_interp=SFDGetUniInterp(sfd, tok, sf);
      } else if (strmatch(tok, "NameList:")==0) {
	 SFDGetNameList(sfd, tok, sf);
      } else if (strmatch(tok, "Compacted:")==0) {
	 int temp;

	 getint(sfd, &temp);
	 sf->compacted=temp;
      } else if (strmatch(tok, "Registry:")==0) {
	 geteol(sfd, tok);
	 sf->cidregistry=fastrdup(tok);
      }

      //////////
      else if (strmatch(tok, "Ordering:")==0) {
	 geteol(sfd, tok);
	 sf->ordering=fastrdup(tok);
      } else if (strmatch(tok, "Supplement:")==0) {
	 getint(sfd, &sf->supplement);
      } else if (strmatch(tok, "RemapN:")==0) {
	 int n;

	 getint(sfd, &n);
	 remap=calloc(n + 1, sizeof(struct remap));
	 remap[n].infont=-1;
	 mappos=0;
	 if (sf->map != NULL)
	    sf->map->remap=remap;
      } else if (strmatch(tok, "Remap:")==0) {
	 uint32_t f, l;
	 int p;

	 gethex(sfd, &f);
	 gethex(sfd, &l);
	 getint(sfd, &p);
	 if (remap != NULL && remap[mappos].infont != -1) {
	    remap[mappos].firstenc=f;
	    remap[mappos].lastenc=l;
	    remap[mappos].infont=p;
	    mappos++;
	 }
      } else if (strmatch(tok, "CIDVersion:")==0) {
	 double temp;

	 getreal(sfd, &temp);
	 sf->cidversion=temp;
      } else if (strmatch(tok, "Grid")==0) {
	 sf->grid.splines=SFDGetSplineSet(sf, sfd, sf->grid.order2);
      } else if (strmatch(tok, "ScriptLang:")==0) {
	 int i, j, k;
	 int imax, jmax, kmax;

	 if (sf->sfd_version >= 2) {
	    ErrorMsg(3,"Script lang lists should not happen in version 2 sfd files.\n");
	    exit(1);
	 }
	 getint(sfd, &imax);
	 ((SplineFont1 *) sf)->sli_cnt=imax;
	 ((SplineFont1 *) sf)->script_lang =
	    malloc((imax + 1) * sizeof(struct script_record *));
	 ((SplineFont1 *) sf)->script_lang[imax]=NULL;
	 for (i=0; i < imax; ++i) {
	    getint(sfd, &jmax);
	    ((SplineFont1 *) sf)->script_lang[i] =
	       malloc((jmax + 1) * sizeof(struct script_record));
	    ((SplineFont1 *) sf)->script_lang[i][jmax].script=0;
	    for (j=0; j < jmax; ++j) {
	       ((SplineFont1 *) sf)->script_lang[i][j].script=gettag(sfd);
	       getint(sfd, &kmax);
	       ((SplineFont1 *) sf)->script_lang[i][j].langs =
		  malloc((kmax + 1) * sizeof(uint32_t));
	       ((SplineFont1 *) sf)->script_lang[i][j].langs[kmax]=0;
	       for (k=0; k < kmax; ++k) {
		  ((SplineFont1 *) sf)->script_lang[i][j].langs[k] =
		     gettag(sfd);
	       }
	    }
	 }
      } else if (strmatch(tok, "TeXData:")==0) {
	 int temp;

	 getint(sfd, &temp);
	 sf->texdata.type=temp;
	 getint(sfd, &temp);
	 if (sf->design_size==0) {
	    sf->design_size=(5 * temp + (1 << 18)) >> 19;
	 }
	 for (i=0; i < 22; ++i) {
	    int foo;

	    getint(sfd, &foo);
	    sf->texdata.params[i]=foo;
	 }
      } else if (strnmatch(tok, "AnchorClass", 11)==0) {
	 char *name;
	 AnchorClass *lastan=NULL, *an;
	 int old=strchr(tok, '2')==NULL;

	 while ((name=SFDReadUTF7Str(sfd)) != NULL) {
	    an=chunkalloc(old ? sizeof(AnchorClass1) : sizeof(AnchorClass));
	    an->name=name;
	    if (old) {
	       getname(sfd, tok);
	       if (tok[0]=='0' && tok[1]=='\0')
		  ((AnchorClass1 *) an)->feature_tag=0;
	       else {
		  if (tok[1]=='\0') {
		     tok[1]=' ';
		     tok[2]=0;
		  }
		  if (tok[2]=='\0') {
		     tok[2]=' ';
		     tok[3]=0;
		  }
		  if (tok[3]=='\0') {
		     tok[3]=' ';
		     tok[4]=0;
		  }
		  ((AnchorClass1 *) an)->feature_tag =
		     (tok[0] << 24) | (tok[1] << 16) | (tok[2] << 8) | tok[3];
	       }
	       while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	       aungetc(ch, sfd);
	       if (isdigit(ch)) {
		  int temp;

		  getint(sfd, &temp);
		  ((AnchorClass1 *) an)->flags=temp;
	       }
	       while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	       aungetc(ch, sfd);
	       if (isdigit(ch)) {
		  int temp;

		  getint(sfd, &temp);
		  ((AnchorClass1 *) an)->script_lang_index=temp;
	       } else
		  ((AnchorClass1 *) an)->script_lang_index=0xffff;	/* Will be fixed up later */
	       while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	       aungetc(ch, sfd);
	       if (isdigit(ch)) {
		  int temp;

		  getint(sfd, &temp);
		  ((AnchorClass1 *) an)->merge_with=temp;
	       } else
		  ((AnchorClass1 *) an)->merge_with=0xffff;	/* Will be fixed up later */
	    } else {
	       char *subtable_name=SFDReadUTF7Str(sfd);

	       if (subtable_name != NULL)	/* subtable is optional */
		  an->subtable =
		     SFFindLookupSubtableAndFreeName(sf, subtable_name);
	    }
	    while ((ch=nlgetc(sfd))==' ' || ch=='\t');
	    aungetc(ch, sfd);
	    if (isdigit(ch)) {
	       /* Early versions of SfdFormat 2 had a number here */
	       int temp;

	       getint(sfd, &temp);
	       an->type=temp;
	    } else if (old) {
	       if (((AnchorClass1 *) an)->feature_tag ==
		   CHR('c', 'u', 'r', 's'))
		  an->type=act_curs;
	       else if (((AnchorClass1 *) an)->feature_tag ==
			CHR('m', 'k', 'm', 'k'))
		  an->type=act_mkmk;
	       else
		  an->type=act_mark;
	    } else {
	       an->type=act_mark;
	       if (an->subtable && an->subtable->lookup) {
		  switch (an->subtable->lookup->lookup_type) {
		    case gpos_cursive:
		       an->type=act_curs;
		       break;
		    case gpos_mark2base:
		       an->type=act_mark;
		       break;
		    case gpos_mark2ligature:
		       an->type=act_mklg;
		       break;
		    case gpos_mark2mark:
		       an->type=act_mkmk;
		       break;
		    default:
		       an->type=act_mark;
		       break;
		  }
	       }
	    }
	    if (lastan==NULL)
	       sf->anchor=an;
	    else
	       lastan->next=an;
	    lastan=an;
	 }
      } else if (strncmp(tok, "MATH:", 5)==0) {
	 SFDParseMathItem(sfd, sf, tok);
      } else if (strmatch(tok, "TableOrder:")==0) {
	 int temp;
	 struct table_ordering *ord;

	 if (sfdversion >= 2) {
	    ErrorMsg(3,"Table ordering specified in version 2 sfd file.\n");
	    exit(1);
	 }
	 ord=chunkalloc(sizeof(struct table_ordering));
	 ord->table_tag=gettag(sfd);
	 getint(sfd, &temp);
	 ord->ordered_features=malloc((temp + 1) * sizeof(uint32_t));
	 ord->ordered_features[temp]=0;
	 for (i=0; i < temp; ++i) {
	    while (isspace((ch=nlgetc(sfd))));
	    if (ch=='\'') {
	       aungetc(ch, sfd);
	       ord->ordered_features[i]=gettag(sfd);
	    } else if (ch=='<') {
	       int f, s;

	       afscanf(sfd, "%d,%d>", &f, &s);
	       ord->ordered_features[i]=(f << 16) | s;
	    }
	 }
	 if (lastord==NULL)
	    ((SplineFont1 *) sf)->orders=ord;
	 else
	    lastord->next=ord;
	 lastord=ord;
      } else if (strmatch(tok, "BeginPrivate:")==0) {
	 SFDGetPrivate(sfd, sf);
      } else if (strmatch(tok, "BeginSubrs:")==0) {	/* leave in so we don't croak on old sfd files */
	 SFDGetSubrs(sfd, sf);
      } else if (strmatch(tok, "PickledData:")==0) {
	 sf->python_persistent=SFDUnPickle(sfd);
      } else if (strmatch(tok, "MMCounts:")==0) {
	 MMSet *mm=sf->mm=chunkalloc(sizeof(MMSet));

	 getint(sfd, &mm->instance_count);
	 getint(sfd, &mm->axis_count);
	 ch=nlgetc(sfd);
	 if (ch != ' ')
	    aungetc(ch, sfd);
	 else {
	    int temp;

	    getint(sfd, &temp);
	    mm->apple=temp;
	    getint(sfd, &mm->named_instance_count);
	 }
	 mm->instances=calloc(mm->instance_count, sizeof(SplineFont *));
	 mm->positions =
	    malloc(mm->instance_count * mm->axis_count * sizeof(double));
	 mm->defweights=malloc(mm->instance_count * sizeof(double));
	 mm->axismaps=calloc(mm->axis_count, sizeof(struct axismap));
	 if (mm->named_instance_count != 0)
	    mm->named_instances =
	       calloc(mm->named_instance_count,
		      sizeof(struct named_instance));
      } else if (strmatch(tok, "MMAxis:")==0) {
	 MMSet *mm=sf->mm;

	 if (mm != NULL) {
	    for (i=0; i < mm->axis_count; ++i) {
	       getname(sfd, tok);
	       mm->axes[i]=fastrdup(tok);
	    }
	 }
      } else if (strmatch(tok, "MMPositions:")==0) {
	 MMSet *mm=sf->mm;

	 if (mm != NULL) {
	    for (i=0; i < mm->axis_count * mm->instance_count; ++i)
	       getreal(sfd, &mm->positions[i]);
	 }
      } else if (strmatch(tok, "MMWeights:")==0) {
	 MMSet *mm=sf->mm;

	 if (mm != NULL) {
	    for (i=0; i < mm->instance_count; ++i)
	       getreal(sfd, &mm->defweights[i]);
	 }
      } else if (strmatch(tok, "MMAxisMap:")==0) {
	 MMSet *mm=sf->mm;

	 if (mm != NULL) {
	    int index, points;

	    getint(sfd, &index);
	    getint(sfd, &points);
	    mm->axismaps[index].points=points;
	    mm->axismaps[index].blends=malloc(points * sizeof(double));
	    mm->axismaps[index].designs=malloc(points * sizeof(double));
	    for (i=0; i < points; ++i) {
	       getreal(sfd, &mm->axismaps[index].blends[i]);
	       while ((ch=nlgetc(sfd)) != EOF && isspace(ch));
	       aungetc(ch, sfd);
	       if ((ch=nlgetc(sfd)) != '=')
		  aungetc(ch, sfd);
	       else if ((ch=nlgetc(sfd)) != '>')
		  aungetc(ch, sfd);
	       getreal(sfd, &mm->axismaps[index].designs[i]);
	    }
	    lastaxismap=&mm->axismaps[index];
	    lastnamedinstance=NULL;
	 }
      } else if (strmatch(tok, "MMNamedInstance:")==0) {
	 MMSet *mm=sf->mm;

	 if (mm != NULL) {
	    int index;

	    getint(sfd, &index);
	    mm->named_instances[index].coords =
	       malloc(mm->axis_count * sizeof(double));
	    for (i=0; i < mm->axis_count; ++i)
	       getreal(sfd, &mm->named_instances[index].coords[i]);
	    lastnamedinstance=&mm->named_instances[index];
	    lastaxismap=NULL;
	 }
      } else if (strmatch(tok, "MacName:")==0) {
	 struct macname *names=SFDParseMacNames(sfd, tok);

	 if (lastaxismap != NULL)
	    lastaxismap->axisnames=names;
	 else if (lastnamedinstance != NULL)
	    lastnamedinstance->names=names;
	 pushedbacktok=true;
      } else if (strmatch(tok, "MMCDV:")==0) {
	 MMSet *mm=sf->mm;

	 if (mm != NULL)
	    mm->cdv=SFDParseMMSubroutine(sfd);
      } else if (strmatch(tok, "MMNDV:")==0) {
	 MMSet *mm=sf->mm;

	 if (mm != NULL)
	    mm->ndv=SFDParseMMSubroutine(sfd);
      } else if (strmatch(tok, "BeginMMFonts:")==0) {
	 int cnt;

	 getint(sfd, &cnt);
	 getint(sfd, &realcnt);
	 MMInferStuff(sf->mm);
	 break;
      } else if (strmatch(tok, "BeginSubFonts:")==0) {
	 getint(sfd, &sf->subfontcnt);
	 sf->subfonts=calloc(sf->subfontcnt, sizeof(SplineFont *));
	 getint(sfd, &realcnt);
	 sf->map=EncMap1to1(realcnt);
	 break;
      } else if (strmatch(tok, "BeginChars:")==0) {
	 int charcnt;

	 getint(sfd, &charcnt);
	 if (charcnt < enc->char_cnt) {
	    ErrorMsg(3,"SFD file specifies too few slots for its encoding.\n");
	    exit(1);
	 }
	 if (getint(sfd, &realcnt) != 1 || realcnt==-1)
	    realcnt=charcnt;
	 else
	    ++realcnt;		/* value saved is max glyph, not glyph cnt */
	 sf->glyphcnt=sf->glyphmax=realcnt;
	 sf->glyphs=calloc(realcnt, sizeof(SplineChar *));
	 if (cidmaster != NULL) {
	    sf->map=cidmaster->map;
	 } else {
	    sf->map=EncMapNew(charcnt, realcnt, enc);
	    sf->map->remap=remap;
	 }
	 SFDSizeMap(sf->map, sf->glyphcnt, charcnt);
	 break;
#if HANYANG
      } else if (strmatch(tok, "BeginCompositionRules")==0) {
	 sf->rules=SFDReadCompositionRules(sfd);
#endif
      } else {
	 /* If we don't understand it, skip it */
	 geteol(sfd, tok);
      }
   }

   if (sf->subfontcnt != 0) {
      for (i=0; i < sf->subfontcnt; ++i) {
	 sf->subfonts[i] =
	    SFD_GetFont(sfd, sf, tok, dirname, sfdversion);
      }
   } else if (sf->mm != NULL) {
      MMSet *mm=sf->mm;

      for (i=0; i < mm->instance_count; ++i) {
	 mm->instances[i] =
	    SFD_GetFont(sfd, NULL, tok, dirname, sfdversion);
	 EncMapFree(mm->instances[i]->map);
	 mm->instances[i]->map=NULL;
	 mm->instances[i]->mm=mm;
      }
      mm->normal=SFD_GetFont(sfd, NULL, tok, dirname, sfdversion);
      mm->normal->mm=mm;
      sf->mm=NULL;
      SplineFontFree(sf);
      sf=mm->normal;
      if (sf->map->enc != &custom) {
	 EncMap *map;

	 MMMatchGlyphs(mm);	/* sfd files from before the encoding change can have mismatched orig pos */
	 map=EncMapFromEncoding(sf, sf->map->enc);
	 EncMapFree(sf->map);
	 sf->map=map;
      }
   } else {
      while (SFDGetChar(sfd, sf, had_layer_cnt) != NULL);
   }
   haddupenc=false;
   while (getname(sfd, tok)==1) {
      if (strcmp(tok, "EndSplineFont")==0
	  || strcmp(tok, "EndSubSplineFont")==0)
	 break;
      else if (strcmp(tok, "BitmapFont:")==0)
	 SFDGetBitmapFont(sfd, sf);
      else if (strmatch(tok, "DupEnc:")==0) {
	 int enc, orig;

	 haddupenc=true;
	 if (getint(sfd, &enc) && getint(sfd, &orig) && sf->map != NULL) {
	    SFDSetEncMap(sf, orig, enc);
	 }
      }
   }
   if (sf->cidmaster==NULL)
      SFDFixupRefs(sf);

   if (!haddupenc)
      SFD_DoAltUnis(sf);
   else
      AltUniFigure(sf, sf->map, true);
   if (sf->sfd_version < 2)
      SFD_AssignLookups((SplineFont1 *) sf);
   if (!hadtimes) {
      time_t now;

      time(&now);
      sf->creationtime=now;
      sf->modificationtime=now;
   }

   SFDFixupUndoRefs(sf);
   return (sf);
}

static double SFDStartsCorrectly(AFILE *sfd,char *tok) {
   double dval;
   int ch;

   if (getname(sfd, tok) != 1)
      return (-1);
   if (strcmp(tok, "SplineFontDB:") != 0)
      return (-1);
   if (getreal(sfd, &dval) != 1)
      return (-1);
   /* We don't yet generate version 4 of sfd. It will contain backslash */
   /*  newline in the middle of very long lines. I've put in code to parse */
   /*  this sequence, but I don't yet generate it. I want the parser to */
   /*  perculate through to users before I introduce the new format so there */
   /*  will be fewer complaints when it happens */
   // MIQ: getreal() can give some funky rounding errors it seems
   if (dval != 0 && dval != 1 && dval != 2.0 && dval != 3.0
       && !(dval > 3.09 && dval <= 3.11)
       && dval != 4.0) {
      ErrorMsg(2,"Bad SFD Version number %.1f", dval);
      return (-1);
   }
   ch=nlgetc(sfd);
   aungetc(ch, sfd);
   if (ch != '\r' && ch != '\n')
      return (-1);

   return (dval);
}

SplineFont *_SFDRead(char *filename,AFILE *sfd) {
   SplineFont *sf=NULL;
   char tok[2000];
   double version;

   if (sfd==NULL)
     sfd=afopen(filename, "r");
   if (sfd==NULL)
      return (NULL);
   if ((version=SFDStartsCorrectly(sfd, tok)) != -1)
      sf=SFD_GetFont(sfd, NULL, tok, filename, version);
   if (sf != NULL) {
      sf->filename=fastrdup(filename);
      if (sf->mm != NULL) {
	 int i;

	 for (i=0; i < sf->mm->instance_count; ++i)
	    sf->mm->instances[i]->filename=fastrdup(filename);
      } else if (!sf->onlybitmaps) {
/* Jonathyn Bet'nct points out that once you edit in an outline window, even */
/*  if by mistake, your onlybitmaps status is gone for good */
/* Regenerate it if the font has no splines, refs, etc. */
	 int i;
	 SplineChar *sc;

	 for (i=sf->glyphcnt - 1; i >= 0; --i)
	    if ((sc=sf->glyphs[i]) != NULL &&
		(sc->layer_cnt != 2 ||
		 sc->layers[ly_fore].splines != NULL ||
		 sc->layers[ly_fore].refs != NULL))
	       break;
	 if (i==-1)
	    sf->onlybitmaps=true;
      }
   }
   afclose(sfd);
   return (sf);
}

SplineFont *SFDRead(char *filename) {
   return _SFDRead(filename, NULL);
}

char **NamesReadSFD(char *filename) {
   AFILE *sfd=afopen(filename, "r");
   char tok[2000];
   char **ret=NULL;
   int eof;

   if (sfd==NULL)
      return (NULL);
   if (SFDStartsCorrectly(sfd, tok) != -1) {
      while (!afeof(sfd)) {
	 if ((eof=getname(sfd, tok)) != 1) {
	    if (eof==-1)
	       break;
	    geteol(sfd, tok);
	    continue;
	 }
	 if (strmatch(tok, "FontName:")==0) {
	    getname(sfd, tok);
	    ret=malloc(2 * sizeof(char *));
	    ret[0]=fastrdup(tok);
	    ret[1]=NULL;
	    break;
	 }
      }
   }
   afclose(sfd);
   return (ret);
}
