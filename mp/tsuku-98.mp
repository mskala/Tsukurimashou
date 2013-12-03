%
% Unicode page 98 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013  Matthew Skala
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

vardef kanji.grtwo.face =
  push_pbox_toexpand("kanji.grtwo.face");
  build_kanji.level(build_kanji.lr(500,30)
    (kanji.grnine.boy)
    (kanji.grnine.page));
  expand_pbox;
enddef;

vardef kanji.grtwo.head =
  push_pbox_toexpand("kanji.grtwo.head");
  build_kanji.lr(450,-50)
    (build_kanji.lift_skirt(320,150)(kanji.grthree.bean))
    (kanji.grnine.page);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.drink =
  push_pbox_toexpand("kanji.grthree.drink");
  build_kanji.lr(480,20)
    (kanji.leftrad.eat)
    (kanji.grfour.fail);
  expand_pbox;
enddef;

vardef kanji.grthree.topic =
  push_pbox_toexpand("kanji.grthree.topic");
  build_kanji.lr(500,40)
    (kanji.greight.righteousness)
    (build_kanji.sscale(yscaled 0.88 shifted (0,40))
       (kanji.grnine.page));
  replace_strokep(-8)((point 0 of oldp)..(point 1 of oldp)..
    tension 1.5..{curl 0.2}(920,-40));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.cooked_rice =
  push_pbox_toexpand("kanji.grfour.cooked_rice");
  build_kanji.lr(520,0)
    (kanji.leftrad.eat)
    (kanji.grthree.anti);
  expand_pbox;
enddef;

vardef kanji.grfour_helper.fly =
  push_pbox_toexpand("kanji.grfour_helper.fly");
  push_stroke((120,760)--interpath(mincho,
      (660,760){dir -87}..{dir -72}(770,-20)..(860,-10)..tension 1.5..
        (890,100)..(910,200),
      (630,760){dir -82}..(740,100)..{right}(910,-40){curl 1}..
        (890,60)..(890,160)),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(0.9,0.9));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((point 1.33 of get_strokep(0))
      ..tension 1.2..(770,450)..(840,360),
    (1.2,1.2)--(1.6,1.6)--(1.8,1.8));
  set_bosize(0,90);
  push_stroke((810,670)..tension 1.2..(770,590)..(720,480),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  set_bosize(0,90);
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.grfour.fly =
  push_pbox_toexpand("kanji.grfour.fly");
  build_kanji.tb(440,50)
    (build_kanji.sscale(xscaled 0.9)(kanji.grfour_helper.fly))
    (kanji.grfour_helper.fly);
  push_stroke((480,680)--(480,-70),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  set_bosize(0,90);
  push_stroke((120,610)..(270,640)..tension 1.1..(370,680),
    (1.1,1.1)--(1.6,1.6)--(2.0,2.0));
  push_stroke((270,630){down}..(190,130)..(90,-70),
    (1.6,1.6)--(1.3,1.3)--(1,1));
  expand_pbox;
enddef;

vardef kanji.grfour.order =
  push_pbox_toexpand("kanji.grfour.order");
  build_kanji.level(build_kanji.lr(440,20)
    (kanji.grone.river)
    (kanji.grnine.page));
  expand_pbox;
enddef;

vardef kanji.grfour.prayer =
  push_pbox_toexpand("kanji.grfour.prayer");
  build_kanji.level(build_kanji.lr(540,50)
    (tsu_xform(identity shifted (0,40) yscaled (857/800) shifted (0,-40))
       (kanji.grtwo.field))
    (kanji.grnine.page));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.custody =
  push_pbox_toexpand("kanji.grfive.custody");
  build_kanji.level(build_kanji.lr(520,0)
    (build_kanji.sscale(scaled 1.11 shifted (0,28))(kanji.grthree.before))
    (kanji.grnine.page));
  expand_pbox;
enddef;

vardef kanji.grfive.domain =
  push_pbox_toexpand("kanji.grfive.domain");
  build_kanji.level(build_kanji.lr(480,20)
    (build_kanji.sscale(shifted (0,30))(kanji.grfour.orders))
    (kanji.grnine.page));
  expand_pbox;
enddef;

vardef kanji.grfive.forehead =
  push_pbox_toexpand("kanji.grfive.forehead");
  build_kanji.level(build_kanji.lr(490,10)
    (build_kanji.sscale(shifted (0,20))(kanji.grthree.guest))
    (kanji.grnine.page));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ketsu/peeji "page"
begintsuglyph("uni9801",1);
  kanji.grnine.page;
  tsu_render;
endtsuglyph;

%  【頂】⿰<丁>⿱一亅頁
% /
% begintsuglyph("uni9802",2);
%   kanji.grsix.;
%   tsu_render;
% endtsuglyph;

%  【頃】⿰<匕>⿺乚丿頁
% /
% begintsuglyph("uni9803",3);
%   kanji.greight.;
%   tsu_render;
% endtsuglyph;

% extra
begintsuglyph("uni9804",4);
  build_kanji.level(build_kanji.lr(480,20)
    (build_kanji.sscale(yscaled 1.1 shifted (0,60))(kanji.grone.nine))
    (kanji.grnine.page));
  tsu_render;
endtsuglyph;

%  【項】⿰工頁
% /
% begintsuglyph("uni9805",5);
%   kanji.greight.;
%   tsu_render;
% endtsuglyph;

% shun/aya "order"
begintsuglyph("uni9806",6);
  kanji.grfour.order;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9807",7);
  build_kanji.level(build_kanji.lr(480,20)
    (build_kanji.sscale(yscaled 1.14 shifted (0,20))(kanji.grsix.dry))
    (kanji.grnine.page));
  tsu_render;
endtsuglyph;

%  【須】⿰彡頁
% /
% begintsuglyph("uni9808",8);
%   kanji.greight.;
%   tsu_render;
% endtsuglyph;

% extra
begintsuglyph("uni9809",9);
  build_kanji.level(build_kanji.lr(480,30)
    (build_kanji.sscale(yscaled 1.1 shifted (0,50))
       (build_kanji.lift_skirt(370,150+30*mincho)(kanji.grtwo.cease)))
    (kanji.grnine.page));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni980A",10);
  build_kanji.level(build_kanji.lr(480,30)
    (kanji.leftrad.king)
    (kanji.grnine.page));
  tsu_render;
endtsuglyph;

%  【頌】⿰<公>⿱八厶頁
% /
% begintsuglyph("uni980C",12);
%   kanji.grnine.;
%   tsu_render;
% endtsuglyph;

% extra
begintsuglyph("uni980D",13);
  build_kanji.level(build_kanji.lr(500,10)
    (kanji.grfive.support)
    (kanji.grnine.page));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni980E",14);
  build_kanji.level(build_kanji.lr(500,30)
    (kanji.greight.axe)
    (kanji.grnine.page));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni980F",15);
  build_kanji.level(build_kanji.lr(500,0)
    (build_kanji.sscale(shifted (0,40))
       (build_kanji.lift_skirt(350,170)(kanji.rare.high_spirits)))
    (kanji.grnine.page));
  tsu_render;
endtsuglyph;

% yo/azu "custody"
begintsuglyph("uni9810",16);
  kanji.grfive.custody;
  tsu_render;
endtsuglyph;

%  【頑】⿰<元>⿱一<兀>⿱一<儿>⿰丿乚頁
% /
% begintsuglyph("uni9811",17);
%   kanji.greight.;
%   tsu_render;
% endtsuglyph;

%  【頒】⿰<分>⿱八<刀>⿹𠃌丿頁
% /
% begintsuglyph("uni9812",18);
%   kanji.greight.;
%   tsu_render;
% endtsuglyph;

%  【頔】⿰由頁
% extra
% begintsuglyph("uni9814",20);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頕】⿰<占>⿱⺊口頁
% extra
% begintsuglyph("uni9815",21);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頖】⿰<半>⿱丷<CDP-8BF1>⿻<二>⿱一一丨頁
% extra
% begintsuglyph("uni9816",22);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頗】⿰皮頁
% /
% begintsuglyph("uni9817",23);
%   kanji.grnine.;
%   tsu_render;
% endtsuglyph;

% ryou/eri "domain"
begintsuglyph("uni9818",24);
  kanji.grfive.domain;
  tsu_render;
endtsuglyph;

%  【頚】⿰<圣>⿱又<土>⿱十一頁
% extra
% begintsuglyph("uni981A",26);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頜】⿰<合>⿱<CDP-8AFC>⿵𠆢一口頁
% extra
% begintsuglyph("uni981C",28);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頝】⿰<交>⿱<亠>⿱丨一<父>⿱八<乂>⿻丿乀頁
% extra
% begintsuglyph("uni981D",29);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頞】⿰<安>⿱宀女頁
% extra
% begintsuglyph("uni981E",30);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頟】⿰<各>⿱夂口頁
% extra
% begintsuglyph("uni981F",31);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頡】⿰<吉>⿱<士>⿱十一口頁
% extra
% begintsuglyph("uni9821",33);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頢】⿰<舌>⿱<千>⿱丿十口頁
% extra
% begintsuglyph("uni9822",34);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頣】⿰臣頁
% extra
% begintsuglyph("uni9823",35);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頧】⿰<𠂤>⿱丿㠯頁
% extra
% begintsuglyph("uni9827",39);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頨】⿰<羽>⿰<习>⿹𠃌冫<习>⿹𠃌冫頁
% extra
% begintsuglyph("uni9828",40);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頩】⿰<并>⿱丷<开>⿱一<廾>⿻一<CDP-8BF5>⿰丿丨頁
% extra
% begintsuglyph("uni9829",41);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頪】⿰米頁
% extra
% begintsuglyph("uni982A",42);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頫】⿰兆頁
% extra
% begintsuglyph("uni982B",43);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

% tou/atama "head"
begintsuglyph("uni982D",45);
  kanji.grtwo.head;
  tsu_render;
endtsuglyph;

%  【頲】⿰<廷>⿺廴壬頁
% extra
% begintsuglyph("uni9832",50);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頳】⿰<赤>⿱<土>⿱十一<CDP-8CB5>;頁
% extra
% begintsuglyph("uni9833",51);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頵】⿰<君>⿸<尹>⿻<CDP-8BAB>⿴<CDP-8C78>;一丿口頁
% extra
% begintsuglyph("uni9835",53);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頶】⿰<告>⿱𠂒口頁
% extra
% begintsuglyph("uni9836",54);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【頻】⿰<歩>⿱止<少>⿱小丿頁
% /
% begintsuglyph("uni983B",59);
%   kanji.greight.;
%   tsu_render;
% endtsuglyph;

%  【頼】⿰束頁
% /
% begintsuglyph("uni983C",60);
%   kanji.greight.;
%   tsu_render;
% endtsuglyph;

%  【顀】⿰隹頁
% extra
% begintsuglyph("uni9840",64);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【顁】⿰<定>⿱宀<𤴓>⿱一龰頁
% extra
% begintsuglyph("uni9841",65);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【顃】⿰<炎>⿱<火>⿱八人<火>⿱八人頁
% extra
% begintsuglyph("uni9843",67);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【顆】⿰<果>⿻日木頁
% extra
% begintsuglyph("uni9846",70);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【顇】⿰<卒>⿱<𠅃>⿱<亠>⿱丨一<从>⿰人人十頁
% extra
% begintsuglyph("uni9847",71);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【顉】⿰金頁
% extra
% begintsuglyph("uni9849",73);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【顋】⿰<思>⿱田心頁
% extra
% begintsuglyph("uni984B",75);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

% dai "topic"
begintsuglyph("uni984C",76);
  kanji.grthree.topic;
  tsu_render;
endtsuglyph;

% gaku/hitai "forehead" or "framed picture"
begintsuglyph("uni984D",77);
  kanji.grfive.forehead;
  tsu_render;
endtsuglyph;

%  【顎】⿰<咢>⿱<吅>⿰口口<亏>⿱一<丂>⿱一㇉頁
% /
% begintsuglyph("uni984E",78);
%   kanji.greight.;
%   tsu_render;
% endtsuglyph;

%  【顐】⿰<軍>⿱冖車頁
% extra
% begintsuglyph("uni9850",80);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【顑】⿰<咸>⿵<戌>⿵戊一口頁
% extra
% begintsuglyph("uni9851",81);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

% gen/kao "face"
begintsuglyph("uni9854",84);
  kanji.grtwo.face;
  tsu_render;
endtsuglyph;

% gan/nega "prayer" (as in onegai, "please," literally "I pray you")
begintsuglyph("uni9858",88);
  kanji.grfour.prayer;
  tsu_render;
endtsuglyph;

%  【顛】⿰<真>⿱十<具>⿳目一八頁
% extra
% begintsuglyph("uni985B",91);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

% rui/tagu "genus"
begintsuglyph("uni985E",94);
  kanji.grfour.genus;
  tsu_render;
endtsuglyph;

%  【顠】⿰<票>⿱<覀>⿱一<CDP-86EA>⿻<〢>⿰丨丨口示頁
% extra
% begintsuglyph("uni9860",96);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

%  【顥】⿰<景>⿱日<京>⿳<亠>⿱丨一口小頁
% extra
% begintsuglyph("uni9865",101);
%   build_kanji.level(build_kanji.lr(500,0)
%     ()
%     (kanji.grnine.page));
%   tsu_render;
% endtsuglyph;

% fuu/kaze "wind"
begintsuglyph("uni98A8",168);
  kanji.grtwo.wind;
  tsu_render;
endtsuglyph;

% hi/to "fly"
begintsuglyph("uni98DB",219);
  kanji.grfour.fly;
  tsu_render;
endtsuglyph;

% helper for "fly"
begintsuglyph("uni98DE",222);
  kanji.grfour_helper.fly;
  tsu_render;
endtsuglyph;

% shoku/ta "eat"
begintsuglyph("uni98DF",223);
  kanji.grtwo.eat;
  tsu_render;
endtsuglyph;

% simplified "eat" for use as radical
begintsuglyph("uni98E0",224);
  build_kanji.sscale(xscaled 0.6)(kanji.leftrad.eat);
  tsu_render;
endtsuglyph;

% han/meshi "cooked rice"
begintsuglyph("uni98EF",239);
  kanji.grfour.cooked_rice;
  tsu_render;
endtsuglyph;

% in/no "drink"
begintsuglyph("uni98F2",242);
  kanji.grthree.drink;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

