#
# SYNOPSIS
#
#   TSU_C_ANON_UNION_STRUCT
#
# DESCRIPTION
#
#   Check, by compiling a test program, whether the C compiler will allow
#   anonymous unions and structs nested inside structs, with promotion of
#   their members to appear as members of the enclosing structure.  If so,
#   it will #define ANON_UNION_STRUCT in config.h.
#
# LICENSE
#
#   This macro is released to the public domain by its author,
#   Matthew Skala <mskala@ansuz.sooke.bc.ca>.

#serial 1

AC_DEFUN([TSU_C_ANON_UNION_STRUCT],[dnl
AC_CACHE_CHECK(
 [whether anonymous unions and structs can be members],
 tsu_cv_c_anon_union_struct,[
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([#include <stdio.h>
   struct _A {
     int x;
     union {
       int y;
       struct { int z; };
     };
   } a;],
   [a.x=1;a.z=2;])],
   [tsu_cv_c_anon_union_struct=yes],[tsu_cv_c_anon_union_struct=no])])
AS_IF([test "x$tsu_cv_c_anon_union_struct" = xyes],
      [AC_DEFINE([ANON_UNION_STRUCT],[1],
         [Define to 1 if anonymous unions and structs can be members])])
])
