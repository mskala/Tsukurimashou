/* $Id: fontanvil.h 3880 2015-03-28 11:27:22Z mskala $ */
/*
 * Global header for FontAnvil
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

/* Place nothing here that doesn't need to be global! */

/* Place everything here that DOES need to be global! */

#ifndef _FONTANVIL_H
#define _FONTANVIL_H

/* Autotools-generated config, must be global so all parts see it the same */
#include "fontanvil-config.h"

/* global data types */
# include "_stdint.h"
# define true 1
# define false 0
typedef uint32_t unichar_t;

/* this is a wart and should be removed */
extern void NoMoreMemMessage(void);

/* this should be moved elsewhere */
#ifndef HAVE_ISFINITE
#define isfinite finite
#endif

/* need AFILE globally to unify error reporting */
#include "afile.h"

/**********************************************************************/

/* random nonsense from PfaEdit... should go elsewhere */

#   include <fontanvil-config.h>
#   include "configure-fontanvil.h"
#   include "fontanvil.h"
#   include <stdio.h>
#   include <string.h>
#   include <intl.h>
#   include "splinefont.h"
#   include "uiinterface.h"

static const int unicode4_size=17 *65536;
    /* Unicode goes up to 0x10ffff */

extern char *AdobeStandardEncoding[256];
extern int32_t unicode_from_adobestd[256];

/* unicode_nameannot - Deprecated, but kept for older programs to access. */
#   if _NO_LIBUNINAMESLIST
struct unicode_nameannot {
   const char *name, *annot;
};
#   endif

extern const struct unicode_nameannot *const *const *_UnicodeNameAnnot;

extern int default_fv_font_size;
extern int default_fv_antialias;
extern int default_fv_bbsized;

extern Encoding *default_encoding, custom;

extern int adjustwidth;
extern int adjustlbearing;
extern int autohint_before_generate;
extern uint32_t default_background;
extern int new_em_size;
extern int new_fonts_are_order2;
extern int loaded_fonts_same_as_new;

extern char *BDFFoundry, *TTFFoundry;
extern char *xuid;

extern int pagewidth, pageheight, printtype;	/* Printer defaults */
extern char *printcommand, *printlazyprinter;

#   define SCRIPT_MENU_MAX	10

extern MacFeat *default_mac_feature_map;

#endif /* ndef _FONTANVIL_H */

