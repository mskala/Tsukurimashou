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

#serial 2

AC_DEFUN([TSU_COLOURISE], [
    AS_IF([test "x$tsu_colour" = "xyes"],
      [echo $ECHO_N "~@<:@3$2;1m$1~@<:@m$ECHO_C" | tr '~' '\033'],
      [echo $ECHO_N "$1$ECHO_C"])
])
