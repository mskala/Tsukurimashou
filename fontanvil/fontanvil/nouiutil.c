/* $Id: nouiutil.c 3284 2014-09-09 07:34:26Z mskala $ */
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
#include "uiinterface.h"
#include "splinefont.h"
#include <stdarg.h>
#include <stdio.h>
#include <basics.h>
#include <ustring.h>

void IError(const char *format, ...) {
   va_list ap;

   char buffer[400], *str;

   va_start(ap, format);
   fprintf(stderr, "Internal Error: ");
   vsnprintf(buffer, sizeof(buffer), format, ap);
   str = utf82def_copy(buffer);
   fprintf(stderr, "%s", str);
   if (str[strlen(str) - 1] != '\n')
      putc('\n', stderr);
   free(str);
   va_end(ap);
}

static void NOUI__LogError(const char *format, va_list ap) {
   char buffer[400], *str;

   vsnprintf(buffer, sizeof(buffer), format, ap);
   str = utf82def_copy(buffer);
   fprintf(stderr, "%s", str);
   if (str[strlen(str) - 1] != '\n')
      putc('\n', stderr);
   free(str);
}

void LogError(const char *format, ...) {
   va_list ap;

   va_start(ap, format);
   NOUI__LogError(format, ap);
   va_end(ap);
}

void ff_post_notice(const char *title, const char *statement, ...) {
   va_list ap;

   va_start(ap, statement);
   NOUI__LogError(statement, ap);
   va_end(ap);
}

void ff_post_error(const char *title, const char *statement, ...) {
   va_list ap;

   va_start(ap, statement);
   NOUI__LogError(statement, ap);
   va_end(ap);
}

int ff_ask(const char *title, const char **answers,
		    int def, int cancel, const char *question, ...) {
   return (def);
}

int ff_choose(const char *title, const char **choices, int cnt,
		       int def, const char *question, ...) {
   return (def);
}

int ff_choose_multiple(char *title, const char **choices, char *sel,
				int cnt, char *buts[2], const char *question,
				...) {
   return (-1);
}

char *ff_ask_string(const char *title, const char *def,
		    const char *question, ...) {
   return ((char *) def);
}

int PsStrokeFlagsDlg(void) {
   return (sf_correctdir);
}
