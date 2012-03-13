%
% Unicode page 6e (Kanji) for Tsukurimashou
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
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.hot_water =
  push_pbox_toexpand("kanji.grthree.hot_water");
  build_kanji.lr(290,20)
    (kanji.leftrad.water)
    (build_kanji.sscale(yscaled 0.9)(kanji.rare.sun));
  expand_pbox;
enddef;

vardef kanji.grthree.lake =
  push_pbox_toexpand("kanji.grthree.lake");
  build_kanji.lr(290,20)
    (kanji.leftrad.water)
    (kanji.grnine.barbarian);
  expand_pbox;
enddef;

vardef kanji.grthree.warm =
  push_pbox_toexpand("kanji.grthree.warm");
  build_kanji.lr(290,20)
    (kanji.leftrad.water)
    (build_kanji.level(build_kanji.tb(360,0)
       (build_kanji.sscale(scaled 0.87)(kanji.grone.day))
       (kanji.grthree.dish)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% on/atata "warm"
begintsuglyph("uni6E29",41);
  kanji.grthree.warm;
  tsu_render;
endtsuglyph;

% tou/yu "hot water"
begintsuglyph("uni6E6F",111);
  kanji.grthree.hot_water;
  tsu_render;
endtsuglyph;

% ko/mizuumi "lake"
begintsuglyph("uni6E56",86);
  kanji.grthree.lake;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6E76",118);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grsix.fountain);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
