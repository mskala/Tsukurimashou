#
# SYNOPSIS
#
#   TSU_C_GCC_BUILTIN_BSWAP
#
# DESCRIPTION
#
#   Check, by compiling a test program, whether the C compiler defines
#   __builtin_bswap32 and __builtin_bswap64 as GCC does.
#
# LICENSE
#
#   This macro is released to the public domain by its author,
#   Matthew Skala <mskala@ansuz.sooke.bc.ca>.

#serial 1

AC_DEFUN([TSU_C_GCC_BUILTIN_BSWAP],[dnl
AC_CACHE_CHECK(
 [for __builtin_bswap{32,64}],
 tsu_cv_c_gcc_builtin_bswap,[
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([],
   [__builtin_bswap32(0);__builtin_bswap64(0);])],
   [tsu_cv_c_gcc_builtin_bswap=yes],[tsu_cv_c_gcc_builtin_bswap=no])])
AS_IF([test "x$tsu_cv_c_gcc_builtin_bswap" = xyes],
      [AC_DEFINE([GCC_BUILTIN_BSWAP],[1],
         [Define to 1 if GCC-style builtin bswaps are supported])])
])
