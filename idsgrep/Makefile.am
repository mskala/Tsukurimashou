## Process this file with automake to produce Makefile.in

#
# Makefile source for IDSgrep
# Copyright (C) 2012, 2013  Matthew Skala
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.
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

SHELL=$(if $(wildcard @KLEKNEV@),@KLEKNEV@,/bin/sh)

############################################################################

# SILENT BUILD BLINKENLIGHTS

TSU_V_REDIR=$(if $(AM_V_at),>& /dev/null)

if COND_COLOUR
  ECHO_ANSI=echo -e
  ansi_default=\e[0m
  ansi_red=\e[31m
  ansi_green=\e[32m
  ansi_yellow=\e[33m
  ansi_blue=\e[34m
  ansi_magenta=\e[35m
  ansi_cyan=\e[36m
  ansi_pink=\e[35;1m
  ansi_white=\e[37;1m
  ansi_cleareol=\e[K
  ansi_clearescaped=\033\[K
  ansi_home=\e[1G
  am__@andt@v_CC_0=@echo -e "$(ansi_default)$(ansi_cleareol)  CC    " $@;
  am__@andt@v_CCLD_0=@echo -e "$(ansi_default)$(ansi_cleareol)  CCLD  " $@;
  am__@andt@v_GEN_0=@echo -e "$(ansi_default)$(ansi_cleareol)  GEN   " $@;
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

TSU_V_CP =$(TSU_V_CP_$(V))
TSU_V_CP_=$(TSU_V_CP_$(AM_DEFAULT_VERBOSITY))
TSU_V_CP_0=@$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_default)CP$(ansi_default)    " $@;

TSU_V_TEXL=$(TSU_V_TEXL_$(V))
TSU_V_TEXL_=$(TSU_V_TEXL_$(AM_DEFAULT_VERBOSITY))
TSU_V_TEXL_0=$(ECHO_ANSI) \
  "$(ansi_cleareol)  $(ansi_green)TEX$(ansi_default)   " "$@($$I)";

############################################################################

# CONDITIONAL OPTIONS

if COND_BUDDY
   BUDDY_LIBS=-lbdd
else
if COND_WIDTHTAB
$(error Cannot use --enable-widthtab without BuDDy)
endif
endif
if COND_CHISE_IDS
   MAYBE_CIDATA=chise.eids chise.bvec
endif
if COND_DOCS
    MAYBE_DOCS=idsgrep.pdf
endif
if COND_EXPECT
  expect_start= $(if $(AM_V_at),$(EXPECT) -c \
    'log_user 0 ; spawn -noecho sh -c ")
  expect_end= $(if $(AM_V_at), " ; \
    expect -timeout -1 \
    -re "\n! " {exit 1} \
    -re "PROGRESS:(\[^\n\]*)\n" \
      {puts -nonewline \
         "$(ansi_clearescaped)$$expect_out(1,string)\r"; \
       flush stdout;exp_continue} \
    eof ; wait' )
else
  expect_end=$(TSU_V_REDIR)
endif
if COND_GCOV
   MAYBE_COVERAGE=--coverage --no-inline
endif
if COND_KANJIVG
   MAYBE_KVDATA=kanjivg.eids kanjivg.bvec
endif
if COND_TSUKU_BUILD
   MAYBE_DOCS=idsgrep.pdf
   MAYBE_TSUKUDATA=tsukurimashou.eids tsukurimashou.bvec
endif
if COND_EDICT2
   MAYBE_EDICTDATA=edict.eids edict.bvec
endif
MAYBE_CJKVIDATA=$(foreach ver,g t j k v x a,\
  $(if $(findstring $(ver),$(enable_cjkvi_style)),\
  cjkvi-$(ver).eids cjkvi-$(ver).bvec ))

############################################################################

# TESTING

# must go before "filenames for autotools"

GCOV_TESTS = \
  test/andor test/anynot test/assoc test/basicmatch test/backslash \
  test/bighash test/cooked test/demorgan test/equal test/filtcalc \
  test/genbv test/kvg-grone test/messages test/parsedict test/regex \
  test/spacing test/speed test/tsu-grone test/unilist test/unord \
  test/userpred test/utf8

define GCDEP_RECIPE
$1.log: test/rmgcda.log

endef

if COND_GCOV

  TESTS = test/rmgcda $(GCOV_TESTS) test/gcov

  $(foreach test,$(GCOV_TESTS),$(eval $(call GCDEP_RECIPE,$(test))))

  test/gcov.log: $(foreach test,$(GCOV_TESTS),$(test).log)

else
  TESTS = $(GCOV_TESTS) test/vgneko
endif

############################################################################

# FILENAMES FOR AUTOTOOLS

# QVFG and FPEVCGF are DIST and SCRIPTS in ROT13, to keep Automake
# from recognizing them

STANDALONE_QVFG:=
EXTRA_DIST:= \
  $(if $(filter $(distdir),$(top_distdir)),$(STANDALONE_QVFG)) \
  gnugetopt.h idsgrep.tex idsgrep.bib

STANDALONE_FPEVCGF:=
dist_noinst_SCRIPTS:= \
  $(if $(filter $(distdir),$(top_distdir)),$(STANDALONE_FPEVCGF)) \
  chise2eids cjkvi2eids ed22eids kvg2eids \
  cjkvi-ids.txt \
  $(GCOV_TESTS) test/vgneko test/rmgcda test/gcov

bin_PROGRAMS = idsgrep
noinst_PROGRAMS = mkwcw

dict_DATA = $(MAYBE_CJKVIDATA) $(MAYBE_CIDATA) $(MAYBE_EDICTDATA) \
  $(MAYBE_KVDATA) $(MAYBE_TSUKUDATA)

dist_pdf_DATA = $(MAYBE_DOCS)

AM_CFLAGS := $(MAYBE_COVERAGE) $(PCRE_CFLAGS) $(AM_CFLAGS)
idsgrep_SOURCES = \
  assoc.c bitvec.c cook.c hash.c idsgrep.c idsgrep.h match.c \
  parse.c regex.c unilist.c userpred.c widthtab.c

mkwcw_SOURCES = mkwcw.c

LDADD = @LIBOBJS@ $(PCRE_LIBS) $(BUDDY_LIBS)

man1_MANS = idsgrep.1

############################################################################

# MAKE CLEAN

MOSTLYCLEANFILES = \
  idsgrep.aux idsgrep.log idsgrep.blg idsgrep.bbl idsgrep.toc \
  *.bvec *.gcda *.gcno *.gcov

CLEANFILES = chise.errs edict.eids kanjivg.eids tsukurimashou.eids

DISTCLEANFILES = \
  $(if $(VPATH),idsgrep.pdf chise.eids,) _stdint.h aminclude.am

MAINTAINERCLEANFILES = idsgrep.pdf chise.eids

############################################################################

# PDF DOCUMENTATION

idsgrep.pdf: idsgrep.tex config.tex idsgrep.bib \
  @with_tsuku_build@/otf/TsukurimashouMincho.otf
	$(AM_V_at)I=1;$(TSU_V_TEXL) \
	  $(expect_start)$(XELATEX) $(mvp)/idsgrep.tex $(expect_end) ; \
	export BIBINPUTS=$(mvp) ; bibtex idsgrep.aux $(TSU_V_REDIR) ; \
	I=2;$(TSU_V_TEXL) \
	  $(expect_start)$(XELATEX) $(mvp)/idsgrep.tex $(expect_end) ; \
	I=3;$(TSU_V_TEXL) \
	  $(expect_start)$(XELATEX) $(mvp)/idsgrep.tex $(expect_end)

############################################################################

# DICTIONARIES

chise.eids: $(wildcard @with_chise_ids@/IDS-*.txt) chise2eids
	$(PERL) -CDS $(mvp)/chise2eids \
	  @with_chise_ids@ @with_chise_ids@/IDS-*.txt \
	  > chise.eids 2> chise.errs
	echo `wc -l < chise.errs` errors detected in CHISE IDS

cjkvi-%.eids: cjkvi-ids.txt cjkvi2eids
	$(PERL) -CDS $(mvp)/cjkvi2eids $* \
	  $(mvp)/cjkvi-ids.txt > cjkvi-$*.eids

edict.eids: @with_edict2@ @edict_decomp@ ed22eids
	$(GZIP) -cd @with_edict2@ \
	  | $(ICONV) -feuc-jp -tutf-8 \
	  | $(PERL) -CDS $(mvp)/ed22eids @edict_decomp@ > edict.eids

kanjivg.eids: @with_kanjivg@ kvg2eids
	if $(PERL) \
	  -e 'read STDIN,$$_,2;exit 1 if unpack("n",$$_)!=8075' \
	  < @with_kanjivg@ ; \
	then $(GZIP) -cd @with_kanjivg@ \
	  | $(PERL) -CS $(mvp)/kvg2eids > kanjivg.eids ; \
	else $(PERL) -CS $(mvp)/kvg2eids < @with_kanjivg@ > kanjivg.eids ; fi

@with_tsuku_build@/otf/TsukurimashouMincho.otf:
	cd @with_tsuku_build@ ; \
	  $(MAKE) $(AM_MAKEFLAGS) otf/TsukurimashouMincho.otf

@with_tsuku_build@/txt/tsukurimashou.eids: Makefile
	cd @with_tsuku_build@ ; $(MAKE) $(AM_MAKEFLAGS) eids

tsukurimashou.eids: @with_tsuku_build@/txt/tsukurimashou.eids
	$(LN_S) -f @with_tsuku_build@/txt/tsukurimashou.eids \
	  tsukurimashou.eids

%.bvec: idsgrep %.eids
	$(AM_V_GEN)
	$(AM_V_at)./idsgrep -G $*.eids > $*.bvec

############################################################################

# BUILD THE WIDTH TABLE

if COND_WIDTHTAB
widthtab.c: mkwcw widths.txt EastAsianWidth.txt UnicodeData.txt
	cat widths.txt EastAsianWidth.txt | ./mkwcw N UnicodeData.txt \
	  > widthtab.c
endif

############################################################################

# AUTOMAKE'S RULES WILL GO HERE

automake_rules = here

############################################################################

# PARASITE BUILD

if COND_PARASITE

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

m4/ax_create_stdint_h.m4: ../m4/ax_create_stdint_h.m4
	$(TSU_V_CP) cp $< $@

m4/ax_count_cpus.m4: ../m4/ax_count_cpus.m4
	$(TSU_V_CP) cp $< $@

m4/ax_file_escapes.m4: ../m4/ax_file_escapes.m4
	$(TSU_V_CP) cp $< $@

m4/ax_perl_module_version.m4: ../m4/ax_perl_module_version.m4
	$(TSU_V_CP) cp $< $@

m4/ax_print_to_file.m4: ../m4/ax_print_to_file.m4
	$(TSU_V_CP) cp $< $@

endif

############################################################################
