/* $Id: flaglist.h 3879 2015-03-28 11:08:16Z mskala $ */
/* flaglist.h */
#ifndef _FLAGLIST_H_
#   define _FLAGLIST_H_

#   include "fontanvil.h"

struct flaglist {
   const char *name;
   int flag;
};

#   define FLAGLIST_EMPTY { NULL, 0 }
#   define FLAG_UNKNOWN ((int32_t)0x80000000)

extern int FindFlagByName(struct flaglist *flaglist, const char *name);

extern const char *FindNameOfFlag(struct flaglist *flaglist, int flag);

#endif
