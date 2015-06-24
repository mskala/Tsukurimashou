#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#

#
# Configuration source for Icemap
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

#
############################################################################
#
# Override Autoconf's argument parsing - must be done here,
# before AC_INIT has a chance to run
#

# Much of this code is copied from the Tsukurimashou project, but since it
# has the same copyright holder, there's no licensing problem.

# General macro for editing a definition
m4_define([TSUKU_DEFINITION_SUBST],
          [m4_define([$1],
                     m4_bpatsubst(m4_dquote(m4_defn([$1])),
                                  [$2],
                                  [$3]))])

# Delete an option from the argument parser
m4_define([TSUKU_DELETE_CMDLINE_OPTION],
          [TSUKU_DEFINITION_SUBST([_AC_INIT_PARSE_ARGS],
                                  [\
  -$1[^)]*)\
.*;;\
  -$1=\*[^)]*)\
.*;;\
],
                                  [\
  # Deleted $1 option\
])
           TSUKU_DEFINITION_SUBST([_AC_INIT_PARSE_ARGS],
                                  [\
  -$1[^)]*)\
    # Obsolete.*\
.*;;\
],
                                  [\
  # Deleted obsolete $1 option\
])
           ])

# Delete unwanted non-install-dir options
TSUKU_DELETE_CMDLINE_OPTION([-x])
TSUKU_DELETE_CMDLINE_OPTION([x-includes])
TSUKU_DELETE_CMDLINE_OPTION([x-libraries])

# Delete an install dir option from both parser and help
m4_define([TSUKU_DELETE_INSTDIR_OPTION],
          [TSUKU_DELETE_CMDLINE_OPTION([$1dir])
           TSUKU_DEFINITION_SUBST([_AC_INIT_PARSE_ARGS],
                                  [for ac_var in\([^#]*\).\b$1dir\b],
                                  [for ac_var in\1])
           TSUKU_DEFINITION_SUBST([_AC_INIT_HELP],
                                  [  --$1dir=DIR.*\
],
                                  [])])

# Delete many of the default install dirs
TSUKU_DELETE_INSTDIR_OPTION([data])
TSUKU_DELETE_INSTDIR_OPTION([dvi])
TSUKU_DELETE_INSTDIR_OPTION([html])
TSUKU_DELETE_INSTDIR_OPTION([include])
TSUKU_DELETE_INSTDIR_OPTION([info])
TSUKU_DELETE_INSTDIR_OPTION([lib])
TSUKU_DELETE_INSTDIR_OPTION([libexec])
TSUKU_DELETE_INSTDIR_OPTION([info])
TSUKU_DELETE_INSTDIR_OPTION([locale])
TSUKU_DELETE_INSTDIR_OPTION([localstate])
TSUKU_DELETE_INSTDIR_OPTION([oldinclude])
TSUKU_DELETE_INSTDIR_OPTION([ps])
TSUKU_DELETE_INSTDIR_OPTION([sbin])
TSUKU_DELETE_INSTDIR_OPTION([sharedstate])
TSUKU_DELETE_INSTDIR_OPTION([sysconf])

# Reduce the ridiculous verbosity of Autoconf's help message
TSUKU_DEFINITION_SUBST([_AC_INIT_HELP],
                       [ to adapt to many kinds of systems],[])
TSUKU_DEFINITION_SUBST([_AC_INIT_HELP],
                       [of some of the useful variables],
                       [of some useful variables])
TSUKU_DEFINITION_SUBST([_AC_INIT_HELP],
                       [Defaults for the options are specified in brackets],
                       [Defaults are specified in brackets])
TSUKU_DEFINITION_SUBST([_AC_INIT_HELP],
                       [\barch.*-independent \b],
                       [])

#
############################################################################
#
# Autoconf initialization
#
AC_PREREQ([2.67])
AC_INIT([Icemap],
	[0.1pre], [mskala@ansuz.sooke.bc.ca], [icemap],
	[[http://tsukurimashou.osdn.jp/]])
AC_PRESERVE_HELP_ORDER
AC_CONFIG_AUX_DIR([.])
AM_INIT_AUTOMAKE([foreign color-tests parallel-tests silent-rules])
AC_CONFIG_SRCDIR([icemap.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_REVISION([$Id: configure.ac 1015 2011-12-15 22:24:32Z mskala $])
AC_COPYRIGHT([Copyright (C) 2014 Matthew Skala])
AC_SUBST([release_date],["November 1, 2014"])
AM_SILENT_RULES
#
############################################################################
#
# Checks for programs.
#
AC_PROG_CC
AC_PROG_CC_C_O
AC_PROG_GREP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PATH_PROG([AUTOCONF],[autoconf])
AC_PATH_PROG([AUTOMAKE],[automake])
AX_CHECK_GNU_MAKE
AC_PATH_PROG([GZIP],[gzip])
AC_ARG_VAR([KLEKNEV],[Kleknev])
AS_IF([test "x$KLEKNEV" = "x"],
  [AC_PATH_PROG([KLEKNEV],[kleknev],[/bin/sh])])
AC_ARG_VAR([PERL],[Perl])
AS_IF([test "x$PERL" = "x"],
  [AC_PATH_PROG([PERL],[perl])])
#
############################################################################
#
# Check for parasite build
#
AC_MSG_CHECKING([whether we are building as a parasite])
AM_CONDITIONAL([COND_PARASITE],
  [grep Tsukurimashou ../Makefile > /dev/null 2> /dev/null])
AM_COND_IF([COND_PARASITE],
  [AC_MSG_RESULT([yes])],
  [AC_MSG_RESULT([no])])
#
############################################################################
#
# Checks for libraries.
#
AX_PATH_LIB_PCRE([have_pcre=yes
  AC_DEFINE([HAVE_PCRE],[1],
    [Define to 1 if Perl Compatible Regular Expressions library is available])
  ],[have_pcre=no])
AM_CONDITIONAL([COND_PCRE],[test '!' "$have_pcre" = no])
#
############################################################################
#
# Checks for header files.
#
# AC_CHECK_HEADERS([libintl.h stdlib.h string.h wchar.h])
AX_CREATE_STDINT_H
#
############################################################################
#
# Checks for typedefs, structures, and compiler characteristics.
#
AC_CHECK_SIZEOF([int])
AC_TYPE_SIZE_T
#
############################################################################
#
# Checks for library functions.
#
AX_FUNC_GETOPT_LONG
AC_CHECK_FUNCS([vasprintf])
#
############################################################################
#
# Checks for system services
#
AC_SYS_LONG_FILE_NAMES
AX_AM_JOBSERVER
#
############################################################################
#
# User-settable options
#
AC_ARG_ENABLE([gcov],
  [AS_HELP_STRING([--enable-gcov],
    [use Gcov to test the test suite])],
    [],
    [enable_gcov=no])
AM_CONDITIONAL([COND_GCOV],[test '!' "$enable_gcov" = no])
#
AC_ARG_ENABLE([colour-build],
  [AS_HELP_STRING([--disable-colour-build],
    [turn off ANSI colour in build scripts])],
    [],
    [enable_colour_build=yes])
AC_ARG_ENABLE([color-build],[dnl],[],[enable_color_build=yes])
#
# Process user options
#
tsu_colour=yes
AS_IF([test "x$enable_colour_build" = "xyes"],
  [],[tsu_colour=no])
AS_IF([test "x$enable_color_build" = "xyes"],
  [],[tsu_colour=no])
AM_CONDITIONAL([COND_COLOUR],[test '!' "$tsu_colour" = no])
#
AS_IF([test "x$enable_silent_rules" = "x"],
  [enable_silent_rules=yes
   AM_DEFAULT_VERBOSITY=0])
#
############################################################################
#
# Generate output
#
AC_SUBST([andt],[])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
#
############################################################################
#
# Warn about missing prerequisites
#
AS_IF([test "x$have_pcre" = "xyes"],[],
  [AC_MSG_WARN([PCRE is missing])])
