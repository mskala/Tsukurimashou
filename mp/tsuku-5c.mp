%
% Unicode page 5C (Kanji) for Tsukurimashou
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

% AUTODEPS
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.rock =
  push_pbox_toexpand("kanji.grtwo.rock");
  build_kanji.level(build_kanji.tb(600,10)
    (build_kanji.sscale(xscaled 0.85)(kanji.grone.mountain))
    (kanji.grone.right));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.beach =
  push_pbox_toexpand("kanji.grthree.beach");
  build_kanji.level(build_kanji.tb(570,-60)
    (kanji.grone.mountain)
    (build_kanji.cliff_enclose(
      build_kanji.sscale(yscaled 0.85 shifted (0,-100))
        (kanji.grsix.dry))));
  expand_pbox;
enddef;

vardef kanji.grthree.bureau =
  push_pbox_toexpand("kanji.grthree.bureau");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (1.15,0.83) shifted (-30,-110))
      (kanji.grfive.phrase;set_bosize(-3,0)));
  expand_pbox;
enddef;

vardef kanji.grthree.house =
  push_pbox_toexpand("kanji.grthree.house");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.79,0.54) shifted (40,-150))
      (kanji.grsix.climax));
  expand_pbox;
enddef;

vardef kanji.grthree.island =
  push_pbox_toexpand("kanji.grthree.island");
  kanji.grtwo.bird;
  pop_stroke;pop_stroke;pop_stroke;pop_stroke;
  build_kanji.sscale(xyscaled (0.6,0.25) shifted (-200,-325))
    (kanji.grone.mountain);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.reside =
  push_pbox_toexpand("kanji.grfive.reside");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.77,0.72) shifted (30,-100))
      (kanji.grtwo.old));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.notify =
  push_pbox_toexpand("kanji.grsix.notify");
  build_kanji.level(
    kanji.radical.flag;
    build_kanji.sscale(xyscaled (0.77,0.54) shifted (30,-180))
      (kanji.grthree.reason));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.bend =
  push_pbox_toexpand("kanji.greight.bend");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.77,0.63) shifted (40,-130))
      (kanji.grone.go_away));
  expand_pbox;
enddef;

vardef kanji.greight.buttocks =
  push_pbox_toexpand("kanji.greight.buttocks");
  build_kanji.level(
    kanji.radical.flag;
    build_kanji.sscale(xyscaled (0.77,0.52) shifted (80,-170))
      (kanji.grone.nine));
  expand_pbox;
enddef;

vardef kanji.greight.hill =
  push_pbox_toexpand("kanji.greight.hill");
  kanji.radical.gmm;
  build_kanji.sscale(xyscaled (0.6,0.7))
    (build_kanji.level(build_kanji.tb(480,110)
       (kanji.toprad.sparkle_two)
       (kanji.grone.mountain;
        set_boserif(0,0,whatever);
        push_stroke((120,780)--(880,780),(1.6,1.6)--(1.6,1.6));
        set_boserif(0,1,9))));
  expand_pbox;
enddef;

vardef kanji.greight.tail =
  push_pbox_toexpand("kanji.greight.tail");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.79,0.63) shifted (40,-130))
      (kanji.grtwo.hair));
  expand_pbox;
enddef;

vardef kanji.greight.urine =
  push_pbox_toexpand("kanji.greight.urine");
  build_kanji.level(
    kanji.radical.flag;
    build_kanji.sscale(xyscaled (0.7,0.55) shifted (20,-200))
      (kanji.grone.water));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.chad =
  push_pbox_toexpand("kanji.grnine.chad");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.85,0.63) shifted (60,-130))
      (kanji.greight.resemblance));
  expand_pbox;
enddef;

vardef kanji.grnine.pointed =
  push_pbox_toexpand("kanji.grnine.pointed");
  build_kanji.tb(500,-20)
    (kanji.grone.small)
    (kanji.grone.big);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% not in dictionaries by itself, but appears as right of "professional"
begintsuglyph("uni5C03",3);
  kanji.rightrad.professional;
  tsu_render;
endtsuglyph;

% shuu/chii "small"
begintsuglyph("uni5C0F",15);
  kanji.grone.small;
  tsu_render;
endtsuglyph;

% sho/suko "little"
begintsuglyph("uni5C11",17);
  kanji.grtwo.little;
  tsu_render;
endtsuglyph;

% pointed
begintsuglyph("uni5C16",22);
  kanji.grnine.pointed;
  tsu_render;
endtsuglyph;

% extra "younger brother"
begintsuglyph("uni5C17",23);
  build_kanji.level(build_kanji.tb(570,80)
    (kanji.grone.up)
    (kanji.grone.small;set_boserif(-1,0,whatever)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5C18",24);
  build_kanji.tb(500,-20)
    (kanji.grone.small)
    (kanji.grone.earth);
  tsu_render;
endtsuglyph;

% gyou/taka "high" as in mountain
begintsuglyph("uni5C2D",45);
  kanji.grnine.mountain_high;
  tsu_render;
endtsuglyph;

% shi/katashiro "corpse" or "flag radial"
begintsuglyph("uni5C38",56);
  kanji.radical.flag;
  tsu_render;
endtsuglyph;

% in/osa "a particular official rank"
begintsuglyph("uni5C39",57);
  kanji.rare.director;
  tsu_render;
endtsuglyph;

% shaku "foot (unit of measure)," "bamboo flute," or "blowjob"
begintsuglyph("uni5C3A",58);
  kanji.grsix.blowjob;
  tsu_render;
endtsuglyph;

% kou/shiri "buttocks"
begintsuglyph("uni5C3B",59);
  kanji.greight.buttocks;
  tsu_render;
endtsuglyph;

% ni/ama "nun"
begintsuglyph("uni5C3C",60);
  kanji.greight.nun;
  tsu_render;
endtsuglyph;

% bi/o "tail"
begintsuglyph("uni5C3E",62);
  kanji.greight.tail;
  tsu_render;
endtsuglyph;

% nyou "urine"
begintsuglyph("uni5C3F",63);
  kanji.greight.urine;
  tsu_render;
endtsuglyph;

% kyoku/tsubone "bureau"
begintsuglyph("uni5C40",64);
  kanji.grthree.bureau;
  tsu_render;
endtsuglyph;

% extra "fart"
begintsuglyph("uni5C41",65);
  build_kanji.level(
    kanji.radical.flag;
    build_kanji.sscale(xyscaled (0.68,0.52) shifted (40,-170))
      (kanji.grfive.compare));
  tsu_render;
endtsuglyph;

% kyo/i "reside"
begintsuglyph("uni5C45",69);
  kanji.grfive.reside;
  tsu_render;
endtsuglyph;

% kutsu/kaga "bend"
begintsuglyph("uni5C48",72);
  kanji.greight.bend;
  tsu_render;
endtsuglyph;

% kai/todo "notify"
begintsuglyph("uni5C4A",74);
  kanji.grsix.notify;
  tsu_render;
endtsuglyph;

% oku/ya "house"
begintsuglyph("uni5C4B",75);
  kanji.grthree.house;
  tsu_render;
endtsuglyph;

% extra "shit"
begintsuglyph("uni5C4E",78);
  build_kanji.level(
    kanji.radical.flag;
    build_kanji.sscale(xyscaled (0.7,0.55) shifted (20,-200))
      (kanji.grtwo.rice));
  tsu_render;
endtsuglyph;

% extra "fence"
begintsuglyph("uni5C4F",79);
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.77,0.68) shifted (40,-100))
      (kanji.rare.merger));
  tsu_render;
endtsuglyph;

% setsu/kuzu "chad"
begintsuglyph("uni5C51",81);
  kanji.grnine.chad;
  tsu_render;
endtsuglyph;

% extra "exerting strength, in aikido"
begintsuglyph("uni5C53",83);
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.77,0.62) shifted (40,-150))
      (kanji.grone.shell));
  tsu_render;
endtsuglyph;

% extra "slaughter"
begintsuglyph("uni5C60",96);
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.72,0.66) shifted (40,-120))
      (kanji.grthree.person));
  tsu_render;
endtsuglyph;

% yama/san "mountain"
begintsuglyph("uni5C71",113);
  kanji.grone.mountain;
  tsu_render;
endtsuglyph;

% kou/oka "hill"
begintsuglyph("uni5CA1",161);
  kanji.greight.hill;
  tsu_render;
endtsuglyph;

% gan/iwa "rock"
begintsuglyph("uni5CA9",169);
  kanji.grtwo.rock;
  tsu_render;
endtsuglyph;

% gan/kishi "beach"
begintsuglyph("uni5CB8",184);
  kanji.grthree.beach;
  tsu_render;
endtsuglyph;

% tou/shima "island"
begintsuglyph("uni5CF6",246);
  kanji.grthree.island;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
