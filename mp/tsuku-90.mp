%
% Unicode page 90 (Kanji) for Tsukurimashou
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
input gradefour.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.distant =
  push_pbox_toexpand("kanji.grtwo.distant");
  build_kanji.road_enclose(tsu_xform(identity shifted (0,-20))
    (kanji.radical.long_kimono));
  expand_pbox;
enddef;

vardef kanji.grtwo.street =
  push_pbox_toexpand("kanji.grtwo.street");
  build_kanji.road_enclose(kanji.grtwo.neck);
  expand_pbox;
enddef;

vardef kanji.grtwo.traffic =
  push_pbox_toexpand("kanji.grtwo.traffic");
  build_kanji.road_enclose(kanji.rare.walled_road);
  expand_pbox;
enddef;

vardef kanji.grtwo.week =
  push_pbox_toexpand("kanji.grtwo.week");
  build_kanji.road_enclose(kanji.grfour.circuit);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.fast =
  push_pbox_toexpand("kanji.grthree.fast");
  build_kanji.road_enclose(kanji.grfour.bundle);
  expand_pbox;
enddef;

vardef kanji.grthree.fortune =
  push_pbox_toexpand("kanji.grthree.fortune");
  build_kanji.road_enclose(kanji.grfour.army);
  expand_pbox;
enddef;

vardef kanji.grthree.metropolis =
  push_pbox_toexpand("kanji.grthree.metropolis");
  build_kanji.lr(580,0)
    (kanji.grthree.person)
    (kanji.rightrad.beta);
  expand_pbox;
enddef;

vardef kanji.grthree.proceed =
  push_pbox_toexpand("kanji.grthree.proceed");
  build_kanji.road_enclose(kanji.radical.old_bird);
  expand_pbox;
enddef;

vardef kanji.grthree.section =
  push_pbox_toexpand("kanji.grthree.section");
  build_kanji.lr(580,0)
    (build_kanji.tb(340,-60+20*mincho)
       (kanji.toprad.stand_up)
       (kanji.grone.mouth))
    (kanji.rightrad.beta);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tsuu/too "distant"
begintsuglyph("uni901A",26);
  kanji.grtwo.traffic;
  tsu_render;
endtsuglyph;

% soku/haya "fast"
begintsuglyph("uni901F",31);
  kanji.grthree.fast;
  tsu_render;
endtsuglyph;

% shuu "week"
begintsuglyph("uni9031",49);
  kanji.grtwo.week;
  tsu_render;
endtsuglyph;

% sin/susu "proceed"
begintsuglyph("uni9032",50);
  kanji.grthree.proceed;
  tsu_render;
endtsuglyph;

% sin/susu "proceed"
begintsuglyph("uni904B",75);
  kanji.grthree.fortune;
  tsu_render;
endtsuglyph;

% dou/michi "street"
begintsuglyph("uni9053",83);
  kanji.grtwo.street;
  tsu_render;
endtsuglyph;

% en/too "distant"
begintsuglyph("uni9060",96);
  kanji.grtwo.distant;
  tsu_render;
endtsuglyph;

% bu/be "section"
begintsuglyph("uni90E8",232);
  kanji.grthree.section;
  tsu_render;
endtsuglyph;

% to/miyako "metropolis"
begintsuglyph("uni90FD",253);
  kanji.grthree.metropolis;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
