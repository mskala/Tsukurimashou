%
% Unicode page 6F (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2017  Matthew Skala
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
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.go_fish =
  push_pbox_toexpand("kanji.grfour.go_fish");
  build_kanji.lr(270,-10)
    (kanji.leftrad.water)
    (kanji.grtwo.fish);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.performance =
  push_pbox_toexpand("kanji.grfive.performance");
  build_kanji.lr(320,-30)
    (kanji.leftrad.water)
    (kanji.grnine.tiger_sign);
  expand_pbox;
enddef;

% can't easily refactor this because it uses (only in the Japanese form)
% a strange left-side variant of U+4E30 with the bottom clipped off
vardef kanji.grfive.undefiled =
  push_pbox_toexpand("kanji.grfive.undefiled");
  build_kanji.lr(280,-20)
    (kanji.leftrad.water)
    (build_kanji.tb(380,0)
       (build_kanji.lr(480,30)
          (build_kanji.level(build_kanji.lift_skirt(370,150+30*mincho)
             (tsu_xform(identity yscaled 0.74)(kanji.grone.three);
              push_stroke((500,780)--(500,0),
                (1.6,1.6)--(1.5,1.5));
              set_boserif(0,0,10))))
          (kanji.grtwo.sword))
       (kanji.grone.thread));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.tide =
  push_pbox_toexpand("kanji.grsix.tide");
  build_kanji.lr(300,30)
    (kanji.leftrad.water)
    (kanji.grtwo.morning);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% gyo/asa "go fish"
begintsuglyph("uni6F01",1);
  kanji.grfour.go_fish;
  tsu_render;
endtsuglyph;

% en "performance"
begintsuglyph("uni6F14",20);
  kanji.grfive.performance;
  tsu_render;
endtsuglyph;

% kan "Chinese"
begintsuglyph("uni6F22",34);
  build_kanji.level(build_kanji.lr(360,10)
    (kanji.leftrad.water)
    (build_kanji.tb(630,-10)
       (kanji.toprad.grass)
       (build_kanji.box((210,800),(790,570));
        tsu_xform(identity yscaled 0.65 shifted (-10,0))
          (kanji.grfour.husband);
        replace_strokep(-1)((500,800)--oldp);
        replace_strokeq(-1)((1.6,1.6)--oldq);
        set_boserif(-1,0,whatever))));
  tsu_render;
endtsuglyph;

% ketsu/isagiyo "undefiled" (clean, pure)
begintsuglyph("uni6F54",84);
  kanji.grfive.undefiled;
  tsu_render;
endtsuglyph;

% chou/shio "tide" (or "opportunity")
begintsuglyph("uni6F6E",110);
  kanji.grsix.tide;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
