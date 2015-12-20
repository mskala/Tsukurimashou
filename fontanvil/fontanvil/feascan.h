/*
 * Definitions for the feature file tokenizer
 * Copyright (C) 2015  Matthew Skala
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Matthew Skala
 * http://ansuz.sooke.bc.ca/
 * mskala@ansuz.sooke.bc.ca
 */

enum toktype { tk_name, tk_class, tk_int, tk_char, tk_cid, tk_eof,
     /* keywords */
        tk_firstkey,
        tk_anchor =
           tk_firstkey, tk_anonymous, tk_by, tk_caret, tk_cursive, tk_device,
        tk_enumerate, tk_excludeDFLT, tk_exclude_dflt, tk_feature, tk_from,
        tk_ignore, tk_ignoreDFLT, tk_ignoredflt, tk_IgnoreBaseGlyphs,
        tk_IgnoreLigatures, tk_IgnoreMarks, tk_include, tk_includeDFLT,
        tk_include_dflt, tk_language, tk_languagesystem, tk_lookup,
        tk_lookupflag, tk_mark, tk_nameid, tk_NULL, tk_parameters, tk_position,
        tk_required, tk_RightToLeft, tk_script, tk_substitute, tk_subtable,
        tk_table, tk_useExtension,
     /* Additional keywords in the 2008 draft */
        tk_anchorDef, tk_valueRecordDef, tk_contourpoint,
        tk_MarkAttachmentType, tk_UseMarkFilteringSet,
        tk_markClass, tk_reversesub, tk_base, tk_ligature, tk_ligComponent,
        tk_featureNames
};

typedef enum _TOKENIZER_MODE {
   tm_generic,tm_nokw,tm_hexint,tm_tenths,tm_string
} TOKENIZER_MODE;

struct glyphclasses {
      char *classname, *glyphs;
      struct glyphclasses *next;
};

struct namedanchor {
      char *name;
      AnchorPoint *ap;
      struct namedanchor *next;
};

struct namedvalue {
      char *name;
      struct vr *vr;
      struct namedvalue *next;
};

struct gdef_mark {
      char *name;
      int index;
      char *glyphs;
};

/* GPOS mark classes may have multiple definitions each added a glyph
 * class and anchor, these are linked under "same" */
struct gpos_mark {
      char *name;
      char *glyphs;
      AnchorPoint *ap;
      struct gpos_mark *same, *next;
      int name_used; /* Same "markClass" can be used in any mark type lookup,
		      * or indeed in multiple lookups of the same type */
};

#define MAXT    80
#define MAXI    5

struct parseState {
   char tokbuf[MAXT+1];
   long value;
   enum toktype type;
   uint32_t tag;
   int could_be_tag;
   AFILE *inlist[MAXI];
   int inc_depth;
   int line[MAXI];
   char *filename[MAXI];
   int err_count;
   unsigned int warned_about_not_cid:1;
   unsigned int lookup_in_sf_warned:1;
   unsigned int in_vkrn:1;
   unsigned int backedup:1;
   unsigned int skipping:1;
   SplineFont *sf;
   struct scriptlanglist *def_langsyses;
   struct glyphclasses *classes;
   struct namedanchor *namedAnchors;
   struct namedvalue *namedValueRs;
   struct feat_item *sofar;
   OTLookup *created,*last; /* Ordered, but not sorted into GSUB, GPOS yet */
   AnchorClass *accreated;
   int gm_cnt[2],gm_max[2],gm_pos[2];
   struct gdef_mark *gdef_mark[2];
   struct gpos_mark *gpos_mark;
   char *nm;
};

void fea_ParseTok(struct parseState *,TOKENIZER_MODE);
