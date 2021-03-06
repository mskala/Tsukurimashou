%
% Unicode page 81 (Kanji) for Tsukurimashou
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
input rare.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.guts =
  push_pbox_toexpand("kanji.grfour.guts");
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.grone.moon)
    (kanji.rare.sun));
  expand_pbox;
enddef;

vardef kanji.grfour.pulse =
  push_pbox_toexpand("kanji.grfour.pulse");
  build_kanji.level(build_kanji.lr(420,10)
    (kanji.grone.moon)
    (kanji.rare.branch));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.gland =
  push_pbox_toexpand("kanji.greight.gland");
  build_kanji.lr(420,30)
    (kanji.grone.moon)
    (kanji.grsix.fountain);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% myaku/suji "pulse"
begintsuglyph("uni8108",8);
  kanji.grfour.pulse;
  tsu_render;
endtsuglyph;

% chou/harawata "guts"
begintsuglyph("uni8178",120);
  kanji.grfour.guts;
  tsu_render;
endtsuglyph;

% sen "gland"
begintsuglyph("uni817A",122);
  kanji.greight.gland;
  tsu_render;
endtsuglyph;

% shin/omi "vassal"
begintsuglyph("uni81E3",227);
  kanji.grfour.vassal;
  tsu_render;
endtsuglyph;

% rare needed for greight.wisdom
begintsuglyph("uni81E4",228);
  kanji.rare.wisdom;
  tsu_render;
endtsuglyph;

% ji as in jibun "self"
begintsuglyph("uni81EA",234);
  kanji.grtwo.self;
  tsu_render;
endtsuglyph;

% shi/ita "climax"
begintsuglyph("uni81F3",243);
  kanji.grsix.climax;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
