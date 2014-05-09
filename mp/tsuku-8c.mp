%
% Unicode page 8C (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2014  Matthew Skala
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
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradeten.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.buy =
  push_pbox_toexpand("kanji.grtwo.buy");
  build_kanji.level(build_kanji.tb(610,0)
    (kanji.toprad.eye)
    (kanji.grone.shell));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.undertake =
  push_pbox_toexpand("kanji.grthree.undertake");
  build_kanji.attach_fishhook(0.77)(kanji.grone.shell);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.expense =
  push_pbox_toexpand("kanji.grfour.freight");
  build_kanji.thickness(0.92)(build_kanji.level(build_kanji.tb(410,-20)
    (kanji.rare.dollar)
    (kanji.grone.shell)));
  expand_pbox;
enddef;

vardef kanji.grfour.freight =
  push_pbox_toexpand("kanji.grfour.freight");
  build_kanji.level(build_kanji.tb(560,-50)
    (kanji.grthree.change)
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfour.prize =
  push_pbox_toexpand("kanji.grfour.prize");
  build_kanji.level(build_kanji.tb(460,-10)
    (build_kanji.sscale(xscaled 0.87)(kanji.toprad.ridiculous_hat))
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfour.wear_moustache =
  push_pbox_toexpand("kanji.grfour.wear_moustache");
  build_kanji.level(build_kanji.lr(480,0)
    (kanji.grone.shell)
    (kanji.rare.bobbin));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.congratulations =
  push_pbox_toexpand("kanji.grfive.congratulations");
  build_kanji.level(build_kanji.tb(560,-10)
    (kanji.grfour.addition)
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfive.fortune =
  push_pbox_toexpand("kanji.grfive.fortune");
  build_kanji.level(build_kanji.lr(480,0)
    (kanji.grone.shell)
    (kanji.rightrad.genius));
  expand_pbox;
enddef;

vardef kanji.grfive.fund =
  push_pbox_toexpand("kanji.grfive.fund");
  build_kanji.level(build_kanji.tb(560,-10)
    (build_kanji.sscale(shifted (-70,0))(kanji.grthree.next))
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfive.lend =
  push_pbox_toexpand("kanji.grfive.lend");
  build_kanji.level(build_kanji.tb(580,0)
    (kanji.grthree.generation;
     replace_strokep(-2)(oldp shifted (0,-80)))
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfive.poor =
  push_pbox_toexpand("kanji.grfive.poor");
  build_kanji.level(build_kanji.tb(530,-20)
    (kanji.grtwo.minute)
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfive.quality =
  push_pbox_toexpand("kanji.grfive.quality");
  build_kanji.level(build_kanji.tb(540,0)
    (build_kanji.lr(480,70)
       (kanji.greight.axe)
       (kanji.greight.axe))
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfive.trade =
  push_pbox_toexpand("kanji.grfive.trade");
  build_kanji.level(build_kanji.tb(540,0)
    (build_kanji.lr(480,40)
     (kanji.toprad.detain)
     (kanji.grtwo.sword))
    (kanji.grone.shell));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.wage =
  push_pbox_toexpand("kanji.grsix.wage");
  build_kanji.level(build_kanji.tb(560,-50)
    (kanji.grfive.responsibility)
    (kanji.grone.shell));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.chastity =
  push_pbox_toexpand("kanji.greight.chastity");
  build_kanji.level(build_kanji.tb(580,50)
    (kanji.grone.ten;
     replace_strokep(0)(subpath (0.5,0.8) of oldp shifted (5,40)))
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.greight.covet =
  push_pbox_toexpand("kanji.greight.covet");
  build_kanji.tb(470,50)
    (kanji.grtwo.now)
    (kanji.grone.shell);
  expand_pbox;
enddef;

vardef kanji.greight.subscribe =
  push_pbox_toexpand("kanji.greight.subscribe");
  build_kanji.level(build_kanji.lr(410,20)
    (build_kanji.lift_skirt(220,60)(kanji.grone.shell))
    (kanji.rare.inner_palace));
  expand_pbox;
enddef;

vardef kanji.greight.tribute =
  push_pbox_toexpand("kanji.greight.tribute");
  build_kanji.level(build_kanji.tb(540,-20)
    (kanji.grtwo.craft)
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.greight.wisdom =
  push_pbox_toexpand("kanji.greight.wisdom");
  build_kanji.level(build_kanji.tb(530,-50)
    (kanji.rare.wisdom)
    (kanji.grone.shell));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.obtain =
  push_pbox_toexpand("kanji.grnine.obtain");
  build_kanji.level(build_kanji.tb(520,-50)
    (kanji.grthree.world)
    (kanji.grone.shell));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% koku/tani "valley"
begintsuglyph("uni8C37",55);
  kanji.grtwo.valley;
  tsu_render;
endtsuglyph;

% tou/mame "bean"
begintsuglyph("uni8C46",70);
  kanji.grthree.bean;
  tsu_render;
endtsuglyph;

% inoko "pig" radical
begintsuglyph("uni8C55",85);
  kanji.radical.pig;
  tsu_render;
endtsuglyph;

% shou/katado "elephant" or "to imitate"
begintsuglyph("uni8C61",97);
  kanji.grfour.elephant;
  tsu_render;
endtsuglyph;

% bai/kai "shellfish"
begintsuglyph("uni8C9D",157);
  kanji.grone.shell;
  tsu_render;
endtsuglyph;

% tei/sada "chastity"
begintsuglyph("uni8C9E",158);
  kanji.greight.chastity;
  tsu_render;
endtsuglyph;

% fu/ma "undertake"
begintsuglyph("uni8CA0",160);
  kanji.grthree.undertake;
  tsu_render;
endtsuglyph;

% zai/takara "fortune"
begintsuglyph("uni8CA1",161);
  kanji.grfive.fortune;
  tsu_render;
endtsuglyph;

% kou/mitsu "tribute"
begintsuglyph("uni8CA2",162);
  kanji.greight.tribute;
  tsu_render;
endtsuglyph;

% hin/mazu "poor"
begintsuglyph("uni8CA7",167);
  kanji.grfive.poor;
  tsu_render;
endtsuglyph;

% ka/takara "freight"
begintsuglyph("uni8CA8",168);
  kanji.grfour.freight;
  tsu_render;
endtsuglyph;

% tan/musabo "covet"
begintsuglyph("uni8CAA",170);
  kanji.greight.covet;
  tsu_render;
endtsuglyph;

% seki/se "blame"
begintsuglyph("uni8CAC",172);
  kanji.grfive.blame;
  tsu_render;
endtsuglyph;

% cho/ta "wear moustache"
% That is what KANJIDIC2 says, and "save" is a reserved word.
begintsuglyph("uni8CAF",175);
  kanji.grfour.wear_moustache;
  tsu_render;
endtsuglyph;

% sei/mora "obtain"
begintsuglyph("uni8CB0",176);
  kanji.grnine.obtain;
  tsu_render;
endtsuglyph;

% gai/ka "buy"
begintsuglyph("uni8CB7",183);
  kanji.grtwo.buy;
  tsu_render;
endtsuglyph;

% tai/ka "lend"
begintsuglyph("uni8CB8",184);
  kanji.grfive.lend;
  tsu_render;
endtsuglyph;

% hi/tsui "expense"
begintsuglyph("uni8CBB",187);
  kanji.grfour.expense;
  tsu_render;
endtsuglyph;

% bou "trade"
begintsuglyph("uni8CBF",191);
  kanji.grfive.trade;
  tsu_render;
endtsuglyph;

% ga/ka "congratulations"
begintsuglyph("uni8CC0",192);
  kanji.grfive.congratulations;
  tsu_render;
endtsuglyph;

% fun "decorate" (needed for greight.indignation)
begintsuglyph("uni8CC1",193);
  kanji.rare.decorate;
  tsu_render;
endtsuglyph;

% chin "wage"
begintsuglyph("uni8CC3",195);
  kanji.grsix.wage;
  tsu_render;
endtsuglyph;

% shi "fund"
begintsuglyph("uni8CC7",199);
  kanji.grfive.fund;
  tsu_render;
endtsuglyph;

% extra ko/akina "tradesman"
begintsuglyph("uni8CC8",200);
  build_kanji.level(build_kanji.tb(560,-30)
    (kanji.toprad.ticket)
    (kanji.grone.shell));
  tsu_render;
endtsuglyph;

% san/tasu "approve"
begintsuglyph("uni8CDB",219);
  kanji.grfive.approve;
  tsu_render;
endtsuglyph;

% shuu/ho "prize"
begintsuglyph("uni8CDE",222);
  kanji.grfour.prize;
  tsu_render;
endtsuglyph;

% ken/kashiko "wisdom"
begintsuglyph("uni8CE2",226);
  kanji.greight.wisdom;
  tsu_render;
endtsuglyph;

% bai/uru "sell out"
begintsuglyph("uni8CE3",227);
  kanji.grten.sell_out;
  tsu_render;
endtsuglyph;

% shitsu/tachi "quality"
begintsuglyph("uni8CEA",234);
  kanji.grfive.quality;
  tsu_render;
endtsuglyph;

% kou "subscribe"
begintsuglyph("uni8CFC",252);
  kanji.greight.subscribe;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
