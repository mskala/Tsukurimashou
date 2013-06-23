%
% Unicode page 89 (Kanji) for Tsukurimashou
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
input gradefive.mp;
input gradefour.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.parent =
  push_pbox_toexpand("kanji.grtwo.parent");
  build_kanji.level(build_kanji.lr(460,50)
    (build_kanji.tb(470,20)
      (kanji.toprad.stand_up)
      (kanji.leftrad.wood))
    (kanji.grone.see));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.essential =
  push_pbox_toexpand("kanji.grfour.essential");
  build_kanji.tb(480,-30)
    (kanji.toprad.ticket)
    (kanji.grone.woman);
  expand_pbox;
enddef;

vardef kanji.grfour.outlook =
  push_pbox_toexpand("kanji.grfour.outlook");
  build_kanji.level(build_kanji.lr(460,50)
    (build_kanji.tb(470,190)
      (kanji.grtwo.arrow;
       replace_strokep(-1)(oldp shifted (-60,0));
       obstacktype[find_whatever(otstroke,0)]:=otnull)
      (kanji.radical.old_bird;
       obstacktype[find_whatever(otstroke,-7)]:=otnull;
       replace_strokep(-6)(point 0 of oldp+(0,15)--point 1 of oldp);
       replace_strokep(-4)(point 0 of oldp+(30,0)--point 1 of oldp)))
    (kanji.grone.see));
  expand_pbox;
enddef;

vardef kanji.grfour.remember =
  push_pbox_toexpand("kanji.grtwo.remember");
    build_kanji.tb(740,100)
      (kanji.toprad.alt_sparkle_three)
      (build_kanji.tb(580,110)
         (kanji.radical.conservative_hat)
         (build_kanji.sscale(xscaled 0.93)(kanji.grone.see)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.solve =
  push_pbox_toexpand("kanji.grfive.solve");
  build_kanji.lr(520,50)
    (kanji.grtwo.corner)
    (build_kanji.level(build_kanji.tb(480,70-40*mincho)
       (kanji.grtwo.sword)
       (kanji.grtwo.cow)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extra: kon/fundoshi "loincloth"
begintsuglyph("uni890C",12);
  build_kanji.lr(380,0)
    (kanji.leftrad.clothes)
    (kanji.grfour.army);
  tsu_render;
endtsuglyph;

% extra: hi/mutsuki "diaper"
begintsuglyph("uni8913",19);
  build_kanji.lr(360,-20)
    (kanji.leftrad.clothes)
    (kanji.grfive.protect);
  tsu_render;
endtsuglyph;

% extra: tai/a "discolour"
begintsuglyph("uni892A",42);
  build_kanji.lr(360,-10)
    (kanji.leftrad.clothes)
    (kanji.grfive.expel);
  tsu_render;
endtsuglyph;

% extra: shou/kasanu "pleats"
begintsuglyph("uni8936",54);
  build_kanji.lr(360,0)
    (kanji.leftrad.clothes)
    (kanji.grthree.learn);
  tsu_render;
endtsuglyph;

% extra: kyou/mutsuki "diaper"
begintsuglyph("uni8941",65);
  build_kanji.lr(360,-20)
    (kanji.leftrad.clothes)
    (kanji.grtwo.strong);
  tsu_render;
endtsuglyph;

% extra: zetsu/maji "blended"
begintsuglyph("uni894D",77);
  build_kanji.lr(360,-10)
    (kanji.leftrad.clothes)
    (kanji.grthree.collect);
  tsu_render;
endtsuglyph;

% extra: shin/hadagi "underwear"
begintsuglyph("uni896F",111);
  build_kanji.lr(340,0)
    (kanji.leftrad.clothes)
    (kanji.grtwo.parent);
  tsu_render;
endtsuglyph;

% sai/nishi "West" or "Spain"
begintsuglyph("uni897F",127);
  kanji.grtwo.west;
  tsu_render;
endtsuglyph;

% you/i "essential"
begintsuglyph("uni8981",129);
  kanji.grfour.essential;
  tsu_render;
endtsuglyph;

% ken/mi "see"
begintsuglyph("uni898B",139);
  kanji.grone.see;
  tsu_render;
endtsuglyph;

% extra: beki/moto "seek"
begintsuglyph("uni8993",147);
  build_kanji.level(build_kanji.tb(580,0)
    (kanji.toprad.paw)
    (kanji.grone.see));
  tsu_render;
endtsuglyph;

% kaku/obo "remember"
begintsuglyph("uni899A",154);
  kanji.grfour.remember;
  tsu_render;
endtsuglyph;

% shin/oya/shita "parent"
begintsuglyph("uni89AA",170);
  kanji.grtwo.parent;
  tsu_render;
endtsuglyph;

% kan/mi "outlook"
begintsuglyph("uni89B3",179);
  kanji.grfour.outlook;
  tsu_render;
endtsuglyph;

% kaku/kado "corner"
begintsuglyph("uni89D2",210);
  kanji.grtwo.corner;
  tsu_render;
endtsuglyph;

% kai/to "solve"
begintsuglyph("uni89E3",227);
  kanji.grfive.solve;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
