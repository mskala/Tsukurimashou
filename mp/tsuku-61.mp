%
% Unicode page 61 (Kanji) for Tsukurimashou
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
input gradefive.mp;
input gradeone.mp;
input gradethree.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.feeling =
  push_pbox_toexpand("kanji.grthree.feeling");
  build_kanji.level(build_kanji.tb(250,0)
    (kanji.rare.the_same)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.manner =
  push_pbox_toexpand("kanji.grfive.manner");
  build_kanji.level(build_kanji.tb(230,0)
    (kanji.grfive.talent)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.indignation =
  push_pbox_toexpand("kanji.greight.indignation");
  build_kanji.level(build_kanji.lr(320,50)
    (kanji.leftrad.heart;
     replace_strokep(0)(oldp shifted (0,-50)))
    (kanji.rare.decorate));
  expand_pbox;
enddef;

vardef kanji.greight.melancholy =
  push_pbox_toexpand("kanji.greight.melancholy");
  build_kanji.level(build_kanji.tb(400,115)
    (build_kanji.tb(260,193)
       (kanji.toprad.summer)
       (kanji.radical.conservative_hat))
    (build_kanji.tb(480,-40)
       (build_kanji.sscale(xscaled 0.8)(kanji.bottomrad.heart))
       (kanji.radical.winter)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% i/moto "intention"
begintsuglyph("uni610F",15);
  kanji.grthree.intention;
  tsu_render;
endtsuglyph;

% kan "feeling"
begintsuglyph("uni611F",31);
  kanji.grthree.feeling;
  tsu_render;
endtsuglyph;

% tai/waza "manner"
begintsuglyph("uni614B",75);
  kanji.grfive.manner;
  tsu_render;
endtsuglyph;

% yuu/ure "melancholy"
begintsuglyph("uni6182",130);
  kanji.greight.melancholy;
  tsu_render;
endtsuglyph;

% fun/ikidoo "indignation"
begintsuglyph("uni61A4",164);
  kanji.greight.indignation;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
