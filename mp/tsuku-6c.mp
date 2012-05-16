%
% Unicode page 6C (Kanji) for Tsukurimashou
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
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.spirit =
  push_pbox_toexpand("kanji.grone.spirit");
  build_kanji.steam_enclose((700,400))
    (kanji.radical.cut_the_grass);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.pond =
  push_pbox_toexpand("kanji.grtwo.pond");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grnine.to_be);
  expand_pbox;
enddef;

vardef kanji.grtwo.steam =
  push_pbox_toexpand("kanji.grtwo.steam");
  build_kanji.lr(360,20-50*mincho)
    (kanji.leftrad.water)
    (build_kanji.steam_enclose((700,400))());
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.decide =
  push_pbox_toexpand("kanji.grthree.decide");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.rare.decide);
  expand_pbox;
enddef;

vardef kanji.grthree.ice =
  push_pbox_toexpand("kanji.grthree.ice");
  kanji.grone.water;
  replace_strokep(-3)(oldp yscaled 0.9);
  push_stroke((190,700)..tension 1.2..(280,650)..(360,580),
    (1,1)--(1.4,1.4)--(1.6,1.6));
  expand_pbox;
enddef;

vardef kanji.grthree.oil =
  push_pbox_toexpand("kanji.grthree.oil");
  build_kanji.lr(360,30)
    (kanji.leftrad.water)
    (kanji.grthree.reason);
  expand_pbox;
enddef;

vardef kanji.grthree.pour =
  push_pbox_toexpand("kanji.grthree.pour");
  build_kanji.lr(360,30)
    (kanji.leftrad.water)
    (kanji.grthree.master);
  expand_pbox;
enddef;

vardef kanji.grthree.swim =
  push_pbox_toexpand("kanji.grthree.swim");
  build_kanji.lr(360,30)
    (kanji.leftrad.water)
    (kanji.grfive.long);
  expand_pbox;
enddef;

vardef kanji.grthree.wave =
  push_pbox_toexpand("kanji.grthree.wave");
  build_kanji.lr(360,-20)
    (kanji.leftrad.water)
    (tsu_xform(identity shifted (0,20))(kanji.grthree.pelt));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.long =
  push_pbox_toexpand("kanji.grfive.long");
  push_stroke((360,790)..tension 1.2..(480,740)..(560,680),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  tsu_xform(identity yscaled 0.87)(kanji.grone.water);
  replace_strokep(-3)(oldp shifted (0,-40));
  replace_strokep(-1)((280,580)--(510,580)--(subpath (1,infinity) of oldp));
  replace_strokeq(-1)((1.6,1.6)--oldq);
  set_boserif(-1,0,whatever);
  set_botip(-1,1,1);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.bay =
  push_pbox_toexpand("kanji.greight.bay");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.craft);
  expand_pbox;
enddef;

vardef kanji.greight.fertility =
  push_pbox_toexpand("kanji.greight.fertility");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.rare.early_death);
  expand_pbox;
enddef;

vardef kanji.greight.juice =
  push_pbox_toexpand("kanji.greight.juice");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.ten);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.luxury =
  push_pbox_toexpand("kanji.grnine.luxury");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.thick);
  expand_pbox;
enddef;

vardef kanji.grnine.shore =
  push_pbox_toexpand("kanji.grnine.shore");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grthree.thumbtack);
  expand_pbox;
enddef;

vardef kanji.grnine.thou =
  push_pbox_toexpand("kanji.grnine.thou");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.woman);
  expand_pbox;
enddef;

vardef kanji.grnine.tide =
  push_pbox_toexpand("kanji.grnine.tide");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (tsu_xform(identity xyscaled (1.07,0.93) slanted 0.17 shifted (-60,80))
      (kanji.grone.evening));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% shi/uji "clan"
begintsuglyph("uni6C0F",15);
  kanji.grfour.clan;
  tsu_render;
endtsuglyph;

% sei/tada/machi "correct"
begintsuglyph("uni6C14",20);
  build_kanji.steam_enclose((700,400))();
  tsu_render;
endtsuglyph;

% ki/iki "spirit"
begintsuglyph("uni6C17",23);
  kanji.grone.spirit;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C19",25);
  build_kanji.steam_enclose((700,400))(kanji.grone.mountain);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C1A",26);
  build_kanji.steam_enclose((700,400))(kanji.grone.river);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C1C",28);
  build_kanji.steam_enclose((700,400))(kanji.grone.day);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C28",40);
  build_kanji.steam_enclose((700,500))(kanji.grthree.easy);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C30",48);
  build_kanji.steam_enclose((700,500))
    (build_kanji.sscale(yscaled 1.13)(kanji.grone.blue));
  tsu_render;
endtsuglyph;

% sui/mizu "water"
begintsuglyph("uni6C34",52);
  kanji.grone.water;
  tsu_render;
endtsuglyph;

% extra "water side radical"
begintsuglyph("uni6C35",53);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    ();
  tsu_render;
endtsuglyph;

% hyou/koori "ice"
begintsuglyph("uni6C37",55);
  kanji.grthree.ice;
  tsu_render;
endtsuglyph;

% ei/naga "long"
begintsuglyph("uni6C38",56);
  kanji.grfive.long;
  tsu_render;
endtsuglyph;

% water radical variant
begintsuglyph("uni6C3A",58);
  kanji.radical.alt_water;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C3B",59);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.power);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C3F",63);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.nine);
  tsu_render;
endtsuglyph;

% tei/migiwa "shore"
begintsuglyph("uni6C40",64);
  kanji.grnine.shore;
  tsu_render;
endtsuglyph;

% juu/shiru "juice" or "soup"
begintsuglyph("uni6C41",65);
  kanji.greight.juice;
  tsu_render;
endtsuglyph;

% gyuu/moto "request"
begintsuglyph("uni6C42",66);
  kanji.grfour.request;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C43",67);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.eight);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C44",68);
  build_kanji.lr(360,40)
    (kanji.leftrad.water)
    (kanji.grone.person);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C4C",76);
  build_kanji.lr(360,-20)
    (kanji.leftrad.water)
    (kanji.grone.river);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C4D",77);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.circle);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C4F",79);
  build_kanji.lr(360,20)
    (kanji.leftrad.water)
    (kanji.grone.big);
  tsu_render;
endtsuglyph;

% seki/shio "tide"
begintsuglyph("uni6C50",80);
  kanji.grnine.tide;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C53",83);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.child);
  tsu_render;
endtsuglyph;

% extra "fish swimming"
begintsuglyph("uni6C55",85);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.mountain);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C58",88);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.one_thousand);
  tsu_render;
endtsuglyph;

% jo/nanji "thou"
begintsuglyph("uni6C5D",93);
  kanji.grnine.thou;
  tsu_render;
endtsuglyph;

% kou/e "bay" ("e" in "Edo")
begintsuglyph("uni6C5F",95);
  kanji.greight.bay;
  tsu_render;
endtsuglyph;

% chi/ike "pond"
begintsuglyph("uni6C60",96);
  kanji.grtwo.pond;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C62",98);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.earth);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C68",104);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.day);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C6A",106);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grone.king);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C6D",109);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.home);
  tsu_render;
endtsuglyph;

% ta/ogo "luxury"
begintsuglyph("uni6C70",112);
  kanji.grnine.luxury;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C75",117);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.now);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C78",120);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.direction);
  tsu_render;
endtsuglyph;

% ketsu/ki "decide"
begintsuglyph("uni6C7A",122);
  kanji.grthree.decide;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6C7B",123);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.noon);
  tsu_render;
endtsuglyph;

% ki "steam"
begintsuglyph("uni6C7D",125);
  kanji.grtwo.steam;
  tsu_render;
endtsuglyph;

% extra "name of a Chinese river"
begintsuglyph("uni6C7E",126);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.minute);
  tsu_render;
endtsuglyph;

% you/soso "fertility"
begintsuglyph("uni6C83",131);
  kanji.greight.fertility;
  tsu_render;
endtsuglyph;

% yu/abura "oil"
begintsuglyph("uni6CB9",185);
  kanji.grthree.oil;
  tsu_render;
endtsuglyph;

% sen/izumi "spring" or "fountain" (not the season)
begintsuglyph("uni6CC9",201);
  kanji.grsix.fountain;
  tsu_render;
endtsuglyph;

% ha/nami "wave" (or Poland)
begintsuglyph("uni6CE2",226);
  kanji.grthree.wave;
  tsu_render;
endtsuglyph;

% chuu/soso "pour"
begintsuglyph("uni6CE8",232);
  kanji.grthree.pour;
  tsu_render;
endtsuglyph;

% ei/oyo "swim"
begintsuglyph("uni6CF3",243);
  kanji.grthree.swim;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
