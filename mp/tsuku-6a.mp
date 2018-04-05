%
% Unicode page 6A (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2016, 2017  Matthew Skala
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
input bottomrad.mp;
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
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.bridge =
  push_pbox_toexpand("kanji.grthree.bridge");
  build_kanji.lr(380,30)
    (build_kanji.sscale(yscaled 1.11)(kanji.leftrad.wood))
    (kanji.grnine.boast);
  expand_pbox;
enddef;

vardef kanji.grthree.sideways =
  push_pbox_toexpand("kanji.grthree.sideways");
  build_kanji.lr(380,30)
    (build_kanji.sscale(yscaled 1.11)(kanji.leftrad.wood))
    (kanji.grtwo.yellow);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.aircraft =
  push_pbox_toexpand("kanji.grfour.aircraft");
  build_kanji.lr(380,50)
    (kanji.leftrad.wood)
    (kanji.greight.how_much);
  expand_pbox;
enddef;

vardef kanji.grfour.symbol =
  push_pbox_toexpand("kanji.grfour.symbol");
  build_kanji.lr(380,50)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.86)(kanji.grfour.ticket));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.bitter_orange =
  push_pbox_toexpand("kanji.grnine.bitter_orange");
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grthree.climb);
  expand_pbox;
enddef;

vardef kanji.grnine.camphor =
  push_pbox_toexpand("kanji.grnine.camphor");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.chapter);
  expand_pbox;
enddef;

vardef kanji.grnine.comb =
  push_pbox_toexpand("kanji.grnine.comb");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.section);
  expand_pbox;
enddef;

vardef kanji.grnine.downspout =
  push_pbox_toexpand("kanji.grnine.downspout");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.traffic);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extra
begintsuglyph("uni6A00",0);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.stalk);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A08",8);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.finally);
  tsu_render;
endtsuglyph;

% tou/hi "downspout"
begintsuglyph("uni6A0B",11);
  kanji.grnine.downspout;
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.traffic);
 tsu_render;
endtsuglyph;

% extra:  kan "grove"
begintsuglyph("uni6A0C",12);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.sushi_counter);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A0D",13);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.blame);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A0E",14);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.inn);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A18",24);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.hall);
  tsu_render;
endtsuglyph;

% hyou/shirobe "symbol"
begintsuglyph("uni6A19",25);
  kanji.grfour.symbol;
  tsu_render;
endtsuglyph;

% shou/kusu "camphor"
begintsuglyph("uni6A1F",31);
  kanji.grnine.camphor;
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.chapter);
  tsu_render;
endtsuglyph;

% extra:  to/tsuta "type of bird/vine"
begintsuglyph("uni6A22",34);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.bird);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A27",39);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.kill);
  tsu_render;
endtsuglyph;

% ou/yoku "sideways"
begintsuglyph("uni6A2A",42);
  kanji.grthree.sideways;
  tsu_render;
endtsuglyph;

% extra:  tara "no meaning given"
begintsuglyph("uni6A30",48);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.snow);
  tsu_render;
endtsuglyph;

% extra:  sai/fushi "knot in wood"
begintsuglyph("uni6A36",54);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.utmost);
  tsu_render;
endtsuglyph;

% extra:  muku/kohada "bark of tree"
begintsuglyph("uni6A38",56);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.rare.eight_three_dee_zero);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A3C",60);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.rare.steep);
  tsu_render;
endtsuglyph;

% extra:  bo/kata "beech tree"
begintsuglyph("uni6A45",69);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grfour.nothing);
  tsu_render;
endtsuglyph;

% kyou/hashi "bridge"
begintsuglyph("uni6A4B",75);
  kanji.grthree.bridge;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A4C",76);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (build_kanji.gate_enclose(kanji.grone.moon));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A4D",77);
  build_kanji.lr(340,20)
    (kanji.leftrad.wood)
    (kanji.grnine.leap_year);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A4E",78);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.ordinal);
  tsu_render;
endtsuglyph;

% extra:  "wood streaks"
begintsuglyph("uni6A52",82);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.cloud);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A57",87);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grnine.moe);
  tsu_render;
endtsuglyph;

% tou/daidai "bitter orange"
begintsuglyph("uni6A59",89);
  kanji.grnine.bitter_orange;
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grthree.climb);
  tsu_render;
endtsuglyph;

% ki/hata "aircraft"
begintsuglyph("uni6A5F",95);
  kanji.grfour.aircraft;
  tsu_render;
endtsuglyph;

% shou/tochi "horse chestnut"
begintsuglyph("uni6A61",97);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.elephant);
  tsu_render;
endtsuglyph;

% shu "pole"
begintsuglyph("uni6A66",102);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.child);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A68",104);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.decorate);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A6A",106);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.that_case);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A6E",110);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.trade);
  tsu_render;
endtsuglyph;

% ki "Japanese storax"
begintsuglyph("uni6A72",114);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.pleasure);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A73",115);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.victory);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A75",117);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.loose);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A7A",122);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.interval);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A7D",125);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.plural);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A82",130);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.farming);
  tsu_render;
endtsuglyph;

% oku/i "evergreen oak"
begintsuglyph("uni6A8D",141);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.intention);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A8F",143);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.business);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A98",152);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.punish);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6A9B",155);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.pass);
  tsu_render;
endtsuglyph;

% kai/matsuyani "oak"
begintsuglyph("uni6A9E",158);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.solve);
  tsu_render;
endtsuglyph;

% extra: ka/hisagi "small evergreen shrub"
begintsuglyph("uni6A9F",159);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.tradesman);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6AA4",164);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.street);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6AA5",165);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.righteousness);
  tsu_render;
endtsuglyph;

% extra: reki/kunugi "oak used for charcoal"
begintsuglyph("uni6AAA",170);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.fun);
  tsu_render;
endtsuglyph;

% extra satsu/shinbashira "sassafras tzumu" and a Buddhist technical term
begintsuglyph("uni6AAB",171);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.guess);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6AAD",173);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.silver);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6AC7",199);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.extremely);
  tsu_render;
endtsuglyph;

% extra yuu/na "kind of hoe"
begintsuglyph("uni6ACC",204);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.melancholy);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6ACD",205);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.quality);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6AD5",213);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.approve);
  tsu_render;
endtsuglyph;

% shitsu/kushi "comb"
begintsuglyph("uni6ADB",219);
  kanji.grnine.comb;
  tsu_render;
endtsuglyph;

% extra sou/kashi "oak"
begintsuglyph("uni6AE7",231);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grsix.various);
  tsu_render;
endtsuglyph;

% extra shin/hitsugi "coffin" or "tung tree"
begintsuglyph("uni6AEC",236);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.parent);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
