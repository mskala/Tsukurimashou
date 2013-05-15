%
% Unicode page 7D (Kanji) for Tsukurimashou
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
input gradetwo.mp;
input radical.mp;
input rightrad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.assemble =
  push_pbox_toexpand("kanji.grtwo.assemble");
  build_kanji.lr(450,20)
    (kanji.grone.thread)
    (kanji.greight.furthermore);
  expand_pbox;
enddef;

vardef kanji.grtwo.dainty =
  push_pbox_toexpand("kanji.grtwo.dainty");
  build_kanji.lr(450,30)
    (kanji.grone.thread)
    (kanji.grone.paddy);
  expand_pbox;
enddef;

% "picture" is a reserved word
vardef kanji.grtwo.drawing =
  push_pbox_toexpand("kanji.grtwo.drawing");
  build_kanji.lr(450,10)
    (kanji.grone.thread)
    (kanji.grtwo.meet);
  expand_pbox;
enddef;

vardef kanji.grtwo.line =
  push_pbox_toexpand("kanji.grtwo.line");
  build_kanji.lr(450,0)
    (kanji.grone.thread)
    (kanji.grsix.fountain);
  expand_pbox;
enddef;

vardef kanji.grtwo.paper =
  push_pbox_toexpand("kanji.grtwo.paper");
  build_kanji.lr(450,60-10*mincho)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.grfour.clan);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.final =
  push_pbox_toexpand("kanji.grthree.final");
  build_kanji.lr(450,0)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.grtwo.winter);
  expand_pbox;
enddef;

vardef kanji.grthree.grade =
  push_pbox_toexpand("kanji.grthree.grade");
  build_kanji.lr(450,50)
    (build_kanji.lift_skirt(300,100)
       (kanji.grone.thread;
        replace_strokep(0)(subpath (0,1.6) of oldp)))
    (kanji.greight.reach);
  replace_strokep(-1)((point 0 of oldp)..tension 1.2..
    ((0,-90)+point 1 of oldp)..((-50,0)+point 2 of oldp));
  expand_pbox;
enddef;

vardef kanji.grthree.green =
  push_pbox_toexpand("kanji.grthree.green");
  build_kanji.lr(450,0)
    (build_kanji.lift_skirt(300,100)(kanji.grone.thread))
    (kanji.rightrad.carve_wood);
  expand_pbox;
enddef;

vardef kanji.grthree.knead =
  push_pbox_toexpand("kanji.grthree.final");
  build_kanji.lr(420,20)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.grtwo.east);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.continue =
  push_pbox_toexpand("kanji.grfour.continue");
  build_kanji.lr(420,-40)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.grtwo.sell);
  expand_pbox;
enddef;

% both "shrink" and "agreement"!
vardef kanji.grfour.contract =
  push_pbox_toexpand("kanji.grfour.contract");
  build_kanji.lr(420,40)
    (build_kanji.lift_skirt(300,20)(kanji.grone.thread))
    (kanji.grsix.inch);
  expand_pbox;
enddef;

vardef kanji.grfour.journal =
  push_pbox_toexpand("kanji.grfour.journal");
  build_kanji.lr(420,-40)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.grsix.self);
  expand_pbox;
enddef;

vardef kanji.grfour.salary =
  push_pbox_toexpand("kanji.grfour.salary");
  build_kanji.lr(450,10)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.grtwo.join);
  expand_pbox;
enddef;

vardef kanji.grfour.tie =
  push_pbox_toexpand("kanji.grfour.tie");
  build_kanji.lr(420,20)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.greight.good_luck);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.unified =
  push_pbox_toexpand("kanji.grfive.unified");
  build_kanji.lr(450,30-20*mincho)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.greight.fulfill);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ki "journal"
begintsuglyph("uni7D00",0);
  kanji.grfour.journal;
  tsu_render;
endtsuglyph;

% yaku/tsudzu "contract"
begintsuglyph("uni7D04",4);
  kanji.grfour.contract;
  tsu_render;
endtsuglyph;

% shi/kami "paper"
begintsuglyph("uni7D19",25);
  kanji.grtwo.paper;
  tsu_render;
endtsuglyph;

% kyuu "grade"
begintsuglyph("uni7D1A",26);
  kanji.grthree.grade;
  tsu_render;
endtsuglyph;

% dai/hoso "dainty"
begintsuglyph("uni7D30",48);
  kanji.grtwo.dainty;
  tsu_render;
endtsuglyph;

% shuu/o "final"
begintsuglyph("uni7D42",66);
  kanji.grthree.final;
  tsu_render;
endtsuglyph;

% so/ku "assemble"
begintsuglyph("uni7D44",68);
  kanji.grtwo.assemble;
  tsu_render;
endtsuglyph;

% ketsu/musu "tie"
begintsuglyph("uni7D50",80);
  kanji.grfour.tie;
  tsu_render;
endtsuglyph;

% kyuu/tama "salary"
begintsuglyph("uni7D66",102);
  kanji.grfour.salary;
  tsu_render;
endtsuglyph;

% tou/su "unified"
begintsuglyph("uni7D71",113);
  kanji.grfive.unified;
  tsu_render;
endtsuglyph;

% kai/e "picture"
begintsuglyph("uni7D75",117);
  kanji.grtwo.drawing;
  tsu_render;
endtsuglyph;

% zoku/tsudzu "continue"
begintsuglyph("uni7D9A",154);
  kanji.grfour.continue;
  tsu_render;
endtsuglyph;

% ryoku/midori "green"
begintsuglyph("uni7DD1",209);
  kanji.grthree.green;
  tsu_render;
endtsuglyph;

% sen/suji "line" (geometric, rail, telephone)
begintsuglyph("uni7DDA",218);
  kanji.grtwo.line;
  tsu_render;
endtsuglyph;

% ren/nuri "knead" or "paste"
begintsuglyph("uni7DF4",244);
  kanji.grthree.knead;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
