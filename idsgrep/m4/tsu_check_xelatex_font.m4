#
# SYNOPSIS
#
#   TSU_CHECK_XELATEX_FONT([FONTNAME])
#
# DESCRIPTION
#
#   Check whether XeLaTeX and fontspec are capable of loading a specific
#   font.  If so, the variable xelatex_font_found is set to yes.
#
# LICENSE
#
#   This macro is released to the public domain by its author,
#   Matthew Skala <mskala@ansuz.sooke.bc.ca>.

#serial 1

AC_DEFUN([TSU_CHECK_XELATEX_FONT],[dnl
  AC_MSG_CHECKING([for $1 in XeLaTeX])
  mkdir tcxf-tmp
  cd tcxf-tmp
  cat <<EOF > test.tex
\documentclass{article}
\usepackage{fontspec}
\setmainfont{$1}
\begin{document}
\end{document}
EOF
  AS_IF([$XELATEX ./test.tex > /dev/null],
    [AC_MSG_RESULT([yes])
     xelatex_font_found=yes],
    [AC_MSG_RESULT([no])])
  cd ..
  rm -rf tcxf-tmp
])
