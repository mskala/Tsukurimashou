%
% Unicode page 59 (Kanji) for Tsukurimashou
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

vardef kanji.grone.heaven =
  push_pbox_toexpand("kanji.grone.heaven");
  push_stroke((60,740)--(940,740),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((110,460)--(890,460),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((510,740){down}..(505,510)..(370,200)..{curl 0.5}(50,-20),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke(((get_strokep(-1) intersectionpoint get_strokep(0))+(50,0))..
      (650,200)..(900,-10),
    (1.1,1.1)--(1.5,1.5)--(1.7,1.7));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.big_sister =
  push_pbox_toexpand("kanji.grtwo.big_sister");
  build_kanji.lr(380,20)
    (kanji.leftrad.woman)
    (kanji.grtwo.market);
  expand_pbox;
enddef;

vardef kanji.grtwo.little_sister =
  push_pbox_toexpand("kanji.grtwo.little_sister");
  build_kanji.lr(380,20)
    (kanji.leftrad.woman)
    (kanji.grfour.husband);
  expand_pbox;
enddef;

vardef kanji.grtwo.other =
  push_pbox_toexpand("kanji.grtwo.other");
  tsu_xform(identity shifted (-50,-500) rotated -1 xscaled 0.65
    shifted (50,520))
    (kanji.grone.evening);
  push_stroke((670,790)..(670,-60),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke(
    (point 1.25 of get_strokep(-2))..tension 1.2..(710,340)..(890,250),
    (1.1,1.1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grtwo.summer =
  push_pbox_toexpand("kanji.grtwo.summer");
  build_kanji.level(build_kanji.tb(350,0)
    (kanji.toprad.summer)
    (kanji.radical.winter));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.begin =
  push_pbox_toexpand("kanji.grthree.begin");
  build_kanji.lr(380,20)
    (kanji.leftrad.woman)
    (kanji.grtwo.pedestal);
  expand_pbox;
enddef;

vardef kanji.grthree.committee =
  push_pbox_toexpand("kanji.grthree.committee");
  build_kanji.tb(420,-20)
    (kanji.grnine.two_branch_tree)
    (kanji.grone.woman);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.weird =
  push_pbox_toexpand("kanji.grfour.weird");
  build_kanji.level(build_kanji.tb(380,-30)
    (kanji.grnine.again)
    (kanji.radical.winter));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.dream =
  push_pbox_toexpand("kanji.grfive.dream");
  build_kanji.tb(360,90)
    (build_kanji.level(build_kanji.tcb(560,-60)(310,55)
       (kanji.toprad.grass)
       (kanji.toprad.eye)
       (kanji.radical.conservative_hat)))
    (build_kanji.sscale(xscaled 0.94)(kanji.grone.evening));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.compromise =
  push_pbox_toexpand("kanji.greight.compromise");
  build_kanji.level(build_kanji.tb(480,30)
    (kanji.toprad.paw)
    (kanji.grone.woman));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% chi/shuu "winter radical"
begintsuglyph("uni5902",2);
  kanji.radical.winter;
  tsu_render;
endtsuglyph;

% hen/ka "weird"
begintsuglyph("uni5909",9);
  kanji.grfour.weird;
  tsu_render;
endtsuglyph;

% ka/natsu "summer"
begintsuglyph("uni590F",15);
  kanji.grtwo.summer;
  tsu_render;
endtsuglyph;

% yuu/seki "evening"
begintsuglyph("uni5915",21);
  kanji.grone.evening;
  tsu_render;
endtsuglyph;

% gai/hoka "except"
begintsuglyph("uni5916",22);
  kanji.grtwo.other;
  tsu_render;
endtsuglyph;

% ta/oo "many"
begintsuglyph("uni591A",26);
  kanji.grtwo.many;
  tsu_render;
endtsuglyph;

% ya/yoru "evening"
begintsuglyph("uni591C",28);
  kanji.grtwo.evening;
  tsu_render;
endtsuglyph;

% mu/yume "dream"
begintsuglyph("uni5922",34);
  kanji.grfive.dream;
  tsu_render;
endtsuglyph;

% dai/oo "big"
begintsuglyph("uni5927",39);
  kanji.grone.big;
  tsu_render;
endtsuglyph;

% ten "heaven"
begintsuglyph("uni5929",41);
  kanji.grone.heaven;
  tsu_render;
endtsuglyph;

% tai/futo "thick"
begintsuglyph("uni592A",42);
  kanji.grtwo.thick;
  tsu_render;
endtsuglyph;

% fu/otto "husband"
begintsuglyph("uni592B",43);
  kanji.grfour.husband;
  tsu_render;
endtsuglyph;

% rare, but needed to build more common glyphs
begintsuglyph("uni592C",44);
  kanji.rare.decide;
  tsu_render;
endtsuglyph;

% rare, but needed to build more common glyphs
begintsuglyph("uni592D",45);
  kanji.rare.early_death;
  tsu_render;
endtsuglyph;

% ou "centre"
begintsuglyph("uni592E",46);
  kanji.grthree.centre;
  tsu_render;
endtsuglyph;

% shitsu/ushina "disappear"
begintsuglyph("uni5931",49);
  kanji.grfour.disappear;
  tsu_render;
endtsuglyph;

% en/oo "suffocate"
begintsuglyph("uni5944",68);
  kanji.grnine.suffocate;
  tsu_render;
endtsuglyph;

% ki/ku "strange"
begintsuglyph("uni5947",71);
  kanji.greight.strange;
  tsu_render;
endtsuglyph;

% jo/onna "woman"
begintsuglyph("uni5973",115);
  kanji.grone.woman;
  tsu_render;
endtsuglyph;

% me/yatsu "guy"
begintsuglyph("uni5974",116);
  kanji.greight.guy;
  tsu_render;
endtsuglyph;

% kou/su "fancy" (British sense)
begintsuglyph("uni597D",125);
  kanji.grfour.fancy;
  tsu_render;
endtsuglyph;

% da/yasu "compromise"
begintsuglyph("uni59A5",165);
  kanji.greight.compromise;
  tsu_render;
endtsuglyph;

% mai/imouto "younger sister"
begintsuglyph("uni59B9",185);
  kanji.grtwo.little_sister;
  tsu_render;
endtsuglyph;

% nee as in oneesan "elder sister"
begintsuglyph("uni59C9",201);
  kanji.grtwo.big_sister;
  tsu_render;
endtsuglyph;

% shi/haji "begin"
begintsuglyph("uni59CB",203);
  kanji.grthree.begin;
  tsu_render;
endtsuglyph;

% i/yuda "committee"
begintsuglyph("uni59D4",212);
  kanji.grthree.committee;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni59ED",237);
  build_kanji.tb(500,-20)
    (build_kanji.tricluster(0.85)
      (kanji.grone.power)
      (kanji.grone.power)
      (kanji.grone.power))
    (kanji.grone.woman);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
