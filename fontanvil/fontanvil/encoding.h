/* $Id: encoding.h 3326 2014-09-29 07:28:28Z mskala $ */
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
   uint32 *unicode;
   char **name;
   struct cidaltuni *alts;
   struct cidmap *next;
};

extern struct cidmap *cidmaps;
#endif
