%
% Ogonek letters for Tsukurimashou
% Copyright (C) 2011, 2012  Matthew Skala
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

inclusion_lock(ogonek);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef latin.upaogonek =
  push_pbox_toexpand("latin.upaogonek");
  latin.upa;

  x6=0.3[x2,x3];
  x7=0.4[x6,x8];
  x8=x3;

  y6=0.5[y7,y3];
  y7=latin_wide_desc_r;
  y8=0.2[y7,y3];

  if do_alternation:
    replace_strokep(0)(oldp{dir 210}..z6..z7{right}..z8);
    replace_strokep(0)(insert_nodes(oldp)(length(oldp)-2.5));
    replace_strokeq(0)(oldq--(1.4,1.4)--(1.3,1.3)--(1.4,1.4)--(1,1));
    set_boserif(0,1,2);
    set_botip(0,length(get_strokep(0))-4,1);
  else:
    replace_strokep(-1)(oldp{dir 210}..z6..z7{right}..z8);
    replace_strokep(-1)(insert_nodes(oldp)(length(oldp)-2.5));
    replace_strokeq(-1)(oldq--(1.4,1.4)--(1.3,1.3)--(1.4,1.4)--(1,1));
    set_boserif(-1,1,2);
    set_botip(-1,length(get_strokep(-1))-4,1);
  fi;
  expand_pbox;
enddef;

vardef latin.upeogonek =
  push_pbox_toexpand("latin.upeogonek");
  latin.upe;

  x7=0.5[x3,x4];
  x8=0.4[x7,x9];
  x9=x4;

  y7=0.5[y8,y4];
  y8=latin_wide_desc_r;
  y9=0.2[y8,y4];

  replace_strokep(-1)(oldp{dir 210}..z7..z8{right}..z9);
  replace_strokep(-1)(insert_nodes(oldp)(length(oldp)-2.5));
  replace_strokeq(-1)(oldq--(1.4,1.4)--(1.3,1.3)--(1.4,1.4)--(1,1));
  set_botip(-1,length(get_strokep(-1))-4,0);
  expand_pbox;
enddef;

vardef latin.upiogonek =
  push_pbox_toexpand("latin.upiogonek");
  latin.upi;

  x1=x4=500;
  x2=300;
  x3=0.4[x2,x4];

  y1=latin_wide_low_h;
  y2=0.5[y3,y1];
  y3=latin_wide_desc_r;
  y4=0.2[y3,y1];

  replace_strokep(0)((700,latin_wide_low_h)--z1{dir 210}..z2..z3{right}..z4);
  replace_strokep(0)(insert_nodes(oldp)(1.5));
  replace_strokeq(0)((1.6,1.6)--(1.6,1.6)--(1.4,1.4)--
    (1.3,1.3)--(1.4,1.4)--(1,1));
  expand_pbox;
enddef;

vardef latin.upuogonek =
  push_pbox_toexpand("latin.upuogonek");
  latin.upu;

  replace_strokep(0)(insert_nodes(oldp)(2.5));
  replace_strokeq(0)(insert_nodes(oldq)(2.5));
  set_boserif(0,5,3);
  set_boserif(0,4,whatever);

  z6=point 3 of get_strokep(0);

  y7=0.5[y8,y6];
  y8=latin_wide_desc_r;
  y9=0.2[y8,y6];

  x9-x7=(x4-x2)*((y6-y8)/(y1-y3));
  x8=0.4[x7,x9];
  x9=x4;

  push_stroke(z6{-direction 3 of get_strokep(0)}..z7..z8{right}..z9,
    (1.1,1.1)--(1.4,1.4)--(1.3,1.3)--(1.4,1.4)--(1,1));
  replace_strokep(0,insert_nodes(oldp)(length(oldp)-2.5));
  expand_pbox;
enddef;

vardef latin.lowaogonek =
  push_pbox_toexpand("latin.lowaogonek");
  latin.lowa;

  y9=0.5[y10,y4];
  y10=latin_wide_desc_r;
  y11=0.2[y10,y4];

  x11-x9=(x4-x1)*((y4-y10)/(y2-y4));
  x10=0.4[x9,x11];
  x11=x4;

  replace_strokep(-1)(oldp{dir 210}..z9..z10{right}..z11);
  replace_strokep(-1)(insert_nodes(oldp)(length(oldp)-2.5));
  replace_strokeq(-1)(oldq--(1.4,1.4)--(1.3,1.3)--(1.4,1.4)--(1,1));
  set_botip(-1,length(get_strokep(-1))-4,1);
  expand_pbox;
enddef;

vardef latin.loweogonek =
  push_pbox_toexpand("latin.loweogonek");
  latin.lowe;

  z7=point (-0.5+length get_strokep(0)) of get_strokep(0);

  y8=0.4[y9,y7];
  y9=latin_wide_desc_r;
  y10=0.2[y9,y7];

  x10-x8=(x2-x4)*((y7-y9)/(y3-y5));
  x9=0.4[x8,x10];
  x10=x6;

  push_stroke(z7{-direction (-0.5+length get_strokep(0)) of get_strokep(0)}
      ..z8..z9{right}..z10,
    (1.1,1.1)--(1.4,1.4)--(1.3,1.3)--(1.4,1.4)--(1,1));
  replace_strokep(0,insert_nodes(oldp)(length(oldp)-2.5));
  expand_pbox;
enddef;

vardef latin.lowiogonek =
  push_pbox_toexpand("latin.lowiogonek");
  latin.lowi;

  x5=x7-200;
  x6=0.4[x5,x7];
  x7=x3;

  y5=0.5[y6,y3];
  y6=latin_wide_desc_r;
  y7=0.2[y6,y3];

  replace_strokep(0)(oldp{dir 210}..z5..z6{right}..z7);
  replace_strokep(0)(insert_nodes(oldp)(2.5));
  replace_strokeq(0)(oldq--(1.4,1.4)--(1.3,1.3)--(1.4,1.4)--(1,1));
  set_boserif(0,2,2);
  set_botip(0,2,1);
  expand_pbox;
enddef;

vardef latin.lowuogonek =
  push_pbox_toexpand("latin.lowuogonek");
  latin.lowu;

  y7=0.5[y8,y1];
  y8=latin_wide_desc_r;
  y9=0.2[y8,y1];

  x9-x7=(x1-x6)*((y1-y8)/(y2-y1));
  x8=0.4[x7,x9];
  x9=x1;

  replace_strokep(-1)(z2--z1{dir 210}..z7..z8{right}..z9);
  replace_strokep(-1)(insert_nodes(oldp)(length(oldp)-2.5));
  replace_strokeq(-1)((1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.3,1.3)--
    (1.4,1.4)--(1,1));
  set_botip(-1,1,1);
  set_boserif(-1,0,whatever);
  set_boserif(-1,1,2);
  expand_pbox;
enddef;
