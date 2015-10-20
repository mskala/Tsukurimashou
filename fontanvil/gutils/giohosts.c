/* $Id: giohosts.c 4286 2015-10-20 10:46:56Z mskala $ */
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
#include "fontanvil.h"
#include "gfile.h"
#include "ustring.h"
#include "utype.h"

#   ifdef HAVE_PTHREAD_H
#      include <pthread.h>
#   endif

#if !defined(__MINGW32__)
#   include <netdb.h>
#endif

struct passwd_cache {
   char *proto;
   char *host;
   char *username;
   char *password;
};

static int pc_cnt = 0, pc_max = 0;

struct passwd_cache *pc = NULL;

char *GIO_PasswordCache(char *proto, char *host, char *username,
			char *password) {
   int i;

#ifdef HAVE_PTHREAD_H
   static pthread_mutex_t mymutex = PTHREAD_MUTEX_INITIALIZER;
#endif

   if (proto == NULL || host == NULL || username == NULL)
      return (password);

#ifdef HAVE_PTHREAD_H
   pthread_mutex_lock(&mymutex);
#endif

   for (i = 0; i < pc_cnt; ++i) {
      if (strcasecmp(proto, pc[i].proto) == 0 &&
	  strcasecmp(host, pc[i].host) == 0 &&
	  strcmp(username, pc[i].username) == 0) {
	 if (password == NULL) {
	    password = fastrdup(pc[i].password);
	    goto leave;
	 }
	 if (strcmp(password, pc[i].password) != 0) {
	    free(pc[i].password);
	    pc[i].password = fastrdup(password);
	 }
	 goto leave;
      }
   }

   if (password == NULL)
      goto leave;

   if (pc_cnt >= pc_max)
      pc = realloc(pc, (pc_max += 10) * sizeof(struct passwd_cache));
   pc[pc_cnt].proto = fastrdup(proto);
   pc[pc_cnt].host = fastrdup(host);
   pc[pc_cnt].username = fastrdup(username);
   pc[pc_cnt].password = fastrdup(password);
   ++pc_cnt;
 leave:
#ifdef HAVE_PTHREAD_H
   pthread_mutex_unlock(&mymutex);
#endif

   return (password);
}
