%
% Unicode page 5D (Kanji) for Tsukurimashou
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
input gradethree.mp;
input gradetwo.mp;
input radical.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.province =
  push_pbox_toexpand("kanji.grthree.province");
  tsu_xform(identity shifted (50,0))(kanji.grone.river);
  push_stroke((120,520)..(110,380)..(70,290),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  set_bosize(0,82);
  push_stroke((350,530)..(400,400)..(410,290),
    (1,1)--(1.4,1.4)--(1.8,1.8));
  set_bosize(0,82);
  push_stroke((620,530)..(700,390)..(710,290),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  set_bosize(0,82);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.halt =
  push_pbox_toexpand("kanji.grnine.halt");
  push_stroke((160,740)--(750,740)--(750,380),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((140,450)--(750,450),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((145,570),(1.7,1.7));
  set_boserif(0,0,10);
  build_kanji.add_ltail(0);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hou/kuzu "demolish"
begintsuglyph("uni5D29",41);
  kanji.greight.demolish;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5D52",82);
  build_kanji.tb(300,-10)
    (kanji.grthree.goods)
    (kanji.grone.mountain);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5D53",83);
  build_kanji.level(build_kanji.tb(600,-10)
    (kanji.grone.mountain)
    (kanji.grthree.goods));
  tsu_render;
endtsuglyph;

% kawa "river"
begintsuglyph("uni5DDD",221);
  kanji.grone.river;
  tsu_render;
endtsuglyph;

% shuu "province"
begintsuglyph("uni5DDE",222);
  kanji.grthree.province;
  tsu_render;
endtsuglyph;

% takumi "craft"
begintsuglyph("uni5DE5",229);
  kanji.grtwo.craft;
  tsu_render;
endtsuglyph;

% hidari "left"
begintsuglyph("uni5DE6",230);
  kanji.grone.left;
  tsu_render;
endtsuglyph;

% ko/ki "self" (dict. says also "snake" but almost no words use it that way)
begintsuglyph("uni5DF1",241);
  kanji.grsix.self;
  tsu_render;
endtsuglyph;

% i/ya "halt"
begintsuglyph("uni5DF2",242);
  kanji.grnine.halt;
  tsu_render;
endtsuglyph;

% shi/mi "snake zodiac sign"
begintsuglyph("uni5DF3",243);
  kanji.grnine.snake_sign;
  tsu_render;
endtsuglyph;

% ha/tomoe "tomoe"
begintsuglyph("uni5DF4",244);
  kanji.grnine.tomoe;
  tsu_render;
endtsuglyph;

% kou/chimata "fork in the road"
begintsuglyph("uni5DF7",247);
  kanji.grnine.fork_in_the_road;
  tsu_render;
endtsuglyph;

% son/tatsumi "southeast"
begintsuglyph("uni5DFD",253);
  kanji.grnine.southeast;
  tsu_render;
endtsuglyph;

% kin/oo/haba "towel" or "hanging scroll"
begintsuglyph("uni5DFE",254);
  kanji.greight.towel;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
