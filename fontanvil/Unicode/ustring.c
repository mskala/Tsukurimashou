/* $Id: ustring.c 2950 2014-03-15 16:10:53Z mskala $ */
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
#include <stddef.h>
#include "ustring.h"
#include "utype.h"

long u_strcmp(const unichar_t * str1, const unichar_t * str2) {
   long ch1, ch2;

   for (;;) {
      ch1 = *str1++;
      ch2 = *str2++;
      if (ch1 != ch2 || ch1 == '\0')
	 return (ch1 - ch2);
   }
}

void u_strcpy(unichar_t * to, const unichar_t * from) {
   register unichar_t ch;

   while ((ch = *from++) != '\0')
      *(to++) = ch;
   *to = 0;
}

void u_strncpy(register unichar_t * to, const unichar_t * from, int len) {
   register unichar_t ch;

   while ((ch = *from++) != '\0' && --len >= 0)
      *(to++) = ch;
   *to = 0;
}

int u_strlen(register const unichar_t * str) {
   register int len = 0;

   while (*str++ != '\0')
      ++len;
   return (len);
}

static unichar_t *u_copyn(const unichar_t * pt, long n) {
   unichar_t *res;

#ifdef MEMORY_MASK
   if (n * sizeof(unichar_t) >= MEMORY_MASK)
      n = MEMORY_MASK / sizeof(unichar_t) - 1;
#endif
   res = (unichar_t *) malloc((n + 1) * sizeof(unichar_t));
   memcpy(res, pt, n * sizeof(unichar_t));
   res[n] = '\0';
   return (res);
}

unichar_t *u_copy(const unichar_t * pt) {
   if (pt)
      return u_copyn(pt, u_strlen(pt));

   return ((unichar_t *) 0);
}

unichar_t *uc_copy(const char *pt) {
   unichar_t *res, *rpt;

   int n;

   if (!pt)
      return ((unichar_t *) 0);

   n = strlen(pt);
#ifdef MEMORY_MASK
   if ((n + 1) * sizeof(unichar_t) >= MEMORY_MASK)
      n = MEMORY_MASK / sizeof(unichar_t) - 1;
#endif
   res = (unichar_t *) malloc((n + 1) * sizeof(unichar_t));
   for (rpt = res; --n >= 0; *rpt++ = *(unsigned char *) pt++);
   *rpt = '\0';
   return (res);
}

char *cu_copy(const unichar_t * pt) {
   char *res, *rpt;

   int n;

   if (!pt)
      return ((char *) 0);

   n = u_strlen(pt);
#ifdef MEMORY_MASK
   if ((n + 1) >= MEMORY_MASK)
      n = MEMORY_MASK / sizeof(unichar_t) - 1;
#endif
   res = (char *) malloc(n + 1);
   for (rpt = res; --n >= 0; *rpt++ = *pt++);
   *rpt = '\0';
   return (res);
}

unichar_t *utf82u_strncpy(unichar_t * ubuf, const char *utf8buf, int len) {
   unichar_t *upt = ubuf, *uend = ubuf + len - 1;

   const uint8 *pt = (const uint8 *) utf8buf, *end = pt + strlen(utf8buf);

   int w, w2;

   while (pt < end && *pt != '\0' && upt < uend) {
      if (*pt <= 127)
	 *upt = *pt++;
      else if (*pt <= 0xdf) {
	 *upt = ((*pt & 0x1f) << 6) | (pt[1] & 0x3f);
	 pt += 2;
      } else if (*pt <= 0xef) {
	 *upt = ((*pt & 0xf) << 12) | ((pt[1] & 0x3f) << 6) | (pt[2] & 0x3f);
	 pt += 3;
      } else {
	 w = (((*pt & 0x7) << 2) | ((pt[1] & 0x30) >> 4)) - 1;
	 w = (w << 6) | ((pt[1] & 0xf) << 2) | ((pt[2] & 0x30) >> 4);
	 w2 = ((pt[2] & 0xf) << 6) | (pt[3] & 0x3f);
	 *upt = w * 0x400 + w2 + 0x10000;
	 pt += 4;
      }
      ++upt;
   }
   *upt = '\0';
   return (ubuf);
}

unichar_t *utf82u_strcpy(unichar_t * ubuf, const char *utf8buf) {
   return (utf82u_strncpy(ubuf, utf8buf, strlen(utf8buf) + 1));
}

unichar_t *utf82u_copy(const char *utf8buf) {
   int len;

   unichar_t *ubuf;

   if (utf8buf == NULL)
      return (NULL);

   len = strlen(utf8buf);
   ubuf = (unichar_t *) malloc((len + 1) * sizeof(unichar_t));
   return (utf82u_strncpy(ubuf, utf8buf, len + 1));
}

char *latin1_2_utf8_strcpy(char *utf8buf, const char *lbuf) {
   char *pt = utf8buf;

   const unsigned char *lpt = (const unsigned char *) lbuf;

   while (*lpt) {
      if (*lpt < 0x80)
	 *pt++ = *lpt;
      else {
	 *pt++ = 0xc0 | (*lpt >> 6);
	 *pt++ = 0x80 | (*lpt & 0x3f);
      }
      ++lpt;
   }
   *pt = '\0';
   return (utf8buf);
}

char *latin1_2_utf8_copy(const char *lbuf) {
   int len;

   char *utf8buf;

   if (lbuf == NULL)
      return (NULL);

   len = strlen(lbuf);
   utf8buf = (char *) malloc(2 * len + 1);
   return (latin1_2_utf8_strcpy(utf8buf, lbuf));
}

char *utf8_2_latin1_copy(const char *utf8buf) {
   int len;

   int ch;

   char *lbuf, *pt;

   const char *upt;

   if (utf8buf == NULL)
      return (NULL);

   len = strlen(utf8buf);
   pt = lbuf = (char *) malloc(len + 1);
   for (upt = utf8buf; (ch = utf8_ildb(&upt)) != '\0';)
      if (ch >= 0xff)
	 *pt++ = '?';
      else
	 *pt++ = ch;
   *pt = '\0';
   return (lbuf);
}

char *u2utf8_copy(const unichar_t * ubuf) {
/* Make a utf8 string copy of unichar string ubuf */

   if (ubuf == NULL)
      return (NULL);

   return (u2utf8_copyn(ubuf, u_strlen(ubuf) + 1));
}

char *u2utf8_copyn(const unichar_t * ubuf, int len) {
/* Make a utf8 string copy of unichar string ubuf[0..len] */
   char *utf8buf, *pt;

   if (ubuf == NULL || len <= 0
       || (utf8buf = pt = (char *) malloc(len * 6 + 1)) == NULL)
      return (NULL);

   while ((pt = utf8_idpb(pt, *ubuf++, 0)) && --len);
   if (pt) {
      *pt = '\0';
      return (utf8buf);
   }
   free(utf8buf);
   return (NULL);
}

int32 utf8_ildb(const char **_text) {
   int32 val = -1;

   int ch;

   const uint8 *text = (const uint8 *) *_text;

   /* Increment and load character */

   if ((ch = *text++) < 0x80) {
      val = ch;
   } else if (ch <= 0xbf) {
      /* error */
   } else if (ch <= 0xdf) {
      if (*text >= 0x80 && *text < 0xc0)
	 val = ((ch & 0x1f) << 6) | (*text++ & 0x3f);
   } else if (ch <= 0xef) {
      if (*text >= 0x80 && *text < 0xc0 && text[1] >= 0x80 && text[1] < 0xc0) {
	 val =
	    ((ch & 0xf) << 12) | ((text[0] & 0x3f) << 6) | (text[1] & 0x3f);
	 text += 2;
      }
   } else {
      int w = (((ch & 0x7) << 2) | ((text[0] & 0x30) >> 4)) - 1, w2;

      w = (w << 6) | ((text[0] & 0xf) << 2) | ((text[1] & 0x30) >> 4);
      w2 = ((text[1] & 0xf) << 6) | (text[2] & 0x3f);
      val = w * 0x400 + w2 + 0x10000;
      if (*text < 0x80 || text[1] < 0x80 || text[2] < 0x80 ||
	  *text >= 0xc0 || text[1] >= 0xc0 || text[2] >= 0xc0)
	 val = -1;
      else
	 text += 3;
   }
   *_text = (const char *) text;
   return (val);
}

char *utf8_idpb(char *utf8_text, uint32 ch, int flags) {
/* Increment and deposit character, no '\0' appended */
/* NOTE: Unicode only needs range of 17x65535 values */
/* and strings must be long enough to hold +4 chars. */
/* ISO/IEC 10646 description of UTF8 allows encoding */
/* character values up to U+7FFFFFFF before RFC3629. */

   if (ch > 0x7fffffff ||
       (!(flags & UTF8IDPB_OLDLIMIT)
	&& ((ch >= 0xd800 && ch <= 0xdfff) || ch >= 17 * 65536)))
      return (0);		/* Error, ch is out of range */

   if ((flags & (UTF8IDPB_UCS2 | UTF8IDPB_UTF16 | UTF8IDPB_UTF32))) {
      if ((flags & UTF8IDPB_UCS2) && ch > 0xffff)
	 return (0);		/* Error, ch is out of range */
      if ((flags & UTF8IDPB_UTF32)) {
	 *utf8_text++ = ((ch >> 24) & 0xff);
	 *utf8_text++ = ((ch >> 16) & 0xff);
	 ch &= 0xffff;
      }
      if (ch > 0xffff) {
	 /* ...here if a utf16 encoded value */
	 unsigned long us;

	 ch -= 0x10000;
	 us = (ch >> 10) + 0xd800;
	 *utf8_text++ = us >> 8;
	 *utf8_text++ = us & 0xff;
	 ch = (ch & 0x3ff) + 0xdc00;
      }
      *utf8_text++ = ch >> 8;
      ch &= 0xff;
   } else if (ch > 127 || (ch == 0 && (flags & UTF8IDPB_NOZERO))) {
      if (ch <= 0x7ff)
	 /* ch>=0x80 && ch<=0x7ff */
	 *utf8_text++ = 0xc0 | (ch >> 6);
      else {
	 if (ch <= 0xffff)
	    /* ch>=0x800 && ch<=0xffff */
	    *utf8_text++ = 0xe0 | (ch >> 12);
	 else {
	    if (ch <= 0x1fffff)
	       /* ch>=0x10000 && ch<=0x1fffff */
	       *utf8_text++ = 0xf0 | (ch >> 18);
	    else {
	       if (ch <= 0x3ffffff)
		  /* ch>=0x200000 && ch<=0x3ffffff */
		  *utf8_text++ = 0xf8 | (ch >> 24);
	       else {
		  /* ch>=0x4000000 && ch<=0x7fffffff */
		  *utf8_text++ = 0xfc | (ch >> 30);
		  *utf8_text++ = 0x80 | ((ch >> 24) & 0x3f);
	       }
	       *utf8_text++ = 0x80 | ((ch >> 18) & 0x3f);
	    }
	    *utf8_text++ = 0x80 | ((ch >> 12) & 0x3f);
	 }
	 *utf8_text++ = 0x80 | ((ch >> 6) & 0x3f);
      }
      ch = 0x80 | (ch & 0x3f);
   }
   *utf8_text++ = ch;
   return (utf8_text);
}

int utf8_valid(const char *str) {
   /* Is this a valid utf8 string? */
   int ch;

   while ((ch = utf8_ildb(&str)) != '\0')
      if (ch == -1)
	 return (false);

   return (true);
}

long utf82u_strlen(const char *utf8_str) {
/* Count how many shorts needed to represent in UCS2 */
   int32 ch;

   long len = 0;

   while ((ch = utf8_ildb(&utf8_str)) > 0 && ++len > 0)
      if (ch >= 0x10000)
	 ++len;
   return (len);
}

#include <chardata.h>
char *StripToASCII(const char *utf8_str) {
   /* Remove any non-ascii characters: Special case, convert the copyright symbol to (c) */
   char *newcr, *pt, *end;

   int len, ch;

   const unichar_t *alt;

   len = strlen(utf8_str);
   pt = newcr = (char *) malloc(len + 1);
   end = pt + len;
   while ((ch = utf8_ildb(&utf8_str)) != '\0') {
      if (pt >= end) {
	 int off = pt - newcr;

	 newcr = (char *) realloc(newcr, (off + 10) + 1);
	 pt = newcr + off;
	 end = pt + 10;
      }
      if ((ch >= ' ' && ch < '\177') || ch == '\n' || ch == '\t')
	 *pt++ = ch;
      else if (ch == '\r' && *utf8_str != '\n')
	 *pt++ = '\n';
      else if (ch == 0xa9 /* Copyright sign */ ) {
	 char *str = "(c)";

	 if (pt + strlen(str) >= end) {
	    int off = pt - newcr;

	    newcr = (char *) realloc(newcr, (off + 10 + strlen(str)) + 1);
	    pt = newcr + off;
	    end = pt + 10;
	 }
	 while (*str)
	    *pt++ = *str++;
      } else if (unicode_alternates[ch >> 8] != NULL &&
		 (alt = unicode_alternates[ch >> 8][ch & 0xff]) != NULL) {
	 while (*alt != '\0') {
	    if (pt >= end) {
	       int off = pt - newcr;

	       newcr = (char *) realloc(newcr, (off + 10) + 1);
	       pt = newcr + off;
	       end = pt + 10;
	    }
	    if (*alt >= ' ' && *alt < '\177')
	       *pt++ = *alt;
	    else if (*alt == 0x300)
	       *pt++ = '`';
	    else if (*alt == 0x301)
	       *pt++ = '\'';
	    else if (*alt == 0x302)
	       *pt++ = '^';
	    else if (*alt == 0x303)
	       *pt++ = '~';
	    else if (*alt == 0x308)
	       *pt++ = ':';
	    ++alt;
	 }
      }
   }
   *pt = '\0';
   return (newcr);
}

int AllAscii(const char *txt) {
   for (; *txt != '\0'; ++txt) {
      if (*txt == '\t' || *txt == '\n' || *txt == '\r')
	 /* All right */ ;
      else if (*txt < ' ' || *txt >= '\177')
	 return (false);
   }
   return (true);
}
