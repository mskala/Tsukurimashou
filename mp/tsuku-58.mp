%
% Unicode page 58 (Kanji) for Tsukurimashou
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
input gradeeight.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.place =
  push_pbox_toexpand("kanji.grtwo.place");
  build_kanji.level(build_kanji.lr(370,0)
    (tsu_xform(identity shifted (0,20))(kanji.leftrad.earth))
    (kanji.rare.sun));
  expand_pbox;
enddef;

vardef kanji.grtwo.voice =
  push_pbox_toexpand("kanji.grtwo.voice");
  build_kanji.tb(530,-60)
    (kanji.grfour.gentleman)
    (kanji.radical.flag;
     push_stroke((500,730)--(500,490),(1.5,1.5)--(1.4,1.4)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.hall =
  push_pbox_toexpand("kanji.grfour.hall");
  build_kanji.level(build_kanji.tb(260,100)
    (kanji.toprad.ridiculous_hat)
    (kanji.grone.earth;
     set_boserif(-2,0,whatever)));
  expand_pbox;
enddef;

vardef kanji.grfour.salt =
  push_pbox_toexpand("kanji.grfour.salt");
  build_kanji.lr(370,0)
    (kanji.leftrad.earth)
    (build_kanji.level(build_kanji.tb(620,150)
       (kanji.toprad.slash)
       (build_kanji.tb(420,0)
          (build_kanji.sscale(scaled 0.75 shifted (20,0))
             (kanji.grone.mouth))
          (kanji.grthree.dish))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.report =
  push_pbox_toexpand("kanji.grfive.report");
  build_kanji.level(build_kanji.lr(520,0)
    (kanji.grthree.blessing)
    (kanji.rightrad.clothing));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.legal_one =
  push_pbox_toexpand("kanji.greight.legal_one");
  build_kanji.level(build_kanji.tb(550,0)
    (kanji.grfour.gentleman)
    (kanji.rare.other;
     set_bosize(-3,0)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% dou "hall"
begintsuglyph("uni5802",2);
  kanji.grfour.hall;
  tsu_render;
endtsuglyph;

% hou/muku "report"
begintsuglyph("uni5831",49);
  kanji.grfive.report;
  tsu_render;
endtsuglyph;

% shou/ba "place"
begintsuglyph("uni5834",52);
  kanji.grtwo.place;
  tsu_render;
endtsuglyph;

% en/shio "salt"
begintsuglyph("uni5869",105);
  kanji.grfour.salt;
  tsu_render;
endtsuglyph;

% shi "gentleman" ("samurai" radical)
begintsuglyph("uni58EB",235);
  kanji.grfour.gentleman;
  tsu_render;
endtsuglyph;

% jin/mizunoe "ninth"
begintsuglyph("uni58EC",236);
  kanji.grnine.ninth;
  tsu_render;
endtsuglyph;

% ichi/hitotsu "one" (formal, also first musical scale degree)
begintsuglyph("uni58F1",241);
  kanji.greight.legal_one;
  tsu_render;
endtsuglyph;

% sei/koe "voice"
begintsuglyph("uni58F0",240);
  kanji.grtwo.voice;
  tsu_render;
endtsuglyph;

% bai/u "sell"
begintsuglyph("uni58F2",242);
  kanji.grtwo.sell;
  tsu_render;
endtsuglyph;

% needed for grfour.pleasure
begintsuglyph("uni58F4",244);
  kanji.toprad.pleasure;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
