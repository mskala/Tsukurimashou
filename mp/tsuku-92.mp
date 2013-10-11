%
% Unicode page 92 (Kanji) for Tsukurimashou
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
input bkencl.mp;
input buildkanji.mp;
input gradefour.mp;
input gradeone.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.iron =
  push_pbox_toexpand("kanji.grthree.iron");
  build_kanji.level(build_kanji.lr(480,20)
    (kanji.leftrad.gold)
    (kanji.grfour.disappear));
  expand_pbox;
enddef;

vardef kanji.grthree.silver =
  push_pbox_toexpand("kanji.grthree.silver");
  build_kanji.level(build_kanji.lr(480,90-20*mincho)
    (kanji.leftrad.gold)
    (kanji.radical.northeast));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.cent =
  push_pbox_toexpand("kanji.grfive.cent");
  build_kanji.level(build_kanji.lr(520,20)
    (kanji.leftrad.gold)
    (build_kanji.sscale(shifted (0,40))
       (kanji.radical.three_tasselled_spear)));
  expand_pbox;
enddef;

vardef kanji.grfive.copper =
  push_pbox_toexpand("kanji.grfive.copper");
  build_kanji.level(build_kanji.lr(480,-20)
    (kanji.leftrad.gold)
    (kanji.grtwo.same));
  expand_pbox;
enddef;

vardef kanji.grfive.ore =
  push_pbox_toexpand("kanji.grfive.ore");
  build_kanji.level(build_kanji.lr(480,-20)
    (kanji.leftrad.gold)
    (kanji.grtwo.wide));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tetsu/kurogane "iron"
begintsuglyph("uni9244",68);
  kanji.grthree.iron;
  tsu_render;
endtsuglyph;

% kou/aragane "ore"
begintsuglyph("uni9271",113);
  kanji.grfive.ore;
  tsu_render;
endtsuglyph;

% gin/shirogane "silver"
begintsuglyph("uni9280",128);
  kanji.grthree.silver;
  tsu_render;
endtsuglyph;

% dou/akagane "copper"
begintsuglyph("uni9285",133);
  kanji.grfive.copper;
  tsu_render;
endtsuglyph;

% sen "hundredth of a yen"
begintsuglyph("uni92AD",173);
  kanji.grfive.cent;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
