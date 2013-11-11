%
% Unicode page 51 (Kanji) for Tsukurimashou
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
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
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

vardef kanji.grthree.copy =
  push_pbox_toexpand("kanji.grthree.copy");
  build_kanji.level(build_kanji.tb(600,160)
   (kanji.radical.conservative_hat)
   (kanji.greight.give));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.child =
  push_pbox_toexpand("kanji.grfour.child");
  build_kanji.tb(360,0)
    (kanji.grfive.old_times)
    (kanji.radical.legs);
  expand_pbox;
enddef;

vardef kanji.grfour.chill =
  push_pbox_toexpand("kanji.grfour.chill");
  build_kanji.lr(360,20)
    (kanji.leftrad.ice)
    (build_kanji.sscale(shifted (0,20))(kanji.grfour.orders));
  expand_pbox;
enddef;

vardef kanji.grfour.hundred_million =
  push_pbox_toexpand("kanji.grfour.healthy");
  build_kanji.lr(300,0)
    (kanji.leftrad.person)
    (kanji.grthree.intention);
  expand_pbox;
enddef;

vardef kanji.grfour.rule =
  push_pbox_toexpand("kanji.grfour.rule");
  build_kanji.level(build_kanji.tb(180,0)
   (build_kanji.sscale(xscaled 0.84)
      (kanji.grthree.melody;
       replace_strokep(-4)((140,30)--(140,600)--(860,600)--(860,30)));
    pop_hook;
    replace_strokep(-3)((80,30)--(920,30));
    set_boserif(-3,1,9))
   (kanji.radical.eight));
  expand_pbox;
enddef;

vardef kanji.grfour.soldier =
  push_pbox_toexpand("kanji.grfour.soldier");
  build_kanji.level(build_kanji.tb(200,0)
    (kanji.greight.knoll)
    (kanji.radical.eight));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.gentle =
  push_pbox_toexpand("kanji.grsix.gentle");
  build_kanji.lr(270,0)
    (kanji.leftrad.person)
    (build_kanji.sscale(yscaled 0.96 shifted (0,-30))
       (kanji.greight.melancholy));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% oku "one hundred million"
begintsuglyph("uni5104",4);
  kanji.grfour.hundred_million;
  tsu_render;
endtsuglyph;

% yuu/yasa "gentle"
begintsuglyph("uni512A",42);
  kanji.grsix.gentle;
  tsu_render;
endtsuglyph;

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

% chou/kiza "portent" or "trillion"
begintsuglyph("uni5146",70);
  kanji.grfour.portent;
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

% ko/ji "child"
begintsuglyph("uni5150",80);
  kanji.grfour.child;
  tsu_render;
endtsuglyph;

% rare needed for 8AAC
begintsuglyph("uni5151",81);
  kanji.rare.cash;
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

% kyou/tomo "together"
begintsuglyph("uni5171",113);
  kanji.grfour.together;
  tsu_render;
endtsuglyph;

% hei/tsuwamono "soldier"
begintsuglyph("uni5175",117);
  kanji.grfour.soldier;
  tsu_render;
endtsuglyph;

% ki/so "that" (as in sore and sono)
begintsuglyph("uni5176",118);
  kanji.grnine.that;
  tsu_render;
endtsuglyph;

% gu/sona "ingredient"
begintsuglyph("uni5177",119);
  kanji.grthree.ingredient;
  tsu_render;
endtsuglyph;

% ten/suke "rule"
begintsuglyph("uni5178",120);
  kanji.grfour.rule;
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

% rei/tsume "chill"
begintsuglyph("uni51B7",183);
  kanji.grfour.chill;
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
