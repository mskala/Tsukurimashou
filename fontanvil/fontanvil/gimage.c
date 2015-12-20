/* $Id: gimage.c 4523 2015-12-20 12:30:49Z mskala $ */
/* Copyright (C) 2000-2012 by George Williams */
/* Copyright (C) 2015  Matthew Skala */
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

#include "gimage.h"
#include <string.h>
#include <ustring.h>
#include <ctype.h>
#ifdef _NO_LIBPNG
#include <setjmp.h>
#else
#include <png.h>
#endif

#include "gfile.h"
#include "fontanvil-config.h"

/**********************************************************************/

/* GENERAL UTILITY FUNCTIONS */

static int readlongtab(AFILE *fp,uint32_t *tab,int tablen) {
   int i;

   for (i=0;i<tablen;i++)
     if (aread_int32_le(fp,(int32_t *)&tab[i]))
       return -1;		/* had a read error */
   return 0;			/* read everything okay */
}

/**********************************************************************/

/* MICROSOFT BITMAP (BMP) */

struct bmpheader {
   char b;			/* should contain 'B' */
   char m;			/* should contain 'M' */
   int32_t size;			/* lowbyte first, size of file in bytes */
   int16_t mbz1;			/* reserved */
   int16_t mbz2;			/* reserved */
   int32_t offset;			/* lowbyte first, offset to bitmap */
   int32_t headersize;		/* who cares */
   int32_t width;
   int32_t height;
   int16_t planes;		/* must be 1 */
   int16_t bitsperpixel;		/* 1,4,8,24 (later 16,32 also) */
   int32_t compression;		/* 0 => none, 1=>8bit rlc, 2=>4bit rlc, 3=>16/32 */
   int32_t imagesize;
   int32_t ignore1;		/* suggested x pixels per meter */
   int32_t ignore2;		/* suggested y pixels per meter */
   int32_t colorsused;		/* size of color table */
   int32_t colorsimportant;
   uint32_t clut[256];
   int32_t red_mask, green_mask, blue_mask;
   int32_t red_shift, green_shift, blue_shift;
   unsigned int invert:1;
   uint8_t *byte_pixels;
   uint32_t *int32_pixels;
};

GImage *_GImage_Create(enum image_type type, int32_t width, int32_t height);

static int bitshift(unsigned long mask) {
   int off=0, len=0, bit;

   if (mask == 0)
      return (0);
   for (off=0; !(mask & 1); mask >>= 1, ++off);
   for (len=0, bit=1; (mask & bit) && len < 32; ++len, bit <<= 1);
   return (off + (8 - len));
}

static int fillbmpheader(AFILE *fp,struct bmpheader *head) {
/* Get BMPheader info. Return 0 if read the header okay, -1 if read error */
   int i;
   uint32_t temp;

   if (agetc(fp) != 'B' || agetc(fp) != 'M' ||	/* Bad format */
       aread_int32_le(fp, &head->size) ||
       (head->mbz1=aget_uint16_le(fp)) < 0 ||
       (head->mbz2=aget_uint16_le(fp)) < 0 ||
       aread_int32_le(fp, &head->offset) || aread_int32_le(fp, &head->headersize))
     return -1;
   
   if (head->headersize == 12) {	/* Windows 2.0 format, also OS/2 */
      if ((head->width=aget_uint16_le(fp)) < 0 ||
	  (head->height=aget_uint16_le(fp)) < 0 ||
	  (head->planes=aget_uint16_le(fp)) < 0 ||
	  (head->bitsperpixel=aget_uint16_le(fp)) < 0)
	return -1;
   } else {
      if (aread_int32_le(fp, &head->width) ||
	  aread_int32_le(fp, &head->height) ||
	  (head->planes=aget_uint16_le(fp)) < 0 ||
	  (head->bitsperpixel=aget_uint16_le(fp)) < 0 ||
	  aread_int32_le(fp, &head->compression) ||
	  aread_int32_le(fp, &head->imagesize) ||
	  aread_int32_le(fp, &head->ignore1) ||
	  aread_int32_le(fp, &head->ignore2) ||
	  aread_int32_le(fp, &head->colorsused) ||
	  aread_int32_le(fp, &head->colorsimportant))
	return -1;
   }
   if (head->height < 0)
     head->height=-head->height;
   else
     head->invert=true;

   if (head->bitsperpixel != 1 && head->bitsperpixel != 4
       && head->bitsperpixel != 8 && head->bitsperpixel != 16
       && head->bitsperpixel != 24 && head->bitsperpixel != 32)
     return -1;
   
   if (head->compression == 3
       && (head->bitsperpixel == 16 || head->bitsperpixel == 32))
     /* Good */ ;
   else if (head->compression == 0
	    && (head->bitsperpixel <= 8 || head->bitsperpixel == 24
		|| head->bitsperpixel == 32))
     /* Good */ ;
   else if (head->compression == 1 && head->bitsperpixel == 8)
     /* Good */ ;
   else if (head->compression == 2 && head->bitsperpixel == 4)
     /* Good */ ;
   else
     return -1;

   if (head->colorsused == 0)
     head->colorsused=1 << head->bitsperpixel;
   if (head->bitsperpixel >= 16)
     head->colorsused=0;
   if (head->colorsused > (1 << head->bitsperpixel))
     return -1;

   for (i=0; i < head->colorsused;i++) {
      int b,g,r;

      if ((b=agetc(fp)) < 0 || (g=agetc(fp)) < 0 || (r=agetc(fp)) < 0)
	return -1;
      head->clut[i]=COLOR_CREATE(r, g, b);
      if (head->headersize != 12 && agetc(fp) < 0)
	return -1;
   }
   if (head->compression == 3 || head->headersize == 108) {
      if (aread_int32_le(fp, &head->red_mask) ||
	  aread_int32_le(fp, &head->green_mask) || aread_int32_le(fp, &head->blue_mask))
	return (-1);
      head->red_shift=bitshift(head->red_mask);
      head->green_shift=bitshift(head->green_mask);
      head->blue_shift=bitshift(head->blue_mask);
   }

   if (head->headersize == 108 && (aread_int32_le(fp, &temp) ||	/* alpha_mask */
				   aread_int32_le(fp, &temp) ||	/* color space type */
				   aread_int32_le(fp, &temp) ||	/* redx */
				   aread_int32_le(fp, &temp) ||	/* redy */
				   aread_int32_le(fp, &temp) ||	/* redz */
				   aread_int32_le(fp, &temp) ||	/* greenx */
				   aread_int32_le(fp, &temp) ||	/* greeny */
				   aread_int32_le(fp, &temp) ||	/* greenz */
				   aread_int32_le(fp, &temp) ||	/* bluex */
				   aread_int32_le(fp, &temp) ||	/* bluey */
				   aread_int32_le(fp, &temp) ||	/* bluez */
				   aread_int32_le(fp, &temp) ||	/* gammared */
				   aread_int32_le(fp, &temp) ||	/* gammagreen */
				   aread_int32_le(fp, &temp)) /* gammablue */ )
     return -1;

   return 0;
}

static int readpixels(AFILE *file, struct bmpheader *head) {
   int i,ii,j,ll,excess;

   afseek(file,head->offset,0);

   ll=head->width;
   if (head->bitsperpixel == 8 && head->compression == 0) {
      excess=((ll + 3) / 4) * 4 - ll;
      for (i=0; i < head->height;i++) {
	 afread(head->byte_pixels + i * ll, 1, ll, file);
	 for (j=0; j < excess;j++)
	    (void)agetc(file);
      }
   } else if (head->bitsperpixel == 8) {
      /* 8 bit RLE */
      int ii=0;

      while (ii < head->height * head->width) {
	 int cnt=agetc(file);

	 if (cnt != 0) {
	    int ch=agetc(file);

	    while (--cnt >= 0)
	       head->byte_pixels[ii++]=ch;
	 } else {
	    cnt=agetc(file);
	    if (cnt >= 3) {
	       int odd=cnt & 1;

	       while (--cnt >= 0)
		  head->byte_pixels[ii++]=agetc(file);
	       if (odd)
		 agetc(file);
	    } else if (cnt == 0) {	/* end of scan line */
	       ii=((ii + head->width - 1) / head->width) * head->width;
	    } else if (cnt == 1) {
	       break;
	    } else if (cnt == 2) {
	       int x=agetc(file);
	       int y=agetc(file);

	       y += ii / head->width;
	       x += ii % head->width;
	       ii=y * head->width + x;
	    }
	 }
      }
   } else if (head->bitsperpixel == 4 && head->compression == 0) {
      excess=(ll + 1) / 2;
      excess=((excess + 3) / 4) * 4 - excess;
      for (i=0; i < head->height;i++) {
	 ii=i * ll;
	 for (j=0; j < ((head->width + 7) / 8) * 8; j += 8) {
	    int b1=agetc(file);
	    int b2=agetc(file);
	    int b3=agetc(file);
	    int b4=agetc(file);

	    head->byte_pixels[ii + j]=(b1 >> 4);
	    if (j + 1 < ll)
	       head->byte_pixels[ii + j + 1]=(b1 & 0xf);
	    if (j + 2 < ll)
	       head->byte_pixels[ii + j + 2]=(b2 >> 4);
	    if (j + 3 < ll)
	       head->byte_pixels[ii + j + 3]=(b2 & 0xf);
	    if (j + 4 < ll)
	       head->byte_pixels[ii + j + 4]=(b3 >> 4);
	    if (j + 5 < ll)
	       head->byte_pixels[ii + j + 5]=(b3 & 0xf);
	    if (j + 6 < ll)
	       head->byte_pixels[ii + j + 6]=(b4 >> 4);
	    if (j + 7 < ll)
	       head->byte_pixels[ii + j + 7]=(b4 & 0xf);
	 }
	 for (j=0; j < excess;j++)
	    (void)agetc(file);
      }
   } else if (head->bitsperpixel == 4) {
      /* 4 bit RLE */
      int ii=0;

      while (ii < head->height * head->width) {
	 int cnt=agetc(file);

	 if (cnt != 0) {
	    int ch=agetc(file);

	    while ((cnt -= 2) >= -1) {
	       head->byte_pixels[ii++]=ch >> 4;
	       head->byte_pixels[ii++]=ch & 0xf;
	    }
	    if (cnt == -1)
	       ii--;
	 } else {
	    cnt=agetc(file);
	    if (cnt >= 3) {
	       int odd=cnt & 2;

	       while ((cnt -= 2) >= -1) {
		  int ch=agetc(file);

		  head->byte_pixels[ii++]=ch >> 4;
		  head->byte_pixels[ii++]=ch & 0xf;
	       }
	       if (cnt == -1)
		 ii--;
	       if (odd)
		 agetc(file);
	    } else if (cnt == 0) {	/* end of scan line */
	       ii=((ii + head->width - 1) / head->width) * head->width;
	    } else if (cnt == 1) {
	       break;
	    } else if (cnt == 2) {
	       int x=agetc(file);
	       int y=agetc(file);

	       y += ii / head->width;
	       x += ii % head->width;
	       ii=y * head->width + x;
	    }
	 }
      }
   } else if (head->bitsperpixel == 1) {
      excess=(ll + 7) / 8;
      excess=((excess + 3) / 4) * 4 - excess;
      for (i=0; i < head->height;i++) {
	 ii=i * ((ll + 7) / 8);
	 for (j=0; j < ((head->width + 7) / 8);j++) {
	    head->byte_pixels[ii + j]=agetc(file);
	 }
	 for (j=0; j < excess;j++)
	    (void)agetc(file);
      }
   } else if (head->bitsperpixel == 24) {
      excess=((3 * head->width + 3) / 4) * 4 - 3 * head->width;
      for (i=0; i < head->height;i++) {
	 ii=i * head->width;
	 for (j=0; j < head->width;j++) {
	    int b=agetc(file);
	    int g=agetc(file);
	    int r=agetc(file);

	    head->int32_pixels[ii + j]=COLOR_CREATE(r, g, b);
	 }
	 for (j=0; j < excess;j++)
	    (void)agetc(file);	/* ignore padding */
      }
   } else if (head->bitsperpixel == 32 && head->compression == 0) {
      for (i=0; i < head->height;i++) {
	 ii=i * head->width;
	 for (j=0; j < head->width;j++) {
	    int b, g, r;

	    b=agetc(file);
	    g=agetc(file);
	    r=agetc(file);
	    (void)agetc(file);	/* Ignore the alpha channel */
	    head->int32_pixels[ii + j]=COLOR_CREATE(r, g, b);
	 }
      }
   } else if (head->bitsperpixel == 16) {
      for (i=0; i < head->height;i++) {
	 ii=i * head->width;
	 for (j=0; j < head->width;j++) {
	    int pix=aget_uint16_le(file);

	    head->int32_pixels[ii + j] =
	       COLOR_CREATE((pix & head->red_mask) >> head->red_shift,
			    (pix & head->green_mask) >> head->green_shift,
			    (pix & head->blue_mask) >> head->blue_shift);
	 }
      }
      if (head->width & 1)
	 aget_uint16_le(file);
   } else if (head->bitsperpixel == 32) {
      for (i=0; i < head->height;i++) {
	 ii=i * head->width;
	 for (j=0; j < head->width;j++) {
	    uint32_t pix;

	    if (aread_int32_le(file, &pix))
	       return (1);
	    head->int32_pixels[ii + j] =
	       COLOR_CREATE((pix & head->red_mask) >> head->red_shift,
			    (pix & head->green_mask) >> head->green_shift,
			    (pix & head->blue_mask) >> head->blue_shift);
	 }
      }
   }

   if (afeof(file))		/* Did we get an incomplete file? */
      return 0;
   return 1;
}

GImage *GImageRead_Bmp(AFILE *file) {
   /* Import a BMP image (based on file handle), clean up,
    * and return NULL if error */
   struct bmpheader bmp;
   int i, l;
   GImage *ret=NULL;
   struct _GImage *base;

   if (file==NULL)
     return (NULL);

   /* First, read-in header information */
   memset(&bmp,'\0',sizeof(bmp));
   if (fillbmpheader(file,&bmp))
     goto errorGImageReadBmp;

   /* Create memory-space to read-in bmp file */
   if (((bmp.bitsperpixel>=16) &&
	(bmp.int32_pixels=
	    (uint32_t *)(malloc(bmp.height*bmp.width*sizeof(uint32_t))))==
	NULL) || (bmp.bitsperpixel==1
		  && (bmp.byte_pixels=
		      (unsigned char *)(malloc(bmp.height*((bmp.width+7)/8)
					       *sizeof(unsigned char))))
		  ==NULL)
       || (bmp.byte_pixels=
	   (unsigned char *)(malloc(bmp.height*bmp.width*
				    sizeof(unsigned char))))
       ==NULL) {
      return (NULL);
   }

   if (!readpixels(file, &bmp))
     goto errorGImageReadBmp;

   if (!bmp.invert) {
      if ((ret =
	   _GImage_Create(bmp.bitsperpixel >=
			  16 ? it_true : bmp.bitsperpixel !=
			  1 ? it_index : it_mono, bmp.width,
			  bmp.height)) == NULL) {
	 goto errorGImageMemBmp;
      }
      if (bmp.bitsperpixel >= 16) {
	 ret->u.image->data=(uint8_t *) bmp.int32_pixels;
      } else if (bmp.bitsperpixel != 1) {
	 ret->u.image->data=(uint8_t *) bmp.byte_pixels;
      }
   } else {
      if (bmp.bitsperpixel >= 16) {
	 if ((ret=GImageCreate(it_true, bmp.width, bmp.height)) == NULL) {
	    goto errorGImageMemBmp;
	 }
	 base=ret->u.image;
	 for (i=0; i < bmp.height;i++) {
	    l=bmp.height - 1 - i;
	    memcpy(base->data + l * base->bytes_per_line,
		   bmp.int32_pixels + i * bmp.width,
		   bmp.width * sizeof(uint32_t));
	 }
	 free(bmp.int32_pixels);
      } else if (bmp.bitsperpixel != 1) {
	 if ((ret=GImageCreate(it_index, bmp.width, bmp.height)) == NULL) {
	    goto errorGImageMemBmp;
	 }
	 base=ret->u.image;
	 for (i=0; i < bmp.height;i++) {
	    l=bmp.height - 1 - i;
	    memcpy(base->data + l * base->bytes_per_line,
		   bmp.byte_pixels + i * bmp.width, bmp.width);
	 }
	 free(bmp.byte_pixels);
      } else {
	 if ((ret=GImageCreate(it_mono, bmp.width, bmp.height)) == NULL) {
	    goto errorGImageMemBmp;
	 }
	 base=ret->u.image;
	 for (i=0; i < bmp.height;i++) {
	    l=bmp.height - 1 - i;
	    memcpy(base->data + l * base->bytes_per_line,
		   bmp.byte_pixels + i * base->bytes_per_line,
		   base->bytes_per_line);
	 }
	 free(bmp.byte_pixels);
      }
   }
   if (ret->u.image->image_type == it_index) {
      ret->u.image->clut->clut_len=bmp.colorsused;
      memcpy(ret->u.image->clut->clut, bmp.clut,
	     bmp.colorsused * sizeof(Color));
      ret->u.image->clut->trans_index=COLOR_UNKNOWN;
   } else if (ret->u.image->image_type == it_mono && bmp.colorsused != 0) {
      if ((ret->u.image->clut=(GClut *) (calloc(1, sizeof(GClut)))) == NULL) {
	 goto errorGImageMemBmp;
      }
      ret->u.image->clut->clut_len=bmp.colorsused;
      memcpy(ret->u.image->clut->clut, bmp.clut,
	     bmp.colorsused * sizeof(Color));
      ret->u.image->clut->trans_index=COLOR_UNKNOWN;
   }
   return (ret);

errorGImageReadBmp:
   fprintf(stderr, "Bad input file\n");
errorGImageMemBmp:
   GImageDestroy(ret);
   if (bmp.bitsperpixel >= 16)
     free(bmp.int32_pixels);
   else
     free(bmp.byte_pixels);
   return (NULL);
}

GImage *GImageReadBmp(char *filename) {
   /* Import a BMP image, else cleanup and return NULL if error found */
   AFILE *file;			/* source file */
   GImage *ret;

   if ((file=afopen(filename, "rb")) == NULL) {
      ErrorMsg(2,"Can't open \"%s\"\n",filename);
      return NULL;
   }

   ret=GImageRead_Bmp(file);
   afclose(file);
   return ret;
}

int GImageWrite_Bmp(GImage *gi,AFILE *file) {
   struct _GImage *base=gi->list_len==0?gi->u.image:gi->u.images[0];
   int headersize=40,preheadersize=14;
   int filesize,offset,imagesize;
   int bitsperpixel,clutsize,ncol;
   int row,col,i;

   if (base->image_type == it_mono) {
      ncol=2;
      bitsperpixel=1;
      clutsize=ncol * 4;
   } else if (base->image_type == it_index) {
      ncol=base->clut->clut_len;
      if (ncol <= 16)
	 bitsperpixel=4;
      else
	 bitsperpixel=8;
      clutsize=ncol * 4;
   } else {
      bitsperpixel=24;
      clutsize=0;
      ncol=0;
   }
   imagesize=((base->bytes_per_line + 3) & ~3U) * base->height;
   offset=preheadersize + headersize + clutsize;
   filesize=offset + imagesize;

   aputc('B',file);
   aputc('M',file);
   aput_int32_le(filesize,file);	/* filesize */
   aput_int16_le(0,file);		/* mbz1 */
   aput_int16_le(0,file);		/* mbz2 */
   aput_int32_le(offset,file);		/* offset */
   aput_int32_le(headersize,file);	/* headersize */
   aput_int32_le(base->width, file);	/* width */
   aput_int32_le(base->height, file);	/* height */
   aput_int16_le(1,file);		/* planes */
   aput_int16_le(bitsperpixel, file);	/* bitsperpixel */
   aput_int32_le(0,file);		/* compression */
   aput_int32_le(imagesize,file);	/* imagesize */
   aput_int32_le(3000,file);		/* horizontal res, pixels/meter */
   aput_int32_le(3000,file);		/* vertical res, pixels/meter */
   aput_int32_le(ncol,file);		/* colours used */
   aput_int32_le(0,file);		/* colours important */

   if (clutsize!=0) {
      int i;

      if (base->clut != NULL) {
	 for (i=0; i < ncol;i++) {
	    aputc(COLOR_BLUE(base->clut->clut[i]), file);
	    aputc(COLOR_GREEN(base->clut->clut[i]), file);
	    aputc(COLOR_RED(base->clut->clut[i]), file);
	    aputc(0, file);
	 }
      } else {
	 aputc(0, file);
	 aputc(0, file);
	 aputc(0, file);
	 aputc(0, file);
	 aputc(0xff, file);
	 aputc(0xff, file);
	 aputc(0xff, file);
	 aputc(0, file);
      }
   }

   for (row=base->height - 1; row >= 0; --row) {
      int pad=0;

      if (bitsperpixel == 24) {
	 uint32_t *pt=(uint32_t *) (base->data + row * base->bytes_per_line);

	 for (col=0; col < base->width; ++col) {
	    aputc(COLOR_BLUE(pt[col]), file);
	    aputc(COLOR_GREEN(pt[col]), file);
	    aputc(COLOR_RED(pt[col]), file);
	 }
	 pad=base->width & 3;
      } else if (bitsperpixel == 8) {
	 unsigned char *pt =
	    (unsigned char *) (base->data + row * base->bytes_per_line);
	 afwrite(pt, 1, base->width, file);
	 pad=4 - (base->width & 3);
      } else if (bitsperpixel == 4) {
	 unsigned char *pt =
	    (unsigned char *) (base->data + row * base->bytes_per_line);
	 for (col=0; col < base->width / 2; ++col) {
	    aputc((*pt << 4) | pt[1], file);
	    pt += 2;
	 }
	 if (base->width & 1)
	    aputc(*pt << 4, file);
	 pad=4 - (((base->width + 1) >> 1) & 3);
      } else if (bitsperpixel == 1) {
	 unsigned char *pt =
	    (unsigned char *) (base->data + row * base->bytes_per_line);
	 afwrite(pt, 1, base->bytes_per_line, file);
	 pad=4 - (base->bytes_per_line & 3);
      }
      if (pad & 1)		/* pad to 4byte boundary */
	 aputc('\0', file);
      if (pad & 2)
	 aput_int16_le(0, file);
   }
   i=aferror(file);
   return !i;
}

int GImageWriteBmp(GImage *gi, char *filename) {
   AFILE *file;
   int ret;

   if ((file=afopen(filename, "wb")) == NULL)
      return (false);
   ret=GImageWrite_Bmp(gi, file);
   afclose(file);
   return ret;
}

/**********************************************************************/

/* COMPUSERVE GRAPHICS INTERCHANGE FORMAT (GIF) */

#ifdef _NO_LIBUNGIF

#else /* We can build with gif_lib - therefore import gif files */

#   include "fontanvil.h"
#   include <string.h>
#   include "gimage.h"
#   include <gif_lib.h>

#   if defined(GIFLIB_MAJOR) && defined(GIFLIB_MINOR)
#    if ((GIFLIB_MAJOR==5) && (GIFLIB_MINOR>=1)) || (GIFLIB_MAJOR>5)
#     define _GIFLIB_51PLUS
#    endif
#   endif

static GImage *ProcessSavedImage(GifFileType *gif,struct SavedImage *si,
				 int il) {
   /* Process each gif image into an internal FF format. Return NULL if error */
   GImage *ret;
   struct _GImage *base;
   ColorMapObject *m=gif->SColorMap;	/* gif_lib.h, NULL if not exists. */
   int i,j,k,*id;
   long l;
   uint8_t *d,*iv;
   
   /* Create memory to hold image, exit with NULL if not enough memory */
   if (si->ImageDesc.ColorMap!=NULL)
     m=si->ImageDesc.ColorMap;
   if (m==NULL)
     return NULL;
   if (m->BitsPerPixel==1) {
      if ((ret=GImageCreate(it_bitmap,si->ImageDesc.Width,
			    si->ImageDesc.Height))==NULL)
	return NULL;
      if ((m->ColorCount==2) &&
	  (m->Colors[0].Red==0) && (m->Colors[0].Green==0) &&
	  (m->Colors[0].Blue==0) && (m->Colors[1].Red==255) &&
	  (m->Colors[1].Green==255) && (m->Colors[1].Blue==255))
	/* Don't need a clut */ ;
      else
	if ((ret->u.image->clut=(GClut *)calloc(1,sizeof(GClut)))==NULL) {
	   free(ret);
	   return NULL;
	}
   } else
     if ((ret=GImageCreate(it_index,si->ImageDesc.Width,
			   si->ImageDesc.Height))==NULL)
       return (NULL);
   if (il && ((id=(int *)malloc(si->ImageDesc.Height*sizeof(int)))==NULL
	      || (iv=(uint8_t *)malloc(si->ImageDesc.Height*
				       sizeof(uint8_t)))==NULL)) {
      free(ret->u.image->clut);
      free(ret);
      free(id);
      free(iv);
      return NULL;
   }

   /* Process gif image into an internal FF usable format */
   base=ret->u.image;
   if (base->clut!=NULL) {
      base->clut->clut_len=m->ColorCount;
      for (i=0;i<m->ColorCount;i++)
	base->clut->clut[i]=
	COLOR_CREATE(m->Colors[i].Red,m->Colors[i].Green,
		     m->Colors[i].Blue);
   }
   if (m->BitsPerPixel!=1)
     memcpy(base->data,si->RasterBits,base->width *base->height);
   else if (m->BitsPerPixel==1) {
      l=0;
      for (i=0;i<base->height;i++) {
	 d=(base->data+i*base->bytes_per_line);
	 memset(d,'\0',base->bytes_per_line);
	 for (j=0;j<base->width;j++) {
	    if (si->RasterBits[l])
	      d[j>>3]|=(1<<(7-(j&7)));
	    l++;
	 }
      }
   }
   if (il) {
      /* Convert interlaced image into a sequential image */
      j=0;
      k=0;
      for (i=0; i < base->height;i++) {
	 id[i]=k;
	 if (j == 0) {
	    k += 8;
	    if (k >= base->height) {
	       j++;
	       k=4;
	    }
	 } else if (j == 1) {
	    k += 8;
	    if (k >= base->height) {
	       j++;
	       k=2;
	    }
	 } else if (j == 2) {
	    k += 4;
	    if (k >= base->height) {
	       j++;
	       k=1;
	    }
	 } else
	    k += 2;
      }
      for (j=0; j < base->bytes_per_line;j++) {
	 for (i=1; i < base->height;i++)
	    iv[id[i]]=base->data[i * base->bytes_per_line + j];
	 for (i=1; i < base->height;i++)
	    base->data[i * base->bytes_per_line + j]=iv[i];
      }
      free(id);
      free(iv);
   }
   for (i=0; i < si->ExtensionBlockCount;i++) {
      if (si->ExtensionBlocks[i].Function == 0xf9 &&
	  si->ExtensionBlocks[i].ByteCount >= 4) {
	 base->delay=(si->ExtensionBlocks[i].Bytes[2] << 8) |
	    (si->ExtensionBlocks[i].Bytes[2] & 0xff);
	 if (si->ExtensionBlocks[i].Bytes[0] & 1) {
	    base->trans=(unsigned char) si->ExtensionBlocks[i].Bytes[3];
	    if (base->clut != NULL)
	       base->clut->trans_index=base->trans;
	 }
      }
   }
   return (ret);
}


GImage *GImageReadGif(char *filename) {
/* Import a gif image (or gif animation), else return NULL if error  */
   GImage *ret,**images;
   GifFileType *gif;
   int i,il;

   /* MIQ: As at mid 2013 giflib version 4 is still the current
    * version in some environments. Given that this function call
    * seems to be the only incompatible change in what FontAnvil uses
    * as at that time, I added a smoother macro here to allow v4 to
    * still work OK for the time being. */
#   if defined(GIFLIB_MAJOR) && GIFLIB_MAJOR >= 5
   if ((gif=DGifOpenFileName(filename, NULL)) == NULL) {
#   else
   if ((gif=DGifOpenFileName(filename)) == NULL) {
#   endif
      fprintf(stderr, "Can't open \"%s\"\n", filename);
      return (NULL);
   }

   if (DGifSlurp(gif) != GIF_OK) {
      fprintf(stderr, "Bad input file \"%s\"\n", filename);
#   ifdef _GIFLIB_51PLUS
      DGifCloseFile(gif,NULL);
#   else
      DGifCloseFile(gif);
#   endif
      return (NULL);
   }

   /* Process each image so that it/they can be imported into FF. */
   if ((images =
	(GImage **) malloc(gif->ImageCount * sizeof(GImage *))) == NULL) {
#   ifdef _GIFLIB_51PLUS
      DGifCloseFile(gif,NULL);
#   else
      DGifCloseFile(gif);
#   endif
      return (NULL);
   }
   il=gif->SavedImages[0].ImageDesc.Interlace;
   for (i=0; i < gif->ImageCount;i++) {
      if ((images[i] =
	   ProcessSavedImage(gif, &gif->SavedImages[i], il)) == NULL) {
	 while (--i >= 0)
	    free(images[i]);
	 free(images);
#   ifdef _GIFLIB_51PLUS
	 DGifCloseFile(gif,NULL);
#   else
	 DGifCloseFile(gif);
#   endif
	 return (NULL);
      }
   }

   /* All okay if you reached here. We have 1 image or several images */
   if (gif->ImageCount == 1)
      ret=images[0];
   else
      ret=GImageCreateAnimation(images, gif->ImageCount);
#   ifdef _GIFLIB_51PLUS
      DGifCloseFile(gif,NULL);
#   else
      DGifCloseFile(gif);
#   endif
   free(images);
   return (ret);
}

#endif /* ! _NO_LIBUNGIF */

/**********************************************************************/

/* JOINT PHOTOGRAPHIC EXPERTS GROUP (JPEG) */

#ifdef _NO_LIBJPEG

#else /* We can build with jpeglib - therefore import jpg files */

#   include <sys/types.h>
#   include <stdio.h>
#   include <jpeglib.h>
#   include <jerror.h>

struct jpegState {
   struct jpeg_decompress_struct *cinfo;
   int state;
   struct _GImage *base;
   JSAMPLE *buffer;
   int scanpos;
};

struct my_error_mgr {
   struct jpeg_error_mgr pub;	/* "public" fields */

   jmp_buf setjmp_buffer;	/* for return to caller */
   int padding[8];		/* On my solaris box jmp_buf is the wrong size */
};

typedef struct my_error_mgr *my_error_ptr;

METHODDEF(void) my_error_exit(j_common_ptr cinfo) {
   /* cinfo->err really points to a my_error_mgr struct, so coerce pointer */
   my_error_ptr myerr=(my_error_ptr) cinfo->err;

   /* Always display the message. */
   /* We could postpone this until after returning, if we chose. */
   (*cinfo->err->output_message) (cinfo);

   /* Return control to the setjmp point */
   longjmp(myerr->setjmp_buffer, 1);
}

/* jpeg routines use 24 bit pixels, xvt routines pad out to 32 */
static void transferBufferToImage(struct jpegState *js, int ypos) {
   struct jpeg_decompress_struct *cinfo=js->cinfo;
   JSAMPLE *pt, *end;
   Color *ppt;

   ppt=(Color *) (js->base->data + ypos * js->base->bytes_per_line);
   for (pt=js->buffer, end=pt + 3 * cinfo->image_width; pt < end;) {
      register int r, g, b;

      r=*(pt++);
      g=*(pt++);
      b=*(pt++);
      *(ppt++)=COLOR_CREATE(r, g, b);
   }
}

#define JPEG_BUFFER_SIZE 4096

typedef struct _FA_JPEG_SRCMGR {
   struct jpeg_source_mgr pub;
   AFILE *fp;
   char buffer[JPEG_BUFFER_SIZE];
} FA_JPEG_SRCMGR;

static void fajpeg_init_source(j_decompress_ptr cinfo) {
   cinfo->src->next_input_byte=
     (JOCTET *)(&(((FA_JPEG_SRCMGR *)cinfo->src)->buffer));
   cinfo->src->bytes_in_buffer=0;
}

static boolean fajpeg_fill_input_buffer(j_decompress_ptr cinfo) {
   size_t res;
   
   res=afread(&(((FA_JPEG_SRCMGR *)cinfo->src)->buffer),
	      sizeof(char),JPEG_BUFFER_SIZE,
	      ((FA_JPEG_SRCMGR *)cinfo->src)->fp);
   if (res<=0) {
      ERREXIT(cinfo,JERR_INPUT_EOF);
   }

   cinfo->src->next_input_byte=
     (JOCTET *)(&(((FA_JPEG_SRCMGR *)cinfo->src)->buffer));
   cinfo->src->bytes_in_buffer=res;

   return TRUE;
}

static void fajpeg_skip_input_data(j_decompress_ptr cinfo,long num_bytes) {
   while (num_bytes>cinfo->src->bytes_in_buffer) {
      num_bytes-=cinfo->src->bytes_in_buffer;
      fajpeg_fill_input_buffer(cinfo);
   }
   if (num_bytes>0) {
      cinfo->src->next_input_byte+=num_bytes;
      cinfo->src->bytes_in_buffer-=num_bytes;
   }
}

static void fajpeg_term_source(j_decompress_ptr cinfo) {
   /* NOOP */
}

static void fajpeg_afile_src(j_decompress_ptr cinfo,AFILE *infile) {
      FA_JPEG_SRCMGR *sm;
   
      sm=(FA_JPEG_SRCMGR *)malloc(sizeof(FA_JPEG_SRCMGR));
   
      sm->fp=infile;
      sm->pub.init_source=fajpeg_init_source;
      sm->pub.fill_input_buffer=fajpeg_fill_input_buffer;
      sm->pub.skip_input_data=fajpeg_skip_input_data;
      sm->pub.resync_to_restart=jpeg_resync_to_restart;
      sm->pub.term_source=fajpeg_term_source;
   
      cinfo->src=(struct jpeg_source_mgr *)sm;
}


GImage *GImageRead_Jpeg(AFILE *infile) {
   GImage *ret;
   struct _GImage *base;
   struct jpeg_decompress_struct cinfo;
   struct my_error_mgr jerr;
   JSAMPLE *rows[1];
   struct jpegState js;
   int ypos;


   cinfo.err=jpeg_std_error(&jerr.pub);
   jerr.pub.error_exit=my_error_exit;
   if (setjmp(jerr.setjmp_buffer)) {
      jpeg_destroy_decompress(&cinfo);
      return NULL;
   }

   jpeg_CreateDecompress(&cinfo,JPEG_LIB_VERSION,
			 (size_t) sizeof(struct jpeg_decompress_struct));
   fajpeg_afile_src(&cinfo,infile);
   (void)jpeg_read_header(&cinfo, TRUE);

   if (cinfo.jpeg_color_space==JCS_GRAYSCALE)
      cinfo.out_color_space=JCS_RGB;
   ret=GImageCreate(it_true,cinfo.image_width,cinfo.image_height);
   if (ret==NULL) {
      free(cinfo.src);
      cinfo.src=NULL;
      jpeg_destroy_decompress(&cinfo);
      return NULL;
   }
   base=ret->u.image;

   (void)jpeg_start_decompress(&cinfo);
   rows[0]=(JSAMPLE *)malloc(3*cinfo.image_width);
   js.cinfo=&cinfo;
   js.base=base;
   js.buffer=rows[0];
   while (cinfo.output_scanline<cinfo.output_height) {
      ypos=cinfo.output_scanline;
      (void)jpeg_read_scanlines(&cinfo,rows,1);
      transferBufferToImage(&js,ypos);
   }

   (void)jpeg_finish_decompress(&cinfo);
   free(cinfo.src);
   cinfo.src=NULL;
   jpeg_destroy_decompress(&cinfo);
   free(rows[0]);

   return ret;
}

GImage *GImageReadJpeg(char *filename) {
/* Import a jpeg image, else return NULL if error  */
   GImage *ret;
   AFILE *infile;		/* source file */

   if ((infile=afopen(filename,"rb"))==NULL) {
      ErrorMsg(2,"Can't open \"%s\"\n",filename);
      return NULL;
   }

   ret=GImageRead_Jpeg(infile);
   afclose(infile);
   return ret;
}


static void transferImageToBuffer(struct _GImage *base, JSAMPLE * buffer,
				  int w, int ypos) {
   JSAMPLE *pt, *end;

   uint32_t *ppt;

   ppt=(uint32_t *) (base->data + ypos * base->bytes_per_line);
   if (base->image_type == it_index && base->clut == NULL) {
      unsigned char *px=(unsigned char *) ppt;

      int col;

      register int bit=0x80;

      for (pt=buffer, end=pt + 3 * w; pt < end;) {
	 if (*px & bit)
	    col=0xffffff;
	 else
	    col=0;
	 if ((bit >>= 1) == 0) {
	    ++px;
	    bit=0x80;
	 }
	 *pt++=COLOR_RED(col);
	 *pt++=COLOR_GREEN(col);
	 *pt++=COLOR_BLUE(col);
      }
   } else if (base->image_type == it_index) {
      unsigned char *px=(unsigned char *) ppt;

      int col;

      register int bit=0x80;

      for (pt=buffer, end=pt + 3 * w; pt < end;) {
	 if (*px & bit)
	    col=base->clut->clut[1];
	 else
	    col=base->clut->clut[0];
	 if ((bit >>= 1) == 0) {
	    ++px;
	    bit=0x80;
	 }
	 *pt++=COLOR_RED(col);
	 *pt++=COLOR_GREEN(col);
	 *pt++=COLOR_BLUE(col);
      }
   } else if (base->image_type == it_index) {
      unsigned char *px=(unsigned char *) ppt;

      int col;

      for (pt=buffer, end=pt + 3 * w; pt < end;) {
	 col=base->clut->clut[*px++];
	 *pt++=COLOR_RED(col);
	 *pt++=COLOR_GREEN(col);
	 *pt++=COLOR_BLUE(col);
      }
   } else {
      for (pt=buffer, end=pt + 3 * w; pt < end; ++ppt) {
	 *pt++=COLOR_RED(*ppt);
	 *pt++=COLOR_GREEN(*ppt);
	 *pt++=COLOR_BLUE(*ppt);
      }
   }
}

static void setColorSpace(struct jpeg_compress_struct *cinfo,
			  struct _GImage *base) {
   int i;

   cinfo->input_components=3;	/* # of color components per pixel */
   cinfo->in_color_space=JCS_RGB;	/* colorspace of input image */

   if (base->image_type == it_index) {
      if (base->clut->clut_len != 256)
	 return;
      for (i=0; i < 256;i++)
	 if (base->clut->clut[i] != COLOR_CREATE(i, i, i))
	    break;
      if (i == 256) {
	 cinfo->input_components=1;
	 cinfo->in_color_space=JCS_GRAYSCALE;
      }
   }
}

#define JPEG_BUFFER_SIZE 4096

typedef struct _FA_JPEG_DESTMGR {
   struct jpeg_destination_mgr pub;
   AFILE *fp;
   char buffer[JPEG_BUFFER_SIZE];
} FA_JPEG_DESTMGR;

static void fajpeg_init_destination(j_compress_ptr cinfo) {
   cinfo->dest->next_output_byte=
     (JOCTET *)(&(((FA_JPEG_DESTMGR *)cinfo->dest)->buffer));
   cinfo->dest->free_in_buffer=JPEG_BUFFER_SIZE;
}

static boolean fajpeg_empty_output_buffer(j_compress_ptr cinfo) {
   afwrite(&(((FA_JPEG_DESTMGR *)cinfo->dest)->buffer),
	   sizeof(char),JPEG_BUFFER_SIZE,
	   ((FA_JPEG_DESTMGR *)cinfo->dest)->fp);
   fajpeg_init_destination(cinfo);
   return TRUE;
}

static void fajpeg_term_destination(j_compress_ptr cinfo) {
   afwrite(&(((FA_JPEG_DESTMGR *)cinfo->dest)->buffer),
	   sizeof(char),
	   JPEG_BUFFER_SIZE-cinfo->dest->free_in_buffer,
	   ((FA_JPEG_DESTMGR *)cinfo->dest)->fp);
   fajpeg_init_destination(cinfo);
}

static void fajpeg_afile_dest(j_compress_ptr cinfo,AFILE *outfile) {
   FA_JPEG_DESTMGR *dm;
   
   dm=(FA_JPEG_DESTMGR *)malloc(sizeof(FA_JPEG_DESTMGR));
   
   dm->fp=outfile;
   dm->pub.init_destination=fajpeg_init_destination;
   dm->pub.empty_output_buffer=fajpeg_empty_output_buffer;
   dm->pub.term_destination=fajpeg_term_destination;
   
   cinfo->dest=(struct jpeg_destination_mgr *)dm;
}

/* quality is a number between 0 and 100 */
int GImageWrite_Jpeg(GImage *gi,AFILE *outfile,int quality,
		     int progressive) {
   struct _GImage *base=gi->list_len == 0 ? gi->u.image : gi->u.images[0];
   struct jpeg_compress_struct cinfo;
   struct my_error_mgr jerr;

   JSAMPROW row_pointer[1];	/* pointer to JSAMPLE row[s] */

   cinfo.err=jpeg_std_error(&jerr.pub);
   jerr.pub.error_exit=my_error_exit;
   if (setjmp(jerr.setjmp_buffer)) {
      jpeg_destroy_compress(&cinfo);
      return 0;
   }
   jpeg_CreateCompress(&cinfo, JPEG_LIB_VERSION,
		       (size_t) sizeof(struct jpeg_compress_struct));
   fajpeg_afile_dest(&cinfo, outfile);

   cinfo.image_width=base->width;
   cinfo.image_height=base->height;
   setColorSpace(&cinfo, base);
   jpeg_set_defaults(&cinfo);
   jpeg_set_quality(&cinfo, quality, TRUE);
   if (progressive)
      jpeg_simple_progression(&cinfo);
   jpeg_start_compress(&cinfo, TRUE);

   if (cinfo.in_color_space != JCS_GRAYSCALE)
      row_pointer[0]=(JSAMPROW) malloc(3 * base->width);
   while (cinfo.next_scanline < cinfo.image_height) {
      if (cinfo.in_color_space == JCS_GRAYSCALE)
	 row_pointer[0] =
	    (unsigned char *) (base->data +
			       cinfo.next_scanline * base->bytes_per_line);
      else
	 transferImageToBuffer(base, row_pointer[0], base->width,
			       cinfo.next_scanline);
      (void) jpeg_write_scanlines(&cinfo, row_pointer, 1);
   }
   jpeg_finish_compress(&cinfo);
   free(cinfo.dest);
   cinfo.dest=NULL;
   jpeg_destroy_compress(&cinfo);
   if (cinfo.in_color_space != JCS_GRAYSCALE)
      free(row_pointer[0]);
   return 1;
}

#endif

/**********************************************************************/

/* PORTABLE NETWORK GRAPHICS (PNG) */

#ifdef _NO_LIBPNG

#else

static void *libpng=(void *) 1;

static int loadpng() {
   return true;
}

static void user_error_fn(png_structp png_ptr, png_const_charp error_msg) {
   ErrorMsg(2,"%s\n", error_msg);
#   if (PNG_LIBPNG_VER < 10500)
   longjmp(png_ptr->jmpbuf, 1);
#   else
   png_longjmp(png_ptr, 1);
#   endif
}

static void user_warning_fn(png_structp png_ptr, png_const_charp warning_msg) {
   ErrorMsg(2,"%s\n",warning_msg);
}

static void fapng_read_data(png_structp png_ptr,
			    png_bytep data,png_size_t length) {
   afread(data,1,length,(AFILE *)png_get_io_ptr(png_ptr));
}

GImage *GImageRead_Png(AFILE *fp) {
   GImage *ret=NULL;
   struct _GImage *base;
   png_structp png_ptr;
   png_infop info_ptr;
   png_bytep *row_pointers=NULL;
   png_bytep trans_alpha;
   int num_trans;
   png_color_16p trans_color;
   int i;

   if (libpng==NULL)
      if (!loadpng())
	 return NULL;

   png_ptr=png_create_read_struct(PNG_LIBPNG_VER_STRING,
				  (void *) NULL, user_error_fn,
				  user_warning_fn);

   if (!png_ptr)
      return NULL;

   info_ptr=png_create_info_struct(png_ptr);
   if (!info_ptr) {
      png_destroy_read_struct(&png_ptr,(png_infopp)NULL,(png_infopp)NULL);
      return NULL;
   }
#   if (PNG_LIBPNG_VER<10500)
   if (setjmp(png_ptr->jmpbuf))
#   else
   if (setjmp(*png_set_longjmp_fn(png_ptr,longjmp,sizeof(jmp_buf))))
#   endif
   {
      /* Free all of the memory associated with the png_ptr and info_ptr */
      png_destroy_read_struct(&png_ptr, &info_ptr, (png_infopp) NULL);
      if (ret!=NULL) {
	 GImageDestroy(ret);
	 free(row_pointers);
      }
      /* If we get here, we had a problem reading the file */
      return NULL;
   }

   png_set_read_fn(png_ptr,(void *)fp,fapng_read_data);
   png_read_info(png_ptr, info_ptr);
   png_set_strip_16(png_ptr);
   if ((png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_GRAY
	|| png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_PALETTE)
       && png_get_bit_depth(png_ptr, info_ptr) == 1)
      /* Leave bitmaps packed */ ;
   else
      png_set_packing(png_ptr);
   if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_GRAY_ALPHA)
      png_set_strip_alpha(png_ptr);
   if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_RGB)
      png_set_filler(png_ptr, 0xff, PNG_FILLER_AFTER);

   if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_GRAY
       && png_get_bit_depth(png_ptr, info_ptr) == 1) {
      ret =
	 GImageCreate(it_mono, png_get_image_width(png_ptr, info_ptr),
		      png_get_image_height(png_ptr, info_ptr));
   } else if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_GRAY
	      || png_get_color_type(png_ptr,
				    info_ptr) == PNG_COLOR_TYPE_GRAY_ALPHA) {
      GClut *clut;

      ret =
	 GImageCreate(it_index, png_get_image_width(png_ptr, info_ptr),
		      png_get_image_height(png_ptr, info_ptr));
      clut=ret->u.image->clut;
      clut->is_grey=true;
      clut->clut_len=256;
      for (i=0; i < 256;i++)
	 clut->clut[i]=COLOR_CREATE(i, i, i);
   } else if (png_get_color_type(png_ptr, info_ptr) ==
	      PNG_COLOR_TYPE_RGB_ALPHA) {
      ret =
	 GImageCreate(it_rgba, png_get_image_width(png_ptr, info_ptr),
		      png_get_image_height(png_ptr, info_ptr));
   } else if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_RGB
	      || png_get_color_type(png_ptr,
				    info_ptr) == PNG_COLOR_TYPE_RGB_ALPHA)
      ret =
	 GImageCreate(it_true, png_get_image_width(png_ptr, info_ptr),
		      png_get_image_height(png_ptr, info_ptr));
   else {
      png_colorp palette;
      int num_palette;
      GClut *clut;

      ret =
	 GImageCreate(png_get_bit_depth(png_ptr, info_ptr) !=
		      1 ? it_index : it_mono, png_get_image_width(png_ptr,
								  info_ptr),
		      png_get_image_height(png_ptr, info_ptr));
      clut=ret->u.image->clut;
      if (clut == NULL)
	 clut=ret->u.image->clut=(GClut *) calloc(1, sizeof(GClut));
      clut->is_grey=true;
      png_get_PLTE(png_ptr, info_ptr, &palette, &num_palette);
      clut->clut_len=num_palette;
      for (i=0; i < num_palette;i++)
	 clut->clut[i]=COLOR_CREATE(palette[i].red,
				      palette[i].green, palette[i].blue);
   }
   png_get_tRNS(png_ptr, info_ptr, &trans_alpha, &num_trans, &trans_color);
   base=ret->u.image;
   if ((png_get_valid(png_ptr, info_ptr, PNG_INFO_tRNS)) && num_trans > 0) {
      if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_RGB
	  || png_get_color_type(png_ptr,
				info_ptr) == PNG_COLOR_TYPE_RGB_ALPHA)
	 base->trans =
	    COLOR_CREATE((trans_color->red >> 8), (trans_color->green >> 8),
			 (trans_color->blue >> 8));
      else if (base->image_type == it_mono)
	 base->trans=trans_alpha ? trans_alpha[0] : 0;
      else
	 base->clut->trans_index=base->trans =
	    trans_alpha ? trans_alpha[0] : 0;
   }

   row_pointers =
      (png_byte **) malloc(png_get_image_height(png_ptr, info_ptr) *
			   sizeof(png_bytep));
   for (i=0; i < png_get_image_height(png_ptr, info_ptr);i++)
      row_pointers[i]=(png_bytep) (base->data + i * base->bytes_per_line);

   /* Ignore progressive loads for now */
   /* libpng wants me to do it with callbacks, but that doesn't sit well */
   /*  with my wish to be in control... */
   png_read_image(png_ptr, row_pointers);
   png_read_end(png_ptr, NULL);

   if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_RGB
       || png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_RGB_ALPHA) {
      /* PNG orders its bytes as AABBGGRR instead of 00RRGGBB */
      uint32_t *ipt, *iend;

      for (ipt=(uint32_t *) (base->data), iend =
	   ipt + base->width * base->height; ipt < iend; ++ipt) {
	 uint32_t r, g, b, a=*ipt & 0xff000000;

	 r=(*ipt) & 0xff;
	 g=(*ipt >> 8) & 0xff;
	 b=(*ipt >> 16) & 0xff;
	 *ipt=COLOR_CREATE(r, g, b) | a;
      }
   }

   png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
   free(row_pointers);
   /* Note png b&w images come out as indexed */
   return (ret);
}

GImage *GImageReadPng(char *filename) {
   GImage *ret=NULL;
   AFILE *fp;

   fp=afopen(filename, "rb");
   if (!fp)
      return NULL;

   ret=GImageRead_Png(fp);
   afclose(fp);
   return ret;
}


static void fa_png_write_cb(png_structp png_ptr,png_bytep data,
			    png_size_t length) {
   if (afwrite(data,1,length,(AFILE *)png_get_io_ptr(png_ptr))<0)
      png_error(png_ptr,"Error writing PNG");
}

static void fa_png_flush_cb(png_structp png_ptr) {
   /* NOOP */
}

int GImageWrite_Png(GImage *gi,AFILE *fp,int progressive) {
   struct _GImage *base=gi->list_len==0?gi->u.image:gi->u.images[0];
   png_structp png_ptr;
   png_infop info_ptr;
   png_byte **rows;
   int i;
   int bit_depth;
   int color_type;
   int num_palette;
   png_bytep trans_alpha=NULL;
   png_color_16p trans_color=NULL;
   png_colorp palette=NULL;
   png_ptr=png_create_write_struct(PNG_LIBPNG_VER_STRING,
				   (void *) NULL, user_error_fn,
				   user_warning_fn);

   if (!png_ptr) {
      return (false);
   }

   info_ptr=png_create_info_struct(png_ptr);
   if (!info_ptr) {
      png_destroy_write_struct(&png_ptr, (png_infopp) NULL);
      return (false);
   }
#   if (PNG_LIBPNG_VER < 10500)
   if (setjmp(png_ptr->jmpbuf))
#   else
   if (setjmp(*png_set_longjmp_fn(png_ptr, longjmp, sizeof(jmp_buf))))
#   endif
   {
      png_destroy_write_struct(&png_ptr,(png_infopp)NULL);
      return (false);
   }

   png_set_write_fn(png_ptr,fp,&fa_png_write_cb,&fa_png_flush_cb);

   bit_depth=8;
   num_palette=base->clut == NULL ? 2 : base->clut->clut_len;
   if (base->image_type == it_index || base->image_type == it_bitmap) {
      color_type=PNG_COLOR_TYPE_PALETTE;
      if (num_palette <= 2)
	 bit_depth=1;
      else if (num_palette <= 4)
	 bit_depth=2;
      else if (num_palette <= 16)
	 bit_depth=4;
   } else {
      color_type=PNG_COLOR_TYPE_RGB;
      if (base->image_type == it_rgba)
	 color_type=PNG_COLOR_TYPE_RGB_ALPHA;
   }

   png_set_IHDR(png_ptr, info_ptr, base->width, base->height,
		bit_depth, color_type, progressive,
		PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);
   if (base->image_type == it_index || base->image_type == it_bitmap) {
      palette=(png_color *) malloc(num_palette * sizeof(png_color));
      if (base->clut == NULL) {
	 palette[0].red=palette[0].green=palette[0].blue=0;
	 palette[1].red=palette[1].green=palette[1].blue=0xff;
      } else {
	 for (i=0; i < num_palette;i++) {
	    long col=base->clut->clut[i];

	    palette[i].red=COLOR_RED(col);
	    palette[i].green=COLOR_GREEN(col);
	    palette[i].blue=COLOR_BLUE(col);
	 }
      }
      png_set_PLTE(png_ptr, info_ptr, palette, num_palette);
      if (num_palette <= 16)
	 png_set_packing(png_ptr);

      if (base->trans != -1) {
	 trans_alpha=(png_bytep) malloc(1);
	 trans_alpha[0]=base->trans;
      }
   } else {
      if (base->trans != -1) {
	 trans_color=(png_color_16p) malloc(sizeof(png_color_16));
	 trans_color->red=COLOR_RED(base->trans);
	 trans_color->green=COLOR_GREEN(base->trans);
	 trans_color->blue=COLOR_BLUE(base->trans);
      }
   }
   if (base->trans != -1) {
      png_set_tRNS(png_ptr, info_ptr, trans_alpha, 1, trans_color);
   }
   png_write_info(png_ptr, info_ptr);

   if (color_type == PNG_COLOR_TYPE_RGB)
      png_set_filler(png_ptr, '\0', PNG_FILLER_BEFORE);

   rows=(png_byte **) malloc(base->height * sizeof(png_byte *));
   for (i=0; i < base->height;i++)
      rows[i]=(png_byte *) (base->data + i * base->bytes_per_line);

   png_write_image(png_ptr, rows);

   png_write_end(png_ptr, info_ptr);

   free(trans_alpha);
   free(trans_color);
   free(palette);
   png_destroy_write_struct(&png_ptr, &info_ptr);
   free(rows);
   return (1);
}

int GImageWritePng(GImage *gi,char *filename,int progressive) {
   AFILE *fp;

   int ret;

   /* open the file */
   fp=afopen(filename, "wb");
   if (!fp)
      return (false);
   ret=GImageWrite_Png(gi,fp,progressive);
   afclose(fp);
   return (ret);
}

#endif

/**********************************************************************/

/* SUN/CMU RASTER (RAS) */

typedef struct _SunRaster {
   int32_t MagicNumber;		/* Magic (identification) number */
   int32_t Width;			/* Width of image in pixels */
   int32_t Height;			/* Height of image in pixels */
   int32_t Depth;			/* Number of bits per pixel */
   int32_t Length;			/* Size of image data in bytes */
   int32_t Type;			/* Type of raster file */
   int32_t ColorMapType;		/* Type of color map */
   int32_t ColorMapLength;		/* Size of the color map in bytes */
} SUNRASTER;

#define SUN_RAS_MAGIC	0x59a66a95
#define LITTLE_ENDIAN_MAGIC	0x956aa659	/* if we read this value, must byte swap */

enum types { TypeOld, TypeStandard, TypeByteEncoded, TypeRGB, TypeTIFF,
      TypeIFF };
enum cluts { ClutNone, ClutRGB, ClutRaw };

static int getrasheader(SUNRASTER *head,AFILE *fp) {
/* Get Header info. Return 0 if read input file okay, -1 if read error	*/
   if (aread_int32_le(fp, &head->MagicNumber) ||
       (head->MagicNumber != SUN_RAS_MAGIC
	&& head->MagicNumber != LITTLE_ENDIAN_MAGIC)
       || aread_int32_le(fp, &head->Width) || aread_int32_le(fp, &head->Height)
       || aread_int32_le(fp, &head->Depth) || aread_int32_le(fp, &head->Length)
       || aread_int32_le(fp, &head->Type) || aread_int32_le(fp, &head->ColorMapType)
       || aread_int32_le(fp, &head->ColorMapLength))
      return (-1);

   /* Check if header information okay (only try Big-Endian for now).  */
   if (head->MagicNumber != SUN_RAS_MAGIC ||
       head->Type < 0 || head->Type > TypeRGB ||
       (head->ColorMapType != ClutNone && head->ColorMapType != ClutRGB) ||
       (head->Depth != 1 && head->Depth != 8 && head->Depth != 24
	&& head->Depth != 32) || (head->Depth >= 24
				  && head->ColorMapType != ClutNone)
       || head->ColorMapLength > 3 * 256)
      return (-1);

   return (0);
}

static GImage *ReadRasBitmap(GImage * ret, int width, int height,AFILE *fp) {
   struct _GImage *base=ret->u.image;
   int i, j, len;
   unsigned char *pt, *buf;

   len=((width + 15) / 16) * 2;	/* pad out to 16 bits */
   if ((buf=(unsigned char *) malloc(len * sizeof(unsigned char))) == NULL) {
      GImageDestroy(ret);
      return NULL;
   }

   for (i=0; i < height;i++) {
      if (afread(buf, len, 1, fp) < 1) {
	 free(buf);
	 GImageDestroy(ret);
	 return NULL;
      }
      pt=(unsigned char *) (base->data + i * base->bytes_per_line);
      for (j=0; j < (width + 7) >> 3;j++)
	 pt[j]=256 - buf[j];
   }
   free(buf);
   return (ret);
}

static GImage *ReadRas8Bit(GImage *ret,int width,int height,AFILE *fp) {
   struct _GImage *base=ret->u.image;
   int i;

   for (i=0; i < height;i++) {
      if (afread((base->data + i * base->bytes_per_line), width, 1, fp) < 1) {
	 goto errorReadRas8Bit;
      }
      if (width & 1)		/* pad out to 16 bits */
	 if (agetc(fp) < 0)
	    goto errorReadRas8Bit;
   }
   return ret;

 errorReadRas8Bit:
   GImageDestroy(ret);
   return NULL;
}

static GImage *ReadRas24Bit(GImage *ret,int width,int height,AFILE *fp) {
   struct _GImage *base=ret->u.image;
   int ch1, ch2, ch3=0;
   int i;
   long *ipt, *end;

   for (i=0; i < height;i++) {
      for (ipt=(long *) (base->data + i * base->bytes_per_line), end =
	   ipt + width; ipt < end;) {
	 if ((ch1=agetc(fp)) < 0 || (ch2=agetc(fp)) < 0
	     || (ch3=agetc(fp)) < 0)
	    goto errorReadRas24Bit;
	 *ipt++=COLOR_CREATE(ch3, ch2, ch1);
      }
      if (width & 1)		/* pad out to 16 bits */
	 if (agetc(fp) < 0)
	    goto errorReadRas24Bit;
   }
   return ret;

 errorReadRas24Bit:
   GImageDestroy(ret);
   return NULL;
}

static GImage *ReadRas32Bit(GImage * ret, int width, int height,AFILE *fp) {
   struct _GImage *base=ret->u.image;
   int ch1, ch2, ch3=0;
   int i;
   long *ipt, *end;

   for (i=0; i < height;i++)
      for (ipt=(long *) (base->data + i * base->bytes_per_line), end =
	   ipt + width; ipt < end;) {
	 agetc(fp);		/* pad byte */
	 ch1=agetc(fp);
	 ch2=agetc(fp);
	 ch3=agetc(fp);
	 *ipt++=COLOR_CREATE(ch3, ch2, ch1);
      }
   if (ch3 == EOF) {
      GImageDestroy(ret);
      ret=NULL;
   }
   return ret;
}

static GImage *ReadRas24RBit(GImage *ret,int width,int height,AFILE *fp) {
   struct _GImage *base=ret->u.image;
   int ch1, ch2, ch3=0;
   int i;
   long *ipt, *end;

   for (i=0; i < height;i++) {
      for (ipt=(long *) (base->data + i * base->bytes_per_line), end =
	   ipt + width; ipt < end;) {
	 if ((ch1=agetc(fp)) < 0 || (ch2=agetc(fp)) < 0
	     || (ch3=agetc(fp)) < 0)
	    goto errorReadRas24RBit;
	 *ipt++=COLOR_CREATE(ch1, ch2, ch3);
      }
      if (width & 1)		/* pad out to 16 bits */
	 if (agetc(fp) < 0)
	    goto errorReadRas24RBit;
   }
   return (ret);

 errorReadRas24RBit:
   GImageDestroy(ret);
   return NULL;
}

static GImage *ReadRas32RBit(GImage *ret,int width,int height,AFILE *fp) {
   struct _GImage *base=ret->u.image;
   int ch1, ch2, ch3=0;
   int i;
   long *ipt, *end;

   for (i=0; i < height;i++)
      for (ipt=(long *) (base->data + i * base->bytes_per_line), end =
	   ipt + width; ipt < end;) {
	 agetc(fp);		/* pad byte */
	 ch1=agetc(fp);
	 ch2=agetc(fp);
	 ch3=agetc(fp);
	 *ipt++=COLOR_CREATE(ch1, ch2, ch3);
      }
   if (ch3 == EOF) {
      GImageDestroy(ret);
      ret=NULL;
   }
   return ret;
}

static GImage *ReadRle8Bit(GImage *ret,int width,int height,AFILE *fp) {
/* TODO: Make this an input filter that goes in front of other routines	*/
/* above so that in can be re-used by the different converters above.	*/
   struct _GImage *base=ret->u.image;
   int x, y, cnt, val;
   unsigned char *pt;

   x=0;
   y=0;
   cnt=0;
   while (1) {
      while (cnt && x) {
	 cnt--;
	 if (--x || (width & 1) - 1)
	    *pt++=val;
      }
      if (x == 0) {
	 pt=(unsigned char *) (base->data + y * base->bytes_per_line);
	 if (++y > height)
	    return (ret);
	 x=((width + 1) >> 1) << 1;
      }
      if (cnt == 0) {
	 if ((val=agetc(fp)) < 0)
	    goto errorReadRle8Bit;
	 cnt++;
	 if (val == 0x80) {
	    if ((cnt=agetc(fp)) < 0)
	       goto errorReadRle8Bit;
	    if (cnt++ != 0)
	       /* prepare to go insert 'val', 'cnt' times */
	       if ((val=agetc(fp)) < 0)
		  goto errorReadRle8Bit;
	 }
      }
   }

 errorReadRle8Bit:
   GImageDestroy(ret);
   return NULL;
}

GImage *GImageReadRas(char *filename) {
/* Import a *.ras image (or *.im{1,8,24,32}), else return NULL if error	*/
   AFILE *fp;			/* source file */
   struct _SunRaster header;
   GImage *ret=NULL;
   struct _GImage *base;

   if ((fp=afopen(filename, "rb")) == NULL) {
      ErrorMsg(2,"Can't open \"%s\"\n", filename);
      return NULL;
   }

   if (getrasheader(&header,fp))
      goto errorGImageReadRas;

   /* Create memory to hold image, exit with NULL if not enough memory */
   if ((header.Depth == 1 &&
	(ret=GImageCreate(it_bitmap, header.Width, header.Height)) == NULL)
       || (header.Depth != 1
	   && (ret =
	       GImageCreate(header.Depth == 24 ? it_true : it_index,
			    header.Width, header.Height)) == NULL)) {
      afclose(fp);
      return NULL;
   }

   /* Convert *.ras ColorMap to one that FF can use */
   base=ret->u.image;
   if (header.ColorMapLength != 0 && base->clut != NULL) {
      unsigned char clutb[3 * 256];
      int i, n;
      
      if (afread(clutb, header.ColorMapLength, 1, fp) < 1)
	goto errorGImageReadRas;
      n=header.ColorMapLength / 3;
      base->clut->clut_len=n;
      for (i=0; i < n;i++)
	base->clut->clut[i] =
	COLOR_CREATE(clutb[i], clutb[i + n], clutb[i + 2 * n]);
   }

   if (header.Type == TypeOld || header.Type == TypeStandard) {	/* Synonymous */
      if (header.Depth == 1)
	 ret=ReadRasBitmap(ret, header.Width, header.Height, fp);
      else if (header.Depth == 8)
	 ret=ReadRas8Bit(ret, header.Width, header.Height, fp);
      else if (header.Depth == 24)
	 ret=ReadRas24Bit(ret, header.Width, header.Height, fp);
      else
	 ret=ReadRas32Bit(ret, header.Width, header.Height, fp);
   } else if (header.Type == TypeRGB) {
      /* I think this type is the same as standard except rgb not bgr */
      if (header.Depth == 1)
	 ret=ReadRasBitmap(ret, header.Width, header.Height, fp);
      else if (header.Depth == 8)
	 ret=ReadRas8Bit(ret, header.Width, header.Height, fp);
      else if (header.Depth == 24)
	 ret=ReadRas24RBit(ret, header.Width, header.Height, fp);
      else
	 ret=ReadRas32RBit(ret, header.Width, header.Height, fp);
   } else if (header.Type == TypeByteEncoded) {
      if (header.Depth == 8)
	 ret=ReadRle8Bit(ret, header.Width, header.Height, fp);
      else
	 /* Don't bother with most rle formats */
	 /* TODO: if someone wants to do this - accept more formats */
	 free(ret);
   } else
      /* Don't bother with other formats */
      /* TODO: if someone wants to do this - accept more formats */
      free(ret);
   if (ret != NULL) {
      /* All okay if reached here, return converted image */
      afclose(fp);
      return ret;
   }

 errorGImageReadRas:
   ErrorMsg(2,"Bad input file \"%s\"\n", filename);
   GImageDestroy(ret);
   afclose(fp);
   return NULL;
}

/**********************************************************************/

/* SGI RGB FORMAT */

struct sgiheader {
   int16_t magic;			/* Magic (SGI identification) number    */
   int8_t format;			/* Storage format (RLE=1 or VERBATIM=0) */
   int8_t bpc;			/* Bytes per pixel channel (1or2 bytes) */
   uint16_t dim;		/* Number of dimensions (1,2,3)         */
   uint16_t width;	/* Width of image in pixels     X-size  */
   uint16_t height;	/* Height of image in pixels    Y-size  */
   uint16_t chans;	/* Number of channels (1,3,4)   Z-size  */
   int32_t pixmin;			/* Minimum pixel value  (darkest)       */
   int32_t pixmax;			/* Maximum pixel value  (brightest)     */
   int8_t dummy[4];		/* Ignored                              */
   char imagename[80];		/* Image name   (0..79chars + '\0')     */
   int32_t colormap;		/* Colormap ID  (0,1,2,3)               */
   int8_t pad[404];		/* Ignored      (total=512bytes)        */
};

#define SGI_MAGIC	474
#define VERBATIM	0
#define RLE		1

static int getsgiheader(struct sgiheader *head,AFILE * fp) {
/* Get Header info. Return 0 if read input file okay, -1 if read error	*/
   if ((head->magic=aget_uint16_le(fp)) < 0 || head->magic != SGI_MAGIC ||
       (head->format=agetc(fp)) < 0 ||
       (head->bpc=agetc(fp)) < 0 ||
       (head->dim=aget_uint16_le(fp)) < 0 ||
       (head->width=aget_uint16_le(fp)) < 0 ||
       (head->height=aget_uint16_le(fp)) < 0 ||
       (head->chans=aget_uint16_le(fp)) < 0 ||
       aread_int32_le(fp, &head->pixmin) ||
       aread_int32_le(fp, &head->pixmax) ||
       afread(head->dummy, sizeof(head->dummy), 1, fp) < 1 ||
       afread(head->imagename, sizeof(head->imagename), 1, fp) < 1 ||
       aread_int32_le(fp, &head->colormap) ||
       afread(head->pad, sizeof(head->pad), 1, fp) < 1)
      return (-1);

   /* Check if header information okay (for us to use here ) */
   if ((head->format != VERBATIM && head->format != RLE) ||
       (head->bpc != 1 && head->bpc != 2) ||
       head->dim < 1 || head->dim > 3 ||
       head->pixmax > 65535 || (head->pixmax > 255 && head->bpc == 1) ||
       (head->chans != 1 && head->chans != 3 && head->chans != 4) ||
       head->pixmax < 0 || head->pixmin < 0 || head->pixmin >= head->pixmax ||
       head->colormap != 0)
      return (-1);

   return (0);
}

static long scalecolor(struct sgiheader *header, long value) {
   return ((value - header->pixmin) * 255L / (header->pixmax -
					      header->pixmin));
}

static int find_scanline(AFILE *fp, struct sgiheader *header, int cur,
			 uint32_t *starttab, unsigned char **ptrtab) {
/* Find and expand a scanline. Return 0 if okay, else -ve if error */
   int ch, i, cnt;
   int32_t val;
   unsigned char *pt;

   for (i=0; i < cur;i++)
      if (starttab[i] == starttab[cur]) {
	 ptrtab[cur]=ptrtab[i];
	 return (0);
      }
   if ((pt=ptrtab[cur]=(unsigned char *) malloc(header->width)) == NULL) {
      return (-1);
   }
   if (afseek(fp, starttab[cur], 0) != 0)
      return (-2);
   while (header->bpc == 1) {
      if ((ch=agetc(fp)) < 0)
	 return (-2);
      if ((cnt=(ch & 0x7f)) == 0)
	 return (0);
      if (ch & 0x80) {
	 while (--cnt >= 0) {
	    if ((ch=agetc(fp)) < 0)
	       return (-2);
	    *pt++=scalecolor(header, ch);
	 }
      } else {
	 if ((ch=agetc(fp)) < 0)
	    return (-2);
	 ch=scalecolor(header, ch);
	 while (--cnt >= 0)
	    *pt++=ch;
      }
   }
   while (header->bpc != 1) {
      if (aread_int32_le(fp, &val))
	 return (-2);
      if ((cnt=(ch & 0x7f)) == 0)
	 return (0);
      if (ch & 0x80) {
	 while (--cnt >= 0) {
	    if (aread_int32_le(fp, &val))
	       return (-2);
	    *pt++=scalecolor(header, val);
	 }
      } else {
	 if (aread_int32_le(fp, &val))
	    return (-2);
	 val=scalecolor(header, val);
	 while (--cnt >= 0)
	    *pt++=val;
      }
   }
   return (-2);
}

static void freeptrtab(unsigned char **ptrtab, long tot) {
   long i, j;

   if (ptrtab != NULL)
      for (i=0; i < tot;i++)
	 if (ptrtab[i] != NULL) {
	    for (j=i + 1; j < tot;j++)
	       if (ptrtab[j] == ptrtab[i])
		  ptrtab[j]=NULL;
	    free(ptrtab[i]);
	 }
}

GImage *GImageReadRgb(char *filename) {
   AFILE *fp;			/* source file */
   struct sgiheader header;
   int i, j, k;
   unsigned char *pt, *end;
   unsigned char *r=NULL, *g=NULL, *b=NULL, *a=NULL;	/* Colors */
   uint32_t *starttab=NULL /*, *lengthtab=NULL */ ;
   unsigned char **ptrtab=NULL;
   long tablen=0;
   unsigned long *ipt, *iend;
   GImage *ret=NULL;
   struct _GImage *base;

   if ((fp=afopen(filename, "rb")) == NULL) {
      ErrorMsg(2,"Can't open \"%s\"\n", filename);
      return (NULL);
   }

   /* Check, and Get, Header information */
   if (getsgiheader(&header, fp))
      goto errorGImageReadRgbFile;

   /* Create memory to hold image, exit with NULL if not enough memory */
   if ((ret =
	GImageCreate(header.dim == 3 ? it_true : it_index, header.width,
		     header.height)) == NULL) {
      afclose(fp);
      return (NULL);
   }
   base=ret->u.image;

   if (header.format == RLE) {
      /* Working with RLE image data */

      /* First, get offset table info */
      tablen=header.height * header.chans;
      if ((starttab =
	   (uint32_t *)calloc(1, tablen * sizeof(long))) == NULL ||
	  /*(lengthtab=(unsigned long *)calloc(1,tablen*sizeof(long)))==NULL || \ */
	  (ptrtab =
	   (unsigned char **) calloc(1,
				     tablen * sizeof(unsigned char *))) ==
	  NULL) {
	 goto errorGImageReadRgbMem;
      }
      if (readlongtab(fp,starttab,tablen))
	 goto errorGImageReadRgbFile;

      /* Next, get image data */
      for (i=0; i < tablen;i++)
	 if ((k=find_scanline(fp, &header, i, starttab, ptrtab))) {
	    if (k == -1)
	       goto errorGImageReadRgbMem;
	    else
	       goto errorGImageReadRgbFile;
	 }

      /* Then, build image */
      if (header.chans == 1) {
	 for (i=0; i < header.height;i++)
	    memcpy(base->data +
		   (header.height - 1 - i) * base->bytes_per_line, ptrtab[i],
		   header.width);
      } else {
	 unsigned long *ipt;

	 for (i=0; i < header.height;i++) {
	    ipt =
	       (unsigned long *) (base->data +
				  (header.height - 1 -
				   i) * base->bytes_per_line);
	    for (j=0; j < header.width;j++)
	       *ipt++=COLOR_CREATE(ptrtab[i][j],
				     ptrtab[i + header.height][j],
				     ptrtab[i + 2 * header.height][j]);
	 }
      }
      freeptrtab(ptrtab, tablen);
      free(ptrtab);
      free(starttab);		/*free(lengthtab); */
   } else {
      /* working with Verbatim image data */
      if (header.chans == 1 && header.bpc == 1) {
	 for (i=0; i < header.height;i++) {
	    afread(base->data + (header.height - 1 - i) * base->bytes_per_line,
		  header.width, 1, fp);
	    if (header.pixmax != 255) {
	       pt =
		  (unsigned char *) (base->data +
				     (header.height - 1 -
				      i) * base->bytes_per_line);
	       for (end=pt + header.width; pt < end; ++pt)
		  *pt=(*pt * 255) / header.pixmax;
	    }
	 }
      } else if (header.chans == 1) {
	 for (i=0; i < header.height;i++) {
	    pt =
	       (unsigned char *) (base->data +
				  (header.height - 1 -
				   i) * base->bytes_per_line);
	    for (end=pt + header.width; pt < end;) {
	       if ((k=aget_uint16_le(fp)) < 0)
		  goto errorGImageReadRgbFile;
	       *pt++=(k * 255L) / header.pixmax;
	    }
	 }
      } else {
	 /* import RGB=3 or RGBA=4 Verbatim images */
	 unsigned char *rpt, *gpt, *bpt;

	 if ((r =
	      (unsigned char *) malloc(header.width *
				       sizeof(unsigned char))) == NULL
	     || (g =
		 (unsigned char *) malloc(header.width *
					  sizeof(unsigned char))) == NULL
	     || (b =
		 (unsigned char *) malloc(header.width *
					  sizeof(unsigned char))) == NULL
	     || (header.chans == 4
		 && (a =
		     (unsigned char *) malloc(header.width *
					      sizeof(unsigned char))) ==
		 NULL)) {
	    goto errorGImageReadRgbMem;
	 }
	 if (header.bpc == 1) {
	    for (i=0; i < header.height;i++) {
	       if ((afread(r, header.width, 1, fp)) < 1 ||
		   (afread(g, header.width, 1, fp)) < 1 ||
		   (afread(b, header.width, 1, fp)) < 1 ||
		   (header.chans == 4 && (afread(a, header.width, 1, fp)) < 1))
		  goto errorGImageReadRgbFile;
	       ipt =
		  (unsigned long *) (base->data +
				     (header.height - 1 -
				      i) * base->bytes_per_line);
	       rpt=r;
	       gpt=g;
	       bpt=b;
	       for (iend=ipt + header.width; ipt < iend;)
		  *ipt++=COLOR_CREATE(*rpt++ * 255L / header.pixmax,
					*gpt++ * 255L / header.pixmax,
					*bpt++ * 255L / header.pixmax);
	    }
	 } else {
	    for (i=0; i < header.height;i++) {
	       for (j=0; j < header.width;j++) {
		  if ((k=aget_uint16_le(fp)) < 0)
		     goto errorGImageReadRgbFile;
		  r[j]=k * 255L / header.pixmax;
	       }
	       for (j=0; j < header.width;j++) {
		  if ((k=aget_uint16_le(fp)) < 0)
		     goto errorGImageReadRgbFile;
		  g[j]=k * 255L / header.pixmax;
	       }
	       for (j=0; j < header.width;j++) {
		  if ((k=aget_uint16_le(fp)) < 0)
		     goto errorGImageReadRgbFile;
		  b[j]=k * 255L / header.pixmax;
	       }
	       if (header.chans == 4) {
		  afread(a, header.width, 1, fp);
		  afread(a, header.width, 1, fp);
	       }
	       ipt =
		  (unsigned long *) (base->data +
				     (header.height - 1 -
				      i) * base->bytes_per_line);
	       rpt=r;
	       gpt=g;
	       bpt=b;
	       for (iend=ipt + header.width; ipt < iend;)
		  *ipt++=COLOR_CREATE(*rpt++, *gpt++, *bpt++);
	    }
	 }
	 free(r);
	 free(g);
	 free(b);
	 free(a);
      }
   }
   return (ret);

 errorGImageReadRgbFile:
   ErrorMsg(2, "Bad input file \"%s\"\n", filename);
 errorGImageReadRgbMem:
   freeptrtab(ptrtab, tablen);
   free(ptrtab);
   free(starttab);		/*free(lengthtab); */
   free(r);
   free(g);
   free(b);
   free(a);
   GImageDestroy(ret);
   afclose(fp);
   return (NULL);
}


/**********************************************************************/

/* TAGGED IMAGE FILE FORMAT (TIFF) */

#ifdef _NO_LIBTIFF

#else

#   include <tiffio.h>

GImage *GImageReadTiff(char *filename) {
/* Import a TIF image, else return NULL if error  */
   TIFF *tif;
   uint32_t w, h, i, j;
   uint32_t *ipt, *fpt, *raster=NULL;
   GImage *ret=NULL;
   struct _GImage *base;

   if ((tif=TIFFOpen(filename, "rb")) == NULL) {
      /* if error, then report "built-in" error message and then exit */
      return (NULL);
   }

   /* Get width and height of TIF image, exit if error */
   if (TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &w) != 1 ||
       TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &h) != 1)
      goto errorGImageReadTiff;

   /* Create memory to hold image & raster, exit if not enough memory  */
   if ((ret=GImageCreate(it_true, w, h)) == NULL)
      goto errorGImageReadTiffMem;
   if ((raster=(uint32_t *) malloc(w * h * sizeof(uint32_t))) == NULL) {
      goto errorGImageReadTiffMem;
   }

   /* Read TIF image and process it into an internal FF usable format  */
   if (TIFFReadRGBAImage(tif, w, h, raster, 0)) {
      TIFFClose(tif);
      base=ret->u.image;
      for (i=0; i < h;i++) {
	 ipt=(uint32_t *) (base->data + i * base->bytes_per_line);
	 fpt=raster + (h - 1 - i) * w;
	 for (j=0; j < w;j++)
	    *ipt++ =
	       COLOR_CREATE(TIFFGetR(fpt[j]), TIFFGetG(fpt[j]),
			    TIFFGetB(fpt[j]));
      }
      free(raster);
      return (ret);
   }

 errorGImageReadTiff:
   fprintf(stderr, "Bad input file \"%s\"\n", filename);
 errorGImageReadTiffMem:
   free(raster);
   free(ret);
   TIFFClose(tif);
   return (NULL);
}

#endif

/**********************************************************************/

/* X BITMAP (XBM) */

static int ConvertXbmByte(int pixels) {
   int i, val=0;

   for (i=0; i < 8;i++)
      if (pixels & (1 << i))
	 val |= (0x80 >> i);
   return (val ^ 0xff);		/* I default black the other way */
}

GImage *GImageReadXbm(char *filename) {
/* Import an *.xbm image, else return NULL if error */
   FILE *file;
   int width, height;
   GImage *gi=NULL;
   struct _GImage *base;
   int ch, i, j, l;
   long pixels;
   uint8_t *scanline;

   if ((file=fopen(filename, "r")) == NULL) {
      fprintf(stderr, "Can't open \"%s\"\n", filename);
      return (NULL);
   }

   /* Get width and height */
   if (fscanf(file, "#define %*s %d\n", &width) != 1 ||
       fscanf(file, "#define %*s %d\n", &height) != 1)
      goto errorGImageReadXbm;

   /* Check for, and skip past hotspot */
   if ((ch=getc(file)) < 0)
      goto errorGImageReadXbm;
   if (ch == '#') {
      if (fscanf(file, "define %*s %*d\n") < 0 ||	/* x hotspot */
	  fscanf(file, "#define %*s %*d\n") < 0)	/* y hotspot */
	 goto errorGImageReadXbm;
   } else if (ungetc(ch, file) < 0)
      goto errorGImageReadXbm;

   /* Data starts after finding "static unsigned " or "static " */
   if (fscanf(file, "static ") < 0 || (ch=getc(file)) < 0)
      goto errorGImageReadXbm;
   if (ch == 'u') {
      if (fscanf(file, "nsigned ") < 0 || (ch=getc(file)) < 0)
	 goto errorGImageReadXbm;
      /* TODO: Do we want to track signed/unsigned data? */
   }

   /* Data may be in char,short or long formats */
   if (ch == 'c') {
      if (fscanf(file, "har %*s={") < 0)
	 goto errorGImageReadXbm;
      l=8;
   } else if (ch == 's') {
      if (fscanf(file, "hort %*s={") < 0)
	 goto errorGImageReadXbm;
      l=16;
   } else if (ch == 'l') {
      if (fscanf(file, "ong %*s={") < 0)
	 goto errorGImageReadXbm;
      l=32;
   }

   /* Create memory to hold image, exit with NULL if not enough memory */
   if ((gi=GImageCreate(it_mono, width, height)) == NULL)
      goto errorGImageReadXbmMem;

   /* Convert *.xbm graphic into one that FF can use */
   base=gi->u.image;
   for (i=0; i < height;i++) {
      scanline=base->data + i * base->bytes_per_line;
      for (j=0; j < base->bytes_per_line;j++) {
	 if (fscanf(file, " 0x%x", (unsigned *) &pixels) != 1)
	    goto errorGImageReadXbm;
	 *scanline++=ConvertXbmByte(pixels);
	 if (l > 8 && j + 1 < base->bytes_per_line) {
	    *scanline++=ConvertXbmByte(pixels >> 8);
	    ++j;
	 }
	 if (l > 16 && j + 1 < base->bytes_per_line) {
	    *scanline++=ConvertXbmByte(pixels >> 16);
	    ++j;
	    if (j + 1 < base->bytes_per_line) {
	       *scanline++=ConvertXbmByte(pixels >> 24);
	       ++j;
	    }
	 }
	 fscanf(file, ",");
      }
   }
   fclose(file);
   return (gi);

 errorGImageReadXbm:
   fprintf(stderr, "Bad input file \"%s\"\n", filename);
 errorGImageReadXbmMem:
   GImageDestroy(gi);
   fclose(file);
   return (NULL);
}

int GImageWriteXbm(GImage * gi, char *filename) {
/* Export an *.xbm image, return 0 if all done okay */
   struct _GImage *base=gi->list_len == 0 ? gi->u.image : gi->u.images[0];
   FILE *file;
   int i, j, val, val2, k;
   char stem[256];
   char *pt;
   uint8_t *scanline;

   /* This routine only exports 1-pixel mono-type images */
   if (base->image_type != it_mono) {
      fprintf(stderr, "Image must be mono color.\n");
      return (-1);
   }

   /* get filename stem (255chars max) */
   if ((pt=strrchr(filename, '/')) != NULL)
      ++pt;
   else
      pt=filename;
   strncpy(stem, pt, sizeof(stem));
   stem[255]='\0';
   if ((pt=strrchr(stem, '.')) != NULL && pt != stem)
      *pt='\0';

   if ((file=fopen(filename, "w")) == NULL) {
      fprintf(stderr, "Can't open \"%s\"\n", filename);
      return (-1);
   }
   fprintf(file, "#define %s_width %d\n", stem, (int) base->width);
   fprintf(file, "#define %s_height %d\n", stem, (int) base->height);
   fprintf(file, "static unsigned char %s_bits[]={\n", stem);
   for (i=0; i < base->height;i++) {
      fprintf(file, "  ");
      scanline=base->data + i * base->bytes_per_line;
      for (j=0; j < base->bytes_per_line;j++) {
	 val=*scanline++;
	 val2=0;
	 for (k=0; k < 8; ++k) {
	    if ((val & (1 << k)))
	       val2 |= (0x80 >> k);
	 }
	 fprintf(file, "0x%.2x%s", val2 ^ 0xff, i == base->height - 1
		 && j == base->bytes_per_line - 1 ? "" : ", ");
      }
      fprintf(file, "\n");
   }
   fprintf(file, "};\n");
   fflush(file);

   i=ferror(file);
   fclose(file);
   return (i);
}
/**********************************************************************/

/* X PIXMAP (XPM) */

/* These are c files, all the significant data resides in strings, everything
else may be ignored (well, the first line must be the comment / * XPM * /)

    / * XPM * /
    static char * plaid[] =
    {
    / * plaid pixmap * /
    / * width height ncolors chars_per_pixel * /
    "22 22 4 2 0 0 XPMEXT",
    / * colors * /
    "   c red       m white  s light_color",
    "Y  c green     m black  s ines_in_mix",
    "+  c yellow    m white  s lines_in_dark ",
    "x              m black  s dark_color ",
    / * pixels * /
    "x   x   x x x   x   x x x x x x + x x x x x ",
    "  x   x   x   x   x   x x x x x x x x x x x ",
    "x   x   x x x   x   x x x x x x + x x x x x ",

The first string has 4 interesting numbers in it: width, height, ncolors,
characters per pixel, these may be followed by the hot spot location (2 nums)
or the text XPMEXT which means there are extensions later.

The next few strings (there will be ncolors of them) provide a mapping between
character(s) and colors.  Above the "  " combination maps to red on a color
display, white on monochrome and is called light_color.

After that come lines of pixels.  Each line is width*chars_per_pixel long and
there are height of them.

color names may be: a name in the x database (ie sky blue), #xxxxxx (hex rgb),
%xxxxxx (hex hsb), None==transparent, "a symbolic name" and I don't know what
good they are.
*/
/* There seems to be another, similar format XPM2 which is the same except
    nothing is in a string.  Example:
! XPM2
64 64 2 1
. c #FFFFFFFFFFFF
+ c #000000000000
.....................++.......+...+.............................
.+....................................+..++.....................
..+.............................................................
.....+.................+........................................
........++..................................+...................
................................................................
................................................................
................................................+...............
............................+...................................
*/

static int getstring(unsigned char *buf, int sz, FILE * fp) {
/* get a string of text within "" marks and skip */
/* backslash sequences, or concatenated strings. */
   int ch, incomment=0;

   while ((ch=getc(fp)) >= 0) {
      if (ch == '"' && !incomment)
	 break;
      if (!incomment && ch == '/') {
	 if ((ch=getc(fp)) < 0)
	    break;
	 if (ch == '*')
	    incomment=true;
	 else
	    ungetc(ch, fp);
      } else if (incomment && ch == '*') {
	 if ((ch=getc(fp)) < 0)
	    break;
	 if (ch == '/')
	    incomment=false;
	 else
	    ungetc(ch, fp);
      }
   }
   if (ch < 0)
      return (0);

   /* Get data within quote marks */
   while (--sz > 0 && (ch=getc(fp)) >= 0 && ch != '"')
      *buf++=ch;
   if (ch != '"')
      return (0);
   *buf='\0';
   return (1);
}

static int gww_getline(unsigned char *buf, int sz, FILE * fp) {
/* get a single line of text (leave-out the '\n') */
   int ch=0;

   unsigned char *pt=buf;

   while (--sz > 0 && (ch=getc(fp)) >= 0 && ch != '\n' && ch != '\r')
      *pt++=ch;
   if (ch == '\r' && (ch=getc(fp)) != '\n')
      ungetc(ch, fp);
   *pt='\0';
   if (ch < 0 && pt == buf)
      return (0);
   return (1);
}

#define TRANS 0x1000000
union hash {
   long color;
   union hash *table;
};

static void freetab(union hash *tab, int nchars) {
   int i;

   if (tab && nchars > 1) {
      for (i=0; i < 256;i++)
	 if (tab[i].table != NULL)
	    freetab(tab[i].table, nchars - 1);
   }
   free(tab);
}

static int fillupclut(Color * clut, union hash *tab, int index, int nchars) {
   int i;

   if (nchars == 1) {
      for (i=0; i < 256;i++)
	 if (tab[i].color != -1) {
	    if (tab[i].color == TRANS) {
	       clut[256]=index;
	       tab[i].color=0;
	    }
	    clut[index]=tab[i].color;
	    tab[i].color=index++;
	 }
   } else {
      for (i=0; i < 256;i++)
	 if (tab[i].table != NULL)
	    index=fillupclut(clut, tab[i].table, index, nchars - 1);
   }
   return (index);
}

static long parsecol(char *start, char *end) {
   long ret=-1;
   int ch;

   while (!isspace(*start) && *start != '\0')
      ++start;
   while (isspace(*start))
      ++start;
   while (end > start && isspace(end[-1]))
      --end;
   ch=*end;
   *end='\0';

   if (strcmp(start, "None") == 0)
      ret=TRANS;		/* no_color==transparent */
   else if (*start == '#' || *start == '%') {
      if (end - start == 4) {
	 sscanf(start + 1, "%lx", &ret);
	 ret =
	    ((ret & 0xf00) << 12) | ((ret & 0xf0) << 8) | ((ret & 0xf) << 4);
      } else if (end - start == 7)
	 sscanf(start + 1, "%lx", &ret);
      else if (end - start == 13) {
	 int r, g, b;

	 sscanf(start + 1, "%4x%4x%4x", &r, &g, &b);
	 ret=((r >> 8) << 16) | ((g >> 8) << 8) | (b >> 8);
      }
      if (*start == '%') {
	 /* TODO! */
	 /* How do I translate from HSB to RGB???? */
	 ;
      }
   } else if (strcmp(start, "white") == 0) {
      ret=COLOR_CREATE(255, 255, 255);
   } else {
      ret=0;
   }

   *end=ch;
   return ret;
}

static char *findnextkey(char *str) {
   int oktostart=1;

   while (*str) {
      if (isspace(*str))
	 oktostart=true;
      else if (oktostart) {
	 if ((*str == 'c' && isspace(str[1])) ||
	     (*str == 'm' && isspace(str[1])) ||
	     (*str == 'g' && isspace(str[1])) ||
	     (*str == 'g' && str[1] == '4' && isspace(str[2])) ||
	     (*str == 's' && isspace(str[1])))
	    return (str);
	 oktostart=false;
      }
      ++str;
   }
   return (str);
}

static long findcol(char *str) {
   char *pt, *end;
   char *try_order="cgm";	/* Try in this order to find something */

   while (*try_order) {
      pt=findnextkey(str);
      while (*pt) {
	 end=findnextkey(pt + 2);
	 if (*pt == *try_order)
	    return (parsecol(pt, end));
	 pt=end;
      }
      ++try_order;
   }
   return (0);
}

static union hash *parse_colors(FILE * fp, unsigned char *line, int lsiz,
				int ncols, int nchars,
				int (*getdata) (unsigned char *, int,
						FILE *)) {
   union hash *tab;
   union hash *sub;
   int i, j;

   if ((tab=(union hash *) malloc(256 * sizeof(union hash))) == NULL) {
      return (NULL);
   }

   if (nchars == 1)
      memset(tab, -1, 256 * sizeof(union hash));
   for (i=0; i < ncols;i++) {
      if (!getdata(line, lsiz, fp)) {
	 freetab(tab, nchars);
	 return (NULL);
      }
      sub=tab;
      for (j=0; j < nchars - 1;j++) {
	 if (sub[line[j]].table == NULL) {
	    if ((sub[line[j]].table =
		 (union hash *) malloc(256 * sizeof(union hash))) == NULL) {
	       freetab(tab, nchars);
	       return (NULL);
	    }
	    if (j == nchars - 2)
	       memset(sub[line[j]].table, -1, 256 * sizeof(union hash));
	 }
	 sub=sub[line[j]].table;
      }
      sub[line[j]].color=findcol((char *) line + j + 1);
   }
   return (tab);
}

GImage *GImageReadXpm(char *filename) {
/* Import an *.xpm image, else cleanup and return NULL if error */
/* TODO: There is an XPM3 library that takes care of all cases. */
   FILE *fp;
   GImage *ret=NULL;
   struct _GImage *base;
   int width, height, cols, nchar;
   unsigned char buf[80];
   unsigned char *line, *lpt;
   int y, j, lsiz;
   union hash *tab, *sub;
   unsigned char *pt, *end;
   unsigned long *ipt;

   int (*getdata) (unsigned char *, int, FILE *)=NULL;

   if ((fp=fopen(filename, "r")) == NULL) {
      fprintf(stderr, "Can't open \"%s\"\n", filename);
      return (NULL);
   }

   line=NULL;
   tab=NULL;
   nchar=0;
   /* If file begins with XPM then read lines using getstring;() */
   /* otherwise for XPM2 read lines using function gww_getline() */
   if ((fgets((char *) buf, sizeof(buf), fp)) < 0)
      goto errorGImageReadXpm;
   if (strstr((char *) buf, "XPM2") != NULL)
      getdata=gww_getline;
   else if (strstr((char *) buf, "/*") != NULL
	    && strstr((char *) buf, "XPM") != NULL
	    && strstr((char *) buf, "*/") != NULL)
      getdata=getstring;

   /* If no errors yet then go get width, height, colors, nchars */
   if (getdata == NULL ||
       !getdata(buf, sizeof(buf), fp) ||
       sscanf((char *) buf, "%d %d %d %d", &width, &height, &cols,
	      &nchar) != 4)
      goto errorGImageReadXpm;

   /* Prepare to fetch one graphic line at a time for conversion */
   if ((line =
	(unsigned char *) malloc((lsiz=nchar * width + 20) *
				 sizeof(unsigned char))) == NULL) {
      goto errorGImageReadXpmMem;
   }

   /* Fetch color table */
   if ((tab=parse_colors(fp, line, lsiz, cols, nchar, getdata)) == NULL)
      goto errorGImageReadXpmMem;

   if (cols <= 256) {
      Color clut[257];

      clut[256]=COLOR_UNKNOWN;
      fillupclut(clut, tab, 0, nchar);
      if ((ret=GImageCreate(it_index, width, height)) == NULL)
	 goto errorGImageReadXpmMem;
      ret->u.image->clut->clut_len=cols;
      memcpy(ret->u.image->clut->clut, clut, cols * sizeof(Color));
      ret->u.image->trans=clut[256];
      ret->u.image->clut->trans_index=clut[256];
   } else {
      if ((ret=GImageCreate(it_true, width, height)) == NULL)
	 goto errorGImageReadXpmMem;
      ret->u.image->trans=TRANS;	/* TRANS isn't a valid Color, but it fits in our 32 bit pixels */
   }

   /* Get image */
   base=ret->u.image;
   for (y=0; y < height; ++y) {
      if (!getdata(line, lsiz, fp))
	 goto errorGImageReadXpm;
      pt=(uint8_t *) (base->data + y * base->bytes_per_line);
      ipt=NULL;
      end=pt + width;
      if (cols > 256)
	 ipt=(unsigned long *) pt;
      for (lpt=line; *line && pt < end;) {
	 sub=tab;
	 for (j=0; *lpt && j < nchar - 1; ++j, ++lpt)
	    if (sub != NULL)
	       sub=sub[*lpt].table;
	 if (sub != NULL) {
	    if (cols <= 256)
	       *pt=sub[*lpt].color;
	    else
	       *ipt=sub[*lpt].color;
	 }
	 ++pt;
	 ++ipt;
	 ++lpt;
      }
   }
   free(line);
   freetab(tab, nchar);
   fclose(fp);
   return (ret);

 errorGImageReadXpm:
   fprintf(stderr, "Bad input file \"%s\"\n", filename);
 errorGImageReadXpmMem:
   GImageDestroy(ret);
   free(line);
   freetab(tab, nchar);
   fclose(fp);
   return (NULL);
}

/**********************************************************************/

/* FORMAT INDEPENDENT */

GImage *GImageCreate(enum image_type type, int32_t width, int32_t height) {
/* Prepare to get a bitmap image. Cleanup and return NULL if not enough memory */
   GImage *gi;
   struct _GImage *base;

   if (type < it_mono || type > it_rgba)
      return (NULL);

   gi=(GImage *) calloc(1, sizeof(GImage));
   base=(struct _GImage *) malloc(sizeof(struct _GImage));
   if (gi == NULL || base == NULL)
      goto errorGImageCreate;

   gi->u.image=base;
   base->image_type=type;
   base->width=width;
   base->height=height;
   base->bytes_per_line=(type == it_true
			   || type == it_rgba) ? 4 * width : type ==
      it_index ? width : (width + 7) / 8;
   base->data=NULL;
   base->clut=NULL;
   base->trans=COLOR_UNKNOWN;
   if ((base->data=(uint8_t *) malloc(height * base->bytes_per_line)) == NULL)
      goto errorGImageCreate;
   if (type == it_index) {
      if ((base->clut=(GClut *) calloc(1, sizeof(GClut))) == NULL) {
	 free(base->data);
	 goto errorGImageCreate;
      }
      base->clut->trans_index=COLOR_UNKNOWN;
   }
   return (gi);

 errorGImageCreate:
   free(base);
   free(gi);
   return (NULL);
}

GImage *_GImage_Create(enum image_type type, int32_t width, int32_t height) {
   GImage *gi;
   struct _GImage *base;

   if (type < it_mono || type > it_rgba)
      return (NULL);

   gi=(GImage *) calloc(1, sizeof(GImage));
   base=(struct _GImage *) malloc(sizeof(struct _GImage));
   if (gi == NULL || base == NULL)
      goto error_GImage_Create;

   gi->u.image=base;
   base->image_type=type;
   base->width=width;
   base->height=height;
   base->bytes_per_line=(type == it_true
			   || type == it_rgba) ? 4 * width : type ==
      it_index ? width : (width + 7) / 8;
   base->data=NULL;
   base->clut=NULL;
   if (type == it_index) {
      if ((base->clut=(GClut *) calloc(1, sizeof(GClut))) == NULL)
	 goto error_GImage_Create;
   }
   return (gi);

 error_GImage_Create:
   free(base);
   free(gi);
   return (NULL);
}

void GImageDestroy(GImage * gi) {
/* Free memory (if GImage exists) */
   int i;

   if (gi != NULL) {
      if (gi->list_len != 0) {
	 for (i=0; i < gi->list_len;i++) {
	    free(gi->u.images[i]->clut);
	    free(gi->u.images[i]->data);
	    free(gi->u.images[i]);
	 }
	 free(gi->u.images);
      } else {
	 free(gi->u.image->clut);
	 free(gi->u.image->data);
	 free(gi->u.image);
      }
      free(gi);
   }
}

GImage *GImageCreateAnimation(GImage ** images, int n) {
   /* Create an animation using n "images". Return gi and free "images" if*/
   /* okay, else return NULL and keep "images" if memory error occurred,*/
   GImage *gi;
   struct _GImage **imgs;
   int i;
   
   /* Check if "images" are okay to copy before creating an animation. */
   /* We expect to find single images (not an array). Type must match. */
   for (i=0; i < n;i++) {
      if (images[i]->list_len != 0 ||
	  images[i]->u.image->image_type != images[0]->u.image->image_type) {
	 fprintf(stderr, "Images are not compatible to make an Animation\n");
	 return (NULL);
      }
   }
   
   /* First, create enough memory space to hold the complete animation */
   gi=(GImage *) calloc(1, sizeof(GImage));
   imgs=(struct _GImage **) malloc(n * sizeof(struct _GImage *));
   if (gi == NULL || imgs == NULL) {
      free(gi);
      free(imgs);
      return (NULL);
   }
   
   /* Copy images[i] pointer into 'gi', then release each "images[i]". */
   gi->list_len=n;
   gi->u.images=imgs;
   for (i=0; i < n;i++) {
      imgs[i]=images[i]->u.image;
      free(images[i]);
   }
   return (gi);
   
}

void GImageDrawRect(GImage * img, GRect * r, Color col) {
   struct _GImage *base;
   int i;

   base=img->u.image;
   if (r->y >= base->height || r->x >= base->width)
      return;

   for (i=0; i < r->width;i++) {
      if (i + r->x >= base->width)
	 break;
      base->data[r->y * base->bytes_per_line + i + r->x]=col;
      if (r->y + r->height - 1 < base->height)
	 base->data[(r->y + r->height - 1) * base->bytes_per_line + i +
		    r->x]=col;
   }
   for (i=0; i < r->height;i++) {
      if (i + r->y >= base->height)
	 break;
      base->data[(r->y + i) * base->bytes_per_line + r->x]=col;
      if (r->x + r->width - 1 < base->width)
	 base->data[(r->y + i) * base->bytes_per_line + r->x + r->width - 1] =
	    col;
   }
}

void GImageDrawImage(GImage * dest, GImage * src, GRect * junk, int x, int y) {
   struct _GImage *sbase, *dbase;

   int i, j, di, sbi, dbi, val, factor, maxpix, sbit;

   /* This is designed to merge images which should be treated as alpha */
   /* channels. dest must be indexed, src may be either indexed or mono */
   dbase=dest->u.image;
   sbase=src->u.image;

   if (dbase->image_type != it_index) {
      fprintf(stderr, "Bad call to GImageMaxImage\n");
      return;
   }

   maxpix=1;
   if (dbase->clut != NULL)
      maxpix=dbase->clut->clut_len - 1;

   if (dbase->clut != NULL && sbase->clut != NULL
       && sbase->clut->clut_len > 1) {
      factor=(dbase->clut->clut_len - 1) / (sbase->clut->clut_len - 1);
      if (factor == 0)
	 factor=1;
   } else
      factor=1;

   if (sbase->image_type == it_index) {
      for (i=0; i < sbase->height;i++) {
	 di=y + i;
	 if (di < 0 || di >= dbase->height)
	    continue;
	 sbi=i * sbase->bytes_per_line;
	 dbi=di * dbase->bytes_per_line;
	 for (j=0; j < sbase->width;j++) {
	    if (x + j < 0 || x + j >= dbase->width)
	       continue;
	    val=dbase->data[dbi + x + j] + sbase->data[sbi + j] * factor;
	    if (val > 255)
	       val=255;
	    dbase->data[dbi + x + j]=val;
	 }
      }
   } else if (sbase->image_type == it_mono) {
      for (i=0; i < sbase->height;i++) {
	 di=y + i;
	 if (di < 0 || di >= dbase->height)
	    continue;
	 sbi=i * sbase->bytes_per_line;
	 dbi=di * dbase->bytes_per_line;
	 for (j=0, sbit=0x80; j < sbase->width;j++) {
	    if (x + j < 0 || x + j >= dbase->width)
	       continue;
	    if (sbase->data[sbi + (j >> 3)] & sbit)
	       dbase->data[dbi + x + j]=maxpix;
	    if ((sbit >>= 1) == 0)
	       sbit=0x80;
	 }
      }
   }
}

/* Blends src image with alpha channel over dest. Both images must be */
/* 32-bit truecolor. Alpha channel of dest must be all opaque.        */
static void GImageBlendOver(GImage * dest, GImage * src, GRect * from, int x, int y) {
   struct _GImage *sbase, *dbase;
   int i, j, a, r, g, b;
   uint32_t *dpt, *spt;

   dbase=dest->u.image;
   sbase=src->u.image;

   if (dbase->image_type != it_true) {
      fprintf(stderr, "Bad call to GImageBlendOver\n");
      return;
   }

   if (sbase->image_type != it_rgba) {
      fprintf(stderr, "Bad call to GImageBlendOver\n");
      return;
   }

   for (i=0; i < from->height;i++) {
      dpt =
	 (uint32_t *) (dbase->data + (i + y) * dbase->bytes_per_line +
		     x * sizeof(uint32_t));
      spt =
	 (uint32_t *) (sbase->data + (i + from->y) * sbase->bytes_per_line +
		     from->x * sizeof(uint32_t));

      for (j=0; j < from->width; j++) {
	 a=COLOR_ALPHA(*spt);
	 r=((255 - a) * COLOR_RED(*dpt) + a * COLOR_RED(*spt)) / 255;
	 g=((255 - a) * COLOR_GREEN(*dpt) + a * COLOR_GREEN(*spt)) / 255;
	 b=((255 - a) * COLOR_BLUE(*dpt) + a * COLOR_BLUE(*spt)) / 255;
	 spt++;
	 *dpt++=0xff000000 | COLOR_CREATE(r, g, b);
      }
   }
}

int GImageGetWidth(GImage * img) {
   if (img->list_len == 0) {
      return (img->u.image->width);
   } else {
      return (img->u.images[0]->width);
   }
}

int GImageGetHeight(GImage * img) {
   if (img->list_len == 0) {
      return (img->u.image->height);
   } else {
      return (img->u.images[0]->height);
   }
}

GImage *GImageRead(char *filename) {
   char *mime,*pt;
   unsigned char buffer[80];
   AFILE *fp;

   if (filename==NULL)
      return (NULL);

   if (GFileExists(filename)) {
      fp=afopen(filename,"rb");
      if (fp==NULL)
	return NULL;
      memset(buffer,0,80);
      afread(buffer,1,80,fp);
      afclose(fp);
      
      if ((buffer[0]=='B') && (buffer[1]=='M') && (buffer[15]==0) &&
	  ((buffer[14]==12) || (buffer[14]==40) || (buffer[14]==64) ||
	      (buffer[14]==124) || (buffer[14]==108) || (buffer[14]==128)))
	return GImageReadBmp(filename);

      if (strncmp(buffer,"/* XPM */",9)==0)
	 return GImageReadXpm(filename);
      
#ifndef _NO_LIBTIFF
      if ((memcmp(buffer,"II*",4)==0) || (memcmp(buffer,"MM\0*",4)==0))
	 return GImageReadTiff(filename);
#endif

#ifndef _NO_LIBJPEG
      if ((buffer[0]==0xFF) && (buffer[1]==0xD8))
	return GImageReadJpeg(filename);
#endif

#ifndef _NO_LIBPNG
      if (memcmp(buffer,"\x89PNG\x0D\x0A\x1A\x0A",8)==0)
	 return GImageReadPng(filename);
#endif

#ifndef _NO_LIBUNGIF
      if (memcmp(buffer,"GIF8",4)==0)
	return GImageReadGif(filename);
#endif
      if ((memcmp(buffer,"\361\0\100\273",4)==0) ||
	  (memcmp(buffer,"\x59\xA6\x6A\x95",4)==0))
	 return GImageReadRas(filename);	/* CMU or Sun raster */

      if ((buffer[0]==1) && (buffer[1]==218))
	 return GImageReadRgb(filename);	/* SGI format */
   }

   /* Try finding correct routine to use based on filename suffix */
   if ((pt=strrchr(filename, '.')) != NULL) {

      if (strmatch(pt, ".bmp") == 0)
	 return (GImageReadBmp(filename));
      else if (strmatch(pt, ".xbm") == 0)
	 return (GImageReadXbm(filename));
      else if (strmatch(pt, ".xpm") == 0)
	 return (GImageReadXpm(filename));
#ifndef _NO_LIBTIFF
      else if (strmatch(pt, ".tiff") == 0 || strmatch(pt, ".tif") == 0)
	 return (GImageReadTiff(filename));
#endif
#ifndef _NO_LIBJPEG
      else if (strmatch(pt, ".jpeg") == 0 || strmatch(pt, ".jpg") == 0)
	 return (GImageReadJpeg(filename));
#endif
#ifndef _NO_LIBPNG
      else if (strmatch(pt, ".png") == 0)
	 return (GImageReadPng(filename));
#endif
#ifndef _NO_LIBUNGIF
      else if (strmatch(pt, ".gif") == 0)
	 return (GImageReadGif(filename));
#endif
      else if (strmatch(pt, ".ras") == 0 || strmatch(pt, ".im1") == 0 ||
	       strmatch(pt, ".im8") == 0 || strmatch(pt, ".im24") == 0 ||
	       strmatch(pt, ".im32") == 0 || strmatch(pt, ".rs") == 0 ||
	       strmatch(pt, ".sun") == 0)
	 return (GImageReadRas(filename));	/* Sun raster */
      else if (strmatch(pt, ".rgb") == 0 || strmatch(pt, ".rgba") == 0 ||
	       strmatch(pt, ".sgi") == 0 || strmatch(pt, ".bw") == 0)
	 return (GImageReadRgb(filename));	/* SGI format */
   }

   return (NULL);
}

static void WriteBase(FILE * file, struct _GImage *base, char *stem,
		      int instance) {
/* Write one image in C code which can be compiled into FontAnvil. */
/* This routine is called and used by GImageWriteGImage() */
   int i, j, k;
   uint32_t *ipt;
   uint8_t *pt;
   long val;

   if (base->image_type == it_true) {
      fprintf(file, "static uint32_t %s%d_data[]={\n", stem, instance);
      for (i=0; i < base->height;i++) {
	 ipt=(uint32_t *) (base->data + i * base->bytes_per_line);
	 for (j=0; j < base->width;) {
	    fprintf(file, j == 0 ? "    " : "\t");
	    for (k=0; k < 8 && j < base->width; ++k, ++j, ++ipt) {
	       val=*ipt & 0xffffffff;
	       fprintf(file, "0x%.8x%s", (unsigned int) val,
		       j == base->width - 1
		       && i == base->height - 1 ? "" : ", ");
	    }
	    fprintf(file, "\n");
	 }
      }
   } else {
      fprintf(file, "static uint8_t %s%d_data[]={\n", stem, instance);
      for (i=0; i < base->height;i++) {
	 pt=(uint8_t *) (base->data + i * base->bytes_per_line);
	 for (j=0; j < base->bytes_per_line;) {
	    fprintf(file, j == 0 ? "    " : "\t");
	    for (k=0; k < 8 && j < base->bytes_per_line; ++k, ++j, ++pt)
	       fprintf(file, "0x%.2x%s", *pt, j == base->width - 1
		       && i == base->height - 1 ? "" : ", ");
	    fprintf(file, "\n");
	 }
      }
   }
   fprintf(file, "};\n");

   if (base->clut != NULL) {
      fprintf(file, "\nstatic GClut %s%d_clut={ %d, %d, %ld,\n",
	      stem, instance,
	      base->clut->clut_len, base->clut->is_grey,
	      (unsigned long) base->clut->trans_index & 0xfffffff);
      for (i=0; i < base->clut->clut_len;) {
	 fprintf(file, "    ");
	 for (k=0; k < 8 && i < base->clut->clut_len; ++k, ++i) {
	    val=base->clut->clut[i] & 0xffffffff;
	    fprintf(file, "0x%.8x%s", (unsigned int) val,
		    i == base->clut->clut_len - 1 ? " };" : ", ");
	 }
	 fprintf(file, "\n");
      }
   }
   fprintf(file, "\nstatic struct _GImage %s%d_base={\n", stem, instance);
   fprintf(file, base->image_type == it_true ? "    it_true,\n" :
	   base->image_type == it_index ? "    it_index,\n" :
	   "    it_mono,\n");
   fprintf(file, "    %d,%ld,%ld,%ld,\n", (int) base->delay,
	   (long) base->width, (long) base->height,
	   (long) base->bytes_per_line);
   fprintf(file, "    (uint8_t *) %s%d_data,\n", stem, instance);
   if (base->clut == NULL)
      fprintf(file, "    NULL,\n");
   else
      fprintf(file, "    &%s%d_clut,\n", stem, instance);
   fprintf(file, "    0x%.8x\n};\n\n",
	   (unsigned int) base->trans & 0xffffffff);
}

int GImageWriteGImage(GImage * gi, char *filename) {
/* Export a GImage that can be used by FontAnvil. Return 0 if all done okay */
   FILE *file;
   int i;
   char stem[256];
   char *pt;

   if (gi == NULL)
      return (-1);

   /* get filename stem (255chars max) */
   if ((pt=strrchr(filename, '/')) != NULL)
      ++pt;
   else
      pt=filename;
   strncpy(stem, pt, sizeof(stem));
   stem[255]='\0';
   if ((pt=strrchr(stem, '.')) != NULL && pt != stem)
      *pt='\0';

   /* Begin writing C code to the file */
   if ((file=fopen(filename, "w")) == NULL) {
      fprintf(stderr, "Can't open \"%s\"\n", filename);
      return (-1);
   }
   fprintf(file,
	   "/* This file was generated using GImageWriteGImage(gi,\"%s\") */\n",
	   filename);
   fprintf(file, "#include \"gimage.h\"\n\n");
   if (gi->list_len == 0) {
      /* Construct a single image */
      WriteBase(file, gi->u.image, stem, 0);
      fprintf(file, "GImage %s={ 0, &%s0_base };\n", stem, stem);
   } else {
      /* Construct an array of images */
      for (i=0; i < gi->list_len;i++)
	 WriteBase(file, gi->u.images[i], stem, i);
      fprintf(file, "static struct _GImage *%s_bases={\n", stem);
      for (i=0; i < gi->list_len;i++)
	 fprintf(file, "    &%s%d_base%s\n", stem, i,
		 i == gi->list_len - 1 ? "" : ",");
      fprintf(file, "};\n\n");

      fprintf(file, "GImage %s={ %d, (struct _GImage *) %s_bases };\n",
	      stem, gi->list_len, stem);
   }
   fflush(file);
   i=ferror(file);
   fclose(file);
   return (i);
}
