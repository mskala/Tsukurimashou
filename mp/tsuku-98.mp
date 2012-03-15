%
% Unicode page 98 (Kanji) for Tsukurimashou
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
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rightrad.mp;
input toprad.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.face =
  push_pbox_toexpand("kanji.grtwo.face");
  build_kanji.lr(500,30)
    (kanji.grnine.boy)
    (kanji.grnine.page);
  expand_pbox;
enddef;

vardef kanji.grtwo.head =
  push_pbox_toexpand("kanji.grtwo.head");
  build_kanji.lr(450,-50)
    (build_kanji.lift_skirt(320,150)(kanji.grthree.bean))
    (kanji.grnine.page);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.drink =
  push_pbox_toexpand("kanji.grthree.drink");
  build_kanji.lr(480,20)
    (kanji.leftrad.eat)
    (kanji.grfour.fail);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ketsu/peeji "page"
begintsuglyph("uni9801",1);
  kanji.grnine.page;
  tsu_render;
endtsuglyph;

% tou/atama "head"
begintsuglyph("uni982D",45);
  kanji.grtwo.head;
  tsu_render;
endtsuglyph;

% gen/kao "face"
begintsuglyph("uni9854",84);
  kanji.grtwo.face;
  tsu_render;
endtsuglyph;

% fuu/kaze "wind"
begintsuglyph("uni98A8",168);
  kanji.grtwo.wind;
  tsu_render;
endtsuglyph;

% shoku/ta "eat"
begintsuglyph("uni98DF",223);
  kanji.grtwo.eat;
  tsu_render;
endtsuglyph;

% simplified "eat" for use as radical
begintsuglyph("uni98E0",224);
  build_kanji.sscale(xscaled 0.6)(kanji.leftrad.eat);
  tsu_render;
endtsuglyph;

% in/no "drink"
begintsuglyph("uni98F2",242);
  kanji.grthree.drink;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
