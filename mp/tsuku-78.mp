%
% Unicode page 78 (Kanji) for Tsukurimashou
% Copyright (C) 2012, 2017  Matthew Skala
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
input bkencl.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradeone.mp;
input gradethree.mp;
input radical.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.sharpen =
  push_pbox_toexpand("kanji.grthree.sharpen");
  build_kanji.level(build_kanji.lr(460,-40)
    (kanji.grone.stone)
    (kanji.radical.topped_aitch));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.certainly =
  push_pbox_toexpand("kanji.grfive.certainly");
  build_kanji.level(build_kanji.lr(420,-20)
    (build_kanji.sscale(yscaled 0.9 shifted (0,40))(kanji.grone.stone))
    (kanji.radical.yatwbmw));
  expand_pbox;
enddef;

vardef kanji.grfive.tear_out =
  push_pbox_toexpand("kanji.grfive.tear_out");
  build_kanji.level(build_kanji.lr(420,-20)
    (build_kanji.sscale(yscaled 0.9 shifted (0,40))(kanji.grone.stone))
    (kanji.grthree.pelt));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ken/to "sharpen"
begintsuglyph("uni7814",20);
  kanji.grthree.sharpen;
  tsu_render;
endtsuglyph;

% ha/yabu "tear out"
begintsuglyph("uni7834",52);
  kanji.grfive.tear_out;
  tsu_render;
endtsuglyph;

% kaku/tashika "certainly"
begintsuglyph("uni78BA",186);
  kanji.grfive.certainly;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
