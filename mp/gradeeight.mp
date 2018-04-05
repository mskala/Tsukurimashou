%
% Grade Eight kanji used on more than one page
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

inclusion_lock(gradeeight);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.a_certain =
  push_pbox_toexpand("kanji.greight.a_certain");
  build_kanji.tb(440,10)
    (kanji.greight.sweet)
    (kanji.grone.wood);
  expand_pbox;
enddef;

vardef kanji.greight.acrid =
  push_pbox_toexpand("kanji.greight.acrid");
  build_kanji.level(build_kanji.tb(520,50)
    (kanji.radical.kettle_lid)
    (build_kanji.sscale(xyscaled (1.2,1.4) shifted (0,-140))
       (kanji.grthree.sheep);
     obstacktype[find_stroke(-3)]:=otnull;
     replace_strokep(0)((point 0 of oldp)--(500,-50))));
  expand_pbox;
enddef;

vardef kanji.greight.already =
  push_pbox_toexpand("kanji.greight.already");
  build_kanji.level(build_kanji.lr(460+60*mincho,60-30*mincho)
    (build_kanji.sscale(yscaled 0.92)(build_kanji.lift_skirt(300,80)
       (kanji.radical.alt_northeast)))
    (kanji.rightrad.crooked_heaven));
  expand_pbox;
enddef;

vardef kanji.greight.axe =
  push_pbox_toexpand("kanji.greight.axe");
  push_stroke((770,810)..tension 1.2..(550,740)..(250,700),
    (1.8,1.8)--(1.5,1.5)--(1,1));
  push_stroke((250,730){down}..(160,180)..(50,30),
    (1.6,1.6)--(1.3,1.3)--(1,1));
  set_boserif(0,0,10);
  push_stroke((250,500)--(870,500),(1.6,1.6)--(1.6,1.6)); 
  set_boserif(0,1,9);
  push_stroke((570,500)--(570,-20),(1.6,1.6)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.greight.boat =
  push_pbox_toexpand("kanji.greight.boat");
  kanji.leftrad.boat;
  replace_strokep(-1)((110,370)--(890,370));
  replace_strokeq(-1)((1.5,1.5)--(1.5,1.5));
  set_boserif(-1,1,9);
  expand_pbox;
enddef;

vardef kanji.greight.call =
  push_pbox_toexpand("kanji.greight.call");
  build_kanji.tb(420,30)
    (kanji.grtwo.sword)
    (kanji.grone.mouth);
  expand_pbox;
enddef;

vardef kanji.greight.chastity =
  push_pbox_toexpand("kanji.greight.chastity");
  build_kanji.level(build_kanji.tb(580,50)
    (kanji.grone.ten;
     replace_strokep(0)(subpath (0.5,0.8) of oldp shifted (5,40)))
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.greight.chinese_spear =
  push_pbox_toexpand("kanji.greight.chinese_spear");
  kanji.grthree.before;
  push_stroke(insert_nodes((500,480)..tension 1.1..
      (320,250)..{curl 1.2}(100,130))(0.3),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  expand_pbox;
enddef;

vardef kanji.greight.completion =
  push_pbox_toexpand("kanji.greight.completion");
  kanji.grone.child;
  pop_stroke;
  expand_pbox;
enddef;

vardef kanji.greight.compromise =
  push_pbox_toexpand("kanji.greight.compromise");
  build_kanji.level(build_kanji.tb(480,30)
    (kanji.toprad.paw)
    (kanji.grone.woman));
  expand_pbox;
enddef;

vardef kanji.greight.court =
  push_pbox_toexpand("kanji.greight.court");
  build_kanji.long_stride_enclose(false)
    (build_kanji.sscale(xscaled 0.84)
       (build_kanji.add_beret(kanji.grfour.gentleman;
        replace_strokep(-1)(oldp shifted (0,-70)))));
  expand_pbox;
enddef;

vardef kanji.greight.daybreak =
  push_pbox_toexpand("kanji.greight.daybreak");
  build_kanji.sscale(yscaled 1.05 shifted (0,-30))
    (build_kanji.level(build_kanji.tb(120,20)
      (kanji.grone.day)
      (kanji.grone.one)));
  expand_pbox;
enddef;

vardef kanji.greight.decapitate =
  push_pbox_toexpand("kanji.greight.decapitate");
  build_kanji.lr(480,20)
    (build_kanji.sscale(yscaled 0.94 shifted (0,30))
       (kanji.grone.wheel))
    (kanji.greight.axe);
  expand_pbox;
enddef;

vardef kanji.greight.demolish =
  push_pbox_toexpand("kanji.greight.demolish");
  build_kanji.tb(650,0)
    (kanji.grone.mountain)
    (build_kanji.lr(500,30)
     (kanji.grone.moon)
     (kanji.grone.moon));
  expand_pbox;
enddef;

vardef kanji.greight.dice =
  push_pbox_toexpand("kanji.greight.dice");
  build_kanji.level(build_kanji.tb(540,40)
    (kanji.toprad.paw)
    (kanji.grone.wood));
  expand_pbox;
enddef;

vardef kanji.greight.dipper =
  push_pbox_toexpand("kanji.greight.dipper");
  push_stroke((600,810)--(600,-70),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((220,720)..tension 1.2..(310,660)..(400,580),
    (1,1)--(1.3,1.3)--(1.9,1.9));
  set_bosize(0,94);
  push_stroke((150,480)..tension 1.2..(250,420)..(340,340),
    (1,1)--(1.3,1.3)--(1.9,1.9));
  set_bosize(0,94);
  push_stroke((100,150)--(900,280),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.greight.dismiss =
  push_pbox_toexpand("kanji.greight.dismiss");
  build_kanji.attach_fishhook(0.8)(kanji.grtwo.big_brother);
  push_stroke(
    (point 1.5 of get_strokep(-5))--(point 0.5 of get_strokep(-4)),
    (1.6,1.6)--(1.5,1.5));
  set_bosize(0,get_bosize(-5));
  expand_pbox;
enddef;

vardef kanji.greight.divination =
  push_pbox_toexpand("kanji.greight.divination");
  build_kanji.level(build_kanji.tb(420,100)
    (kanji.grone.ten;
     replace_strokep(0)(subpath (0.5,1) of oldp))
    (build_kanji.sscale(xscaled 0.9)(kanji.grone.mouth)));
  expand_pbox;
enddef;

vardef kanji.greight.everybody =
  push_pbox_toexpand("kanji.greight.everybody");
  build_kanji.level(build_kanji.tb(420,0)
    (kanji.grfive.compare)
    (kanji.grone.white));
  expand_pbox;
enddef;

vardef kanji.greight.exhibit =
  push_pbox_toexpand("kanji.greight.exhibit");
  build_kanji.level(build_kanji.tb(440,0)
    (kanji.grone.mouth)
    (kanji.grone.king));
  expand_pbox;
enddef;

vardef kanji.greight.fulfill =
  push_pbox_toexpand("kanji.greight.fulfill");
  build_kanji.level(build_kanji.tb(650,70)
    (kanji.radical.kettle_lid)
    (kanji.grnine.permission));
  expand_pbox;
enddef;

vardef kanji.greight.furthermore =
  push_pbox_toexpand("kanji.greight.furthermore");
  push_stroke((280,-30)--(280,760)--(720,760)--(720,-30),
    (1.5,1.5)--(1.7,1.7)--(1.7,1.7)--(1.5,1.5));
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  push_stroke((280,510)--(720,510),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((280,240)--(720,240),
    (1.4,1.4)--(1.4,1.4));
  push_stroke((100,-30)--(900,-30),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.greight.give =
  push_pbox_toexpand("kanji.greight.give");
  push_stroke((330,710)--(750,710),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((345,790)..tension 1.2..(290,550)..(250,440),
    (1.7,1.7)--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((get_strokep(0) intersectionpoint ((0,500)--(1000,500)))--
      (700,500)..tension 1.4..(660,210)..(530,-10)..{curl 0.1}(340,0),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5)--(1.7,1.7)--(1.8,1.8));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((100,230)--(900,230),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

% this actually means sort of generically "good", but it's "uma" in
% "umami" and needs to be distinguished from other vague kanji
vardef kanji.greight.glutamate =
  push_pbox_toexpand("kanji.greight.glutamate");
  build_kanji.level(build_kanji.tb(410,-50)
    (kanji.radical.spoon)
    (kanji.grone.day));
  expand_pbox;
enddef;

vardef kanji.greight.good_luck =
  push_pbox_toexpand("kanji.greight.good_luck");
  build_kanji.level(build_kanji.tb(440,-50)
    (kanji.grfour.gentleman)
    (kanji.grone.mouth));
  expand_pbox;
enddef;

vardef kanji.greight.great =
  push_pbox_toexpand("kanji.greight.great");
  build_kanji.tb(280,-30)
    (build_kanji.tb(540,130)
       (build_kanji.sscale(xscaled 0.75)(kanji.toprad.sparkle_two))
       (kanji.grone.paddy))
    (build_kanji.sscale(xscaled 0.88)(kanji.grone.day));
  expand_pbox;
enddef;

vardef kanji.greight.guy =
  push_pbox_toexpand("kanji.greight.guy");
  build_kanji.lr(380,80)
    (kanji.leftrad.woman)
    (kanji.greight.otoh);
  expand_pbox;
enddef;

vardef kanji.greight.head_of_household =
  push_pbox_toexpand("kanji.greight.head_of_household");
  build_kanji.level(build_kanji.tb(650,-45)
    (kanji.radical.kettle_lid)
    (build_kanji.tb(550,0)
       (build_kanji.sscale(xscaled 0.75)(kanji.grone.mouth))
       (build_kanji.tb(450,90)
          (build_kanji.sscale(yscaled 1.1)(kanji.radical.conservative_hat))
          (build_kanji.sscale(xscaled 0.75)(kanji.grthree.thumbtack)))));
  expand_pbox;
enddef;

vardef kanji.greight.hill =
  push_pbox_toexpand("kanji.greight.hill");
  kanji.radical.gmm;
  build_kanji.sscale(xyscaled (0.6,0.7))
    (build_kanji.level(build_kanji.tb(480,110)
       (kanji.toprad.sparkle_two)
       (kanji.grone.mountain;
        set_boserif(0,0,whatever);
        push_stroke((120,780)--(880,780),(1.6,1.6)--(1.6,1.6));
        set_boserif(0,1,9))));
  expand_pbox;
enddef;

vardef kanji.greight.how_much =
  push_pbox_toexpand("kanji.greight.how_much");
  build_kanji.level(
    build_kanji.tb(440,100)
      (build_kanji.lr(520,-80)
         (kanji.radical.short_thread)
         (kanji.radical.short_thread))
      (kanji.radical.ceremony);
    replace_strokep(-1)
      (oldp shifted (-900,60) xscaled 0.9 shifted (900,-60));
    replace_strokep(-1)((500,840){down}...subpath (1,infinity) of oldp);
    push_stroke((780,190)..tension 1.2..(720,110)..(530,-40),
      (1.6,1.6)--(1.4,1.4)--(1.2,1.2));
    build_kanji.sscale(xyscaled (0.42,0.35) shifted (-220,-280))
      (kanji.leftrad.alt_person);
  );
  expand_pbox;
enddef;

vardef kanji.greight.inflammation =
  push_pbox_toexpand("kanji.greight.inflammation");
  build_kanji.level(build_kanji.tb(420,50)
    (kanji.leftrad.fire)
    (kanji.grone.fire));
  expand_pbox;
enddef;

vardef kanji.greight.insect =
  push_pbox_toexpand("kanji.greight.insect");
  build_kanji.level(build_kanji.tb(420,-20)
    (kanji.grone.day)
    (kanji.grfive.compare));
  expand_pbox;
enddef;

vardef kanji.greight.instant =
  push_pbox_toexpand("kanji.greight.instant");
  build_kanji.level(build_kanji.lr(520,0)
    (kanji.radical.alt_northeast)
    (build_kanji.sscale(shifted (0,-28))(kanji.radical.seal)));
  expand_pbox;
enddef;

vardef kanji.greight.knoll =
  push_pbox_toexpand("kanji.greight.knoll");
  push_stroke((770,810)..tension 1.2..(580,740)..(300,700),
    (1.8,1.8)--(1.5,1.5)--(1,1));
  push_stroke((300,730)--(300,20),
    (1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((300,400)--(860,400),(1.6,1.6)--(1.6,1.6)); 
  set_boserif(0,1,9);
  push_stroke((590,400)--(590,20),(1.6,1.6)--(1.5,1.5));
  push_stroke((120,20)--(880,20),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.greight.mediate =
  push_pbox_toexpand("kanji.greight.mediate");
  build_kanji.level(
    kanji.radical.tent;
    pop_stroke;
    tsu_xform(identity yscaled 0.63)(kanji.radical.aitch);
    obstacktype[find_whatever(otstroke,-2)]:=otnull;
  );
  expand_pbox;
enddef;

vardef kanji.greight.mediocre =
  push_pbox_toexpand("kanji.greight.mediocre");
  kanji.radical.windy;
  push_stroke((370,550)..tension 1.2..(490,420)..(550-20*mincho,280),
    (0.9,0.9)--(1.5,1.5)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.greight.melancholy =
  push_pbox_toexpand("kanji.greight.melancholy");
  build_kanji.level(build_kanji.tb(400,115)
    (build_kanji.tb(260,193)
       (kanji.toprad.summer)
       (kanji.radical.conservative_hat))
    (build_kanji.tb(480,-40)
       (build_kanji.sscale(xscaled 0.8)(kanji.bottomrad.heart))
       (kanji.radical.winter)));
  expand_pbox;
enddef;

vardef kanji.greight.night_watch =
  push_pbox_toexpand("kanji.greight.night_watch");
  push_stroke((90,760)--(910,760),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.box((220,610),(780,310));
  push_stroke((220,460)--(780,460),(1.5,1.5)--(1.5,1.5));
  push_stroke((500,760)--(500,300){down}..(370,70)..{curl 0.5}(90,-40),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke((310,260)..tension 1.2..(640,40)..(840,-10),
    (0.9,0.9)--(1.5,1.5)--(2,2));
  expand_pbox;
enddef;

vardef kanji.greight.nun =
  push_pbox_toexpand("kanji.greight.nun");
  build_kanji.level(
    kanji.radical.flag;
    build_kanji.sscale(xyscaled (0.7,0.5) shifted (80,-170))
      (kanji.radical.spoon));
  expand_pbox;
enddef;

vardef kanji.greight.officer =
  push_pbox_toexpand("kanji.greight.officer");
  push_stroke((90,670)--(910,670),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.box((220,540),(780,340));
  push_stroke((500,810)--(500,300){down}..(370,70)..{curl 0.5}(90,-40),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke((340,260)..tension 1.2..(670,40)..(840,-10),
    (0.9,0.9)--(1.5,1.5)--(2,2));
  expand_pbox;
enddef;

vardef kanji.greight.otoh =
  push_pbox_toexpand("kanji.greight.otoh");
  push_stroke(
    (200,780)--(760,780)..tension 1.2..(550,340)..(40,-40),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(0.9,0.95));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke((280,780)..tension 1.2..(520,270)..(880,-30),
    (0.9,0.9)--(1.4,1.4)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.greight.precept =
  push_pbox_toexpand("kanji.greight.precept");
  kanji.radical.tasselled_spear;
  build_kanji.sscale(xyscaled (0.4,0.54) shifted (-250,-130))
    (kanji.radical.aitch;
     replace_strokep(0)(subpath (0,0.85) of oldp));
  expand_pbox;
enddef;

vardef kanji.greight.prefix_sub =
  push_pbox_toexpand("kanji.greight.prefix.sub");
  push_stroke((80,790)--(920,790),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((400,790)--(400,0),(1.6,1.6)--(1.5,1.5));
  push_stroke((600,790)--(600,0),(1.6,1.6)--(1.5,1.5));
  build_kanji.box((180,560),(820,290));
  push_stroke((80,0)--(920,0),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.greight.prostrate =
  push_pbox_toexpand("kanji.greight.prostrate");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.dog);
  expand_pbox;
enddef;

vardef kanji.greight.punish =
  push_pbox_toexpand("kanji.greight.punish");
  build_kanji.level(build_kanji.lr(560,10)
    (kanji.radical.topped_aitch)
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

vardef kanji.greight.reach =
  push_pbox_toexpand("kanji.greight.reach");
  begingroup
    save x,y;
    numeric x[],y[];
    x1=140;
    x2=680;
    x4=540;
    y1=y2=780;
    y4=460;
    z3=0.4[z4,z2]+mincho*(30,0);
    z5=(0.3-0.5*mincho)[z4,z2];
    push_stroke(z1--z2..tension 1.2..z3..z5,
      (1.6,1.6)--(1.6,1.6)--(1.6-0.1*mincho,1.6-0.1*mincho)--
        (1.6-0.2*mincho,1.6-0.2*mincho));
    set_boserif(0,1,4);
    set_botip(0,1,0);
    x7=0;
    x9=880;
    x10=660;
    x11=280;
    y7=y9=y4;
    y10=110;
    y11=-70;
    z6=point 2.2 of get_strokep(0);
    z8=(z7--z9) intersectionpoint (get_strokep(0)--((-1)[z4,z2]));
    push_stroke(z6--z8--z9..tension 1.2..z10..z11,
      (1.6-0.5*mincho,1.6-0.5*mincho)--(1.5-0.1*mincho,1.5-0.1*mincho)--
      (1.6,1.6)--(1.4,1.4)--(1,1));
    set_boserif(0,2,4);
    set_botip(0,1,1);
    set_botip(0,2,0);
  endgroup;
  push_stroke((point 0.4 of get_strokep(-1))..tension 1.2..
      (240,290)..(60,-60),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke((point 0.08 of get_strokep(0))..tension 1.2..
      (480,270)..(870,-60),
    (1.2,1.2)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.greight.resemblance =
  push_pbox_toexpand("kanji.greight.resemblance");
  build_kanji.tb(620,77)
    (kanji.toprad.sparkle_three)
    (kanji.bottomrad.moon);
  expand_pbox;
enddef;

vardef kanji.greight.righteousness =
  push_pbox_toexpand("kanji.greight.righteousness");
  build_kanji.tb(420,-40)
    (kanji.grone.day)
    (kanji.grnine.animal_counter;
     replace_strokep(-4)(subpath (0,1) of oldp);
     set_botip(-4,1,whatever);
     replace_strokeq(-4)((1.6,1.6)--(1.6,1.6));
     set_boserif(-4,1,9));
  expand_pbox;
enddef;

vardef kanji.greight.seedling =
  push_pbox_toexpand("kanji.greight.seedling");
  build_kanji.tb(600,40)
    (kanji.toprad.grass)
    (kanji.grone.paddy);
  expand_pbox;
enddef;

vardef kanji.greight.ship_counter =
  push_pbox_toexpand("kanji.greight.ship_counter");
  build_kanji.tb(320,-30)
    (kanji.radical.old_bird)
    (kanji.greight.otoh);
  expand_pbox;
enddef;

vardef kanji.greight.spine =
  push_pbox_toexpand("kanji.greight.spine");
  build_kanji.box((270,800),(730,500));
  push_stroke((480,495)..(450,360)..(400,275),
    (1.7,1.7)--(1.4,1.4)--(1,1));
  build_kanji.box((200,270),(800,0));
  expand_pbox;
enddef;

vardef kanji.greight.strange =
  push_pbox_toexpand("kanji.greight.strange");
  build_kanji.tb(420,0)
    (build_kanji.sscale(xscaled 0.78)(kanji.leftrad.big))
    (kanji.grfive.passable);
  expand_pbox;
enddef;

vardef kanji.greight.strike =
  push_pbox_toexpand("kanji.greight.strike");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.radical.tasselled_spear);
  expand_pbox;
enddef;

vardef kanji.greight.substitute =
  push_pbox_toexpand("kanji.greight.substitute");
  build_kanji.tb(360,-10)
    (build_kanji.lr(480,-50*mincho)
       (kanji.leftrad.husband)
       (kanji.grfour.husband))
    (kanji.grone.day);
  expand_pbox;
enddef;

vardef kanji.greight.sushi_counter =
  push_pbox_toexpand("kanji.greight.sushi_counter");
  build_kanji.tb(520,-20)
    (build_kanji.sscale(xscaled 0.96 shifted (30,0) slanted -0.06)
       (kanji.rare.penetrate))
    (kanji.grone.shell);
  expand_pbox;
enddef;

vardef kanji.greight.sweet =
  push_pbox_toexpand("kanji.greight.sweet");
  kanji.grnine.twenty;
  push_stroke((320,222)--(680,222),(1.5,1.5)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.greight.tail =
  push_pbox_toexpand("kanji.greight.tail");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.79,0.63) shifted (40,-130))
      (kanji.grtwo.hair));
  expand_pbox;
enddef;

vardef kanji.greight.third =
  push_pbox_toexpand("kanji.greight.third");
  push_stroke((80,800)--(920,800),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  kanji.grtwo.home;
  set_boserif(-2,0,whatever);
  expand_pbox;
enddef;

vardef kanji.greight.tin_can =
  push_pbox_toexpand("kanji.greight.tin_can");
  kanji.grtwo.noon;
  replace_strokep(-1)((500,640)--(500,0));
  replace_strokep(0)(oldp shifted (0,20));
  build_kanji.cup((190,230),(810,0));
  expand_pbox;
enddef;

vardef kanji.greight.towel =
  push_pbox_toexpand("kanji.greight.towel");
  build_kanji.sscale(xyscaled (0.9,0.6) shifted (0,-50))
    (kanji.radical.gmm);
  push_stroke((500,790)--(500,-60),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.greight.tribute =
  push_pbox_toexpand("kanji.greight.tribute");
  build_kanji.level(build_kanji.tb(540,-20)
    (kanji.grtwo.craft)
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.greight.tusk =
  push_pbox_toexpand("kanji.greight.tusk");
  kanji.radical.tusk;
  replace_strokep(-4)((310,480)--(310,780)--(830,780));
  replace_strokeq(-4)((1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_boserif(-4,1,4);
  set_boserif(-4,2,9);
  set_botip(-4,1,1);
  obstacktype[find_whatever(otstroke,-2)]:=otnull;
  expand_pbox;
enddef;

vardef kanji.greight.undergo =
  push_pbox_toexpand("kanji.greight.undergo");
  build_kanji.level(build_kanji.tb(650,-20)
    (kanji.radical.kettle_lid)
    (build_kanji.tb(550,-40)
      (build_kanji.sscale(xscaled 0.9)(kanji.grone.mouth))
      (kanji.grone.child)));
  expand_pbox;
enddef;

vardef kanji.greight.well =
  push_pbox_toexpand("kanji.greight.well");
  kanji.radical.aitch;
  replace_strokep(-2)(oldp shifted (0,-140));
  push_stroke((130,530)--(870,530),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.greight.wizard =
  push_pbox_toexpand("kanji.greight.wizard");
  build_kanji.lr(300,0)
    (kanji.leftrad.person)
    (kanji.grone.mountain);
  expand_pbox;
enddef;
