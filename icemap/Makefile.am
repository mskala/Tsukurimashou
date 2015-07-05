## Process this file with automake to produce Makefile.in

#
# Makefile source for Icemap
# Copyright (C) 2014, 2015  Matthew Skala
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

if COND_GCOV
   MAYBE_COVERAGE=--coverage --no-inline
endif

############################################################################

# FILENAMES FOR AUTOTOOLS

# QVFG and FPEVCGF are DIST and SCRIPTS in ROT13, to keep Automake
# from recognizing them

STANDALONE_QVFG:=
EXTRA_DIST:= \
  $(if $(filter $(distdir),$(top_distdir)),$(STANDALONE_QVFG))

STANDALONE_FPEVCGF:=
dist_noinst_SCRIPTS:= \
  $(if $(filter $(distdir),$(top_distdir)),$(STANDALONE_FPEVCGF)) \
  $(GCOV_TESTS)

bin_PROGRAMS = icemap

AM_CFLAGS := $(MAYBE_COVERAGE) $(PCRE_CFLAGS) $(AM_CFLAGS)

icemap_SOURCES = icemap.c icemap.h \
  arrays.c arrows.c cascade.c context.c encode.c fileout.c \
  nodes.c parser.c remap.c rxparse.c

LDADD = @LIBOBJS@ $(PCRE_LIBS) -lbdd

# man1_MANS = icemap.1

############################################################################

# MAKE CLEAN

MOSTLYCLEANFILES =

CLEANFILES =

DISTCLEANFILES =

MAINTAINERCLEANFILES =

############################################################################

# PDF DOCUMENTATION

############################################################################

# TESTING

GCOV_TESTS =

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
