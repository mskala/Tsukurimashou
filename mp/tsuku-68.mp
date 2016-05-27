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
input buildkanji.mp;
input gradeeight.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
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
  build_kanji.lr(480,80)
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

% 【栂】⿰木母
% extra?
begintsuglyph("uni6802",2);
  tsu_render;
endtsuglyph;

% ei/saka "prosperity"
begintsuglyph("uni6804",4);
  kanji.grfour.prosperity;
  tsu_render;
endtsuglyph;

% 【标】⿰木示
% extra?
begintsuglyph("uni6807",7);
  tsu_render;
endtsuglyph;

% 【栈】⿰木<戋>⿻<戈>⿻<弋>⿺<𫠠>⿻一乚丶丿一
% extra?
begintsuglyph("uni6808",8);
  tsu_render;
endtsuglyph;

% 【栍】⿰木生
% extra?
begintsuglyph("uni680D",13);
  tsu_render;
endtsuglyph;

% 【栐】⿰木永
% extra?
begintsuglyph("uni6810",16);
  tsu_render;
endtsuglyph;

% 【栓】⿰木<全>⿱𠆢<王>⿱一<土>⿱十一
% extra?
begintsuglyph("uni6813",19);
  tsu_render;
endtsuglyph;

% 【栕】⿰木臣
% extra?
begintsuglyph("uni6815",21);
  tsu_render;
endtsuglyph;

% 【栖】⿰木<西>⿱一<𠁤>⿻<儿>⿰丿乚口
% extra?
begintsuglyph("uni6816",22);
  tsu_render;
endtsuglyph;

% 【栘】⿰木<多>⿱<夕>⿴𠂊丶<夕>⿴𠂊丶
% extra?
begintsuglyph("uni6818",24);
  tsu_render;
endtsuglyph;

% 【栛】⿰木<劦>⿱<力>⿻丿𠃌<𠠴>⿰<力>⿻丿𠃌<力>⿻丿𠃌
% extra?
begintsuglyph("uni681B",27);
  tsu_render;
endtsuglyph;

% 【栝】⿰木<舌>⿱<千>⿱丿十口
% extra?
begintsuglyph("uni681D",29);
  tsu_render;
endtsuglyph;

% 【栟】⿰木<并>⿱丷<开>⿱一<廾>⿻一<CDP-8BF5>⿰丿丨
% extra?
begintsuglyph("uni681F",31);
  tsu_render;
endtsuglyph;

% kou "school"
begintsuglyph("uni6821",33);
  kanji.grone.school;
  tsu_render;
endtsuglyph;

% 【栢】⿰木<百>⿱一白
% extra?
begintsuglyph("uni6822",34);
  tsu_render;
endtsuglyph;

% 【栣】⿰木<任>⿰亻壬
% extra?
begintsuglyph("uni6823",35);
  tsu_render;
endtsuglyph;

% 【栦】⿰木州
% extra?
begintsuglyph("uni6826",38);
  tsu_render;
endtsuglyph;

% 【栨】⿰木<次>⿰冫欠
% extra?
begintsuglyph("uni6828",40);
  tsu_render;
endtsuglyph;

% 【栩】⿰木<羽>⿰<习>⿹𠃌冫<习>⿹𠃌冫
% extra?
begintsuglyph("uni6829",41);
  tsu_render;
endtsuglyph;

% 【栫】⿰木<存>⿸<CDP-88F1>;子
% extra?
begintsuglyph("uni682B",43);
  tsu_render;
endtsuglyph;

% 【栬】⿰木<色>⿱⺈巴
% extra?
begintsuglyph("uni682C",44);
  tsu_render;
endtsuglyph;

% 【栮】⿰木耳
% extra?
begintsuglyph("uni682E",46);
  tsu_render;
endtsuglyph;

% 【栯】⿰木<有>⿸𠂇月
% extra?
begintsuglyph("uni682F",47);
  tsu_render;
endtsuglyph;

% 【栰】⿰木<伐>⿰亻<戈>⿻<弋>⿺<𫠠>⿻一乚丶丿
% extra?
begintsuglyph("uni6830",48);
  tsu_render;
endtsuglyph;

% 【栱】⿰木<共>⿱<龷>⿱<卄>⿻⿰丨丨一一八
% extra?
begintsuglyph("uni6831",49);
  tsu_render;
endtsuglyph;

% 【栲】⿰木<考>⿸耂<丂>⿱一㇉
% extra?
begintsuglyph("uni6832",50);
  tsu_render;
endtsuglyph;

% 【栳】⿰木<老>⿸耂<匕>⿺乚丿
% extra?
begintsuglyph("uni6833",51);
  tsu_render;
endtsuglyph;

% 【栵】⿰木<列>⿰<歹>⿱一<夕>⿴𠂊丶刂
% extra?
begintsuglyph("uni6835",53);
  tsu_render;
endtsuglyph;

% 【栶】⿰木<因>⿴囗<大>⿻一人
% extra?
begintsuglyph("uni6836",54);
  tsu_render;
endtsuglyph;

% 【样】⿰木<羊>⿱<䒑>⿱丷一<CDP-8BF1>⿻<二>⿱一一丨
% extra?
begintsuglyph("uni6837",55);
  tsu_render;
endtsuglyph;

% kon/ne "root"
begintsuglyph("uni6839",57);
  kanji.grthree.root;
  tsu_render;
endtsuglyph;

% 【栺】⿰木<旨>⿱<匕>⿺乚丿日
% extra?
begintsuglyph("uni683A",58);
  tsu_render;
endtsuglyph;

% 【栻】⿰木<式>⿹<弋>⿺<𫠠>⿻一乚丶工
% extra?
begintsuglyph("uni683B",59);
  tsu_render;
endtsuglyph;

% 【格】⿰木<各>⿱夂口
% extra?
begintsuglyph("uni683C",60);
  tsu_render;
endtsuglyph;

% 【栿】⿰木<伏>⿰亻犬
% extra?
begintsuglyph("uni683F",63);
  tsu_render;
endtsuglyph;

% 【桁】⿰木<行>⿰彳<亍>⿱一<丁>⿱一亅
% extra?
begintsuglyph("uni6841",65);
  tsu_render;
endtsuglyph;

% 【桂】⿰木<圭>⿱<土>⿱十一<土>⿱十一
% extra?
begintsuglyph("uni6842",66);
  tsu_render;
endtsuglyph;

% 【桃】⿰木兆
% extra?
begintsuglyph("uni6843",67);
  tsu_render;
endtsuglyph;

% 【桄】⿰木<光>⿳⺌一<儿>⿰丿乚
% extra?
begintsuglyph("uni6844",68);
  tsu_render;
endtsuglyph;

% 【框】⿰木<匡>⿷匚<王>⿱一<土>⿱十一
% extra?
begintsuglyph("uni6846",70);
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
  tsu_render;
endtsuglyph;

% 【桎】⿰木<至>⿱<𠫔>⿱一厶<土>⿱十一
% extra?
begintsuglyph("uni684E",78);
  tsu_render;
endtsuglyph;

% 【桐】⿰木<同>⿵<𠔼>⿵冂一口
% extra?
begintsuglyph("uni6850",80);
  tsu_render;
endtsuglyph;

% 【桔】⿰木<吉>⿱<士>⿱十一口
% extra?
begintsuglyph("uni6854",84);
  tsu_render;
endtsuglyph;

% 【桖】⿰木<血>⿱丿皿
% extra?
begintsuglyph("uni6856",86);
  tsu_render;
endtsuglyph;

% 【桘】⿰木<𠂤>⿱丿㠯
% extra?
begintsuglyph("uni6858",88);
  tsu_render;
endtsuglyph;

% 【桙】⿰木<牟>⿱厶牛
% extra?
begintsuglyph("uni6859",89);
  tsu_render;
endtsuglyph;

% 【档】⿰木<当>⿱⺌彐
% extra?
begintsuglyph("uni6863",99);
  tsu_render;
endtsuglyph;

% 【桧】⿰木<会>⿱𠆢<云>⿱<二>⿱一一厶
% extra?
begintsuglyph("uni6867",103);
  tsu_render;
endtsuglyph;

% 【桩】⿰木<庄>⿸广<土>⿱十一
% extra?
begintsuglyph("uni6869",105);
  tsu_render;
endtsuglyph;

% 【桭】⿰木<辰>⿸厂⿱<二>⿱一一<CDP-8CC6>⿰𠄌⿺乀丿
% extra?
begintsuglyph("uni686D",109);
  tsu_render;
endtsuglyph;

% 【桮】⿰木<否>⿱<不>⿱一<CDP-8665>;口
% extra?
begintsuglyph("uni686E",110);
  tsu_render;
endtsuglyph;

% 【桴】⿰木<孚>⿱<爫>⿱丿⿲丿丶丶子
% extra?
begintsuglyph("uni6874",116);
  tsu_render;
endtsuglyph;

% 【桵】⿰木<妥>⿱<爫>⿱丿⿲丿丶丶女
% extra?
begintsuglyph("uni6875",117);
  tsu_render;
endtsuglyph;

% 【桶】⿰木<甬>⿱龴<用>⿵冂<CDP-8BF1>⿻<二>⿱一一丨
% extra?
begintsuglyph("uni6876",118);
  tsu_render;
endtsuglyph;

% 【桷】⿰木角
% extra?
begintsuglyph("uni6877",119);
  tsu_render;
endtsuglyph;

% 【桸】⿰木<希>⿱㐅<布>⿸𠂇巾
% extra?
begintsuglyph("uni6878",120);
  tsu_render;
endtsuglyph;

% 【桹】⿰木<良>⿱丨艮
% extra?
begintsuglyph("uni6879",121);
  tsu_render;
endtsuglyph;

% 【桾】⿰木<君>⿸<尹>⿻<CDP-8BAB>⿻<CDP-8C78>;一丿口
% extra?
begintsuglyph("uni687E",126);
  tsu_render;
endtsuglyph;

% 【梀】⿰木束
% extra?
begintsuglyph("uni6880",128);
  tsu_render;
endtsuglyph;

% 【梂】⿰木<求>⿺<CDP-85DC>⿻一<氺>⿻亅<CDP-89AE>⿱丷八丶
% extra?
begintsuglyph("uni6882",130);
  tsu_render;
endtsuglyph;

% 【梃】⿰木<廷>⿺廴壬
% extra?
begintsuglyph("uni6883",131);
  tsu_render;
endtsuglyph;

% 【梄】⿰木酉
% extra?
begintsuglyph("uni6884",132);
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
  tsu_render;
endtsuglyph;

% 【梌】⿰木<余>⿱<CDP-8AFC>⿵𠆢一朩
% extra?
begintsuglyph("uni688C",140);
  tsu_render;
endtsuglyph;

% 【梏】⿰木<告>⿱𠂒口
% extra?
begintsuglyph("uni688F",143);
  tsu_render;
endtsuglyph;

% 【梓】⿰木<辛>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一十
% extra?
begintsuglyph("uni6893",147);
  tsu_render;
endtsuglyph;

% 【梖】⿰木<貝>⿱目八
% extra?
begintsuglyph("uni6896",150);
  tsu_render;
endtsuglyph;

% 【梗】⿰木<更>⿱一<CDP-89E7>⿻日<乂>⿻丿乀
% extra?
begintsuglyph("uni6897",151);
  tsu_render;
endtsuglyph;

% 【梘】⿰木<見>⿱目<儿>⿰丿乚
% extra?
begintsuglyph("uni6898",152);
  tsu_render;
endtsuglyph;

% 【梚】⿰木<免>⿳⺈<𫩏>⿴囗丨<儿>⿰丿乚
% extra?
begintsuglyph("uni689A",154);
  tsu_render;
endtsuglyph;

% 【梠】⿰木<呂>⿳口丿口
% extra?
begintsuglyph("uni68A0",160);
  tsu_render;
endtsuglyph;

% 【梡】⿰木<完>⿱宀<元>⿱一<兀>⿱一<儿>⿰丿乚
% extra?
begintsuglyph("uni68A1",161);
  tsu_render;
endtsuglyph;

% 【梢】⿰木<肖>⿱⺌月
% extra?
begintsuglyph("uni68A2",162);
  tsu_render;
endtsuglyph;

% 【梧】⿰木<吾>⿱<五>⿱一𫝀口
% extra?
begintsuglyph("uni68A7",167);
  tsu_render;
endtsuglyph;

% 【梩】⿰木<里>⿱<CDP-8BD9>⿻甲一一
% extra?
begintsuglyph("uni68A9",169);
  tsu_render;
endtsuglyph;

% 【梪】⿰木豆
% extra?
begintsuglyph("uni68AA",170);
  tsu_render;
endtsuglyph;

% 【梮】⿰木<局>⿸尸⿹𠃌口
% extra?
begintsuglyph("uni68AE",174);
  tsu_render;
endtsuglyph;

% 【梯】⿰木<弟>⿱丷<𢎨>⿹<弔>⿻弓丨丿
% extra?
begintsuglyph("uni68AF",175);
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
  tsu_render;
endtsuglyph;

% 【梳】⿰木<㐬>⿱<𠫓>⿱<亠>⿱丨一厶<𫶧>⿴<儿>⿰丿乚丨
% extra?
begintsuglyph("uni68B3",179);
  tsu_render;
endtsuglyph;

% 【梴】⿰木<延>⿺廴<CDP-8D62>⿱丿止
% extra?
begintsuglyph("uni68B4",180);
  tsu_render;
endtsuglyph;

% 【梶】⿰木<尾>⿸尸毛
% extra?
begintsuglyph("uni68B6",182);
  tsu_render;
endtsuglyph;

% 【梸】⿰木<利>⿰<禾>⿱丿木刂
% extra?
begintsuglyph("uni68B8",184);
  tsu_render;
endtsuglyph;

% 【梹】⿰木<兵>⿱丘八
% extra?
begintsuglyph("uni68B9",185);
  tsu_render;
endtsuglyph;

% 【梽】⿰木<志>⿱<士>⿱十一心
% extra?
begintsuglyph("uni68BD",189);
  tsu_render;
endtsuglyph;

% 【梾】⿰木来
% extra?
begintsuglyph("uni68BE",190);
  tsu_render;
endtsuglyph;

% 【棁】⿰木<兑>⿱丷<兄>⿱口<儿>⿰丿乚
% extra?
begintsuglyph("uni68C1",193);
  tsu_render;
endtsuglyph;

% 【棆】⿰木<侖>⿱<CDP-8AFC>⿵𠆢一<𠕁>⿵冂<卄>⿻⿰丨丨一
% extra?
begintsuglyph("uni68C6",198);
  tsu_render;
endtsuglyph;

% 【棇】⿰木<忩>⿱<公>⿱八厶心
% extra?
begintsuglyph("uni68C7",199);
  tsu_render;
endtsuglyph;

% 【棋】⿰木<其>⿱<CDP-8B72>⿱<CDP-88C8>;一八
% extra?
begintsuglyph("uni68CB",203);
  tsu_render;
endtsuglyph;

% 【棌】⿰木<采>⿱<爫>⿱丿⿲丿丶丶木
% extra?
begintsuglyph("uni68CC",204);
  tsu_render;
endtsuglyph;

% 【棑】⿰木非
% extra?
begintsuglyph("uni68D1",209);
  tsu_render;
endtsuglyph;

% 【棕】⿰木<宗>⿱宀示
% extra?
begintsuglyph("uni68D5",213);
  tsu_render;
endtsuglyph;

% 【棖】⿰木<長>⿳<CDP-884A>;一<CDP-8CC6>⿰𠄌⿺乀丿
% extra?
begintsuglyph("uni68D6",214);
  tsu_render;
endtsuglyph;

% 【棛】⿰木<育>⿱<𠫓>⿱<亠>⿱丨一厶月
% extra?
begintsuglyph("uni68DB",219);
  tsu_render;
endtsuglyph;

% 【棝】⿰木<固>⿴囗<古>⿱十口
% extra?
begintsuglyph("uni68DD",221);
  tsu_render;
endtsuglyph;

% 【棟】⿰木東
% extra?
begintsuglyph("uni68DF",223);
  tsu_render;
endtsuglyph;

% 【棡】⿰木<岡>⿵冂<CDP-8CC7>⿱<䒑>⿱丷一山
% extra?
begintsuglyph("uni68E1",225);
  tsu_render;
endtsuglyph;

% 【棤】⿰木<昔>⿱<龷>⿱<卄>⿻⿰丨丨一一日
% extra?
begintsuglyph("uni68E4",228);
  tsu_render;
endtsuglyph;

% 【棪】⿰木<炎>⿱<火>⿱八人<火>⿱八人
% extra?
begintsuglyph("uni68EA",234);
  tsu_render;
endtsuglyph;

% 【棭】⿰木<夜>⿱<亠>⿱丨一⿰亻<CDP-89F3>⿴夂丶
% extra?
begintsuglyph("uni68ED",237);
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
  tsu_render;
endtsuglyph;

% 【棴】⿰木<服>⿰月<𠬝>⿸卩又
% extra?
begintsuglyph("uni68F4",244);
  tsu_render;
endtsuglyph;

% 【棵】⿰木<果>⿻日木
% extra?
begintsuglyph("uni68F5",245);
  tsu_render;
endtsuglyph;

% 【棷】⿰木<取>⿸耳又
% extra?
begintsuglyph("uni68F7",247);
  tsu_render;
endtsuglyph;

% 【棺】⿰木<官>⿱宀㠯
% extra?
begintsuglyph("uni68FA",250);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
