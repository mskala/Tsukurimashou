/* $Id: ustring.c 2918 2014-03-07 16:09:49Z mskala $ */
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
#include <stddef.h>
#include "ustring.h"
#include "utype.h"

long uc_strcmp(const unichar_t * str1, const char *str2) {
   long ch1, ch2;

   for (;;) {
      ch1 = *str1++;
      ch2 = *(unsigned char *) str2++;
      if (ch1 != ch2 || ch1 == '\0')
	 return (ch1 - ch2);
   }
}

long u_strcmp(const unichar_t * str1, const unichar_t * str2) {
   long ch1, ch2;

   for (;;) {
      ch1 = *str1++;
      ch2 = *str2++;
      if (ch1 != ch2 || ch1 == '\0')
	 return (ch1 - ch2);
   }
}

void uc_strcpy(unichar_t * to, const char *from) {
   register unichar_t ch;

   while ((ch = *(unsigned char *) from++) != '\0')
      *(to++) = ch;
   *to = 0;
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

void cu_strncpy(register char *to, const unichar_t * from, int len) {
   register unichar_t ch;

   while ((ch = *from++) != '\0' && --len >= 0)
      *(to++) = ch;
   *to = 0;
}

void uc_strncpy(register unichar_t * to, const char *from, int len) {
   register unichar_t ch;

   while ((ch = *(unsigned char *) from++) != '\0' && --len >= 0)
      *(to++) = ch;
   *to = 0;
}

int u_strlen(register const unichar_t * str) {
   register int len = 0;

   while (*str++ != '\0')
      ++len;
   return (len);
}

unichar_t *u_strchr(const unichar_t * str, unichar_t ch) {
   register unichar_t test;

   while ((test = *(str++)) != '\0')
      if (test == ch)
	 return ((unichar_t *) str - 1);

   return (NULL);
}

unichar_t *uc_strstr(const unichar_t * longer, const char *substr) {
   long ch1, ch2;

   const unichar_t *lpt, *str1;

   const char *str2;

   for (lpt = longer; *lpt != '\0'; ++lpt) {
      str1 = lpt;
      str2 = substr;
      for (;;) {
	 ch1 = *str1++;
	 ch2 = *(unsigned char *) str2++;
	 if (ch2 == '\0')
	    return ((unichar_t *) lpt);
	 if (ch1 != ch2)
	    break;
      }
   }
   return (NULL);
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

char *cu_copyn(const unichar_t * pt, int len) {
   char *res, *rpt;

   if (!pt)
      return (NULL);

#ifdef MEMORY_MASK
   if ((len + 1) >= MEMORY_MASK)
      len = MEMORY_MASK - 1;
#endif
   res = (char *) malloc(len + 1);
   for (rpt = res; --len >= 0; *rpt++ = *pt++);
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

unichar_t *c_to_u(const char *buf) {
   static unichar_t ubuf[400];

   uc_strncpy(ubuf, buf, sizeof(ubuf));
   return (ubuf);
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

unichar_t *utf82u_copyn(const char *utf8buf, int len) {
   unichar_t *ubuf = (unichar_t *) malloc((len + 1) * sizeof(unichar_t));

   return (utf82u_strncpy(ubuf, utf8buf, len + 1));
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

void utf82u_strcat(unichar_t * to, const char *from) {
   utf82u_strcpy(to + u_strlen(to), from);
}

char *u2utf8_strcpy(char *utf8buf, const unichar_t * ubuf) {
/* Copy unichar string 'ubuf' into utf8 buffer string 'utf8buf' */
   char *pt = utf8buf;

   if (ubuf != NULL) {
      while (*ubuf && (pt = utf8_idpb(pt, *ubuf++, 0)));
      if (pt) {
	 *pt = '\0';
	 return (utf8buf);
      }
   }
   return (NULL);
}

char *utf8_strchr(const char *str, int search) {
   int ch;

   const char *old = str;

   while ((ch = utf8_ildb(&str)) != 0) {
      if (ch == search)
	 return ((char *) old);
      old = str;
   }
   return (NULL);
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

char *utf8_ib(char *utf8_text) {
/* Increment to next utf8 character */
   unsigned char ch;

   if ((ch = (unsigned char) *utf8_text) == '\0')
      return (utf8_text);
   else if (ch <= 127)
      return (utf8_text + 1);
   else if (ch < 0xe0)
      return (utf8_text + 2);
   else if (ch < 0xf0)
      return (utf8_text + 3);
   else if (ch < 0xf8)
      return (utf8_text + 4);
   else if (ch < 0xfc)
      return (utf8_text + 5);
   else
      return (utf8_text + 6);
}

int utf8_valid(const char *str) {
   /* Is this a valid utf8 string? */
   int ch;

   while ((ch = utf8_ildb(&str)) != '\0')
      if (ch == -1)
	 return (false);

   return (true);
}

void utf8_truncatevalid(char *str) {
   /* There are certain cases where we have a fixed amount of space to display */
   /*  something, and if it doesn't fit in that, then we truncate it. But... */
   /*  that can leave us with a half completed utf8 byte sequence. So truncate */
   /*  again, right before the start of the bad sequence */
   int ch;

   char *old;

   old = str;
   while ((ch = utf8_ildb((const char **) &str)) != '\0') {
      if (ch == -1) {
	 *old = '\0';
	 return;
      }
      old = str;
   }
}

char *utf8_db(char *utf8_text) {
/* Decrement utf8 pointer to previous utf8 character.*/
/* NOTE: This should never happen but if the pointer */
/* was looking at an intermediate character, it will */
/* be properly positioned at the start of a new char */
/* and not the previous character.		     */
   unsigned char *pt = (unsigned char *) utf8_text;

   --pt;
   if (*pt >= 0x80 && *pt < 0xc0) {
      --pt;
      if (*pt >= 0x80 && *pt < 0xc0) {
	 --pt;
	 if (*pt >= 0x80 && *pt < 0xc0) {
	    --pt;
	    if (*pt >= 0x80 && *pt < 0xc0) {
	       --pt;
	       if (*pt >= 0x80 && *pt < 0xc0)
		  --pt;
	    }
	 }
      }
   }
   return ((char *) pt);
}

long utf8_strlen(const char *utf8_str) {
/* Count how many characters in the string NOT bytes */
   long len = 0;

   while (utf8_ildb(&utf8_str) > 0 && ++len > 0);
   return (len);
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

void utf8_strncpy(register char *to, const char *from, int len) {
   /* copy n characters NOT bytes */
   const char *old = from;

   while (len && *old) {
      utf8_ildb(&old);
      len--;
   }
   strncpy(to, from, old - from);
   to[old - from] = 0;
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

int uAllAscii(const unichar_t * txt) {
   for (; *txt != '\0'; ++txt) {
      if (*txt == '\t' || *txt == '\n' || *txt == '\r')
	 /* All right */ ;
      else if (*txt < ' ' || *txt >= '\177')
	 return (false);
   }
   return (true);
}

char *chomp(char *line) {
   if (!line)
      return line;
   if (line[strlen(line) - 1] == '\n')
      line[strlen(line) - 1] = '\0';
   if (line[strlen(line) - 1] == '\r')
      line[strlen(line) - 1] = '\0';
   return line;
}

char *copytolower(const char *input) {
   char *ret = copy(input);

   char *p = ret;

   for (; *p; ++p) {
      *p = tolower(*p);
   }
   return ret;
}


int endswith(const char *haystack, const char *needle) {
   int haylen = strlen(haystack);

   int nedlen = strlen(needle);

   if (haylen < nedlen)
      return 0;
   char *p = strstr(haystack + haylen - nedlen, needle);

   return p == (haystack + haylen - nedlen);
}

int endswithi(const char *haystackZ, const char *needleZ) {
   char *haystack = copytolower(haystackZ);

   char *needle = copytolower(needleZ);

   int ret = endswith(haystack, needle);

   free(haystack);
   free(needle);
   return ret;
}

int endswithi_partialExtension(const char *haystackZ, const char *needleZ) {
   int nedlen = strlen(needleZ);

   if (nedlen == 0) {
      return 0;
   }
   char *haystack = copytolower(haystackZ);

   char *needle = copytolower(needleZ);

   int ret = 0;

   int i = nedlen - 1;

   ret |= endswith(haystack, needle);
   for (; i >= 0 && !ret; --i) {
      needle[i] = '\0';
      ret |= endswith(haystack, needle);
   }
   free(haystack);
   free(needle);
   return ret;
}

char *str_replace_all(char *s, char *orig, char *replacement, int free_s) {
   char *p = strstr(s, orig);

   if (!p) {
      if (free_s)
	 return s;
      return copy(s);
   }

   int count = 0;

   p = s;
   while (p) {
      p = strstr(p, orig);
      if (!p)
	 break;
      p++;
      count++;
   }
   count++;

   // more than strictly needed, but always enough RAM.
   int retsz = strlen(s) + count * strlen(replacement) + 1;

   char *ret = (char *) malloc(retsz);

   memset(ret, '\0', retsz);
   char *output = ret;

   char *remains = s;

   p = remains;
   while (p) {
      p = strstr(remains, orig);
      if (!p) {
	 strcpy(output, remains);
	 break;
      }
      if (p > remains)
	 strncpy(output, remains, p - remains);
      strcat(output, replacement);
      output += strlen(output);
      remains = p + strlen(orig);
   }

   if (free_s)
      free(s);
   return ret;
}
