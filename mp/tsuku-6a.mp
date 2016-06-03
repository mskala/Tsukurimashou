%
% Unicode page 6A (Kanji) for Tsukurimashou
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

%tsukurimashou.eids:【啇】⿱?([kanji.bottomrad.stalk,[kanji.radical.gmm,push_stroke,replace_strokep,replace_strokep],[build_kanji.tb,eids.u2ff1._1.1_,[kanji.grone.ten,push_stroke,push_stroke],[build_kanji.box,push_stroke,push_stroke]]])
%tsukurimashou.eids:【啇】(uni5547: kanji.rare.stalk, rare.mp)
% 【樀】⿰木<啇>⿱<CDP-8BAE>⿱<亠>⿱丨一丷<CDP-8C6C>⿵冂<古>⿱十口
% extra?
begintsuglyph("uni6A00",0);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【竟】⿱立⿱<日>⿻口(+1)儿
%tsukurimashou.eids:【竟】(uni7ADF: kanji.rare.finally, rare.mp)
% 【樈】⿰木<竟>⿱<音>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一日<儿>⿰丿乚
% extra?
begintsuglyph("uni6A08",8);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【通】⿺⻌甬
%tsukurimashou.eids:【通】(uni901A: kanji.grtwo.traffic, tsuku-90.mp)
% 【樋】⿰木<通>⿺辶<甬>⿱龴<用>⿵冂<CDP-8BF1>⿻<二>⿱一一丨
% extra?
begintsuglyph("uni6A0B",11);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【貫】⿱<毌>⿻?(+1)<貝>⿱<目>⿻口(+2)?
%tsukurimashou.eids:【貫】(uni8CAB: kanji.greight.sushi_counter, gradeeight.mp)
% 【樌】⿰木<貫>⿱毌<貝>⿱目八
% extra?
begintsuglyph("uni6A0C",12);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【責】⿱?<貝>⿱<目>⿻口(+2)?
%tsukurimashou.eids:【責】(uni8CAC: kanji.grfive.blame, gradefive.mp)
% 【樍】⿰木<責>⿱龶<貝>⿱目八
% extra?
begintsuglyph("uni6A0D",13);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【宿】⿱<宀>⿻冖(+1)<佰>⿰亻<百>⿻<日>⿻口(+1)(+2)
%tsukurimashou.eids:【宿】(uni5BBF: kanji.grthree.inn, tsuku-5b.mp)
% 【樎】⿰木<宿>⿱宀<佰>⿰亻<百>⿱一白
% extra?
begintsuglyph("uni6A0E",14);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【堂】⿱⿱<⺌>⿻?(+1)⿱冖口土
%tsukurimashou.eids:【堂】(uni5802: kanji.grfour.hall, gradefour.mp)
% 【樘】⿰木<堂>⿱<𫩠>⿱<龸>⿱⺌冖口<土>⿱十一
% extra?
begintsuglyph("uni6A18",24);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% hyou/shirobe "symbol"
begintsuglyph("uni6A19",25);
  kanji.grfour.symbol;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【章】⿱?<早>⿱<日>⿻口(+1)十
%tsukurimashou.eids:【章】(uni7AE0: kanji.grthree.chapter, gradethree.mp)
% 【樟】⿰木<章>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一<早>⿱日十
% extra?
begintsuglyph("uni6A1F",31);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【鳥】;
%tsukurimashou.eids:【鳥】(uni9CE5: kanji.grtwo.bird, gradetwo.mp)
% 【樢】⿰木<鳥>⿹<CDP-8CBB>;灬
% extra?
begintsuglyph("uni6A22",34);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【殺】⿰⿱?木<殳>⿱几又
%tsukurimashou.eids:【殺】(uni6BBA: kanji.grfour.kill, tsuku-6b.mp)
% 【樧】⿰木<殺>⿰⿱㐅木<殳>⿱几又
% extra?
begintsuglyph("uni6A27",39);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% ou/yoku "sideways"
begintsuglyph("uni6A2A",42);
  kanji.grthree.sideways;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【雪】⿱⻗?
%tsukurimashou.eids:【雪】(uni96EA: kanji.grtwo.snow, tsuku-96.mp)
% 【樰】⿰木<雪>⿱<雨>⿱一<𠕒>⿻冂<CDP-8C41>⿻丨<CDP-89AE>⿱丷八彐
% extra?
begintsuglyph("uni6A30",48);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【最】⿱<日>⿻口(+1)<取>⿰耳又
%tsukurimashou.eids:【最】(uni6700: kanji.grfour.utmost, gradefour.mp)
% 【樶】⿰木<最>⿱日<取>⿸耳又
% extra?
begintsuglyph("uni6A36",54);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【菐】⿱⿻?(+1)<⺸>⿻<羊>([kanji.grthree.sheep,[kanji.grone.three,push_stroke,push_stroke,push_stroke],[kanji.toprad.sparkle_two,push_stroke,push_stroke],push_stroke])(+1*1)
%tsukurimashou.eids:【菐】(uni83D0: kanji.rare.eight_three_dee_zero, rare.mp)
% 【樸】⿰木<菐>⿳<业>⿱<CDP-85F0>;一<䒑>⿱丷一<夫>⿻<二>⿱一一人
% extra?
begintsuglyph("uni6A38",56);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【孱】⿸尸⿱子⿰子子
% 【樼】⿰木<孱>⿸尸<孨>⿱子<孖>⿰子子
% extra?
begintsuglyph("uni6A3C",60);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【無】⿱?⺣
%tsukurimashou.eids:【無】(uni7121: kanji.grfour.nothing, gradefour.mp)
% 【橅】⿰木<無>⿱<CDP-8BBE>⿳𠂉卌一灬
% extra?
begintsuglyph("uni6A45",69);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% kyou/hashi "bridge"
begintsuglyph("uni6A4B",75);
  kanji.grthree.bridge;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【閒】⿵門月
% 【橌】⿰木<閒>⿵<門>⿰𠁣𠃛月
% extra?
begintsuglyph("uni6A4C",76);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【閏】⿵門王
%tsukurimashou.eids:【閏】(uni958F: kanji.grnine.leap_year, tsuku-95.mp)
% 【橍】⿰木<閏>⿵<門>⿰𠁣𠃛<王>⿱一<土>⿱十一
% extra?
begintsuglyph("uni6A4D",77);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【番】⿱<釆>⿱丿<米>⿱?木<田>⿻口(+2)
%tsukurimashou.eids:【番】(uni756A: kanji.grtwo.ordinal, gradetwo.mp)
% 【橎】⿰木<番>⿱<釆>⿱丿米田
% extra?
begintsuglyph("uni6A4E",78);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【雲】⿱⻗<云>⿻厶(+1*2)
%tsukurimashou.eids:【雲】(uni96F2: kanji.grtwo.cloud, tsuku-96.mp)
% 【橒】⿰木<雲>⿱<雨>⿱一<𠕒>⿻冂<CDP-8C41>⿻丨<CDP-89AE>⿱丷八<云>⿱<二>⿱一一厶
% extra?
begintsuglyph("uni6A52",82);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【萌】⿱艹<明>⿰<日>⿻口(+1)月
%tsukurimashou.eids:【萌】(uni840C: kanji.grnine.moe, tsuku-84.mp)
% 【橗】⿰木<萌>⿱<艹>⿻十丨<明>⿰日月
% extra?
begintsuglyph("uni6A57",87);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【登】⿱癶<豆>⿻口(+4)
%tsukurimashou.eids:【登】(uni767B: kanji.grthree.climb, gradethree.mp)
% 【橙】⿰木<登>⿱<癶>⿰<CDP-88D3>;<CDP-88D5>;豆
% extra?
begintsuglyph("uni6A59",89);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

% ki/hata "aircraft"
begintsuglyph("uni6A5F",95);
  kanji.grfour.aircraft;
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【象】⿱⺈⿱口豕
%tsukurimashou.eids:【象】(uni8C61: kanji.grfour.elephant, gradefour.mp)
% 【橡】⿰木<象>⿳⺈<𫩏>⿴囗丨𧰨
% extra?
begintsuglyph("uni6A61",97);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【童】⿱?<里>⿻口(+4)
%tsukurimashou.eids:【童】(uni7AE5: kanji.grthree.child, gradethree.mp)
% 【橦】⿰木<童>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一<里>⿱<CDP-8BD9>⿻甲一一
% extra?
begintsuglyph("uni6A66",102);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【賁】⿱⿱十艹<貝>⿱<目>⿻口(+2)?
%tsukurimashou.eids:【賁】(uni8CC1: kanji.rare.decorate, rare.mp)
% 【橨】⿰木<賁>⿱⿱十<卄>⿻⿰丨丨一<貝>⿱目八
% extra?
begintsuglyph("uni6A68",104);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【然】⿱⿰⿻夕(+1*1)<犬>⿻大(+1)⺣
%tsukurimashou.eids:【然】(uni7136: kanji.grfour.that_case, tsuku-71.mp)
% 【橪】⿰木<然>⿱<CDP-8BB5>⿰<CDP-88F0>⿴𠂊冫犬灬
% extra?
begintsuglyph("uni6A6A",106);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【貿】⿱⿰?刀<貝>⿱<目>⿻口(+2)?
%tsukurimashou.eids:【貿】(uni8CBF: kanji.grfive.trade, tsuku-8c.mp)
% 【橮】⿰木<貿>⿱<CDP-8C69>⿰<CDP-88EE>;<刀>⿹𠃌丿<貝>⿱目八
% extra?
begintsuglyph("uni6A6E",110);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【喜】⿱<壴>⿱十<豆>⿻口(+4)口
%tsukurimashou.eids:【喜】(uni559C: kanji.grfour.pleasure, gradefour.mp)
% 【橲】⿰木<喜>⿱<壴>⿱十豆口
% extra?
begintsuglyph("uni6A72",114);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【勝】⿰月⿱([[kanji.toprad.sparkle_two,push_stroke,push_stroke],[kanji.grone.person,push_stroke,push_stroke],[kanji.grone.two,push_stroke,push_stroke],replace_strokep])力
%tsukurimashou.eids:【勝】(uni52DD: kanji.grthree.victory, tsuku-52.mp)
% 【橳】⿰木<勝>⿰月<劵>⿱<𠔉>⿱八<夫>⿻<二>⿱一一人<力>⿻丿𠃌
% extra?
begintsuglyph("uni6A73",115);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【散】⿰⿱<龷>⿱艹一⺝攵
%tsukurimashou.eids:【散】(uni6563: kanji.grfour.loose, tsuku-65.mp)
% 【橵】⿰木<散>⿰<CDP-8CEC>⿱<龷>⿱<卄>⿻⿰丨丨一一<⺼>⿵⺆冫攵
% extra?
begintsuglyph("uni6A75",117);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【間】⿵門<日>⿻口(+1)
%tsukurimashou.eids:【間】(uni9593: kanji.grtwo.interval, gradetwo.mp)
% 【橺】⿰木<間>⿵<門>⿰𠁣𠃛日
% extra?
begintsuglyph("uni6A7A",122);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【達】⿺⻌⿱土<羊>([kanji.grthree.sheep,[kanji.grone.three,push_stroke,push_stroke,push_stroke],[kanji.toprad.sparkle_two,push_stroke,push_stroke],push_stroke])
%tsukurimashou.eids:【達】(uni9054: kanji.grfour.plural, tsuku-90.mp)
% 【橽】⿰木<達>⿺辶<𦍒>⿱<土>⿱十一<羊>⿱<䒑>⿱丷一<CDP-8BF1>⿻<二>⿱一一丨
% extra?
begintsuglyph("uni6A7D",125);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【農】⿱<曲>⿻口(+3)<辰>⿸厂⿱二?
%tsukurimashou.eids:【農】(uni8FB2: kanji.grthree.farming, gradethree.mp)
% 【檂】⿰木<農>⿱曲<辰>⿸厂⿱<二>⿱一一<CDP-8CC6>⿰𠄌⿺乀丿
% extra?
begintsuglyph("uni6A82",130);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【意】⿱<音>⿱?<日>⿻口(+1)心
%tsukurimashou.eids:【意】(uni610F: kanji.grthree.intention, gradethree.mp)
% 【檍】⿰木<意>⿱<音>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一日心
% extra?
begintsuglyph("uni6A8D",141);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【業】⿱⿻?(+1)⿻<羊>([kanji.grthree.sheep,[kanji.grone.three,push_stroke,push_stroke,push_stroke],[kanji.toprad.sparkle_two,push_stroke,push_stroke],push_stroke])(+2*1)
%tsukurimashou.eids:【業】(uni696D: kanji.grthree.business, tsuku-69.mp)
% 【檏】⿰木<業>⿱<业>⿱<CDP-85F0>;一<𦍎>⿱<䒑>⿱丷一未
% extra?
begintsuglyph("uni6A8F",143);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【辟】⿰⿸尸口<辛>⿱亠<羊>([kanji.grthree.sheep,[kanji.grone.three,push_stroke,push_stroke,push_stroke],[kanji.toprad.sparkle_two,push_stroke,push_stroke],push_stroke])
%tsukurimashou.eids:【辟】(uni8F9F: kanji.rare.punish, rare.mp)
% 【檘】⿰木<辟>⿰<𡰪>⿸尸口<辛>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一十
% extra?
begintsuglyph("uni6A98",152);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【過】⿺⻌<咼>⿻⿻冂口(+2)
%tsukurimashou.eids:【過】(uni904E: kanji.grfive.pass, tsuku-90.mp)
% 【檛】⿰木<過>⿺辶<咼>⿵<冎>⿱⿵冂<CDP-86E8>;冂口
% extra?
begintsuglyph("uni6A9B",155);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【解】⿰<角>⿱⺈用⿱刀牛
%tsukurimashou.eids:【解】(uni89E3: kanji.grfive.solve, gradefive.mp)
% 【檞】⿰木<解>⿰角<CDP-8C68>⿱<刀>⿹𠃌丿牛
% extra?
begintsuglyph("uni6A9E",158);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【賈】⿱⿻口(+3)<貝>⿱<目>⿻口(+2)?
% 【檟】⿰木<賈>⿱<覀>⿱一<CDP-86EA>⿻<〢>⿰丨丨口<貝>⿱目八
% extra?
begintsuglyph("uni6A9F",159);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【道】⿺⻌<首>⿱⿻?(+1*1)<自>⿱㇒<目>⿻口(+2)
%tsukurimashou.eids:【道】(uni9053: kanji.grtwo.street, gradetwo.mp)
% 【檤】⿰木<道>⿺辶<首>⿱丷<𦣻>⿱一自
% extra?
begintsuglyph("uni6AA4",164);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【義】⿱?<我>⿰⿱丿扌<戈>⿻弋(+1)
%tsukurimashou.eids:【義】(uni7FA9: kanji.grfive.righteousness, gradefive.mp)
% 【檥】⿰木<義>⿱<𦍌>⿱<䒑>⿱丷一<土>⿱十一我
% extra?
begintsuglyph("uni6AA5",165);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【楽】⿻⿱<白>⿱㇒<日>⿻口(+1)木(+4)
%tsukurimashou.eids:【楽】(uni697D: kanji.grtwo.fun, gradetwo.mp)
% 【檪】⿰木<楽>⿱⿴<CDP-89AE>⿱丷八白木
% extra?
begintsuglyph("uni6AAA",170);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【察】⿱<宀>⿻冖(+1)<祭>⿻<示>⿱二小(+7)
%tsukurimashou.eids:【察】(uni5BDF: kanji.grfour.guess, tsuku-5b.mp)
% 【檫】⿰木<察>⿱宀<祭>⿱<CDP-8C4F>⿰<CDP-88F0>⿴𠂊冫<CDP-8C4E>;示
% extra?
begintsuglyph("uni6AAB",171);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【銀】⿰<金>⿱人?艮
%tsukurimashou.eids:【銀】(uni9280: kanji.grthree.silver, tsuku-92.mp)
% 【檭】⿰木<銀>⿰金艮
% extra?
begintsuglyph("uni6AAD",173);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【頗】⿰<皮>⿻<反>⿸厂又(+1*2)<頁>⿱⿻<自>⿱㇒<目>⿻口(+2)(+1)?
%tsukurimashou.eids:【頗】(uni9817: kanji.grnine.extremely, tsuku-98.mp)
% 【櫇】⿰木<頗>⿰皮頁
% extra?
begintsuglyph("uni6AC7",199);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【憂】⿱⿱⿻<自>⿱㇒<目>⿻口(+2)(+1)冖⿱心夂
%tsukurimashou.eids:【憂】(uni6182: kanji.greight.melancholy, gradeeight.mp)
% 【櫌】⿰木<憂>⿱<㥑>⿱<CDP-8CD4>;心夂
% extra?
begintsuglyph("uni6ACC",204);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【質】⿱<斦>⿰斤斤<貝>⿱<目>⿻口(+2)?
%tsukurimashou.eids:【質】(uni8CEA: kanji.grfive.quality, gradefive.mp)
% 【櫍】⿰木<質>⿱<斦>⿰<斤>⿸𠂆<丅>⿱一丨<斤>⿸𠂆<丅>⿱一丨<貝>⿱目八
% extra?
begintsuglyph("uni6ACD",205);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【賛】⿱⿰⿻夫(+1)夫<貝>⿱<目>⿻口(+2)?
%tsukurimashou.eids:【賛】(uni8CDB: kanji.grfive.approve, gradefive.mp)
% 【櫕】⿰木<賛>⿱<㚘>⿰<夫>⿻<二>⿱一一人<夫>⿻<二>⿱一一人<貝>⿱目八
% extra?
begintsuglyph("uni6AD5",213);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【節】⿱⺮<即>⿰?卩
%tsukurimashou.eids:【節】(uni7BC0: kanji.grfour.section, tsuku-7b.mp)
% 【櫛】⿰木<節>⿱<竹>⿰亇亇<即>⿰<CDP-8B7C>;卩
% extra?
begintsuglyph("uni6ADB",219);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【諸】⿰<訁>⿻口(+4)<者>⿻⿱土<日>⿻口(+1)(+1)
%tsukurimashou.eids:【諸】(uni8AF8: kanji.grsix.various, tsuku-8a.mp)
% 【櫧】⿰木<諸>⿰言<者>⿸耂日
% extra?
begintsuglyph("uni6AE7",231);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%tsukurimashou.eids:【親】⿰⿱?木<見>⿱<目>⿻口(+2)儿
%tsukurimashou.eids:【親】(uni89AA: kanji.grtwo.parent, tsuku-89.mp)
% 【櫬】⿰木<親>⿰<亲>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一朩<見>⿱目<儿>⿰丿乚
% extra?
begintsuglyph("uni6AEC",236);
  build_kanji.lr(440,20)
    (kanji.leftrad.wood)
    ();
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
