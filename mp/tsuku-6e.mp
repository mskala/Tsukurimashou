%
% Unicode page 6E (Kanji) for Tsukurimashou
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
input bottomrad.mp;
input buildkanji.mp;
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.harbour =
  push_pbox_toexpand("kanji.grthree.harbour");
  build_kanji.lr(290,20)
    (kanji.leftrad.water)
    (kanji.grnine.fork_in_the_road);
  expand_pbox;
enddef;

vardef kanji.grthree.hot_water =
  push_pbox_toexpand("kanji.grthree.hot_water");
  build_kanji.lr(290,20)
    (kanji.leftrad.water)
    (build_kanji.sscale(yscaled 0.9)(kanji.rare.sun));
  expand_pbox;
enddef;

vardef kanji.grthree.lake =
  push_pbox_toexpand("kanji.grthree.lake");
  build_kanji.lr(290,20)
    (kanji.leftrad.water)
    (kanji.grnine.barbarian);
  expand_pbox;
enddef;

vardef kanji.grthree.warm =
  push_pbox_toexpand("kanji.grthree.warm");
  build_kanji.lr(290,20)
    (kanji.leftrad.water)
    (build_kanji.level(build_kanji.tb(360,0)
       (build_kanji.sscale(scaled 0.87)(kanji.grone.day))
       (kanji.grthree.dish)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.full =
  push_pbox_toexpand("kanji.grfour.full");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (build_kanji.level(build_kanji.tb(560,100)
       (kanji.toprad.grass)
       (kanji.grthree.both)));
  expand_pbox;
enddef;

vardef kanji.grfour.pure =
  push_pbox_toexpand("kanji.grfour.pure");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.blue);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.measure =
  push_pbox_toexpand("kanji.grfive.measure");
  build_kanji.lr(290,10)
    (kanji.leftrad.water)
    (kanji.grfive.conform);
  expand_pbox;
enddef;

vardef kanji.grfive.reduce =
  push_pbox_toexpand("kanji.grfive.reduce");
  build_kanji.lr(290,-30)
    (kanji.leftrad.water)
    (kanji.rare.the_same);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.source =
  push_pbox_toexpand("kanji.grsix.source");
  build_kanji.lr(270,-10)
    (kanji.leftrad.water)
    (kanji.grtwo.field);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.pool =
  push_pbox_toexpand("kanji.grnine.pool");
  build_kanji.lr(290,10)
    (kanji.leftrad.water)
    (kanji.grfive.detain);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sei/kiyo "pure"
begintsuglyph("uni6E05",5);
  kanji.grfour.pure;
  tsu_render;
endtsuglyph;

% gen/he "reduce"
begintsuglyph("uni6E1B",27);
  kanji.grfive.reduce;
  tsu_render;
endtsuglyph;

% on/atata "warm"
begintsuglyph("uni6E29",41);
  kanji.grthree.warm;
  tsu_render;
endtsuglyph;

% soku/haka "measure"
begintsuglyph("uni6E2C",44);
  kanji.grfive.measure;
  tsu_render;
endtsuglyph;

% kou/minato "harbour"
begintsuglyph("uni6E2F",47);
  kanji.grthree.harbour;
  tsu_render;
endtsuglyph;

% tou/yu "hot water"
begintsuglyph("uni6E6F",111);
  kanji.grthree.hot_water;
  tsu_render;
endtsuglyph;

% ko/mizuumi "lake"
begintsuglyph("uni6E56",86);
  kanji.grthree.lake;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6E76",118);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grsix.fountain);
  tsu_render;
endtsuglyph;

% man/mi "full"
begintsuglyph("uni6E80",128);
  kanji.grfour.full;
  tsu_render;
endtsuglyph;

% gen/minamoto "source" (also "gen" as in "Genji Monogatari")
begintsuglyph("uni6E90",144);
  kanji.grsix.source;
  tsu_render;
endtsuglyph;

% ryuu/ta "pool" or "collect"
begintsuglyph("uni6E9C",156);
  kanji.grnine.pool;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
