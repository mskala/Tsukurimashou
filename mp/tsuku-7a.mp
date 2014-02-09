%
% Unicode page 7A (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2014  Matthew Skala
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
input gradefive.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.sky =
  push_pbox_toexpand("kanji.grone.sky");
  build_kanji.level(build_kanji.tb(500,70)
    (kanji.toprad.cave)
    (kanji.grtwo.craft));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.child =
  push_pbox_toexpand("kanji.grthree.child");
  build_kanji.level(build_kanji.tb(480,-30)
    (kanji.toprad.stand_up)
    (kanji.grtwo.neighbourhood ));
  expand_pbox;
enddef;

vardef kanji.grthree.research =
  push_pbox_toexpand("kanji.grthree.research");
  build_kanji.level(build_kanji.tb(500,70)
    (kanji.toprad.cave)
    (kanji.grone.nine));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.contest =
  push_pbox_toexpand("kanji.grfour.contest");
  build_kanji.lr(480,-50)
    (kanji.leftrad.contend)
    (kanji.rare.contend);
  expand_pbox;
enddef;

vardef kanji.grfour.load =
  push_pbox_toexpand("kanji.grfour.load");
  build_kanji.lr(420,-20*mincho)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfive.blame);
  expand_pbox;
enddef;

vardef kanji.grfour.seed =
  push_pbox_toexpand("kanji.grfour.seed");
  build_kanji.lr(360,0)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 0.91)(kanji.grthree.heap_big));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.contend =
  push_pbox_toexpand("kanji.leftrad.contend");
  kanji.rare.contend;
  begingroup
    save myxf,myp;
    transform myxf;
    path myp;
    myp=get_strokep(0);
    (0,0) transformed myxf=llcorner myp;
    (1,0) transformed myxf=lrcorner myp;
    (0,1) transformed myxf=ulcorner myp;
    replace_strokep(0)(((0.05,1)--(0.07,0.07)) transformed myxf);
    replace_strokeq(0)((1.7,1.7)--(1.5,1.5));
    push_stroke(((-0.46,0)..tension 1.2..(0.07,0.07)..(1,0.27))
        transformed myxf,
      (1.7,1.7)--(1.5,1.5)--(1,1));
    set_bosize(0)(get_bosize(-1));
  endgroup;
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.rare.contend =
  push_pbox_toexpand("kanji.rare.contend");
  build_kanji.tb(480,-60)
    (kanji.grone.stand_up)
    (kanji.grtwo.big_brother);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 【稀】⿰<禾>⿱丿木<希>⿱㐅<布>⿸𠂇巾
% extra
% begintsuglyph("uni7A00",0);
%   tsu_render;
% endtsuglyph;

% 【稂】⿰<禾>⿱丿木<良>⿱丨艮
% extra
% begintsuglyph("uni7A02",2);
%   tsu_render;
% endtsuglyph;

% 【稃】⿰<禾>⿱丿木<孚>⿱<爫>⿱丿⿲丿丶丶子
% extra
% begintsuglyph("uni7A03",3);
%   tsu_render;
% endtsuglyph;

% 【稇】⿰<禾>⿱丿木<困>⿴囗木
% extra
% begintsuglyph("uni7A07",7);
%   tsu_render;
% endtsuglyph;

% 【稉】⿰<禾>⿱丿木<更>⿱一<CDP-89E7>⿻日<乂>⿻丿乀
% extra
% begintsuglyph("uni7A09",9);
%   tsu_render;
% endtsuglyph;

% 【稊】⿰<禾>⿱丿木<弟>⿱丷<𢎨>⿹<弔>⿻弓丨丿
% extra
% begintsuglyph("uni7A0A",10);
%   tsu_render;
% endtsuglyph;

% 【稌】⿰<禾>⿱丿木<余>⿱<CDP-8AFC>⿵𠆢一朩
% extra
% begintsuglyph("uni7A0C",12);
%   tsu_render;
% endtsuglyph;

% 【稍】⿰<禾>⿱丿木<肖>⿱⺌月
% extra
% begintsuglyph("uni7A0D",13);
%   tsu_render;
% endtsuglyph;

% 【税】⿰<禾>⿱丿木<兑>⿱丷<兄>⿱口<儿>⿰丿乚
% grade five LOOK UP
% begintsuglyph("uni7A0E",14);
%   tsu_render;
% endtsuglyph;

% 【稐】⿰<禾>⿱丿木<侖>⿱<CDP-8AFC>⿵𠆢一<𠕁>⿵冂<卄>⿻⿰丨丨一
% extra
% begintsuglyph("uni7A10",16);
%   tsu_render;
% endtsuglyph;

% 【稑】⿰<禾>⿱丿木<坴>⿱<圥>⿱<土>⿱十一<儿>⿰丿乚<土>⿱十一
% extra
% begintsuglyph("uni7A11",17);
%   tsu_render;
% endtsuglyph;

% 【稒】⿰<禾>⿱丿木<固>⿴囗<古>⿱十口
% extra
% begintsuglyph("uni7A12",18);
%   tsu_render;
% endtsuglyph;

% 【稓】⿰<禾>⿱丿木<昔>⿱<龷>⿱<卄>⿻⿰丨丨一一日
% extra
% begintsuglyph("uni7A13",19);
%   tsu_render;
% endtsuglyph;

% 【稔】⿰<禾>⿱丿木<念>⿱<今>⿱<CDP-8AFC>⿵𠆢一⺂心
% extra
% begintsuglyph("uni7A14",20);
%   tsu_render;
% endtsuglyph;

% 【稕】⿰<禾>⿱丿木<享>⿳<亠>⿱丨一口子
% extra
% begintsuglyph("uni7A15",21);
%   tsu_render;
% endtsuglyph;

% 【稘】⿰<禾>⿱丿木<其>⿱<CDP-8B72>⿱<CDP-88C8>;一八
% extra
% begintsuglyph("uni7A18",24);
%   tsu_render;
% endtsuglyph;

% 【稙】⿰<禾>⿱丿木<直>⿱十⿺𠃊目
% extra
% begintsuglyph("uni7A19",25);
%   tsu_render;
% endtsuglyph;

% 【稚】⿰<禾>⿱丿木隹
% extra
% begintsuglyph("uni7A1A",26);
%   tsu_render;
% endtsuglyph;

% 【稞】⿰<禾>⿱丿木<果>⿻日木
% extra
% begintsuglyph("uni7A1E",30);
%   tsu_render;
% endtsuglyph;

% 【稠】⿰<禾>⿱丿木<周>⿵⺆<𠮷>⿱<土>⿱十一口
% extra
% begintsuglyph("uni7A20",32);
%   tsu_render;
% endtsuglyph;

% 【稡】⿰<禾>⿱丿木<卒>⿱<𠅃>⿱<亠>⿱丨一<从>⿰人人十
% extra
% begintsuglyph("uni7A21",33);
%   tsu_render;
% endtsuglyph;

% 【稤】⿰<禾>⿱丿木<京>⿳<亠>⿱丨一口小
% extra
% begintsuglyph("uni7A24",36);
%   tsu_render;
% endtsuglyph;

% 【稩】⿰<禾>⿱丿木<胃>⿱田月
% extra
% begintsuglyph("uni7A29",41);
%   tsu_render;
% endtsuglyph;

% 【稫】⿰<禾>⿱丿木<畐>⿱<𠮛>⿱一口田
% extra
% begintsuglyph("uni7A2B",43);
%   tsu_render;
% endtsuglyph;

% 【稭】⿰<禾>⿱丿木<皆>⿱比白
% extra
% begintsuglyph("uni7A2D",45);
%   tsu_render;
% endtsuglyph;

% shu/tane "seed"
begintsuglyph("uni7A2E",46);
  kanji.grfour.seed;
  tsu_render;
endtsuglyph;

% 【稳】⿰<禾>⿱丿木<急>⿱<刍>⿱𠂊彐心
% extra
% begintsuglyph("uni7A33",51);
%   tsu_render;
% endtsuglyph;

% 【稼】⿰<禾>⿱丿木<家>⿱宀<豕>⿱一𧰨
% extra
% begintsuglyph("uni7A3C",60);
%   tsu_render;
% endtsuglyph;

% 【稿】⿰<禾>⿱丿木<高>⿳<亠>⿱丨一口<冋>⿵冂口
% extra
% begintsuglyph("uni7A3F",63);
%   tsu_render;
% endtsuglyph;

% 【穁】⿰<禾>⿱丿木<茸>⿱<艹>⿻十丨耳
% extra
% begintsuglyph("uni7A41",65);
%   tsu_render;
% endtsuglyph;

% 【穃】⿰<禾>⿱丿木<容>⿱宀谷
% extra
% begintsuglyph("uni7A43",67);
%   tsu_render;
% endtsuglyph;

% 【穄】⿰<禾>⿱丿木<祭>⿱<CDP-8C4F>⿰<CDP-88F0>⿴𠂊冫<CDP-8C4E>;示
% extra
% begintsuglyph("uni7A44",68);
%   tsu_render;
% endtsuglyph;

% 【穅】⿰<禾>⿱丿木<康>⿸广隶
% extra
% begintsuglyph("uni7A45",69);
%   tsu_render;
% endtsuglyph;

% 【穊】⿰<禾>⿱丿木<既>⿰<CDP-8B7C>;旡
% extra
% begintsuglyph("uni7A4A",74);
%   tsu_render;
% endtsuglyph;

% seki/tsu "load"
begintsuglyph("uni7A4D",77);
  kanji.grfour.load;
  tsu_render;
endtsuglyph;

% 【穕】⿰<禾>⿱丿木<集>⿱隹木
% extra
% begintsuglyph("uni7A55",85);
%   tsu_render;
% endtsuglyph;

% 【穖】⿰<禾>⿱丿木<幾>⿹<CDP-8BA4>⿻<戈>⿻弋丿<𢆶>⿰<幺>⿰<CDP-895C>;丶<幺>⿰<CDP-895C>;丶人
% extra
% begintsuglyph("uni7A56",86);
%   tsu_render;
% endtsuglyph;

% 【穙】⿰<禾>⿱丿木<菐>⿳<业>⿱<CDP-85F0>;一<䒑>⿱丷一<夫>⿻<二>⿱一一人
% extra
% begintsuglyph("uni7A59",89);
%   tsu_render;
% endtsuglyph;

% 【穚】⿰<禾>⿱丿木<喬>⿱<呑>⿱<夭>⿱丿<大>⿻一人口<冋>⿵冂口
% extra
% begintsuglyph("uni7A5A",90);
%   tsu_render;
% endtsuglyph;

% 【穜】⿰<禾>⿱丿木<童>⿱<立>⿱<CDP-8BAE>⿱<亠>⿱丨一丷一<里>⿱<CDP-8BD9>⿻甲一一
% extra
% begintsuglyph("uni7A5C",92);
%   tsu_render;
% endtsuglyph;

% 【穝】⿰<禾>⿱丿木<最>⿱日<取>⿸耳又
% extra
% begintsuglyph("uni7A5D",93);
%   tsu_render;
% endtsuglyph;

% 【穠】⿰<禾>⿱丿木<農>⿱曲<辰>⿸厂⿱<二>⿱一一<CDP-8CC6>⿰𠄌⿺乀丿
% extra
% begintsuglyph("uni7A60",96);
%   tsu_render;
% endtsuglyph;

% kyuu/kiwa "research"
begintsuglyph("uni7A76",118);
  kanji.grthree.research;
  tsu_render;
endtsuglyph;

% kara/sora "sky"
begintsuglyph("uni7A7A",122);
  kanji.grone.sky;
  tsu_render;
endtsuglyph;

% ta "stand up"
begintsuglyph("uni7ACB",203);
  kanji.grone.stand_up;
  tsu_render;
endtsuglyph;

% extra: "contend"
begintsuglyph("uni7ADE",222);
  kanji.rare.contend;
  tsu_render;
endtsuglyph;

% kyou/owa "finally"
begintsuglyph("uni7ADF",223);
  kanji.rare.finally;
  tsu_render;
endtsuglyph;

% shou/aki "chapter"
begintsuglyph("uni7AE0",224);
  kanji.grthree.chapter;
  tsu_render;
endtsuglyph;

% dou/warabe "child"
begintsuglyph("uni7AE5",229);
  kanji.grthree.child;
  tsu_render;
endtsuglyph;

% chiku/take "bamboo"
begintsuglyph("uni7AF9",249);
  kanji.grone.bamboo;
  tsu_render;
endtsuglyph;

% kyou/kiso "contest"
begintsuglyph("uni7AF6",246);
  kanji.grfour.contest;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
