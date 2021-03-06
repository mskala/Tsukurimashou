## Process this file with automake to produce Makefile.in

#
# Makefile for FontAnvil
# Copyright (C) 2014, 2015, 2016, 2017  Matthew Skala
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

$(error This Makefile must be edited by Perl code in config.status before use)

SHELL=$(if $(wildcard @KLEKNEV@),@KLEKNEV@,$(if \
  $(wildcard /bin/bash),/bin/bash,/bin/sh))

############################################################################

# SILENT BUILD BLINKENLIGHTS

TSU_V_REDIR=$(if $(AM_V_at),>& /dev/null)

if COND_COLOUR
  escchar:=$(strip $(shell echo x | tr 'x' '\033'))
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
  TSU_V_CHOPPER=| '$(PERL)' -pe 's/\[0m   (.{65})([^\n]+)/\[0m   \1.../'
else
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
  TSU_V_CHOPPER=| '$(PERL)' -pe 's/RM   (.{65})([^\n]+)/RM   \1.../'
endif

TSU_V_CP =$(TSU_V_CP_$(V))
TSU_V_CP_=$(TSU_V_CP_$(AM_DEFAULT_VERBOSITY))
TSU_V_CP_0=@echo \
  "$(ansi_cleareol)  $(ansi_default)CP$(ansi_default)    " $@;

TSU_V_ICE=$(TSU_V_ICE_$(V))
TSU_V_ICE_=$(TSU_V_ICE_$(AM_DEFAULT_VERBOSITY))
TSU_V_ICE_0=@echo \
  "$(ansi_cleareol)  $(ansi_cyan)ICE$(ansi_default)   " $@;

TSU_V_MAKE=$(TSU_V_MAKE_$(V))
TSU_V_MAKE_=$(TSU_V_MAKE_$(AM_DEFAULT_VERBOSITY))
TSU_V_MAKE_0=@echo \
  "$(ansi_cleareol)  $(ansi_white)MAKE$(ansi_default)  " $@;

TSU_V_RM=$(TSU_V_RM_$(V))
TSU_V_RM_=$(TSU_V_RM_$(AM_DEFAULT_VERBOSITY))
TSU_V_RM_0=@echo \
  "$(ansi_cleareol)   $(ansi_red)RM$(ansi_default)   "
TSU_V_RM_1=@true

TSU_V_TEX=$(TSU_V_TEX_$(V))
TSU_V_TEX_=$(TSU_V_TEX_$(AM_DEFAULT_VERBOSITY))
TSU_V_TEX_0=@echo \
  "$(ansi_cleareol)  $(ansi_green)TEX$(ansi_default)   " $@;

TSU_V_TEXL=$(TSU_V_TEXL_$(V))
TSU_V_TEXL_=$(TSU_V_TEXL_$(AM_DEFAULT_VERBOSITY))
TSU_V_TEXL_0=echo \
  "$(ansi_cleareol)  $(ansi_green)TEX$(ansi_default)   " "$@($$I)";

############################################################################

# TESTING

# must go before "filenames for autotools"

TEST_EXTENSIONS = .pe .pl .sh
if COND_VALGRIND
  PE_LOG_COMPILER = '@VALGRIND@' @VALGRIND_FLAGS@ \
    '$(builddir)/fontanvil/fontanvil$(EXEEXT)'
else
  PE_LOG_COMPILER = '$(builddir)/fontanvil/fontanvil$(EXEEXT)'
endif
PL_LOG_COMPILER = '@PERL@'

TESTS = \
  test/rmo-loop2.sh \
  test/arithmetic.pe test/autotrace.pe test/feamerge.pe test/ocrblue.pe \
  test/unilib.pe \
  test/test001.pe test/test002.pe test/test003.pe test/test004.pe \
  test/test005.pe test/test006.pe test/test007.pe test/test008.pe \
  test/test009.pe test/test010.pe test/test101.pe test/test102.pe \
  test/test103.pe test/test104.pe test/test105.pe test/test106.pe \
  test/test107.pe test/test108.pe test/test109.pe test/test110.pe \
  test/test111.pe test/test112.pe test/test113.pe test/test114.pe \
  test/test115.pe test/test116.pe test/test117.pe test/test118.pe \
  test/test119.pe test/test120.pe test/test121.pe test/test122.pe \
  test/test123.pe test/test124.pe test/test125.pe test/test126.pe \
  test/test127.pe test/test128.pe \
  test/coverage.pl test/doccov.pl test/feart.pl test/floatuse.pl

test/coverage.log: $(patsubst %.pe,%.log,$(filter test/%.pe,$(TESTS)))

test/feart.log: test/feamerge.log

if COND_KPSEWHICH
test/test111.log: ttmp/cmbsy10.pfb

ttmp/cmbsy10.pfb:
	$(AM_V_GEN)
	$(AM_V_at)cp `$(KPSEWHICH) cmbsy10.pfb` $@

endif

$(TESTS): ttmp/.dirstamp fontanvil/fontanvil$(EXEEXT)

############################################################################

# CONDITIONAL OPTIONS

if COND_GIFLIB
  MAYBE_GIFLIB_CF=$(GIFLIB_CFLAGS)
  MAYBE_GIFLIB_LD=$(GIFLIB_LDFLAGS)
endif
if COND_LIBJPEG
  MAYBE_LIBJPEG_CF=$(LIBJPEG_CFLAGS)
  MAYBE_LIBJPEG_LD=$(LIBJPEG_LDFLAGS)
endif
if COND_LIBPNG
  MAYBE_LIBPNG_CF=$(LIBPNG_CFLAGS)
  MAYBE_LIBPNG_LD=$(LIBPNG_LDFLAGS)
endif
if COND_LIBREADLINE
  MAYBE_LIBREADLINE_CF=$(LIBREADLINE_CFLAGS)
  MAYBE_LIBREADLINE_LD=$(LIBREADLINE_LDFLAGS)
endif
if COND_LIBSPIRO
  MAYBE_LIBSPIRO_CF=$(LIBSPIRO_CFLAGS)
  MAYBE_LIBSPIRO_LD=$(LIBSPIRO_LDFLAGS)
endif
if COND_LIBTIFF
  MAYBE_LIBTIFF_CF=$(LIBTIFF_CFLAGS)
  MAYBE_LIBTIFF_LD=$(LIBTIFF_LDFLAGS)
endif
if COND_LIBUNICODENAMES
  MAYBE_LIBUNICODENAMES_CF=$(LIBUNICODENAMES_CFLAGS)
  MAYBE_LIBUNICODENAMES_LD=$(LIBUNICODENAMES_LDFLAGS)
endif
if COND_LIBUNINAMESLIST
  MAYBE_LIBUNINAMESLIST_CF=$(LIBUNINAMESLIST_CFLAGS)
  MAYBE_LIBUNINAMESLIST_LD=$(LIBUNINAMESLIST_LDFLAGS)
endif
if COND_LIBXML2
  MAYBE_LIBXML2_CF=$(LIBXML2_CFLAGS)
  MAYBE_LIBXML2_LD=$(LIBXML2_LDFLAGS)
endif

############################################################################

# FILENAMES FOR AUTOTOOLS

AM_CPPFLAGS = "-I$(top_builddir)/inc" "-I$(top_srcdir)/inc" \
  "-I$(top_srcdir)/fontanvil" "-DSHAREDIR=\"${MY_SHAREDIR}\"" \
  "-DDOCDIR=\"${MY_DOCDIR}\""
AM_CFLAGS = \
  $(FREETYPE_CFLAGS) $(MAYBE_GIFLIB_CF) $(MAYBE_LIBJPEG_CF) \
  $(MAYBE_LIBPNG_CF) $(MAYBE_LIBREADLINE_CF) $(MAYBE_LIBSPIRO_CF) \
  $(MAYBE_LIBTIFF_CF) $(MAYBE_LIBUNICODENAMES_CF) \
  $(MAYBE_LIBUNINAMESLIST_CF) $(MAYBE_LIBXML2_CF) \
  $(ZLIB_CFLAGS) $(WARNING_CFLAGS)
AM_LDFLAGS = \
  $(FREETYPE_LDFLAGS) $(MAYBE_GIFLIB_LD) $(MAYBE_LIBJPEG_LD) \
  $(MAYBE_LIBPNG_LD) $(MAYBE_LIBREADLINE_LD) $(MAYBE_LIBSPIRO_LD) \
  $(MAYBE_LIBTIFF_LD) $(MAYBE_LIBUNICODENAMES_LD) \
  $(MAYBE_LIBUNINAMESLIST_LD) $(MAYBE_LIBXML2_LD) $(ZLIB_LDFLAGS)
AM_LFLAGS = -s -P`basename $* | sed 's,l$$,,'` -olex.yy.c

ICEMAP_INPUTS = \
 fontanvil/hinttab.im fontanvil/macenctab.im \
 fontanvil/nonmactab.im fontanvil/unicodelib.im

# non-empty value needed here to work around an Automake macro bug
# see http://permalink.gmane.org/gmane.comp.sysutils.autoconf.archive-maintainers/626
# "Makefile" was used before we had things we wanted to include for real
# BUILT_SOURCES = Makefile
BUILT_SOURCES = \
  fontanvil/feascan.c fontanvil/feascan.h \
  $(ICEMAP_INPUTS:.im=.c) $(ICEMAP_INPUTS:.im=.h)

bin_PROGRAMS = fontanvil/fontanvil

dist_man_MANS = \
  doc/fontanvil.1 doc/fontimage.1 doc/fontlint.1 \
  doc/sfddiff.1

noinst_HEADERS = \
  inc/PfEd.h \
  inc/SFMT-common.h inc/SFMT-params.h inc/SFMT-params19937.h inc/SFMT.h \
  inc/afile.h inc/autowidth.h inc/autowidth2.h \
  inc/baseviews.h inc/bezctx_ff.h inc/bitmapcontrol.h \
  inc/chardata.h inc/charset.h \
  inc/edgelist.h inc/edgelist2.h \
  inc/fffreetype.h inc/fileutil.h inc/flaglist.h inc/fontanvil.h \
    inc/fontanvil-config.h inc/fontanvilvw.h inc/fvmetrics.h \
  inc/gb12345.h inc/gfile.h inc/gimage.h inc/gresource.h \
  inc/mm.h \
  inc/namehash.h inc/nonlineartrans.h \
  inc/potrace.h inc/print.h inc/psfont.h \
  inc/savefont.h inc/scriptfuncs.h inc/scripting.h inc/sd.h inc/sfd1.h \
    inc/sflayoutP.h inc/splinefont.h inc/stemdb.h \
  inc/ttf.h inc/ttfinstrs.h \
  inc/uiinterface.h inc/unicodelibinfo.h inc/ustring.h inc/utype.h \
  inc/views.h \
  fontanvil/feascan.h \
  $(ICEMAP_INPUTS:.im=.h)

noinst_LIBRARIES = \
  Unicode/libgunicode.a

fontanvil_fontanvil_SOURCES = \
 fontanvil/main.c \
 fontanvil/afile.c fontanvil/asmfpst.c fontanvil/autohint.c \
   fontanvil/autotrace.c fontanvil/autowidth.c fontanvil/autowidth2.c \
 fontanvil/bezctx_ff.c fontanvil/bitmapchar.c fontanvil/bitmapcontrol.c \
   fontanvil/bvedit.c \
 fontanvil/crctab.c fontanvil/cvexport.c fontanvil/cvimages.c \
   fontanvil/cvundoes.c \
 fontanvil/dumpbdf.c fontanvil/dumppfa.c \
 fontanvil/effects.c fontanvil/encoding.c \
 fontanvil/fastring.c fontanvil/featurefile.c fontanvil/fontviewbase.c \
   fontanvil/freetype.c fontanvil/fsys.c fontanvil/fvcomposite.c \
   fontanvil/fvfonts.c fontanvil/fvimportbdf.c fontanvil/fvmetrics.c \
 fontanvil/gb12345.c fontanvil/gimage.c fontanvil/glyphcomp.c \
 fontanvil/ikarus.c \
 fontanvil/lookups.c \
 fontanvil/macbinary.c fontanvil/macenc.c fontanvil/mathconstants.c \
   fontanvil/mm.c \
 fontanvil/namelist.c fontanvil/nonlineartrans.c fontanvil/noprefs.c \
   fontanvil/nowakowskittfinstr.c \
 fontanvil/othersubrs.c \
 fontanvil/palmfonts.c fontanvil/parsepdf.c fontanvil/parsepfa.c \
   fontanvil/parsettfatt.c fontanvil/parsettfbmf.c fontanvil/parsettf.c \
   fontanvil/parsettfvar.c fontanvil/potrace.c fontanvil/print.c \
   fontanvil/psread.c fontanvil/pua.c fontanvil/python.c \
 fontanvil/savefont.c fontanvil/scripting.c fontanvil/scstyles.c \
   fontanvil/scvalid.c fontanvil/search.c fontanvil/SFMT.c \
   fontanvil/sfd1.c fontanvil/sfd.c fontanvil/sflayout.c inc/sfundo.h \
   fontanvil/spiro.c fontanvil/splinechar.c fontanvil/splinefill.c \
   fontanvil/splinefont.c fontanvil/splineorder2.c \
   fontanvil/splineoverlap.c fontanvil/splinerefigure.c \
   fontanvil/splinesaveafm.c fontanvil/splinesave.c \
   fontanvil/splinestroke.c fontanvil/splineutil2.c \
   fontanvil/splineutil.c fontanvil/start.c fontanvil/stemdb.c \
   fontanvil/svg.c \
 fontanvil/tottfaat.c fontanvil/tottfgpos.c fontanvil/tottf.c \
   fontanvil/tottfvar.c fontanvil/ttfinstrs.c fontanvil/ttfspecial.c \
 fontanvil/ufo.c fontanvil/unicodelibinfo.c \
 fontanvil/winfonts.c fontanvil/woff.c \
 fontanvil/zapfnomen.c \
 fontanvil/feascan.l fontanvil/pescript.l \
 $(ICEMAP_INPUTS:.im=.c)

fontanvil_fontanvil_LDADD = $(top_builddir)/Unicode/libgunicode.a

Unicode_libgunicode_a_SOURCES = \
  Unicode/char.c \
  Unicode/memory.c Unicode/unialt.c Unicode/ustring.c \
  Unicode/utype.c Unicode/combiners.h

dist_doc_DATA = doc/fontanvil.pdf
dist_noinst_DATA = dat/8r.enc dat/glyphlist.txt

texfiles = \
  doc/building.tex doc/datamodel.tex doc/fontanvil.tex \
  doc/intro.tex doc/language.tex doc/reference.tex doc/running.tex

# QVFG and FPEVCGF are DIST and SCRIPTS in ROT13, to keep Automake
# from recognizing them

STANDALONE_QVFG:=doc/mitsuba.cls
EXTRA_DIST:= \
  $(if $(filter no,@parasite@),$(STANDALONE_QVFG)) \
  COPYING README \
  Unicode/README.TXT \
  $(texfiles) doc/anvil.pdf doc/quixote-daumier.jpg doc/quixote-dore.jpg \
  fontanvil/fontimage.pe fontanvil/fontlint.pe fontanvil/sfddiff.pe \
  $(FONTANVILSHARE_FILES) $(HOTKEY_FILES) $(ICEMAP_INPUTS) share/default-n \
  test/helper107.pe test/helper118A.pe test/helper118B.pe \
  test/fonts/AHBugs.sfd test/fonts/AddExtremumTest.sfd \
  test/fonts/AddExtremaTest2.sfd \
  test/fonts/Ambrosia.sfd test/fonts/AmbrosiaBold.sfd \
  test/fonts/AmbrosiaItalic.sfd \
  test/fonts/BrushScriptX-Italic.pfa test/fonts/BrushScriptX-Italic.tfm \
  test/fonts/Caliban.sfd \
  test/fonts/CaslonMM.sfd test/fonts/DataURI.sfd \
  test/fonts/DejaVuSerif.sfd test/fonts/FormalScript.sfd \
  test/fonts/Hinting.sfd test/fonts/ItalicHand.sfd \
  test/fonts/NimbusLGCUni-Regular.sfd test/fonts/NumberPoints.sfd \
  test/fonts/OmittedCharBugs.sfd test/fonts/OverlapBugs.sfd \
  test/fonts/QuadraticConversionBug.sfd test/fonts/SimplifyBugs.sfd \
  test/fonts/SplineOverlapBug1.sfd test/fonts/VKern.sfd \
  test/fonts/dvng10a-crash.sfd test/fonts/feta20.pfb test/fonts/i11.png \
  test/fonts/rmo-loop2.sfd

STANDALONE_FPEVCGF:=
dist_noinst_SCRIPTS:= \
  $(if $(filter no,@parasite@),$(STANDALONE_FPEVCGF)) \
  $(TESTS) tools/dlunicode
nodist_bin_SCRIPTS = \
  fontanvil/fontimage fontanvil/fontlint fontanvil/sfddiff

# FIXME FontForge claims that splinerefigure.c requires special handling
# to avoid optimization.  Look into this.

############################################################################

# CFLOW

if COND_CFLOW

# rule straight out of the cflow manual

CFLOW_FLAGS=-i _x --cpp

fontanvil_fontanvil_CFLOW_INPUT= \
  $(fontanvil_fontanvil_OBJECTS:.$(OBJEXT)=.c)

fontanvil/fontanvil.cflow: \
  $(fontanvil_fontanvil_CFLOW_INPUT) Makefile tools/cflow.rc
	$(TSU_V_GEN)
	$(TSU_V_at)CFLOWRC=$(top_srcdir)/tools/cflow.rc \
	  cflow -o$@ $(CFLOW_FLAGS) $(DEFS) \
	    $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) \
	    $(fontanvil_fontanvil_CFLOW_INPUT) 2> /dev/null

fontanvil/fontanvil.rcflow: \
  $(fontanvil_fontanvil_CFLOW_INPUT) Makefile tools/cflow.rc
	$(TSU_V_GEN)
	$(TSU_V_at)CFLOWRC=$(top_srcdir)/tools/cflow.rc \
	  cflow -o$@ -r -d3 $(CFLOW_FLAGS) $(DEFS) \
	    $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) \
	    $(fontanvil_fontanvil_CFLOW_INPUT) 2> /dev/null

charts: fontanvil/fontanvil.cflow fontanvil/fontanvil.rcflow

endif

############################################################################

# ICEMAP

download:
	$(top_srcdir)/tools/dlunicode @UNICODE_URL@

if COND_DOWNLOAD

dat/Unihan_OtherMappings.txt: download

endif

if COND_ICEMAP

%.h:%.im $(ICEMAP)
	$(TSU_V_ICE)'$(ICEMAP)' -H$@ -C$(patsubst %.h,%.c,$@) $< $(TSU_V_REDIR)

fontanvil/hinttab.h: fontanvil/hinttab.im
fontanvil/hinttab.c: fontanvil/hinttab.h

fontanvil/macenctab.h: fontanvil/macenctab.im
fontanvil/macenctab.c: fontanvil/macenctab.h

fontanvil/nonmactab.h: fontanvil/nonmactab.im \
  dat/texbase.dat dat/gb2312.dat dat/glyphlist.txt
	$(AM_V_at)if test '!' "x$(VPATH)" = "x" ; then \
	  cp $(mvp)/dat/glyphlist.txt dat/ ; fi
	$(TSU_V_ICE)'$(ICEMAP)' -H$@ -C$(patsubst %.h,%.c,$@) $< $(TSU_V_REDIR)
fontanvil/nonmactab.c: fontanvil/nonmactab.h

fontanvil/unicodelib.h: fontanvil/unicodelib.im
fontanvil/unicodelib.c: fontanvil/unicodelib.h

if COND_KPSEWHICH
dat/8r.enc: @eightrenc@
	$(AM_V_GEN)
	$(AM_V_at)cp $< $@

endif

dat/texbase.dat: dat/8r.enc
	$(AM_V_GEN)
	$(AM_V_at)mkdir -p dat
	$(AM_V_at)'$(PERL)' -pe \
	  's/\%.*//;s!/TeXBase1Encoding!!;s/\s/\n/g;' $< > $@

dat/gb2312.dat: dat/Unihan_OtherMappings.txt
	$(AM_V_GEN)
	$(AM_V_at)mkdir -p dat
	$(AM_V_at)'$(PERL)' -n \
	  -e 'printf "%02X%02X\t%s\n",$$2+161,$$3+161,$$1 ' \
	  -e 'if /U\+([0-9a-f]{4})\tkGB0\t(\d\d)(\d\d)/i;' $< > $@
endif

############################################################################

# PE SCRIPTS

PESCRIPT_HEADER = "\#!$(bindir)/fontanvil$(EXEEXT)"

fontanvil/fontimage: fontanvil/fontimage.pe
	$(AM_V_GEN)
	$(AM_V_at)echo "${PESCRIPT_HEADER}" | cat - $< > $@
	$(AM_V_at)chmod +x $@

fontanvil/fontlint: fontanvil/fontlint.pe
	$(AM_V_GEN)
	$(AM_V_at)echo "${PESCRIPT_HEADER}" | cat - $< > $@
	$(AM_V_at)chmod +x $@

fontanvil/sfddiff: fontanvil/sfddiff.pe
	$(AM_V_GEN)
	$(AM_V_at)echo "${PESCRIPT_HEADER}" | cat - $< > $@
	$(AM_V_at)chmod +x $@

############################################################################

# PDF DOCUMENTATION

doc/fontanvil.pdf: $(texfiles) doc/mitsuba.cls \
  doc/quixote-dore.jpg doc/quixote-daumier.jpg
	$(AM_V_at)rm -f fontanvil.aux
	$(AM_V_at)if test '!' "$(realpath $(mvp)/doc)" = \
	  "$(realpath ./doc)" ; then \
	  cp $(mvp)/doc/*.tex $(mvp)/doc/*.jpg doc/ ; fi
	$(AM_V_at)I=1;$(TSU_V_TEXL) cd doc ; \
	  '$(PDFLATEX)' fontanvil.tex $(TSU_V_REDIR)
	$(AM_V_at)cd doc ; makeindex fontanvil.idx $(TSU_V_REDIR)
	$(AM_V_at)I=2;$(TSU_V_TEXL) cd doc ; \
	  '$(PDFLATEX)' fontanvil.tex $(TSU_V_REDIR)
	$(AM_V_at)I=3;$(TSU_V_TEXL) cd doc ; \
	  '$(PDFLATEX)' fontanvil.tex $(TSU_V_REDIR)

############################################################################

# MAKE CLEAN

MOSTLYCLEANFILES = \
  *~ */*~ \
  fontanvil/fontimage fontanvil/fontlint fontanvil/sfddiff \
  doc/fontanvil.aux doc/fontanvil.log doc/fontanvil.toc doc/fontanvil.out \
  doc/fontanvil.idx doc/fontanvil.ilg doc/fontanvil.ind \
  test/atconfig \
  $(MO_FILES) $(noinst_FILES)
  
mostlyclean-local:
	$(TSU_V_RM) 'ttmp'
	$(AM_V_at)rm -rf ttmp

CLEANFILES = \
  $(if $(filter yes,@parasite@),$(STANDALONE_QVFG) $(STANDALONE_FPEVCGF))

DISTCLEANFILES = \
  aminclude.am _stdint.h \
  inc/fontanvil-config.h inc/stamp-h1 \
  $(filter-out $(dist_noinst_DATA),$(wildcard dat/*)) \
  */.dirstamp

distclean-local:
	$(TSU_V_RM) 'dat/apple'
	$(AM_V_at)rm -rf dat/apple
	$(TSU_V_RM) 'dat/adobe'
	$(AM_V_at)rm -rf dat/adobe

MAINTAINERCLEANFILES = \
  inc/fontanvil-config.h.in

distcleancheck_listfiles = \
  find . -type f -exec sh -c 'test -f $(srcdir)/$$1 || echo $$1' \
    sh '{}' ';'

############################################################################

# KILL EMPTY FILES

kill_empty=@'$(PERL)' \
  -e 'while (<$(1)>) { if (-f && -z _) {' \
  -e 'print "DELETING EMPTY FILE $$_\n"; `rm $$_`; } }'

kill-empty:
	$(call kill_empty,pfb/*.pfb)
	$(call kill_empty,sfd/*.sfd)
	$(call kill_empty,otf/*.otf)

.PHONY: kill-empty

############################################################################

# DIRSTAMPS

ttmp/.dirstamp:
	$(AM_V_GEN)
	$(AM_V_at)$(MKDIR_P) ttmp
	$(AM_V_at)echo directory created > ttmp/.dirstamp

############################################################################

# AUTOMAKE'S RULES WILL GO HERE

automake_rules = here

############################################################################

# PARASITE BUILD

if COND_PARASITE

doc/mitsuba.cls: ../mitsuba/mitsuba.cls
	$(MKDIR_P) doc
	$(TSU_V_CP) cp $< $@

m4/ax_add_am_macro.m4: ../m4/ax_add_am_macro.m4
	$(TSU_V_CP) cp $< $@

m4/ax_am_jobserver.m4: ../m4/ax_am_jobserver.m4
	$(TSU_V_CP) cp $< $@

m4/ax_am_macros.m4: ../m4/ax_am_macros.m4
	$(TSU_V_CP) cp $< $@

m4/ax_append_to_file.m4: ../m4/ax_append_to_file.m4
	$(TSU_V_CP) cp $< $@

m4/ax_check_gnu_make.m4: ../m4/ax_check_gnu_make.m4
	$(TSU_V_CP) cp $< $@

m4/ax_count_cpus.m4: ../m4/ax_count_cpus.m4
	$(TSU_V_CP) cp $< $@

m4/ax_create_stdint_h.m4: ../m4/ax_create_stdint_h.m4
	$(TSU_V_CP) cp $< $@

m4/ax_file_escapes.m4: ../m4/ax_file_escapes.m4
	$(TSU_V_CP) cp $< $@

m4/ax_print_to_file.m4: ../m4/ax_print_to_file.m4
	$(TSU_V_CP) cp $< $@

m4/tsu_bad_paths.m4: ../m4/tsu_bad_paths.m4
	$(TSU_V_CP) cp $< $@

m4/tsu_colourise.m4: ../m4/tsu_colourise.m4
	$(TSU_V_CP) cp $< $@

m4/tsu_fix_makefile.m4: ../m4/tsu_fix_makefile.m4
	$(TSU_V_CP) cp $< $@

dat/UnicodeData.txt: $(wildcard ../idsgrep/UnicodeData.txt)
	$(MKDIR_P) dat
	$(TSU_V_CP) if test -s ../idsgrep/UnicodeData.txt ; \
	  then cp ../idsgrep/UnicodeData.txt $@ ; fi

endif

############################################################################
