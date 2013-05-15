%
% Katakana for Tsukurimashou
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

inclusion_lock(katakana);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% KATAKANA VOWELS

vardef kata.a =
  push_pbox_toexpand("kata.a");

  kata.fu_stroke((160,650),(870,660),(525,370));

  push_stroke((460,490)..(410,220)..(290,0),
    (1.8,1.8)--(1.7,1.7)--(1.2,1.2));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef kata.i =
  push_pbox_toexpand("kata.i");

  push_stroke((740,760)..(510,470)..(140,280),
    (1.8,1.8)--(1.7,1.7)--(1.2,1.2));
  set_boserif(0,0,8);

  push_stroke((get_strokep(0) intersectionpoint
      ((530,-infinity)--(530,infinity)))--(530,-10),
    (1.4,1.4)--(1.6,1.6));
  expand_pbox;
enddef;

vardef kata.u =
  push_pbox_toexpand("kata.u");

  push_stroke((480,790)--(480,580),
    (1.7,1.7)--(1.4,1.4));
  set_boserif(0,0,8);

  kata.fu_stroke((220,580),(780,580),(340,20));
  if mincho>0.01:
    replace_strokep(0)((220,350)--(220,580)--oldp);
    replace_strokeq(0)((1.4,1.4)--(1.7,1.7)--oldq);
    set_botip(0,2,1);
    set_botip(0,4,0);
    set_boserif(0,2,whatever);
    set_boserif(0,4,4);
  else:
    replace_strokep(0)((220,350)--oldp);
    replace_strokeq(0)((1.4,1.4)--oldq);
    set_botip(0,1,1);
    set_botip(0,3,0);
    set_boserif(0,3,4);
  fi;
  set_boserif(0,0,whatever);
  set_boserif(0,1,8);
  expand_pbox;
enddef;

vardef kata.e =
  push_pbox_toexpand("kata.e");

  kata.ni;

  push_stroke((point 1 of get_strokep(-1))--(point 1 of get_strokep(0)),
    (1.5,1.5)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kata.o =
  push_pbox_toexpand("kata.o");

  push_stroke((130+100*mincho,570)--(870-90*mincho,570),
    (1.8,1.8)--(1.6,1.6));
  set_boserif(0,0,5);
  set_boserif(0,1,6);

  kata.ho_centre((610,790),(610,20));

  kata.no_stroke((550,570),(110,130));
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA KAKIKUKEKO/GAGIGUGEGO

vardef kata.ka =
  push_pbox_toexpand("kata.ka");

  kata.ho_centre((750,550),(700,20));

  replace_strokep(0)((130,530)--oldp);
  replace_strokeq(0)((1.8,1.8)--oldq);
  set_botip(0,1,1);
  set_botip(0,2,whatever);
  set_botip(0,3,0);
  set_boserif(0,0,5);
  set_boserif(0,1,4);

  kata.no_stroke((460,790),(130,20));
  expand_pbox;
enddef;

vardef kata.ki =
  push_pbox_toexpand("kata.ki");

  push_stroke((410,780)--(560,-10),
    (0.74,2.55)--(1.4,1.4)--(1.5,1.5));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,8);

  push_stroke((180,490)--(740,620),
    (0.6,3)--(1.6,1.6)--(0.6,3));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((180,270)--(830,425),
    (0.6,3)--(1.6,1.6)--(0.6,3));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  expand_pbox;
enddef;

vardef kata.ku =
  push_pbox_toexpand("kata.ku");

  push_stroke((470,780)..(360,540)..(210,380),
    (0.68,2.7)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,5);

  z1=(get_strokep(0) intersectionpoint ((0,600)--(1000,620)))+10*right;
  kata.fu_stroke(z1,(760,620),(280,20));
  set_boserif(0,0,whatever);
  expand_pbox;
enddef;

vardef kata.ke =
  push_pbox_toexpand("kata.ke");

  push_stroke((400,770)..(307,540)..(140,320),
    (0.68,2.7)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,5);

  z1=(get_strokep(0) intersectionpoint ((0,540)--(1000,540)));
  push_stroke(z1--(880,540),(1.5,1.5)--(1.5,1.5)--(0.75,2.85));
  set_boserif(0,1,6);

  kata.no_stroke(point 0.6 of (z1--(880,540)),(310,10));
  replace_strokep(0)(insert_nodes(oldp)(0.2));
  expand_pbox;
enddef;

vardef kata.ko =
  push_pbox_toexpand("kata.ko");

  push_stroke((200,630-20*mincho)--(770,630)--(780,mincho[20,110]),
    (0.78,2.83)--(1.3,1.3)--(1.7,1.7)--(1.4,1.4));
  replace_strokep(0)(insert_nodes(oldp)(0.8));
  set_botip(0,2,1);
  set_boserif(0,0,5);
  set_boserif(0,2,4);

  push_stroke((193,110-20*mincho)--(776,110),
    (0.78,2.83)--(1.4,1.4));
  set_boserif(0,0,5);
  set_boserif(0,1,6);
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA SASHISUSESO/ZAJIZUZEZO

vardef kata.sa =
  push_pbox_toexpand("kata.sa");

  push_stroke((110,520)--(900,540),
    (0.7,3)--(1.7,1.7)--(0.7,3));
  replace_strokep(0)(insert_nodes(oldp)(0.4));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  kata.ri;
  expand_pbox;
enddef;

vardef kata.shi =
  push_pbox_toexpand("kata.shi");

  push_stroke((220,710)..(350,690)..(470,650),
    (1,1)..(1.6,1.6)..(1.8,1.8));

  push_stroke((170,520)..(280,500)..(380,460),
    (1,1)..(1.6,1.6)..(1.8,1.8));

  kata.no_stroke((870,480),(210,30));

  replace_strokeq(0)((0.9,0.9)--(1.1,1.1)--(1.4,1.4)--(2.2,2.2));
  set_boserif(0,4,5);
  expand_pbox;
enddef;

vardef kata.su =
  push_pbox_toexpand("kata.su");

  push_stroke((260,700-30*mincho)--(740,700+20*mincho)..(530,350)..(140,10),
    (1.8,1.8)--(1.3,1.3)--(1.7,1.7)--(1.4,1.4)--(1,1));
  replace_strokep(0)(insert_nodes(oldp)(0.6));
  set_botip(0,2,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);

  push_stroke((point 2.95 of get_strokep(0))..(729,190)..(860,20),
    (1.2,1.2)--(1.6,1.6)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kata.se =
  push_pbox_toexpand("kata.se");

  kata.ya;

  replace_strokep(-1)(oldp shifted (-30,0));

  replace_strokep(0)((360,760)--(360,140){dir 274}..
    (440,70)..tension 2.1..(820,70));
  replace_strokeq(0)((1.6,1.6)--(1.5,1.5)--(1.9,1.9)--(1.8,1.8));
  set_boserif(0,0,8);
  set_boserif(0,3,6);
  expand_pbox;
enddef;

vardef kata.so =
  push_pbox_toexpand("kata.so");

  push_stroke((230,740)..(290,620)..(330,460),
    (1,1)..(1.3,1.3)..(1.8,1.8));

  kata.no_stroke((770,660-10*mincho),(310,20));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA TACHITSUTETO/DAJIZUDEDO

vardef kata.ta =
  push_pbox_toexpand("kata.ta");

  kata.ku;

  numeric x[],y[];
  z1=point 1.25 of get_strokep(-1);
  z3=point 4.9 of get_strokep(0);
  z2=(0.5[z1,z3])+0.05*((z3-z1) rotated 90);
  push_stroke(z1..tension 2..z2..z3,
    (1.2,1.2)--(1.6,1.6)--(1.9,1.9));
  expand_pbox;
enddef;

vardef kata.chi =
  push_pbox_toexpand("kata.chi");

  push_stroke((230,630)..tension 1.3..(540,660)..(750,740),
    (1.2,1.2)--(1.7,1.7)--(2,2));
  set_boserif(0,2,4);

  kata.na_centre;
  replace_strokep(0)(subpath (xpart (oldp intersectiontimes
    get_strokep(-1)),infinity) of oldp);

  push_stroke((130,430)--(870,430),
    (0.7,2.7)--(1.6,1.6)--(0.7,2.7));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  expand_pbox;
enddef;

vardef kata.tsu =
  push_pbox_toexpand("kata.tsu");

  push_stroke((160,660)..(210,570)..(250,450),
    (1,1)..(1.3,1.3)..(1.8,1.8));

  push_stroke((370,730)..(420,640)..(460,490),
    (1,1)..(1.3,1.3)..(1.8,1.8));

  kata.no_stroke((770,680),(310,20));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef kata.te_top =
  push_pbox_toexpand("kata.te_top");

  push_stroke((220,690-10*mincho)--(780,690+10*mincho),
    (0.5,2.9)--(1.6,1.6)--(0.5,2.9));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((110,460-10*mincho)--(890,460+10*mincho),
    (0.6,2.8)--(1.6,1.6)--(0.6,2.8));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  expand_pbox;
enddef;

vardef kata.te =
  push_pbox_toexpand("kata.te");

  kata.te_top;

  kata.na_centre;
  replace_strokep(0)(subpath (xpart (oldp intersectiontimes get_strokep(-1)),
    infinity) of oldp);
  expand_pbox;
enddef;

vardef kata.toh =
  push_pbox_toexpand("kata.toh");

  push_stroke((400,780)--(400,350)--(400,-20),
    (1.6,1.6)--(1.4,1.4)--(1.7,1.7));
  set_boserif(0,0,8);

  push_stroke((400,500)..tension 1.1..(640,405)..(780,300),
    (1.3,1.3)--(1.6,1.6)--(1.8,1.8));
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA NANINUNENO

vardef kata.na_centre =
  push_stroke((530,750){down}..tension 1.2..(510,320)..(180,-30),
    (1.6,1.6)--(1.4,1.4)--(0.78,0.78));
enddef;

vardef kata.na =
  push_pbox_toexpand("kata.na");

  push_stroke((130,530)--(870,530),
    (0.6,2.8)--(1.6,1.6)--(0.6,2.8));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  kata.na_centre;
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef kata.ni =
  push_pbox_toexpand("kata.ni");

  push_stroke((220,600)--(500,600)--(780,600),
    (0.7,2.7)--(1.5,1.5)--(0.7,2.9));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((110,140)--(500,140)--(890,140),
    (0.7,2.7)--(1.5,1.5)--(0.7,2.9));
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  expand_pbox;
enddef;

vardef kata.nu =
  push_pbox_toexpand("kata.nu");

  kata.fu_stroke((260,700),(740,690),(160,10));

  push_stroke((370,440)..(590,310)..(770,90),
    (1.3,1.3)--(1.6,1.6)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kata.ne =
  push_pbox_toexpand("kata.ne");

  kata.fu_stroke((220,610),(780,610),(130,230));

  push_stroke((((510,0)--(510,1000)) intersectionpoint
      reverse get_strokep(0))--(510,-20),
    (1.4,1.4)--(1.6,1.6));

  push_stroke((670,330)..(790,250)..(880,180),
    (1.3,1.3)--(1.6,1.6)--(1.8,1.8));

  push_stroke(get_strokep(0) shifted ((510,800)-point 0.7 of get_strokep(0)),
    get_strokeq(0));
  expand_pbox;
enddef;

vardef kata.no_stroke(expr ur,ll) =
  push_stroke(insert_nodes(ur..tension 1.1..
      (0.65[xpart ll,xpart ur],0.35[ypart ll,ypart ur])..{curl 1.2}ll)(0.3),
    (1.7,1.7)--(1.7,1.7)--(1.4,1.4)--(1.1,1.1));
enddef;

vardef kata.no =
  push_pbox_toexpand("kata.no");

  kata.no_stroke((700,680),(210,20));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA HAHIFUHEHO/BABIBUBEBO/PAPIPUPEPO

vardef kata.ha =
  push_pbox_toexpand("kata.ha");

  push_stroke((350,600)..(250,340)..(110,120),
    (0.7,2.7)--(1.5,1.5)--(1.1,1.1));
  set_boserif(0,0,8);

  push_stroke((620,600)..(750,390)..(870,140),
    (1.2,1.2)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kata.hi =
  push_pbox_toexpand("kata.hi");

  push_stroke((260,760)--(260,140){dir 274}..(340,70)..tension 2.1..(820,70),
    (0.84,2.18)--(1.4,1.4)--(2.1,2.1)--(1.9,1.9));
  set_boserif(0,0,8);
  set_boserif(0,3,6);

  kata.no_stroke((750,600),point 0.45 of get_strokep(0));
  replace_strokeq(0)(oldq shifted (0.1,0.1));
  expand_pbox;
enddef;

vardef kata.fu_stroke(expr ul,ur,ll) =
  kata.no_stroke(ur,ll);
  replace_strokep(0)(insert_nodes(((mincho*0.1)[ul,ur])--oldp)(0.5,1.15));
  replace_strokeq(0)((2,2)--(1.9,1.9)--(1.5,1.5)--oldq);
  set_botip(0,2,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);
enddef;

vardef kata.fu =
  push_pbox_toexpand("kata.fu");

  kata.fu_stroke((160,625),(790,635),(320,20));
  expand_pbox;
enddef;

vardef kata.he =
  push_pbox_toexpand("kata.he");

  push_stroke((120,320)--(440,570)--(880,230),
    (1.8,1.8)--(1.5,1.5)--(1.9,1.9));
  set_botip(0,1,1);
  set_boserif(0,0,5);
  expand_pbox;
enddef;

vardef kata.ho_centre(expr pta,ptb) =
  push_stroke(begingroup
    numeric x[],y[];
    path mycirc,ripx,ripy;
    mycirc:=fullcircle scaled 100 shifted ptb;
    z1=(pta--ptb) intersectionpoint mycirc;
    z2=ptb+(-200,40);
    z3=0.85[z2,z1];
    ripx:=pta{down}..tension 1.6..z3..{curl 0}z2;
    ripx:=pta{down}...(point 0.95 of ripx)..z3..{curl 0}z2;
    z4=1.5[z1,ptb];
    z5=ptb+(-170,90);
    ripy:=pta--z4{z3-z4}..{curl 0}z5;
    ripy:=pta--(point 0.90 of ripy)--z4{z3-z4}..{curl 0}z5;;
    interpath(mincho,ripx,ripy)
  endgroup,
    (1.7,1.7)--(1.5,1.5)--(1.6,1.6)--(0.9,1.6));
  set_botip(0,2,0);
  set_boserif(0,0,8);
enddef;

vardef kata.ho =
  push_pbox_toexpand("kata.ho");

  push_stroke((130,570)--(500,570)--(870,570),
    (0.68,2.92)--(1.8,1.8)--(1.9,1.9));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  kata.ho_centre((520,790),(520,20));

  push_stroke((300,410)..(230,260)..(120,130),
    (1.2,1.2)--(1.5,1.5)--(1.8,1.8));

  push_stroke((710,410)..(790,300)..(870,130),
    (1.2,1.2)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA MAMIMUMEMO

vardef kata.ma =
  push_pbox_toexpand("kata.ma");

  kata.fu_stroke((120,600),(830,610),(200,180));

  push_stroke((320,370)..(480,250)..(640,70),
    (1.3,1.3)--(1.6,1.6)--(1.8,1.8));
  replace_strokep(-1)(subpath (0,xpart (oldp intersectiontimes
    get_strokep(0))) of oldp);
  expand_pbox;
enddef;

vardef kata.mi =
  push_pbox_toexpand("kata.mi");

  push_stroke((280,720)..(590,640)..(750,570),
    (1.4,1.4)--(1.7,1.7)--(1.9,1.9));

  push_stroke((300,460)..(550,390)..(680,330),
    (1.4,1.4)--(1.7,1.7)--(1.9,1.9));

  push_stroke((210,220)..(570,130)..(750,40),
    (1.4,1.4)--(1.7,1.7)--(1.9,1.9));
  expand_pbox;
enddef;

vardef kata.mu =
  push_pbox_toexpand("kata.mu");

  push_stroke((680,370)..(770,230)..(870,40),
    (1.2,1.2)--(1.6,1.6)--(1.9,1.9));

  push_stroke((110,110)..(490,140)..(point 1.2 of get_strokep(0)),
    (1.8,1.8)--(1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,5);

  push_stroke((480,710)..(370,440)..(point 0.3 of get_strokep(0)),
    (1.7,1.7)--(1.5,1.5)--(1.3,1.3));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef kata.me =
  push_pbox_toexpand("kata.me");

  kata.no_stroke((720,730),(160,10));
  set_boserif(0,0,8);

  push_stroke((340,470)..(570,350)..(780,180),
    (1.3,1.3)--(1.6,1.6)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kata.mo =
  push_pbox_toexpand("kata.mo");

  kata.te_top;

  push_stroke((point 0.8 of get_strokep(-1))--
      (xpart point 0.8 of get_strokep(-1),140){dir 274}..
      (80+xpart point 0.8 of get_strokep(-1),70)..tension 2.1..(860,70),
    (1.5,1.5)--(1.6,1.6)--(2,2)--(1.9,1.9));
  set_boserif(0,3,6);
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA YAYUYO

vardef kata.ya =
  push_pbox_toexpand("kata.ya");

  push_stroke((120,460)--(820,600)..(750,430)..(650,310),
    (0.77,2.9)--(1.3,1.3)--(1.7,1.7)--(1.4,1.4)--(1,1));
  replace_strokep(0)(insert_nodes(oldp)(0.6));
  set_botip(0,2,0);
  set_boserif(0,0,5);
  set_boserif(0,2,4);

  push_stroke((340,740)--(510,20),
    (1.5,1.5)--(1.4,1.4)--(1.7,1.7)--(1.7,1.7));
  replace_strokep(0)(insert_nodes(oldp)(0.6,0.95));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef kata.yu =
  push_pbox_toexpand("kata.yu");

  push_stroke((210,600-15*mincho)--(670+10*mincho,600)--(640,100),
    (1.8,1.8)--(1.2,1.2)--(1.7,1.7)--(1.5,1.5));
  replace_strokep(0)(insert_nodes(oldp)(0.7));
  set_botip(0,2,1);
  set_boserif(0,0,5);
  set_boserif(0,2,4);

  push_stroke((110,100)--(500,100)--(890,100),
    (0.7,2.2)--(1.8,1.8)--(0.7,2.2));
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  expand_pbox;
enddef;

vardef kata.yo =
  push_pbox_toexpand("kata.yo");

  kata.ko;

  push_stroke((220,390-20*mincho)--(772,390),
    (0.77,2.7)--(1.3,1.3));
  set_boserif(0,0,5);
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA RARIRURERO

vardef kata.ra =
  push_pbox_toexpand("kata.ra");

  push_stroke((230,680)--(740,680),
    (0.68,3.12)--(1.6,1.6));
  set_boserif(0,0,5);
  set_boserif(0,1,6);

  kata.fu_stroke((150,480),(800,480),(360,0));
  expand_pbox;
enddef;

vardef kata.ri =
  push_pbox_toexpand("kata.ri");

  push_stroke((310,740)--(310,300),
    (1.5,1.5)--(1.3,1.3)--(1.5,1.5));
  replace_strokep(0)(insert_nodes(oldp)(0.6));
  set_boserif(0,0,8);

  push_stroke((690,760)--(690,400){dir 267}..(650,260)..(580,160)..(380,10),
    (1.7,1.7)--(1.6,1.6)--(1.5,1.5)--(1.3,1.3)--(0.8,1));
  set_boserif(0,0,8);
  expand_pbox;
enddef;

vardef kata.ru =
  push_pbox_toexpand("kata.ru");

  kata.no_stroke((320,680),(100,40));
  set_boserif(0,0,8);

  kata.no_stroke((880,370),(560,60));
  replace_strokep(0)(insert_nodes((560,710)--reverse oldp)(0.7));
  replace_strokeq(0)((1.6,1.6)--(1.3,1.3)--(1.8,1.8)--
      (1.2,1.2)--(1,1)--(0.8,1));
  set_botip(0,2,0);
  set_boserif(0,0,8);
  set_boserif(0,2,4);
  expand_pbox;
enddef;

vardef kata.re =
  push_pbox_toexpand("kata.re");

  kata.no_stroke((770,390),(300,80));
  replace_strokep(0)(insert_nodes((290,700)--reverse oldp)(0.7));
  replace_strokeq(0)((1.6,1.6)--(1.3,1.3)--(1.8,1.8)--
      (1.2,1.2)--(1.1,1.1)--(0.8,1));
  set_botip(0,2,1);
  set_boserif(0,0,8);
  set_boserif(0,2,4);
  expand_pbox;
enddef;

vardef kata.ro =
  push_pbox_toexpand("kata.ro");

  kata.ko;

  replace_strokep(-1)((190,30)--oldp);
  replace_strokeq(-1)((1.4,1.4)--(1.7,1.7)--(subpath (1,infinity) of oldq));
  set_botip(-1,1,1);
  set_botip(-1,2,whatever);
  set_botip(-1,3,1);
  set_boserif(-1,0,whatever);
  set_boserif(-1,1,8);
  set_boserif(-1,2,whatever);
  set_boserif(-1,3,4);
  set_boserif(0,0,whatever);
  expand_pbox;
enddef;

%%%%%%%%%% KATAKANA WAWIWEWO/N/ITERATION

vardef kata.wa =
  push_pbox_toexpand("kata.wa");

  kata.fu_stroke((190,630),(780,630),(330,20));
  replace_strokep(0)((xpart point 0 of oldp,390)--oldp);
  replace_strokeq(0)((1.5,1.5)--oldq);
  set_botip(0,1,1);
  set_botip(0,3,0);
  set_boserif(0,0,whatever);
  set_boserif(0,1,8);
  set_boserif(0,2,whatever);
  set_boserif(0,3,4);
  expand_pbox;
enddef;

vardef kata.wi =
  push_pbox_toexpand("kata.wi");

  x1=100;
  x2=180;
  x3=0.25[x2,x5];
  x4=0.667[x2,x5];
  (x5+x2)/2=(x1+x6)/2=500;
  y1=-10;
  y2=250;
  y3=570;
  y4=780;
  push_stroke((x2,y3)--(x5,y3),
    (0.7,3.3)--(1.8,1.8)--(0.7,3.3));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);

  push_stroke((x3,y3)--(x3,y2),
    (1.5,1.5)--(1.5,1.5));

  push_stroke((x4,y4)--(x4,0.5[y4,y1])--(x4,y1),
    (0.75,2.65)--(1.4,1.4)--(1.6,1.6));
  set_boserif(0,0,8);

  push_stroke((x1,y2)--(x6,y2),
    (0.7,3.3)--(1.8,1.8)--(0.7,3.3));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  expand_pbox;
enddef;

vardef kata.we =
  push_pbox_toexpand("kata.we");

  push_stroke((500,470-60*mincho)--(500,140),
    (1.5,1.5)--(1.4,1.4));
  set_boserif(0,0,8);

  kata.fu_stroke((220,600),(780,600),
    (0.5*mincho)[(590,360),point 0 of get_strokep(0)]);

  push_stroke((110,140)--(500,140)--(890,140),
    (0.7,2.9)--(1.7,1.7)--(0.7,2.9));
  set_boserif(0,0,5);
  set_boserif(0,2,6);
  expand_pbox;
enddef;

vardef kata.wo =
  push_pbox_toexpand("kata.wo");

  kata.fu_stroke((190,670),(780,680),(260,20));

  z1=get_strokep(0) intersectionpoint ((0,420)--(1000,430));
  push_stroke((210,420)--z1,
    (0.7,3.3)--(1.6,1.6));
  set_boserif(0,0,5);
  expand_pbox;
enddef;

vardef kata.n =
  push_pbox_toexpand("kata.n");

  push_stroke((140,650)..tension 1.2..(350,550)..(460,460),
    (1,1)..(1.6,1.6)..(1.8,1.8));

  kata.no_stroke((870,480),(210,30));
  replace_strokeq(0)((0.9,0.9)--(1.1,1.1)--(1.4,1.4)--(2.2,2.2));
  set_boserif(0,4,5);
  expand_pbox;
enddef;

vardef kata.iteration =
  push_pbox_toexpand("kata.iteration");

  push_stroke((300,600){curl 0.2}..(560,440)..(690,210),
    (1,1)--(1.5,1.5)--(2,2));
  expand_pbox;
enddef;
