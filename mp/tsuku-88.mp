%
% Unicode page 88 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2016  Matthew Skala
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
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.boulevard =
  push_pbox_toexpand("kanji.grfour.boulevard");
  build_kanji.go_enclose(400,10)
    (build_kanji.lift_skirt(250,100)(kanji.grnine.square_jewel));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.collide =
  push_pbox_toexpand("kanji.greight.collide");
  build_kanji.go_enclose(400,10)
    (kanji.leftrad.heap_big);
  expand_pbox;
enddef;

vardef kanji.greight.rend =
  push_pbox_toexpand("kanji.greight.rend");
  build_kanji.tb(420,70)
    (kanji.grthree.column)
    (kanji.grfour.clothes);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef build_kanji.go_enclose(expr w,o)(text inside) =
  push_pbox_toexpand("build_kanji.go_enclose");
  build_kanji.lcr(480-w/2-20,o)(480+w/2+20,o)
    (build_kanji.harmonic(240,0.86,50)(kanji.leftrad.person))
    (inside)
    (build_kanji.harmonic(240,0.86,50)(kanji.grthree.thumbtack));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ketsu/chi "blood"
begintsuglyph("uni8840",64);
  kanji.grthree.blood;
  tsu_render;
endtsuglyph;

% kou/i(ku) "go"
begintsuglyph("uni884C",76);
  kanji.grtwo.go;
  tsu_render;
endtsuglyph;

% extra: en/amari "overflow"
begintsuglyph("uni884D",77);
  build_kanji.go_enclose(400,40)(kanji.leftrad.water);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni884E",78);
  build_kanji.go_enclose(400,-10)(kanji.grsix.dry);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8855",85);
  build_kanji.go_enclose(440,-40)(kanji.grtwo.same);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8856",86);
  build_kanji.go_enclose(420,20)(kanji.grfour.together);
  tsu_render;
endtsuglyph;

% gai/machi "boulevard"
begintsuglyph("uni8857",87);
  kanji.grfour.boulevard;
  tsu_render;
endtsuglyph;

% extra: ga "government office"
begintsuglyph("uni8859",89);
  build_kanji.go_enclose(400,20)(kanji.grnine.my);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni885A",90);
  build_kanji.go_enclose(460,0)(kanji.grnine.barbarian);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni885C",92);
  build_kanji.go_enclose(400,0)(kanji.grtwo.neck);
  tsu_render;
endtsuglyph;

% shou/tsu "collide"
begintsuglyph("uni885D",93);
  kanji.greight.collide;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8860",96);
  build_kanji.go_enclose(420,20)(kanji.grthree.ingredient);
  tsu_render;
endtsuglyph;

% i/koromo "clothes"
begintsuglyph("uni8863",99);
  kanji.grfour.clothes;
  tsu_render;
endtsuglyph;

% extra "clothes left radical"
begintsuglyph("uni8864",100);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    ();
  tsu_render;
endtsuglyph;

% hyou/omote "surface"
begintsuglyph("uni8868",104);
  kanji.grthree.surface;
  tsu_render;
endtsuglyph;

% extra: sen "thin kimono"
begintsuglyph("uni886B",107);
  build_kanji.lr(450,40)
    (kanji.leftrad.clothes)
    (build_kanji.sscale(shifted (0,30))(kanji.rightrad.short_hair));
  tsu_render;
endtsuglyph;

% extra: dou/koromo "priestly vestaments"
begintsuglyph("uni8872",114);
  build_kanji.lr(450,0)
    (kanji.leftrad.clothes)
    (kanji.grtwo.home);
  tsu_render;
endtsuglyph;

% extra: jitsu/akume "everyday clothing"
begintsuglyph("uni8875",117);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    (build_kanji.sscale(shifted (0,-20))(kanji.grone.day));
  tsu_render;
endtsuglyph;

% extra: jin/kokube "gusset"
begintsuglyph("uni887D",125);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    (build_kanji.sscale(shifted (0,-20))(kanji.grnine.ninth));
  tsu_render;
endtsuglyph;

% :kanjivg.eids:<\X887F>[lr]\X8864<\X4ECA>[tb]\X4EBA(anything)
% grnine.neck

% extra: bei/tamato "sleeve"
begintsuglyph("uni8882",130);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    (kanji.rare.decide);
  tsu_render;
endtsuglyph;

% extra: tan/katanu "baring the shoulder"
begintsuglyph("uni8892",146);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    (kanji.greight.daybreak);
  tsu_render;
endtsuglyph;

% :kanjivg.eids:<\X8896>[lr]\X8864\X7531
% greight.sleeve

% extra: han "summer kimono"
% not quite right - this code is Chinese style, needs slant dir change
% begintsuglyph("uni88A2",162);
%   build_kanji.level(build_kanji.lr(450,20)
%     (kanji.leftrad.clothes)
%     (kanji.grtwo.half));
%   tsu_render;
% endtsuglyph;

% :kanjivg.eids:<\X88AB>[lr]\X8864\X76AE
% greight.brood_over

% extra: fuku "cloth wrapper"
begintsuglyph("uni88B1",177);
  build_kanji.lr(380,-10)
    (kanji.leftrad.clothes)
    (kanji.greight.prostrate);
  tsu_render;
endtsuglyph;

% extra: jin/kokubi "gusset"
begintsuglyph("uni88B5",181);
  build_kanji.lr(380,-10)
    (kanji.leftrad.clothes)
    (kanji.grfive.responsibility);
  tsu_render;
endtsuglyph;

% extra: kou/awase "lined kimono"
begintsuglyph("uni88B7",183);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    (kanji.grtwo.join);
  tsu_render;
endtsuglyph;

% extra: kei/uchiki "Heian Period court clothing"
begintsuglyph("uni88BF",191);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    (kanji.grnine.square_jewel);
  tsu_render;
endtsuglyph;

% retsu/sa "rend"
begintsuglyph("uni88C2",194);
  kanji.greight.rend;
  tsu_render;
endtsuglyph;

% extra: yuki "sleeve length"
begintsuglyph("uni88C4",196);
  build_kanji.lr(380,-10)
    (kanji.leftrad.clothes)
    (kanji.grtwo.go);
  tsu_render;
endtsuglyph;

% :kanjivg.eids:<\X88D5>[lr]\X8864<\X8C37>[tb](anything)(anything)
% greight.abundant

% extra: kun/mosuso "underwear"
begintsuglyph("uni88D9",217);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    (kanji.grthree.junior);
  tsu_render;
endtsuglyph;

% :kanjivg.eids:<\X88E1>[lr]\X8864\X91CC
% grnine.reverse

% :kanjivg.eids:<\X88F8>[lr]\X8864\X679C
% greight.nude

% extra: seki/hadanu "bare the shoulder"
begintsuglyph("uni88FC",252);
  build_kanji.lr(450,20)
    (kanji.leftrad.clothes)
    (kanji.grfive.easy);
  tsu_render;
endtsuglyph;

% :kanjivg.eids:<\X88FE>[lr]\X8864<\X5C45>[wrapul]\X5C38<\X53E4>[tb]\X5341\X53E3
% greight.cuff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
