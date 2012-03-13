%
% Unicode page 5e (Kanji) for Tsukurimashou
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
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.year =
  push_pbox_toexpand("kanji.grone.year");
  push_stroke((220,790){curl 0.1}..(180,650)..(60,470),
    (1.7,1.7)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke(
    (((0,680)--(1000,680)) intersectionpoint get_strokep(0))--(850,680),
    (1.4,1.4)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((500,680)--(500,-20),(1.6,1.6)--(1.4,1.4));
  push_stroke((270,220)--(270,460)--(800,460),
    (1.5,1.5)--(1.5,1.5)--(1.5,1.5));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  set_boserif(0,2,9);
  push_stroke((100,220)--(900,220),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.return =
  push_pbox_toexpand("kanji.grtwo.return");
  % can't just invoke "broom" because of Japanese style difference
  % between "pig's snout" and "pig's head" radicals
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.sword)
    (build_kanji.sscale(yscaled 0.95 shifted (0,-10))
       (build_kanji.tb(550,50)
          (kanji.radical.pigs_head)
          (build_kanji.tb(450,200)
             (kanji.radical.conservative_hat)
             (kanji.greight.towel)))));
  expand_pbox;
enddef;

vardef kanji.grtwo.shop =
  push_pbox_toexpand("kanji.grtwo.shop");
  build_kanji.dotcliff_enclose(kanji.greight.divination);
  expand_pbox;
enddef;

vardef kanji.grtwo.wide =
  push_pbox_toexpand("kanji.grtwo.wide");
  build_kanji.dotcliff_enclose(kanji.radical.mu);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.degree =
  push_pbox_toexpand("kanji.grthree.degree");
  build_kanji.dotcliff_enclose(build_kanji.level(
    build_kanji.sscale(xscaled 1.12 shifted (-35,0))(build_kanji.tb(480,-80)
      (kanji.grnine.twenty)
      (kanji.greight.otoh))));
  expand_pbox;
enddef;

vardef kanji.grthree.register =
  push_pbox_toexpand("kanji.grthree.register");
  build_kanji.level(build_kanji.lr(420,50)
    (kanji.greight.towel)
    (kanji.grtwo.long));
  expand_pbox;
enddef;

vardef kanji.grthree.warehouse =
  push_pbox_toexpand("kanji.grthree.warehouse");
  build_kanji.dotcliff_enclose(kanji.grone.wheel);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.normal =
  push_pbox_toexpand("kanji.grfive.normal");
  build_kanji.level(build_kanji.tb(340,90)
    (kanji.toprad.ridiculous_hat)
    (kanji.greight.towel));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.government_office =
  push_pbox_toexpand("kanji.grsix.government_office");
  build_kanji.dotcliff_enclose(tsu_xform(identity yscaled 0.85)
                               (kanji.grthree.thumbtack));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.urban_prefecture =
  push_pbox_toexpand("kanji.grfour.urban_prefecture");
  build_kanji.dotcliff_enclose(kanji.grfour.attach);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.bed =
  push_pbox_toexpand("kanji.greight.bed");
  build_kanji.dotcliff_enclose(kanji.grone.wood);
  expand_pbox;
enddef;

vardef kanji.greight.seclude =
  push_pbox_toexpand("kanji.greight.seclude");
  build_kanji.sscale(xyscaled (1.18,1.07) shifted (0,20))
    (kanji.grone.mountain);
  build_kanji.sscale(xyscaled (0.38,0.83) shifted (-193,15))
    (kanji.radical.short_thread);
  build_kanji.sscale(xyscaled (0.38,0.83) shifted (192,15))
    (kanji.radical.short_thread);
  for i=-14 upto 0: set_bosize(i,80); endfor;
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.hermitage =
  push_pbox_toexpand("kanji.grnine.hermitage");
  build_kanji.dotcliff_enclose(kanji.grnine.suffocate);
  expand_pbox;
enddef;

vardef kanji.grnine.manor =
  push_pbox_toexpand("kanji.grnine.manor");
  build_kanji.dotcliff_enclose(kanji.grone.earth);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.rare.broom =
  push_pbox_toexpand("kanji.rare.broom");
  build_kanji.level(build_kanji.sscale(yscaled 0.95 shifted (0,-10))
    (build_kanji.tb(550,50)
      (kanji.radical.pigs_snout)
      (build_kanji.tb(450,200)
         (kanji.radical.conservative_hat)
         (kanji.greight.towel))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.sword =
  push_pbox_toexpand("kanji.leftrad.sword");
  push_stroke((260,720)--(260,300),(1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((740,760)--(740,400){down}..(550,130)..(200,-40),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3)--(1,1));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.toprad.ridiculous_hat =
  push_pbox_toexpand("kanji.toprad.ridiculous_hat");
  build_kanji.level(build_kanji.tb(620,156)
    (kanji.toprad.sparkle_three)
    (build_kanji.tb(600,410)
       (kanji.radical.conservative_hat)
       (build_kanji.sscale(xyscaled (0.8,0.64) shifted (0,-120))
         (kanji.grone.mouth))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% shi/ichi "market"
begintsuglyph("uni5E02",2);
  kanji.grtwo.market;
  tsu_render;
endtsuglyph;

% sou/houki "broom" as in houkiboshi "comet"
begintsuglyph("uni5E1A",26);
  kanji.rare.broom;
  tsu_render;
endtsuglyph;

% ki/kae "return"
begintsuglyph("uni5E30",48);
  kanji.grtwo.return;
  tsu_render;
endtsuglyph;

% chou/tobari "register"
begintsuglyph("uni5E33",51);
  kanji.grthree.register;
  tsu_render;
endtsuglyph;

% jou/tsune "normal"
begintsuglyph("uni5E38",56);
  kanji.grfive.normal;
  tsu_render;
endtsuglyph;

% kan/ho "dry"
begintsuglyph("uni5E72",114);
  kanji.grsix.dry;
  tsu_render;
endtsuglyph;

% nen/toshi "year"
begintsuglyph("uni5E74",116);
  kanji.grone.year;
  tsu_render;
endtsuglyph;

% hei/awa "merger"
begintsuglyph("uni5E76",118);
  kanji.rare.merger;
  tsu_render;
endtsuglyph;

% you/chiisai "short thread radical"
begintsuglyph("uni5E7A",122);
  kanji.radical.short_thread;
  tsu_render;
endtsuglyph;

% yuu as in yuurei "seclude"
begintsuglyph("uni5E7D",125);
  kanji.greight.seclude;
  tsu_render;
endtsuglyph;

% madare "dotted cliff radical"
begintsuglyph("uni5E7F",127);
  build_kanji.dotcliff_enclose();
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5E80",128);
  build_kanji.dotcliff_enclose(
    build_kanji.sscale(xscaled 0.9 shifted (80,0))
      (kanji.radical.spoon));
  tsu_render;
endtsuglyph;

% chou/yakushou "government office"
begintsuglyph("uni5E81",129);
  kanji.grsix.government_office;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5E82",130);
  build_kanji.dotcliff_enclose(kanji.grone.person);
  tsu_render;
endtsuglyph;

% kou/hiro "wide"
begintsuglyph("uni5E83",131);
  kanji.grtwo.wide;
  tsu_render;
endtsuglyph;

% kou/hiro "wide"
begintsuglyph("uni5E84",132);
  kanji.grnine.manor;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5E86",134);
  build_kanji.dotcliff_enclose(kanji.grone.big);
  tsu_render;
endtsuglyph;

% toko/yuka "bed"
begintsuglyph("uni5E8A",138);
  kanji.greight.bed;
  tsu_render;
endtsuglyph;

% ten/mise "shop"
begintsuglyph("uni5E97",151);
  kanji.grtwo.shop;
  tsu_render;
endtsuglyph;

% fu "urban prefecture"
begintsuglyph("uni5E9C",156);
  kanji.grfour.urban_prefecture;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5EA4",164);
  build_kanji.dotcliff_enclose(kanji.grtwo.temple);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5EA5",165);
  build_kanji.dotcliff_enclose(kanji.grone.vacation);
  tsu_render;
endtsuglyph;

% do/tabi "degree"
begintsuglyph("uni5EA6",166);
  kanji.grthree.degree;
  tsu_render;
endtsuglyph;

% ko/kura "warehouse"
begintsuglyph("uni5EAB",171);
  kanji.grthree.warehouse;
  tsu_render;
endtsuglyph;

% an/iori "hermitage"
begintsuglyph("uni5EB5",181);
  kanji.grnine.hermitage;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5EBF",191);
  build_kanji.dotcliff_enclose(
    tsu_xform(identity yscaled 0.94)(kanji.greight.seedling));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5EFE",254);
  kanji.radical.aitch;
  tsu_render;
endtsuglyph;

% juu/nijuu "twenty"
begintsuglyph("uni5EFF",255);
  kanji.grnine.twenty;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
