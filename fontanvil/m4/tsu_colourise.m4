#
# SYNOPSIS
#
#   TSU_COLOURISE(TEXT,COLOUR)
#
# DESCRIPTION
#
#   Display TEXT in ANSI colour number COLOUR if the tsu_colour shell
#   variable is "yes"
#
# LICENSE
#
#   This macro is released to the public domain by its author,
#   Matthew Skala <mskala@ansuz.sooke.bc.ca>.

#serial 1

AC_DEFUN([TSU_COLOURISE], [
    AS_IF([test "x$tsu_colour" = "xyes"],
      [echo $ECHO_N -e "\e@<:@3$2;1m$1\e@<:@m$ECHO_C"],
      [echo $ECHO_N "$1$ECHO_C"])
])
