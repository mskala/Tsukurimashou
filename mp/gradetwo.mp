%
% Grade Two kanji used on more than one page
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

inclusion_lock(gradetwo);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.answer =
  push_pbox_toexpand("kanji.grtwo.answer");
  build_kanji.level(build_kanji.tb(540,220)
    (kanji.toprad.bamboo)
    (kanji.grtwo.join));
  expand_pbox;
enddef;

vardef kanji.grtwo.arrow =
  push_pbox_toexpand("kanji.grone.arrow");
  push_stroke((300,810)..tension 1.2..(220,600)..(110,480),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  set_boserif(0,0,10);
  tsu_xform(identity yscaled (400/360))(kanji.grfour.husband);
  replace_strokep(-3)((100,680)--(780,680));
  replace_strokep(-3)(subpath
    (0.01+xpart (oldp intersectiontimes get_strokep(-4)),1) of oldp);
  replace_strokep(-1)(subpath
    (xpart (oldp intersectiontimes get_strokep(-3)),infinity) of oldp);
  set_boserif(-1,0,whatever);
  expand_pbox;
enddef;

vardef kanji.grtwo.autumn =
  push_pbox_toexpand("kanji.grtwo.autumn");
  build_kanji.lr(450,120)
    (kanji.leftrad.two_branch_tree)
    (kanji.grone.fire);
  expand_pbox;
enddef;

vardef kanji.grtwo.before =
  tsu_xform(identity yscaled (780/720))
  (build_kanji.level(build_kanji.tb(570,0)
    (build_kanji.sscale(xscaled 0.6)(kanji.toprad.sparkle_two);
     push_stroke((70,120)--(930,120),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,0,whatever);
     set_boserif(0,1,9))
    (build_kanji.lr(560,30)
       (kanji.bottomrad.moon)
       (kanji.rightrad.sword))));
enddef;

vardef kanji.grtwo.big_brother =
  push_pbox_toexpand("kanji.grtwo.big_brother");
  build_kanji.level(build_kanji.tb(440,110)
    (kanji.grone.mouth)
    (kanji.radical.legs));
  expand_pbox;
enddef;

vardef kanji.grtwo.bird =
  push_pbox_toexpand("kanji.grtwo.bird");
  push_stroke((490,850){curl 0.1}..(440,790)..(380,730),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke((180,180)--(180,730)--(690,730)--(690,420),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  set_botip(0,1,1);
  set_botip(0,2,1);
  push_stroke((180,600)--(690,600),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((180,460)--(690,460),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((180,340)--(840,340),
    (1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((200,220)--(830,220){dir 268}..(760,-10)..{curl 0.2}(590,-20),
    (1.5,1.5)--(1.5,1.5)--(1.5,1.5)--(1.5,1.5)--(1.4,1.4)--(1.2,1.2));
  replace_strokep(0)(insert_nodes(oldp)((length oldp)-0.5));
  set_boserif(0,1,4);
  set_botip(0,1,1);
  push_stroke((180,130)..tension 1.2..(150,60)..(80,-50),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  push_stroke((340,130)..tension 1.2..(330,50)..(300,-20),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  push_stroke((520,150)..tension 1.2..(510,60)..(490,10),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  push_stroke((680,170)..tension 1.2..(680,90)..(670,50),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.grtwo.bow =
  push_pbox_toexpand("kanji.grtwo.bow");
  push_stroke((140,740)--(750,740)--(750,440),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((250,500)--(750,500),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((255,535-15*mincho)..tension 1.2..(220,350)..(170,240),
    (1.7,1.7)--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((get_strokep(0) intersectionpoint ((0,300)--(1000,300)))--
      (820,300)..tension 1.7..(780,150)..(650,-10)..{curl 0.1}(450,0),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5)--(1.7,1.7)--(1.8,1.8));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  expand_pbox;
enddef;

vardef kanji.grtwo.capital =
  push_pbox_toexpand("kanji.grtwo.capital");
  build_kanji.level(build_kanji.tb(650,-20)
    (kanji.radical.kettle_lid)
    (build_kanji.tb(500,110)
      (build_kanji.sscale(xscaled 0.82)(kanji.grone.mouth))
      (kanji.grone.small)));
  set_boserif(0,0,whatever);
  expand_pbox;
enddef;

% can't use "stop," it is reserved by Metafont
vardef kanji.grtwo.cease =
  push_pbox_toexpand("kanji.grtwo.cease");
  push_stroke((500,710)--(500,40),(1.6,1.6)--(1.5,1.5));
  push_stroke((500,390)--(840,390),(1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((80,40)--(920,40),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((270,510)--(270,40),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.grtwo.chamber =
  push_pbox_toexpand("kanji.grtwo.chamber");
  build_kanji.tb(600,150)
    (kanji.radical.silly_hat)
    (build_kanji.level(build_kanji.tb(420,100)
       (build_kanji.sscale(scaled 0.7)(kanji.radical.mu_bar))
       (kanji.grone.earth)));
  expand_pbox;
enddef;

vardef kanji.grtwo.circle =
  push_pbox_toexpand("kanji.grtwo.circle");
  kanji.grone.nine;
  push_stroke((170,360)..(340,310)..(480,170),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.grtwo.cloud =
  push_pbox_toexpand("kanji.grtwo.cloud");
  build_kanji.tb(300,50)
    (kanji.toprad.rain)
    (kanji.grnine.declaim);
  expand_pbox;
enddef;

vardef kanji.grtwo.colour =
  push_pbox_toexpand("kanji.grtwo.colour");
  build_kanji.attach_fishhook(0.75)
    (tsu_xform(identity shifted (50,0))(kanji.grnine.tomoe));
  expand_pbox;
enddef;

vardef kanji.grtwo.come =
  push_pbox_toexpand("kanji.grtwo.come");
  push_stroke((500,780)--(500,0),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((130,640)--(870,640),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((210,580)..tension 1.2..(260,520)..(330,410),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3));
  set_boserif(0,0,10);
  push_stroke((780,590)..tension 1.2..(720,490)..(660,400),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3));
  set_boserif(0,0,10);
  push_stroke((80,350)--(920,350),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,350)..(250,100)..(80,0),
    (1.6,1.6)..(1.3,1.3)..(0.9,0.9));
  push_stroke((500,350)..(750,100)..(870,10),
    (1.1,1.1)..(1.5,1.5)..(1.7,1.7));
  for i=-6 upto 0: set_bosize(i,94); endfor;
  expand_pbox;
enddef;

vardef kanji.grtwo.consider =
  push_pbox_toexpand("kanji.grtwo.consider");
  kanji.radical.old_man(
    build_kanji.sscale(xyscaled (0.8,1.5) shifted (60,220))
      (push_stroke((250,500)..tension 1.2..(550,520)..(780,550+30*mincho),
         (1.5,1.5)--(1.5,1.5)--(1.9,1.9));
       push_stroke((255,535-15*mincho)..tension 1.2..(220,350)..(170,240),
         (1.7,1.7)--(1.6,1.6)--(1.6,1.6));
       set_boserif(0,0,10);
       push_stroke((get_strokep(0) intersectionpoint ((0,300)--(1000,300)))--
           (820,300)..tension 1.7..(780,150)..(650,-10)..{curl 0.1}(450,0),
         (1.6,1.6)--(1.6,1.6)--(1.5,1.5)--(1.7,1.7)--(1.8,1.8));
       set_botip(0,1,1);
       set_boserif(0,1,4)));
  expand_pbox;
enddef;

vardef kanji.grtwo.corner =
  push_pbox_toexpand("kanji.grtwo.corner");
  build_kanji.attach_fishhook(0.8)(
    build_kanji.sscale(xscaled 0.84)(kanji.grtwo.job);
    replace_strokep(-2)((500,760)--(500,290)));
  expand_pbox;
enddef;

vardef kanji.grtwo.country =
  push_pbox_toexpand("kanji.grtwo.country");
  kanji.radical.box;
  build_kanji.sscale(scaled 0.75)(kanji.grone.ball);
  expand_pbox;
enddef;

vardef kanji.grtwo.cow =
  push_pbox_toexpand("kanji.grtwo.cow");
  push_stroke((280,720)..tension 1.2..(240,580)..(100,360),
    (1.7,1.7)--(1.4,1.4)--(0.9,0.9));
  set_boserif(0,0,10);
  push_stroke(((((0,540)--(1000,540)) intersectionpoint
      get_strokep(0))+(12,0))--(850-30*mincho,540),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((520,780)--(520,-60),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((110,280)--(910-30*mincho,280),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grtwo.craft =
  push_pbox_toexpand("kanji.grtwo.craft");
  kanji.grone.two;
  push_stroke((point 0.5 of get_strokep(-1))--(point 0.5 of get_strokep(0)),
    (1.6,1.6)--(1.6,1.6));
  expand_pbox;
enddef;

vardef kanji.grtwo.direction =
  push_pbox_toexpand("kanji.grtwo.direction");
  build_kanji.level(
    tsu_xform(identity yscaled (620/780))
      (kanji.grtwo.myriad);
    push_stroke((500,790)..(500,620),(1.6,1.6)--(1.5,1.5));
    set_boserif(0,0,10);
  );
  expand_pbox;
enddef;

vardef kanji.grtwo.door =
  push_pbox_toexpand("kanji.grtwo.door");
  tsu_xform(identity yscaled (600/730))(kanji.radical.flag);
  push_stroke((120,760)--(880,760),(1.6,1.6));
  set_boserif(0,1,9);
  set_bosize(0,95);
  expand_pbox;
enddef;

vardef kanji.grtwo.east =
  push_pbox_toexpand("kanji.grtwo.east");
  kanji.grfour.bundle;
  push_stroke((210,450)--(790,450),(1.5,1.5)--(1.5,1.5));
  set_bosize(0,get_bosize(-1));
  expand_pbox;
enddef;

vardef kanji.grtwo.eat =
  push_pbox_toexpand("kanji.grtwo.eat");
  build_kanji.level(
    tsu_xform(identity yscaled 0.85 shifted (0,150))
      (kanji.radical.tent);
    pop_stroke;
    tsu_xform(identity yscaled 0.8)(kanji.grfour.good));
  expand_pbox;
enddef;

vardef kanji.grtwo.evening =
  push_pbox_toexpand("kanji.grtwo.evening");
  build_kanji.level(build_kanji.tb(650,0)
    (kanji.radical.kettle_lid)
    (build_kanji.lr(300,20)
      (kanji.leftrad.person)
      (kanji.radical.winter;
       push_stroke(
         (430,600)..tension 1.2..(480,570)..(510,520),
         (1.1,1.1)--(1.4,1.4)--(1.6,1.6)))));
  set_bosize(0,73);
  expand_pbox;
enddef;

vardef kanji.grtwo.every =
  push_pbox_toexpand("kanji.grtwo.every");
  tsu_xform(identity yscaled (550/750))
    (kanji.radical.mother_stroked);
  push_stroke((280,810)..tension 1.2..(160,600)..(50,500),
    (1.7,1.7)--(1.5,1.5)--(1.2,1.2));
  set_boserif(0,0,10);
  set_bosize(0,90);
  push_stroke((get_strokep(0) intersectionpoint ((0,730)--(1000,730)))--
      (880,730),
    (1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef kanji.grtwo.father =
  push_pbox_toexpand("kanji.grtwo.father");
  build_kanji.level(build_kanji.tb(700,300)
    (tsu_xform(identity shifted (0,-180))(kanji.radical.eight))
    (push_stroke((300,600)..(500,200)..(900,0),
       (1.3,1.3)--(1.5,1.5)--(1.7,1.7));
     push_stroke((700,600)..(500,200)..(70,-30),
       (1.6,1.6)--(1.5,1.5)--(1,1));
     set_boserif(0,0,10);
    ));
  expand_pbox;
enddef;

vardef kanji.grtwo.feather =
  push_pbox_toexpand("kanji.grtwo.feather");
  build_kanji.lr(480,-20)
    (kanji.grtwo_helper.feather)
    (kanji.grtwo_helper.feather);
  expand_pbox;
enddef;

vardef kanji.grtwo.half =
  push_pbox_toexpand("kanji.grtwo.half");
  build_kanji.level(begingroup
    save saved_path,mytr;
    path saved_path;
    transform mytr;
    xpart mytr=xypart mytr=yxpart mytr=0;
    xxpart mytr=1;
    (500,160) transformed mytr=(500,540);
    (500,780) transformed mytr=(500,780);
    tsu_xform(mytr)
      (kanji.toprad.sparkle_three;saved_path:=get_strokep(0));
    replace_strokep(0)(saved_path);
    push_stroke((170,460)--(830,460),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
    push_stroke((120,260)--(880,260),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
  endgroup);
  expand_pbox;
enddef;

vardef kanji.grtwo_helper.feather =
  push_pbox_toexpand("kanji.grtwo_helper.feather");
  push_stroke((60,720)--(410,720),(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  replace_strokep(0)(oldp xscaled 2);
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((200,580)..tension 1.2..(370,480)..(460,400),
    (1,1)--(1.3,1.3)--(1.6,1.6));
  push_stroke((670,330)..tension 1.2..(380,190)..(250,150),
    (1,1)--(1.6,1.6)--(1.9,1.9));
  expand_pbox;
enddef;

vardef kanji.grtwo.field =
  push_pbox_toexpand("kanji.grtwo.field");
  build_kanji.level(build_kanji.cliff_enclose(
    build_kanji.tb(380,67)
      (kanji.grone.white)
      (kanji.grone.small)));
  begingroup
    save myxf;
    transform myxf;
    point 2 of get_strokep(-3) transformed myxf=point 2 of get_strokep(-3);
    ypart (point 0 of get_strokep(-3) transformed myxf)=760;
    xpart myxf=yxpart myxf=0;
    xxpart myxf=1;
    replace_strokep(-3)(oldp transformed myxf);
  endgroup;
  set_boserif(-3,0,whatever);
  set_boserif(-1,0,whatever);
  expand_pbox;
enddef;

vardef kanji.grtwo.fish =
  push_pbox_toexpand("kanji.grtwo.fish");
  build_kanji.level(build_kanji.tb(190,0)
    (build_kanji.attach_fishhook(0.7)(kanji.grone.paddy))
    (kanji.bottomrad.four_ticks));
  expand_pbox;
enddef;

vardef kanji.grtwo.friend =
  push_pbox_toexpand("kanji.grtwo.friend");
  build_kanji.lean_to((360,-30));
  push_stroke(
    ((50,0)+(get_strokep(0) intersectionpoint ((0,460)--(1000,460))))--
      (760,460)..tension 1.2..(550,140)..(170,-50),
    (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(0.9,0.9));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke((380,460)..tension 1.2..(570,130)..(880,-30),
    (0.9,0.9)--(1.4,1.4)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grtwo.fun =
  push_pbox_toexpand("kanji.grtwo.fun");
  build_kanji.level(
    build_kanji.tb(400,20)
      (build_kanji.sscale(xscaled 0.6)(kanji.grone.white))
      (kanji.grone.wood));
  push_stroke((80,720)..tension 1.2..(170,650)..(210,600),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  set_bosize(0,80);
  push_stroke((230,510)..(160,440)..tension 1.2..(70,390),
    (1.1,1.1)--(1.4,1.4)--(1.9,1.9));
  set_bosize(0,80);
  push_stroke(get_strokep(-1) shifted ((760,520)-point 0 of get_strokep(-1)),
    get_strokeq(-1));
  set_bosize(0,80);
  push_stroke(get_strokep(-1) shifted ((760,610)-point 2 of get_strokep(-1)),
    get_strokeq(-1));
  set_bosize(0,80);
  expand_pbox;
enddef;

vardef kanji.grtwo.gate =
  push_pbox_toexpand("kanji.grtwo.gate");
  push_stroke((150,-50)--(150,30)--(150,780)--(430,780)--(430,450),
    (1.5,1.5)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_boserif(0,2,4);
  set_boserif(0,3,4);
  push_stroke((150,640)--(430,640),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((150,490)--(430,490),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((570,450)--(570,780)--(850,780),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  push_stroke((570,640)--(850,640),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((570,490)--(850,490),
    (1.5,1.5)--(1.5,1.5));
  for i=-5 upto 0: set_bosize(i,90); endfor;
  expand_pbox;
enddef;

vardef kanji.grtwo.go =
  push_pbox_toexpand("kanji.grtwo.go");
  build_kanji.harmonic(240,0.86,50)
    (build_kanji.level(build_kanji.lr(380,-40)
      (kanji.leftrad.person)
      (kanji.grthree.thumbtack)));
  replace_strokep(-4)(oldp shifted (50,0));
  expand_pbox;
enddef;

vardef kanji.grtwo.hair =
  push_pbox_toexpand("kanji.grtwo.hair");
  build_kanji.level(build_kanji.add_beret(
    push_stroke((450,700),(1.6,1.6));
    build_kanji.add_ltail(0);
    build_kanji.sscale(yscaled 0.4 rotated 5)(kanji.grone.two)));
  expand_pbox;
enddef;

vardef kanji.grtwo.heart =
  push_pbox_toexpand("kanji.grtwo.heart");
  tsu_xform(identity shifted (-100,0))
    (push_stroke((450,600),(1.6,1.6));
     build_kanji.add_ltail(0));
  set_boserif(0,0,10);
  push_stroke((180,480)..tension 1.2..(130,280)..(60,150),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  push_stroke((370,800)..tension 1.2..(540,690)..(650,580),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  push_stroke((660,450)..tension 1.2..(860,270)..(930,170),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grtwo.high =
  push_pbox_toexpand("kanji.grtwo.high");
  build_kanji.level(build_kanji.tcb(650,-45)(400,-45)
    (kanji.radical.kettle_lid)
    (build_kanji.sscale(xscaled 0.75)(kanji.grone.mouth))
    (kanji.radical.gmm;
     build_kanji.box((350,550),(650,250))));
  expand_pbox;
enddef;

vardef kanji.grtwo.hit =
  push_pbox_toexpand("kanji.grtwo.hit");
  build_kanji.level(build_kanji.tb(450,50)
    (kanji.toprad.sparkle_three)
    (kanji.radical.pigs_head));
  expand_pbox;
enddef;

vardef kanji.grtwo.home =
  push_pbox_toexpand("kanji.grtwo.home");
  push_stroke((520,800)..tension 1.2..(450,450)..(220,240),
    (1.6,1.6)--(1.5,1.5)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke(
    (point 0.8 of get_strokep(0))..tension 1.2..(620,400)..(750,230),
    (0.9,0.9)--(1.5,1.5)--(1.8,1.8));
  tsu_xform(identity yscaled (610/780))(kanji.radical.gmm);
  expand_pbox;
enddef;

vardef kanji.grtwo.horse =
  push_pbox_toexpand("kanji.grtwo.horse");
  push_stroke((180,230)--(180,770)--(790,770),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,4);
  set_boserif(0,2,9);
  set_botip(0,1,1);
  push_stroke((180,610)--(730,610),
    (1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((180,450)--(740,450),
    (1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((480,770)--(480,280),(1.4,1.4)--(1.3,1.3));
  push_stroke((200,280)--(830,280){dir 268}..(760,-10)..{curl 0.2}(590,-20),
    (1.5,1.5)--(1.5,1.5)--(1.5,1.5)--(1.5,1.5)--(1.4,1.4)--(1.2,1.2));
  replace_strokep(0)(insert_nodes(oldp)((length oldp)-0.5));
  set_boserif(0,1,4);
  set_botip(0,1,1);
  push_stroke((180,190)..tension 1.2..(140,70)..(80,-50),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  push_stroke((340,170)..tension 1.2..(320,50)..(300,-20),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  push_stroke((520,180)..tension 1.2..(510,70)..(490,10),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  push_stroke((680,200)..tension 1.2..(680,120)..(670,50),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.grtwo.house =
  push_pbox_toexpand("kanji.grtwo.house");
  build_kanji.level(build_kanji.tb(600,150)
    (kanji.radical.silly_hat)
    (kanji.radical.pig));
  expand_pbox;
enddef;

vardef kanji.grtwo.interval =
  push_pbox_toexpand("kanji.grtwo.interval");
  build_kanji.gate_enclose(kanji.grone.day);
  expand_pbox;
enddef;

vardef kanji.grtwo.job =
  push_pbox_toexpand("kanji.grtwo.job");
  push_stroke((80,-20)..(150,100)..{up}(200,760){right}--(820,760),
    (1,1)--(1.4,1.4)--(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,2,0.8);
  set_botip(0,3,1);
  set_boserif(0,2,4);
  set_boserif(0,3,4);
  push_stroke((500,760)--(500,-20),(1.5,1.5)--(1.4,1.4));
  push_stroke(
    (get_strokep(-1) intersectionpoint ((0,530)--(1000,530)))--(820,530),
    (1.5,1.5)--(1.5,1.5));
  push_stroke(
    (get_strokep(-2) intersectionpoint ((0,290)--(1000,290)))--(820,290),
    (1.5,1.5)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.grtwo.join =
  push_pbox_toexpand("kanji.grtwo.join");
  build_kanji.level(
    kanji.radical.tent;
    tsu_xform(identity shifted (-500,0) xyscaled (0.9,0.46) shifted (500,-40))
      (kanji.grone.mouth);
  );
  expand_pbox;
enddef;

vardef kanji.grtwo.know =
  push_pbox_toexpand("kanji.grtwo.know");
  build_kanji.level(build_kanji.lr(550,-20)
    (kanji.leftrad.arrow)
    (kanji.grone.mouth));
  expand_pbox;
enddef;

vardef kanji.grtwo.light =
  push_pbox_toexpand("kanji.grtwo.light");
  build_kanji.level(build_kanji.lr(460,0)
    (kanji.leftrad.day)
    (kanji.grone.moon));
  expand_pbox;
enddef;

vardef kanji.grtwo.little =
  push_pbox_toexpand("kanji.grtwo.little");
  build_kanji.level(build_kanji.tb(350,210)
    (kanji.grone.small)
    (
      push_stroke((750,780){curl 0.1}..(500,220)..(100,-20),
        (1.6,1.6)--(1.4,1.4)--(0.9,0.9));
      set_boserif(0,0,10);
    ));
  expand_pbox;
enddef;

vardef kanji.grtwo.little_brother =
  push_pbox_toexpand("kanji.grtwo.little_brother");
  build_kanji.level(build_kanji.tb(630,90)
    (kanji.toprad.sparkle_two)
    (kanji.grtwo.bow));
  replace_strokep(0)((point 0 of oldp)--
    ((subpath (1,infinity) of oldp)
     shifted (-820,0) xscaled 0.45 shifted (820,0)));
  push_stroke((500,ypart point 0 of get_strokep(-3))--(500,-70),
    (1.6,1.6)--(1.4,1.4));
  push_stroke(
    ((get_strokep(0) intersectionpoint get_strokep(-1))+(-40,0))..
      tension 1.2..(280,30)..(80,-60),
    (1.6,1.6)--(1.4,1.4)--(0.9,0.9));
  expand_pbox;
enddef;

vardef kanji.grtwo.long =
  push_pbox_toexpand("kanji.grtwo.long");
  push_stroke((300,0)--(300,770)--(800,770),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,4);
  set_boserif(0,2,9);
  set_botip(0,1,1);
  push_stroke((300,620)--(700,620),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((300,470)--(710,470),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((90,320)--(860,320),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((120,-30)..tension 1.2..(300,0)..(510,70),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  push_stroke((500,320)..tension 1.2..(710,40)..(860,-30),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  push_stroke((770,250)..tension 1.2..(710,190)..
      (point 0.65 of get_strokep(0)),
    (1.7,1.7)--(1.4,1.4)--(1.2,1.2));
  expand_pbox;
enddef;

vardef kanji.grtwo.many =
  push_pbox_toexpand("kanji.grtwo.many");
  perl_structure:=perl_structure&"'eids.u2FF1._1.1_',";
  tsu_xform(identity shifted (-50,-850) xyscaled (0.8,0.65) shifted (30,870))
    (kanji.grone.evening);
  tsu_xform(identity shifted (-50,50)
    xyscaled (0.95,0.6) slanted 0.3 shifted (100,-20))
    (kanji.grone.evening);
  expand_pbox;
enddef;

vardef kanji.grtwo.market =
  push_pbox_toexpand("kanji.grtwo.market");
  build_kanji.level(build_kanji.tb(610,90-10*mincho)
    (kanji.radical.kettle_lid)
    (kanji.greight.towel));
  expand_pbox;
enddef;

vardef kanji.grtwo.meat =
  push_pbox_toexpand("kanji.grtwo.meat");
  push_stroke((520,800)..tension 1.2..(460,530)..(240,380),
    (1.6,1.6)--(1.5,1.5)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke((point 0.8 of get_strokep(0))..tension 1.2..(610,490)..(730,370),
    (0.9,0.9)--(1.5,1.5)--(1.8,1.8));
  push_stroke((520,390)..tension 1.2..(460,240)..(250,100),
    (1.6,1.6)--(1.5,1.5)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke((point 0.8 of get_strokep(0))..tension 1.2..(610,190)..(720,90),
    (0.9,0.9)--(1.5,1.5)--(1.8,1.8));
  tsu_xform(identity yscaled (660/780))(kanji.radical.gmm);
  expand_pbox;
enddef;

vardef kanji.grtwo.meet =
  push_pbox_toexpand("kanji.grtwo.meet");
  build_kanji.level(
    kanji.radical.tent;
    tsu_xform(identity yscaled 0.37)(kanji.radical.mu_bar);
  );
  expand_pbox;
enddef;

vardef kanji.grtwo.minute =
  push_pbox_toexpand("kanji.grtwo.minute");
  build_kanji.level(build_kanji.tb(430,120)
    (kanji.radical.eight)
    (kanji.grtwo.sword;
     replace_strokep(0)(oldp shifted (-500,0) xscaled 0.7 shifted (500,0))));
  expand_pbox;
enddef;

vardef kanji.grtwo.mix =
  push_pbox_toexpand("kanji.grtwo.mix");
  build_kanji.level(build_kanji.tb(610,70)
    (kanji.radical.kettle_lid)
    (kanji.grtwo.father));
  expand_pbox;
enddef;

vardef kanji.grtwo.morning =
  push_pbox_toexpand("kanji.grtwo.morning");
  tsu_xform(identity shifted (50,0))
    (build_kanji.level(build_kanji.lr(480,30)
      (kanji.leftrad.morning)
      (kanji.grone.moon)));
  expand_pbox;
enddef;

vardef kanji.grtwo.mother =
  push_pbox_toexpand("kanji.grtwo.mother");
  kanji.radical.mother;
  push_stroke((410,660)..tension 1.2..(520,590)..(560,530),
    (1.1,1.1)--(1.4,1.4)--(1.7,1.7));
  set_bosize(0,90);
  push_stroke((370,360)..tension 1.2..(490,280)..(530,210),
    (1.1,1.1)--(1.4,1.4)--(1.7,1.7));
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef kanji.grtwo_helper.myriad =
  push_pbox_toexpand("kanji.grtwo_helper.myriad");
  kanji.grone.power;
  set_boserif(0,0,whatever);
  replace_strokep(0)(oldp yscaled (500/600) shifted (-50,0));
  replace_strokep(0)(
    subpath (xpart (oldp intersectiontimes get_strokep(-1)),infinity) of oldp);
  expand_pbox;
enddef;

vardef kanji.grtwo.myriad =
  push_pbox_toexpand("kanji.grtwo.myriad");
  kanji.grtwo_helper.myriad;
  push_stroke((100,780)--(900,780),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grtwo.neck =
  push_pbox_toexpand("kanji.grtwo.neck");
  build_kanji.level(build_kanji.tb(600,10)
    (kanji.toprad.sparkle_two;
     replace_strokep(0)(oldp shifted (-point 0 of oldp)
       yscaled 1.25 shifted (point 0 of oldp) shifted (0,-60));
     push_stroke((100,0)--(900,0),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9))
    (build_kanji.attach_tick(660)(kanji.grone.eye)));
  expand_pbox;
enddef;

vardef kanji.grtwo.neighbourhood =
  push_pbox_toexpand("kanji.grtwo.neighbourhood");
  build_kanji.box((230,760),(770,420));
  push_stroke((230,590)--(770,590),(1.5,1.5)--(1.5,1.5));
  push_stroke((500,760)--(500,0),(1.6,1.6)--(1.5,1.5));
  push_stroke((160,210)--(840,210),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((90,0)--(910,0),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  for i=-6 upto 0: set_bosize(i,93); endfor;
  expand_pbox;
enddef;

vardef kanji.grtwo.noon =
  push_pbox_toexpand("kanji.grtwo.noon");
  push_stroke((300,790)..tension 1.2..(240,610)..(100,420),
    (1.7,1.7)--(1.4,1.4)--(0.9,0.9));
  set_boserif(0,0,10);
  push_stroke((((0,640)--(1000,640)) intersectionpoint get_strokep(0))--
      (850-30*mincho,640),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,640)--(500,-60),(1.6,1.6)--(1.5,1.5));
  push_stroke((110,330)--(910-30*mincho,330),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grtwo.now =
  push_pbox_toexpand("kanji.grtwo.now");
  kanji.radical.tent;
  push_stroke((200,300)--(760,300)..tension 1.2..(650,100)..(500,-40),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,1,4);
  set_botip(0,1,0);
  expand_pbox;
enddef;

vardef kanji.grtwo.occurrences =
  push_pbox_toexpand("kanji.grtwo.occurrences");
  kanji.radical.box;
  build_kanji.box((350,550),(650,250));
  expand_pbox;
enddef;

vardef kanji.grtwo.old =
  push_pbox_toexpand("kanji.grtwo.old");
  build_kanji.level(build_kanji.tb(420,100)
    (kanji.grone.ten)
    (build_kanji.sscale(xscaled 0.83)(kanji.grone.mouth)));
  expand_pbox;
enddef;

vardef kanji.grtwo.ordinal =
  push_pbox_toexpand("kanji.grtwo.ordinal");
  build_kanji.level(build_kanji.tb(350,140)
    (build_kanji.spread_legs(140)(build_kanji.add_beret(
       kanji.grtwo.rice)))
    (kanji.grone.paddy));
  replace_strokep(-8)((point 0 of oldp)--(500,330+50*mincho));
  expand_pbox;
enddef;

vardef kanji.grtwo.origin =
  push_pbox_toexpand("kanji.grtwo.origin");
  build_kanji.tb(520,110)
    (kanji.grone.two)
    (kanji.radical.legs);
  expand_pbox;
enddef;

vardef kanji.grtwo.parent =
  push_pbox_toexpand("kanji.grtwo.parent");
  build_kanji.level(build_kanji.lr(460,50)
    (build_kanji.tb(470,20)
      (kanji.toprad.stand_up)
      (kanji.leftrad.wood))
    (kanji.grone.see));
  expand_pbox;
enddef;

vardef kanji.grtwo.pedestal =
  push_pbox_toexpand("kanji.grtwo.pedestal");
  build_kanji.sscale(xscaled 0.83)(
    build_kanji.level(build_kanji.tb(420,-50)
      (kanji.radical.mu)
      (kanji.grone.mouth)));
  expand_pbox;
enddef;

vardef kanji.grtwo.public =
  push_pbox_toexpand("kanji.grtwo.public");
  build_kanji.level(build_kanji.tb(390,150)
    (kanji.radical.eight)
    (kanji.radical.mu));
  expand_pbox;
enddef;

vardef kanji.grtwo.pull =
  push_pbox_toexpand("kanji.grtwo.pull");
  build_kanji.level(build_kanji.lr(600,0)
    (kanji.grtwo.bow)
    (push_stroke((500,740)--(500,-60),(1.6,1.6)--(1.5,1.5));
     set_boserif(0,0,10);
    ));
  expand_pbox;
enddef;

vardef kanji.grtwo.rice =
  push_pbox_toexpand("kanji.grtwo.rice");
  build_kanji.level(build_kanji.tb(540,220)
    (build_kanji.spread_legs(-200)(kanji.toprad.sparkle_two))
    (kanji.grone.wood));
  replace_strokep(-3)((500,820)--(500,-30));
  replace_strokeq(-3)((1.6,1.6)--(1.4,1.4));
  expand_pbox;
enddef;

vardef kanji.grtwo.run =
  push_pbox_toexpand("kanji.grtwo.run");
  push_stroke((500,810)--(500,40),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((140,640)--(830,640),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((90,450)--(900,450),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,250)--(820,250),(1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  kanji.grone_helper.foot;
  expand_pbox;
enddef;

vardef kanji.grtwo.same =
  push_pbox_toexpand("kanji.grtwo.same");
  kanji.radical.gmm;
  push_stroke((310,620)--(690,620),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.box((350,470),(650,170));
  expand_pbox;
enddef;

vardef kanji.grtwo.self =
  push_pbox_toexpand("kanji.grtwo.self");
  build_kanji.attach_tick(660)(kanji.grone.eye);
  expand_pbox;
enddef;

vardef kanji.grtwo.sell =
  push_pbox_toexpand("kanji.grtwo.sell");
  build_kanji.level(build_kanji.tb(550,0)
    (kanji.grfour.gentleman)
    (build_kanji.tb(450,200)
       (kanji.radical.conservative_hat)
       (kanji.radical.legs)));
  expand_pbox;
enddef;

vardef kanji.grtwo.shine =
  push_pbox_toexpand("kanji.grtwo.shine");
  build_kanji.level(build_kanji.tb(440,55)
    (kanji.toprad.sparkle_three;
     push_stroke((80,-20)--(920,-20),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9);
    )
    (kanji.radical.legs));
  expand_pbox;
enddef;

vardef kanji.grtwo.shop =
  push_pbox_toexpand("kanji.grtwo.shop");
  build_kanji.dotcliff_enclose(kanji.greight.divination);
  expand_pbox;
enddef;

vardef kanji.grtwo.snow =
  push_pbox_toexpand("kanji.grtwo.snow");
  build_kanji.tb(280,0)
    (kanji.toprad.rain)
    (kanji.radical.pigs_head);
  expand_pbox;
enddef;

vardef kanji.grtwo.south =
  push_pbox_toexpand("kanji.grtwo.south");
  build_kanji.tb(540,60)
    (kanji.grone.ten)
    (kanji.radical.gmm;
     build_kanji.sscale(xyscaled (0.54,0.45))(kanji.grone.two);
     build_kanji.sscale(xyscaled (0.4,0.32) shifted (0,230))
       (kanji.toprad.sparkle_two);
     push_stroke((500,492)--(500,-20),(1.6,1.6)--(1.5,1.5));
     );
  expand_pbox;
enddef;

vardef kanji.grtwo.spring =
  push_pbox_toexpand("kanji.grtwo.spring");
  build_kanji.tb(320,90)
    (kanji.grone.person;
     build_kanji.sscale(xyscaled (1,0.5) shifted (0,30))
       (kanji.grone.three);
     replace_strokep(-3)
       (subpath (xpart (oldp intersectiontimes get_strokep(-1)),infinity)
        of oldp))
    (build_kanji.sscale(xscaled 0.8 shifted (10,0))
      (kanji.grone.day));
  expand_pbox;
enddef;

vardef kanji.grtwo.star =
  push_pbox_toexpand("kanji.grtwo.star");
  build_kanji.sscale(xscaled 1.07)(build_kanji.tb(420,0)
    (kanji.grone.day)
    (kanji.grone.life));
  expand_pbox;
enddef;

vardef kanji.grtwo.straight =
  push_pbox_toexpand("kanji.grtwo.straight");
  build_kanji.level(
    build_kanji.sscale(scaled 0.82 shifted (0,100))
      (build_kanji.tb(500,70)
         (kanji.grone.ten)
         (kanji.grone.eye));
    build_kanji.cup((120,580),(880,20));
    set_bosize(-1,0);
    set_boserif(0,1,9);
  );
  expand_pbox;
enddef;

vardef kanji.grtwo.street =
  push_pbox_toexpand("kanji.grtwo.street");
  build_kanji.road_enclose(kanji.grtwo.neck);
  expand_pbox;
enddef;

vardef kanji.grtwo.strong =
  push_pbox_toexpand("kanji.grtwo.strong");
  build_kanji.level(build_kanji.lr(410,0)
    (kanji.grtwo.bow)
    (build_kanji.tb(600,30)
     (kanji.radical.mu)
     (kanji.grone.bug)));
  expand_pbox;
enddef;

vardef kanji.grtwo.summer =
  push_pbox_toexpand("kanji.grtwo.summer");
  build_kanji.level(build_kanji.tb(350,0)
    (kanji.toprad.summer)
    (kanji.radical.winter));
  expand_pbox;
enddef;

vardef kanji.grtwo.sword =
  push_pbox_toexpand("kanji.grtwo.sword");
  push_stroke((450,710)..(400,400)..(290,120)..(100,-20),
    (1.5,1.5)--(1.6,1.6)--(1.3,1.3)--(1,1));
  push_stroke((100,710)--(830,710)..tension 1.1..(830,300)..(770,70)..(650,0),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.4,1.4));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  expand_pbox;
enddef;

vardef kanji.grtwo.temple =
  push_pbox_toexpand("kanji.grtwo.temple");
  build_kanji.tb(500,0)
    (kanji.grone.earth)
    (kanji.grsix.inch;
     replace_strokep(-1)(((point 0 of oldp)+(0,60))
       --(subpath (1,infinity) of oldp)));
  expand_pbox;
enddef;

vardef kanji.grtwo.thick =
  push_pbox_toexpand("kanji.grtwo.thick");
  kanji.grone.big;
  push_stroke((370,150)..(470,90)..(540,10),
    (1,1)--(1.4,1.4)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grtwo.think =
  push_pbox_toexpand("kanji.grtwo.think");
  build_kanji.level(build_kanji.tb(390,120)
    (kanji.grone.paddy)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.grtwo.time =
  push_pbox_toexpand("kanji.grtwo.time");
  build_kanji.lr(330,0)
    (kanji.leftrad.day)
    (kanji.grtwo.temple);
  expand_pbox;
enddef;

vardef kanji.grtwo.traffic =
  push_pbox_toexpand("kanji.grtwo.traffic");
  build_kanji.road_enclose(kanji.rare.walled_road);
  expand_pbox;
enddef;

vardef kanji.grtwo.valley =
  push_pbox_toexpand("kanji.grtwo.valley");
  build_kanji.harmonic(230,0.8,260)(build_kanji.level(
    kanji.radical.tent;
    pop_stroke;
    build_kanji.box((250,400),(750,-10));
  ));
  expand_pbox;
enddef;

vardef kanji.grtwo.walk =
  push_pbox_toexpand("kanji.grtwo.walk");
  build_kanji.level(build_kanji.tb(440,50)
    (kanji.grtwo.cease)
    (kanji.grtwo.little));
  expand_pbox;
enddef;

vardef kanji.grtwo.weak =
  push_pbox_toexpand("kanji.grtwo.weak");
  build_kanji.lr(450,0)
    (kanji.grtwo_helper.weak)
    (kanji.grtwo_helper.weak);
  expand_pbox;
enddef;

vardef kanji.grtwo_helper.weak =
  kanji.grtwo.bow;
  push_stroke((330,230)..tension 1.2..(450,190)..(490,160),
    (1.2,1.2)--(1.4,1.4)--(1.8,1.8));
  set_bosize(0,80);
  push_stroke((600,130)..tension 1.2..(380,80)..(250,60),
    (1.3,1.3)--(1.6,1.6)--(1.9,1.9));
  set_bosize(0,80);
enddef;

vardef kanji.grtwo.west =
  push_pbox_toexpand("kanji.grtwo.west");
  push_stroke((120,770)--(880,770),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.sscale(scaled 0.7 shifted (0,100))
    (kanji.radical.legs);
  build_kanji.box((180,520),(820,30));
  expand_pbox;
enddef;

vardef kanji.grtwo.what =
  push_pbox_toexpand("kanji.grtwo.what");
  build_kanji.lr(300,50)
    (kanji.leftrad.person)
    (kanji.grfive.passable);
  expand_pbox;
enddef;

vardef kanji.grtwo.wheat =
  push_pbox_toexpand("kanji.grtwo.wheat");
  build_kanji.level(build_kanji.tb(450,15)
    (push_stroke((500,780)--(500,0),
       (1.5,1.5)--(1.4,1.4));
     set_boserif(0,0,10);
     push_stroke((170,550)--(830,550),
       (1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9);
     push_stroke((220,290)--(780,290),
       (1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9);
     push_stroke((120,0)--(880,0),
       (1.7,1.7)--(1.7,1.7));
     set_boserif(0,1,9))
    (kanji.radical.winter));
  expand_pbox;
enddef;

vardef kanji.grtwo.wide =
  push_pbox_toexpand("kanji.grtwo.wide");
  build_kanji.dotcliff_enclose(kanji.radical.mu);
  expand_pbox;
enddef;

vardef kanji.grtwo.wind =
  push_pbox_toexpand("kanji.grtwo.wind");
  build_kanji.wind_enclose(build_kanji.add_beret(kanji.grone.bug));
  expand_pbox;
enddef;

vardef kanji.grtwo.winter =
  push_pbox_toexpand("kanji.grtwo.winter");
  build_kanji.level(
    tsu_xform(begingroup
      save myxf;
      transform myxf;
      (0,690) transformed myxf=(0,690);
      (1000,690) transformed myxf=(1000,690);
      (500,0) transformed myxf=(500,220);
      myxf
    endgroup)(kanji.radical.winter);
    push_stroke((430,260)..tension 1.2..(570,220)..(660,180),
      (1.2,1.2)--(1.5,1.5)--(1.8,1.8));
    push_stroke((300,130)..tension 1.2..(580,40)..(690,-10),
      (1.2,1.2)--(1.5,1.5)--(1.8,1.8));
  );
  expand_pbox;
enddef;

vardef kanji.grtwo.word =
  push_pbox_toexpand("kanji.grtwo.word");
  push_stroke((220,750)--(780,750),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((100,620)--(900,620),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((220,490)--(780,490),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((220,360)--(780,360),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.box((220,230),(780,20));
  expand_pbox;
enddef;

vardef kanji.grtwo.yellow =
  push_pbox_toexpand("kanji.grtwo.yellow");
  build_kanji.level(build_kanji.tb(140,0)
    (kanji.grthree.once_upon_a_time;
     push_stroke((point 0.5 of get_strokep(-3))--
         (point 0.5 of get_strokep(-1)),
       (1.6,1.6)--(1.5,1.5)))
    (build_kanji.sscale(xscaled 0.85)(kanji.radical.eight)));
  expand_pbox;
enddef;
