%
% Unicode page 65 (Kanji) for Tsukurimashou
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
input gradefive.mp;
input gradefour.mp;
input gradeone.mp;
input gradesix.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.new =
  push_pbox_toexpand("kanji.grtwo.new");
  build_kanji.level(build_kanji.lr(480,20)
    (build_kanji.tb(470,20)
       (kanji.toprad.stand_up)
       (kanji.leftrad.wood))
    (kanji.greight.axe));
  expand_pbox;
enddef;

vardef kanji.grtwo.number =
  push_pbox_toexpand("kanji.grtwo.number");
  build_kanji.level(build_kanji.lr(520,80)
    (build_kanji.tb(490,20)
       (kanji.grtwo.come;
        set_bosize(-5,0);
        replace_strokep(-4)(oldp shifted (0,80));
        replace_strokeq(-4)((1.2,1.2)--(1.4,1.4)--(1.7,1.7));
        set_boserif(-4,0,whatever);
        replace_strokep(-3)(oldp shifted (0,60)))
       (kanji.grone.woman))
    (kanji.radical.folding_chair));
  expand_pbox;
enddef;

vardef kanji.grtwo.teaching =
  push_pbox_toexpand("kanji.grtwo.teaching");
  build_kanji.level(build_kanji.lr(520,80)
    (kanji.radical.old_man(kanji.rare.mosquito_larva))
    (kanji.radical.folding_chair));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.organize =
  push_pbox_toexpand("kanji.grthree.organize");
  build_kanji.level(build_kanji.tb(280,0)
    (kanji.rare.imperial_decree)
    (kanji.grone.correct));
  expand_pbox;
enddef;

vardef kanji.grthree.release =
  push_pbox_toexpand("kanji.grthree.release");
  build_kanji.level(build_kanji.lr(480,60)
    (kanji.grtwo.direction)
    (kanji.radical.folding_chair));
  expand_pbox;
enddef;

vardef kanji.grthree.travel =
  push_pbox_toexpand("kanji.grthree.travel");
  build_kanji.level(build_kanji.flag_enclose(0.8,0.8)(
    push_stroke((720,810)..tension 1.2..(380,610)..(80,510),
      (1.7,1.7)--(1.5,1.5)--(1,1));
    push_stroke((320,570)--(320,-60),(1.6,1.6)--(1.5,1.5));
    push_stroke((point 0.7 of get_strokep(-1))..
        tension 1.2..(650,240)..(850,0),
      (1,1)--(1.4,1.4)--(1.7,1.7));
    push_stroke((770,490)..tension 1.2..(680,420)..
        (point 0.65 of get_strokep(0)),
      (1.7,1.7)--(1.4,1.4)--(1.2,1.2))));
  expand_pbox;
enddef;

vardef kanji.grthree.tribe =
  push_pbox_toexpand("kanji.grthree.tribe");
  build_kanji.level(build_kanji.flag_enclose(0.8,0.8)(
    kanji.grtwo.arrow;
    replace_strokep(-4)(oldp shifted (-500,0)
      xscaled 0.86 shifted (500,0));
    replace_strokep(-3)(oldp shifted (-500,0)
      xscaled 0.86 shifted (500,0))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.failure =
  push_pbox_toexpand("kanji.grfour.failure");
  build_kanji.level(build_kanji.lr(500,40)
    (kanji.grone.shell)
    (kanji.radical.folding_chair;
     replace_strokep(-1)(subpath (0,length(oldp)-0.17) of oldp)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.decapitate =
  push_pbox_toexpand("kanji.greight.decapitate");
  build_kanji.lr(480,20)
    (build_kanji.sscale(yscaled 0.94 shifted (0,30))
       (kanji.grone.wheel))
    (kanji.greight.axe);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.rare.imperial_decree =
  push_pbox_toexpand("kanji.rare.imperial_decree");
  build_kanji.level(build_kanji.lr(520,60)
    (kanji.leftrad.bundle)
    (kanji.radical.folding_chair));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.bundle =
  push_pbox_toexpand("kanji.leftrad.bundle");
  kanji.grfour.bundle;
  replace_strokep(0)((520,230)..(750,150)..(870,60));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% shi/sasa "support"
begintsuglyph("uni652F",47);
  kanji.grfive.support;
  tsu_render;
endtsuglyph;

% "folding chair" radical
begintsuglyph("uni6535",53);
  kanji.radical.folding_chair;
  tsu_render;
endtsuglyph;

% hou/hana "release"
begintsuglyph("uni653E",62);
  kanji.grthree.release;
  tsu_render;
endtsuglyph;

% choku/imashi "imperial decree"
begintsuglyph("uni6555",85);
  kanji.rare.imperial_decree;
  tsu_render;
endtsuglyph;

% hai/yabu "failure"
begintsuglyph("uni6557",87);
  kanji.grfour.failure;
  tsu_render;
endtsuglyph;

% kyou/oshi "teaching"
begintsuglyph("uni6559",89);
  kanji.grtwo.teaching;
  tsu_render;
endtsuglyph;

% kei/uyama "respect"
begintsuglyph("uni656C",108);
  kanji.grsix.respect;
  tsu_render;
endtsuglyph;

% suu/kazu "number"
begintsuglyph("uni6570",112);
  kanji.grtwo.number;
  tsu_render;
endtsuglyph;

% sei/totono "organize"
begintsuglyph("uni6574",116);
  kanji.grthree.organize;
  tsu_render;
endtsuglyph;

% bun/fumi "sentence"
begintsuglyph("uni6587",135);
  kanji.grone.sentence;
  tsu_render;
endtsuglyph;

% to/masu "dipper"
begintsuglyph("uni6597",151);
  kanji.greight.dipper;
  tsu_render;
endtsuglyph;

% kin/ono "axe"
begintsuglyph("uni65A4",164);
  kanji.greight.axe;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni65A6",166);
  build_kanji.level(build_kanji.lr(480,70)
    (kanji.greight.axe)
    (kanji.greight.axe));
  tsu_render;
endtsuglyph;

% zan/ki "decapitate
begintsuglyph("uni65AC",172);
  kanji.greight.decapitate;
  tsu_render;
endtsuglyph;

% shin/atara "new"
begintsuglyph("uni65B0",176);
  kanji.grtwo.new;
  tsu_render;
endtsuglyph;

% hou/kata "direction" or "how to do it"
begintsuglyph("uni65B9",185);
  kanji.grtwo.direction;
  tsu_render;
endtsuglyph;

% needed for "play"
begintsuglyph("uni65BF",191);
  kanji.rare.swim;
  tsu_render;
endtsuglyph;

% ryo/tabi "travel"
begintsuglyph("uni65C5",197);
  kanji.grthree.travel;
  tsu_render;
endtsuglyph;

% zoku "tribe"
begintsuglyph("uni65CF",207);
  kanji.grthree.tribe;
  tsu_render;
endtsuglyph;

% hi/nichi "day"
begintsuglyph("uni65E5",229);
  kanji.grone.day;
  tsu_render;
endtsuglyph;

% tan/aki "daybreak"
begintsuglyph("uni65E6",230);
  kanji.greight.daybreak;
  tsu_render;
endtsuglyph;

% kyuu/furu "old times"
begintsuglyph("uni65E7",231);
  kanji.grfive.old_times;
  tsu_render;
endtsuglyph;

% shi/mune/uma "vaguely good" or "uma" in "umami"
begintsuglyph("uni65E8",232);
  kanji.greight.glutamate;
  tsu_render;
endtsuglyph;

% hayaku "early"
begintsuglyph("uni65E9",233);
  kanji.grone.early;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
