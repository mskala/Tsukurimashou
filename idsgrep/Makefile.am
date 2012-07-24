## Process this file with automake to produce Makefile.in

#
# Makefile source for IDSgrep
# Copyright (C) 2012  Matthew Skala
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

ACLOCAL_AMFLAGS = -I m4

mvp:=$(if $(VPATH),$(VPATH),.)

if COND_CHISE_IDS
   MAYBE_CIDATA=chise.eids
endif
if COND_GCOV
   MAYBE_COVERAGE=--coverage --no-inline
endif
if COND_KANJIVG
   MAYBE_KVDATA=kanjivg.eids
endif
if COND_TSUKU_BUILD
   MAYBE_DOCS=idsgrep.pdf
   MAYBE_TSUKUDATA=tsukurimashou.eids
endif
if COND_EDICT2
   MAYBE_EDICTDATA=edict.eids
endif

bin_PROGRAMS = idsgrep

MOSTLYCLEANFILES = \
  idsgrep.aux idsgrep.log idsgrep.blg idsgrep.bbl idsgrep.toc \
  *.gcda *.gcno *.gcov

CLEANFILES = chise.errs edict.eids kanjivg.eids tsukurimashou.eids

DISTCLEANFILES = $(if $(VPATH),idsgrep.pdf chise.eids,)

MAINTAINERCLEANFILES = idsgrep.pdf chise.eids

dist_dict_DATA = $(MAYBE_CIDATA)

dict_DATA = $(MAYBE_EDICTDATA) $(MAYBE_KVDATA) $(MAYBE_TSUKUDATA)

dist_noinst_SCRIPTS = \
  chise2eids ed22eids kvg2eids \
  $(GCOV_TESTS) test/vgneko test/rmgcda test/gcov

dist_pdf_DATA = $(MAYBE_DOCS)

EXTRA_DIST = PKGBUILD.in gnugetopt.h idsgrep.tex idsgrep.bib

AM_CFLAGS := $(MAYBE_COVERAGE) $(AM_CFLAGS)
idsgrep_SOURCES = assoc.c hash.c idsgrep.c idsgrep.h match.c parse.c

LDADD = @LIBOBJS@

man1_MANS = idsgrep.1

idsgrep.pdf: idsgrep.tex config.tex idsgrep.bib \
  @with_tsuku_build@/otf/TsukurimashouMincho.otf
	$(XELATEX) $(mvp)/idsgrep.tex
	export BIBINPUTS=$(mvp) ; bibtex idsgrep.aux
	$(XELATEX) $(mvp)/idsgrep.tex
	$(XELATEX) $(mvp)/idsgrep.tex

chise.eids: $(wildcard @with_chise_ids@/IDS-*.txt) chise2eids
	$(PERL) -CDS $(mvp)/chise2eids \
	  @with_chise_ids@ @with_chise_ids@/IDS-*.txt \
	  > chise.eids 2> chise.errs
	echo `wc -l < chise.errs` errors detected in CHISE IDS

# this if is for the case of chise.eids distributed and not locally built
edict.eids: @with_edict2@ @edict_decomp@ ed22eids
	if test -r @edict_decomp@ ; \
	then $(GZIP) -cd @with_edict2@ \
	  | $(ICONV) -feuc-jp -tutf-8 \
	  | $(PERL) -CDS $(mvp)/ed22eids @edict_decomp@ > edict.eids ; \
	else $(GZIP) -cd @with_edict2@ \
	  | $(ICONV) -feuc-jp -tutf-8 \
	  | $(PERL) -CDS $(mvp)/ed22eids $(mvp)/@edict_decomp@ \
	  > edict.eids ; fi

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

GCOV_TESTS = \
  test/andor test/anynot test/assoc test/basicmatch test/backslash \
  test/bighash test/demorgan test/equal test/kvg-grone test/messages \
  test/spacing test/tsu-grone test/unord test/utf8

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
