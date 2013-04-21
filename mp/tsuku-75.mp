%
% Unicode page 75 (Kanji) for Tsukurimashou
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
input buildkanji.mp;
input gradeeight.mp;
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

vardef kanji.grone.town =
  push_pbox_toexpand("kanji.grone.town");
  build_kanji.level(build_kanji.lr(550,120)
    (tsu_xform(identity shifted (-50,100))(kanji.grone.paddy))
    (tsu_xform(identity yscaled 0.92)
      (kanji.grthree.thumbtack)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.brush_stroke =
  push_pbox_toexpand("kanji.grtwo.brush_stroke");
  push_stroke((110,740)--(890,740),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,740)--(500,190),
    (1.6,1.6)--(1.4,1.4));
  push_stroke((300,370)--(700,370),
    (1.6,1.6)--(1.6,1.6));
  build_kanji.box((300,550),(700,190));
  build_kanji.cup((120,580),(880,20));
  expand_pbox;
enddef;

vardef kanji.grtwo.ordinal =
  push_pbox_toexpand("kanji.grtwo.ordinal");
  build_kanji.level(build_kanji.tb(350,140)
    (build_kanji.spread_legs(140)(build_kanji.add_beret(
       kanji.grtwo.rice)))
    (kanji.grone.paddy));
  replace_strokep(-8)((point 0 of oldp)--(500,330+50*mincho));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.farm =
  push_pbox_toexpand("kanji.grthree.farm");
  build_kanji.level(build_kanji.lr(440,0)
    (kanji.leftrad.fire)
    (kanji.grone.paddy));
  expand_pbox;
enddef;

vardef kanji.grthree.ill =
  push_pbox_toexpand("kanji.grthree.ill");
  build_kanji.sickness_enclose(tsu_xform(identity yscaled 0.88)
    (kanji.greight.third));
  expand_pbox;
enddef;

vardef kanji.grthree.realm =
  push_pbox_toexpand("kanji.grthree.realm");
  build_kanji.level(build_kanji.tb(460,80)
    (kanji.grone.paddy)
    (kanji.greight.mediate));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.give_birth =
  push_pbox_toexpand("kanji.grfour.give_birth");
  build_kanji.level(build_kanji.tb(520,80)
    (kanji.toprad.stand_up;pop_stroke)
    (build_kanji.cliff_enclose(build_kanji.sscale(shifted (-40,0))
       (kanji.grone.life))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef build_kanji.sickness_enclose(text contents) =
  push_pbox_toexpand("build_kanji.sickness_enclose");
  perl_structure:=perl_structure&"'eids.u2FF8.u7592.2_',";
  push_stroke((570,810)--(570,660),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke(
    (80,-50)..(170,100)..(210,300)..tension 1.2..(230,660)--(850,660),
    (1,1)--(1.3,1.3)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,3,1);
  push_stroke((70,580)..tension 1.2..(100,510)..(120,440),
    (1,1)--(1.4,1.4)--(1.6,1.6));
  push_stroke((40,260)..tension 1.2..(110,300)..(150,330),
    (1.7,1.7)--(1.5,1.5)--(1.1,1.1));
  begingroup
    save t;
    transform t;
    (50,-50) transformed t=(280,-60);
    (500,-50) transformed t=(570,-60);
    (500,850) transformed t=(570,630);
    tsu_xform(t)(contents);
  endgroup;
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kan/ama "sweet"
begintsuglyph("uni7518",24);
  kanji.greight.sweet;
  tsu_render;
endtsuglyph;

% sei/ki "life"
begintsuglyph("uni751F",31);
  kanji.grone.life;
  tsu_render;
endtsuglyph;

% san/u "give birth"
begintsuglyph("uni7523",35);
  kanji.grfour.give_birth;
  tsu_render;
endtsuglyph;

% you/mochi "job"
begintsuglyph("uni7528",40);
  kanji.grtwo.job;
  tsu_render;
endtsuglyph;

% you "walled road"
begintsuglyph("uni752C",44);
  kanji.rare.walled_road;
  tsu_render;
endtsuglyph;

% ta "rice paddy"
begintsuglyph("uni7530",48);
  kanji.grone.paddy;
  tsu_render;
endtsuglyph;

% yu/yoshi "reason" or "cause"
begintsuglyph("uni7531",49);
  kanji.grthree.reason;
  tsu_render;
endtsuglyph;

% shin/mou "have the honour to," "monkey zodiac sign," etc.
begintsuglyph("uni7533",51);
  kanji.grthree.have_honour;
  tsu_render;
endtsuglyph;

% otoko "man"
begintsuglyph("uni7537",55);
  kanji.grone.man;
  tsu_render;
endtsuglyph;

% chuu/machi "town"
begintsuglyph("uni753A",58);
  kanji.grone.town;
  tsu_render;
endtsuglyph;

% ga/ega "brush stroke" (or "picture" but that is reserved)
begintsuglyph("uni753B",59);
  kanji.grtwo.brush_stroke;
  tsu_render;
endtsuglyph;

% kai "realm" (actually "world" but that is a collision)
begintsuglyph("uni754C",76);
  kanji.grthree.realm;
  tsu_render;
endtsuglyph;

% fuku "roll of cloth"
begintsuglyph("uni7550",80);
  kanji.rare.roll_of_cloth;
  tsu_render;
endtsuglyph;

% hata "farm"
begintsuglyph("uni7551",81);
  kanji.grthree.farm;
  tsu_render;
endtsuglyph;

% ban/tsuga "ordinal number"
begintsuglyph("uni756A",106);
  kanji.grtwo.ordinal;
  tsu_render;
endtsuglyph;

% hiki/ashi "head" (counter for animals)
begintsuglyph("uni758B",139);
  kanji.grnine.animal_counter;
  tsu_render;
endtsuglyph;

% extra: sickness enclosure radical
begintsuglyph("uni7592",146);
  build_kanji.sickness_enclose();
  tsu_render;
endtsuglyph;

% byou/ya "ill"
begintsuglyph("uni75C5",197);
  kanji.grthree.ill;
  tsu_render;
endtsuglyph;

% extra: hi/tsukae "constipation"
begintsuglyph("uni75DE",222);
  build_kanji.sickness_enclose(build_kanji.sscale
    (yscaled 0.96 shifted (0,-30))
    (kanji.grsix.noes));
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
