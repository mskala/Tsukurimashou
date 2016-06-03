%
% Unicode page 67 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2014, 2016  Matthew Skala
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
input rightrad.mp;
input toprad.mp;

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

vardef kanji.grfour.full_moon =
  push_pbox_toexpand("kanji.grfour.full_moon");
  build_kanji.tb(340,-20)
    (build_kanji.lr(480,10)
       (build_kanji.sscale(xyscaled (0.95,0.85) shifted (0,60))
          (kanji.grsix.dead))
       (kanji.grone.moon))
    (kanji.grone.king);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.article =
  push_pbox_toexpand("kanji.grfive.article");
  build_kanji.level(build_kanji.tb(420,20+30*mincho)
    (kanji.radical.winter)
    (kanji.grone.wood));
  expand_pbox;
enddef;

vardef kanji.grfive.branch =
  push_pbox_toexpand("kanji.grfive.branch");
  build_kanji.lr(480,10)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.94)(kanji.grfive.support));
  expand_pbox;
enddef;

vardef kanji.grfive.inspection =
  push_pbox_toexpand("kanji.grfive.inspection");
  build_kanji.level(build_kanji.tb(420,60)
    (kanji.grone.wood)
    (kanji.greight.furthermore));
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

vardef kanji.grsix.table =
  push_pbox_toexpand("kanji.grsix.table");
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.radical.windy);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.analyse =
  push_pbox_toexpand("kanji.greight.analyse");
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.greight.axe);
  expand_pbox;
enddef;

vardef kanji.greight.cedar =
  push_pbox_toexpand("kanji.greight.cedar");
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.93)(kanji.rightrad.short_hair));
  expand_pbox;
enddef;

vardef kanji.greight.design =
  push_pbox_toexpand("kanji.greight.design");
  build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (kanji.greight.third);
  expand_pbox;
enddef;

vardef kanji.greight.die_in_obscurity =
  push_pbox_toexpand("kanji.greight.die_in_obscurity");
  build_kanji.lr(480,40)
    (kanji.leftrad.wood)
    (kanji.rare.obstruction);
  expand_pbox;
enddef;

vardef kanji.greight.hinge =
  push_pbox_toexpand("kanji.greight.hinge");
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.9 shifted (0,20))(kanji.grthree.ward));
  expand_pbox;
enddef;

vardef kanji.greight.magnolia =
  push_pbox_toexpand("kanji.greight.magnolia");
  build_kanji.lr(480,80)
    (kanji.leftrad.wood)
    (kanji.grnine.divination);
  expand_pbox;
enddef;

vardef kanji.greight.persimmon =
  push_pbox_toexpand("kanji.greight.persimmon");
  build_kanji.lr(420,10)
    (kanji.leftrad.wood)
    (kanji.grtwo.market);
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

vardef kanji.greight.wither =
  push_pbox_toexpand("kanji.greight.wither");
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.old);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.citron =
  push_pbox_toexpand("kanji.grnine.citron");
  build_kanji.lr(390,30)
    (kanji.leftrad.wood)
    (kanji.grthree.reason);
  expand_pbox;
enddef;

vardef kanji.grnine.citrus =
  push_pbox_toexpand("kanji.grnine.citrus");
  build_kanji.lr(400,40)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,80) scaled 0.92)(kanji.greight.sweet));
  expand_pbox;
enddef;

vardef kanji.grnine.farmers_rake =
  push_pbox_toexpand("kanji.grnine.farmers_rake");
  build_kanji.lr(450,-10)
    (kanji.leftrad.wood)
    (kanji.grnine.tomoe);
  expand_pbox;
enddef;

vardef kanji.grnine.grove =
  push_pbox_toexpand("kanji.grnine.grove");
  build_kanji.lr(440,60)
    (kanji.leftrad.wood)
    (kanji.grone.earth);
  expand_pbox;
enddef;

vardef kanji.grnine.holly =
  push_pbox_toexpand("kanji.grnine.holly");
  build_kanji.lr(430,-20)
    (kanji.leftrad.wood)
    (kanji.grtwo.winter);
  expand_pbox;
enddef;

vardef kanji.grnine.mulberry =
  push_pbox_toexpand("kanji.grnine.mulberry");
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grone.stone);
  expand_pbox;
enddef;

vardef kanji.grnine.oak =
  push_pbox_toexpand("kanji.grnine.oak");
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grone.white);
  expand_pbox;
enddef;

vardef kanji.grnine.pestle =
  push_pbox_toexpand("kanji.grnine.pestle");
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.noon);
  expand_pbox;
enddef;

vardef kanji.grnine.piling =
  push_pbox_toexpand("kanji.grnine.piling");
  build_kanji.lr(480,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.96)(kanji.rare.high_spirits));
  expand_pbox;
enddef;

vardef kanji.grnine.spindle_tree =
  push_pbox_toexpand("kanji.grnine.spindle_tree");
  build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (kanji.grone.correct);
  expand_pbox;
enddef;

vardef kanji.grnine.spoon =
  push_pbox_toexpand("kanji.grnine.spoon");
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grfive.compare);
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

% bou/nozo "full moon" (and many other things by analogy)
begintsuglyph("uni671B",27);
  kanji.grfour.full_moon;
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

% extra
begintsuglyph("uni6732",50);
  build_kanji.lr(480,60)
    (kanji.leftrad.wood)
    (kanji.grone.person);
  tsu_render;
endtsuglyph;

% hatsu/eburi "tree"
begintsuglyph("uni6733",51);
  build_kanji.lr(440,40)
    (kanji.leftrad.wood)
    (kanji.grone.eight);
  tsu_render;
endtsuglyph;

% boku/hou "magnolia" (or any of several other specific plants)
begintsuglyph("uni6734",52);
  kanji.greight.magnolia;
  tsu_render;
endtsuglyph;

% tou "type of tree"
begintsuglyph("uni6737",55);
  build_kanji.lr(460,40)
    (kanji.leftrad.wood)
    (kanji.grtwo.sword);
  tsu_render;
endtsuglyph;

% ryoku/oogo "carrying pole"
begintsuglyph("uni6738",56);
  build_kanji.lr(460,30)
    (kanji.leftrad.wood;
     replace_strokep(-2)(point 0 of oldp--point (1-0.12*mincho) of oldp))
    (kanji.grone.power);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6739",57);
  build_kanji.lr(440,30)
    (kanji.leftrad.wood)
    (kanji.grone.nine);
  tsu_render;
endtsuglyph;

% ki/tsukue "table"
begintsuglyph("uni673A",58);
  kanji.grsix.table;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni673C",60);
  build_kanji.lr(480,-10)
    (kanji.leftrad.wood)
    (kanji.radical.spoon);
  tsu_render;
endtsuglyph;

% kyuu/ku "die in obscurity"
begintsuglyph("uni673D",61);
  kanji.greight.die_in_obscurity;
  tsu_render;
endtsuglyph;

% tou/tsuku "to bump"
begintsuglyph("uni673E",62);
  build_kanji.lr(480,50)
    (kanji.leftrad.wood)
    (kanji.grthree.thumbtack);
  tsu_render;
endtsuglyph;

% iri "sluice"
begintsuglyph("uni6741",65);
  build_kanji.lr(480,80)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grone.put_it_in));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6743",67);
  build_kanji.lr(480,60)
    (kanji.leftrad.wood)
    (kanji.greight.otoh);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6744",68);
  build_kanji.lr(480,40)
    (kanji.leftrad.wood)
    (kanji.grone.one_thousand);
  tsu_render;
endtsuglyph;

% kan/teko "rod-shaped bacterium"
begintsuglyph("uni6746",70);
  build_kanji.lr(480,40)
    (kanji.leftrad.wood)
    (kanji.grsix.dry);
  tsu_render;
endtsuglyph;

% o/kote "loquat"
begintsuglyph("uni6747",71);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.rare.deficient);
  tsu_render;
endtsuglyph;

% san/sugi "cedar"
begintsuglyph("uni6749",73);
  kanji.greight.cedar;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni674A",74);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grone.river);
  tsu_render;
endtsuglyph;

% gotsu/kirikabu "stump"
begintsuglyph("uni674C",76);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.rare.bald);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni674D",77);
  build_kanji.lr(440,40)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.92)(kanji.grone.child));
  tsu_render;
endtsuglyph;

% zai/ki "lumber"
begintsuglyph("uni6750",80);
  kanji.grfour.lumber;
  tsu_render;
endtsuglyph;

% son/mura "village"
begintsuglyph("uni6751",81);
  kanji.grone.village;
  tsu_render;
endtsuglyph;

% shaku/hishaku "ladle"
begintsuglyph("uni6753",83);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grnine.ladle);
  tsu_render;
endtsuglyph;

% tei "alone"
begintsuglyph("uni6755",85);
  build_kanji.lr(480,50)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grone.big));
  tsu_render;
endtsuglyph;

% yoku/kui "piling"
begintsuglyph("uni6759",89);
  build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (kanji.radical.ceremony);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni675B",91);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.bow);
  tsu_render;
endtsuglyph;

% to/mori "grove"
begintsuglyph("uni675C",92);
  kanji.grnine.grove;
  tsu_render;
endtsuglyph;

% chi/magaki "tree"
begintsuglyph("uni675D",93);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grnine.to_be);
  tsu_render;
endtsuglyph;

% ki "river willow" (used in a word for anxiety)
begintsuglyph("uni675E",94);
  build_kanji.lr(480,-20)
    (kanji.leftrad.wood)
    (kanji.grsix.self);
  tsu_render;
endtsuglyph;

% soku/taba "bundle"
begintsuglyph("uni675F",95);
  kanji.grfour.bundle;
  tsu_render;
endtsuglyph;

% kou/chigiri "balance beam"
begintsuglyph("uni6760",96);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 1.14)(kanji.grtwo.craft));
  tsu_render;
endtsuglyph;

% jou/eda "article" (as a division of a document) etc.
begintsuglyph("uni6761",97);
  kanji.grfive.article;
  tsu_render;
endtsuglyph;

% soma "timber"
begintsuglyph("uni6763",99);
  build_kanji.lr(460,10)
    (kanji.leftrad.wood)
    (kanji.grone.mountain);
  tsu_render;
endtsuglyph;

% tochi "type of oak"
begintsuglyph("uni6764",100);
  build_kanji.lr(480,50-20*mincho)
    (kanji.leftrad.wood)
    (kanji.grtwo.myriad);
  tsu_render;
endtsuglyph;

% ku/rai "come"
begintsuglyph("uni6765",101);
  kanji.grtwo.come;
  tsu_render;
endtsuglyph;

% sugi (phonetic only)
begintsuglyph("uni6766",102);
  build_kanji.lr(480,50-30*mincho)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.96 shifted (0,-20))
       (kanji.grfive.long_time));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6767",103);
  build_kanji.lr(460,-20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,6))(kanji.grsix.dead));
  tsu_render;
endtsuglyph;

% byou/kozue "treetop"
begintsuglyph("uni676A",106);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.little);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni676B",107);
  build_kanji.lr(440,30)
    (kanji.leftrad.wood)
    (kanji.grtwo.cease);
  tsu_render;
endtsuglyph;

% gen/fujimotoki (phonetic only)
begintsuglyph("uni676C",108);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.origin);
  tsu_render;
endtsuglyph;

% kou/kui "piling"
begintsuglyph("uni676D",109);
  kanji.grnine.piling;
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

% ken/suki "water trough"
begintsuglyph("uni6774",116);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grfour.fail);
  tsu_render;
endtsuglyph;

% shou/kine "wooden pestle"
begintsuglyph("uni6775",117);
  kanji.grnine.pestle;
  tsu_render;
endtsuglyph;

% ha/tsuka "farmer's rake"
begintsuglyph("uni6777",119);
  kanji.grnine.farmers_rake;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6778",120);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.radical.windy_again);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6779",121);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grthree.change);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni677A",122);
  build_kanji.lr(460,-10)
    (kanji.leftrad.wood)
    (kanji.grtwo.heart);
  tsu_render;
endtsuglyph;

% cho/hi "shuttle" (of a loom)
begintsuglyph("uni677C",124);
  build_kanji.lr(480,60)
    (kanji.leftrad.wood)
    (kanji.grthree.before);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni677D",125);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled (0.94+0.06*mincho))(kanji.grone.hand));
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

% kyou/nigura "utmost"
begintsuglyph("uni6781",129);
  build_kanji.lr(480,30)
    (kanji.leftrad.wood)
    (kanji.greight.reach);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6782",130);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grone.moon);
  tsu_render;
endtsuglyph;

% kei/hijiki "rafter"
begintsuglyph("uni6785",133);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,20))(kanji.radical.topped_aitch));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6786",134);
  build_kanji.lr(460,10)
    (kanji.leftrad.wood)
    (kanji.grtwo.hair);
  tsu_render;
endtsuglyph;

% bi "spoon"
begintsuglyph("uni6787",135);
  kanji.grnine.spoon;
  tsu_render;
endtsuglyph;

% ou/mageru "bend crooked"
begintsuglyph("uni6789",137);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grone.king);
  tsu_render;
endtsuglyph;

% hou/ho "raft"
begintsuglyph("uni678B",139);
  build_kanji.lr(460,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.direction);
  tsu_render;
endtsuglyph;

% shou/matsu "pine tree"
begintsuglyph("uni678C",140);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.minute);
  tsu_render;
endtsuglyph;

% fu/shigeru (phonetic only)
begintsuglyph("uni678E",142);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grfour.husband));
  tsu_render;
endtsuglyph;

% seki "analyse"
begintsuglyph("uni6790",144);
  kanji.greight.analyse;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6792",146);
  build_kanji.lr(480,40)
    (kanji.leftrad.wood)
    (kanji.greight.tusk);
  tsu_render;
endtsuglyph;

% shu/hishaku "capital"
begintsuglyph("uni6793",147);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.greight.dipper);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6794",148);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.now);
  tsu_render;
endtsuglyph;

% you (phonetic only)
begintsuglyph("uni6796",150);
  build_kanji.lr(480,30)
    (kanji.leftrad.wood)
    (kanji.rare.early_death);
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

% shi/eda "branch"
begintsuglyph("uni679D",157);
  kanji.grfive.branch;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni679F",159);
  build_kanji.lr(440,40)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,40))(kanji.grnine.declaim));
  tsu_render;
endtsuglyph;

% suu/toboso "hinge"
begintsuglyph("uni67A2",162);
  kanji.greight.hinge;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67A4",164);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grone.dog);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67A5",165);
  build_kanji.lr(420,-10)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,30))
       (build_kanji.cliff_enclose(kanji.grone.power)));
  tsu_render;
endtsuglyph;

% ro/haze "wax tree"
begintsuglyph("uni67A6",166);
  build_kanji.lr(440,10)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,20))(kanji.grtwo.door));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67AE",174);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.divination);
  tsu_render;
endtsuglyph;

% ko/kareru "wither"
begintsuglyph("uni67AF",175);
  kanji.greight.wither;
  tsu_render;
endtsuglyph;

% hei/sugoroku "chessboard"
begintsuglyph("uni67B0",176);
  build_kanji.lr(420,40)
    (kanji.leftrad.wood)
    (kanji.grthree.level);
  tsu_render;
endtsuglyph;

% i/suki (phonetic only)
begintsuglyph("uni67B1",177);
  build_kanji.lr(440,30)
    (kanji.leftrad.wood)
    (kanji.grtwo.pedestal);
  tsu_render;
endtsuglyph;

% ki/karatachi "trifoliate orange tree"
begintsuglyph("uni67B3",179);
  build_kanji.lr(460,20)
    (kanji.leftrad.wood)
    (kanji.grnine.only);
  tsu_render;
endtsuglyph;

% kyou/utsuro "hollow tree stump"
begintsuglyph("uni67B5",181);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.number);
  tsu_render;
endtsuglyph;

% ka/kase "handcuffs"
begintsuglyph("uni67B7",183);
  build_kanji.lr(360,0)
    (kanji.leftrad.wood)
    (kanji.grfour.addition);
  tsu_render;
endtsuglyph;

% ku "quince tree"
begintsuglyph("uni67B8",184);
  build_kanji.lr(440,40)
    (kanji.leftrad.wood)
    (kanji.grfive.phrase);
  tsu_render;
endtsuglyph;

% fu/ho "gong stick"
begintsuglyph("uni67B9",185);
  build_kanji.lr(440,30)
    (kanji.leftrad.wood)
    (kanji.grfour.wrap);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67BA",186);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood;
     replace_strokep(-2)(subpath (0,0.85) of oldp))
    (build_kanji.sscale(yscaled 0.92)(kanji.grfour.tip));
  tsu_render;
endtsuglyph;

% ei/kai "long oar"
begintsuglyph("uni67BB",187);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grthree.world);
  tsu_render;
endtsuglyph;

% hi/sugi (phonetic only)
begintsuglyph("uni67C0",192);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grthree.pelt);
  tsu_render;
endtsuglyph;

% da/kaji "rudder"
begintsuglyph("uni67C1",193);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.rare.other);
  tsu_render;
endtsuglyph;

% rei "Eurya japonica (evergreen tree)"
begintsuglyph("uni67C3",195);
  build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.96 shifted (0,20))(kanji.grfour.orders));
  tsu_render;
endtsuglyph;

% hei/gara "design"
begintsuglyph("uni67C4",196);
  kanji.greight.design;
  tsu_render;
endtsuglyph;

% ji "flourish"
begintsuglyph("uni67C5",197);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.nun);
  tsu_render;
endtsuglyph;

% rou "bent tree"
begintsuglyph("uni67C6",198);
  build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (kanji.grone.stand_up);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67C7",199);
  build_kanji.lr(460,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,30))(kanji.grnine.two_branch_tree));
  tsu_render;
endtsuglyph;

% han/hachi "container"
begintsuglyph("uni67C8",200);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rightrad.half);
  tsu_render;
endtsuglyph;

% shu/hiiragi "holly"
begintsuglyph("uni67CA",202);
  kanji.grnine.holly;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67CC",204);
  build_kanji.lr(460,20)
    (kanji.leftrad.wood)
    (kanji.grfour.director);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67CD",205);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.centre);
  tsu_render;
endtsuglyph;

% fu/utena "calyx"
begintsuglyph("uni67CE",206);
  build_kanji.lr(420,10)
    (kanji.leftrad.wood)
    (kanji.grfour.attach);
  tsu_render;
endtsuglyph;

% haku/kashiwa "oak"
begintsuglyph("uni67CF",207);
  kanji.grnine.oak;
  tsu_render;
endtsuglyph;

% bou/soregashi "a certain" (person, or whatever)
begintsuglyph("uni67D0",208);
  kanji.greight.a_certain;
  tsu_render;
endtsuglyph;

% kon "citrus"
begintsuglyph("uni67D1",209);
  kanji.grnine.citrus;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67D6",214);
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.greight.call);
  tsu_render;
endtsuglyph;

% sha/so "mulberry"
begintsuglyph("uni67D8",216);
  kanji.grnine.mulberry;
  tsu_render;
endtsuglyph;

% yu/yuzu "citron"
begintsuglyph("uni67DA",218);
  kanji.grnine.citron;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67DB",219);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grthree.have_honour);
  tsu_render;
endtsuglyph;

% seku/hahaso "type of oak"
begintsuglyph("uni67DE",222);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.notwithstanding);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67DF",223);
  build_kanji.lr(440,60)
    (kanji.leftrad.wood;
     replace_strokep(0)(subpath (0,1.45) of oldp))
    (kanji.rare.terracotta);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67E0",224);
  build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (kanji.rare.bobbin);
  tsu_render;
endtsuglyph;

% tei/ne "root"
begintsuglyph("uni67E2",226);
  build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (kanji.rare.cruithne);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67E3",227);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.disappear);
  tsu_render;
endtsuglyph;

% sa/so "railing"
begintsuglyph("uni67E4",228);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.furthermore);
  tsu_render;
endtsuglyph;

% tan (phonetic only)
begintsuglyph("uni67E6",230);
  build_kanji.lr(460,20)
    (kanji.leftrad.wood)
    (kanji.greight.daybreak);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67E8",232);
  build_kanji.lr(430,0)
    (kanji.leftrad.wood)
    (kanji.grfive.cloth);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67EB",235);
  build_kanji.lr(380,-10)
    (kanji.leftrad.wood)
    (kanji.rare.dollar);
  tsu_render;
endtsuglyph;

% totsu "to cut"
begintsuglyph("uni67EE",238);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grone.go_away);
  tsu_render;
endtsuglyph;

% ka/e "axe handle"
begintsuglyph("uni67EF",239);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.passable);
  tsu_render;
endtsuglyph;

% chuu/hashira "pillar"
begintsuglyph("uni67F1",241);
  kanji.grthree.pillar;
  tsu_render;
endtsuglyph;

% hi/nigiri "axe handle" (syn. with 67EF above)
begintsuglyph("uni67F2",242);
  build_kanji.lr(390,-10)
    (kanji.leftrad.wood)
    (kanji.grfour.inevitable);
  tsu_render;
endtsuglyph;

% shi/saji "ladle"
begintsuglyph("uni67F6",246);
  build_kanji.lr(420,-20)
    (kanji.leftrad.wood)
    (kanji.grone.four);
  tsu_render;
endtsuglyph;

% shuku "instrument"
begintsuglyph("uni67F7",247);
  build_kanji.lr(460,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.big_brother);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67F8",248);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,40))(kanji.rare.glorious));
  tsu_render;
endtsuglyph;

% sa "inspection"
begintsuglyph("uni67FB",251);
  kanji.grfive.inspection;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni67FD",253);
  build_kanji.lr(460,10)
    (kanji.leftrad.wood)
    (kanji.rare.sacred);
  tsu_render;
endtsuglyph;

% masaki "Euonymus japonicus (spindle tree)"
begintsuglyph("uni67FE",254);
  kanji.grnine.spindle_tree;
  tsu_render;
endtsuglyph;

% shi/kaki "persimmon"
begintsuglyph("uni67FF",255);
  kanji.greight.persimmon;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
