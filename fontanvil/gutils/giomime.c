/* $Id: giomime.c 2918 2014-03-07 16:09:49Z mskala $ */
/* Copyright (C) 2000-2012 by George Williams */
/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.

 * The name of the author may not be used to endorse or promote products
 * derived from this software without specific prior written permission.

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
#include "gio.h"
#include "gfile.h"
#include "ustring.h"

unichar_t unknown[] = { '*', '/', '*', '\0' };
unichar_t textplain[] =
   { 't', 'e', 'x', 't', '/', 'p', 'l', 'a', 'i', 'n', '\0' };
unichar_t texthtml[] = { 't', 'e', 'x', 't', '/', 'h', 't', 'm', 'l', '\0' };
unichar_t textxml[] = { 't', 'e', 'x', 't', '/', 'x', 'm', 'l', '\0' };
unichar_t textc[] = { 't', 'e', 'x', 't', '/', 'c', '\0' };
unichar_t textcss[] = { 't', 'e', 'x', 't', '/', 'c', 's', 's', '\0' };
unichar_t textmake[] = { 't', 'e', 'x', 't', '/', 'm', 'a', 'k', 'e', '\0' };
unichar_t textjava[] = { 't', 'e', 'x', 't', '/', 'j', 'a', 'v', 'a', '\0' };
unichar_t textps[] = { 't', 'e', 'x', 't', '/', 'p', 's', '\0' };

	/* Officially registered with IANA on 14 May 2008 */
unichar_t sfdfont[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'v', 'n',
'd', '.', 'f', 'o', 'n', 't', '-', 'f', 'o', 'n', 't', 'f', 'o', 'r', 'g', 'e', '-', 's',
'f', 'd', '\0' };
unichar_t textpsfont[] =
   { 't', 'e', 'x', 't', '/', 'f', 'o', 'n', 't', 'p', 's', '\0' };
unichar_t textbdffont[] =
   { 't', 'e', 'x', 't', '/', 'f', 'o', 'n', 't', 'b', 'd', 'f', '\0' };
unichar_t imagebmp[] = { 'i', 'm', 'a', 'g', 'e', '/', 'b', 'm', 'p', '\0' };	/* *.bmp */
unichar_t imagegif[] = { 'i', 'm', 'a', 'g', 'e', '/', 'g', 'i', 'f', '\0' };
unichar_t imagejpeg[] = { 'i', 'm', 'a', 'g', 'e', '/', 'j', 'p', 'e', 'g', '\0' };	/* *.jpeg,*.jpg */
unichar_t imagepng[] = { 'i', 'm', 'a', 'g', 'e', '/', 'p', 'n', 'g', '\0' };
unichar_t imageras[] = { 'i', 'm', 'a', 'g', 'e', '/', 'x', '-', 'c', 'm', 'u', '-', 'r', 'a', 's', 't', 'e', 'r', '\0' };	/* *.ras */
unichar_t imagesvg[] =
   { 'i', 'm', 'a', 'g', 'e', '/', 's', 'v', 'g', '+', 'x', 'm', 'l', '\0' };
unichar_t videoquick[] =
   { 'v', 'i', 'd', 'e', 'o', '/', 'q', 'u', 'i', 'c', 'k', 't', 'i', 'm',
'e', '\0' };
unichar_t audiowav[] = { 'a', 'u', 'd', 'i', 'o', '/', 'w', 'a', 'v', '\0' };
unichar_t pdf[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'p', 'd',
'f', '\0' };
unichar_t object[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'o', 'b', 'j', 'e', 'c', 't', '\0' };
unichar_t dir[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'n', 'a', 'v', 'i', 'd', 'i', 'r', '\0' };
unichar_t core[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'c', 'o', 'r', 'e', '\0' };
unichar_t fontttf[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'f', 'o', 'n', 't', '-', 't', 't', 'f', '\0' };
unichar_t fontotf[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'f', 'o', 'n', 't', '-', 'o', 't', 'f', '\0' };
unichar_t fontcid[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'f', 'o', 'n', 't', '-', 'c', 'i', 'd', '\0' };
unichar_t fonttype1[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'f', 'o', 'n', 't', '-', 't', 'y', 'p', 'e', '1', '\0' };
unichar_t fontmacsuit[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'm', 'a', 'c', '-', 's', 'u', 'i', 't', '\0' };
unichar_t macbin[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'm', 'a', 'c', 'b', 'i', 'n', 'a', 'r', 'y', '\0' };
unichar_t machqx[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'm', 'a', 'c', '-', 'b', 'i', 'n', 'h', 'e', 'x', '4', '0', '\0' };
unichar_t macdfont[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'm', 'a', 'c', '-', 'd', 'f', 'o', 'n', 't', '\0' };
unichar_t compressed[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'c', 'o', 'm', 'p', 'r', 'e', 's', 's', 'e', 'd', '\0' };
unichar_t tar[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
't', 'a', 'r', '\0' };
unichar_t fontpcf[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'f', 'o', 'n', 't', '-', 'p', 'c', 'f', '\0' };
unichar_t fontsnf[] =
   { 'a', 'p', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'o', 'n', '/', 'x', '-',
'f', 'o', 'n', 't', '-', 's', 'n', 'f', '\0' };
//unichar_t fontwoff[] = { 'a','p','p','l','i','c','a','t','i','o','n','/','x','-','f','o','n','t','-','w','o','f','f', '\0' };
//unichar_t fonttexfm[] = { 'a','p','p','l','i','c','a','t','i','o','n','/','x','-','t','e','x','-','t','f','m', '\0' }; /* *.tfm */


//////////////////////////////////////////////////
// The below code is from sortsmill
//

// Copyright (C) 2012 Khaled Hosny
// 
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program; if not, see <http://www.gnu.org/licenses/>.

#include <glib.h>
#include <gio/gio.h>
#include "gio.h"
#include "ustring.h"


char *GIOGetMimeType(const char *path, int sniff_data) {
   char *content_type, *mime;

   int sniff_length = 4096;

   guchar sniff_buffer[sniff_length];

   gboolean uncertain;

   content_type = g_content_type_guess(path, NULL, 0, NULL);

   if (sniff_data) {
      FILE *fp = fopen(path, "rb");

      if (fp) {
	 size_t res = fread(sniff_buffer, 1, sniff_length, fp);

	 fclose(fp);
	 if (res >= 0) {
	    g_free(content_type);
	    content_type =
	       g_content_type_guess(NULL, sniff_buffer, res, &uncertain);
	    if (uncertain) {
	       g_content_type_guess(path, sniff_buffer, res, NULL);
	    }
	 }
      }
   }

   mime = g_content_type_get_mime_type(content_type);
   g_free(content_type);

   if (!mime)
      mime = "*/*";

   return mime;
}
