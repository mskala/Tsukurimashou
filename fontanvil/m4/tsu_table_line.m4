#
# SYNOPSIS
#
#   TSU_TABLE_LINE(CMPNAME,WANTSHOW,WANTVAL,CANVAL,EXTRA)
#
# DESCRIPTION
#
#   Display a line of the config status table with appropriate colourisation,
#   where CMPNAME is the  component name field, WANTSHOW is what to show in
#   the "want" field, WANTVAL is the actual yes/no "want" value, and CANVAL
#   is the yes/no "can" value.
#
# LICENSE
#
#   This macro is released to the public domain by its author,
#   Matthew Skala <mskala@ansuz.sooke.bc.ca>.

#serial 1

AC_DEFUN([TSU_TABLE_LINE], [
  AS_ECHO_N(["$1"])
  wantshow="[$2]"
  AS_IF([test "$wantshow" = "no"],[wantshow="no      "],[])
  AS_IF([test "$wantshow" = "yes"],[wantshow="yes     "],[])
  AS_IF([test "$3" = "yes"],
    [AS_IF([test "$4" = "yes"],
      [canscolour=2],
      [canscolour=1])],
    [canscolour=3])
  AS_IF([test "$2" = "$3"],
    [TSU_COLOURISE([$wantshow],[$canscolour])],
    [AS_ECHO_N(["$wantshow"])
     AS_IF([test "$4$canscolour" = "yes3"],[canscolour=2])])
  TSU_COLOURISE([$4],[$canscolour])
  AS_ECHO([])
])
