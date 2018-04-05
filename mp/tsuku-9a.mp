%
% Unicode page 9A (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2017  Matthew Skala
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
input gradefive.mp;
input gradefour.mp;
input gradeone.mp;
input gradesix.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.attempt =
  push_pbox_toexpand("kanji.grfour.attempt");
  build_kanji.lr(480,10)
    (kanji.grtwo.horse)
    (kanji.rightrad.attempt);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.hair =
  push_pbox_toexpand("kanji.greight.hair");
  build_kanji.level(build_kanji.tb(440,20)
    (kanji.radical.long_hair)
    (kanji.grtwo.friend));
  expand_pbox;
enddef;

vardef kanji.greight.surprise =
  push_pbox_toexpand("kanji.greight.surprise");
  build_kanji.thickness(0.9)(build_kanji.level(build_kanji.tb(420,0)
    (kanji.grsix.respect)
    (kanji.grtwo.horse)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ken/okashi "attempt"
begintsuglyph("uni9A13",19);
  kanji.grfour.attempt;
  tsu_render;
endtsuglyph;

% kyou/odoro "surprise"
begintsuglyph("uni9A5A",90);
  kanji.greight.surprise;
  tsu_render;
endtsuglyph;

% kou/taka "high"
begintsuglyph("uni9AD8",216);
  kanji.grtwo.high;
  tsu_render;
endtsuglyph;

% hyuu/kamigashira "long hair radical"
begintsuglyph("uni9ADF",223);
  kanji.radical.long_hair;
  tsu_render;
endtsuglyph;

% hatsu/kami "hair of the head"
begintsuglyph("uni9AEA",234);
  kanji.greight.hair;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
