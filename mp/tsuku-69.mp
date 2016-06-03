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

vardef kanji.grfive.posture =
  push_pbox_toexpand("kanji.grfive.posture");
  build_kanji.lr(380,30)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 0.95)(kanji.rare.inner_palace));
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

%tsukurimashou.eids:【享】⿱亠⿱口子
%tsukurimashou.eids:【享】(uni4EAB: kanji.greight.undergo, gradeeight.mp)
% 【椁】⿰木<享>⿳<亠>⿱丨一口子
% extra?
begintsuglyph("uni6901",1);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【奇】⿱大<可>⿻口(+2*2)
%tsukurimashou.eids:【奇】(uni5947: kanji.greight.strange, gradeeight.mp)
% 【椅】⿰木<奇>⿱<大>⿻一人<可>⿹<丁>⿱一亅口
% extra?
begintsuglyph("uni6905",5);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【周】⿻⿱土口(+1*2)
%tsukurimashou.eids:【周】(uni5468: kanji.grfour.circuit, gradefour.mp)
% 【椆】⿰木<周>⿵⺆<𠮷>⿱<土>⿱十一口
% extra?
begintsuglyph("uni6906",6);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【具】⿱<目>⿻口(+2)⿱一?
%tsukurimashou.eids:【具】(uni5177: kanji.grthree.ingredient, gradethree.mp)
% 【椇】⿰木<具>⿳目一八
% extra?
begintsuglyph("uni6907",7);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【卒】⿱亠⿱⿰??十
%tsukurimashou.eids:【卒】(uni5352: kanji.grfour.graduate, gradefour.mp)
% 【椊】⿰木<卒>⿱<𠅃>⿱<亠>⿱丨一<从>⿰人人十
% extra?
begintsuglyph("uni690A",10);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【京】⿱亠⿱口小
%tsukurimashou.eids:【京】(uni4EAC: kanji.grtwo.capital, gradetwo.mp)
% 【椋】⿰木<京>⿳<亠>⿱丨一口小
% extra?
begintsuglyph("uni690B",11);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【空】⿱<宂>⿱<宀>⿻冖(+1)儿<工>⿻二(+1)
%tsukurimashou.eids:【空】(uni7A7A: kanji.grone.sky, gradeone.mp)
% 【椌】⿰木<空>⿱<穴>⿱宀八工
% extra?
begintsuglyph("uni690C",12);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% shoku/u "plant"
begintsuglyph("uni690D",13);
  kanji.grthree.plant;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【隹】;
%tsukurimashou.eids:【隹】(uni96B9: kanji.radical.old_bird, radical.mp)
% 【椎】⿰木隹
% extra?
begintsuglyph("uni690E",14);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【居】⿸尸<古>⿱十口
%tsukurimashou.eids:【居】(uni5C45: kanji.grfive.reside, tsuku-5c.mp)
% 【椐】⿰木<居>⿸尸<古>⿱十口
% extra?
begintsuglyph("uni6910",16);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【定】⿱<宀>⿻冖(+1)<疋>⿻?(+3)
%tsukurimashou.eids:【定】(uni5B9A: kanji.grthree.regular, gradethree.mp)
% 【椗】⿰木<定>⿱宀<𤴓>⿱一龰
% extra?
begintsuglyph("uni6917",23);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【昌】⿱<日>⿻口(+1)<日>⿻口(+1)
%tsukurimashou.eids:【昌】(uni660C: kanji.grnine.prosperity, gradenine.mp)
% 【椙】⿰木<昌>⿱日日
% extra?
begintsuglyph("uni6919",25);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【門】;
%tsukurimashou.eids:【門】(uni9580: kanji.grtwo.gate, gradetwo.mp)
% 【椚】⿰木<門>⿰𠁣𠃛
% extra?
begintsuglyph("uni691A",26);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【花】⿱艹<化>⿰亻匕
%tsukurimashou.eids:【花】(uni82B1: kanji.grone.flower, tsuku-82.mp)
% 【椛】⿰木<花>⿱<艹>⿻十丨<化>⿰亻<匕>⿺乚丿
% extra?
begintsuglyph("uni691B",27);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【国】⿴囗<玉>⿻王(+1)
%tsukurimashou.eids:【国】(uni56FD: kanji.grtwo.country, tsuku-56.mp)
% 【椢】⿰木<国>⿴囗<玉>⿷<王>⿱一<土>⿱十一丶
% extra?
begintsuglyph("uni6922",34);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【典】⿱<曲>⿻口(+3)?
%tsukurimashou.eids:【典】(uni5178: kanji.grfour.rule, tsuku-51.mp)
% 【椣】⿰木<典>⿱<CDP-89E0>;八
% extra?
begintsuglyph("uni6923",35);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【知】⿰<矢>⿻夫(+1*3)口
%tsukurimashou.eids:【知】(uni77E5: kanji.grtwo.know, tsuku-77.mp)
% 【椥】⿰木<知>⿰<矢>⿱𠂉<大>⿻一人口
% extra?
begintsuglyph("uni6925",37);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【命】⿱人<叩>⿰口卩
%tsukurimashou.eids:【命】(uni547D: kanji.grthree.decree, tsuku-54.mp)
% 【椧】⿰木<命>⿱<CDP-8AFC>⿵𠆢一<叩>⿰口卩
% extra?
begintsuglyph("uni6927",39);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【府】⿸广<付>⿰亻寸
%tsukurimashou.eids:【府】(uni5E9C: kanji.grfour.urban_prefecture, tsuku-5e.mp)
% 【椨】⿰木<府>⿸广<付>⿰亻寸
% extra?
begintsuglyph("uni6928",40);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【参】⿳厶大彡
%tsukurimashou.eids:【参】(uni53C2: kanji.grfour.participate, gradefour.mp)
% 【椮】⿰木<参>⿱厶⿱<大>⿻一人彡
% extra?
begintsuglyph("uni692E",46);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【咸】⿻⿻弋口(+2*3)
%tsukurimashou.eids:【咸】(uni54B8: kanji.rare.the_same, rare.mp)
% 【椷】⿰木<咸>⿵<戌>⿵戊一口
% extra?
begintsuglyph("uni6937",55);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【保】⿰亻<呆>⿱口木
%tsukurimashou.eids:【保】(uni4FDD: kanji.grfive.protect, gradefive.mp)
% 【椺】⿰木<保>⿰亻<呆>⿱口木
% extra?
begintsuglyph("uni693A",58);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【衍】([build_kanji.go_enclose,[build_kanji.lcr,eids.u2ff2._2.1_1.2_,[build_kanji.harmonic,eids.u2FF1.u003F._1,[kanji.leftrad.person,push_stroke,push_stroke],[[kanji.leftrad.person,push_stroke,push_stroke],replace_strokep,bosize0,replace_strokep]],[kanji.leftrad.water,[kanji.leftrad.ice,push_stroke,push_stroke],push_stroke],[build_kanji.harmonic,eids.u2FF1.u003F._1,[kanji.grthree.thumbtack,push_stroke,push_stroke,replace_strokep,replace_strokep],[[kanji.grthree.thumbtack,push_stroke,push_stroke,replace_strokep,replace_strokep],replace_strokep,bosize0,replace_strokep]]]])
% 【椼】⿰木<衍>⿲彳氵<亍>⿱一<丁>⿱一亅
% extra?
begintsuglyph("uni693C",60);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【前】⿱⿻?(+1)⿰⺝刂
%tsukurimashou.eids:【前】(uni524D: kanji.grtwo.before, tsuku-52.mp)
% 【椾】⿰木<前>⿱<䒑>⿱丷一<刖>⿰月刂
% extra?
begintsuglyph("uni693E",62);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【春】⿱([[kanji.grone.person,push_stroke,push_stroke],[kanji.grone.three,push_stroke,push_stroke,push_stroke],replace_strokep])<日>⿻口(+1)
%tsukurimashou.eids:【春】(uni6625: kanji.grtwo.spring, tsuku-66.mp)
% 【椿】⿰木<春>⿱<𡗗>⿻<三>⿳一一一人日
% extra?
begintsuglyph("uni693F",63);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【客】⿱<宀>⿻冖(+1)<各>⿱夂口
%tsukurimashou.eids:【客】(uni5BA2: kanji.grthree.guest, gradethree.mp)
% 【楁】⿰木<客>⿱宀<各>⿱夂口
% extra?
begintsuglyph("uni6941",65);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【査】⿱木且
%tsukurimashou.eids:【査】(uni67FB: kanji.grfive.inspection, tsuku-67.mp)
% 【楂】⿰木<査>⿱木<且>⿱<CDP-865E>;一
% extra?
begintsuglyph("uni6942",66);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【屋】⿸尸<至>⿱⿻厶(+1*2)土
%tsukurimashou.eids:【屋】(uni5C4B: kanji.grthree.house, tsuku-5c.mp)
% 【楃】⿰木<屋>⿸尸<至>⿱<𠫔>⿱一厶<土>⿱十一
% extra?
begintsuglyph("uni6943",67);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【畐】⿱⿱一口<田>⿻口(+2)
%tsukurimashou.eids:【畐】(uni7550: kanji.rare.roll_of_cloth, rare.mp)
% 【楅】⿰木<畐>⿱<𠮛>⿱一口田
% extra?
begintsuglyph("uni6945",69);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【要】⿱⿻口(+3)女
%tsukurimashou.eids:【要】(uni8981: kanji.grfour.essential, tsuku-89.mp)
% 【楆】⿰木<要>⿱<覀>⿱一<CDP-86EA>⿻<〢>⿰丨丨口女
% extra?
begintsuglyph("uni6946",70);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【咼】⿻⿻冂口(+2)
%tsukurimashou.eids:【咼】(uni54BC: kanji.rare.crooked_mouth, rare.mp)
% 【楇】⿰木<咼>⿵<冎>⿱⿵冂<CDP-86E8>;冂口
% extra?
begintsuglyph("uni6947",71);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【若】⿱艹<右>⿻口(+2)
%tsukurimashou.eids:【若】(uni82E5: kanji.grsix.young_master, gradesix.mp)
% 【楉】⿰木<若>⿱<艹>⿻十丨<右>⿸𠂇口
% extra?
begintsuglyph("uni6949",73);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【昜】⿱<日>⿻口(+1)⿻<勿>⿻勹(+2)(+1)
%tsukurimashou.eids:【昜】(uni661C: kanji.rare.sun, rare.mp)
% 【楊】⿰木<昜>⿱<旦>⿱日一<勿>⿹勹<CDP-89A6>⿰丿丿
% extra?
begintsuglyph("uni694A",74);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【軍】⿱冖<車>⿻口(+4)
%tsukurimashou.eids:【軍】(uni8ECD: kanji.grfour.army, gradefour.mp)
% 【楎】⿰木<軍>⿱冖車
% extra?
begintsuglyph("uni694E",78);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【界】⿱<田>⿻口(+2)<介>⿱人廾
%tsukurimashou.eids:【界】(uni754C: kanji.grthree.realm, tsuku-75.mp)
% 【楐】⿰木<界>⿱田<介>⿱𠆢<CDP-8BF5>⿰丿丨
% extra?
begintsuglyph("uni6950",80);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【思】⿱<田>⿻口(+2)心
%tsukurimashou.eids:【思】(uni601D: kanji.grtwo.think, gradetwo.mp)
% 【楒】⿰木<思>⿱田心
% extra?
begintsuglyph("uni6952",82);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【風】⿻⿱丿<虫>⿻口(+3)(+1)
%tsukurimashou.eids:【風】(uni98A8: kanji.grtwo.wind, gradetwo.mp)
% 【楓】⿰木<風>⿵𠘨<䖝>⿱丿<CDP-8853>⿷虫丿
% extra?
begintsuglyph("uni6953",83);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【即】⿰?卩
%tsukurimashou.eids:【即】(uni5373: kanji.greight.instant, gradeeight.mp)
% 【楖】⿰木<即>⿰<CDP-8B7C>;卩
% extra?
begintsuglyph("uni6956",86);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【建】⿺廴<聿>⿻?(+3)
%tsukurimashou.eids:【建】(uni5EFA: kanji.grfour.build, gradefour.mp)
% 【楗】⿰木<建>⿺廴<聿>⿻<肀>⿻<CDP-8BAB>⿻<CDP-8C78>;一丨<二>⿱一一
% extra?
begintsuglyph("uni6957",87);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【苦】⿱艹<古>⿱十口
%tsukurimashou.eids:【苦】(uni82E6: kanji.grthree.suffering, tsuku-82.mp)
% 【楛】⿰木<苦>⿱<艹>⿻十丨<古>⿱十口
% extra?
begintsuglyph("uni695B",91);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【胡】⿰<古>⿱十口月
%tsukurimashou.eids:【胡】(uni80E1: kanji.grnine.barbarian, gradenine.mp)
% 【楜】⿰木<胡>⿰<古>⿱十口月
% extra?
begintsuglyph("uni695C",92);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【亭】⿱亠⿱口⿱冖丁
%tsukurimashou.eids:【亭】(uni4EAD: kanji.greight.head_of_household, gradeeight.mp)
% 【楟】⿰木<亭>⿱<CDP-8C4D>⿳<亠>⿱丨一口冖<丁>⿱一亅
% extra?
begintsuglyph("uni695F",95);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【南】⿱十([[kanji.radical.gmm,push_stroke,replace_strokep,replace_strokep],[kanji.grone.two,push_stroke,push_stroke],[kanji.toprad.sparkle_two,push_stroke,push_stroke],push_stroke])
%tsukurimashou.eids:【南】(uni5357: kanji.grtwo.south, tsuku-53.mp)
% 【楠】⿰木<南>⿱十<CDP-8BDC>⿵冂<𢆉>⿱丷干
% extra?
begintsuglyph("uni6960",96);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【怱】⿱<匆>⿻<勿>⿻勹(+2)(+1)心
% 【楤】⿰木<怱>⿱<匆>⿻<勿>⿹勹<CDP-89A6>⿰丿丿丶心
% extra?
begintsuglyph("uni6964",100);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【英】⿱艹央
%tsukurimashou.eids:【英】(uni82F1: kanji.grfour.english, gradefour.mp)
% 【楧】⿰木<英>⿱<艹>⿻十丨央
% extra?
begintsuglyph("uni6967",103);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【貞】⿱十<貝>⿱<目>⿻口(+2)?
%tsukurimashou.eids:【貞】(uni8C9E: kanji.greight.chastity, tsuku-8c.mp)
% 【楨】⿰木<貞>⿱⺊<貝>⿱目八
% extra?
begintsuglyph("uni6968",104);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【便】⿰亻<更>⿻口(+4)
%tsukurimashou.eids:【便】(uni4FBF: kanji.grfour.convenience, tsuku-4f.mp)
% 【楩】⿰木<便>⿰亻<更>⿱一<CDP-89E7>⿻日<乂>⿻丿乀
% extra?
begintsuglyph("uni6969",105);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% kyou/waza "business"
begintsuglyph("uni696D",109);
  kanji.grthree.business;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【者】⿻⿱土<日>⿻口(+1)(+1)
%tsukurimashou.eids:【者】(uni8005: kanji.grthree.person, gradethree.mp)
% 【楮】⿰木<者>⿸耂日
% extra?
begintsuglyph("uni696E",110);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【某】⿱<甘>⿻廿(+1)木
%tsukurimashou.eids:【某】(uni67D0: kanji.greight.a_certain, gradeeight.mp)
% 【楳】⿰木<某>⿱甘木
% extra?
begintsuglyph("uni6973",115);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% kyoku/kiwa "extreme"
begintsuglyph("uni6975",117);
  kanji.grfour.extreme;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【皆】⿱<比>⿰上匕<白>⿱㇒<日>⿻口(+1)
%tsukurimashou.eids:【皆】(uni7686: kanji.greight.everybody, gradeeight.mp)
% 【楷】⿰木<皆>⿱比白
% extra?
begintsuglyph("uni6977",119);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【秋】⿰⿱丿木<火>⿻人(+2)
%tsukurimashou.eids:【秋】(uni79CB: kanji.grtwo.autumn, gradetwo.mp)
% 【楸】⿰木<秋>⿰<禾>⿱丿木<火>⿱八人
% extra?
begintsuglyph("uni6978",120);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【皇】⿱<白>⿱㇒<日>⿻口(+1)王
%tsukurimashou.eids:【皇】(uni7687: kanji.grsix.emperor, gradesix.mp)
% 【楻】⿰木<皇>⿱白<王>⿱一<土>⿱十一
% extra?
begintsuglyph("uni697B",123);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【娄】⿱<米>⿱?木女
% 【楼】⿰木<娄>⿱米女
% extra?
begintsuglyph("uni697C",124);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
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

%tsukurimashou.eids:【品】⿱口⿰口口
%tsukurimashou.eids:【品】(uni54C1: kanji.grthree.goods, gradethree.mp)
% 【榀】⿰木<品>⿱口<吅>⿰口口
% extra?
begintsuglyph("uni6980",128);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【室】⿱<宀>⿻冖(+1)<至>⿱⿻厶(+1*2)土
%tsukurimashou.eids:【室】(uni5BA4: kanji.grtwo.chamber, tsuku-5b.mp)
% 【榁】⿰木<室>⿱宀<至>⿱<𠫔>⿱一厶<土>⿱十一
% extra?
begintsuglyph("uni6981",129);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【既】⿰??
%tsukurimashou.eids:【既】(uni65E2: kanji.greight.already, gradeeight.mp)
% 【概】⿰木<既>⿰<CDP-8B7C>;旡
% extra?
begintsuglyph("uni6982",130);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【神】⿰礻<申>([kanji.grthree.have_honour,[kanji.grone.day,[build_kanji.box,push_stroke,push_stroke],push_stroke],[kanji.radical.vline,push_stroke]])
%tsukurimashou.eids:【神】(uni795E: kanji.grthree.deity, tsuku-79.mp)
% 【榊】⿰木<神>⿰礻申
% extra?
begintsuglyph("uni698A",138);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【飛】⿻⿱飞飞(+3)
%tsukurimashou.eids:【飛】(uni98DB: kanji.grfour.fly, tsuku-98.mp)
% 【榌】⿰木飛
% extra?
begintsuglyph("uni698C",140);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【屑】⿸尸<肖>⿱<⺌>⿻?(+1)⺝
%tsukurimashou.eids:【屑】(uni5C51: kanji.grnine.chad, tsuku-5c.mp)
% 【榍】⿰木<屑>⿸尸<肖>⿱⺌月
% extra?
begintsuglyph("uni698D",141);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【夏】⿱⿻<自>⿱㇒<目>⿻口(+2)(+1)夂
%tsukurimashou.eids:【夏】(uni590F: kanji.grtwo.summer, tsuku-59.mp)
% 【榎】⿰木<夏>⿱<𦣻>⿱一自夂
% extra?
begintsuglyph("uni698E",142);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【尃】⿱⿻⿱十<日>⿻口(+1)(+1*1)寸
%tsukurimashou.eids:【尃】(uni5C03: kanji.rightrad.professional, rightrad.mp)
% 【榑】⿰木<尃>⿱<甫>⿺<CDP-86B7>⿻十月丶寸
% extra?
begintsuglyph("uni6991",145);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【弱】⿰⿻弓(+2)⿻弓(+2)
%tsukurimashou.eids:【弱】(uni5F31: kanji.grtwo.weak, gradetwo.mp)
% 【榒】⿰木<弱>⿰<CDP-8CC4>⿹弓冫<CDP-8CC4>⿹弓冫
% extra?
begintsuglyph("uni6992",146);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【容】⿱<宀>⿻冖(+1)<谷>⿱?⿱人口
%tsukurimashou.eids:【容】(uni5BB9: kanji.grfive.face, gradefive.mp)
% 【榕】⿰木<容>⿱宀谷
% extra?
begintsuglyph("uni6995",149);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【殺】⿰⿱?木<殳>⿱几又
%tsukurimashou.eids:【殺】(uni6BBA: kanji.grfour.kill, tsuku-6b.mp)
% 【榝】⿰木<殺>⿰⿱㐅木<殳>⿱几又
% extra?
begintsuglyph("uni699D",157);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【原】⿸厂⿱<白>⿱㇒<日>⿻口(+1)小
%tsukurimashou.eids:【原】(uni539F: kanji.grtwo.field, gradetwo.mp)
% 【榞】⿰木<原>⿸厂<CDP-8BC4>⿱白小
% extra?
begintsuglyph("uni699E",158);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【家】⿱<宀>⿻冖(+1)豕
%tsukurimashou.eids:【家】(uni5BB6: kanji.grtwo.house, gradetwo.mp)
% 【榢】⿰木<家>⿱宀<豕>⿱一𧰨
% extra?
begintsuglyph("uni69A2",162);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【馬】;
%tsukurimashou.eids:【馬】(uni99AC: kanji.grtwo.horse, gradetwo.mp)
% 【榪】⿰木<馬>⿹<CDP-896A>;灬
% extra?
begintsuglyph("uni69AA",170);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【時】⿰<日>⿻口(+1)<寺>⿱土寸
%tsukurimashou.eids:【時】(uni6642: kanji.grtwo.time, tsuku-66.mp)
% 【榯】⿰木<時>⿰日<寺>⿱<土>⿱十一寸
% extra?
begintsuglyph("uni69AF",175);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【庭】⿸广<廷>⿺廴<壬>⿱丿士
%tsukurimashou.eids:【庭】(uni5EAD: kanji.grthree.courtyard, tsuku-5e.mp)
% 【榳】⿰木<庭>⿸广<廷>⿺廴壬
% extra?
begintsuglyph("uni69B3",179);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【留】⿱⿰?刀<田>⿻口(+2)
%tsukurimashou.eids:【留】(uni7559: kanji.grfive.detain, gradefive.mp)
% 【榴】⿰木<留>⿱<CDP-8C69>⿰<CDP-88EE>;<刀>⿹𠃌丿田
% extra?
begintsuglyph("uni69B4",180);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【茸】⿱艹耳
% 【榵】⿰木<茸>⿱<艹>⿻十丨耳
% extra?
begintsuglyph("uni69B5",181);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【高】⿳亠口⿻冂口
%tsukurimashou.eids:【高】(uni9AD8: kanji.grtwo.high, gradetwo.mp)
% 【槁】⿰木<高>⿳<亠>⿱丨一口<冋>⿵冂口
% extra?
begintsuglyph("uni69C1",193);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【孫】⿰孑<系>⿱丿<糸>⿻?(+3)
%tsukurimashou.eids:【孫】(uni5B6B: kanji.grfour.grandchild, gradefour.mp)
% 【槂】⿰木<孫>⿰子<系>⿱丿<糸>⿱<幺>⿰<CDP-895C>;丶小
% extra?
begintsuglyph("uni69C2",194);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% kou/kama "posture" or "construction"
begintsuglyph("uni69CB",203);
  kanji.grfive.posture;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【追】⿺⻌⿱㇒?
%tsukurimashou.eids:【追】(uni8FFD: kanji.grthree.pursue, tsuku-8f.mp)
% 【槌】⿰木<追>⿺辶<𠂤>⿱丿㠯
% extra?
begintsuglyph("uni69CC",204);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【倉】⿱人⿻?口
%tsukurimashou.eids:【倉】(uni5009: kanji.grfour.warehouse, gradefour.mp)
% 【槍】⿰木<倉>⿱<CDP-8AFC>⿵𠆢一⿸<CDP-89CE>⿴尸一口
% extra?
begintsuglyph("uni69CD",205);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【差】⿻⿱<⺷>([kanji.grthree.sheep,[kanji.grone.three,push_stroke,push_stroke,push_stroke],[kanji.toprad.sparkle_two,push_stroke,push_stroke],push_stroke])<工>⿻二(+1)(+1)
%tsukurimashou.eids:【差】(uni5DEE: kanji.grfour.difference, tsuku-5d.mp)
% 【槎】⿰木<差>⿸<CDP-8CCC>⿱<𦍌>⿱<䒑>⿱丷一<土>⿱十一丿工
% extra?
begintsuglyph("uni69CE",206);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【貢】⿱<工>⿻二(+1)<貝>⿱<目>⿻口(+2)?
%tsukurimashou.eids:【貢】(uni8CA2: kanji.greight.tribute, gradeeight.mp)
% 【槓】⿰木<貢>⿱工<貝>⿱目八
% extra?
begintsuglyph("uni69D3",211);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% you/sama "honorific suffix with difficult literal meaning"
begintsuglyph("uni69D8",216);
  kanji.grthree.appearance;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【真】⿱⿱十<目>⿻口(+2)?
%tsukurimashou.eids:【真】(uni771F: kanji.grthree.truth, gradethree.mp)
% 【槙】⿰木<真>⿱十<具>⿳目一八
% extra?
begintsuglyph("uni69D9",217);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【島】([kanji.grthree.island,[kanji.grtwo.bird,push_stroke,push_stroke,push_stroke,push_stroke,push_stroke,push_stroke,replace_strokep,push_stroke,push_stroke,push_stroke,push_stroke],[kanji.grone.mountain,push_stroke,push_stroke,push_stroke,build_kanji.cup,push_stroke]])
%tsukurimashou.eids:【島】(uni5CF6: kanji.grthree.island, tsuku-5c.mp)
% 【槝】⿰木<島>⿹<CDP-8CBB>;山
% extra?
begintsuglyph("uni69DD",221);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【習】⿱<羽>⿰??<白>⿱㇒<日>⿻口(+1)
%tsukurimashou.eids:【習】(uni7FD2: kanji.grthree.learn, gradethree.mp)
% 【槢】⿰木<習>⿱<羽>⿰<习>⿹𠃌冫<习>⿹𠃌冫白
% extra?
begintsuglyph("uni69E2",226);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【寄】⿱<宀>⿻冖(+1)<奇>⿱大<可>⿻口(+2*2)
%tsukurimashou.eids:【寄】(uni5BC4: kanji.grfive.draw_near, tsuku-5b.mp)
% 【槣】⿰木<寄>⿱宀<奇>⿱<大>⿻一人<可>⿹<丁>⿱一亅口
% extra?
begintsuglyph("uni69E3",227);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【連】⿺⻌<車>⿻口(+4)
%tsukurimashou.eids:【連】(uni9023: kanji.grfour.bring, gradefour.mp)
% 【槤】⿰木<連>⿺辶車
% extra?
begintsuglyph("uni69E4",228);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【埶】⿰⿱<圥>⿱土儿土<丸>⿻九(+1)
%tsukurimashou.eids:【埶】(uni57F6: kanji.rare.art, rare.mp)
% 【槸】⿰木<埶>⿰<坴>⿱<圥>⿱<土>⿱十一<儿>⿰丿乚<土>⿱十一<丸>⿻九丶
% extra?
begintsuglyph("uni69F8",248);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【康】⿸广⿱?氺
%tsukurimashou.eids:【康】(uni5EB7: kanji.grfour.peace, gradefour.mp)
% 【槺】⿰木<康>⿸广隶
% extra?
begintsuglyph("uni69FA",250);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
