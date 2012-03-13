%
% Unicode page 56 (Kanji) for Tsukurimashou
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
input gradeone.mp;
input gradesix.mp;
input gradetwo.mp;
input radical.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.country =
  push_pbox_toexpand("kanji.grtwo.country");
  kanji.radical.box;
  build_kanji.sscale(scaled 0.75)(kanji.grone.ball);
  expand_pbox;
enddef;

vardef kanji.grtwo.map =
  push_pbox_toexpand("kanji.grtwo.map");
  kanji.radical.box;
  push_stroke((270,650)..tension 1.2..(340,560)..(360,500),
    (1,1)--(1.2,1.2)--(1.3,1.3));
  push_stroke(get_strokep(0) shifted ((430,690)-point 0 of get_strokep(0)),
    get_strokeq(0));
  push_stroke((760,610)..tension 1.2..(570,290)..(210,100),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke((240,430)..tension 1.2..(460,310)..(710,80),
    (1.2,1.2)--(1.4,1.4)--(1.5,1.5));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% box radical
begintsuglyph("uni56D7",215);
  kanji.radical.box;
  tsu_render;
endtsuglyph;

% shi/yon "four"
begintsuglyph("uni56DB",219);
  kanji.grone.four;
  tsu_render;
endtsuglyph;

% kai "counter for occurrences"
begintsuglyph("uni56DE",222);
  kanji.grtwo.occurrences;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni56ED",237);
  kanji.radical.box;
  build_kanji.sscale(scaled 0.75)(kanji.grtwo.origin);
  tsu_render;
endtsuglyph;

% koma "bothered"
begintsuglyph("uni56F0",240);
  kanji.grsix.bothered;
  tsu_render;
endtsuglyph;

% zu/haka "map"
begintsuglyph("uni56F3",243);
  kanji.grtwo.map;
  tsu_render;
endtsuglyph;

% koku/kuni "country"
begintsuglyph("uni56FD",253);
  kanji.grtwo.country;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
