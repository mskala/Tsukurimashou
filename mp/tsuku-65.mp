%
% Unicode page 65 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012  Matthew Skala
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
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

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
  replace_strokep(0)((520,230)..(750,170)..(870,60));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.radical.folding_chair =
  push_pbox_toexpand("kanji.radical.folding_chair");
  push_stroke((420,830)..tension 1.2..(270,570)..(120,460),
    (1.7,1.7)--(1.4,1.4)--(1,1));
  set_boserif(0,0,10);
  push_stroke(
    (get_strokep(0) intersectionpoint ((0,650)--(1000,650)))--(820,650),
    (1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((680,650)..tension 1.1..(490,280)..(60,-20),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke((point 0.95 of get_strokep(-2))..(520,200)..(920,-20),
    (1,1)--(1.3,1.3)--(1.8,1.8));
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

% kyou/oshi "teaching"
begintsuglyph("uni6559",89);
  kanji.grtwo.teaching;
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

% hi/nichi "day"
begintsuglyph("uni65E5",229);
  kanji.grone.day;
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
