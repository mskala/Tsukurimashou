## Process this file with automake to produce Makefile.in

#
# Makefile source for Icemap
# Copyright (C) 2014, 2015, 2017  Matthew Skala
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

TSU_V_RM=$(TSU_V_RM_$(V))
TSU_V_RM_=$(TSU_V_RM_$(AM_DEFAULT_VERBOSITY))
TSU_V_RM_0=@echo \
  "$(ansi_cleareol)   $(ansi_red)RM$(ansi_default)   "
TSU_V_RM_1=@true

TSU_V_TEXL=$(TSU_V_TEXL_$(V))
TSU_V_TEXL_=$(TSU_V_TEXL_$(AM_DEFAULT_VERBOSITY))
TSU_V_TEXL_0=echo \
  "$(ansi_cleareol)  $(ansi_green)TEX$(ansi_default)   " "$@($$I)";

############################################################################

# CONDITIONAL OPTIONS

if COND_GCOV
   MAYBE_COVERAGE=--coverage @NO_INLINE@
endif

############################################################################

# FILENAMES FOR AUTOTOOLS

# QVFG and FPEVCGF are DIST and SCRIPTS in ROT13, to keep Automake
# from recognizing them

STANDALONE_QVFG:=mitsuba.cls
EXTRA_DIST:= \
  $(if $(filter no,@parasite@),$(STANDALONE_QVFG)) \
  inttest.c icemap.tex

STANDALONE_FPEVCGF:=
dist_noinst_SCRIPTS= \
  $(if $(filter no,@parasite@),$(STANDALONE_FPEVCGF)) \
  $(GCOV_TESTS) test/rmgcda test/gcov

bin_PROGRAMS = icemap

AM_CFLAGS := $(MAYBE_COVERAGE) $(AM_CFLAGS)

icemap_SOURCES = icemap.c icemap.h \
  arrays.c arrows.c cascade.c construct.c context.c encode.c fileout.c \
  nodes.c parser.c remap.c rxparse.c

dist_pdf_DATA = icemap.pdf

# man1_MANS = icemap.1

############################################################################

# MAKE CLEAN

MOSTLYCLEANFILES =

CLEANFILES = \
  $(if $(filter yes,@parasite@),$(STANDALONE_QVFG) $(STANDALONE_FPEVCGF)) \
  icemap.out icemap.aux icemap.log icemap.toc \
  icemap.idx icemap.ind icemap.ilg 

DISTCLEANFILES = \
  aminclude.am _stdint.h

MAINTAINERCLEANFILES =

distcleancheck_listfiles = \
  find . -type f -exec sh -c 'test -f $(srcdir)/$$1 || echo $$1' \
    sh '{}' ';'

############################################################################

# PDF DOCUMENTATION

icemap.pdf: icemap.tex mitsuba.cls
	$(TSU_V_TEX)
	$(AM_V_at)rm -f icemap.aux
	$(AM_V_at)I=1;$(TSU_V_TEXL) \
	  '$(PDFLATEX)' $(mvp)/icemap.tex $(TSU_V_REDIR)
	$(AM_V_at)makeindex icemap.idx $(TSU_V_REDIR)
	$(AM_V_at)I=2;$(TSU_V_TEXL) \
	  '$(PDFLATEX)' $(mvp)/icemap.tex $(TSU_V_REDIR)
#	export BIBINPUTS=$(mvp) ; bibtex icemap.aux $(TSU_V_REDIR) ; \
#	I=3;$(TSU_V_TEXL) \
#	  $(expect_start)$(PDFLATEX) $(mvp)/icemap.tex $(expect_end)

############################################################################

# TESTING

IM_TESTS = \
  test/basicarray test/big5 test/bigger5 test/remap

define IMDEP_RECIPE
$1.log: inttest.c

endef

$(foreach test,$(IM_TESTS),$(eval $(call IMDEP_RECIPE,$(test))))

GCOV_TESTS = \
  test/help \
  $(IM_TESTS)

define GCDEP_RECIPE
$1.log: test/rmgcda.log

endef

if COND_GCOV

  TESTS = test/rmgcda $(GCOV_TESTS) test/gcov

  $(foreach test,$(GCOV_TESTS),$(eval $(call GCDEP_RECIPE,$(test))))

  test/gcov.log: $(foreach test,$(GCOV_TESTS),$(test).log)

else
  TESTS = $(GCOV_TESTS)
endif

############################################################################

# AUTOMAKE'S RULES WILL GO HERE

automake_rules = here

############################################################################

# PARASITE BUILD

if COND_PARASITE

download:

mitsuba.cls: ../mitsuba/mitsuba.cls
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

m4/tsu_bad_paths.m4: ../m4/tsu_bad_paths.m4
	$(TSU_V_CP) cp $< $@

m4/tsu_colourise.m4: ../m4/tsu_colourise.m4
	$(TSU_V_CP) cp $< $@

m4/tsu_fix_makefile.m4: ../m4/tsu_fix_makefile.m4
	$(TSU_V_CP) cp $< $@

endif

############################################################################
