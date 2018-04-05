%
% Unicode page 68 (Kanji) for Tsukurimashou
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
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.forest =
  push_pbox_toexpand("kanji.grone.forest");
  build_kanji.tb(500,100)
    (kanji.grone.wood)
    (build_kanji.lr(480,0)
       (kanji.leftrad.wood)
       (kanji.grone.wood));
  expand_pbox;
enddef;

vardef kanji.grone.school =
  push_pbox_toexpand("kanji.grone.school");
  build_kanji.lr(480,30)
    (kanji.leftrad.wood)
    (kanji.grtwo.mix);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.root =
  push_pbox_toexpand("kanji.grthree.root");
  build_kanji.lr(440,70)
    (kanji.leftrad.wood)
    (kanji.radical.northeast);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.machine =
  push_pbox_toexpand("kanji.grfour.machine");
  build_kanji.lr(370,40)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,30))(kanji.greight.precept));
  expand_pbox;
enddef;

vardef kanji.grfour.plan =
  push_pbox_toexpand("kanji.grfour.plan");
  build_kanji.tb(320,10)
    (kanji.grthree.easy)
    (kanji.grone.wood);
  expand_pbox;
enddef;

vardef kanji.grfour.plum =
  push_pbox_toexpand("kanji.grfour.plum");
  build_kanji.lr(370,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.every);
  expand_pbox;
enddef;

vardef kanji.grfour.prosperity =
  push_pbox_toexpand("kanji.grfour.prosperity");
  build_kanji.tb(740,100)
    (kanji.toprad.alt_sparkle_three)
    (build_kanji.tb(580,180)
       (kanji.radical.conservative_hat)
       (kanji.grone.wood));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.sakura =
  push_pbox_toexpand("kanji.grfive.sakura");
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (build_kanji.tb(520,40-20*mincho)
       (build_kanji.sscale(xyscaled (1.25,0.7))
          (kanji.toprad.alt_sparkle_three))
       (kanji.grone.woman)));
  expand_pbox;
enddef;

vardef kanji.grfive.rank =
  push_pbox_toexpand("kanji.grfive.rank");
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (kanji.grfour.every);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.coffin =
  push_pbox_toexpand("kanji.greight.coffin");
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (kanji.grfour.bureaucracy);
  expand_pbox;
enddef;

vardef kanji.greight.girder =
  push_pbox_toexpand("kanji.greight.girder");
  build_kanji.lr(380,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.go);
  expand_pbox;
enddef;

vardef kanji.greight.go_game =
  push_pbox_toexpand("kanji.greight.go_game");
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (kanji.grnine.that);
  expand_pbox;
enddef;

vardef kanji.greight.infarction =
  push_pbox_toexpand("kanji.greight.infarction");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.night_watch);
  expand_pbox;
enddef;

vardef kanji.greight.peach =
  push_pbox_toexpand("kanji.greight.peach");
  build_kanji.lr(360,0)
    (kanji.leftrad.wood)
    (kanji.grfour.portent);
  expand_pbox;
enddef;

vardef kanji.greight.ridgepole =
  push_pbox_toexpand("kanji.greight.ridgepole");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.east);
  expand_pbox;
enddef;

vardef kanji.greight.stopper =
  push_pbox_toexpand("kanji.greight.stopper");
  build_kanji.level(build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grthree.complete));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.bellflower =
  push_pbox_toexpand("kanji.grnine.bellflower");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.good_luck);
  expand_pbox;
enddef;

vardef kanji.grnine.bucket =
  push_pbox_toexpand("kanji.grnine.bucket");
  build_kanji.lr(420,10)
    (kanji.leftrad.wood)
    (kanji.rare.walled_road);
  expand_pbox;
enddef;

vardef kanji.grnine.catalpa =
  push_pbox_toexpand("kanji.grnine.catalpa");
  build_kanji.lr(400,-20)
    (kanji.leftrad.wood)
    (kanji.greight.acrid);
  expand_pbox;
enddef;

vardef kanji.grnine.chinese_parasol_tree =
  push_pbox_toexpand("kanji.grnine.chinese_parasol_tree");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.my);
  expand_pbox;
enddef;

vardef kanji.grnine.cypress =
  push_pbox_toexpand("kanji.grnine.cypress");
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.meet);
  expand_pbox;
enddef;

vardef kanji.grnine.judas_tree =
  push_pbox_toexpand("kanji.grnine.judas_tree");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.square_jewel);
  expand_pbox;
enddef;

vardef kanji.grnine.ladder =
  push_pbox_toexpand("kanji.grnine.ladder");
  build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.little_brother);
  expand_pbox;
enddef;

vardef kanji.grnine.nest =
  push_pbox_toexpand("kanji.grnine.nest");
  build_kanji.lr(420,-10)
    (kanji.leftrad.wood)
    (kanji.grtwo.west);
  expand_pbox;
enddef;

vardef kanji.grnine.rudder =
  push_pbox_toexpand("kanji.grnine.rudder");
  build_kanji.lr(410,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 1.04)(kanji.greight.tail));
  expand_pbox;
enddef;

vardef kanji.grnine.twig =
  push_pbox_toexpand("kanji.grnine.twig");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.resemblance);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tsuga "hemlock tree"
begintsuglyph("uni6802",2);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.mother);
  tsu_render;
endtsuglyph;

% ei/saka "prosperity"
begintsuglyph("uni6804",4);
  kanji.grfour.prosperity;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6807",7);
  build_kanji.lr(460,30)
    (kanji.leftrad.wood)
    (kanji.grfive.showing);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6808",8);
  build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,30))
       (kanji.radical.three_tasselled_spear;
        obstacktype[find_whatever(otstroke,-2)]:=otnull;
        replace_strokep(-2)(oldp shifted (0,-60));
        replace_strokep(-4)(oldp shifted (0,-90))));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni680D",13);
  build_kanji.lr(400,30)
    (kanji.leftrad.wood)
    (kanji.grone.life);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6810",16);
  build_kanji.lr(390,40)
    (kanji.leftrad.wood)
    (kanji.grfive.long);
  tsu_render;
endtsuglyph;

% sen "stopper"
begintsuglyph("uni6813",19);
  kanji.greight.stopper;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6815",21);
  build_kanji.lr(420,-30)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.91)(kanji.grfour.vassal));
  tsu_render;
endtsuglyph;

% sei/sumu "nest"
begintsuglyph("uni6816",22);
  kanji.grnine.nest;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6818",24);
  build_kanji.level(build_kanji.lr(400,10)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.94)(kanji.grtwo.many)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni681B",27);
  build_kanji.level(build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (build_kanji.tricluster(0.85)
       (kanji.grone.power)
       (kanji.grone.power)
       (kanji.grone.power)));
  tsu_render;
endtsuglyph;

% ten/takigi "builder's measuring frame"
begintsuglyph("uni681D",29);
  build_kanji.lr(420,-20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.95 shifted (0,-20))(kanji.grfive.tongue));
  tsu_render;
endtsuglyph;

% hei "hemp palm"
begintsuglyph("uni681F",31);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.merger);
  tsu_render;
endtsuglyph;

% kou "school"
begintsuglyph("uni6821",33);
  kanji.grone.school;
  tsu_render;
endtsuglyph;

% haku/kashiwa "oak"
begintsuglyph("uni6822",34);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grone.hundred);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6823",35);
  build_kanji.level(build_kanji.lr(370,20)
    (kanji.leftrad.wood)
    (kanji.grfive.responsibility));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6826",38);
  build_kanji.level(build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grthree.province));
  tsu_render;
endtsuglyph;

% setsu/taru (phonetic only)
begintsuglyph("uni6828",40);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.next);
  tsu_render;
endtsuglyph;

% ku/kunugi "roof shingle"
begintsuglyph("uni6829",41);
  build_kanji.lr(420,10)
    (kanji.leftrad.wood)
    (kanji.grtwo.feather);
  tsu_render;
endtsuglyph;

% sen "weir"
begintsuglyph("uni682B",43);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grsix.exist);
  tsu_render;
endtsuglyph;

% sei/chiisanakui (phonetic only)
begintsuglyph("uni682C",44);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.colour);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni682E",46);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grone.ear);
  tsu_render;
endtsuglyph;

% iku (phonetic only)
begintsuglyph("uni682F",47);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (kanji.grthree.existence);
  tsu_render;
endtsuglyph;

% hatsu/ikada "bamboo raft"
begintsuglyph("uni6830",48);
  build_kanji.level(build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.greight.strike));
  tsu_render;
endtsuglyph;

% kyou/kui "large peg"
begintsuglyph("uni6831",49);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.94)(kanji.grfour.together));
  tsu_render;
endtsuglyph;

% kou/kae "cloth made from mulberry-tree fibre"
begintsuglyph("uni6832",50);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.94 shifted(0,-20))(kanji.grtwo.consider));
  tsu_render;
endtsuglyph;

% kou "basket"
begintsuglyph("uni6833",51);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.94 shifted (0,-20))(kanji.grfour.old_man));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6835",53);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grthree.column);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6836",54);
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.88)(kanji.grfive.cause));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6837",55);
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (kanji.grthree.sheep);
  tsu_render;
endtsuglyph;

% kon/ne "root"
begintsuglyph("uni6839",57);
  kanji.grthree.root;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni683A",58);
  build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (kanji.greight.glutamate);
  tsu_render;
endtsuglyph;

% choku "tree"
begintsuglyph("uni683B",59);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grthree.formula);
  tsu_render;
endtsuglyph;

% kaku/itaru "rank"
begintsuglyph("uni683C",60);
  kanji.grfive.rank;
  tsu_render;
endtsuglyph;

% fuku/hari (phonetic only)
begintsuglyph("uni683F",63);
  build_kanji.lr(390,10)
    (kanji.leftrad.wood)
    (kanji.greight.prostrate);
  tsu_render;
endtsuglyph;

% kou/keta "girder"
begintsuglyph("uni6841",65);
  kanji.greight.girder;
  tsu_render;
endtsuglyph;

% kei/katsura "Japanese Judas-tree"
begintsuglyph("uni6842",66);
  kanji.grnine.judas_tree;
  tsu_render;
endtsuglyph;

% tou/momo "peach"
begintsuglyph("uni6843",67);
  kanji.greight.peach;
  tsu_render;
endtsuglyph;

% kou/yokogi "coir-palm"
begintsuglyph("uni6844",68);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.shine);
  tsu_render;
endtsuglyph;

% kyou/kamachi "framework"
begintsuglyph("uni6846",70);
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.92)(kanji.grnine.deliverance));
  tsu_render;
endtsuglyph;

% an/tsukue "plan"
begintsuglyph("uni6848",72);
  kanji.grfour.plan;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6849",73);
  build_kanji.lr(390,0)
    (kanji.leftrad.wood)
    (kanji.grthree.easy);
  tsu_render;
endtsuglyph;

% shitsu/ashikase "fetters"
begintsuglyph("uni684E",78);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grsix.climax);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6850",80);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.same);
  tsu_render;
endtsuglyph;

% kitsu/ki "used in the name of a bellflower"
begintsuglyph("uni6854",84);
  kanji.grnine.bellflower;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6856",86);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grthree.blood);
  tsu_render;
endtsuglyph;

% tsui/tsuchi phonetic only
begintsuglyph("uni6858",88);
  build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,30))(kanji.rare.mound));
  tsu_render;
endtsuglyph;

% u/hoko "halberd"
begintsuglyph("uni6859",89);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.moo);
  tsu_render;
endtsuglyph;

% ou/sakura "cherry blossom"
begintsuglyph("uni685C",92);
  kanji.grfive.sakura;
  tsu_render;
endtsuglyph;

% tou "bookshelf"
begintsuglyph("uni6863",99);
  build_kanji.level(build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.hit));
  tsu_render;
endtsuglyph;

% kai/hinoki "cypress"
begintsuglyph("uni6867",103);
  kanji.grnine.cypress;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6869",105);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grnine.manor);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni686D",109);
  build_kanji.lr(390,20)
    (kanji.leftrad.wood)
    (kanji.grnine.dragon_sign);
  tsu_render;
endtsuglyph;

% hai/sakazuki "drinking cup"
begintsuglyph("uni686E",110);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grsix.noes);
  tsu_render;
endtsuglyph;

% fu/bachi "drumstick"
begintsuglyph("uni6874",116);
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (build_kanji.tb(580,0)
       (kanji.toprad.paw)
       (kanji.grone.child)));
  tsu_render;
endtsuglyph;

% zui/tara (phonetic only)
begintsuglyph("uni6875",117);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.greight.compromise);
  tsu_render;
endtsuglyph;

% you/oke "bucket"
begintsuglyph("uni6876",118);
  kanji.grnine.bucket;
  tsu_render;
endtsuglyph;

% kaku/taruki "crabapple"
begintsuglyph("uni6877",119);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.corner);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6878",120);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grfour.rarity);
  tsu_render;
endtsuglyph;

% rou "palm"
begintsuglyph("uni6879",121);
  build_kanji.lr(400,60)
    (kanji.leftrad.wood)
    (kanji.grfour.good);
  tsu_render;
endtsuglyph;

% kun "type of fruit tree"
begintsuglyph("uni687E",126);
  build_kanji.lr(400,-10)
    (kanji.leftrad.wood)
    (kanji.grthree.junior);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6880",128);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.bundle);
  tsu_render;
endtsuglyph;

% kyuu/nominosaki "evergreen cone"
begintsuglyph("uni6882",130);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (kanji.grfour.request);
  tsu_render;
endtsuglyph;

% chou/teko "lever"
begintsuglyph("uni6883",131);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.greight.court);
  tsu_render;
endtsuglyph;

% you/yaku "to lay in stores of firewood"
begintsuglyph("uni6884",132);
  build_kanji.lr(400,10)
    (kanji.leftrad.wood)
    (kanji.grnine.bird_sign);
  tsu_render;
endtsuglyph;

% bai/ume "plum"
begintsuglyph("uni6885",133);
  kanji.grfour.plum;
  tsu_render;
endtsuglyph;

% hou/kidetsukutsutaooyumi (phonetic only)
begintsuglyph("uni6888",136);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.undergo);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni688C",140);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grfive.surplus);
  tsu_render;
endtsuglyph;

% koku/tekase "manacles"
begintsuglyph("uni688F",143);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.revelation);
  tsu_render;
endtsuglyph;

% shi/azusa "catalpa"
begintsuglyph("uni6893",147);
  kanji.grnine.catalpa;
  tsu_render;
endtsuglyph;

% hai "palm tree"
begintsuglyph("uni6896",150);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grone.shell);
  tsu_render;
endtsuglyph;

% kou/fusagu "infarction"
begintsuglyph("uni6897",151);
  kanji.greight.infarction;
  tsu_render;
endtsuglyph;

% ken/sen "bamboo tube"
begintsuglyph("uni6898",152);
  build_kanji.lr(440,40)
    (kanji.leftrad.wood)
    (kanji.grone.see);
  tsu_render;
endtsuglyph;

% ban (phonetic only)
begintsuglyph("uni689A",154);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.greight.dismiss);
  tsu_render;
endtsuglyph;

% ro/hisashi "a kind of quince"
begintsuglyph("uni68A0",160);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.spine);
  tsu_render;
endtsuglyph;

% kan/manaita "tray for carrying sacrificial meat"
begintsuglyph("uni68A1",161);
  build_kanji.lr(410,0)
    (kanji.leftrad.wood)
    (kanji.grfour.perfect);
  tsu_render;
endtsuglyph;

% shou/kozue "twig"
begintsuglyph("uni68A2",162);
  kanji.grnine.twig;
  tsu_render;
endtsuglyph;

% go/aogiri "Chinese parasol tree"
begintsuglyph("uni68A7",167);
  kanji.grnine.chinese_parasol_tree;
  tsu_render;
endtsuglyph;

% ri/suki "hod"
begintsuglyph("uni68A9",169);
  build_kanji.lr(440,10)
    (kanji.leftrad.wood)
    (kanji.grtwo.neighbourhood);
  tsu_render;
endtsuglyph;

% hou/takatsuki (phonetic only)
begintsuglyph("uni68AA",170);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (tsu_xform(identity yscaled 0.94)(kanji.grthree.bean));
  tsu_render;
endtsuglyph;

% kiku/zen "snowshoe"
begintsuglyph("uni68AE",174);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.bureau);
  tsu_render;
endtsuglyph;

% tei/hashigo "ladder"
begintsuglyph("uni68AF",175);
  kanji.grnine.ladder;
  tsu_render;
endtsuglyph;

% kai/kase "machine"
begintsuglyph("uni68B0",176);
  kanji.grfour.machine;
  tsu_render;
endtsuglyph;

% kon/kouru "pack up"
begintsuglyph("uni68B1",177);
  build_kanji.lr(400,-20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grsix.bothered));
  tsu_render;
endtsuglyph;

% so/toku "comb hair"
begintsuglyph("uni68B3",179);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.uncultivated);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68B4",180);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grsix.prolong);
  tsu_render;
endtsuglyph;

% bi/kaji "rudder"
begintsuglyph("uni68B6",182);
  kanji.grnine.rudder;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68B8",184);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grfour.advantage);
  tsu_render;
endtsuglyph;

% hin "areca nut"
begintsuglyph("uni68B9",185);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.soldier);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68BD",189);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.intention);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68BE",190);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.come);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68C1",193);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.cash);
  tsu_render;
endtsuglyph;

% rin "camphor tree"
begintsuglyph("uni68C6",198);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.rare.be_methodical);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68C7",199);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.rare.be_flustered);
  tsu_render;
endtsuglyph;

% ki/go "go (board game)"
begintsuglyph("uni68CB",203);
  kanji.greight.go_game;
  tsu_render;
endtsuglyph;

% sai/kunugi (phonetic only)
begintsuglyph("uni68CC",204);
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.greight.dice));
  tsu_render;
endtsuglyph;

% hai/ikada "raft"
begintsuglyph("uni68D1",209);
  build_kanji.lr(390,0)
    (kanji.leftrad.wood)
    (kanji.grfive.mistake);
  tsu_render;
endtsuglyph;

% shu "hemp palm"
begintsuglyph("uni68D5",213);
  build_kanji.lr(400,-10)
    (kanji.leftrad.wood)
    (kanji.grsix.religion);
  tsu_render;
endtsuglyph;

% tou/hashira "door jamb"
begintsuglyph("uni68D6",214);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.long);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68DB",219);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.raise);
  tsu_render;
endtsuglyph;

% ko/nezumiotoshi (phonetic only)
begintsuglyph("uni68DD",221);
  build_kanji.lr(400,-20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grfour.hard));
  tsu_render;
endtsuglyph;

% tou/mune "ridgepole"
begintsuglyph("uni68DF",223);
  kanji.greight.ridgepole;
  tsu_render;
endtsuglyph;

% kou "mast crossbeam"
begintsuglyph("uni68E1",225);
  build_kanji.lr(380,10)
    (kanji.leftrad.wood)
    (kanji.greight.hill);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68E4",228);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.once_upon_a_time);
  tsu_render;
endtsuglyph;

% en "tree"
begintsuglyph("uni68EA",234);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.inflammation);
  tsu_render;
endtsuglyph;

% eki/nemunoki (phonetic only)
begintsuglyph("uni68ED",237);
  build_kanji.lr(380,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.evening);
  tsu_render;
endtsuglyph;

% shin/mori "forest"
begintsuglyph("uni68EE",238);
  kanji.grone.forest;
  tsu_render;
endtsuglyph;

% nen "type of fruit tree"
begintsuglyph("uni68EF",239);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.care);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68F4",244);
  build_kanji.lr(370,20)
    (kanji.leftrad.wood)
    (kanji.grthree.clothing);
  tsu_render;
endtsuglyph;

% kan/kigire "numerary adjunct for trees"
begintsuglyph("uni68F5",245);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.fruit);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni68F7",247);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,30))(kanji.grthree.take));
  tsu_render;
endtsuglyph;

% kan "coffin"
begintsuglyph("uni68FA",250);
  kanji.greight.coffin;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
