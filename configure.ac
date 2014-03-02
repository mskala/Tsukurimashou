#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#

#
# Configuration source for Tsukurimashou
# Copyright (C) 2011, 2012, 2013  Matthew Skala
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.
#
# As a special exception, if you create a document which uses this font, and
# embed this font or unaltered portions of this font into the document, this
# font does not by itself cause the resulting document to be covered by the
# GNU General Public License. This exception does not however invalidate any
# other reasons why the document might be covered by the GNU General Public
# License. If you modify this font, you may extend this exception to your
# version of the font, but you are not obligated to do so. If you do not
# wish to do so, delete this exception statement from your version.
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
AC_PREREQ([2.67])
AC_INIT([Tsukurimashou],[0.8],[mskala@ansuz.sooke.bc.ca],[tsukurimashou],
  [[http://tsukurimashou.sourceforge.jp/]])
AC_PRESERVE_HELP_ORDER
AM_INIT_AUTOMAKE([foreign check-news color-tests dist-zip no-dist-gzip
  parallel-tests silent-rules subdir-objects])
AC_CONFIG_SRCDIR([hamlog/hamlog])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_REVISION([$Id: configure.ac 2831 2014-03-02 07:18:54Z mskala $])
AC_COPYRIGHT([Copyright (C) 2011, 2012, 2013 Matthew Skala])
AC_SUBST([release_date],["August 26, 2013"])
AM_SILENT_RULES
#
############################################################################
#
# Checks for programs (and other things controlled by environment variables)
#
AC_PROG_CC
AC_PROG_CC_C_O
AC_PROG_CPP
AC_PROG_GREP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PATH_PROG([AUTOCONF],[autoconf])
AC_PATH_PROG([AUTOMAKE],[automake])
AC_PATH_PROGS([CHECKSUM],[sha256sum sha1sum md5sum cksum wc],[no])
AC_ARG_VAR([EXPECT],[Expect])
AC_PATH_PROG([EXPECT],[expect])
AM_CONDITIONAL([COND_EXPECT],[test '!' "x$EXPECT" = "x"])
AC_ARG_VAR([FONTANVIL],[FontAnvil])
AC_PATH_PROGS([FONTANVIL],[fontanvil fontforge])
AC_ARG_VAR([FONTLINT_FLAGS],[Flags for fontlint])
AC_PATH_TOOL([GDB],[gdb])
AX_CHECK_GNU_MAKE
AC_PATH_PROG([GZIP],[gzip])
AC_ARG_VAR([KLEKNEV],[Kleknev])
AC_PATH_PROG([KLEKNEV],[kleknev],[/bin/sh],[$PATH:$PWD/kleknev])
AC_PATH_PROG([MAKE],[make])
AC_ARG_VAR([MPOST],[MetaPost])
AC_PATH_PROG([MPOST],[mpost])
AC_ARG_VAR([PERL],[Perl])
AC_PATH_PROG([PERL],[perl])
AC_PATH_PROGS([PROLOG],[pl swipl eclipse gprolog],[])
AC_ARG_VAR([XDVIPDFMX],[xdvipdfmx])
AC_PATH_PROG([XDVIPDFMX],[xdvipdfmx])
AC_ARG_VAR([XELATEX],[XeLaTeX])
AC_PATH_PROG([XELATEX],[xelatex])
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
AS_IF([test "x$KLEKNEV" = "x"],[KLEKNEV=/bin/sh])
#
############################################################################
#
# Checks for libraries.
#
AC_CHECK_LIB([m], [pow])
AX_PERL_MODULE_VERSION([XML::Parser 2.36],[have_perlxml=yes],
  [have_perlxml=no
   can_full_idsgrep=no])
AC_CHECK_LIB([bdd],[bdd_init],[have_buddy=yes],
  [have_buddy=no
   can_full_idsgrep=no])
PKG_CHECK_MODULES([PCRE],[libpcre],[have_pcre=yes],
  [have_pcre=no
   can_full_idsgrep=no])
#
############################################################################
#
# Checks for header files.
#
AC_CHECK_HEADERS([fcntl.h limits.h stdlib.h string.h])
AX_CREATE_STDINT_H
#
############################################################################
#
# Checks for typedefs, structures, and compiler characteristics.
#
AC_TYPE_INT64_T
AC_FUNC_OBSTACK
AC_TYPE_UINT16_T
AC_TYPE_UINT64_T
#
############################################################################
#
# Checks for library functions.
#
AC_CHECK_FUNCS([memmove])
AC_CHECK_FUNCS([pow])
AC_CHECK_FUNCS([strchr strdup strerror strrchr strstr strtol strtoul])
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
AC_ARG_ENABLE([build-hacking],
  [AS_HELP_STRING([--disable-build-hacking],
    [turn off Autotools compatibility test])],
    [],
    [enable_build_hacking="test    "])
AC_ARG_ENABLE([chars],
  [AS_HELP_STRING([--enable-chars[=TAGS]],
    [character set(s) to build [all]])],
    [],
    [enable_chars=all])
AC_ARG_ENABLE([colour-build],
  [AS_HELP_STRING([--disable-colour-build],
    [turn off ANSI colour in build scripts])],
    [],
    [enable_colour_build=yes])
AC_ARG_ENABLE([color-build],[dnl],[],[enable_color_build=yes])
AC_ARG_ENABLE([docs],
  [AS_HELP_STRING([--disable-docs],
    [turn off PDF documentation])],
    [],
    [enable_docs=yes])
AC_ARG_ENABLE([ff-debug],
  [AS_HELP_STRING([--disable-ff-debug],
    [turn off FontAnvil debuggery warning])],
    [],
    [enable_ff_debug="test    "])
AC_ARG_ENABLE([kanji-chart],
  [AS_HELP_STRING([--enable-kanji-chart],
    [kanji coverage chart [auto]])],
    [],
    [enable_kanji_chart=auto])
AC_ARG_ENABLE([ot-features],
  [AS_HELP_STRING([--enable-ot-features[=TAGS]],
    [OpenType feature(s) to include [all,-pfed]])],
    [],
    [ot_feature_default_warn=yes
     enable_ot_features='all,-pfed'])
AC_ARG_ENABLE([parasites],
  [AS_HELP_STRING([--enable-parasites[=TAGS]],
    [Parasite package(s) to build [none]])],
    [],
    [enable_parasites='none'])
AC_ARG_ENABLE([proofs],
  [AS_HELP_STRING([--enable-proofs=[yes|no|book]],
    [proofs and pretty-printed source [no]])],
    [],
    [enable_proofs=no])
AC_ARG_ENABLE([proportional],
  [AS_HELP_STRING([--disable-proportional],
    [turn off proportionally spaced, kerned fonts])],
    [],
    [enable_proportional=yes])
AC_ARG_ENABLE([styles],
  [AS_HELP_STRING([--enable-styles[=TAGS]],
    [type style(s) to build [tsuku&normal,mg&el,mg&eq]])],
    [],
    [enable_styles="tsuku&normal,mg&el,mg&eq"])
AC_ARG_WITH([kanjidic2],
  [AS_HELP_STRING([--with-kanjidic2=PATH],
    [gzipped KANJIDIC2 database [auto]])],
    [],
    [with_kanjidic2=auto])
AC_ARG_WITH([prolog],
  [AS_HELP_STRING([--with-prolog=PATH],
    [Prolog interpreter [auto]])],
    [],
    [with_prolog=auto])
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
AS_IF([test "x$FONTLINT_FLAGS" = "x"],[FONTLINT_FLAGS="-w 2"])
#
AC_SUBST([enable_chars])
#
AM_CONDITIONAL([COND_DOCS],[test '!' "$enable_docs" = no])
AC_SUBST([enable_docs])
#
AC_SUBST([enable_ot_features])
#
AC_SUBST([enable_parasites])
AS_IF([test "x$enable_parasites" = "xnone"],[],
      [AC_CONFIG_SUBDIRS([beikaitoru genjimon idsgrep kleknev ocr])])
#
AS_IF([test "x$prefix" = "xNONE"],[prefix="$ac_default_prefix"])
AS_IF([test "$with_kanjidic2" = "auto"],[
AC_MSG_CHECKING([for KANJIDIC2])
AS_IF([test "x$GZIP" = x],
      [with_kanjidic2=no
       AC_MSG_RESULT([can't, no gzip])],
      [m4_foreach_w([kdcheckpath],m4_expand([$srcdir $srcdir/doc dnl
$prefix/dict $prefix/share dnl
/dict /share /usr/dict /usr/share/dict /usr/local/dict dnl
/usr/local/share/dict $HOME $HOME/dict]),[
       AS_IF([test "$with_kanjidic2" = "auto"],
             [AS_IF([test -r "kdcheckpath/kanjidic2.xml.gz"],
                    [with_kanjidic2="kdcheckpath/kanjidic2.xml.gz"])])])
       AS_IF([test "$with_kanjidic2" = "auto"],[with_kanjidic2=no])
       AC_MSG_RESULT([$with_kanjidic2])
       ])
])
AM_CONDITIONAL([COND_KANJIDIC2], [test '!' "$with_kanjidic2" = no])
AC_SUBST([with_kanjidic2])
#
AS_IF([test "x$enable_kanji_chart" = "xauto"],
  [AS_IF([test "$with_kanjidic2" = "no"],
    [enable_kanji_chart=no],[enable_kanji_chart=yes])])
AM_CONDITIONAL([COND_KANJI_CHART], [test '!' "$enable_kanji_chart" = no])
AC_SUBST([enable_kanji_chart])
#
AS_IF([test "x$enable_silent_rules" = "x"],
  [enable_silent_rules=yes
   AM_DEFAULT_VERBOSITY=0])
#
AC_MSG_CHECKING([Prolog type])
tsu_prolog_style=unknown
case "x$with_prolog" in #(((((
  xno) :
    AC_MSG_RESULT([no])
    AS_ECHO(["Tsukurimashou must have some sort of logic programming environment in order"])
    AS_ECHO(["to build at all; --with-prolog=no is not allowed.  Use --with-prolog=hamlog"])
    AS_ECHO(["to use the included Hamlog interpreter, or leave --with-prolog out entirely"])
    AS_ECHO(["(or =auto) for autodetection."])
    AC_MSG_ERROR([cannot proceed]) ;;
  xauto) :
    AS_IF([test "x$PROLOG" = "x"],
      [PROLOG="$PERL ./hamlog"
       tsu_prolog_style=hamlog]) ;;
  xyes) :
    AS_IF([test "x$PROLOG" = "x"],
      [PROLOG="$PERL ./hamlog"
       tsu_prolog_style=hamlog]) ;;
  xhamlog) :
    PROLOG="$PERL ./hamlog" 
    tsu_prolog_style=hamlog ;;
  *) :
    PROLOG="$with_prolog" ;;
esac;
AS_IF([test "$tsu_prolog_style" = "unknown" \
  && test '!' "x$with_prolog" = "x$PROLOG"],[
case "$PROLOG" in #(
  *eclipse*) :
    PROLOG="$PERL ./hamlog"
    tsu_prolog_style=hamlog
    eclipse_prolog_warn=yes
  ;;
esac;
])
AS_IF([test "$tsu_prolog_style" = "unknown"],[
  prolog_version_result="`echo halt. | \
    $PROLOG -e 'get_flag(version,X),write(eclipse),write(X),halt.' 2>&1`"
  case "x$prolog_version_result" in #(((
    *SWI-Prolog*) :
      tsu_prolog_style=swi ;;
    *eclipse*) :
      tsu_prolog_style=eclipse ;;
    *GNU\ Prolog*) :
      tsu_prolog_style=gnu ;;
    *Hamlog*) :
      tsu_prolog_style=hamlog ;;
  esac;
])
AC_MSG_RESULT([$tsu_prolog_style])
AM_CONDITIONAL([COND_PROLOG_HAMLOG],[test "$tsu_prolog_style" = hamlog])
AM_CONDITIONAL([COND_PROLOG_SWI],[test "$tsu_prolog_style" = swi])
AM_CONDITIONAL([COND_PROLOG_GNU],[test "$tsu_prolog_style" = gnu])
AM_CONDITIONAL([COND_PROLOG_ECLIPSE],[test "$tsu_prolog_style" = eclipse])
#
AM_CONDITIONAL([COND_PROOFS], [test '!' "$enable_proofs" = no])
AM_CONDITIONAL([COND_BOOKPROOFS], [test "$enable_proofs" = book])
#
AM_CONDITIONAL([COND_PROPORTIONAL], [test '!' "$enable_proportional" = no])
AC_SUBST([enable_proportional])
#
AC_SUBST([enable_styles])
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

AC_MSG_CHECKING([PDF documentation prerequisites])
can_docs=yes
AS_IF([test "x$XDVIPDFMX" = "x"],
  [missing_xdvipdfmx=yes
   can_docs=no])
AS_IF([test "x$XELATEX" = "x"],
  [missing_xelatex=yes
   can_docs=no],
  [kprcs=`kpsewhich pgfrcs.code.tex`
   pgf_version=`cat $kprcs /dev/null | $PERL -ne 'print $1 if /^@<:@^%@:>@+pgfversion\{(.*)\}/'`
   AS_VERSION_COMPARE([$pgf_version],[2.00],
     [missing_pgf_version=yes
      can_docs=no])
   ])
AS_IF([test '!' "$enable_proportional" = "yes" \
  || test '!' "$can_proportional" = "yes"],
  [missing_proportional=yes
   can_docs=no])
AS_IF([test "$enable_docs" = "yes" && test "$can_docs" = "no"],
  [can_build=no])
AC_MSG_RESULT([$can_docs])

AC_MSG_CHECKING([kanji chart prerequisites])
can_kanji_chart=yes
AS_IF([test "x$XDVIPDFMX" = "x"],
  [missing_xdvipdfmx=yes
   can_kanji_chart=no])
AS_IF([test "x$XELATEX" = "x"],
  [missing_xelatex=yes
   can_kanji_chart=no])
AS_IF([test "$with_kanjidic2" = "no"],
  [missing_kanjidic2=yes
   can_kanji_chart=no])
AS_IF([test '!' "$enable_proportional" = "yes" \
  || test '!' "$can_proportional" = "yes"],
  [missing_proportional=yes
   can_kanji_chart=no])
AS_IF([test "$enable_kanji_chart" = "yes" && test "$can_kanji_chart" = "no"],
  [can_build=no])
AC_MSG_RESULT([$can_kanji_chart])

AC_MSG_CHECKING([proof prerequisites])
can_proofs=yes
AS_IF([test "x$XDVIPDFMX" = "x"],
  [missing_xdvipdfmx=yes
   can_proofs=no])
AS_IF([test "x$XELATEX" = "x"],
  [missing_xelatex=yes
   can_proofs=no],
  [kprcs=`kpsewhich pgfrcs.code.tex`
   pgf_version=`cat $kprcs /dev/null | $PERL -ne 'print $1 if /^@<:@^%@:>@+pgfversion\{(.*)\}/'`
   AS_VERSION_COMPARE([$pgf_version],[2.00],
     [missing_pgf_version=yes
      can_proofs=no])
   ])
AS_IF([test '!' "$enable_proportional" = "yes" \
  || test '!' "$can_proportional" = "yes"],
  [missing_proportional=yes
   can_proofs=no])
AS_IF([test '!' "$enable_proofs" = "no" && test "$can_proofs" = "no"],
  [can_build=no])
AC_MSG_RESULT([$can_proofs])

AC_MSG_CHECKING([whether PGF 2.10 workaround is needed])
need_pgf_workaround=no
AS_VERSION_COMPARE([$pgf_version],[2.10],[],[need_pgf_workaround=yes])
AM_CONDITIONAL([COND_PGFWORKAROUND],[test "x$need_pgf_workaround" = "xyes"])
AC_MSG_RESULT([$need_pgf_workaround])

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
  [gdb_result=`echo q | $GDB -q -n -s $FONTANVIL | $GREP 'no debug'`
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

AC_MSG_CHECKING([whether FontForge accepts AddExtrema(1)])
echo '#!/usr/local/bin/fontanvil' > ffaetest.pe
echo 'New();AddExtrema(1);' >> ffaetest.pe
AS_IF([$FONTANVIL ffaetest.pe >& /dev/null],
  [ae_arg_okay=yes],[ae_arg_okay=no])
rm ffaetest.pe
AC_SUBST([ae_arg_okay])
AC_MSG_RESULT([$ae_arg_okay])
#
############################################################################
#
# Generate output
#
AC_SUBST([andt],[])
AC_CONFIG_FILES([Makefile])
AC_CONFIG_COMMANDS([fix-makefile],
  [$PERL -i -pe \
's/ZZZZHACKZZZZ\s*=\s*//;$_="" if /\$\(error This Makefile must be /;'\
's#(\$\(AUTOMAKE\) --foreign( Makefile)?)(?! && ./config)#'\
'\1 && \$(SHELL) ./config.status fix-makefile#;'\
's#config\.status \$\@ \$\(am__depfiles_maybe\)#'\
'config.status \$\@ fix-makefile \$(am__depfiles_maybe)#;'\
's#TESTS = #TESTS = \$(otf_DATA) #;'\
's#^all: config.h#all: kill-empty config.h#;' \
   Makefile
   rm -f pfb-stamp* chl-stamp],
  [PERL=$PERL])
AC_OUTPUT
#
############################################################################
#
# Display a status table
#
AS_ECHO([])
TSU_COLOURISE([Configuration status],[5])AS_ECHO([])
AS_ECHO([])
TSU_COLOURISE([Component              Want    Can],[7])AS_ECHO([])
TSU_TABLE_LINE([Tsukurimashou core     ],[always  ],[yes],[$can_core])
TSU_TABLE_LINE([proportional spacing   ],[$enable_proportional],
  [$enable_proportional],[$can_proportional])
TSU_TABLE_LINE([PDF documentation      ],[$enable_docs],
  [$enable_docs],[$can_docs])
TSU_TABLE_LINE([kanji coverage chart   ],[$enable_kanji_chart],
  [$enable_kanji_chart],[$can_kanji_chart])
AS_IF([test "x$enable_proofs" = "xbook"],
  [TSU_TABLE_LINE([proofs                 ],[book    ],[book    ],
     [$can_proofs])],
  [TSU_TABLE_LINE([proofs                 ],[$enable_proofs],
     [$enable_proofs],[$can_proofs])])
AS_IF([test "x$enable_jobserver" = "xno"],
  [TSU_TABLE_LINE([parallel build jobs    ],[no],[no],[yes])],
  [wantline=`$PERL -e 'printf "%-8s","'$enable_jobserver/$CPU_COUNT'"'`
   TSU_TABLE_LINE([parallel build jobs    ],[$wantline],[yes],
     [yes])])
TSU_TABLE_LINE([silent build rules     ],[$enable_silent_rules],
  [$enable_silent_rules],[$can_silent_rules])
TSU_TABLE_LINE([fontanvil debugging    ],[$enable_ff_debug],
  [no],[$can_ffdebug])
TSU_TABLE_LINE([build-system hacking   ],[$enable_build_hacking],
  [no],[$can_bshack])
AS_ECHO([])
AS_ECHO_N(["Character selection    "])
TSU_COLOURISE([$enable_chars],[6])AS_ECHO([])
AS_ECHO_N(["Type style selection   "])
TSU_COLOURISE([$enable_styles],[6])AS_ECHO([])
AS_ECHO_N(["OpenType features      "])
TSU_COLOURISE([$enable_ot_features],[6])AS_ECHO([])
AS_ECHO_N(["Parasite packages      "])
TSU_COLOURISE([$enable_parasites],[6])AS_ECHO([])

#
# Warn about missing prerequisites
#

AS_IF([test "$can_core" = "no"],
  [AS_ECHO([])
   AS_ECHO(["One or more prerequisites for the Tsukurimashou core are missing:"])
   AS_IF([test "$missing_fontanvil" = "yes"],
     [AS_ECHO(["   FontAnvil             http://fontforge.sourceforge.net/"])])
   AS_IF([test "$missing_gmake" = "yes"],
     [AS_ECHO(["   GNU Make >=3.82       http://www.gnu.org/software/make/"])])
   AS_IF([test "$missing_mpost" = "yes"],
     [AS_ECHO(["   MetaPost              http://foundry.supelec.fr/gf/project/metapost/"])])
   AS_IF([test "$missing_perl" = "yes"],
     [AS_ECHO(["   Perl                  http://www.perl.org/"])])
   AS_IF([test "$missing_prolog" = "yes"],
     [AS_ECHO(["   logic programming     (should be built-in, did you override?)"])])
   AS_IF([test '!' "$ac_cv_sys_long_file_names" = "yes"],
     [AS_ECHO(["   long filename support"])])
   AS_ECHO(["Without the above it is not possible to build Tsukurimashou at all."])
   ])

AS_IF([test "x$mpost_version_warn" = "xyes"],
  [AS_ECHO([])
   AS_ECHO(["Warning:  your MetaPost is version $mpost_version, and it probably has"])
   AS_ECHO(["a limit of 2^25 \"independent variable instances.\"  It may fail when"])
   AS_ECHO(["performing long computations, as in the experimental blackletter fonts."])
   AS_ECHO(["Upgrading to at least version 1.501 will raise the limit to 2^31 (a"])
   AS_ECHO(["factor of 64) and increase the chances of successful compilation, but"])
   AS_ECHO(["unfortunately, as of this writing there is no version of MetaPost that"])
   AS_ECHO(["removes the limit entirely."])])

AS_IF([test "x$eclipse_prolog_warn" = "xyes"],
  [AS_ECHO([])
   AS_ECHO(["Warning:  configure detected something that might possibly be the"])
   AS_ECHO(["ECLiPSe-CLP logic programming system, but could not be positively"])
   AS_ECHO(["identified as such.  It is more likely the popular multilanguage IDE also"])
   AS_ECHO(["called Eclipse.  To avoid accidentally invoking a heavy GUI program"])
   AS_ECHO(["during configuration, configure will not investigate further and will"])
   AS_ECHO(["use the included (but very slow) Hamlog interpreter instead.  To"])
   AS_ECHO(["override this decision or disable this message, specify an appropriate"])
   AS_ECHO(["--with-prolog option."])])

AS_IF([test "x$ot_feature_default_warn" = "xyes"],
  [AS_ECHO([])
   AS_ECHO(["No choice of OpenType features was selected, so using all,-pfed by"])
   AS_ECHO(["default.  Please consider using --enable-ot-features=all to attach"])
   AS_ECHO(["detailed information about your installation to the generated fonts;"])
   AS_ECHO(["that is recommended, but not default because some people might consider"])
   AS_ECHO(["it a privacy threat.  See the documentation for more information, and"])
   AS_ECHO(["see txt/fontlog.txt after building to read the information that would"])
   AS_ECHO(["have been attached.  This message will go away with any use of the"])
   AS_ECHO(["--enable-ot-features option, such as --enable-ot-features=all,-pfed"])
   AS_ECHO(["to affirmatively choose the default value."])])

AS_IF([test '!' "x$enable_proportional" = "xno" \
  && test "$can_proportional" = "no"],
  [AS_ECHO([])
   AS_ECHO(["One or more prerequisites for proportional spacing and kerning are missing:"])
   AS_IF([test "$missing_cc" = "yes"],
     [AS_ECHO(["   Any C compiler"])])
   AS_ECHO(["Without the above it is not possible to build proportionally spaced fonts."])
   AS_ECHO(["Use the --disable-proportional option, or install all prerequisites."])
   ])

AS_IF([test '!' "x$enable_docs" = "xno" && test "$can_docs" = "no"],
  [AS_ECHO([])
   AS_ECHO(["One or more prerequisites for building PDF documentation are missing:"])
   AS_IF([test "$missing_xdvipdfmx" = "yes"],
     [AS_ECHO(["   xdvipdfmx             http://scripts.sil.org/xetex"])])
   AS_IF([test "$missing_xelatex" = "yes"],
     [AS_ECHO(["   XeLaTeX               http://scripts.sil.org/xetex"])])
   AS_IF([test "$missing_pgf_version" = "yes"],
     [AS_ECHO(["   PGF/TikZ (>=2.00)     http://pgf.sf.net/"])])
   AS_IF([test "$missing_proportional" = "yes"],
     [AS_ECHO(["   proportional spacing and kerning must be enabled and buildable"])])
   AS_ECHO(["Without the above it is not possible to build this component.  Use"])
   AS_ECHO(["the --disable-docs option, or install all prerequisites."])
   ])

AS_IF([test '!' "x$enable_kanji_chart" = "xno" && test "$can_kanji_chart" = "no"],
  [AS_ECHO([])
   AS_ECHO(["One or more prerequisites for building the kanji chart are missing:"])
   AS_IF([test "$missing_xdvipdfmx" = "yes"],
     [AS_ECHO(["   xdvipdfmx             http://scripts.sil.org/xetex"])])
   AS_IF([test "$missing_xelatex" = "yes"],
     [AS_ECHO(["   XeLaTeX               http://scripts.sil.org/xetex"])])
   AS_IF([test "$missing_kanjidic2" = "yes"],
     [AS_ECHO(["   KANJIDIC2             http://www.csse.monash.edu.au/~jwb/kanjidic2/"])])
   AS_IF([test "$missing_proportional" = "yes"],
     [AS_ECHO(["   proportional spacing and kerning must be enabled and buildable"])])
   AS_ECHO(["Without the above it is not possible to build this component.  Use"])
   AS_ECHO(["the --disable-kanji-chart option, or install all prerequisites."])
   ])

AS_IF([test '!' "x$enable_proofs" = "xno" && test "$can_proofs" = "no"],
  [AS_ECHO([])
   AS_ECHO(["One or more prerequisites for building proofs and pretty-printed source"])
   AS_ECHO(["code are missing:"])
   AS_IF([test "$missing_xdvipdfmx" = "yes"],
     [AS_ECHO(["   xdvipdfmx             http://scripts.sil.org/xetex"])])
   AS_IF([test "$missing_xelatex" = "yes"],
     [AS_ECHO(["   XeLaTeX               http://scripts.sil.org/xetex"])])
   AS_IF([test "$missing_pgf_version" = "yes"],
     [AS_ECHO(["   PGF/TikZ (>=2.00)     http://pgf.sf.net/"])])
   AS_IF([test "$missing_proportional" = "yes"],
     [AS_ECHO(["   proportional spacing and kerning must be enabled and buildable"])])
   AS_ECHO(["Without the above it is not possible to build this component.  Use"])
   AS_ECHO(["the --disable-proofs option, or install all prerequisites."])
   ])

AS_IF([test '!' "x$enable_silent_rules" = "xno" \
  && test "$can_silent_rules" = "no"],
  [AS_ECHO([])
   AS_ECHO(["Silent build rules are enabled (which is the default and recommended)"])
   AS_ECHO(["but Expect was not found.  This situation is dangerous because if mkfont1"])
   AS_ECHO(["fails during the build, it may sit waiting for input without producing"])
   AS_ECHO(["a message.  Install Expect from http://sourceforge.net/projects/expect/ ,"])
   AS_ECHO(["let configure know where it is through the EXPECT environment variable if"])
   AS_ECHO(["it is not in your PATH, use --disable-silent-rules, or accept the risk of"])
   AS_ECHO(["this type of failure."])
   ])

AS_IF([test '!' "x$enable_ff_debug" = "xno" && test "$can_ffdebug" = "no"],
  [AS_ECHO([])
   AS_ECHO(["One or more prerequisites for debugging FontAnvil are missing:"])
   AS_IF([test "$missing_fontanvil" = "yes"],
     [AS_ECHO(["   FontAnvil itself!"])])
   AS_IF([test "$missing_cc" = "yes"],
     [AS_ECHO(["   a C compiler of some description"])])
   AS_IF([test "$missing_grep" = "yes"],
     [AS_ECHO(["   grep (needed for the symbol test)"])])
   AS_IF([test "$missing_gdb" = "yes"],
     [AS_ECHO(["   gdb                   http://www.gnu.org/software/gdb/"])])
   AS_IF([test "$missing_ff_debugsymbols" = "yes"],
     [AS_ECHO(["   FontAnvil was compiled without debug symbols"])])
   AS_ECHO(["When FontAnvil inevitably breaks, you'll be sorry.  Use --disable-ff-debug"])
   AS_ECHO(["to turn off this message without solving the problem."])
   ])

AS_IF([test '!' "x$enable_build_hacking" = "xno" && test "$can_bshack" = "no"],
  [AS_ECHO([])
   AS_ECHO(["One or more prerequisites for hacking the build system are missing:"])
   AS_IF([test "$missing_autoconf" = "yes"],
     [AS_ECHO(["   GNU Autoconf          http://www.gnu.org/software/autoconf/"])])
   AS_IF([test "$missing_autoconf_version" = "yes"],
     [AS_ECHO(["   Your Autoconf is older than 2.65; it may or may not work."])])
   AS_IF([test "$excessive_autoconf_version" = "yes"],
     [AS_ECHO(["   Your Autoconf is more than 10 minor versions newer than version 2.65,"])
      AS_ECHO(["      whose internals this code was designed to subvert; beware."])])
   AS_IF([test "$missing_automake" = "yes"],
     [AS_ECHO(["   GNU Automake          http://www.gnu.org/software/automake/"])])
   AS_ECHO(["Unless you intend to hack the build system, and know what that means,"])
   AS_ECHO(["this condition is harmless.  Use --disable-build-hacking to turn off"])
   AS_ECHO(["this message."])
   ])

AS_IF([test '!' "x$ae_arg_okay" = "xyes"],
  [AS_ECHO([])
   AS_ECHO(["The installed version of FontForge does not accept an optional"])
   AS_ECHO(["argument to force AddExtrema() to really add all extrema.  Generated"])
   AS_ECHO(["fonts may be missing some extrema as a result; this is probably harmless"])
   AS_ECHO(["for most purposes, but it means that make check and any offline calls to"])
   AS_ECHO(["fontlint are likely to report errors."])
   ])

AS_IF([test '!' "x$enable_parasites" = "xnone" && test "$can_full_idsgrep" = "no"],
  [AS_ECHO([])
   AS_ECHO(["One or more optional libraries for IDSgrep are missing:"])
   AS_IF([test '!' "$have_perlxml" = "yes"],
     [AS_ECHO(["   XML::Parser (>=2.36)  http://search.cpan.org/search?module=XML::Parser"])])
   AS_IF([test '!' "$have_pcre" = "yes"],
     [AS_ECHO(["   PCRE                  http://www.pcre.org"])])
   AS_IF([test '!' "$have_buddy" = "yes"],
     [AS_ECHO(["   BuDDy                 https://sourceforge.net/projects/buddy/"])])
   AS_ECHO(["Without these things, IDSgrep can still be built if enabled, and will"])
   AS_ECHO(["still run, but some features may be missing."])
   ])

#
# Prognosticate
#

AS_ECHO([])
AS_ECHO_N(["With the current configuration, the build is expected to "])
AS_IF([test "$can_build" = "yes"],
  [TSU_COLOURISE([SUCCEED],[2])],
  [TSU_COLOURISE([FAIL],[1])])
AS_ECHO(["."])
