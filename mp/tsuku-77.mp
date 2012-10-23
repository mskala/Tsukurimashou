%
% Unicode page 77 (Kanji) for Tsukurimashou
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
input gradefour.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.know =
  push_pbox_toexpand("kanji.grtwo.know");
  build_kanji.level(build_kanji.lr(550,-20)
    (kanji.leftrad.arrow)
    (kanji.grone.mouth));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.prefecture =
  push_pbox_toexpand("kanji.grthree.prefecture");
  build_kanji.level(build_kanji.tb(240,30)
    (build_kanji.sscale(scaled 0.80 shifted (0,100))(kanji.grone.eye);
     build_kanji.cup((120,580),(880,20));
     set_bosize(-1,0);
     set_boserif(0,1,9))
    (push_stroke((490,890)--(490,-80),(1.6,1.6)--(1.5,1.5));
     push_stroke((320,630)..tension 1.3..(220,210)..(100,-60),
       (1.6,1.6)--(1.5,1.5)--(1,1));
     set_boserif(0,0,10);
     push_stroke((630,680)..tension 1.3..(760,370)..(860,0),
       (1,1)--(1.5,1.5)--(1.8,1.8))));
  expand_pbox;
enddef;

vardef kanji.grthree.short =
  push_pbox_toexpand("kanji.grhree.short");
  build_kanji.level(build_kanji.lr(550,-20)
    (kanji.leftrad.arrow)
    (tsu_xform(identity shifted (0,-20))(kanji.grthree.bean)));
  expand_pbox;
enddef;

vardef kanji.grthree.truth =
  push_pbox_toexpand("kanji.grthree.truth");
  build_kanji.level(build_kanji.tb(200,-60)
    (build_kanji.tb(500,70)
       (kanji.grone.ten)
       (kanji.grone.eye))
    (push_stroke((100,850)--(900,850),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9);
     push_stroke((320,630)..tension 1.3..(220,210)..(100,-60),
       (1.6,1.6)--(1.5,1.5)--(1,1));
     set_boserif(0,0,10);
     push_stroke((630,680)..tension 1.3..(760,370)..(860,0),
       (1,1)--(1.5,1.5)--(1.8,1.8))));
  expand_pbox;
enddef;

vardef kanji.grthree.wear_clothes =
  push_pbox_toexpand("kanji.grthree.wear_clothes");
  build_kanji.level(
    build_kanji.tb(370,70)
      (build_kanji.sscale(xscaled 1.08)
          (kanji.grthree.sheep;
           replace_strokep(0)((point 0 of oldp)
             --(oldp intersectionpoint get_strokep(-3)))))
      (tsu_xform(identity shifted (15,0))(kanji.grone.eye));
    push_stroke(
      (point 0.30 of get_strokep(-7))..tension 1.2..(190,280)..(80,200),
      (1.6,1.6)--(1.4,1.4)--(1,1)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.ministry =
  push_pbox_toexpand("kanji.grfour.ministry");
  build_kanji.level(build_kanji.tb(420,50)
    (kanji.grtwo.little)
    (build_kanji.sscale(xscaled 0.84 shifted (40,0))(kanji.grone.eye)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.arrow =
  push_pbox_toexpand("kanji.leftrad.arrow");
  kanji.grtwo.arrow;
  replace_strokep(0)((point 1.6 of get_strokep(-1))..(690,200)..(850,80));
  replace_strokeq(0)((0.9,0.9)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sei/kaeri "ministry"
begintsuglyph("uni7701",1);
  kanji.grfour.ministry;
  tsu_render;
endtsuglyph;

% ken/ka "prefecture"
begintsuglyph("uni770C",12);
  kanji.grthree.prefecture;
  tsu_render;
endtsuglyph;

% shin/ma "truth"
begintsuglyph("uni771F",31);
  kanji.grthree.truth;
  tsu_render;
endtsuglyph;

% chaku/ki/tsu "wear clothes"
begintsuglyph("uni7740",64);
  kanji.grthree.wear_clothes;
  tsu_render;
endtsuglyph;

% extra: "luxuriance"
begintsuglyph("uni77D7",215);
  build_kanji.tricluster(0.85)
    (build_kanji.thickness(0.7)(kanji.grtwo.straight))
    (build_kanji.thickness(0.8)(kanji.grtwo.straight))
    (build_kanji.thickness(0.8)(kanji.grtwo.straight));
  tsu_render;
endtsuglyph;

% shi/ya "arrow"
begintsuglyph("uni77E2",226);
  kanji.grtwo.arrow;
  tsu_render;
endtsuglyph;

% chi/shi "to know"
begintsuglyph("uni77E5",229);
  kanji.grtwo.know;
  tsu_render;
endtsuglyph;

% tan/mijika "short"
begintsuglyph("uni77ED",237);
  kanji.grthree.short;
  tsu_render;
endtsuglyph;

% seki/ishi "stone"
begintsuglyph("uni77F3",243);
  kanji.grone.stone;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
