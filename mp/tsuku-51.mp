%
% Unicode page 51 (Kanji) for Tsukurimashou
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
input gradeeight.mp;
input gradenine.mp;
input gradeone.mp;
input gradetwo.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.yen =
  push_pbox_toexpand("kanji.grone.yen");
  kanji.radical.gmm;
  push_stroke((point 1.52 of get_strokep(0))--(point 3.48 of get_strokep(0)),
    (1.6,1.6)--(1.6,1.6));
  push_stroke((point 2.5 of get_strokep(-1))--(point 0.5 of get_strokep(0)),
    (1.6,1.6)--(1.6,1.6));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.shine =
  push_pbox_toexpand("kanji.grtwo.shine");
  build_kanji.level(build_kanji.tb(440,55)
    (kanji.toprad.sparkle_three;
     push_stroke((80,-20)--(920,-20),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9);
    )
    (kanji.radical.legs));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.complete =
  push_pbox_toexpand("kanji.grthree.complete");
  kanji.radical.tent;
  pop_stroke;
  tsu_xform(identity yscaled 0.56)(kanji.grone.king);
  replace_strokep(-3)((220,ypart point 0 of oldp)--
    (770,ypart point 1 of oldp));
  expand_pbox;
enddef;

vardef kanji.grthree.copy =
  push_pbox_toexpand("kanji.grthree.copy");
  build_kanji.level(build_kanji.tb(600,160)
   (kanji.radical.conservative_hat)
   (kanji.greight.give));
  expand_pbox;
enddef;

vardef kanji.grthree.ingredient =
  push_pbox_toexpand("kanji.grthree.ingredient");
  build_kanji.level(build_kanji.tb(260,-50)
    (kanji.grone.eye)
    (build_kanji.tb(600,0)
       (kanji.grone.one)
       (kanji.radical.eight)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% legs radical
begintsuglyph("uni513F",63);
  kanji.radical.legs;
  tsu_render;
endtsuglyph;

% kotsu "bald"
begintsuglyph("uni5140",64);
  kanji.rare.bald;
  tsu_render;
endtsuglyph;

% in/shou "permission"
begintsuglyph("uni5141",65);
  kanji.grnine.permission;
  tsu_render;
endtsuglyph;

% moto/gen "origin"
begintsuglyph("uni5143",67);
  kanji.grtwo.origin;
  tsu_render;
endtsuglyph;

% nii (as in oniisan) "big brother"
begintsuglyph("uni5144",68);
  kanji.grtwo.big_brother;
  tsu_render;
endtsuglyph;

% shuu/a "fulfill"
begintsuglyph("uni5145",69);
  kanji.greight.fulfill;
  tsu_render;
endtsuglyph;

% sen "ahead"
begintsuglyph("uni5148",72);
  kanji.grone.ahead;
  tsu_render;
endtsuglyph;

% kou/hikari "shine"
begintsuglyph("uni5149",73);
  kanji.grtwo.shine;
  tsu_render;
endtsuglyph;

% men/manu "dismiss"
begintsuglyph("uni514D",77);
  kanji.greight.dismiss;
  tsu_render;
endtsuglyph;

% hai/i "put it in"
begintsuglyph("uni5165",101);
  kanji.grone.put_it_in;
  tsu_render;
endtsuglyph;

% zen/matta "complete"
begintsuglyph("uni5168",104);
  kanji.grthree.complete;
  tsu_render;
endtsuglyph;

% hachi/ya "eight"
begintsuglyph("uni516B",107);
  kanji.grone.eight;
  tsu_render;
endtsuglyph;

% kou/kimi "public" but also the pronoun kimi
begintsuglyph("uni516C",108);
  kanji.grtwo.public;
  tsu_render;
endtsuglyph;

% roku/mui "six"
begintsuglyph("uni516D",109);
  kanji.grone.six;
  tsu_render;
endtsuglyph;

% gu/sona "ingredient"
begintsuglyph("uni5177",119);
  kanji.grthree.ingredient;
  tsu_render;
endtsuglyph;

% George Michael's Moustache
begintsuglyph("uni5182",130);
  kanji.radical.gmm;
  tsu_render;
endtsuglyph;

% nai/uchi "home, me"
begintsuglyph("uni5185",133);
  kanji.grtwo.home;
  tsu_render;
endtsuglyph;

% en "yen" (currency unit)
begintsuglyph("uni5186",134);
  kanji.grone.yen;
  tsu_render;
endtsuglyph;

% kei/akiraka "clear"
begintsuglyph("uni518F",143);
  kanji.rare.clear;
  tsu_render;
endtsuglyph;

% like silly-hat minus the upper bobble
begintsuglyph("uni5196",150);
  kanji.radical.conservative_hat;
  tsu_render;
endtsuglyph;

% sha/utsu "copy" (often photo)
begintsuglyph("uni5199",153);
  kanji.grthree.copy;
  tsu_render;
endtsuglyph;

% tou/fuyu "winter"
begintsuglyph("uni51AC",172);
  kanji.grtwo.winter;
  tsu_render;
endtsuglyph;

% ki/kinyou "windy radical"
begintsuglyph("uni51E0",224);
  kanji.radical.windy;
  tsu_render;
endtsuglyph;

% kan "open box radical"
begintsuglyph("uni51F5",245);
  kanji.radical.open_box;
  tsu_render;
endtsuglyph;

% de "go away"
begintsuglyph("uni51FA",250);
  kanji.grone.go_away;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
