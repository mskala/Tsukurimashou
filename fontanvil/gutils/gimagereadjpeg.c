/* $Id: gimagereadjpeg.c 4289 2015-10-20 16:13:40Z mskala $ */
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

#else /* We can build with jpeglib - therefore import jpg files */

#   include "fontanvil.h"
#   include <sys/types.h>
#   include <stdio.h>
#   include <jpeglib.h>
#   include <jerror.h>
#   include <setjmp.h>
#   include "gimage.h"

/******************************************************************************/

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
   my_error_ptr myerr = (my_error_ptr) cinfo->err;

   /* Always display the message. */
   /* We could postpone this until after returning, if we chose. */
   (*cinfo->err->output_message) (cinfo);

   /* Return control to the setjmp point */
   longjmp(myerr->setjmp_buffer, 1);
}

/* jpeg routines use 24 bit pixels, xvt routines pad out to 32 */
static void transferBufferToImage(struct jpegState *js, int ypos) {
   struct jpeg_decompress_struct *cinfo = js->cinfo;
   JSAMPLE *pt, *end;
   Color *ppt;

   ppt = (Color *) (js->base->data + ypos * js->base->bytes_per_line);
   for (pt = js->buffer, end = pt + 3 * cinfo->image_width; pt < end;) {
      register int r, g, b;

      r = *(pt++);
      g = *(pt++);
      b = *(pt++);
      *(ppt++) = COLOR_CREATE(r, g, b);
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
#endif
