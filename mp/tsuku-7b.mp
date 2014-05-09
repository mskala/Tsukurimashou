%
% Unicode page 7B (Kanji) for Tsukurimashou
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
input buildkanji.mp;
input gradeeight.mp;
input gradefour.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.calculate =
  push_pbox_toexpand("kanji.grtwo.calculate");
  build_kanji.level(build_kanji.tb(560,170)
    (kanji.toprad.bamboo)
    (build_kanji.tb(360,20)
       (kanji.grone.eye)
       (kanji.radical.aitch)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.box =
  push_pbox_toexpand("kanji.grthree.box");
  build_kanji.level(build_kanji.tb(520,190)
    (kanji.toprad.bamboo)
    (kanji.grthree.correlation));
  expand_pbox;
enddef;

vardef kanji.grthree.flute =
  push_pbox_toexpand("kanji.grthree.flute");
  build_kanji.level(build_kanji.tb(460,220-40*mincho)
    (kanji.toprad.bamboo)
    (kanji.grthree.reason));
  expand_pbox;
enddef;

vardef kanji.grthree.ordinal =
  push_pbox_toexpand("kanji.grthree.ordinal");
  build_kanji.level(build_kanji.tb(520,230)
    (kanji.toprad.bamboo)
    (kanji.grtwo.bow));
  push_stroke((500,ypart point 0 of get_strokep(-3))--(500,-70),
    (1.6,1.6)--(1.4,1.4));
  replace_strokep(-1)((point 0 of oldp)--
    ((subpath (1,infinity) of oldp)
     shifted (-820,0) xscaled 0.45 shifted (820,0)));
  push_stroke(((get_strokep(0) intersectionpoint get_strokep(-1))+(-40,0))..
      tension 1.2..(280,20)..(80,-60),
    (1.6,1.6)--(1.4,1.4)--(0.9,0.9));
  expand_pbox;
enddef;

vardef kanji.grthree.rank =
  push_pbox_toexpand("kanji.grthree.rank");
  build_kanji.level(build_kanji.tb(520,190)
    (kanji.toprad.bamboo)
    (kanji.grtwo.temple));
  expand_pbox;
enddef;

vardef kanji.grthree.writing_brush =
  push_pbox_toexpand("kanji.grthree.writing_brush");
  build_kanji.level(build_kanji.tb(520,190)
    (kanji.toprad.bamboo)
    (kanji.radical.brush));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.laugh =
  push_pbox_toexpand("kanji.grfour.laugh");
  build_kanji.level(build_kanji.tb(480,150)
    (kanji.toprad.bamboo)
    (kanji.rare.early_death));
  expand_pbox;
enddef;

vardef kanji.grfour.pipe =
  push_pbox_toexpand("kanji.grfour.pipe");
  build_kanji.level(build_kanji.tb(490,210)
    (kanji.toprad.bamboo)
    (kanji.grfour.bureaucracy));
  expand_pbox;
enddef;

vardef kanji.grfour.section =
  push_pbox_toexpand("kanji.grfour.section");
  build_kanji.level(build_kanji.tb(480,190)
    (kanji.toprad.bamboo)
    (kanji.greight.instant));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.code =
  push_pbox_toexpand("kanji.greight.code");
  build_kanji.level(build_kanji.tb(520,210)
    (kanji.toprad.bamboo)
    (kanji.grfour.attach));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% shou/wara "laugh"
begintsuglyph("uni7B11",17);
  kanji.grfour.laugh;
  tsu_render;
endtsuglyph;

% teki/fue "flute"
begintsuglyph("uni7B1B",27);
  kanji.grthree.flute;
  tsu_render;
endtsuglyph;

% fu "code"
begintsuglyph("uni7B26",38);
  kanji.greight.code;
  tsu_render;
endtsuglyph;

% dai "ordinal number"
begintsuglyph("uni7B2C",44);
  kanji.grthree.ordinal;
  tsu_render;
endtsuglyph;

% hitsu/fude "writing brush"
begintsuglyph("uni7B46",70);
  kanji.grthree.writing_brush;
  tsu_render;
endtsuglyph;

% tou/hito "rank"
begintsuglyph("uni7B49",73);
  kanji.grthree.rank;
  tsu_render;
endtsuglyph;

% tou/kota "answer"
begintsuglyph("uni7B54",84);
  kanji.grtwo.answer;
  tsu_render;
endtsuglyph;

% sen/soru "calculate"
begintsuglyph("uni7B97",151);
  kanji.grtwo.calculate;
  tsu_render;
endtsuglyph;

% kan/kuda "pipe" or "jurisdiction"
begintsuglyph("uni7BA1",161);
  kanji.grfour.pipe;
  tsu_render;
endtsuglyph;

% extra: tan/hako "bamboo rice bucket"
begintsuglyph("uni7BAA",170);
  build_kanji.level(build_kanji.tb(540,140)
    (kanji.toprad.bamboo)
    (kanji.grfour.single));
  tsu_render;
endtsuglyph;

% sou/hako "box"
begintsuglyph("uni7BB1",177);
  kanji.grthree.box;
  tsu_render;
endtsuglyph;

% setsu/fushi "section"
begintsuglyph("uni7BC0",192);
  kanji.grfour.section;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
