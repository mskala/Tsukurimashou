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

TSU_V_CP =$(TSU_V_CP_$(V))
TSU_V_CP_=$(TSU_V_CP_$(AM_DEFAULT_VERBOSITY))
TSU_V_CP_0=@$(ECHO_ANSI) \
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

TEST_EXTENSIONS = .pe .pl
if COND_VALGRIND
  PE_LOG_COMPILER = @VALGRIND@ @VALGRIND_FLAGS@ \
    $(builddir)/fontanvil/fontanvil
else
  PE_LOG_COMPILER = $(builddir)/fontanvil/fontanvil
endif
PL_LOG_COMPILER = @PERL@

TESTS = \
  test/arithmetic.pe test/feamerge.pe test/unilib.pe \
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
  test/coverage.pl test/doccov.pl test/feart.pl

test/coverage.log: $(patsubst %.pe,%.log,$(filter test/%.pe,$(TESTS)))

test/feart.log: test/feamerge.log

$(TESTS): ttmp/.dirstamp fontanvil/fontanvil

############################################################################

# FILENAMES FOR AUTOTOOLS

AM_CPPFLAGS = "-I$(top_builddir)/inc" "-I$(top_srcdir)/inc" \
  "-I$(top_srcdir)/fontanvil" "-DSHAREDIR=\"${MY_SHAREDIR}\"" \
  "-DDOCDIR=\"${MY_DOCDIR}\""
AM_CFLAGS = \
  $(FREETYPE_CFLAGS) $(GIFLIB_CFLAGS) $(LIBPNG_CFLAGS) \
  $(LIBTIFF_CFLAGS) $(LIBXML2_CFLAGS) $(WARNING_CFLAGS) $(ZLIB_CFLAGS)
AM_LDFLAGS = \
  $(FREETYPE_LIBS) $(GIFLIB_CFLAGS) $(LIBPNG_LIBS) \
  $(LIBTIFF_LIBS) $(LIBXML2_LIBS) $(ZLIB_LIBS)
AM_LFLAGS = -s -P`basename $* | sed 's,l$$,,'` -olex.yy.c

# needed to work around an Automake macro bug
# see http://permalink.gmane.org/gmane.comp.sysutils.autoconf.archive-maintainers/626
BUILT_SOURCES = Makefile

bin_PROGRAMS = fontanvil/fontanvil


dist_man_MANS = \
  fontanvil/fontanvil.1 fontanvil/fontimage.1 fontanvil/fontlint.1 \
  fontanvil/sfddiff.1

noinst_HEADERS = \
  inc/fontanvil.h \
  inc/chardata.h inc/charset.h inc/fileutil.h \
  inc/fontanvil-config.h inc/gfile.h \
  inc/gimage.h \
  inc/gresource.h inc/ustring.h \
  inc/utype.h \
  inc/afile.h \
  inc/views.h \
  inc/flaglist.h \
  inc/autowidth2.h inc/fontanvil.h \
  inc/libffstamp.h inc/psfont.h inc/stemdb.h \
  inc/autowidth.h inc/fontanvilvw.h \
  inc/savefont.h inc/ttf.h \
  inc/baseviews.h inc/fvmetrics.h inc/mm.h \
  inc/scriptfuncs.h inc/ttfinstrs.h inc/edgelist2.h \
  inc/namehash.h inc/scripting.h inc/uiinterface.h \
  inc/bezctx_ff.h inc/edgelist.h \
  inc/nonlineartrans.h inc/sd.h \
  inc/bitmapcontrol.h \
  inc/search.h inc/fffreetype.h \
  inc/PfEd.h inc/SFMT.h inc/SFMT-params.h inc/SFMT-params19937.h \
  inc/SFMT-common.h inc/sfd1.h \
  inc/sflayoutP.h inc/print.h inc/splinefont.h \
  inc/gb12345.h \
  inc/unicodelibinfo.h \
  fontanvil/feascan.h fontanvil/macenctab.h fontanvil/nonmactab.h \
  fontanvil/unicodelib.h

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
   fontanvil/parsettfvar.c fontanvil/print.c fontanvil/psread.c \
   fontanvil/pua.c fontanvil/python.c \
 fontanvil/savefont.c fontanvil/scripting.c fontanvil/scstyles.c \
   fontanvil/search.c fontanvil/SFMT.c fontanvil/sfd1.c fontanvil/sfd.c \
   fontanvil/sflayout.c inc/sfundo.h fontanvil/spiro.c \
   fontanvil/splinechar.c fontanvil/splinefill.c fontanvil/splinefont.c \
   fontanvil/splineorder2.c fontanvil/splineoverlap.c \
   fontanvil/splinerefigure.c fontanvil/splinesaveafm.c \
   fontanvil/splinesave.c fontanvil/splinestroke.c fontanvil/splineutil2.c \
   fontanvil/splineutil.c fontanvil/start.c fontanvil/stemdb.c \
   fontanvil/svg.c \
 fontanvil/tottfaat.c fontanvil/tottfgpos.c fontanvil/tottf.c \
   fontanvil/tottfvar.c fontanvil/ttfinstrs.c fontanvil/ttfspecial.c \
 fontanvil/ufo.c fontanvil/unicodelibinfo.c \
 fontanvil/winfonts.c fontanvil/woff.c \
 fontanvil/zapfnomen.c \
 fontanvil/feascan.l fontanvil/pescript.l \
 fontanvil/macenctab.im fontanvil/nonmactab.im fontanvil/unicodelib.im \
 fontanvil/macenctab.c fontanvil/nonmactab.c fontanvil/unicodelib.c

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
  $(if $(filter $(distdir),$(top_distdir)),$(STANDALONE_QVFG)) \
  COPYING README \
  Unicode/README.TXT \
  $(texfiles) doc/anvil.pdf doc/quixote-daumier.jpg doc/quixote-dore.jpg \
  fontanvil/fontimage.pe fontanvil/fontlint.pe fontanvil/sfddiff.pe \
  $(FONTANVILSHARE_FILES) $(HOTKEY_FILES) share/default-n \
  test/helper107.pe test/helper118A.pe test/helper118B.pe \
  test/fonts/AHBugs.sfd test/fonts/AddExtremumTest.sfd \
  test/fonts/Ambrosia.sfd test/fonts/AmbrosiaBold.sfd \
  test/fonts/AmbrosiaItalic.sfd test/fonts/Caliban.sfd \
  test/fonts/CaslonMM.sfd test/fonts/DataURI.sfd \
  test/fonts/DejaVuSerif.sfd test/fonts/FormalScript.sfd \
  test/fonts/Hinting.sfd test/fonts/ItalicHand.sfd \
  test/fonts/NimbusLGCUni-Regular.sfd test/fonts/NumberPoints.sfd \
  test/fonts/OmittedCharBugs.sfd test/fonts/OverlapBugs.sfd \
  test/fonts/QuadraticConversionBug.sfd test/fonts/SimplifyBugs.sfd \
  test/fonts/SplineOverlapBug1.sfd test/fonts/VKern.sfd \
  test/fonts/dvng10a-crash.sfd test/fonts/feta20.pfb

STANDALONE_FPEVCGF:=
dist_noinst_SCRIPTS:= \
  $(if $(filter $(distdir),$(top_distdir)),$(STANDALONE_FPEVCGF)) \
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

charts: fontanvil/fontanvil.cflow

endif

############################################################################

# ICEMAP

download:
	tools/dlunicode

if COND_ICEMAP

%.h:%.im $(ICEMAP)
	$(TSU_V_ICE)$(ICEMAP) -H$@ -C$(patsubst %.h,%.c,$@) $< $(TSU_V_REDIR)

fontanvil/macenctab.h: fontanvil/macenctab.im
fontanvil/macenctab.c: fontanvil/macenctab.h
fontanvil/nonmactab.h: fontanvil/nonmactab.im \
  dat/texbase.dat dat/gb2312.dat dat/glyphlist.txt \
  dat/UnicodeData.txt
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
	$(AM_V_at)$(PERL) -pe \
	  's/\%.*//;s!/TeXBase1Encoding!!;s/\s/\n/g;' $< > $@

dat/gb2312.dat: dat/Unihan_OtherMappings.txt
	$(AM_V_GEN)
	$(AM_V_at)mkdir -p dat
	$(AM_V_at)$(PERL) -n \
	  -e 'printf "%02X%02X\t%s\n",$$2+161,$$3+161,$$1 ' \
	  -e 'if /U\+([0-9a-f]{4})\tkGB0\t(\d\d)(\d\d)/i;' $< > $@
endif

fontanvil/encoding.o: fontanvil/macenctab.h fontanvil/nonmactab.h
fontanvil/fvcomposite.o: fontanvil/unicodelib.h
fontanvil/macenc.o: fontanvil/macenctab.h
fontanvil/parsettf.o: fontanvil/nonmactab.h
fontanvil/scripting.o: fontanvil/unicodelib.h
fontanvil/svg.o: fontanvil/unicodelib.h
fontanvil/unicodelibinfo.o: fontanvil/unicodelib.h

############################################################################

# PE SCRIPTS

PESCRIPT_HEADER = "\#!$(bindir)/fontanvil"

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
	$(AM_V_at)I=1;$(TSU_V_TEXL) cd doc ; \
	  $(PDFLATEX) fontanvil.tex $(TSU_V_REDIR)
	$(AM_V_at)cd doc ; makeindex fontanvil.idx $(TSU_V_REDIR)
	$(AM_V_at)I=2;$(TSU_V_TEXL) cd doc ; \
	  $(PDFLATEX) fontanvil.tex $(TSU_V_REDIR)
	$(AM_V_at)I=3;$(TSU_V_TEXL) cd doc ; \
	  $(PDFLATEX) fontanvil.tex $(TSU_V_REDIR)

############################################################################

# MAKE CLEAN

MOSTLYCLEANFILES = \
  *~ */*~ \
  fontanvil/fontimage fontanvil/fontlint fontanvil/sfddiff \
  test/atconfig \
  $(MO_FILES) $(noinst_FILES)
  
mostlyclean-local:
	$(TSU_V_RM) 'ttmp'
	$(AM_V_at)rm -rf ttmp

CLEANFILES =

DISTCLEANFILES = \
  aminclude.am _stdint.h \
  inc/fontanvil-config.h inc/stamp-h1 \
  */.dirstamp

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

m4/tsu_colourise.m4: ../m4/tsu_colourise.m4
	$(TSU_V_CP) cp $< $@

dat/UnicodeData.txt: ../idsgrep/UnicodeData.txt
	$(TSU_V_CP) cp $< $@

endif

############################################################################
