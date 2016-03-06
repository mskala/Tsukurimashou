# Process this file with autoconf to produce a configure script.

#
# Configuration source for FontAnvil
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

#
############################################################################
#
# Override Autoconf's argument parsing - must be done here,
# before AC_INIT has a chance to run
#

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
TSUKU_DELETE_CMDLINE_OPTION([gas])
TSUKU_DELETE_CMDLINE_OPTION([nfp])
TSUKU_DELETE_CMDLINE_OPTION([program-prefix])
TSUKU_DELETE_CMDLINE_OPTION([program-suffix])
TSUKU_DELETE_CMDLINE_OPTION([program-transform-name])
# may as well do this now - removes some processing and a help stanza
AC_DEFUN([AC_ARG_PROGRAM],[])
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

# Delete nearly all of the default install dirs
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
TSUKU_DELETE_INSTDIR_OPTION([man])
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
TSUKU_DEFINITION_SUBST([_AC_INIT_HELP],
                       [\
.*(\[--exec-prefix=EPREFIX.*\
.*\])\(.\)[^:]*\
Fine tuning of the installation directories:\
],
                       [\1\
])

#
############################################################################
#
# Autoconf initialization
#
AC_PREREQ([2.68])
AC_INIT([FontAnvil],[0.4],[mskala@ansuz.sooke.bc.ca],[fontanvil],
  [[http://tsukurimashou.osdn.jp/]])
AC_PRESERVE_HELP_ORDER
AC_CONFIG_AUX_DIR([config])
AM_INIT_AUTOMAKE([foreign check-news color-tests
  parallel-tests silent-rules subdir-objects])
AC_CONFIG_SRCDIR([fontanvil/main.c])
AC_CONFIG_HEADERS([inc/fontanvil-config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_REVISION([$Id: configure.ac 2831 2014-03-02 07:18:54Z mskala $])
AC_COPYRIGHT([Copyright (C) 2014, 2015 Matthew Skala])
AC_SUBST([release_date],["December 8, 2015"])
AM_SILENT_RULES
AC_USE_SYSTEM_EXTENSIONS
#
############################################################################
#
# Pass version numbers and dates
#
AC_DEFINE([FONTANVIL_VERSION_MAJOR],[0],[FontAnvil Major Version])
AC_DEFINE([FONTANVIL_VERSION_MINOR],[4],[FontAnvil Minor Version])
AC_SUBST([VERSION_MAJOR],[0])
AC_SUBST([VERSION_MINOR],[4])
AC_SUBST([VERSION_PATCH],[0])
AC_SUBST([FONTANVIL_VERSION],[0.4.0])
FONTANVIL_MODTIME="`date '+%s'`L"
FONTANVIL_MODTIME_STR="`date +'%H:%M %Z %e-%b-%Y'`"
FONTANVIL_VERSIONDATE="`date '+%Y%m%d'`"
AC_DEFINE_UNQUOTED(FONTANVIL_MODTIME,"$FONTANVIL_MODTIME","Epoch time that configure was run at")
AC_DEFINE_UNQUOTED(FONTANVIL_MODTIME_STR,"$FONTANVIL_MODTIME_STR",
	"A user friendly date that that configure was run at: For example 01:48 GMT 6-Sep-2012")
AC_DEFINE_UNQUOTED(FONTANVIL_VERSIONDATE,"$FONTANVIL_VERSIONDATE","YYYYMMDD as number when configure was run")
AC_DEFINE_UNQUOTED(FONTANVIL_MODTIME_RAW,$FONTANVIL_MODTIME,"Epoch time that configure was run at (no quotes)")
AC_DEFINE_UNQUOTED(FONTANVIL_MODTIME_STR_RAW,$FONTANVIL_MODTIME_STR,
	"A user friendly date that that configure was run at: For example 01:48 GMT 6-Sep-2012 (no quotes)")
AC_DEFINE_UNQUOTED(FONTANVIL_VERSIONDATE_RAW,$FONTANVIL_VERSIONDATE,"YYYYMMDD as number when configure was run (no quotes)")
#
############################################################################
#
# Checks for programs (and other things controlled by environment variables)
#
AC_PROG_AWK
AC_PROG_CC
AC_PROG_CC_C99
AM_PROG_CC_C_O
AC_PROG_CPP
AC_PROG_GREP
AC_PROG_INSTALL
AM_PROG_LEX
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PROG_RANLIB
AC_PROG_SED
AC_PATH_PROG([AUTOCONF],[autoconf])
AC_PATH_PROG([AUTOMAKE],[automake])
AC_PATH_PROG([CFLOW],[cflow])
AM_CONDITIONAL([COND_CFLOW],[test '!' "x$CFLOW" = "x"])
AC_PATH_PROG([GZIP],[gzip])
AC_ARG_VAR([ICEMAP],[Icemap])
AS_IF([test "x$ICEMAP" = "x"],
  [AC_PATH_PROG([ICEMAP],[icemap],[],[$PATH:$PWD/../icemap])])
AC_ARG_VAR([KLEKNEV],[Kleknev])
AS_IF([test "x$KLEKNEV" = "x"],
  [AC_PATH_PROG([KLEKNEV],[kleknev],[/bin/sh],[$PATH:$PWD/../kleknev])])
AC_PATH_PROG([KPSEWHICH],[kpsewhich])
AM_CONDITIONAL([COND_KPSEWHICH],[test '!' "x$KPSEWHICH" = "x"])
AC_PATH_PROG([MAKE],[make])
AX_CHECK_GNU_MAKE
AC_PATH_PROG([MSGFMT],[msgfmt],[msgfmt])
AC_ARG_VAR([PDFLATEX],[PDFLaTeX])
AS_IF([test "x$PDFLATEX" = "x"],
  [AC_PATH_PROG([PDFLATEX],[pdflatex])])
AC_ARG_VAR([PERL],[Perl])
AS_IF([test "x$PERL" = "x"],
  [AC_PATH_PROG([PERL],[perl])])
AC_PATH_PROG([UNZIP],[unzip],[unzip])
#
AC_ARG_VAR([VALGRIND],[Valgrind])
AS_IF([test "x$VALGRIND" = "x"],
  [AC_PATH_PROG([VALGRIND],[valgrind])])
AC_ARG_VAR([VALGRIND_FLAGS],[options for Valgrind])
AC_SUBST([VALGRIND_FLAGS])
AS_IF([test "x$VALGRIND" = "x"],
  [VALGRIND_FLAGS=],
  [uname=`uname`
   AS_IF([test "x$uname" = "xDarwin"],
     [VALGRIND_FLAGS='--dsymutil=yes --leak-check=full --track-origins=yes'],
     [VALGRIND_FLAGS='--leak-check=full --track-origins=yes'])])
#
gmake_version=unknown
missing_gmake_version=yes
AC_MSG_CHECKING([GNU Make version])
AS_IF([test "x$PERL" = "x" || test "x$MAKE" = "x"],[],
  [missing_gmake_version=no
gmake_version=dnl
`"$MAKE" --version | perl -ne 'print $1 if /^GNU Make.*(\d+\.\d+)/'`
   AS_VERSION_COMPARE([$gmake_version],[3.82],
     [missing_gmake_version=yes])])
AC_MSG_RESULT([$gmake_version])
#
PKG_PROG_PKG_CONFIG
#
############################################################################
#
# Check for parasite build
#
AC_MSG_CHECKING([whether we are building as a parasite])
AM_CONDITIONAL([COND_PARASITE],
  [grep Tsukurimashou ../Makefile > /dev/null 2> /dev/null])
AM_COND_IF([COND_PARASITE],
  [AC_MSG_RESULT([yes])
   AS_IF([test "x$ICEMAP" = "x"],
     [AC_MSG_WARN([Depending on locally-built Icemap])
      ICEMAP=$PWD/../icemap/icemap])],
  [AC_MSG_RESULT([no])])
AS_IF([test "x$ICEMAP" = "x"],[ICEMAP=no])
AM_CONDITIONAL([COND_ICEMAP],[test '!' "x$ICEMAP" = "xno"])
#
############################################################################
#
# Checks for libraries.
#
AC_SEARCH_LIBS([cos],[m])
#
PKG_CHECK_MODULES([FREETYPE],[freetype2],
  [have_freetype2=yes
   LIBS="$FREETYPE_LIBS $LIBS"
  ],[have_freetype2=no])
AC_SEARCH_LIBS([iconv_open],[iconv],[],
  [AC_SEARCH_LIBS([libiconv_open],[iconv])])
PKG_CHECK_MODULES([ZLIB],[zlib],[LIBS="$ZLIB_LIBS $LIBS"],
  [AC_SEARCH_LIBS([inflate],[z])])
#
AC_ARG_WITH([giflib],
 [AS_HELP_STRING([--with-giflib=PATH],
   [GIF image file library [auto]])],
   [],
   [with_giflib=auto])
AC_ARG_WITH([iconv],
 [AS_HELP_STRING([--with-iconv=PATH],
   [character set converter [auto]])],
   [],
   [with_iconv=auto])
AC_ARG_WITH([libjpeg],
 [AS_HELP_STRING([--with-libjpeg=PATH],
   [JPEG image file library [auto]])],
   [],
   [with_libjpeg=auto])
AC_ARG_WITH([libpng],
 [AS_HELP_STRING([--with-libpng=PATH],
   [PNG image file library [auto]])],
   [],
   [with_libpng=auto])
AC_ARG_WITH([libreadline],
 [AS_HELP_STRING([--with-libreadline=PATH],
   [command-line interactivity library [auto]])],
   [],
   [with_libreadline=auto])
AC_ARG_WITH([libspiro],
 [AS_HELP_STRING([--with-libspiro=PATH],
   [spline geometry library [auto]])],
   [],
   [with_libspiro=auto])
AC_ARG_WITH([libtiff],
 [AS_HELP_STRING([--with-libtiff=PATH],
   [TIFF image file library [auto]])],
   [],
   [with_libtiff=auto])
AC_ARG_WITH([libuninameslist],
 [AS_HELP_STRING([--with-libuninameslist=PATH],
   [Unicode name database [auto]])],
   [],
   [with_libuninameslist=auto])
AC_ARG_WITH([libunicodenames],
 [AS_HELP_STRING([--with-libunicodenames=PATH],
   [Unicode name database [auto]])],
   [],
   [with_libunicodenames=auto])
AC_ARG_WITH([libxml2],
 [AS_HELP_STRING([--with-libxml2=PATH],
   [XML file format library [auto]])],
   [],
   [with_libxml2=auto])
#
# process library enable options
#
AC_ARG_VAR([GIFLIB_CFLAGS],[C compiler flags for giflib])
AC_ARG_VAR([GIFLIB_LDFLAGS],[linker flags for giflib])
AS_IF([test '!' "x$with_giflib" = xno],
  [AC_SEARCH_LIBS([DGifOpenFileName],[gif ungif],[],[with_giflib=no])])
AM_CONDITIONAL([COND_GIFLIB],[test '!' "x$with_giflib" = xno])
AC_SUBST([GIFLIB_CFLAGS])
AC_SUBST([GIFLIB_LDFLAGS])
AS_IF([test '!' "x$with_giflib" = xno],
  [],
  [AC_DEFINE([_NO_LIBUNGIF],1,[Define if not using system giflib.])])
#
AC_ARG_VAR([LIBJPEG_CFLAGS],[C compiler flags for libjpeg])
AC_ARG_VAR([LIBJPEG_LDFLAGS],[linker flags for libjpeg])
AS_IF([test '!' "x$with_libjpeg" = xno],
  [AC_SEARCH_LIBS([jpeg_CreateDecompress],[jpeg],[],[with_libjpeg=no])])
AM_CONDITIONAL([COND_LIBJPEG],[test '!' "x$with_libjpeg" = xno])
AC_SUBST([LIBJPEG_CFLAGS])
AC_SUBST([LIBJPEG_LDFLAGS])
AS_IF([test '!' "x$with_libjpeg" = xno],
  [],
  [AC_DEFINE([_NO_LIBJPEG],1,[Define if not using libjpeg.])])
#
AC_ARG_VAR([LIBPNG_CFLAGS],[C compiler flags for libpng])
AC_ARG_VAR([LIBPNG_LDFLAGS],[linker flags for libpng])
AS_IF([test '!' "x$with_libpng" = xno],
  [PKG_CHECK_MODULES([LIBPNG],[libpng],
    [LIBS="$LIBPNG_LIBS $LIBS"],[with_libpng=no])])
AM_CONDITIONAL([COND_LIBPNG],[test '!' "x$with_libpng" = xno])
AC_SUBST([LIBPNG_CFLAGS])
AC_SUBST([LIBPNG_LDFLAGS])
AS_IF([test '!' "x$with_libpng" = xno],
  [],
  [AC_DEFINE([_NO_LIBPNG],1,[Define if not using libpng.])])
#
AC_ARG_VAR([LIBREADLINE_CFLAGS],[C compiler flags for libreadline])
AC_ARG_VAR([LIBREADLINE_LDFLAGS],[linker flags for libreadline])
AS_IF([test '!' "x$with_libreadline" = xno],
  [AC_SEARCH_LIBS([rl_readline_version],[readline],
    [AC_SEARCH_LIBS([tgetflag],[termcap],[],[])],
    [with_libreadline=no],[-ltermcap])])
AM_CONDITIONAL([COND_LIBREADLINE],[test '!' "x$with_libreadline" = xno])
AC_SUBST([LIBREADLINE_CFLAGS])
AC_SUBST([LIBREADLINE_LDFLAGS])
AS_IF([test '!' "x$with_libreadline" = xno],
  [AC_CHECK_HEADER([readline/readline.h])],
  [AC_DEFINE([_NO_LIBREADLINE],1,[Define if not using libreadline.])])
#
AC_ARG_VAR([LIBSPIRO_CFLAGS],[C compiler flags for libspiro])
AC_ARG_VAR([LIBSPIRO_LDFLAGS],[linker flags for libspiro])
AS_IF([test '!' "x$with_libspiro" = xno],
  [AC_SEARCH_LIBS([TaggedSpiroCPsToBezier],[spiro],[],[with_libspiro=no])])
AM_CONDITIONAL([COND_LIBSPIRO],[test '!' "x$with_libspiro" = xno])
AC_SUBST([LIBSPIRO_CFLAGS])
AC_SUBST([LIBSPIRO_LDFLAGS])
AS_IF([test '!' "x$with_libspiro" = xno],
  [],
  [AC_DEFINE([_NO_LIBSPIRO],1,[Define if not using libspiro.])])
#
AC_ARG_VAR([LIBTIFF_CFLAGS],[C compiler flags for libtiff])
AC_ARG_VAR([LIBTIFF_LDFLAGS],[linker flags for libtiff])
AS_IF([test '!' "x$with_libtiff" = xno],
  [PKG_CHECK_MODULES([LIBTIFF],[libtiff-4],[LIBS="$LIBTIFF_LIBS $LIBS"],
    [AC_SEARCH_LIBS([TIFFClose],[tiff],[],[with_libtiff=no])])])
AM_CONDITIONAL([COND_LIBTIFF],[test '!' "x$with_libtiff" = xno])
AC_SUBST([LIBTIFF_CFLAGS])
AC_SUBST([LIBTIFF_LDFLAGS])
AS_IF([test '!' "x$with_libtiff" = xno],
  [],
  [AC_DEFINE([_NO_LIBTIFF],1,[Define if not using libtiff.])])
#
AC_ARG_VAR([LIBUNICODENAMES_CFLAGS],[C compiler flags for libunicodenames])
AC_ARG_VAR([LIBUNICODENAMES_LDFLAGS],[linker flags for libunicodenames])
AS_IF([test '!' "x$with_libunicodenames" = xno],
  [AC_SEARCH_LIBS([UnicodeNamesAnnot],[unicodenames],[],
    [with_libunicodenames=no])])
AM_CONDITIONAL([COND_LIBUNICODENAMES],[test '!' "x$with_libunicodenames" = xno])
AC_SUBST([LIBUNICODENAMES_CFLAGS])
AC_SUBST([LIBUNICODENAMES_LDFLAGS])
AS_IF([test '!' "x$with_libunicodenames" = xno],
  [],
  [AC_DEFINE([_NO_LIBUNICODENAMES],1,[Define if not using libunicodenames.])])
#
AC_ARG_VAR([LIBUNINAMESLIST_CFLAGS],[C compiler flags for libuninameslist])
AC_ARG_VAR([LIBUNINAMESLIST_LDFLAGS],[linker flags for libuninameslist])
AS_IF([test '!' "x$with_libuninameslist" = xno],
  [AC_SEARCH_LIBS([UnicodeNamesAnnot],[uninameslist],[],
    [with_libuninameslist=no])])
AM_CONDITIONAL([COND_LIBUNINAMESLIST],[test '!' "x$with_libuninameslist" = xno])
AC_SUBST([LIBUNINAMESLIST_CFLAGS])
AC_SUBST([LIBUNINAMESLIST_LDFLAGS])
AS_IF([test '!' "x$with_libuninameslist" = xno],
  [],
  [AC_DEFINE([_NO_LIBUNINAMESLIST],1,[Define if not using libuninameslist.])])
#
AC_ARG_VAR([LIBXML2_CFLAGS],[C compiler flags for libxml2])
AC_ARG_VAR([LIBXML2_LDFLAGS],[linker flags for libxml2])
AS_IF([test '!' "x$with_libxml2" = xno],
  [PKG_CHECK_MODULES([LIBXML2],[libxml-2.0],
    [LIBS="$LIBXML2_LIBS $LIBS"],[with_libxml2=no])])
AM_CONDITIONAL([COND_LIBXML2],[test '!' "x$with_libxml2" = xno])
AC_SUBST([LIBXML2_CFLAGS])
AC_SUBST([LIBXML2_LDFLAGS])
AS_IF([test '!' "x$with_libxml2" = xno],
  [],
  [AC_DEFINE([_NO_LIBXML],1,[Define if not using libxml2.])])
#
############################################################################
#
# Checks for header files.
#
AC_CHECK_HEADERS([fcntl.h ieeefp.h])
AC_CHECK_HEADERS([memory.h])
AC_CHECK_HEADERS([strings.h sys/time.h unistd.h])
AC_CHECK_HEADERS([iconv.h])
#
############################################################################
#
# Checks for typedefs, structures, and compiler characteristics.
#
AC_C_BIGENDIAN
AC_CHECK_TYPES([off_t])
AC_TYPE_PID_T
AX_CREATE_STDINT_H
WARNING_CFLAGS=
AX_CHECK_COMPILE_FLAG([-Werror=implicit-function-declaration],
  [WARNING_CFLAGS="$WARNING_CFLAGS -Werror=implicit-function-declaration"],
  [],[])
AX_CHECK_COMPILE_FLAG([-Wno-deprecated-declarations],
  [WARNING_CFLAGS="$WARNING_CFLAGS -Wno-deprecated-declarations"],[],[])
AX_CHECK_COMPILE_FLAG([-Wpedantic],
  [AX_CHECK_COMPILE_FLAG([-pedantic-errors],
    [WARNING_CFLAGS="$WARNING_CFLAGS -pedantic-errors"],[],[])
   WARNING_CFLAGS="$WARNING_CFLAGS -Wno-pedantic"],
  [],[])
AX_CHECK_COMPILE_FLAG([-Wno-pointer-sign],
  [WARNING_CFLAGS="$WARNING_CFLAGS -Wno-pointer-sign"],[],[])
AC_SUBST([WARNING_CFLAGS])
#
############################################################################
#
# Checks for library functions.
#
AC_FUNC_ERROR_AT_LINE
AC_FUNC_FORK
AC_FUNC_MKTIME
AC_FUNC_MMAP
AC_FUNC_STRCOLL
AC_FUNC_STRTOD
AC_CHECK_FUNCS([alarm atexit dup2 endpwent fesetround fseeko ftello])
AC_CHECK_FUNCS([getcwd gethostbyname gettimeofday])
AC_CHECK_FUNCS([mkdir munmap nl_langinfo putenv rmdir select])
AC_CHECK_FUNCS([setenv socket strcasecmp strdup strncasecmp tzset uname])
AC_CHECK_FUNC([tzset],[],
  [AC_DEFINE([_NO_TZSET],1,[Define if not using tzset.])])
#
AC_MSG_CHECKING([for isfinite])
AC_COMPILE_IFELSE(
  [AC_LANG_PROGRAM([[#include <math.h>]],[[int x=isfinite(1.0);]])],
  [AC_DEFINE([HAVE_ISFINITE],1,[Define if we have isfinite])
   AC_MSG_RESULT([yes])],[AC_MSG_RESULT([no])])
#
############################################################################
#
# Checks for system services
#
AC_SYS_LONG_FILE_NAMES
AX_AM_JOBSERVER
AS_IF([test '!' "x$KPSEWHICH" = "x"],[eightrenc=`"$KPSEWHICH" 8r.enc`])
AC_SUBST([eightrenc])
#
############################################################################
#
# User-settable options
#
# Define user options
#
AC_ARG_ENABLE([colour-build],
  [AS_HELP_STRING([--disable-colour-build],
    [turn off ANSI colour in build scripts])],
    [],
    [enable_colour_build=yes])
AC_ARG_ENABLE([color-build],[dnl],[],[enable_color_build=yes])
#
AC_ARG_ENABLE([debug],
  [AS_HELP_STRING([--enable-debug],[turn on debug build])],
  [],
  [enable_debug=no])
AS_IF([test "x$enable_debug" = xyes],
  [CFLAGS="$CFLAGS -g -O0" ; CPPFLAGS="$CPPFLAGS -g -O0"])
#
AC_ARG_WITH([valgrind],
  [AS_HELP_STRING([--with-valgrind],
    [use Valgrind for tests if available])],
    [],
    [with_valgrind=no])
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
AM_CONDITIONAL([COND_VALGRIND],[test '!' "$with_valgrind" = no])
#
############################################################################
#
# Generate output
#
AH_TOP([#ifndef _FF_CONFIG_H
#define _FF_CONFIG_H 1])
AH_BOTTOM([#endif])
AC_SUBST([andt],[])
AC_SUBST([HOST],["$host"])
AC_SUBST([MACAPP])
AC_CONFIG_FILES([Makefile doc/fontanvil.1])
AC_CONFIG_COMMANDS([fix-makefile],
  [if test '!' "x$ICEMAP" = "x" ; then "$PERL" -i -pe \
's/^(@<:@a-z\-@:>@+:) (\$\(BUILT_SOURCES\))/'\
'\1\n\t@\$(MAKE) -q \2 || \$(MAKE) \$(AM_MAKEFLAGS) \2/;' Makefile ; fi ; \
"$PERL" -i -pe \
's#\t-\@?(test -z.* || )?rm -(r?)f (.*)#'\
'\t\$(TSU_V_RM) '"'"'\3'"'"' \$(TSU_V_CHOPPER)\n'\
'\t-\$(A''M_V_at)\1rm -\2f \3#;' \
   Makefile],
  [PERL=$PERL
   ICEMAP=$ICEMAP])
TSU_BAD_PATHS
AC_OUTPUT
#
############################################################################
#
# Display a status table
#
AS_ECHO([])
TSU_COLOURISE([FontAnvil configuration status],[5])AS_ECHO([])
#
AS_ECHO([])
TSU_COLOURISE([Requirements for all builds],[7])AS_ECHO([])
AS_ECHO_N(["freetype2         "])
  AS_IF([test "x$have_freetype2" = "xno"],
    [TSU_COLOURISE([no],[1])
     AS_ECHO_N(["     http://freetype.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["gzip              "])
  AS_IF([test "x$GZIP" = "x"],
    [TSU_COLOURISE([no],[1])
     AS_ECHO_N(["     http://gzip.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["perl              "])
  AS_IF([test "x$PERL" = "x"],
    [TSU_COLOURISE([no],[1])
     AS_ECHO_N(["     http://perl.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
#
AS_IF([test -e "$srcdir/.checked_out"],[
  AS_ECHO([])
  TSU_COLOURISE([Requirements for source control builds],[7])AS_ECHO([])
  AS_ECHO_N(["autoconf          "])
    AS_IF([test "x$AUTOCONF" = "x"],
      [TSU_COLOURISE([no],[1])
       AS_ECHO_N(["     http://gnu.org/software/autoconf/"])],
      [TSU_COLOURISE([yes],[2])])
    AS_ECHO([])
  AS_ECHO_N(["automake          "])
    AS_IF([test "x$AUTOMAKE" = "x"],
      [TSU_COLOURISE([no],[1])
       AS_ECHO_N(["     http://gnu.org/software/automake/"])],
      [TSU_COLOURISE([yes],[2])])
    AS_ECHO([])
  AS_ECHO_N(["icemap            "])
    AS_IF([test "x$ICEMAP" = "x"],
      [TSU_COLOURISE([no],[1])
       AS_ECHO_N(["     http://tsukurimashou.osdn.jp/"])],
      [TSU_COLOURISE([yes],[2])])
    AS_ECHO([])
  AS_ECHO_N(["lex               "])
    AS_IF([$LEX --version > /dev/null 2> /dev/null],
      [TSU_COLOURISE([yes],[2])],
      [TSU_COLOURISE([no],[1])
       AS_ECHO_N(["     http://flex.sourceforge.net/"])])
    AS_ECHO([])
  ])
#
AS_ECHO([])
TSU_COLOURISE([Optional items],[7])AS_ECHO([])
AS_ECHO_N(["cflow             "])
  AS_IF([test "x$CFLOW" = "x"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://gnu.org/software/cflow/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["giflib            "])
  AS_IF([test "x$with_giflib" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://giflib.sourceforge.net/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["kleknev           "])
  AS_IF([test "x$KLEKNEV" = "x"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://tsukurimashou.osdn.jp/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["libjpeg           "])
  AS_IF([test "x$with_libjpeg" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://ijg.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["libpng            "])
  AS_IF([test "x$with_libpng" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://libpng.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["libreadline       "])
  AS_IF([test "x$with_libreadline" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://gnu.org/software/readline/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["libspiro          "])
  AS_IF([test "x$with_libspiro" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     https://github.com/fontforge/libspiro/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["libtiff           "])
  AS_IF([test "x$with_libtiff" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://libtiff.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["libunicodenames   "])
  AS_IF([test "x$with_libunicodenames" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     https://bitbucket.org/sortsmill/libunicodenames/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["libuninameslist   "])
  AS_IF([test "x$with_libuninameslist" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     https://github.com/fontforge/libuninameslist/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["libxml2           "])
  AS_IF([test "x$with_libxml2" = "xno"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://xmlsoft.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["TeX               "])
  AS_IF([test "x$KPSEWHICH" = "x"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://tug.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["valgrind          "])
  AS_IF([test "x$VALGRIND" = "x"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://valgrind.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO([])
AS_IF([test "x$has_bad_paths" = "xyes"],
  [AS_ECHO([])
   AS_ECHO(["The following pathnames contain illegal characters, such as spaces:"])
   AS_ECHO(["$all_bad_paths"])
   AS_ECHO(["Autotools-based build systems like this one cannot be expected to work"])
   AS_ECHO(["with such pathnames.  The system will attempt to continue anyway, but it"])
   AS_ECHO(["is quite likely to fail.  It would be better to eliminate all illegal"])
   AS_ECHO(["characters from pathnames before continuing."])
   ])
