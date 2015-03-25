/* $Id: afile.h 3861 2015-03-25 14:52:50Z mskala $ */
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

#if 0
#define AFILE FILE
#else
typedef int AFILE;
#endif

AFILE *afopen(const char *,const char *);
int afclose(AFILE *);

AFILE *atmpfile(void);

int afeof(AFILE *);
int aferror(AFILE *);

void arewind(AFILE *);
int afseek(AFILE *,long,int);
long aftell(AFILE *);

int agetc(AFILE *);
int aungetc(int,AFILE *);
int aputc(int,AFILE *);

size_t afread(const void *,size_t, size_t,AFILE *);
size_t afwrite(const void *,size_t, size_t,AFILE *);

int afprintf(AFILE *,const char *,...);

#endif /* ndef _AFILE_H */
