%
% Unicode page 70 (Kanji) for Tsukurimashou
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
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradeone.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% "point" is a reserved word
vardef kanji.grtwo.dot =
  push_pbox_toexpand("kanji.grtwo.dot");
  build_kanji.tb(190,-30)
    (build_kanji.sscale(xscaled 1.13)
       (kanji.greight.divination))
    (kanji.bottomrad.four_ticks);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.charcoal =
  push_pbox_toexpand("kanji.grthree.charcoal");
  build_kanji.level(build_kanji.tb(600,-40)
    (build_kanji.sscale(xscaled 0.9)(kanji.grone.mountain))
    (kanji.grsix.ash));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.ash =
  push_pbox_toexpand("kanji.grsix.ash");
  build_kanji.cliff_enclose(kanji.grone.fire);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hi/ka "fire"
begintsuglyph("uni706B",107);
  kanji.grone.fire;
  tsu_render;
endtsuglyph;

% kai/hai "ash"
begintsuglyph("uni7070",112);
  kanji.grsix.ash;
  tsu_render;
endtsuglyph;

% tan/sumi "charcoal"
begintsuglyph("uni70AD",173);
  kanji.grthree.charcoal;
  tsu_render;
endtsuglyph;

% ten/tsu "point"
begintsuglyph("uni70B9",185);
  kanji.grtwo.dot;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
