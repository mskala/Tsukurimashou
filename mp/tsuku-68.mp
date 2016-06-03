%
% Unicode page 68 (Kanji) for Tsukurimashou
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

vardef kanji.grfive.rank =
  push_pbox_toexpand("kanji.grfive.rank");
  build_kanji.lr(420,0)
    (kanji.leftrad.wood)
    (kanji.grfour.every);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.stopper =
  push_pbox_toexpand("kanji.greight.stopper");
  build_kanji.level(build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grthree.complete));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.nest =
  push_pbox_toexpand("kanji.grnine.nest");
  build_kanji.lr(420,-10)
    (kanji.leftrad.wood)
    (kanji.grtwo.west);
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

% 【桁】⿰木<行>⿰彳<亍>⿱一<丁>⿱一亅
% extra?
begintsuglyph("uni6841",65);
  build_kanji.lr(380,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.go);
  tsu_render;
endtsuglyph;

% 【桂】⿰木<圭>⿱<土>⿱十一<土>⿱十一
% extra?
begintsuglyph("uni6842",66);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.square_jewel);
  tsu_render;
endtsuglyph;

% 【桃】⿰木兆
% extra?
begintsuglyph("uni6843",67);
  build_kanji.lr(360,0)
    (kanji.leftrad.wood)
    (kanji.grfour.portent);
  tsu_render;
endtsuglyph;

% 【桄】⿰木<光>⿳⺌一<儿>⿰丿乚
% extra?
begintsuglyph("uni6844",68);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.shine);
  tsu_render;
endtsuglyph;

% 【框】⿰木<匡>⿷匚<王>⿱一<土>⿱十一
% extra?
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

% 【桉】⿰木<安>⿱宀女
% extra?
begintsuglyph("uni6849",73);
  build_kanji.lr(390,0)
    (kanji.leftrad.wood)
    (kanji.grthree.easy);
  tsu_render;
endtsuglyph;

% 【桎】⿰木<至>⿱<𠫔>⿱一厶<土>⿱十一
% extra?
begintsuglyph("uni684E",78);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grsix.climax);
  tsu_render;
endtsuglyph;

% 【桐】⿰木<同>⿵<𠔼>⿵冂一口
% extra?
begintsuglyph("uni6850",80);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.same);
  tsu_render;
endtsuglyph;

% 【桔】⿰木<吉>⿱<士>⿱十一口
% extra?
begintsuglyph("uni6854",84);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.good_luck);
  tsu_render;
endtsuglyph;

% 【桖】⿰木<血>⿱丿皿
% extra?
begintsuglyph("uni6856",86);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grthree.blood);
  tsu_render;
endtsuglyph;

% 【桘】⿰木<𠂤>⿱丿㠯
% extra?
begintsuglyph("uni6858",88);
  build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,30))(kanji.rare.mound));
  tsu_render;
endtsuglyph;

% 【桙】⿰木<牟>⿱厶牛
% extra?
begintsuglyph("uni6859",89);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.moo);
  tsu_render;
endtsuglyph;

% 【档】⿰木<当>⿱⺌彐
% extra?
begintsuglyph("uni6863",99);
  build_kanji.level(build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.hit));
  tsu_render;
endtsuglyph;

% 【桧】⿰木<会>⿱𠆢<云>⿱<二>⿱一一厶
% extra?
begintsuglyph("uni6867",103);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.meet);
  tsu_render;
endtsuglyph;

% 【桩】⿰木<庄>⿸广<土>⿱十一
% extra?
begintsuglyph("uni6869",105);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grnine.manor);
  tsu_render;
endtsuglyph;

% 【桭】⿰木<辰>⿸厂⿱<二>⿱一一<CDP-8CC6>⿰𠄌⿺乀丿
% extra?
begintsuglyph("uni686D",109);
  build_kanji.lr(390,20)
    (kanji.leftrad.wood)
    (kanji.grnine.dragon_sign);
  tsu_render;
endtsuglyph;

% 【桮】⿰木<否>⿱<不>⿱一<CDP-8665>;口
% extra?
begintsuglyph("uni686E",110);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grsix.noes);
  tsu_render;
endtsuglyph;

% 【桴】⿰木<孚>⿱<爫>⿱丿⿲丿丶丶子
% extra?
begintsuglyph("uni6874",116);
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (build_kanji.tb(580,0)
       (kanji.toprad.paw)
       (kanji.grone.child)));
  tsu_render;
endtsuglyph;

% 【桵】⿰木<妥>⿱<爫>⿱丿⿲丿丶丶女
% extra?
begintsuglyph("uni6875",117);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.greight.compromise);
  tsu_render;
endtsuglyph;

% 【桶】⿰木<甬>⿱龴<用>⿵冂<CDP-8BF1>⿻<二>⿱一一丨
% extra?
begintsuglyph("uni6876",118);
  build_kanji.lr(420,10)
    (kanji.leftrad.wood)
    (kanji.rare.walled_road);
  tsu_render;
endtsuglyph;

% 【桷】⿰木角
% extra?
begintsuglyph("uni6877",119);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.corner);
  tsu_render;
endtsuglyph;

% 【桸】⿰木<希>⿱㐅<布>⿸𠂇巾
% extra?
begintsuglyph("uni6878",120);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grfour.rarity);
  tsu_render;
endtsuglyph;

% 【桹】⿰木<良>⿱丨艮
% extra?
begintsuglyph("uni6879",121);
  build_kanji.lr(400,60)
    (kanji.leftrad.wood)
    (kanji.grfour.good);
  tsu_render;
endtsuglyph;

% 【桾】⿰木<君>⿸<尹>⿻<CDP-8BAB>⿻<CDP-8C78>;一丿口
% extra?
begintsuglyph("uni687E",126);
  build_kanji.lr(400,-10)
    (kanji.leftrad.wood)
    (kanji.grthree.junior);
  tsu_render;
endtsuglyph;

% 【梀】⿰木束
% extra?
begintsuglyph("uni6880",128);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.bundle);
  tsu_render;
endtsuglyph;

% 【梂】⿰木<求>⿺<CDP-85DC>⿻一<氺>⿻亅<CDP-89AE>⿱丷八丶
% extra?
begintsuglyph("uni6882",130);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (kanji.grfour.request);
  tsu_render;
endtsuglyph;

% 【梃】⿰木<廷>⿺廴壬
% extra?
begintsuglyph("uni6883",131);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.greight.court);
  tsu_render;
endtsuglyph;

% 【梄】⿰木酉
% extra?
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

% 【梈】⿰木<亨>⿳<亠>⿱丨一口<了>⿱乛亅
% extra?
begintsuglyph("uni6888",136);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.undergo);
  tsu_render;
endtsuglyph;

% 【梌】⿰木<余>⿱<CDP-8AFC>⿵𠆢一朩
% extra?
begintsuglyph("uni688C",140);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.grfive.surplus);
  tsu_render;
endtsuglyph;

% 【梏】⿰木<告>⿱𠂒口
% extra?
begintsuglyph("uni688F",143);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.revelation);
  tsu_render;
endtsuglyph;

% 【梓】⿰木<辛>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一十
% extra?
begintsuglyph("uni6893",147);
  build_kanji.lr(400,-20)
    (kanji.leftrad.wood)
    (kanji.greight.acrid);
  tsu_render;
endtsuglyph;

% 【梖】⿰木<貝>⿱目八
% extra?
begintsuglyph("uni6896",150);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grone.shell);
  tsu_render;
endtsuglyph;

% 【梗】⿰木<更>⿱一<CDP-89E7>⿻日<乂>⿻丿乀
% extra?
begintsuglyph("uni6897",151);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.night_watch);
  tsu_render;
endtsuglyph;

% 【梘】⿰木<見>⿱目<儿>⿰丿乚
% extra?
begintsuglyph("uni6898",152);
  build_kanji.lr(440,40)
    (kanji.leftrad.wood)
    (kanji.grone.see);
  tsu_render;
endtsuglyph;

% 【梚】⿰木<免>⿳⺈<𫩏>⿴囗丨<儿>⿰丿乚
% extra?
begintsuglyph("uni689A",154);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.greight.dismiss);
  tsu_render;
endtsuglyph;

% 【梠】⿰木<呂>⿳口丿口
% extra?
begintsuglyph("uni68A0",160);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.spine);
  tsu_render;
endtsuglyph;

% 【梡】⿰木<完>⿱宀<元>⿱一<兀>⿱一<儿>⿰丿乚
% extra?
begintsuglyph("uni68A1",161);
  build_kanji.lr(410,0)
    (kanji.leftrad.wood)
    (kanji.grfour.perfect);
  tsu_render;
endtsuglyph;

% 【梢】⿰木<肖>⿱⺌月
% extra?
begintsuglyph("uni68A2",162);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.resemblance);
  tsu_render;
endtsuglyph;

% 【梧】⿰木<吾>⿱<五>⿱一𫝀口
% extra?
begintsuglyph("uni68A7",167);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grnine.my);
  tsu_render;
endtsuglyph;

% 【梩】⿰木<里>⿱<CDP-8BD9>⿻甲一一
% extra?
begintsuglyph("uni68A9",169);
  build_kanji.lr(440,10)
    (kanji.leftrad.wood)
    (kanji.grtwo.neighbourhood);
  tsu_render;
endtsuglyph;

% 【梪】⿰木豆
% extra?
begintsuglyph("uni68AA",170);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (tsu_xform(identity yscaled 0.94)(kanji.grthree.bean));
  tsu_render;
endtsuglyph;

% 【梮】⿰木<局>⿸尸⿹𠃌口
% extra?
begintsuglyph("uni68AE",174);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.bureau);
  tsu_render;
endtsuglyph;

% 【梯】⿰木<弟>⿱丷<𢎨>⿹<弔>⿻弓丨丿
% extra?
begintsuglyph("uni68AF",175);
  build_kanji.lr(440,0)
    (kanji.leftrad.wood)
    (kanji.grtwo.little_brother);
  tsu_render;
endtsuglyph;

% kai/kase "machine"
begintsuglyph("uni68B0",176);
  kanji.grfour.machine;
  tsu_render;
endtsuglyph;

% 【梱】⿰木<困>⿴囗木
% extra?
begintsuglyph("uni68B1",177);
  build_kanji.lr(400,-20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grsix.bothered));
  tsu_render;
endtsuglyph;

% 【梳】⿰木<㐬>⿱<𠫓>⿱<亠>⿱丨一厶<𫶧>⿴<儿>⿰丿乚丨
% extra?
begintsuglyph("uni68B3",179);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.uncultivated);
  tsu_render;
endtsuglyph;

% 【梴】⿰木<延>⿺廴<CDP-8D62>⿱丿止
% extra?
begintsuglyph("uni68B4",180);
  build_kanji.lr(360,20)
    (kanji.leftrad.wood)
    (kanji.grsix.prolong);
  tsu_render;
endtsuglyph;

% 【梶】⿰木<尾>⿸尸毛
% extra?
begintsuglyph("uni68B6",182);
  build_kanji.lr(410,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(yscaled 1.04)(kanji.greight.tail));
  tsu_render;
endtsuglyph;

% 【梸】⿰木<利>⿰<禾>⿱丿木刂
% extra?
begintsuglyph("uni68B8",184);
  build_kanji.lr(380,20)
    (kanji.leftrad.wood)
    (kanji.grfour.advantage);
  tsu_render;
endtsuglyph;

% 【梹】⿰木<兵>⿱丘八
% extra?
begintsuglyph("uni68B9",185);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.soldier);
  tsu_render;
endtsuglyph;

% 【梽】⿰木<志>⿱<士>⿱十一心
% extra?
begintsuglyph("uni68BD",189);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfive.intention);
  tsu_render;
endtsuglyph;

% 【梾】⿰木来
% extra?
begintsuglyph("uni68BE",190);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.come);
  tsu_render;
endtsuglyph;

% 【棁】⿰木<兑>⿱丷<兄>⿱口<儿>⿰丿乚
% extra?
begintsuglyph("uni68C1",193);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.rare.cash);
  tsu_render;
endtsuglyph;

% 【棆】⿰木<侖>⿱<CDP-8AFC>⿵𠆢一<𠕁>⿵冂<卄>⿻⿰丨丨一
% extra?
begintsuglyph("uni68C6",198);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.rare.be_methodical);
  tsu_render;
endtsuglyph;

% 【棇】⿰木<忩>⿱<公>⿱八厶心
% extra?
begintsuglyph("uni68C7",199);
  build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.rare.be_flustered);
  tsu_render;
endtsuglyph;

% 【棋】⿰木<其>⿱<CDP-8B72>⿱<CDP-88C8>;一八
% extra?
begintsuglyph("uni68CB",203);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (kanji.grnine.that);
  tsu_render;
endtsuglyph;

% 【棌】⿰木<采>⿱<爫>⿱丿⿲丿丶丶木
% extra?
begintsuglyph("uni68CC",204);
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.wood)
    (kanji.greight.dice));
  tsu_render;
endtsuglyph;

% 【棑】⿰木非
% extra?
begintsuglyph("uni68D1",209);
  build_kanji.lr(390,0)
    (kanji.leftrad.wood)
    (kanji.grfive.mistake);
  tsu_render;
endtsuglyph;

% 【棕】⿰木<宗>⿱宀示
% extra?
begintsuglyph("uni68D5",213);
  build_kanji.lr(400,-10)
    (kanji.leftrad.wood)
    (kanji.grsix.religion);
  tsu_render;
endtsuglyph;

% 【棖】⿰木<長>⿳<CDP-884A>;一<CDP-8CC6>⿰𠄌⿺乀丿
% extra?
begintsuglyph("uni68D6",214);
  build_kanji.lr(400,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.long);
  tsu_render;
endtsuglyph;

% 【棛】⿰木<育>⿱<𠫓>⿱<亠>⿱丨一厶月
% extra?
begintsuglyph("uni68DB",219);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.raise);
  tsu_render;
endtsuglyph;

% 【棝】⿰木<固>⿴囗<古>⿱十口
% extra?
begintsuglyph("uni68DD",221);
  build_kanji.lr(400,-20)
    (kanji.leftrad.wood)
    (build_kanji.sscale(scaled 0.96)(kanji.grfour.hard));
  tsu_render;
endtsuglyph;

% 【棟】⿰木東
% extra?
begintsuglyph("uni68DF",223);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.east);
  tsu_render;
endtsuglyph;

% 【棡】⿰木<岡>⿵冂<CDP-8CC7>⿱<䒑>⿱丷一山
% extra?
begintsuglyph("uni68E1",225);
  build_kanji.lr(380,10)
    (kanji.leftrad.wood)
    (kanji.greight.hill);
  tsu_render;
endtsuglyph;

% 【棤】⿰木<昔>⿱<龷>⿱<卄>⿻⿰丨丨一一日
% extra?
begintsuglyph("uni68E4",228);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grthree.once_upon_a_time);
  tsu_render;
endtsuglyph;

% 【棪】⿰木<炎>⿱<火>⿱八人<火>⿱八人
% extra?
begintsuglyph("uni68EA",234);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.greight.inflammation);
  tsu_render;
endtsuglyph;

% 【棭】⿰木<夜>⿱<亠>⿱丨一⿰亻<CDP-89F3>⿴夂丶
% extra?
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

% 【棯】⿰木<念>⿱<今>⿱<CDP-8AFC>⿵𠆢一<CDP-8BA2>;心
% extra?
begintsuglyph("uni68EF",239);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.care);
  tsu_render;
endtsuglyph;

% 【棴】⿰木<服>⿰月<𠬝>⿸卩又
% extra?
begintsuglyph("uni68F4",244);
  build_kanji.lr(370,20)
    (kanji.leftrad.wood)
    (kanji.grthree.clothing);
  tsu_render;
endtsuglyph;

% 【棵】⿰木<果>⿻日木
% extra?
begintsuglyph("uni68F5",245);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    (kanji.grfour.fruit);
  tsu_render;
endtsuglyph;

% 【棷】⿰木<取>⿸耳又
% extra?
begintsuglyph("uni68F7",247);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (build_kanji.sscale(shifted (0,30))(kanji.grthree.take));
  tsu_render;
endtsuglyph;

% 【棺】⿰木<官>⿱宀㠯
% extra?
begintsuglyph("uni68FA",250);
  build_kanji.lr(400,0)
    (kanji.leftrad.wood)
    (kanji.grfour.bureaucracy);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
