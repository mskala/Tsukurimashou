/*
 * Test an integer map
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
#include <stdlib.h>

#include "map.h"

int main(int argc,char **argv) {
#ifdef STRINGVAL
   long int i,lo,hi;
   char *j;
#else
   long int i,j,lo,hi;
#endif

   lo=atol(argv[1]);
   hi=atol(argv[2]);

   puts("TOP");
   for (i=lo;i<=hi;i++) {
      j=map_lookup(i);
      if (j!=0)
#ifdef STRINGVAL
	printf("%ld -> \"%s\"\n",i,j);
#else
	printf("%ld -> %ld\n",i,j);
#endif
   }
   puts("BOTTOM");

   exit(0);
}

