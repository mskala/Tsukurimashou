%
% Unicode page 63 (Kanji) for Tsukurimashou
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
input gradefive.mp;
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

vardef kanji.grthree.finger =
  push_pbox_toexpand("kanji.grthree.finger");
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.leftrad.hand)
    (kanji.greight.glutamate));
  expand_pbox;
enddef;

vardef kanji.grthree.have =
  push_pbox_toexpand("kanji.grthree.have");
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.leftrad.hand)
    (kanji.grtwo.temple));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.lift =
  push_pbox_toexpand("kanji.grfour.lift");
  build_kanji.level(build_kanji.sscale(xscaled 0.92 shifted (6,0))
    (build_kanji.tb(480,180)
       (build_kanji.tb(720,380)
          (kanji.toprad.alt_sparkle_three)
          (build_kanji.spread_legs(280)(kanji.grone.big);
           replace_strokep(-1)(subpath
               (xpart (oldp intersectiontimes get_strokep(-2)),infinity)
             of oldp)))
       (build_kanji.warp((700-40*mincho,850),(300,850),
                         (-50-20*mincho,-50),(1050-20*mincho,-50))
          (kanji.grone.hand))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.award =
  push_pbox_toexpand("kanji.grfive.award");
  build_kanji.level(build_kanji.lr(400,-20)
    (kanji.leftrad.hand)
    (kanji.grthree.accept));
  expand_pbox;
enddef;

vardef kanji.grfive.gather =
  push_pbox_toexpand("kanji.grfive.gather");
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.leftrad.hand)
    (kanji.greight.dice));
  expand_pbox;
enddef;

vardef kanji.grfive.proposal =
  push_pbox_toexpand("kanji.grfive.proposal");
  build_kanji.level(build_kanji.lr(360,30)
    (kanji.leftrad.hand)
    (kanji.greight.righteousness));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.depict =
  push_pbox_toexpand("kanji.greight.depict");
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.leftrad.hand)
    (build_kanji.sscale(shifted (0,-40))(kanji.greight.seedling)));
  expand_pbox;
enddef;

vardef kanji.greight.discharge =
  push_pbox_toexpand("kanji.greight.discharge");
  build_kanji.level(build_kanji.lr(420,-30)
    (kanji.leftrad.hand)
    (kanji.grfive.mistake));
  expand_pbox;
enddef;

vardef kanji.greight.vibrate =
  push_pbox_toexpand("kanji.greight.discharge");
  build_kanji.level(build_kanji.lr(360,40)
    (kanji.leftrad.hand)
    (build_kanji.tb(480,0)
       (kanji.toprad.paw)
       (push_stroke((200,760)--(800,760),(1.6,1.6)--(1.6,1.6));
        set_boserif(0,1,9);
        push_stroke((120,500)--(880,500),(1.6,1.6)--(1.6,1.6));
        set_boserif(0,1,9);
        push_stroke((500,760)--(500,0),(1.6,1.6)--(1.5,1.5));
        build_kanji.cup((220,300),(780,0)))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ji/mo "have"
begintsuglyph("uni6301",1);
  kanji.grthree.have;
  tsu_render;
endtsuglyph;

% shi/yubi "finger"
begintsuglyph("uni6307",7);
  kanji.grthree.finger;
  tsu_render;
endtsuglyph;

%kyo/a "lift"
begintsuglyph("uni6319",25);
  kanji.grfour.lift;
  tsu_render;
endtsuglyph;

% ju/sazu "award"
begintsuglyph("uni6388",136);
  kanji.grfive.award;
  tsu_render;
endtsuglyph;

% hai "discharge"
begintsuglyph("uni6392",146);
  kanji.greight.discharge;
  tsu_render;
endtsuglyph;

% sai/to "gather"
begintsuglyph("uni63A1",161);
  kanji.grfive.gather;
  tsu_render;
endtsuglyph;

% byou/ega "depict"
begintsuglyph("uni63CF",207);
  kanji.greight.depict;
  tsu_render;
endtsuglyph;

% tei/sa "proposal" (or "lunchbox," or "prostitute")
begintsuglyph("uni63D0",208);
  kanji.grfive.proposal;
  tsu_render;
endtsuglyph;

% you/yu "vibrate"
begintsuglyph("uni63FA",250);
  kanji.greight.vibrate;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
