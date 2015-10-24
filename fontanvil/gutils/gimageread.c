/* $Id: gimageread.c 4304 2015-10-24 19:05:22Z mskala $ */
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
#include "gimage.h"
#include <string.h>
#include <ustring.h>

#include "gfile.h"

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
   if ((pt = strrchr(filename, '.')) != NULL) {

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
