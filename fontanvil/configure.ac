#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#

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

# FIXME these directory deletions are from Tsukurimashou - audit them for
# appropriateness to FontAnvil!

# exec-prefix is special because it's an install dir option without "dir"
TSUKU_DELETE_CMDLINE_OPTION([exec-prefix])
TSUKU_DEFINITION_SUBST([_AC_INIT_PARSE_ARGS],
                         [for ac_var in\([^#]*\)\bexec_prefix\b],
                         [for ac_var in\1])

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
TSUKU_DELETE_INSTDIR_OPTION([bin])
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

# generate a "case" pattern matching chunk
#   TSUKU_CASE_PATTERN_CHUNK(option,shortest,before,after)
m4_define([TSUKU_CASE_PATTERN_CHUNK],
  [$3$1$4[]m4_if([$1],[$2],[],
  [TSUKU_CASE_PATTERN_CHUNK(m4_substr($1,0,m4_eval(m4_len($1)-1)),
      [$2],[$3],[$4])])])

# Add a new installation directory
#   TSUKU_ADD_INSTDIR_OPTION(dirname,under,default,help,abbrev,casebefore)
m4_define([TSUKU_ADD_INSTDIR_OPTION],
          [TSUKU_DEFINITION_SUBST([_AC_INIT_PARSE_ARGS],
                                  [AC_SUBST(\[$2\].*)dnl\
],
                                  [\&AC_SUBST([$1dir],['${$2}/$3'])dnl\
])
           TSUKU_DEFINITION_SUBST([_AC_INIT_HELP],
                                  [\
\(.*--$2=.*\)\
],
                                  m4_expand([\
\1\
AS_HELP_STRING([--$1dir=DIR],m4_expand([$4 @<:@m4_toupper([$2])/$3@:>@]))\
]))
           TSUKU_DEFINITION_SUBST([_AC_INIT_PARSE_ARGS],
                                  [\
\(.*$6.*\)\
],
                                  [\
  -$1dir[]TSUKU_CASE_PATTERN_CHUNK([$1dir],[$5],[ | --],[])@:}@
    ac_prev=$1dir ;;
  -$1dir=*TSUKU_CASE_PATTERN_CHUNK([$1dir],[$5],[ | --],[=*])@:}@
    $1dir=$ac_optarg ;;\
\
\1\
])
           TSUKU_DEFINITION_SUBST([_AC_INIT_PARSE_ARGS],
                                  [for ac_var in\([^#]*.\b$2\)\b],
                                  [for ac_var in\1 $1dir])])

# Add our new directories
TSUKU_ADD_INSTDIR_OPTION([font],[datarootdir],[fonts],[fonts],
  [f],[obsolete gas option])
TSUKU_ADD_INSTDIR_OPTION([ttf],[fontdir],[TTF],
  [TrueType fonts (parasite only)],
  [tt],[ --prefix ])
TSUKU_ADD_INSTDIR_OPTION([otf],[fontdir],[OTF],[OpenType fonts],
  [ot],[ --prefix ])

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
AC_INIT([FontAnvil],[0.2],[mskala@ansuz.sooke.bc.ca],[fontanvil],
  [[http://tsukurimashou.osdn.jp/]])
AC_PRESERVE_HELP_ORDER
AC_CONFIG_AUX_DIR([config])
AM_INIT_AUTOMAKE([foreign check-news color-tests
  parallel-tests silent-rules subdir-objects])
AC_CONFIG_SRCDIR([fontanvil/main.c])
AC_CONFIG_HEADERS([inc/fontanvil-config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_TESTDIR([tests],[fontanvil])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_REVISION([$Id: configure.ac 2831 2014-03-02 07:18:54Z mskala $])
AC_COPYRIGHT([Copyright (C) 2014 Matthew Skala])
AC_SUBST([release_date],["March 2, 2014"])
AM_SILENT_RULES
AC_USE_SYSTEM_EXTENSIONS
#
############################################################################
#
# Pass version numbers and dates
#
AC_DEFINE([FONTANVIL_VERSION_MAJOR],[0],[FontAnvil Major Version])
AC_DEFINE([FONTANVIL_VERSION_MINOR],[1],[FontAnvil Minor Version])
AC_SUBST([VERSION_MAJOR],[0])
AC_SUBST([VERSION_MINOR],[1])
AC_SUBST([VERSION_PATCH],[0])
AC_SUBST([FONTANVIL_VERSION],[0.1.0])
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
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PROG_RANLIB
AC_PROG_SED
AC_PATH_PROG([AUTOCONF],[autoconf])
AC_PATH_PROG([AUTOMAKE],[automake])
AC_PATH_PROG([GZIP],[gzip])
AC_ARG_VAR([KLEKNEV],[Kleknev])
AC_PATH_PROG([KLEKNEV],[kleknev],[/bin/sh],[$PATH:$PWD/kleknev])
AC_PATH_PROG([MAKE],[make])
AX_CHECK_GNU_MAKE
AC_PATH_PROG([MSGFMT],[msgfmt],[msgfmt])
AC_ARG_VAR([PDFLATEX],[PDFLaTeX])
AC_PATH_PROG([PDFLATEX],[pdflatex])
AC_ARG_VAR([PERL],[Perl])
AC_PATH_PROG([PERL],[perl])
AC_PATH_PROG([UNZIP],[unzip],[unzip])
#
gmake_version=unknown
missing_gmake_version=yes
AC_MSG_CHECKING([GNU Make version])
AS_IF([test "x$PERL" = "x" || test "x$MAKE" = "x"],[],
  [missing_gmake_version=no
gmake_version=dnl
`$MAKE --version | perl -ne 'print $1 if /^GNU Make.*(\d+\.\d+)/'`
   AS_VERSION_COMPARE([$gmake_version],[3.82],
     [missing_gmake_version=yes])])
AC_MSG_RESULT([$gmake_version])
#
PKG_PROG_PKG_CONFIG
#
############################################################################
#
# Checks for libraries.
#
AC_SEARCH_LIBS([cos],[m])
#
PKG_CHECK_MODULES([FREETYPE],[freetype2])
PKG_CHECK_MODULES([GLIB],[glib-2.0 >= 2.6 gio-2.0])
AC_SEARCH_LIBS([iconv],[iconv])
PKG_CHECK_MODULES([ZLIB],[zlib],[],[AC_SEARCH_LIBS([inflate],[z])])
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
AC_ARG_WITH([libxml],
 [AS_HELP_STRING([--with-libxml=PATH],
   [XML file format library [auto]])],
   [],
   [with_libxml=auto])
#
# process library enable options
#
AC_ARG_VAR([GIFLIB_CFLAGS],[C compiler flags for giflib])
AC_ARG_VAR([GIFLIB_LIBS],[linker flags for giflib])
AC_SEARCH_LIBS([DGifOpenFileName],[gif ungif],[],[with_giflib=no])
AM_CONDITIONAL([COND_GIFLIB],[test '!' "x$with_giflib" = xno])
AC_SUBST([GIFLIB_CFLAGS])
AC_SUBST([GIFLIB_LIBS])
AS_IF([test '!' "x$with_giflib" = xno],
  [],
  [AC_DEFINE([_NO_LIBUNGIF],1,[Define if not using system giflib.])])
#
AC_ARG_VAR([LIBJPEG_CFLAGS],[C compiler flags for libjpeg])
AC_ARG_VAR([LIBJPEG_LIBS],[linker flags for libjpeg])
AC_SEARCH_LIBS([jpeg_CreateDecompress],[jpeg],[],[with_libjpeg=no])
AM_CONDITIONAL([COND_LIBJPEG],[test '!' "x$with_libjpeg" = xno])
AC_SUBST([LIBJPEG_CFLAGS])
AC_SUBST([LIBJPEG_LIBS])
AS_IF([test '!' "x$with_libjpeg" = xno],
  [],
  [AC_DEFINE([_NO_LIBJPEG],1,[Define if not using libjpeg.])])
#
AC_ARG_VAR([LIBPNG_CFLAGS],[C compiler flags for libpng])
AC_ARG_VAR([LIBPNG_LIBS],[linker flags for libpng])
PKG_CHECK_MODULES([LIBPNG],[libpng],[],[with_libpng=no])
AM_CONDITIONAL([COND_LIBPNG],[test '!' "x$with_libpng" = xno])
AC_SUBST([LIBPNG_CFLAGS])
AC_SUBST([LIBPNG_LIBS])
AS_IF([test '!' "x$with_libpng" = xno],
  [],
  [AC_DEFINE([_NO_LIBPNG],1,[Define if not using libpng.])])
#
AC_ARG_VAR([LIBREADLINE_CFLAGS],[C compiler flags for libreadline])
AC_ARG_VAR([LIBREADLINE_LIBS],[linker flags for libreadline])
AC_SEARCH_LIBS([rl_readline_version],[readline],
  [AC_SEARCH_LIBS([tgetflag],[termcap],[],[])],
  [with_libreadline=no],[-ltermcap])
AM_CONDITIONAL([COND_LIBREADLINE],[test '!' "x$with_libreadline" = xno])
AC_SUBST([LIBREADLINE_CFLAGS])
AC_SUBST([LIBREADLINE_LIBS])
AS_IF([test '!' "x$with_libreadline" = xno],
  [AC_CHECK_HEADER([readline/readline.h])],
  [AC_DEFINE([_NO_LIBREADLINE],1,[Define if not using libreadline.])])
#
AC_ARG_VAR([LIBSPIRO_CFLAGS],[C compiler flags for libspiro])
AC_ARG_VAR([LIBSPIRO_LIBS],[linker flags for libspiro])
AC_SEARCH_LIBS([TaggedSpiroCPsToBezier],[spiro],[],[with_libspiro=no])
AM_CONDITIONAL([COND_LIBSPIRO],[test '!' "x$with_libspiro" = xno])
AC_SUBST([LIBSPIRO_CFLAGS])
AC_SUBST([LIBSPIRO_LIBS])
AS_IF([test '!' "x$with_libspiro" = xno],
  [],
  [AC_DEFINE([_NO_LIBSPIRO],1,[Define if not using libspiro.])])
#
AC_ARG_VAR([LIBTIFF_CFLAGS],[C compiler flags for libtiff])
AC_ARG_VAR([LIBTIFF_LIBS],[linker flags for libtiff])
PKG_CHECK_MODULES([LIBTIFF],[libtiff-4],[],
  [AC_SEARCH_LIBS([TIFFClose],[tiff],[],[with_libtiff=no])])
AM_CONDITIONAL([COND_LIBTIFF],[test '!' "x$with_libtiff" = xno])
AC_SUBST([LIBTIFF_CFLAGS])
AC_SUBST([LIBTIFF_LIBS])
AS_IF([test '!' "x$with_libtiff" = xno],
  [],
  [AC_DEFINE([_NO_LIBTIFF],1,[Define if not using libtiff.])])
#
AC_ARG_VAR([LIBUNICODENAMES_CFLAGS],[C compiler flags for libunicodenames])
AC_ARG_VAR([LIBUNICODENAMES_LIBS],[linker flags for libunicodenames])
AC_SEARCH_LIBS([UnicodeNamesAnnot],[unicodenames],[],[with_libunicodenames=no])
AM_CONDITIONAL([COND_LIBUNICODENAMES],[test '!' "x$with_libunicodenames" = xno])
AC_SUBST([LIBUNICODENAMES_CFLAGS])
AC_SUBST([LIBUNICODENAMES_LIBS])
AS_IF([test '!' "x$with_libunicodenames" = xno],
  [],
  [AC_DEFINE([_NO_LIBUNICODENAMES],1,[Define if not using libunicodenames.])])
#
AC_ARG_VAR([LIBUNINAMESLIST_CFLAGS],[C compiler flags for libuninameslist])
AC_ARG_VAR([LIBUNINAMESLIST_LIBS],[linker flags for libuninameslist])
AC_SEARCH_LIBS([UnicodeNamesAnnot],[uninameslist],[],[with_libuninameslist=no])
AM_CONDITIONAL([COND_LIBUNINAMESLIST],[test '!' "x$with_libuninameslist" = xno])
AC_SUBST([LIBUNINAMESLIST_CFLAGS])
AC_SUBST([LIBUNINAMESLIST_LIBS])
AS_IF([test '!' "x$with_libuninameslist" = xno],
  [],
  [AC_DEFINE([_NO_LIBUNINAMESLIST],1,[Define if not using libuninameslist.])])
#
AC_ARG_VAR([LIBXML_CFLAGS],[C compiler flags for libxml])
AC_ARG_VAR([LIBXML_LIBS],[linker flags for libxml])
PKG_CHECK_MODULES([LIBXML],[libxml],[],[with_libxml=no])
AM_CONDITIONAL([COND_LIBXML],[test '!' "x$with_libxml" = xno])
AC_SUBST([LIBXML_CFLAGS])
AC_SUBST([LIBXML_LIBS])
AS_IF([test '!' "x$with_libxml" = xno],
  [],
  [AC_DEFINE([_NO_LIBXML],1,[Define if not using libxml.])])
#
############################################################################
#
# Checks for header files.
#
AC_CHECK_HEADERS([arpa/inet.h fcntl.h ieeefp.h])
AC_CHECK_HEADERS([memory.h netdb.h netinet/in.h pthread.h])
AC_CHECK_HEADERS([strings.h sys/ioctl.h sys/socket.h sys/time.h unistd.h])
AC_CHECK_HEADERS([iconv.h])
#
############################################################################
#
# Checks for typedefs, structures, and compiler characteristics.
#
AC_C_BIGENDIAN
AC_CHECK_TYPES([off_t])
AC_TYPE_PID_T
AX_PTHREAD
AX_CREATE_STDINT_H
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
  [enable_debug=yes],
  [enable_debug=no])
AS_IF([test "x$enable_debug" = xyes],
  [CFLAGS="$CFLAGS -g -O0" ; CPPFLAGS="$CPPFLAGS -g -O0"])
#
AC_ARG_ENABLE([real],
  [AS_HELP_STRING([--enable-real=TYPE],
    [choose data type for real numbers])],
    [my_real_type="${enableval}"],
    [my_real_type=double])
AS_IF([test x"${my_real_type}" = x"double"],
  [AC_DEFINE([FONTANVIL_CONFIG_USE_DOUBLE],1,
    [Define if using double precision.])],
  [AS_IF([test x"${my_real_type}" != x"float"],
    [AC_MSG_ERROR([Floating point type '${my_real_type}' not recognized.])],
    [])])
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
# Evaluate what we can and can't do
#

can_build=yes

AC_MSG_CHECKING([core prerequisites])
can_core=yes
AS_IF([test "x$FONTANVIL" = "x" || test '!' -r "$FONTANVIL"],
  [missing_fontanvil=yes
   can_core=no])
AS_IF([test "x$_cv_gnu_make_command" = "x"],
  [missing_gmake=yes
   can_core=no])
AS_IF([test '!' "x$missing_gmake_version" = "xno"],
  [missing_gmake=yes
   can_core=no])
AS_IF([test "x$MPOST" = "x"],
  [missing_mpost=yes
   can_core=no],
  [mpost_version=`$MPOST --version | $PERL -ne 'print $1 if /MetaPost\s+(@<:@0-9.@:>@+)/'`
   AS_VERSION_COMPARE([$mpost_version],[1.501],
     [mpost_version_warn=yes])
   ])
AS_IF([test "x$PERL" = "x"],
  [missing_perl=yes
   can_core=no])
AS_IF([test "$tsu_prolog_style" = "unknown"],
  [missing_prolog=yes
   can_core=no])
AS_IF([test '!' "$ac_cv_sys_long_file_names" = "yes"],[can_core=no])
AS_IF([test "$can_core" = "no"],[can_build=no])
AC_MSG_RESULT([$can_core])

AC_MSG_CHECKING([proportional spacing prerequisites])
can_proportional=yes
AS_IF([test "x$CC" = "x"],
  [missing_cc=yes
   can_proportional=no])
AS_IF([test "$enable_proportional" = "yes" && test "$can_proportional" = "no"],
  [can_build=no])
AC_MSG_RESULT([$can_proportional])

AC_MSG_CHECKING([safety of silent build rules])
can_silent_rules=yes
AS_IF([test "x$EXPECT" = "x"],
  [missing_expect=yes
   can_silent_rules=no])
AC_MSG_RESULT([$can_silent_rules])

AC_MSG_CHECKING([FontAnvil debuggery])
can_ffdebug=yes
AS_IF([test "x$FONTANVIL" = "x" || test '!' -r "$FONTANVIL"],
  [missing_fontanvil=yes
   can_ffdebug=no])
AS_IF([test "x$CC" = "x"],
  [missing_cc=yes
   can_ffdebug=no])
AS_IF([test "x$GREP" = "x"],
  [missing_grep=yes
   can_ffdebug=no])
AS_IF([test "x$GDB" = "x"],
  [missing_gdb=yes
   can_ffdebug=no])
AS_IF([test "$can_ffdebug" = "yes"],
  [gdb_result=`echo q | $GDB -q -n -s $FONTANVIL 2> /dev/null | $GREP 'no debug'`
   AS_IF([test "x$gdb_result" = "x"],[],
     [missing_ff_debugsymbols=yes
      can_ffdebug=no])])
AC_MSG_RESULT([$can_ffdebug])

AC_MSG_CHECKING([build-system hackability])
can_bshack=yes
AS_IF([test "x$AUTOCONF" = "x"],
  [missing_autoconf=yes
   can_bshack=no])
AS_IF([test "x$AUTOMAKE" = "x"],
  [missing_automake=yes
   can_bshack=no])
AS_IF([test "x$PERL" = "x" || test "x$AUTOCONF" = "x"],[],
  [autoconf_version=dnl
`autoconf --version | perl -ne 'print $1 if /^autoconf.*(\d+\.\d+)/'`
   AS_VERSION_COMPARE([$autoconf_version],[2.65],
     [missing_autoconf_version=yes
      can_bshack=no])
   AS_VERSION_COMPARE([$autoconf_version],[2.75],[],[],
     [excessive_autoconf_version=yes
      can_bshack=no])])
AC_MSG_RESULT([$can_bshack])
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
AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([fontanvil/GNUmakefile])
AC_CONFIG_FILES([fontanvil/darwinsetup],[chmod +x fontanvil/darwinsetup])
AC_OUTPUT
#
############################################################################
#
# Display a status table
#

# FIXME FIXME FIXME

#
# Warn about missing prerequisites
#

# FontForge's advisory URLs, for reference when revising this section:
# freetype_url="http://www.freetype.org/"
# giflib_url="http://giflib.sourceanvil.net/"
# libpng_url="http://www.libpng.org/"
# libxml_url="http://www.xmlsoft.org/"
# libspiro_url="https://github.com/fontanvil/libspiro"
# libuninameslist_url="https://github.com/fontanvil/libuninameslist"
# libunicodenames_url="https://bitbucket.org/sortsmill/libunicodenames"
# libreadline_url="http://www.gnu.org/software/readline"
# libjpeg_url="http://en.wikipedia.org/wiki/Libjpeg"
# libtiff_url="http://en.wikipedia.org/wiki/Libtiff"
