%
% Unicode page 9B (Kanji) for Tsukurimashou
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
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradeone.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.gloom =
  push_pbox_toexpand("kanji.greight.gloom");
  build_kanji.tb(510,20)
    (build_kanji.lcr(320,0)(680,0)
       (kanji.leftrad.wood)
       (kanji.greight.tin_can)
       (kanji.grone.wood))
    (build_kanji.tb(600,140)
      (build_kanji.sscale(xscaled 1.06)(kanji.radical.conservative_hat))
      (build_kanji.sscale(xyscaled (0.8,0.9))(build_kanji.lr(580,0)
        (kanji.rare.spiced_liqueur)
        (build_kanji.sscale(shifted (0,40))(kanji.rightrad.short_hair)))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% chou/kaorigusa "spiced liqueur"
begintsuglyph("uni9B2F",47);
  kanji.rare.spiced_liqueur;
  tsu_render;
endtsuglyph;

% utsu "gloom"
begintsuglyph("uni9B31",49);
  kanji.greight.gloom;
  tsu_render;
endtsuglyph;

% gyo/sakana "fish"
begintsuglyph("uni9B5A",90);
  kanji.grtwo.fish;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
