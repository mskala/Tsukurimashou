%
% Grade Four kanji used on more than one page
% Copyright (C) 2011, 2012, 2013, 2014, 2016  Matthew Skala
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

vardef kanji.grfour.as =
  push_pbox_toexpand("kanji.grfour.as");
  push_stroke((200,780)--(200,40),(1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((100,0)..tension 1.2..(200,40)..(560,300),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  push_stroke((850,800)..tension 1.2..(780,250)
      ..(680,70)..(400,-80),
    (1.6,1.6)--(1.55,1.55)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  push_stroke((420,720)..tension 1.3..(550,620)..(620,520),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  push_stroke((point 1.3 of get_strokep(-1))..tension 1.3
      ..(860,110)..(920,0),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  replace_strokep(0)(oldp shifted (0,-40));
  expand_pbox;
enddef;

vardef kanji.grfour.attach =
  push_pbox_toexpand("kanji.grfour.attach");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grsix.inch);
  expand_pbox;
enddef;

vardef kanji.grfour.become =
  push_pbox_toexpand("kanji.grfour.become");
  kanji.grnine.fifth;
  push_stroke((173,280)--(410,280),
    (1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  replace_strokep(0)(oldp shifted (0,110));
  set_boserif(0,1,4);
  set_botip(0,1,1);
  expand_pbox;
enddef;

vardef kanji.grfour.bring =
  push_pbox_toexpand("kanji.grfour.bring");
  build_kanji.road_enclose(kanji.grone.wheel);
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
       (kanji.rare_helper.mound)));
  expand_pbox;
enddef;

vardef kanji.grfour.care =
  push_pbox_toexpand("kanji.grfour.care");
  build_kanji.level(build_kanji.tb(360,160)
    (kanji.grtwo.now;
     replace_strokep(0)
       ((point 0 of oldp)--
        (subpath (1,infinity) of (oldp shifted (-point 1 of oldp)
                                  xscaled 0.5
                                  shifted (point 1 of oldp)))))
    (kanji.bottomrad.heart));
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

vardef kanji.grfour.clothes =
  push_pbox_toexpand("kanji.grfour.clothes");
  build_kanji.level(build_kanji.tb(540,80)
    (kanji.radical.kettle_lid)
    (kanji.bottomrad.clothes));
  expand_pbox;
enddef;

vardef kanji.grfour.convenience =
  push_pbox_toexpand("kanji.grfour.convenience");
  build_kanji.lr(300,10)
    (kanji.leftrad.person)
    (kanji.greight.night_watch);
  expand_pbox;
enddef;

vardef kanji.grfour.courage =
  push_pbox_toexpand("kanji.grfour.courage");
  build_kanji.level(build_kanji.tb(640,80)
    (push_stroke((220,740)--(750,740)..tension 1.2..(620,380)..(490,140),
       (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
     set_botip(0,1,0);
     set_boserif(0,1,4);
     push_stroke((340,410)..tension 1.2..(490,140)..(520,20),
       (1.1,1.1)--(1.5,1.5)--(1.8,1.8)))
    (kanji.grone.man));
  expand_pbox;
enddef;

vardef kanji.grfour.difference =
  push_pbox_toexpand("kanji.grfour.difference");
  build_kanji.level(
    build_kanji.tb(250,100)
      (build_kanji.sscale(xscaled 1.08)(kanji.toprad.sheep))
      (build_kanji.sscale(xscaled 0.83 shifted (80,0))(kanji.grtwo.craft));
    push_stroke(
      (point 0.30 of get_strokep(-6))..tension 1.2..(270,210)..(80,20),
      (1.6,1.6)--(1.4,1.4)--(0.9,0.9)));
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

vardef kanji.grfour.elephant =
  push_pbox_toexpand("kanji.grfour.elephant");
  build_kanji.attach_fishhook(0.8)
    (build_kanji.level(build_kanji.tb(580,140)
       (kanji.grone.mouth)
       (kanji.radical.pig);
     replace_strokep(-6)((point 1.5 of get_strokep(-8))
         --(point 0.5 of get_strokep(-7)));
     replace_strokeq(-6)((1.5,1.5)--(1.4,1.4))));
  expand_pbox;
enddef;

vardef kanji.grfour.english =
  push_pbox_toexpand("kanji.grfour.english");
  build_kanji.tb(630,80)
    (kanji.toprad.grass)
    (kanji.grthree.centre);
  expand_pbox;
enddef;

vardef kanji.grfour.essential =
  push_pbox_toexpand("kanji.grfour.essential");
  build_kanji.tb(480,-30)
    (kanji.toprad.ticket)
    (kanji.grone.woman);
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

vardef kanji.grfour_helper.fly =
  push_pbox_toexpand("kanji.grfour_helper.fly");
  push_stroke((120,760)--interpath(mincho,
      (660,760){dir -87}..{dir -72}(770,-20)..(860,-10)..tension 1.5..
        (890,100)..(910,200),
      (630,760){dir -82}..(740,100)..{right}(910,-40){curl 1}..
        (890,60)..(890,160)),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(0.9,0.9));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((point 1.33 of get_strokep(0))
      ..tension 1.2..(770,450)..(840,360),
    (1.2,1.2)--(1.6,1.6)--(1.8,1.8));
  set_bosize(0,90);
  push_stroke((810,670)..tension 1.2..(770,590)..(720,480),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  set_bosize(0,90);
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.grfour.fly =
  push_pbox_toexpand("kanji.grfour.fly");
  build_kanji.tb(440,50)
    (build_kanji.sscale(xscaled 0.9)(kanji.grfour_helper.fly))
    (kanji.grfour_helper.fly);
  push_stroke((480,680)--(480,-70),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  set_bosize(0,90);
  push_stroke((120,610)..(270,640)..tension 1.1..(370,680),
    (1.1,1.1)--(1.6,1.6)--(2.0,2.0));
  push_stroke((270,630){down}..(190,130)..(90,-70),
    (1.6,1.6)--(1.3,1.3)--(1,1));
  expand_pbox;
enddef;

vardef kanji.grfour.fold =
  push_pbox_toexpand("kanji.grfour.fold");
  build_kanji.level(build_kanji.lr(420,20)
    (kanji.leftrad.hand)
    (kanji.greight.axe));
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

vardef kanji.grfour.genus =
  push_pbox_toexpand("kanji.grfour.genus");
  build_kanji.level(build_kanji.lr(480,40)
    (build_kanji.lift_skirt(200,40)(build_kanji.tb(360,80)
       (kanji.leftrad.rice;
        replace_strokep(-3)(subpath (0,0.8) of oldp))
       (kanji.leftrad.big)))
    (kanji.grnine.page));
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

vardef kanji.grfour.graduate =
  push_pbox_toexpand("kanji.grfour.graduate");
  build_kanji.level(build_kanji.tb(650,20)
    (kanji.radical.kettle_lid)
    (build_kanji.tb(480,-20)
       (build_kanji.lr(480,20)
          (kanji.leftrad.alt_person)
          (kanji.leftrad.alt_person))
       (kanji.grone.ten;
        replace_strokep(0)(oldp shifted (0,50)))));
  expand_pbox;
enddef;

vardef kanji.grfour.grandchild =
  push_pbox_toexpand("kanji.grfour.grandchild");
  build_kanji.lr(480,110)
    (kanji.rare.mosquito_larva)
    (kanji.grfour.lineage);
  expand_pbox;
enddef;

vardef kanji.grfour.guess =
  push_pbox_toexpand("kanji.grfour.guess");
  build_kanji.tb(600,70)
    (kanji.radical.silly_hat)
    (kanji.grthree.festival);
  expand_pbox;
enddef;

vardef kanji.grfour.hall =
  push_pbox_toexpand("kanji.grfour.hall");
  build_kanji.level(build_kanji.tb(260,100)
    (kanji.toprad.ridiculous_hat)
    (kanji.grone.earth;
     set_boserif(-2,0,whatever)));
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

vardef kanji.grfour.kill =
  push_pbox_toexpand("kanji.grfour.kill");
  build_kanji.level(build_kanji.lr(360,0)
    (build_kanji.sscale(shifted (0,-40))(build_kanji.tb(600,-20)
       (kanji.radical.cut_the_grass)
       (kanji.leftrad.wood)))
    (kanji.radical.windy_again));
  expand_pbox;
enddef;

vardef kanji.grfour.lineage =
  push_pbox_toexpand("kanji.grfour.lineage");
  build_kanji.add_beret(kanji.grone.thread);
  expand_pbox;
enddef;

vardef kanji.grfour.loose =
  push_pbox_toexpand("kanji.grfour.loose");
  build_kanji.level(build_kanji.lr(520,20)
    (build_kanji.tb(500,-50)
       (kanji.toprad.once_upon_a_time)
       (kanji.bottomrad.moon))
    (kanji.radical.folding_chair));
  expand_pbox;
enddef;

vardef kanji.grfour.non =
  push_pbox_toexpand("kanji.grfour.non");
  push_stroke((120,760)--(880,760),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((520,760)..tension 1.2..(320,400)..(100,210),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  push_stroke((((480,1000)--(480,0)) intersectionpoint get_strokep(0))--
      (480,-50),
    (1.5,1.5)--(1.4,1.4));
  push_stroke((580,580)..tension 1.2..(780,400)..(870,250),
    (1,1)--(1.4,1.4)--(1.7,1.7));
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

vardef kanji.grfour.nothing =
  push_pbox_toexpand("kanji.grfour.nothing");
  build_kanji.level(build_kanji.tb(230,-50)
    (push_stroke((330,840){curl 0.1}..(230,660)..(90,480),
       (1.7,1.7)--(1.5,1.5)--(1.1,1.1));
     set_boserif(0,0,10);
     push_stroke((260,680)--(260,-40),
       (1.39,1.39)--(1.3,1.3));
     push_stroke(
       (((0,680)--(1000,680)) intersectionpoint get_strokep(-1))--(840,680),
       (1.5,1.5)--(1.5,1.5));
     set_boserif(0,1,9);
     push_stroke((420,680)--(420,-40),
       (1.4,1.4)--(1.3,1.3));
     push_stroke((580,680)--(580,-40),
       (1.4,1.4)--(1.3,1.3));
     push_stroke((740,680)--(740,-40),
       (1.4,1.4)--(1.3,1.3));
     push_stroke((120,320)--(880,320),
       (1.5,1.5)--(1.5,1.5));
     set_boserif(0,1,9);
     push_stroke((140,-40)--(860,-40),
       (1.5,1.5)--(1.5,1.5));
     set_boserif(0,1,9))
    (kanji.bottomrad.four_ticks));
  expand_pbox;
enddef;

vardef kanji.grfour.nurture =
  push_pbox_toexpand("kanji.grfour.nurture");
  build_kanji.tb(460,230)
    (kanji.toprad.sheep)
    (kanji.grtwo.eat);
  replace_strokeq(-8)(subpath (xpart (get_strokep(-8) intersectiontimes
    get_strokep(-12)),infinity) of oldq);
  replace_strokep(-8)(subpath (xpart (oldp intersectiontimes
    get_strokep(-12)),infinity) of oldp);
  set_boserif(-8,0,whatever);
  replace_strokeq(-7)(subpath (xpart (get_strokep(-7) intersectiontimes
    get_strokep(-12)),infinity) of oldq);
  replace_strokep(-7)(subpath (xpart (oldp intersectiontimes
    get_strokep(-12)),infinity) of oldp);
  expand_pbox;
enddef;

vardef kanji.grfour.old_man =
  push_pbox_toexpand("kanji.grfour.old_man");
  kanji.radical.old_man(
    build_kanji.sscale(xyscaled (0.83,1.1) shifted (70,50))
      (kanji.radical.spoon));
  expand_pbox;
enddef;

vardef kanji.grfour.orders =
  push_pbox_toexpand("kanji.grfour.orders");
  kanji.radical.tent;
  push_stroke((200,280)--(780,280),(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,1,1);
  replace_strokep(0)(oldp shifted (0,30));
  push_stroke((470,310)--(470,-70),(1.6,1.6)--(1.5,1.5));  
  expand_pbox;
enddef;

vardef kanji.grfour.participate =
  push_pbox_toexpand("kanji.grfour.participate");
  build_kanji.level(build_kanji.tcb(600,10)(320,120)
    (build_kanji.sscale(xscaled 0.8)(kanji.radical.mu))
    (build_kanji.spread_legs(140)(kanji.grone.big))
    (build_kanji.sscale(rotated 24 shifted (-60,0))
       (kanji.rightrad.short_hair)));
  expand_pbox;
enddef;

vardef kanji.grfour.peace =
  push_pbox_toexpand("kanji.grfour.peace");
  build_kanji.dotcliff_enclose(build_kanji.tb(520,0)
      (tsu_xform(identity shifted (10,-270))
         (kanji.radical.pigs_snout))
      (kanji.radical.alt_water);
    replace_strokep(-4)((500,810)--subpath (1,infinity) of oldp));
  expand_pbox;
enddef;

vardef kanji.grfour.people =
  push_pbox_toexpand("kanji.grfour.people");
  push_stroke((800,480)--(800,730)--(250,730)--(250,-10),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  push_stroke((250,540)--(800,540),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((140,-30)..tension 1.2..(250,-10)..(510,70),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  push_stroke((250,320)--(870,326),(1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke(interpath(mincho,
      (500,537){dir 280}..tension 1.1..(760,0)..(850,0)..tension 1.5..
        (880,75)..(910,150),
      (500,537)..(660,150)..{right}(910,0){curl 1}..
        (870,75)..(870,150)),
    (1.6,1.6)--(1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(0.9,0.9));
  expand_pbox;
enddef;

vardef kanji.grfour.perfect =
  push_pbox_toexpand("kanji.grfour.perfect");
  build_kanji.tb(600,110)
    (kanji.radical.silly_hat)
    (build_kanji.sscale(xscaled 0.8)(kanji.grtwo.origin));
  expand_pbox;
enddef;

vardef kanji.grfour.pleasure =
  push_pbox_toexpand("kanji.grfour.pleasure");
  build_kanji.level(build_kanji.tb(190,-30)
    (kanji.toprad.pleasure)
    (build_kanji.sscale(xscaled 0.85)(kanji.grone.mouth)));
  expand_pbox;
enddef;

vardef kanji.grfour.plural =
  push_pbox_toexpand("kanji.grfour.plural");
  build_kanji.road_enclose(build_kanji.tb(560,0)
    (kanji.grone.earth)
    (kanji.grthree.sheep));
  expand_pbox;
enddef;

vardef kanji.grfour.portent =
  push_pbox_toexpand("kanji.grfour.portent");
  build_kanji.spread_legs(-110)(kanji.radical.legs);
  push_stroke((100,660)..tension 1.2..(200,570)..(250,500),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  push_stroke((330,390)..(210,300)..tension 1.2..(70,240),
    (1.2,1.2)--(1.6,1.6)--(1.9,1.9));
  push_stroke((860,670)..(810,570)..tension 1.2..(720,500),
    (1.2,1.2)--(1.6,1.6)--(1.9,1.9));
  push_stroke((630,410)..tension 1.2..(750,340)..(850,240),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grfour.rarity =
  push_pbox_toexpand("kanji.grfour.rarity");
  build_kanji.level(build_kanji.tb(600,20)
    (build_kanji.sscale(xscaled 0.9 shifted (60,0))
       (kanji.radical.cut_the_grass))
    (kanji.grfive.cloth));
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

vardef kanji.grfour.scenery =
  push_pbox_toexpand("kanji.grfour.scenery");
  build_kanji.level(build_kanji.tb(560,30)
    (kanji.grone.day)
    (kanji.grtwo.capital));
  expand_pbox;
enddef;

vardef kanji.grfour.season =
  push_pbox_toexpand("kanji.grfour.season");
  build_kanji.tb(340,100)
    (kanji.grnine.two_branch_tree;
     replace_strokep(-4)(subpath (0,0.78) of oldp))
    (path charsvp;
     build_kanji.sscale(xscaled 0.75)
       (kanji.grone.child;
        charsvp:=get_strokep(0));
     replace_strokep(0)(charsvp));
  expand_pbox;
enddef;

vardef kanji.grfour.section =
  push_pbox_toexpand("kanji.grfour.section");
  build_kanji.level(build_kanji.tb(480,190)
    (kanji.toprad.bamboo)
    (kanji.greight.instant));
  expand_pbox;
enddef;

vardef kanji.grfour.single =
  push_pbox_toexpand("kanji.grfour.single");
  build_kanji.level(build_kanji.tb(720,100)
    (kanji.toprad.alt_sparkle_three)
    (build_kanji.sscale(shifted (0,-30))(kanji.grtwo.neighbourhood);
     pop_stroke));
  expand_pbox;
enddef;

vardef kanji.grfour.soldier =
  push_pbox_toexpand("kanji.grfour.soldier");
  build_kanji.level(build_kanji.tb(200,0)
    (kanji.greight.knoll)
    (kanji.radical.eight));
  expand_pbox;
enddef;

vardef kanji.grfour.stomach =
  push_pbox_toexpand("kanji.grfour.stomach");
  build_kanji.level(build_kanji.tb(420,0)
    (kanji.grone.paddy)
    (kanji.bottomrad.moon));
  expand_pbox;
enddef;

vardef kanji.grfour.that_case =
  path mytp,mytq;
  push_pbox_toexpand("kanji.grfour.that_case");
  build_kanji.tb(190,-30)
    (build_kanji.level(build_kanji.lr(520,130)
       (kanji.grone.evening;
        mytp=get_strokep(0);
        mytq=get_strokeq(0);
        push_stroke(mytp shifted (-point 0.6 of mytp)
          scaled 0.65 shifted ((-90,-120)+point 0.6 of mytp),mytq);
        replace_strokep(-1)(oldp shifted (-point 0.6 of oldp)
          scaled 0.60 shifted ((40,50)+point 0.6 of oldp)))
        (kanji.grone.dog)))
    (kanji.bottomrad.four_ticks);
  expand_pbox;
enddef;

vardef kanji.grfour.ticket =
  push_pbox_toexpand("kanji.grfour.ticket");
  build_kanji.tb(480,-30)
    (kanji.toprad.ticket)
    (kanji.grfive.showing);
  expand_pbox;
enddef;

vardef kanji.grfour.tip =
  push_pbox_toexpand("kanji.grfour.tip");
  kanji.grfour.not_yet;
  replace_strokep(-3)((70,610)--(930,610));
  replace_strokep(-4)((160,360)--(840,360));
  expand_pbox;
enddef;

vardef kanji.grfour.together =
  push_pbox_toexpand("kanji.grfour.together");
  build_kanji.level(build_kanji.tb(290,46)
    (kanji.toprad.once_upon_a_time)
    (tsu_xform(identity shifted (20,0))(kanji.radical.eight)));
  expand_pbox;
enddef;

vardef kanji.grfour.urban_prefecture =
  push_pbox_toexpand("kanji.grfour.urban_prefecture");
  build_kanji.dotcliff_enclose(kanji.grfour.attach);
  expand_pbox;
enddef;

vardef kanji.grfour.utmost =
  push_pbox_toexpand("kanji.grfour.utmost");
  build_kanji.tb(500,-20)
    (build_kanji.sscale(xscaled 0.9)(kanji.grone.day))
    (build_kanji.lr(470,40)
       (kanji.grone.ear)
       (tsu_xform(identity yscaled 0.74 shifted (0,-40))
          (kanji.greight.otoh));
     replace_strokep(-7)
       (point 0 of oldp--(point 0 of oldp xscaled -1 shifted (1000,0))));
  expand_pbox;
enddef;

vardef kanji.grfour.vassal =
  push_pbox_toexpand("kanji.grfour.vassal");
  kanji.radical.box_on_side;
  push_stroke((500,800)--(500,550),(1.5,1.5)--(1.4,1.4));
  build_kanji.box((100,550),(750,270));
  replace_strokep(-1)(subpath (1.01,infinity) of oldp);
  replace_strokeq(-1)(subpath (1,infinity) of oldq);
  set_boserif(-1,2,whatever);
  push_stroke((500,270)--(500,-20),(1.5,1.5)--(1.4,1.4));
  expand_pbox;
enddef;

vardef kanji.grfour.warehouse =
  push_pbox_toexpand("kanji.grfour.warehouse");
  build_kanji.level(build_kanji.tb(400,320)
    (kanji.radical.tent)
    (build_kanji.sscale(xscaled 0.84)(kanji.radical.moon_flag);
     build_kanji.box((320,210),(810,-10))));
  expand_pbox;
enddef;

vardef kanji.grfour.wrap =
  push_pbox_toexpand("kanji.grfour.wrap");
  build_kanji.tb(360,480)
    (kanji.radical.wrapping)
    (save savep,selft;
     path savep;
     transform selft[];
     
     (145,0) transformed selft1=(230,0);
     (145,1000) transformed selft1=(230,1000);
     (900,0) transformed selft1=(720,0);
     (145,0) transformed selft2=(230,0);
     (145,1000) transformed selft2=(230,1000);
     (900,0) transformed selft2=(900,0);
     tsu_xform(selft1)
       (kanji.grsix.self;
        savep=get_strokep(0));
     replace_strokep(0)(savep transformed selft2));
  expand_pbox;
enddef;
