%
% Tsukurimashou "font base" macros
%
% THIS FILE IS PUBLIC DOMAIN NOTWITHSTANDING THE COPYRIGHT ON THE
% OVERALL TSUKURIMASHOU PACKAGE
%
% This file is based on the files "fontbase.mp" and "plain_ex.mp" from the
% METATYPE1 package version 0.55.  Those files contain no copyright-related
% notices of their own, but the README for METATYPE1 version 0.55 contains
% the following notices (in English and Polish; the slashes are verbatim
% from the original and presumably are some convention for expressing
% non-ASCII Polish letters in the ASCII file):
%
%     This is METATYPE1 package -- a tool for creating Type 1 fonts using
%     METAPOST. The package belongs to public domain (no copyrights,
%     copylefts, copyups, copydowns, etc.).
%     Version: 0.55 (16.09.2009; a tentative version, released along with
%              the sources of the Latin Modern fonts ver. 2.003)
%     Author: JNS team <JNSteam@gust.org.pl>
%
%     To jest pakiet METATYPE1 -- narz/edzie do tworzenia font/ow Type 1
%     za pomoc/a systemu METAPOST. Pakiet stanowi dobro wsp/olne
%     (/zadnych copyright/ow, copyleft/ow, copyup/ow, copydown/ow, etc.).
%     Wersja: 0.55 (16.09.2009 -- wersja opublikowana wraz z wersj/a
%             /xr/od/low/a 2.003 pakietu font/ow Latin Modern)
%     Autorstwo: JNS team <JNSteam@gust.org.pl>
%
% Although I assert my general right to claim copyright on work of my own
% that draws from public domain source materials, I nonetheless am releasing
% this file to the public domain in an effort to maintain the spirit of the
% JNS team's release above.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
%
% Matthew Skala
% mskala@ansuz.sooke.bc.ca
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% from fontbase.mp

%%%%
%%%% It is a basic set of macros for generating Type 1 fonts
%% \raggedbottom
%% \--------------------------------------------------------------------
%% \centering\bf A \MP{}-to-Type 1 converter:\break
%% BASIC MACROS ver. 0.55
%% \-
%% \centering\bf Konwerter \MP{}$\;\rightarrow\;$Type 1:\break
%% MAKRA PODSTAWOWE wer. 0.55
%% \--------------------------------------------------------------------
if known fontbase_ver: expandafter endinput else: fontbase_ver:=0.55; fi
% ---

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% at this point fontbase.mp includes plain_ex.mp; I'm inlining that
% to help with namespace issues - MS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% from plain_ex.mp

%%%% THIS FILE IS DISTRIBUTED WITH THE METATYPE1 PACKAGE
%%%%
%%%% It is an extension of plain.mp
%% \raggedbottom
%% \edef\illusname{plain\string_e\string_}
%% \--------------------------------------------------------------------
%% \centering \BF EXTENSION OF \MP{} plain FORMAT (ver. 0.46)
%% \-
%% \centering \BF ROZSZERZENIE \MP{}-owego FORMATU plain (wer. 0.46)
%% \--------------------------------------------------------------------
if known plain_ex_ver: expandafter endinput else: plain_ex_ver:=.45; fi
def killtext text t = enddef; % absent from older versions of plain.mf
%% \--------------------------------------------------------------------
%% Knuthian tradition:
%% \-
%% Knuthowa tradycja:
%% \--------------------------------------------------------------------
mm#=2.84528; pt#=1; dd#=1.07001; bp#=1.00375; cm#=28.45276; pc#=12;
cc#=12.84010; in#=72.27;
%% \--------------------------------------------------------------------
%% A patch for bugs in \MP{} |turningnumber| functionality
%% \-
%% Makra /lataj/ace wadliwe funkcjonowanie operacji |turningnumber|
%% \--------------------------------------------------------------------
let original_turningnumber = turningnumber;
vardef straighten_path(expr r) =
 for k=0 upto length r - 1: point k of r -- endfor
if cycle r: cycle else: point infinity of r fi enddef;
vardef emergency_turningnumber primary r =
 original_turningnumber(straighten_path(r))
enddef;
def use_emergency_turningnumber =
 def turningnumber = emergency_turningnumber enddef;
enddef;
def use_original_turningnumber =
 def turningnumber = original_turningnumber enddef;
enddef;
%% \--------------------------------------------------------------------
%% Loading a file optionally
%% \-
%% Opcjonalne czytanie pliku
%% \--------------------------------------------------------------------
boolean maybeinput_ok; string maybedir;
vardef maybename(text name) =
 if known maybedir: maybedir & fi if string name: name else: str name fi
enddef;
def maybeinput text name =
 if (readfrom maybename(name))=EOF:
  message "PX: file " & maybename(name) & " cannot be read";
  maybeinput_ok:=false;
 else:
  closefrom maybename(name); scantokens ("input " & maybename(name));
  maybeinput_ok:=true;
 fi
enddef;
%% \--------------------------------------------------------------------
%%   A few colours more:
%% \-
%%   Par/e dodatkowych kolor/ow:
%% \--------------------------------------------------------------------
color cyan, magenta, yellow; cyan=(0,1,1); magenta=(1,0,1); yellow=(1,1,0);
%% \--------------------------------------------------------------------
%% A few functions more:
%% \-
%% Par/e dodatkowych funkcji:
%% \--------------------------------------------------------------------
vardef gen_whatever(text type) = save ?; type ?; ? enddef; % 1-argument func.
vardef whatever_pair = gen_whatever(pair) enddef; % 0-argument function
vardef tand primary a = sind(a)/cosd(a) enddef;
vardef cotd primary a = cosd(a)/sind(a) enddef;
vardef signum primary x = if x>0: 1 elseif x<0: -1 else: 0 fi enddef;
primarydef w dotnorm z =
 begingroup
  save w_, z_, lw_, lz_; pair w_, z_;
  lw_=abs(w); w_:=w if lw_>0: /lw_ fi;
  lz_=abs(z); z_:=z if lz_>0: /lz_ fi;
  (xpart w_ * xpart z_ + ypart w_ * ypart z_)
 endgroup
enddef;
%
let ori_decimal=decimal;
def decimal primary n = 
 (
  if path n: 
   for i_=0 upto length(n)-1: if i_>0: & " " & fi
    decimal(point i_ of n) & " " & decimal(postcontrol i_ of n)  & " " & 
     decimal(precontrol i_+1 of n)  & " " & decimal(point i_+1 of n) 
   endfor
  elseif color n: ori_decimal(redpart(n)) & " " &
   ori_decimal(greenpart(n)) & " " & ori_decimal(bluepart(n)) 
  elseif pair n: ori_decimal(xpart(n)) & " " & ori_decimal(ypart(n)) 
  else: ori_decimal(n) fi
 )
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The definition of |postdir| and |predir| given below is
% based on the following observation, being the consequence
% of the de~l'H\^ospital's rule: consider a~B\'ezier segment
% |a .. controls b and c .. d|; normally, the vector $\vec{ab}$
% determines the ``post'' direction at node~$a$; if $b$
% coincides with $a$, then the vector $\vec{ac}$ determines
% the direction; if also $c$ coincides coincides with~$a$,
% then the last resort is the vector $\vec{ad}$; if even $d$
% coincides with~$a$, the B\'ezier segment is degenerated,
% and can be removed (a~similar argumentation can be provided
% for the ``pre'' direction at node~$d$).
%% \-
%% \descriptioncomments
% Definicje makr |postdir| i~|predir| wykorzystuj/a nast/epuj/ac/a
% obserwacj/e, b/ed/ac/a prost/a konsekwencj/a regu/ly de~l'H\^ospitala:
% rozwa/zmy segment |a .. controls b and c .. d|; w~normalnej sytuacji
% kierunek ,,post'' w~punkcie~$a$ jest okre/slony przez
% wektor $\vec{ab}$; je/zeli punkty $a$ i~$b$ si/e pokrywaj/a,
% kierunek ,,post'' w~punkcie~$a$ jest okre/slony przez
% wektor $\vec{ac}$; je/zeli tak/ze punkty $a$ i~$c$ si/e pokrywaj/a,
% ostatni/a szans/a na wyznaczenie kierunku ,,post'' w~punkcie~$a$
% jest wektor $\vec{ad}$; je/zeli wszystkie punkty $a$, $b$, $c$, i~$d$
% si/e pokrywaj/a, to oznacza, /ze segment jest zdegenerowany i~mo/ze
% by/c w zasadzie usuni/ety (analogiczn/a argumentacj/e mo/zna przedstawi/c
% dla kierunku ,,pre'' w punkcie~$d$).
%% \--------------------------------------------------------------------
% Previous, insufficiently robust definitions:
% |vardef predir expr t of p = (point t of p)-(precontrol t of p) enddef;|
% |vardef postdir expr t of p = (postcontrol t of p)-(point t of p) enddef;|
% |vardef udir expr t of p = unitvector(direction t of p) enddef;|
% New, more general definitions:
vardef gendir expr t of p =
 predir t of p + postdir t of p % |direction|-compatible definition
enddef;
vardef predir expr t of p =
 save a_,b_,c_,d_,s_,t_; pair a_,b_,c_,d_; path s_; t_:=t;
 if not cycle p: if t<0: t_:=0; elseif t>length(p): t_:=length(p); fi fi
  s_=subpath (ceiling t_-1,t_) of p;
  a_=point 0 of s_;
  b_=postcontrol 0 of s_; % |b_<>postcontrol t-1 of p| for |t=0|
  c_=precontrol 1 of s_;
  d_=point 1 of s_;
  if d_<>c_:     d_-c_
  elseif d_<>b_: d_-b_
  elseif d_<>a_: d_-a_
  else:       (0,0)
 fi
enddef;
vardef postdir expr t of p =
 save a_,b_,c_,d_,s_,t_; pair a_,b_,c_,d_; path s_; t_:=t;
 if not cycle p: if t<0: t_:=0; elseif t>length(p): t_:=length(p); fi fi
  s_=subpath (t_,floor t_+1) of p;
  a_=point 0 of s_;
  b_=postcontrol 0 of s_;
  c_=precontrol 1 of s_; % |c_<>precontrol t+1 of p| for |t=length p|
  d_=point 1 of s_;
  if a_<>b_:     b_-a_
  elseif a_<>c_: c_-a_
  elseif a_<>d_: d_-a_
  else:       (0,0)
 fi
enddef;
%% \--------------------------------------------------------------------
% Definitions related to ``pre-'' and ``post-'':
%% \-
% Definicje jako/s zwi/azane z~,,pre-'' i~,,post-'':
%% \--------------------------------------------------------------------
vardef udir expr t of p = unitvector(gendir t of p) enddef;
vardef upredir expr t of p = unitvector(predir t of p) enddef;
vardef upostdir expr t of p = unitvector(postdir t of p) enddef;
vardef pos_subpath expr z of p =
 if not cycle p: subpath z of p else:
  if xpart(z)<=ypart(z): subpath z of p
  else: subpath (xpart(z),ypart(z)+length(p)) of p fi
 fi
enddef;
%
vardef posttension expr t of p = % ``The \MF{}book'', ex. 14.15
 save q_; path q_;
 q_=point t of p {direction t of p} .. {direction t+1 of p} point t+1 of p;
 length(postcontrol 0 of q_ - point 0 of q_)/
 length(postcontrol t of p - point t of p)% doesn't work for ``straight lines''
enddef;
vardef pretension expr t of p = % ditto
 save q_; path q_;
 q_=point t-1 of p {direction t-1 of p} .. {direction t of p} point t of p;
 length(precontrol 1 of q_ - point 1 of q_)/
 length(precontrol t of p - point t of p)% doesn't work for ``straight lines''
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The two macros below, |path_eq| and |inside| macros, might have been
% primitives. The macro |path_eq| is obvious; |a inside b| returns true
% if the bounding box of |a| is inside the bounding box of |b|, which
% may be misleading; think, for example of:
% |fullcircle inside unitsquare shifted (-1/2,-1/2) scaled .9 rotated 45|.
% For most curves occuring in fonts, however, one can safely infere
% that if |a inside b| holds, then |a| is inside |b|.
%% \-
%% \descriptioncomments
% Poni/zsze dwa makra mog/lyby by/c w~zasadzie instrukcjami podstawowymi.
% Makro |path_eq| jest oczywiste. Wynikiem operacji |a inside b| jest
% ,,true'' je/zeli prostok/at ograniczaj/acy |a| le/zy wewn/atrz prostok/ata
% ograniczaj/acego |b|, co mo/ze dawa/c wynik myl/acy, np.~w~wypadku
% |fullcircle inside unitsquare shifted (-1/2,-1/2) scaled. 9 rotated 45|.
% Jednak/ze w~wi/ekszo/sci sytuacji wyst/epuj/acych fontach
% mo/zna /smia/lo zak/lada/c, /ze z~|a inside b| wynika, i/z |a| le/zy
% wewn/atrz~|b|.
%% \--------------------------------------------------------------------
vardef path_eq(expr a,b)=
 save i_,l_,r_; boolean r_;
 r_:=(length(a)=length(b)) and (cycle a= cycle b);
 if r_:
  i_:=0; l_:=length(a) if cycle a: -1 fi;
  forever:
   r_:=(point i_ of a = point i_ of b); exitif not r_;
   r_:=(precontrol i_ of a = precontrol i_ of b); exitif not r_;
   r_:=(postcontrol i_ of a = postcontrol i_ of b); exitif not r_;
   exitif incr i_>l_;
 endfor fi
 r_
enddef;
%
tertiarydef a inside b =
 if path a: % |and path b|
  (xpart llcorner b < xpart llcorner a) and
  (xpart urcorner b > xpart urcorner a) and
  (ypart llcorner b < ypart llcorner a) and
  (ypart urcorner b > ypart urcorner a)
 else: % |numeric a and pair b|
  (a>=xpart b) and (a<=ypart b)
 fi
enddef;
%% \--------------------------------------------------------------------
%  Two convenient macros more:
%% \-
%  Jeszcze dwa wygodne makra:
%% \--------------------------------------------------------------------
vardef x_time expr x of p = % obsolete
 xpart(p intersectiontimes ((x,-infinity)--(x,infinity)))
enddef;
vardef y_time expr y of p = % obsolete
 xpart(p intersectiontimes ((-infinity,y)--(infinity,y)))
enddef;
vardef xtime expr x of p = % preferable alias
 xpart(p intersectiontimes ((x,-infinity)--(x,infinity)))
enddef;
vardef ytime expr y of p = % preferable alias
 xpart(p intersectiontimes ((-infinity,y)--(infinity,y)))
enddef;
%% \--------------------------------------------------------------------
%%   A few figures more:
%% \-
%%   Par/e dodatkowych figur:
%% \--------------------------------------------------------------------
vardef triangle =
 (0,-1/2)--(0.866,0)--(0,1/2)--cycle % |1/2sqrt(3)| $\approx$ |0.866025...|
enddef;
vardef vpolygon(expr n) =
 for i:=0 upto n-1: (1/2right rotated ((360/n)*(i+1/2))) -- endfor cycle
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% A method, entangled a bit and not particularly robust, of testing whether
% a parameter is a {\it string\/} expression or a {\it suffix}.
% (Remark: |is_suffix((a))| or |is_suffix(a+b)| returns |true|;
% |is_suffix(((a)))| causes \MP{} to report an error).
%% \-
%% \descriptioncomments
% Nieco pokr/etna i niezbyt og/olna metoda sprawdzania, czy parametr
% jest wyra/zeniem typu {\it string\/} czy {\it sufiksem}.
% (Uwaga: |is_suffix((a))| b/ad/x |is_suffix(a+b)| zwraca |true|,
% za/s |is_suffix(((a)))| powoduje, /ze \MP{} zg/lasza b/l/ad).
%% \--------------------------------------------------------------------
vardef is_suffix(text suffix_or_not_suffix) =
 save the_suffix_; string the_suffix_; is_suffix_ suffix_or_not_suffix;
 the_suffix_<>""
enddef;
def is_suffix_ suffix $ = the_suffix_:= str $; killtext enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The macro |&&| is to be used instead of the |&| operator if the respective
% ends of paths coincide only approximately; using |..| instead would add
% unwanted tiny B\'ezier segments. The macro is somewhat ``left-handed,''
% i.e., it does not consider the expression that follow the macro, therefore,
% it can be used before the `|cycle|' command; if the argument |p| of the
% macro |amp_amp_| is a |pair|, it is just ignored which may be
% considered hardly intuitive.
%% \-
%% \descriptioncomments
% Makra |&&| nale/zy u/zywa/c zamiast operatora |&| je/sli ko/nce /scie/zek
% nie pokrywaj/a si/e idealnie; u/zycie operatora |..| zamiast |&|
% spowodowa/loby dodanie do /scie/zki zb/ednych (ma/lych) segment/ow
% B\'eziera. Makro to jest nieco ,,lewor/eczne'', tzn.~nie analizuje
% wyra/zenia, kt/ore si/e po nim pojawi, dzi/eki czemu mo/ze by/c u/zyte
% przed operatorem ,|cycle|'; argument |p| makra |amp_amp_| b/ed/acy
% punktem (|pair|) jest pomijany, co mo/zna uzna/c za zachowanie ma/lo
% intuicyjne.
%% \--------------------------------------------------------------------
def && = amp_amp_ whatever enddef;
tertiarydef p amp_amp_ q =
 if not pair p:
  (subpath(0,length(p)-1) of p) .. controls (postcontrol length(p)-1 of p)
   and (precontrol length(p) of p) ..
 fi
enddef;
%% \--------------------------------------------------------------------
%% A few postfix and infix path operators:
%% \-
%% Par/e postfiksowych i~infiksowych operator/ow /scie/zkowych:
%% \--------------------------------------------------------------------
primarydef a mirr b = a reflectedabout(origin,b) enddef;
%
def store_prec_obj = store_prec_obj_ whatever enddef;
primarydef a store_prec_obj_ b = hide(def prec_obj = a enddef) enddef;
%
primarydef a sub b =
 if path a: (pos_subpath b of a) elseif string a: (substring b of a) fi
enddef;
%
def node = store_prec_obj node_ enddef;
vardef node_@# primary a =
 if str @#="x": xpart(point a of prec_obj)
 elseif str @#="y": ypart(point a of prec_obj)
 elseif str @#="": point a of prec_obj
 else:
  errhelp "The operator `node' works only with `x', `y' or an empty suffixes.";
  errmessage "PX: improper usage of `node'";
 fi
enddef;
%
def first suffix $ =
 if str $="at": % moves the first point of a path to a specified location
  store_prec_obj prec_obj shifted -(point 0 of prec_obj) shifted
 else: node$(0) fi
enddef;
def last suffix $ =
 if str $="at": % moves the last point of a path to a specified location
  store_prec_obj prec_obj shifted
   -(point if cycle prec_obj: 0 else: infinity fi of prec_obj) shifted
 else: node$(if cycle prec_obj: 0 else: infinity fi) fi
enddef;
%
% node-governed flipping:
def nflipped = nflipped_ whatever enddef;
primarydef a nflipped_ b =
 if cycle a: a
 else: reverse(a reflectedabout (point 0 of a, point infinity of a))
 fi
enddef;
%
def xflipped = xflipped_ whatever enddef;
primarydef a xflipped_ b =
 reverse(a reflectedabout
   (1/2[llcorner a, lrcorner a], 1/2[ulcorner a, urcorner a]))
enddef;
%
def yflipped = yflipped_ whatever enddef;
primarydef a yflipped_ b =
 reverse(a reflectedabout
   (1/2[llcorner a, ulcorner a], 1/2[lrcorner a, urcorner a]))
enddef;
%
% node-governed rotating (infix operator):
primarydef a nrotated b =
 if cycle a: a
 else: a rotatedaround(1/2[point 0 of a,point infinity of a], b)
 fi
enddef;
%
% center-governed rotating (infix operator):
primarydef a crotated b =
 a rotatedaround(1/2[llcorner a, urcorner a], b)
enddef;
%% \--------------------------------------------------------------------
%% Neat macros excerpted from John D. Hobby's boxes.mp macro package:
%% \-
%% Zgrabne makra zaczerpni/ete z zestawu makr boxes.mp Johna D. Hobby'ego:
%% \--------------------------------------------------------------------
% Find the length of the prefix of string |s| for which |cond| is true for
% each character |c| of the prefix
vardef generisize_prefix(expr s)(text cond) =
 save i_, c_; string c_;
 i_ = 0;
 forever:
  c_ := substring (i_,i_+1) of s;
  exitunless cond; exitif incr i_=length s;
 endfor
 i_
enddef;
%
% Take a string returned by the |str| operator and return the same string
% with explicit numeric subscripts replaced by generic subscript symbols []:
vardef generisize(expr s) =
 save res_, s_, l_; string res_, s_;
 res_=""; % result so far
 s_ =s; % left to process
 forever: exitif s_="";
  l_:=generisize_prefix(s_, (c_<>"[") and ((c_<"0") or (c_>"9")));
  res_:=res_ & substring (0,l_) of s_;
  s_:=substring (l_,infinity) of s_;
  if s_<>"":
   res_ := res_ & "[]";
   l_ :=if s_>="[": 1+generisize_prefix(s_, c_<>"]")
    else: generisize_prefix(s_, (c_=".") or ("0"<=c_) and (c_<="9")) fi;
   s_:=substring(l_,infinity) of s_;
  fi
 endfor
 res_
enddef;
%%\vfill\eject
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The macro |extrapolate| computes a ``superpath'' (as opposed to
% ``subpath'') for a single B\'ezier segment in such a way
% that the following identity holds
% (for 0${}\le{}$|t1|${}\le{}$|t2|${}\le{}$1):
%% \-
%% \descriptioncomments
% Makro |extrapolate| wyznacza ,,nad/scie/zk/e'' (w~odr/o/znieniu od
% ,,pod/scie/zki'') dla pojedynczego /luku B\'eziera w~taki spos/ob,
% /ze poni/zsza r/owno/s/c jest spe/lniona (dla
% 0${}\xle{}$|t1|${}\xle{}$|t2|${}\xle{}$1):
%% %
%% \LINE{%
%% \descriptioncomments
%   |subpath (t1,t2) of (extrapolate (t1,t2) of b) = b|
%% \unskip}
%% %
%% \descriptioncomments
% Below, there are the results of the command |extrapolate (.3,.7) of p|
% for three similarly defined paths. The black line denotes the source
% path, the gray one---its~extrapolation.
%% \-
%% \descriptioncomments
% Poni/zsza ilustracja przedstawia wynik polecenia |extrapolate (.3,.7) of p|
% dla trzech podobnie zdefiniowanych /scie/zek. Czarn/a lini/a zaznaczona
% zosta/la /scie/zka oryginalna, szar/a~--~ekstrapolowana.
%% %
%% \LINE{\valign{#\vss\cr
%%   \hbox{\epsfbox{\illusname.100}}\cr\noalign{\hfil}
%%   \hbox{\epsfbox{\illusname.101}}\cr\noalign{\hfil}
%%   \hbox{\epsfbox{\illusname.102}}\cr
%% }}
%% %
%% \descriptioncomments
% Exercise 1. What happens if the relation
% 0${}\le{}$|t1|${}\le{}$|t2|${}\le{}$1
% is not fulfilled? (Hint: there are~a~few
% possible cases.)\vadjust{\smallskip}\break
% Exercise 2. True or false:
%% \-
%% \descriptioncomments
% Zadanie 1. Co by si/e sta/lo, gdyby warunek
% 0${}\xle{}$|t1|${}\xle{}$|t2|${}\xle{}$1 nie by/l spe/lniony?
% (Wskaz/owka: mo/zliwych jest kilka r/o/znych
% przypadk/ow.)\vadjust{\smallskip}\break
% Zadanie 2. Prawda czy fa/lsz:
%% %
%% \LINE{%
%% \descriptioncomments
%  |point 1 of (extrapolate (t.a,t) of b) = point 1 of (extrapolate (t.b,t) of b)|
% \quad for\quad |t.a<>t.b|
%% \unskip}
%% %
%% \descriptioncomments
% Exercise 3. Try to imagine the result of the extrapolation for
% such weird (yet trivial) paths~as:%
%% \-
%% \descriptioncomments
% Zadanie 3. Spr/obuj przewidzie/c wynik ekstrapolacji dla tak dziwnych
% (chocia/z trywialnych) /scie/zek~jak:%
%% \LINE{%
%% \descriptioncomments
%  |(0,0) .. controls (0,0) and (100,0) .. (100,0)| \quad or\quad
%  |(0,0) .. controls (100,0) and (0,0) .. (100,0)|
%% \unskip}
%% \--------------------------------------------------------------------
vardef extrapolate expr t of b = % |t| pair, |b| B\'ezier segment
 clearxy;
 Casteljau(xpart(t)) = point 0 of b;
 Casteljau(1/3[xpart(t),ypart(t)]) = point 1/3 of b;
 Casteljau(2/3[xpart(t),ypart(t)]) = point 2/3 of b;
 Casteljau(ypart(t)) = point 1 of b;
 z0 .. controls z1 and z2 .. z3
enddef;
%
def Casteljau(expr t) =
 t[t[t[z0,z1], t[z1,z2] ], t[t[z1,z2], t[z2,z3] ] ]
enddef;
%
vardef elongation_to_times(expr ea,eb) =
 % negative parameter values are admissible; they are meant for |pen_stroke|
 (if ea<0: - fi 1/(abs(ea)+1), eb/(abs(eb)+1))
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% A~numerical function `|point_line_dist|' takes as a~parameter
% three |pair| expressions and returns a~(signed) value of the distance
% of the first parameter from the line defined by the other two.
% It is referred to in the `|is_line|' function.
%% \-
%% \descriptioncomments
% Funkcja ,|point_line_dist|', zale/zna od trzech wyra/ze/n typu |pair|,
% oblicza odleg/l/o/s/c (dodatni/a lub ujemn/a) pierwszego z~parametr/ow
% od linii okre/slonej przez dwa pozosta/le parametry. Do funkcji
% ,|point_line_dist|' odwo/luje si/e funkcja ,|is_line|'.
%% \--------------------------------------------------------------------
vardef point_line_dist(expr a,b,c) =
 clearxy; save d_; d_=sqrt(length(b-c));
 z0=a/d_; z1=b/d_; z2=c/d_;
 (x2-x1)*(y1-y0)-(x1-x0)*(y2-y1)
enddef;
%% \--------------------------------------------------------------------
%% The following code (its idea is due to Dan Luecking and Larry Siebenmann)
%% computes the area surrounded by a cyclic path.
%% \-
%% Poni/zszy kod (pomys/l podsun/eli Dan Luecking i~Larry Siebenmann)
%% oblicza pole obszaru ograniczonego zamkni/et/a krzyw/a B\'eziera.
%% \--------------------------------------------------------------------
newinternal area_scale;
area_scale:=1; % decrease if the result is going to be too large
vardef area(expr p) = % |p| is a B\'ezier segment; result = $\int y\, dx$
 save xa, xb, xc, xd, ya, yb, yc, yd;
 (xa,20ya)=point 0 of p;
 (xb,20yb)=postcontrol 0 of p;
 (xc,20yc)=precontrol 1 of p;
 (xd,20yd)=point 1 of p;
   area_scale*(xb-xa)*(10ya + 6yb + 3yc +   yd)
  +area_scale*(xc-xb)*( 4ya + 6yb + 6yc +  4yd)
  +area_scale*(xd-xc)*(  ya + 3yb + 6yc + 10yd)
enddef;
vardef Area(expr P) = % |P| is a cyclic path
 area(subpath (0,1) of P)
  for t=1 upto length(P)-1: + area(subpath (t,t+1) of P) endfor
enddef;
%% \--------------------------------------------------------------------
%% The idea of calculation of a turning angle
%% between two vectors, employed in the definition of the function
%% `turn_ang,' is based on the following observation:
%% \-
%% Idea obliczania k/ata (skierowanego) mi/edzy dwoma wektorami,
%% wykorzystana w~funkcji ,turn_ang', zasadza si/e na nast/epuj/acej
%% obserwacji:
%% %
%% \LINE{%
%% \descriptioncomments
%   |z reflectedabout(origin,right)=1/z|
%% \unskip}
%% %
%% for a complex number $z$ such that $\vbar z\vbar=1$;
%% recall also that multiplication of complex numbers
%% (`zscaled' operation) implies addition of their angle arguments.
%% \-
%% dla liczby zespolonej $z$ takiej, /ze $\vbar z\vbar=1$; przypomnijmy
%% tak/ze, /ze mno/zeniu liczb zespolonych (operacja ,zscaled')
%% odpowiada dodawanie argument/ow k/atowych.
%% \--------------------------------------------------------------------
vardef turn_ang(expr za,zb) =
 if (abs(za)>=1/1000) and (abs(zb)>=1/1000): % |eps| may be not enough
  angle(unitvector(za) zscaled (unitvector(zb) reflectedabout (origin,right)))
 else: whatever fi
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% A~Boolean function `|is_line|' checks whether a~given B\'ezier segment
% is a~straight line. For large segments (fonts) it makes sense to specify
% a~numerical parameter |is_line_off>=0|; it defines a~maximal acceptable
% distance of the control points of a~B\'ezier arc from its secant
% (which corresponds to the distance between the arc and the secant
% circa |3/4is_line_off| for a symmetric, inflexionless arcs).
%% \-
%% \descriptioncomments
% Boole'owska funkcja, ,|is_line|' sprawdza, czy dany segment B\'eziera
% jest lini/a prost/a. Dla du/zych segment/ow (fonty) mo/ze mie/c sens zadanie
% parametru numerycznego |is_line_off>=0|; okre/sla on maksymalne dopuszczalne
% odchylenie naci/ag/ow krzywej B\'eziera od siecznej (co odpowiada
% odleg/lo/sci krzywej od siecznej wynosz/acej ok.~|3/4is_line_off|
% dla symetrycznych /luk/ow bez punkt/ow przegi/ecia).
%% \--------------------------------------------------------------------
vardef is_line(expr B) =
 save r_; boolean r_;
 if known is_line_off:
  save a_;
  a_=length((point 1 of B)-(point 0 of B));
  r_=(-a_+arclength(B))<=(a_/infinity);
  if r_:
   r_:=(is_line_off>=abs(point_line_dist(
         postcontrol 0 of B, point 0 of B, point 1 of B))) and
       (is_line_off>=abs(point_line_dist(
         precontrol 1 of B, point 0 of B, point 1 of B)));
  fi
 else: % backward compatibility
  save a_,b_,c_,d_;
  a_=length((point 1 of B)-(point 0 of B));
  b_=length((postcontrol 0 of B)-(point 0 of B));
  c_=length((precontrol 1 of B)-(postcontrol 0 of B));
  d_=length((point 1 of B)-(precontrol 1 of B));
  r_=(-a_+b_+c_+d_ <= a_/infinity);
 fi
 r_
enddef;
%% \--------------------------------------------------------------------
%% Abbreviations for a few simple yet useful phrases:
%% \-
%% Skr/oty dla kilku prostych acz przydatnych fraz:
%% \--------------------------------------------------------------------
def xyscaled primary p = xscaled xpart(p) yscaled ypart(p) enddef;
def yxscaled primary p = yscaled xpart(p) xscaled ypart(p) enddef;
primarydef a xscaledto b =
 hide(lastscale:=b/(xpart(urcorner(a))-xpart(llcorner(a))))
 a xscaled lastscale
enddef;
primarydef a xyscaledto b =
 hide(lastscale:=b/(xpart(urcorner(a))-xpart(llcorner(a))))
 a scaled lastscale
enddef;
primarydef a yscaledto b =
 hide(lastscale:=b/(ypart(urcorner(a))-ypart(llcorner(a))))
 a yscaled lastscale
enddef;
primarydef a yxscaledto b =
 hide(lastscale:=b/(ypart(urcorner(a))-ypart(llcorner(a))))
 a scaled lastscale
enddef;
%
pair lastshift;
primarydef a llshiftedto b =
 hide(lastshift:=-llcorner(a)+b) a shifted lastshift
enddef;
primarydef a lrshiftedto b =
 hide(lastshift:=-lrcorner(a)+b) a shifted lastshift
enddef;
primarydef a urshiftedto b =
 hide(lastshift:=-urcorner(a)+b) a shifted lastshift
enddef;
primarydef a ulshiftedto b =
 hide(lastshift:=-ulcorner(a)+b) a shifted lastshift
enddef;
primarydef a ccshiftedto b =
 hide(lastshift:=-center(a)+b) a shifted lastshift
enddef;
%% \--------------------------------------------------------------------
%% Joining two paths at their intersection point:
%% \-
%% /L/aczenie dw/och scie/zek w punkcie ich przeci/ecia:
%% \--------------------------------------------------------------------
tertiarydef a intersection_join b = % like |softjoin|
 begingroup save t_;
  (t_1,t_2)=a intersectiontimes b; a.sub(0,t_1)&&b.sub(t_2,infinity)
 endgroup
enddef;
%% \--------------------------------------------------------------------
%% Changing locally non-internal variables (sometimes we want to set locally
%% not only numeric variables):
%% \-
%% Lokalna zmiana warto/sci zwyk/lych zmiennych (czasami zachodzi potrzeba
%% lokalnej zmiany nie tylko zmiennych numerycznych):
%% \--------------------------------------------------------------------
def local suffix s =
 begingroup
  save local_stack_value_, local_stack_name_;
  if pair s: pair local_stack_value_; fi
  if path s: path local_stack_value_; fi
  if picture s: picture local_stack_value_; fi
  if string s: string local_stack_value_; fi
  if color s: color local_stack_value_; fi
  local_stack_value_ = s; def local_stack_name_ = s enddef;
  local_
enddef;
def local_ expr x = local_stack_name_:=x enddef;
def endlocal = local_stack_name_:=local_stack_value_; endgroup; enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The following abbreviation is roughly equivalent to the Knuthian
% {\it of-the-way function}, namely, to the |whatever[z1,z2]|
% operator; observe, however, that this construction requires that
% both |z1| and |z2| should be known, while |z1| the in
% the construction |z1^z2| can be unknown.
%% \-
%% \descriptioncomments
% Poni/zszy skr/ot jest z grubsza r/ownowa/zny Knuthowej funkcji
% {\it w-p/o/l-drogi}, tzn. operatorowi |whatever[z1,z2]|;
% odnotujmy wszak/ze, /ze konstrukcja ta wymaga, by zar/owno
% |z1| jak i~|z2| by/ly znane, natomiast konstrukcja |z1^z2|
% pozwala, by |z1| by/lo nieznane.
%% \--------------------------------------------------------------------
primarydef a ^ b = a + whatever * b enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The macro `leg' computes the leg of a right-angled triangle,
% given a hypotenuse (vector, parameter~|c|) and a length
% of one leg (parameter~|b|).
%% \-
%% \descriptioncomments
% Makro ,leg' oblicza przyprostok/atn/a tr/ojk/ata prostok/atnego
% przy za/lo/zeniu, /ze znana jest przeciwprostok/atna (wektor,
% parametr~|c|) i~przyprostok/atna (parametr~|b|).
%% \--------------------------------------------------------------------
primarydef c leg b =
 begingroup save a_; pair a_;
  a_+b/(length(c)+-+b)*(a_ rotated -90)=c; % |(length(c)+-+b)=length(a_)|
  a_
 endgroup
enddef;
%% \--------------------------------------------------------------------
%% This extremely simple macro is particularly
%% useful for constructing sloped objects. Assume, for example, that
%% we want to draw the following parallelogram:
%% \-
%% To pro/sciutkie makro jest szczeg/olnie u/zyteczne przy konstruowaniu
%% uko/snych obiekt/ow. Za/l/o/zmy, /ze chcemy narysowa/c nast/epuj/acy
%% r/ownoleg/lobok:
%% %
%% \LINE{\epsfbox{\illusname.103}}
%% %
%% \descriptioncomments
% (given |h|, |w| and |b|). This is exactly the situation, where
% the macro `leg' comes handy in. Given |z0| and |z2|, the remaining
% points |z1| and |z3| can be easily determined from the following
% relations:
%% \-
%% \descriptioncomments
% dla zadanych wielko/sci |h|, |w| i~|b|. To jest w/la/snie
% ta~sytuacja, w~kt/orej makro ,leg' okazuje si/e u/zyteczne.
% Maj/ac dane punkty |z0| i~|z2|, punkty |z1| i~|z3| wyznaczy/c
% mo/zna z~relacji:
%% %
%% \LINE{%
%% \descriptioncomments
%   |z1=z0+whatever*((z2-z0) leg (-b));|\quad
%   |y1=y2;|\quad |z1-z2=z0-z3;|
%% \unskip}
%% %
%% Note the minus preceding the second argument to~the~`leg';
%% the positive value means ``leftwards,'' negative---``rightwards''
%% (with respect to hypotenuse vector).
%% \-
%% Odnotujmy obecno/s/c minusa przed drugim argumentem makra ,leg';
%% warto/s/c dodatnia oznacza ,,po~lewej'', ujemna~--~,,po prawej''
%% (wzgl/edem wektora przeciwprostok/atnej).
%% \--------------------------------------------------------------------
%% \medskip
%% \--------------------------------------------------------------------
%% {\descriptioncomments
% The macro |quicksort| sorts |@#||s.i ... @#||s.j| along with
% |@#|.|$i ... @#|.|$j| for |$| $\in$ |t|, using Tony Hoare's ``quick sort''
% method; suffix |s| must must not occur in the |t| list (no checking
% is performed); if both |s| and |t| are empty, |t| is ignored.
%% }
%% \bull Remark 1: the algorithm has no explicit recursion, because of
%%  \MF{}//\MP{} limits on recursion level.
%% \bull Remark 2: the algorithm is not stable, i.e., it does not
%%  preserve the order of equal items.
%% \bull {\descriptioncomments
%    Sample usage: |quicksort| |A(1,100)()(x,y)| will sort |A1|,
%    |A2,...|$\,$|,A100| (comparing |A.i| with |A.j|) and, moreover,
%    |A.x1, A.y1,...|$\,$|,A.x100, A.y100| will be reordered simultaneously.
%% }
%% \-
%% {\descriptioncomments
% Makro |quicksort| sortuje |@#||s.i ... @#||s.j| wraz
% z~|@#|.|$i ... @#|.|$j| dla |$| $\in$ |t|, z~u/zyciem algorytmu
% ``quick sort'', kt/orego autorem jest Tony Hoare;
% sufiks |s| nie mo/ze wyst/api/c w~li/scie |t| list (za/lo/zenie to
% nie jest sprawdzane); je/sli parametry |s| i~|t| s/a r/ownocze/snie
% puste, parametr |t| ignorowany.
%% }
%% \bull Uwaga 1: algorytm nie korzysta z~jawnej rekursji ze wzgl/edu
%%  na ograniczenia implementacyjne \MF{}//\MP{}.
%% \bull Uwaga 2: algorytm jest niestabilny, tzn. nie zachowuje
%%  kolejno/sci r/ownych obiekt/ow.
%% \bull {\descriptioncomments
%    Przyk/ladowe u/zycie: |quicksort| |A(1,100)()(x,y)| posortuje |A1|,
%    |A2,...|$\,$|,A100| (por/ownuj/ac |A.i| z~|A.j|), ponadto
%    |A.x1, A.y1,...|$\,$|,A.x100, A.y100| zostan/a r/ownocze/snie
%    odpowiednio przestawione.
%% }
%% \--------------------------------------------------------------------
vardef quicksort@#(expr i,j)(suffix s)(text t) =
 save i_,j_,k_,l_,cell_,stack_,incl_t_; boolean incl_t_;
 pair stack_[\\]; stack_.lev:=0; stack_[incr stack_.lev]:=(i,j);
 i_:=0; for $:=t: i_:=i_+1; endfor % ``measure'' |t|-list
 incl_t_:=(str s <> "") or ((str s = "") and (i_<>0));
 forsuffixes $:= s if incl_t_: , t fi:
  if numeric @#.$[i]: numeric cell_.$;
  elseif string @#.$[i]: string cell_.$;
  elseif boolean @#.$[i]: boolean cell_.$;
  fi
 endfor
 forever:
 exitif stack_.lev<=0;
  numeric i_,j_; (i_,j_)=stack_[stack_.lev]; stack_.lev:=stack_.lev-1;
  if i_<j_:
   forsuffixes $:= s if incl_t_: , t fi: cell_.$:=@#.$[i_]; endfor
   l_:=i_;
   for k_:=i_+1 upto j_:
    if is_less(@#.s[k_],cell_.s):
     forsuffixes $:=s if incl_t_: , t fi:
      @#.$[l_]:=@#.$[k_]; @#.$[k_]:=@#.$[l_+1];
     endfor
     l_:=l_+1;
    fi
   endfor
   forsuffixes $:= s if incl_t_: , t fi: @#.$[l_]:=cell_.$; endfor
   stack_[incr stack_.lev]:=(i_,l_-1); stack_[incr stack_.lev]:=(l_+1,j_);
  fi
 endfor
enddef;
vardef is_less(expr a,b) = (a<b) enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The macro |soften_path| rounds all corners of a path |p|;
% |r| is the radius. Use |soften_nodes| for rounding corners at
% a given set of nodes; its text parameter |t| is a comma-separated
% list of either numbers or pairs: a number means the number
% of a node, a pair means the number of a node and a local
% radius, to be used instead of~|r|; prior to insertion
% the list of nodes is sorted.
%% \-
%% \descriptioncomments
% Macro |soften_path| zaokr/agla naro/za /scie/zki |p|;
% |r|~oznacza promie/n. Aby zaokr/agli/c naro/za w~wybranych w/ez/lach
% nale/zy u/zy/c makra |soften_nodes|; parametr tekstowy~|t| tego
% makra jest list/a (separowan/a przecinkami) liczb lub par:
% liczba oznacza numer w/ez/la, para~-- numer w/ez/la i~lokalny
% promie/n zaokr/aglenia (zamiast~|r|); lista w/ez/l/ow przed
% wstawieniem jest sortowana.
%% \--------------------------------------------------------------------
vardef soften_node(expr p,r,t) = % path, radius, node (i.e., time)
 save q_; path q_; interim join_radius:=r;
 if cycle p:
  q_=(subpath (t-1,t) of p) softjoin (subpath (t,t+length(p)-1) of p) & cycle;
   (subpath(1-t, 1+length(q_)-t) of q_) & cycle % re-position origin
 else: (subpath (0,t) of p) softjoin (subpath (t,length(p)) of p) fi
enddef;
%
vardef soften_nodes(expr p,r) (text t) =
 save j_, n_, p_, r_, t_; path p_; p_:=p;
 t_:=0; for i_:=t: (n_[incr t_],r_[t_])=if pair i_: i_ else: (i_,r) fi; endfor
 quicksort(1,t_)(n_)(r_);
 j_:=-1; for i_:=1 upto t_: p_:=soften_node(p_,r_[i_],n_[i_]+incr j_); endfor;
 p_
enddef;
%
vardef soften_path(expr p,r) = % path, radius
 save p_; path p_; p_:=p;
 if r>0:
  for i_:=if cycle p: 0 else: 1 fi step 2 until 2(length(p)-1):
   p_:=soften_node(p_,r,i_);
  endfor;
 fi
 p_
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The macro |insert_nodes| inserts additional nodes at given non-integer
% non-repeating times~|t| into a given path |p|.
% The code would be a bit longer without `|arclength|' and `|arctime|.'
% The macro can be useful in some cases in the context of finding
% the envelopes of pen-stroked paths (avoiding inflection
% points---see below).
%% \-
%% \descriptioncomments
% Macro |insert_nodes| wstawia w~/scie/zce~|p| dodatkowe
% w/ez/ly w~punktach odpowiadaj/acych czasom~|t| (nieca/lkowitym,
% niepowtarzaj/acym si/e). Bez funkcji ,|arclength|' i~,|arctime|'
% kod by/lby nieco d/lu/zszy. Makro to mo/ze by/c przydatne przy
% wyznaczaniu obrysu pi/orka (unikanie punkt/ow przegi/ecia -- p.~ni/zej).
%% \--------------------------------------------------------------------
vardef insert_nodes(expr p)(text t) =
 save j_, p_, s_, t_; path p_; p_:=p;
 t_:=0;
 for i_:=t:
  if round(i_)<>i_: % ignore integer times
   t_[incr t_]=arclength(subpath(0,i_ mod length(p_)) of p_);
  fi
 endfor
 for i_:=1 upto t_:
  s_:=arctime t_[i_] of p_;
  if abs(round(s_)-s_)>eps: % ignore repeating times; is |eps| OK?
   p_:=(subpath (0, s_) of p_) && (subpath (s_,length p_) of p_)
    if cycle p_: & cycle fi;
  fi
 endfor;
 p_
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The macro |delete_nodes| removes, as the name suggests, selected nodes
% from a given (cyclic) path. The macro can be useful for removing
% superfluous nodes, e.g., in case of improving fonts converted
% from PFB to \MP{}. The nodes can be removed in three possible
% ways: with both control nodes, with the precontrol node, or with
% the postcontrol one.
% During the process of removal, additional control
% nodes may be removed. More precisely: given a path |p|, let
% |z_[i_]| denothes its |i_|-th node, |z_[i_]b|---the respective
% precontrol node (``before''), |z_[i_]a|---the respective postcontrol
% node (``after''). Macro |delete_nodes| removes elements (by assigning
% an undefined value) from the tables |z_[\\]|, |z_[\\]b| and |z_[\\]a|
% in such a way that the following invariant holds for the main loop:
% for any pair of consecutive known nodes |z_[i_]| and |z_[j_]|,
% |i_<j_|, there exist exactly two indices |u_| and |v_| such that
% |i_<=u_<v_<=j_| and both |z_[u_]a| and |z_[v_]b| are known; moreover,
% |z_[w_]a| and |z_[w_]b| are unknown for the remaining indices |w_|,
% |i_<=w_<=j_|. The resulting path is constructed from the elements
% that remain in the table.\break
% Nodes to be removed are passed as the list of pairs
% (text parameter |node_list|):
% |(index,kind)|, where |index| denotes the time of
% the path corresponding to a given node, and |kind|
% is a number. If |kind=0|, both control nodes are to be removed;
% if~|kind<0|, a~precontrol node is to be removed;
% if~|kind>0|, a~postcontrol node is to be removed.\break
% The figure below shows the results of the |delete_nodes|
% applied to a sample path |p| (|p=fullcircle|): the topmost picture depicts
% the source path and the numbering of nodes, the left lower picture
% is the path returned by
% |delete_nodes(p)((1,-1), (3,-1), (5,-1), (7,-1))|
% middle lower one---by
% |delete_nodes(p)((1,0), (3,0), (5,0), (7,0))|,
% right lower one---by
% |delete_nodes(p)((1,1), (3,1), (5,1), (7,1))|.
%% \-
%% \descriptioncomments
% Makro |delete_nodes|, jak sama nazwa wskazuje, usuwa wskazane w/ez/ly
% z~danej (cyklicznej) /scie/zki. Makro mo/ze si/e przyda/c do usuwania
% zb/ednych w/ez/l/ow, na przyk/lad przy poprawianiu font/ow zamienionych
% z~postaci PFB na posta/c \MP{}-ow/a. W/ez/ly s/a usuwane na trzy mo/zliwe
% sposoby: wraz z~obydwoma przyleg/lymi naci/agami, z~poprzedzaj/acym
% lub z~nast/epuj/acym naci/agiem. W~ka/zdym z~przypadk/ow mog/a zosta/c
% te/z usuni/ete s/asiaduj/ace naci/agi.
% Dok/ladniej: dla danej /scie/zki |p| niech |z_[i_]| oznacza |i_|-ty w/eze/l,
% |z_[i_]b| -- jego naci/ag poprzedzaj/acy, |z_[i_]a| -- jego naci/ag
% nast/epuj/acy. Makro |delete_nodes| usuwa elementy (poprzez nadanie
% warto/sci nieokre/slonej) z~tablic |z_[\\]|, |z_[\\]b|
% i~|z_[\\]a| w~taki spos/ob, by zachowany by/l nast/epuj/acy
% niezmiennik: dla dowolnej pary s/asiaduj/acych w/ez/l/ow
% |z_[i_]| i~|z_[j_]|, |i_<j_|, istniej/a dok/ladnie dwa indeksy
% |u_| i~|v_|, takie /ze |i_<=u_<v_<=j_| i~zar/owno |z_[u_]a|,
% jak i~|z_[v_]b| s/a znane; ponadto |z_[w_]a| i~|z_[w_]b| s/a
% nieokre/slone dla pozosta/lych indeks/ow~|w_|, |i_<=w_<=j_|.
% Z element/ow, kt/ore pozostaj/a w~tablicy, budowana jest
% /scie/zka wynikowa.\break
% W/ez/ly, kt/ore maj/a by/c usuni/ete, s/a podawane jako lista par
% (parametr tekstowy |node_list|): |(indeks,rodzaj)|, gdzie |indeks| oznacza
% czas odpowiadaj/acy danemu w/ez/lowi na /scie/zce, a~|rodzaj|
% jest liczb/a; je/sli |rodzaj=0|, to usuwane s/a oba naci/agi,
% je/sli |rodzaj<0|, to usuwany jest naci/ag poprzedzaj/acy,
% je/sli |rodzaj>0|, to usuwany jest naci/ag nast/epuj/acy.\break
% Efekt dzia/lania makra dla przyk/ladowej /scie/zki |p| (|p=fullcircle|)
% jest przedstawiony na poni/zszym rysunku: g/orna ilustracja przedstawia
% /scie/zk/e /xr/od/low/a z~numeracj/a w/ez/l/ow, lewa dolna ilustracja
% to rezultat u/zycia operacji
% |delete_nodes(p)((1,-1), (3,-1), (5,-1), (7,-1))|
% /srodkowa dolna -- operacji
% |delete_nodes(p)((1,0), (3,0), (5,0), (7,0))|,
% prawa dolna -- operacji
% |delete_nodes(p)((1,1), (3,1), (5,1), (7,1))|.
%% %
%% \LINE{\vbox{\kern3mm\hbox{\epsfbox{\illusname.104}}}}
%% \--------------------------------------------------------------------
vardef delete_nodes(expr p)(text node_list) = % |p| is cyclic
 save o_,i_,j_,j__,l_,n_,z_; pair z_[\\],z_[\\]a,z_[\\]b;
 n_=length(p);
 for i_:=0 upto n_:
   z_[i_]:=point i_ of p;
   z_[i_]a:=postcontrol i_ of p;
   z_[i_]b:=precontrol i_ of p;
 endfor
 for l_:=node_list:
  % here the above-mentioned invariant holds (the result may depend
  % on the order of the nodes to be deleted, if neighbouring nodes
  % are being deleted)
  i_:=xpart(l_) mod n_; % to |mod| or not to |mod|?
  % to ignore (with a |message|) or to apply the |mod| operation?
  z_[i_]:=whatever_pair;
  if ypart(l_)=0: % delete predecessing |b|-node and successing |a|-node
   j_:=i_; forever: exitif known z_[j_]b; j_:=(j_-1) mod n_; endfor
   z_[j_]b:=whatever_pair;
   j_:=i_; forever: exitif known z_[j_]a; j_:=(j_+1) mod n_; endfor
   z_[j_]a:=whatever_pair;
  elseif ypart(l_)>0: % delete successing |a|-node and |b|-node
   j_:=i_; forever: exitif known z_[j_]a; j_:=(j_+1) mod n_; endfor
   z_[j_]a:=whatever_pair;
   j_:=i_; forever: j_:=(j_+1) mod n_; exitif known z_[j_]b; endfor
   z_[j_]b:=whatever_pair;
  else: % |ypart(l_)<0|; delete predecessing |a|-node and |b|-node
   j_:=i_; forever: j_:=(j_-1) mod n_; exitif known z_[j_]a; endfor
   z_[j_]a:=whatever_pair;
   j_:=i_; forever: exitif known z_[j_]b; j_:=(j_-1) mod n_; endfor
   z_[j_]b:=whatever_pair;
  fi
 endfor
 i_:=0; forever: exitif known z_[i_]; i_:=i_+1; endfor; o_:=i_;
 for i_:=o_ upto n_-1+o_:
  hide(j_:=i_ mod n_; j__:=(i_+1) mod n_)
  if known z_[j_]: z_[j_] fi
  if known z_[j_]a: .. controls z_[j_]a fi
  if known z_[j__]b: and \\ z_[j__]b .. fi
 endfor \\ z_[o_] & cycle
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The macros |insert_extreme| and |insert_extremes| insert additional
% nodes at extremes into a given path |p|. They make use of |unslant_stroke|
% operation in order to provide valid extremes after slanting the path~|p|.
% The first parameter (optional, of type |text|, i.e, it the list
% of numbers or pairs) defines either the minimal acceptable length
% of a~resulting subpath (if its value is of the |numeric| type) or
% a~subpath to be excluded from the process of the insertion of extremes
% (if its value is of the |pair| type).
%% \-
%% \descriptioncomments
% Makra |insert_extreme| i~|insert_extremes| wstawiaj/a dodatkowe w/ez/ly
% w~ekstremach w~/scie/zce~|p|. Makra robi u/zytek z~operacji |unslant_stroke|
% aby zapewni/c w/la/sciwe po/lo/zenie ekstrm/ow po pochyleniu s/cie/zki~|p|.
% Pierwszy, opcjonalny parametr (typu |text|; tzn. jest to lista liczb lub
% par) pozwala poda/c d/lugo/s/c minimalnej akceptowalnej (wynikowej)
% pod/scie/zki oraz pod/scie/zki nieuwzgl/edniane przy wstawianiu
% ekstrem/ow; decyduje o~tym typ warto/sci parametru: |integer|
% oznacza d/lugo/s/c, |pair|~-- pod/scie/zk/e.
%% \--------------------------------------------------------------------
vardef insert_extremes(text opt)(expr p) = % far from being optimal...
 save p_; path p_;
 p_:=insert_extreme(opt)(up)(p);
 p_:=insert_extreme(opt)(left)(p_);
 p_:=insert_extreme(opt)(down)(p_);
 insert_extreme(opt)(right)(p_)
enddef;
%
vardef insert_extreme(text opt)(expr d,p) = 
 save ignored_size_,ignored_segments_,a_,b_,found_,p_,t_,t__; path p_;
 ignored_size_:=ignore_nib_limit;
 for opt_:=opt:
  if numeric opt_: ignored_size_:=opt_; fi
  if pair opt_:
   a_:=floor (xpart opt_); b_:=ceiling (ypart opt_)-1; if b_<a_: b_:=a_; fi
   for t_:=a_ upto b_: ignored_segments_[t_]:=1; endfor
  fi
 endfor
 for t_:=0 upto length(p)-1:
  hide(found_:=whatever)
  if unknown ignored_segments_[t_]:
   hide (p_:=subpath (t_,t_+1) of p)
   if arclength(p_)>ignored_size_:
    hide(t__:=directiontime d unslant_stroke of p_)
    if (arclength(subpath (0,t__) of p_)>ignored_size_) and
       (arclength(subpath (t__,1) of p_)>ignored_size_): hide(found_:=1)
    fi
   fi
  fi
  if known found_: ((subpath (0,t__) of p_) && (subpath (t__,1) of p_)) else: p_ fi
  &
 endfor
 if cycle p: cycle fi
enddef;
%% \vfill\eject
%% \--------------------------------------------------------------------
%% \centering \bf A MODULE THAT FINDS AN~OUTLINE FOR
%% A SINGLE (SELF-INTERSECTING) CYCLIC PATH
%% OR~A~PAIR OF~CYCLIC~PATHS
%% \-
%% \centering \bf MODU/L ZNAJDUJ/ACY OBWIEDNI/E POJEDYNCZEJ
%% /SCIE/ZKI CYKLICZNEJ (SAMOPRZECINAJ/ACEJ SI/E)
%% LUB PARY /SCIE/ZEK CYKLICZNYCH
%%
%% \LINE{\leaders\hrule\hfill}
%%
%% The problem can be stated as follows: two paths are given (precisely:
%% expressions of type {\bf path}); assume that the positively directed
%% (anti-clockwise) path accomplishes filling, and negatively directed
%% (clockwise)---erasing; the task is to find the outline of the resulting
%% (visible) figure. Such a task is known as ``removing overlaps''
%% which seems too narrow for such a complex operation. Actually,
%% the basic macro of that part, i.e., `find_outlines,' accomplishes
%% set-theory operations: sum, difference and product, depending on the
%% turning number of the input paths. The illustration below demonstrates
%% the results yielded by the macro `find_outlines.' There are four
%% cases since there are four combinations of turning numbers for two
%% ``regular'' paths. Each case shows the initial situation (left)
%% and the resulting one (right). Filling is omitted, the outline colour
%% shows the turning number: blue---positive, red---negative.
%% \-
%% Problem mo/zna postawi/c w~nast/epuj/acy spos/ob: dane s/a dwie /scie/zki
%% (dok/ladniej wyra/zenia typu {\bf path}); zak/ladamy, /ze dodatnio
%% skierowane /scie/zki (przeciwnie do ruchu wskaz/owek zegara) zaczerniaj/a
%% obszar, a~ujemnie -- odczerniaj/a. Nale/zy znale/x/c obwiedni/e
%% tak powsta/lej (widocznej) figury. Operacja ta nosi nazw/e
%% ,,usuwanie cz/e/sci wsp/olnej'', co niezbyt dobrze oddaje z/lo/zony
%% charakter operacji. W~istocie podstawowa operacja tego modu/lu,
%% tj.~,find_outlines', realizuje operacje teoriomnogo/sciowe:
%% sum/e, iloczyn i~r/o/znic/e, w~zale/zno/sci od kierunk/ow wej/sciowych
%% /scie/zek. Poni/zsza ilustracja przedstawia wyniki dzia/lania makra
%% ,find_outlines'. Ka/zdy z~czterech przypadk/ow pokazuje stan
%% pocz/atkowy (lewa strona) i~ko/ncowy (prawa strona). Wype/lnienie nie
%% zosta/lo naniesione, zaznaczony jedynie zosta/l kierunek /scie/zek: kolor
%% niebieski -- kierunek dodatni, kolor czerwony -- kierunek ujemny.
%% %
%% \LINE{\epsfbox{\illusname.105}}
%% %
%% \descriptioncomments
% A single (cyclic) curve can be supplied as an input argument to
% |find_outlines|; in this case it {\it should have\/} self-intersections.
% Depending on the orientation of the input path, there are possible
% two sets of resulting paths:
%% \-
%% \descriptioncomments
% Argumentem wej/sciowym makra |find_outlines| mo/ze by/c pojedyncza
% (cykliczna) /scie/zka; w takim przypadku {\it powinna\/} ona mie/c
% samoprzeci/ecia. Makro |find_outlines| -- w~zale/zno/sci od kierunku
% wej/sciowej /scie/zki -- znajduje dwa mo/zliwe zestawy /scie/zek
% wynikowych:
%% %
%% \LINE{\epsfbox{\illusname.106}}
%% \--------------------------------------------------------------------
vardef feasible_cross(suffix p,q,v)(expr c,s) =
 if v[c]: (s*turn_ang(gendir p[c] of p, gendir q[c] of q)>0)
 else: false fi
enddef;
%
vardef recombine(expr self_intersection)(suffix p, r) =
 save s_,e_,v_,n_; boolean v_[\\];
 if not path r0: scantokens("path " & generisize(str r) & "[]"); fi
 if not numeric r.num: scantokens("numeric " & generisize(str r.num); fi
 r.num:=0;
 s_:=if self_intersection: 1 else: turningnumber(p1)*turningnumber(p2) fi;
 for i_:=1 upto p.num: v_[i_]:=true; endfor
 forever:
  save c_; c_:=0;
  forever:
   c_:=c_+1; exitif c_>p.num; exitif feasible_cross(p1,p2,v_,c_,s_);
  endfor
  exitif c_>p.num;
  e_:=1;
  r[incr r.num]:=
   forever:
    hide(e_:=3-e_; v_[c_]:=false;
    if self_intersection: % identify the same crossings as ``visited''
     for i_:=1 upto p.num:
      % |intersectiontime| is not a comutative operation:
      if abs(p[e_][c_]-p[3-e_][i_])<=16epsilon: % |1epsilon|? |2epsilon|?
       v_[i_]:=false;
      fi
     endfor
    fi
    n_:=next_time(p[e_])(c_))
    (pos_subpath (p[e_][c_],p[e_][n_]) of p[e_]) hide(c_:=n_) &&
    exitif not v_[n_];
   endfor
   cycle;
 endfor
enddef;
%
vardef next_time(suffix p)(expr t) =
 save c_;
 for i_:=1 upto p.num:
  if (p[i_]>p[t]):
   if known c_: if p[i_]<p[c_]: c_:=i_; fi else: c_:=i_; fi
  fi
 endfor
 if unknown c_:
  c_=1; for i_:=2 upto p.num: if p[i_]<p[c_]: c_:=i_; fi endfor
 fi
 c_
enddef;
%
vardef feasible_time(suffix p)(expr t) =
 save b_,i_; boolean b_; b_:=true; i_:=0;
 forever:
  i_:=i_+1;
  exitif (unknown p[i_]) or (not b_);
  b_:=b_ if (abs(p[i_]-t)<1) or (abs(p[i_]-t)>length(p)-1): % optimization?
   and (arclength( pos_subpath(p[i_],t) of p ) > acc_eps)
   and (arclength( pos_subpath(t,p[i_]) of p ) > acc_eps)
  fi;
 endfor
 b_
enddef;
%
vardef intersect_curves(expr self_intersection)(suffix p) =
 save l_,p_; l_:=0;
 for i_:=0 upto length(p1)-1:
  for j_:=0 upto length(p2)-1:
% if a curve is being self-intersected, we demand that its neighbouring
% B\'ezier segments do not intersect (could be circumvent at the cost
% of the increased complexity of computation):
   if if self_intersection: (abs(i_-j_) mod (length(p1)-1))>1 else: true fi:
   for k_:=1 upto
    intersect_segments(subpath (i_,i_+1) of p1, subpath (j_,j_+1) of p2)(p_):
% assuming that there are no self-intersections of single B\'ezier segments,
% it suffices to check feasibility only for |p1|:
    if feasible_time(p1, p_1[k_]+i_):
     p1[incr l_]=p_1[k_]+i_; p2[l_]=p_2[k_]+j_;
    fi
   endfor
   fi
  endfor
 endfor
 p.num:=p1num:=p2num:=l_;
enddef;
%
vardef intersect_segments(expr a,b)(suffix p) =
 save ta_,tb_; (ta_,tb_)=a intersectiontimes b;
 if ta_>=0:
  p1[1]:=ta_; p2[1]:=tb_;
  save tc_,td_; (tc_,td_)=reverse a intersectiontimes reverse b;
  if length(1/2[point ta_ of a, point tb_ of b]
   -1/2[point tc_ of reverse a, point td_ of reverse b])>acc_eps:
   p1[2]:=1-tc_; p2[2]:=1-td_; 1+ \\ fi \\ 1
 else: 0 fi
enddef;
newinternal acc_eps; acc_eps:=.5;
%% \--------------------------------------------------------------------
%% As was mentioned, the input argument to `find_outlines' can be either
%% a single path or a pair of paths. The paths must comply with
%% the following assumptions:
%% \bull paths are cyclic;
%% \bull if two paths are passed as an argument, each of them should
%% contain no self-intersection;
%% \bull if a single path is passed as an argument, its adjacent segments
%% do not intersect;
%% \bull no tangent touching occur;
%% \bull no inflection points occur (because the applied algorithm
%% assumes that two B\'ezier segments can cross at at most two points)
%% \bull segments are long enough (minimal length of a segment after the
%% process of intersection is controlled by the variable
%% {\descriptioncomments
% |acc_eps|---see above).
%% }
%% \-
%% Jak zosta/lo wspomniane, wej/sciowym argumentem makra ,find_outlines'
%% mo/ze by/c albo pojedyncza /scie/zka, albo para /scie/zek.
%% Nast/epuj/ace warunki musz/a by/c spe/lnione:
%% \bull /scie/zki powinny by/c cykliczne
%% \bull je/sli argumentem jest para /scie/zek, /zadna z~nich nie powinna
%% mie/c punkt/ow samoprzeci/ecia;
%% \bull je/sli argumentem jest pojedyncza /scie/zka, to jej s/asiednie
%% segmenty B\'eziera nie powinny si/e przecina/c;
%% \bull nie powinny wyst/epowa/c punkty styczno/sci;
%% \bull nie powinny wyst/epowa/c punkty przegi/ecia (gdy/z
%% zastosowany algorytm zak/lada, /ze dwa segmenty B\'eziera
%% przecinaj/a si/e co najwy/zej w~dw/och punktach);
%% \bull poszczeg/olne segmenty powinny by/c dostatecznie d/lugie (minimalna
%% d/lugo/s/c segmentu po procesie znajdowania przeci/e/c jest okre/slona
%% {\descriptioncomments
% przez zmienn/a |acc_eps| -- p.~wy/zej).
%% }
%% \LINE{}
%% Further improvements:
%% \bull intersection points nearly coinciding with
%%    nodes should be replaced by the nodes, i.e., by an integer time.
%% \-
%% Przewidywane udoskonalenie:
%% \bull je/sli punkt przeci/ecia niemal/ze pokrywa si/e z~w/ez/lem
%% kt/orej/s z~krzywych, to do oblicze/n powinien by/c brany ten/ze w/eze/l.
%% \--------------------------------------------------------------------
vardef find_outlines(text a)(suffix r) = % |a| -- input, |r| -- output
 save auto_,i_,q_;
 boolean auto_; numeric q_.num; numeric q_[\\][\\]; path q_[\\];
 i_:=0;
 for a_:=a: q_[incr i_]:=a_; endfor
 if i_>2: % presumably, a user never tries to intersect no paths
  errhelp "I'll ignore superfluous paths.";
  errmessage "PX: too many paths (" & decimal(i_) & ")";
 fi
 auto_:=unknown q_2; if auto_: q_2=q_1; fi;
 intersect_curves(auto_,q_);
 if q_.num=0: % emergency?
  if not path r[0]: scantokens("path " & generisize(str r) & "[]"); fi
  if not numeric r.num: scantokens("numeric " & generisize(str r.num); fi
  if auto_: r.num:=-1; r1:=q_1;
  else: r.num:=-2; r1:=q_1; r2:=q_2; fi
 else: recombine(auto_,q_,r); fi
enddef;
%% \vfill\eject
%% \--------------------------------------------------------------------
%% \centering \bf A MODULE THAT FINDS AN~ENVELOPE OF A PATH BEING DRAWN
%% WITH AN ELLIPTICAL OR A ONE-DIMENSIONAL (``RAZOR'') PEN
%% \-
%% \centering \bf MODU/L ZNAJDUJ/ACY OBRYS OBSZARU ZAMALOWYWANEGO
%% PRZEZ PI/ORKO ELIPTYCZNE LUB JEDNOWYMIAROWE (,,/ZYLETKOWE'')
%%
%% \LINE{\leaders\hrule\hfill}
%%
%% \descriptioncomments
% The following macros approximate the envelope of an elliptical or a razor
% pen. The exact solution is impossible---in general, the envelope is not
% a B\'ezier curve, therefore some heuristics is, in general, unavoidable.
% We assumed that the backbone of a figure is such that
% the envelope does not form loops at smoothly joined nodes. Moreover,
% all B\'ezier segments appearing in the process {\bf should not}
% contain inflection points (the reason for this limitation is the
% method of finding an approximation of a pen envelope). If the latter
% condition is not fulfilled, one may expect weird results (see the usage
% of the |...| operator in the code of |pen_stroke_edge|).
%% \-
%% \descriptioncomments
% Poni/zsze makra przybli/zaj/a brzeg /scie/zki kre/slonej eliptycznym lub
% ,,/zyletkowym'' pi/orkiem. Dok/ladne rozwi/azanie nie jest mo/zliwe~--
% w~og/olno/sci brzeg nie jest krzyw/a B\'eziera, zatem heurystyki
% w~og/olno/sci unikn/a/c si/e nie da. Za/lo/zyli/smy, /ze szkielet
% figury jest tak skonstruowany, /ze przy g/ladko po/l/aczonych w/ez/lach
% kraw/ed/x pi/orka nie rysuje p/etli. Ponadto krzywe pojawiaj/ace si/e
% w~trakcie przetwarzania {\bf nie~powinny~mie/c} punkt/ow przegi/ecia (co
% wi/a/ze si/e z~zastosowanym sposobem aproksymacji obrysu pi/orka). Je/sli
% to za/lo/zenie nie jest spe/lnione, mo/zna oczekiwa/c dziwacznych efekt/ow
% (p.~u/zycie operatora |...| w~kodzie makra |pen_stroke_edge|).
%% \--------------------------------------------------------------------
%% \bigskip
%% \--------------------------------------------------------------------
%% \descriptioncomments
% We assume that slanting should not distort a pen. Therefore, if
% a glyph is to be slanted {\it after\/} expanding a stroke, which
% usually is the case, the envelope should be constructed with
% an {\it unslanted pen}. Macros |slant_stroke|, |unslant_stroke|,
% and |unslant_angle| are devised to facilitate handling this
% situation. These macros refer to the variable |slant_stroke_val|;
% it should be assigned a definite value prior to expanding stroke.
%% \-
%% \descriptioncomments
% Zak/ladamy, /ze pochylenie ({\it slanting\/}) nie powinno wp/lywa/c
% na kszta/lt pi/orka. Zatem je/sli obrys konstruujemy w~taki spos/ob,
% /ze pochylenie jest wykonywane po wyznaczeniu obrysu pi/orka, co
% zwykle ma miejsce, to obrys powinnien by/c znajdowany dla pi/orka
% poddanego pochyleniu odwrotnemu ({\it unslanting\/}).
% Makra |slant_stroke|, |unslant_stroke| oraz |unslant_angle|
% zosta/ly wprowadzone po to, aby u/latwi/c obs/lug/e takiego zabiegu.
% Zmiennej |slant_stroke_val|, do kt/orej te makra si/e odwo/luj/a,
% nale/zy nada/c stosown/a warto/s/c przed wyznaczaniem obrysu pi/orka.
%% \--------------------------------------------------------------------
def slant_stroke =
 if known slant_stroke_val: slanted slant_stroke_val fi
enddef;
def unslant_stroke =
 if known slant_stroke_val: slanted -slant_stroke_val fi
enddef;
vardef unslant_angle(expr a) = angle(dir(a) unslant_stroke) enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% Macro |fix_nib| returns a path. If |y_diam| parameter
% is~0, a ``razor'' pen (a segment) is returned, otherwise it is
% an approximation of an ellipse. We do our best to avoid unnecessary
% nodes, hence the approximation is somewhat complicated; another reason
% for the complication is that interpolation and affine transformations
% do not commute, therefore the appropriate nodes are found for
% the untransformed pen, and only then the pen is transformed.
% {\it Note\/}: So far, there is no explicit relation between a built-in
% \MP{} pen mechanism and the |fix_nib| operation, in particular,
% |beginfig| does not alter the setting of |default_nib|. Needs rethinking.
%% \-
%% \descriptioncomments
% Makro |fix_nib| zwraca /scie/zk/e. Je/sli parametr |y_diam|
% jest r/owny~0, zwracane jest pi/orko ,,/zyletkowe'' (odcinek),
% w~przeciwnym razie wynikiem jest (przybli/zona) elipsa. Poniewa/z
% chcemy w~miar/e mo/zliwo/sci unika/c zb/ednych w/ez/l/ow, konstrukcja
% przybli/zenia jest nieco skomplikowana. Dodatkowym czynnikiem komplikuj/acym
% jest to, /ze interpolacja nie jest przemienna wzgl/edem przekszta/lce/n
% afinicznych, dlatego najpierw wyznaczane s/a stosowne w/ez/ly na
% niezdeformowanym pi/orku, a dopiero potem pi/orko jest przekszta/lcane.
% {\it Uwaga\/}: Nie ma bezpo/sredniego powi/azania mi/edzy operacj/a
% |fix_nib| a~wbudowanym w~\MP{}-a mechanizmem pi/orek, w~szczeg/olno/sci
% |beginfig| nie zmienia ustawienia |default_nib|. Rzecz wymaga przemy/slenia.
%% \--------------------------------------------------------------------

vardef fix_nib(expr x_diam, y_diam, rot_angle) =
 if (x_diam<>0) and (y_diam<>0): fix_elliptic_nib(x_diam, y_diam, rot_angle)
 elseif (x_diam<>0) and (y_diam=0): fix_razor_nib(x_diam, rot_angle)
 elseif (x_diam=0) and (y_diam<>0): fix_razor_nib(y_diam, rot_angle+90)
 else:
  errhelp "I'll use the default pen, but I'd suggest to cancel the job.";
  errmessage "PX: the null pen is not alowed";
  default_nib
 fi
enddef;

vardef fix_razor_nib(expr x_diam, rot_angle) =
 ((-1/2x_diam,0)--(1/2x_diam,0)) rotated rot_angle unslant_stroke
enddef;

vardef fix_elliptic_nib(expr x_diam, y_diam, rot_angle) =
 save p_; path p_;
 % construct a temporary ellipse:
 p_:=fullcircle
  xscaled x_diam yscaled y_diam rotated rot_angle unslant_stroke;
 % construct an elliptic pen path having
 % 4 or, if necessary (heuristic), 6 nodes:
 (for d=up unslant_stroke, left,
  if (y_diam/x_diam<1/2) and (abs(rot_angle mod 90)>5):
    left rotated rot_angle unslant_stroke,
  fi
  down unslant_stroke, right,
  if (y_diam/x_diam<1/2) and (abs(rot_angle mod 90)>5):
    right rotated rot_angle unslant_stroke
  fi:
  (point(directiontime d of p_) of fullcircle)
   {direction (directiontime d of p_) of fullcircle}...
 endfor cycle) xscaled x_diam yscaled y_diam rotated rot_angle unslant_stroke
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% Arcs of a pen shorter than |ignore_nib_limit| will be joined together
% to form larger ones. Remember to adjust the parameter |ignore_nib_limit|
% if the size of |default_nib| is significantly changed.
%% \-
%% \descriptioncomments
% /Luki pi/orka kr/otsze ni/z |ignore_nib_limit| zostan/a po/l/aczone
% w~wi/eksze segmenty. Nale/zy pami/eta/c o~zmianie parametru
% |ignore_nib_limit| przy znacz/acej zmianie rozmiaru pi/orka
% (|default_nib|).
%% \--------------------------------------------------------------------
newinternal ignore_nib_limit; ignore_nib_limit:=5;

path default_nib;
default_nib:=fix_nib(50,50,0); % hundred times as large as a default plain pen

newinternal default_elongation, default_join, default_cap;
default_elongation:=1/2;
default_join:=1;
  % 0 -- tip, default elongation used
  % 1 -- pen join, default elongation ignored
  % 2 -- tip, default elongation ignored, elongation=0 used
default_cap:=1;
  % 0 -- cut 90 rel
  % 1 -- pen end
%% \--------------------------------------------------------------------
%% \descriptioncomments
% |tangent_point|, |pen_join|, |pen_stroke_edge_|, and |pen_stroke_edge|
% are auxiliary macros, exploited by the main macro, i.e., |pen_stroke|.
%% \-
%% \descriptioncomments
% |tangent_point|, |pen_join|, |pen_stroke_edge_| i~|pen_stroke_edge| to
% makra pomocnicze, u/zyte w~g/l/ownym makrze, tj.~|pen_stroke|.
%% \--------------------------------------------------------------------
vardef tangent_point(expr d,nib) = % |d| -- direction of pen movement
 save a_;
 point if cycle nib: (directiontime d of nib) else:
  hide (a_:=turn_ang(d,(point 1 of nib)-(point 0 of nib)))
  if abs(a_ mod 180)<.1: 1/2 % emergency
  elseif a_<0: 0 else: 1 fi
 fi of nib
enddef;
%
vardef pen_join(expr a,b,c,nib)=
 % deleting superfluous nodes is based on the |arclength| operation
 % which, obviously, is not preserved after slanting,  but let's hope
 % it does not matter (too much)
 save t_, m_, m__, ta_, tb_, p_; path p_;
 m_:=infinity; % will be the minimal length of |nib|'s segment
 for t_:=0 upto 1/2length(nib)-1:
  m__:=arclength(subpath(t_,t_+1) of nib);
  if m__<m_: m_:=m__; fi
 endfor
 if m_<ignore_nib_limit:
  message "PX: the shortest nib segment < ignore_nib_limit (" &
    decimal(m__) & " < " & decimal(ignore_nib_limit) & ")";
 fi
 p_=nib shifted c;
 if cycle nib:
  ta_=directiontime a of p_; tb_=directiontime b of p_;
  p_:=pos_subpath(ta_,tb_) of p_;
  if arclength(p_)>ignore_nib_limit:
   for i_:=0,0:
    p_:=reverse p_; % short segments may appear at both ends
    if length(p_)>1: % optimization
     if arclength(subpath (0,1) of p_)<1/4ignore_nib_limit: 
      % cf. the comment concerning |1/4ignore_nib_limit| in
      % |pen_stroke_edge| below
      p_:=(point 0 of p_) .. controls (postcontrol 1 of p_) and 
        (precontrol 2 of p_) .. subpath (2,infinity) of p_;
    fi
   fi
   endfor
  else:
   p_:=(point 0 of p_){a}...{b}(point length(p_) of p_);
  fi
 else: % razor nib
  p_:=tangent_point(a,p_)--tangent_point(b,p_);
 fi
 p_
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% The finding of a~pen envelope for a~given B\'ezier segment,
% defined by nodes |a|, |b|, |c|, and |d|, begins with
% the placing the pen at the ends of the B\'ezier segment
% (i.e., at the points |a|, |d|) and finding the corresponding points
% |a'| and |d'| where the pen outline is parrallel to the direction
% of the original path at these points. Then, the outline is constructed.
% For |pen_stroke_method=0| (default), the envelope segment is constructed
% by setting the beginning and final directions (optionally, the direction
% at a given node can be ignored); for |pen_stroke_method=1| or~2
% an alternative (more elaborate) procedure is involved which explicitly
% computes control nodes |b'| and |c'| of the resulting path basing on
% a~heuristic assumption that
% |length(b'-a')/length(b-a)|~$\approx$
% |length(c'-d')/length(c-d)|~$\approx$
% |length(a'-d')/length(a-d)|.\break
% The default method never produce concave edges because the operator |...|
% is used always; the alternative methods employs the operator
% |force_convex_edge| instead; for |pen_stroke_method=1| the convex edges
% are forced (i.e, inflexion points are being removed),
% for |pen_stroke_method=2| no forcing of convex edges takes place.
%% \-
%% \descriptioncomments
% Wyznaczanie brzegu obszaru rysowanego pi/orkiem
% dla segmentu B\'eziera okre/slonego przez w/ez/ly
% |a|, |b|, |c| i~|d|, rozpoczyna si/e od umieszczenia
% pi/orka w~w/ez/lach ko/ncowych (tj.~|a| i~|d|) znalezienia
% odpowiadaj/acych im punkt/ow |a'| i~|d'| w~kt/orych obwiednia
% pi/orka jest r/ownoleg/la do oryginalnej /scie/zki. Nast/epnie
% konstruowana jest kraw/ed/x brzegu obszaru rysowanego pi/orkiem.
% Dla metody domy/slnej (|pen_stroke_method=0|) /scie/zka jest
% budowana na podstawie kierunku pocz/atkowego i~ko/ncowego.
% Dla metody alternatywnej (|pen_stroke_method=1| lub~2) /scie/zka jest
% wyznaczana przez jawne wyliczenie naci/ag/ow
% (|b'|~i~|c'|) na podstawie heurystycznego za/lo/zenia
%  |length(b'-a')/length(b-a)|~$\approx$
%  |length(c'-d')/length(c-d)|~$\approx$
%  |length(a'-d')/length(a-d)|.\break
% Pierwsza z metod (tzn. domy/slna) nie daje w~wyniku /scie/zki wkl/es/lej,
% gdy/z u/zywany jest zawsze operator |...|~; w~wypadku metody alternatywnej
% stosowany jest operator |force_convex_edge|, kt/ory wymusza wypuk/lo/s/c
% (tzn. usuwa punkty przegi/ecia) dla |pen_stroke_method=1|, natomiast
% nie wymusza dla |pen_stroke_method=2|.
%% \--------------------------------------------------------------------
vardef extrapoline expr t of B = % the result may be not a single segment
 save l_, t_;
 (t_.a,t_.b)=t; % |0<=ta_<tb_<=1|!
 l_=arclength(B)/(t_.b-t_.a); l_.a=l_*t_.a; l_.b=l_*(1-t_.b);
 if t_.a>0: ((point 0 of B) - l_.a*(upostdir 0 of B))-- fi
  B
 if t_.b<1:  -- ((point 1 of B) + l_.b*(upredir 1 of B)) fi
enddef;
%
vardef force_convex_edge(expr za, zb, zc, zd) =
 save a_, b_, c_, d_, z_;
 a_:=length(zd-za); b_:=length(zb-za); c_:=length(zc-zb); d_:=length(zd-zc);
 if (-a_+b_+c_+d_ > a_/infinity):
  if pen_stroke_method=2:
   za .. controls zb and zc .. zd
  else:
   if (a_>0.01) and (b_>0.01) and (c_>0.01) and (d_>0.01): % no degeneration...
    a_:=signum((za-zd) rotated -90 dotnorm (zb-za));
    b_:=signum((zb-za) rotated -90 dotnorm (zc-zb));
    c_:=signum((zc-zb) rotated -90 dotnorm (zd-zc));
    d_:=signum((zd-zc) rotated -90 dotnorm (za-zd));
    if ((a_<>b_) or (b_<>c_)) and (a_=d_):
     numeric b_, c_; pair z_;
     z_=b_[za,zb]=c_[zd,zc];
     za .. controls
      if b_<1: z_ else: zb fi and if c_<1: z_ else: zc fi
     .. zd
    else:
     za .. controls zb and zc .. zd
    fi
   else:
    za .. controls zb and zc .. zd
   fi
  fi
 else:
  za -- zd
 fi
enddef;
%
vardef pen_stroke_edge_(expr b,b_nib,e_nib) = % |b| -- B\'ezier segment
 save pa_,pb_,qa_,qb_,ra_,rb_,sa_,sb_;
 pair pa_,pb_,qa_,qb_,ra_,rb_,sa_,sb_;
 pa_=point 0 of b; ra_=(postcontrol 0 of b)-pa_; sa_=postdir 0 of b;
 pb_=point 1 of b; rb_=(precontrol 1 of b)-pb_;  sb_=predir 1 of b;
 qa_=pa_ + tangent_point(sa_, b_nib);
 qb_=pb_ + tangent_point(sb_, e_nib);
 if pen_stroke_method=0:
  qa_ {sa_} ... {sb_} qb_
 elseif (pen_stroke_method=1) or (pen_stroke_method=2):
  save lp_,lq_; lp_=length(pb_-pa_); lq_=length(qb_-qa_);
  if 2lp_<lq_: % heuresis -- too close nodes
   qa_ {sa_} ... {sb_} qb_
  else:
   force_convex_edge(qa_, qa_+lq_/lp_*ra_, qb_+lq_/lp_*rb_, qb_)
  fi
 else:
  errhelp "Only the values 0,1 and 2 for `pen_stroke_method' are admissible. " &
   "Better stop now.";
  errmessage "PX: unknown pen stroke method (" &
   decimal(pen_stroke_method) & ")";
 fi
enddef;
%
vardef pen_stroke_edge@#(expr p) =
 save e_,l_,i_,i__; path e_[\\];
 l_:=length(p);
 for i_:=0 upto l_-1:
  e_[i_]=pen_stroke_edge_(subpath (i_,i_+1) of p,
   % |local_nib_@#(i_),local_nib_@#(i_+1));| % a nasty bug removed 20.08.2009
   local_nib_@#(i_),local_nib_@#((i_+1) if cycle p: mod l_ fi)); 
 endfor
 for i_:=0 upto l_ if cycle p: -1 else: -2 fi:
  i__:=(i_+1) mod l_;
  save t_;
  t_:=turn_ang(predir 1 of e_[i_], postdir 0 of e_[i__]);
  if if known t_: abs(t_)>1 else: false fi:
   save t_; (t_.a,t_.b)=e_[i_] intersectiontimes e_[i__];
   if t_.a>0:
    e_[i_]:=subpath (0,t_.a) of e_[i_];
    e_[i__]:=subpath (t_.b,1) of e_[i__];
   elseif known local_tip_@#(i__):
    save tx_, ty_, b_, b__, ei_, ei__; path ei_, ei__, ei_[], ei__[];
    (tx_,ty_)=local_tip_@#(i__);
    ei_:=if is_line(e_[i_]):
     (point 0 of e_[i_])--
     (1/abs(tx_))[point 0 of e_[i_], point 1 of e_[i_] ]
     elseif tx_<0: hide(b_:=1) extrapoline (0,abs(tx_)) of e_[i_]
     else: extrapolate (0,abs(tx_)) of e_[i_] fi;
    ei__:=if is_line(e_[i__]):
     (1/(1-abs(ty_)))[point 1 of e_[i__], point 0 of e_[i__] ] --
     point 1 of e_[i__]
    elseif ty_<0: hide(b__:=1) extrapoline (abs(ty_),1) of e_[i__]
    else: extrapolate (abs(ty_),1) of e_[i__] fi;
% clumsy HEURESIS (choosing an optimal intersection point, if there are
% more intersections):
    save t_; (t_.a1,length(ei__)-t_.b1)=ei_ intersectiontimes reverse ei__;
    if t_.a1>0:
     ei_1:=if (known b_)  and (t_.a1>1):
       force_convex_edge(point 0 of e_[i_], postcontrol 0 of e_[i_],
        precontrol 1 of e_[i_],  point t_.a1 of ei_)
      else: subpath (0,t_.a1) of ei_ fi;
     ei__1:=if (known b__) and (t_.b1<1):
      force_convex_edge(point t_.b1 of ei__, postcontrol 0 of e_[i__],
       precontrol 1 of e_[i__], point 1 of e_[i__])
      else: subpath (t_.b1,infinity) of ei__ fi;
     (length(ei_)-t_.a2,t_.b2)=reverse ei_ intersectiontimes ei__;
     if length((t_.a1,t_.b1)-(t_.a2,t_.b2))>eps:
      ei_2:=if (known b_) and (t_.a2>1):
       force_convex_edge(point 0 of e_[i_], postcontrol 0 of e_[i_],
        precontrol 1 of e_[i_],  point t_.a2 of ei_)
       else: subpath (0,t_.a2) of ei_ fi;
      ei__2:=if (known b__) and (t_.b2<1):
      force_convex_edge(point t_.b2 of ei__, postcontrol 0 of e_[i__],
       precontrol 1 of e_[i__], point 1 of e_[i__])
       else: subpath (t_.b2,infinity) of ei__ fi;
      if arclength(ei_1)+arclength(ei__1) > arclength(ei_2)+arclength(ei__2):
       ei_1:=ei_2; ei__1:=ei__2;
      fi
     fi
     e_[i_]:=ei_1; e_[i__]:=ei__1;
    fi
   fi
  fi
 endfor
 for i_:=0 upto l_-1:
  hide(i__:=(i_-1) mod l_)
  if cycle p or (i_>0):
   if length((point 1 of e_[i__])-(point 0 of e_[i_]))>1/4ignore_nib_limit:
   % the constant |1/4ignore_nib_limit| plays a similar role
   % to that of the |SNAP_TO_NODE| variable in pf2mt1.awk
    (point 1 of e_[i__])
    if known local_tip_@#(i_): -- else:
     && pen_join(predir 1 of e_[i__],postdir 0 of e_[i_],point i_ of p,
      local_nib_@#(i_)) &&
    fi
   fi
  fi
  % reconstruct |e_[i_]| (possibly ignoring direction(s)):
  (point 0 of e_[i_])
   if is_line(e_[i_]):
   % the using of |--| circumvents \MF{}//\MP{} instable behaviour:
   % the operator |...| may cause that a control point and a node
   % (nearly) coincide (note that this is feature, not a bug);
   % thus, it is advisable for |pen_stroke_method=0|; supposedly,
   % it is also adequate for |pen_stroke_method=1|:
    --
   else:
    if pen_stroke_method=0:
     if not ignore_dir_(i_): {postdir 0 of e_[i_]} fi ...
     if not ignore_dir_(i_+1): {predir 1 of e_[i_]} fi
    elseif (pen_stroke_method=1) or (pen_stroke_method=2):
     .. controls (postcontrol 0 of e_[i_]) and (precontrol 1 of e_[i_]) ..
    fi
   fi
 endfor
 if cycle p: cycle else: (point 1 of e_[l_-1]) fi
enddef;
newinternal pen_stroke_method;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% Macro |pen_stroke| performs an operation known as ``expanding stroke'';
% we'll call the result of the operation a ``pen envelope'' (for
% a given path). The macro has one optional parameter, |opts| (|text|),
% and two obligatory ones: input path~|p| (|expr|)
% and a |result| (|suffix|). A user has an access to subpaths of the
% envelope, namely: |result.r| is the right edge of the envelope,
% |result.l|---its left edge, |result.b|---is a fragment of the pen outline
% joining left and right edge of the envelope at the beginning
% node of the path, |result.e|---is a similar fragment at the ending
% node of the path (see the picture below). If the path~|p|
% is cyclic, then |result.e| and |result.b| are undefined,
% otherwise the variable |result| contains additionally the complete
% expanded stroke.
%% \-
%% \descriptioncomments
% Makro |pen_stroke| realizuje operacj/e znan/a jako ,,ekspansja /scie/zki''
% ({\it expanding stroke\/}); wynik tej operacji b/edziemy okre/sla/c mianem
% ,,obrysu pi/orka'' (dla danej /scie/zki).
% Makro |pen_stroke| ma jeden parametr opcjonalny |opts| (typu |text|)
% oraz dwa parametry obowi/azkowe: /scie/zk/e wej/sciow/a~|p| (typu |expr|)
% i~wynik |result| (typu |suffix|). U/zytkownik ma dost/ep do pod/scie/zek
% obrysu, mianowicie: |result.r| to prawa kraw/ed/x obrysu, |result.l| --
% lewa, |result.b| -- fragment obwiedni pi/orka /l/acz/acy lew/a i~praw/a
% kraw/ed/x w~pocz/atkowym punkcie /scie/zki, |result.e| -- analogiczny
% fragment na ko/ncu /scie/zki (p.~rysunek poni/zej). Je/sli /scie/zka~|p|
% jest zamkni/eta, to |result.e| oraz |result.b| s/a niezdefiniowane,
% je/sli otwarta -- zmienna |result| zawiera dodatkowo kompletny
% obrys /scie/zki.
%% \LINE{\epsfbox{\illusname.109}}
%% \descriptioncomments
% For finding an envelope, a default path (|default_nib|, returned
% by |fix_nib|) is used except nodes for which the parameter |opts|
% sets another pen. Mastering the usage of the parameter |opts| allows
% a user to achieve nontrivial effects. The parameter |opts| is a list
% (space-separated or semicolon-separated) of the following
% operators: (1)~|nib|, (2)~|cut|, (3)~|tip|, and (4)~|ignore_directions|.
%% \-
%% \descriptioncomments
% Do wyznaczenia obrysu wykorzystywane jest pi/orko |default_nib|
% (zdefiniowane za pomoc/a makra |fix_nib|), za wyj/atkiem
% w/ez/l/ow, dla kt/orych parametr |opts| definiuje inne
% pi/orko. Bieg/le wykorzystanie parametru |opts|
% pozwala na uzyskiwanie nietrywialnych efekt/ow. Parametr |opts| jest
% list/a nast/epuj/acych polece/n (separowan/a spacjami lub /srednikami,
% jak kto woli):
% (1)~|nib|, (2)~|cut|, (3)~|tip| oraz (4)~|ignore_directions|.
%% \LINE{}
%% \descriptioncomments
% Ad 1. The macro |nib| has two parameters:
% |nib|(pen)(list_of_nodes), where ``pen'' is a path returned by
% macro |fix_nib|, and ``list_of_nodes'' contains comma-separated numbers
% (times) of the nodes of the path~|p| at which a given pen is to be
% used. If needed, the outline is complemented at corner nodes
% with a fragment of a pen path. Such a join corresponds to the setting
% |linejoin:=rounded| in \MP{}. If the path~|p| is non-cyclic,
% its ends are also complemented with appropriate fragments of a pen path
% (the setting |linecap:=rounded|). Such a method of joining is also applied
% by |pen_stroke| to nodes not mentioned in the parameter |opts|.
% The result of the following statement
%% \-
%% \descriptioncomments
% Ad 1. Wywo/lanie makra |nib| ma posta/c
% |nib|(pi/orko)(lista_w/ez/l/ow), gdzie ,,pi/orko'' jest /scie/zk/a
% zdefiniowan/a za pomoc/a makra |fix_nib|, a~,,lista_w/ez/l/ow'' zawiera
% rozdzielone przecinkami numery (czasy) w/ez/l/ow /scie/zki~|p|, w~kt/orych
% dane pi/orko ma by/c u/zyte. W~punktach naro/znych obrys jest
% w~razie potrzeby uzupe/lniany fragmentem /scie/zki pi/orka. Odpowiada
% to \MP{}-owemu ustawieniu |linejoin:=rounded|. W przypadku /scie/zki
% otwartej tak/ze jej ko/nce s/a uzupe/lnianie fragmentem pi/orka
% (|linecap:=rounded|). Taki spos/ob /l/aczenia stosowany jest r/ownie/z
% przez makro |pen_stroke| w~w/ez/lach niewymienionych w~parametrze
% |opts|. Wynik u/zycia polecenia
%% \LINE{\descriptioncomments
% |pen_stroke(nib(default_nib xyscaled (1,2))(infinity))(p)(q)|
%% \unskip}
%% \descriptioncomments
% that changes the pen at the last node of the path,
% is shown in the following picture:
%% \-
%% \descriptioncomments
% powoduj/acego zmian/e pi/orka w ostatnim w/e/xle /scie/zki
% przedstawia poni/zszy rysunek:
%% \LINE{\epsfbox{\illusname.110}}
%% \descriptioncomments
% Ad 2. The call of the macro |cut| has the form: |cut|(angle,
% pen)(list_of_nodes) or |cut|(pen,~angle)(list_of_nodes),
% where ``pen'' and ``list_of_nodes'' are defined as
% previously. The pen parameter can be omitted which means using a default
% pen (|default_nib|). The macro replaces a default pen with a special
% ``razor'' pen at specified nodes. More precisely, it is a projection of a
% given pen in the direction of the path~|p| at a given node onto a
% straight line going through this node under the angle specified in the
% respective parameter of the macro. Uf\/f\/f\dots\ The angle of the straight
% line can be defined either absolutly (with respect to the axis~|x|)
% or---by adding a prefix `|rel|'---relatively to the direction of the path
% at a given node. From the point of view of a user, the result of the
% macro |cut| is ``cutting'' the expanded stroke with a straight
% line. This operation is particularly useful at the ends of a path and
% corresponds to the setting |linecap:=butt| in \MP{}, except that in \MP{}
% one cannot specify angles. The result of the statement
%% \-
%% \descriptioncomments
% Ad 2. Wywo/lanie makra |cut| ma posta/c |cut|(k/at,
% pi/orko)(lista_w/ez/l/ow) lub |cut|(pi/orko,~k/at)(lista_w/ez/l/ow),
% gdzie ,,pi/orko'' i~,,lista_w/ez/l/ow'' s/a
% zdefiniowane jak wy/zej. Parametr okre/slaj/acy pi/orko mo/zna pomin/a/c,
% co oznacza u/zycie pi/orka domy/slnego (|default_nib|). Makro powoduje
% u/zycie w~zadanych punktach specjalnego pi/orka ,,/zyletkowego'',
% b/ed/acego rzutem danego pi/orka w~kierunku zgodnym z~kierunkiem
% scie/zki |p| w~danym w/e/xle na prost/a, przechodz/ac/a przez ten w/eze/l
% pod k/atem okre/slonym przez parametr ,,k/at''. Uf\/f\/f\dots\ K/at prostej
% mo/ze by/c okre/slany wzgl/edem osi |x|, lub~-- po dodaniu przedrostka
% ,|rel|'~-- wzgl/edem kierunku /scie/zki w~danym w/e/xle. Z~punktu widzenia
% u/zytkownika efektem dzia/lania makra |cut| jest ,,przeci/ecie'' obwiedni
% w~danym w/e/xle zadan/a prost/a~-- jest to u/zyteczne g/l/ownie na
% ko/ncach /scie/zki. Makro to odpowiada \MP{}-owemu ustawieniu
% |linecap:=butt|, z~tym /ze \MP{} nie pozwala na dowolne zadanie
% k/ata /sci/ecia. Wynik u/zycia polecenia
%% \LINE{\descriptioncomments
% |pen_stroke(cut(45)(0)|
% |cut(default_nib xyscaled (1,2), rel 90)(infinity))(p)(q)|
%% \unskip}
%% \descriptioncomments
% that cuts both ends and, moreover, changes a pen
% at the ending node is shown in the figure below
% (at the beginning node, the absolute angle of 45 degrees is specified,
% at the ending one---the relative angle of 90~degrees):
%% \-
%% \descriptioncomments
% definiuj/acego /sci/ecia na ko/ncach /scie/zki wraz ze zmian/a
% pi/orka w~punkcie ko/ncowym przedstawia poni/zszy rysunek
% (w~punkcie pocz/atkowym zadany jest k/at bezwzgl/edny 45~stopni,
% w~ko/ncowym~-- 90~stopni wzgl/edem kierunku /scie/zki):
%% \LINE{\epsfbox{\illusname.111}}
%% \descriptioncomments
% Ad 3. The call of the macro |tip| has the form |tip|(pen,
% pre_elongate, post_elongate)(list_of_nodes), where ``pen''
% and ``list_of_nodes'' have the same meaning as previously.
% In particular, a pen can be omitted. At corner nodes
% specified in the list of nodes, the consecutive elements of the outline
% are not joined with an appropriate subpath of a pen; instead, they
% are elongated (extrapolated) until they intersect. This process corresponds
% (roughly) to the \MP{} setting |linejoin:=mitered|:
%% \-
%% \descriptioncomments
% Ad 3. Wywo/lanie makra |tip| ma posta/c |tip|(pi/orko,
% przed_wyd/lu/zenie, po_wyd/lu/zenie)(lista_w/ez/l/ow), gdzie ,,pi/orko''
% i~,,lista_w/ez/l/ow'' maj/a posta/c jak w~poprzednich makrach,
% w~szczeg/olno/sci pi/orko r/ownie/z mo/zna pomin/a/c. W~w/ez/lach
% naro/znych, wyspecyfikowanych za pomoc/a tego makra, s/asiednie segmenty
% nie s/a /laczone fragmentem /scie/zki pi/orka, tylko s/a przed/lu/zane
% (ekstrapolowane) i~jest znajdowany ich punkt przeci/ecia. Procedura ta
% odpowiada z~grubsza \MP{}-owemu ustawieniu |linejoin:=mitered|:
%% \LINE{\epsfbox{\illusname.112}}
%% \descriptioncomments
% The illustration above is the result of the following call
% of the macro |pen_stroke| (the macro |tip| is invoked with default
% settings, only the number of a node is specified):
%% \-
%% \descriptioncomments
% Powy/zsza ilustracja to rezultat wywo/lania makra |pen_stroke|
% w~nast/epuj/acy (u/zycie makra |tip| bazuje na ustawieniach domy/slnych,
% wyspecyfikowany jest jedynie numer w/ez/la) spos/ob:
%% \LINE{\descriptioncomments
% |pen_stroke(tip()(3))(p)(q); draw q;|
%% \unskip}
%% \descriptioncomments
% The optional parameters |pre_elongation| and |post_elongation| define how
% far the consecutive edges (segments) should be elongated in order to make
% them intersect each other (the measure is the time). If one parameter is
% omitted, both will receive the same value; if both are omitted, a~default
% value, |(0.5,0.5)| (it corresponds to elongation by circa 50\%), will be
% used. The precise meaning of the pre- and post-elongation is defined as
% follows: for a~given pre-edge |e1|, post-edge |e2|, pre-elongation |v1|
% and post-elongation |v2|, the paths
%  |extrapolate (0, 1/(1+v1) of e1| and
%  |extrapolate (v2/(1+v2), 1) of e2| are computed
% (i.e., for the default elongation: |extrapolate (0, 2/3) of s1|
% and |extrapolate (1/3, 1) of s2|, respectively).
% If elongated curves do not intersect, the terminal nodes
% of the consecutive segments are joined with a~straight line. The latter
% property can be used to obtain a~result corresponding to the \MP{} setting
% |linejoin:=beveled|: it suffices to apply a~null elongation, i.e.,
% |tip|(0)(list_of_nodes). Changing the first (empty) parameter
% of the |tip| macro in the previous example would yield the following
% result:
%% \-
%% \descriptioncomments
% Parametry opcjonalne ,,przed_wyd/lu/zenie''
% i~,,po_wyd/lu/zenie'' okre/slaj/a, jak daleko maj/a by/c
% przed/lu/zane kraw/edzie (segmenty)~-- miar/a jest tu czas~--
% aby mo/zna by/lo wyznaczy/c ich punkt przeci/ecia. W~przypadku
% pomini/ecia jednego z~tych~parametr/ow oba otrzymuj/a t/e sam/a
% warto/s/c; je/sli oba zostan/a pomini/ete, u/zyta b/edzie warto/s/c
% domy/slna, tj.~|(0.5,0.5)|, odpowiadaj/aca wyd/lu/zeniu mniej
% wi/ecej o~50\%. /Sci/sle bior/ac: dla danej ,,przed-kraw/edzi''
% |e1|, ,,po-kraw/edzi'' |e2|, ,,przed-wyd/lu/zenia''~|v1| oraz
% ,,po-wyd/lu/zenia''~|v2| wyznaczane s/a /scie/zki
%   |extrapolate (0, 1/(1+v1) of e1| oraz
%   |extrapolate (v2/(1+v2), 1) of e2|
% (tzn.~dla~wyd/lu/zenia domy/slnego odpowiednio
% |extrapolate (0, 2/3) of s1| oraz |extrapolate (1/3, 1) of s2|).
% Je/sli przed/lu/zenia nie~przetn/a si/e, w/ez/ly obrysu
% /l/aczone s/a odcinkiem prostym. Ostatnia w/lasno/s/c umo/zliwia
% osi/agni/ecie efektu analogicznego do skutk/ow ustawienia
% |linejoin:=beveled|. W~tym celu nale/zy u/zy/c zerowego wyd/lu/zenia:
% |tip|(0)(lista_w/ez/l/ow). U/zycie w~poprzednim przyk/ladzie zera zamiast
% pierwszego (pustego) parametru makra |tip| da/loby nast/epuj/acy~efekt:
%% \LINE{\epsfbox{\illusname.113}}
%% \descriptioncomments
% Ad 4. The macro |ignore_directions| has a different character. It is
% invoked with one parameter being a comma-separated list of nodes:
% |ignore_directions|(list_of_nodes). The numbers {\it must be\/} followed
% by sufixes |l| or |r|. The macro causes that, at specified nodes,
% the direction of the outline is not forced to be parallel to the direction
% of the path~|p| (which is the default); instead, the direction is
% calculated by \MP{}. Suffixes determine whether the direction
% is not to be forced at the right (|r|) or the left~(|l|) edge (with
% respect to the direction of the path~|p|). This heuristic
% trick can be used to improve the appearence of the outline
% if the ``inner'' part of the envelope has too tight arcs.
%%%% The examples of the usage of this macro can be found in the \MP{} version
%%%% of D.~E.~Knuth's `logo' font (letters `P'~and~,S').
%% \-
%% \descriptioncomments
% Ad 4. Wywo/lanie makra |ignore_directions| ma posta/c
% |ignore_directions|(lista_w/ez/l/ow), gdzie ,,lista w/ez/l/ow'' zawiera
% rozdzielone przecinkami numery (czasy) w/ez/l/ow /scie/zki~|p|
% z~{\it obowi/azkowymi\/} sufiksami |l| albo |r|. Makro to spe/lnia nieco
% inn/a rol/e ni/z poprzednie~-- powoduje mianowicie, /ze w~zadanych
% w/ez/lach kierunek krzywej tworz/acej obrys nie jest wymuszany (normalnie
% jest on r/ownoleg/ly do kierunku /scie/zki~|p| w~odpowiadaj/acym punkcie).
% Sufiksy okre/slaj/a, czy~niewymuszanie kierunku ma~dotyczy/c prawej~(|r|)
% czy te/z lewej~(|l|) strony obrysu (patrz/ac zgodnie z~kierunkiem
% /scie/zki). Taki heurystyczny zabieg poprawia na og/o/l wygl/ad obrysu,
% gdy jego ,,wewn/etrzna'' cz/e/s/c ma zbyt ciasne /luki.
%%%% Przyk/lad u/zycia
%%%% tego sposobu korygowania kszta/ltu /scie/zki mo/zna znale/x/c w~\MP{}-owej
%%%% wersji fontu ,logo' D.~E.~Knutha (litery ,P'~i~,S').
%% \--------------------------------------------------------------------
vardef pen_stroke(text opts)(expr p)(suffix result) =
 forsuffixes $=,r,l,b,e:
  if not path result$: scantokens("path " & generisize(str result$)); fi
 endfor
 save a_, a__, d_, i_, k_, n_, p_, z_, norm_, norml_, normr_, normlr_,
  fix_opts_, ignore_dir_, ignore_dir__, local_nib_, local_nib__,
  local_tip_, default_tip_, local_tip__, % internal
  all, rel, last, nib, cut, tip, ignore_directions, current_node; % exported
 numeric ignore_dir__[\\]; pair default_tip_, local_tip__[\\];
 path local_nib__[\\];
 pair a_, d_, z_[\\]; path p_;
%%% xpart norm_ norml_ normr_ normlr_
 vardef norm_ primary n =
  if cycle p: n mod last else: if n<0: 0 elseif n>last: last else: n fi fi
 enddef;
 vardef norml_ primary n = -norm_ n -1 enddef;
 vardef normr_ primary n = norm_ n +1 enddef;
 vardef normlr_@# primary i= if str @#="l": -norm_(last-i)-1 else: i+1 fi enddef;
 last=length(p);
 vardef rel primary a =
  angle((gendir current_node of p) slant_stroke)+a
 enddef;
 def all =
  hide(% locally we use the prefix rather than postfix noitation;
       % a trick due to the |suffix| parameter of the |allcont_| macro
   vardef l primary n = (norml_ n,0) enddef;
   vardef r primary n = (normr_ n,0) enddef) allcont_
 enddef;
 def allcont_ suffix $ =
  $0 for i_:=1 upto last if cycle p: -1 fi: , $i_ endfor
 enddef;
 vardef fixopts_(suffix optname)(text nodes) text val =
%%% intersectiontimes lcont_ rcont_
  save l, r, lcont_, rcont_;
  def l = lcont_ whatever enddef; primarydef a lcont_ b = (norml_ a,0) enddef;
  def r = rcont_ whatever enddef; primarydef a rcont_ b = (normr_ a,0) enddef;
  for n_:=nodes:
   if numeric n_:
    current_node:=norm_ n_;
    optname[norml_ n_]:=optname[normr_ n_]
   else:
    current_node:=abs(xpart n_)-1; % the inverse of both |norml_| and |normr_|
    optname[xpart(n_)]
   fi :=val; % |val| may depend on |current_node|
  endfor
 enddef;
 def nib(text nib_)(text nodes) = % nib and node list
  fixopts_(local_nib__)(nodes)
   begingroup
    p_:=default_nib; for k_:=nib_: p_:=k_; endfor \\ p_
   endgroup;
 enddef;
 def cut(text nib_and_ang)(text nodes) = % angle, nib and node list
  fixopts_(local_nib__)(nodes)
   begingroup
    p_:=default_nib;
    for k_:=nib_and_ang:
     if numeric k_: a_:=dir(unslant_angle(k_)); else: p_:=k_; fi
    endfor
    d_:=gendir current_node of p;
    z_1:=whatever*a_=tangent_point(d_,p_)+whatever*d_;
    z_2:=whatever*a_=tangent_point(-d_,p_)+whatever*d_;
    z_1--z_2
   endgroup;
 enddef;
 def tip(text nib_and_lim)(text nodes)= % limit(s) and node list
  i_:=0; for n_:=nib_and_lim: if numeric n_: i_[incr i_]:=n_; fi endfor
  fixopts_(local_tip__)(nodes)
   elongation_to_times(if i_=0: default_elongation, default_elongation
    elseif i_=1: i_1, i_1 else: i_1, i_2 fi);
  fixopts_(local_nib__)(nodes)
   begingroup
    p_:=default_nib; for k_:=nib_and_lim: if path k_: p_:=k_; fi endfor \\ p_
   endgroup;
 enddef;
 def ignore_directions(text nodes) = % node list
  fixopts_(ignore_dir__)(nodes) 1;
 enddef;
 if default_cap=0:
  if not cycle p: cut(rel 90)(0,last); fi
 elseif default_cap=1: % do nothing
 else:
  errhelp "Admissible values are 0, 1; continue, I'll use the value 1.";
  errmessage "PX: improper `default_cap' value ("&decimal(default_cap)&")";
 fi
 opts;
%
 if default_join=0:
  default_tip_:=elongation_to_times(default_elongation, default_elongation);
 elseif default_join=1: % no tip setting, do nothing
 elseif default_join=2:
  default_tip_:=(1,0); % |(1,0)=elongation_to_times(0,0)|
 else:
  errhelp "Admissible values are 0, 1, 2; continue, I'll use the value 1.";
  errmessage "PX: improper `default_join' value ("&decimal(default_join)&")";
 fi
 vardef ignore_dir_@#(expr i) = known ignore_dir__[normlr_@# i] enddef;
 vardef local_tip_@#(expr i) = if known local_tip__[normlr_@# i]:
  local_tip__[normlr_@# i] else: default_tip_ fi enddef;
 vardef local_nib_@#(expr i) = if known local_nib__[normlr_@# i]:
  local_nib__[normlr_@# i] else: default_nib fi enddef;
 result.r:=pen_stroke_edge.r(p);
 result.l:=pen_stroke_edge.l(reverse p);
 if not cycle p:
  result.b:=pen_cap(predir infinity of result.l,postdir 0 of result.r,
   -postdir 0 of p,point 0 of p,local_nib_.l(last),local_nib_.r(0));
  result.e:=pen_cap(predir infinity of result.r,postdir 0 of result.l,
   predir last of p,point last of p,local_nib_.r(last), local_nib_.l(0));
  result:=result.r && result.e && result.l && result.b && cycle;
 fi
enddef;

vardef pen_cap(expr a,b,c,p,niba,nibb)=
 if path_eq(niba,nibb): pen_join(a,b,p,niba)
 else: pen_join(a,c rotated 90,p,niba)--pen_join(c rotated 90,b,p,nibb)
 fi
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% Sometimes the results yielded by |find_outlines| can be further
% improved, although it is not advisable to relay on fully
% automatic approach. Macro |correct_close_triplets|
% replaces three close nodes by a single (central) one:
%% \-
%% \descriptioncomments
% W~niekt/orych przypadkach wyniki generowane przez makro
% |find_outlines| mo/zna nieco poprawi/c, aczkolwiek nie
% nale/za/loby polega/c na~w~pe/lni automatycznym przetwarzaniu.
% Makro |correct_close_triplets| zast/epuje trzy bliskie
% w/ez/ly pojedynczym (centralnym):
%% %
%% \LINE{\epsfbox{\illusname.107}}
%% %
%% \descriptioncomments
% while macro |correct_close_doublets| replaces two close nodes
% by a single one (of two nodes of the short segment remains
% the node at which the change of direction is less abrupt):
%% \-
%% \descriptioncomments
% natomiast |correct_close_doublets| zast/epuje dwa bliskie w/ez/ly
% jednym (pozostawiany jest ten koniec kr/otkiego segmentu, w~kt/orym
% /scie/zka zmienia kierunek mniej gwa/ltownie):
%% %
%% \LINE{\epsfbox{\illusname.108}}
%% %
%% Red colour denotes the points that are being removed;
%% filled circles denote nodes, outlined ones---control points.
%% \-
%% Kolor czerwony oznacza punkty usuwane; wype/lnione k/o/lka
%% oznaczaj/a w/ez/ly, natomiast obrysowane k/o/lka -- naci/agi.
%% \--------------------------------------------------------------------
vardef correct_close_triplets(expr p, acc) =
 save i_; i_:=1;
 forever:
  if arclength(subpath(i_-1,i_+1) of p)<=acc:
   (point i_ of p) ..
    controls (postcontrol incr(i_) of p) and (precontrol incr(i_) of p) ..
  else:
   (point i_-1 of p) ..
    controls (postcontrol i_-1 of p) and (precontrol  i_ of p) ..
  fi
  exitif incr(i_)=length(p)+1;
 endfor
 (point length(p) of p) & cycle
enddef;
%
vardef correct_close_doublets(expr p, acc) =
 save p_,was_item_; path p_; p_:=p;
 p_:=delete_nodes(p_)(
  for i_:=0 upto length(p)-1:
   if arclength(subpath(i_,i_+1) of p)<=acc:
    if known was_item_: , fi (i_,1) hide(was_item_:=1)
   fi
  endfor);
 p_
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% from fontbase.mp

% ---
% define somehow |use_eps|, if epsincl.mp is not used (commented out),
% i.e., if stencils are definitely not to be used
vardef use_eps(expr dummy) = nullpicture enddef;
input epsincl.mp;
% ---
vardef enc_file = jobname & ".enc" enddef;
vardef map_file = jobname & ".map" enddef;
vardef kpx_file = jobname & ".kpx" enddef;
vardef pfi_file = jobname & ".pfi" enddef;
vardef pic_file = "piclist" enddef;
vardef dim_file = jobname & ".dim" enddef;
% ---
errorstopmode; warningcheck:=-1;
ignore:=whatever; process:=0; utilize:=1; store:=2; % constants for introducing
let semicolon_=; ; % stores original meaning of a semicolon
newinternal tracingdimens; % if |tracingdimens>0| then |dim_file| is generated
% ---
def write_special = % additional info to be processed by AWK
 special "%GLYNFO: " &
enddef;
vardef mtone_glyph_pfx = "MT1: glyph " & str glyph_name & ": " enddef;
def mtone_message = message mtone_glyph_pfx & enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% Macros |write_tex| and |write_commands| provide contact with the
% outer world. The former macro contains the information about EPSes that is
% used for proofing and assembling the font; must be consistent with
% the definitions contained in the files `mpform.sty' and `mp2pf.awk'.
% The latter macro provides a DOS-batch interface to the `epscinl'
% package which is used for including background bitmaps
% (in EPS form), i.e., stencils, into the resulting EPSes.
%% \-
%% \descriptioncomments
% Makra |write_tex| i~|write_commands| zapewniaj/a kontakt ze /swiatem
% zewn/etrznym. Pierwsze z~nich zawiera informacj/e o~p[likach EPS
% wykorzystywan/a przy tworzeniu dokumentacji i~zestawianiu fontu;
% musi by/c zgodne z~definicjami w plikach ,mpform.sty' i ,mp2pf.awk'.
% Drugie przygotowuje DOS-owy plik wsadowy wykorzystuj/acy pakiet ,epscinl'
% wykorzystywany przy umieszczaniu w~tle wygenerowanego EPS-a mapy bitowej
% (tak/ze w~postaci EPS-owej) jako podk/ladu ({\it stencil\/}).
%% \--------------------------------------------------------------------
vardef write_tex(expr name, num) =
 write "\EPSNAMEandNUMBER{" & name & "}{" & decimal(num) & "}"
  to pic_file & ".tex"
enddef;
vardef write_commands(expr num) =
 write "call epsincl " & jobname & "." & decimal(num) to pic_file & ".bat";
enddef;
%% \--------------------------------------------------------------------
%% The following macros are related to the operation of slanting.
%% In particular, they enable to keep a fixed width of a stem
%% after slanting.
%% \-
%% Poni/zsze makra s/a zwi/azane z operacj/a pochylania. Mi/edzy innymi
%% pozwalaj/a one na zachowanie zadanej grubo/sci stem/ow (/lody/zek?)
%% po pochyleniu.
%% \--------------------------------------------------------------------
vardef slant_ang = % should be rather called ``local_slant_angle''
 slang \\ if known glyph_slanting.glyph_name: * glyph_slanting.glyph_name fi
enddef;
vardef slant_val = tand(slant_ang) enddef;
vardef slant_preadjust(expr slope, slang) =
% |if sind(angle(slope))=0: 1 else:|
% | abs(sind(angle(slope))/sind(angle(cotd(angle(slope))+tand(slang),1)))|
% |fi|
% Correction of stem size taking into account its slope and a slant angle;
% nice formula, isn't it? Much simpler than the previous one, yet equivalent:
 length(unitvector(slope) slanted tand(slang))
enddef;
vardef slant_stroke_val = slant_val enddef; % compatibility with plain_ex.mp
% ---
vardef stem_corr (expr slope) = slant_preadjust(slope, slant_ang) enddef;
% ---
def italicized = % fairly complex operation
 if slang<>0:
  if known glyph_slanting.glyph_name:
   if glyph_slanting.glyph_name=0: shifted (math_axis*tand(slang),0) fi
  fi
  shifted (italic_shift*tand(slang),0) % re-positioning
  slanted slant_val % and slanting
 fi
enddef;
% ---
primarydef b || c =
 whatever*b + c*stem_corr(b)*unitvector(b rotated 90)
enddef;
% ---
primarydef c /\ b =
% A variant of the |leg| procedure that iteratively counteracts slant
% deformation; as with |leg|, given: |c| -- hypotenuse (vector) of
% a right-angled triangle, |b| -- the length of one of its legs;
% result: the other leg of the triangle (vector),
 if slant_ang=0: (c leg b)
 else:
  begingroup save b_, b__, n_; b_:=b__:=b; n_:=10;
   forever:
    b_:=b*stem_corr(c leg b_);
    exitif (abs(b_-b__)<.01) or (n_<=0);
    b__:=b_; n_:=n_-1;
   endfor
   if (abs(b_-b__)>=.01):
    errhelp "The result is likely to be weird.";
    errmessage mtone_glyph_pfx & "iteration hasn't converged";
   fi
   c leg b_
  endgroup
 fi
enddef;
% ---
% Obsolete?
vardef rib(expr t,p,r) text u = % |u| is either empty or a vector
 save k_; pair k_; for i_:=u: k_:=u; endfor
 if unknown k_: k_=((udir t of p) rotated 90); fi
 (point t of p) + r * k_ * stem_corr(k_ rotated 90)
enddef;
%% \--------------------------------------------------------------------
%% The operation {\it compose_path\/} is useful in \MP{} programs
%% automatically generated from PFB sources (pf2mt1 utility). Suffixes
%% $a$ and $b$ of control nodes stand for `after' and `before', respectively;
%% The operation {\it compose_path\/} makes use of the operation
%% {\it compose_segment\/} that serves for constructing non-cyclic
%% paths. Undefined nodes are ignored.
%% \-
%% Operacja {\it compose_path\/} jest przydatna w~programach \MP{}-owych
%% automatycznie wygenerowanych z~plik/ow PFB (narz/edzie pf2mt1). Przyrostki
%% $a$ i~$b$ naci/ag/ow mnemonicznie mo/zna kojarzy/c z~angielskimi
%% okre/sleniami ,,after'' i~,,before''; operacja {\it compose_path\/}
%% wykorzystuje operacj/e {\it compose_segment\/} pozwalaj/ac/a konstruowa/c
%% /scie/zki niecykliczne. W/ez/ly o nieokre/slonych warto/sciach
%% s/a ignorowane.
%% \--------------------------------------------------------------------
vardef compose_segment@#(expr m,n) = % |m<=n|, not checked
 if unknown generating: if show_labels_>0:
  for i_:=m upto n:
   if show_compose_>0:
    if known @#[i_]: just_label(str @#[i_], @#[i_]); fi
   fi
   if show_compose_>1:
    if known @#[i_]a: just_label(str @#[i_]a, @#[i_]a); fi
    if known @#[i_+1]b: just_label(str @#[i_+1]b, @#[i_+1]b); fi
   fi
  endfor
 fi fi
 if unknown inside_compose_path_: save idx_, n_; n_:=-1; fi
 save n__; n__=n_+1;
 for i_:=m upto n: if known @#[i_]: idx_[incr(n_)]=i_; fi endfor
 for i_:=n__ upto n_-1:
   @#[idx_[i_]] .. controls
         @#[idx_[i_]]   if known @#[idx_[i_]]a: a fi
     and @#[idx_[i_+1]] if known @#[idx_[i_+1]]b: b fi
     ..
 endfor
 @#[idx_[n_]]
enddef;
vardef compose_path@#(expr n) =
 save inside_compose_path_, idx_, n_; n_:=-1; inside_compose_path_:=1;
 compose_segment@#(0,n)
  if @#[idx_[0]]=@#[idx_[n_]]: & else: -- fi \\ cycle
enddef;
%% \--------------------------------------------------------------------
%% Automatically generated \MP{} programs often has improper
%% path directions. The macro {\it correct_path_directions\/}
%% fixes the problem (in most cases).
%% \-
%% Automatycznie generowane programy \MP{}-owe maj/a cz/estokro/c
%% nieprawid/lowe kierunki /scie/zek. Makro {\it correct_path_directions\/}
%% leczy problem (w~wi/ekszo/sci wypadk/ow).
%% \--------------------------------------------------------------------
def correct_path_directions(text t)(suffix s) =
 begingroup
  save s_, s__, i_, j_, idx_; path s_[];
  if not path s0: scantokens("path " & generisize(str s0)); fi
  if not numeric s.num: scantokens("numeric " & generisize(str s.num)); fi
  s.num:=0;
  for s__:=t: s_[s.num]:=s__; idx_[s.num]:=0; s.num:=s.num+1; endfor;
  for i_:=0 upto s.num-1:
   for j_:=i_+1 upto s.num-1:
    if s_[i_] inside s_[j_]: idx_[i_]:=idx_[i_]+1; fi
    if s_[j_] inside s_[i_]: idx_[j_]:=idx_[j_]+1; fi
   endfor
  endfor
  for i_:=0 upto s.num-1:
   if odd idx_[i_]: s[i_]:=if turningnumber s_[i_]>0: reverse fi s_[i_];
   else: s[i_]:=if turningnumber s_[i_]<0: reverse fi s_[i_];
   fi
  endfor
 endgroup
enddef;
%% \--------------------------------------------------------------------
%% Basic macros for building character glyphs:
%% \-
%% Podstawowe makra do tworzenia obrys/ow znak/ow:
%% \--------------------------------------------------------------------
vardef round_node_values(expr p) =
 save d_; % candidates for Flex -- no checking for ``straightlinessness''
 if known dish_size: % default is |unknown dish_size|
  for t_=0 upto length(p)-1: if is_dish(t_,p): d_[t_]=0; fi endfor;
 fi
 for t_=0 upto length(p)-1:
  if round(point t_ of p)=round(point t_+1 of p):
   hide(mtone_message "degenerated bezier " & ", length=" &
    decimal(length(p)) & " " & ", time=" & decimal(t_) & " ";
   show p)
  else:
   round(point t_ of p)..
    if if known d_[t_] or known d_[t_+1]: false else:
     is_line(subpath (t_,t_+1) of p) fi:
    controls round(point t_ of p) and round(point t_+1 of p)
   else:
    controls round(postcontrol t_ of p) and round(precontrol t_+1 of p)
   fi
   ..
  fi
 endfor
 round(point length(p) of p) \\ if cycle p: & cycle fi
enddef;
%
vardef is_dish(expr t,p) =
% returns |true| if |point t of p| is a good candidate for a center
% of a dish (suitable for Type~1 Flex option)
 if known dish_size:
  save b_; boolean b_; b_:=false;
  if xpart(predir t of p)=0:
   b_:=true;
   if b_: b_:=b_ and (xpart(postdir t of p)=0); fi
   if b_: b_:=b_ and (ypart(predir t of p)<>0); fi
   if b_: b_:=b_ and (ypart(postdir t of p)<>0); fi
   if b_: b_:=b_ and (xpart(point (t-1) of p)=xpart(point (t+1) of p)); fi
   if b_:
    save u_; u_:=ypart(point (t-1) of p)-ypart(point t of p);
    b_:=b_ and (abs(u_)>dish_size);
   fi
   if b_:
    save v_; v_:=-signum(u_)*(xpart(point (t-1) of p)-xpart(point t of p));
    b_:=b_ and (abs(v_)<=dish_incise);
   fi
   if b_:
    save p_; path p_; p_:=subpath (t-1,t+1) of p;
    u_:=xpart(urcorner p_)-xpart(llcorner p_);
    b_:=b_ and (u_=v_);
   fi;
   % |if b_: show "VER",(t,u_,v_); fi|
  elseif ypart(predir t of p)=0:
   b_:=true;
   if b_: b_:=b_ and (ypart(postdir t of p)=0); fi
   if b_: b_:=b_ and (xpart(predir t of p)<>0); fi
   if b_: b_:=b_ and (xpart(postdir t of p)<>0); fi
   if b_: b_:=b_ and (ypart(point (t-1) of p)=ypart(point (t+1) of p)); fi
   if b_:
    save u_; u_:=xpart(point (t-1) of p)-xpart(point t of p);
    b_:=b_ and (abs(u_)>dish_size);
   fi
   if b_:
    save v_; v_:=signum(u_)*(ypart(point (t-1) of p)-ypart(point t of p));
    b_:=b_ and (abs(v_)<=dish_incise);
   fi
   if b_:
    save p_; path p_; p_:=subpath (t-1,t+1) of p;
    u_:=ypart(urcorner p_)-ypart(llcorner p_);
    b_:=b_ and (u_=v_);
   fi;
   % |if b_: show "HOR",(t,u_,v_); fi|
  fi 
  b_
 else:
  errhelp "Proceed, I'll return the value `false'.";
  errmessage mtone_glyph_pfx & "`is_dish' used without initialization";
  false
 fi 
enddef;
% by default, dishes are not considered candidates for Flex;
% instead, they may be converted to (pairs of) straight lines
def flex_checking_on = % no forcing straight lines when a dish is encountered
 newinternal dish_incise, dish_size;
 dish_incise:=5; dish_size:=10; % defaults; Adobe says that |dish_incise<=20|
enddef;
def flex_checking_off = % locally, flex checking can be switched off
 save dish_incise, dish_size;
enddef;
% ---
primarydef a start b =
 if cycle a:
  if b=default: default_start_(a)
  else: ((subpath (b,length(a)+b) of a) & cycle) fi
 else: a fi
enddef;
%
newinternal default; default:=infinity;
vardef default_start_(expr p) =
 save i_,j_,pi_,pj_; pair pi_,pj_;
 j_:=0; pj_:=point j_ of p;
 for i_=1 upto length(p):
  pi_:=point i_ of p;
  if (xpart(pi_)>xpart(pj_)) or
   (xpart(pi_)=xpart(pj_)) and (ypart(pi_)<ypart(pj_)):
   j_:=i_; pj_:=point j_ of p;
  fi
 endfor
 (subpath (j_, length(p)+j_) of p) & cycle
enddef;
% ---
def Fill text glist =
 begingroup
  save h_; path h_;
  for g_:=glist:
   h_:=g_ start.default; % JMN's suggestion
   if turningnumber h_<>1:
    errhelp "The result is likely to be weird.";
    errmessage mtone_glyph_pfx & "strange turning number in Fill, " &
     decimal(turningnumber h_);
   fi
   if glyph_usage div store = 1: % storing
    glyph_stored.glyph_name[incr glyph_stored.glyph_name.num]=h_;
   fi
   glyph_list[incr glyph_list.num]:=round_node_values(h_ italicized);
   update_glyph_bb(glyph_list[glyph_list.num]);
  endfor;
 endgroup
enddef;
%
def unFill text glist =
 begingroup
  save h_; path h_;
  for g_:=glist:
   h_:=g_ start.default; % JMN's suggestion
   if turningnumber h_<>-1:
    errhelp "The result is likely to be weird.";
    errmessage mtone_glyph_pfx & "strange turning number in unFill, " &
     decimal(turningnumber h_);
   fi
   if glyph_usage div store = 1: % storing
    glyph_stored.glyph_name[incr glyph_stored.glyph_name.num]=h_;
   fi
   glyph_list[incr glyph_list.num]:=round_node_values(h_ italicized);
  endfor;
 endgroup
enddef;
% ---
def fix_hsbw (expr xr,ml,mr) =
 glyph_shift:=round(ml); % shift = left margin
 glyph_width:=round(xr+ml+mr); % declared width plus margins
 if glyph_usage div store = 1: % storing
  glyph_shift.glyph_name:=glyph_shift; glyph_width.glyph_name:=glyph_width;
 fi
enddef;
% ---
def fix_exact_hsbw(expr xr,ml,mr) =
 glyph_shift:=round(ml); % shift = left margin
 glyph_width:=xr+ml+mr; % declared width plus margins
 if glyph_usage div store = 1: % storing
  glyph_shift.glyph_name:=glyph_shift; glyph_width.glyph_name:=glyph_width;
 fi
enddef;
% ---
def sym_hsbw (expr wd_fig, wd_gl) = % abbreviation
 fix_hsbw(wd_gl,1/2(wd_fig-wd_gl),1/2(wd_fig-wd_gl));
enddef;
% ---
vardef is_stored(text name) =
 known glyph_stored.uni_name(name).num
enddef;
%% \--------------------------------------------------------------------
%% The procedure {\it fix\_tfm\_data\/} computes and stores basic TFM data
%% for a given character ({\it wd}, {\it ht}, {\it dp}, and {\it ic\/}). If
%% ${\it fontmaking}=1$, the character dimensions will be written to the
%% TFM file (the {\it charcode\/} parameter is supposed to be appropriately
%% set); otherwise, they can be written out to the {\it dim\_file}, provided
%% ${\it tracingdimens}>0$. The parameters {\it tipx\/} and {\it tipy\/}
%% are used for heuristic computing the italic correction for the
%% character (see \MF{\/}book, p.~105); they are simply coordinates of the
%% the upper-right corner of the glyph (for italic font they refer to the
%% slanted glyph). It should be emphasized, however, that character
%% dimensions should be given explicitly, if possible. After all, a font
%% designer is expected to know them better than \MP{}\dots
%% \-
%% Procedura {\it fix\_tfm\_data\/} wyznacza i~zapami/etuje
%% podstawowe dane metryczne znaku ({\it wd}, {\it ht}, {\it dp}
%% i~{\it ic\/}). Je/sli ${\it fontmaking}=1$, wyznaczone warto/sci zostan/a
%% zapisane w~pliku TFM (zak/lada si/e, /ze parametr {\it charcode\/} ma
%% stosownie nadan/a warto/s/c); w~przeciwnym razie dane te mog/a zosta/c
%% zapisane do pliku {\it dim\_file}, o~ile ${\it tracingdimens}>0$.
%% Parametry {\it tipx\/} i~{\it tipy\/} s/a wykorzystywane do do
%% heurystycznego wyznaczenia korekty kursywy (por.~\MF{\/}book, p.~105);
%% oznaczaj/a one po prostu wsp/o/lrz/edne prawego
%% g/ornego naro/znika prostok/ata ograniczaj/acego obrys znaku
%% (w~kursywie odnosz/a si/e do obrysu po pochyleniu). Nale/zy jednak/ze
%% podkre/sli/c, /ze dane metryczne powinny by/c w~miar/e mo/zno/sci
%% podane jawnie. W~ko/ncu projektant fontu powinien lepiej si/e
%% orientowa/c w~tej materii ni/z \MP{}\dots
%% \--------------------------------------------------------------------
def fix_tfm_data(expr tipx, tipy) = % to improve or not to improve?
 if unknown wd.glyph_name: wd.glyph_name:=glyph_width; fi
 if unknown ht.glyph_name:
  ht.glyph_name:=if known glyph_ury: glyph_ury else: 0 fi;
 fi
 if unknown dp.glyph_name:
  dp.glyph_name:=if known glyph_lly: glyph_lly else: 0 fi;
  if dp.glyph_name>0: dp.glyph_name:=0; fi
 fi
 charwd:=tfm_units(glyph_width);
 charht:=tfm_units(ht.glyph_name);
 chardp:=tfm_units(-dp.glyph_name); % reverse Polish convention
 % |tipx| and |tipy| are also valid for slanted font.
 if unknown ic.glyph_name:
  if known tipx and known tipy:
   ic.glyph_name:=round(tipx-glyph_width+1000/36);
   if ic.glyph_name<=2: % PSt's obstinacy
    ic.glyph_name:=0;
   fi
  else: ic.glyph_name:=0; fi
 fi
 charic:=tfm_units(ic.glyph_name);
 if tracingdimens>0:
  write "wd." & str glyph_name & ":=" & decimal glyph_width & "; " &
   "ht." & str glyph_name & ":=" & decimal ht.glyph_name & "; " &
   "dp." & str glyph_name & ":=" & decimal dp.glyph_name & "; " &
   "ic." & str glyph_name & ":=" & decimal ic.glyph_name & ";" to dim_file;
 fi
 if tracingdimens>1:
  if known glyph_axis.glyph_name:
   write "glyph_axis." & str glyph_name & ":=" &
    decimal glyph_axis.glyph_name & "; " to dim_file;
  fi
 fi
enddef;
%
%% \--------------------------------------------------------------------
%% Macros below set PostScript and \TeX{} units; a trick with `\#'
%% in {\it tfm\_units\/} proves useful in achieving compatibility
%% with the Knuthian fonts (e.g., it is employed in {\it logo\/} font).
%% Old versions of {\it tfm\_units\/} and {\it ps\_units\/} are less
%% accurate, but are kept because of backward compatibility reasons.
%% \-
%% Poni/zsze makra definiuj/a postscriptowe i~\TeX-/owe jednostki; trick
%% z~symbolem~,,\#'' w~{\it tfm\_units\/} jest u/zyteczny dla uzyskania
%% kompatybilno/sci z~Knuthowymi fontami (np.~wykorzystany zosta/l
%% w~foncie {\it logo\/}). Stare wersje makr {\it tfm\_units\/}
%% i~{\it ps\_units\/} s/a mniej dok/ladne, ale zosta/ly zachowane
%% ze~wzgl/edu na kompatybilno/s/c wstecz.
%% \--------------------------------------------------------------------
vardef tfm_units(text x) =
 save #; if known (x#): x# else: x/(1000/designsize) fi
enddef;
vardef old_tfm_units(text x) =
 save #; if known (x#): x# else: x/1000*designsize fi
enddef;
%
vardef ps_units(expr x) = x*(1000/designsize) enddef;
vardef old_ps_units(expr x) = x/designsize*1000 enddef;
%
def define_ps_units(text t) =
 forsuffixes $:=t: $:=ps_units($.#); endfor
enddef;
def define_whole_ps_units(text t) =
 forsuffixes $:=t: $:=round(ps_units($.#)); endfor
enddef;
def define_even_ps_units(text t) =
 forsuffixes $:=t: $:=2round(1/2ps_units($.#)); endfor
enddef;
%% \--------------------------------------------------------------------
%% Kerns and ligatures: you need to be careful if you don't want to produce
%% a malformed TFM:
%% \-
%% Podci/ecia i ligatury: nale/zy zachowa/c ostro/zno/s/c, /zeby nie powsta/l
%% nieopoprawny TFM
%% \--------------------------------------------------------------------
def start_or_cont =
% we postpone starting |ligtable| until a legal pair is encountered
 if unknown already_started: already_started:=1; ligtable LK_code: else: , fi
enddef;
%
def skip_LK =
 let ; = end_skip_LK \\ semicolon_
 let KL = fi \\ semicolon_
 if false:
enddef;
%
def end_skip_LK =
 let ; = semicolon_ semicolon_
 let KL = relax;
enddef;
%
def LK(text name) = % start ligature-kern table
 numeric LK_code,code,code',already_started; string LK_name;
 code:=name_to_code(name);
 if name_used(name): let next_to_do = relax;
 else: let next_to_do = skip_LK; fi
 next_to_do \\ LK_code:=code; LK_name:=glyph_ps_name.uni_name(name);
enddef;
%
def LP(text name_a, name_b) = % ligature pair
 if name_used(name_a) and name_used(name_b):
  if fontmaking=1:
   hide(code:=name_to_code(name_a); code':=name_to_code(name_b))
   start_or_cont \\ code=:(code') % braces are crucial for delimiting suffix
  else:
   out_lig(LK_name,
    glyph_ps_name.uni_name(name_a), glyph_ps_name.uni_name(name_b));
  fi
 fi
enddef;
%
def KP(text name)(text kern_val) = % kern pair
 if name_used(name):
  if fontmaking=1:
   hide(code:=name_to_code(name))
   start_or_cont \\ code kern tfm_units(kern_val)
  else:
   out_kpx(LK_name,glyph_ps_name.uni_name(name),kern_val);
  fi
 fi
enddef;
let KL = relax;
% ---
def out_kpx (expr l, r, v) =
 write "KPX " & l & " " & r & " " & decimal(v) to kpx_file
enddef;
% ---
def out_lig (expr l, r, s) =
 write "L " & l & " " & r & " " & s to kpx_file
enddef;
%% \--------------------------------------------------------------------
%% Macros for handling hints:
%% \-
%% Makra do wyznaczania ,,hint/ow'':
%% \--------------------------------------------------------------------
vardef feasible_node(text apart)(expr t, p)(text constraints)=
 save b_,z_; pair z_, z_.it;
 % |constraints| are not italicized, while |p| is (in |fix_stem|),
 % hence anti-italicizing; actually, |constraints| are not rounded
 % while the nodes of |p| are, but this seems unimportant.
 % Sometimes, we may want to acces |z1|, |z2|, etc., hence |clearxy|
 % cannot be used here; hence the following trick (the variables |z|
 % and |z.it| are ``reserved'' for constraints):
 z_=(x,y); z_.it=(x.it,y.it); % store the old values
 x:=whatever; y:=whatever; x.it:=whatever; y.it:=whatever;
 z.it=point t of p; z italicized=z.it;
 boolean b_; b_:=true;
 for c_:=constraints: b_:=b_ and c_; endfor % |constraints| can be empty
 % restore the old values:
 x:=xpart(z_); y:=ypart(z_); x.it:=xpart(z_.it); y.it:=ypart(z_.it);
 if b_ :
  if unknown loose_fix_stem : % for non-cyclic path, end-points are always considered OK
   % check the situation earlier than |t|
   (if origin<>predir t of p: apart(predir t of p)=0
    else: (apart(point t-1 of p)=apart(point t of p))
%    |and (apart(postcontrol t-1 of p)=apart(point t of p))%| shouldn't occur
    fi
   )
   or
   % check the situation later than |t|
   (if origin<>postdir t of p: apart(postdir t of p)=0
    else: (apart(point t+1 of p)=apart(point t of p))
%    |and (apart(precontrol t+1 of p)=apart(point t of p)) %| shouldn't occur
    fi
   )
  else: true fi
 else: false fi
enddef;
% ---
vardef covering@#(expr s,ds) =
 save res_; res_=0;
 for i_:=1 upto @#num:
  if (xpart(@#[i_])+ypart(@#[i_])>=s) and (xpart(@#[i_])<=s+ds):
   if res_=0: res_:=3; fi
   if (xpart(@#[i_])=s) or (xpart(@#[i_])+ypart(@#[i_])=s+ds): res_:=2; fi
   if (xpart(@#[i_])=s) and (ypart(@#[i_])=ds): res_:=1; fi
  fi
  exitif res_=1;
 endfor
% |0| -- no overlapping, |1| -- exact overlapping,
% |2| -- overlapping edges, |3| -- general overlapping
 res_
enddef;
% ---
def add_to_stem_list(expr stem_kind, base, delta) =
 begingroup
% |base| and |delta| are expected to be integers
  save stem_list_, stem_stored_, covering_;
  if stem_kind = "hstem":
   def stem_list_ = hstem_list enddef; def stem_stored_ = hstem_stored enddef;
  fi
  if stem_kind = "vstem":
   def stem_list_ = vstem_list enddef; def stem_stored_ = vstem_stored enddef;
  fi
  covering_:=covering.stem_list_(base,delta);
  if (covering_<>1) if delta<0: and (covering_=0) fi:
   stem_list_[incr stem_list_.num]:=(base,delta);
   if glyph_usage div store = 1: % storing
    stem_stored_.glyph_name[incr stem_stored_.glyph_name.num]:=(base,delta);
   fi
   if covering_>=2:
    stem_list_.cov:=1;
    if known overlapping_info: % a sort of debugging
     mtone_message "overlapping " & stem_kind & " (" & decimal(base) &
      "," & decimal(delta) & ").";
    fi
   fi
  fi
 endgroup
enddef;
% ---
def fix_stem(expr stem_kind)(expr delta)(text path_list) text constraints =
 begingroup
  if unknown old_hinting_scheme and known new_hinting_scheme:
    mtone_message "old hinting scheme mixed up with the new one.";
  fi; old_hinting_scheme:=1;
  save apart_, stem_tab_, base_, delta_, p__; path p__;
  if stem_kind="hstem": let apart_=ypart; fi
  if stem_kind="vstem": let apart_=xpart; fi
  delta_:=round(delta);
  for p_:=path_list: p__:=round_node_values(p_ italicized);
   for t_:=0 upto length(p__):
    if feasible_node(apart_)(t_, p__)(constraints):
     base_:=apart_(point t_ of p__);
     if unknown stem_tab_[base_]: stem_tab_[base_]:=1; fi
     if known stem_tab_[base_+delta_]:
      if stem_tab_[base_]=1:
        stem_tab_[base_]:=2;
        add_to_stem_list(stem_kind, base_, delta_);
      fi
     fi
     if known stem_tab_[base_-delta_]:
      if stem_tab_[base_-delta_]=1:
        stem_tab_[base_-delta_]:=2;
        add_to_stem_list(stem_kind, base_-delta_, delta_);
      fi
     fi
    fi
   endfor
  endfor
 endgroup
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% Macro |set_stem| allows for forcing user-defined stem positions.
% The macro can be invoked in one of the three forms:
%    |set_stem (stem_kind) (a,b), (c,d), ... ;| (``low-level'' call)
%    |set_stem (stem_kind) px, (a,b), (c,d), ... ;|
%    |set_stem (stem_kind) px, py, (a,b), (c,d), ... ;|
% In~the~first~case, pairs |(a,b)|, |(c,d)|, etc., are expected to be
% the rounded coordinates (anyway, rounding is performed) of edges of
% a stem (left and right for vstem and top and bottom for hstem;
% order does not matter); in the second and third cases, |px| and
% |py| are paths, and the following pairs denote ordering numbers
% of nodes of the respective paths. Relevant coordinates of the
% nodes are taken into account (i.e., |x| for |stem_kind="vstem"|
% and |y| for |stem_kind="hstem"|). Path are subjected to the
% operation |italicizes| and |round_node_values| prior to processing.
%
%% \-
%% \descriptioncomments
% Makro |set_stem| pozwala na zadawanie warto/sci ,,hint/ow'' w~spos/ob
% kontrolowany przez u/zytkownika.
% Makro to mo/ze by/c wywo/lywane na trzy sposoby:
%  |set_stem (stem_kind) (a,b), (c,d), ...;|
%  (wywo/lanie ,,niskiego poziomu'')
%  |set_stem (stem_kind) px, (a,b), (c,d), ...; |
%  |set_stem (stem_kind) px, py, (a,b), (c,d), ...; |
% W~pierwszym przypadku wsp/o/lrz/edne poszczeg/olnych par oznaczaj/a
% po/lo/zenie lewej i~prawej b/ad/x g/ornej i~dolnej kraw/edzi ,,hintu''
% (warto/sci powinny by/c zaokr/aglone, ale wszelki wypadek zaokr/aglanie
% jest i~tak wykonywane; kolejno/s/c nie gra roli), podczas gdy
% w~przypadku drugim i~trzecim s/a to numery w/ez/l/ow /scie/zek |px| i~|py|.
% Do oblicze/n brane s/a wsp/o/lrz/edne tych w/ez/l/ow (|x| je/sli
% |stem_kind="vstem"|, |y| je/sli |stem_kind="hstem"|), przy czym
% /scie/zki poddawane s/a uprzednio operacji |italicized|
% i~|round_node_values|.
%% \--------------------------------------------------------------------
def set_stem(expr stem_kind) text hint_data =
 begingroup
  if unknown old_hinting_scheme and known new_hinting_scheme:
    mtone_message "old hinting scheme mixed up with the new one.";
  fi; old_hinting_scheme:=1;
  save p_, i_; path p_[];
  i_:=0;
  for h_:=hint_data:
   i_:=i_+1;
   if (path h_):
    if i_=1: p_1=round_node_values(h_ italicized); fi
    if i_=2: p_2=round_node_values(h_ italicized); fi
   fi
  endfor
  if known p_1:
   if unknown p_2: p_2=p_1; fi
   save q_; pair q_;
   for h_:=hint_data:
    if pair h_:
     if stem_kind="hstem":
      q_:=(ypart(point xpart(h_) of p_1), ypart(point ypart(h_) of p_2));
     fi
     if stem_kind="vstem":
      q_:=(xpart(point xpart(h_) of p_1), xpart(point ypart(h_) of p_2));
     fi
     % a single-level recursion below makes the code a bit simpler:
     set_stem(stem_kind) q_;
    fi
   endfor
  else:
   pair i_;
   for h_:=hint_data:
    i_:=round(h_); % just in case...
    if ypart(i_)>xpart(i_):
     add_to_stem_list(stem_kind, xpart(i_), ypart(i_)-xpart(i_));
    else:
     add_to_stem_list(stem_kind, ypart(i_), xpart(i_)-ypart(i_));
    fi
  endfor
  fi
 endgroup
enddef;
%% \--------------------------------------------------------------------
%% FIND STEM
%% \-
%% FIND STEM
%% \--------------------------------------------------------------------
newinternal hint_node_tolerance, hint_angle_tolerance;
newinternal finding_triple_hstems, finding_triple_vstems;
newinternal finding_flex_hstems, finding_flex_vstems;
def find_stem (expr stem_kind) primary base_delta = % syntactic sugar
 find_stem_(stem_kind)(base_delta)
enddef;
def find_stem_(expr stem_kind)(expr base_delta) text constraints =
 if unknown new_hinting_scheme and known old_hinting_scheme:
   mtone_message "new hinting scheme mixed up with the old one.";
 fi; new_hinting_scheme:=1;
 if pair base_delta: find_stem_firm(stem_kind)
  (xpart(base_delta) if ypart(base_delta)<0: + ypart(base_delta) fi,
   abs(ypart(base_delta))) constraints;
 else: find_stem_free(stem_kind)(abs(base_delta)) constraints; fi
enddef;
def find_hstem = find_stem("hstem") enddef;
def find_vstem = find_stem("vstem") enddef;
% ---
def find_stem_firm(expr stem_kind)(expr base,delta) text constraints =
 begingroup
  save apart_, stem_tab_, segm_, edge_, base_, delta_;
  path segm_, stem_tab_.b, stem_tab_.e;
  if stem_kind="hstem": let apart_=ypart; fi
  if stem_kind="vstem": let apart_=xpart; fi
  base_:=round(base); delta_:=round(delta);
  for i_:=1 upto glyph_list.num:
   for t_:=1 upto length(glyph_list[i_]):
    edge_:=apart_(point t_ of glyph_list[i_]);
    segm_:=subpath (t_-1,t_) of glyph_list[i_];
    if (abs(base_-edge_)<=hint_node_tolerance) and
     ((delta_>0) or (delta_=-20)):
     if viable_node(stem_kind)(i_,t_)(constraints)
      if delta<0: > 1 else: mod 2 > 0 fi: % = if ghost 2 or 3 else 1 or 3
      if unknown stem_tab_.b: stem_tab_.b:=segm_;
      else: stem_tab_.b:=stem_tab_.b--segm_; fi
     fi
    elseif (abs(base_+delta_-edge_)<=hint_node_tolerance) and
     ((delta_>0) or (delta_=-21)):
     if viable_node(stem_kind)(i_,t_)(constraints)
      if delta<0: mod 2 > 0 else: > 1 fi: % = if ghost 1 or 3 else 2 or 3
      if unknown stem_tab_.e: stem_tab_.e:=segm_;
      else: stem_tab_.e:=stem_tab_.e--segm_; fi
     fi
    fi
   endfor
  endfor
  if (delta_=-20) and  known stem_tab_.b:
   add_to_stem_xlist(stem_kind, base_, delta_, stem_tab_.b);
  elseif (delta_=-21) and  known stem_tab_.e:
   add_to_stem_xlist(stem_kind, base_, delta_, stem_tab_.e);
  elseif (delta_>0) and known stem_tab_.b and known stem_tab_.e:
   add_to_stem_xlist(stem_kind, base_, delta_, stem_tab_.b--stem_tab_.e);
  else:
   mtone_message "no viable node found for " & stem_kind & ": (" &
    decimal(base_) & "," & decimal(delta_) & "), hint ignored.";
  fi
 endgroup
enddef;
% ---
def find_stem_free(expr stem_kind)(expr delta) text constraints =
 begingroup
  save apart_, stem_tab_, segm_, edge_, delta_;
  stem_tab_.num:=0; numeric stem_tab_[]n;
  path segm_, stem_tab_[]b, stem_tab_[]e;
  if stem_kind="vstem": let apart_=xpart;
  elseif stem_kind="hstem": let apart_=ypart; fi
  delta_:=round(delta);
  for i_:=1 upto glyph_list.num:
   for t_:=1 upto length(glyph_list[i_]):
    edge_:=apart_(point t_ of glyph_list[i_]);
    segm_:=subpath (t_-1,t_) of glyph_list[i_];
    v_:=viable_node(stem_kind)(i_,t_)(constraints);
    if v_ mod 2 > 0: % = 1 or 3
     if unknown stem_tab_[edge_]b: stem_tab_[edge_]b:=segm_;
      stem_tab_[incr stem_tab_.num]n=edge_;
     else: stem_tab_[edge_]b:=stem_tab_[edge_]b--segm_; fi
    fi
    if v_ > 1: % = 2 or 3
     if unknown stem_tab_[edge_]e: stem_tab_[edge_]e:=segm_;
     else: stem_tab_[edge_]e:=stem_tab_[edge_]e--segm_; fi
    fi
   endfor
  endfor
  for n_:=1 upto stem_tab_.num:
   edge_:=stem_tab_[n_]n;
   if known stem_tab_[edge_+delta_]e:
    add_to_stem_xlist(stem_kind, edge_, delta_,
     stem_tab_[edge_]b--stem_tab_[edge_+delta_]e);
   fi
  endfor
 endgroup
enddef;
% ---
def fix_ghost_new =
 begingroup
  if known glyph.ghost_num:
   save base_, delta_;
   for i_:=1 upto glyph.ghost_num:
    base_:=xpart(glyph.ghost[i_]); delta_:=ypart(glyph.ghost[i_]);
    if delta_>0:
     if base_=infinity:
      base_:=round(if delta_=20: glyph_ury else: glyph_lly fi);
     fi
     if delta_=21: base_:=base_+21; fi
     find_stem_firm("hstem")(base_, -delta_);
    else:
     if base_=infinity:
      base_:=round(if delta_=-20: glyph_urx else: glyph_llx fi);
     fi
     if delta_=-21: base_:=base_+21; fi
     find_stem_firm("vstem")(base_, delta_);
    fi
   endfor
  fi
 endgroup
enddef;
% ---
vardef viable_node(expr stem_kind)(expr pnum, nnum)(text constraints)=
 % returns: |0| -- not viable; |1| -- viable as left or bottom edge;
 %          |2| -- viable as right or top edge; |3 = 1+2|
 save p, n, b_, z_, pred_, postd_, prea_, posta_;
 pair z_, z_.it, pred_, postd_;
 % |constraints| are not italicized, while |p| is (in |fix_stem|),
 % hence anti-italicizing; actually, |constraints| are not rounded
 % while the nodes of |p| are, but this seems unimportant.
 % Sometimes, we may want to acces |z1|, |z2|, etc., hence |clearxy|
 % cannot be used here; hence the following trick (the variables |z|
 % and |z.it| are ``reserved'' for constraints, i.e., are ``exported''):
 z_=(x,y); z_.it=(x.it,y.it); % store the old values
 x:=whatever; y:=whatever; x.it:=whatever; y.it:=whatever;
 z.it=point nnum of glyph_list[pnum]; z italicized=z.it;
 % moreover, exported are |p| -- path number, |n| -- node number (time)
 p:=pnum; n:=nnum;
 boolean b_; b_:=true;
 for c_:=constraints: b_:=b_ and c_; endfor % |constraints| can be empty
 % restore the old values:
 x:=xpart(z_); y:=ypart(z_); x.it:=xpart(z_.it); y.it:=ypart(z_.it);
 if b_ :
  if stem_kind="vstem":
   pred_:=predir n of glyph_list[p];
   postd_:=postdir n of glyph_list[p];
  elseif stem_kind="hstem":
   pred_:=(predir n of glyph_list[p]) rotated -90;
   postd_:=(postdir n of glyph_list[p]) rotated -90;
  fi
  if pred_<>origin: prea_:=angle(pred_); else: prea_:=0;
   errhelp "Degenerated bezier in viable_node procedure.";
   errmessage mtone_glyph_pfx & " This shouldn't happen";
  fi
  if postd_<>origin: posta_:=angle(postd_); else: posta_:=0;
   errhelp "Degenerated bezier in viable_node procedure.";
   errmessage mtone_glyph_pfx & " This shouldn't happen";
  fi
  0
  if min(abs(prea_+90),abs(posta_+90))<=hint_angle_tolerance: +1 fi
  if min(abs(prea_-90),abs(posta_-90))<=hint_angle_tolerance: +2 fi
 else: 0 fi
enddef;
% ---
def add_to_stem_xlist(expr stem_kind, base, delta, node_list) =
 begingroup
% |base| and |delta| are expected to be integers; |node_list| is a path
  save stem_list_, stem_list_segms_, stem_stored_, stem_stored_segms_,
   covering_;
  if stem_kind = "hstem":
   def stem_list_ = hstem_list enddef;
   def stem_stored_ = hstem_stored enddef;
   def stem_list_segms_ = hstem_list_segms enddef;
   def stem_stored_segms_ = hstem_stored_segms enddef;
  fi
  if stem_kind = "vstem":
   def stem_list_ = vstem_list enddef;
   def stem_stored_ = vstem_stored enddef;
   def stem_list_segms_ = vstem_list_segms enddef;
   def stem_stored_segms_ = vstem_stored_segms enddef;
  fi
  covering_:=xcovering.stem_list_(base,delta);
  if covering_=1: % a ghost stem with an edge matching existing stem
   mtone_message "ghost stem overlaps with " & stem_kind & ", ghost ignored.";
  elseif covering_<0: % exact covering -- only extend node_list
   if known stem_list_segms_[-covering_]:
    stem_list_segms_[-covering_]:=stem_list_segms_[-covering_]--node_list;
   else:
    stem_list_segms_[-covering_]:=node_list;
   fi
   if glyph_usage div store = 1: % storing
    if known stem_stored_segms_.glyph_name[-covering_]:
     stem_stored_segms_.glyph_name[-covering_]:=
      stem_stored_segms_.glyph_name[-covering_]--node_list;
    else:
     stem_stored_segms_.glyph_name[-covering_]:=node_list;
    fi
   fi
  else: % |covering_=0| or |covering_=2|
   stem_list_[incr stem_list_.num]:=(base,delta);
   stem_list_segms_[stem_list_.num]:=node_list;
   if glyph_usage div store = 1: % storing
    stem_stored_.glyph_name[incr stem_stored_.glyph_name.num]:=(base,delta);
    stem_stored_segms_.glyph_name[stem_stored_.glyph_name.num]:=node_list;
   fi
   if covering_=2: % general overlapping
    stem_list_.cov:=1;
    if known overlapping_info: % a sort of debugging
     mtone_message "overlapping " & stem_kind & " (" & decimal(base) &
      "," & decimal(delta) & ").";
    fi
   fi
  fi
 endgroup
enddef;
% ---
vardef xcovering@#(expr s,ds) =
 save lc_, rc_, s_, sds_, li_, ri_, res_; res_:=0;
 lc_:=min(s,s+ds); rc_:=max(s,s+ds);
 for i_:=1 upto @#num:
  s_:=xpart(@#[i_]); sds_:=xpart(@#[i_])+ypart(@#[i_]);
  li_:=min(s_, sds_); ri_:=max(s_, sds_);
  if (ri_>=lc_) and (li_<=rc_):
   if res_=0: res_:=2; fi
   if ((li_=lc_) and (ds=-21)) or ((ri_=rc_) and (ds=-20)): res_:=1; fi
   if (xpart(@#[i_])=s) and (ypart(@#[i_])=ds): res_:=-i_; fi
  fi
  exitif res_<0;
 endfor
% |0| -- no overlapping, 
% |<0| -- exact overlapping (|-res_| = matching hint number),
% |1| -- overlapping `ghost' edges,
% |2| -- general overlapping
 res_
enddef;
% ---
def fix_hstem = fix_stem("hstem") enddef;
def fix_vstem = fix_stem("vstem") enddef;
def set_hstem = set_stem("hstem") enddef;
def set_vstem = set_stem("vstem") enddef;
% ---
newinternal candidate_precision;
vardef candidate_list(text xy)(text cand_list) = % useful in constraints
 false for l_=cand_list: or (abs(xy-l_)<=candidate_precision) endfor
enddef;
% ---
def ghost_stem text t = % |t=bot| or |top| or |lft| or |rt|
 begingroup
  save top, bot, lft, rt;
  if unknown glyph.ghost_num: glyph.ghost_num:=0; pair glyph.ghost[]; fi
  % little trickery:
  def top suffix s_ = (if str s_="": infinity else: s_ fi,20) enddef;
  def bot suffix s_ = (if str s_="": infinity else: s_ fi,21) enddef;
  def rt  suffix s_ = (if str s_="": infinity else: s_ fi,-20) enddef;
  def lft suffix s_ = (if str s_="": infinity else: s_ fi,-21) enddef;
  % deferred action:
  for s_:=t: glyph.ghost[incr glyph.ghost_num]:=s_; endfor
 endgroup
enddef;
%
def fix_ghost_old =
 begingroup
  if known glyph.ghost_num:
   save base_, delta_;
   for i_:=1 upto glyph.ghost_num:
    base_:=xpart(glyph.ghost[i_]); delta_:=ypart(glyph.ghost[i_]);
    if delta_>0:
     if base_=infinity:
      base_:=round(if delta_=20: glyph_ury else: glyph_lly fi);
     fi
     if delta_=21: base_:=base_+21; fi
     add_to_stem_list("hstem", base_, -delta_);
    else:
     if base_=infinity:
      base_:=round(if delta_=-20: glyph_urx else: glyph_llx fi);
     fi
     if delta_=-21: base_:=base_+21; fi
     add_to_stem_list("vstem", base_, delta_);
    fi
   endfor
  fi
 endgroup
enddef;
% ---
def use_stems(text name) text offset =
 begingroup
  save base_,delta_,offset_; pair offset_; offset_=(0,0);
  for t_:=offset: % syntactic sugar
   if pair t_: offset_:=t_; fi
   if numeric t_: offset_:=(t_,0); fi
  endfor
  % |offset_| must not be rounded prematurely;
  % if |use_stems| is invoked from |use_accent|, the argument
  % |offset_ slanted slant_val| of the |round| operation below
  % is (nearly) rounded
  for i_:=1 upto hstem_stored.uni_name(name).num:
   base_:=round(xpart(hstem_stored.uni_name(name)[i_])+ypart(offset_));
   delta_:=ypart(hstem_stored.uni_name(name)[i_]);
   if delta_=-20: ghost_stem top[base_];
   elseif delta_=-21: ghost_stem bot[base_-21];
   else:
    if known hstem_list_segms_stored.uni_name(name)[i_]:
     add_to_stem_xlist("hstem",base_,delta_,
      hstem_list_segms_stored.uni_name(name)[i_] shifted
       round(offset_ slanted slant_val));
    else:
     add_to_stem_list("hstem",base_,delta_);
    fi
   fi
  endfor
  for i_:=1 upto vstem_stored.uni_name(name).num:
   base_:=round(xpart(vstem_stored.uni_name(name)[i_])+
    xpart(offset_ slanted slant_val));
   delta_:=ypart(vstem_stored.uni_name(name)[i_]);
   if delta_=-20: ghost_stem rt[base_];
   elseif delta_=-21: ghost_stem lft[base_-21];
   else:
    if known vstem_list_segms_stored.uni_name(name)[i_]:
     add_to_stem_xlist("vstem",base_,delta_,
      vstem_list_segms_stored.uni_name(name)[i_] shifted
       round(offset_ slanted slant_val));
    else:
     add_to_stem_list("vstem",base_,delta_);
    fi
   fi
  endfor
 endgroup
enddef;
%% \--------------------------------------------------------------------
%% In general, all objects are supposed to be drawn by the
%% {\bf endglyph} macro, i.e., all drawing operations are deferred.
%% The same concerns labelling, which necessitates redefinition
%% of labelling macros.
%% \-
%% Zak/lada si/e, /ze wszelkie operacje rysowania s/a ,,odraczane''
%% i~realizowane dopiero przez makro {\bf endglyph}. To samo dotyczy
%% etykietowania, sk/ad konieczno/s/c przedefiniowania makr etykietuj/acych.
%% \--------------------------------------------------------------------
newinternal path_label_len; path_label_len:=1;
vardef path_labels@#(text suffix_list) text label_length =
 save s_;
 for l_:=label_length: interim path_label_len:=l_; endfor
 forsuffixes l_:=suffix_list:
  string s_; s_=str l_;
  if (known l_) and (path l_):
   for t_:=0 upto length(l_) if cycle l_: -1 fi: dot_label@#(
     decimal(t_) & substring (length(s_)-path_label_len,length(s_)) of s_,
    point t_ of l_);
   endfor
  fi
 endfor
enddef;
% ---
vardef node_labels@#(text suffix_list)(expr idx_min, idx_max) =
 save s_;
 forsuffixes l_:=suffix_list:
  string s_; s_=str l_;
  for i_:=idx_min upto idx_max:
   if pair l_[i_]:
    if known l_[i_]:
     dot_label@#(s_ & " " & decimal(i_), l_[i_]);
    fi
   fi
  endfor
 endfor
enddef;
% ---
vardef just_labels@#(text t) =
 forsuffixes $=t: if known z$: just_label@#(str$,z$); fi endfor
enddef;
%
vardef just_label@#(expr s,z) = label_(@#)(s,z)(false); enddef;
%
vardef dot_labels@#(text t) =
 forsuffixes $=t: if known z$: dot_label@#(str$,z$); fi endfor
enddef;
%
vardef dot_label@#(expr s,z) = label_(@#)(s,z)(true); enddef;
%
def label_(suffix pos)(expr s,z, dot_or_not) =
% should be more complex if overlapping labels are to be avoided
 if unknown generating: if show_labels_>0:
  begingroup
   save defaultfont; string defaultfont; defaultfont:=label_defaultfont;
   interim defaultscale:=label_defaultscale;
   label_list[incr label_list.num]:=thelabel.pos(s,z italicized);
  endgroup;
  if dot_or_not: label_list.dot[label_list.num]:=z italicized; fi
 fi fi
enddef;
string label_defaultfont; label_defaultfont:="cmr10";
newinternal label_defaultscale; label_defaultscale:=magstep 5;
%% \--------------------------------------------------------------------
%% If the {\it project\/} variable is assigned value greater than~0,
%% proofing mode is assumed; the following macros display then
%% the details of the construction of glyphs for proofing purposes.
%% The larger value of the variable {\it project}, the more details
%% are visualised.
%% \-
%% Je/sli zmienna {\it project\/} ma warto/s/c wi/eksz/a ni/z~0, zak/lada
%% si/e, /ze przetwarzanie zwi/azane jest z~przygotowywaniem dokumentacji.
%% Poni/zsze makra uwidoczniaj/a w/owczas szczeg/o/ly konstrukcji
%% obrys/ow w~celach dokumentacyjnych. Im wy/zsza warto/s/c zmiennej
%% {\it project}, tym wi/ecej szczeg/o/l/ow zawieraj/a ilustracje.
%% \--------------------------------------------------------------------
% ---
def local_drawoptions (text t) = % to be used within a group, see below
%% \begingroup \def\\#1{{\it#1}}% local: no underscore hacks
 save _op_; drawoptions(t);
%% \endgroup
enddef;
% ---
color stem_color; stem_color=1/10[white,1/2red+1/2green];
def replstem_spec =
 withpen pencircle scaled 1 dashed withdots withcolor red
enddef;
def fontdim_spec = withpen pencircle scaled 2 withcolor magenta enddef;
def fontmath_spec = withpen pencircle scaled 2 withcolor cyan enddef;
def chardim_spec = withpen pencircle scaled 2 withcolor 3/4green enddef;
% ---
vardef draw_vhint@#(expr a,b) =
 if str @#="cov":
  draw (a,bot_line)--(a,top_line) replstem_spec;
  draw (a+b,bot_line)--(a+b,top_line) replstem_spec;
 else:
  fill (a,bot_line)--(a+b,bot_line)--(a+b,top_line)--(a,top_line)--cycle
   withcolor stem_color;
 fi;
enddef;
% ---
vardef draw_hhint@#(expr a,b) =
 if str @#="cov":
  draw (0,a)--(glyph_width,a) replstem_spec;
  draw (0,a+b)--(glyph_width,a+b) replstem_spec;
 else:
  fill (0,a)--(glyph_width,a)--(glyph_width,a+b)--(0,a+b)--cycle
   withcolor stem_color;
 fi
enddef;
def do_show_hints =
 if show_stems_>0:
  for h_:=1 upto hstem_list.num:
   draw_hhint(xpart(hstem_list[h_]), ypart(hstem_list[h_]));
  endfor
  if hstem_list.cov=1:
   for h_:=1 upto hstem_list.num:
    draw_hhint.cov(xpart(hstem_list[h_]), ypart(hstem_list[h_]));
   endfor
  fi
  for v_:=1 upto vstem_list.num:
   draw_vhint(xpart(vstem_list[v_])+glyph_shift, ypart(vstem_list[v_]));
  endfor
  if vstem_list.cov=1:
   for v_:=1 upto vstem_list.num:
    draw_vhint.cov(xpart(vstem_list[v_])+glyph_shift, ypart(vstem_list[v_]));
   endfor
  fi
 fi
enddef;
def ship_hints =
 write_special "HINT-TRIPLE " &
  decimal(finding_triple_hstems, finding_triple_vstems);
 write_special "HINT-FLEX " &
  decimal(finding_flex_hstems, finding_flex_vstems);
 ship_vhints; ship_hhints;
enddef;
def ship_vhints =
 for v_:=1 upto vstem_list.num:
  if known vstem_list_segms[v_]:
   write_special "VHINTX " & decimal(vstem_list[v_] + (glyph_shift,0));
   for i_:=0 step 2 until length(vstem_list_segms[v_]):
    write_special "VHINTN " &
     decimal(subpath (i_,i_+1) of vstem_list_segms[v_] shifted(glyph_shift,0));
   endfor
  else:
   write_special "VHINT " & decimal(vstem_list[v_] + (glyph_shift,0));
  fi
 endfor
enddef;
def ship_hhints =
 for h_:=1 upto hstem_list.num:
  if known hstem_list_segms[h_]:
   write_special "HHINTX " & decimal(hstem_list[h_]);
   for i_:=0 step 2 until length(hstem_list_segms[h_]):
    write_special "HHINTN " &
     decimal(subpath (i_,i_+1) of hstem_list_segms[h_]);
   endfor
  else:
   write_special "HHINT " & decimal(hstem_list[h_]);
  fi
 endfor
enddef;
def update_glyph_bb(expr p) =
 if unknown glyph_llx:
  glyph_llx:=xpart(llcorner(p)); glyph_lly:=ypart(llcorner(p));
  glyph_urx:=xpart(urcorner(p)); glyph_ury:=ypart(urcorner(p));
 else:
  if xpart(llcorner(p))<glyph_llx: glyph_llx:=xpart(llcorner(p)); fi
  if ypart(llcorner(p))<glyph_lly: glyph_lly:=ypart(llcorner(p)); fi
  if xpart(urcorner(p))>glyph_urx: glyph_urx:=xpart(urcorner(p)); fi
  if ypart(urcorner(p))>glyph_ury: glyph_ury:=ypart(urcorner(p)); fi
 fi
enddef;
def do_show_stencils =
 begingroup
  if show_stencils_>0:
   if known glyph_stencil.glyph_name and
    (known bitmap_scale or known glyph_llx):
    save s_; picture s_;
    s_:=use_eps(if known stencil_dir: stencil_dir & fi
     glyph_stencil.glyph_name);
    if length s_ > 0: % |use_eps| returns |nullpicture| in the case of emergency
     draw (s_ if known bitmap_scale: scaled bitmap_scale
      else: yxscaledto (glyph_ury-glyph_lly) fi)
     if known absolute_stencils:
      if known bitmap_offset: shifted (bitmap_offset+(glyph_shift,0))
      else: llshiftedto (glyph_llx+glyph_shift,glyph_lly) fi
     else:
      ccshiftedto
       (1/2[glyph_llx,glyph_urx]+glyph_shift, 1/2[glyph_lly,glyph_ury])
       if known bitmap_offset: shifted (bitmap_offset) fi
     fi;
    fi
   fi
  fi
 endgroup
enddef;
string stencil_dir;
def ship_glyphs =
 begingroup
  local_drawoptions();
  for g_:=1 upto glyph_list.num:
   if turningnumber glyph_list[g_]>0: fill else: unfill fi
    glyph_list[g_] shifted (glyph_shift,0);
  endfor
 endgroup
enddef;
def do_show_glyphs =
 begingroup
  save p_; path p_;
  for g_:=1 upto glyph_list.num:
   p_:=glyph_list[g_] shifted (glyph_shift,0);
   if show_fills_>0: if turningnumber p_>0: fill else: unfill fi p_; fi
   if show_strokes_>0:
    draw p_ if show_strokes_>1:
     withpen pencircle scaled show_stroke_size withcolor show_stroke_color
    fi;
   fi
   if show_paths_>0: draw_controls(p_); fi
  endfor
 endgroup
enddef;
newinternal show_stroke_size; show_stroke_size:=1.5;
color show_stroke_color; show_stroke_color:=red;
% ---
vardef visible_control_node =
 unitsquare shifted (-1/2,-1/2) rotated 45 scaled 4.5bp
enddef;
vardef visible_node = fullcircle scaled 7bp enddef;
vardef visible_first_node = triangle scaled 12bp enddef;
vardef visible_direction =
 triangle shifted (-1/6sqrt(3),0) yscaled 3/5 scaled 10bp
enddef;
def draw_controls (expr p) =
 begingroup
  save c_,d_,e_,f_; path c_,d_,e_,f_;
  c_=visible_control_node;
  d_=visible_node;
  e_=visible_direction;
  f_=visible_first_node;
  local_drawoptions (withcolor blue);
  for t_=0 upto length(p) if cycle p: -1 fi:
   if arclength(subpath (t_,t_+1) of p)>5xpart((point 1 of e_)-(point 0 of e_)):
    draw e_ rotated angle(direction t_+1/2 of p) shifted point t_+1/2 of p;
   fi
   if t_>0: fill d_ shifted point t_ of p; fi
   if show_paths_>1:
    if (point t_ of p)<>(precontrol t_ of p):
     draw (point t_ of p) -- (precontrol t_ of p) dashed evenly;
     fill c_ rotated angle(predir t_ of p) shifted precontrol t_ of p
      withcolor white;
     draw c_ rotated angle(predir t_ of p) shifted precontrol t_ of p
      withpen pencircle scaled .3bp;
    fi
    if (postcontrol t_ of p)<>(point t_ of p):
     draw (postcontrol t_ of p) -- (point t_ of p) dashed evenly;
     fill c_ rotated angle(postdir t_ of p) shifted postcontrol t_ of p
      withcolor white;
     draw c_ rotated angle(postdir t_ of p) shifted postcontrol t_ of p
      withpen pencircle scaled .3bp;
    fi
   fi
  endfor
  fill f_ rotated
   if (point 0 of p)<>(postcontrol 0 of p): angle(postdir 0 of p)
   else: angle((point 1 of p)-(point 0 of p)) fi
   shifted point 0 of p withcolor red;
 endgroup
enddef;
% ---
def do_show_labels =
 for l_:=1 upto label_list.num:
  draw label_list[l_] shifted (glyph_shift,0) withcolor label_text_color;
 endfor
 for l_:=1 upto label_list.num: % dots always on top
  if known label_list.dot[l_]:
   fill fullcircle scaled label_dot_size
     shifted label_list.dot[l_] shifted (glyph_shift,0)
     withcolor label_dot_color;
  fi
 endfor
enddef;
color label_dot_color, label_text_color;
label_dot_color:=.8white; label_text_color:=black;
newinternal label_dot_size; label_dot_size:=3bp;
%
def do_show_boxes =
 if show_boxes_>0:
  draw (0,bot_line)--(glyph_width,bot_line)--
   (glyph_width,top_line)--(0,top_line)--cycle;
  draw (0,0)--(glyph_width,0) dashed evenly;
  if known glyph_axis.glyph_name:
   draw ((glyph_axis.glyph_name+glyph_shift,bot_line)--
    (glyph_axis.glyph_name+glyph_shift,top_line)) italicized dashed evenly;
  fi
  draw (0,uc_height)--(glyph_width,uc_height) fontdim_spec;
  draw (0,lc_height)--(glyph_width,lc_height) fontdim_spec;
  draw (0,depth)--(glyph_width,depth) fontdim_spec;
  if known math_axis:
    draw (0,math_axis)--(glyph_width,math_axis) fontmath_spec;
  fi
  if known ht.glyph_name:
   draw (0,ht.glyph_name)--(glyph_width,ht.glyph_name) chardim_spec;
  fi
  if known dp.glyph_name:
   draw (0,dp.glyph_name)--(glyph_width,dp.glyph_name) chardim_spec;
  fi
  if known ic.glyph_name:
   draw (glyph_width+ic.glyph_name,top_line)--
    (glyph_width+ic.glyph_name,top_line-250) chardim_spec;
  elseif known glyph_urx:
   save ital_corr; ital_corr:=glyph_urx+glyph_shift-glyph_width+1000/36;
   if ital_corr>0:
    draw (glyph_width+ital_corr,top_line)--(glyph_width+ital_corr,top_line-250)
     chardim_spec dashed evenly;
   fi
  fi
 fi
enddef;
%
def force_bbox =
 begingroup
 % circumventing the fragility of dvips prologues and inaccuracy of epsf:
 save corr_; corr_:=if glyph_width<100: 1/2(100-glyph_width) else: 0 fi;
 setbounds currentpicture to
  (glyph_width+corr_,bot_line)--(0,top_line)--(-corr_,bot_line)--cycle;
 endgroup;
enddef;
%% \--------------------------------------------------------------------
%% Begin and end of the definitions of a character glyph:
%% \-
%% Rozpocz/ecie i zako/nczenie definicji obrysu znaku:
%% \--------------------------------------------------------------------
def begin_skip =
 let endglyph = fi;
 let ; = end_skip semicolon_
 if false:
enddef;
def end_skip =
 let ; = semicolon_ semicolon_
 let endglyph = endglyph_;
enddef;

def uni_name(text name) = % name is either a suffix or a string expression
 if is_suffix(name): name else: scantokens("_" & name) fi
enddef;

def glyph_name_ext = enddef;
def beginglyph(text name) =
 %
 def glyph_name = uni_name(name) glyph_name_ext enddef; % to use in |endglyph|
 numeric glyph_usage; glyph_usage:=glyph_usage.glyph_name;
 if unknown glyph_usage: expandafter begin_skip fi
 string ps_name; ps_name:=glyph_ps_name.glyph_name;
 if (fontmaking=1) and (name_to_code(glyph_name)<0):
  glyph_usage:=glyph_usage-glyph_usage mod store;
 fi
 if unknown ps_name:
  errhelp "Use macro `introduce' or `assign_name' prior to `beginglyph.'";
  errmessage "MT1: PS name not assigned to " & str glyph_name;
 fi
 if name_used(glyph_name):
  errhelp "Proceed if you wish, I'll use the second glyph description.";
  errmessage "MT1: double output: name " & (str glyph_name);
 fi
 if glyph_usage mod store = 1: % utilizing
  mark_name_used(glyph_name);
 fi
 numeric glyph_code, glyph_num; glyph_code:=name_to_code(glyph_name);
 if fontmaking=0:
  if glyph_code<0: glyph_num:=500-decr(min_glyph_code); else:
   glyph_num:=100+glyph_code;
   if glyph_code>max_glyph_code: max_glyph_code:=glyph_code; fi
  fi
 else:
  glyph_num:=glyph_code-256;
 fi
 %
 beginfig(glyph_num)
 if glyph_usage mod store = 1: % utilizing
  write_special "NAME " & ps_name & " " & decimal(glyph_code);
  if (if known generating: generating=0 else: true fi):
   % mpform.sty and mp2pf.awk interface
%  |write_tex(glyph_name, glyph_num);|
   write_tex(ps_name, glyph_num);
  fi
  if unknown generating:
   if show_stencils_>0: if known glyph_stencil.glyph_name:
    % `epsincl' interface
    write_commands(glyph_num);
   fi fi
  fi
 fi;
 glyph_list.num:=label_list.num:=0;
 path glyph_list[\\];
 picture label_list[\\]; pair label_list.dot[\\];
 numeric glyph_llx, glyph_lly, glyph_urx, glyph_ury;
 numeric bitmap_scale; pair bitmap_offset;
 numeric glyph_shift, glyph_width, glyph_axis;
 save glyph;
 hstem_list.num:=vstem_list.num:=hstem_list.cov:=vstem_list.cov:=0;
 pair hstem_list[\\], vstem_list[\\];
 path hstem_list_segms[\\], vstem_list_segms[\\];
 numeric old_hinting_scheme, new_hinting_scheme;
 if glyph_usage div store = 1: % storing
  if not path glyph_stored.glyph_name[0]: % glyph_name may contain digits
   scantokens("path " & generisize(str glyph_stored.glyph_name) & "[]");
   scantokens("pair " & generisize(str hstem_stored.glyph_name) & "[]");
   scantokens("path " & generisize(str hstem_stored_segms.glyph_name) & "[]");
   scantokens("pair " & generisize(str vstem_stored.glyph_name) & "[]");
   scantokens("path " & generisize(str vstem_stored_segms.glyph_name) & "[]");
  fi
  glyph_stored.glyph_name.num:=0;
  hstem_stored.glyph_name.num:=0; vstem_stored.glyph_name.num:=0;
 fi
 scantokens extra_beginglyph;
enddef;
% ---
picture endglyph_picture;
def endglyph =
 scantokens extra_endglyph;
 % usually, |currentpicture=nullpicture|, but if not (i.e., some
 % extra objects have been drawn), the picture must be shifted:
 endglyph_picture:=currentpicture shifted (glyph_shift,0);
 currentpicture:=nullpicture;
 if fontmaking=0:
  if known new_hinting_scheme: fix_ghost_new; else: fix_ghost_old; fi
 fi
 if known glyph_axis: % actually, used only with stored chars
  glyph_axis.glyph_name:=glyph_axis;
 fi
% fix char dimensions and write them to TFM and/or |dim_file|
% independently of |glyph_usage| (|dim_file|)
 fix_tfm_data(glyph_urx+glyph_shift, glyph_ury);
 if glyph_usage mod store = 1: % utilizing
  if known generating:
   if generating=0:
    write_special "HSBW * " & decimal(glyph_width);
    ship_hints;
    write_special "BEGINCHAR";
    ship_glyphs;
   else: % |fontmaking=1|
    message "{" & ps_name & " " & decimal(glyph_code) & "}";
   fi
  else:
   ship_hints; % debugging!!!
   do_show_hints; do_show_stencils; do_show_boxes;
   draw endglyph_picture;
   do_show_glyphs; do_show_labels; 
   force_bbox;
  fi
  endfig;
 else:
  endgroup; % ends figure without shipping it out
 fi
enddef;
let endglyph_=endglyph;
string extra_beginglyph, extra_endglyph; extra_beginglyph=extra_endglyph="";
%% \--------------------------------------------------------------------
%% Additional macros:
%% \-
%% Makra dodatkowe:
%% \--------------------------------------------------------------------
vardef fix_name_list text t =
 string name_list[]; numeric name_list.num; name_list.num:=0;
 save , ; let , = fix_name_list_; fix_name_list_ t
enddef;
def fix_name_list_ suffix name =
 ; % important semicolon!
 if str name<>"": fix_name_list_s_ name else: fix_name_list_e_ "_" & fi
enddef;
def fix_name_list_s_ suffix s_name = fix_name_list_e_ (str s_name) enddef;
def fix_name_list_e_ expr e_name = % name is expected to be of the string type
 name_list[incr name_list.num]=e_name
enddef;

newinternal uc_accent_drop; % zero by default
newinternal ht_accent_limit;
ht_accent_limit:=50; % supposedly bottom accent |ht.acc < ht_accent_limit|
def use_accent(text name_char_acc) text offsets =
 begingroup
  save name_char_, name_acc_; save name_list; fix_name_list name_char_acc;
  def name_char_ = scantokens(name_list[1]) enddef;
  def name_acc_ = scantokens(name_list[2]) enddef;
  save off_acc_, off_char_; pair off_acc_, off_char_;
  off_char_:=off_acc_:=(0,0);
  for t_:=offsets: % syntactic sugar
   if pair t_: off_acc_:=t_; fi
   if numeric t_: off_char_:=(t_, 0); fi
   if color t_: off_char_:=(redpart t_, greenpart t_); fi
  endfor
  if (is_stored(name_acc_)) and (is_stored(name_char_)):
   if (unknown glyph_axis.glyph_name) and (known glyph_axis.name_char_):
    glyph_axis.glyph_name=glyph_axis.name_char_;
   fi
   off_acc_:=off_acc_+
    (if known glyph_axis.name_char_: glyph_axis.name_char_
     else: (1/2wd.name_char_-glyph_shift.name_char_) fi
     -if known glyph_axis.name_acc_: glyph_axis.name_acc_
     else: 1/2wd.name_acc_ fi, 0) +
    (0,if ht.name_acc_>ht_accent_limit:
        ht.name_char_-lc_height if ht.name_char_-lc_height>0: -uc_accent_drop fi
      else: -dp.name_char_ fi);
   off_acc_:=round(off_acc_ slanted slant_val) slanted -slant_val;
   off_char_:=round(off_char_ slanted slant_val) slanted -slant_val;
   glyph_shift:=glyph_shift.name_char_;
   glyph_width:=glyph_width.name_char_; % can be overwritten in |fix_hsbw|
   if glyph_usage div store = 1: % storing
    glyph_shift.glyph_name:=glyph_shift; glyph_width.glyph_name:=glyph_width;
   fi
   for g_:=1 upto glyph_stored.name_char_.num:
    if turningnumber glyph_stored.name_char_[g_]>0: Fill else: unFill fi
     glyph_stored.name_char_[g_] shifted off_char_;
   endfor;
   for g_:=1 upto glyph_stored.name_acc_.num:
    if turningnumber glyph_stored.name_acc_[g_]>0: Fill else: unFill fi
     glyph_stored.name_acc_[g_] shifted off_acc_;
   endfor;
   write_special("ACC " & decimal(glyph_stored.name_char_.num+1));
   use_stems(name_char_) off_char_; use_stems(name_acc_) off_acc_;
  else:
   mtone_message "attempt to use not stored glyph " & str name_acc_ &
    " or " & str name_char_ & " (`use_accent' ignored)";
  fi
 endgroup
enddef;

def use_dimens(text name) =
 wd.glyph_name:=wd.uni_name(name);
 ht.glyph_name:=ht.uni_name(name);
 dp.glyph_name:=dp.uni_name(name);
 ic.glyph_name:=ic.uni_name(name);
enddef;

def use_glyph(text name) text offset =
 begingroup
  save gly_off_; pair gly_off_; gly_off_:=(0,0);
  for t_:=offset: % syntactic sugar
   if pair t_: gly_off_:=round(t_); fi
   if numeric t_: gly_off_:=(round(t_),0); fi
  endfor
  if is_stored(name):
   glyph_shift:=glyph_shift.uni_name(name);
   glyph_width:=glyph_width.uni_name(name); % can be overwritten in |fix_hsbw|
   if glyph_usage div store = 1: % storing
    glyph_shift.glyph_name:=glyph_shift; glyph_width.glyph_name:=glyph_width;
   fi
   for g_:=1 upto glyph_stored.uni_name(name).num:
    if turningnumber glyph_stored.uni_name(name)[g_]>0: Fill else: unFill fi
     glyph_stored.uni_name(name)[g_] shifted gly_off_;
   endfor;
   use_stems(name) gly_off_;
  else:
   mtone_message "attempt to use not stored glyph " & str uni_name(name) &
    " (`use_glyph' ignored)";
  fi
 endgroup
enddef;

def reset_selected = save process_selected; save ignore_selected; enddef;
def introduce_selected text t =
 begingroup
  save name_list; fix_name_list t;
  process_selected:=1; % multi-step selection is legal
  for i_:=1 upto name_list.num:
   if known process_selected.scantokens(name_list[i_]):
    errhelp "Proceed, I'll just ignore the repeated selection.";
    errmessage "MT1: character `" & (substring(1, infinity) of name_list[i_])
     & "' introduced again";
   else: process_selected.scantokens(name_list[i_])=1; fi
  endfor;
 endgroup
enddef;
def exclude_selected text t =
 begingroup
  save name_list; fix_name_list t;
  for i_:=1 upto name_list.num:
   if known ignore_selected.scantokens(name_list[i_]):
    errhelp "Proceed, I'll just ignore the repeated exclusion.";
    errmessage "MT1: character `" & (substring(1, infinity) of name_list[i_])
     & "' excluded again";
   else: ignore_selected.scantokens(name_list[i_])=1; fi
  endfor;
 endgroup
enddef;

def introduce suffix name =
 if str name="": introduce_
 elseif (substring (0,1) of str name)<>"_": introduce_ name
 else: introduce__ name fi
enddef;
def introduce_ expr name = % name is expected to be a string expression
 introduce__ scantokens("_" & name)
enddef;
vardef introduce__@#(expr usage, slanting)(text stencil) =
 if (unknown process_selected or known process_selected@#)
  and known usage and unknown ignore_selected@#:
  glyph_usage@#:=usage; % |ignore=whatever|, |process=0|, |utilize=1|, |store=2|
  if unknown glyph_ps_name@#: % set default:
   assign_name @# (substring (1,infinity) of (str @#));
  fi
  glyph_slanting@#:=slanting; % ignore |slant_ang| if |0|; use |slant_ang| otherwise
  % |stencil| can be either string (recommended) or suffix (with default
  % extension |".eps"| -- obsolete), hence some trickery below
  save r_; string r_;
  for i_:=stencil: if string i_: r_:=i_; fi endfor
  if unknown r_:
   forsuffixes i_:=stencil: r_:= str i_; endfor
   if r_<>"": r_:=r_ & ".eps"; fi
  fi
  if r_<>"":
   if not string glyph_stencil@#:
    scantokens("string " & generisize(str glyph_stencil@#));
   fi
   glyph_stencil@# = r_;
  fi
 fi
enddef;
% ---
vardef assign_name@#(expr ps_name) =
 if not string glyph_ps_name @#:
  scantokens("string " & generisize(str glyph_ps_name@#));
 fi
 glyph_ps_name@#:=ps_name;
enddef;
% ---
def standard_introduce(expr name) =
 introduce name (utilize+store)(1)();
enddef;
% ---
def standard_hsbw(expr name) =
 fix_hsbw(wd.scantokens("_" & name),0,0);
enddef;
% ---
def standard_exact_hsbw(expr name) =
 fix_exact_hsbw(wd.scantokens("_" & name),0,0);
enddef;
% ---
vardef name_to_code(text name) =
 save res_, name_; string name_;
 name_:=substring (1,infinity) of str uni_name(name); res_=-1;
 for i:=0 upto 255: % 1-to-1 coding presumed
  if known code_to_name_[i]: if code_to_name_[i]=name_: res_:=i; fi fi
  exitif res_>-1;
 endfor
 res_
enddef;
newinternal select_encoded;
def encode(text name)(expr glyph_code)=
 if (glyph_code<0) or (glyph_code>255):
  errhelp "The code must be within the range 0..255.";
  errmessage "MT1: improper code " & decimal(glyph_code) &
   " (`encode' ignored)";
 elseif known code_to_name_[glyph_code]:
  errhelp "A given code can be assigned only to one name (obviously).";
  errmessage "MT1: repeated code for " & code_to_name_[glyph_code] &
    " (" & decimal(glyph_code) & "; `encode' ignored)";
 else:
  code_to_name_[glyph_code]:=substring (1,infinity) of str uni_name(name);
 fi
 if select_encoded>0: introduce_selected uni_name(name); fi
enddef;
def uncode(expr glyph_code)=
 if (glyph_code<0) or (glyph_code>255):
  errhelp "The code must be within the range 0..255.";
  errmessage "MT1: improper code " & decimal(glyph_code) &
   " (`uncode' ignored)";
 else:
  code_to_name_[glyph_code]:=gen_whatever(string);
 fi
enddef;
string code_to_name_[\\];
% ---
vardef name_used(text name) =
 save res_, name_; boolean res_; string name_;
 name_:=substring (1,infinity) of str uni_name(name); res_:=false;
 for i:=1 upto max_name_used: res_:=(name_used_[i]=name_); exitif res_; endfor
 res_
enddef;
def mark_name_used(text name)=
 name_used_[incr max_name_used]:=substring (1,infinity) of str uni_name(name);
enddef;
string name_used_[\\]; newinternal max_name_used;

% ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
vardef string_date =
 if day<10: "0" & fi decimal(day) & "." &
 if month<10: "0" & fi decimal(month) & "." &
 decimal(year)
enddef;
% ---
def set_pfi (suffix kind) (expr val) =
 if known val:
  if (numeric val) or (string val) or (boolean val):
   if (numeric val) and (not numeric pf_info_set.kind):
    scantokens ("numeric " & generisize(str pf_info_set.kind));
   elseif (string val) and (not string pf_info_set.kind):
    scantokens ("string " & generisize(str pf_info_set.kind));
   elseif (boolean val) and (not boolean pf_info_set.kind):
    scantokens ("boolean " & generisize(str pf_info_set.kind));
   fi
   pf_info_set.kind:=val;
   if known generating: if generating=0:
    write str kind & " : " &
     if string val: val
     elseif numeric val: decimal(val)
     elseif boolean val: if val: "true" else: "false" fi
     fi
     to pfi_file;
   fi fi
  else:
   errhelp "Proceed, I'll just ignore the setting.";
   errmessage "MT1: pf_info keys can only be of numeric, string " &
    "and boolean type";
  fi
 fi
enddef;
% ---
def pf_info_version expr v = set_pfi(VERSION,v); enddef;
%
def pf_info_creationdate text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1; set_pfi(CREATION_DATE, t_); exitif k_=1; endfor
  if k_=0: set_pfi(CREATION_DATE, string_date); fi
 endgroup
enddef;
%
def pf_info_fontname text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if k_=1: set_pfi(FONT_NAME, t_); fi
   if k_=2: set_pfi(FULL_NAME, t_); fi
   exitif k_=2;
  endfor
  if k_=1: set_pfi(FULL_NAME, pf_info_set.FONT_NAME); fi
 endgroup
enddef;
%
% useful short-cuts:
vardef family_name = pf_info_set.FAMILY_NAME enddef;
vardef font_name = pf_info_set.FONT_NAME enddef;
vardef full_name = pf_info_set.FULL_NAME enddef;
%
def pf_info_author expr v = set_pfi(AUTHOR,v); enddef;
%% \--------------------------------------------------------------------
%% There is `much ado about nothing,' i.e., about the sign of descender:
%% in a PFB file in an `ADL' comment, descender is positive, while in an AFM
%% in a `Descender' comment -- negative; we will distinguish between
%% the two, the more so as `ADL' comment is not mentioned in
%% in the Adobe documentation {\it Adobe Type~1 Font Format}.
%% \-
%% ,,Wiele ha/lasu o~nic'' jest spowodowane dwoma konwencjami ustalania
%% znaku parametru, descender': w~pliku PFB w~komentarzu, ADL' jego warto/s/c
%% jest dodatnia, natomiast w~pliku AFM w~komentarzu, Descender' -- ujemna.
%% Zdecydowali/smy si/e na odr/o/znienie tych dw/och przypadk/ow
%% tum bardziej, /ze komentarz, ADL' nie jest wzmiankowany
%% w~dokumentacji pt.~{\it Adobe Type~1 Font Format}.
%% \--------------------------------------------------------------------

def pf_info_ascender expr v = ascender:=v; set_pfi(ASCENDER,v); enddef;
def pf_info_descender expr v = descender:=v; set_pfi(DESCENDER,v); enddef;

def pf_info_adl text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if (k_=1) and known t_: adl_ascender:=t_; set_pfi(ADL_ASCENDER,t_); fi
   if (k_=2) and known t_: adl_descender:=t_; set_pfi(ADL_DESCENDER,t_); fi
   if (k_=3) and known t_: adl_lineskip:=t_; set_pfi(ADL_LINESKIP,t_); fi
   exitif k_=3;
  endfor
 endgroup
enddef;
%
def pf_info_underline text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if k_=1: set_pfi(UNDERLINE_POSITION,t_); fi
   if k_=2: set_pfi(UNDERLINE_THICKNESS,t_); fi
   exitif k_=2;
  endfor
 endgroup
enddef;
%
def pf_info_pfm text t =
% parameters: name, bold (0 or 1), italic (0 or 1), char set;
% each of them can be either known or unknown or "*" (which means unknown);
% the last parameter can be either numeric or string representation of
% a valid Perl numeric value (e.g., "0xFF" means 255).
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if (k_=1) and known t_: set_pfi(PFM_NAME,t_); fi
   if (k_=2) and known t_: set_pfi(PFM_BOLD,t_); fi
   if (k_=3) and known t_: set_pfi(PFM_ITALIC,t_); fi
   if (k_=4) and known t_: set_pfi(PFM_CHARSET,t_); fi
   exitif k_=4;
  endfor
 endgroup
enddef;
%
def pf_info_fixedpitch expr v = set_pfi(FIXED_PITCH,v); enddef;
def pf_info_capheight expr v = uc_height:=v; set_pfi(CAPHEIGHT,v); enddef;
def pf_info_weight expr v = set_pfi(WEIGHT,v); enddef;
def pf_info_stdvstem expr v = set_pfi(STDVW,v); enddef;
def pf_info_stdhstem expr v = set_pfi(STDHW,v); enddef;
def pf_info_forcebold expr v = set_pfi(FORCE_BOLD,v); enddef;

% TeX-related font info (fontdimens and headerbytes):
def pf_info_fontdimen text t = % exceptionally, TFM units expected
 begingroup
  save i_, k_, b_; boolean b_;
  k_:=0;
  if true for t_:=t: hide(k_:=k_+1) and known t_ endfor and (k_<=3):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if k_=1:
     i_:=t_;
     % |b| means ``we are ready to override (possibly) the previous value
     % of a font parameter unless we are inside |complete_tfm_info| and
     % then we want to set only a `virgin' value.''
     b_:=unknown completing_tfm_info or unknown pf_info_set.FONT_DIMEN[i_];
    fi
    if b_ and (k_=2): set_pfi(FONT_DIMEN[i_],t_); fontdimen i_: t_; fi
    if b_ and (k_=3): set_pfi(DIMEN_NAME[i_],t_); fi
   endfor
   if b_ and (k_=2): set_pfi(DIMEN_NAME[i_],"(unknown fontdimen name)"); fi
  else:
   errhelp "Proceed, I'll just ignore TFM fontdimen settings.";
   errmessage "MT1: invalid TFM fontdimen data";
  fi
 endgroup
enddef;
def pf_info_headerbyte text t =
 begingroup
  save i_, k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) and known t_ endfor and (k_=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if k_=1: i_:=t_; fi
    if k_=2:
     set_pfi(HEADER_BYTE[i_],if numeric t_: decimal(t_) else: t_ fi);
     if i_=9: % encoding scheme, e.g., |"TEX TEXT"|
      headerbyte 9: BCPL_string(t_,40); fi
     if i_=49: % font family, e.g., |"CMR"|
      headerbyte 49: BCPL_string(t_,20); fi
     if i_=72: % family member number, which should be between 0 and 255
      headerbyte 72: t_; fi
    fi
   endfor
  else:
   errhelp "Proceed, I'll just ignore TFM headerbyte settings.";
   errmessage "MT1: invalid TFM headerbyte data";
  fi
 endgroup
enddef;
def pf_info_designsize expr v = % |designsize| is special
 designsize:=v; set_pfi(DESIGN_SIZE,decimal(v) & " (in points)");
enddef;
def pf_info_italicangle expr v =
 begingroup
  save tfm_units; vardef tfm_units(text x) = c enddef;
  slang:=v; set_pfi(ITALIC_ANGLE,-v);
  pf_info_fontdimen 1, if known slant: slant else: tand(slang) fi, "(slant)";
 endgroup
enddef;
def pf_info_space text t = % three in one
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if (designsize<>0) and known t_:
    if k_=1:
     space:=t_; pf_info_fontdimen 2, tfm_units(space), "(space)";
    elseif k_=2:
     space_stretch:=t_; pf_info_fontdimen 3, tfm_units(space_stretch),
      "(space stretch)";
    elseif k_=3:
     space_shrink:=t_; pf_info_fontdimen 4, tfm_units(space_shrink),
       "(space shrink)";
    fi
   fi
   exitif k_=3;
  endfor
 endgroup
enddef;
def pf_info_normal_space text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: space:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 2, t_, "(space)";
    fi
   endfor
   if (k_=1) and (designsize<>0) and known space:
    pf_info_fontdimen 2, tfm_units(space), "(space)";
   fi
  fi
 endgroup
enddef;
def pf_info_space_stretch text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: space_stretch:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 3, t_, "(space stretch)";
    fi
   endfor
   if (k_=1) and (designsize<>0) and known space_stretch:
    pf_info_fontdimen 3, tfm_units(space_stretch), "(space stretch)";
   fi
  fi
 endgroup
enddef;
def pf_info_space_shrink text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: space_shrink:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 4, t_, "(space shrink)";
    fi
   endfor
   if (k_=1) and (designsize<>0) and known space_shrink:
    pf_info_fontdimen 4, tfm_units(space_shrink), "(space shrink)";
   fi
  fi
 endgroup
enddef;
def pf_info_xheight text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: lc_height:=t_; set_pfi(XHEIGHT, t_); fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 5, t_, "(xheight)";
    fi
   endfor
   if (k_=1) and (designsize<>0) and known lc_height:
    pf_info_fontdimen 5, tfm_units(lc_height), "(xheight)";
   fi
  fi
 endgroup
enddef;
def pf_info_quad text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: quad:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 6, t_, "(quad)";
    fi
   endfor
   if (k_=1) and (designsize<>0) and known quad:
    pf_info_fontdimen 6, tfm_units(quad), "(quad)";
   fi
  fi
 endgroup
enddef;
def pf_info_extra_space text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: extra_space:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 7, t_, "(extra space)";
    fi
   endfor
   if (k_=1) and (designsize<>0) and known extra_space:
    pf_info_fontdimen 7, tfm_units(extra_space), "(extra space)";
   fi
  fi
 endgroup
enddef;
def pf_info_encoding text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if (k_=1) and known t_: if t_<>"": set_pfi(ENCODING_SCHEME, t_); fi fi
   if (k_=2) and known t_: if t_<>"": pf_info_headerbyte 9, t_; fi fi
   if (k_=3) and known t_: if t_<>"": set_pfi(ENCODING_NAME, t_); fi fi
   exitif k_=3;
  endfor
  if (k_=1) and known pf_info_set.ENCODING_SCHEME % upward compatibility
   and unknown pf_info_set.HEADER_BYTE9:
   pf_info_headerbyte 9, pf_info_set.ENCODING_SCHEME;
  fi
 endgroup
enddef;
def pf_info_familyname text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if k_=1: set_pfi(FAMILY_NAME, t_); fi
   if k_=2: pf_info_headerbyte 49, t_; fi
   exitif k_=2;
  endfor
  if k_=1: pf_info_headerbyte 49, pf_info_set.FAMILY_NAME; fi
 endgroup
enddef;
%
% bluezz forever...
newinternal blue_fuzz, blue_scale, blue_shift;
blue_fuzz:=0; % Adobe Type 1 Font Format, p. 41
blue_scale:=0.0454545;
blue_shift:=7;
%
def pf_info_overshoots text t =
 begingroup
  save i_, j_, b_, c_, r_; pair b_[\\], c_[\\];
  i_:=0; j_:=0;
  for t_:=t:
   if (xpart t_=0) and (ypart t_<0): b_[incr i_]=(ypart t_, xpart t_); fi
  endfor
  if i_=0:
   errhelp "No blue values will be written.";
   errmessage "MT1: wrong overshoot info: no baseline ``blue value'' found";
  else:
   if i_>1:
    message "MT1: improper overshoot info: multiple baseline ``blue values'' found";
    i_:=1;
   fi
   for t_:=t: if ypart t_>0: ins_blue(i_, t_, b_); fi endfor
   for t_:=t:
    if (xpart t_<>0) and (ypart t_<0): ins_other_blue(i_, j_, t_, b_, c_); fi
   endfor
  fi
  %
  flush_blues(BLUE_VALUES, min(7, i_), b_); % not more than 14 blue values
  if j_>0: % other blues are optional, while blue values are obligatory
   flush_blues(OTHER_BLUES, min(5, j_), c_); % not more than 10 other blues
  fi
  set_pfi(BLUE_FUZZ, blue_fuzz);
  set_pfi(BLUE_SCALE, blue_scale);
  set_pfi(BLUE_SHIFT, blue_shift);
 endgroup
enddef;
%
def ins_blue (suffix m) (expr p) (suffix b) =
 begingroup
  save p_, bad; boolean bad; pair p_;
  bad:=false; p_=(xpart p, xpart p+ypart p);
  for i_:=1 upto m: bad:=infeasible_blue(b[i_],p_); exitif bad; endfor
  if not bad: b[incr m]=p_;
  else:
   message "MT1: improper overshoot info: ``blue value'' (" &
    decimal(xpart p) & "," & decimal(ypart p) & ") ignored.";
  fi
 endgroup
enddef;
%
def ins_other_blue (suffix m,n) (expr p) (suffix b,c) =
 begingroup
  save p_, bad; boolean bad; pair p_;
  bad:=false; p_=(xpart p+ypart p,xpart p);
  for i_:=1 upto m: bad:=infeasible_blue(b[i_], p_); exitif bad; endfor
  if not bad:
   for i_:=1 upto n: bad:=infeasible_blue(c[i_], p_); exitif bad; endfor
   if not bad: c[incr n]=p_; fi
  fi
  if bad:
   message "MT1: improper overshoot info: ``other blue'' (" &
    decimal(xpart p) & "," & decimal(ypart p) & ") ignored.";
  fi
 endgroup
enddef;
%
def flush_blues (suffix kind) (expr n) (suffix v) =
 begingroup
  save r_; string r_; r_:="";
  if n>0:
   r_:=decimal(xpart v[1]) & " " & decimal(ypart v[1]);
   for i_:=2 upto n:
    r_:=r_ & " " & decimal(xpart v[i_]) & " " & decimal(ypart v[i_]);
   endfor
  fi
  set_pfi(kind, r_);
 endgroup
enddef;
%
vardef infeasible_blue(expr p,q) = % Adobe Type 1 Font Format, p. 41, Note
 ((ypart p + 2blue_fuzz+1)>=xpart q) and ((ypart q + 2blue_fuzz+1)>=xpart p)
enddef;

% it is advisable to avoid typso whenever possible:
def show_compose  expr x = show_compose_  :=x; enddef;
def show_fills    expr x = show_fills_    :=x; enddef;
def show_strokes  expr x = show_strokes_  :=x; enddef;
def show_paths    expr x = show_paths_    :=x; enddef;
def show_labels   expr x = show_labels_   :=x; enddef;
def show_boxes    expr x = show_boxes_    :=x; enddef;
def show_stems    expr x = show_stems_    :=x; enddef;
def show_stencils expr x = show_stencils_ :=x; enddef;

string extra_beginfont, extra_endfont; extra_beginfont=extra_endfont="";

def beginfont =
 min_glyph_code=max_glyph_code=0;
 finding_triple_hstems:=1; finding_triple_vstems:=1;
% |finding_flex_hstems:=1; finding_flex_vstems:=1;|
 if known generating:
  if generating<>0: fontmaking:=1; fi
 else:
  if unknown show_compose_: show_compose(1); fi % upward compatibility
  if unknown show_fills_: show_fills(0); fi
  if unknown show_strokes_: show_strokes(2); fi
  if unknown show_paths_: show_paths(1); fi
  if unknown show_labels_: show_labels(1); fi
  if unknown show_boxes_: show_boxes(1); fi
  if unknown show_stems_: show_stems(1); fi
  if unknown show_stencils_: show_stencils(0); fi
 fi
 complete_param_setting;
 scantokens extra_beginfont;
enddef;

def complete_param_setting =
 if designsize=0: designsize:=10; fi
 if unknown space: space:=333; fi
 if unknown space_stretch: space_stretch:=round(1/2space); fi
 if unknown space_shrink: space_shrink:=round(1/3space); fi
 if unknown extra_space: extra_space:=round(1/3space); fi
 if unknown quad: quad:=1000; fi
 if unknown slang:
  if known slant: % compatibility with the Old Tradition...
   slang:=angle(1, slant);
  else: slang:=0; fi
 fi
 if unknown uc_height: uc_height:=750; fi
 if unknown lc_height: lc_height:=400; fi
 if unknown italic_shift: italic_shift:=-40; fi % used to be |-100|
 if unknown depth: depth:=-250; fi
 if unknown ascender: ascender:=uc_height; fi
 if unknown descender: descender:=depth; fi
 if unknown adl_ascender: adl_ascender:=uc_height; fi
 if unknown adl_descender: adl_descender:=-depth; fi
 if unknown adl_lineskip: adl_lineskip:=0; fi
 if unknown top_line: top_line:=adl_ascender+1/2adl_lineskip; fi
 if unknown bot_line: bot_line:=-(adl_descender+1/2adl_lineskip); fi
 if unknown math_axis: math_axis:=250; fi
 if unknown math_rule: math_rule:=40; fi
 begingroup
  save rth_, pt_, subs_, desc_depth_, fig_height_, asc_height_;
  rth_:=math_rule; pt_:=100;
  % math symbol font parameters (defaults excerpted from cmsy10)
  subs_:=7/10;
  desc_depth_:=70/36pt_; fig_height_:=232/36pt_; asc_height_:=250/36pt_;
  if unknown num_one:
   num_one:=math_axis+3.51rth_+54/36pt_+subs_*desc_depth_; fi
  if unknown num_two:   num_two:=math_axis+1.51rth_+30/36pt_; fi
  if unknown num_three: num_three:=math_axis+1.51rth_+48/36pt_; fi
  if unknown denom_one:
   denom_one:=3.51rth_+subs_*fig_height_+124/36pt_-math_axis; fi
  if unknown denom_two:
   denom_two:=1.51rth_+subs_*fig_height_+30/36pt_-math_axis; fi
  if unknown sup_one:   sup_one:=8.99pt_-subs_*asc_height_; fi
  if unknown sup_two:   sup_two:=8.49pt_-subs_*asc_height_; fi
  if unknown sup_three: sup_three:=104/36pt_; fi
  if unknown sub_one:   sub_one:=54/36pt_; fi
  if unknown sub_two:   sub_two:=-8.49pt_+2subs_*asc_height_+3.1rth_; fi
  if unknown sup_drop:  sup_drop:=subs_*asc_height_-36/36pt_; fi
  if unknown sub_drop:  sub_drop:=18/36pt_; fi
  if unknown delim_one: delim_one:=23.9pt_; fi
  if unknown delim_two: delim_two:=10.1pt_; fi
  % math extension font parameters (defaults excerpted from cmex10)
  if unknown big_op_spacing_one:   big_op_spacing_one:=40/36pt_; fi;
  if unknown big_op_spacing_two:   big_op_spacing_two:=60/36pt_; fi;
  if unknown big_op_spacing_three: big_op_spacing_three:=72/36pt_; fi;
  if unknown big_op_spacing_four:  big_op_spacing_four:=216/36pt_; fi;
  if unknown big_op_spacing_five:  big_op_spacing_five:=36/36pt_; fi;
 endgroup;
enddef;
% ---
def endfont =
 scantokens extra_endfont;
 complete_pf_info;
 if fontmaking=1: write_dvips_info; fi
 complete_tfm_info;
 scantokens "end";
enddef;
% ---
def complete_pf_info =
 if unknown pf_info_set.DESIGN_SIZE: pf_info_designsize designsize; fi
 if unknown pf_info_set.VERSION: pf_info_version "0.000"; fi
 if unknown pf_info_set.AUTHOR: pf_info_author "Unknown"; fi
 if unknown pf_info_set.CREATION_DATE: pf_info_creationdate; fi
 if unknown pf_info_set.FAMILY_NAME: pf_info_familyname "Untitled"; fi
 if unknown pf_info_set.FONT_NAME: pf_info_fontname "Untitled"; fi
 if unknown pf_info_set.ASCENDER: pf_info_ascender ascender; fi
 if unknown pf_info_set.DESCENDER: pf_info_descender descender; fi
 if unknown pf_info_set.ADL_ASCENDER:
  pf_info_adl adl_ascender, whatever, whatever;
 fi
 if unknown pf_info_set.ADL_DESCENDER:
  pf_info_adl whatever, adl_descender, whatever;
 fi
 if unknown pf_info_set.ADL_LINESKIP:
  pf_info_adl whatever, whatever, adl_lineskip;
 fi
 if unknown pf_info_set.UNDERLINE_POSITION: pf_info_underline -200, whatever; fi
 if unknown pf_info_set.UNDERLINE_THICKNESS: pf_info_underline whatever, math_rule; fi
 if unknown pf_info_set.ITALIC_ANGLE: pf_info_italicangle slang; fi
 if unknown pf_info_set.FIXED_PITCH: pf_info_fixedpitch false; fi
 if unknown pf_info_set.CAPHEIGHT: pf_info_capheight uc_height; fi
 if unknown pf_info_set.XHEIGHT: pf_info_xheight lc_height; fi
 if unknown pf_info_set.WEIGHT: pf_info_weight "Normal"; fi
 if unknown pf_info_set.STDVW: fi % just ignore
 if unknown pf_info_set.STDHW: fi % just ignore
 if unknown pf_info_set.FORCE_BOLD: pf_info_forcebold false; fi
 if unknown pf_info_set.ENCODING_SCHEME:
  pf_info_encoding "FontSpecific", whatever;
 fi
 if unknown pf_info_set.HEADER_BYTE9:
  pf_info_encoding whatever, "UNSPECIFIED";
 fi
 if unknown pf_info_set.BLUE_VALUES: set_pfi(BLUE_VALUES, ""); fi
 if unknown pf_info_set.OTHER_BLUES: fi % just ignore
 if unknown pf_info_set.BLUE_FUZZ: set_pfi(BLUE_FUZZ, blue_fuzz); fi
 if unknown pf_info_set.BLUE_SCALE: set_pfi(BLUE_SCALE, blue_scale); fi
 if unknown pf_info_set.BLUE_SHIFT: set_pfi(BLUE_SHIFT, blue_shift); fi
 % for those who like smart (implicit) systems:
 if unknown no_implicit_spaces:
  if not name_used("space"):
   if unknown glyph_usage._space: introduce _space (utilize)(0)(); fi;
   if (name_to_code("space")<0) and (unknown code_to_name_32):
    encode("space") (32);
   fi
   beginglyph(_space) fix_hsbw(space,0,0); endglyph;
  fi
  if not name_used("nbspace"):
   if unknown glyph_usage._nbspace: introduce _nbspace (utilize)(0)(); fi;
   %
   beginglyph(_nbspace) fix_hsbw(space,0,0); endglyph; % normal space width
  fi
 fi
enddef;
% ---
% Johannes K\"uster's naming convention:
vardef CreateSymbolFont = known create_symbol_font enddef;
vardef CreateExtensionFont = known create_extension_font enddef;
vardef CreateQuasiMathFont = known create_quasi_math_font enddef;
create_quasi_math_font:=1; % upward compatibility
%
def complete_tfm_info =
 % complete fontdimen info:
 % |designsize| is expected to be known
 % |slant| dimen has already been set; |xheight| dimen -- not necessarily,
 % but |pf_info_set.XHEIGHT| is known:
 completing_tfm_info:=1;
 pf_info_xheight whatever,
   if known lc_height#: lc_height# else: tfm_units(pf_info_set.XHEIGHT) fi;
 pf_info_normal_space space if known space#: , space# fi;
 pf_info_space_stretch space_stretch
  if known space_stretch#: , space_stretch# fi;
 pf_info_space_shrink space_shrink if known space_shrink#: , space_shrink# fi;
 pf_info_quad quad if known quad#: , quad# fi;
 pf_info_extra_space extra_space if known extra_space#: , extra_space# fi;
 if CreateSymbolFont:
  font_num_one   num_one;
  font_num_two   num_two;
  font_num_three num_three;
  font_denom_one denom_one;
  font_denom_two denom_two;
  font_sup_one   sup_one;
  font_sup_two   sup_two;
  font_sup_three sup_three;
  font_sub_one   sub_one;
  font_sub_two   sub_two;
  font_sup_drop  sup_drop;
  font_sub_drop  sub_drop;
  font_delim_one delim_one;
  font_delim_two delim_two;
  font_math_axis math_axis;
 elseif CreateExtensionFont:
  font_math_rule            math_rule;
  font_big_op_spacing_one   big_op_spacing_one;
  font_big_op_spacing_two   big_op_spacing_two;
  font_big_op_spacing_three big_op_spacing_three;
  font_big_op_spacing_four  big_op_spacing_four;
  font_big_op_spacing_five  big_op_spacing_five;
 elseif CreateQuasiMathFont: % non-standard
  font_math_rule math_rule;
  font_math_axis math_axis;
 fi
 % complete header info:
 pf_info_headerbyte 72, max(0, 254 - round 2designsize);
 completing_tfm_info:=whatever;
enddef;
% ---
def BCPL_string(expr s,n)= % string |s| becomes an |n|-byte BCPL string
 for l:=if length(s)>=n: n-1 else: length(s) fi: l
  for k:=1 upto l: , substring (k-1,k) of s endfor
  for k:=l+2 upto n: , 0 endfor endfor
enddef;
%
def write_dvips_info = % this macro is invoked only if |fontmaking=1|
 begingroup
  save enc_name_; string enc_name_; enc_name_:="enc" & jobname;
  write "/" & enc_name_ & "[" to enc_file;
  for i_:=0 upto 255:
   write "/" &
     if unknown code_to_name_[i_]
       if known rigorous_encoding: or not charexists i_ fi:
      ".notdef"
     else:
      % |glyph_ps_name.uni_name(begingroup code_to_name_[i_] endgroup))|
      % may be undefined (it is an undefined numeric then) if a character
      % is encoded but not introduced; allowing this may be useful at the
      % initial stage of a font development (if one starts with a complete
      % encoding); the construction |begingroup|\dots|endgroup| is essential:
      if known glyph_ps_name.uni_name(begingroup code_to_name_[i_] endgroup):
       glyph_ps_name.uni_name(begingroup code_to_name_[i_] endgroup)
      else:
       ".notdef"
      fi
     fi
    to enc_file;
  endfor
  write "] def" to enc_file;
  write jobname & " " & pf_info_set.FONT_NAME & " " &
   ditto & enc_name_ & " ReEncodeFont" & ditto &
   " <" & enc_file & " <" & jobname & ".pfb" to map_file;
 endgroup
enddef;
% ---
% The Old Tradition...
def font_size expr x = designsize:=x enddef;
def font_slant expr x = fontdimen 1: x enddef;
def font_normal_space expr x = fontdimen 2: x enddef;
def font_normal_stretch expr x = fontdimen 3: x enddef;
def font_normal_shrink expr x = fontdimen 4: x enddef;
def font_x_height expr x = fontdimen 5: x enddef;
def font_quad expr x = fontdimen 6: x enddef;
def font_extra_space expr x = fontdimen 7: x enddef;
%
% A New Tradition...
def def_font_param (suffix param_name)(expr param_num, param_desc) =
 def param_name text x =
  begingroup save #; % cf. the definition of |tfm_units|
   if (known x#) or ((designsize<>0) and known x):
    pf_info_fontdimen param_num, tfm_units(x), "(" & param_desc & ")";
   fi
  endgroup
 enddef;
enddef;
% ---
def_font_param (font_math_rule, 8, "math rule");
def_font_param (font_math_axis, 22, "math axis");
% --- symbol fonts
def_font_param (font_num_one,    8, "num1");
def_font_param (font_num_two,    9, "num2");
def_font_param (font_num_three, 10, "num3");
def_font_param (font_denom_one, 11, "denom1");
def_font_param (font_denom_two, 12, "denom2");
def_font_param (font_sup_one,   13, "sup1");
def_font_param (font_sup_two,   14, "sup2");
def_font_param (font_sup_three, 15, "sup3");
def_font_param (font_sub_one,   16, "sub1");
def_font_param (font_sub_two,   17, "sub2");
def_font_param (font_sup_drop,  18, "sup_drop");
def_font_param (font_sub_drop,  19, "sub_drop");
def_font_param (font_delim_one, 20, "delim1");
def_font_param (font_delim_two, 21, "delim2");
% --- extension fonts
def_font_param (font_big_op_spacing_one,    9, "big_op_spacing1");
def_font_param (font_big_op_spacing_two,   10, "big_op_spacing2");
def_font_param (font_big_op_spacing_three, 11, "big_op_spacing3");
def_font_param (font_big_op_spacing_four,  12, "big_op_spacing4");
def_font_param (font_big_op_spacing_five,  13, "big_op_spacing5");

endinput
%%\end

