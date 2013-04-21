%
% Unicode page 67 (Kanji) for Tsukurimashou
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
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
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

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.village =
  push_pbox_toexpand("kanji.grone.village");
  build_kanji.lr(480,0)
    (kanji.leftrad.wood)
    (kanji.grsix.inch);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.clothing =
  push_pbox_toexpand("kanji.grthree.clothing");
  build_kanji.level(build_kanji.lr(480,20)
    (kanji.grone.moon)
    (kanji.rightrad.clothing));
  expand_pbox;
enddef;

vardef kanji.grthree.pillar =
  push_pbox_toexpand("kanji.grthree.pillar");
  build_kanji.lr(480,-10)
    (kanji.leftrad.wood)
    (kanji.grthree.master);
  expand_pbox;
enddef;

vardef kanji.grthree.plank =
  push_pbox_toexpand("kanji.grthree.plank");
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grthree.anti);
  expand_pbox;
enddef;

vardef kanji.grthree.term =
  push_pbox_toexpand("kanji.grthree.term");
  build_kanji.lr(580,-10)
    (build_kanji.sscale(yscaled 0.96)(kanji.grnine.that))
    (kanji.grone.moon);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.banknote =
  push_pbox_toexpand("kanji.grfour.banknote");
  build_kanji.lr(540+20*mincho,-30)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.94)(kanji.rare.mysterious));
  expand_pbox;
enddef;

vardef kanji.grfour.lumber =
  push_pbox_toexpand("kanji.grfour.lumber");
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.rightrad.genius);
  expand_pbox;
enddef;

vardef kanji.grfour.pine =
  push_pbox_toexpand("kanji.grfour.pine");
  build_kanji.lr(480,20)
    (build_kanji.sscale(yscaled 1.07)(kanji.leftrad.wood))
    (kanji.grtwo.public);
  expand_pbox;
enddef;

vardef kanji.grfour.tip =
  push_pbox_toexpand("kanji.grfour.tip");
  kanji.grfour.not_yet;
  replace_strokep(-3)((70,610)--(930,610));
  replace_strokep(-4)((160,360)--(840,360));
  expand_pbox;
enddef;

vardef kanji.grfour.utmost =
  push_pbox_toexpand("kanji.grfour.utmost");
  build_kanji.tb(500,-20)
    (build_kanji.sscale(xscaled 0.9)(kanji.grone.day))
    (build_kanji.lr(470,40)
       (kanji.grone.ear)
       (tsu_xform(identity yscaled 0.74 shifted (0,-40))
          (kanji.greight.otoh));
     replace_strokep(-7)
       (point 0 of oldp--(point 0 of oldp xscaled -1 shifted (1000,0))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.sheet =
  push_pbox_toexpand("kanji.grsix.sheet");
  build_kanji.lr(480,110)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.96)(kanji.radical.folding_chair));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.die_in_obscurity =
  push_pbox_toexpand("kanji.greight.die_in_obscurity");
  build_kanji.lr(480,40)
    (kanji.leftrad.wood)
    (kanji.rare.obstruction);
  expand_pbox;
enddef;

vardef kanji.greight.sake_cup =
  push_pbox_toexpand("kanji.greight.sake_cup");
  build_kanji.lr(480,50)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,-60))(kanji.grfour.non));
  replace_strokep(-1)(subpath (0,0.85) of oldp);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sai/motto "utmost"
begintsuglyph("uni6700",0);
  kanji.grfour.utmost;
  tsu_render;
endtsuglyph;

% tsuki/getsu "moon"
begintsuglyph("uni6708",8);
  kanji.grone.moon;
  tsu_render;
endtsuglyph;

% yuu/a "to have"
begintsuglyph("uni6709",9);
  kanji.grthree.existence;
  tsu_render;
endtsuglyph;

% fuku as in "sailor fuku"
begintsuglyph("uni670D",13);
  kanji.grthree.clothing;
  tsu_render;
endtsuglyph;

% chou/asa "morning"
begintsuglyph("uni671D",29);
  kanji.grtwo.morning;
  tsu_render;
endtsuglyph;

% ki "term" (limited time)
begintsuglyph("uni671F",31);
  kanji.grthree.term;
  tsu_render;
endtsuglyph;

% ki "wood"
begintsuglyph("uni6728",40);
  kanji.grone.wood;
  tsu_render;
endtsuglyph;

% mi/ima "not yet", also zodiac sign of the ram
begintsuglyph("uni672A",42);
  kanji.grfour.not_yet;
  tsu_render;
endtsuglyph;

% matsu/sue "tip"
begintsuglyph("uni672B",43);
  kanji.grfour.tip;
  tsu_render;
endtsuglyph;

% hon "book"
begintsuglyph("uni672C",44);
  kanji.grone.book;
  tsu_render;
endtsuglyph;

% setsu/fuda "banknote"
begintsuglyph("uni672D",45);
  kanji.grfour.banknote;
  tsu_render;
endtsuglyph;

% kyuu/ku "die in obscurity"
begintsuglyph("uni673D",61);
  kanji.greight.die_in_obscurity;
  tsu_render;
endtsuglyph;

% son/mura "village"
begintsuglyph("uni6751",81);
  kanji.grone.village;
  tsu_render;
endtsuglyph;

% zai/ki "lumber"
begintsuglyph("uni6750",80);
  kanji.grfour.lumber;
  tsu_render;
endtsuglyph;

% soku/taba "bundle"
begintsuglyph("uni675F",95);
  kanji.grfour.bundle;
  tsu_render;
endtsuglyph;

% ku/rai "come"
begintsuglyph("uni6765",101);
  kanji.grtwo.come;
  tsu_render;
endtsuglyph;

% hai/sakazuki "sake cup"
begintsuglyph("uni676F",111);
  kanji.greight.sake_cup;
  tsu_render;
endtsuglyph;

% tou/higashi "east"
begintsuglyph("uni6771",113);
  kanji.grtwo.east;
  tsu_render;
endtsuglyph;

% shou/matsu "pine"
begintsuglyph("uni677E",126);
  kanji.grfour.pine;
  tsu_render;
endtsuglyph;

% han/ita "plank"
begintsuglyph("uni677F",127);
  kanji.grthree.plank;
  tsu_render;
endtsuglyph;

% rin/hayashi "grove"
begintsuglyph("uni6797",151);
  kanji.grone.grove;
  tsu_render;
endtsuglyph;

% mai "sheet" (counter for thin flat things)
begintsuglyph("uni679A",154);
  kanji.grsix.sheet;
  tsu_render;
endtsuglyph;

% ka/ha "fruit" or "result"
begintsuglyph("uni679C",156);
  kanji.grfour.fruit;
  tsu_render;
endtsuglyph;

% bou/soregashi "a certain" (person, or whatever)
begintsuglyph("uni67D0",208);
  kanji.greight.a_certain;
  tsu_render;
endtsuglyph;

% chuu/hashira "pillar"
begintsuglyph("uni67F1",241);
  kanji.grthree.pillar;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
