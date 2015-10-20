/* $Id: views.h 4285 2015-10-20 09:10:39Z mskala $ */
/* Copyright (C) 2000-2012  George Williams
 * Copyright (C) 2015  Matthew Skala
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
#ifndef _VIEWS_H
#   define _VIEWS_H

#   include "ffglib.h"
#   include "baseviews.h"

#include "gimage.h"

struct gfi_data;

struct contextchaindlg;

struct statemachinedlg;


extern struct cvshows {
   int showfore, showback, showgrids, showhhints, showvhints, showdhints;
   int showpoints, showfilled;
   int showrulers;
   int showrounds;		/* 0=>no, 1=>auto, 2=>always */
   int showmdx, showmdy;	/* minimum distances x,y */
   int showhmetrics, showvmetrics;	/* show advance width, baseline, etc. */
   int markextrema;
   int markpoi;			/* Points of inflection */
   int showblues, showfamilyblues;
   int showanchor;
   int showcpinfo;
   int showtabs;		/* with the names of former glyphs */
   int showsidebearings;
   int showrefnames;
   int snapoutlines;
   int showalmosthvlines;
   int showalmosthvcurves;
   int hvoffset;
   int checkselfintersects;	/* Not really something shown, but convenient to keep it here */
   int showdebugchanges;	/* Changes the way changing rasters are displayed in tt debug mode */
   int alwaysshowcontrolpoints;	//< Always show the BCP even when their splinepoint is not selected
} CVShows;

extern struct bvshows {
   int showfore, showoutline, showgrid;
   int lastpixelsize;
} BVShows;

enum debug_wins { dw_registers=0x1, dw_stack=0x2, dw_storage =
      0x4, dw_points=0x8,
   dw_cvt=0x10, dw_raster=0x20, dw_gloss=0x40
};


struct instrinfo {
   int isel_pos;
   int16_t lheight, lpos;
   char *scroll, *offset;
   int16_t sbw;
   int16_t vheight, vwidth;
   int16_t lstopped;
   int16_t as, fh;
   struct instrdata *instrdata;
   unsigned int showaddr:1;
   unsigned int showhex:1;
   unsigned int mousedown:1;
   void *userdata;
   void (*selection_callback) (struct instrinfo *, int ip);
   int (*bpcheck) (struct instrinfo *, int ip);
};


struct reflist {
   RefChar *ref;
   struct reflist *parent;
};

enum dv_coderange { cr_none=0, cr_fpgm, cr_prep, cr_glyph };	/* cleverly chosen to match ttobjs.h */

struct freehand {
   struct tracedata *head, *last;	/* for the freehand tool */
   SplinePointList *current_trace;
   int ignore_wobble;		/* Ignore wiggles smaller than this */
   int skip_cnt;
};

enum expandedge { ee_none, ee_nw, ee_up, ee_ne, ee_right, ee_se, ee_down,
   ee_sw, ee_left, ee_max
};

enum { charviewtab_charselectedsz=1024 };

typedef struct charviewtab {
   char charselected[charviewtab_charselectedsz + 1];
   char tablabeltxt[charviewtab_charselectedsz + 1];
} CharViewTab;

enum { charview_cvtabssz=100 };


typedef struct charview {
   CharViewBase b;
   uint32_t showback[265 / 32];
   unsigned int showfore:1;
   unsigned int showgrids:1;
   unsigned int showhhints:1;
   unsigned int showvhints:1;
   unsigned int showdhints:1;
   unsigned int showpoints:1;
   unsigned int alwaysshowcontrolpoints:1;
   unsigned int showfilled:1;
   unsigned int showrulers:1;
   unsigned int showrounds:2;	/* 0=>no, 1=>auto, 2=>always */
   unsigned int showmdx:1;
   unsigned int showmdy:1;
   unsigned int showhmetrics:1;
   unsigned int showvmetrics:1;
   unsigned int showblues:1;	/* 16 */
   unsigned int showfamilyblues:1;
   unsigned int showanchor:1;
   unsigned int showpointnumbers:2;
   unsigned int markextrema:1;
   unsigned int markpoi:1;
   unsigned int needsrasterize:1;	/* Rasterization (of fill or fontview) needed on mouse up */
   unsigned int recentchange:1;	/* a change happened in the grids or background. don't need to rasterize */
   unsigned int info_within:1;	/* cursor is within main window */
   unsigned int back_img_out_of_date:1;	/* Force redraw of back image pixmap */
   unsigned int cntrldown:1;
   unsigned int joinvalid:1;
   unsigned int widthsel:1;
   unsigned int vwidthsel:1;
   unsigned int lbearingsel:1;
   unsigned int icsel:1;
   unsigned int tah_sel:1;
   unsigned int inactive:1;	/* When in a search view (32) */
   unsigned int show_ft_results:1;
   unsigned int show_ft_results_live_update:1;
   unsigned int coderange:2;	/* For the debugger */
   unsigned int autonomous_ruler_w:1;
   unsigned int showcpinfo:1;
   unsigned int showtabs:1;
   unsigned int showsidebearings:1;
   unsigned int showing_spiro_pt_menu:1;
   unsigned int ruler_pressed:1;
   unsigned int ruler_pressedv:1;
   unsigned int showrefnames:1;
   unsigned int snapoutlines:1;
   unsigned int showalmosthvlines:1;
   unsigned int showalmosthvcurves:1;
   unsigned int checkselfintersects:1;
   unsigned int showdebugchanges:1;
   unsigned int inPreviewMode:1;
   unsigned int inDraggingComparisonOutline:1;
   unsigned int activeModifierControl:1;	//< Is control being held right now?
   unsigned int activeModifierAlt:1;	//< Is alt being held right now?
   unsigned int changedActiveGlyph:1;	//< Set in CVSwitchActiveSC() cleared in cvmouseup()

   int hvoffset;		/* for showalmosthvlines */
   int layers_off_top;
   real scale;
   unichar_t ruler_linger_lines[40][80];
   int ruler_linger_num_lines;
   int num_ruler_intersections;
   int allocated_ruler_intersections;
   BasePoint *ruler_intersections;
   int start_intersection_snapped;
   int end_intersection_snapped;
   int width, height;
   float xoff, yoff;		/* must be floating point, for precise zoom by scroll */
   int mbh;			//< menu bar height
   int charselectorh;		//< char selection input box height
   int infoh;			//< info bar height
   int rulerh;			//< ruler height
   int16_t sas, sfh, sdh, nas, nfh;
   BasePoint info;
   SplinePoint *info_sp;
   Spline *info_spline;
   real info_t;
   GPoint e;			/* mouse location */
   GPoint olde;
   BasePoint last_c;
   BDFChar *filled;
   GImage gi;			/* used for fill bitmap only */
   int enc;
   EncMap *map_of_enc;		/* Only use for comparison against fontview's map to see if our enc be valid */
   /*  Will not be updated when fontview is reencoded */
   PressedOn p;
   SplinePoint *lastselpt;
   spiro_cp *lastselcp;
   int8_t b1_tool, cb1_tool, b2_tool, cb2_tool;	/* Button 3 does a popup */
   int8_t b1_tool_old;		/* Used by mingw port */
   int8_t s1_tool, s2_tool, er_tool;	/* Bindings for wacom stylus and eraser */
   int8_t showing_tool, pressed_tool, pressed_display, had_control, active_tool;
   int8_t spacebar_hold;		/* spacebar is held down */
   SplinePointList *active_spl;
   SplinePoint *active_sp;
   spiro_cp *active_cp;
   IPoint handscroll_base;
   uint16_t rfh, ras;
   BasePoint lastknife;
   struct freehand freehand;
   enum expandedge expandedge;
   BasePoint expandorigin;
   real expandwidth, expandheight;
   SplinePointList *active_shape;
   SplinePoint joinpos;
   spiro_cp joincp;
   SplineChar *template1, *template2;
#   if HANYANG
   struct jamodisplay *jamodisplay;
#   endif
   real oldwidth, oldvwidth;
   real oldlbearing;
   int16_t oldic, oldtah;
#   if _ModKeysAutoRepeat
   GTimer *autorpt;
   int keysym, oldstate;
   int oldkeyx, oldkeyy;
#   endif
   PST *lcarets;
   int16_t nearcaret;
   /* freetype results display */
   int16_t ft_dpi, ft_ppemy, ft_ppemx, ft_depth;
   real ft_pointsizey, ft_pointsizex;
   struct freetype_raster *raster, *oldraster;
   uint32_t mmvisible;
   char *former_names[10];
   int former_cnt;
   AnchorPoint *apmine, *apmatch;
   SplineChar *apsc;
   int guide_pos;
   struct qg_data *qg;
   int16_t note_x, note_y;
   struct dlistnode *pointInfoDialogs;
   int charselectoridx;
   SplineChar *additionalCharsToShow[51];	//<  additionalCharsToShowLimit + 1 in size
   int additionalCharsToShowActiveIndex;

   CharViewTab cvtabs[charview_cvtabssz + 1];
   int oldtabnum;

} CharView;

typedef struct bitmapview {
   BDFChar *bc;
   BDFFont *bdf;
   struct fontview *fv;
   EncMap *map_of_enc;
   int enc;
   int xoff, yoff;
   int width, height;
   int infoh, mbh;
   int scale;
   real scscale;
   struct bitmapview *next;
   unsigned int showfore:1;
   unsigned int showoutline:1;
   unsigned int showgrid:1;
   unsigned int cntrldown:1;
   unsigned int recentchange:1;
   unsigned int clearing:1;
   unsigned int shades_hidden:1;
   unsigned int shades_down:1;
   int8_t b1_tool, cb1_tool, b2_tool, cb2_tool;	/* Button 3 does a popup */
   int8_t s1_tool, s2_tool, er_tool;	/* Bindings for wacom stylus and eraser */
   int8_t showing_tool, pressed_tool, pressed_display, had_control, active_tool;
   int pressed_x, pressed_y;
   int info_x, info_y;
   int event_x, event_y;
   int16_t sas, sfh;
#   if _ModKeysAutoRepeat
   GTimer *autorpt;
   int keysym, oldstate;
#   endif
   int color;			/* for greyscale fonts (between 0,255) */
   int color_under_cursor;
} BitmapView;

struct aplist {
   AnchorPoint *ap;
   int connected_to, selected;
   struct aplist *next;
};

enum mv_grids { mv_hidegrid, mv_showgrid, mv_partialgrid, mv_hidemovinggrid };
enum mv_type { mv_kernonly, mv_widthonly, mv_kernwidth };

struct metricchar {
   int16_t dx, dwidth;		/* position and width of the displayed char */
   int16_t dy, dheight;		/*  displayed info for vertical metrics */
   int xoff, yoff;
   int16_t mx, mwidth;		/* position and width of the text underneath */
   int16_t kernafter;
   unsigned int selected:1;
};

typedef struct metricsview {
   struct fontview *fv;
   SplineFont *sf;
   int pixelsize;		/* If the user has manually requested a pixelsize */
   /*  then rasterize at that size no matter how large */
   /*  the font is zoomed. For non-user requesed sizes */
   /*  this is the pixelsize * zoom-factor */
   BDFFont *bdf;		/* We can also see metric info on a bitmap font */
   BDFFont *show;		/*  Or the rasterized version of the outline font */
   int16_t xstart;
   int16_t width, height, dwidth;
   int16_t vwidth, vheight;
   int16_t mbh, sbh;
   int16_t topend;		/* y value of the end of the region containing the text field */
   int16_t displayend;		/* y value of the end of the region showing filled characters */
   int16_t fh, as;
   int16_t cmax, clen;
   SplineChar **chars;		/* Character input stream */
   struct opentype_str *glyphs;	/* after going through the various gsub/gpos transformations */
   struct metricchar *perchar;	/* One for each glyph above */
   SplineChar **sstr;		/* Character input stream */
   int16_t mwidth, mbase;
   int16_t glyphcnt, max;
   int16_t pressed_x, pressed_y;
   int16_t activeoff;
   int xoff, coff, yoff;
   struct metricsview *next;
   unsigned int right_to_left:1;
   unsigned int pressed:1;
   unsigned int pressedwidth:1;
   unsigned int pressedkern:1;
   unsigned int showgrid:2;
   unsigned int antialias:1;
   unsigned int vertical:1;
   unsigned int type:2;		/* enum mv_type */
   unsigned int usehinting:1;	/* should the hints be used during the render */
   unsigned int pixelsize_set_by_window;
   int xp, yp, ap_owner;
   BasePoint ap_start;
   int cursor;
   int scale_index;
   struct lookup_subtable *cur_subtable;
   int word_index;
   int layer;
   int fake_unicode_base;
   int ptsize, dpi;
   int ybaseline;
   int oldscript, oldlang;
} MetricsView;

enum fv_metrics { fvm_baseline=1, fvm_origin=2, fvm_advanceat =
      4, fvm_advanceto=8 };
typedef struct fontview {
   FontViewBase b;
   BDFFont *show, *filled;
   int width, height;		/* of v */
   int16_t infoh, mbh;
   int16_t lab_height, lab_as;
   int16_t colcnt, rowcnt;	/* of display window */
   int32_t rowoff, rowltot;	/* Can be really big in full unicode */
   int16_t cbw, cbh;		/* width/height of a character box */
   int pressed_pos, end_pos;
   unsigned int antialias:1;
   unsigned int bbsized:1;	/* displayed bitmap should be scaled by bounding box rather than emsize */
   unsigned int wasonlybitmaps:1;
   /*unsigned int refstate: 3; *//* 0x1 => paste orig of all non exist refs, 0x2=>don't, 0x3 => don't warn about non-exist refs with no source font */
   unsigned int touched:1;
   unsigned int showhmetrics:4;
   unsigned int showvmetrics:4;
   unsigned int drag_and_drop:1;
   unsigned int has_dd_no_cursor:1;
   unsigned int any_dd_events_sent:1;
   unsigned int resize_expected:1;
   /* Some window managers do not honour my resize requests (if window is */
   /*  maximized for example), but we depend on the resize request to    */
   /*  fix up the window. We do get a configure notify, but the window   */
   /*  stays the same size, so kludge things */
   unsigned int glyphlabel:2;
   unsigned int notactive:1;	/* When embedded in a dlg */
   int16_t magnify;
   int16_t user_requested_magnify;
   struct searchview *sv;
   SplineChar *sc_near_top;
   int sel_index;
   struct lookup_subtable *cur_subtable;
   struct qg_data *qg;
   GPid pid_webfontserver;
} FontView;

typedef struct findsel {
   real fudge;			/* One pixel fudge factor */
   real xl, xh, yl, yh;		/* One pixel fudge factor */
   real c_xl, c_xh, c_yl, c_yh;	/* fudge rectangle for control points, larger than above if alt is depressed */
   unsigned int select_controls:1;	/* notice control points */
   unsigned int seek_controls:1;	/* notice control points before base points */
   unsigned int all_controls:1;	/* notice control points even if the base points aren't selected (in truetype point numbering mode where all cps are visible) */
   unsigned int alwaysshowcontrolpoints:1;	/* if the BCP are forced on, then we want the selection code paths
						 * to also know that so the user can drag the BCP of a non selected splinepoint */
   real scale;
   PressedOn *p;
} FindSel;

typedef struct searchview {
   struct cvcontainer base;
   FontView dummy_fv;
   SplineFont dummy_sf;
   LayerInfo layerinfo[2];
   SplineChar *chars[2];
   EncMap dummy_map;
   int32_t map[2], backmap[2];
   uint8_t sel[2];
   CharView cv_srch, cv_rpl;
   CharView *lastcv;
/* ****** */
   int mbh;
   int fh, as;
   int rpl_x, cv_y;
   int cv_width, cv_height;
   short button_height, button_width;
/* ****** */
   SearchData sd;
   unsigned int showsfindnext:1;
   unsigned int findenabled:1;
   unsigned int rplallenabled:1;
   unsigned int rplenabled:1;
   unsigned int isvisible:1;
} SearchView;

typedef struct mathkernview {
   struct cvcontainer base;
   FontView dummy_fv;
   SplineFont dummy_sf;
   LayerInfo layerinfo[2];
   SplineChar sc_topright, sc_topleft, sc_bottomright, sc_bottomleft;
   SplineChar *chars[4];
   EncMap dummy_map;
   int32_t map[4], backmap[4];
   uint8_t sel[4];
   CharView cv_topright, cv_topleft, cv_bottomright, cv_bottomleft;
   CharView *lastcv;
/* ****** */
   int mbh;
   int fh, as;
   int mid_space, cv_y;
   int cv_width, cv_height;
   short button_height, button_width;
/* ****** */
   SplineChar *cursc;
   int def_layer;
   struct mathkern *orig_mathkern;
   uint8_t saved_mathkern;	/* Can't just check if orig is non-NULL, because NULL is a perfectly valid initial state */
   uint8_t last_aspect;
   uint8_t done;
} MathKernDlg;

struct lksubinfo {
   struct lookup_subtable *subtable;
   unsigned int deleted:1;
   unsigned int new:1;
   unsigned int selected:1;
   unsigned int moved:1;
};

struct lkinfo {
   OTLookup *lookup;
   unsigned int open:1;
   unsigned int deleted:1;
   unsigned int new:1;
   unsigned int selected:1;
   unsigned int moved:1;
   int16_t subtable_cnt, subtable_max;
   struct lksubinfo *subtables;
};

struct lkdata {
   int cnt, max;
   int off_top, off_left;
   struct lkinfo *all;
};

struct anchor_shows {
   CharView *cv;
   SplineChar *sc;
   int restart;
};

struct gfi_data {		/* FontInfo */
   SplineFont *sf;
   int def_layer;
   int tn_active;
   int private_aspect, ttfv_aspect, tn_aspect, tx_aspect, unicode_aspect;
   int old_sel, old_aspect, old_lang, old_strid;
   int ttf_set, names_set, tex_set;
   int langlocalecode;		/* MS code for the current locale */
   unsigned int family_untitled:1;
   unsigned int human_untitled:1;
   unsigned int done:1;
   unsigned int mpdone:1;
   unsigned int lk_drag_and_drop:1;
   unsigned int lk_dropablecursor:1;
   struct anchor_shows anchor_shows[2];
   struct texdata texdata;
   int as, fh;
   struct lkdata tables[2];
   int lkwidth, lkheight;
   int first_sel_lookup, first_sel_subtable;
   int last_panose_family;
};

enum genfam { gf_none, gf_macfamily, gf_ttc };

extern int WritePfmFile(char *filename, SplineFont *sf, int type0,
			EncMap * map);

#endif /* _VIEWS_H */
