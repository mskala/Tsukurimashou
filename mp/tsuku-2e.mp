%
% Unicode page 2E (Radicals Supplement) for Tsukurimashou
% Copyright (C) 2012  Matthew Skala
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
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CJK RADICALS SUPPLEMENT

% hito/jin "person" as radical
begintsuglyph("uni2E85",133);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.person);
  tsu_render;
endtsuglyph;

% Unicode calls it "table"
begintsuglyph("uni2E87",135);
  build_kanji.wind_enclose();
  tsu_render;
endtsuglyph;

% Unicode calls it "knife one"
begintsuglyph("uni2E88",136);
  build_kanji.attach_fishhook(0.8)(
    perl_structure:=perl_structure&"'eids._2',";
    push_stroke((200,0)--(200,800)--(800,800),
      (1.5,1.5)--(1.6,1.6)--(1.6,1.6));
    set_bosize(0,0));
  tsu_render;
endtsuglyph;

% tou "sword radical"
begintsuglyph("uni2E89",137);
  tsu_xform(identity xscaled 0.5)(kanji.rightrad.sword);
  tsu_render;
endtsuglyph;

% Unicode calls it "small one"
begintsuglyph("uni2E8C",140);
  build_kanji.tb(620,80)
    (kanji.toprad.sparkle_three)
    ();
  tsu_render;
endtsuglyph;

% shi/mi "snake zodiac sign"
begintsuglyph("uni2E92",146);
  kanji.grnine.snake_sign;
  tsu_render;
endtsuglyph;

% you/chiisai "short thread radical"
begintsuglyph("uni2E93",147);
  kanji.radical.short_thread;
  tsu_render;
endtsuglyph;

% left radical version of "heart"
begintsuglyph("uni2E96",150);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.heart);
  tsu_render;
endtsuglyph;

% hand radical
begintsuglyph("uni2E98",152);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.hand);
  tsu_render;
endtsuglyph;

% special form with straight left side
begintsuglyph("uni2E9D",157);
  kanji.bottomrad.moon;
  tsu_render;
endtsuglyph;

% bo/haha "mother"
begintsuglyph("uni2E9F",159);
  kanji.grtwo.mother;
  tsu_render;
endtsuglyph;

% extra "water side radical"
begintsuglyph("uni2EA1",161);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.water);
  tsu_render;
endtsuglyph;

% water radical variant
begintsuglyph("uni2EA2",162);
  kanji.radical.alt_water;
  tsu_render;
endtsuglyph;

% Unicode calls it "fire"
begintsuglyph("uni2EA3",163);
  build_kanji.tb(190,-30)
    ()
    (kanji.bottomrad.four_ticks);
  tsu_render;
endtsuglyph;

% Unicode calls it "cow"
begintsuglyph("uni2EA7",167);
  build_kanji.tb(440,-30)
    (kanji.radical.life_minus)
    ();
  tsu_render;
endtsuglyph;

% Unicode calls it "jade"
begintsuglyph("uni2EA9",169);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.king);
  tsu_render;
endtsuglyph;

% Unicode calls it "spirit one"
begintsuglyph("uni2EAC",172);
  tsu_xform(identity xscaled 0.5)(kanji.grfive.showing);
  tsu_render;
endtsuglyph;

% Unicode calls it "spirit two"
begintsuglyph("uni2EAD",173);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.showing);
  tsu_render;
endtsuglyph;

% "bamboo" top radical
begintsuglyph("uni2EAE",174);
  build_kanji.tb(540,200)
    (kanji.toprad.bamboo)
    ();
  tsu_render;
endtsuglyph;

% Unicode calls it "silk"
begintsuglyph("uni2EAF",175);
  tsu_xform(identity xscaled 0.5)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread));
  tsu_render;
endtsuglyph;

% "sheep" (ram) top radical
begintsuglyph("uni2EB7",183);
  build_kanji.tb(420,200)
    (kanji.toprad.sheep)
    ();
  tsu_render;
endtsuglyph;

% "sheep" left-side radical
begintsuglyph("uni2EB8",184);
  tsu_xform(identity xscaled 0.5)
    (kanji.radical.twin_tailed_sheep;
     pop_stroke);
  tsu_render;
endtsuglyph;

% Japanese form of "grass" top radical
begintsuglyph("uni2EBE",190);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    ();
  tsu_render;
endtsuglyph;

% sai/nishi "West" or "Spain"
begintsuglyph("uni2EC4",196);
  kanji.grtwo.west;
  tsu_render;
endtsuglyph;

% foot radical
begintsuglyph("uni2ECA",202);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.foot);
  tsu_render;
endtsuglyph;

% Unicode calls it "simplified walk"
begintsuglyph("uni2ECC",204);
  build_kanji.road_enclose();
  tsu_render;
endtsuglyph;

% Unicode calls it "city"
begintsuglyph("uni2ECF",207);
  tsu_xform(identity xscaled 0.5 shifted (500,0))
    (kanji.rightrad.beta);
  tsu_render;
endtsuglyph;

% chou/naga "long"
begintsuglyph("uni2ED1",209);
  kanji.grtwo.long;
  tsu_render;
endtsuglyph;

% Unicode calls it "long two"
begintsuglyph("uni2ED2",210);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.long_hair);
  tsu_render;
endtsuglyph;

% Unicode calls it "mound two"
begintsuglyph("uni2ED6",214);
  tsu_xform(identity xscaled 0.5)
    (kanji.radical.beta);
  tsu_render;
endtsuglyph;

% "rain" top radical
begintsuglyph("uni2ED7",215);
  build_kanji.tb(300,0)
    (kanji.toprad.rain)
    ();
  tsu_render;
endtsuglyph;

% ao "blue"
begintsuglyph("uni2ED8",216);
  kanji.grone.blue;
  tsu_render;
endtsuglyph;

% shoku/ta "eat"
begintsuglyph("uni2EDD",221);
  kanji.grtwo.eat;
  tsu_render;
endtsuglyph;

% simplified "eat" for use as radical
begintsuglyph("uni2EDF",223);
  tsu_xform(identity xscaled 0.5)(kanji.leftrad.eat);
  tsu_render;
endtsuglyph;

% baku/mugi "wheat"
begintsuglyph("uni2EE8",232);
  kanji.grtwo.wheat;
  tsu_render;
endtsuglyph;

% kou/ki "yellow"
begintsuglyph("uni2EE9",233);
  kanji.grtwo.yellow;
  tsu_render;
endtsuglyph;

% shi/ha "tooth"
begintsuglyph("uni2EED",237);
  kanji.grthree.tooth;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
