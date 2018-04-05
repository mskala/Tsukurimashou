/* $Id: splinefont.h 5734 2017-11-10 04:37:40Z mskala $ */
/* Copyright (C) 2000-2012  George Williams
 * Copyright (C) 2015, 2016  Matthew Skala
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * The name of the author may not be used to endorse or promote products
 * derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#ifndef _SPLINEFONT_H
# define _SPLINEFONT_H

# include "fontanvil.h"
# include <iconv.h>
/* libiconv.h defines iconv as taking a const pointer for inbuf.
 * iconv doesn't.  OH, JOY!  A new version of libiconv does not use
 * the const! Even better, the man page says it does */
# ifdef _LIBICONV_VERSION
#  if _LIBICONV_VERSION >= 0x10B
#   define ICONV_CONST
#  else
#   define ICONV_CONST	const
#  endif
# else
#  define ICONV_CONST
# endif

# define CHR(ch1,ch2,ch3,ch4) (((ch1)<<24)|((ch2)<<16)|((ch3)<<8)|(ch4))

# define MmMax		16
/* PS says at most this many instances for type1/2 mm fonts */
# define AppleMmMax	26	/* Apple sort of has a limit of 4095,
				 * but we only support this many */
#include "afile.h"

typedef struct ipoint {
   int x;
   int y;
} IPoint;
# define IPOINT_EMPTY { 0,0 }

typedef struct basepoint {
   double x;
   double y;
} BasePoint;
# define BASEPOINT_EMPTY { (double)0.0,(double)0.0 }

typedef struct dbasepoint {
   double x;
   double y;
} DBasePoint;
# define DBASEPOINT_EMPTY { (double)0.0,(double)0.0 }

typedef struct tpoint {
   double x;
   double y;
   double t;
} TPoint;
# define TPOINT_EMPTY { (double)0.0,(double)0.0,(double)0.0 }

typedef struct dbounds {
   double minx,maxx;
   double miny,maxy;
} DBounds;
# define DBOUNDS_EMPTY { (double)0.0,(double)0.0,(double)0.0,(double)0.0 }

typedef struct ibounds {
   int minx,maxx;
   int miny,maxy;
} IBounds;
# define IBOUNDS_EMPTY { 0,0,0,0 }

enum val_type { v_int,v_real,v_str,v_unicode,v_lval,v_arr,v_arrfree,
     v_int32pt,v_int16pt,v_int8pt,v_void
};

typedef struct val {
   enum val_type type;
   union {
      int ival;
      double fval;
      char *sval;
      struct val *lval;
      struct array *aval;
      uint32_t *u32ptval;
      uint16_t *u16ptval;
      uint8_t *u8ptval;
   } u;
} Val;		   /* Used by scripting */

struct psdict {
   int cnt;	   /* *key[0..cnt] and *values[0..cnt] currently available */
   int next;	   /* **key[0..next] and **values[0..next] currently used  */
   char **keys;
   char **values;
};

struct pschars {
   int cnt,next;
   char **keys;
   uint8_t **values;
   int *lens;
   int bias;			/* for type2 strings */
};

enum linejoin {
   lj_miter,			/* Extend lines until they meet */
     lj_round,			/* circle centered at the join of expand radius */
     lj_bevel,			/* Straight line between the ends of next and prev */
     lj_inherited
};

enum linecap {
   lc_butt,			/* equiv to lj_bevel, straight line extends from one side to other */
     lc_round,			/* semi-circle */
     lc_square,			/* Extend lines by radius, then join them */
     lc_inherited
};

enum spreadMethod {
   sm_pad,sm_reflect,sm_repeat
};

# define COLOR_INHERITED	0xfffffffe

struct grad_stops {
   double offset;
   uint32_t col;
   double opacity;
};

struct gradient {
   BasePoint start;		/* focal of a radial gradient, start of a linear */
   BasePoint stop;		/* center of a radial gradient, end of a linear */
   double radius;			/* 0=>linear gradient, else radius of a radial gradient */
   enum spreadMethod sm;
   int stop_cnt;
   struct grad_stops *grad_stops;
};

struct pattern {
   char *pattern;
   double width,height;		/* Pattern is scaled to be repeated every width/height (in user coordinates) */
   double transform[6];
   /* Used during rasterization process */
   struct bdfchar *pat;
   double invtrans[6];
   int bminx,bminy,bwidth,bheight;	/* of the pattern at bdfchar scale */
};

struct brush {
   uint32_t col;
   float opacity;		/* number between [0,1], only for svg/pdf */
   struct pattern *pattern;	/* A pattern to be tiled */
   struct gradient *gradient;	/* A gradient fill */
};

# define WIDTH_INHERITED	(-1)
# define DASH_INHERITED	255
/* if the dashes[0]==0 && dashes[1]==DASH_INHERITED */
# define DASH_MAX	8
typedef unsigned char DashType;

struct pen {
   struct brush brush;
   uint8_t linejoin;
   uint8_t linecap;
   float width;
   double trans[4];
   DashType dashes[DASH_MAX];
};

struct spline;
enum si_type { si_std,si_caligraphic,si_poly,si_centerline };

/* If you change this structure you may need to update MakeStrokeDlg */
/*  and cvpalettes.c both contain statically initialized StrokeInfos */
typedef struct strokeinfo {
   double radius;			/* or major axis of pen */
   enum linejoin join;
   enum linecap cap;
   enum si_type stroke_type;
   unsigned int removeinternal:1;
   unsigned int removeexternal:1;
   unsigned int leave_users_center:1;	/* Don't move the pen so its center is at the origin */
   double penangle;
   double minorradius;
   struct splinepointlist *poly;
   double resolution;
   /* For freehand tool */
   double radius2;
   int pressure1,pressure2;
   /* End freehand tool */
   void *data;
   double(*factor) (void *data,struct spline *spline,double t);
} StrokeInfo;

enum PolyType { Poly_Convex,Poly_Concave,Poly_PointOnEdge,
     Poly_TooFewPoints,Poly_Line
};

enum overlap_type { over_remove,over_rmselected,over_intersect,
     over_intersel,
     over_exclude,over_findinter,over_fisel
};

enum simplify_flags { sf_cleanup=-1,sf_normal=0,sf_ignoreslopes=1,
     sf_ignoreextremum=2,sf_smoothcurves=4,sf_choosehv=8,
     sf_forcelines=0x10,sf_nearlyhvlines=0x20,
     sf_mergelines=0x40,sf_setstart2extremum=0x80,
     sf_rmsingletonpoints=0x100
};

struct simplifyinfo {
   int flags;
   double err;
   double tan_bounds;
   double linefixup;
   double linelenmax;		/* Don't simplify any straight lines longer than this */
   int set_as_default;
   int check_selected_contours;
};

struct hsquash {
   double lsb_percent,stem_percent,counter_percent,rsb_percent;
};

enum serif_type { srf_flat,srf_simpleslant,srf_complexslant };

/* |    | (flat)    |   | (simple)     |    | (complex) */
/* |    |           |  /               |   /            */
/* |    |           | /                |  /             */
/* +----+           |/                 \ /              */

typedef struct italicinfo {
   double italic_angle;
   double xheight_percent;
   struct hsquash lc,uc,neither;
   enum serif_type secondary_serif;

   unsigned int transform_bottom_serifs:1;
   unsigned int transform_top_xh_serifs:1;	/* Those at x-height */
   unsigned int transform_top_as_serifs:1;	/* Those at ascender-height */
   unsigned int transform_diagon_serifs:1;	/* Those at baseline/xheight */

   unsigned int a_from_d:1;	/* replace the "a" glyph with the variant which looks like a "d" without an ascender */
   /* When I say "f" I also mean "f_f" ligature, "longs", cyrillic phi and other things shaped like "f" */
   unsigned int f_long_tail:1;	/* Some Italic fonts have the "f" grow an extension of the main stem below the baseline */
   unsigned int f_rotate_top:1;	/* Most Italic fonts take the top curve of the "f", rotate it 180 and attach to the bottom */
   unsigned int pq_deserif:1;	/* Remove a serif from the descender of p or q and replace with a secondary serif as above */

   /* Unsupported */
   /* e becomes rounder, cross bar slightly slanted */
   /* g closed counter at bottom */
   /* k closed counter at top */
   /* v-z diagonal stems become more curvatious */

   unsigned int cyrl_phi:1;	/* Gains an "f" like top, bottom treated like "f" */
   unsigned int cyrl_i:1;	/* Turns into a latin u */
   unsigned int cyrl_pi:1;	/* Turns into a latin n */
   unsigned int cyrl_te:1;	/* Turns into a latin m */
   unsigned int cyrl_sha:1;	/* Turns into a latin m rotated 180 */
   unsigned int cyrl_dje:1;	/* Turns into a latin smallcaps T */
   unsigned int cyrl_dzhe:1;	/* Turns into a latin u */
   /* Is there a difference between dzhe and i? both look like u to me */

   /* Unsupported */
   /* u432 curved B */
   /* u433 strange gamma */
   /* u434 normal delta */
   /* u436 */
   /* u43b lambda ? */
   /* u43c */
   /* u446 */
   /* u449 */
   /* u449 */
   /* u44a */

/* This half of the structure gets filled in later - see ITALICINFO_REMAINDER */
   double tan_ia;
   double x_height;
   double pq_depth;
   double ascender_height;
   double emsize;
   int order2;
   struct splinefont *sf;
   int layer;
   double serif_extent,serif_height;
   struct splinepoint *f_start,*f_end;	/* start has next pointing into the f head and up */
   struct splinepoint *ff_start1,*ff_end1,*ff_start2,*ff_end2;
   double f_height,ff_height;
} ItalicInfo;

#   define ITALICINFO_REMAINDER 0,0,0,0,0,0,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0

typedef struct bluedata {
   double xheight,xheighttop;	/* height of "x" and "o" (u,v,w,x,y,z) */
   double caph,caphtop;		/* height of "I" and "O" */
   double base,basebelow;	/* bottom of "I" and "O" */
   double ascent;			/* height of "l" */
   double descent;		/* depth of "p" */
   double numh,numhtop;		/* height of "7" and "8" *//* numbers with ascenders */
   int bluecnt;			/* If the private dica contains bluevalues... */
   double blues[12][2];		/* 7 pairs from bluevalues, 5 from otherblues */
} BlueData;

#   define BLUEDATA_EMPTY { \
    0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0,\
    { { 0.0,0.0 },{ 0.0,0.0 },{ 0.0,0.0 },{ 0.0,0.0 },{ 0.0,0.0 },{ 0.0,0.0 },\
      { 0.0,0.0 },{ 0.0,0.0 },{ 0.0,0.0 },{ 0.0,0.0 },{ 0.0,0.0 },{ 0.0,0.0 }  \
    } \
}

typedef struct bdffloat {
   int16_t xmin,xmax,ymin,ymax;
   int16_t bytes_per_line;
   unsigned int byte_data:1;
   uint8_t depth;
   uint8_t *bitmap;
} BDFFloat;

/* OpenType does not document 'dflt' as a language,but we'll use it anyway. */
/* (Adobe uses it too) we'll turn it into a default entry when we output it. */
#   define DEFAULT_LANG		CHR('d','f','l','t')
/* The OpenType spec says in one place that the default script is 'dflt' and */
/*  in another that it is 'DFLT'. 'DFLT' is correct */
#   define DEFAULT_SCRIPT		CHR('D','F','L','T')
#   define REQUIRED_FEATURE	CHR(' ','R','Q','D')

enum otlookup_type {
   ot_undef=0,		/* Not a lookup type */
   gsub_start=0x000,		/* Not a lookup type */
   gsub_single=0x001,
   gsub_multiple=0x002,
   gsub_alternate=0x003,
   gsub_ligature=0x004,
   gsub_context=0x005,
   gsub_contextchain=0x006,
   /* GSUB extension 7 */
   gsub_reversecchain=0x008,
   /* mac state machines */
   morx_indic=0x0fd,
   morx_context=0x0fe,
   morx_insert=0x0ff,
   /* ********************* */
   gpos_start=0x100,		/* Not a lookup type */

   gpos_single=0x101,
   gpos_pair=0x102,
   gpos_cursive=0x103,
   gpos_mark2base=0x104,
   gpos_mark2ligature=0x105,
   gpos_mark2mark=0x106,
   gpos_context=0x107,
   gpos_contextchain=0x108,
   /* GPOS extension 9 */
   kern_statemachine=0x1ff
      /* otlookup&0xff==lookup type for the appropriate table */
      /* otlookup>>8:     0=>GSUB, 1=>GPOS */
};

enum otlookup_typemasks {
   gsub_single_mask=0x00001,
   gsub_multiple_mask=0x00002,
   gsub_alternate_mask=0x00004,
   gsub_ligature_mask=0x00008,
   gsub_context_mask=0x00010,
   gsub_contextchain_mask=0x00020,
   gsub_reversecchain_mask=0x00040,
   morx_indic_mask=0x00080,
   morx_context_mask=0x00100,
   morx_insert_mask=0x00200,
   /* ********************* */
   gpos_single_mask=0x00400,
   gpos_pair_mask=0x00800,
   gpos_cursive_mask=0x01000,
   gpos_mark2base_mask=0x02000,
   gpos_mark2ligature_mask=0x04000,
   gpos_mark2mark_mask=0x08000,
   gpos_context_mask=0x10000,
   gpos_contextchain_mask=0x20000,
   kern_statemachine_mask=0x40000
};

#   define MAX_LANG 		4	/* If more than this we allocate more_langs in chunks of MAX_LANG */
struct scriptlanglist {
   uint32_t script;
   uint32_t langs[MAX_LANG];
   uint32_t *morelangs;
   int lang_cnt;
   struct scriptlanglist *next;
};

extern struct opentype_feature_friendlynames {
   uint32_t tag;
   char *tagstr;
   char *friendlyname;
   int masks;
} friendlies[];

#   define OPENTYPE_FEATURE_FRIENDLYNAMES_EMPTY { 0,NULL,NULL,0 }

typedef struct featurescriptlanglist {
   uint32_t featuretag;
   struct scriptlanglist *scripts;
   struct featurescriptlanglist *next;
   unsigned int ismac:1;	/* treat the featuretag as a mac feature/setting */
} FeatureScriptLangList;

enum pst_flags { pst_r2l=1,pst_ignorebaseglyphs=2,pst_ignoreligatures =
      4,
   pst_ignorecombiningmarks=8,pst_usemarkfilteringset=0x10,
   pst_markclass=0xff00,pst_markset=0xffff0000
};

struct lookup_subtable {
   char *subtable_name;
   char *suffix;		/* for gsub_single, used to find a default replacement */
   int16_t separation,minkern;	/* for gpos_pair, used to guess default kerning values */
   struct otlookup *lookup;
   unsigned int unused:1;
   unsigned int per_glyph_pst_or_kern:1;
   unsigned int anchor_classes:1;
   unsigned int vertical_kerning:1;
   unsigned int ticked:1;
   unsigned int kerning_by_touch:1;	/* for gpos_pair, calculate kerning so that glyphs will touch */
   unsigned int onlyCloser:1;	/* for kerning classes */
   unsigned int dontautokern:1;	/* for kerning classes */
   struct kernclass *kc;
   struct generic_fpst *fpst;
   struct generic_asm *sm;
   /* Each time an item is added to a lookup we must place it into a */
   /*  subtable. If it's a kerning class, fpst or state machine it has */
   /*  a subtable all to itself. If it's an anchor class it can share */
   /*  a subtable with other anchor classes (merge with). If it's a glyph */
   /*  PST it may share a subtable with other PSTs */
   /* Note items may only be placed in lookups in which they fit. Can't */
   /*  put kerning data in a gpos_single lookup, etc. */
   struct lookup_subtable *next;
   int32_t subtable_offset;
   int32_t *extra_subtables;
   /* If a kerning subtable has too much stuff in it, we are prepared to */
   /*  break it up into several smaller subtables, each of which has */
   /*  an offset in this list (extra-subtables[0]==subtable_offset) */
   /*  the list is terminated by an entry of -1 */
};

typedef struct otlookup {
   struct otlookup *next;
   enum otlookup_type lookup_type;
   uint32_t lookup_flags;		/* Low order: traditional flags, High order: markset index, only meaningful if pst_usemarkfilteringset set */
   char *lookup_name;
   FeatureScriptLangList *features;
   struct lookup_subtable *subtables;
   unsigned int unused:1;	/* No subtable is used (call SFFindUnusedLookups before examining) */
   unsigned int empty:1;	/* No subtable is used, and no anchor classes are used */
   unsigned int store_in_afm:1;	/* Used for ligatures, some get stored */
   /*  'liga' generally does, but 'frac' doesn't */
   unsigned int needs_extension:1;	/* Used during opentype generation */
   unsigned int temporary_kern:1;	/* Used when decomposing kerning classes into kern pairs for older formats */
   unsigned int def_lang_checked:1;
   unsigned int def_lang_found:1;
   unsigned int ticked:1;
   unsigned int in_gpos:1;
   unsigned int in_jstf:1;
   unsigned int only_jstf:1;
   int16_t subcnt;		/* Actual number of subtables we will output */
   /* Some of our subtables may contain no data */
   /* Some may be too big and need to be broken up. */
   /* So this field may be different from just counting the subtables */
   int lookup_index;		/* used during opentype generation */
   uint32_t lookup_offset;
   uint32_t lookup_length;
   char *tempname;
} OTLookup;

#   define LOOKUP_SUBTABLE_EMPTY { NULL,NULL,0,0,NULL,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL }
#   define OTLOOKUP_EMPTY { NULL,0,0,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL }

typedef struct devicetab {
   uint16_t first_pixel_size,last_pixel_size;	/* A range of point sizes to which this table applies */
   int8_t *corrections;		/* a set of pixel corrections, one for each point size */
} DeviceTable;

typedef struct valdev {		/* Value records can have four associated device tables */
   DeviceTable xadjust;
   DeviceTable yadjust;
   DeviceTable xadv;
   DeviceTable yadv;
} ValDevTab;

enum anchorclass_type { act_mark,act_mkmk,act_curs,act_mklg,act_unknown };

typedef struct anchorclass {
   char *name;			/* in utf8 */
   struct lookup_subtable *subtable;
   uint8_t type;			/* anchorclass_type */
   uint8_t has_base;
   uint8_t processed,has_mark,matches,ac_num;
   uint8_t ticked;
   struct anchorclass *next;
} AnchorClass;

enum anchor_type { at_mark,at_basechar,at_baselig,at_basemark,at_centry,
      at_cexit,at_max };
typedef struct anchorpoint {
   AnchorClass *anchor;
   BasePoint me;
   DeviceTable xadjust,yadjust;
   unsigned int type:4;
   unsigned int selected:1;
   unsigned int ticked:1;
   unsigned int has_ttf_pt:1;
   uint16_t ttf_pt_index;
   int16_t lig_index;
   struct anchorpoint *next;
} AnchorPoint;

typedef struct kernpair {
   struct lookup_subtable *subtable;
   struct splinechar *sc;
   int16_t off;
   uint16_t kcid;			/* temporary value */
   DeviceTable *adjust;		/* Only adjustment in one dimen, if more needed use pst */
   struct kernpair *next;
} KernPair;

typedef struct kernclass {
   int first_cnt, second_cnt;	/* Count of classes for first and second chars */
   char **firsts;		/* list of a space separated list of char names */
   char **seconds;		/*  one entry for each class. Entry 0 is null */
   /*  and means everything not specified elsewhere */
   struct lookup_subtable *subtable;
   uint16_t kcid;			/* Temporary value, used for many things briefly */
   int16_t *offsets;		/* array of first_cnt*second_cnt entries */
   DeviceTable *adjusts;	/* array of first_cnt*second_cnt entries */
   struct kernclass *next;
} KernClass;

enum possub_type { pst_null, pst_position, pst_pair,
   pst_substitution, pst_alternate,
   pst_multiple, pst_ligature,
   pst_lcaret /* must be pst_max-1, see charinfo.c */ ,
   pst_max,
   /* These are not psts but are related so it's handly to have values for them */
   pst_kerning=pst_max, pst_vkerning, pst_anchors,
   /* And these are fpsts */
   pst_contextpos, pst_contextsub, pst_chainpos, pst_chainsub,
   pst_reversesub, fpst_max,
   /* And these are used to specify a kerning pair where the current */
   /*  char is the final glyph rather than the initial one */
   /* A kludge used when cutting and pasting features */
   pst_kernback, pst_vkernback
};

struct vr {
   int16_t xoff, yoff, h_adv_off, v_adv_off;
   ValDevTab *adjust;
};

typedef struct generic_pst {
   unsigned int ticked:1;
   unsigned int temporary:1;	/* Used in afm ligature closure */
   /* enum possub_type */ uint8_t type;
   struct lookup_subtable *subtable;
   struct generic_pst *next;
   union {
      struct vr pos;
      struct {
	 char *paired;
	 struct vr *vr;
      } pair;
      struct {
	 char *variant;
      } subs;
      struct {
	 char *components;
      } mult, alt;
      struct {
	 char *components;
	 struct splinechar *lig;
      } lig;
      struct {
	 int16_t *carets;
	 int cnt;
      } lcaret;			/* Ligature caret positions */
   } u;
} PST;

typedef struct liglist {
   PST *lig;
   struct splinechar *first;	/* First component */
   struct splinecharlist *components;	/* Other than the first */
   struct liglist *next;
   int ccnt;			/* Component count. (includes first component) */
} LigList;

enum fpossub_format { pst_glyphs, pst_class, pst_coverage,
   pst_reversecoverage, pst_formatmax
};

struct seqlookup {
   int seq;
   struct otlookup *lookup;
};

struct fpg {
   char *names, *back, *fore;
};

struct fpc {
   int ncnt, bcnt, fcnt;
   uint16_t *nclasses, *bclasses, *fclasses, *allclasses;
};

struct fpv {
   int ncnt, bcnt, fcnt;
   char **ncovers, **bcovers, **fcovers;
};

struct fpr {
   int always1, bcnt, fcnt;
   char **ncovers, **bcovers, **fcovers;
   char *replacements;
};

struct fpst_rule {
   union {
      /* Note: Items in backtrack area are in reverse order because that's how the OT wants them */
      /*  they need to be reversed again to be displayed to the user */
      struct fpg glyph;
      struct fpc class;
      struct fpv coverage;
      struct fpr rcoverage;
   } u;
   int lookup_cnt;
   struct seqlookup *lookups;
};

typedef struct generic_fpst {
   uint16_t /*enum possub_type */ type;
   uint16_t /*enum fpossub_format */ format;
   struct lookup_subtable *subtable;
   struct generic_fpst *next;
   uint16_t nccnt, bccnt, fccnt;
   uint16_t rule_cnt;
   char **nclass, **bclass, **fclass;
   struct fpst_rule *rules;
   uint8_t ticked;
   uint8_t effectively_by_glyphs;
   char **nclassnames, **bclassnames, **fclassnames;
} FPST;

enum asm_type { asm_indic, asm_context, asm_lig, asm_simple=4, asm_insert,
   asm_kern=0x11
};
enum asm_flags { asm_vert=0x8000, asm_descending=0x4000, asm_always =
      0x2000 };

struct asm_state {
   uint16_t next_state;
   uint16_t flags;
   union {
      struct {
	 struct otlookup *mark_lookup;	/* for contextual glyph subs (tag of a nested lookup) */
	 struct otlookup *cur_lookup;	/* for contextual glyph subs */
      } context;
      struct {
	 char *mark_ins;
	 char *cur_ins;
      } insert;
      struct {
	 int16_t *kerns;
	 int kcnt;
      } kern;
   } u;
};

typedef struct generic_asm {	/* Apple State Machine */
   struct generic_asm *next;
     uint16_t /*enum asm_type */ type;
   struct lookup_subtable *subtable;	/* Lookup contains feature setting info */
   uint16_t flags;		/* 0x8000=>vert, 0x4000=>r2l, 0x2000=>hor&vert */
   uint8_t ticked;

   uint16_t class_cnt, state_cnt;
   char **classes;
   struct asm_state *state;
} ASM;

/* State Flags:
 Indic:
	0x8000	mark current glyph as first in rearrangement
	0x4000	don't advance to next glyph
	0x2000	mark current glyph as last
	0x000f	verb
		0=no change		8=AxCD => CDxA
		1=Ax => xA		9=AxCD => DCxA
		2=xD => Dx		a=ABxD => DxAB
		3=AxD => DxA		b=ABxD => DxBA
		4=ABx => xAB		c=ABxCD => CDxAB
		5=ABx => xBA		d=ABxCD => CDxBA
		6=xCD => CDx		e=ABxCD => DCxAB
		7=xCD => DCx		f=ABxCD => DCxBA
 Contextual:
	0x8000	mark current glyph
	0x4000	don't advance to next glyph
 Insert:
	0x8000	mark current glyph
	0x4000	don't advance to next glyph
	0x2000	current is Kashida like
	0x1000	mark is Kashida like
	0x0800	current insert before
	0x0400	mark insert before
	0x03e0	count of chars to be inserted at current (31 max)
	0x001f	count of chars to be inserted at mark (31 max)
 Kern:
	0x8000	add current glyph to kerning stack
	0x4000	don't advance to next glyph
	0x3fff	value offset
*/

struct jstf_prio {
   OTLookup **enableShrink;	/* Points to an array of lookups (GSUB or GPOS) */
   OTLookup **disableShrink;	/* NULL terminated */
   OTLookup **maxShrink;	/* Array of GPOS like lookups */
   OTLookup **enableExtend;
   OTLookup **disableExtend;
   OTLookup **maxExtend;
};

struct jstf_lang {
   uint32_t lang;
   struct jstf_lang *next;
   int cnt;
   struct jstf_prio *prios;
};

typedef struct jstf_script {
   uint32_t script;
   struct jstf_script *next;
   char *extenders;		/* list of glyph names */
   struct jstf_lang *langs;
} Justify;

struct opentype_str {
   struct splinechar *sc;
   struct vr vr;		/* Scaled and rounded gpos modifications (device table info included in xoff, etc. not in adjusts) */
   struct kernpair *kp;
   struct kernclass *kc;
   unsigned int prev_kc0:1;
   unsigned int next_kc0:1;
   int16_t advance_width;		/* Basic advance, modifications in vr, scaled and rounded */
   /* Er... not actually set by ApplyLookups, but somewhere the caller */
   /*  can stash info. (Extract width from hinted bdf if possible, tt */
   /*  instructions can change it from the expected value) */
   int16_t kc_index;
   int16_t lig_pos;		/* when skipping marks to form a ligature keep track of what ligature element a mark was attached to */
   int16_t context_pos;		/* When doing a contextual match remember which glyphs are used, and where in the match they occur. Skipped glyphs have -1 */
   int32_t orig_index;
   void *fl;
   unsigned int line_break_after:1;
   unsigned int r2l:1;
   int16_t bsln_off;
};

struct macname {
   struct macname *next;
   uint16_t enc;			/* Platform specific encoding. 0=>mac roman, 1=>sjis, 7=>russian */
   uint16_t lang;			/* Mac languages 0=>english, 1=>french, 2=>german */
   char *name;			/* Not a unicode string, uninterpreted mac encoded string */
};

/* Wow, the GPOS 'size' feature stores a string in the name table just as mac */
/*  features do */
/* And now (OTF 1.6) GSUB 'ss01'-'ss20' do too */
struct otfname {
   struct otfname *next;
   uint16_t lang;			/* windows language code */
   char *name;			/* utf8 */
};

struct otffeatname {
   uint32_t tag;			/* Feature tag */
   struct otfname *names;
   struct otffeatname *next;
   uint16_t nid;			/* temporary value */
};

struct macsetting {
   struct macsetting *next;
   uint16_t setting;
   uint16_t strid;
   struct macname *setname;
   unsigned int initially_enabled:1;
};

typedef struct macfeat {
   struct macfeat *next;
   uint16_t feature;
   uint8_t ismutex;
   uint8_t default_setting;	/* Apple's docs say both that this is a byte and a short. It's a byte */
   uint16_t strid;		/* Temporary value, used when reading in */
   struct macname *featname;
   struct macsetting *settings;
} MacFeat;

typedef struct refbdfc {
   unsigned int checked:1;
   unsigned int selected:1;
   int8_t xoff;
   int8_t yoff;
   uint16_t gid;
   struct refbdfc *next;
   struct bdfchar *bdfc;
} BDFRefChar;

struct bdfcharlist {
   struct bdfchar *bc;
   struct bdfcharlist *next;
};

typedef struct bdfchar {
   struct splinechar *sc;
   int16_t xmin, xmax, ymin, ymax;
   int16_t width;
   int16_t bytes_per_line;
   uint8_t *bitmap;
   struct refbdfc *refs;
   int orig_pos;
   int16_t pixelsize;		/* for undoes */
   struct bitmapview *views;
   struct undoes *undoes;
   struct undoes *redoes;
   unsigned int changed:1;
   unsigned int byte_data:1;	/* for anti-aliased chars entries are grey-scale bytes not bw bits */
   unsigned int widthgroup:1;	/* for ttf bitmap output */
   unsigned int isreference:1;	/* for ttf bitmap input, */
   unsigned int ticked:1;
   uint8_t depth;			/* for ttf bitmap output */
   uint16_t vwidth;
   BDFFloat *selection;
   BDFFloat *backup;
   struct bdfcharlist *dependents;
} BDFChar;

enum undotype { ut_none=0, ut_state, ut_statehint, ut_statename,
   ut_statelookup,
   ut_anchors,
   ut_width, ut_vwidth, ut_lbearing, ut_rbearing,
   ut_bitmap, ut_composit, ut_multiple, ut_layers,
   ut_noop
};

#   define UNDO_LAYER_UNKNOWN -1

typedef struct undoes {
   struct undoes *next;
   enum undotype undotype;
   unsigned int was_modified:1;
   unsigned int was_order2:1;
   int layer;			/* the layer the undo is assoicated with or -1 if unknown */
   union {
      struct {
	 int16_t width, vwidth;
	 int16_t lbearingchange;
	 int unicodeenc;	/* only for ut_statename */
	 char *charname;	/* only for ut_statename */
	 char *comment;		/* in utf8 */
	 PST *possub;		/* only for ut_statename */
	 struct splinepointlist *splines;
	 struct refchar *refs;

	 struct imagelist *images;
	 void *hints;		/* ut_statehint, ut_statename */
	 uint8_t *instrs;
	 int instrs_len;
	 AnchorPoint *anchor;
	 struct brush fill_brush;
	 struct pen stroke_pen;
	 unsigned int dofill:1;
	 unsigned int dostroke:1;
	 unsigned int fillfirst:1;
      } state;
      int width;		/* used by both ut_width and ut_vwidth */
      int lbearing;		/* used by ut_lbearing */
      int rbearing;		/* used by ut_rbearing */
      BDFChar bmpstate;
      struct {			/* copy contains an outline state and a set of bitmap states */
	 struct undoes *state;
	 struct undoes *bitmaps;
      } composit;
      struct {
	 struct undoes *mult;	/* copy contains several sub copies (composits, or states or widths or...) */
	 /* Also used for ut_layers, each sub copy is a state (first is ly_fore, next ly_fore+1...) */
      } multiple;
      struct {
	 enum possub_type pst;
	 char **data;		/* First 4 bytes is tag, then space then data */
	 struct undoes *more_pst;
	 short cnt, max;	/* Not always set */
      } possub;
      uint8_t *bitmap;
   } u;
   struct splinefont *copied_from;
} Undoes;

enum sfundotype {
   sfut_none=0,
   sfut_lookups,
   sfut_lookups_kerns,
   sfut_fontinfo,
   sfut_noop
};

/*
 * A spline font level undo stack. undoes are doubly linked using the
 * 'ln' member and carry some user presentable description of what the
 * undo relates to in 'msg'.
 *
 * The sfdchunk is a pointer to an SFD fragment which will apply the
 * undo to the current state. For example, it might contain
 * information about the old value of kerning pairs which can be used
 * to restore state to how it was. Note that the sfdchunk might only
 * be partial, containing only enough information to restore the state
 * which changed when the undo was created.
 */
typedef struct sfundoes {
//   struct dlistnode ln;
   char *msg;
   enum sfundotype type;
   union {
      int dummy;
   } u;
   char *sfdchunk;
} SFUndoes;

typedef struct enc {
   char *enc_name;
   int char_cnt;		/* Size of the next two arrays */
   int32_t *unicode;		/* unicode value for each encoding point */
   char **psnames;		/* optional postscript name for each encoding point */
   struct enc *next;
   unsigned int builtin:1;
   unsigned int hidden:1;
   unsigned int only_1byte:1;
   unsigned int has_1byte:1;
   unsigned int has_2byte:1;
   unsigned int is_unicodebmp:1;
   unsigned int is_unicodefull:1;
   unsigned int is_custom:1;
   unsigned int is_original:1;
   unsigned int is_compact:1;
   unsigned int is_japanese:1;
   unsigned int is_korean:1;
   unsigned int is_tradchinese:1;
   unsigned int is_simplechinese:1;
   char iso_2022_escape[8];
   int iso_2022_escape_len;
   int low_page, high_page;
   char *iconv_name;		/* For compatibility to old versions we might use a different name from that used by iconv. */
   iconv_t *tounicode;
   iconv_t *fromunicode;
   int (*tounicode_func) (int);
   int (*fromunicode_func) (int);
   unsigned int is_temporary:1;	/* freed when the map gets freed */
   int char_max;		/* Used by temporary encodings */
} Encoding;

struct renames {
   char *from;
   char *to;
};

typedef struct namelist {
   struct namelist *basedon;
   char *title;
   const char ***unicode[17];
   struct namelist *next;
   struct renames *renames;
   int uses_unicode;
   char *a_utf8_name;
} NameList;

enum uni_interp { ui_unset=-1, ui_none, ui_adobe, ui_greek, ui_japanese,
   ui_trad_chinese, ui_simp_chinese, ui_korean, ui_ams
};

struct remap {
   uint32_t firstenc, lastenc;
   int32_t infont;
};

typedef struct encmap {		/* A per-font map of encoding to glyph id */
   int32_t *map;			/* Map from encoding to glyphid */
   int32_t *backmap;		/* Map from glyphid to encoding */
   int enccount;		/* used size of the map array */
   /*  strictly speaking this might include */
   /*  glyphs that are not encoded, but which */
   /*  are displayed after the proper encoding */
   int encmax;			/* allocated size of the map array */
   int backmax;			/* allocated size of the backmap array */
   struct remap *remap;
   Encoding *enc;
   unsigned int ticked:1;
} EncMap;

enum property_type { prt_string, prt_atom, prt_int, prt_uint, prt_property =
      0x10 };

typedef struct bdfprops {
   char *name;			/* These include both properties (like SLANT) and non-properties (like FONT) */
   int type;
   union {
      char *str;
      char *atom;
      int val;
   } u;
} BDFProperties;

typedef struct bdffont {
   struct splinefont *sf;
   int glyphcnt, glyphmax;	/* used & allocated sizes of glyphs array */
   BDFChar **glyphs;		/* an array of charcnt entries */
   int16_t pixelsize;
   int16_t ascent, descent;
   int16_t layer;			/* for piecemeal fonts */
   unsigned int piecemeal:1;
   unsigned int bbsized:1;
   unsigned int ticked:1;
   unsigned int unhinted_freetype:1;
   unsigned int recontext_freetype:1;
   struct bdffont *next;
   struct clut *clut;
   char *foundry;
   int res;
   void *freetype_context;
   uint16_t truesize;		/* for bbsized fonts */
   int16_t prop_cnt;
   int16_t prop_max;		/* only used within bdfinfo dlg */
   BDFProperties *props;
   uint16_t ptsize, dpi;		/* for piecemeal fonts */
} BDFFont;

#   define HntMax	96	/* PS says at most 96 hints */
typedef uint8_t HintMask[HntMax / 8];

enum pointtype { pt_curve, pt_corner, pt_tangent, pt_hvcurve };

typedef struct splinepoint {
   BasePoint me;
   BasePoint nextcp;		/* control point */
   BasePoint prevcp;		/* control point */
   unsigned int nonextcp:1;
   unsigned int noprevcp:1;
   unsigned int nextcpdef:1;
   unsigned int prevcpdef:1;
   unsigned int selected:1;	/* for UI */
   unsigned int nextcpselected:2;	/* Is the next BCP selected */
   unsigned int prevcpselected:2;	/* Is the prev BCP selected */
   unsigned int pointtype:2;
   unsigned int isintersection:1;
   unsigned int flexy:1;	/* When "freetype_markup" is on in charview.c:DrawPoint */
   unsigned int flexx:1;	/* flexy means select nextcp, and flexx means draw circle around nextcp */
   unsigned int roundx:1;	/* For true type hinting */
   unsigned int roundy:1;	/* For true type hinting */
   unsigned int dontinterpolate:1;	/* in ttf, don't imply point by interpolating between cps */
   unsigned int ticked:1;
   unsigned int watched:1;
   /* 1 bits left... */
   uint16_t ptindex;		/* Temporary value used by metafont routine */
   uint16_t ttfindex;		/* Truetype point index */
   /* Special values 0xffff => point implied by averaging control points */
   /*                0xfffe => point created with no real number yet */
   /* (or perhaps point in context where no number is possible as in a glyph with points & refs) */
   uint16_t nextcpindex;		/* Truetype point index */
   struct spline *next;
   struct spline *prev;
   HintMask *hintmask;
   char *name;
} SplinePoint;

enum linelist_flags { cvli_onscreen=0x1, cvli_clipped=0x2 };

typedef struct linelist {
   IPoint here;
   struct linelist *next;
   /* The first two fields are constant for the linelist, the next ones */
   /*  refer to a particular screen. If some portion of the line from */
   /*  this point to the next one is on the screen then set cvli_onscreen */
   /*  if this point needs to be clipped then set cvli_clipped */
   /*  asend and asstart are the actual screen locations where this point */
   /*  intersects the clip edge. */
   enum linelist_flags flags;
   IPoint asend, asstart;
} LineList;

typedef struct linearapprox {
   double scale;
   unsigned int oneline:1;
   unsigned int onepoint:1;
   unsigned int any:1;		/* refers to a particular screen */
   struct linelist *lines;
   struct linearapprox *next;
} LinearApprox;

typedef struct spline1d {
   double a, b, c, d;
} Spline1D;

/*
 *
 * 2013Note: If you are altering from->me.x and y then you will
 *           probably have to modify splines[] to match your change.
 *           eg, moving both ends of a spline up/down by changing their
 *           to/from will also probably need an update to splines[ 0 | 1 ].d to
 *           match.
 */
typedef struct spline {
   unsigned int islinear:1;	/* No control points */
   unsigned int isquadratic:1;	/* probably read in from ttf */
   unsigned int isticked:1;
   unsigned int isneeded:1;	/* Used in remove overlap */
   unsigned int isunneeded:1;	/* Used in remove overlap */
   unsigned int exclude:1;	/* Used in remove overlap varient: exclude */
   unsigned int ishorvert:1;
   unsigned int knowncurved:1;	/* We know that it curves */
   unsigned int knownlinear:1;	/* it might have control points, but still traces out a line */
   /* If neither knownlinear nor curved then we haven't checked */
   unsigned int order2:1;	/* It's a bezier curve with only one cp */
   unsigned int touched:1;
   unsigned int leftedge:1;
   unsigned int rightedge:1;
   unsigned int acceptableextrema:1;	/* This spline has extrema, but we don't care */
   SplinePoint *from;
   SplinePoint *to;
   Spline1D splines[2];		/* splines[0] is the x spline, splines[1] is y */
   struct linearapprox *approx;
   /* Posible optimizations:
      Precalculate bounding box
      Precalculate min/max/ points of inflection
    */
} Spline;

#   ifndef _NO_LIBSPIRO
#    include "spiroentrypoints.h"
#   else
#    define SPIRO_OPEN_CONTOUR	'{'
#    define SPIRO_CORNER		'v'
#    define SPIRO_G4		'o'
#    define SPIRO_G2		'c'
#    define SPIRO_LEFT		'['
#    define SPIRO_RIGHT		']'
#    define SPIRO_END		'z'
typedef struct {		/* Taken from spiro.h because I want */
   double x;			/*  to be able to compile for spiro */
   double y;			/*  even on a system without it */
   char ty;
} spiro_cp;
#   endif
#   define SPIRO_SELECTED(cp)	((cp)->ty&0x80)
#   define SPIRO_DESELECT(cp)	((cp)->ty&=~0x80)
#   define SPIRO_SELECT(cp)	((cp)->ty|=0x80)
#   define SPIRO_SPL_OPEN(spl)	((spl)->spiro_cnt>1 && ((spl)->spiros[0].ty&0x7f)==SPIRO_OPEN_CONTOUR)

#   define SPIRO_NEXT_CONSTRAINT	SPIRO_RIGHT
/* The curve is on the next side of the constraint point */
#   define SPIRO_PREV_CONSTRAINT	SPIRO_LEFT
/* The curve is on the prev side of the constraint point */

typedef struct splinepointlist {
   SplinePoint *first, *last;
   struct splinepointlist *next;
   spiro_cp *spiros;
   uint16_t spiro_cnt, spiro_max;
   /* These could be bit fields, but bytes are easier to access and we */
   /*  don't need the space (yet) */
   uint8_t ticked;
   uint8_t beziers_need_optimizer;	/* If the spiros have changed in spiro mode, then reverting to bezier mode might, someday, run a simplifier */
   uint8_t is_clip_path;		/* In type3/svg fonts */
   char *contour_name;
} SplinePointList, SplineSet;

typedef struct imagelist {
   struct gimage *image;
   double xoff, yoff;		/* position in character space of upper left corner of image */
   double xscale, yscale;		/* scale to convert one pixel of image to one unit of character space */
   DBounds bb;
   struct imagelist *next;
   unsigned int selected:1;
} ImageList;

struct reflayer {
   unsigned int background:1;
   unsigned int order2:1;
   unsigned int anyflexes:1;
   unsigned int dofill:1;
   unsigned int dostroke:1;
   unsigned int fillfirst:1;
   struct brush fill_brush;
   struct pen stroke_pen;
   SplinePointList *splines;
   ImageList *images;		/* Only in background or type3 layer(s) */
};

typedef struct refchar {
   unsigned int checked:1;
   unsigned int selected:1;
   unsigned int point_match:1;	/* match_pt* are point indexes */
   /*  and need to be converted to a */
   /*  translation after truetype readin */
   unsigned int encoded:1;	/* orig_pos is actually an encoded value, used for old sfd files */
   unsigned int justtranslated:1;	/* The transformation matrix specifies a translation (or is identity) */
   unsigned int use_my_metrics:1;	/* Retain the ttf "use_my_metrics" info. */
   /* important for glyphs with instructions which change the width used */
   /* inside composites */
   unsigned int round_translation_to_grid:1;	/* Retain the ttf "round_to_grid" info. */
   unsigned int point_match_out_of_date:1;	/* Someone has edited a base glyph */
   int16_t adobe_enc;
   int orig_pos;
   int unicode_enc;		/* used by paste */
   double transform[6];		/* transformation matrix (first 2 rows of a 3x3 matrix, missing row is 0,0,1) */
   struct reflayer *layers;
   int layer_cnt;
   struct refchar *next;
   DBounds bb;
   struct splinechar *sc;
   BasePoint top;
   uint16_t match_pt_base, match_pt_ref;
} RefChar;

/* Some stems may appear, disappear, reapear several times */
/* Serif stems on I which appear at 0, disappear, reappear at top */
/* Or the major vertical stems on H which disappear at the cross bar */
typedef struct hintinstance {
   double begin;			/* location in the non-major direction */
   double end;			/* width/height in non-major direction */
   unsigned int closed:1;
   short int counternumber;
   struct hintinstance *next;
} HintInstance;

enum hinttypes { ht_unspecified=0, ht_h, ht_v, ht_d };

typedef double _MMArray[2][MmMax];

typedef struct steminfo {
   struct steminfo *next;
   unsigned int hinttype:2;	/* Only used by undoes */
   unsigned int ghost:1;	/* this is a ghost stem hint. As such truetype should ignore it, type2 output should negate it, and type1 should use as is */
   /* stored width will be either 20 or 21 */
   /* Type2 says: -20 is "width" of top edge, -21 is "width" of bottom edge, type1 accepts either */
   unsigned int haspointleft:1;
   unsigned int haspointright:1;
   unsigned int hasconflicts:1;	/* Does this stem have conflicts within its cluster? */
   unsigned int used:1;		/* Temporary for counter hints or hint substitution */
   unsigned int tobeused:1;	/* Temporary for counter hints or hint substitution */
   unsigned int active:1;	/* Currently active hint in Review Hints dlg */
   /*  displayed differently in char display */
   unsigned int enddone:1;	/* Used by ttf instructing, indicates a prev */
   /*  hint had the same end as this one (so */
   /*  the points on the end line have been */
   /*  instructed already */
   unsigned int startdone:1;	/* Used by ttf instructing */
   /*unsigned int backwards: 1; *//* If we think this hint is better done with a negative width */
   unsigned int reordered:1;	/* In AutoHinting. Means we changed the start of the hint, need to test for out of order */
   unsigned int pendingpt:1;	/* A pending stem creation, not a true stem */
   unsigned int linearedges:1;	/* If we have a nice rectangle then we aren't */
   /*  interested in the orientation which is */
   /*  wider than long */
   int16_t hintnumber;		/* when dumping out hintmasks we need to know */
   /*  what bit to set for this hint */
   union {
      int mask;			/* Mask of all references that use this hint */
      /*  in type2 output */
      _MMArray *unblended /*[2][MmMax] */ ;	/* Used when reading in type1 mm hints */
   } u;
   double start;			/* location at which the stem starts */
   double width;			/* or height */
   HintInstance *where;		/* location(s) in the other coord */
} StemInfo;

typedef struct dsteminfo {
   struct dsteminfo *next;	/* First two fields match those in steminfo */
   unsigned int hinttype:2;	/* Only used by undoes */
   unsigned int used:1;		/* used only by tottf.c:gendinstrs, metafont.c to mark a hint that has been dealt with */
   BasePoint left, right, unit;
   HintInstance *where;		/* location(s) along the unit vector */
} DStemInfo;

typedef struct minimumdistance {
   /* If either point is NULL it will be assumed to mean either the origin */
   /*  or the width point (depending on which is closer). This allows user */
   /*  to control metrics... */
   SplinePoint *sp1, *sp2;
   unsigned int x:1;
   unsigned int done:1;
   struct minimumdistance *next;
} MinimumDistance;

typedef struct layer {		/* : reflayer */
   unsigned int background:1;
   unsigned int order2:1;
   unsigned int anyflexes:1;
   unsigned int dofill:1;
   unsigned int dostroke:1;
   unsigned int fillfirst:1;
   struct brush fill_brush;
   struct pen stroke_pen;
   SplinePointList *splines;
   ImageList *images;		/* Only in background or type3 layer(s) */
   RefChar *refs;		/* Only in foreground layer(s) */
   Undoes *undoes;
   Undoes *redoes;
   uint32_t validation_state;
   uint32_t old_vs;
} Layer;

enum layer_type { ly_all=-2, ly_grid=-1, ly_back=0, ly_fore=1,
   /* Possibly other foreground layers for type3 things */
   /* Possibly other background layers for normal fonts */
   ly_none=-3
};

struct gv_part {
   char *component;
   unsigned int is_extender:1;	/* This component may be skipped or repeated */
   uint16_t startConnectorLength;
   uint16_t endConnectorLength;
   uint16_t fullAdvance;
};

/* For the 'MATH' table (and for TeX) */
struct glyphvariants {
   char *variants;		/* Space separated list of glyph names */
/* Glyph assembly */
   int16_t italic_correction;	/* Of the composed glyph */
   DeviceTable *italic_adjusts;
   int part_cnt;
   struct gv_part *parts;
};

struct mathkerndata {
   int16_t height, kern;
   DeviceTable *height_adjusts;
   DeviceTable *kern_adjusts;
};

/* For the 'MATH' table */
struct mathkernvertex {
   int cnt;			/* There is one more kern entry than height entry */
   /* So the last mkd should have its height ignored */
   /* The MATH table stores the height count, I think the kern count */
   /*  is more useful (and that's what I use here). They differ by 1 */
   struct mathkerndata *mkd;
};

struct mathkern {
   struct mathkernvertex top_right;
   struct mathkernvertex top_left;
   struct mathkernvertex bottom_right;
   struct mathkernvertex bottom_left;
};

enum privatedict_state {
   pds_odd=0x1,		/* Odd number of entries */
   pds_outoforder=0x2,	/* Bluevalues should be listed in order */
   pds_toomany=0x4,		/* arrays are of limited sizes */
   pds_tooclose=0x8,		/* adjacent zones must not be within 2*bluefuzz+1 (or 3, if bluefuzz omitted) */
   pds_notintegral=0x10,	/* Must be integers */
   pds_toobig=0x20,		/* within pair difference have some relation to BlueScale but the docs make no sense to me */
   pds_shift=8,		/* BlueValues/OtherBlues, unshifted, FamilyBlues/FamilyOtherBlues shifted once */

   pds_missingblue=0x010000,
   pds_badbluefuzz=0x020000,
   pds_badbluescale=0x040000,
   pds_badstdhw=0x080000,
   pds_badstdvw=0x100000,
   pds_badstemsnaph=0x200000,
   pds_badstemsnapv=0x400000,
   pds_stemsnapnostdh=0x0800000,
   pds_stemsnapnostdv=0x1000000,
   pds_badblueshift=0x2000000
};

enum validation_state { vs_unknown=0,
   vs_known=0x01,		/* It has been validated */
   vs_opencontour=0x02,
   vs_selfintersects=0x04,
   vs_wrongdirection=0x08,
   vs_flippedreferences=0x10,	/* special case of wrong direction */
   vs_missingextrema=0x20,
   vs_missingglyphnameingsub=0x40,
   /* Next few are postscript only */
   vs_toomanypoints=0x80,
   vs_toomanyhints=0x100,
   vs_badglyphname=0x200,
   /* Next few are only for fontlint */
   /* These are relative to maxp values which ff would fix on generating a font */
   vs_maxp_toomanypoints=0x400,
   vs_maxp_toomanypaths=0x800,
   vs_maxp_toomanycomppoints=0x1000,
   vs_maxp_toomanycomppaths=0x2000,
   vs_maxp_instrtoolong=0x4000,
   vs_maxp_toomanyrefs=0x8000,
   vs_maxp_refstoodeep=0x10000,
   /* vs_maxp_prepfpgmtoolong=0x20000, *//* I think I was wrong about this "error" */
   /* Oops, we need another one, two, for the glyphs */
   vs_pointstoofarapart=0x40000,
   vs_nonintegral=0x80000,	/* This will never be interesting in a real font, but might be in an sfd file */
   vs_missinganchor=0x100000,
   vs_dupname=0x200000,
   vs_dupunicode=0x400000,
   vs_overlappedhints=0x800000,

   vs_last=vs_overlappedhints,
   vs_maskps =
      0x3fe | vs_pointstoofarapart | vs_missinganchor | vs_dupname |
      vs_dupunicode | vs_overlappedhints,
   vs_maskcid =
      0x1fe | vs_pointstoofarapart | vs_missinganchor | vs_dupname |
      vs_overlappedhints,
   vs_maskttf =
      0x7e | vs_pointstoofarapart | vs_nonintegral | vs_missinganchor |
      vs_dupunicode,
   vs_maskfindproblems =
      0x1be | vs_pointstoofarapart | vs_nonintegral | vs_missinganchor |
      vs_overlappedhints
};

struct splinecharlist {
   struct splinechar *sc;
   struct splinecharlist *next;
};

struct altuni {
   struct altuni *next;
   int unienc, vs, fid;
};

	/* vs is the "variation selector" a unicode codepoint which modifieds */
	/*  the code point before it. If vs is -1 then unienc is just an */
	/*  alternate encoding (greek Alpha and latin A), but if vs is one */
	/*  of unicode's variation selectors then this glyph is somehow a */
	/*  variant shape. The specifics depend on the selector and script */
	/*  fid is currently unused, but may, someday, be used to do ttcs */
	/* NOTE: GlyphInfo displays vs==-1 as vs==0, and fixes things up */

typedef struct splinechar {
   char *name;
   int unicodeenc;
   int orig_pos;		/* Original position in the glyph list */
   int16_t width, vwidth;
   int16_t lsidebearing;		/* only used when reading in a type1 font */
   /*  Or an otf font where it is the subr number of a refered character */
   /*  or a ttf font without bit 1 of head.flags set */
   /*  or (once upon a time, but no longer) a ttf font with vert metrics where it is the ymax value when we had a font-wide vertical offset */
   /*  or when generating morx where it is the mask of tables in which the glyph occurs */
   /* Always a temporary value */
   int ttf_glyph;		/* only used when writing out a ttf or otf font */
   Layer *layers;		/* layer[0] is background, layer[1] foreground */
   /* In type3 fonts 2-n are also foreground, otherwise also background */
   int layer_cnt;
   StemInfo *hstem;		/* hstem hints have a vertical offset but run horizontally */
   StemInfo *vstem;		/* vstem hints have a horizontal offset but run vertically */
   DStemInfo *dstem;		/* diagonal hints for ttf */
   MinimumDistance *md;
   struct charviewbase *views;
   struct charinfo *charinfo;
   struct splinefont *parent;
   unsigned int changed:1;
   unsigned int changedsincelasthinted:1;
   unsigned int manualhints:1;
   unsigned int ticked:1;	/* For reference character processing */
   /* And fontview processing */
   unsigned int widthset:1;	/* needed so an emspace char doesn't disappear */
   unsigned int vconflicts:1;	/* Any hint overlaps in the vstem list? */
   unsigned int hconflicts:1;	/* Any hint overlaps in the hstem list? */
   unsigned int searcherdummy:1;
   unsigned int changed_since_search:1;
   unsigned int wasopen:1;
   unsigned int namechanged:1;
   unsigned int blended:1;	/* An MM blended character */
   unsigned int ticked2:1;
   unsigned int glyph_class:3;	/* 0=> fontanvil determines class automagically, else one more than the class value in gdef so 2+1=>lig, 3+1=>mark */
   unsigned int numberpointsbackards:1;
   unsigned int instructions_out_of_date:1;
   unsigned int complained_about_ptnums:1;
   unsigned int vs_open:1;
   unsigned int inspiro:1;
   unsigned int lig_caret_cnt_fixed:1;
   unsigned int suspendMetricsViewEventPropagation:1;	/* rect tool might do this while drawing */
   /* 5 bits left (one more if we ignore compositionunit below) */
#   if HANYANG
   unsigned int compositionunit:1;
   int16_t jamo, varient;
#   endif
   struct splinecharlist *dependents;
   /* The dependents list is a list of all characters which refenence */
   /*  the current character directly */
   KernPair *kerns;
   KernPair *vkerns;
   PST *possub;			/* If we are a ligature then this tells us what */
   /*  It may also contain a bunch of other stuff now */
   LigList *ligofme;		/* If this is the first character of a ligature then this gives us the list of possible ones */
   /*  this field must be regenerated before the font is saved */
   char *comment;		/* in utf8 */
     uint32_t /*Color */ color;
   AnchorPoint *anchor;
   uint8_t *ttf_instrs;
   int16_t ttf_instrs_len;
   int16_t countermask_cnt;
   HintMask *countermasks;
   struct altuni *altuni;
/* for TeX */
   int16_t tex_height, tex_depth;
/* TeX also uses italic_correction and glyph variants below */
/* For the 'MATH' table (and for TeX) */
   unsigned int is_extended_shape:1;
   int16_t italic_correction;
   int16_t top_accent_horiz;	/* MATH table allows you to specific a */
   /* horizontal anchor for accent attachments, vertical */
   /* positioning is done elsewhere */
   DeviceTable *italic_adjusts;
   DeviceTable *top_accent_adjusts;
   struct glyphvariants *vert_variants;
   struct glyphvariants *horiz_variants;
   struct mathkern *mathkern;
/* End of MATH/TeX fields */
   void *python_persistent;	/* If python this will hold a python object, if not python this will hold a string containing a pickled object. We do nothing with it (if not python) except save it back out unchanged */
   /* If the glyph is used as a tile pattern, then the next two values */
   /*  determine the amount of white space around the tile. If extra is */
   /*  non-zero then we add it to the max components of the bbox and   */
   /*  subtract it from the min components. If extra is 0 then tile_bounds */
   /*  will be used. If tile_bounds is all zeros then the glyph's bbox */
   /*  will be used. */
   double tile_margin;		/* If the glyph is used as a tile */
   DBounds tile_bounds;
} SplineChar;

#   define TEX_UNDEF 0x7fff

enum ttfnames { ttf_copyright=0, ttf_family, ttf_subfamily, ttf_uniqueid,
   ttf_fullname, ttf_version, ttf_postscriptname, ttf_trademark,
   ttf_manufacturer, ttf_designer, ttf_descriptor, ttf_venderurl,
   ttf_designerurl, ttf_license, ttf_licenseurl, ttf_idontknow /*reserved */ ,
   ttf_preffamilyname, ttf_prefmodifiers, ttf_compatfull, ttf_sampletext,
   ttf_cidfindfontname, ttf_wwsfamily, ttf_wwssubfamily, ttf_namemax
};

struct ttflangname {
   int lang;
   char *names[ttf_namemax];	/* in utf8 */
   int frommac[(ttf_namemax + 31) / 32];	/* Used when parsing the 'name' table */
   struct ttflangname *next;
};

struct MATH {
/* From the MATH Constants subtable (constants for positioning glyphs. Not PI)*/
   int16_t ScriptPercentScaleDown;
   int16_t ScriptScriptPercentScaleDown;
   uint16_t DelimitedSubFormulaMinHeight;
   uint16_t DisplayOperatorMinHeight;
   int16_t MathLeading;
   DeviceTable *MathLeading_adjust;
   int16_t AxisHeight;
   DeviceTable *AxisHeight_adjust;
   int16_t AccentBaseHeight;
   DeviceTable *AccentBaseHeight_adjust;
   int16_t FlattenedAccentBaseHeight;
   DeviceTable *FlattenedAccentBaseHeight_adjust;
   int16_t SubscriptShiftDown;
   DeviceTable *SubscriptShiftDown_adjust;
   int16_t SubscriptTopMax;
   DeviceTable *SubscriptTopMax_adjust;
   int16_t SubscriptBaselineDropMin;
   DeviceTable *SubscriptBaselineDropMin_adjust;
   int16_t SuperscriptShiftUp;
   DeviceTable *SuperscriptShiftUp_adjust;
   int16_t SuperscriptShiftUpCramped;
   DeviceTable *SuperscriptShiftUpCramped_adjust;
   int16_t SuperscriptBottomMin;
   DeviceTable *SuperscriptBottomMin_adjust;
   int16_t SuperscriptBaselineDropMax;
   DeviceTable *SuperscriptBaselineDropMax_adjust;
   int16_t SubSuperscriptGapMin;
   DeviceTable *SubSuperscriptGapMin_adjust;
   int16_t SuperscriptBottomMaxWithSubscript;
   DeviceTable *SuperscriptBottomMaxWithSubscript_adjust;
   int16_t SpaceAfterScript;
   DeviceTable *SpaceAfterScript_adjust;
   int16_t UpperLimitGapMin;
   DeviceTable *UpperLimitGapMin_adjust;
   int16_t UpperLimitBaselineRiseMin;
   DeviceTable *UpperLimitBaselineRiseMin_adjust;
   int16_t LowerLimitGapMin;
   DeviceTable *LowerLimitGapMin_adjust;
   int16_t LowerLimitBaselineDropMin;
   DeviceTable *LowerLimitBaselineDropMin_adjust;
   int16_t StackTopShiftUp;
   DeviceTable *StackTopShiftUp_adjust;
   int16_t StackTopDisplayStyleShiftUp;
   DeviceTable *StackTopDisplayStyleShiftUp_adjust;
   int16_t StackBottomShiftDown;
   DeviceTable *StackBottomShiftDown_adjust;
   int16_t StackBottomDisplayStyleShiftDown;
   DeviceTable *StackBottomDisplayStyleShiftDown_adjust;
   int16_t StackGapMin;
   DeviceTable *StackGapMin_adjust;
   int16_t StackDisplayStyleGapMin;
   DeviceTable *StackDisplayStyleGapMin_adjust;
   int16_t StretchStackTopShiftUp;
   DeviceTable *StretchStackTopShiftUp_adjust;
   int16_t StretchStackBottomShiftDown;
   DeviceTable *StretchStackBottomShiftDown_adjust;
   int16_t StretchStackGapAboveMin;
   DeviceTable *StretchStackGapAboveMin_adjust;
   int16_t StretchStackGapBelowMin;
   DeviceTable *StretchStackGapBelowMin_adjust;
   int16_t FractionNumeratorShiftUp;
   DeviceTable *FractionNumeratorShiftUp_adjust;
   int16_t FractionNumeratorDisplayStyleShiftUp;
   DeviceTable *FractionNumeratorDisplayStyleShiftUp_adjust;
   int16_t FractionDenominatorShiftDown;
   DeviceTable *FractionDenominatorShiftDown_adjust;
   int16_t FractionDenominatorDisplayStyleShiftDown;
   DeviceTable *FractionDenominatorDisplayStyleShiftDown_adjust;
   int16_t FractionNumeratorGapMin;
   DeviceTable *FractionNumeratorGapMin_adjust;
   int16_t FractionNumeratorDisplayStyleGapMin;
   DeviceTable *FractionNumeratorDisplayStyleGapMin_adjust;
   int16_t FractionRuleThickness;
   DeviceTable *FractionRuleThickness_adjust;
   int16_t FractionDenominatorGapMin;
   DeviceTable *FractionDenominatorGapMin_adjust;
   int16_t FractionDenominatorDisplayStyleGapMin;
   DeviceTable *FractionDenominatorDisplayStyleGapMin_adjust;
   int16_t SkewedFractionHorizontalGap;
   DeviceTable *SkewedFractionHorizontalGap_adjust;
   int16_t SkewedFractionVerticalGap;
   DeviceTable *SkewedFractionVerticalGap_adjust;
   int16_t OverbarVerticalGap;
   DeviceTable *OverbarVerticalGap_adjust;
   int16_t OverbarRuleThickness;
   DeviceTable *OverbarRuleThickness_adjust;
   int16_t OverbarExtraAscender;
   DeviceTable *OverbarExtraAscender_adjust;
   int16_t UnderbarVerticalGap;
   DeviceTable *UnderbarVerticalGap_adjust;
   int16_t UnderbarRuleThickness;
   DeviceTable *UnderbarRuleThickness_adjust;
   int16_t UnderbarExtraDescender;
   DeviceTable *UnderbarExtraDescender_adjust;
   int16_t RadicalVerticalGap;
   DeviceTable *RadicalVerticalGap_adjust;
   int16_t RadicalDisplayStyleVerticalGap;
   DeviceTable *RadicalDisplayStyleVerticalGap_adjust;
   int16_t RadicalRuleThickness;
   DeviceTable *RadicalRuleThickness_adjust;
   int16_t RadicalExtraAscender;
   DeviceTable *RadicalExtraAscender_adjust;
   int16_t RadicalKernBeforeDegree;
   DeviceTable *RadicalKernBeforeDegree_adjust;
   int16_t RadicalKernAfterDegree;
   DeviceTable *RadicalKernAfterDegree_adjust;
   uint16_t RadicalDegreeBottomRaisePercent;
/* Global constants from other subtables */
   uint16_t MinConnectorOverlap;	/* in the math variants sub-table */
};

enum backedup_state { bs_dontknow=0, bs_not=1, bs_backedup=2 };

enum loadvalidation_state {
   lvs_bad_ps_fontname=0x001,
   lvs_bad_glyph_table=0x002,
   lvs_bad_cff_table=0x004,
   lvs_bad_metrics_table=0x008,
   lvs_bad_cmap_table=0x010,
   lvs_bad_bitmaps_table=0x020,
   lvs_bad_gx_table=0x040,
   lvs_bad_ot_table=0x080,
   lvs_bad_os2_version=0x100,
   lvs_bad_sfnt_header=0x200
};

typedef struct layerinfo {
   char *name;
   unsigned int background:1;	/* Layer is to be treated as background: No width, images, not worth outputting */
   unsigned int order2:1;	/* Layer's data are order 2 bezier splines (truetype) rather than order 3 (postscript) */
   /* In all glyphs in the font */
   unsigned int ticked:1;
} LayerInfo;

/* Baseline data from the 'BASE' table */
struct baselangextent {
   uint32_t lang;			/* also used for feature tag */
   struct baselangextent *next;
   int16_t ascent, descent;
   struct baselangextent *features;
};

struct basescript {
   uint32_t script;
   struct basescript *next;
   int def_baseline;		/* index [0-baseline_cnt) */
   int16_t *baseline_pos;		/* baseline_cnt of these */
   struct baselangextent *langs;	/* Language specific extents (may be NULL) */
   /* The default one has the tag DEFAULT_LANG */
};

struct Base {
   int baseline_cnt;
   uint32_t *baseline_tags;
   /* A font does not need to provide info on all baselines, but if one script */
   /*  talks about a baseline, then all must. So the set of baselines is global */
   struct basescript *scripts;
};

struct pfminfo {		/* A misnomer now. OS/2 info would be more accurate, but that's stuff in here from all over ttf files */
   unsigned int pfmset:1;
   unsigned int winascent_add:1;
   unsigned int windescent_add:1;
   unsigned int hheadascent_add:1;
   unsigned int hheaddescent_add:1;
   unsigned int typoascent_add:1;
   unsigned int typodescent_add:1;
   unsigned int subsuper_set:1;
   unsigned int panose_set:1;
   unsigned int hheadset:1;
   unsigned int vheadset:1;
   unsigned int hascodepages:1;
   unsigned int hasunicoderanges:1;
   unsigned char pfmfamily;
   int16_t weight;
   int16_t width;
   char panose[10];
   int16_t fstype;
   int16_t linegap;		/* from hhea */
   int16_t vlinegap;		/* from vhea */
   int16_t hhead_ascent, hhead_descent;
   int16_t os2_typoascent, os2_typodescent, os2_typolinegap;
   int16_t os2_winascent, os2_windescent;
   int16_t os2_subxsize, os2_subysize, os2_subxoff, os2_subyoff;
   int16_t os2_supxsize, os2_supysize, os2_supxoff, os2_supyoff;
   int16_t os2_strikeysize, os2_strikeypos;
   char os2_vendor[4];
   int16_t os2_family_class;
   uint32_t codepages[2];
   uint32_t unicoderanges[4];
};

struct ttf_table {
   uint32_t tag;
   int32_t len, maxlen;
   uint8_t *data;
   struct ttf_table *next;
   AFILE *temp;			/* Temporary storage used during generation */
};

enum texdata_type { tex_unset, tex_text, tex_math, tex_mathext };

struct texdata {
   enum texdata_type type;
   int32_t params[22];		/* param[6] has different meanings in normal and math fonts */
};

struct gasp {
   uint16_t ppem;
   uint16_t flags;
};

typedef struct splinefont {
   char *fontname, *fullname, *familyname, *weight;
   char *familyname_with_timestamp;
   char *copyright;
   char *filename;		/* sfd name. NULL if we open a font, that's origname */
   char *defbasefilename;
   char *version;
   double italicangle, upos, uwidth;	/* In font info */
   int ascent, descent;
   int uniqueid;		/* Not copied when reading in!!!! */
   int glyphcnt, glyphmax;	/* allocated size of glyphs array */
   SplineChar **glyphs;
   unsigned int changed:1;
   unsigned int changed_since_xuidchanged:1;
   unsigned int display_antialias:1;
   unsigned int display_bbsized:1;
   unsigned int dotlesswarn:1;	/* User warned that font doesn't have a dotless i character */
   unsigned int onlybitmaps:1;	/* it's a bdf editor, not a postscript editor */
   unsigned int serifcheck:1;	/* Have we checked to see if we have serifs? */
   unsigned int issans:1;	/* We have no serifs */
   unsigned int isserif:1;	/* We have serifs. If neither set then we don't know. */
   unsigned int hasvmetrics:1;	/* We've got vertical metric data and should output vhea/vmtx/VORG tables */
   unsigned int loading_cid_map:1;
   unsigned int dupnamewarn:1;	/* Warn about duplicate names when loading bdf font */
   unsigned int encodingchanged:1;	/* Font's encoding has changed since it was loaded */
   unsigned int multilayer:1;	/* only applies if TYPE3 is set, means this font can contain strokes & fills */
   /*  I leave it in so as to avoid cluttering up code with #ifdefs */
   unsigned int strokedfont:1;
   unsigned int new:1;		/* A new and unsaved font */
   unsigned int compacted:1;	/* only used when opening a font */
   unsigned int backedup:2;	/* 0=>don't know, 1=>no, 2=>yes */
   unsigned int use_typo_metrics:1;	/* The standard says to. But MS */
   /* seems to feel that isn't good */
   /* enough and has created a bit */
   /* to mean "really use them" */
   unsigned int weight_width_slope_only:1;	/* This bit seems stupid to me */
   unsigned int head_optimized_for_cleartype:1;	/* Bit in the 'head' flags field, if unset "East Asian fonts in the Windows Presentation Framework (Avalon) will not be hinted" */
   unsigned int ticked:1;
   unsigned int internal_temp:1;	/* Internal temporary font to be passed to freetype for rasterizing. Don't complain about oddities. Don't generate GPOS/GSUB tables, etc. */
   unsigned int complained_about_spiros:1;
   unsigned int use_xuid:1;	/* Adobe has deprecated these two */
   unsigned int use_uniqueid:1;	/* fields. Mostly we don't want to use them */
   /* 2 bits left */
   struct fontviewbase *fv;
   struct metricsview *metrics;
   enum uni_interp uni_interp;
   NameList *for_new_glyphs;
   EncMap *map;			/* only used when opening a font to provide original default encoding */
   Layer grid;
   BDFFont *bitmaps;
   char *origname;		/* filename of font file (ie. if not an sfd) */
   int display_size;		/* a val <0 => Generate our own images from splines, a value >0 => find a bdf font of that size */
   struct psdict *private;	/* read in from type1 file or provided by user */
   char *xuid;
   struct pfminfo pfminfo;
   struct ttflangname *names;
   char *cidregistry, *ordering;
   int supplement;
   int subfontcnt;
   struct splinefont **subfonts;
   struct splinefont *cidmaster;	/* Top level cid font */
   float cidversion;
#   if HANYANG
   struct compositionrules *rules;
#   endif
   char *comments;		/* Used to be restricted to ASCII, now utf8 */
   char *fontlog;
   int tempuniqueid;
   int top_enc;
   uint16_t desired_row_cnt, desired_col_cnt;
   struct glyphnamehash *glyphnames;
   struct ttf_table *ttf_tables, *ttf_tab_saved;
   /* We copy: fpgm, prep, cvt, maxp (into ttf_tables) user can ask for others, into saved */
   char **cvt_names;
   /* The end of this array is marked by a special entry: */
#   define END_CVT_NAMES ((char *) (~(intptr_t) 0))
   struct instrdata *instr_dlgs;	/* Pointer to all table and character instruction dlgs in this font */
   struct shortview *cvt_dlg;
   struct kernclasslistdlg *kcld, *vkcld;
   struct kernclassdlg *kcd;
   struct texdata texdata;
   OTLookup *gsplookups[2];
   /* Apple morx subtables become gsub, and kern subtables become gpos */
   AnchorClass *anchor;
   KernClass *kerns, *vkerns;
   FPST *possub;
   ASM *sm;			/* asm is a keyword */
   MacFeat *features;
   char *chosenname;		/* Set for files with multiple fonts in them */
   struct mmset *mm;		/* If part of a multiple master set */
   int16_t macstyle;
   char *fondname;		/* For use in generating mac families */
   /* from the GPOS 'size' feature. design_size, etc. are measured in tenths of a point */
   /*  bottom is exclusive, top is inclusive */
   /*  if any field is 0, it is undefined. All may be undefined, All may be */
   /*  defined, or design_size may be defined without any of the others */
   /*  but we can't define the range without defining the other junk */
   /*  Name must contain an English language name, may contain others */
   uint16_t design_size;
   uint16_t fontstyle_id;
   struct otfname *fontstyle_name;
   uint16_t design_range_bottom, design_range_top;
   struct otffeatname *feat_names;
   double strokewidth;
/* For GDEF Mark Attachment Class -- used in lookup flags */
/* As usual, class 0 is unused */
   int mark_class_cnt;
   char **mark_classes;		/* glyph name list */
   char **mark_class_names;	/* used within ff, utf8 (the name we've given to this class of marks) */
/* For GDEF Mark Attachment Sets -- used in lookup flags */
/* but here, set 0 is meaningful, since pst_usemarkfilteringset tells us */
   int mark_set_cnt;
   char **mark_sets;		/* glyph name list */
   char **mark_set_names;	/* used within ff, utf8 (the name we've given to this class of marks) */
   long long creationtime;	/* seconds since 1970 */
   long long modificationtime;
   short os2_version;		/* 0 means default rather than the real version 0 */
   short compression;		/* If we opened a compressed sfd file, then save it out compressed too */
   short gasp_version;		/* 0/1 currently */
   short gasp_cnt;
   struct gasp *gasp;
   struct MATH *MATH;
   float sfd_version;		/* Used only when reading in an sfd file */
   struct gfi_data *fontinfo;
   struct val_data *valwin;
   void *python_persistent;	/* If python this will hold a python object, if not python this will hold a string containing a pickled object. We do nothing with it (if not python) except save it back out unchanged */
   enum loadvalidation_state loadvalidation_state;
   LayerInfo *layers;
   int layer_cnt;
   int display_layer;
   struct Base *horiz_base, *vert_base;
   Justify *justify;
   int extrema_bound;		/* Splines do not count for extrema complaints when the distance between the endpoints is less than or equal to this */
   int width_separation;
   int sfntRevision;
#   define sfntRevisionUnset	0x44445555
   int woffMajor;
#   define woffUnset		0x4455
   int woffMinor;
   char *woffMetadata;
   double ufo_ascent, ufo_descent;	/* I don't know what these mean, they don't seem to correspond to any other ascent/descent pair, but retain them so round-trip ufo input/output leaves them unchanged */
   /* ufo_descent is negative */

   struct sfundoes *undoes;
} SplineFont;

struct axismap {
   int points;			/* size of the next two arrays */
   double *blends;		/* between [0,1] ordered so that blend[0]<blend[1]<... */
   double *designs;		/* between the design ranges for this axis, typically [1,999] or [6,72] */
   double min, def, max;		/* For mac */
   struct macname *axisnames;	/* For mac */
};

struct named_instance {		/* For mac */
   double *coords;		/* array[axis], these are in user units */
   struct macname *names;
};

/* I am going to simplify my life and not encourage intermediate designs */
/*  this means I can easily calculate ConvertDesignVector, and don't have */
/*  to bother the user with specifying it. */
/* (NormalizeDesignVector is fairly basic and shouldn't need user help ever) */
/*  (As long as they want piecewise linear) */
/* I'm not going to support intermediate designs at all for apple var tables */
typedef struct mmset {
   int axis_count;
   char *axes[4];
   int instance_count;
   SplineFont **instances;
   SplineFont *normal;
   double *positions;		/* array[instance][axis] saying where each instance lies on each axis */
   double *defweights;		/* array[instance] saying how much of each instance makes the normal font */
   /* for adobe */
   struct axismap *axismaps;	/* array[axis] */
   char *cdv, *ndv;		/* for adobe */
   int named_instance_count;
   struct named_instance *named_instances;
   unsigned int changed:1;
   unsigned int apple:1;
} MMSet;

/* mac styles. Useful idea we'll just steal it */
enum style_flags { sf_bold=1, sf_italic=2, sf_underline=4, sf_outline =
      8,
   sf_shadow=0x10, sf_condense=0x20, sf_extend=0x40
};

struct sflist {
   SplineFont *sf;
   int32_t *sizes;
   AFILE *tempttf;		/* For ttf */
   int id;			/* For ttf */
   int *ids;			/* One for each size */
   BDFFont **bdfs;		/* Ditto */
   EncMap *map;
   struct sflist *next;
   char **former_names;
   int len;
};

    /* Used for drawing text with mark to base anchors */
typedef struct anchorpos {
   SplineChar *sc;		/* This is the mark being positioned */
   int x, y;			/* Its origin should be shifted this much relative to that of the original base char */
   AnchorPoint *apm;		/* The anchor point in sc used to position it */
   AnchorPoint *apb;		/* The anchor point in the base character against which we are positioned */
   int base_index;		/* Index in this array to the base character (-1=> original base char) */
   unsigned int ticked:1;	/* Used as a mark to mark */
} AnchorPos;

enum ttf_flags { ttf_flag_shortps=1, ttf_flag_nohints=2,
   ttf_flag_applemode=4,
   ttf_flag_pfed_comments=8, ttf_flag_pfed_colors=0x10,
   ttf_flag_otmode=0x20,
   ttf_flag_glyphmap=0x40,
   ttf_flag_TeXtable=0x80,
   ttf_flag_ofm=0x100,
   ttf_flag_oldkern=0x200,	/* never set in conjunction with applemode */
   ttf_flag_brokensize=0x400,	/* Adobe originally issued fonts with a bug in the size feature. They now claim (Aug 2006) that this has been fixed. Legacy programs will do the wrong thing with the fixed feature though */
   ttf_flag_pfed_lookupnames=0x800,
   ttf_flag_pfed_guides=0x1000,
   ttf_flag_pfed_layers=0x2000,
   ttf_flag_symbol=0x4000,
   ttf_flag_dummyDSIG=0x8000
};
enum ttc_flags { ttc_flag_trymerge=0x1, ttc_flag_cff=0x2 };

enum openflags { of_fstypepermitted=1, of_askcmap =
      2, of_all_glyphs_in_ttc=4,
   of_fontlint=8, of_hidewindow=0x10
};

enum ps_flags { ps_flag_nohintsubs=0x10000, ps_flag_noflex=0x20000,
   ps_flag_nohints=0x40000, ps_flag_restrict256=0x80000,
   ps_flag_afm=0x100000, ps_flag_pfm=0x200000,
   ps_flag_tfm=0x400000,
   ps_flag_round=0x800000,
/* CFF fonts are wrapped up in some postscript sugar -- unless they are to */
/*  go into a pdf file or an otf font */
   ps_flag_nocffsugar=0x1000000,
/* in type42 cid fonts we sometimes want an identity map from gid to cid */
   ps_flag_identitycidmap=0x2000000,
   ps_flag_afmwithmarks=0x4000000,
   ps_flag_noseac=0x8000000,
   ps_flag_outputfontlog=0x10000000,
   ps_flag_mask=(ps_flag_nohintsubs | ps_flag_noflex |
		   ps_flag_afm | ps_flag_pfm | ps_flag_tfm | ps_flag_round)
};

struct compressors {
   char *ext, *decomp, *recomp;
};

#   define COMPRESSORS_EMPTY { NULL, NULL, NULL }
extern struct compressors compressors[];

enum archive_list_style { ars_tar, ars_zip };

struct archivers {
   char *ext, *unarchive, *archive, *listargs, *extractargs, *appendargs;
   enum archive_list_style ars;
};

#   define ARCHIVERS_EMPTY { NULL, NULL, NULL, NULL, NULL, NULL, 0 }

struct fontdict;
struct pschars;
struct findsel;
struct charprocs;
struct enc;

#   define chunkalloc(size)	calloc(1,size)
#   define chunkfree(item,size)	free(item)

extern char *strconcat(const char *str, const char *str2);
extern char *strconcat3(const char *str, const char *str2, const char *str3);

extern char *XUIDFromFD(int xuid[20]);

extern SplineFont *SplineFontFromPSFont(struct fontdict *fd);

extern int CheckAfmOfPostScript(SplineFont *sf, char *psname, EncMap *map);

extern int LoadKerningDataFromAmfm(SplineFont *sf, char *filename,
				   EncMap *map);
extern int LoadKerningDataFromAfm(SplineFont *sf, char *filename,
				  EncMap *map);
extern int LoadKerningDataFromTfm(SplineFont *sf, char *filename,
				  EncMap *map);
extern int LoadKerningDataFromOfm(SplineFont *sf, char *filename,
				  EncMap *map);
extern int LoadKerningDataFromPfm(SplineFont *sf, char *filename,
				  EncMap *map);
extern int LoadKerningDataFromMacFOND(SplineFont *sf, char *filename,
				      EncMap *map);
extern int LoadKerningDataFromMetricsFile(SplineFont *sf, char *filename,
					  EncMap *map);

extern void FeatDumpFontLookups(AFILE *out, SplineFont *sf);
extern void FeatDumpOneLookup(AFILE *out, SplineFont *sf, OTLookup *otl);

extern void SFApplyFeatureFile(SplineFont *sf, AFILE *file, char *filename);
extern void SFApplyFeatureFilename(SplineFont *sf, char *filename);

extern void SubsNew(SplineChar *to, enum possub_type type, int tag,
		    char *components, SplineChar *default_script);

extern int SFOneWidth(SplineFont *sf);
extern int CIDOneWidth(SplineFont *sf);

extern int SFIsCJK(SplineFont *sf, EncMap *map);

enum fontformat { ff_pfa, ff_pfb, ff_pfbmacbin, ff_multiple, ff_mma, ff_mmb,
   ff_ptype3, ff_ptype0, ff_cid, ff_cff, ff_cffcid,
   ff_type42, ff_type42cid,
   ff_ttf, ff_ttfsym, ff_ttfmacbin, ff_ttc, ff_ttfdfont, ff_otf, ff_otfdfont,
   ff_otfcid, ff_otfciddfont, ff_svg, ff_ufo, ff_woff, ff_none
};

extern struct pschars *SplineFont2ChrsSubrs(SplineFont *sf, int iscjk,
					    struct pschars *subrs, int flags,
					    enum fontformat format,
					    int layer);
extern int CanonicalCombiner(int uni);

struct cidbytes;
struct fd2data;
struct ttfinfo;
struct alltabs;

typedef struct growbuf {
   unsigned char *pt;
   unsigned char *base;
   unsigned char *end;
} GrowBuf;

extern void GrowBuffer(GrowBuf *gb);
extern void GrowBufferAdd(GrowBuf *gb, int ch);
extern void GrowBufferAddStr(GrowBuf *gb, char *str);

struct glyphdata;

extern int UnitsParallel(BasePoint *u1, BasePoint *u2, int strict);

extern int CvtPsStem3(struct growbuf *gb, SplineChar *scs[MmMax],
		      int instance_count, int ishstem, int round);

extern struct pschars *CID2ChrsSubrs(SplineFont *cidmaster,
				     struct cidbytes *cidbytes, int flags,
				     int layer);
extern struct pschars *SplineFont2ChrsSubrs2(SplineFont *sf, int nomwid,
					     int defwid, const int *bygid,
					     int cnt, int flags,
					     struct pschars **_subrs,
					     int layer);
extern struct pschars *CID2ChrsSubrs2(SplineFont *cidmaster,
				      struct fd2data *fds, int flags,
				      struct pschars **_glbls, int layer);
enum bitmapformat { bf_bdf, bf_ttf, bf_sfnt_dfont, bf_sfnt_ms, bf_otb,
   bf_nfntmacbin, /*bf_nfntdfont, */ bf_fon, bf_fnt, bf_palm,
   bf_ptype3,
   bf_none
};

extern int32_t filechecksum(AFILE *file);

extern void SC_PSDump(AFILE *f,
		      SplineChar *sc, int refs_to_splines, int pdfopers,
		      int layer);
extern int _WritePSFont(AFILE *out, SplineFont *sf, enum fontformat format,
			int flags, EncMap *enc, SplineFont *fullsf,
			int layer);
extern int WritePSFont(char *fontname, SplineFont *sf,
		       enum fontformat format, int flags, EncMap *enc,
		       SplineFont *fullsf, int layer);
extern int WriteMacPSFont(char *fontname, SplineFont *sf,
			  enum fontformat format, int flags, EncMap *enc,
			  int layer);
extern int _WriteWOFFFont(AFILE *ttf, SplineFont *sf, enum fontformat format,
			  int32_t *bsizes, enum bitmapformat bf, int flags,
			  EncMap *enc, int layer);
extern int WriteWOFFFont(char *fontname, SplineFont *sf,
			 enum fontformat format, int32_t *bsizes,
			 enum bitmapformat bf, int flags, EncMap *enc,
			 int layer);
extern int _WriteTTFFont(AFILE *ttf, SplineFont *sf, enum fontformat format,
			 int32_t *bsizes, enum bitmapformat bf, int flags,
			 EncMap *enc, int layer);
extern int WriteTTFFont(char *fontname, SplineFont *sf,
			enum fontformat format, int32_t *bsizes,
			enum bitmapformat bf, int flags, EncMap *enc,
			int layer);
extern int _WriteType42SFNTS(AFILE *type42, SplineFont *sf,
			     enum fontformat format, int flags, EncMap *enc,
			     int layer);
extern int WriteMacTTFFont(char *fontname, SplineFont *sf,
			   enum fontformat format, int32_t *bsizes,
			   enum bitmapformat bf, int flags, EncMap *enc,
			   int layer);
extern int WriteMacBitmaps(char *filename, SplineFont *sf, int32_t *sizes,
			   int is_dfont, EncMap *enc);
extern int WritePalmBitmaps(char *filename, SplineFont *sf, int32_t *sizes,
			    EncMap *enc);
extern int WriteMacFamily(char *filename, struct sflist *sfs,
			  enum fontformat format, enum bitmapformat bf,
			  int flags, int layer);
extern long mactime(void);

extern SplineSet *SplinePointListInterpretSVG(char *filename,char *memory,
					      int memlen,int em_size,
					      int ascent,int is_stroked);

extern int WriteSVGFont(char *fontname, SplineFont *sf,
			enum fontformat format, int flags, EncMap *enc,
			int layer);
extern int WriteUFOFont(char *fontname, SplineFont *sf,
			enum fontformat format, int flags, EncMap *enc,
			int layer);

extern void TTF_PSDupsDefault(SplineFont *sf);

extern void DefaultTTFEnglishNames(struct ttflangname *dummy,
				   SplineFont *sf);
extern void TeXDefaultParams(SplineFont *sf);

extern int AlreadyMSSymbolArea(SplineFont *sf, EncMap *map);

extern void OS2FigureCodePages(SplineFont *sf, uint32_t CodePage[2]);
extern void OS2FigureUnicodeRanges(SplineFont *sf, uint32_t Ranges[4]);
extern void SFDefaultOS2Info(struct pfminfo *pfminfo, SplineFont *sf,
			     char *fontname);
extern void SFDefaultOS2Simple(struct pfminfo *pfminfo, SplineFont *sf);
extern void SFDefaultOS2SubSuper(struct pfminfo *pfminfo, int emsize,
				 double italicangle);

extern int ScriptIsRightToLeft(uint32_t script);
extern void ScriptMainRange(uint32_t script, int *start, int *end);
extern uint32_t ScriptFromUnicode(int u, SplineFont *sf);
extern uint32_t SCScriptFromUnicode(SplineChar *sc);

extern int SCRightToLeft(SplineChar *sc);

extern int SFForceEncoding(SplineFont *sf, EncMap *old, Encoding *new_map);

extern void SFMatchGlyphs(SplineFont *sf, SplineFont *target,
			  int addempties);
extern void MMMatchGlyphs(MMSet *mm);

extern char *_GetModifiers(char *fontname, char *familyname, char *weight);

extern char *SFGetModifiers(SplineFont *sf);

extern void SFSetFontName(SplineFont *sf, char *family, char *mods,
			  char *fullname);
extern void ttfdumpbitmap(SplineFont *sf, struct alltabs *at, int32_t *sizes);

extern void ttfdumpbitmapscaling(SplineFont *sf, struct alltabs *at,
				 int32_t *sizes);

extern int Within4RoundingErrors(double v1, double v2);
extern int Within16RoundingErrors(double v1, double v2);
extern int Within64RoundingErrors(double v1, double v2);

extern int RealNear(double a, double b);
extern int RealNearish(double a, double b);
extern int RealApprox(double a, double b);
extern int RealWithin(double a, double b, double fudge);
extern int RealRatio(double a, double b, double fudge);

extern int PointsDiagonalable(SplineFont *sf, BasePoint ** bp,
			      BasePoint *unit);
extern int MergeDStemInfo(SplineFont *sf, DStemInfo ** ds, DStemInfo *test);

extern void LinearApproxFree(LinearApprox *la);
extern void SplineFree(Spline *spline);

extern SplinePoint *SplinePointCreate(double x, double y);
extern void SplinePointFree(SplinePoint *sp);
extern void SplinePointMDFree(SplineChar *sc,SplinePoint *sp);
extern void SplinePointListFree(SplinePointList *spl);
extern void SplinePointListMDFree(SplineChar *sc, SplinePointList *spl);
extern void SplinePointListsFree(SplinePointList *head);

extern void SplineSetSpirosClear(SplineSet *spl);
extern void SplineSetBeziersClear(SplineSet *spl);

extern void RefCharFree(RefChar *ref);
extern void RefCharsFree(RefChar *ref);

extern void CopyBufferClearCopiedFrom(SplineFont *dying);

extern void UndoesFree(Undoes *undo);

extern void StemInfosFree(StemInfo *h);
extern void StemInfoFree(StemInfo *h);
extern void DStemInfosFree(DStemInfo *h);
extern void DStemInfoFree(DStemInfo *h);

extern void KernPairsFree(KernPair *kp);

extern void SCOrderAP(SplineChar *sc);

extern void AnchorPointsFree(AnchorPoint *ap);
extern AnchorPoint *AnchorPointsCopy(AnchorPoint *alist);
extern void SFRemoveAnchorClass(SplineFont *sf, AnchorClass *an);
extern int IsAnchorClassUsed(SplineChar *sc, AnchorClass *an);
extern AnchorPoint *APAnchorClassMerge(AnchorPoint *anchors,
				       AnchorClass *into,
				       AnchorClass *from);

extern void TtfTablesFree(struct ttf_table *tab);

extern void ValDevFree(ValDevTab *adjust);

extern ValDevTab *ValDevTabCopy(ValDevTab *orig);

extern void DeviceTableFree(DeviceTable *adjust);

extern DeviceTable *DeviceTableCopy(DeviceTable *orig);

extern void PSTFree(PST *lig);

extern int PSTContains(const char *components, const char *name);

extern StemInfo *StemInfoCopy(StemInfo *h);

extern DStemInfo *DStemInfoCopy(DStemInfo *h);

struct lookup_cvt {
   OTLookup *from, *to;
   int old;
};

struct sub_cvt {
   struct lookup_subtable *from, *to;
   int old;
};

struct ac_cvt {
   AnchorClass *from, *to;
   int old;
};

struct sfmergecontext {
   SplineFont *sf_from, *sf_to;
   int lcnt;
   struct lookup_cvt *lks;
   int scnt;
   struct sub_cvt *subs;
   int acnt;
   struct ac_cvt *acs;
   char *prefix;
   int preserveCrossFontKerning;
   int lmax;
};

extern PST *PSTCopy(PST *base, SplineChar *sc, struct sfmergecontext *mc);

extern struct lookup_subtable *MCConvertSubtable(struct sfmergecontext *mc,
						 struct lookup_subtable *sub);
extern AnchorClass *MCConvertAnchorClass(struct sfmergecontext *mc,
					 AnchorClass *ac);
extern void SFFinishMergeContext(struct sfmergecontext *mc);

extern SplineChar *SplineCharCopy(SplineChar *sc, SplineFont *into,
				  struct sfmergecontext *);
extern BDFChar *BDFCharCopy(BDFChar *bc);

extern void BCFlattenFloat(BDFChar *bc);

extern void BitmapsCopy(SplineFont *to, SplineFont *from, int to_index,
			int from_index);
extern struct gimage *ImageAlterClut(struct gimage *image);

extern void ImageListsFree(ImageList *imgs);

extern void AltUniFree(struct altuni *altuni);

extern void AltUniFigure(SplineFont *sf, EncMap *map, int check_dups);

extern void AltUniRemove(SplineChar *sc, int uni);

extern void AltUniAdd(SplineChar *sc, int uni);

extern void AltUniAdd_DontCheckDups(SplineChar *sc, int uni);

extern void MinimumDistancesFree(MinimumDistance *md);

extern void LayerDefault(Layer *);

extern SplineChar *SplineCharCreate(int layer_cnt);

extern SplineChar *SFSplineCharCreate(SplineFont *sf);

extern RefChar *RefCharCreate(void);

extern RefChar *RefCharsCopy(RefChar *ref);	/* Still needs to be instantiated and have the dependency list adjusted */

extern struct altuni *AltUniCopy(struct altuni *altuni,
				 SplineFont *noconflicts);
extern void SCAddRef(SplineChar *sc, SplineChar *rsc, int layer, double xoff,
		     double yoff);
extern void _SCAddRef(SplineChar *sc, SplineChar *rsc, int layer,
		      double transform[6]);
extern KernClass *KernClassCopy(KernClass *kc);

extern void KernClassListFree(KernClass *kc);

extern int KernClassContains(KernClass *kc, char *name1, char *name2,
			     int ordered);
extern void OTLookupFree(OTLookup *lookup);

extern void OTLookupListFree(OTLookup *lookup);

extern FPST *FPSTCopy(FPST *fpst);

extern void FPSTFree(FPST *fpst);

extern void ASMFree(ASM *sm);

extern struct macname *MacNameCopy(struct macname *mn);

extern void SplineCharFree(SplineChar *sc);

extern void EncMapFree(EncMap *map);

extern EncMap *EncMapFromEncoding(SplineFont *sf, Encoding *enc);

extern EncMap *CompactEncMap(EncMap *map, SplineFont *sf);

extern EncMap *EncMapNew(int encmax, int backmax, Encoding *enc);

extern EncMap *EncMap1to1(int enccount);

extern EncMap *EncMapCopy(EncMap *map);

extern void SFExpandGlyphCount(SplineFont *sf, int newcnt);

extern void ScriptLangListFree(struct scriptlanglist *sl);

extern void FeatureScriptLangListFree(FeatureScriptLangList *fl);

extern void SFBaseSort(SplineFont *sf);

extern void BaseScriptFree(struct basescript *bs);

extern void BaseFree(struct Base *base);

extern void SplineFontFree(SplineFont *sf);

extern void OtfNameListFree(struct otfname *on);

extern void OtfFeatNameListFree(struct otffeatname *fn);

extern struct otffeatname *findotffeatname(uint32_t tag, SplineFont *sf);

extern void SplineRefigure3(Spline *spline);

extern void SplineRefigure(Spline *spline);

extern Spline *SplineMake3(SplinePoint *from, SplinePoint *to);

extern LinearApprox *SplineApproximate(Spline *spline, double scale);

extern int SplinePointListIsClockwise(const SplineSet *spl);

extern void SplineSetFindBounds(const SplinePointList *spl,
				DBounds *bounds);
extern void SplineCharLayerFindBounds(SplineChar *sc, int layer,
				      DBounds *bounds);
extern void SplineCharFindBounds(SplineChar *sc, DBounds *bounds);

extern void SplineFontLayerFindBounds(SplineFont *sf, int layer,
				      DBounds *bounds);
extern void SplineFontFindBounds(SplineFont *sf, DBounds *bounds);

extern void CIDLayerFindBounds(SplineFont *sf, int layer, DBounds *bounds);

extern void SplineSetQuickBounds(SplineSet *ss, DBounds *b);

extern void SplineCharLayerQuickBounds(SplineChar *sc, int layer,
				       DBounds *bounds);
extern void SplineCharQuickBounds(SplineChar *sc, DBounds *b);

extern void SplineCharQuickConservativeBounds(SplineChar *sc, DBounds *b);

extern void SplineFontQuickConservativeBounds(SplineFont *sf, DBounds *b);

extern void SplinePointCategorize(SplinePoint *sp);

extern void SPLCategorizePoints(SplinePointList *spl);

extern void SCCategorizePoints(SplineChar *sc);

extern SplinePointList *SplinePointListCopy1(const SplinePointList *spl);

extern SplinePointList *SplinePointListCopy(const SplinePointList *base);

extern ImageList *ImageListCopy(ImageList *cimg);

extern void ApTransform(AnchorPoint *ap, double transform[6]);

/* The order of the enum elements below doesn't make much sense, but it's done*/
/*  this way to preserve binary compatibility */
enum transformPointType { tpt_OnlySelected, tpt_AllPoints,
      tpt_OnlySelectedInterpCPs };
/*
 *As SplinePointListTransform() does a few things, this is a mask to selectively be
 *able to disable some of them.
 */
enum transformPointMask {
   tpmask_dontFixControlPoints=1 << 1,
   tpmask_operateOnSelectedBCP=1 << 2
};

extern SplinePointList *SplinePointListTransform(SplinePointList *base,
						 double transform[6],
						 enum transformPointType
						 allpoints);
extern SplinePointList *SplinePointListShift(SplinePointList *base,
					     double xoff,
					     enum transformPointType
					     allpoints);
extern HintMask *HintMaskFromTransformedRef(RefChar *ref, BasePoint *trans,
					    SplineChar *basesc,
					    HintMask *hm);
extern SplinePointList *SPLCopyTranslatedHintMasks(SplinePointList *base,
						   SplineChar *basesc,
						   SplineChar *subsc,
						   BasePoint *trans);
extern SplinePointList *SPLCopyTransformedHintMasks(RefChar *r,
						    SplineChar *basesc,
						    BasePoint *trans,
						    int layer);
extern void SplinePointListSelect(SplinePointList *spl, int sel);

extern void SCRefToSplines(SplineChar *sc, RefChar *rf, int layer);

extern void RefCharFindBounds(RefChar *rf);

extern void SCReinstantiateRefChar(SplineChar *sc, RefChar *rf, int layer);

extern void SCRemoveDependent(SplineChar * dependent, RefChar * rf, int layer);

extern void SFInstantiateRefs(SplineFont *sf);

extern void SCRemoveLayerDependents(SplineChar *dependent, int layer);

extern int SCDependsOnSC(SplineChar *parent, SplineChar *child);

extern void BCCompressBitmap(BDFChar *bdfc);

extern void BCRegularizeBitmap(BDFChar *bdfc);

extern void BCRegularizeGreymap(BDFChar *bdfc);

extern void BCPasteInto(BDFChar *bc, BDFChar *rbc, int ixoff, int iyoff,
			int invert, int cleartoo);
extern void BCRotateCharForVert(BDFChar *bc, BDFChar *from,
				BDFFont *frombdf);
extern int GradientHere(double scale, DBounds *bbox, int iy, int ix,
			struct gradient *grad, struct pattern *pat,
			int defgrey);
extern void PatternPrep(SplineChar *sc, struct brush *brush, double scale);

extern BDFChar *SplineCharRasterize(SplineChar *sc, int layer,
				    double pixelsize);
extern BDFFont *SplineFontToBDFHeader(SplineFont *_sf, int pixelsize,
				      int indicate);
extern BDFFont *SplineFontRasterize(SplineFont *sf, int layer, int pixelsize,
				    int indicate);
extern void BDFCAntiAlias(BDFChar *bc, int linear_scale);

extern BDFChar *SplineCharAntiAlias(SplineChar *sc, int layer, int pixelsize,
				    int linear_scale);
extern BDFFont *SplineFontAntiAlias(SplineFont *sf, int layer, int pixelsize,
				    int linear_scale);
extern struct clut *_BDFClut(int linear_scale);

extern void BDFClut(BDFFont *bdf, int linear_scale);

extern int BDFDepth(BDFFont *bdf);

extern BDFChar *BDFPieceMeal(BDFFont *bdf, int index);

extern BDFChar *BDFPieceMealCheck(BDFFont *bdf, int index);
enum piecemeal_flags { pf_antialias=1, pf_bbsized=2, pf_ft_nohints =
      4, pf_ft_recontext=8 };
extern BDFFont *SplineFontPieceMeal(SplineFont *sf, int layer, int ptsize,
				    int dpi, int flags,
				    void *freetype_context);
extern void BDFCharFindBounds(BDFChar *bc, IBounds *bb);

extern int BDFCharQuickBounds(BDFChar *bc, IBounds *bb, int8_t xoff,
			      int8_t yoff, int use_backup, int first);
extern void BCPrepareForOutput(BDFChar *bc, int mergeall);

extern void BCRestoreAfterOutput(BDFChar *bc);

extern void BCMakeDependent(BDFChar *dependent, BDFChar *base);

extern void BCRemoveDependent(BDFChar *dependent, BDFRefChar *rf);

extern void BCExpandBitmapToEmBox(BDFChar *bc, int xmin, int ymin, int xmax,
				  int ymax);
extern BDFFont *BitmapFontScaleTo(BDFFont *old, int to);

extern void BDFCharFree(BDFChar *bdfc);

extern void BDFPropsFree(BDFFont *bdf);

extern void BDFFontFree(BDFFont *bdf);

extern void SFDefaultAscent(SplineFont *sf);

extern int PSBitmapDump(char *filename, BDFFont *font, EncMap *map);

extern int BDFFontDump(char *filename, BDFFont *font, EncMap *map, int res);

extern int FNTFontDump(char *filename, BDFFont *font, EncMap *map, int res);

extern int FONFontDump(char *filename, SplineFont *sf, int32_t *sizes,
		       int res, EncMap *map);
extern void SFReplaceEncodingBDFProps(SplineFont *sf, EncMap *map);

extern void SFReplaceFontnameBDFProps(SplineFont *sf);

extern int IsUnsignedBDFKey(char *key);

extern int BdfPropHasInt(BDFFont *font, const char *key, int def);

extern char *BdfPropHasString(BDFFont *font, const char *key, char *def);

extern void def_Charset_Enc(EncMap *map, char *reg, char *enc);

extern void Default_XLFD(BDFFont *bdf, EncMap *map, int res);

extern void Default_Properties(BDFFont *bdf, EncMap *map, char *onlyme);

extern void BDFDefaultProps(BDFFont *bdf, EncMap *map, int res);

struct xlfd_components {
   char foundry[80];
   char family[100];
   char weight[80];
   char slant[40];
   char setwidth[50];
   char add_style[50];
   int pixel_size;
   int point_size;
   int res_x;
   int res_y;
   char spacing[40];
   int avg_width;
   char cs_reg[80];		/* encoding */
   char cs_enc[80];		/* encoding version? */
   int char_cnt;
};

struct std_bdf_props {
   char *name;
   int type;
   int defaultable;
};

#   define STD_BDF_PROPS_EMPTY { NULL, 0, 0 }

extern void XLFD_GetComponents(char *xlfd, struct xlfd_components *comp);

extern void XLFD_CreateComponents(BDFFont *bdf, EncMap *map, int res,
				  struct xlfd_components *comp);
/* Two lines intersect in at most 1 point */
/* Two quadratics intersect in at most 4 points */
					       /* Two cubics intersect in at most 9 points *//* Plus an extra space for a trailing -1 */
extern int SplinesIntersect(const Spline *s1, const Spline *s2,
			    BasePoint pts[9], double t1s[10],
			    double t2s[10]);
extern SplineSet *LayerAllSplines(Layer *layer);

extern SplineSet *LayerUnAllSplines(Layer *layer);

extern int SplineSetIntersect(SplineSet *spl, Spline ** _spline,
			      Spline ** _spline2);
extern int _CubicSolve(const Spline1D *sp, double sought, double ts[3]);

extern int CubicSolve(const Spline1D *sp, double sought, double ts[3]);

/* Uses an algebraic solution */
extern double SplineSolve(const Spline1D *sp, double tmin, double tmax,
			    double sought_y);
/* Tries to fixup rounding errors that crept in to the solution */
extern double SplineSolveFixup(const Spline1D *sp, double tmin, double tmax,
				 double sought_y);
/* Uses an iterative approximation */
extern double IterateSplineSolve(const Spline1D *sp, double tmin,
				   double tmax, double sought_y);
/* Uses an iterative approximation and then tries to fix things up */
extern double IterateSplineSolveFixup(const Spline1D *sp, double tmin,
					double tmax, double sought_y);
extern void SplineFindExtrema(const Spline1D *sp, double *_t1,
			      double *_t2);

SplineSet *SplineSetsInterpolate(SplineSet *base, SplineSet *other,
				 double amount, SplineChar *sc);
SplineChar *SplineCharInterpolate(SplineChar *base, SplineChar *other,
				  double amount, SplineFont *newfont);
extern SplineFont *InterpolateFont(SplineFont *base, SplineFont *other,
				   double amount, Encoding *enc);

double SFSerifHeight(SplineFont *sf);

extern char *ParseEncodingFile(char *filename, char *encodingname);

extern int GenerateScript(SplineFont *sf, char *filename, char *bitmaptype,
			  int fmflags, int res, char *subfontdirectory,
			  struct sflist *sfs, EncMap *map,
			  NameList *rename_to, int layer);

extern void _SCAutoTrace(SplineChar *sc, int layer, char **args);

extern char **AutoTraceArgs(int ask);

#   define CURVATURE_ERROR	-1e9
extern double SplineCurvature(Spline *s, double t);

extern double CheckExtremaForSingleBitErrors(const Spline1D *sp, double t,
					     double othert);
extern int Spline2DFindExtrema(const Spline *sp, double extrema[4]);

extern int Spline2DFindPointsOfInflection(const Spline *sp, double poi[2]);

extern void SplineRemoveExtremaTooClose(Spline1D *sp, double *_t1,
					double *_t2);
extern double SplineNearPoint(Spline *spline, BasePoint *bp, double fudge);

extern void SCMakeDependent(SplineChar *dependent, SplineChar *base);

extern SplinePoint *SplineBisect(Spline *spline, double t);

extern Spline *ApproximateSplineFromPoints(SplinePoint *from,
					   SplinePoint *to, TPoint *mid,
					   int cnt, int order2);
extern Spline *ApproximateSplineFromPointsSlopes(SplinePoint *from,
						 SplinePoint *to,
						 TPoint *mid, int cnt,
						 int order2);
extern double SplineLength(Spline *spline);

extern int SplineIsLinear(Spline *spline);

extern int SplineIsLinearMake(Spline *spline);

extern int SplineInSplineSet(Spline *spline, SplineSet *spl);

extern int SSPointWithin(SplineSet *spl, BasePoint *pt);

extern SplineSet *SSRemoveZeroLengthSplines(SplineSet *base);

extern void SSRemoveStupidControlPoints(SplineSet *base);

extern void SplinesRemoveBetween(SplineChar *sc, SplinePoint *from,
				 SplinePoint *to, int type);

extern void SPLNearlyHvCps(SplineChar *sc, SplineSet *ss, double err);

extern void SPLNearlyHvLines(SplineChar *sc, SplineSet *ss, double err);

extern int SPLNearlyLines(SplineChar *sc, SplineSet *ss, double err);

extern int SPInterpolate(const SplinePoint *sp);

extern void SplinePointListSimplify(SplineChar *sc, SplinePointList *spl,
				    struct simplifyinfo *smpl);
extern SplineSet *SplineCharSimplify(SplineChar *sc, SplineSet *head,
				     struct simplifyinfo *smpl);
extern void SPLStartToLeftmost(SplineChar *sc, SplinePointList *spl,
			       int *changed);
extern void SPLsStartToLeftmost(SplineChar *sc, int layer);

extern void CanonicalContours(SplineChar *sc, int layer);

extern void SplineSetJoinCpFixup(SplinePoint *sp);

extern SplineSet *SplineSetJoin(SplineSet *start, int doall, double fudge,
				int *changed);
enum ae_type { ae_all, ae_between_selected, ae_only_good,
      ae_only_good_rm_later };
extern int SpIsExtremum(SplinePoint *sp);

extern int Spline1DCantExtremeX(const Spline *s);

extern int Spline1DCantExtremeY(const Spline *s);

extern Spline *SplineAddExtrema(Spline *s, int always, double lenbound,
				double offsetbound, DBounds *b);
extern void SplineSetAddExtrema(SplineChar *sc, SplineSet *ss,
				enum ae_type between_selected, int emsize);
extern void SplineCharAddExtrema(SplineChar *sc, SplineSet *head,
				 enum ae_type between_selected, int emsize);

extern SplineFont *SplineFontNew(void);

extern char *GetNextUntitledName(void);

extern SplineFont *SplineFontEmpty(void);

extern SplineFont *SplineFontBlank(int charcnt);

extern void SFIncrementXUID(SplineFont *sf);

extern SplineSet *SplineSetReverse(SplineSet *spl);

extern SplineSet *SplineSetsCorrect(SplineSet *base, int *changed);

extern SplineSet *SplineSetsAntiCorrect(SplineSet *base);

extern SplineSet *SplineSetsDetectDir(SplineSet ** _base, int *lastscan);

extern void BP_HVForce(BasePoint *vector);

extern void SplineCharDefaultPrevCP(SplinePoint *base);

extern void SplineCharDefaultNextCP(SplinePoint *base);

extern void SplineCharTangentNextCP(SplinePoint *sp);

extern void SplineCharTangentPrevCP(SplinePoint *sp);

extern void SPAdjustControl(SplinePoint *sp, BasePoint *cp, BasePoint *to,
			    int order2);

extern void SPSmoothJoint(SplinePoint *sp);

extern int PointListIsSelected(SplinePointList *spl);

extern void SCSplinePointsUntick(SplineChar *sc, int layer);

extern void SplineSetsUntick(SplineSet *spl);

extern void SFOrderBitmapList(SplineFont *sf);

extern int KernThreshold(SplineFont *sf, int cnt);

extern double SFGuessItalicAngle(SplineFont *sf);

extern SplinePoint *SplineTtfApprox(Spline *ps);

extern SplineSet *SSttfApprox(SplineSet *ss);

extern SplineSet *SplineSetsTTFApprox(SplineSet *ss);

extern SplineSet *SSPSApprox(SplineSet *ss);

extern SplineSet *SplineSetsPSApprox(SplineSet *ss);

extern SplineSet *SplineSetsConvertOrder(SplineSet *ss, int to_order2);

extern void SplineRefigure2(Spline *spline);

extern void SplineRefigureFixup(Spline *spline);

extern Spline *SplineMake2(SplinePoint *from, SplinePoint *to);

extern Spline *SplineMake(SplinePoint *from, SplinePoint *to, int order2);

extern void SCConvertToOrder2(SplineChar *sc);

extern void SFConvertToOrder2(SplineFont *sf);

extern void SFConvertToOrder3(SplineFont *sf);

extern void SFConvertGridToOrder2(SplineFont *_sf);

extern void SCConvertLayerToOrder2(SplineChar *sc, int layer);

extern void SFConvertLayerToOrder2(SplineFont *sf, int layer);

extern void SFConvertGridToOrder3(SplineFont *_sf);

extern void SCConvertLayerToOrder3(SplineChar *sc, int layer);

extern void SFConvertLayerToOrder3(SplineFont *sf, int layer);

extern int IntersectLinesSlopes(BasePoint *inter,
				BasePoint *line1, BasePoint *slope1,
				BasePoint *line2, BasePoint *slope2);
extern int IntersectLines(BasePoint *inter,
			  BasePoint *line1_1, BasePoint *line1_2,
			  BasePoint *line2_1, BasePoint *line2_2);
extern int IntersectLinesClip(BasePoint *inter,
			      BasePoint *line1_1, BasePoint *line1_2,
			      BasePoint *line2_1, BasePoint *line2_2);

extern void SSRemoveBacktracks(SplineSet *ss);

extern SplineSet *SplineSetStroke(SplineSet *spl, StrokeInfo *si,
				  int order2);
extern SplineSet *SplineSetRemoveOverlap(SplineChar *sc, SplineSet *base,
					 enum overlap_type);
extern SplineSet *SSShadow(SplineSet *spl, double angle, double outline_width,
			   double shadow_length, SplineChar *sc,
			   int wireframe);

extern double BlueScaleFigureForced(struct psdict *private_,
				    double bluevalues[], double otherblues[]);
extern double BlueScaleFigure(struct psdict *private_, double bluevalues[],
			      double otherblues[]);
extern void FindBlues(SplineFont *sf, int layer, double blues[14],
		      double otherblues[10]);
extern void QuickBlues(SplineFont *sf, int layer, BlueData *bd);

extern void FindHStems(SplineFont *sf, double snaps[12], double cnt[12]);

extern void FindVStems(SplineFont *sf, double snaps[12], double cnt[12]);

extern double SFStdVW(SplineFont *sf);

extern void SCGuessHintInstancesList(SplineChar *sc, int layer,
				     StemInfo *hstem, StemInfo *vstem,
				     DStemInfo *dstem, int hvforce,
				     int dforce);
extern void SCGuessDHintInstances(SplineChar *sc, int layer, DStemInfo *ds);

extern void SCGuessHHintInstancesAndAdd(SplineChar *sc, int layer,
					StemInfo *stem, double guess1,
					double guess2);
extern void SCGuessVHintInstancesAndAdd(SplineChar *sc, int layer,
					StemInfo *stem, double guess1,
					double guess2);
extern void SCGuessHHintInstancesList(SplineChar *sc, int layer);

extern void SCGuessVHintInstancesList(SplineChar *sc, int layer);

extern double HIlen(StemInfo *stems);

extern double HIoverlap(HintInstance *mhi, HintInstance *thi);

extern int StemInfoAnyOverlaps(StemInfo *stems);

extern int StemListAnyConflicts(StemInfo *stems);

extern HintInstance *HICopyTrans(HintInstance *hi, double mul, double offset);

extern int SFNeedsAutoHint(SplineFont *_sf, int layer);

typedef struct bluezone {
   double base;
   int cvtindex;
   double family_base;		/* NaN if none */
   int family_cvtindex;
   double overshoot;		/* relative to baseline, NOT to base */
   int highest;			/* used in autoinstructing for HStem positioning */
   int lowest;			/* as above */
} BlueZone;

typedef struct stdstem {
   double width;			/* -1 if none */
   int cvtindex;
   struct stdstem *snapto;	/* NULL means stem isn't snapped to any other */
   int stopat;			/* at which ppem stop snapping to snapto */
} StdStem;

typedef struct globalinstrct {
   SplineFont *sf;
   int layer;
   BlueData *bd;
   double fudge;

   /* Did we initialize the tables needed? 'maxp' is skipped because */
   /* its initialization always succeeds. */
   int cvt_done;
   int fpgm_done;
   int prep_done;

   /* PS private data with truetype-specific information added */
   BlueZone blues[12];		/* like in BlueData */
   int bluecnt;
   StdStem stdhw;
   StdStem *stemsnaph;		/* StdHW excluded */
   int stemsnaphcnt;
   StdStem stdvw;
   StdStem *stemsnapv;		/* StdVW excluded */
   int stemsnapvcnt;
} GlobalInstrCt;

extern void InitGlobalInstrCt(GlobalInstrCt *gic, SplineFont *sf, int layer,
			      BlueData *bd);
extern void FreeGlobalInstrCt(GlobalInstrCt *gic);

extern void NowakowskiSCAutoInstr(GlobalInstrCt *gic, SplineChar *sc);

extern void SCClearHints(SplineChar *sc);

extern void SCClearHintMasks(SplineChar *sc, int layer, int counterstoo);

extern void SCFigureCounterMasks(SplineChar *sc);

extern void SCFigureHintMasks(SplineChar *sc, int layer);

extern void _SplineCharAutoHint(SplineChar *sc,int layer,BlueData *bd,
				struct glyphdata *gd2);
extern void SplineCharAutoHint(SplineChar *sc, int layer,BlueData *bd);

extern void SFSCAutoHint(SplineChar *sc, int layer, BlueData *bd);

extern void SplineFontAutoHint(SplineFont *sf, int layer);

extern void SplineFontAutoHintRefs(SplineFont *sf, int layer);

extern StemInfo *HintCleanup(StemInfo *stem, int dosort, int instance_count);

extern int SplineFontIsFlexible(SplineFont *sf, int layer, int flags);

extern int SCDrawsSomething(SplineChar *sc);

extern int SCWorthOutputting(SplineChar *sc);

extern int SFFindNotdef(SplineFont *sf, int fixed);

extern int doesGlyphExpandHorizontally(SplineChar *sc);

extern int IsntBDFChar(BDFChar *bdfc);

extern int AmfmSplineFont(AFILE *afm, MMSet *mm, int formattype,
			  EncMap *map, int layer);
extern int AfmSplineFont(AFILE *afm, SplineFont *sf, int formattype,
			 EncMap *map, int docc, SplineFont *fullsf,
			 int layer);
extern int PfmSplineFont(AFILE *pfm, SplineFont *sf, int type0, EncMap *map,
			 int layer);
extern int TfmSplineFont(AFILE *afm, SplineFont *sf, int formattype,
			 EncMap *map, int layer);
extern int OfmSplineFont(AFILE *afm, SplineFont *sf, int formattype,
			 EncMap *map, int layer);
extern char *EncodingName(Encoding *map);

extern void SFLigaturePrepare(SplineFont *sf);

extern void SFLigatureCleanup(SplineFont *sf);

extern void SFKernClassTempDecompose(SplineFont *sf, int isv);

extern void SFKernCleanup(SplineFont *sf, int isv);

extern int SCSetMetaData(SplineChar *sc, char *name, int unienc,
			 const char *comment);

typedef struct sfd_getfontmetadatadata {

   // these indicate if we saw some metadata or not.
   // perhaps the caller wants to do something special
   // if the metadata was present/missing.
   int hadtimes;
   int had_layer_cnt;

   // state that is mostly interesting to SFD_GetFontMetaData() only
   struct Base *last_base;
   struct basescript *last_base_script;
   OTLookup *lastpotl;
   OTLookup *lastsotl;
   KernClass *lastkc;
   KernClass *lastvkc;
   FPST *lastfp;
   ASM *lastsm;
   struct ttf_table *lastttf[2];

} SFD_GetFontMetaDataData;

extern enum uni_interp interp_from_encoding(Encoding *enc,
					    enum uni_interp interp);

extern const char *FindUnicharName(void);

extern Encoding *FindOrMakeEncoding(const char *name);

extern int SFDWriteBakExtended(char *locfilename,
			       SplineFont *sf, EncMap *map, EncMap *normal,
			       int localPrefMaxBackupsToKeep);
extern SplineFont *SFDRead(char *filename);

extern SplineFont *_SFDRead(char *filename, AFILE *sfd);

extern char *TTFGetFontName(AFILE *ttf, int32_t offset, int32_t off2);

extern void TTFLoadBitmaps(AFILE *ttf, struct ttfinfo *info, int onlyone);
enum ttfflags { ttf_onlystrikes=1, ttf_onlyonestrike=2, ttf_onlykerns =
      4, ttf_onlynames=8 };
extern SplineFont *_SFReadWOFF(AFILE *woff, int flags,
			       enum openflags openflags, char *filename,
			       struct fontdict *fd);
extern SplineFont *_SFReadTTF(AFILE *ttf, int flags, enum openflags openflags,
			      char *filename, struct fontdict *fd);
extern SplineFont *SFReadTTF(char *filename, int flags,
			     enum openflags openflags);
extern SplineFont *SFReadSVG(char *filename, int flags);

extern SplineFont *SFReadUFO(char *filename, int flags);
extern SplineSet *SplinePointListInterpretGlif(SplineFont *sf, char *filename,
					       char *memory, int memlen, int em_size,
					       int ascent, int is_stroked);

extern SplineFont *_CFFParse(AFILE *temp, int len, char *fontsetname);

extern SplineFont *CFFParse(char *filename);

extern SplineFont *SFReadMacBinary(char *filename, int flags,
				   enum openflags openflags);
extern SplineFont *SFReadWinFON(char *filename, int toback);

extern SplineFont *SFReadPalmPdb(char *filename, int toback);

extern SplineFont *LoadSplineFont(char *filename, enum openflags);

extern SplineFont *_ReadSplineFont(AFILE *file, char *filename,
				   enum openflags openflags);
extern SplineFont *ReadSplineFont(char *filename, enum openflags);	/* Don't use this, use LoadSF instead */

extern void ArchiveCleanup(char *archivedir);

extern char *Unarchive(char *name, char **_archivedir);

extern char *Decompress(char *name, int compression);

extern SplineFont *SFFromBDF(char *filename, int ispk, int toback);

extern SplineFont *SFFromMF(char *filename);

extern void SFCheckPSBitmap(SplineFont *sf);

extern uint16_t _MacStyleCode(char *styles, SplineFont *sf, uint16_t *psstyle);

extern uint16_t MacStyleCode(SplineFont *sf, uint16_t *psstyle);

extern SplineFont *SFReadIkarus(char *fontname);

extern SplineFont *_SFReadPdfFont(AFILE *ttf, char *filename,
				  enum openflags openflags);
extern SplineFont *SFReadPdfFont(char *filename, enum openflags openflags);

extern char **NamesReadPDF(char *filename);
extern char **NamesReadSFD(char *filename);
extern char **NamesReadTTF(char *filename);
extern char **NamesReadCFF(char *filename);
extern char **NamesReadPostScript(char *filename);
extern char **_NamesReadPostScript(AFILE *ps);
extern char **NamesReadSVG(char *filename);
extern char **NamesReadUFO(char *filename);
extern char **NamesReadMacBinary(char *filename);

extern void SFSetOrder(SplineFont *sf, int order2);

extern void SFLSetOrder(SplineFont *sf, int layerdest, int order2);

extern int SFFindOrder(SplineFont *sf);

extern int SFLFindOrder(SplineFont *sf, int layerdest);

extern SplineChar *SCBuildDummy(SplineChar *dummy, SplineFont *sf,
				EncMap *map, int i);
extern SplineChar *SFMakeChar(SplineFont *sf, EncMap *map, int i);

extern BDFChar *BDFMakeGID(BDFFont *bdf, int gid);

extern BDFChar *BDFMakeChar(BDFFont *bdf, EncMap *map, int enc);

extern RefChar *RefCharsCopyState(SplineChar *sc, int layer);

extern int SCWasEmpty(SplineChar *sc, int skip_this_layer);

extern void SCUndoSetLBearingChange(SplineChar *sc, int lb);

extern Undoes *SCPreserveLayer(SplineChar *sc, int layer, int dohints);

extern Undoes *SCPreserveState(SplineChar *sc, int dohints);

extern Undoes *SCPreserveBackground(SplineChar *sc);

extern Undoes *SCPreserveWidth(SplineChar *sc);

extern Undoes *SCPreserveVWidth(SplineChar *sc);

extern int isaccent(int uni);

extern int SFIsCompositBuildable(SplineFont *sf, int unicodeenc,
				 SplineChar *sc, int layer);
extern int SFIsSomethingBuildable(SplineFont *sf, SplineChar *sc, int layer,
				  int onlyaccents);
extern int SFIsRotatable(SplineFont *sf, SplineChar *sc, int layer);

extern void SCBuildComposite(SplineFont *sf, SplineChar *sc, int layer,
			     BDFFont *bmp, int disp_only);
extern int SCAppendAccent(SplineChar *sc, int layer, char *glyph_name,
			  int uni, uint32_t pos);
extern const unichar_t *SFGetAlternate(SplineFont *sf, int base,
				       SplineChar *sc, int nocheck);

extern int getAdobeEnc(char *name);

#   define UNDEFINED_WIDTH	-999999
extern SplinePointList *SplinePointListInterpretPS(AFILE *ps, int flags,
						   int stroked, int *width);
extern void PSFontInterpretPS(AFILE *ps, struct charprocs *cp,
			      char **encoding);
extern struct enc *PSSlurpEncodings(AFILE *file);

struct pscontext {
   int is_type2;
   int painttype;
   int instance_count;
   double blend_values[17];
   int blend_warn;
};

extern int UnblendedCompare(double u1[MmMax], double u2[MmMax], int cnt);

extern SplineChar *PSCharStringToSplines(uint8_t *type1, int len,
					 struct pscontext *context,
					 struct pschars *subrs,
					 struct pschars *gsubrs,
					 const char *name);
extern void MatMultiply(double m1[6], double m2[6], double to[6]);

extern int MatIsIdentity(double transform[6]);

extern int NameToEncoding(SplineFont *sf, EncMap *map, const char *uname);

extern void GlyphHashFree(SplineFont *sf);

extern void SFHashGlyph(SplineFont *sf, SplineChar *sc);

extern SplineChar *SFHashName(SplineFont *sf, const char *name);

extern int SFFindGID(SplineFont *sf, int unienc, const char *name);

extern int SFFindSlot(SplineFont *sf, EncMap *map, int unienc,
		      const char *name);
extern int SFCIDFindCID(SplineFont *sf, int unienc, const char *name);

extern SplineChar *SFGetChar(SplineFont *sf, int unienc, const char *name);

extern int SFHasChar(SplineFont *sf, int unienc, const char *name);

extern SplineChar *SFGetOrMakeChar(SplineFont *sf, int unienc,
				   const char *name);

extern int SFFindExistingSlot(SplineFont *sf, int unienc, const char *name);

extern int SFCIDFindExistingChar(SplineFont *sf, int unienc,
				 const char *name);
extern int SFHasCID(SplineFont *sf, int cid);

extern void PSCharsFree(struct pschars *chrs);

extern void PSDictFree(struct psdict *chrs);

extern struct psdict *PSDictCopy(struct psdict *dict);

extern int PSDictFindEntry(struct psdict *dict, char *key);

extern char *PSDictHasEntry(struct psdict *dict, char *key);

extern int PSDictRemoveEntry(struct psdict *dict, char *key);

extern int PSDictChangeEntry(struct psdict *dict, char *key, char *newval);

extern int SFPrivateGuess(SplineFont *sf, int layer, struct psdict *private,
			  char *name, int onlyone);


extern void SplineSetsRound2Int(SplineSet *spl, double factor, int inspiro,
				int onlysel);
extern void SCRound2Int(SplineChar *sc, int layer, double factor);

extern int SCRoundToCluster(SplineChar *sc, int layer, int sel,
			    double within, double max);
extern int SplineSetsRemoveAnnoyingExtrema(SplineSet *ss, double err);

extern int hascomposing(SplineFont *sf, int u, SplineChar *sc);

struct cidmap;			/* private structure to encoding.c */

extern int CIDFromName(char *name, SplineFont *cidmaster);

extern int CID2NameUni(struct cidmap *map, int cid, char *buffer, int len);

extern int NameUni2CID(struct cidmap *map, int uni, const char *name);

extern struct altuni *CIDSetAltUnis(struct cidmap *map, int cid);

extern int MaxCID(struct cidmap *map);

extern struct cidmap *LoadMapFromFile(char *file, char *registry,
				      char *ordering, int supplement);
extern struct cidmap *FindCidMap(char *registry, char *ordering,
				 int supplement, SplineFont *sf);
extern void SFFlatten(SplineFont *cidmaster);

extern int SFFlattenByCMap(SplineFont *sf, char *cmapname);

extern SplineFont *MakeCIDMaster(SplineFont *sf, EncMap *oldmap, int bycmap,
				 char *cmapfilename, struct cidmap *cidmap);

void putlong(AFILE *file, int val);

void putfixed(AFILE *file, double dval);

int ttfcopyfile(AFILE *ttf, AFILE *other, int pos, char *table_name);

extern void SCCopyLayerToLayer(SplineChar *sc, int from, int to,
			       int doclear);

extern int hasFreeType(void);

extern void *_FreeTypeFontContext(SplineFont *sf, SplineChar *sc,
				  struct fontviewbase *fv, int layer,
				  enum fontformat ff, int flags,
				  void *shared_ftc);
extern void *FreeTypeFontContext(SplineFont *sf, SplineChar *sc,
				 struct fontviewbase *fv, int layer);
extern BDFFont *SplineFontFreeTypeRasterize(void *freetypecontext,
					    int pixelsize, int depth);
extern BDFChar *SplineCharFreeTypeRasterize(void *freetypecontext, int gid,
					    int ptsize, int dpi, int depth);
extern void FreeTypeFreeContext(void *freetypecontext);

extern SplineSet *FreeType_GridFitChar(void *single_glyph_context,
				       int enc, double ptsizey, double ptsizex,
				       int dpi, uint16_t *width,
				       SplineChar *sc, int depth,
				       int scaled);
extern struct freetype_raster *FreeType_GetRaster(void *single_glyph_context,
						  int enc, double ptsizey,
						  double ptsizex, int dpi,
						  int depth);
extern BDFChar *SplineCharFreeTypeRasterizeNoHints(SplineChar *sc, int layer,
						   int ptsize, int dpi,
						   int depth);
extern BDFFont *SplineFontFreeTypeRasterizeNoHints(SplineFont *sf, int layer,
						   int pixelsize, int depth);

struct TT_ExecContextRec_;

extern int UniFromName(const char *name, enum uni_interp interp,
		       Encoding *encname);
extern const char *StdGlyphName(char *buffer, int uni, enum uni_interp interp,
				NameList *for_this_font);

extern NameList *DefaultNameListForNewFonts(void);

extern NameList *NameListByName(char *name);

extern NameList *LoadNamelist(char *filename);

extern void LoadNamelistDir(char *dir);

extern const char *RenameGlyphToNamelist(char *buffer, SplineChar *sc,
					 NameList *old, NameList *new,
					 char **sofar);
extern void SFRenameGlyphsToNamelist(SplineFont *sf, NameList *new);

extern char **SFTemporaryRenameGlyphsToNamelist(SplineFont *sf,
						NameList *new);
extern void SFTemporaryRestoreGlyphNames(SplineFont *sf, char **former);

extern int SSTtfNumberPoints(SplineSet *ss);

extern int SCNumberPoints(SplineChar *sc, int layer);

extern int SCPointsNumberedProperly(SplineChar *sc, int layer);

extern int ttfFindPointInSC(SplineChar *sc, int layer, int pnum,
			    BasePoint *pos, RefChar *bound);

int SFFigureDefWidth(SplineFont *sf, int *_nomwid);

extern int ClassesMatch(int cnt1, char **classes1, int cnt2, char **classes2);

extern ASM *ASMFromOpenTypeForms(SplineFont *sf, uint32_t script);

extern ASM *ASMFromFPST(SplineFont *sf, FPST *fpst, int ordered);

extern char *utf8_verify_copy(const char *str);

extern char *MacStrToUtf8(const char *str, int macenc, int maclang);

extern char *Utf8ToMacStr(const char *ustr, int macenc, int maclang);

extern uint8_t MacEncFromMacLang(int maclang);

extern uint16_t WinLangFromMac(int maclang);

extern uint16_t WinLangToMac(int winlang);

extern const int32_t *MacEncToUnicode(int script, int lang);

extern int MacLangFromLocale(void);

extern char *MacLanguageFromCode(int code);

extern char *FindEnglishNameInMacName(struct macname *mn);

extern char *PickNameFromMacName(struct macname *mn);

extern MacFeat *FindMacFeature(SplineFont *sf, int feat,
			       MacFeat ** secondary);
extern struct macsetting *FindMacSetting(SplineFont *sf, int feat, int set,
					 struct macsetting **secondary);
extern struct macname *FindMacSettingName(SplineFont *sf, int feat, int set);

extern int32_t UniFromEnc(int enc, Encoding *encname);

extern int32_t EncFromUni(int32_t uni, Encoding *encname);

extern int32_t EncFromName(const char *name, enum uni_interp interp,
			 Encoding *encname);

extern void MatInverse(double into[6], double orig[6]);

extern int BpColinear(BasePoint *first, BasePoint *mid, BasePoint *last);

extern int BpWithin(BasePoint *first, BasePoint *mid, BasePoint *last);

    /* Colinear & between */

enum psstrokeflags { /* sf_removeoverlap=2, */ sf_handle_eraser=4,
   sf_correctdir=8, sf_clearbeforeinput=16
};

extern char *MMAxisAbrev(char *axis_name);

extern char *MMMakeMasterFontname(MMSet *mm, int ipos, char **fullname);

extern char *MMGuessWeight(MMSet *mm, int ipos, char *def);

extern char *MMExtractNth(char *pt, int ipos);

extern char *MMExtractArrayNth(char *pt, int ipos);

extern int MMValid(MMSet *mm, int complain);

extern void MMKern(SplineFont *sf, SplineChar *first, SplineChar *second,
		   int diff, struct lookup_subtable *sub, KernPair *oldkp);
extern char *MMBlendChar(MMSet *mm, int gid);

extern char *EnforcePostScriptName(char *old);

extern char *ToAbsolute(char *filename);

enum Compare_Ret { SS_DiffContourCount=1,
   SS_MismatchOpenClosed=2,
   SS_DisorderedContours=4,
   SS_DisorderedStart=8,
   SS_DisorderedDirection=16,
   SS_PointsMatch=32,
   SS_ContourMatch=64,
   SS_NoMatch=128,
   SS_RefMismatch=256,
   SS_WidthMismatch=512,
   SS_VWidthMismatch=1024,
   SS_HintMismatch=2048,
   SS_HintMaskMismatch=4096,
   SS_LayerCntMismatch=8192,
   SS_ContourMismatch=16384,
   SS_UnlinkRefMatch=32768,

   BC_DepthMismatch=1 << 16,
   BC_BoundingBoxMismatch=2 << 16,
   BC_BitmapMismatch=4 << 16,
   BC_NoMatch=8 << 16,
   BC_Match=16 << 16,

   SS_RefPtMismatch=32 << 16
};

extern enum Compare_Ret BitmapCompare(BDFChar *bc1, BDFChar *bc2, int err,
				      int bb_err);
extern enum Compare_Ret SSsCompare(const SplineSet *ss1,
				   const SplineSet *ss2, double pt_err,
				   double spline_err, SplinePoint ** hmfail);
enum font_compare_flags { fcf_outlines=1, fcf_exact =
      2, fcf_warn_not_exact=4,
   fcf_hinting=8, fcf_hintmasks=0x10, fcf_hmonlywithconflicts=0x20,
   fcf_warn_not_ref_exact=0x40,
   fcf_bitmaps=0x80, fcf_names=0x100, fcf_gpos=0x200, fcf_gsub=0x400,
   fcf_adddiff2sf1=0x800, fcf_addmissing=0x1000
};

extern int CompareFonts(SplineFont *sf1, EncMap *map1, SplineFont *sf2,
			AFILE *diffs, int flags);

extern void DefaultOtherSubrs(void);

extern int ReadOtherSubrsFile(char *filename);

extern void SFSetModTime(SplineFont *sf);

extern int SFHasInstructions(SplineFont *sf);

extern int RefDepth(RefChar *ref, int layer);

extern char *TagFullName(SplineFont *sf, uint32_t tag, int ismac,
			 int onlyifknown);

extern uint32_t *SFScriptsInLookups(SplineFont *sf, int gpos);

extern uint32_t *SFLangsInScript(SplineFont *sf, int gpos, uint32_t script);

extern uint32_t *SFFeaturesInScriptLang(SplineFont *sf, int gpos,
				      uint32_t script, uint32_t lang);
extern OTLookup **SFLookupsInScriptLangFeature(SplineFont *sf, int gpos,
					       uint32_t script, uint32_t lang,
					       uint32_t feature);
extern SplineChar **SFGlyphsWithPSTinSubtable(SplineFont *sf,
					      struct lookup_subtable
					      *subtable);
extern void SFFindUnusedLookups(SplineFont *sf);

extern void SFFindClearUnusedLookupBits(SplineFont *sf);

extern void SFRemoveLookupSubTable(SplineFont *sf,
				   struct lookup_subtable *sub,
				   int remove_acs);
extern void SFRemoveLookup(SplineFont *sf, OTLookup *otl, int remove_acs);

extern struct lookup_subtable *SFFindLookupSubtable(SplineFont *sf,
						    char *name);
extern struct lookup_subtable *SFFindLookupSubtableAndFreeName(SplineFont *
							       sf,
							       char *name);
extern OTLookup *SFFindLookup(SplineFont *sf, char *name);

extern void NameOTLookup(OTLookup *otl, SplineFont *sf);

extern void FListAppendScriptLang(FeatureScriptLangList *fl,
				  uint32_t script_tag, uint32_t lang_tag);
extern void FListsAppendScriptLang(FeatureScriptLangList *fl,
				   uint32_t script_tag, uint32_t lang_tag);
struct scriptlanglist *SLCopy(struct scriptlanglist *sl);

struct scriptlanglist *SListCopy(struct scriptlanglist *sl);

extern FeatureScriptLangList *FeatureListCopy(FeatureScriptLangList *fl);

extern void SLMerge(FeatureScriptLangList *into, struct scriptlanglist *fsl);

extern void FLMerge(OTLookup *into, OTLookup *from);

extern FeatureScriptLangList *FLOrder(FeatureScriptLangList *fl);

extern int FeatureScriptTagInFeatureScriptList(uint32_t tag, uint32_t script,
					       FeatureScriptLangList *fl);
extern FeatureScriptLangList *FindFeatureTagInFeatureScriptList(uint32_t tag,
								FeatureScriptLangList
								* fl);
extern int FeatureTagInFeatureScriptList(uint32_t tag,
					 FeatureScriptLangList *fl);
extern int DefaultLangTagInOneScriptList(struct scriptlanglist *sl);

extern struct scriptlanglist *DefaultLangTagInScriptList(struct scriptlanglist
							 *sl, int DFLT_ok);
extern int _FeatureOrderId(int isgpos, uint32_t tag);

extern int FeatureOrderId(int isgpos, FeatureScriptLangList *fl);

extern void SFSubTablesMerge(SplineFont *_sf,
			     struct lookup_subtable *subfirst,
			     struct lookup_subtable *subsecond);
extern struct lookup_subtable *SFSubTableFindOrMake(SplineFont *sf,
						    uint32_t tag, uint32_t script,
						    int lookup_type);
extern struct opentype_str *ApplyTickedFeatures(SplineFont *sf,
						uint32_t *flist, uint32_t script,
						uint32_t lang, int pixelsize,
						SplineChar ** glyphs);

extern void SFGlyphRenameFixup(SplineFont *sf, char *old, char *new,
			       int rename_related_glyphs);

extern void SplinePointRound(SplinePoint *, double);

extern int KCFindName(char *name, char **classnames, int cnt,
		      int allow_class0);

extern void SCClearRounds(SplineChar *sc, int layer);

extern void SCSynchronizeWidth(SplineChar *sc, double newwidth, double oldwidth,
			       struct fontviewbase *fv);
extern RefChar *HasUseMyMetrics(SplineChar *sc, int layer);

extern void SCSynchronizeLBearing(SplineChar *sc, double off, int layer);

extern void SFUntickAll(SplineFont *sf);

extern void SCImportSVG(SplineChar *sc, int layer, char *path, char *memory,
			int memlen, int doclear);

extern void SCImportGlif(SplineChar *sc, int layer, char *path, char *memory,
			 int memlen, int doclear);
extern void SCImportPS(SplineChar *sc, int layer, char *path, int doclear,
		       int flags);
extern void SCImportPSFile(SplineChar *sc, int layer, AFILE *ps, int doclear,
			   int flags);
extern void SCImportPDF(SplineChar *sc, int layer, char *path, int doclear,
			int flags);
extern void SCImportPDFFile(SplineChar *sc, int layer, AFILE *ps,
			    int doclear, int flags);
extern void SCAddScaleImage(SplineChar *sc, struct gimage *image,
			    int doclear, int layer);
extern void SCInsertImage(SplineChar *sc, struct gimage *image, double scale,
			  double yoff, double xoff, int layer);

extern int _ExportPlate(AFILE *pdf, SplineChar *sc, int layer);

extern int _ExportPDF(AFILE *pdf, SplineChar *sc, int layer);

extern int _ExportEPS(AFILE *eps, SplineChar *sc, int layer,
		      int gen_preview);
extern int _ExportSVG(AFILE *svg, SplineChar *sc, int layer);

extern int _ExportGlif(AFILE *glif, SplineChar *sc, int layer);

extern void ScriptExport(SplineFont *sf, BDFFont *bdf, int format, int gid,
			 char *format_spec, EncMap *map);

extern EncMap *EncMapFromEncoding(SplineFont *sf, Encoding *enc);

extern void SFRemoveGlyph(SplineFont *sf, SplineChar *sc, int *flags);

extern void SFAddEncodingSlot(SplineFont *sf, int gid);

extern void SFAddGlyphAndEncode(SplineFont *sf, SplineChar *sc,
				EncMap *basemap, int baseenc);

extern void SCClearBackground(SplineChar *sc);

extern void BackgroundImageTransform(SplineChar *sc, ImageList *img,
				     double transform[6]);

extern void SCClearLayer(SplineChar *sc, int layer);

extern void SCClearContents(SplineChar *sc, int layer);

extern void SCClearAll(SplineChar *sc, int layer);

extern void BCClearAll(BDFChar *bc);

extern void InitSimpleStuff(void);

extern int MSLanguageFromLocale(void);

extern struct math_constants_descriptor {
   char *ui_name;
   char *script_name;
   int offset;
   int devtab_offset;
   char *message;
   int new_page;
} math_constants_descriptor[];

#   define MATH_CONSTANTS_DESCRIPTOR_EMPTY { NULL, NULL, 0, 0, NULL, 0 }

extern const char *knownweights[], *realweights[], **noticeweights[];

extern int BPTooFar(BasePoint *bp1, BasePoint *bp2);

extern StemInfo *SCHintOverlapInMask(SplineChar *sc, HintMask *hm);

extern int SCValidate(SplineChar *sc, int layer, int force);

extern AnchorClass *SCValidateAnchors(SplineChar *sc);

extern void SCTickValidationState(SplineChar *sc, int layer);

extern int ValidatePrivate(SplineFont *sf);

extern int SFValidate(SplineFont *sf, int layer, int force);

extern int hasspiro(void);

extern SplineSet *SpiroCP2SplineSet(spiro_cp *spiros);

extern spiro_cp *SplineSet2SpiroCP(SplineSet *ss, uint16_t *_cnt);

extern void SSRegenerateFromSpiros(SplineSet *spl);

struct lang_frequencies;

extern int SSHasClip(SplineSet *ss);

extern int SSHasDrawn(SplineSet *ss);

extern void GradientFree(struct gradient *grad);

extern struct gradient *GradientCopy(struct gradient *old,double transform[6]);

extern void PatternFree(struct pattern *pat);

extern void BrushCopy(struct brush *into, struct brush *from,
		      double transform[6]);
extern void PenCopy(struct pen *into, struct pen *from, double transform[6]);

extern void PatternSCBounds(SplineChar *sc, DBounds *b);

extern void SCClearInstrsOrMark(SplineChar *sc, int layer, int complain);

extern void TTFPointMatches(SplineChar *sc, int layer, int top);

extern double SFCapHeight(SplineFont *sf, int layer, int return_error);

extern double SFXHeight(SplineFont *sf, int layer, int return_error);

extern double SFAscender(SplineFont *sf, int layer, int return_error);

extern double SFDescender(SplineFont *sf, int layer, int return_error);

/*
 * Visitor for SPLFirstVisitSplines()
 */
typedef void (*SPLFirstVisitSplinesVisitor) (SplinePoint * splfirst,
					     Spline *s, void *udata);

/*
 * Given a SplinePointList* that you want to visit each spline in the
 * iteration is not as simple as it could be, so you can call this
 * function passing spl->first as 'splfirst' and a visitor function
 * which will see each spline in the splfirst colleciton.
 *
 * For debug, you can pass SPLFirstVisitorDebug which will print
 * information for each item in the splfirst collection.
 *
 * You can pass any arbitrary data in as udata and SPLFirstVisit()
 * will pass that udata to your visitor function without change. If
 * you want a return value from your visitor, pass a pointer to a
 * struct as udata. eg:
 *
 * typedef struct SPLFirstVisitorFoundSoughtDataS
 * {
 *    SplinePoint* sought;
 *    int found;
 * } SPLFirstVisitorFoundSoughtData;
 *
 * // ...
 *
 *	SPLFirstVisitorFoundSoughtData d;
 *	d.sought=sought;
 *	d.found=0;
 *	SPLFirstVisit( spl->first, SPLFirstVisitorFoundSought, &d );
 *	if( d.found )
 *           return 1;
 *
 */
extern void SPLFirstVisitSplines(SplinePoint * splfirst,
				 SPLFirstVisitSplinesVisitor f, void *udata);

/*
 * Applies a visitor to the container and returns false if no point in the SPL
 * has an x coordinate of 'x'.
 */
extern SplinePoint *SplinePointListContainsPointAtX(SplinePointList *
						    container, double x);

#endif
