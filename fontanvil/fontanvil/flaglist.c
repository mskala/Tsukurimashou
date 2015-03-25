/* $Id: flaglist.c 3857 2015-03-25 13:26:40Z mskala $ */
#include <basics.h>
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
