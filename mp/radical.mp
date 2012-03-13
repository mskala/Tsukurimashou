%
% Radicals that are not common kanji in themselves
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

inclusion_lock(radical);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.radical.aitch =
  push_pbox_toexpand("kanji.radical.aitch");
  push_stroke((100,430)--(900,430),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((360,730){down}..(270,130)..(120,-80),
    (1.6,1.6)--(1.3,1.3)--(1,1));
  set_boserif(0,0,10);
  push_stroke((650,730)--(660,-80),(1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.radical.beta =
  push_pbox_toexpand("kanji.radical.beta");
  push_stroke((250,-80)--(250,760)--(650,760)..tension 1.2..
      (550,600)..{curl 1}(350,480){curl 0.5}..
      (650,340)..(650,240)..{curl 0.3}(400+70*mincho,210),
    (1.6,1.6)--(1.7,1.7)--(1.6,1.6)--
      (1.1,1.3)--(0.55,1.4)--
      (1.4,1.4)--(1.6,1.6)--(1.8,1.8)--(1.9,1.9));
  set_botip(0,1,1);
  set_botip(0,2,0);
  set_botip(0,4,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  replace_strokep(0)(insert_nodes(oldp)(6.5));
  expand_pbox;
enddef;

vardef kanji.radical.box =
  perl_structure:=perl_structure&"'eids.u2FF4.u56D7.1_',";
  push_pbox_toexpand("kanji.radical.box");
  build_kanji.box((100,800),(900,-20));
  expand_pbox;
enddef;

vardef kanji.radical.brush =
  push_pbox_toexpand("kanji.radical.brush");
  push_stroke((500,810)--(500,-60),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  tsu_xform(identity yscaled 0.4 shifted (0,360))
    (kanji.radical.pigs_snout);
  push_stroke((160,220)--(840,220),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((80,60)--(930,60),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  for i=-5 upto 0: set_bosize(i,85); endfor;
  expand_pbox;
enddef;

vardef kanji.radical.box_on_side =
  push_pbox_toexpand("kanji.radical.box_on_side");
  build_kanji.box((100,800),(900,-20));
  replace_strokep(-1)(subpath (0,2) of oldp);
  replace_strokeq(-1)(subpath (0,2) of oldq);
  set_boserif(-1,2,9);
  set_botip(-1,2,whatever);
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.radical.ceremony =
  push_pbox_toexpand("kanji.radical.ceremony");
  push_stroke((120,510)--(880,530),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke(interpath(mincho,
      (470,760){down}..(610,100)..(810,0)..tension 1.5..
        (870,70)..{curl 0.3}(910,200),
      (440,760){down}..(620,100)..{right}(910,-40){curl 1}..
        (860,60)..(860,160)),
    (1.6,1.6)--(1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(0.9,0.9));
  set_boserif(0,0,10);
  push_stroke((610,720)..tension 1.2..(680,680)..(740,610),
    (1,1)..(1.5,1.5)--(1.7,1.7));
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef kanji.radical.conservative_hat =
  push_pbox_toexpand("kanji.radical.conservative_hat");
  push_stroke((100,100)..(100+50*mincho,300)..(100+70*mincho,500)--
      (900,500)..(900-40*mincho,200)..(900-70*mincho,100),
    (1.7,1.7)--(1.6,1.6)--(1.4,1.4)--(1.7,1.7)--(1.6,1.6)--(1.4,1.4));
  set_bosize(0,95);
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_boserif(0,3,4);
  expand_pbox;
enddef;

vardef kanji.radical.crossed_must_not =
  push_pbox_toexpand("kanji.radical.crossed_must_not");
  kanji.grnine.must_not;
  push_stroke((290,430)..tension 1.2..(480,370)..(660,210),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef kanji.radical.cut_the_grass =
  push_pbox_toexpand("kanji.radical.cut_the_grass");
  push_stroke((150,750)..(500,500)..(850,50),
    (1.3,1.3)--(1.5,1.5)--(1.7,1.7));
  push_stroke((700,800)..(500,330)..(70,-30),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.radical.eight =
  push_pbox_toexpand("kanji.radical.eight");
  push_stroke((610,760)..tension 1.3..(760,240)..(880,-10),
    (1,1)--(1.4,1.4)--(1.8,1.8));
  set_bosize(0,110);
  push_stroke((350,740)..(280,360)..(160,80)..(40,-30),
    (1.6,1.6)--(1.4,1.4)--(1.3,1.3)--(0.88,0.88));
  set_bosize(0,110);
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.radical.flag =
  perl_structure:=perl_structure&"'eids.u2FF8.u5C38.1_',";
  push_pbox_toexpand("kanji.radical.flag");
  push_stroke((800,430)--(800,730)--(200,730){down}..(160,200)..(30,-50),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.3,1.3)--(0.9,0.9));
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  set_bosize(0,93);
  push_stroke((((0,490)--(1000,490))
      intersectionpoint reverse get_strokep(0))--(800,490),
    (1.5,1.5)--(1.5,1.5));
  set_bosize(0,93);
  expand_pbox;
enddef;

% "George Michael's Moustache" radical, according to Schultzzz
vardef kanji.radical.gmm =
  push_pbox_toexpand("kanji.radical.gmm");
  push_stroke((150,-50)--(150,30)--(150,780)--(850,780),
    (1.5,1.5)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_boserif(0,2,4);
  set_boserif(0,3,4);
  expand_pbox;
enddef;

vardef kanji.radical.kettle_lid =
  push_pbox_toexpand("kanji.radical.kettle_lid");
  push_stroke((500,700)..(500,160),(1.6,1.6)--(1.5,1.5));
  set_bosize(0,125);
  set_boserif(0,0,10);
  push_stroke((100,160)--(900,160),(1.7,1.7)--(1.7,1.7));
  set_bosize(0,125);
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.radical.legs =
  push_pbox_toexpand("kanji.radical.legs");
  push_stroke((370,780){down}..(330,300)..(40,-60),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(0.8,0.7));
  replace_strokep(0)(insert_nodes(oldp)(1.3));
  set_bosize(0,110);
  push_stroke((610,780),
    (1.6,1.6));
  build_kanji.add_ltail(0);
  set_bosize(0,110);
  expand_pbox;
enddef;

vardef kanji.radical.life_minus =
  push_pbox_toexpand("kanji.radical.life_minus");
  push_stroke((500,780)--(500,0),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((280,700)..(220,360)..(140,120),
    (1.6,1.6)--(1.2,1.2)--(0.8,0.8));
  set_boserif(0,0,10);
  push_stroke((point 0.9 of get_strokep(0))--
      (820,ypart point 0.9 of get_strokep(0)),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((120,0)--(880,0),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.radical.long_hair =
  push_pbox_toexpand("kanji.radical.long_hair");
  build_kanji.level(build_kanji.lr(520,30)
    (kanji.leftrad.long_hair)
    (tsu_xform(identity shifted (0,40))
       (kanji.rightrad.short_hair)));
  expand_pbox;
enddef;

vardef kanji.radical.long_kimono =
  push_pbox_toexpand("kanji.radical.long_kimono");
  build_kanji.level(build_kanji.tb(600,-50)
      (kanji.grone.earth)
      (kanji.bottomrad.long_kimono));
  expand_pbox;
enddef;

vardef kanji.radical.mother =
  push_pbox_toexpand("kanji.radical.mother");
  push_stroke(
    (150,0)..(240,390)..tension 1.2..(280,750)--
    (750,750)..(720,390)..tension 1.2..(630,-20){dir 250}..{curl 0.2}(480,-50),
    (1.5,1.5)--(1.6,1.6)--(1.7,1.7)--(1.7,1.7)--(1.6,1.6)--(1.5,1.5));
  replace_strokep(0)(insert_nodes(oldp)((length oldp)-0.5));
  replace_strokeq(0)(oldq--(1.4,1.4)--(1.2,1.2));
  set_botip(0,2,1);
  set_botip(0,3,0);
  set_boserif(0,2,4);
  set_boserif(0,3,4);
  push_stroke((110,440)--(890,440),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((183,100)--(860,100),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.radical.mother_stroked =
  push_pbox_toexpand("kanji.radical.mother_stroked");
  kanji.radical.mother;
  push_stroke((520,750)..tension 1.2..(480,390)..(420,100),
    (1.6,1.6)--(1.5,1.5)--(1.4,1.4));
  expand_pbox;
enddef;

vardef kanji.radical.mu =
  push_pbox_toexpand("kanji.radical.mu");
  push_stroke((120,-20)..tension 1.2..(450,0)..(800,50),
    (2,2)--(1.7,1.7)--(1.2,1.2));
  push_stroke(
    (500,780)..tension 1.2..(350,350)..(point 0.2 of get_strokep(0)),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3));
  set_boserif(0,0,10);
  push_stroke((700,180)..tension 1.3..(800,50)..(880,-60),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.radical.mu_bar =
  push_pbox_toexpand("kanji.radical.mu_bar");
  push_stroke((140,780)--(860,780),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.sscale(xyscaled (0.92,1.5) shifted (0,250))
    (kanji.radical.mu);
  replace_strokep(-1)(subpath
    (xpart (oldp intersectiontimes get_strokep(-3)),infinity) of oldp);
  set_boserif(-1,0,whatever);
  replace_strokep(0)(oldp rotatedaround (point 1 of oldp,-15));
  expand_pbox;
enddef;

vardef kanji.radical.narrow_flag =
  perl_structure:=perl_structure&"'eids.u2FF8.u5C38.1_',";
  push_pbox_toexpand("kanji.radical.narrow_flag");
  push_stroke((800,560)--(800,730)--(200,730){down}..(160,200)..(30,-50),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.3,1.3)--(0.9,0.9));
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  set_bosize(0,93);
  push_stroke((((0,610)--(1000,610))
      intersectionpoint reverse get_strokep(0))--(800,610),
    (1.5,1.5)--(1.5,1.5));
  set_bosize(0,93);
  expand_pbox;
enddef;

vardef kanji.radical.northeast =
  push_pbox_toexpand("kanji.radical.northeast");
  push_stroke((300,0)--(300,770)--(730,770)--(730,320),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  set_botip(0,1,1);
  set_botip(0,2,1);
  push_stroke((300,570)--(730,570),(1.5,1.5)--(1.5,1.5));
  push_stroke((300,370)--(730,370),(1.5,1.5)--(1.5,1.5));
  push_stroke((140,-30)..tension 1.2..(300,0)..(510,70),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  push_stroke((500,360)..tension 1.2..(710,40)..(860,-30),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  push_stroke((820,250)..tension 1.2..(750,190)..
      (point 0.7 of get_strokep(0)),
    (1.7,1.7)--(1.4,1.4)--(1.2,1.2));
  expand_pbox;
enddef;

vardef kanji.radical.old_bird =
  push_pbox_toexpand("kanji.radical.old_bird");
  push_stroke((300,840){curl 0.1}..(200,660)..(60,480),
    (1.7,1.7)--(1.5,1.5)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke((200,660)--(200,-40),
    (1.49,1.49)--(1.4,1.4));
  push_stroke((630,850){curl 0.1}..(560,780)..(480,710),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke(
    (((0,710)--(1000,710)) intersectionpoint get_strokep(-2))--(890,710),
    (1.4,1.4)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((200,500)--(770,500),
    (1.4,1.4)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((200,290)--(790,290),
    (1.4,1.4)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((530,710)--(530,70),(1.5,1.5)--(1.4,1.4));
  push_stroke((200,70)--(840,70),
    (1.4,1.4)--(1.5,1.5));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

% pass in some code that goes in the bottom
vardef kanji.radical.old_man(text curves) =
  push_pbox_toexpand("kanji.radical.old_man");
  build_kanji.level(
    build_kanji.tb(480,-110)
      (kanji.grone.earth;
       replace_strokep(-1)(oldp shifted (-500,0) xscaled 0.75 shifted (480,0)))
      (curves);
    push_stroke((880,780)..tension 1.2..(600,530)..(50,260),
      (1.6,1.6)--(1.5,1.5)--(1,1)));
  expand_pbox;
enddef;

vardef kanji.radical.open_box =
  push_pbox_toexpand("kanji.radical.open_box");
  push_stroke((100,760)--(100,-60),(1.7,1.7)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((100,-20)--(900,-20),(1.5,1.5)--(1.5,1.5));
  push_stroke((900,760)--(900,-60),(1.7,1.7)--(1.5,1.5));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.radical.pig =
  push_pbox_toexpand("kanji.radical.pig");
  push_stroke((200,740)--(800,740),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,740)..tension 1.2..(280,570)..(100,500),
    (1.6,1.6)--(1.4,1.4)--(1.0,1.0));
  push_stroke(
    (point 0.5 of get_strokep(0))..tension 1.1..(560,300)..
      (470,20)..{curl 0.6}(300,20),
    (1.3,1.3)--(1.5,1.5)--(1.4,1.4)--(1.3,1.3));
  push_stroke(
    (point 0.4 of get_strokep(0))..tension 1.2..(250,350)..(80,290),
    (1.35,1.35)--(1.4,1.4)--(1.0,1.0));
  push_stroke(
    (point 0.8 of get_strokep(-1))..tension 1.2..(380,230)..(140,140),
    (1.35,1.35)--(1.4,1.4)--(1.0,1.0));
  push_stroke(
    ((0,90)+point 0.3 of get_strokep(-2))..tension 1.2..(670,410)..(870,280),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  push_stroke(
    (810,620)..tension 1.2..(730,550)..(point 0.7 of get_strokep(0)),
    (1.7,1.7)--(1.4,1.4)--(1.2,1.2));
  for i=-6 upto 0: set_bosize(i,92); endfor;
  expand_pbox;
enddef;

vardef kanji.radical.pigs_head =
  push_pbox_toexpand("kanji.radical.pigs_head");
  push_stroke((150,760)--(830,760)--(830,-70),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((190,410)--(830,410),(1.55,1.55)--(1.55,1.55));
  push_stroke((150,30)--(830,30),(1.5,1.5)--(1.5,1.5));
  expand_pbox;
enddef;

% name is mine - it has central horizontal line lengthened
vardef kanji.radical.pigs_snout =
  push_pbox_toexpand("kanji.radical.pigs_snout");
  build_kanji.level(
    build_kanji.sscale(xscaled 0.87)(kanji.radical.pigs_head);
    replace_strokep(-1)((100,410)--(910,410));
    set_boserif(-1,1,9);
  );
  expand_pbox;
enddef;

% name is mine - it has bottom horizontal line lengthened, vertical clipped
vardef kanji.radical.pigs_tail =
  push_pbox_toexpand("kanji.radical.pigs_tail");
  kanji.radical.pigs_head;
  replace_strokep(-2)((150,760)--(830,760)--(830,30));
  replace_strokep(0)((150,30)--(920,30));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.radical.seal =
  push_pbox_toexpand("kanji.radical.seal");
  push_stroke((150,-300)--(150,550)--(600,550),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  replace_strokep(0)(oldp shifted (0,250) xscaled 1.3333);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  set_botip(0,1,1);
  set_botip(0,2,1);
  expand_pbox;
enddef;

vardef kanji.radical.short_thread =
  push_pbox_toexpand("kanji.radical.short_thread");
  tsu_xform(begingroup
    save myxf;
    transform myxf;
    xpart myxf=yxpart myxf=0;
    xxpart myxf=1;
    (500,330) transformed myxf=(500,90);
    (500,800) transformed myxf=(500,810);
    myxf
  endgroup)(kanji.radical.thread_common);
  replace_strokep(0)(subpath (0,1.6) of oldp);
  replace_strokeq(0)(subpath (0,1.6) of oldq);
  for i=-4 upto 0: set_bosize(i,100); endfor;
  expand_pbox;
enddef;

vardef kanji.radical.silly_hat =
  push_pbox_toexpand("kanji.radical.silly_hat");
  push_stroke((500,800)..(500,500),(1.6,1.6)--(1.5,1.5));
  set_bosize(0,95);
  set_boserif(0,0,10);
  kanji.radical.conservative_hat;
  expand_pbox;
enddef;

vardef kanji.radical.spoon =
  push_pbox_toexpand("kanji.radical.spoon");
  push_stroke((150,780),(1.6,1.6));
  build_kanji.add_ltail(0);
  set_boserif(0,0,10);
  push_stroke(
    (xpart point infinity of get_strokep(0),620)..(550,520)..(150,420),
    (1.9,1.9)..(1.6,1.6)..(1.3,1.3));
  set_boserif(0,0,9);
  expand_pbox;
enddef;

vardef kanji.radical.tent =
  perl_structure:=perl_structure&"'eids.u2FF1.u4EBA.1_',";
  push_pbox_toexpand("kanji.radical.tent");
  push_stroke((510,800)..(450,700)..(300,540)..(60,360),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3)--(0.85,0.9));
  set_boserif(0,0,10);
  push_stroke(
    (point 0.2 of get_strokep(0))..tension 1.2..(640,620)..(920,400),
    (1,1)--(1.3,1.3)--(2.25,0.95));
  push_stroke((330,470)--(660,470),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.radical.thread_common =
  push_pbox_toexpand("kanji.radical.thread_common");
  push_stroke((120,330)..tension 1.2..(450,330)..(800,360),
    (2,2)--(1.7,1.7)--(1.2,1.2));
  push_stroke((700,650)..tension 1.3..(550,480)..(point 0.7 of get_strokep(0)),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  push_stroke(subpath (0,2-0.3*mincho) of
      ((190,670)..tension 1.3..(320,580)..(point 1.3 of get_strokep(0))),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  push_stroke((500,790)..(450,700)..(point 1.15 of get_strokep(0)),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  push_stroke((700,460)..tension 1.3..(800,360)..(880,250),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.radical.topped_aitch =
  push_pbox_toexpand("kanji.radical.topped_aitch");
  push_stroke((160,730)--(840,730),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  kanji.radical.aitch;
  set_boserif(-1,0,whatever);
  set_boserif(0,0,whatever);
  expand_pbox;
enddef;

% insert "Scottish tsundere" joke here
vardef kanji.radical.twin_tailed_sheep =
  push_pbox_toexpand("kanji.radical.twin_tailed_sheep");
  kanji.grthree.sheep;
  replace_strokep(0)
    ((510,615){down}..(500,260)..(370,70)..{curl 0.5}(50,-60));
  replace_strokeq(0)((1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke(((get_strokep(0) intersectionpoint get_strokep(-3))+(50,0))..
      (650,80)..(900,-50),
    (1.1,1.1)--(1.4,1.4)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.radical.vline =
  push_pbox_toexpand("kanji.radical.vline");
  push_stroke((500,780)--(500,-20),(1.7,1.7)--(1.3,1.3));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.radical.water_variant =
  push_pbox_toexpand("kanji.radical.water_variant");
  push_stroke((510,810),(1.6,1.6));
  build_kanji.add_jtail(0);
  set_boserif(0,0,10);
  push_stroke((130,600)..tension 1.2..(210,520)..(270,400),
    (1,1)--(1.4,1.4)--(1.6,1.6));
  push_stroke((410,420)..tension 1.2..(300,270)..(120,100),
    (1.2,1.2)--(1.4,1.4)--(1.6,1.6));
  push_stroke((510,570)..tension 1.2..(640,300)..(880,100),
    (1,1)--(1.3,1.3)--(1.7,1.7));
  push_stroke((860,590)..(720,410)..(point 0.9 of get_strokep(0)),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.radical.windy =
  push_pbox_toexpand("kanji.radical.windy");
  build_kanji.spread_legs(80)(kanji.radical.legs);
  replace_strokep(-1)((reverse oldp)--get_strokep(0));
  replace_strokeq(-1)((reverse oldq)--get_strokeq(0));
  pop_stroke;
  set_boserif(0,3,4);
  set_boserif(0,4,4);
  set_botip(0,3,1);
  set_botip(0,4,1);
  expand_pbox;
enddef;

vardef kanji.radical.windy_again =
  push_pbox_toexpand("kanji.radical.windy_again");
  tsu_xform(identity yscaled 0.93)
    (build_kanji.tb(460,-60)	
       (kanji.radical.windy)
       (kanji.greight.otoh));
  expand_pbox;
enddef;

vardef kanji.radical.winter =
  push_pbox_toexpand("kanji.radical.winter");
  push_stroke((420,830)..tension 1.2..(270,570)..(120,460),
    (1.7,1.7)--(1.4,1.4)--(1,1));
  set_boserif(0,0,10);
  push_stroke((get_strokep(0) intersectionpoint ((0,690)--(1000,690)))--
      (730,690)..tension 1.2..(460,280)..(60,-20),
    (1.5,1.5)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,1,4);
  set_botip(0,1,0);
  push_stroke((point 0.85 of get_strokep(-1))..tension 1.2..
      (570,260)..(920,20),
    (1,1)--(1.3,1.3)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.radical.wrapping =
  push_pbox_toexpand("kanji.radical.wrapping");
  push_stroke((350,780)..tension 1.2..(260,600)..(120,450),
    (1.7,1.7)--(1.4,1.4)--(1,1));
  set_boserif(0,0,10);
  push_stroke(
    ((5,0)+((get_strokep(0) intersectionpoint ((0,610)--(1000,610)))))--
      (860,610){down}..(770,90)..(560,-10),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5)--(1.1,1.1));
  set_boserif(0,1,4);
  set_botip(0,1,0);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.rightrad.beta =
  push_pbox_toexpand("kanji.rightrad.beta");
  kanji.radical.beta;
  replace_strokep(0)
    (oldp shifted (-250,-760) xyscaled (1.2,630/550) shifted (300,760));
  replace_strokep(0)((300,-60)--(subpath (1,infinity) of oldp));
  expand_pbox;
enddef;

vardef kanji.rightrad.short_hair =
  push_pbox_toexpand("kanji.rightrad.short_hair");
  push_stroke((780,750)..tension 1.2..(580,620)..(180,500),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke((880,220)..tension 1.2..(600,60)..(100,-70),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke(interpath(0.52,get_strokep(0),get_strokep(-1)),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  expand_pbox;
enddef;

vardef kanji.rightrad.sword =
  push_pbox_toexpand("kanji.rightrad.sword");
  push_stroke((260,720)--(260,120),(1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((740,760),(1.6,1.6));
  set_boserif(0,0,10);
  build_kanji.add_jtail(0);
  replace_strokep(0)(oldp shifted (-740,0) xscaled 2.3 shifted (740,0));
  expand_pbox;
enddef;
