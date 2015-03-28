/* $Id: encoding.h 3879 2015-03-28 11:08:16Z mskala $ */
#ifndef _ENCODING_H
#   define _ENCODING_H

struct cidaltuni {
   struct cidaltuni *next;
   int uni;
   int cid;
};

struct cidmap {
   char *registry, *ordering;
   int supplement, maxsupple;
   int cidmax;			/* Max cid found in the charset */
   int namemax;			/* Max cid with useful info */
   uint32_t *unicode;
   char **name;
   struct cidaltuni *alts;
   struct cidmap *next;
};

extern struct cidmap *cidmaps;
#endif
