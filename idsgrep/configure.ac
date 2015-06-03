#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#

#
# Configuration source for IDSgrep
# Copyright (C) 2012, 2013, 2014  Matthew Skala
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

# Add a new directory
TSUKU_ADD_INSTDIR_OPTION([dict],[datarootdir],[dict],[dictionaries],
  [di],[ --docdir])

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
AC_INIT([IDSgrep],
	[0.5.1], [mskala@ansuz.sooke.bc.ca], [idsgrep],
	[[http://tsukurimashou.osdn.jp/idsgrep.php]])
AC_PRESERVE_HELP_ORDER
AC_CONFIG_AUX_DIR([.])
AM_INIT_AUTOMAKE([foreign color-tests parallel-tests silent-rules])
AC_CONFIG_SRCDIR([idsgrep.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_REVISION([$Id: configure.ac 1015 2011-12-15 22:24:32Z mskala $])
AC_COPYRIGHT([Copyright (C) 2012, 2013, 2014  Matthew Skala])
AC_SUBST([release_date],["March 27, 2014"])
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
AC_PATH_PROGS([CHECKSUM],[sha256sum sha1sum md5sum cksum wc],[no])
AC_ARG_VAR([EXPECT],[Expect])
AC_PATH_PROG([EXPECT],[expect])
AM_CONDITIONAL([COND_EXPECT],[test '!' "x$EXPECT" = "x"])
AX_CHECK_GNU_MAKE
AC_PATH_PROG([GZIP],[gzip])
AC_PATH_PROG([ICONV],[iconv])
AC_ARG_VAR([KLEKNEV],[Kleknev])
AC_PATH_PROG([KLEKNEV],[kleknev],[/bin/sh],[$PATH:$PWD/../kleknev])
AC_ARG_VAR([PERL],[Perl])
AC_PATH_PROG([PERL],[perl])
AC_ARG_VAR([XELATEX],[XeLaTeX],[no])
AC_PATH_PROG([XELATEX],[xelatex])
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
AX_PERL_MODULE_VERSION([XML::Parser 2.36],[have_perlxml=yes],
  [have_perlxml=no])
AC_CHECK_LIB([bdd],[bdd_init],[
  have_buddy=yes
  AC_DEFINE([HAVE_BUDDY],[1],
    [Define to 1 if BuDDy is available])
  ],[have_buddy=no])
AM_CONDITIONAL([COND_BUDDY],[test '!' "$have_buddy" = no])
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
AC_CHECK_HEADERS([libintl.h stdlib.h string.h wchar.h])
AX_CREATE_STDINT_H
#
############################################################################
#
# Checks for typedefs, structures, and compiler characteristics.
#
AC_C_INLINE
AC_CHECK_SIZEOF([int])
AC_TYPE_SIZE_T
AX_C___ATTRIBUTE__
TSU_C_ANON_UNION_STRUCT
TSU_C_GCC_BUILTIN_BSWAP
#
############################################################################
#
# Checks for library functions.
#
AX_FUNC_GETOPT_LONG
AC_CHECK_FUNCS_ONCE([memmove memset strchr])
#
AC_SUBST([set_sans_font])
AS_IF([test "x$XELATEX" = "xno"],[],
  [TSU_CHECK_XELATEX_FONT([Helvetica])
   AS_IF([test "x$xelatex_font_found" = "xyes"],
     [set_sans_font='\setsansfont{Helvetica}'],
     [TSU_CHECK_XELATEX_FONT([Nimbus Sans L])
      AS_IF([test "x$xelatex_font_found" = "xyes"],
        [set_sans_font='\setsansfont{Nimbus Sans L}'],
        [set_sans_font='%'])
   ])
])
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
AC_ARG_ENABLE([widthtab],
  [AS_HELP_STRING([--enable-widthtab],
    [reconstruct the character width automaton table])],
    [],
    [enable_widthtab=no])
AM_CONDITIONAL([COND_WIDTHTAB],[test '!' "$enable_widthtab" = no])
#
AC_ARG_WITH([chise-ids],
  [AS_HELP_STRING([--with-chise-ids=PATH],
     [CHISE IDS database [auto]])],
     [],
     [with_chise_ids=auto])
AS_IF([test "x$with_chise_ids" = "xauto"],[
AC_MSG_CHECKING([for CHISE IDS database])
m4_foreach_w([cicheckpath],m4_expand([$srcdir $srcdir/.. $srcdir/../.. dnl
$prefix/src /src /usr/src /usr/local/src dnl
$HOME $HOME/src]),[
       AS_IF([test "$with_chise_ids" = "auto"],
             [for cicheckdir in cicheckpath/chise-ids-* cicheckpath/chise-ids
do
  AS_IF([test -r "$cicheckdir/Makefile"],[
check_line=x`grep 'Makefile for CHISE IDS' "$cicheckdir/Makefile"`
              AS_IF([test "$check_line" = "x# Makefile for CHISE IDS."],
                    [with_chise_ids=$cicheckdir])])
done
])])
AS_IF([test "$with_chise_ids" = "auto"],[with_chise_ids=no])
AC_MSG_RESULT([$with_chise_ids])
])
AM_CONDITIONAL([COND_CHISE_IDS], [test '!' "$with_chise_ids" = no])
AC_SUBST([with_chise_ids])
#
AS_IF([test "x$prefix" = "xNONE"],[prefix="$ac_default_prefix"])
AC_ARG_WITH([edict2],
  [AS_HELP_STRING([--with-edict2=PATH],
     [EDICT2 database [auto]])],
     [],
     [with_edict2=auto])
AS_IF([test "x$with_edict2" = "xauto"],[
AC_MSG_CHECKING([for EDICT2])
m4_foreach_w([edcheckpath],m4_expand([$srcdir dnl
$prefix/dict $prefix/share dnl
/dict /share /usr/dict /usr/share/dict /usr/local/dict dnl
/usr/local/share/dict $HOME $HOME/dict]),[
   for testfn in edcheckpath/edict2.gz edcheckpath/edict.gz
   do
     AS_IF([test "$with_edict2" = "auto"],
           [AS_IF([test -r "$testfn"],
                  [with_edict2="$testfn"])])
   done
   ])
   AS_IF([test "$with_edict2" = "auto"],[with_edict2=no])
   AC_MSG_RESULT([$with_edict2])
   ])
AM_CONDITIONAL([COND_EDICT2], [test '!' "$with_edict2" = no])
AC_SUBST([with_edict2])
#
AS_IF([test "x$prefix" = "xNONE"],[prefix="$ac_default_prefix"])
AC_ARG_WITH([kanjivg],
  [AS_HELP_STRING([--with-kanjivg=PATH],
     [KanjiVG database [auto]])],
     [],
     [with_kanjivg=auto])
AS_IF([test "x$with_kanjivg" = "xauto"],[
AC_MSG_CHECKING([for KanjiVG])
m4_foreach_w([kvcheckpath],m4_expand([$srcdir dnl
$prefix/dict $prefix/share dnl
/dict /share /usr/dict /usr/share/dict /usr/local/dict dnl
/usr/local/share/dict $HOME $HOME/dict]),[
   for testfn in kvcheckpath/kanjivg*.xml.gz kvcheckpath/kanjivg*.xml
   do
     AS_IF([test "$with_kanjivg" = "auto"],
           [AS_IF([test -r "$testfn"],
                  [with_kanjivg="$testfn"])])
   done
   ])
   AS_IF([test "$with_kanjivg" = "auto"],[with_kanjivg=no])
   AC_MSG_RESULT([$with_kanjivg])
   ])
AM_CONDITIONAL([COND_KANJIVG], [test '!' "$with_kanjivg" = no])
AC_SUBST([with_kanjivg])
#
AC_ARG_WITH([tsuku-build],
  [AS_HELP_STRING([--with-tsuku-build=PATH],
     [Tsukurimashou build dir [auto]])],
     [],
     [with_tsuku_build=auto])
AS_IF([test "x$with_tsuku_build" = "xauto"],[
AC_MSG_CHECKING([for Tsukurimashou build dir])
m4_foreach_w([tbcheckname],m4_expand([tsukurimashou dnl
tsukurimashou-0.6 tsukurimashou-0.7 tsukurimashou-0.8 dnl
tsukurimashou-0.9 tsukurimashou-0.10 tsukurimashou-0.11]),[
m4_foreach_w([tbcheckpath],m4_expand([$srcdir $srcdir/.. $srcdir/../.. dnl
$srcdir/../../.. $prefix/src /src /usr/src /usr/local/src dnl
$HOME $HOME/src]),[
       AS_IF([test "$with_tsuku_build" = "auto"],
             [AS_IF([test -r "tbcheckpath/tbcheckname/Makefile"],[
check_line=x`grep 'Makefile for Tsu' tbcheckpath/tbcheckname/Makefile`
              AS_IF([test "$check_line" = "x# Makefile for Tsukurimashou"],
                    [with_tsuku_build=tbcheckpath/tbcheckname])])])])])
AS_IF([test "$with_tsuku_build" = "auto"],[with_tsuku_build=no])
AC_MSG_RESULT([$with_tsuku_build])
])
AM_CONDITIONAL([COND_TSUKU_BUILD], [test '!' "$with_tsuku_build" = no])
AC_SUBST([with_tsuku_build])
#
AC_ARG_ENABLE([cjkvi-style],
  [AS_HELP_STRING([--enable-cjkvi-style=[[gtjkvxhau]]],
    [which CJKVI dictionaries to build [j]])],
    [],
    [enable_cjkvi_style=j])
AC_SUBST([enable_cjkvi_style])
#
AC_ARG_ENABLE([colour-build],
  [AS_HELP_STRING([--disable-colour-build],
    [turn off ANSI colour in build scripts])],
    [],
    [enable_colour_build=yes])
AC_ARG_ENABLE([color-build],[dnl],[],[enable_color_build=yes])
#
AC_ARG_ENABLE([docs],
  [AS_HELP_STRING([--disable-docs],
    [turn off PDF documentation])],
    [],
    [enable_docs=yes])
#
AC_ARG_ENABLE([edict-decomp],
  [AS_HELP_STRING([--enable-edict-decomp[[=cjkvi-X|chise|kanjivg|tsuku]]],
    [dictionary for EDICT2 decomposition [cjkvi-j]])],
    [],
    [enable_edict_decomp=cjkvi-j])
AS_IF([test "$enable_edict_decomp" = "cjkvi-g"],[edict_decomp=cjkvi-g.eids])
AS_IF([test "$enable_edict_decomp" = "cjkvi-t"],[edict_decomp=cjkvi-t.eids])
AS_IF([test "$enable_edict_decomp" = "cjkvi-j"],[edict_decomp=cjkvi-j.eids])
AS_IF([test "$enable_edict_decomp" = "cjkvi-k"],[edict_decomp=cjkvi-k.eids])
AS_IF([test "$enable_edict_decomp" = "cjkvi-v"],[edict_decomp=cjkvi-v.eids])
AS_IF([test "$enable_edict_decomp" = "cjkvi-x"],[edict_decomp=cjkvi-x.eids])
AS_IF([test "$enable_edict_decomp" = "cjkvi-h"],[edict_decomp=cjkvi-x.eids])
AS_IF([test "$enable_edict_decomp" = "cjkvi-a"],[edict_decomp=cjkvi-a.eids])
AS_IF([test "$enable_edict_decomp" = "chise"],[edict_decomp=chise.eids])
AS_IF([test "$enable_edict_decomp" = "kanjivg"],[edict_decomp=kanjivg.eids])
AS_IF([test "$enable_edict_decomp" = "tsuku"],
      [edict_decomp=tsukurimashou.eids])
AS_IF([test "$enable_edict_decomp" = "no"],
      [edict_decomp=])
AC_SUBST([edict_decomp])
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
AM_CONDITIONAL([COND_DOCS],[test '!' "$enable_docs" = no])
AC_SUBST([enable_docs])
#
#
AS_IF([test "x$prefix" = "xNONE"],[prefix="$ac_default_prefix"])
#
AS_IF([test "x$enable_silent_rules" = "x"],
  [enable_silent_rules=yes
   AM_DEFAULT_VERBOSITY=0])
#
############################################################################
#
# Generate output
#
AC_SUBST([flat_dictdir])
AC_SUBST([flat_docdir])
eval flat_dictdir=${dictdir}
eval flat_dictdir=${flat_dictdir}
eval flat_dictdir=${flat_dictdir}
eval flat_docdir=${docdir}
eval flat_docdir=${flat_docdir}
eval flat_docdir=${flat_docdir}
#
AC_DEFINE_UNQUOTED([DICTDIR],["$flat_dictdir"],
  [Default location of dictionaries])
#
AC_SUBST([andt],[])
AC_CONFIG_FILES([Makefile idsgrep.1 config.tex])
AC_OUTPUT
#
############################################################################
#
# Warn about missing prerequisites
#
AS_IF([test "x$have_perlxml" = "xyes"],[],
  [AC_MSG_WARN([XML::Parser is missing, KanjiVG dictionary disabled])])
AS_IF([test "x$have_buddy" = "xyes"],[],
  [AC_MSG_WARN([BuDDy is missing, binary decision diagrams disabled])])
AS_IF([test "x$have_pcre" = "xyes"],[],
  [AC_MSG_WARN([PCRE is missing, regular expression search disabled])])
