%
% Unicode page 84 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2016, 2017  Matthew Skala
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
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.fall =
  push_pbox_toexpand("kanji.grthree.fall");
  build_kanji.tb(630,-20)
    (kanji.toprad.grass)
    (kanji.grnine.kyoto);
  expand_pbox;
enddef;

vardef kanji.grthree.leaf =
  push_pbox_toexpand("kanji.grthree.leaf");
  build_kanji.tb(630,0)
    (kanji.toprad.grass)
    (build_kanji.tb(480,60)
       (tsu_xform(identity shifted (30,0))(kanji.grthree.world))
       (kanji.grone.wood));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% moe (untranslatable)
begintsuglyph("uni840C",12);
  kanji.grnine.moe;
  tsu_render;
endtsuglyph;

% raku/o "fall" or "drop"
begintsuglyph("uni843D",61);
  kanji.grthree.fall;
  tsu_render;
endtsuglyph;

% you/ha "leaf"
begintsuglyph("uni8449",73);
  kanji.grthree.leaf;
  tsu_render;
endtsuglyph;

% waku/hakari "to calculate"
begintsuglyph("uni84A6",166);
  kanji.rare.to_calculate;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
