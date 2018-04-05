# Process this file with autoconf to produce a configure script.

#
# Configuration source for Beikaitoru
# Copyright (C) 2012, 2013, 2014, 2015, 2017  Matthew Skala
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
TSUKU_ADD_INSTDIR_OPTION([afm],[fontdir],[afm],
  [Adobe Font Metrics],
  [afm],[ --prefix ])
TSUKU_ADD_INSTDIR_OPTION([type1],[fontdir],[type1],
  [Postscript Type 1 fonts],
  [ty],[ --prefix ])
TSUKU_ADD_INSTDIR_OPTION([ttf],[fontdir],[TTF],
  [TrueType fonts],
  [tt],[ --prefix ])
TSUKU_ADD_INSTDIR_OPTION([otf],[fontdir],[OTF],
  [OpenType fonts],
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
AC_INIT([Beikaitoru],
	[0.1pre], [mskala@ansuz.sooke.bc.ca], [beikaitoru],
	[[http://tsukurimashou.osdn.jp/]])
AC_PRESERVE_HELP_ORDER
AC_CONFIG_AUX_DIR([.])
AM_INIT_AUTOMAKE([foreign color-tests dist-zip no-dist-gzip
  parallel-tests silent-rules])
AC_CONFIG_SRCDIR([subfont.mp])
AC_CONFIG_MACRO_DIR([m4])
AC_REVISION([$Id: configure.ac 5795 2017-11-21 21:32:34Z mskala $])
AC_COPYRIGHT([Copyright (C) 2013 Matthew Skala])
AC_SUBST([release_date],["March 7, 2013"])
# this must be early so it will happen before depfiles
TSU_FIX_MAKEFILE
AM_SILENT_RULES
#
############################################################################
#
# Checks for programs.
#
AC_PROG_GREP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PATH_PROG([AUTOCONF],[autoconf])
AC_PATH_PROG([AUTOMAKE],[automake])
AC_ARG_VAR([EXPECT],[Expect])
AS_IF([test "x$EXPECT" = "x"],
  [AC_PATH_PROG([EXPECT],[expect])])
AM_CONDITIONAL([COND_EXPECT],[test '!' "x$EXPECT" = "x"])
AC_ARG_VAR([FONTANVIL],[FontAnvil])
AS_IF([test "x$FONTANVIL" = "x"],
  [AC_PATH_PROGS([FONTANVIL],[fontanvil fontforge],[],
     [$PATH:$PWD/../fontanvil/fontanvil])])
AX_CHECK_GNU_MAKE
AC_ARG_VAR([KLEKNEV],[Kleknev])
AS_IF([test "x$KLEKNEV" = "x"],
  [AC_PATH_PROG([KLEKNEV],[kleknev],[/bin/sh],[$PATH:$PWD/../kleknev])])
AC_ARG_VAR([MPOST],[MetaPost])
AS_IF([test "x$MPOST" = "x"],
  [AC_PATH_PROG([MPOST],[mpost])])
AC_ARG_VAR([PERL],[Perl])
AS_IF([test "x$PERL" = "x"],
  [AC_PATH_PROG([PERL],[perl])])
AC_ARG_VAR([T1ASM],[t1asm])
AC_ARG_VAR([XDVIPDFMX],[xdvipdfmx])
AS_IF([test "x$XDVIPDFMX" = "x"],
  [AC_PATH_PROG([XDVIPDFMX],[xdvipdfmx])])
AC_ARG_VAR([XELATEX],[XeLaTeX])
AS_IF([test "x$XELATEX" = "x"],
  [AC_PATH_PROG([XELATEX],[xelatex])])
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
#]
AC_ARG_ENABLE([docs],
  [AS_HELP_STRING([--disable-docs],
    [turn off PDF documentation])],
  [],
  [enable_docs=yes])
AC_ARG_ENABLE([parasite],
  [AS_HELP_STRING([--enable-parasite=[yes|no|auto]],
    [build as a parasite [auto]])],
  [],
  [enable_parasite=auto])
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
AC_MSG_CHECKING([whether FontAnvil accepts AddExtrema(1)])
echo '#!/usr/local/bin/fontforge' > ffaetest.pe
echo 'New();AddExtrema(1);' >> ffaetest.pe
AS_IF(["$FONTANVIL" -script ffaetest.pe >& /dev/null],
  [ae_arg_okay=yes],[ae_arg_okay=no])
rm ffaetest.pe
AC_SUBST([ae_arg_okay])
AC_MSG_RESULT([$ae_arg_okay])
#
############################################################################
#
# Check for parasite build
#
AC_MSG_CHECKING([whether we are building as a parasite])
AS_IF([test "x$enable_parasite" = "xauto"],
  [AS_IF([grep Tsukurimashou ../Makefile > /dev/null 2> /dev/null],
    [enable_parasite=yes],
    [enable_parasite=no])])
AC_MSG_RESULT([$enable_parasite])
AM_CONDITIONAL([COND_PARASITE],[test "x$enable_parasite" = "xyes"])
AM_COND_IF([COND_PARASITE],
  [T1ASM=../t1asm/t1asm
   parasite=yes],
  [AC_PATH_PROG([T1ASM],[t1asm])
   parasite=no])
AC_SUBST([T1ASM])
AC_SUBST([parasite])
#
############################################################################
#
# Generate output
#
AC_SUBST([andt],[])
AC_CONFIG_FILES([Makefile])
TSU_BAD_PATHS
AC_OUTPUT
#
############################################################################
#
# Display a status table
#
AS_ECHO([])
TSU_COLOURISE([Beikaitoru configuration status],[5])AS_ECHO([])
#
AS_ECHO([])
TSU_COLOURISE([Requirements for all builds],[7])AS_ECHO([])
AS_ECHO_N(["FontAnvil         "])
  AS_IF([test "x$FONTANVIL" = "x"],
    [TSU_COLOURISE([no],[1])
     AS_ECHO_N(["     http://tsukurimashou.osdn.jp/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["MetaPost          "])
  AS_IF([test "x$MPOST" = "x"],
    [TSU_COLOURISE([no],[1])
     AS_ECHO_N(["     http://tug.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["perl              "])
  AS_IF([test "x$PERL" = "x"],
    [TSU_COLOURISE([no],[1])
     AS_ECHO_N(["     http://perl.org/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
#
AS_ECHO([])
TSU_COLOURISE([Optional items],[7])AS_ECHO([])
AS_ECHO_N(["kleknev           "])
  AS_IF([test "x$KLEKNEV" = "x"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://tsukurimashou.osdn.jp/"])],
    [TSU_COLOURISE([yes],[2])])
  AS_ECHO([])
AS_ECHO_N(["XeLaTeX           "])
  AS_IF([test "x$XELATEX" = "x"],
    [TSU_COLOURISE([no],[3])
     AS_ECHO_N(["     http://tug.org/"])],
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
AS_IF([test "x$parasite" = "xyes"],
  [TSU_COLOURISE([Parasite build enabled.],[6])
   AS_ECHO([])])
