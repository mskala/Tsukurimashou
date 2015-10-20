/* $Id: uiinterface.h 4286 2015-10-20 10:46:56Z mskala $ */
/* Copyright (C) 2007-2012  George Williams
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
#ifndef _UIINTERFACE_H
#   define _UIINTERFACE_H
#   include "fontanvil.h"
#   include <fontanvil-config.h>

/* These next few provide friendly names of various opentype tags */
/*  The ui version will probably be translated, while the non-ui list */
/*  will probably not. The distinction isn't necessary, but is present in ff */
const char *TTFNameIds(int);
const char *MSLangString(int);

struct val;

extern int GetPrefs(char *name,struct val *value);
extern int SetPrefs(char *name,struct val *val1,struct val *val2);
extern char *getFontAnvilShareDir(void);

struct splinechar;

/* The hints of the glyph have changed */
extern void SCHintsChanged(struct splinechar *);

extern void SCCharChangedUpdate(struct splinechar *,int,int);

struct bdfchar;

extern void BCCharChangedUpdate(struct bdfchar *bc);

struct splinefont;
struct fontviewbase;
struct bdffont;

/* Create a new font view. Whatever that may entail */
extern struct fontviewbase *FontViewCreate(struct splinefont *,int hide);

/* Create a new font view but without attaching it to a window */
extern struct fontviewbase *_FontViewCreate(struct splinefont *);

/* Free a font view (we assume all windows have already been destroyed) */
extern void FontViewClose(struct fontviewbase *);

/* Free a font view (we assume all windows have already been destroyed) */
extern void FontViewFree(struct fontviewbase *);

/* Retrieve the window's size in rows and columns */
extern int FVWinInfo(struct fontviewbase *, int *cols, int *rows);

/* Is this font currently open? (It was open once, this check is to make   */
/*  sure the user hasn't closed it since they copied from it -- so we can  */
/*  follow references appropriately if the font we are pasting into doesn't */
/*  have the needed glyph */
extern int SFIsActive(struct splinefont *);

/* Sometimes we just need a fontview, any fontview as a last resort fallback */
extern struct fontviewbase *FontViewFirst(void);

/* Append this fontview to the list of them */
extern struct fontviewbase *FVAppend(struct fontviewbase *);

/* Look through all loaded fontviews and see if any contains a font */
/*  which lives in the given filename */
extern struct splinefont *FontWithThisFilename(const char *);

/* deselect any selected glyphs */
extern void FVDeselectAll(struct fontviewbase *);

extern const char *TTFNameIds(int id);

extern const char *MSLangString(int language);

#  endif
