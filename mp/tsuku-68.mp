%
% Unicode page 68 (Kanji) for Tsukurimashou
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
input buildkanji.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.forest =
  push_pbox_toexpand("kanji.grone.forest");
  build_kanji.tb(500,100)
    (kanji.grone.wood)
    (build_kanji.lr(480,0)
       (kanji.leftrad.wood)
       (kanji.grone.wood));
  expand_pbox;
enddef;

vardef kanji.grone.school =
  push_pbox_toexpand("kanji.grone.school");
  build_kanji.lr(480,30)
    (kanji.leftrad.wood)
    (kanji.grtwo.mix);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.root =
  push_pbox_toexpand("kanji.grthree.root");
  build_kanji.lr(480,80)
    (kanji.leftrad.wood)
    (kanji.radical.northeast);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.plan =
  push_pbox_toexpand("kanji.grfour.plan");
  build_kanji.tb(320,10)
    (kanji.grthree.easy)
    (kanji.grone.wood);
  expand_pbox;
enddef;

vardef kanji.grfour.plum =
  push_pbox_toexpand("kanji.grfour.plum");
  build_kanji.lr(370,20)
    (kanji.leftrad.wood)
    (kanji.grtwo.every);
  expand_pbox;
enddef;

vardef kanji.grfour.prosperity =
  push_pbox_toexpand("kanji.grfour.prosperity");
  build_kanji.tb(740,100)
    (kanji.toprad.alt_sparkle_three)
    (build_kanji.tb(580,180)
       (kanji.radical.conservative_hat)
       (kanji.grone.wood));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ei/saka "prosperity"
begintsuglyph("uni6804",4);
  kanji.grfour.prosperity;
  tsu_render;
endtsuglyph;

% kou "school"
begintsuglyph("uni6821",33);
  kanji.grone.school;
  tsu_render;
endtsuglyph;

% kon/ne "root"
begintsuglyph("uni6839",57);
  kanji.grthree.root;
  tsu_render;
endtsuglyph;

% an/tsukue "plan"
begintsuglyph("uni6848",72);
  kanji.grfour.plan;
  tsu_render;
endtsuglyph;

% bai/ume "plum"
begintsuglyph("uni6885",133);
  kanji.grfour.plum;
  tsu_render;
endtsuglyph;

% shin/mori "forest"
begintsuglyph("uni68EE",238);
  kanji.grone.forest;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
