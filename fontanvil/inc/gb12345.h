/* $Id: gb12345.h 3879 2015-03-28 11:08:16Z mskala $ */
/*
 * Prototypes for FontAnvil to use GB12345 without a "plugin"
 * Copyright (C) 2014  Matthew Skala
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
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

typedef int (*EncFunc) (int);

int AddEncoding(char *, EncFunc, EncFunc, int);
extern int euc_gb12345_to_uni(int);
extern int uni_to_euc_gb12345(int);
