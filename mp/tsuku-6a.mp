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
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
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

% 【樀】⿰木<啇>⿱<CDP-8BAE>⿱<亠>⿱丨一丷<CDP-8C6C>⿵冂<古>⿱十口
% extra?
begintsuglyph("uni6A00",0);
  tsu_render;
endtsuglyph;

% 【樈】⿰木<竟>⿱<音>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一日<儿>⿰丿乚
% extra?
begintsuglyph("uni6A08",8);
  tsu_render;
endtsuglyph;

% 【樋】⿰木<通>⿺辶<甬>⿱龴<用>⿵冂<CDP-8BF1>⿻<二>⿱一一丨
% extra?
begintsuglyph("uni6A0B",11);
  tsu_render;
endtsuglyph;

% 【樌】⿰木<貫>⿱毌<貝>⿱目八
% extra?
begintsuglyph("uni6A0C",12);
  tsu_render;
endtsuglyph;

% 【樍】⿰木<責>⿱龶<貝>⿱目八
% extra?
begintsuglyph("uni6A0D",13);
  tsu_render;
endtsuglyph;

% 【樎】⿰木<宿>⿱宀<佰>⿰亻<百>⿱一白
% extra?
begintsuglyph("uni6A0E",14);
  tsu_render;
endtsuglyph;

% 【樘】⿰木<堂>⿱<𫩠>⿱<龸>⿱⺌冖口<土>⿱十一
% extra?
begintsuglyph("uni6A18",24);
  tsu_render;
endtsuglyph;

% hyou/shirobe "symbol"
begintsuglyph("uni6A19",25);
  kanji.grfour.symbol;
  tsu_render;
endtsuglyph;

% 【樟】⿰木<章>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一<早>⿱日十
% extra?
begintsuglyph("uni6A1F",31);
  tsu_render;
endtsuglyph;

% 【樢】⿰木<鳥>⿹<CDP-8CBB>;灬
% extra?
begintsuglyph("uni6A22",34);
  tsu_render;
endtsuglyph;

% 【樧】⿰木<殺>⿰⿱㐅木<殳>⿱几又
% extra?
begintsuglyph("uni6A27",39);
  tsu_render;
endtsuglyph;

% ou/yoku "sideways"
begintsuglyph("uni6A2A",42);
  kanji.grthree.sideways;
  tsu_render;
endtsuglyph;

% 【樰】⿰木<雪>⿱<雨>⿱一<𠕒>⿻冂<CDP-8C41>⿻丨<CDP-89AE>⿱丷八彐
% extra?
begintsuglyph("uni6A30",48);
  tsu_render;
endtsuglyph;

% 【樶】⿰木<最>⿱日<取>⿸耳又
% extra?
begintsuglyph("uni6A36",54);
  tsu_render;
endtsuglyph;

% 【樸】⿰木<菐>⿳<业>⿱<CDP-85F0>;一<䒑>⿱丷一<夫>⿻<二>⿱一一人
% extra?
begintsuglyph("uni6A38",56);
  tsu_render;
endtsuglyph;

% 【樼】⿰木<孱>⿸尸<孨>⿱子<孖>⿰子子
% extra?
begintsuglyph("uni6A3C",60);
  tsu_render;
endtsuglyph;

% 【橅】⿰木<無>⿱<CDP-8BBE>⿳𠂉卌一灬
% extra?
begintsuglyph("uni6A45",69);
  tsu_render;
endtsuglyph;

% kyou/hashi "bridge"
begintsuglyph("uni6A4B",75);
  kanji.grthree.bridge;
  tsu_render;
endtsuglyph;

% 【橌】⿰木<閒>⿵<門>⿰𠁣𠃛月
% extra?
begintsuglyph("uni6A4C",76);
  tsu_render;
endtsuglyph;

% 【橍】⿰木<閏>⿵<門>⿰𠁣𠃛<王>⿱一<土>⿱十一
% extra?
begintsuglyph("uni6A4D",77);
  tsu_render;
endtsuglyph;

% 【橎】⿰木<番>⿱<釆>⿱丿米田
% extra?
begintsuglyph("uni6A4E",78);
  tsu_render;
endtsuglyph;

% 【橒】⿰木<雲>⿱<雨>⿱一<𠕒>⿻冂<CDP-8C41>⿻丨<CDP-89AE>⿱丷八<云>⿱<二>⿱一一厶
% extra?
begintsuglyph("uni6A52",82);
  tsu_render;
endtsuglyph;

% 【橗】⿰木<萌>⿱<艹>⿻十丨<明>⿰日月
% extra?
begintsuglyph("uni6A57",87);
  tsu_render;
endtsuglyph;

% 【橙】⿰木<登>⿱<癶>⿰<CDP-88D3>;<CDP-88D5>;豆
% extra?
begintsuglyph("uni6A59",89);
  tsu_render;
endtsuglyph;

% ki/hata "aircraft"
begintsuglyph("uni6A5F",95);
  kanji.grfour.aircraft;
  tsu_render;
endtsuglyph;

% 【橡】⿰木<象>⿳⺈<𫩏>⿴囗丨𧰨
% extra?
begintsuglyph("uni6A61",97);
  tsu_render;
endtsuglyph;

% 【橦】⿰木<童>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一<里>⿱<CDP-8BD9>⿻甲一一
% extra?
begintsuglyph("uni6A66",102);
  tsu_render;
endtsuglyph;

% 【橨】⿰木<賁>⿱⿱十<卄>⿻⿰丨丨一<貝>⿱目八
% extra?
begintsuglyph("uni6A68",104);
  tsu_render;
endtsuglyph;

% 【橪】⿰木<然>⿱<CDP-8BB5>⿰<CDP-88F0>⿴𠂊冫犬灬
% extra?
begintsuglyph("uni6A6A",106);
  tsu_render;
endtsuglyph;

% 【橮】⿰木<貿>⿱<CDP-8C69>⿰<CDP-88EE>;<刀>⿹𠃌丿<貝>⿱目八
% extra?
begintsuglyph("uni6A6E",110);
  tsu_render;
endtsuglyph;

% 【橲】⿰木<喜>⿱<壴>⿱十豆口
% extra?
begintsuglyph("uni6A72",114);
  tsu_render;
endtsuglyph;

% 【橳】⿰木<勝>⿰月<劵>⿱<𠔉>⿱八<夫>⿻<二>⿱一一人<力>⿻丿𠃌
% extra?
begintsuglyph("uni6A73",115);
  tsu_render;
endtsuglyph;

% 【橵】⿰木<散>⿰<CDP-8CEC>⿱<龷>⿱<卄>⿻⿰丨丨一一<⺼>⿵⺆冫攵
% extra?
begintsuglyph("uni6A75",117);
  tsu_render;
endtsuglyph;

% 【橺】⿰木<間>⿵<門>⿰𠁣𠃛日
% extra?
begintsuglyph("uni6A7A",122);
  tsu_render;
endtsuglyph;

% 【橽】⿰木<達>⿺辶<𦍒>⿱<土>⿱十一<羊>⿱<䒑>⿱丷一<CDP-8BF1>⿻<二>⿱一一丨
% extra?
begintsuglyph("uni6A7D",125);
  tsu_render;
endtsuglyph;

% 【檂】⿰木<農>⿱曲<辰>⿸厂⿱<二>⿱一一<CDP-8CC6>⿰𠄌⿺乀丿
% extra?
begintsuglyph("uni6A82",130);
  tsu_render;
endtsuglyph;

% 【檍】⿰木<意>⿱<音>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一日心
% extra?
begintsuglyph("uni6A8D",141);
  tsu_render;
endtsuglyph;

% 【檏】⿰木<業>⿱<业>⿱<CDP-85F0>;一<𦍎>⿱<䒑>⿱丷一未
% extra?
begintsuglyph("uni6A8F",143);
  tsu_render;
endtsuglyph;

% 【檘】⿰木<辟>⿰<𡰪>⿸尸口<辛>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一十
% extra?
begintsuglyph("uni6A98",152);
  tsu_render;
endtsuglyph;

% 【檛】⿰木<過>⿺辶<咼>⿵<冎>⿱⿵冂<CDP-86E8>;冂口
% extra?
begintsuglyph("uni6A9B",155);
  tsu_render;
endtsuglyph;

% 【檞】⿰木<解>⿰角<CDP-8C68>⿱<刀>⿹𠃌丿牛
% extra?
begintsuglyph("uni6A9E",158);
  tsu_render;
endtsuglyph;

% 【檟】⿰木<賈>⿱<覀>⿱一<CDP-86EA>⿻<〢>⿰丨丨口<貝>⿱目八
% extra?
begintsuglyph("uni6A9F",159);
  tsu_render;
endtsuglyph;

% 【檤】⿰木<道>⿺辶<首>⿱丷<𦣻>⿱一自
% extra?
begintsuglyph("uni6AA4",164);
  tsu_render;
endtsuglyph;

% 【檥】⿰木<義>⿱<𦍌>⿱<䒑>⿱丷一<土>⿱十一我
% extra?
begintsuglyph("uni6AA5",165);
  tsu_render;
endtsuglyph;

% 【檪】⿰木<楽>⿱⿴<CDP-89AE>⿱丷八白木
% extra?
begintsuglyph("uni6AAA",170);
  tsu_render;
endtsuglyph;

% 【檫】⿰木<察>⿱宀<祭>⿱<CDP-8C4F>⿰<CDP-88F0>⿴𠂊冫<CDP-8C4E>;示
% extra?
begintsuglyph("uni6AAB",171);
  tsu_render;
endtsuglyph;

% 【檭】⿰木<銀>⿰金艮
% extra?
begintsuglyph("uni6AAD",173);
  tsu_render;
endtsuglyph;

% 【櫇】⿰木<頗>⿰皮頁
% extra?
begintsuglyph("uni6AC7",199);
  tsu_render;
endtsuglyph;

% 【櫌】⿰木<憂>⿱<㥑>⿱<CDP-8CD4>;心夂
% extra?
begintsuglyph("uni6ACC",204);
  tsu_render;
endtsuglyph;

% 【櫍】⿰木<質>⿱<斦>⿰<斤>⿸𠂆<丅>⿱一丨<斤>⿸𠂆<丅>⿱一丨<貝>⿱目八
% extra?
begintsuglyph("uni6ACD",205);
  tsu_render;
endtsuglyph;

% 【櫕】⿰木<賛>⿱<㚘>⿰<夫>⿻<二>⿱一一人<夫>⿻<二>⿱一一人<貝>⿱目八
% extra?
begintsuglyph("uni6AD5",213);
  tsu_render;
endtsuglyph;

% 【櫛】⿰木<節>⿱<竹>⿰亇亇<即>⿰<CDP-8B7C>;卩
% extra?
begintsuglyph("uni6ADB",219);
  tsu_render;
endtsuglyph;

% 【櫧】⿰木<諸>⿰言<者>⿸耂日
% extra?
begintsuglyph("uni6AE7",231);
  tsu_render;
endtsuglyph;

% 【櫬】⿰木<親>⿰<亲>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一朩<見>⿱目<儿>⿰丿乚
% extra?
begintsuglyph("uni6AEC",236);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
