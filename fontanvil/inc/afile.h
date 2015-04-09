/* $Id: afile.h 3899 2015-04-08 17:07:48Z mskala $ */
/*
 * File abstraction for FontAnvil
 * Copyright (C) 2015  Matthew Skala
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Matthew Skala
 * http://ansuz.sooke.bc.ca/
 * mskala@ansuz.sooke.bc.ca
 */

#ifndef _AFILE_H
#define _AFILE_H

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include "fontanvil-config.h"

#ifndef HAVE_OFF_T
typedef long off_t;
#endif

typedef struct _AFILE AFILE;

extern AFILE *astdin,*astdout,*astderr;

AFILE *afopen(const char *,const char *);
AFILE *afpopen(FILE *);
int afclose(AFILE *);

AFILE *atmpfile(void);
AFILE *ps_obfuscated_afile(AFILE *,int);
AFILE *base85_afile(AFILE *);

int afeof(AFILE *);
int aferror(AFILE *);
int aisatty(AFILE *);

int afseek(AFILE *,off_t,int);
off_t aftell(AFILE *);
off_t afilesize(AFILE *);

int agetc(AFILE *);
int aungetc(int,AFILE *);
char *afgets(char *,int,AFILE *);

int aputc(int,AFILE *);
int afputs(const char *,AFILE *);

size_t afread(void *,size_t, size_t,AFILE *);
size_t afwrite(const void *,size_t, size_t,AFILE *);

int afprintf(AFILE *,const char *,...);
int avfprintf(AFILE *,const char * restrict format,va_list);

int afscanf(AFILE *,const char *,...);

/*
 * Error message levels:
 *   0: informational (not an error, but might be written in verbose mode)
 *   1: unavoidable warning and debug messages (occurs in normal operation
 *      and user can't prevent it, such as overlap-related nonsense)
 *   2: non-fatal error that the user ought to prevent
 *   3: fatal error that terminates the program
 */

void ErrorMsg(int,const char *,...);

#endif /* ndef _AFILE_H */
