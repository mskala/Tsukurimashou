%
% Unicode page 72 (Kanji) for Tsukurimashou
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
input bkencl.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input radical.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.thing =
  push_pbox_toexpand("kanji.grthree.thing");
  build_kanji.lr(420,80)
    (kanji.leftrad.cow)
    (kanji.grnine.must_not);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.pasture =
  push_pbox_toexpand("kanji.grfour.pasture");
  build_kanji.lr(420,80)
    (kanji.leftrad.cow)
    (build_kanji.sscale(shifted (0,-30))(kanji.radical.folding_chair));
  expand_pbox;
enddef;

% "singular" because METAFONT reserves "special"
vardef kanji.grfour.singular =
  push_pbox_toexpand("kanji.grfour.singular");
  build_kanji.lr(420,-10)
    (kanji.leftrad.cow)
    (kanji.grtwo.temple);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.situation =
  push_pbox_toexpand("kanji.grfive.situation");
  build_kanji.lr(340,40)
    (kanji.radical.half_trunk)
    (kanji.grone.dog);
  expand_pbox;
enddef;

vardef kanji.grfive.crime =
  push_pbox_toexpand("kanji.grfive.crime");
  build_kanji.lr(430,-40)
    (kanji.leftrad.dog)
    (kanji.radical.ancient_seal);
  expand_pbox;
enddef;

vardef kanji.grfive.edition =
  push_pbox_toexpand("kanji.grfive.edition");
  build_kanji.lr(460,30)
    (kanji.grsix.slice)
    (kanji.grthree.anti);
  expand_pbox;
enddef;

vardef kanji.grfive.germany =
  push_pbox_toexpand("kanji.grfive.germany");
  build_kanji.lr(390,-10)
    (kanji.leftrad.dog)
    (tsu_xform(identity yscaled 1.12)(kanji.grone.bug));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.slice =
  push_pbox_toexpand("kanji.grsix.slice");
  push_stroke((200,780){down}..(145,130)..(50,-50),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  push_stroke((510,840)--(510,560),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((get_strokep(-1) intersectionpoint ((0,560)--(500,560)))
      --(800,560),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((get_strokep(-2) intersectionpoint ((0,320)--(500,320)))
      --(600,320)--(600,-80),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.male =
  push_pbox_toexpand("kanji.grnine.male");
  build_kanji.lr(450,80)
    (kanji.leftrad.cow)
    (kanji.grone.earth);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.cow =
  push_pbox_toexpand("kanji.leftrad.cow");
  kanji.grtwo.cow;
  replace_strokep(0)((140,200)..tension 1.2..(520,250)..(880-30*mincho,340));
  replace_strokeq(0)((1.7,1.7)--(1.5,1.5)--(1,1));
  set_boserif(0,1,whatever);
  expand_pbox;
enddef;

vardef kanji.leftrad.dog =
  push_pbox_toexpand("kanji.leftrad.dog");
  push_stroke(
    (120,840){curl 0}..tension 1.4..(820,320)..(640,40)..{curl 0.6}(100,40),
    (1.1,1.1)--(1.5,1.5)--(1.6,1.6)--(1.4,1.4));
  push_stroke((770,870)..tension 1.2..(550,700)..(200,510),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke((point 0.75 of get_strokep(-1))
      ..tension 1.2..(550,330)..{curl 0.6}(290,250),
    (point 0.6 of get_strokeq(-1))..(1.3,1.3)..(1.1,1.1));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% chichi "father"
begintsuglyph("uni7236",54);
  kanji.grtwo.father;
  tsu_render;
endtsuglyph;

% hen/kata "slice"
begintsuglyph("uni7247",71);
  kanji.grsix.slice;
  tsu_render;
endtsuglyph;

% han "edition"
begintsuglyph("uni7248",72);
  kanji.grfive.edition;
  tsu_render;
endtsuglyph;

% ga/kiba "tusk"
begintsuglyph("uni7259",89);
  kanji.greight.tusk;
  tsu_render;
endtsuglyph;

% kyuu/ushi "cow"
begintsuglyph("uni725B",91);
  kanji.grtwo.cow;
  tsu_render;
endtsuglyph;

% naked cow radical
begintsuglyph("uni725C",92);
  build_kanji.lr(450,20)(kanji.leftrad.cow)();
  tsu_render;
endtsuglyph;

% extra "female"
begintsuglyph("uni725D",93);
  build_kanji.lr(450,20)
    (kanji.leftrad.cow)
    (kanji.radical.spoon);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni725E",94);
  build_kanji.lr(450,20)
    (kanji.leftrad.cow)
    (kanji.grone.power);
  tsu_render;
endtsuglyph;

% bou/mu "moo (cow sound)"
begintsuglyph("uni725F",95);
  kanji.grnine.moo;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7260",96);
  build_kanji.lr(450,20)
    (kanji.leftrad.cow)
    (kanji.grnine.to_be);
  tsu_render;
endtsuglyph;

% bo/osu "male (animal)"
begintsuglyph("uni7261",97);
  kanji.grnine.male;
  tsu_render;
endtsuglyph;

% boku/maki "pasture"
begintsuglyph("uni7267",103);
  kanji.grfour.pasture;
  tsu_render;
endtsuglyph;

% butsu/mono "thing"
begintsuglyph("uni7269",105);
  kanji.grthree.thing;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni726A",106);
  build_kanji.lr(450,20)
    (kanji.leftrad.cow)
    (kanji.grtwo.cow);
  tsu_render;
endtsuglyph;

% toku "special"
begintsuglyph("uni7279",121);
  kanji.grfour.singular;
  tsu_render;
endtsuglyph;

% inu "dog"
begintsuglyph("uni72AC",172);
  kanji.grone.dog;
  tsu_render;
endtsuglyph;

% han/oka "crime"
begintsuglyph("uni72AF",175);
  kanji.grfive.crime;
  tsu_render;
endtsuglyph;

% shou "situation"
begintsuglyph("uni72B6",182);
  kanji.grfive.situation;
  tsu_render;
endtsuglyph;

% doku/hito "Germany"
begintsuglyph("uni72EC",236);
  kanji.grfive.germany;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
