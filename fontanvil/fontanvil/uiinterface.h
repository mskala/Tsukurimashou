/* $Id: uiinterface.h 3441 2014-11-03 07:49:27Z mskala $ */
/* Copyright (C) 2007-2012 by George Williams */
/*
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
#   include <basics.h>
#   include <fontanvil-config.h>

/* This encapsulates a set of callbacks and stubs. The callbacks get activated*/
/*  when an event happens (a glyph in a font changes for example, then all */
/*  charviews looking at it must be updated), and the stubs provide some simple*/
/*  UI routines: Post an error, etc. */

/* ************************************************************************** */
/* Basic, low-level UI routines for events we discover deep inside script code*/
/* ************************************************************************** */

/* The following is used to post a fontanvil internal error */
/* currently it puts up a dlg displaying the error text */
void IError(const char *fmt, ...);

/* The following is a simple dialog to alert the user that s/he has */
/*  made an error. Currently it posts a modal dlg and waits for the */
/*  user to dismiss it */
/* The title argument is the window's title. The error argument is the */
/*  text of the message. It may contain printf formatting. It may contain */
/*  newlines to force line breaks -- even if it doesn't contain new lines */
/*  the routine will wrap the text if a line is too long */
void ff_post_error(const char *title, const char *error, ...);

/* The following is used to post a warning message in such a way that it */
/*  will not impede the user. Currently it creates a little window at the */
/*  bottom right of the screen and writes successive messages there */
void LogError(const char *fmt, ...);

/* The following is another way to post a warning message in such a way */
/*  that it will not impede the user. Currently it pops up a little */
/*  non-modal dlg which vanishes after a minute or two (or if the user */
/*  dismisses it, of course */
void ff_post_notice(const char *title, const char *statement, ...);

/* Occasionally we we be deep in a non-ui routine and we find we must ask */
/*  the user a question. In this routine the choices are displayed as */
/*  buttons, one button is the default, another is a cancel choice */
int ff_ask(const char *title, const char **answers,
	   int def, int cancel, const char *question, ...);

/* Similar to the above, except here the choices are presented as a */
/*  scrolled list. Return -1 if the user cancels */
int ff_choose(const char *title, const char **answers,
	      int def, int cancel, const char *question, ...);

/* Multiple things can be selected, sel is an in/out parameter, one byte */
/*  per entry in the choice array. 0=> not selected, 1=>selected */
int ff_choose_multiple(char *title, const char **choices, char *sel,
		       int cnt, char *buts[2], const char *question, ...);

/* Here we want a string. We are passed a default answer (or NULL) */
/* The return is NULL on cancel, otherwise a string which must be freed */
char *ff_ask_string(const char *title,
		     const char *def, const char *question, ...);
/* Same as above, except for entering a password */
char *ff_ask_password(const char *title,
		       const char *def, const char *question, ...);

void void_void_noop(void);
void void_int_noop(int useless);
int int_int_noop(int useless);
void void_str_noop(const char *useless);
int alwaystrue(void);

void ff_progress_start_indicator(int delay, const char *title, const char *line1,
			const char *line2, int tot, int stages);

/* pops up a dlg asking user whether to do remove overlap (and other stuff) */
/*  when loading an eps file with strokes, etc. */
int PsStrokeFlagsDlg(void);

/* These next few provide friendly names of various opentype tags */
/*  The ui version will probably be translated, while the non-ui list */
/*  will probably not. The distinction isn't necessary, but is present in ff */
const char *TTFNameIds(int);
const char *MSLangString(int);

#   define ff_ask_password ff_ask_string

struct val;

extern void SavePrefs(void);
extern void LoadPrefs(void);
extern int GetPrefs(char *name,struct val *value);
extern int SetPrefs(char *name,struct val *val1,struct val *val2);
extern char *getFontAnvilShareDir(void);

struct splinechar;
struct layer;

/* The hints of the glyph have changed */
void SCHintsChanged(struct splinechar *);

void SCCharChangedUpdate(struct splinechar *,int,int);

struct bdfchar;

extern void BCCharChangedUpdate(struct bdfchar *bc);

struct otlookup;
struct splinefont;
struct fontviewbase;
struct bdffont;

/* Create a new font view. Whatever that may entail */
struct fontviewbase *FontViewCreate(struct splinefont *, int hide);

/* Create a new font view but without attaching it to a window */
struct fontviewbase *_FontViewCreate(struct splinefont *);

/* Free a font view (we assume all windows have already been destroyed) */
void FontViewClose(struct fontviewbase *);

/* Free a font view (we assume all windows have already been destroyed) */
void FontViewFree(struct fontviewbase *);

/* Retrieve the window's size in rows and columns */
int FVWinInfo(struct fontviewbase *, int *cols, int *rows);

/* Is this font currently open? (It was open once, this check is to make   */
/*  sure the user hasn't closed it since they copied from it -- so we can  */
/*  follow references appropriately if the font we are pasting into doesn't */
/*  have the needed glyph */
int SFIsActive(struct splinefont *);

/* Sometimes we just need a fontview, any fontview as a last resort fallback */
struct fontviewbase *FontViewFirst(void);

/* Append this fontview to the list of them */
struct fontviewbase *FVAppend(struct fontviewbase *);

/* Look through all loaded fontviews and see if any contains a font */
/*  which lives in the given filename */
struct splinefont *FontWithThisFilename(const char *);

/* deselect any selected glyphs */
void FVDeselectAll(struct fontviewbase *);

/* ************************************************************************** */
/*                       Clibboard access (copy/paste)                        */
/* ************************************************************************** */

struct clip_interface {
   /* Announce we own the clipboard selection */
   void (*grab_clip) (void);
   /* Either place data in the clipboard of a given type, or */
   /*  provide a routine to call which will give data on demand */
   /*  (and another routine to clean things up) */
   void (*add_data_type) (const char *type, void *data, int cnt, int size,
			  void *(*gendata) (void *, int32 * len),
			  void (*freedata) (void *));
   /* Does the clipboard contain something of the given type? */
   int (*clip_has_type) (const char *mimetype);
   /* Ask for the clipboard, and waits (and returns) for the response */
   void *(*request_clip) (const char *mimetype, int *len);

};

extern struct clip_interface *clip_interface;

#   define ClipboardGrab		(clip_interface->grab_clip)
#   define ClipboardAddDataType	(clip_interface->add_data_type)
#   define ClipboardRequest	(clip_interface->request_clip)
#   define ClipboardHasType	(clip_interface->clip_has_type)

void FF_SetClipInterface(struct clip_interface *clipi);

extern const char *TTFNameIds(int id);

extern const char *MSLangString(int language);

#  endif
