/* $Id: fffreetype.h 4020 2015-06-14 18:15:09Z mskala $ */
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

#ifndef _FFFREETYPE_H
#   define _FFFREETYPE_H

#   if !defined(_NO_FREETYPE)
#      include <ft2build.h>
#      include FT_FREETYPE_H
#      include FT_OUTLINE_H
#      if FREETYPE_MINOR >= 5
#         include FT_TRUETYPE_DRIVER_H
#      endif

#      if defined(__MINGW32__)
#         include <Windows.h>
#      else
#         include <sys/mman.h>
#      endif

#      include <unistd.h>

extern FT_Library ff_ft_context;

typedef struct freetypecontext {
   SplineFont *sf;
   int layer;
   void *mappedfile;
   long len;
   int *glyph_indices;
   AFILE *file;
   FT_Face face;
   struct freetypecontext *shared_ftc;	/* mappedfile, glyph_indices are shared with this ftc */
   /*  We have a new face, but that's it. This is so we can */
   /*  have multiple pointsizes without loading the font many */
   /*  times */
   int isttf;
   int em;			/* Em size in the spline font, not ppem */
} FTC;

#   endif
       /* we do have FreeType */

#endif /* _FFFREETYPE_H */
