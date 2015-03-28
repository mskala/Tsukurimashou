/* $Id: flaglist.c 3879 2015-03-28 11:08:16Z mskala $ */
#include "fontanvil.h"
#include <string.h>
#include "flaglist.h"

const char *FindNameOfFlag(struct flaglist *flags, int flag) {
   int i;

   for (i=0; flags[i].name != NULL; ++i) {
      if (flags[i].flag==flag)
	 return flags[i].name;
   }
   return NULL;
}
