\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mitsuba}[2015/07/27 v0.01 Tsukurimashou project documentation]

\ProcessOptions\relax

\LoadClass[twocolumn]{report}

\RequirePackage{ifxetex}
\ifxetex
  \RequirePackage{fontspec}
\fi

\RequirePackage{amsfonts}
\RequirePackage{calc}
\RequirePackage{manfnt}
\RequirePackage[rigidchapters]{titlesec}
\RequirePackage{tocloft}

\RequirePackage{url}

\InputIfFileExists{mitsuba.cfg}{}{}

\setlength{\topmargin}{0.25in}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}

\setlength{\oddsidemargin}{\paperwidth*2/17-1in}
\setlength{\marginparsep}{\paperwidth*1/68}
\setlength{\marginparwidth}{\paperwidth*1/17}
\setlength{\columnsep}{1em}
\setlength{\textwidth}{\paperwidth*13/17}
\setlength{\textheight}{8.5in}

\setlength{\parindent}{1.5em}

\dimen@=\f@size\p@\dimen@6\dimen@\divide\dimen@5\edef\l@rgesize{\the\dimen@}
\dimen@=\f@size\p@\dimen@2\dimen@\edef\@hugesize{\the\dimen@}

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                      \@afterheading
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}


\newcommand{\ch@pterform@t}[1]{%
  \begin{@twocolumnfalse}%
    \fontsize{\@hugesize}{3\baselineskip}\sffamily\bfseries\selectfont
    #1\,\leaders\hrule height 0.2ex\hfill\null
  \end{@twocolumnfalse}%
}%
\titlespacing*{\chapter}{0pt}{6\baselineskip}{2\baselineskip}
\titleformat{\chapter}[hang]{}{}{0pt}{\ch@pterform@t}

\titleformat{\section}[runin]%
   {\fontsize{\l@rgesize}{\baselineskip}\sffamily\bfseries}{}{0pt}{}%
   [\,\leaders\hrule height 0.16ex\hfill\null\\]
\titlespacing*{\section}{0pt}{\baselineskip}{0pt}

\titleformat{\subsection}[runin]{\sffamily\bfseries}{}{0pt}{}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0.666em}

\titleformat{\subsubsection}[runin]{\rmfamily\scshape}{}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{\baselineskip}{0.666em}

\titleformat{\paragraph}[runin]{\rmfamily\itshape}{}{0pt}{}
\titlespacing*{\paragraph}{\parindent}{0pt}{0.666em}

\renewcommand\maketitle{%
  \begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \vspace*{\fill}
    \vspace*{\fill}
    {\sffamily\bfseries\huge \hfill\@title\hfill\null\par}
    \vspace{\fill}
    {\sffamily\bfseries\Large \hfill\@author\hfill\null\par}
    \vspace{\fill}
    \vspace{\fill}
    \vspace{\fill}
    \vspace{\fill}
    \vspace{\fill}
    {\sffamily\bfseries\Large \hfill\@date\par}
    \vspace*{\fill}
    \@thanks\par
    \null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \setcounter{page}{2}
}

\def\@maketitle{%
  \newpage\noindent
  \null
  \begingroup
    \let\footnote\thanks
    {\fontsize{\@hugesize}{2\baselineskip}\sffamily\bfseries\selectfont
      \@title\,\leaders\hrule height 0.2ex\hfill\null}\par\noindent
    {\fontsize{\l@rgesize}{\baselineskip}\sffamily\bfseries
      \@author\hfill\@date}\par
  \endgroup
  \dimen@=0.5\baselineskip\relax\advance\dimen@-0.5\p@\relax
  \vspace{\dimen@}\noindent
}

\newcommand{\DangerousBend}{\marginpar{\large\hfill\dbend\hfill\null}}
\newcommand{\DangerousSection}{\marginpar{\large\hfill
\raisebox{-0.5\baselineskip}[0pt][0pt]{\dbend}\hfill\null}}

\renewcommand{\thefootnote}{\fnsymbol{footnote}}

\raggedbottom

\renewcommand{\cfttoctitlefont}{%
  \huge\sffamily\bfseries}
\renewcommand{\cftaftertoctitle}{%
  {\huge\,\leaders\hrule height 0.2ex\hfill\null\vspace*{-4ex}}}

\def\gobbtohfil#1{%
  \begingroup\if#1\hfil\else\aftergroup\gobbtohfil\fi\endgroup}

\renewcommand{\cftchappresnum}{\gobbtohfil}
\renewcommand{\cftchapnumwidth}{0pt}
\renewcommand{\cftchapfont}{\sffamily\bfseries}
\renewcommand{\cftchappagefont}{\sffamily\bfseries}

\renewcommand{\cftsecpresnum}{\gobbtohfil}
\renewcommand{\cftsecnumwidth}{0pt}

\renewcommand{\cftsubsecpresnum}{\gobbtohfil}
\renewcommand{\cftsubsecnumwidth}{0pt}

