%
% Unicode page 69 (Kanji) for Tsukurimashou
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
input buildkanji.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this is "sama," the honorific, also "you" as in "you ni"
vardef kanji.grthree.appearance =
  push_pbox_toexpand("kanji.grthree.appearance");
  build_kanji.lr(420,60)
    (kanji.leftrad.wood)
    (build_kanji.level(build_kanji.sscale(yscaled 0.95)(
       build_kanji.tb(420,240)
         (build_kanji.sscale(shifted (10,0))(kanji.grthree.sheep))
         (kanji.radical.alt_water);
       replace_strokep(-4)
         ((point 0 of get_strokep(-5))--subpath (1,infinity) of oldp);
       set_boserif(-4,0,whatever);
       set_bosize(-5,0))));
  expand_pbox;
enddef;

vardef kanji.grthree.business =
  push_pbox_toexpand("kanji.grthree.business");
  build_kanji.tb(620,0)
    (kanji.rare.obscure_grass_toprad)
    (kanji.radical.three_tailed_sheep);
  expand_pbox;
enddef;

vardef kanji.grthree.plant =
  push_pbox_toexpand("kanji.grthree.plant");
  build_kanji.lr(380,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.straight);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.extreme =
  push_pbox_toexpand("kanji.grfour.extreme");
  build_kanji.lr(380,30)
    (kanji.leftrad.wood)
    (kanji.rare.extremely);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.radical.three_tailed_sheep =
  push_pbox_toexpand("kanji.radical.three_tailed_sheep");
  kanji.grthree.sheep;
  push_stroke(
    (510,615){down}..(500,260)..(370,70)..{curl 0.5}(50,-60),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke(((get_strokep(0) intersectionpoint get_strokep(-4))+(50,0))..
      (650,80)..(900,-50),
    (1.1,1.1)--(1.4,1.4)--(1.7,1.7));
  replace_strokep(-1)(subpath
    (xpart (oldp intersectiontimes get_strokep(-5)),infinity) of oldp);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% shoku/u "plant"
begintsuglyph("uni690D",13);
  kanji.grthree.plant;
  tsu_render;
endtsuglyph;

% kyou/waza "business"
begintsuglyph("uni696D",109);
  kanji.grthree.business;
  tsu_render;
endtsuglyph;

% kyoku/kiwa "extreme"
begintsuglyph("uni6975",117);
  kanji.grfour.extreme;
  tsu_render;
endtsuglyph;

% gaku/tano "music" or "fun"
begintsuglyph("uni697D",125);
  kanji.grtwo.fun;
  tsu_render;
endtsuglyph;

% hanzou "container for pouring water"
begintsuglyph("uni697E",126);
  build_kanji.lr(480,30)
    (kanji.leftrad.wood)
    (kanji.grsix.fountain);
  tsu_render;
endtsuglyph;

% you/sama "honorific suffix with difficult literal meaning"
begintsuglyph("uni69D8",216);
  kanji.grthree.appearance;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
