%
% Unicode page 62 (Kanji) for Tsukurimashou
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
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.door =
  push_pbox_toexpand("kanji.grtwo.door");
  tsu_xform(identity yscaled (600/730))(kanji.radical.flag);
  push_stroke((120,760)--(880,760),(1.6,1.6));
  set_boserif(0,1,9);
  set_bosize(0,95);
  expand_pbox;
enddef;

vardef kanji.grtwo.genius =
  push_pbox_toexpand("kanji.grtwo.genius");
  push_stroke((500,810),(1.6,1.6));
  build_kanji.add_jtail(0);
  set_boserif(0,0,10);
  push_stroke((80,580)--(810,580),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((750,470)..tension 1.2..(420,210)..(110,70),
    (1.5,1.5)--(1.2,1.2)--(1,1));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.gather =
  push_pbox_toexpand("kanji.grthree.gather");
  build_kanji.level(build_kanji.lr(420,50)
    (kanji.leftrad.hand)
    (kanji.grtwo.join));
  expand_pbox;
enddef;

vardef kanji.grthree.hit =
  push_pbox_toexpand("kanji.grthree.hit");
  build_kanji.level(build_kanji.lr(420,-20)
    (kanji.leftrad.hand)
    (kanji.grthree.thumbtack));
  expand_pbox;
enddef;

vardef kanji.grthree.place =
  push_pbox_toexpand("kanji.grthree.place");
  build_kanji.level(build_kanji.lr(480,20)
    (kanji.grtwo.door)
    (kanji.greight.axe));
  expand_pbox;
enddef;

vardef kanji.grthree.throw =
  push_pbox_toexpand("kanji.grthree.throw");
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.leftrad.hand)
    (kanji.radical.windy_again));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.battle =
  push_pbox_toexpand("kanji.grfour.battle");
  build_kanji.level(build_kanji.lr(520,100)
    (build_kanji.sscale(yscaled 0.94 shifted (0,-30))(kanji.grfour.single))
    (kanji.radical.tasselled_spear));
  expand_pbox;
enddef;

vardef kanji.grfour.become =
  push_pbox_toexpand("kanji.grfour.become");
  kanji.grnine.fifth;
  push_stroke((173,280)--(410,280),
    (1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  replace_strokep(0)(oldp shifted (0,110));
  set_boserif(0,1,4);
  set_botip(0,1,1);
  expand_pbox;
enddef;

vardef kanji.grfour.fold =
  push_pbox_toexpand("kanji.grfour.fold");
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.hand)
    (kanji.greight.axe));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.beckon =
  push_pbox_toexpand("kanji.grfive.beckon");
  build_kanji.level(build_kanji.lr(420,-10)
    (kanji.leftrad.hand)
    (kanji.greight.call));
  expand_pbox;
enddef;

vardef kanji.grfive.technique =
  push_pbox_toexpand("kanji.grfive.technique");
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.hand)
    (kanji.grfive.support));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.carry =
  push_pbox_toexpand("kanji.grsix.carry");
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.hand)
    (kanji.greight.daybreak));
  expand_pbox;
enddef;

vardef kanji.grsix.criticize =
  push_pbox_toexpand("kanji.grsix.criticize");
  build_kanji.level(build_kanji.lr(420,10)
    (kanji.leftrad.hand)
    (build_kanji.sscale(yscaled 1.04 shifted (0,20))
       (kanji.grfive.compare)));
  expand_pbox;
enddef;

vardef kanji.grsix.spread =
  push_pbox_toexpand("kanji.grsix.spread");
  build_kanji.level(build_kanji.lr(420,-10)
    (kanji.leftrad.hand)
    (kanji.grtwo.wide));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.fifth =
  push_pbox_toexpand("kanji.grnine.fifth");
  push_stroke((50,-50)..(120,100)..(160,300)..tension 1.2..(180,560)
      --(850,560),
    (1,1)--(1.3,1.3)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,3,1);
  set_boserif(0,4,9);
  push_stroke(interpath(mincho,
      (570,760){down}..(660,100)..(810,0)..tension 1.5..
        (870,70)..{curl 0.3}(910,200),
      (540,760){down}..(670,100)..{right}(910,-40){curl 1}..
        (860,60)..(860,160)),
    (1.6,1.6)--(1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(0.9,0.9));
  set_boserif(0,0,10);
  push_stroke((680,720)..tension 1.2..(750,690)..(790,640),
    (1,1)..(1.5,1.5)--(1.7,1.7));
  set_bosize(0,90);
  push_stroke((820,410)..tension 1.2..(720,240)..(370,-60),
    (1.6,1.6)--(1.4,1.4)--(1.2,1.2));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ka/hoko "tasselled spear radical"
begintsuglyph("uni6208",8);
  kanji.radical.tasselled_spear;
  tsu_render;
endtsuglyph;

% bo/tsuchinoe "fifth class or calendar sign"
begintsuglyph("uni620A",10);
  kanji.grnine.fifth;
  tsu_render;
endtsuglyph;

% Chinese-only character, and they draw it with two crossbars, but
% it's always three when it occurs as part of a Japanese character
begintsuglyph("uni620B",11);
  kanji.radical.three_tasselled_spear;
  obstacktype[find_whatever(otstroke,-2)]:=otnull;
  tsu_render;
endtsuglyph;

% sei/na (as in "naru") "become"
begintsuglyph("uni6210",16);
  kanji.grfour.become;
  tsu_render;
endtsuglyph;

% kai/imashi "precept"
begintsuglyph("uni6212",18);
  kanji.greight.precept;
  tsu_render;
endtsuglyph;

% sen/ikusa "battle"
begintsuglyph("uni6226",38);
  kanji.grfour.battle;
  tsu_render;
endtsuglyph;

% ko/to "door"
begintsuglyph("uni6238",56);
  kanji.grtwo.door;
  tsu_render;
endtsuglyph;

% sho/tokoro "place"
begintsuglyph("uni6240",64);
  kanji.grthree.place;
  tsu_render;
endtsuglyph;

% te "hand"
begintsuglyph("uni624B",75);
  kanji.grone.hand;
  tsu_render;
endtsuglyph;

% hand radical
begintsuglyph("uni624C",76);
  build_kanji.sscale(xscaled 0.7)(kanji.leftrad.hand);
  tsu_render;
endtsuglyph;

% sai "genius" or "years of age"
begintsuglyph("uni624D",77);
  kanji.grtwo.genius;
  tsu_render;
endtsuglyph;

% da/u "hit"
begintsuglyph("uni6253",83);
  kanji.grthree.hit;
  tsu_render;
endtsuglyph;

% hi "criticize"
begintsuglyph("uni6279",121);
  kanji.grsix.criticize;
  tsu_render;
endtsuglyph;

% gi/waza "technique"
begintsuglyph("uni6280",128);
  kanji.grfive.technique;
  tsu_render;
endtsuglyph;

% tou/na "throw"
begintsuglyph("uni6295",149);
  kanji.grthree.throw;
  tsu_render;
endtsuglyph;

% extra: hou/nado "etcetera"
begintsuglyph("uni6294",148);
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.leftrad.hand)
    (kanji.grfour.non));
  tsu_render;
endtsuglyph;

% satsu/o "fold" (o as in origami)
begintsuglyph("uni6298",152);
  kanji.grfour.fold;
  tsu_render;
endtsuglyph;

% tan/katsu "carry"
begintsuglyph("uni62C5",197);
  kanji.grsix.carry;
  tsu_render;
endtsuglyph;

% shou/mane "beckon" (as in manekineko)
begintsuglyph("uni62DB",219);
  kanji.grfive.beckon;
  tsu_render;
endtsuglyph;

% kaku/hiro "spread"
begintsuglyph("uni62E1",225);
  kanji.grsix.spread;
  tsu_render;
endtsuglyph;

% shuu/hiro "gather"
begintsuglyph("uni62FE",254);
  kanji.grthree.gather;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
