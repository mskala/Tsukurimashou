#
# SYNOPSIS
#
#   TSU_BAD_PATHS
#
# DESCRIPTION
#
#   Check Autoconf's substitution variables to determine whether any of
#   them contain names of paths that exist but cause trouble, such as
#   by containing spaces or quotation marks.  Set has_bad_paths to yes
#   or no depending on the result of this check, and all_bad_paths to
#   all the bad paths found, with four spaces before and a newline after
#   each one.  This check is not absolutely foolproof; a motivated user
#   will still find a way to shoot themselves in the foot.  But at least
#   it should catch the Windows "Program Files" pathname, which is the
#   killer case.
#
# LICENSE
#
#   This macro is released to the public domain by its author,
#   Matthew Skala <mskala@ansuz.sooke.bc.ca>.

#serial 1

AC_DEFUN([TSU_BAD_PATHS], [
  AC_MSG_CHECKING([for bad paths])
  has_bad_paths=no
  all_bad_paths=''
  for sv in $ac_subst_vars ; do
    eval vv='"'\$$sv'"'
    if test -e "$vv" ; then
      if echo "$vv" | grep -q '@<:@ #$&():;<=>\\`|\?\*"'"'@:>@" ; then
        has_bad_paths=yes
        all_bad_paths="$all_bad_paths    $vv
"
      fi
    fi
  done
  AC_MSG_RESULT([$has_bad_paths])
])
