/* $Id: afile.c 3865 2015-03-26 10:37:06Z mskala $ */
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

#include <stdio.h>
#include <stdarg.h>

#include "afile.h"

AFILE *afopen(const char *filename,const char *mode) {
  return (AFILE *)fopen(filename,mode);
}

int afclose(AFILE *f) {
  return fclose((FILE *)f);
}

AFILE *atmpfile(void) {
  return (AFILE *)tmpfile();
}

int afeof(AFILE *f) {
  return feof((FILE *)f);
}

int aferror(AFILE *f) {
  return ferror((FILE *)f);
}

void arewind(AFILE *f) {
  rewind((FILE *)f);
}

int afseek(AFILE *f,long offset,int whence) {
  return fseek((FILE *)f,offset,whence);
}

long aftell(AFILE *f) {
  return ftell((FILE *)f);
}

int agetc(AFILE *f) {
  return getc((FILE *)f);
}

int aungetc(int c,AFILE *f) {
  return ungetc(c,(FILE *)f);
}

int aputc(int c,AFILE *f) {
  return putc(c,(FILE *)f);
}

int afputs(const char *s,AFILE *f) {
  return fputs(s,(FILE *)f);
}

size_t afread(void *ptr,size_t size,size_t nitems,AFILE *f) {
   return fread(ptr,size,nitems,(FILE *)f);
}

size_t afwrite(const void *ptr,size_t size,size_t nitems,AFILE *f) {
   return fwrite(ptr,size,nitems,(FILE *)f);
}

int afprintf(AFILE *f,const char *r,...) {
  va_list args;
  int rval;
  
  va_start(args,r);
  rval=vfprintf((FILE *)f,r,args);
  va_end(args);
  return rval;
}

int avfprintf(AFILE *f,const char *r,va_list args) {
  return vfprintf((FILE *)f,r,args);
}

static int message_level=1;

void ErrorMsg(int level,const char *format,...) {
  va_list args;

  if (level>=message_level) {
    va_start(args,format);
    vfprintf((FILE *)astderr,format,args);
    va_end(args);
  }
}
