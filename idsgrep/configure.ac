#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#

#
# Configuration source for IDSgrep
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
  [di],[ --disable])

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
AC_PREREQ([2.63])
AC_INIT([IDSgrep],
	[0.3pre], [mskala@ansuz.sooke.bc.ca], [idsgrep],
	[[http://ansuz.sooke.bc.ca/]])
AC_PRESERVE_HELP_ORDER
AM_INIT_AUTOMAKE([foreign parallel-tests color-tests])
AC_CONFIG_SRCDIR([idsgrep.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_REVISION([$Id: configure.ac 1015 2011-12-15 22:24:32Z mskala $])
AC_COPYRIGHT([Copyright (C) 2012 Matthew Skala])
AC_SUBST([release_date],["March 17, 2012"])
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
AC_PATH_PROG([GZIP],[gzip])
AC_PATH_PROG([ICONV],[iconv])
AC_ARG_VAR([PERL],[Perl])
AC_PATH_PROG([PERL],[perl])
AC_ARG_VAR([XELATEX],[XeLaTeX])
AC_PATH_PROG([XELATEX],[xelatex])
#
############################################################################
#
# Checks for libraries.
#
AX_PERL_MODULE_VERSION([XML::Parser 2.36],[],
  [AC_MSG_ERROR([Required Perl modules are missing])])
#
############################################################################
#
# Checks for header files.
#
AC_CHECK_HEADERS([libintl.h stdlib.h string.h wchar.h])
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
AC_CHECK_FUNCS([memmove memset strchr])
#
############################################################################
#
# Checks for system services
#
AC_SYS_LONG_FILE_NAMES
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
             [for cicheckdir in cicheckpath/chise-ids-*
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
$prefix/src /src /usr/src /usr/local/src dnl
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
############################################################################
#
# Arch packaging
#
AC_MSG_CHECKING([whether we can make a PKGBUILD])
know_distsums=yes
case "x$CHECKSUM" in #((((
  *sha256sum) :
    checksum_type=sha256sum ;;
  *sha1sum) :
    checksum_type=sha1sum ;;
  *md5sum) :
    checksum_type=md5sum ;;
  no) :
    know_distsums=no ;;
  esac;
AS_IF([test '!' "x$know_distsums" = "xno"],
  [AS_IF([test "x$with_edict2" = "xno"],
     [know_distsums=no],
     [distsum_ed=`$CHECKSUM $with_edict2 | sed 's/[ ]\+.*$//'`])])
AS_IF([test '!' "x$know_distsums" = "xno"],
  [AS_IF([test "x$with_kanjivg" = "xno"],
     [know_distsums=no],
     [distsum_kvg=`$CHECKSUM $with_kanjivg | sed 's/[ ]\+.*$//'`])])
AS_IF([test '!' "x$know_distsums" = "xno"],
  [AS_IF([test "x$with_tsuku_build" = "xno"],
     [know_distsums=no],
     [know_distsums=no
      m4_foreach_w([tsucheckver],m4_expand([dnl
0.1pre 0.1 0.2pre 0.2 0.3pre 0.3 0.4pre 0.4 0.5pre 0.5 dnl
0.6pre 0.6 0.7pre 0.7 0.8pre 0.8 0.9pre 0.9 0.10pre 0.10 dnl
0.11pre 0.11 0.12pre 0.12 0.13pre 0.13 0.14pre 0.14 0.15pre 0.15 dnl
1.1pre 1.1 1.2pre 1.2 1.3pre 1.3 1.4pre 1.4 1.5pre 1.5 dnl
1.6pre 1.6 1.7pre 1.7 1.8pre 1.8 1.9pre 1.9 1.10pre 1.10 dnl
1.11pre 1.11 1.12pre 1.12 1.13pre 1.13 1.14pre 1.14 1.15pre 1.15 dnl
2.1pre 2.1 2.2pre 2.2 2.3pre 2.3 2.4pre 2.4 2.5pre 2.5 dnl
2.6pre 2.6 2.7pre 2.7 2.8pre 2.8 2.9pre 2.9 2.10pre 2.10 dnl
2.11pre 2.11 2.12pre 2.12 2.13pre 2.13 2.14pre 2.14 2.15pre 2.15]),[
      AS_IF([test -s $with_tsuku_build/tsukurimashou-tsucheckver.zip],
        [pkgbuild_tsu_version=tsucheckver
  distsum_tsuku=`$CHECKSUM $with_tsuku_build/tsukurimashou-tsucheckver.zip \
           | sed 's/[ ]\+.*$//'`
         know_distsums="yes"])
   ])])])
AS_IF([test '!' "x$know_distsums" = "xno"],
  [know_distsums=no
   m4_foreach_w([idscheckver],m4_expand([dnl
0.1pre 0.1 0.2pre 0.2 0.3pre 0.3 0.4pre 0.4 0.5pre 0.5 dnl
0.6pre 0.6 0.7pre 0.7 0.8pre 0.8 0.9pre 0.9 0.10pre 0.10 dnl
0.11pre 0.11 0.12pre 0.12 0.13pre 0.13 0.14pre 0.14 0.15pre 0.15 dnl
1.1pre 1.1 1.2pre 1.2 1.3pre 1.3 1.4pre 1.4 1.5pre 1.5 dnl
1.6pre 1.6 1.7pre 1.7 1.8pre 1.8 1.9pre 1.9 1.10pre 1.10 dnl
1.11pre 1.11 1.12pre 1.12 1.13pre 1.13 1.14pre 1.14 1.15pre 1.15 dnl
2.1pre 2.1 2.2pre 2.2 2.3pre 2.3 2.4pre 2.4 2.5pre 2.5 dnl
2.6pre 2.6 2.7pre 2.7 2.8pre 2.8 2.9pre 2.9 2.10pre 2.10 dnl
2.11pre 2.11 2.12pre 2.12 2.13pre 2.13 2.14pre 2.14 2.15pre 2.15]),[
   AS_IF([test -s idsgrep-idscheckver.tar.gz],
     [pkgbuild_version=idscheckver
  distsum_idsgrep=`$CHECKSUM idsgrep-idscheckver.tar.gz \
        | sed 's/[ ]\+.*$//'`
      know_distsums="yes, idscheckver/$pkgbuild_tsu_version"])
   ])])
AC_SUBST([checksum_type])
AC_SUBST([distsum_ed])
AC_SUBST([distsum_kvg])
AC_SUBST([distsum_tsuku])
AC_SUBST([distsum_idsgrep])
AC_SUBST([pkgbuild_tsu_version])
AC_SUBST([pkgbuild_version])
kanjivg_filename=`basename $with_kanjivg`
AC_SUBST([kanjivg_filename])
AS_IF([test '!' "x$know_distsums" = "xno"],[AC_CONFIG_FILES([PKGBUILD])])
AC_MSG_RESULT([$know_distsums])
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
AC_CONFIG_FILES([Makefile idsgrep.1 config.tex])
AC_OUTPUT
