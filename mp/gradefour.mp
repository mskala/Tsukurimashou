%
% Grade Four kanji used on more than one page
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

inclusion_lock(gradefour);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.addition =
  push_pbox_toexpand("kanji.grfour.addition");
  build_kanji.level(build_kanji.lr(500,0)
    (kanji.grone.power)
    (kanji.grone.mouth));
  expand_pbox;
enddef;

vardef kanji.grfour.advantage =
  push_pbox_toexpand("kanji.grfour.advantage");
  build_kanji.level(build_kanji.lr(560,30)
    (kanji.leftrad.two_branch_tree)
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

vardef kanji.grfour.army =
  push_pbox_toexpand("kanji.grfour.army");
  build_kanji.level(build_kanji.tb(640,300)
    (tsu_xform(identity shifted (0,160))(kanji.radical.conservative_hat))
    (kanji.grone.wheel;
     replace_strokep(-5)(subpath (0.1+0.05*mincho,0.9-0.05*mincho) of oldp)));
  expand_pbox;
enddef;

vardef kanji.grfour.attach =
  push_pbox_toexpand("kanji.grfour.attach");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grsix.inch);
  expand_pbox;
enddef;

vardef kanji.grfour.build =
  push_pbox_toexpand("kanji.grfour.build");
  build_kanji.long_stride_enclose(false)
    (build_kanji.sscale(yscaled 1.1 shifted (0,30))(kanji.radical.brush));
  expand_pbox;
enddef;

vardef kanji.grfour.bundle =
  push_pbox_toexpand("kanji.grfour.bundle");
  push_stroke((500,810)--(500,-60),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((100,710)--(900,710),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.box((210,580),(790,320));
  push_stroke((500,320)..(250,90)..(80,-10),
    (1.6,1.6)..(1.3,1.3)..(0.9,0.9));
  push_stroke((500,320)..(750,90)..(870,0),
    (1.1,1.1)..(1.5,1.5)..(1.7,1.7));
  for i=-6 upto 0: set_bosize(i,89); endfor;
  expand_pbox;
enddef;

vardef kanji.grfour.bureaucracy =
  push_pbox_toexpand("kanji.grfour.bureaucracy");
  build_kanji.level(build_kanji.tb(570,100)
    (kanji.radical.silly_hat)
    (build_kanji.sscale(xscaled 0.8 shifted (30,0))
       (kanji.rare.mound_helper)));
  expand_pbox;
enddef;

vardef kanji.grfour.circuit =
  push_pbox_toexpand("kanji.grfour.circuit");
  push_stroke((80,-20)..(150,100)..{up}(200,760){right}--(820,760),
    (1,1)--(1.4,1.4)--(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,2,0.8);
  set_botip(0,3,1);
  set_boserif(0,2,4);
  set_boserif(0,3,4);
  build_kanji.sscale(xyscaled (0.45,0.7) shifted (0,-20))
    (build_kanji.tb(420,-70)
       (kanji.grone.earth)
       (kanji.grone.mouth));
  expand_pbox;
enddef;

vardef kanji.grfour.clan =
  push_pbox_toexpand("kanji.grfour.clan");
  push_stroke((770,810)..tension 1.2..(550,740)..(250,700),
    (1.8,1.8)--(1.5,1.5)--(1,1));
  push_stroke((250,730)--(250,-10),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((140,-30)..tension 1.2..(250,-10)..(510,70),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  push_stroke((250,440)--(870,440),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke(interpath(mincho,
      (550,740){down}..tension 1.2 and 1.6..(760,0)..(850,0)..tension 1.5..
        (880,100)..(910,200),
      (550,740){down}..(660,150)..{right}(910,0){curl 1}..
        (870,100)..(870,200)),
    (1.6,1.6)--(1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(0.9,0.9));
  expand_pbox;
enddef;

vardef kanji.grfour.director =
  push_pbox_toexpand("kanji.grfour.director");
  build_kanji.sscale(shifted (-20,0) xscaled 1.1)
    (kanji.radical.gmm);
  replace_strokep(0)(subpath (2,infinity) of oldp);
  replace_strokeq(0)(subpath (2,infinity) of oldq);
  set_botip(0,1,4);
  set_boserif(0,1,4);
  set_botip(0,2,whatever);
  set_boserif(0,2,whatever);
  set_botip(0,3,whatever);
  set_boserif(0,3,whatever);
  push_stroke((220,620)--(690,620),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.box((260,470),(650,170));
  expand_pbox;
enddef;

vardef kanji.grfour.disappear =
  push_pbox_toexpand("kanji.grfour.disappear");
  push_stroke((270,750)..tension 1.2..(200,550)..(90,430),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  set_boserif(0,0,10);
  kanji.grfour.husband;
  replace_strokep(-3)((100,590)--(810,590));
  replace_strokep(-3)(subpath
    (0.01+xpart (oldp intersectiontimes get_strokep(-4)),1) of oldp);
  expand_pbox;
enddef;

vardef kanji.grfour.dispute =
  push_pbox_toexpand("kanji.grfour.dispute");
  build_kanji.attach_fishhook(0.77)(
    build_kanji.sscale(yscaled 0.6 shifted (0,150))
      (kanji.radical.pigs_snout);
    push_stroke((point 0.5 of get_strokep(-2)),((1.6,1.6)));
    build_kanji.add_jtail(0));
  expand_pbox;
enddef;

vardef kanji.grfour.every =
  push_pbox_toexpand("kanji.grfour.every");
  build_kanji.level(build_kanji.tb(300,80)
    (kanji.radical.winter)
    (kanji.grone.mouth));
  expand_pbox;
enddef;

vardef kanji.grfour.fail =
  push_pbox_toexpand("kanji.grfour.fail");
  push_stroke((240,780)..tension 1.2..(190,570)..(120,460),
    (1.7,1.7)--(1.4,1.4)--(1,1));
  set_boserif(0,0,10);
  push_stroke(
    ((get_strokep(0) intersectionpoint
        ((0,640-7*mincho)--(1000,640))+(10,0)))--
      ((850,640)+mincho*(0,10))..tension 1.2..(820,520)..(730,400),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1,1));
  set_boserif(0,1,4);
  set_botip(0,1,0);
  tsu_xform(identity yscaled (640/780))(kanji.grone.person);
  set_boserif(-1,0,whatever);
  expand_pbox;
enddef;

vardef kanji.grfour.fancy =
  push_pbox_toexpand("kanji.grfour.fancy");
  build_kanji.lr(420,20)
    (kanji.leftrad.woman)
    (kanji.grone.child);
  expand_pbox;
enddef;

vardef kanji.grfour.fruit =
  push_pbox_toexpand("kanji.grfour.fruit");
  build_kanji.tb(420,100)
    (build_kanji.sscale(xscaled 0.9)(kanji.grone.paddy))
    (kanji.grone.wood);
  replace_strokep(-5)
    ((point 0 of oldp)--(point infinity of get_strokep(-3)));
  obstacktype[find_whatever(otstroke,-3)]:=otnull;
  expand_pbox;
enddef;

vardef kanji.grfour.gentleman =
  push_pbox_toexpand("kanji.grfour.gentleman");
  push_stroke((500,780)--(500,0),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((80,470)--(920,470),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((180,0)--(820,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grfour.good =
  push_pbox_toexpand("kanji.grfour.good");
  build_kanji.level(
    push_stroke((500,830)--(500,700),(1.6,1.6)--(1.5,1.5));
    set_boserif(0,0,10);
    tsu_xform(identity yscaled (700/770))(kanji.radical.northeast));
  expand_pbox;
enddef;

vardef kanji.grfour.hard =
  push_pbox_toexpand("kanji.grfour.hard");
  kanji.radical.box;
  build_kanji.sscale(scaled 0.75)(kanji.grtwo.old);
  expand_pbox;
enddef;

vardef kanji.grfour.history =
  push_pbox_toexpand("kanji.grfour.history");
  build_kanji.box((220,610),(780,370));
  push_stroke((500,810)--(500,300){down}..(370,70)..{curl 0.5}(90,-40),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke((340,260)..tension 1.2..(670,40)..(840,-10),
    (0.9,0.9)--(1.5,1.5)--(2,2));
  expand_pbox;
enddef;

vardef kanji.grfour.husband =
  push_pbox_toexpand("kanji.grfour.husband");
  push_stroke((170,610)--(830,610),
    (1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((80,360)--(920,360),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((510,810){down}..(500,440)..(370,180)..{curl 0.5}(50,-20),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke(((get_strokep(-1) intersectionpoint get_strokep(0))+(50,0))..
      (650,180)..(900,-10),
    (1.1,1.1)--(1.4,1.4)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.grfour.inevitable =
  push_pbox_toexpand("kanji.grfour.inevitable");
  kanji.grtwo.heart;
  replace_strokep(-1)(subpath (0,1.7) of oldp);
  replace_strokep(0)(subpath (0.3,2) of oldp);
  push_stroke((830,800)..tension 1.2..(600,370)..(0,0),
    (1.6,1.6)--(1.5,1.5)--(0.9,0.9));
  expand_pbox;
enddef;

vardef kanji.grfour.lineage =
  push_pbox_toexpand("kanji.grfour.lineage");
  build_kanji.add_beret(kanji.grone.thread);
  expand_pbox;
enddef;

vardef kanji.grfour.not_yet =
  push_pbox_toexpand("kanji.grfour.not_yet");
  kanji.grfour.husband;
  begingroup
    save it;
    numeric it;
    it:=xpart (get_strokep(-1) intersectiontimes get_strokep(-2));
    push_stroke(subpath (it,infinity) of get_strokep(-1) shifted (-10,0),
      subpath(it,infinity) of get_strokeq(-1));
  endgroup;
  replace_strokep(-2)((510,810)--(510,-50));
  replace_strokeq(-2)((1.6,1.6)--(1.4,1.4));
  replace_strokep(-1)(oldp shifted (30,0));
  expand_pbox;
enddef;

vardef kanji.grfour.old_man =
  push_pbox_toexpand("kanji.grfour.old_man");
  kanji.radical.old_man(
    build_kanji.sscale(xyscaled (0.83,1.1) shifted (70,50))
      (kanji.radical.spoon));
  expand_pbox;
enddef;

vardef kanji.grfour.perfect =
  push_pbox_toexpand("kanji.grfour.perfect");
  build_kanji.tb(600,110)
    (kanji.radical.silly_hat)
    (build_kanji.sscale(xscaled 0.8)(kanji.grtwo.origin));
  expand_pbox;
enddef;

vardef kanji.grfour.request =
  push_pbox_toexpand("kanji.grfour.request");
  tsu_xform(identity yscaled 0.9)(kanji.radical.alt_water);
  replace_strokep(-4)((510,810)--(subpath (1,infinity) of oldp));
  push_stroke((100,620)--(900,620),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((690,790)..tension 1.2..(780,730)..(810,690),
    (1,1)--(1.4,1.4)--(1.6,1.6));
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef kanji.grfour.revelation =
  push_pbox_toexpand("kanji.grfour.revelation");
  build_kanji.level(build_kanji.tb(440,-30)
    (kanji.radical.life_minus)
    (kanji.grone.mouth));
  expand_pbox;
enddef;

vardef kanji.grfour.together =
  push_pbox_toexpand("kanji.grfour.together");
  build_kanji.level(build_kanji.tb(290,46)
    (kanji.toprad.once_upon_a_time)
    (tsu_xform(identity shifted (20,0))(kanji.radical.eight)));
  expand_pbox;
enddef;
