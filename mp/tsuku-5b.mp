%
% Unicode page 5b (Kanji) for Tsukurimashou
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
input gradefour.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.study =
  push_pbox_toexpand("kanji.grone.study");
  begingroup
    save saved_path;
    path saved_path;
    build_kanji.tb(740,100)
      (kanji.toprad.alt_sparkle_three)
      (build_kanji.tb(580,150)
         (kanji.radical.conservative_hat)
         (build_kanji.sscale(xscaled 0.75)
            (kanji.grone.child;saved_path:=get_strokep(0));
             replace_strokep(0)(saved_path)));
  endgroup;
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.chamber =
  push_pbox_toexpand("kanji.grtwo.chamber");
  build_kanji.tb(600,150)
    (kanji.radical.silly_hat)
    (build_kanji.level(build_kanji.tb(420,100)
       (build_kanji.sscale(scaled 0.7)(kanji.radical.mu_bar))
       (kanji.grone.earth)));
  expand_pbox;
enddef;

vardef kanji.grtwo.house =
  push_pbox_toexpand("kanji.grtwo.house");
  build_kanji.level(build_kanji.tb(600,150)
    (kanji.radical.silly_hat)
    (kanji.radical.pig));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.counterpart =
  push_pbox_toexpand("kanji.grthree.counterpart");
  build_kanji.lr(420,0)
    (kanji.leftrad.sentence)
    (kanji.grsix.inch);
  expand_pbox;
enddef;

vardef kanji.grthree.inn =
  push_pbox_toexpand("kanji.grthree.protect");
  build_kanji.tb(600,110)
    (kanji.radical.silly_hat)
    (kanji.rare.centurion);
  expand_pbox;
enddef;

vardef kanji.grthree.guest =
  push_pbox_toexpand("kanji.grthree.guest");
  build_kanji.tb(600,110)
    (kanji.radical.silly_hat)
    (kanji.grfour.every);
  expand_pbox;
enddef;

vardef kanji.grthree.palace =
  push_pbox_toexpand("kanji.grthree.palace");
  build_kanji.tb(600,90)
    (kanji.radical.silly_hat)
    (kanji.greight.spine);
  expand_pbox;
enddef;

vardef kanji.grthree.protect =
  push_pbox_toexpand("kanji.grthree.protect");
  build_kanji.tb(600,210)
    (kanji.radical.silly_hat)
    (kanji.grsix.inch);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.filial_piety =
  push_pbox_toexpand("kanji.grsix.filial_piety");
  kanji.radical.old_man(kanji.grone.child);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.cave =
  push_pbox_toexpand("kanji.grnine.cave");
  build_kanji.tb(620,150)
    (kanji.radical.silly_hat)
    (kanji.grone.right);
  expand_pbox;
enddef;

vardef kanji.grnine.song_dynasty =
  push_pbox_toexpand("kanji.grnine.song_dynasty");
  build_kanji.tb(600,180)
    (kanji.radical.silly_hat)
    (kanji.grone.wood);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ko "child"
begintsuglyph("uni5B50",80);
  kanji.grone.child;
  tsu_render;
endtsuglyph;

% ketsu/hitori "mosquito larva"
begintsuglyph("uni5B51",81);
  kanji.rare.mosquito_larva;
  tsu_render;
endtsuglyph;

% ji "character"
begintsuglyph("uni5B57",87);
  kanji.grone.character;
  tsu_render;
endtsuglyph;

% kou/taka "filial piety"
begintsuglyph("uni5B5D",93);
  kanji.grsix.filial_piety;
  tsu_render;
endtsuglyph;

% gaku "school"
begintsuglyph("uni5B66",102);
  kanji.grone.study;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5B71",113);
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.73,0.67) shifted (40,-150))
      (build_kanji.tricluster(0.7)
         (kanji.grone.child)
         (build_kanji.sscale(scaled 0.9)(kanji.grone.child))
         (build_kanji.sscale(scaled 0.9)(kanji.grone.child))));
  tsu_render;
endtsuglyph;

% silly hat radical
begintsuglyph("uni5B80",128);
  build_kanji.tb(500,-30)
    (kanji.radical.silly_hat)
    ();
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5B82",130);
  build_kanji.tb(550,180)
    (kanji.radical.silly_hat)
    (kanji.radical.legs);
  tsu_render;
endtsuglyph;

% ta/hebi "other"
begintsuglyph("uni5B83",131);
  kanji.rare.other;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5B84",132);
  build_kanji.tb(600,220)
    (kanji.radical.silly_hat)
    (build_kanji.sscale(xscaled 0.9 shifted (80-30*mincho,0))
       (kanji.grone.nine));
  tsu_render;
endtsuglyph;

% shu/mamo "protect"
begintsuglyph("uni5B88",136);
  kanji.grthree.protect;
  tsu_render;
endtsuglyph;

% an/yasu "easy/cheap"
begintsuglyph("uni5B89",137);
  kanji.grthree.easy;
  tsu_render;
endtsuglyph;

% "song dynasty"
begintsuglyph("uni5B8B",139);
  kanji.grnine.song_dynasty;
  tsu_render;
endtsuglyph;

% kan "perfect"
begintsuglyph("uni5B8C",140);
  kanji.grfour.perfect;
  tsu_render;
endtsuglyph;

% extra "meat"
begintsuglyph("uni5B8D",141);
  build_kanji.tb(550,100)
    (kanji.radical.silly_hat)
    (kanji.grone.six);
  tsu_render;
endtsuglyph;

% "cave"
begintsuglyph("uni5B95",149);
  kanji.grnine.cave;
  tsu_render;
endtsuglyph;

% kyaku "guest"
begintsuglyph("uni5BA2",162);
  kanji.grthree.guest;
  tsu_render;
endtsuglyph;

% shitsu/muro "chamber"
begintsuglyph("uni5BA4",164);
  kanji.grtwo.chamber;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5BAA",170);
  build_kanji.tb(600,160)
    (kanji.radical.silly_hat)
    (kanji.grone.ahead);
  tsu_render;
endtsuglyph;

% kyuu/miya "house"
begintsuglyph("uni5BAE",174);
  kanji.grthree.palace;
  tsu_render;
endtsuglyph;

% ka/ie "house"
begintsuglyph("uni5BB6",182);
  kanji.grtwo.house;
  tsu_render;
endtsuglyph;

% shuku/yado "inn"
begintsuglyph("uni5BBF",191);
  kanji.grthree.inn;
  tsu_render;
endtsuglyph;

% su/miki "inch", also often a radical
begintsuglyph("uni5BF8",248);
  kanji.grsix.inch;
  tsu_render;
endtsuglyph;

% tera/ji "temple"
begintsuglyph("uni5BFA",250);
  kanji.grtwo.temple;
  tsu_render;
endtsuglyph;

% tai/aite "counterpart"
begintsuglyph("uni5BFE",254);
  kanji.grthree.counterpart;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
