%
% Unicode page 91 (Kanji) for Tsukurimashou
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
input gradeeight.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.plains =
  push_pbox_toexpand("kanji.grtwo.plains");
  build_kanji.level(build_kanji.lr(520,50)
    (build_kanji.lift_skirt(250,150)(kanji.grtwo.neighbourhood))
    (kanji.grthree.before));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.alcohol =
  push_pbox_toexpand("kanji.grthree.alcohol");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grnine.bird_sign);
  expand_pbox;
enddef;

vardef kanji.grthree.distribute =
  push_pbox_toexpand("kanji.grthree.distribute");
  build_kanji.lr(520,-20)
    (build_kanji.sscale(yscaled 0.96)(kanji.grnine.bird_sign))
    (kanji.grsix.self);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.quantity =
  push_pbox_toexpand("kanji.grfour.quantity");
  build_kanji.level(build_kanji.tb(460,-60)
   (kanji.greight.daybreak;
    replace_strokep(0)(oldp shifted (0,-70)))
   (kanji.grtwo.neighbourhood));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.bartending =
  push_pbox_toexpand("kanji.greight.bartending");
  build_kanji.lr(520,0)
    (kanji.grnine.bird_sign)
    (kanji.grnine.ladle);
  expand_pbox;
enddef;

vardef kanji.greight.dice =
  push_pbox_toexpand("kanji.greight.dice");
  build_kanji.level(build_kanji.tb(540,40)
    (kanji.toprad.paw)
    (kanji.grone.wood));
  expand_pbox;
enddef;

vardef kanji.greight.shochu =
  push_pbox_toexpand("kanji.greight.shochu");
  build_kanji.lr(520,10)
    (kanji.grnine.bird_sign)
    (kanji.grsix.inch);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.bird_sign =
  push_pbox_toexpand("kanji.grnine.bird_sign");
  build_kanji.thickness(0.93)(
    push_stroke((120,770)--(880,770),(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
    build_kanji.sscale(xyscaled (0.7,0.6) shifted (0,145))
      (kanji.radical.legs);
    build_kanji.box((180,560),(820,0));
    push_stroke((180,180)--(820,180),(1.5,1.5)--(1.5,1.5)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% yuu/tori "sign of the bird" (or "sake radical")
begintsuglyph("uni9149",73);
  kanji.grnine.bird_sign;
  tsu_render;
endtsuglyph;

% extra "intoxication"
begintsuglyph("uni914A",74);
  build_kanji.lr(520,-20)
    (kanji.grnine.bird_sign)
    (kanji.grthree.thumbtack);
  tsu_render;
endtsuglyph;

% shaku/ku "bartending"
begintsuglyph("uni914C",76);
  kanji.greight.bartending;
  tsu_render;
endtsuglyph;

% hai/kuba "distribute"
begintsuglyph("uni914D",77);
  kanji.grthree.distribute;
  tsu_render;
endtsuglyph;

% chu/kamo "shochu" (chuu as in chuu-hai)
begintsuglyph("uni914E",78);
  kanji.greight.shochu;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni914F",79);
  build_kanji.lr(480,-20)
    (kanji.grnine.bird_sign)
    (tsu_xform(identity shifted (0,-20))(kanji.grnine.to_be));
  tsu_render;
endtsuglyph;

% shu/sake "alcoholic drink"
begintsuglyph("uni9152",82);
  kanji.grthree.alcohol;
  tsu_render;
endtsuglyph;

% han/irodori "separate" or "divide" but mostly "topped rice radical"
begintsuglyph("uni91C6",198);
  build_kanji.add_beret(kanji.grtwo.rice);
  tsu_render;
endtsuglyph;

% sai/to "die" (macro name is plural for disambiguation)
begintsuglyph("uni91C7",199);
  kanji.greight.dice;
  tsu_render;
endtsuglyph;

% ri/sato, multiple meanings including 3.929km and "neighbourhood"
begintsuglyph("uni91CC",204);
  kanji.grtwo.neighbourhood;
  tsu_render;
endtsuglyph;

% shuu/e "heap big"
begintsuglyph("uni91CD",205);
  kanji.grthree.heap_big;
  tsu_render;
endtsuglyph;

% ya/no "field"
begintsuglyph("uni91CE",206);
  kanji.grtwo.plains;
  tsu_render;
endtsuglyph;

% ryou/haka "quantity"
begintsuglyph("uni91CF",207);
  kanji.grfour.quantity;
  tsu_render;
endtsuglyph;

% kane/kin "gold"
begintsuglyph("uni91D1",209);
  kanji.grone.gold;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
