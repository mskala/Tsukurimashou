%
% Unicode page 80 (Kanji) for Tsukurimashou
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
input bottomrad.mp;
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

vardef kanji.grtwo.hear =
  push_pbox_toexpand("kanji.grtwo.hear");
  build_kanji.gate_enclose(kanji.grone.ear);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.employment_post =
  push_pbox_toexpand("kanji.grfive.employment_post");
  build_kanji.lr(400,-20*mincho)
    (kanji.grone.ear)
    (kanji.rare.potters_clay);
  expand_pbox;
enddef;

vardef kanji.grfive.manure =
  push_pbox_toexpand("kanji.grfive.manure");
  build_kanji.lr(430,-30)
    (kanji.grone.moon)
    (kanji.grnine.tomoe);
  expand_pbox;
enddef;

vardef kanji.grfive.plow =
  push_pbox_toexpand("kanji.grfive.plow");
  build_kanji.lr(420,0)
    (kanji.leftrad.three_branch_tree)
    (build_kanji.sscale(yscaled 1.05 shifted (0,70))(kanji.greight.well));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.three_branch_tree =
  push_pbox_toexpand("kanji.leftrad.three_branch_tree");
  build_kanji.level(build_kanji.sscale(yscaled 1.10)(
    tsu_xform(identity yscaled 0.7)(kanji.leftrad.wood);
    replace_strokep(-3)((500,780)--(500,0));
    push_stroke(subpath (0.1,0.9) of get_strokep(-2) shifted (0,130),
      get_strokeq(-2));
    set_boserif(0,1,9);
    push_stroke(get_strokep(-3) shifted (0,250),get_strokeq(-3));
    set_boserif(0,1,9);
  ));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% rou/o "old man"
begintsuglyph("uni8001",1);
  kanji.grfour.old_man;
  tsu_render;
endtsuglyph;

% "old man without a spoon" radical
begintsuglyph("uni8002",2);
  kanji.radical.old_man();
  tsu_render;
endtsuglyph;

% kou/kanga "consider"
begintsuglyph("uni8003",3);
  kanji.grtwo.consider;
  tsu_render;
endtsuglyph;

% sha/mono "person" or "thing"
begintsuglyph("uni8005",5);
  kanji.grthree.person;
  tsu_render;
endtsuglyph;

% kou/tagaya "plow"
begintsuglyph("uni8015",21);
  kanji.grfive.plow;
  tsu_render;
endtsuglyph;

% ken/mi "ear"
begintsuglyph("uni8033",51);
  kanji.grone.ear;
  tsu_render;
endtsuglyph;

% bun/ki "hear"
begintsuglyph("uni805E",94);
  kanji.grtwo.hear;
  tsu_render;
endtsuglyph;

% shoku "post" as in employment
begintsuglyph("uni8077",119);
  kanji.grfive.employment_post;
  tsu_render;
endtsuglyph;

% brush radical
begintsuglyph("uni807F",127);
  kanji.radical.brush;
  tsu_render;
endtsuglyph;

% niku "meat"
begintsuglyph("uni8089",137);
  kanji.grtwo.meat;
  tsu_render;
endtsuglyph;

% shou/ayaka "resemblance"
begintsuglyph("uni8096",150);
  kanji.greight.resemblance;
  tsu_render;
endtsuglyph;

% hi/koe "manure" or "fertilizer"
begintsuglyph("uni80A5",165);
  kanji.grfive.manure;
  tsu_render;
endtsuglyph;

% iku/soda "raise"
begintsuglyph("uni80B2",178);
  kanji.grthree.raise;
  tsu_render;
endtsuglyph;

% i "stomach"
begintsuglyph("uni80C3",195);
  kanji.grfour.stomach;
  tsu_render;
endtsuglyph;

% extra: hai/hanami "embryo"
begintsuglyph("uni80DA",218);
  build_kanji.level(build_kanji.lr(380,10)
    (kanji.grone.moon)
    (build_kanji.sscale(yscaled 0.9)(kanji.rare.glorious)));
  tsu_render;
endtsuglyph;

% ko/nanzo "barbarian"
begintsuglyph("uni80E1",225);
  kanji.grnine.barbarian;
  tsu_render;
endtsuglyph;

% nou/yo "talent"
begintsuglyph("uni80FD",253);
  kanji.grfive.talent;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
