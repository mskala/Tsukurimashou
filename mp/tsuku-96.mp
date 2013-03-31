%
% Unicode page 96 (Kanji) for Tsukurimashou
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
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.cloud =
  push_pbox_toexpand("kanji.grtwo.cloud");
  build_kanji.tb(300,50)
    (kanji.toprad.rain)
    (kanji.grnine.declaim);
  expand_pbox;
enddef;

vardef kanji.grtwo.electricity =
  push_pbox_toexpand("kanji.grtwo.electricity");
  build_kanji.tb(370,30)
    (kanji.toprad.rain)
    (build_kanji.sscale(xyscaled (1.1,0.6) shifted (-20*mincho,150))
       (kanji.grone.day);
     push_stroke((point 1.5 of get_strokep(-2)),(1.6,1.6));
     build_kanji.add_ltail(0));
  expand_pbox;
enddef;

vardef kanji.grtwo.snow =
  push_pbox_toexpand("kanji.grtwo.snow");
  build_kanji.tb(280,0)
    (kanji.toprad.rain)
    (kanji.radical.pigs_head);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.collect =
  push_pbox_toexpand("kanji.grthree.collect");
  build_kanji.tb(340,60)
    (build_kanji.sscale(shifted (-10,0))(kanji.radical.old_bird))
    (build_kanji.sscale(shifted (20,0))(kanji.grone.wood));
  expand_pbox;
enddef;

vardef kanji.grthree.institution =
  push_pbox_toexpand("kanji.grthree.institution");
  build_kanji.lr(420,100)
    (kanji.radical.beta)
    (build_kanji.sscale(shifted (0,-20))(kanji.grfour.perfect));
  expand_pbox;
enddef;

vardef kanji.grthree.positive =
  push_pbox_toexpand("kanji.grthree.positive");
  build_kanji.lr(420,70)
    (kanji.radical.beta)
    (build_kanji.sscale(shifted (0,-50))(kanji.rare.sun));
  expand_pbox;
enddef;

vardef kanji.grthree.storey =
  push_pbox_toexpand("kanji.grthree.storey");
  build_kanji.lr(420,70)
    (kanji.radical.beta)
    (kanji.greight.everybody);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.land =
  push_pbox_toexpand("kanji.grfour.land");
  build_kanji.lr(420,70)
    (kanji.radical.beta)
    (kanji.rare.clod_of_earth);
  expand_pbox;
enddef;

vardef kanji.grfour.squad =
  push_pbox_toexpand("kanji.grfour.squad");
  build_kanji.lr(420,70)
    (kanji.radical.beta)
    (kanji.rare.obey);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.brink =
  push_pbox_toexpand("kanji.grfive.brink");
  build_kanji.lr(390,80)
    (kanji.radical.beta)
    (kanji.grthree.festival);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.hinder =
  push_pbox_toexpand("kanji.grsix.hinder");
  build_kanji.lr(420,100)
    (kanji.radical.beta)
    (kanji.grthree.chapter);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.heights =
  push_pbox_toexpand("kanji.greight.heights");
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.radical.beta)
    (kanji.grthree.anti));
  expand_pbox;
enddef;

vardef kanji.greight.yin =
  push_pbox_toexpand("kanji.greight.yin");
  build_kanji.level(build_kanji.lr(460,140)
    (kanji.radical.beta)
    (kanji.rare.yin));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kozato "left village" (beta-looking) radical
begintsuglyph("uni961D",29);
  kanji.radical.beta;
  tsu_render;
endtsuglyph;

% extra "vein"
begintsuglyph("uni961E",30);
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.radical.beta)
    (kanji.grone.power));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni961F",31);
  build_kanji.level(build_kanji.lr(420,180)
    (kanji.radical.beta)
    (kanji.grone.person));
  tsu_render;
endtsuglyph;

% extra "thousand"
begintsuglyph("uni9621",33);
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.radical.beta)
    (kanji.grone.one_thousand));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9622",34);
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.radical.beta)
    (kanji.rare.bald));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9624",36);
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.radical.beta)
    (kanji.grnine.to_be));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9625",37);
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.radical.beta)
    (kanji.grone.water));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9626",38);
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.radical.beta)
    (kanji.grone.fire));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9627",39);
  build_kanji.level(build_kanji.lr(420,60)
    (kanji.radical.beta)
    (kanji.greight.dipper));
  tsu_render;
endtsuglyph;

% han/saka "heights"
begintsuglyph("uni962A",42);
  kanji.greight.heights;
  tsu_render;
endtsuglyph;

% in "institution" (often "house")
begintsuglyph("uni9662",98);
  kanji.grthree.institution;
  tsu_render;
endtsuglyph;

% in/kage "yin"
begintsuglyph("uni9670",112);
  kanji.greight.yin;
  tsu_render;
endtsuglyph;

% riku/oka "land"
begintsuglyph("uni9678",120);
  kanji.grfour.land;
  tsu_render;
endtsuglyph;

% you/hi "positive"
begintsuglyph("uni967D",125);
  kanji.grthree.positive;
  tsu_render;
endtsuglyph;

% tai "squad"
begintsuglyph("uni968A",138);
  kanji.grfour.squad;
  tsu_render;
endtsuglyph;

% kai/kizahashi "storey"
begintsuglyph("uni968E",142);
  kanji.grthree.storey;
  tsu_render;
endtsuglyph;

% sai/kiwa "brink"
begintsuglyph("uni969B",155);
  kanji.grfive.brink;
  tsu_render;
endtsuglyph;

% shou/sawa "hinder"
begintsuglyph("uni969C",156);
  kanji.grsix.hinder;
  tsu_render;
endtsuglyph;

% sai/tori "old bird" radical
begintsuglyph("uni96B9",185);
  kanji.radical.old_bird;
  tsu_render;
endtsuglyph;

% shuu/atsu "collect"
begintsuglyph("uni96C6",198);
  kanji.grthree.collect;
  tsu_render;
endtsuglyph;

% u/ame "rain"
begintsuglyph("uni96E8",232);
  kanji.grone.rain;
  tsu_render;
endtsuglyph;

% satsu/yuki "snow"
begintsuglyph("uni96EA",234);
  kanji.grtwo.snow;
  tsu_render;
endtsuglyph;

% un/kumo "cloud"
begintsuglyph("uni96F2",242);
  kanji.grtwo.cloud;
  tsu_render;
endtsuglyph;

% den "electricity"
begintsuglyph("uni96FB",251);
  kanji.grtwo.electricity;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
