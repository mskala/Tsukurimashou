/* $Id: flaglist.h 4025 2015-06-17 07:34:23Z mskala $ */
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

#endif
