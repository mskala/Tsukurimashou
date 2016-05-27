%
% Unicode page 6B (Kanji) for Tsukurimashou
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
input bkencl.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.song =
  push_pbox_toexpand("kanji.grtwo.song");
  build_kanji.lr(500,0)
    (kanji.rare.big_brother)
    (kanji.grfour.fail);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.die =
  push_pbox_toexpand("kanji.grthree.die");
  build_kanji.level(build_kanji.lr(570,0)
    (tsu_xform(identity shifted (0,-800) yscaled 0.95 shifted (0,800))
       (kanji.leftrad.bare_bone))
    (kanji.radical.spoon));
  set_boserif(-1,0,whatever);
  set_boserif(0,0,whatever);
  replace_strokep(-5)((point 0 of oldp)--
    (1000-xpart point 0 of oldp,ypart point 1 of oldp));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.history =
  push_pbox_toexpand("kanji.grfour.history");
  build_kanji.cliff_enclose(kanji.rare.history_inside);
  expand_pbox;
enddef;

vardef kanji.grfour.kill =
  push_pbox_toexpand("kanji.grfour.kill");
  build_kanji.level(build_kanji.lr(360,0)
    (build_kanji.sscale(shifted (0,-40))(build_kanji.tb(600,-20)
       (kanji.radical.cut_the_grass)
       (kanji.leftrad.wood)))
    (kanji.radical.windy_again));
  expand_pbox;
enddef;

vardef kanji.grfour.poison =
  push_pbox_toexpand("kanji.grfour.poison");
  build_kanji.level(build_kanji.tb(430,-20)
    (kanji.toprad.blue)
    (kanji.radical.mother_stroked));
  expand_pbox;
enddef;

vardef kanji.grfour.remainder =
  push_pbox_toexpand("kanji.grfour.remainder");
  build_kanji.level(build_kanji.lr(470,50)
    (build_kanji.sscale(yscaled 0.85 shifted (0,-50))
       (kanji.leftrad.bare_bone))
    (kanji.radical.three_tasselled_spear));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ketsu/ka/akubi "fail" or "yawn"
begintsuglyph("uni6B20",32);
  kanji.grfour.fail;
  tsu_render;
endtsuglyph;

% ji/tsugi "next"
begintsuglyph("uni6B21",33);
  kanji.grthree.next;
  tsu_render;
endtsuglyph;

% ka/uta "song"
begintsuglyph("uni6B4C",76);
  kanji.grtwo.song;
  tsu_render;
endtsuglyph;

% shi/toma "stop"
begintsuglyph("uni6B62",98);
  kanji.grtwo.cease;
  tsu_render;
endtsuglyph;

% sei/tada/machi "correct"
begintsuglyph("uni6B63",99);
  kanji.grone.correct;
  tsu_render;
endtsuglyph;

% ho/aruku "walk"
begintsuglyph("uni6B69",105);
  kanji.grtwo.walk;
  tsu_render;
endtsuglyph;

% extra: wai/iga "warp"
begintsuglyph("uni6B6A",106);
  build_kanji.tb(440,70)
    (kanji.grfour.non)
    (kanji.grone.correct);
  tsu_render;
endtsuglyph;

% shi/ha "tooth"
begintsuglyph("uni6B6F",111);
  kanji.grthree.tooth;
  tsu_render;
endtsuglyph;

% reki "history"
begintsuglyph("uni6B74",116);
  kanji.grfour.history;
  tsu_render;
endtsuglyph;

% gatsu "bare bone radical"
begintsuglyph("uni6B79",121);
  kanji.leftrad.bare_bone;
  tsu_render;
endtsuglyph;

% shi "die"
begintsuglyph("uni6B7B",123);
  kanji.grthree.die;
  tsu_render;
endtsuglyph;

% zan/noko "remainder"
begintsuglyph("uni6B8B",139);
  kanji.grfour.remainder;
  tsu_render;
endtsuglyph;

% shu/mata "windy again radical"
begintsuglyph("uni6BB3",179);
  kanji.radical.windy_again;
  tsu_render;
endtsuglyph;

% satsu/koro "kill"
begintsuglyph("uni6BBA",186);
  kanji.grfour.kill;
  tsu_render;
endtsuglyph;

% extra: mother radical, stroked version
begintsuglyph("uni6BCB",203);
  kanji.radical.mother_stroked;
  tsu_render;
endtsuglyph;

% further variation
begintsuglyph("uni6BCC",204);
  kanji.rare.penetrate;
  tsu_render;
endtsuglyph;

% bo/haha "mother"
begintsuglyph("uni6BCD",205);
  kanji.grtwo.mother;
  tsu_render;
endtsuglyph;

% mai/goto "every"
begintsuglyph("uni6BCE",206);
  kanji.grtwo.every;
  tsu_render;
endtsuglyph;

% extra, closely related to previous
begintsuglyph("uni6BCF",207);
  tsu_xform(identity yscaled (550/750))
    (kanji.grtwo.mother);
  push_stroke((280,810)..tension 1.2..(160,600)..(50,500),
    (1.7,1.7)--(1.5,1.5)--(1.2,1.2));
  set_boserif(0,0,10);
  set_bosize(0,90);
  push_stroke((get_strokep(0) intersectionpoint ((0,730)--(1000,730)))--
      (880,730),
    (1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  set_bosize(0,90);
  tsu_render;
endtsuglyph;

% doku "poison"
begintsuglyph("uni6BD2",210);
  kanji.grfour.poison;
  tsu_render;
endtsuglyph;

% hi/kura "compare"
begintsuglyph("uni6BD4",212);
  kanji.grfive.compare;
  tsu_render;
endtsuglyph;

% mou/ke "hair"
begintsuglyph("uni6BDB",219);
  kanji.grtwo.hair;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
