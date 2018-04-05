%
% Unicode page 8E (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2017  Matthew Skala
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
input radical.mp;
input rare.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.lightweight =
  push_pbox_toexpand("kanji.grthree.lightweight");
  build_kanji.level(build_kanji.lr(500,00)
    (kanji.grone.wheel)
    (kanji.rare.sacred));
  expand_pbox;
enddef;

vardef kanji.grthree.roll =
  push_pbox_toexpand("kanji.grthree.roll");
  build_kanji.level(build_kanji.lr(500,00)
    (kanji.grone.wheel)
    (tsu_xform(identity yscaled 1.03)(kanji.grnine.declaim)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% shin/mi "body"
begintsuglyph("uni8EAB",171);
  kanji.grthree.body;
  tsu_render;
endtsuglyph;

% kuruma "car/wheel"
begintsuglyph("uni8ECA",202);
  kanji.grone.wheel;
  tsu_render;
endtsuglyph;

% gun/ikusa "army"
begintsuglyph("uni8ECD",205);
  kanji.grfour.army;
  tsu_render;
endtsuglyph;

% ten/koro "roll"
begintsuglyph("uni8EE2",226);
  kanji.grthree.roll;
  tsu_render;
endtsuglyph;

% kei/karu "lightweight"
begintsuglyph("uni8EFD",253);
  kanji.grthree.lightweight;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
