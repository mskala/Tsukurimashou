%
% Hindu/Arabic numerals for Tsukurimashou
% Copyright (C) 2011  Matthew Skala
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, version 3.
%
% As a special exception, if you create a document which uses this font, and
% embed this font or unaltered portions of this font into the document, this
% font does not by itself cause the resulting document to be covered by the
% GNU General Public License. This exception does not however invalidate any
% other reasons why the document might be covered by the GNU General Public
% License. If you modify this font, you may extend this exception to your
% version of the font, but you are not obligated to do so. If you do not
% wish to do so, delete this exception statement from your version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
% Matthew Skala
% http://ansuz.sooke.bc.ca/
% mskala@ansuz.sooke.bc.ca
%

inclusion_lock(numerals);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef numeral.zero =
  push_pbox_toexpand("numeral.zero");
  push_stroke(((0.74*dir 330)..(0.72*dir 30)..(up)..
         (0.72*dir 150)..(0.74*dir 210)..(down)..cycle)
    scaled ((latin_wide_high_r-latin_wide_low_r)/2)
    shifted centre_pt,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);
  expand_pbox;
enddef;

vardef numeral.one =
  push_pbox_toexpand("numeral.one");
  x3=x2=520;

  y2=latin_wide_high_h;
  y3=latin_wide_low_v;

  z1=z2+200*dir 195;

  push_stroke(z1--z2--z3,(1.1,1.1)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_boserif(0,2,3);
  expand_pbox;
enddef;

vardef numeral.two =
  push_pbox_toexpand("numeral.two");
  x1=x4;
  0.62[x1,x3]=500;
  x2=0.6[x1,x3];
  x5=1.2[x1,x3];
  x3-x1=0.57*(y2-y4);

  y1=0.78[y4,y2];
  y2=latin_wide_high_r;
  y3=0.58[y4,y2];
  y4=y5=latin_wide_low_h;

  push_stroke(z1..z2{right}..z3..tension 1.2..{curl 0}z4--z5,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,3,0);
  expand_pbox;
enddef;

vardef numeral.three =
  push_pbox_toexpand("numeral.three");
  x1=x7;
  x2=x6=0.5[x1,x3];
  x3=x5;
  x4=0.35[x1,x3];
  (x1+x3)/2=480;
  (x3-x1)=0.55*(y2-y6);

  y1=0.91[y6,y2];
  y2=latin_wide_high_r;
  y3=0.45[y4,y2];
  y4=0.54[y6,y2];
  y5=0.45[y4,y6];
  y6=latin_wide_low_r;
  y7=0.1[y6,y2];

  push_stroke(z1{curl 0.7}..z2{right}..z3..{left}z4{right}..
      z5..z6{left}..{curl 0.7}z7,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6));
  set_botip(0,3,0);
  expand_pbox;
enddef;

vardef numeral.four =
  push_pbox_toexpand("numeral.four");
  x3=x4=0.7[x2,x1];
  0.53[x2,x1]=520;
  (x1-x2)=0.67(y3-y4);

  y1=y2=0.41[y4,y3];
  y3=latin_wide_high_v;
  y4=latin_wide_low_v;

  if do_alternation:
    push_stroke(z1--z2--(0.1[z2,(z3+alternate_adjust*left)])--
        (z3+alternate_adjust*left),
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
    set_botip(0,2,0);
    set_bobrush(0,bralternate);

    push_stroke(z3--z4,(1.6,1.6)--(1.6,1.6));
    set_botip(0,0,0);
    set_boserif(0,1,3);
  else:
    push_stroke(z1--z2--(0.1[z2,z3])--z3--z4,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
    set_botip(0,3,0);
    set_boserif(0,4,3);
  fi;
  expand_pbox;
enddef;

vardef numeral.five =
  push_pbox_toexpand("numeral.five");
  (x1+x2)/2=500;
  (x1-x2)=(y2-y3);
  x2=x3;
  x4=1.03[x2,x1];
  x5=0.35[x2,x1];
  x6=(-0.25)[x2,x1];

  y1=y2=latin_wide_high_h;
  y3=0.57[y5,y1];
  y4=0.6[y5,y3];
  y5=latin_wide_low_r;
  y6=0.16[y5,y3];

  push_stroke(z1--z2--z3{curl 0.5}..z4..z5{left}..z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_botip(0,2,1);
  expand_pbox;
enddef;

vardef numeral.six =
  push_pbox_toexpand("numeral.six");
  x1=0.8[x2,x4];
  (x2+x4)/2=x3=500;
  (x4-x2)=0.6(y1-y3);
  x5=x3;

  y1=latin_wide_high_v;
  y2=y4=0.32[y3,y1];
  y3=latin_wide_low_r;
  y5-y4=0.73*(y4-y3);

  push_stroke(z1{curl 0.2}..tension 1.2..z2..z3..z4{dir 100},
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(z1{curl 0.2}..tension 1.2..z2..z3..z4{dir 100}..
    z5..{curl 0.2}(point 0.8 of oldp));
  expand_pbox;
enddef;

vardef numeral.seven =
  push_pbox_toexpand("numeral.seven");
  (x1+x2)/2=500;
  x3=0.3[x1,x2];
  (x2-x1)=0.67*(y1-y3);

  y1=y2=latin_wide_high_h;
  y3=latin_wide_low_v;

  push_stroke(z1--z2--z3,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,0);
  expand_pbox;
enddef;

vardef numeral.eight =
  push_pbox_toexpand("numeral.eight");
  x1=x3=x5=x7=(x2+x8)/2=(x4+x6)/2=500;
  (x4-x6)=1.06*(x8-x2);
  (x4+x8-x6-x2)/2=0.6*(y1-y5);

  y1=latin_wide_high_r;
  y2=y8=0.5[y3,y1];
  y3=y7=0.54[y5,y1];
  y4=y6=0.5[y5,y3];
  y5=latin_wide_low_r;

  push_stroke(z1..z2..z3{right}..z4..z5..z6..z7{right}..z8..cycle,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6)--cycle);
  expand_pbox;
enddef;

vardef numeral.nine =
  push_pbox_toexpand("numeral.nine");
  x1=0.3[x4,x2];
  (x2+x4)/2=x3=500;
  (x2-x4)=0.6(y3-y1);
  x5=x3;

  y1=latin_wide_low_v;
  y2=y4=0.29[y3,y1];
  y3=latin_wide_high_r;
  y5-y4=0.69*(y4-y3);

  push_stroke(z1{curl 0.2}..tension 1.2..z2..z3..z4{dir 280},
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(z1{curl 0.2}..tension 1.2..z2..z3..z4{dir 280}..
    z5..{curl 0.2}(point 0.8 of oldp));
  expand_pbox;
enddef;
