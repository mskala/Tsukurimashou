%
% Unicode page 5F (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2014, 2016, 2017  Matthew Skala
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
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.behind =
  push_pbox_toexpand("kanji.grtwo.behind");
  build_kanji.level(build_kanji.lr(310,0)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (build_kanji.tb(400,50)
       (kanji.radical.short_thread)
       (kanji.radical.winter)));
  expand_pbox;
enddef;

vardef kanji.grtwo.form =
  push_pbox_toexpand("kanji.grtwo.form");
  build_kanji.level(build_kanji.lr(580,60)
    (kanji.radical.topped_aitch)
    (tsu_xform(identity yscaled 1.04)(kanji.rightrad.short_hair)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.duty =
  push_pbox_toexpand("kanji.grthree.duty");
  build_kanji.level(build_kanji.lr(310,-20)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.radical.windy_again));
  expand_pbox;
enddef;

vardef kanji.grthree.wait =
  push_pbox_toexpand("kanji.grthree.wait");
  build_kanji.level(build_kanji.lr(310,0)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grtwo.temple));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.diameter =
  push_pbox_toexpand("kanji.grfour.diameter");
  build_kanji.level(build_kanji.lr(310,10)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.rare.sacred));
  expand_pbox;
enddef;

vardef kanji.grfour.pedestrian =
  push_pbox_toexpand("kanji.grfour.pedestrian");
  build_kanji.level(build_kanji.lr(310,10)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grtwo.run));
  expand_pbox;
enddef;

vardef kanji.grfour.profit =
  push_pbox_toexpand("kanji.grfour.profit");
  build_kanji.level(build_kanji.lr(310,10)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (build_kanji.tb(360,-20)
       (kanji.greight.daybreak;
        replace_strokep(0)(oldp shifted (0,-80)))
       (kanji.grsix.inch)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.affirm =
  push_pbox_toexpand("kanji.grfive.affirm");
  build_kanji.dotcliff_enclose(kanji.grtwo.heart);
  expand_pbox;
enddef;

vardef kanji.grfive.eloquence =
  push_pbox_toexpand("kanji.grfive.eloquence");
  build_kanji.level(build_kanji.tb(490,10)
    (build_kanji.sscale(xscaled 0.90)(kanji.radical.mu))
    (kanji.radical.aitch));
  expand_pbox;
enddef;

vardef kanji.grfive.journey =
  push_pbox_toexpand("kanji.grfive.journey");
  build_kanji.level(build_kanji.lr(310,-40)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grthree.master));
  expand_pbox;
enddef;

vardef kanji.grfive.pleasure =
  push_pbox_toexpand("kanji.grfive.pleasure");
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart)
    (kanji.rare.decide));
  expand_pbox;
enddef;

vardef kanji.grfive.restore =
  push_pbox_toexpand("kanji.grfive.restore");
  build_kanji.lr(310,-20-10*mincho)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (build_kanji.level(build_kanji.tb(340,0)
       (tsu_xform(identity yscaled (480/750))
          (kanji.grone.day);
        push_stroke((280,810)..tension 1.2..(160,570)..(50,460),
          (1.7,1.7)--(1.5,1.5)--(1.2,1.2));
        set_boserif(0,0,10);
        set_bosize(0,90);
        push_stroke((get_strokep(0) intersectionpoint ((0,700)--(1000,700)))--
             (880,700),
          (1.5,1.5)--(1.6,1.6));
        set_boserif(0,1,9);
        set_bosize(0,90))
       (kanji.radical.winter)));
  expand_pbox;
enddef;

vardef kanji.grfive.stretch =
  push_pbox_toexpand("kanji.grfive.stretch");
  build_kanji.lr(380,-40)
    (build_kanji.sscale(yscaled 1.06 shifted (0,10))(kanji.grtwo.bow))
    (kanji.grtwo.long);
  expand_pbox;
enddef;

vardef kanji.grfive.virtue =
  push_pbox_toexpand("kanji.grfive.virtue");
  build_kanji.lr(330,-100)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (build_kanji.level(build_kanji.tb(340,70)
       (build_kanji.tb(440,30)
          (kanji.grone.ten)
          (kanji.toprad.eye))
       (kanji.bottomrad.heart)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.busy =
  push_pbox_toexpand("kanji.grsix.busy");
  build_kanji.level(build_kanji.lr(340,-30)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.98)(kanji.grsix.dead)));
  expand_pbox;
enddef;

vardef kanji.grsix.forget =
  push_pbox_toexpand("kanji.grsix.forget");
  build_kanji.level(build_kanji.tb(360,-40)
    (kanji.grsix.dead)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.grsix.loyalty =
  push_pbox_toexpand("kanji.grsix.loyalty");
  build_kanji.level(build_kanji.tb(360,0)
    (kanji.grone.middle)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.grsix.regulate =
  push_pbox_toexpand("kanji.grsix.regulate");
  build_kanji.level(build_kanji.lr(310,0)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.radical.brush));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.fling =
  push_pbox_toexpand("kanji.greight.fling");
  build_kanji.level(build_kanji.lr(400,50)
    (kanji.grtwo.bow)
    (kanji.grfour.single));
  expand_pbox;
enddef;

vardef kanji.greight.funeral =
  push_pbox_toexpand("kanji.greight.funeral");
  kanji.grtwo.bow;
  replace_strokep(0)((point 0 of oldp)--
    ((subpath (1,infinity) of oldp)
     shifted (-820,0) xscaled 0.45 shifted (820,0)));
  push_stroke((500,740)--(500,-60),(1.6,1.6)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.greight.he =
  push_pbox_toexpand("kanji.greight.he");
  build_kanji.level(build_kanji.lr(310,-30)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grthree.pelt));
  expand_pbox;
enddef;

vardef kanji.greight.subjugate =
  push_pbox_toexpand("kanji.greight.subjugate");
  build_kanji.level(build_kanji.lr(310,0)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grone.correct));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.slacken =
  push_pbox_toexpand("kanji.grnine.slacken");
  build_kanji.level(build_kanji.lr(400,30)
    (kanji.grtwo.bow)
    (kanji.grnine.to_be));
  expand_pbox;
enddef;

vardef kanji.grnine.wide =
  push_pbox_toexpand("kanji.grnine.wide");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.bow)
    (kanji.radical.mu));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% "topped aitch radical"
begintsuglyph("uni5F00",0);
  kanji.radical.topped_aitch;
  tsu_render;
endtsuglyph;

% ben/kanmuri multiple meanings including "eloquence"
begintsuglyph("uni5F01",1);
  kanji.grfive.eloquence;
  tsu_render;
endtsuglyph;

% yoku/iguromi "ceremony radical"
begintsuglyph("uni5F0B",11);
  kanji.radical.ceremony;
  tsu_render;
endtsuglyph;

% shiki/nori "formula"
begintsuglyph("uni5F0F",15);
  kanji.grthree.formula;
  tsu_render;
endtsuglyph;

% kyuu/yumi "bow" (projectile weapon)
begintsuglyph("uni5F13",19);
  kanji.grtwo.bow;
  tsu_render;
endtsuglyph;

% chou/tomura "funeral"
begintsuglyph("uni5F14",20);
  kanji.greight.funeral;
  tsu_render;
endtsuglyph;

% in/hi "pull"
begintsuglyph("uni5F15",21);
  kanji.grtwo.pull;
  tsu_render;
endtsuglyph;

% te "phoneme only"
begintsuglyph("uni5F16",22);
  tsu_xform(identity shifted (0,-780) yscaled 0.82 shifted (0,780))
    (kanji.grtwo.bow);
  push_stroke((120,0)--(880,0),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  tsu_render;
endtsuglyph;

% futsu/doru "dollar"
begintsuglyph("uni5F17",23);
  kanji.rare.dollar;
  tsu_render;
endtsuglyph;

% kou/hiro "wide" (used in names)
begintsuglyph("uni5F18",24);
  kanji.grnine.wide;
  tsu_render;
endtsuglyph;

% chi/taru "slacken"
begintsuglyph("uni5F1B",27);
  kanji.grnine.slacken;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5F1C",28);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.bow)
    (kanji.grtwo.bow));
  tsu_render;
endtsuglyph;

% twi/otouto "little brother"
begintsuglyph("uni5F1F",31);
  kanji.grtwo.little_brother;
  tsu_render;
endtsuglyph;

% jyaku/yowa "weak"
begintsuglyph("uni5F31",49);
  kanji.grtwo.weak;
  tsu_render;
endtsuglyph;

% chou/ha "stretch"
begintsuglyph("uni5F35",53);
  kanji.grfive.stretch;
  tsu_render;
endtsuglyph;

% kyou/tsuyo "strong"
begintsuglyph("uni5F37",55);
  kanji.grtwo.strong;
  tsu_render;
endtsuglyph;

% dan/hi multiple meanings including "fling" and "strum"
begintsuglyph("uni5F3E",62);
  kanji.greight.fling;
  tsu_render;
endtsuglyph;

% needed for lots of other things, rare by itself
begintsuglyph("uni5F50",80);
  kanji.radical.pigs_tail;
  tsu_render;
endtsuglyph;

% tou/a(tari) "hit"
begintsuglyph("uni5F53",83);
  kanji.grtwo.hit;
  tsu_render;
endtsuglyph;

% san "short hair radical"
begintsuglyph("uni5F61",97);
  kanji.rightrad.short_hair;
  tsu_render;
endtsuglyph;

% kei/kata "form"
begintsuglyph("uni5F62",98);
  kanji.grtwo.form;
  tsu_render;
endtsuglyph;

% gen/hiko "boy"
begintsuglyph("uni5F66",102);
  kanji.grnine.boy;
  tsu_render;
endtsuglyph;

% extra: hou/samayo "loiter"
begintsuglyph("uni5F77",119);
  build_kanji.level(build_kanji.lr(310,0)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grtwo.direction));
  tsu_render;
endtsuglyph;

% yaku "duty"
begintsuglyph("uni5F79",121);
  kanji.grthree.duty;
  tsu_render;
endtsuglyph;

% hi/kare "he"
begintsuglyph("uni5F7C",124);
  kanji.greight.he;
  tsu_render;
endtsuglyph;

% ou/i "journey"
begintsuglyph("uni5F80",128);
  kanji.grfive.journey;
  tsu_render;
endtsuglyph;

% sei "subjugate"
begintsuglyph("uni5F81",129);
  kanji.greight.subjugate;
  tsu_render;
endtsuglyph;

% extra: ou/i "journey"
begintsuglyph("uni5F82",130);
  build_kanji.level(build_kanji.lr(310,0)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.greight.furthermore));
  tsu_render;
endtsuglyph;

% extra: ou/i "journey"
begintsuglyph("uni5F83",131);
  build_kanji.level(build_kanji.lr(310,0)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grone.life));
  tsu_render;
endtsuglyph;

% kei/machi "diameter"
begintsuglyph("uni5F84",132);
  kanji.grfour.diameter;
  tsu_render;
endtsuglyph;

% tai/matsu "wait"
begintsuglyph("uni5F85",133);
  kanji.grthree.wait;
  tsu_render;
endtsuglyph;

% extra: kon/mopto "disobey"
begintsuglyph("uni5F88",136);
  build_kanji.level(build_kanji.lr(310,30)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.radical.northeast));
  tsu_render;
endtsuglyph;

% extra: kai/samayo "wandering"
begintsuglyph("uni5F8A",138);
  build_kanji.level(build_kanji.lr(310,-40)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (build_kanji.sscale(scaled 0.92)(kanji.grtwo.occurrences)));
  tsu_render;
endtsuglyph;

% ritsu/takashi regulate
begintsuglyph("uni5F8B",139);
  kanji.grsix.regulate;
  tsu_render;
endtsuglyph;

% go/shiri "behind"
begintsuglyph("uni5F8C",140);
  kanji.grtwo.behind;
  tsu_render;
endtsuglyph;

% to/itazura "pedestrian"
begintsuglyph("uni5F92",146);
  kanji.grfour.pedestrian;
  tsu_render;
endtsuglyph;

% taku/e "profit"
begintsuglyph("uni5F97",151);
  kanji.grfour.profit;
  tsu_render;
endtsuglyph;

% extra "wander"
begintsuglyph("uni5F98",152);
  build_kanji.level(build_kanji.lr(310,-30)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grfive.mistake));
  tsu_render;
endtsuglyph;

% extra: kou/samayo "wandering"
begintsuglyph("uni5FA8",168);
  build_kanji.level(build_kanji.lr(310,0)
    (build_kanji.harmonic(240,0.86,0)(kanji.leftrad.person))
    (kanji.grsix.emperor));
  tsu_render;
endtsuglyph;

% fuku/mata "restore"
begintsuglyph("uni5FA9",169);
  kanji.grfive.restore;
  tsu_render;
endtsuglyph;

% toku/atsu "virtue" ("Toku" of "Tokugawa")
begintsuglyph("uni5FB3",179);
  kanji.grfive.virtue;
  tsu_render;
endtsuglyph;

% shin/kokoro "heart"
begintsuglyph("uni5FC3",195);
  kanji.grtwo.heart;
  tsu_render;
endtsuglyph;

% left radical version
begintsuglyph("uni5FC4",196);
  build_kanji.sscale(xscaled 0.5)(kanji.leftrad.heart);
  tsu_render;
endtsuglyph;

% hitsu/nagara "inevitable"
begintsuglyph("uni5FC5",197);
  kanji.grfour.inevitable;
  tsu_render;
endtsuglyph;

% extra "great achievement"
begintsuglyph("uni5FC7",199);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grone.power));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FC8",200);
  build_kanji.level(build_kanji.tb(420,30)
    (kanji.grone.two)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FC9",201);
  build_kanji.level(build_kanji.lr(320,40)
    (kanji.leftrad.heart)
    (kanji.grtwo.sword));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FCA",202);
  build_kanji.level(build_kanji.lr(360,10)
    (kanji.leftrad.heart)
    (kanji.grthree.thumbtack));
  tsu_render;
endtsuglyph;

% kai/tanomu "rely upon"
begintsuglyph("uni5FCB",203);
  build_kanji.level(build_kanji.lr(340,-10)
    (kanji.leftrad.heart)
    (kanji.grsix.self));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FCF",207);
  build_kanji.level(build_kanji.lr(360,-30)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.94)(kanji.grone.one_thousand)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FD0",208);
  build_kanji.level(build_kanji.tb(420,0)
    (kanji.grone.up)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FD1",209);
  build_kanji.level(build_kanji.tb(420,10)
    (kanji.grone.down)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% kan/kiwameru "concerned about"
begintsuglyph("uni5FD3",211);
  build_kanji.level(build_kanji.lr(350,-30-mincho*30)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,-20))(kanji.grsix.dry)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FD5",213);
  build_kanji.level(build_kanji.lr(320,-40)
    (kanji.leftrad.heart)
    (kanji.grone.big));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FD6",214);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grsix.inch));
  tsu_render;
endtsuglyph;

% shi/kokoroza "intention"
begintsuglyph("uni5FD7",215);
  kanji.grfive.intention;
  tsu_render;
endtsuglyph;

% bou/wasu "forget"
begintsuglyph("uni5FD8",216);
  kanji.grsix.forget;
  tsu_render;
endtsuglyph;

% bou/isogashii "busy"
begintsuglyph("uni5FD9",217);
  kanji.grsix.busy;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FDA",218);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grnine.to_be));
  tsu_render;
endtsuglyph;

% ou/ata "affirm"
begintsuglyph("uni5FDC",220);
  kanji.grfive.affirm;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FDF",223);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grone.sentence));
  tsu_render;
endtsuglyph;

% chuu/kiyoshi "loyalty"
begintsuglyph("uni5FE0",224);
  kanji.grsix.loyalty;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FE1",225);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grone.middle));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FE2",226);
  build_kanji.level(build_kanji.tb(420,30)
    (kanji.grone.five)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FE3",227);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (tsu_xform(identity shifted (0,-780) yscaled 0.96 shifted (0,780))
       (kanji.greight.reach)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FE4",228);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.noon));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FE6",230);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.94)(kanji.greight.mediate)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FE8",232);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.origin));
  tsu_render;
endtsuglyph;

% sou/niwaka "be flustered"
begintsuglyph("uni5FE9",233);
  kanji.rare.be_flustered;
  tsu_render;
endtsuglyph;

% shou/odoroku "tranquil"
begintsuglyph("uni5FEA",234);
  build_kanji.level(build_kanji.lr(370,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.95)(kanji.grtwo.public)));
  tsu_render;
endtsuglyph;

% kai/kokoroyo "pleasure"
begintsuglyph("uni5FEB",235);
  kanji.grfive.pleasure;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FEC",236);
  build_kanji.level(build_kanji.lr(320,100)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1) of oldp);
     replace_strokeq(0)(subpath (0,1) of oldq))
    (kanji.grthree.before));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FEE",238);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfive.support));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FEF",239);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.clan));
  tsu_render;
endtsuglyph;

% tai/narau "extravagant"
begintsuglyph("uni5FF2",242);
  build_kanji.level(build_kanji.lr(340,80)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,0.9) of oldp);
     replace_strokeq(0)(subpath (0,0.9) of oldq))
    (build_kanji.sscale(scaled 0.94)(kanji.grtwo.thick)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FF4",244);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.now));
  tsu_render;
endtsuglyph;

% nen "care"
begintsuglyph("uni5FF5",245);
  kanji.grfour.care;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FF6",246);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grnine.declaim));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FF9",249);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grone.king));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FFA",250);
  build_kanji.level(build_kanji.lr(320,-10)
    (kanji.leftrad.heart)
    (kanji.grfour.fail));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FFB",251);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (kanji.greight.axe));
  tsu_render;
endtsuglyph;

% kou/nageku "weep"
begintsuglyph("uni5FFC",252);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.97)(kanji.rare.high_spirits)));
  tsu_render;
endtsuglyph;

% kotsu/tachima "suddenly"
begintsuglyph("uni5FFD",253);
  kanji.grnine.suddenly;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5FFE",254);
  build_kanji.level(build_kanji.lr(360,-50)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.96)(build_kanji.steam_enclose((700,400))())));
  tsu_render;
endtsuglyph;

% extra "be angry"
begintsuglyph("uni5FFF",255);
  build_kanji.level(build_kanji.tb(410,80)
    (kanji.grtwo.minute)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
