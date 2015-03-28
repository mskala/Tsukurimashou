/* $Id: autowidth.h 3879 2015-03-28 11:08:16Z mskala $ */

struct charone {
   real lbearing, rmax;
   real newl, newr;
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
   real spacing;		/* desired spacing between letters */
   real decimation;
   real serifsize;
   real seriflength;
   real caph;
   real descent;
   real xheight;
   real n_stem_exterior_width, n_stem_interior_width;
   real current_I_spacing;
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

extern void AW_AutoWidth(WidthInfo * wi);

extern SplineFont *aw_old_sf;

extern int aw_old_spaceguess;
