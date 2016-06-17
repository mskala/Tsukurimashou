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

% 【椁】⿰木<享>⿳<亠>⿱丨一口子
% extra?
begintsuglyph("uni6901",1);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.undergo);
  tsu_render;
endtsuglyph;

% 【椅】⿰木<奇>⿱<大>⿻一人<可>⿹<丁>⿱一亅口
% extra?
begintsuglyph("uni6905",5);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.strange);
  tsu_render;
endtsuglyph;

% 【椆】⿰木<周>⿵⺆<𠮷>⿱<土>⿱十一口
% extra?
begintsuglyph("uni6906",6);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.circuit);
  tsu_render;
endtsuglyph;

% 【椇】⿰木<具>⿳目一八
% extra?
begintsuglyph("uni6907",7);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.ingredient);
  tsu_render;
endtsuglyph;

% 【椊】⿰木<卒>⿱<𠅃>⿱<亠>⿱丨一<从>⿰人人十
% extra?
begintsuglyph("uni690A",10);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.graduate);
  tsu_render;
endtsuglyph;

% 【椋】⿰木<京>⿳<亠>⿱丨一口小
% extra?
begintsuglyph("uni690B",11);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.capital);
  tsu_render;
endtsuglyph;

% 【椌】⿰木<空>⿱<穴>⿱宀八工
% extra?
begintsuglyph("uni690C",12);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grone.sky);
  tsu_render;
endtsuglyph;

% shoku/u "plant"
begintsuglyph("uni690D",13);
  kanji.grthree.plant;
  tsu_render;
endtsuglyph;

% 【椎】⿰木隹
% extra?
begintsuglyph("uni690E",14);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.radical.old_bird);
  tsu_render;
endtsuglyph;

% 【椐】⿰木<居>⿸尸<古>⿱十口
% extra?
begintsuglyph("uni6910",16);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.reside);
  tsu_render;
endtsuglyph;

% 【椗】⿰木<定>⿱宀<𤴓>⿱一龰
% extra?
begintsuglyph("uni6917",23);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.regular);
  tsu_render;
endtsuglyph;

% 【椙】⿰木<昌>⿱日日
% extra?
begintsuglyph("uni6919",25);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.prosperity);
  tsu_render;
endtsuglyph;

% 【椚】⿰木<門>⿰𠁣𠃛
% extra?
begintsuglyph("uni691A",26);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.gate);
  tsu_render;
endtsuglyph;

% 【椛】⿰木<花>⿱<艹>⿻十丨<化>⿰亻<匕>⿺乚丿
% extra?
begintsuglyph("uni691B",27);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grone.flower);
  tsu_render;
endtsuglyph;

% 【椢】⿰木<国>⿴囗<玉>⿷<王>⿱一<土>⿱十一丶
% extra?
begintsuglyph("uni6922",34);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.country);
  tsu_render;
endtsuglyph;

% 【椣】⿰木<典>⿱<CDP-89E0>;八
% extra?
begintsuglyph("uni6923",35);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.rule);
  tsu_render;
endtsuglyph;

% 【椥】⿰木<知>⿰<矢>⿱𠂉<大>⿻一人口
% extra?
begintsuglyph("uni6925",37);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.know);
  tsu_render;
endtsuglyph;

% 【椧】⿰木<命>⿱<CDP-8AFC>⿵𠆢一<叩>⿰口卩
% extra?
begintsuglyph("uni6927",39);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.decree);
  tsu_render;
endtsuglyph;

% 【椨】⿰木<府>⿸广<付>⿰亻寸
% extra?
begintsuglyph("uni6928",40);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.urban_prefecture);
  tsu_render;
endtsuglyph;

% 【椮】⿰木<参>⿱厶⿱<大>⿻一人彡
% extra?
begintsuglyph("uni692E",46);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.participate);
  tsu_render;
endtsuglyph;

% 【椷】⿰木<咸>⿵<戌>⿵戊一口
% extra?
begintsuglyph("uni6937",55);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.the_same);
  tsu_render;
endtsuglyph;

% 【椺】⿰木<保>⿰亻<呆>⿱口木
% extra?
begintsuglyph("uni693A",58);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.protect);
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

% 【椾】⿰木<前>⿱<䒑>⿱丷一<刖>⿰月刂
% extra?
begintsuglyph("uni693E",62);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.before);
  tsu_render;
endtsuglyph;

% 【椿】⿰木<春>⿱<𡗗>⿻<三>⿳一一一人日
% extra?
begintsuglyph("uni693F",63);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.spring);
  tsu_render;
endtsuglyph;

% 【楁】⿰木<客>⿱宀<各>⿱夂口
% extra?
begintsuglyph("uni6941",65);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.guest);
  tsu_render;
endtsuglyph;

% 【楂】⿰木<査>⿱木<且>⿱<CDP-865E>;一
% extra?
begintsuglyph("uni6942",66);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.inspection);
  tsu_render;
endtsuglyph;

% 【楃】⿰木<屋>⿸尸<至>⿱<𠫔>⿱一厶<土>⿱十一
% extra?
begintsuglyph("uni6943",67);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.house);
  tsu_render;
endtsuglyph;

% 【楅】⿰木<畐>⿱<𠮛>⿱一口田
% extra?
begintsuglyph("uni6945",69);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.roll_of_cloth);
  tsu_render;
endtsuglyph;

% 【楆】⿰木<要>⿱<覀>⿱一<CDP-86EA>⿻<〢>⿰丨丨口女
% extra?
begintsuglyph("uni6946",70);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.essential);
  tsu_render;
endtsuglyph;

% 【楇】⿰木<咼>⿵<冎>⿱⿵冂<CDP-86E8>;冂口
% extra?
begintsuglyph("uni6947",71);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.crooked_mouth);
  tsu_render;
endtsuglyph;

% 【楉】⿰木<若>⿱<艹>⿻十丨<右>⿸𠂇口
% extra?
begintsuglyph("uni6949",73);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grsix.young_master);
  tsu_render;
endtsuglyph;

% 【楊】⿰木<昜>⿱<旦>⿱日一<勿>⿹勹<CDP-89A6>⿰丿丿
% extra?
begintsuglyph("uni694A",74);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.sun);
  tsu_render;
endtsuglyph;

% 【楎】⿰木<軍>⿱冖車
% extra?
begintsuglyph("uni694E",78);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.army);
  tsu_render;
endtsuglyph;

% 【楐】⿰木<界>⿱田<介>⿱𠆢<CDP-8BF5>⿰丿丨
% extra?
begintsuglyph("uni6950",80);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.realm);
  tsu_render;
endtsuglyph;

% 【楒】⿰木<思>⿱田心
% extra?
begintsuglyph("uni6952",82);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.think);
  tsu_render;
endtsuglyph;

% 【楓】⿰木<風>⿵𠘨<䖝>⿱丿<CDP-8853>⿷虫丿
% extra?
begintsuglyph("uni6953",83);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.wind);
  tsu_render;
endtsuglyph;

% 【楖】⿰木<即>⿰<CDP-8B7C>;卩
% extra?
begintsuglyph("uni6956",86);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.instant);
  tsu_render;
endtsuglyph;

% 【楗】⿰木<建>⿺廴<聿>⿻<肀>⿻<CDP-8BAB>⿻<CDP-8C78>;一丨<二>⿱一一
% extra?
begintsuglyph("uni6957",87);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.build);
  tsu_render;
endtsuglyph;

% 【楛】⿰木<苦>⿱<艹>⿻十丨<古>⿱十口
% extra?
begintsuglyph("uni695B",91);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.suffering);
  tsu_render;
endtsuglyph;

% 【楜】⿰木<胡>⿰<古>⿱十口月
% extra?
begintsuglyph("uni695C",92);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.barbarian);
  tsu_render;
endtsuglyph;

% 【楟】⿰木<亭>⿱<CDP-8C4D>⿳<亠>⿱丨一口冖<丁>⿱一亅
% extra?
begintsuglyph("uni695F",95);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.head_of_household);
  tsu_render;
endtsuglyph;

% 【楠】⿰木<南>⿱十<CDP-8BDC>⿵冂<𢆉>⿱丷干
% extra?
begintsuglyph("uni6960",96);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.south);
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

% 【楧】⿰木<英>⿱<艹>⿻十丨央
% extra?
begintsuglyph("uni6967",103);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.english);
  tsu_render;
endtsuglyph;

% 【楨】⿰木<貞>⿱⺊<貝>⿱目八
% extra?
begintsuglyph("uni6968",104);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.chastity);
  tsu_render;
endtsuglyph;

% 【楩】⿰木<便>⿰亻<更>⿱一<CDP-89E7>⿻日<乂>⿻丿乀
% extra?
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

% 【楮】⿰木<者>⿸耂日
% extra?
begintsuglyph("uni696E",110);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.person);
  tsu_render;
endtsuglyph;

% 【楳】⿰木<某>⿱甘木
% extra?
begintsuglyph("uni6973",115);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.a_certain);
  tsu_render;
endtsuglyph;

% kyoku/kiwa "extreme"
begintsuglyph("uni6975",117);
  kanji.grfour.extreme;
  tsu_render;
endtsuglyph;

% 【楷】⿰木<皆>⿱比白
% extra?
begintsuglyph("uni6977",119);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.everybody);
  tsu_render;
endtsuglyph;

% 【楸】⿰木<秋>⿰<禾>⿱丿木<火>⿱八人
% extra?
begintsuglyph("uni6978",120);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.autumn);
  tsu_render;
endtsuglyph;

% 【楻】⿰木<皇>⿱白<王>⿱一<土>⿱十一
% extra?
begintsuglyph("uni697B",123);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grsix.emperor);
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

% 【榀】⿰木<品>⿱口<吅>⿰口口
% extra?
begintsuglyph("uni6980",128);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.goods);
  tsu_render;
endtsuglyph;

% 【榁】⿰木<室>⿱宀<至>⿱<𠫔>⿱一厶<土>⿱十一
% extra?
begintsuglyph("uni6981",129);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.chamber);
  tsu_render;
endtsuglyph;

% 【概】⿰木<既>⿰<CDP-8B7C>;旡
% extra?
begintsuglyph("uni6982",130);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.already);
  tsu_render;
endtsuglyph;

% 【榊】⿰木<神>⿰礻申
% extra?
begintsuglyph("uni698A",138);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.deity);
  tsu_render;
endtsuglyph;

% 【榌】⿰木飛
% extra?
begintsuglyph("uni698C",140);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.fly);
  tsu_render;
endtsuglyph;

% 【榍】⿰木<屑>⿸尸<肖>⿱⺌月
% extra?
begintsuglyph("uni698D",141);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.chad);
  tsu_render;
endtsuglyph;

% 【榎】⿰木<夏>⿱<𦣻>⿱一自夂
% extra?
begintsuglyph("uni698E",142);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.summer);
  tsu_render;
endtsuglyph;

% 【榑】⿰木<尃>⿱<甫>⿺<CDP-86B7>⿻十月丶寸
% extra?
begintsuglyph("uni6991",145);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rightrad.professional);
  tsu_render;
endtsuglyph;

% 【榒】⿰木<弱>⿰<CDP-8CC4>⿹弓冫<CDP-8CC4>⿹弓冫
% extra?
begintsuglyph("uni6992",146);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.weak);
  tsu_render;
endtsuglyph;

% 【榕】⿰木<容>⿱宀谷
% extra?
begintsuglyph("uni6995",149);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.face);
  tsu_render;
endtsuglyph;

% 【榞】⿰木<原>⿸厂<CDP-8BC4>⿱白小
% extra?
begintsuglyph("uni699E",158);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.field);
  tsu_render;
endtsuglyph;

% 【榢】⿰木<家>⿱宀<豕>⿱一𧰨
% extra?
begintsuglyph("uni69A2",162);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.house);
  tsu_render;
endtsuglyph;

% 【榪】⿰木<馬>⿹<CDP-896A>;灬
% extra?
begintsuglyph("uni69AA",170);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.horse);
  tsu_render;
endtsuglyph;

% 【榯】⿰木<時>⿰日<寺>⿱<土>⿱十一寸
% extra?
begintsuglyph("uni69AF",175);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.time);
  tsu_render;
endtsuglyph;

% 【榳】⿰木<庭>⿸广<廷>⿺廴壬
% extra?
begintsuglyph("uni69B3",179);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.courtyard);
  tsu_render;
endtsuglyph;

% 【榴】⿰木<留>⿱<CDP-8C69>⿰<CDP-88EE>;<刀>⿹𠃌丿田
% extra?
begintsuglyph("uni69B4",180);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.detain);
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

% 【槁】⿰木<高>⿳<亠>⿱丨一口<冋>⿵冂口
% extra?
begintsuglyph("uni69C1",193);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.high);
  tsu_render;
endtsuglyph;

% 【槂】⿰木<孫>⿰子<系>⿱丿<糸>⿱<幺>⿰<CDP-895C>;丶小
% extra?
begintsuglyph("uni69C2",194);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.grandchild);
  tsu_render;
endtsuglyph;

% kou/kama "posture" or "construction"
begintsuglyph("uni69CB",203);
  kanji.grfive.posture;
  tsu_render;
endtsuglyph;

% 【槌】⿰木<追>⿺辶<𠂤>⿱丿㠯
% extra?
begintsuglyph("uni69CC",204);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.pursue);
  tsu_render;
endtsuglyph;

% 【槍】⿰木<倉>⿱<CDP-8AFC>⿵𠆢一⿸<CDP-89CE>⿴尸一口
% extra?
begintsuglyph("uni69CD",205);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.warehouse);
  tsu_render;
endtsuglyph;

% 【槎】⿰木<差>⿸<CDP-8CCC>⿱<𦍌>⿱<䒑>⿱丷一<土>⿱十一丿工
% extra?
begintsuglyph("uni69CE",206);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.difference);
  tsu_render;
endtsuglyph;

% 【槓】⿰木<貢>⿱工<貝>⿱目八
% extra?
begintsuglyph("uni69D3",211);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.tribute);
  tsu_render;
endtsuglyph;

% you/sama "honorific suffix with difficult literal meaning"
begintsuglyph("uni69D8",216);
  kanji.grthree.appearance;
  tsu_render;
endtsuglyph;

% 【槙】⿰木<真>⿱十<具>⿳目一八
% extra?
begintsuglyph("uni69D9",217);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.truth);
  tsu_render;
endtsuglyph;

% 【槝】⿰木<島>⿹<CDP-8CBB>;山
% extra?
begintsuglyph("uni69DD",221);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.island);
  tsu_render;
endtsuglyph;

% 【槢】⿰木<習>⿱<羽>⿰<习>⿹𠃌冫<习>⿹𠃌冫白
% extra?
begintsuglyph("uni69E2",226);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.learn);
  tsu_render;
endtsuglyph;

% 【槣】⿰木<寄>⿱宀<奇>⿱<大>⿻一人<可>⿹<丁>⿱一亅口
% extra?
begintsuglyph("uni69E3",227);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.draw_near);
  tsu_render;
endtsuglyph;

% 【槤】⿰木<連>⿺辶車
% extra?
begintsuglyph("uni69E4",228);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.bring);
  tsu_render;
endtsuglyph;

% 【槸】⿰木<埶>⿰<坴>⿱<圥>⿱<土>⿱十一<儿>⿰丿乚<土>⿱十一<丸>⿻九丶
% extra?
begintsuglyph("uni69F8",248);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.art);
  tsu_render;
endtsuglyph;

% 【槺】⿰木<康>⿸广隶
% extra?
begintsuglyph("uni69FA",250);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.peace);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
