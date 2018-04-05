%
% Unicode page 82 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2016, 2017  Matthew Skala
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
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.boat =
  push_pbox_toexpand("kanji.grtwo.boat");
  build_kanji.lr(520,0)
    (kanji.leftrad.boat)
    (build_kanji.level(build_kanji.tb(410,0)
       (kanji.radical.eight)
       (kanji.grone.mouth)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.art =
  push_pbox_toexpand("kanji.grfour.art");
  build_kanji.tb(540,50)
    (kanji.toprad.grass)
    (kanji.grnine.declaim);
  expand_pbox;
enddef;

vardef kanji.grfour.navigate =
  push_pbox_toexpand("kanji.grfour.navigate");
  build_kanji.lr(520,70-30*mincho)
    (kanji.leftrad.boat)
    (build_kanji.sscale(shifted (0,20))(kanji.rare.high_spirits));
  expand_pbox;
enddef;

vardef kanji.grfour.sprout =
  push_pbox_toexpand("kanji.grfour.sprout");
  build_kanji.tb(580,-30)
    (kanji.toprad.grass)
    (kanji.radical.tusk);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.entertainment =
  push_pbox_toexpand("kanji.grfive.entertainment");
  build_kanji.tb(120,20)(
    push_stroke((320,810)..tension 1.2..(220,750)..{curl 1}(100,700)
        --(100,600)--(100,0),
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.5,1.5));
    set_botip(0,2,1);
    set_boserif(0,0,10);
    push_stroke((100,700)--(100,0),(1.6,1.6)--(1.5,1.5));
    set_boserif(0,0,10);
    push_stroke((100,480)--(280,480),(1.5,1.5)--(1.5,1.5));
    set_boserif(0,1,9);
    push_stroke((100,240)--(280,240),(1.5,1.5)--(1.5,1.5));
    set_boserif(0,1,9);
    push_stroke((350,0)--(350,720)--(650,720)--(650,0),
      (1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.5,1.5));
    set_boserif(0,1,4);
    set_boserif(0,2,4);
    set_botip(0,1,1);
    set_botip(0,2,1);
    push_stroke((430,580)--(570,580),(1.5,1.5)--(1.5,1.5));
    set_boserif(0,1,9);
    build_kanji.box((430,460),(570,240));
    push_stroke((700,720)--(900,720)--(900,0),
      (1.6,1.6)--(1.5,1.5)--(1.5,1.5));
    set_boserif(0,1,4);
    set_botip(0,1,1);
    push_stroke((700+30*mincho,480)--(900,480),(1.5,1.5)--(1.5,1.5));
    push_stroke((700+30*mincho,240)--(900,240),(1.5,1.5)--(1.5,1.5));
    push_stroke((40,0)--(960,0),(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
    for i=-11 upto 0: set_bosize(i,80); endfor;
  )(kanji.radical.eight);
  expand_pbox;
enddef;

vardef kanji.grfive.house =
  push_pbox_toexpand("kanji.grfive.house");
  build_kanji.level(
    tsu_xform(identity yscaled 0.78 shifted (0,200))
      (kanji.radical.tent);
    pop_stroke;
    build_kanji.sscale(xyscaled (0.72,0.8) shifted (0,-90))
      (kanji.greight.good_luck);
    begingroup
      save myxf;
      transform myxf;
      (point 0.5 of get_strokep(-2)) transformed myxf=
        (point 0.5 of get_strokep(-3));
      (point 0.5 of get_strokep(-3)) transformed myxf=
        (point 0.5 of get_strokep(-2));
      ((100,0)+point 0.5 of get_strokep(-3)) transformed myxf=
        ((100,0)+point 0.5 of get_strokep(-2));
      replace_strokep(-3)(oldp transformed myxf);
      replace_strokep(-2)(oldp transformed myxf);
    endgroup;
    );
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kou/oko "entertainment"
begintsuglyph("uni8208",8);
  kanji.grfive.entertainment;
  tsu_render;
endtsuglyph;

% zetsu/shita "tongue"
begintsuglyph("uni820C",12);
  kanji.grfive.tongue;
  tsu_render;
endtsuglyph;

% ja/mado "house"
begintsuglyph("uni820E",14);
  kanji.grfive.house;
  tsu_render;
endtsuglyph;

% shuu/fune "boat"
begintsuglyph("uni821F",31);
  kanji.greight.boat;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8220",32);
  build_kanji.lr(520,30)
    (kanji.leftrad.boat)
    (kanji.grtwo.sword);
  tsu_render;
endtsuglyph;

% extra: boat
begintsuglyph("uni8221",33);
  build_kanji.lr(520,0)
    (kanji.leftrad.boat)
    (build_kanji.sscale(xyscaled (1.15,1.3))(kanji.grtwo.craft));
  tsu_render;
endtsuglyph;

% extra: "English" meaning is "sampan"
begintsuglyph("uni8222",34);
  build_kanji.lr(520,0)
    (kanji.leftrad.boat)
    (kanji.grone.mountain);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8225",37);
  build_kanji.lr(460,0)
    (kanji.leftrad.boat)
    (kanji.grnine.tomoe);
  tsu_render;
endtsuglyph;

% extra: boat
begintsuglyph("uni8229",41);
  build_kanji.lr(480,0)
    (kanji.leftrad.boat)
    (kanji.grtwo.public);
  tsu_render;
endtsuglyph;

% kou/wataru "navigate"
begintsuglyph("uni822A",42);
  kanji.grfour.navigate;
  tsu_render;
endtsuglyph;

% extra: moor/berth
begintsuglyph("uni822B",43);
  build_kanji.lr(520,30)
    (kanji.leftrad.boat)
    (kanji.grtwo.direction);
  tsu_render;
endtsuglyph;

% sen/fune "boat"
begintsuglyph("uni8239",57);
  kanji.grtwo.boat;
  tsu_render;
endtsuglyph;

% kon/ushitora "northeast"
begintsuglyph("uni826E",110);
  kanji.radical.northeast;
  tsu_render;
endtsuglyph;

% ryou/yo "good"
begintsuglyph("uni826F",111);
  kanji.grfour.good;
  tsu_render;
endtsuglyph;

% shoku/iro "colour"
begintsuglyph("uni8272",114);
  kanji.grtwo.colour;
  tsu_render;
endtsuglyph;

% extra "naked grass radical"
begintsuglyph("uni8279",121);
  build_kanji.sscale(yscaled 0.5)(kanji.toprad.grass);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni827B",123);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.power);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni827C",124);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grthree.thumbtack);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni827D",125);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.nine);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8284",132);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grtwo.circle);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni828A",138);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.one_thousand);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8293",147);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.child);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8296",150);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.big);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82AB",171);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grtwo.origin);
  tsu_render;
endtsuglyph;

% hana "flower"
begintsuglyph("uni82B1",177);
  kanji.grone.flower;
  tsu_render;
endtsuglyph;

% gei/u "art"
begintsuglyph("uni82B8",184);
  kanji.grfour.art;
  tsu_render;
endtsuglyph;

% ga/me "sprout"
begintsuglyph("uni82BD",189);
  kanji.grfour.sprout;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82C2",194);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.fire);
  tsu_render;
endtsuglyph;

% byo/nae "rice seedling"
begintsuglyph("uni82D7",215);
  kanji.greight.seedling;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82D9",217);
  build_kanji.tb(600,50)
    (kanji.toprad.grass)
    (kanji.grone.stand_up);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82DA",218);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grtwo.job);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82DC",220);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.eye);
  tsu_render;
endtsuglyph;

% kou/iyashiku "in the least"
begintsuglyph("uni82DF",223);
  kanji.rare.in_the_least;
  tsu_render;
endtsuglyph;

% waka "young master"
begintsuglyph("uni82E5",229);
  kanji.grsix.young_master;
  tsu_render;
endtsuglyph;

% ku/kuru "suffering"
begintsuglyph("uni82E6",230);
  kanji.grthree.suffering;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82E9",233);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.white);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82EE",238);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.greight.wizard);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82EF",239);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.book);
  tsu_render;
endtsuglyph;

% ei "English"
begintsuglyph("uni82F1",241);
  kanji.grfour.english;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82F2",242);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.rare.notwithstanding);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82FC",252);
  build_kanji.tb(600,50)
    (kanji.toprad.grass)
    (kanji.grone.life);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
