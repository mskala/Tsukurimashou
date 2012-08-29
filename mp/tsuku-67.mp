%
% Unicode page 67 (Kanji) for Tsukurimashou
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
input bottomrad.mp;
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
input rightrad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.grove =
  push_pbox_toexpand("kanji.grone.grove");
  build_kanji.lr(480,0)
    (kanji.leftrad.wood)
    (kanji.grone.wood);
  expand_pbox;
enddef;

vardef kanji.grone.village =
  push_pbox_toexpand("kanji.grone.village");
  build_kanji.lr(480,0)
    (kanji.leftrad.wood)
    (kanji.grsix.inch);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.morning =
  push_pbox_toexpand("kanji.grtwo.morning");
  tsu_xform(identity shifted (50,0))
    (build_kanji.level(build_kanji.lr(480,30)
      (build_kanji.tb(280,40)
         (build_kanji.tb(460,50)
            (kanji.grone.ten)
            (kanji.grone.day))
         (build_kanji.sscale(xscaled 1.1)
            (kanji.grone.ten;
             set_boserif(-1,0,whatever))))
      (kanji.grone.moon)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.clothing =
  push_pbox_toexpand("kanji.grthree.clothing");
  build_kanji.level(build_kanji.lr(480,20)
    (kanji.grone.moon)
    (kanji.rightrad.clothing));
  expand_pbox;
enddef;

vardef kanji.grthree.have =
  push_pbox_toexpand("kanji.grthree.have");
  build_kanji.lean_to((430,240));
  build_kanji.sscale(xyscaled (0.76,0.63) shifted (30,-170))
    (kanji.bottomrad.moon);
  expand_pbox;  
enddef;

vardef kanji.grthree.pillar =
  push_pbox_toexpand("kanji.grthree.pillar");
  build_kanji.lr(480,-10)
    (kanji.leftrad.wood)
    (kanji.grthree.master);
  expand_pbox;
enddef;

vardef kanji.grthree.plank =
  push_pbox_toexpand("kanji.grthree.plank");
  build_kanji.lr(480,20)
    (kanji.leftrad.wood)
    (kanji.grthree.anti);
  expand_pbox;
enddef;

vardef kanji.grthree.term =
  push_pbox_toexpand("kanji.grthree.term");
  build_kanji.lr(580,-10)
    (build_kanji.sscale(yscaled 0.96)(kanji.grnine.that))
    (kanji.grone.moon);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.pine =
  push_pbox_toexpand("kanji.grfour.pine");
  build_kanji.lr(480,20)
    (build_kanji.sscale(yscaled 1.07)(kanji.leftrad.wood))
    (kanji.grtwo.public);
  expand_pbox;
enddef;

vardef kanji.grfour.tip =
  push_pbox_toexpand("kanji.grfour.tip");
  kanji.grfour.not_yet;
  replace_strokep(-3)((70,610)--(930,610));
  replace_strokep(-4)((160,360)--(840,360));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tsuki/getsu "moon"
begintsuglyph("uni6708",8);
  kanji.grone.moon;
  tsu_render;
endtsuglyph;

% yuu/a "to have"
begintsuglyph("uni6709",9);
  kanji.grthree.have;
  tsu_render;
endtsuglyph;

% fuku as in "sailor fuku"
begintsuglyph("uni670D",13);
  kanji.grthree.clothing;
  tsu_render;
endtsuglyph;

% chou/asa "morning"
begintsuglyph("uni671D",29);
  kanji.grtwo.morning;
  tsu_render;
endtsuglyph;

% ki "term" (limited time)
begintsuglyph("uni671F",31);
  kanji.grthree.term;
  tsu_render;
endtsuglyph;

% ki "wood"
begintsuglyph("uni6728",40);
  kanji.grone.wood;
  tsu_render;
endtsuglyph;

% mi/ima "not yet", also zodiac sign of the ram
begintsuglyph("uni672A",42);
  kanji.grfour.not_yet;
  tsu_render;
endtsuglyph;

% matsu/sue "tip"
begintsuglyph("uni672B",43);
  kanji.grfour.tip;
  tsu_render;
endtsuglyph;

% hon "book"
begintsuglyph("uni672C",44);
  kanji.grone.book;
  tsu_render;
endtsuglyph;

% son/mura "village"
begintsuglyph("uni6751",81);
  kanji.grone.village;
  tsu_render;
endtsuglyph;

% soku/taba "bundle"
begintsuglyph("uni675F",95);
  kanji.grfour.bundle;
  tsu_render;
endtsuglyph;

% ku/rai "come"
begintsuglyph("uni6765",101);
  kanji.grtwo.come;
  tsu_render;
endtsuglyph;

% tou/higashi "east"
begintsuglyph("uni6771",113);
  kanji.grtwo.east;
  tsu_render;
endtsuglyph;

% shou/matsu "pine"
begintsuglyph("uni677E",126);
  kanji.grfour.pine;
  tsu_render;
endtsuglyph;

% han/ita "plank"
begintsuglyph("uni677F",127);
  kanji.grthree.plank;
  tsu_render;
endtsuglyph;

% rin/hayashi "grove"
begintsuglyph("uni6797",151);
  kanji.grone.grove;
  tsu_render;
endtsuglyph;

% chuu/hashira "pillar"
begintsuglyph("uni67F1",241);
  kanji.grthree.pillar;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
