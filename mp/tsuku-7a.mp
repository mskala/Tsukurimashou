%
% Unicode page 7a (Kanji) for Tsukurimashou
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
input gradeone.mp;
input gradetwo.mp;
input radical.mp;
input toprad.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.sky =
  push_pbox_toexpand("kanji.grone.sky");
  build_kanji.level(build_kanji.tb(500,70)
    (kanji.toprad.cave)
    (kanji.grtwo.craft));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.chapter =
  push_pbox_toexpand("kanji.grthree.chapter");
  build_kanji.level(build_kanji.tb(480,-70)
    (kanji.grone.stand_up)
    (kanji.grone.early));
  expand_pbox;
enddef;

vardef kanji.grthree.child =
  push_pbox_toexpand("kanji.grthree.child");
  build_kanji.level(build_kanji.tb(480,-30)
    (kanji.grone.stand_up)
    (kanji.grtwo.neighbourhood ));
  expand_pbox;
enddef;

vardef kanji.grthree.research =
  push_pbox_toexpand("kanji.grthree.research");
  build_kanji.level(build_kanji.tb(500,70)
    (kanji.toprad.cave)
    (kanji.grone.nine));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kyuu/kiwa "research
begintsuglyph("uni7A76",118);
  kanji.grthree.research;
  tsu_render;
endtsuglyph;

% kara/sora "sky"
begintsuglyph("uni7A7A",122);
  kanji.grone.sky;
  tsu_render;
endtsuglyph;

% ta "stand up"
begintsuglyph("uni7ACB",203);
  kanji.grone.stand_up;
  tsu_render;
endtsuglyph;

% shou/aki "chapter"
begintsuglyph("uni7AE0",224);
  kanji.grthree.chapter;
  tsu_render;
endtsuglyph;

% dou/warabe "child"
begintsuglyph("uni7AE5",229);
  kanji.grthree.child;
  tsu_render;
endtsuglyph;

% chiku/take "bamboo"
begintsuglyph("uni7AF9",249);
  kanji.grone.bamboo;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
