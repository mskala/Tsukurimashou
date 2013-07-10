%
% Unicode page 76 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013  Matthew Skala
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

% AUTODEPS
input bkencl.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.climb =
  push_pbox_toexpand("kanji.grthree.climb");
  kanji.radical.dotted_tent;
  tsu_xform(identity shifted (-500,50) xyscaled (0.7,0.54) shifted (500,-50))
    (kanji.grthree.bean);
  obstacktype[find_whatever(otstroke,-5)]:=otnull;
  replace_strokep(0)(oldp shifted (-500,0) xscaled 1.2 shifted (500,0));
  expand_pbox;
enddef;

vardef kanji.grthree.departure =
  push_pbox_toexpand("kanji.grthree.departure");
  build_kanji.level(
    kanji.radical.dotted_tent;
    tsu_xform(identity shifted (-500,50) xyscaled (0.83,0.6) shifted (500,-50))
      (kanji.radical.legs);
    build_kanji.sscale(xscaled 0.9 shifted (0,-130))(kanji.grone.one));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.target =
  push_pbox_toexpand("kanji.grfour.target");
  build_kanji.level(build_kanji.lr(440,80)
    (build_kanji.sscale(yscaled 0.85 shifted (0,30))
       (kanji.grone.white))
    (kanji.grnine.ladle));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grten.sake_cup =
  push_pbox_toexpand("kanji.grten.sake_cup");
  build_kanji.tb(360,40)
    (kanji.grfour.non)
    (kanji.grthree.dish);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% "dotted tent" radical (macro includes floor inside tent)
begintsuglyph("uni7676",118);
  kanji.radical.dotted_tent;
  tsu_render;
endtsuglyph;

% hatsu/ta "departure"
begintsuglyph("uni767A",122);
  kanji.grthree.departure;
  tsu_render;
endtsuglyph;

% tou/nobo "climb"
begintsuglyph("uni767B",123);
  kanji.grthree.climb;
  tsu_render;
endtsuglyph;

% shiro "white"
begintsuglyph("uni767D",125);
  kanji.grone.white;
  tsu_render;
endtsuglyph;

% hyako/momo "hundred"
begintsuglyph("uni767E",126);
  kanji.grone.hundred;
  tsu_render;
endtsuglyph;

% teki/mato "target" and adjective ending
begintsuglyph("uni7684",132);
  kanji.grfour.target;
  tsu_render;
endtsuglyph;

% kai/minna "everybody"
begintsuglyph("uni7686",134);
  kanji.greight.everybody;
  tsu_render;
endtsuglyph;

% kou "emperor"
begintsuglyph("uni7687",135);
  kanji.grsix.emperor;
  tsu_render;
endtsuglyph;

% hi/kawa "pelt"
begintsuglyph("uni76AE",174);
  kanji.grthree.pelt;
  tsu_render;
endtsuglyph;

% bei/sara "dish"
begintsuglyph("uni76BF",191);
  kanji.grthree.dish;
  tsu_render;
endtsuglyph;

% hai/sakazuki "sake cup"
begintsuglyph("uni76C3",195);
  kanji.grten.sake_cup;
  tsu_render;
endtsuglyph;

% moku/me "eye"
begintsuglyph("uni76EE",238);
  kanji.grone.eye;
  tsu_render;
endtsuglyph;

% choku/nao multiple meanings including "straight" and "honesty"
% "The 'nao' in Naota is for honesty"
begintsuglyph("uni76F4",244);
  kanji.grtwo.straight;
  tsu_render;
endtsuglyph;

% sou/ai "mutual" but also "indication seen by fortune teller"
begintsuglyph("uni76F8",248);
  kanji.grthree.correlation;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
