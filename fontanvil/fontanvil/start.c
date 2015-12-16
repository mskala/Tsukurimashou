/* $Id: start.c 4494 2015-12-12 08:13:24Z mskala $ */
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
#include "fontanvilvw.h"
#include "uiinterface.h"
#include "splinefont.h"
#include <stdarg.h>
#include <stdio.h>
#include "fontanvil.h"
#include <ustring.h>
#include <gfile.h>
#include <time.h>
#include <sys/time.h>
#include <locale.h>
#include <unistd.h>
#ifdef __Mac
#   include <stdlib.h>		/* getenv,setenv */
#endif

#include "unicodelibinfo.h"
#include "gb12345.h"
#include "SFMT.h"

sfmt_t fa_sfmt;

int32_t unicode_from_adobestd[256];

struct lconv localeinfo;

static void initadobeenc(void) {
   int i, j;

   for (i=0; i < 0x100; ++i) {
      if (strcmp(AdobeStandardEncoding[i], ".notdef")==0)
	 unicode_from_adobestd[i]=0xfffd;
      else {
	 j=UniFromName(AdobeStandardEncoding[i], ui_none, &custom);
	 if (j==-1)
	    j=0xfffd;
	 unicode_from_adobestd[i]=j;
      }
   }
}

static void initrand(void) {
   struct timeval tv;
   uint32_t seed[3];

   gettimeofday(&tv, NULL);
   seed[0]=tv.tv_sec;
   seed[1]=tv.tv_usec;
   seed[2]=getpid();
   sfmt_init_by_array(&fa_sfmt,seed,3);
}

static void DefaultXUID(void) {
   /* Adobe has assigned PfaEdit a base XUID of 1021. Each new user is going */
   /*  to get a couple of random numbers appended to that, hoping that will */
   /*  make for a fairly safe system. */
   /* FontAnvil will use the same scheme */
   int r1, r2;
   char buffer[50];
   struct timeval tv;

   r1=sfmt_genrand_uint32(&fa_sfmt)&0x3ff;
   gettimeofday(&tv, NULL);
   r2=sfmt_genrand_uint32(&fa_sfmt)&0x7FFFFFF;
   sprintf(buffer, "1021 %d %d", r1+1, r2);
   free(xuid);
   xuid=fastrdup(buffer);
}

void InitSimpleStuff(void) {
   astderr=afpopen(stderr);
   astdin=afpopen(stdin);
   astdout=afpopen(stdout);

   initrand();
   initadobeenc();

   if (!AddEncoding
       ("EUC-GB12345", euc_gb12345_to_uni, uni_to_euc_gb12345, 65535))
      ErrorMsg(2,"Failed to add EUC-GB12345\n");

   setlocale(LC_ALL,"C");
   localeinfo=*localeconv();
   inituninameannot();		/* Note: unicodenames done after locales set */
   DefaultXUID();
}
