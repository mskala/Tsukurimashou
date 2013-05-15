%
% Hiragana for Tsukurimashou
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

inclusion_lock(hiragana);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% HIRAGANA VOWELS

vardef hira.a =
  push_pbox_toexpand("hira.a");

  push_stroke((170,610)..(380,610)..(650,660),
    (1.6,1.7)--(1.4,1.4)--(1.6,1.6));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((390,790)..tension 1.5..(370,320)..(430,40),
    (1.2,1.2)--(1.1,1.1)--(1.3,1.3));
  set_boserif(0,0,8);

  push_stroke((640,540)..tension 1.2..(510,260)..(230,110){left}..
      (220,360)..(660,410)..(810,220)..{curl 0}(560,10),
    (1.5,1.5)--(1.4,1.4)--(1.2,1.2)--
      (1.7,1.7)--(1.8,1.8)--(1.6,1.6)--(1,1));
  set_boserif(0,0,5);
  expand_pbox;
enddef;

vardef hira.i =
  push_pbox_toexpand("hira.i");

  push_stroke((150,640)..(165,566)..(220,250)..(310,110)..{curl 0.1}(430,220),
    (1.6,1.6)..(1.6,1.6)..(1.3,1.3)..(1.8,1.8)..(1,1));
  set_boserif(0,0,5);

  push_stroke((740,620)..(831,470)..(880,290),
    (1,1)..(1.3,1.3)..(1.4,1.4));
  expand_pbox;
enddef;

vardef hira.u_bowl =
  push_pbox_toexpand("hira.u_bowl");

  push_stroke((230,430){dir 355}..(480,510)..(760,340)..{curl 0.1}(420,-20),
    (2.3,2.3)..(2,2)..(1.5,1.5)..(1,1));
  set_boserif(0,0,5);
  expand_pbox;
enddef;

vardef hira.u =
  push_pbox_toexpand("hira.u");

  push_stroke(((370,750)..(0.2[(370,750),(640,660)]+10*down*mincho)..
    tension 2..(640,660)) shifted (25*left*mincho),
    (1,1)..(1.4,1.4)..(2.3,2.3));
  set_boserif(0,2,7);

  hira.u_bowl;
  expand_pbox;
enddef;

vardef hira.e =
  push_pbox_toexpand("hira.e");

  push_stroke(((390,740)..(0.2[(390,740),(620,670)]+20*down*mincho)..
    tension 2..(620,670)) shifted (25*left*mincho),
    (1,1)..(1.4,1.4)..(2.3,2.3));
  set_boserif(0,2,7);

  push_stroke((300,490)..(480,490)..{curl 1}(700,530){curl 1}..
      (510,360)..{curl 1}(200,30){curl 0}..
      (500,250)..(630,150){dir 280}..{dir 5}(820,30),
    (2.2,2.2)--(1.3,1.3)--(1,1)--(2.01,2.01)
      --(1,1)--(1.7,1.7)
      --(1.2,1.2)--(1.4,1.4)--(2,2));
  replace_strokep(0)(insert_nodes(oldp)(1.6));
  set_botip(0,3,0);
  set_botip(0,5,0);
  set_boserif(0,0,5);
  set_boserif(0,3,4);
  set_boserif(0,5,4);
  set_boserif(0,8,6);
  expand_pbox;
enddef;

vardef hira.o =
  push_pbox_toexpand("hira.o");

  push_stroke((150,580){right}..(600,630),
    (1.8,1.8)..(1.8,1.8));
  set_boserif(0,0,5);
  set_boserif(0,1,6);

  push_stroke((380,750)..(380,120){down}..(310,50){left}..tension 1.1..
      (140,220)..(290,370)..(810,180)..{curl 0}(560,40),
    (1.4,1.4)..(1.3,1.3)..(1,1)..(1.5,1.5)..(1.6,1.6)..
      (1.6,1.6)..(1,1));
  set_boserif(0,0,8);

  push_stroke((720,730)..(815,630)..(880,540),
    (1,1)..(1.4,1.4)..(1.8,1.8));
  set_boserif(0,2,4);
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA KAKIKUKEKO/GAGIGUGEGO

vardef hira.ka =
  push_pbox_toexpand("hira.ka");

  push_stroke(((110,520)+20*mincho*down){curl 0}..(470,530)..(590,450)..
      tension 2..(540,90)..{curl 0.3}(370,50),
    (2.3,2.3)..(1.7,1.7)..(1.4,1.4)..(1.8,1.8)..(1,1));
  set_boserif(0,0,5);

  push_stroke((370,780)..(240,250)..(140,30),
    (1.3,1.3)..(1.2,1.2)..(1.6,1.6));
  set_boserif(0,0,8);

  push_stroke((720,620)..((840,440)+35*mincho*(dir -30))..(920,290),
    (0.8,0.8)..(1.4,1.4)..(1.6,1.6));
  set_boserif(0,2,7);
  expand_pbox;
enddef;

vardef hira.ki_body =
  push_pbox_toexpand("hira.ki_body");

  push_stroke((410,790)..(570,460)..{curl 1}(730,220){curl 1}..
      (450,300)..(270,180)..(420,40)..(680,30),
    (1.4,1.4)--(1.2,1.2)--(2.3,2)--(0.60,1)..(0.9,1.1)..
      (2.1,2.1)..(2.4,2.4));
  set_botip(0,2,0);
  set_boserif(0,0,8);
  set_boserif(0,6,6);
  expand_pbox;
enddef;

vardef hira.ki =
  push_pbox_toexpand("hira.ki");

  push_stroke((200,610)..(450,640)..(690,720),
    (1.6,1.6)--(1.4,1.4)--(1.9,1.9));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((200,440)..(490,470)..(800,560),
    (1.9,1.9)--(1.5,1.5)--(1.9,1.9));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  hira.ki_body;
  expand_pbox;
enddef;

vardef hira.ku =
  push_pbox_toexpand("hira.ku");

  push_stroke((640,760)..(510,610)..(340,450)..
      tension 0.75..(340,370)..(530,190)..(670,10),
    (1.9,1.9)..(1.6,1.6)..(1.2,1.2)..(1.2,1.2)..(1.7,1.7)..(2.1,2.1));
  set_boserif(0,0,5);
  expand_pbox;
enddef;

vardef hira.ke =
  push_pbox_toexpand("hira.ke");

  hira.ni_left;

  push_stroke((390,500+15*mincho)..(470,485-5*mincho)..(600,490)..(880,540),
    (1,1)..(1.4,1.4)..(1.8,1.8)..(2,2));
  set_boserif(0,3,6);

  push_stroke((690,770)..tension 2..(700,210)..(280,-10),
    (1.6,1.6)--(1.4,1.4)--(0.6,0.6));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.ko =
  push_pbox_toexpand("hira.ko");

  push_stroke((280,650)..(460,640)..{curl 1}(720,670){curl 1}..
      (450,500)..(330,70)..tension 2.4..(820,60),
    (1.8,1.8)--(1.9,1.9)--(2.3,2.3)--
      (0.35,0.25)--(2.2,1.8)..(2.8,2.4));
  set_botip(0,2,0);
  set_boserif(0,5,6);
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA SASHISUSESO/ZAJIZUZEZO

vardef hira.sa =
  push_pbox_toexpand("hira.sa");

  push_stroke((170,520)..(300,530-20*mincho)..(470,560)..(800-70*mincho,660),
    (1.9,1.9)--(1.8,1.8)--(1.4,1.4)--(2.1,2.1));
  set_boserif(0,3,6);

  hira.ki_body;
  expand_pbox;
enddef;

vardef hira.shi =
  push_pbox_toexpand("hira.shi");

  push_stroke((300,750){down}..tension 2.5..(280,160)..
      (600,20)..tension 1.5..{curl 0}(990,400),
    (1.7,1.7)..(1.6,1.6)--(1.5,1.5)--(0.4,0.55));
  set_boserif(0,0,5);
  expand_pbox;
enddef;

vardef hira.su =
  push_pbox_toexpand("hira.su");

  push_stroke((110,620)..(0.4[(110,620),(890,630)]+15*up*mincho)..(890,630),
    (2.2,2.2)--(1.9,1.9)--(2.2,2.2));
  set_boserif(0,0,5);

  push_stroke((320,330)..(430,470)..(570,300)..{curl 0}(270,-150),
    (1.3,1.3)--(1.7,1.7)--(1.3,1.3)--(1.7,1.7)--(1.6,1.6)--(0.7,0.7));
  replace_strokep(0)((point 1.9 of oldp)..(380,220)..oldp);

  push_stroke((570,790){down}..(point 3.7 of get_strokep(0)),
    (1.6,1.6)..(1.4,1.4));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.se =
  push_pbox_toexpand("hira.se");

  push_stroke((90,470)..(570,500)..(900,540),
    (2,2)..(1.6,1.6)..(2,2));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke(insert_nodes((660,780)..tension 1.5..(655+5*mincho,370)..
      (600,260-20*mincho)..{curl 0.2}(520,280))(2.5),
    (1.7,1.7)--(1.5,1.5)--(1.3,1.3)--(1.2,1.2)--(1,1));
  set_boserif(0,0,8);

  push_stroke((290,710)..(290,170){down}..(500,30)..
      {direction infinity of get_strokep(-1)}(800,50),
    (1.8,1.8)--(1.5,1.5)--(1.7,1.7)--(1.8,1.8));
  set_boserif(0,0,8);
  set_boserif(0,3,6);
  expand_pbox;
enddef;

vardef hira.so =
  push_pbox_toexpand("hira.so");

  push_stroke(
    (210+60*mincho,690)..tension 1.2..(550,700)..
      {curl 0}(700,740){curl 1}..
      (510,580)..
      {curl 1}(130,400){curl 2}..(340,440)..(640,470)..
      {curl 1}(870,510){curl 0}..tension 1.2..(450,200)..{curl 0.2}(760,-10),
    (2.3,2.3)--(1.7,1.7)--(1.8,1.8)--
      (1.2,1.2)--
      (2.1,2.1)--(1.9,1.9)--(1.7,1.7)--(1.5,1.5)--
      (1.4,1.4)--(2.3,2.3));
  set_botip(0,2,0);
  set_botip(0,4,0);
  set_botip(0,7,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);
  set_boserif(0,4,6);
  set_boserif(0,7,6);
  set_boserif(0,9,6);
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA TACHITSUTETO/DAJIZUDEDO

vardef hira.ta_left =
  push_pbox_toexpand("hira.ta_left");

  push_stroke((120,600)..(340,600-20*mincho)..tension 1.5..(610,620),
    (1.6,1.6)..(1.5,1.5)..(1.7,1.7));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((430,800)..(320,440)..(130,20),
    (1.4,1.4)..(1.3,1.3)..(1.6,1.6));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.ta =
  push_pbox_toexpand("hira.ta");

  hira.ta_left;

  push_stroke((520,370)..(690,420+20*mincho)..{curl 1.5}(860,440){curl 0}..
      (610,280+60*mincho)..(520,80)..tension 1.2 and 3..
      {curl 0.2}(910-70*mincho,30),
    (1.1,1.1)--(1.6,1.6)--(2.8,0.99)--(0.45,0.35)--(1.1,1.1)--(1.9,1.9));
  set_botip(0,2,0);
  set_boserif(0,5,6);
  expand_pbox;
enddef;

vardef hira.chi_bottom =
  replace_strokep(0)((oldp){-direction infinity of oldp xscaled 2}..
    (460,350)..(610,380){right}..(830,150)..
    tension 1.4..{curl 0.3}(390,30));
  replace_strokeq(0)((oldq)..(1.3,1.3)..(1.5,1.5)..(1.5,1.5)..(1,1));
enddef;

vardef hira.chi =
  push_pbox_toexpand("hira.chi");

  push_stroke((120,590)..(420,590)..(700-60*mincho,630),
    (1.7,1.7)..(1.5,1.5)..(1.6,1.6));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((370,780)..(320-25*mincho,330)..(290,220),
    (1.6,1.6)..(1.4,1.4)..(1.5,1.5));
  hira.chi_bottom;
  set_botip(0,2,0);
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.tsu =
  push_pbox_toexpand("hira.tsu");

  begingroup
    save xf;
    transform xf;
    (300,450) transformed xf=(220,560);
    (750,350) transformed xf=(820,440);
    (400,0) transformed xf=(400,150);
    tsu_xform(xf)(hira.u_bowl);
    set_bosize(0)(100+10*mincho);
  endgroup;
  expand_pbox;
enddef;

vardef hira.te =
  push_pbox_toexpand("hira.te");

  push_stroke((100,580)..(570,660)..{curl 1}(860,670){curl 0.2}..
    (380,270)..{curl 0.6}(760,10),
    (1.9,1.9)--(1.5,1.5)--(1.8,1.8)--(1.5,1.5)--(1.8,1.8));
  set_botip(0,2,0);
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  set_boserif(0,4,6);
  expand_pbox;
enddef;

vardef hira.toh =
  push_pbox_toexpand("hira.toh");

  push_stroke((770,570)..tension 1.7..(340,380)..(430,50)..
      tension 2..(780,40),
    (2,2)--(1.2,1.2)--(2.1,2.1)--(2,2));
  set_boserif(0,0,5);
  set_boserif(0,3,6);

  push_stroke(subpath (0,1.97) of
      ((360,780-40*mincho)..(370,630)..(point 0.7 of get_strokep(0))),
    (1.4,1.4)--(1.3,1.3)--(1.1,1.1));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA NANINUNENO

vardef hira.na =
  push_pbox_toexpand("hira.na");

  hira.ta_left;
  replace_strokep(-1)(subpath (0,1.8) of oldp);

  push_stroke((730,640)..(820,570)..(900,480),
    (1,1)..(1.3,1.3)..(1.9,1.9));

  hira.ha_right;

  replace_strokep(0)(((120,0)+point 0 of oldp)
    ..(subpath (0.45+0.1*mincho,infinity) of oldp));
  replace_strokeq(0)((-0.2,-0.4)--(1.7,1)--(1.5,1.5)--(2,2)--
    (1.1,1.1)--(1.9,1.9));
  expand_pbox;
enddef;

vardef hira.ni_left =
  push_pbox_toexpand("hira.ni_left");

  push_stroke((220,720)..(150,230){down}..tension 1.5..(210,40)..
      tension 1.5..{curl 0}(320,100),
    (1.5,1.5)..(1.2,1.2)..(1.8,1.8)..(1,1));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  replace_strokeq(0)(insert_nodes(oldq)(0.5));
  set_boserif(0,0,5);
  expand_pbox;
enddef;

vardef hira.ni =
  push_pbox_toexpand("hira.ni");

  hira.ni_left;

  push_stroke((450+30*mincho,610)..(630,630)..(820,630),
    (1,1)..(1.9,1.9)..(2.2,2.2));

  push_stroke((point infinity of get_strokep(0)){curl 0.6}..(530,460)..
      (460,220)..(620,70)..tension 2..(870-80*mincho,70),
    (3,0.7)--(0,0)--(0.8,0.9)--(2,2)--(1.9,1.9));
  set_boserif(0,4,6);
  expand_pbox;
enddef;

vardef hira.nu_curl =
  begingroup
    push_pbox_explicit("hira.nu_curl",
      identity xyscaled (420,240) shifted (540,0));
    (680,40)..(580,140)..(640,200)..{curl 0}(920,70)
  endgroup
enddef;

vardef hira.nu =
  push_pbox_toexpand("hira.nu");

  hira.me;

  replace_strokep(0)((subpath (0,4.8) of oldp)..tension 1.2..
    hira.nu_curl);
  replace_strokeq(0)((1.5,1.5)--(1.4,1.4)--(1.6,1.6)--(1.4,1.4)--
    (1.6,1.6)--(1.6,1.6)--(1.7,1.7)--(1.3,1.3)--(1.6,1.6));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.ne =
  push_pbox_toexpand("hira.ne");

  hira.wa;

  replace_strokep(0)((subpath (0,6.1) of oldp)..tension 1.2..
    hira.nu_curl);
  replace_strokeq(0)((2,2)--(1.6,1.6)--(2.2,0.9)--(0.7,0.7)--(0.97,0.97)--
    (2,2)--(1.5,1.5)--(1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(1.3,1.3));
  expand_pbox;
enddef;

vardef hira.no =
  push_pbox_toexpand("hira.no");

  begingroup
    save px,py;
    path px,py;
    px:=(410,30)..(130,250)..tension 1.1..(570,670)..(870,400)..cycle;
    py:=(510,770){down}..{dir 215}(330,150);

    px:=subpath (0.85,4) of px;
    push_stroke(
        (subpath (xpart (py intersectiontimes px),infinity) of py)..px,
      (1.6,1.6)--(1.3,1.3)--(1.4,1.4)--(1.5,1.5)--(1.8,1.8)--
        (1.4,1.4)--(0.7,0.7));
  endgroup;
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA HAHIFUHEHO/BABIBUBEBO/PAPIPUPEPO

vardef hira.ha_right =
  push_pbox_explicit("hira.ha_right",
    identity xyscaled (610,790) shifted (360,-10));

  push_stroke(insert_nodes((660,740)..(660,150){down}..(550,30)..(440,120)..
      (570,210)..{curl 0.17}(890,100))(4.2),
    (1.6,1.6)--(1.4,1.4)--(1.6,1.6)--(1.3,1.3)--
      (2,2)--(1.6,1.6)--(1.7,1.7));
enddef;

vardef hira.ha =
  push_pbox_toexpand("hira.ha");

  hira.ni_left;

  push_stroke((400+60*mincho,550)..(610,540)..(860-50*mincho,560),
    (1.6,1.6)..(1.6,1.6)..(2,2));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  hira.ha_right;
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.hi =
  push_pbox_toexpand("hira.hi");

  push_stroke(((100,560)+60*mincho*dir 30)..(290,600)..
      {curl 1}(470,680){curl 1}..
      tension 1.3..(200,250)..(590,100)..tension 1.3..
      {curl 1}(730,570){curl 1}..(770,420)..(880,200),
    (1.8,1.8)--(1.7,1.7)--(1.5,1.5)--
      (1.4,1.4)--(1.4,1.4)--(1.4,1.4)--(1.3,1.3)--(1.5,1.5));
  set_botip(0,2,0);
  set_botip(0,5,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);
  set_boserif(0,5,4);
  expand_pbox;
enddef;

vardef hira.fu =
  push_pbox_toexpand("hira.fu");

  push_stroke((370,740)..(530,680)..(610,630),
    (1,1)--(1.7,1.7)--(1.8,1.8));
  set_boserif(0,2,4);

  push_stroke((610,630)..tension 1.4..(410,570)..(410,470)..
      (570,200)..(470,20)..{curl 0.3}(290,270),
    (2.6,0.79)--(0.72,0.72)--(0.85,1.35)--(1.5,1.5)--(2,2)--(0,0));

  push_stroke((90+30*mincho,80)..(270,320){dir 63}..(480,410)..
      {curl 0}(910,100),
    (1.4,1.7)--(0.9,0.9)--(0.7,0.7)--(1.6,1.6));
  set_boserif(0,0,5);
  set_boserif(0,3,8);
  expand_pbox;
enddef;

vardef hira.he =
  push_pbox_toexpand("hira.he");

  push_stroke((90+40*mincho,290){curl 0.2}..(280,430)..tension 2..(380,540)..
      (420,530)..tension 2..(620-10*mincho,360)..{curl 0.2}(910-40*mincho,190),
    (1.7,1.7)..(1.6,1.6)..(1.2,1.2)..(1.3,1.3)..(1.7,1.7)..(2.1,2.1));
  set_boserif(0,0,5);
  expand_pbox;
enddef;

vardef hira.ho =
  push_pbox_toexpand("hira.ho");

  hira.ni_left;

  push_stroke((380,700)..(610-40*mincho,700)..(850-40*mincho,720),
    (1.2,1.2)..(1.6,1.6)..(1.9,1.9));
  set_boserif(0,2,6);

  push_stroke((360+20*mincho,490)..(570-30*mincho,490)..(880-40*mincho,520),
    (1.2,1.2)..(1.5,1.5)..(2,2));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  hira.ha_right;
  replace_strokep(0)(subpath
    (xpart (oldp intersectiontimes get_strokep(-2))+0.02,infinity) of oldp);
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA MAMIMUMEMO

vardef hira.ma_stem =
  push_pbox_toexpand("hira.ma_stem");

  begingroup
    transform xf;

    (660,0) transformed xf = (510,0);
    (660,740) transformed xf = (510,800);
    (910,0) transformed xf = (830,0);

    tsu_xform(xf)(hira.ha_right);
    set_boserif(0,0,8);
  endgroup;
  expand_pbox;
enddef;

vardef hira.ma =
  push_pbox_toexpand("hira.ma");

  push_stroke((190+20*mincho,630)..(290,625-20*mincho)..tension 1.3..
      (490,620-20*mincho)..(810-50*mincho,650),
    (1.3,1.3)--(1.4,1.4)--(1.7,1.7)--(1.9,1.9));
  set_boserif(0,0,5);
  set_boserif(0,3,6);

  push_stroke((220+10*mincho,420+20*mincho)..(280,420)..tension 1.3..
      (570,420)..(780-50*mincho,440+20*mincho),
    (1.3,1.3)--(1.3,1.3)--(1.6,1.6)--(1.8,1.8));
  set_boserif(0,0,5);
  set_boserif(0,3,6);

  hira.ma_stem;
  expand_pbox;
enddef;

vardef hira.mi_base =
  push_pbox_toexpand("hira.mi_base");

  push_stroke(
    (220+70*mincho,670)..tension 1.3..(460,680)..
      {curl 1}(540,730){curl 1}..
      (480,460)..(340,140)..(220,50)..(130,200)..(420,350)..
      {curl 0.4}(890,100),
    (1.7,1.7)--(1.3,1.3)--(1.6,1.6)--
      (1.5,1.5)--(1.2,1.2)--(1.5,1.5)--(1.4,1.4)--(1.6,1.6)--
      (1.8,1.8));
  set_botip(0,2,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);
  expand_pbox;
enddef;

vardef hira.mi =
  push_pbox_toexpand("hira.mi");

  hira.mi_base;

  push_stroke((790,420)..(725,220)..(620,30),
    (1.3,1.3)--(1.5,1.5)--(1,1));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.mu =
  push_pbox_toexpand("hira.mu");

  push_stroke((100+40*mincho,610)..(340,610)..(500-30*mincho,640),
    (1.6,1.6)--(1.4,1.4)--(1.5,1.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((260,440)..(350,300)..(170,200)..(130,330)..cycle,
    (1.3,1.3)..(1.6,1.6)..(1.3,1.3)..(1.6,1.6)..cycle);

  push_stroke((310,780){down}..(300,520)..
      (point 0.5 of get_strokep(0)){direction 0.5 of get_strokep(0)},
    (1.6,1.6)--(1.5,1.5)--(1.2,1.2));
  set_boserif(0,0,8);

  push_stroke(
    (point 1.25 of get_strokep(-1)){direction 1.20 of get_strokep(-1)}..
      (260,90)..(400,30){right}..(650,40)..(750,270)..
      tension 2..(600,590)..(700,610)..(910,430),
    (1.4,1.4)--(1.5,1.5)--(1.8,1.8)--(1.9,1.9)--
      (1,1)--(0.6,0.6)--(1,1)--(1.6,1.6));
  set_boserif(0,7,8);
  expand_pbox;
enddef;

vardef hira.me =
  push_pbox_toexpand("hira.me");

  push_stroke((230,690)..(330,300)..(450,110),
    (1.4,1.4)--(1.3,1.3)--(1.4,1.4));

  push_stroke((580,780){curl 0.2}..tension 2.5..(190,90)..
      (150,100)..(110,250)..tension 1.1..(630,580)..
      (850,200)..tension 1.1..{curl 0.2}(470,-30),
    (1.5,1.5)--(1.4,1.4)--(1.6,1.6)--(1.4,1.4)--
      (1.6,1.6)--(1.6,1.6)--(0.65,0.65));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.mo =
  push_pbox_toexpand("hira.mo");

  push_stroke((460,780)..tension 3..(350,170)..(470,20)..
      tension 1.2..(660,20)..(790,150)..{curl 0}(770,460),
    (1.7,1.7)--(1.4,1.4)--(1.6,1.6)--(1.7,1.7)--(1.4,1.4)--(0.6,0.6));
  set_boserif(0,0,8);

  push_stroke((160,590)..(260,580-20*mincho)..(440,580)..
      (660-40*mincho,600+30*mincho),
    (1.4,1.4)--(1.6,1.6)--(1.8,1.8)--(2,2));
  set_boserif(0,0,5);
  set_boserif(0,3,6);

  push_stroke((160,390+10*mincho)..(260,380-20*mincho)..(450,370)..
      (630-45*mincho,380+30*mincho),
    (1.4,1.4)--(1.6,1.6)--(1.8,1.8)--(2,2));
  set_boserif(0,0,5);
  set_boserif(0,3,6);
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA YAYUYO

vardef hira.ya =
  push_pbox_toexpand("hira.ya");

  push_stroke((110,400)..(690,570)..(870,450)..(690,330)..(520,400),
    (1.8,1.8)--(1.6,1.6)--(1.4,1.4)--(1.8,1.8)--(0.6,0.6));
  set_boserif(0,0,5);

  push_stroke((575,750)--(620,475),
    (1.1,1.1)--(1.6,1.6));
  set_boserif(0,1,4);

  push_stroke((230,680)..tension 2..(420,320)..(570,-30),
    (1.6,1.6)--(1.4,1.4)--(1.7,1.7));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.yu =
  push_pbox_toexpand("hira.yu");

  push_stroke((190,710){down}...(170,340)..(190,120),
    (1.6,1.6)--(1.4,1.4)--(1.5,1.5));
  set_boserif(0,0,5);

  push_stroke((point 1.7 of get_strokep(0))
        {-direction 1.7 of get_strokep(0)}..(210,330)..
      (320,500)..(590,620)..(850,390)..(620,190)..tension 1.3..(320,320),
    (1.4,1.4)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--(1.6,1.6)--
      (1.6,1.6)--(0.77,0.77));

  push_stroke((580,780){down}...(590,300)..{dir 190}(360,-85),
    (1.6,1.6)--(1.5,1.5)--(0.6,0.6));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef hira.yo =
  push_pbox_toexpand("hira.yo");

  hira.ma_stem;

  replace_strokep(0)(oldp shifted (-20,0));
  z0=point 0.4 of get_strokep(0);

  push_stroke(z0..(z0+(160,20))..(z0+(280,60)+60*mincho*dir 200),
    (1.2,1.2)--(1.4,1.4)--(1.8,1.8));
  set_boserif(0,2,6);
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA RARIRURERO

vardef hira.ra =
  push_pbox_toexpand("hira.ra");

  push_stroke((370,770)..(500,720)..{curl 1}(620,640){curl 0.1}..
      (430,650)..(370,580)..(330,400)..(310,220),
    (1,1)--(1.6,1.6)--(2,0.78)--(0.55,0.55)--
      (1.8,1)--(1.4,1.4)--(1.6,1.6));
  set_boserif(0,2,4);

  hira.chi_bottom;
  set_botip(0,2,0);

  replace_strokep(0)(oldp shifted (-60,0));
  expand_pbox;
enddef;

vardef hira.ri =
  push_pbox_toexpand("hira.ri");

  begingroup
    save ripx,ripy,ripz,x,y;
    path ripx,ripy,ripz;
    numeric x[],y[];
    z1=(290,740);
    z2=(280,550);
    z3=(340,270-30*mincho);
    z4=(420-40*mincho,370);
    z5=(540,710);
    z6=(700,730);
    ripx=z1..z2{down}..tension 1.5..z3..
      tension 1.5..z4..z5..z6..tension 5 and 1.2..
      (690,290)..tension 0.75 and 1..{curl 0.45}(420,0);
    ripy=z1..z2{down}..tension 1.5..{curl 1}z3{curl 1}..
      tension 1.5..z4..z5..z6..tension 5 and 1.2..
      (690,290)..tension 0.75 and 1..{curl 0.45}(420,0);
    push_stroke(interpath(mincho,ripx,ripy),
      (1.3,1.3)--(1.6,1.6)--(1.4,1.4)--(1.2,1.2)--(0.4,0.2)--
      (1.5,0.99)--(1.6,1.6)--(1,1));
    set_boserif(0,0,8);
  endgroup;
  expand_pbox;
enddef;

vardef hira.ru =
  push_pbox_toexpand("hira.ru");

  hira.ro;

  replace_strokep(0)((subpath (0,7.8) of oldp)..(350,100)..(530,160)..
    {curl 0.2}(point 7.6 of oldp));
  replace_strokeq(0)((2.6,2.6)--(1.2,1.2)--(1.9,1.9)--
    (1.3,1.3)--(1.6,1.6)--
    (1.5,1.5)--(1.9,1.9)--(1.6,1.6)--
    (1.2,1.2)--(1.5,1.5)--(1.4,1.4));
  expand_pbox;
enddef;

vardef hira.re =
  push_pbox_toexpand("hira.re");

  hira.wa;

  replace_strokep(0)((subpath (0,4) of oldp){curl 0}..
    tension 2..(740,550)..(800,420)..
    (830,40){right}..tension 1.5..{curl 0}(960,270));
  replace_strokeq(0)((2,2)--(1.6,1.6)--(2.7,0.9)--
    (0.84,0.7)--(0.79,0.97)--
    (2.1,2.1)--(1.6,1.6)--(1.5,1.5)--(0.5,0.5));
  set_boserif(0,2,4);
  expand_pbox;
enddef;

vardef hira.ro =
  push_pbox_toexpand("hira.ro");

  push_stroke((230+110*mincho,650)..(580,690)..{curl 1}(690,720){curl 1}..
      (410,450)..{curl 1}(200,260){curl 1}..
      (400,370)..(590,400){right}..(810,230)..
      tension 1.1..{curl 0}(390,10),
    (2.6,2.6)--(1.2,1.2)--(1.9,1.9)--
      (1.3,1.3)--(1.6,1.6)--
      (1.5,1.5)--(1.7,1.7)--(1.5,1.5)--(1,1));
  set_botip(0,2,0);
  set_botip(0,4,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);
  set_boserif(0,4,4);
  expand_pbox;
enddef;

%%%%%%%%%% HIRAGANA WAWIWEWO/N/ITERATION

vardef hira.wa =
  push_pbox_toexpand("hira.wa");

  push_stroke((330,790)--(0.7[(330,790),(330,-20)])--(330,-20),
    (1.5,1.5)--(1.2,1.2)--(1.6,1.6));
  set_boserif(0,0,8);
  set_boserif(0,2,5);

  push_stroke(((110,520)+100*mincho*dir -15)..tension 2..(340,530)..
      {curl 1}(450,560){curl 1}..
      (270,340)..{curl 1}(120,140){curl 0.2}..
      (680,490){right}..(870,300)..{curl 0.2}(450,0),
    (2,2)--(1.6,1.6)--(2.2,0.9)--
      (0.7,0.7)--(0.97,0.97)--
      (2,2)--(1.6,1.6)--(0.8,0.8));
  set_botip(0,2,0);
  set_botip(0,4,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);
  expand_pbox;
enddef;

vardef hira.wi =
  push_pbox_toexpand("hira.wi");

  hira.mi_base;

  replace_strokep(0)((subpath (0,6) of oldp)..(570,450)..(860,210)..(680,20)..
    (520,120)..tension 1.2..(710,160));
  replace_strokep(0)(oldp..{curl 0.3}(point 8.6 of oldp));

  replace_strokeq(0)((1.7,1.7)--(1.3,1.3)--(1.6,1.6)--
    (1.5,1.5)--(1.2,1.2)--(1.5,1.5)--(1.4,1.4)--
    (1.6,1.6)--(1.5,1.5)--(1.7,1.7)--(1.4,1.4)--(1.5,1.5));
  expand_pbox;
enddef;

vardef hira.we =
  push_pbox_toexpand("hira.we");

  push_stroke((220+80*mincho,710-20*mincho)..(470,710)..{curl 1}(660,740)--
      (200,440){curl 1}..
      (600,540)..(760,420)..(430,260)..(320,330)..(470,390)..(470,310)..
      (270,130)..{curl 0}(90,-10){curl 0.1}..
      (400,110)..{down}(520,-20){up}..
      (680,140)..tension 1.3..{curl 0.2}(910,-10),
    (1.8,1.8)--(1.6,1.6)--(1.5,1.5)--(1.9,1.9)--
      (2,2)--(1.6,1.6)--(1.7,1.7)--(1.2,1.2)--(1.3,1.3)--(1.35,1.35)--
         (1.4,1.4)--(1.5,1.5)--(1.3,1.3)--(1.8,1.8)--
      (1.4,1.4)--(1.5,1.5)--
      (1.3,1.3)--(1.7,1.7));
  replace_strokep(0)(insert_nodes(oldp)(8.5,9.5));
  set_bosize(0,90);
  set_botip(0,2,0);
  set_botip(0,3,0);
  set_botip(0,13,0);
  set_botip(0,15,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);
  set_boserif(0,3,4);
  set_boserif(0,13,4);
  set_boserif(0,17,7);
  expand_pbox;
enddef;

vardef hira.wo =
  push_pbox_toexpand("hira.wo");

  push_stroke((160,640)..(460,640)..(670,660),
    (1.3,1.3)--(1.4,1.4)--(1.6,1.6));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((470,800)..(370,580)..{curl 1}(220,370){curl 0.1}..
    (490,460)..{curl 0}(570,190),
    (1.4,1.4)--(1.3,1.3)--(1.5,1.5)--(1.01,1.01)--(1.4,1.4));
  set_botip(0,2,0);
  set_boserif(0,0,8);

  push_stroke((840,450){curl 0.017}..tension 1 and 2..(360,120)..
    tension 2 and 1..{curl 0.03}(770,30),
    (1.7,1.7)--(1.4,1.4)--(1.7,1.7));
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  expand_pbox;
enddef;

vardef hira.n =
  push_pbox_toexpand("hira.n");

  push_stroke((520,750)..(330,450)..{curl 0.2}(140,20){curl 0.1}..
    tension (1.2+0.6*mincho)..(460+50*mincho,370){right}..
       (580,210)..(690,30){right},
   (1.7,1.7)--(1.2,1.2)--(1.3,1.3)--
     (1.1,1.1)--(1.5,1.5)--(1.9,1.9)--(1,1));
  replace_strokep(0)(oldp{right}..(880,200){-direction 0.5 of oldp});
  replace_strokep(0)(insert_nodes(oldp)(1.7,2.3));
  replace_strokeq(0)(insert_nodes(oldq)(1.7,2.3));
  set_botip(0,3,0);
  set_boserif(0,0,5);
  set_boserif(0,3,4);
  expand_pbox;
enddef;

vardef hira.iteration =
  push_pbox_toexpand("hira.iteration");

  push_stroke(begingroup
    save ripx,ripy;
    path ripx,ripy;
    ripx:=(300,600){curl 0.2}..(560,440)..
      tension 1.5 and 2..(670,300)..
      tension 2 and 1.5..(530,190)..{curl 0.2}(370,130);
    ripy:=(300,600){curl 0.2}..(560,440)..
      tension 1.5..{curl 1}(690,180){curl 1}..
      tension 2 and 1.5..(570,240)..tension 1.4..{curl 0}(360,130);
    interpath(mincho,ripx,ripy)
  endgroup,
    (1,1)--(1.5,1.5)--(2,2)--(1.9,1.9)--(1,1));
  set_botip(0,2,0);
  expand_pbox;
enddef;

vardef hira.yori =
  push_pbox_toexpand("hira.yori");

  push_stroke((520,750)..(330,450)..{curl 0.2}(140,20){curl 0.1}..
    tension (1.2+0.6*mincho)..(510+50*mincho,420){right}..
       (630,210)..(430,-30){left}..tension 1.3..(290,600)..
       {curl 0.1}(840,530){curl 1}..(720,550)..(600,530),
    (1.7,1.7)--(1.2,1.2)--(1.3,1.3)--
     (1.1,1.1)--
     (1.5,1.5)--(1.5,1.5)--(-1,-0.4)--
     (1.8,1.6)--(1.6,0.7)--(1.9,0));
  replace_strokep(0)(insert_nodes(oldp)(1.7,2.3));
  replace_strokeq(0)(insert_nodes(oldq)(1.7,2.3));
  set_botip(0,3,0);
  set_botip(0,9,0);
  set_boserif(0,0,5);
  set_boserif(0,3,4);
  expand_pbox;
enddef;
