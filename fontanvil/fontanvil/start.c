/* $Id: start.c 3423 2014-10-26 18:51:07Z mskala $ */
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
#include "fontanvilvw.h"
#include "uiinterface.h"
#include "splinefont.h"
#include <stdarg.h>
#include <stdio.h>
#include <basics.h>
#include <ustring.h>
#include <gfile.h>
#include <time.h>
#include <sys/time.h>
#include <locale.h>
#include <unistd.h>
#include <dynamic.h>
#ifdef __Mac
#   include <stdlib.h>		/* getenv,setenv */
#endif

#include <glib.h>

#include "unicodelibinfo.h"
#include "gb12345.h"

int32 unicode_from_adobestd[256];

struct lconv localeinfo;

static void initadobeenc(void) {
   int i, j;

   for (i = 0; i < 0x100; ++i) {
      if (strcmp(AdobeStandardEncoding[i], ".notdef") == 0)
	 unicode_from_adobestd[i] = 0xfffd;
      else {
	 j = UniFromName(AdobeStandardEncoding[i], ui_none, &custom);
	 if (j == -1)
	    j = 0xfffd;
	 unicode_from_adobestd[i] = j;
      }
   }
}

static void initrand(void) {
   struct timeval tv;

   gettimeofday(&tv, NULL);
   srand(tv.tv_usec);
   g_random_set_seed(tv.tv_usec);
}

static void DefaultXUID(void) {
   /* Adobe has assigned PfaEdit a base XUID of 1021. Each new user is going */
   /*  to get a couple of random numbers appended to that, hoping that will */
   /*  make for a fairly safe system. */
   /* FontAnvil will use the same scheme */
   int r1, r2;
   char buffer[50];
   struct timeval tv;

   gettimeofday(&tv, NULL);
   srand(tv.tv_usec);
   do {
      r1 = rand() & 0x3ff;
   } while (r1 == 0);		/* I reserve "0" for me! */
   gettimeofday(&tv, NULL);
   g_random_set_seed(tv.tv_usec + 1);
   r2 = g_random_int();
   sprintf(buffer, "1021 %d %d", r1, r2);
   free(xuid);
   xuid = copy(buffer);
}

#include <charset.h>		/* we still need the charsets & encoding to set local_encoding */
static int encmatch(const char *enc, int subok) {
   static struct {
      char *name;
      int enc;
   } encs[] = {
      {
      "US-ASCII", e_usascii}, {
      "ASCII", e_usascii}, {
      "ISO646-NO", e_iso646_no}, {
      "ISO646-SE", e_iso646_se}, {
      "LATIN1", e_iso8859_1}, {
      "ISO-8859-1", e_iso8859_1}, {
      "ISO-8859-2", e_iso8859_2}, {
      "ISO-8859-3", e_iso8859_3}, {
      "ISO-8859-4", e_iso8859_4}, {
      "ISO-8859-5", e_iso8859_4}, {
      "ISO-8859-6", e_iso8859_4}, {
      "ISO-8859-7", e_iso8859_4}, {
      "ISO-8859-8", e_iso8859_4}, {
      "ISO-8859-9", e_iso8859_4}, {
      "ISO-8859-10", e_iso8859_10}, {
      "ISO-8859-11", e_iso8859_11}, {
      "ISO-8859-13", e_iso8859_13}, {
      "ISO-8859-14", e_iso8859_14}, {
      "ISO-8859-15", e_iso8859_15}, {
      "ISO_8859-1", e_iso8859_1}, {
      "ISO_8859-2", e_iso8859_2}, {
      "ISO_8859-3", e_iso8859_3}, {
      "ISO_8859-4", e_iso8859_4}, {
      "ISO_8859-5", e_iso8859_4}, {
      "ISO_8859-6", e_iso8859_4}, {
      "ISO_8859-7", e_iso8859_4}, {
      "ISO_8859-8", e_iso8859_4}, {
      "ISO_8859-9", e_iso8859_4}, {
      "ISO_8859-10", e_iso8859_10}, {
      "ISO_8859-11", e_iso8859_11}, {
      "ISO_8859-13", e_iso8859_13}, {
      "ISO_8859-14", e_iso8859_14}, {
      "ISO_8859-15", e_iso8859_15}, {
      "ISO8859-1", e_iso8859_1}, {
      "ISO8859-2", e_iso8859_2}, {
      "ISO8859-3", e_iso8859_3}, {
      "ISO8859-4", e_iso8859_4}, {
      "ISO8859-5", e_iso8859_4}, {
      "ISO8859-6", e_iso8859_4}, {
      "ISO8859-7", e_iso8859_4}, {
      "ISO8859-8", e_iso8859_4}, {
      "ISO8859-9", e_iso8859_4}, {
      "ISO8859-10", e_iso8859_10}, {
      "ISO8859-11", e_iso8859_11}, {
      "ISO8859-13", e_iso8859_13}, {
      "ISO8859-14", e_iso8859_14}, {
      "ISO8859-15", e_iso8859_15}, {
      "ISO88591", e_iso8859_1}, {
      "ISO88592", e_iso8859_2}, {
      "ISO88593", e_iso8859_3}, {
      "ISO88594", e_iso8859_4}, {
      "ISO88595", e_iso8859_4}, {
      "ISO88596", e_iso8859_4}, {
      "ISO88597", e_iso8859_4}, {
      "ISO88598", e_iso8859_4}, {
      "ISO88599", e_iso8859_4}, {
      "ISO885910", e_iso8859_10}, {
      "ISO885911", e_iso8859_11}, {
      "ISO885913", e_iso8859_13}, {
      "ISO885914", e_iso8859_14}, {
      "ISO885915", e_iso8859_15}, {
      "8859_1", e_iso8859_1}, {
      "8859_2", e_iso8859_2}, {
      "8859_3", e_iso8859_3}, {
      "8859_4", e_iso8859_4}, {
      "8859_5", e_iso8859_4}, {
      "8859_6", e_iso8859_4}, {
      "8859_7", e_iso8859_4}, {
      "8859_8", e_iso8859_4}, {
      "8859_9", e_iso8859_4}, {
      "8859_10", e_iso8859_10}, {
      "8859_11", e_iso8859_11}, {
      "8859_13", e_iso8859_13}, {
      "8859_14", e_iso8859_14}, {
      "8859_15", e_iso8859_15}, {
      "KOI8-R", e_koi8_r}, {
      "KOI8R", e_koi8_r}, {
      "WINDOWS-1252", e_win}, {
      "CP1252", e_win}, {
      "Big5", e_big5}, {
      "Big-5", e_big5}, {
      "BigFive", e_big5}, {
      "Big-Five", e_big5}, {
      "Big5HKSCS", e_big5hkscs}, {
      "Big5-HKSCS", e_big5hkscs}, {
      "UTF-8", e_utf8}, {
      "utf-8", e_utf8}, {
      "UTF8", e_utf8}, {
      "utf8", e_utf8}, {
      "ISO-10646/UTF-8", e_utf8}, {
      "ISO_10646/UTF-8", e_utf8}, {
      "UCS2", e_unicode}, {
      "UCS-2", e_unicode}, {
      "UCS-2-INTERNAL", e_unicode}, {
      "ISO-10646", e_unicode}, {
      "ISO_10646", e_unicode},
	 /* { "eucJP", e_euc }, */
	 /* { "EUC-JP", e_euc }, */
	 /* { "ujis", ??? }, */
	 /* { "EUC-KR", e_euckorean }, */
      {
      NULL, 0}
   };
   int i;

   char buffer[80];

#if HAVE_ICONV_H
   static char *last_complaint;

   iconv_t test;

   free(iconv_local_encoding_name);
   iconv_local_encoding_name = NULL;
#endif

   if (strchr(enc, '@') != NULL && strlen(enc) < sizeof(buffer) - 1) {
      strcpy(buffer, enc);
      *strchr(buffer, '@') = '\0';
      enc = buffer;
   }

   for (i = 0; encs[i].name != NULL; ++i)
      if (strmatch(enc, encs[i].name) == 0)
	 return (encs[i].enc);

   if (subok) {
      for (i = 0; encs[i].name != NULL; ++i)
	 if (strstrmatch(enc, encs[i].name) != NULL)
	    return (encs[i].enc);

#if HAVE_ICONV_H
      /* I only try to use iconv if the encoding doesn't match one I support */
      /*  loading iconv unicode data takes a while */
      test = iconv_open(enc, FindUnicharName());
      if (test == (iconv_t) (-1) || test == NULL) {
	 if (last_complaint == NULL || strcmp(last_complaint, enc) != 0) {
	    fprintf(stderr,
		    "Neither FontAnvil nor iconv() supports your encoding (%s) we will pretend\n you asked for latin1 instead.\n",
		    enc);
	    free(last_complaint);
	    last_complaint = copy(enc);
	 }
      } else {
	 if (last_complaint == NULL || strcmp(last_complaint, enc) != 0) {
	    fprintf(stderr,
		    "FontAnvil does not support your encoding (%s), it will try to use iconv()\n or it will pretend the local encoding is latin1\n",
		    enc);
	    free(last_complaint);
	    last_complaint = copy(enc);
	 }
	 iconv_local_encoding_name = copy(enc);
	 iconv_close(test);
      }
#else
      fprintf(stderr,
	      "FontAnvil does not support your encoding (%s), it will pretend the local encoding is latin1\n",
	      enc);
#endif

      return (e_iso8859_1);
   }
   return (e_unknown);
}

static int DefaultEncoding(void) {
   const char *loc;
   int enc;

#if HAVE_LANGINFO_H
   loc = nl_langinfo(CODESET);
   enc = encmatch(loc, false);
   if (enc != e_unknown)
      return (enc);
#endif
   loc = getenv("LC_ALL");
   if (loc == NULL)
      loc = getenv("LC_CTYPE");
   /*if ( loc==NULL ) loc = getenv("LC_MESSAGES"); */
   if (loc == NULL)
      loc = getenv("LANG");

   if (loc == NULL)
      return (e_iso8859_1);

   enc = encmatch(loc, false);
   if (enc == e_unknown) {
      loc = strrchr(loc, '.');
      if (loc == NULL)
	 return (e_iso8859_1);
      enc = encmatch(loc + 1, true);
   }
   if (enc == e_unknown)
      return (e_iso8859_1);

   return (enc);
}

void InitSimpleStuff(void) {

   initrand();
   initadobeenc();

   if (!AddEncoding
       ("EUC-GB12345", euc_gb12345_to_uni, uni_to_euc_gb12345, 65535))
      LogError("Failed to add EUC-GB12345");

   setlocale(LC_ALL, "");
   localeinfo = *localeconv();
   if (getenv("FF_SCRIPT_IN_LATIN1"))
      use_utf8_in_script = false;

   inituninameannot();		/* Note: unicodenames done after locales set */

   DefaultXUID();
   local_encoding = DefaultEncoding();
}
