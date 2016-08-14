%
% Unicode page 69 (Kanji) for Tsukurimashou
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

vardef kanji.grfive.posture =
  push_pbox_toexpand("kanji.grfive.posture");
  build_kanji.lr(380,30)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.95)(kanji.rare.inner_palace));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.chair =
  push_pbox_toexpand("kanji.greight.chair");
  build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (kanji.greight.strange);
  expand_pbox;
enddef;

vardef kanji.greight.chinquapin =
  push_pbox_toexpand("kanji.greight.chinquapin");
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.93)(kanji.radical.old_bird));
  expand_pbox;
enddef;

vardef kanji.greight.generally =
  push_pbox_toexpand("kanji.greight.generally");
  build_kanji.lr(350,50)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 1.08)(kanji.greight.already));
  expand_pbox;
enddef;

vardef kanji.greight.square_style =
  push_pbox_toexpand("kanji.greight.square_style");
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.greight.everybody);
  expand_pbox;
enddef;

vardef kanji.greight.watchtower =
  push_pbox_toexpand("kanji.greight.watchtower");
  build_kanji.level(build_kanji.lr(410,10)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.96)(build_kanji.tb(380,-30)
       (kanji.grtwo.rice)
       (kanji.grone.woman))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.autumn_foliage =
  push_pbox_toexpand("kanji.grnine.autumn_foliage");
  build_kanji.level(build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grone.flower)));
  expand_pbox;
enddef;

vardef kanji.grnine.camellia =
  push_pbox_toexpand("kanji.grnine.camellia");
  build_kanji.lr(380,40)
    (kanji.leftrad.wood)
    (kanji.grtwo.spring);
  expand_pbox;
enddef;

vardef kanji.grnine.camphor_tree =
  push_pbox_toexpand("kanji.grnine.camphor_tree");
  build_kanji.lr(400,10)
    (kanji.leftrad.wood)
    (kanji.grtwo.south);
  expand_pbox;
enddef;

vardef kanji.grnine.hackberry =
  push_pbox_toexpand("kanji.grnine.hackberry");
  build_kanji.lr(440,30)
    (kanji.leftrad.wood)
    (kanji.grtwo.summer);
  expand_pbox;
enddef;

vardef kanji.grnine.hammer =
  push_pbox_toexpand("kanji.grnine.hammer");
  build_kanji.lr(380,40)
    (kanji.leftrad.wood)
    (kanji.grthree.pursue);
  expand_pbox;
enddef;

vardef kanji.grnine.maple =
  push_pbox_toexpand("kanji.grnine.maple");
  build_kanji.lr(350,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,20))(kanji.grtwo.wind));
  expand_pbox;
enddef;

vardef kanji.grnine.sakaki =
  push_pbox_toexpand("kanji.grnine.sakaki");
  build_kanji.lr(350,30)
    (build_kanji.sscale(yscaled 0.94)(kanji.leftrad.wood))
    (kanji.grthree.deity);
  expand_pbox;
enddef;

vardef kanji.grnine.spear =
  push_pbox_toexpand("kanji.grnine.spear");
  build_kanji.lr(410,20)
    (kanji.leftrad.wood)
    (kanji.grfour.warehouse);
  expand_pbox;
enddef;

vardef kanji.grnine.starling =
  push_pbox_toexpand("kanji.grnine.starling");
  build_kanji.lr(430,30)
    (kanji.leftrad.wood)
    (kanji.grtwo.capital);
  expand_pbox;
enddef;

vardef kanji.grnine.willow =
  push_pbox_toexpand("kanji.grnine.willow");
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.sun);
  expand_pbox;
enddef;

vardef kanji.grnine.yew_plum_pine =
  push_pbox_toexpand("kanji.grnine.yew_plum_pine");
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (kanji.grthree.truth);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extra:  kaku "outer box for a coffin"
begintsuglyph("uni6901",1);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.undergo);
  tsu_render;
endtsuglyph;

% extra:  i "chair"
begintsuglyph("uni6905",5);
  kanji.greight.chair;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6906",6);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grfour.circuit);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6907",7);
  build_kanji.level(build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.94)(kanji.grthree.ingredient)));
  tsu_render;
endtsuglyph;

% extra:  sotsu "to fit a handle into a socket"
begintsuglyph("uni690A",10);
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (kanji.grfour.graduate));
  tsu_render;
endtsuglyph;

% ryou/muku "grey starling"
begintsuglyph("uni690B",11);
  kanji.grnine.starling;
  tsu_render;
endtsuglyph;

% extra:  kou "type of ancient musical instrument"
begintsuglyph("uni690C",12);
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,-50))(kanji.grone.sky));
  tsu_render;
endtsuglyph;

% shoku/u "plant"
begintsuglyph("uni690D",13);
  kanji.grthree.plant;
  tsu_render;
endtsuglyph;

% tsui/tsuchi "chinquapin" (apparently a type of tree)
begintsuglyph("uni690E",14);
  kanji.greight.chinquapin;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6910",16);
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grfive.reside));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6917",23);
  build_kanji.lr(400,10)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.94)(kanji.grthree.regular));
  tsu_render;
endtsuglyph;

% extra:  sugi "Japanese cedar"
begintsuglyph("uni6919",25);
  build_kanji.lr(400,40)
    (kanji.leftrad.wood)
    (kanji.grnine.prosperity);
  tsu_render;
endtsuglyph;

% extra:  kunugi "sawtooth oak"
begintsuglyph("uni691A",26);
  build_kanji.lr(360,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grtwo.gate));
  tsu_render;
endtsuglyph;

% kaba "autumn foliage"
begintsuglyph("uni691B",27);
  kanji.grnine.autumn_foliage;
  tsu_render;
endtsuglyph;

% extra:  kai/soko "type of oak tree"
begintsuglyph("uni6922",34);
  build_kanji.lr(360,10)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.94)(kanji.grtwo.country));
  tsu_render;
endtsuglyph;

% extra:  shide "hornbeam" (type of tree; also Shinto paper streamer)
begintsuglyph("uni6923",35);
  build_kanji.lr(380,0)
    (kanji.leftrad.wood)
    (kanji.grfour.rule);
  tsu_render;
endtsuglyph;

% extra:  nagi "type of evergreen tree"
begintsuglyph("uni6925",37);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.know);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6927",39);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grthree.decree);
  tsu_render;
endtsuglyph;

% extra:  tabu "type of laurel tree"
begintsuglyph("uni6928",40);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grfour.urban_prefecture);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni692E",46);
  build_kanji.level(build_kanji.lr(380,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.90 shifted (0,30))
       (kanji.grfour.participate)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6937",55);
  build_kanji.lr(320,20)
    (kanji.leftrad.wood)
    (kanji.rare.the_same);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni693A",58);
  build_kanji.lr(340,20)
    (kanji.leftrad.wood)
    (kanji.grfive.protect);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni693C",60);
  build_kanji.lr(340,20)
    (kanji.leftrad.wood)
    (build_kanji.go_enclose(400,40)(kanji.leftrad.water));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni693E",62);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.before);
  tsu_render;
endtsuglyph;

% chin/tsubaki "camellia"
begintsuglyph("uni693F",63);
  kanji.grnine.camellia;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6941",65);
  build_kanji.lr(400,10)
    (kanji.leftrad.wood)
    (kanji.grthree.guest);
  tsu_render;
endtsuglyph;

% extra:  se/ikada "raft"
begintsuglyph("uni6942",66);
  build_kanji.lr(420,40)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.96)(kanji.grfive.inspection));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6943",67);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 1.03)(kanji.grthree.house));
  tsu_render;
endtsuglyph;

% extra:  hyuku "guard"
begintsuglyph("uni6945",69);
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,20))(kanji.rare.roll_of_cloth)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6946",70);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grfour.essential);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6947",71);
  build_kanji.lr(340,10)
    (kanji.leftrad.wood)
    (kanji.rare.crooked_mouth);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6949",73);
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (kanji.grsix.young_master));
  tsu_render;
endtsuglyph;

% you/yanagi "willow"
begintsuglyph("uni694A",74);
  kanji.grnine.willow;
  tsu_render;
endtsuglyph;

% extra:  kon/kara "peg"
begintsuglyph("uni694E",78);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.army);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6950",80);
  build_kanji.lr(420,30)
    (kanji.leftrad.wood)
    (kanji.grthree.realm);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6952",82);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.think);
  tsu_render;
endtsuglyph;

% fuu/kaede "maple"
begintsuglyph("uni6953",83);
  kanji.grnine.maple;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6956",86);
  build_kanji.lr(360,30)
    (kanji.leftrad.wood)
    (kanji.greight.instant);
  tsu_render;
endtsuglyph;

% extra:  ken/kannuki "bar of door"
begintsuglyph("uni6957",87);
  build_kanji.lr(380,0)
    (kanji.leftrad.wood)
    (kanji.grfour.build);
  tsu_render;
endtsuglyph;

% extra:  ko "coarse"
begintsuglyph("uni695B",91);
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grthree.suffering));
  tsu_render;
endtsuglyph;

% extra:  ko/kurumi "pepper"
begintsuglyph("uni695C",92);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grnine.barbarian);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni695F",95);
  build_kanji.level(build_kanji.lr(410,-10)
    (kanji.leftrad.wood)
    (kanji.greight.head_of_household));
  tsu_render;
endtsuglyph;

% nan/kusu "camphor tree"
begintsuglyph("uni6960",96);
  kanji.grnine.camphor_tree;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6964",100);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (build_kanji.level(build_kanji.tb(420,50)
      (kanji.radical.crossed_must_not)
      (kanji.bottomrad.heart)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6967",103);
  build_kanji.lr(420,10)
    (kanji.leftrad.wood)
    (kanji.grfour.english);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6968",104);
  build_kanji.lr(440,30)
    (kanji.leftrad.wood)
    (kanji.greight.chastity);
  tsu_render;
endtsuglyph;

% extra:  tei/nezumimochi "hardwood"
begintsuglyph("uni6969",105);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.convenience);
  tsu_render;
endtsuglyph;

% kyou/waza "business"
begintsuglyph("uni696D",109);
  kanji.grthree.business;
  tsu_render;
endtsuglyph;

% extra:  cho/kouzo "paper mulberry"
begintsuglyph("uni696E",110);
  build_kanji.level(build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (kanji.grthree.person));
  tsu_render;
endtsuglyph;

% extra:  bai/ume "plum"
begintsuglyph("uni6973",115);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.greight.a_certain);
  tsu_render;
endtsuglyph;

% kyoku/kiwa "extreme"
begintsuglyph("uni6975",117);
  kanji.grfour.extreme;
  tsu_render;
endtsuglyph;

% kai "square character style"
begintsuglyph("uni6977",119);
  kanji.greight.square_style;
  tsu_render;
endtsuglyph;

% extra:  shuu/kisasage "Japanese catalpa"
begintsuglyph("uni6978",120);
  build_kanji.level(build_kanji.lr(370,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,20))(kanji.grtwo.autumn)));
  tsu_render;
endtsuglyph;

% extra:  kou/hatazao
begintsuglyph("uni697B",123);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grsix.emperor);
  tsu_render;
endtsuglyph;

% rou/takadono "watchtower"
begintsuglyph("uni697C",124);
  kanji.greight.watchtower;
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

% extra:  komai
begintsuglyph("uni6980",128);
  build_kanji.lr(340,10)
    (kanji.leftrad.wood)
    (kanji.grthree.goods);
  tsu_render;
endtsuglyph;

% extra:  muro "needle juniper"
begintsuglyph("uni6981",129);
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.chamber));
  tsu_render;
endtsuglyph;

% gai/oomune "generally"
begintsuglyph("uni6982",130);
  kanji.greight.generally;
  tsu_render;
endtsuglyph;

% sakaki "sakaki"
begintsuglyph("uni698A",138);
  kanji.grnine.sakaki;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni698C",140);
  build_kanji.lr(340,40)
    (kanji.leftrad.wood)
    (kanji.grfour.fly);
  tsu_render;
endtsuglyph;

% extra:  zetsu
begintsuglyph("uni698D",141);
  build_kanji.lr(350,30)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 1.08)(kanji.grnine.chad));
  tsu_render;
endtsuglyph;

% ka/enoki "hackberry"
begintsuglyph("uni698E",142);
  kanji.grnine.hackberry;
  tsu_render;
endtsuglyph;

% extra:  fu/kure "unbarked lumber"
begintsuglyph("uni6991",145);
  build_kanji.lr(440,30)
    (kanji.leftrad.wood;
     replace_strokep(0)(subpath (0,1.6) of oldp);
     replace_strokeq(0)(subpath (0,1.6) of oldq))
    (kanji.rightrad.professional);
  tsu_render;
endtsuglyph;

% extra:  daku
begintsuglyph("uni6992",146);
  build_kanji.level(build_kanji.lr(370,20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 1.06 shifted (0,30))(kanji.grtwo.weak)));
  tsu_render;
endtsuglyph;

% extra:  you/akou "evergreen mulberry"
begintsuglyph("uni6995",149);
  build_kanji.lr(390,-20)
    (kanji.leftrad.wood)
    (kanji.grfive.face);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni699E",158);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.field);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69A2",162);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.house);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69AA",170);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.horse);
  tsu_render;
endtsuglyph;

% extra:  shi/tatsu
begintsuglyph("uni69AF",175);
  build_kanji.lr(340,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.time);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69B3",179);
  build_kanji.lr(340+30*mincho,20-30*mincho)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 1.04 shifted (0,30))
       (kanji.grthree.courtyard));
  tsu_render;
endtsuglyph;

% extra:  ryuu/zakuro "pomegranate" (also fragmentation weapon)
begintsuglyph("uni69B4",180);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grfive.detain);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69B5",181);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (build_kanji.tb(600,30)
       (kanji.toprad.grass)
       (kanji.grone.ear));
  tsu_render;
endtsuglyph;

% extra:  kou/kareru "die (vegatation)"
begintsuglyph("uni69C1",193);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.high);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69C2",194);
  build_kanji.lr(350,40)
    (kanji.leftrad.wood)
    (kanji.grfour.grandchild);
  tsu_render;
endtsuglyph;

% kou/kama "posture" or "construction"
begintsuglyph("uni69CB",203);
  kanji.grfive.posture;
  tsu_render;
endtsuglyph;

% tsui/tsuchi "hammer"
begintsuglyph("uni69CC",204);
  kanji.grnine.hammer;
  tsu_render;
endtsuglyph;

% sou/yari "spear"
begintsuglyph("uni69CD",205);
  kanji.grnine.spear;
  tsu_render;
endtsuglyph;

% extra:  sa/ikada "raft" or "cut slantwise"
begintsuglyph("uni69CE",206);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.difference);
  tsu_render;
endtsuglyph;

% extra:  kou/teko "level" (or a specific thing in Mah Jong)
begintsuglyph("uni69D3",211);
  build_kanji.lr(420,0)
    (build_kanji.sscale(shifted (0,-20))(kanji.leftrad.wood))
    (kanji.greight.tribute);
  tsu_render;
endtsuglyph;

% you/sama "honorific suffix with difficult literal meaning"
begintsuglyph("uni69D8",216);
  kanji.grthree.appearance;
  tsu_render;
endtsuglyph;

% ten/maki "yew plum pine"
begintsuglyph("uni69D9",217);
  kanji.grnine.yew_plum_pine;
  tsu_render;
endtsuglyph;

% extra:  kashi
begintsuglyph("uni69DD",221);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (kanji.grthree.island);
  tsu_render;
endtsuglyph;

% extra:  shuu/kusabi "hard wood"
begintsuglyph("uni69E2",226);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grthree.learn);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69E3",227);
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (kanji.grfive.draw_near);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69E4",228);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grfour.bring);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69F8",248);
  build_kanji.level(build_kanji.lr(290,0)
    (kanji.leftrad.wood)
    (kanji.rare.art));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni69FA",250);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grfour.peace);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
