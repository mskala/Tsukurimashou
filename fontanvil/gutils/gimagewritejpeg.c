/* $Id: gimagewritejpeg.c 4289 2015-10-20 16:13:40Z mskala $ */
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

#include <fontanvil-config.h>

#ifdef _NO_LIBJPEG

static int a_file_must_define_something = 0;	/* ANSI says so */

#else

#   include <sys/types.h>
#   include <stdio.h>
#   include <jpeglib.h>
#   include <jerror.h>

#   include <setjmp.h>

#   include "gimage.h"

/******************************************************************************/

struct my_error_mgr {
   struct jpeg_error_mgr pub;	/* "public" fields */

   jmp_buf setjmp_buffer;	/* for return to caller */
   int padding[8];		/* On my solaris box jmp_buf is the wrong size */
};

typedef struct my_error_mgr *my_error_ptr;

METHODDEF(void) my_error_exit(j_common_ptr cinfo) {
   /* cinfo->err really points to a my_error_mgr struct, so coerce pointer */
   my_error_ptr myerr = (my_error_ptr) cinfo->err;

   /* Always display the message. */
   /* We could postpone this until after returning, if we chose. */
   (*cinfo->err->output_message) (cinfo);

   /* Return control to the setjmp point */
   longjmp(myerr->setjmp_buffer, 1);
}

static void transferImageToBuffer(struct _GImage *base, JSAMPLE * buffer,
				  int w, int ypos) {
   JSAMPLE *pt, *end;

   uint32_t *ppt;

   ppt = (uint32_t *) (base->data + ypos * base->bytes_per_line);
   if (base->image_type == it_index && base->clut == NULL) {
      unsigned char *px = (unsigned char *) ppt;

      int col;

      register int bit = 0x80;

      for (pt = buffer, end = pt + 3 * w; pt < end;) {
	 if (*px & bit)
	    col = 0xffffff;
	 else
	    col = 0;
	 if ((bit >>= 1) == 0) {
	    ++px;
	    bit = 0x80;
	 }
	 *pt++ = COLOR_RED(col);
	 *pt++ = COLOR_GREEN(col);
	 *pt++ = COLOR_BLUE(col);
      }
   } else if (base->image_type == it_index) {
      unsigned char *px = (unsigned char *) ppt;

      int col;

      register int bit = 0x80;

      for (pt = buffer, end = pt + 3 * w; pt < end;) {
	 if (*px & bit)
	    col = base->clut->clut[1];
	 else
	    col = base->clut->clut[0];
	 if ((bit >>= 1) == 0) {
	    ++px;
	    bit = 0x80;
	 }
	 *pt++ = COLOR_RED(col);
	 *pt++ = COLOR_GREEN(col);
	 *pt++ = COLOR_BLUE(col);
      }
   } else if (base->image_type == it_index) {
      unsigned char *px = (unsigned char *) ppt;

      int col;

      for (pt = buffer, end = pt + 3 * w; pt < end;) {
	 col = base->clut->clut[*px++];
	 *pt++ = COLOR_RED(col);
	 *pt++ = COLOR_GREEN(col);
	 *pt++ = COLOR_BLUE(col);
      }
   } else {
      for (pt = buffer, end = pt + 3 * w; pt < end; ++ppt) {
	 *pt++ = COLOR_RED(*ppt);
	 *pt++ = COLOR_GREEN(*ppt);
	 *pt++ = COLOR_BLUE(*ppt);
      }
   }
}

static void setColorSpace(struct jpeg_compress_struct *cinfo,
			  struct _GImage *base) {
   int i;

   cinfo->input_components = 3;	/* # of color components per pixel */
   cinfo->in_color_space = JCS_RGB;	/* colorspace of input image */

   if (base->image_type == it_index) {
      if (base->clut->clut_len != 256)
	 return;
      for (i = 0; i < 256; ++i)
	 if (base->clut->clut[i] != COLOR_CREATE(i, i, i))
	    break;
      if (i == 256) {
	 cinfo->input_components = 1;
	 cinfo->in_color_space = JCS_GRAYSCALE;
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
   struct _GImage *base = gi->list_len == 0 ? gi->u.image : gi->u.images[0];
   struct jpeg_compress_struct cinfo;
   struct my_error_mgr jerr;

   JSAMPROW row_pointer[1];	/* pointer to JSAMPLE row[s] */

   cinfo.err = jpeg_std_error(&jerr.pub);
   jerr.pub.error_exit = my_error_exit;
   if (setjmp(jerr.setjmp_buffer)) {
      jpeg_destroy_compress(&cinfo);
      return 0;
   }
   jpeg_CreateCompress(&cinfo, JPEG_LIB_VERSION,
		       (size_t) sizeof(struct jpeg_compress_struct));
   fajpeg_afile_dest(&cinfo, outfile);

   cinfo.image_width = base->width;
   cinfo.image_height = base->height;
   setColorSpace(&cinfo, base);
   jpeg_set_defaults(&cinfo);
   jpeg_set_quality(&cinfo, quality, TRUE);
   if (progressive)
      jpeg_simple_progression(&cinfo);
   jpeg_start_compress(&cinfo, TRUE);

   if (cinfo.in_color_space != JCS_GRAYSCALE)
      row_pointer[0] = (JSAMPROW) malloc(3 * base->width);
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
