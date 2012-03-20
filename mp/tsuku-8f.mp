%
% Unicode page 8F (Kanji) for Tsukurimashou
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
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.near =
  push_pbox_toexpand("kanji.grtwo.near");
  build_kanji.road_enclose(kanji.greight.axe);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.return =
  push_pbox_toexpand("kanji.grthree.return");
  build_kanji.road_enclose(kanji.grthree.anti);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.vicinity =
  push_pbox_toexpand("kanji.grfour.vicinity");
  build_kanji.road_enclose(kanji.grtwo.sword);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.crowded =
  push_pbox_toexpand("kanji.greight.crowded");
  build_kanji.road_enclose(kanji.grone.put_it_in);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.crossroads =
  push_pbox_toexpand("kanji.grnine.crossroads");
  build_kanji.road_enclose(kanji.grone.ten);
  expand_pbox;
enddef;

vardef kanji.grnine.grope_along =
  push_pbox_toexpand("kanji.grnine.grope_along");
  build_kanji.road_enclose(kanji.grone.mountain);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hen/ata "vicinity"
begintsuglyph("uni8FBA",186);
  kanji.grfour.vicinity;
  tsu_render;
endtsuglyph;

% tsuji "crossroads"
begintsuglyph("uni8FBB",187);
  kanji.grnine.crossroads;
  tsu_render;
endtsuglyph;

% ko "crowded"
begintsuglyph("uni8FBC",188);
  kanji.greight.crowded;
  tsu_render;
endtsuglyph;

% ten/tado "grope along"
begintsuglyph("uni8FBF",191);
  kanji.grnine.grope_along;
  tsu_render;
endtsuglyph;

% kin/chika "near"
begintsuglyph("uni8FD1",209);
  kanji.grtwo.near;
  tsu_render;
endtsuglyph;

% hen/kae "return"
begintsuglyph("uni8FD4",212);
  kanji.grthree.return;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
