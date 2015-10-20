/* $Id: ustring.h 4288 2015-10-20 13:06:01Z mskala $ */
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
#ifndef _UCHAR_H
#   define _UCHAR_H
#   include <stdarg.h>
#   include <string.h>
#   include <memory.h>
#   include "fontanvil.h"
#   include <charset.h>

extern char *copyn(const char *, long);

extern unichar_t *uc_copy(const char *);

extern char *cu_copy(const unichar_t *);

extern int strmatch(const char *, const char *);

extern int strnmatch(const char *str1, const char *str2, int n);

extern void u_strcpy(unichar_t *, const unichar_t *);

extern int u_strlen(const unichar_t *);

extern char *strstrmatch(const char *, const char *);

extern int32_t utf8_ildb(const char **utf8_text);

#   define UTF8IDPB_NOZERO 1	/* Allow for 0 encoded as a non-zero utf8 0xc0:0x80 char */
#   define UTF8IDPB_OLDLIMIT 2	/* Today's utf8 is agreed to be limited to {0..0x10FFFF} */
#   define UTF8IDPB_UCS2 8	/* Encode {0...0xffff} as 16bit ucs2 type values */
#   define UTF8IDPB_UTF16 16	/* Encode {0...0x10ffff} as 16bit utf16 type values */
#   define UTF8IDPB_UTF32 32	/* Encode {0...0x10ffff} as 32bit utf32 type values */
extern char *utf8_idpb(char *utf8_text, uint32_t ch, int flags);

extern int utf8_valid(const char *str);

extern char *latin1_2_utf8_strcpy(char *utf8buf, const char *lbuf);

extern char *latin1_2_utf8_copy(const char *lbuf);

extern long utf82u_strlen(const char *utf8_str);	/* Count how many shorts needed to represent in UCS2 */

extern unichar_t *utf82u_strncpy(unichar_t * ubuf, const char *utf8buf,
				 int len);
extern unichar_t *utf82u_strcpy(unichar_t * ubuf, const char *utf8buf);

extern unichar_t *utf82u_copy(const char *utf8buf);

extern char *u2utf8_copy(const unichar_t * ubuf);

extern char *u2utf8_copyn(const unichar_t * ubuf, int len);

extern int AllAscii(const char *);

extern char *StripToASCII(const char *utf8_str);

#endif
