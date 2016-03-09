%
% Unicode page 61 (Kanji) for Tsukurimashou
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
input gradeone.mp;
input gradethree.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.feeling =
  push_pbox_toexpand("kanji.grthree.feeling");
  build_kanji.level(build_kanji.tb(250,0)
    (kanji.rare.the_same)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.love =
  push_pbox_toexpand("kanji.grfour.love");
  build_kanji.level(build_kanji.tb(430,160)
    (build_kanji.tb(380,160)
       (kanji.toprad.paw)
       (kanji.radical.conservative_hat))
    (build_kanji.tb(460,-40)
       (build_kanji.sscale(xscaled 0.8)(kanji.bottomrad.heart))
       (kanji.radical.winter)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.manner =
  push_pbox_toexpand("kanji.grfive.manner");
  build_kanji.level(build_kanji.tb(230,0)
    (kanji.grfive.talent)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.indignation =
  push_pbox_toexpand("kanji.greight.indignation");
  build_kanji.level(build_kanji.lr(320,50)
    (kanji.leftrad.heart;
     replace_strokep(0)(oldp shifted (0,-50)))
    (kanji.rare.decorate));
  expand_pbox;
enddef;

vardef kanji.greight.rue =
  push_pbox_toexpand("kanji.greight.rue");
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart)
    (kanji.greight.already));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 愀 <6100>⿰忄<79CB>⿰<禾>⿱丿木<火>⿱八人
% 愊 <610A>⿰忄<7550>⿱<𠮛>⿱一口田

% i/moto "intention"
begintsuglyph("uni610F",15);
  kanji.grthree.intention;
  tsu_render;
endtsuglyph;

% 愐 <6110>⿰忄<9762>⿳一丿<囬>⿴囗<CDP-89CC>%
% 愑 <6111>⿰忄<52C7>⿱⿱龴田<力>⿻丿𠃌
% 愓 <6113>⿰忄<661C>⿱<旦>⿱日一<勿>⿹勹<CDP-89A6>⿰丿丿
% 愔 <6114>⿰忄<97F3>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一日

% gaku/odoro "surprised"
begintsuglyph("uni6115",21);
  build_kanji.level(build_kanji.lr(320,50)
    (kanji.leftrad.heart)
    (kanji.rare.outspokenly));
  tsu_render;
endtsuglyph;

% 愘 <6118>⿰忄<5BA2>⿱宀<各>⿱夂口

% ai/ito "romantic love"
begintsuglyph("uni611B",27);
  kanji.grfour.love;
  tsu_render;
endtsuglyph;

% kan "feeling"
begintsuglyph("uni611F",31);
  kanji.grthree.feeling;
  tsu_render;
endtsuglyph;

% 愡 <6121>⿰忄<6031>⿱<匆>⿻<勿>⿹勹<CDP-89A6>⿰丿丿丶心
% 愢 <6122>⿰忄<601D>⿱田心
% 愥 <6125>⿰忄<82F1>⿱<艹>⿻十丨央
% 愩 <6129>⿰忄<8CA2>⿱工<貝>⿱目八
% 愪 <612A>⿰忄<54E1>⿱口<貝>⿱目八
% 愴 <6134>⿰忄<5009>⿱<CDP-8AFC>⿵𠆢一⿸<CDP-89CE>⿴尸一口
% 愵 <6135>⿰忄<5F31>⿰<CDP-8CC4>⿹弓冫<CDP-8CC4>⿹弓冫
% 愹 <6139>⿰忄<5BB9>⿱宀谷
% 愺 <613A>⿰忄<8349>⿱<艹>⿻十丨<早>⿱日十
% 愽 <613D>⿰忄<5C03>⿱<甫>⿺<CDP-86B7>⿻十月丶寸

% tai/waza "manner"
begintsuglyph("uni614B",75);
  kanji.grfive.manner;
  tsu_render;
endtsuglyph;

% 慎 <614E>⿰忄<771F>⿱十<具>⿳目一八
% 慓 <6153>⿰忄<7968>⿱<覀>⿱一<CDP-86EA>⿻<〢>⿰丨丨口示
% 慚 <615A>⿰忄<65AC>⿰車<斤>⿸𠂆<丅>⿱一丨
% 慞 <615E>⿰忄<7AE0>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一<早>⿱日十
% 慟 <615F>⿰忄<52D5>⿰重<力>⿻丿𠃌
% 慥 <6165>⿰忄<9020>⿺辶<告>⿱𠂒口

% gai "rue"
begintsuglyph("uni6168",104);
  kanji.greight.rue;
  tsu_render;
endtsuglyph;

% 慩 <6169>⿰忄<9023>⿺辶車
% 慴 <6174>⿰忄<7FD2>⿱<羽>⿰<习>⿹𠃌冫<习>⿹𠃌冫白
% 慷 <6177>⿰忄<5EB7>⿸广隶

% yuu/ure "melancholy"
begintsuglyph("uni6182",130);
  kanji.greight.melancholy;
  tsu_render;
endtsuglyph;

% 憆 <6186>⿰忄<5802>⿱<𫩠>⿱<龸>⿱⺌冖口<土>⿱十一
% 憍 <618D>⿰忄<55AC>⿱<呑>⿱<夭>⿱丿<大>⿻一人口<冋>⿵冂口
% 憏 <618F>⿰忄<796D>⿱<CDP-8C4F>⿰<CDP-88F0>⿴𠂊冫<CDP-8C4E>%示
% 憕 <6195>⿰忄<767B>⿱<癶>⿰<CDP-88D3>%<CDP-88D5>%豆
% 憘 <6198>⿰忄<559C>⿱<壴>⿱十豆口
% 憣 <61A3>⿰忄<756A>⿱<釆>⿱丿米田

% fun/ikidoo "indignation"
begintsuglyph("uni61A4",164);
  kanji.greight.indignation;
  tsu_render;
endtsuglyph;

% 憧 <61A7>⿰忄<7AE5>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一<里>⿱<CDP-8BD9>⿻甲一一
% 憪 <61AA>⿰忄<9592>⿵<門>⿰𠁣𠃛月
% 憬 <61AC>⿰忄<666F>⿱日<京>⿳<亠>⿱丨一口小
% 憮 <61AE>⿰忄<7121>⿱<CDP-8BBE>⿳𠂉卌一灬
% 憶 <61B6>⿰忄<610F>⿱<音>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一日心
% 憹 <61B9>⿰忄<8FB2>⿱曲<辰>⿸厂⿱<二>⿱一一<CDP-8CC6>⿰𠄌⿺乀丿
% 憾 <61BE>⿰忄<611F>⿱<咸>⿵<戌>⿵戊一口心
% 懈 <61C8>⿰忄<89E3>⿰角<CDP-8C68>⿱<刀>⿹𠃌丿牛
% 懓 <61D3>⿰忄<611B>⿱⿱<CDP-8BB8>⿱<爫>⿱丿⿲丿丶丶冖心夂
% 懩 <61E9>⿰忄<990A>⿱<𦍌>⿱<䒑>⿱丷一<土>⿱十一<食>⿱𠆢<良>⿱丨艮
% 懪 <61EA>⿰忄<66B4>⿱日<㳟>⿱<共>⿱<龷>⿱<卄>⿻⿰丨丨一一八<氺>⿻亅<CDP-89AE>⿱丷八
% 懫 <61EB>⿰忄<8CEA>⿱<斦>⿰<斤>⿸𠂆<丅>⿱一丨<斤>⿸𠂆<丅>⿱一丨<貝>⿱目八
% 懮 <61EE>⿰忄<6182>⿱<㥑>⿱<CDP-8CD4>%心夂

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
