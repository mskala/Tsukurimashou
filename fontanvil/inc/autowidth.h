/* $Id: autowidth.h 4464 2015-11-30 09:57:27Z mskala $ */

struct charone {
   double lbearing, rmax;
   double newl, newr;
   int baseserif, lefttops, righttops;	/* serif zones which affect this character */
   SplineChar *sc;
   int base, top;		/* bottom of character, number of decimation zones we've got */
   short *ledge;
   short *redge;
   struct charpair *asleft;
   struct charpair *asright;
};

struct charpair {
   struct charone *left, *right;
   struct charpair *nextasleft, *nextasright;
   int base, top;
   short *distances;
   short visual;
};

typedef struct widthinfo {
   double spacing;		/* desired spacing between letters */
   double decimation;
   double serifsize;
   double seriflength;
   double caph;
   double descent;
   double xheight;
   double n_stem_exterior_width, n_stem_interior_width;
   double current_I_spacing;
   int serifs[4][2];		/* Four serif zones: descent, baseline, xheight, cap */
   int lcnt, rcnt;		/* count of left and right chars respectively */
   int real_lcnt, real_rcnt;	/* what the user asked for. We might add I */
   int tcnt;			/* sum of r+l cnt */
   int pcnt;			/* pair count, often r*l cnt */
   int l_Ipos, r_Ipos;
   struct charone **left, **right;
   struct charpair **pairs;
   int space_guess;
   int threshold;
   SplineFont *sf;
   FontViewBase *fv;
   int layer;
   unsigned int done:1;
   unsigned int autokern:1;
   unsigned int onlynegkerns:1;
   struct lookup_subtable *subtable;
} WidthInfo;

#define NOTREACHED	-9999.0

extern SplineFont *aw_old_sf;

extern int aw_old_spaceguess;
