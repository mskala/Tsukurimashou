/* $Id: afile.h 4524 2015-12-20 19:28:13Z mskala $ */
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

ssize_t agetline(char **,size_t *,AFILE *);

/* any of these reading less than 32 bits return 32-bit -1 on error
 * never mind that's in-band in the signed case; it's what seems most
 * compatible with the FontForge routines they replace */

int32_t aget_uint8_be(AFILE *);
int32_t aget_uint8_le(AFILE *);
int32_t aget_int8_be(AFILE *);
int32_t aget_int8_le(AFILE *);

int32_t aget_uint16_be(AFILE *);
int32_t aget_uint16_le(AFILE *);
int32_t aget_int16_be(AFILE *);
int32_t aget_int16_le(AFILE *);

int32_t aget_uint24_be(AFILE *);
int32_t aget_uint24_le(AFILE *);
int32_t aget_int24_be(AFILE *);
int32_t aget_int24_le(AFILE *);

uint32_t aget_uint32_be(AFILE *);
uint32_t aget_uint32_le(AFILE *);
int32_t aget_int32_be(AFILE *);
int32_t aget_int32_le(AFILE *);

uint64_t aget_uint64_be(AFILE *);
uint64_t aget_uint64_le(AFILE *);
int64_t aget_int64_be(AFILE *);
int64_t aget_int64_le(AFILE *);

/* "read" version reads to a pointer, returns -1 on failure, 0 on success */

int aread_uint32_be(AFILE *,uint32_t *);
int aread_uint32_le(AFILE *,uint32_t *);
int aread_int32_be(AFILE *,int32_t *);
int aread_int32_le(AFILE *,int32_t *);

int aread_uint64_be(AFILE *,uint64_t *);
int aread_uint64_le(AFILE *,uint64_t *);
int aread_int64_be(AFILE *,int64_t *);
int aread_int64_le(AFILE *,int64_t *);

int aput_uint8_be(uint8_t,AFILE *);
int aput_uint8_le(uint8_t,AFILE *);
int aput_int8_be(int8_t,AFILE *);
int aput_int8_le(int8_t,AFILE *);

int aput_uint16_be(uint16_t,AFILE *);
int aput_uint16_le(uint16_t,AFILE *);
int aput_int16_be(int16_t,AFILE *);
int aput_int16_be_checked(int32_t,AFILE *);
int aput_int16_le(int16_t,AFILE *);

int aput_uint24_be(uint32_t,AFILE *);
int aput_uint24_le(uint32_t,AFILE *);
int aput_int24_be(int32_t,AFILE *);
int aput_int24_le(int32_t,AFILE *);

int aput_uint32_be(uint32_t,AFILE *);
int aput_uint32_le(uint32_t,AFILE *);
int aput_int32_be(int32_t,AFILE *);
int aput_int32_le(int32_t,AFILE *);

int aput_uint64_be(uint64_t,AFILE *);
int aput_uint64_le(uint64_t,AFILE *);
int aput_int64_be(int64_t,AFILE *);
int aput_int64_le(int64_t,AFILE *);

/*
 * Error message levels:
 *   0: informational (not an error, but might be written in verbose mode)
 *   1: unavoidable warning and debug messages (occurs in normal operation
 *      and user can't prevent it, such as overlap-related nonsense)
 *   2: non-fatal error that the user ought to prevent
 *   3: fatal error that terminates the program
 */

extern int message_level;
void ErrorMsg(int,const char *,...);

#endif /* ndef _AFILE_H */
