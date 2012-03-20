%
% Unicode page 7D (Kanji) for Tsukurimashou
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
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradetwo.mp;
input radical.mp;

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

vardef kanji.grthree.knead =
  push_pbox_toexpand("kanji.grthree.final");
  build_kanji.lr(420,20)
    (build_kanji.lift_skirt(300,60)(kanji.grone.thread))
    (kanji.grtwo.east);
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

% shi/kami "paper"
begintsuglyph("uni7D19",25);
  kanji.grtwo.paper;
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
