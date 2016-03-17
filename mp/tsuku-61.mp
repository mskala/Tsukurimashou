%
% Unicode page 61 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2016  Matthew Skala
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

vardef kanji.grthree.feeling =
  push_pbox_toexpand("kanji.grthree.feeling");
  build_kanji.level(build_kanji.tb(250,0)
    (kanji.rare.the_same)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.love =
  push_pbox_toexpand("kanji.grfour.love");
  build_kanji.level(build_kanji.tb(430,160)
    (build_kanji.tb(380,160)
       (kanji.toprad.paw)
       (kanji.radical.conservative_hat))
    (build_kanji.tb(460,-40)
       (build_kanji.sscale(xscaled 0.8)(kanji.bottomrad.heart))
       (kanji.radical.winter)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.manner =
  push_pbox_toexpand("kanji.grfive.manner");
  build_kanji.level(build_kanji.tb(230,0)
    (kanji.grfive.talent)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.indignation =
  push_pbox_toexpand("kanji.greight.indignation");
  build_kanji.level(build_kanji.lr(320,40)
    (kanji.leftrad.heart;
     replace_strokep(0)(oldp shifted (0,-50)))
    (kanji.rare.decorate));
  expand_pbox;
enddef;

vardef kanji.greight.longing =
  push_pbox_toexpand("kanji.greight.longing");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grthree.child;
     replace_strokep(-6)(subpath (0.07,1) of oldp)));
  expand_pbox;
enddef;

vardef kanji.greight.prudent =
  push_pbox_toexpand("kanji.greight.prudent");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grthree.truth));
  expand_pbox;
enddef;

vardef kanji.greight.recollection =
  push_pbox_toexpand("kanji.greight.recollection");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grthree.intention));
  expand_pbox;
enddef;

vardef kanji.greight.resentment =
  push_pbox_toexpand("kanji.greight.resentment");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grthree.feeling));
  expand_pbox;
enddef;

vardef kanji.greight.rue =
  push_pbox_toexpand("kanji.greight.rue");
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart)
    (kanji.greight.already));
  expand_pbox;
enddef;

vardef kanji.greight.yearning =
  push_pbox_toexpand("kanji.greight.yearning");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.93 shifted (0,-20))(kanji.grfour.scenery)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% shuu "respect"
begintsuglyph("uni6100",0);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,0.9) of oldp shifted (80,40));
     replace_strokeq(0)(subpath (0,0.9) of oldq))
    (kanji.grtwo.autumn));
  tsu_render;
endtsuglyph;

% hyoku/makoto "sincere"
begintsuglyph("uni610A",10);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 1.05 shifted (0,30))
       (kanji.rare.roll_of_cloth)));
  tsu_render;
endtsuglyph;

% i/moto "intention"
begintsuglyph("uni610F",15);
  kanji.grthree.intention;
  tsu_render;
endtsuglyph;

% ben/tsutomeru "bashful"
begintsuglyph("uni6110",16);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.96 shifted (0,20))(kanji.grthree.face)));
  tsu_render;
endtsuglyph;

% you/mitsuru "no meaning specified"
begintsuglyph("uni6111",17);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.94)(kanji.grfour.courage)));
  tsu_render;
endtsuglyph;

% tou/hoshiimama "profligate"
begintsuglyph("uni6113",19);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.8) of oldp);
     replace_strokeq(0)(subpath (0,1.8) of oldq))
    (build_kanji.sscale(shifted (0,-20))(kanji.rare.sun)));
  tsu_render;
endtsuglyph;

% in/yawaragu "comfortable"
begintsuglyph("uni6114",20);
  build_kanji.level(build_kanji.lr(340,30)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.3) of oldp shifted (60,30));
     replace_strokeq(0)(subpath (0,1.3) of oldq))
    (kanji.grone.noise));
  tsu_render;
endtsuglyph;

% gaku/odoro "surprised"
begintsuglyph("uni6115",21);
  build_kanji.level(build_kanji.lr(320,40)
    (kanji.leftrad.heart)
    (kanji.rare.outspokenly));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6118",24);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grthree.guest));
  tsu_render;
endtsuglyph;

% ai/ito "romantic love"
begintsuglyph("uni611B",27);
  kanji.grfour.love;
  tsu_render;
endtsuglyph;

% kan "feeling"
begintsuglyph("uni611F",31);
  kanji.grthree.feeling;
  tsu_render;
endtsuglyph;

% sou "foot race"
begintsuglyph("uni6121",33);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.tb(420,50)
       (kanji.radical.crossed_must_not)
       (kanji.bottomrad.heart)));
  tsu_render;
endtsuglyph;

% sei/kororogatagau "different mind"?
begintsuglyph("uni6122",34);
  build_kanji.level(build_kanji.lr(320,-10)
    (kanji.leftrad.heart)
    (kanji.grtwo.think));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6125",37);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.english));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6129",41);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.greight.tribute));
  tsu_render;
endtsuglyph;

% un/uraeru "be sad"
begintsuglyph("uni612A",42);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (kanji.grthree.member));
  tsu_render;
endtsuglyph;

% sou/itamashii "pathetic"
begintsuglyph("uni6134",52);
  build_kanji.level(build_kanji.lr(320,40)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1) of oldp shifted (30,40));
     replace_strokeq(0)(subpath (0,1) of oldq))
    (build_kanji.sscale(scaled 0.96)(kanji.grfour.warehouse)));
  tsu_render;
endtsuglyph;

% deki/uraeru "no meaning given"
begintsuglyph("uni6135",53);
  build_kanji.level(build_kanji.lr(350,-20)
    (kanji.leftrad.heart)
    (kanji.grtwo.weak));
  tsu_render;
endtsuglyph;

% you/ikaru "no meaning given"
begintsuglyph("uni6139",57);
  build_kanji.level(build_kanji.lr(320,-10)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.96)(kanji.grfive.face)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni613A",58);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (kanji.grone.grass));
  tsu_render;
endtsuglyph;

% tan "grieving"
begintsuglyph("uni613D",61);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (kanji.rightrad.professional));
  tsu_render;
endtsuglyph;

% tai/waza "manner"
begintsuglyph("uni614B",75);
  kanji.grfive.manner;
  tsu_render;
endtsuglyph;

% shin/tsutsushimu "prudent"
begintsuglyph("uni614E",78);
  kanji.greight.prudent;
  tsu_render;
endtsuglyph;

% hyou "quick"
begintsuglyph("uni6153",83);
  build_kanji.level(build_kanji.lr(350,-20)
    (kanji.leftrad.heart)
    (kanji.grfour.ticket));
  tsu_render;
endtsuglyph;

% zen/haji "feel deeply ashamed"
begintsuglyph("uni615A",90);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.greight.decapitate));
  tsu_render;
endtsuglyph;

% shou/osoreru "no meaning given"
begintsuglyph("uni615E",94);
  build_kanji.level(build_kanji.lr(340,-30)
    (kanji.leftrad.heart)
    (kanji.grthree.chapter));
  tsu_render;
endtsuglyph;

% dou/nageku "grieve"
begintsuglyph("uni615F",95);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grthree.motion));
  tsu_render;
endtsuglyph;

% zou/tashikani "make sure"
begintsuglyph("uni6165",101);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.4) of oldp);
     replace_strokeq(0)(subpath (0,1.4) of oldq))
    (kanji.grfive.make_up));
  tsu_render;
endtsuglyph;

% gai "rue"
begintsuglyph("uni6168",104);
  kanji.greight.rue;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6169",105);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.4) of oldp);
     replace_strokeq(0)(subpath (0,1.4) of oldq))
    (kanji.grfour.bring));
  tsu_render;
endtsuglyph;

% shuu/osoreru "cower"
begintsuglyph("uni6174",116);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grthree.learn));
  tsu_render;
endtsuglyph;

% kou/nageku "lamentation"
begintsuglyph("uni6177",119);
  build_kanji.level(build_kanji.lr(330,-20)
    (kanji.leftrad.heart)
    (kanji.grfour.peace));
  tsu_render;
endtsuglyph;

% yuu/ure "melancholy"
begintsuglyph("uni6182",130);
  kanji.greight.melancholy;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6186",134);
  build_kanji.level(build_kanji.lr(340,-10)
    (kanji.leftrad.heart)
    (kanji.grfour.hall));
  tsu_render;
endtsuglyph;

% kyou/hoshiimama "be haughty"
begintsuglyph("uni618D",141);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.96)(kanji.grnine.boast)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni618F",143);
  build_kanji.level(build_kanji.lr(320,-30)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 1.02 shifted (0,-30))(kanji.grthree.festival)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6195",149);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (kanji.grthree.climb));
  tsu_render;
endtsuglyph;

% ki/yorokobu "joyful thing"
begintsuglyph("uni6198",152);
  build_kanji.level(build_kanji.lr(350,10)
    (kanji.leftrad.heart)
    (kanji.grfour.pleasure));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni61A3",163);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,-10))(kanji.grtwo.ordinal)));
  tsu_render;
endtsuglyph;

% fun/ikidoo "indignation"
begintsuglyph("uni61A4",164);
  kanji.greight.indignation;
  tsu_render;
endtsuglyph;

% shou/akagareru "longing"
begintsuglyph("uni61A7",167);
  kanji.greight.longing;
  tsu_render;
endtsuglyph;

% kan.tanoshimu "contented"
begintsuglyph("uni61AA",170);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.gate_enclose(kanji.grone.moon)));
  tsu_render;
endtsuglyph;

% kei/akogareru "yearning"
begintsuglyph("uni61AC",172);
  kanji.greight.yearning;
  tsu_render;
endtsuglyph;

% bu/itsukushimu "disappointment"
begintsuglyph("uni61AE",174);
  build_kanji.level(build_kanji.lr(300,-20)
    (kanji.leftrad.heart)
    (kanji.grfour.nothing));
  tsu_render;
endtsuglyph;

% oku "recollection"
begintsuglyph("uni61B6",182);
  kanji.greight.recollection;
  tsu_render;
endtsuglyph;

% dou/kokoromidareru "worried"
begintsuglyph("uni61B9",185);
  build_kanji.level(build_kanji.lr(320,-10)
    (kanji.leftrad.heart)
    (kanji.grthree.farming));
  tsu_render;
endtsuglyph;

% kan/uramu "resentment"
begintsuglyph("uni61BE",190);
  kanji.greight.resentment;
  tsu_render;
endtsuglyph;

% ke/tawai "laziness"
begintsuglyph("uni61C8",200);
  build_kanji.level(build_kanji.lr(300,-10)
    (kanji.leftrad.heart)
    (kanji.grfive.solve));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni61D3",211);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.love));
  tsu_render;
endtsuglyph;

% you/negau "no meaning given"
begintsuglyph("uni61E9",233);
  build_kanji.level(build_kanji.lr(310,-10)
    (kanji.leftrad.heart)
    (kanji.grfour.nurture));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni61EA",234);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (kanji.grfive.outrage));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni61EB",235);
  build_kanji.level(build_kanji.lr(310,-10)
    (kanji.leftrad.heart)
    (kanji.grfive.quality));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni61EE",238);
  build_kanji.level(build_kanji.lr(310,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled (0.94+0.06*mincho))
       (kanji.greight.melancholy)));
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
