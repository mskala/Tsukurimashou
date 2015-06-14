## Process this file with automake to produce Makefile.in

#
# Makefile for FontAnvil
# Copyright (C) 2014, 2015  Matthew Skala
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Matthew Skala
# http://ansuz.sooke.bc.ca/
# mskala@ansuz.sooke.bc.ca
#

############################################################################

# BASIC AUTOTOOLS STUFF

ACLOCAL_AMFLAGS = -I m4
@SET_MAKE@
@INC_AMINCLUDE@

mvp:=$(if $(VPATH),$(VPATH),.)

empty:=
space:=$(empty) $(empty)
comma:=,
percent=%

SHELL=$(if $(wildcard @KLEKNEV@),@KLEKNEV@,$(if \
  $(wildcard /bin/bash),/bin/bash,/bin/sh))

############################################################################

# SILENT BUILD BLINKENLIGHTS

TSU_V_REDIR=$(if $(AM_V_at),>& /dev/null)

if COND_COLOUR
  escchar:=$(strip $(shell echo x | tr 'x' '\033'))
  ECHO_ANSI=echo
  ansi_default=$(escchar)[0m
  ansi_red=$(escchar)[31m
  ansi_green=$(escchar)[32m
  ansi_yellow=$(escchar)[33m
  ansi_blue=$(escchar)[34m
  ansi_magenta=$(escchar)[35m
  ansi_cyan=$(escchar)[36m
  ansi_pink=$(escchar)[35;1m
  ansi_white=$(escchar)[37;1m
  ansi_cleareol=$(escchar)[K
  ansi_clearescaped=\033\[K
  ansi_home=$(escchar)[1G
  am__@andt@v_CC_0=@echo "$(ansi_default)$(ansi_cleareol)  CC    " $@;
  am__@andt@v_CCLD_0=@echo "$(ansi_default)$(ansi_cleareol)  CCLD  " $@;
  am__@andt@v_GEN_0=@echo "$(ansi_default)$(ansi_cleareol)  GEN   " $@;
else
  ECHO_ANSI=echo
  ansi_default=
  ansi_red=
  ansi_green=
  ansi_yellow=
  ansi_blue=
  ansi_magenta=
  ansi_cyan=
  ansi_pink=
  ansi_white=
  ansi_cleareol=
  ansi_clearescaped=
  ansi_home=
endif

TSU_V_MAKE=$(TSU_V_MAKE_$(V))
TSU_V_MAKE_=$(TSU_V_MAKE_$(AM_DEFAULT_VERBOSITY))
TSU_V_MAKE_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_white)MAKE$(ansi_default)  " $@;

TSU_V_TEX=$(TSU_V_TEX_$(V))
TSU_V_TEX_=$(TSU_V_TEX_$(AM_DEFAULT_VERBOSITY))
TSU_V_TEX_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_green)TEX$(ansi_default)   " $@;

TSU_V_TEXL=$(TSU_V_TEXL_$(V))
TSU_V_TEXL_=$(TSU_V_TEXL_$(AM_DEFAULT_VERBOSITY))
TSU_V_TEXL_0=$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_green)TEX$(ansi_default)   " "$@($$I)";

############################################################################

# CONDITIONAL OPTIONS

# none coded yet

############################################################################

# FILENAMES FOR AUTOTOOLS

AM_CPPFLAGS = "-I$(top_builddir)/inc" "-I$(top_srcdir)/inc" \
  "-I$(top_srcdir)/fontanvil" "-DSHAREDIR=\"${MY_SHAREDIR}\"" \
  "-DDOCDIR=\"${MY_DOCDIR}\"" \
  $(FREETYPE_CFLAGS) $(GIFLIB_CFLAGS) $(GLIB_CFLAGS) $(LIBPNG_CFLAGS) \
  $(LIBTIFF_CFLAGS) $(ZLIB_CFLAGS)
AM_LDFLAGS = \
  $(FREETYPE_LIBS) $(GIFLIB_CFLAGS) $(GLIB_LIBS) $(LIBPNG_LIBS) \
  $(LIBTIFF_LIBS) $(ZLIB_LIBS)

# needed to work around an Automake macro bug
# see http://permalink.gmane.org/gmane.comp.sysutils.autoconf.archive-maintainers/626
BUILT_SOURCES = Makefile

bin_PROGRAMS = fontanvil/fontanvil

nodist_bin_SCRIPTS = \
  fontanvil/fontimage fontanvil/fontlint fontanvil/sfddiff
dist_man_MANS = \
  fontanvil/fontanvil.1 fontanvil/fontimage.1 fontanvil/fontlint.1 \
  fontanvil/sfddiff.1

noinst_HEADERS = \
  inc/fontanvil.h \
  inc/chardata.h inc/charset.h inc/dynamic.h inc/fileutil.h \
  inc/fontanvil-config.h inc/gdraw.h inc/gfile.h inc/ggadget.h \
  inc/gimage.h inc/gio.h \
  inc/gresource.h inc/gwidget.h inc/intl.h inc/ustring.h \
  inc/utype.h \
  inc/afile.h inc/sftextfieldP.h \
  inc/views.h inc/is_LIGATURE.h \
  inc/flaglist.h inc/charview_private.h \
  inc/autowidth2.h inc/fontanvil.h \
  inc/libffstamp.h inc/psfont.h inc/stemdb.h \
  inc/autowidth.h inc/delta.h inc/fontanvilvw.h \
  inc/lookups.h inc/savefont.h inc/ttf.h \
  inc/baseviews.h inc/fvmetrics.h inc/mm.h \
  inc/scriptfuncs.h inc/ttfinstrs.h inc/edgelist2.h \
  inc/namehash.h inc/scripting.h inc/uiinterface.h \
  inc/bezctx_ff.h inc/edgelist.h \
  inc/nonlineartrans.h inc/sd.h inc/unicoderange.h \
  inc/bitmapcontrol.h inc/encoding.h \
  inc/search.h inc/usermenu.h inc/fffreetype.h \
  inc/PfEd.h inc/sfd1.h \
  inc/sflayoutP.h inc/print.h inc/splinefont.h \
  inc/cvruler.h inc/ffglib.h inc/gb12345.h

noinst_LIBRARIES = \
  Unicode/libgunicode.a \
  gutils/libgutils.a

fontanvil_fontanvil_SOURCES = \
 fontanvil/main.c \
 fontanvil/afile.c fontanvil/asmfpst.c fontanvil/autohint.c \
 fontanvil/autotrace.c fontanvil/autowidth.c fontanvil/autowidth2.c \
 fontanvil/bezctx_ff.c fontanvil/bitmapchar.c fontanvil/bitmapcontrol.c \
 fontanvil/bvedit.c fontanvil/crctab.c \
 fontanvil/cvexport.c fontanvil/cvimages.c fontanvil/cvundoes.c \
 fontanvil/dumpbdf.c fontanvil/dumppfa.c fontanvil/effects.c \
 fontanvil/encoding.c fontanvil/featurefile.c fontanvil/flaglist.c \
 fontanvil/fontviewbase.c fontanvil/freetype.c fontanvil/fvcomposite.c \
 fontanvil/fvfonts.c fontanvil/fvimportbdf.c fontanvil/fvmetrics.c \
 fontanvil/glyphcomp.c \
 fontanvil/http.c fontanvil/ikarus.c fontanvil/is_LIGATURE.c \
 fontanvil/lookups.c fontanvil/macbinary.c \
 fontanvil/macenc.c fontanvil/mathconstants.c fontanvil/mm.c \
 fontanvil/namelist.c fontanvil/nonlineartrans.c fontanvil/noprefs.c \
 fontanvil/nowakowskittfinstr.c \
 fontanvil/othersubrs.c fontanvil/palmfonts.c fontanvil/parsepdf.c \
 fontanvil/parsepfa.c fontanvil/parsettfatt.c fontanvil/parsettfbmf.c \
 fontanvil/parsettf.c fontanvil/parsettfvar.c fontanvil/print.c \
 fontanvil/psread.c fontanvil/pua.c fontanvil/python.c fontanvil/savefont.c \
 fontanvil/scripting.c fontanvil/scstyles.c fontanvil/search.c \
 fontanvil/sfd1.c fontanvil/sfd.c fontanvil/sflayout.c inc/sfundo.h \
 fontanvil/spiro.c fontanvil/splinechar.c fontanvil/splinefill.c \
 fontanvil/splinefont.c fontanvil/splineorder2.c fontanvil/splineoverlap.c \
 fontanvil/splinesaveafm.c fontanvil/splinesave.c fontanvil/splinestroke.c \
 fontanvil/splineutil2.c fontanvil/splineutil.c \
 fontanvil/start.c fontanvil/stemdb.c fontanvil/svg.c \
 fontanvil/tottfaat.c fontanvil/tottfgpos.c fontanvil/tottf.c \
 fontanvil/tottfvar.c fontanvil/ttfinstrs.c fontanvil/ttfspecial.c \
 fontanvil/ufo.c fontanvil/unicoderange.c fontanvil/utils.c \
 fontanvil/winfonts.c fontanvil/woff.c fontanvil/zapfnomen.c \
 fontanvil/splinerefigure.c fontanvil/gb12345.c

fontanvil_fontanvil_LDADD = $(top_builddir)/Unicode/libgunicode.a \
	$(top_builddir)/gutils/libgutils.a

Unicode_libgunicode_a_SOURCES = \
  Unicode/charset/alphabet.c Unicode/charset/big5.c \
  Unicode/charset/big5hkscs.c Unicode/charset/gb2312.c \
  Unicode/charset/iso_8859_10.c Unicode/charset/iso_8859_11.c \
  Unicode/charset/iso_8859_13.c Unicode/charset/iso_8859_14.c \
  Unicode/charset/iso_8859_15.c Unicode/charset/iso_8859_1.c \
  Unicode/charset/iso_8859_2.c Unicode/charset/iso_8859_3.c \
  Unicode/charset/iso_8859_4.c Unicode/charset/iso_8859_5.c \
  Unicode/charset/iso_8859_6.c Unicode/charset/iso_8859_7.c \
  Unicode/charset/iso_8859_8.c Unicode/charset/iso_8859_9.c \
  Unicode/charset/jis201.c Unicode/charset/jis.c Unicode/charset/johab.c \
  Unicode/charset/koi8_r.c Unicode/charset/ksc5601.c Unicode/charset/mac.c \
  Unicode/charset/MacSymbol.c Unicode/charset/win.c \
  Unicode/charset/ZapfDingbats.c Unicode/ArabicForms.c Unicode/char.c \
  Unicode/memory.c Unicode/ucharmap.c Unicode/unialt.c Unicode/ustring.c \
  Unicode/utype.c Unicode/combiners.h

gutils_libgutils_a_SOURCES = \
  gutils/fsys.c gutils/gimage.c \
  gutils/gimagebmpP.h gutils/gimageread.c gutils/gimagereadbmp.c gutils/gimagereadgif.c \
  gutils/gimagereadjpeg.c gutils/gimagereadpng.c gutils/gimagereadras.c \
  gutils/gimagereadrgb.c gutils/gimagereadtiff.c gutils/gimagereadxbm.c \
  gutils/gimagereadxpm.c gutils/gimagewritebmp.c gutils/gimagewritegimage.c \
  gutils/gimagewritejpeg.c gutils/gimagewritepng.c gutils/gimagewritexbm.c \
  gutils/gimagewritexpm.c gutils/giohosts.c gutils/giomime.c \
  gutils/giotrans.c gutils/giofuncP.h gutils/gioP.h gutils/gutils.c \
  gutils/gwwintl.c gutils/unicodelibinfo.c inc/unicodelibinfo.h \
  gutils/gioftpP.h
gutils_libgutils_a_CPPFLAGS = "-I$(top_builddir)/inc" "-I$(top_srcdir)/inc" \
  $(GLIB_CFLAGS)
gutils_libgutils_a_LIBADD = $(top_builddir)/Unicode/libgunicode.a
gutils_libgutils_a_LDFLAGS = $(GLIB_LIBS)

dist_doc_DATA = doc/fontanvil.pdf

texfiles = \
  doc/building.tex doc/datamodel.tex doc/fontanvil.tex \
  doc/intro.tex doc/reference.tex doc/running.tex

EXTRA_DIST = COPYING README \
  Unicode/README.TXT \
  $(texfiles) doc/anvil.pdf doc/quixote-daumier.jpg doc/quixote-dore.jpg \
  fontanvil/fontimage.pe fontanvil/fontlint.pe fontanvil/sfddiff.pe \
  $(FONTANVILSHARE_FILES) $(HOTKEY_FILES) share/default-n

DISTCHECK_CONFIGURE_FLAGS = --enable-debug

# FIXME FontForge claims that splinerefigure.c requires special handling
# to avoid optimization.  Look into this.

############################################################################

# PE SCRIPTS

PESCRIPT_HEADER = "\#!$(bindir)/fontanvil"

fontanvil/fontimage: fontanvil/fontimage.pe
	echo "${PESCRIPT_HEADER}" | cat - $< > $@
	chmod +x $@

fontanvil/fontlint: fontanvil/fontlint.pe
	echo "${PESCRIPT_HEADER}" | cat - $< > $@
	chmod +x $@

fontanvil/sfddiff: fontanvil/sfddiff.pe
	echo "${PESCRIPT_HEADER}" | cat - $< > $@
	chmod +x $@

############################################################################

# PDF DOCUMENTATION

doc/fontanvil.pdf: $(texfiles) \
  doc/quixote-dore.jpg doc/quixote-daumier.jpg
	cd doc ; $(PDFLATEX) fontanvil.tex
	cd doc ; makeindex fontanvil.idx
	cd doc ; $(PDFLATEX) fontanvil.tex
	cd doc ; $(PDFLATEX) fontanvil.tex

############################################################################

# MAKE CLEAN

MOSTLYCLEANFILES = \
  *~ */*~ \
  fontanvil/fontimage fontanvil/fontlint fontanvil/sfddiff \
  tests/atconfig \
  $(MO_FILES) $(noinst_FILES)
  
CLEANFILES =

DISTCLEANFILES = \
  aminclude.am _stdint.h \
  inc/fontanvil-config.h inc/stamp-h1

MAINTAINERCLEANFILES = \
  inc/fontanvil-config.h.in

############################################################################

# KILL EMPTY FILES

kill_empty=@$(PERL) \
  -e 'while (<$(1)>) { if (-f && -z _) {' \
  -e 'print "DELETING EMPTY FILE $$_\n"; `rm $$_`; } }'

kill-empty:
	$(call kill_empty,pfb/*.pfb)
	$(call kill_empty,sfd/*.sfd)
	$(call kill_empty,otf/*.otf)

.PHONY: kill-empty

############################################################################

# AUTOMAKE'S RULES WILL GO HERE

automake_rules = here

############################################################################
