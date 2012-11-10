%
% Grade One kanji used on more than one page
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

inclusion_lock(gradeone);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.ahead =
  push_pbox_toexpand("kanji.grone.ahead");
  build_kanji.tb(450,60)
    (kanji.radical.life_minus)
    (kanji.radical.legs);
  expand_pbox;
enddef;

vardef kanji.grone.ball =
  push_pbox_toexpand("kanji.grone.ball");
  kanji.grone.king;
  push_stroke((640,300)..(700,230)..(760,140),
    (1,1)--(1.4,1.4)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grone.bamboo =
  push_pbox_toexpand("kanji.grone.bamboo");
  push_stroke((250,780)..(190,590)..(70,420),
    (1.7,1.7)--(1.6,1.6)--(1.2,1.2));
  set_boserif(0,0,10);
  push_stroke((190,590)--(490,590),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((310,590)--(310,-50),
    (1.6,1.6)--(1.5,1.5));
  push_stroke((650,780)..(590,590)..(480,440),
    (1.7,1.7)--(1.6,1.6)--(1.2,1.2));
  set_boserif(0,0,10);
  push_stroke((590,590)--(930,590),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((740,590),
    (1.6,1.6));
  build_kanji.add_jtail(0);
  expand_pbox;
enddef;

vardef kanji.grone.big =
  push_pbox_toexpand("kanji.grone.big");
  push_stroke((90,500)--(910,500),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((510,780){down}..(370,200)..{curl 0.5}(50,-20),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke(((get_strokep(-1) intersectionpoint get_strokep(0))+(50,0))..
      (650,200)..(900,-10),
    (1.1,1.1)--(1.5,1.5)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.grone.blue =
  push_pbox_toexpand("kanji.grone.blue");
  build_kanji.level(build_kanji.tb(430,-50)
      (kanji.toprad.blue)
      (kanji.bottomrad.moon));
  expand_pbox;
enddef;

vardef kanji.grone.book =
  push_pbox_toexpand("kanji.grone.book");
  kanji.grone.wood;
  push_stroke((320,150)--(670,150),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.bug =
  push_pbox_toexpand("kanji.grone.bug");
  push_stroke((120,0)..tension 1.2..(450,20)..(800,70),
    (2,2)--(1.7,1.7)--(1.2,1.2));
  push_stroke(
    (500,810)--(get_strokep(0) intersectionpoint ((500,1000)--(500,0))),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((700,170)..tension 1.3..(800,70)..(880,-40),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  build_kanji.box((200,590),(800,320));
  expand_pbox;
enddef;

vardef kanji.grone.character =
  push_pbox_toexpand("kanji.grone.character");
  begingroup
    save charsvp;
    path charsvp;
    build_kanji.tb(580,150)
      (kanji.radical.silly_hat)
      (build_kanji.sscale(xscaled 0.75)
         (kanji.grone.child;
          charsvp:=get_strokep(0));
       replace_strokep(0)(charsvp));
  endgroup;
  expand_pbox;
enddef;

vardef kanji.grone.child =
  push_pbox_toexpand("kanji.grone.child");
  push_stroke((170,780)--(800,780)..(650,610)..(500,530),
    (1.5,1.5)--(1.6,1.6)--(1.4,1.4)--(1,1));
  set_boserif(0,1,4);
  set_botip(0,1,0);
  push_stroke((500,560),
    (1.6,1.6));
  build_kanji.add_jtail(0);
  set_boserif(0,0,10);
  push_stroke((110,410)--(890,410),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.correct =
  push_pbox_toexpand("kanji.grone.correct");
  push_stroke((120,710)--(880,710),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  kanji.grtwo.cease;
  expand_pbox;
enddef;

vardef kanji.grone.day =
  push_pbox_toexpand("kanji.grone.day");
  build_kanji.box((230,760),(770,20));
  push_stroke((250,390)--(750,390),
    (1.6,1.6)--(1.6,1.6));
  expand_pbox;
enddef;

vardef kanji.grone.dog =
  push_pbox_toexpand("kanji.grone.dog");
  kanji.grone.big;
  push_stroke((670,730)..(730,680)..(780,600),
    (1,1)--(1.4,1.4)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grone.down =
  push_pbox_toexpand("kanji.grone.down");
  push_stroke((90,760)--(910,760),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,760)--(500,-20),
    (1.6,1.6)--(1.6,1.6));
  push_stroke((560,540)..(680,440)..(760,330),
    (1.1,1.1)--(1.6,1.6)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grone.ear =
  push_pbox_toexpand("kanji.grone.ear");
  push_stroke((80,720)--(920,720),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((270,720)--(270,120),
    (1.6,1.6)--(1.6,1.6));
  push_stroke((720,720)--(720,-60),
    (1.6,1.6)--(1.5,1.5));
  push_stroke((270,540)--(720,540),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((270,360)--(720,360),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((80,100)..tension 1.3..(270,120)..(920,220),
    (2,2)--(1.7,1.7)--(1,1));
  expand_pbox;
enddef;

vardef kanji.grone.early =
  push_pbox_toexpand("kanji.grone.early");
  build_kanji.level(build_kanji.tb(460,70)
    (kanji.grone.day)
    (kanji.grone.ten));
  set_boserif(0,0,whatever);
  expand_pbox;
enddef;

vardef kanji.grone.earth =
  push_pbox_toexpand("kanji.grone.earth");
  push_stroke((500,780)--(500,0),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((170,470)--(830,470),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((90,0)--(910,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.eight =
  push_pbox_toexpand("kanji.grone.eight");
  push_stroke((470,760)--(600,760)..tension 1.3..(690,240)..(900,-10),
    (1.2,1.2)--(1.2,1.2)--(1.4,1.4)--(1.8,1.8));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke((360,660)..(320,360)..(190,80)..(20,-30),
    (1.6,1.6)--(1.4,1.4)--(1.3,1.3)--(0.88,0.88));
  expand_pbox;
enddef;

vardef kanji.grone.evening =
  push_pbox_toexpand("kanji.grone.evening");
  push_stroke((420,790)..tension 1.2..(320,530)..(120,320),
    (1.6,1.6)--(1.5,1.5)--(1.2,1.2));
  set_boserif(0,0,10);
  push_stroke(
    (get_strokep(0) intersectionpoint ((-infinity,690)--(infinity,690)))--
      (740,700)..tension 1.2..(500,150)..(170,-70),
    (1.5,1.5)--(1.6,1.6)--(1.4,1.4)--(1.2,1.2));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke(
    (point 1.1 of get_strokep(-1))..(500,390)..(point 1.7 of get_strokep(0)),
    (1.2,1.2)--(1.4,1.4)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grone.eye =
  push_pbox_toexpand("kanji.grone.eye");
  build_kanji.box((250,760),(750,20));
  push_stroke((250,520)--(750,520),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((250,270)--(750,270),
    (1.4,1.4)--(1.4,1.4));
  expand_pbox;
enddef;

vardef kanji.grone.fire =
  push_pbox_toexpand("kanji.grone.fire");
  kanji.grone.person;
  push_stroke((360,600)..(270,480)..(140,360),
    (0.9,0.9)--(1.3,1.3)--(1.8,1.8));
  push_stroke((860,600)..(790,500)..(680,380),
    (1.6,1.6)--(1.4,1.4)--(1.2,1.2));
  expand_pbox;
enddef;

vardef kanji.grone.five =
  push_pbox_toexpand("kanji.grone.five");
  push_stroke((170,740)--(830,740),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,740)--(350,20),
    (1.6,1.6)--(1.6,1.6));
  push_stroke((220,410)--(730,410)--(720,20),
    (1.5,1.5)--(1.5,1.5)--(1.4,1.4));
  set_boserif(0,1,4);
  set_botip(0,1,1);
  push_stroke((120,20)--(880,20),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone_helper.foot =
  push_pbox_toexpand("kanji.grone_helper.foot");
  push_stroke((270,330)..tension 1.3..(190,100)..(60,-50),
    (1.6,1.6)--(1.3,1.3)--(1,1));
  set_boserif(0,0,10);
  push_stroke((point 0.4 of get_strokep(0))..(500,40)..tension 1.5..(890,-10),
    (1,1)--(1.7,1.7)--(2,2));
  expand_pbox;
enddef;

vardef kanji.grone.foot =
  push_pbox_toexpand("kanji.grone.foot");
  build_kanji.box((240,730),(760,460));
  push_stroke((500,460)--(500,40),(1.6,1.6)--(1.5,1.5));
  push_stroke((500,250)--(820,250),(1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  kanji.grone_helper.foot;
  expand_pbox;
enddef;

vardef kanji.grone.four =
  push_pbox_toexpand("kanji.grone.four");
  perl_structure:=perl_structure&"'eids.u2FF4.u56D7.u513F',";
  build_kanji.box((120,700),(880,80));
  tsu_xform
    (identity shifted (-500,-780) xyscaled (0.85,0.64) shifted (480,700))
    (kanji.radical.legs);
  expand_pbox;
enddef;

vardef kanji.grone.go_away =
  push_pbox_toexpand("kanji.grone.go_away");
  build_kanji.cup((200,720),(800,470));
  build_kanji.cup((160,270),(840,0));
  push_stroke((500,800)--(500,0),
    (1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.grone.gold =
  push_pbox_toexpand("kanji.grone.gold");
  kanji.radical.tent;
  push_stroke((500,470)--(500,-20),(1.5,1.5)--(1.4,1.4));
  push_stroke((150,300)--(850,300),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((100,-20)--(900,-20),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke(((210,220)..tension 1.3..(270+20*mincho,140)..(320,60))
      shifted ((1-mincho)*10*down),
    (1,1)--(1.5,1.5)--(1.6,1.6));
  push_stroke(((750,210)..tension 1.3..(690,100)..(630,30))
      shifted ((1-mincho)*17*up),
    (1.6,1.6)--(1.3,1.3)--(1,1));
  set_boserif(0,0,10);
  for i=-4 upto 0: set_bosize(i,93); endfor;
  expand_pbox;
enddef;

vardef kanji.grone.hand =
  push_pbox_toexpand("kanji.grone.hand");
  build_kanji.add_beret(
    push_stroke((490,750),(1.6,1.6));
    build_kanji.add_jtail(0);
    push_stroke((130,520)--(870,520),(1.5,1.5)--(1.5,1.5));
    set_boserif(0,1,9);
    push_stroke((90,300)--(910,300),(1.5,1.5)--(1.5,1.5));
    set_boserif(0,1,9);
  );
  expand_pbox;
enddef;

vardef kanji.grone.hundred =
  push_pbox_toexpand("kanji.grone.hundred");
  push_stroke((120,740)--(880,740),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,740)..(480,630)..(440,520),
    (1.7,1.7)--(1.3,1.3)--(1,1));
  tsu_xform(identity yscaled (520/770))(kanji.grone.day);
  expand_pbox;
enddef;

vardef kanji.grone.king =
  push_pbox_toexpand("kanji.grone.king");
  push_stroke((120,710)--(880,710),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,710)--(500,40),
    (1.6,1.6)--(1.5,1.5));
  push_stroke((160,390)--(840,390),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((80,40)--(920,40),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.life =
  push_pbox_toexpand("kanji.grone.life");
  push_stroke((500,780)--(500,0),
    (1.5,1.5)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((250,740)..(190,550)..(110,460),
    (1.6,1.6)--(1.2,1.2)--(0.8,0.8));
  set_boserif(0,0,10);
  push_stroke((point 0.75 of get_strokep(0))--
      (830,ypart point 0.75 of get_strokep(0)),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((220,310)--(780,310),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((120,0)--(880,0),
    (1.7,1.7)--(1.7,1.7));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.left =
  push_pbox_toexpand("kanji.grone.left");
  build_kanji.lean_to((430,160));
  push_stroke(
    ((((0,350)--(1000,350)) intersectionpoint get_strokep(0))+(40,0))..
      (830,350),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((200,30)..(890,30),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke(
    (point 0.5 of get_strokep(-1))--(xpart point 0.5 of get_strokep(-1),30),
    (1.6,1.6)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.grone.man =
  push_pbox_toexpand("kanji.grone.man");
  build_kanji.level(build_kanji.tb(430,75)
    (kanji.grone.paddy)
    (build_kanji.sscale(xyscaled (0.9,1.15) slanted 0.05 shifted (40,0))
       (kanji.grone.power)));
  replace_strokep(0)(oldp shifted (0,-30));
  expand_pbox;
enddef;

vardef kanji.grone.middle =
  push_pbox_toexpand("kanji.grone.middle");
  kanji.radical.vline;
  build_kanji.box((170,590),(830,270));
  expand_pbox;
enddef;

vardef kanji.grone.moon =
  push_pbox_toexpand("kanji.grone.moon");
  push_stroke((80,-20)..(200,100)...{up}(250,760)--(750,760),
    (1,1)--(1.4,1.4)--(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_boserif(0,2,4);
  set_boserif(0,3,4);
  push_stroke(
    (get_strokep(0) intersectionpoint ((0,520)--(1000,520)))--(750,520),
    (1.5,1.5)--(1.5,1.5));
  push_stroke(
    (get_strokep(-1) intersectionpoint ((0,270)--(1000,270)))--(750,270),
    (1.5,1.5)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.grone.mountain =
  push_pbox_toexpand("kanji.grone.mountain");
  build_kanji.cup((170,590),(830,50));
  push_stroke((500,780)--(500,50),
    (1.7,1.7)--(1.5,1.5));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.grone.mouth =
  push_pbox_toexpand("kanji.grone.mouth");
  build_kanji.box((200,700),(800,100));
  expand_pbox;
enddef;

vardef kanji.grone.name =
  push_pbox_toexpand("kanji.grone.name");
  tsu_xform(identity shifted (-50,-850) yscaled 0.6 shifted (50,850))
    (kanji.grone.evening);
  set_bosize(-2,102);
  set_bosize(-1,102);
  set_bosize(0,102);
  build_kanji.box((360,350),(870,30));
  expand_pbox;
enddef;

vardef kanji.grone.nine =
  push_pbox_toexpand("kanji.grone.nine");
  push_stroke((400,780){down}..(350,300)..(40,-60),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(0.8,0.7));
  replace_strokep(0)(insert_nodes(oldp)(1.3));
  set_boserif(0,0,10);
  push_stroke((120,550)--(630+10*mincho,550),
    (1.4,1.4)--(1.6,1.6));
  build_kanji.add_ltail(0);
  set_botip(0,1,1);
  set_boserif(0,1,4);
  expand_pbox;
enddef;

vardef kanji.grone.noise =
  push_pbox_toexpand("kanji.grone.noise");
  build_kanji.level(build_kanji.sscale(xscaled 0.93)(
    build_kanji.tb(430,-80)
      (kanji.toprad.stand_up)
      (kanji.grone.day)));
  expand_pbox;
enddef;

vardef kanji.grone.one =
  push_pbox_toexpand("kanji.grone.one");
  push_stroke((120,390)--(880,390),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.one_thousand =
  push_pbox_toexpand("kanji.grone.one_thousand");
  build_kanji.add_beret(
    push_stroke((500,720)--(500,-50),(1.6,1.6)--(1.4,1.4));
    push_stroke((100,450)--(900,450),(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
  );
  expand_pbox;
enddef;

vardef kanji.grone.paddy =
  push_pbox_toexpand("kanji.grone.paddy");
  build_kanji.box((200,700),(800,100));
  push_stroke((500,700)--(500,100),
    (1.7,1.7)--(1.5,1.5));
  push_stroke((200,390)--(800,390),
    (1.6,1.6)--(1.6,1.6));
  expand_pbox;
enddef;

vardef kanji.grone.person =
  push_pbox_toexpand("kanji.grone.person");
  push_stroke((510,780)..(450,400)..(300,100)..(20,-90),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3)--(0.85,0.85));
  set_boserif(0,0,10);
  push_stroke(
    (point 0.2 of get_strokep(0))..tension 1.2..(640,240)..(920,-40),
    (1.2,1.2)--(1.4,1.4)--(1.6,1.6));
  expand_pbox;
enddef;

vardef kanji.grone.power =
  push_pbox_toexpand("kanji.grone.power");
  push_stroke((390,780)..(370,400)..(260,120)..(50,-50),
    (1.6,1.6)--(1.6,1.6)--(1.3,1.3)--(1,1));
  set_boserif(0,0,10);
  push_stroke(
    (100,600)--(830,600)..tension 1.1..(830,300)..(770,50)..(650,-20),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.4,1.4));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  expand_pbox;
enddef;

vardef kanji.grone.put_it_in =
  push_pbox_toexpand("kanji.grone.put_it_in");
  push_stroke((240,760)--(530,760)..tension 1.2..(640,240)..(920,-40),
    (1.2,1.2)--(1.2,1.2)--(1.6,1.6)--(1.7,1.7));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke(
    ((-20,0)+point 1.14 of get_strokep(0))..(450,360)..(300,80)..(20,-90),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3)--(0.85,0.85));
  expand_pbox;
enddef;

vardef kanji.grone.rain =
  push_pbox_toexpand("kanji.grone.rain");
  build_kanji.level(
    push_stroke((80,720)--(920,720),(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
    push_stroke((500,720)--(500,-10),(1.6,1.6)--(1.5,1.5));
    tsu_xform(identity yscaled (540/780))(kanji.radical.gmm);
    push_stroke((250,430)..tension 1.2..(310,390+13*mincho)..(380,320),
      (1,1)--(1.4,1.4)--(1.7,1.7));
    set_bosize(0,80);
    push_stroke(get_strokep(0) shifted (350,0),get_strokeq(0));
    set_bosize(0,80);
    push_stroke(get_strokep(-1) shifted (0,-220),get_strokeq(-1));
    set_bosize(0,80);
    push_stroke(get_strokep(-2) shifted (350,-220),get_strokeq(-2));
    set_bosize(0,80);
  );
  expand_pbox;
enddef;

vardef kanji.grone.red =
  push_pbox_toexpand("kanji.grone.red");
  push_stroke((500,810)--(500,470),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((160,660)--(840,660),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((50,470)--(950,470),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((240,320)..tension 1.3..(150,170)..(40,70),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  push_stroke((400,470){down}..tension 1.3..(380,160)..(190,-40),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  push_stroke((600,470),(1.6,1.6));
  build_kanji.add_jtail(0);
  push_stroke((740,320)..tension 1.3..(820,210)..(880,80),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  for i=-6 upto 0: set_bosize(i,94); endfor;
  expand_pbox;
enddef;

vardef kanji.grone.right =
  push_pbox_toexpand("kanji.grone.right");
  build_kanji.lean_to((430,160));
  build_kanji.box((340,350),(820,30));
  expand_pbox;
enddef;

vardef kanji.grone.river =
  push_pbox_toexpand("kanji.grone.river");
  push_stroke((200,780){down}..(150,130)..(50,-50),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  push_stroke((490,750)--(490,30),
    (1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((800,780)--(800,-30),
    (1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.grone.see =
  push_pbox_toexpand("kanji.grone.see");
  build_kanji.level(build_kanji.tb(300,70)
    (kanji.grone.eye)
    (kanji.radical.legs));
  expand_pbox;
enddef;

vardef kanji.grone.sentence =
  push_pbox_toexpand("kanji.grone.sentence");
  push_stroke((500,810)--(500,600),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((100,600)--(900,600),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((300,600)..(500,200)..(900,0),
    (1.3,1.3)--(1.5,1.5)--(1.7,1.7));
  push_stroke((700,600)..(500,200)..(70,-30),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  expand_pbox;
enddef;

vardef kanji.grone.seven =
  push_pbox_toexpand("kanji.grone.seven");
  push_stroke((330,770),
    (1.6,1.6));
  build_kanji.add_ltail(0);
  set_boserif(0,0,10);
  push_stroke((80,390)--(890,530),
    (1.4,1.4)--(1.4,1.4));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.shell =
  push_pbox_toexpand("kanji.grone.shell");
  build_kanji.level(build_kanji.tb(200,0)
    (kanji.grone.eye)
    (kanji.radical.eight));
  expand_pbox;
enddef;

vardef kanji.grone.six =
  push_pbox_toexpand("kanji.grone.six");
  build_kanji.level(build_kanji.tb(600,-50)
    (kanji.radical.kettle_lid)
    (kanji.radical.eight));
  expand_pbox;
enddef;

vardef kanji.grone.small =
  push_pbox_toexpand("kanji.grone.small");
  push_stroke((300,570)..(230,340)..(140,210)..(70,120),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1)--(0.88,0.88));
  set_boserif(0,0,10);
  push_stroke((510,780),
    (1.6,1.6));
  set_boserif(0,0,10);
  build_kanji.add_jtail(0);
  push_stroke((680,580)..tension 1.3..(830,350)..(900,180),
    (1,1)--(1.4,1.4)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grone.stand_up =
  push_pbox_toexpand("kanji.grone.stand_up");
  push_stroke((500,810)--(500,610),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((120,610)--(880,610),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((250,490)..tension 1.2..(350,250)..(380,100),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  push_stroke((750,510)..tension 1.2..(660,250)..(580,60),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3));
  set_boserif(0,0,10);
  push_stroke((70,0)--(930,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.stone =
  push_pbox_toexpand("kanji.grone.stone");
  push_stroke((120,730)..(880,730),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((430,730)..(330,440)..(200,270)..(50,160),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3)--(0.8,0.8));
  build_kanji.box((340,410),(840,30));
  expand_pbox;
enddef;

vardef kanji.grone.ten =
  push_pbox_toexpand("kanji.grone.ten");
  push_stroke((500,800)--(500,-30),(1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((100,400)--(900,400),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.thread =
  push_pbox_toexpand("kanji.grone.thread");
  kanji.radical.thread_common;
  push_stroke(
    ((get_strokep(-4) intersectionpoint ((500,1000)--(500,0)))+(0,-5))
      --(500,-50),
    (1.6,1.6)--(1.5,1.5));
  push_stroke((320,230)..tension 1.3..(220,90)..(100,-20),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  push_stroke((610,240)..tension 1.3..(740,130)..(840,0),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  for i=-7 upto 0: set_bosize(i,90); endfor;
  expand_pbox;
enddef;

vardef kanji.grone.three =
  push_pbox_toexpand("kanji.grone.three");
  push_stroke((170,760)--(830,760),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((220,390)--(780,390),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((120,0)--(880,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.two =
  push_pbox_toexpand("kanji.grone.two");
  push_stroke((170,620)--(830,620),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((120,100)--(880,100),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.up =
  push_pbox_toexpand("kanji.grone.up");
  push_stroke((500,780)--(500,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((500,430)--(780,430),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((90,0)--(910,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grone.vacation =
  push_pbox_toexpand("kanji.grone.vacation");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.wood);
  expand_pbox;
enddef;

vardef kanji.grone.water =
  push_pbox_toexpand("kanji.grone.water");
  tsu_xform(identity shifted (-40,160))(kanji.grone.person);
  replace_strokep(-1)(((100,500)--
    (subpath (xpart (oldp intersectiontimes
      ((0,500)--(1000,500))),infinity) of oldp))
    shifted (-250,0) xscaled 0.7 shifted (250,30));
  replace_strokeq(-1)((1.6,1.6)--(1.6,1.6)--(1.3,1.3)--(0.85,0.85));
  set_boserif(-1,0,whatever);
  set_boserif(-1,1,4);
  set_botip(-1,1,0);
  push_stroke((510,810),(1.6,1.6));
  build_kanji.add_jtail(0);
  set_boserif(0,0,10);
  replace_strokep(-1)(
    subpath (xpart (oldp intersectiontimes get_strokep(0)),infinity)
    of oldp);
  push_stroke((860,570)..(760,480)..(point 0.9 of get_strokep(-1)),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.grone.wheel =
  push_pbox_toexpand("kanji.grone.wheel");
  push_stroke((120,690)--(880,690),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,820)--(500,-50),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  build_kanji.box((200,560),(800,280));
  push_stroke((200,420)--(800,420),
    (1.6,1.6)--(1.6,1.6));
  push_stroke((80,130)--(920,130),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  for i=-5 upto 0: set_bosize(i,85); endfor;
  expand_pbox;
enddef;

vardef kanji.grone.white =
  push_pbox_toexpand("kanji.grone.white");
  build_kanji.attach_tick(620)(kanji.grone.day);
  expand_pbox;
enddef;

vardef kanji.grone.woman =
  push_pbox_toexpand("kanji.grone.woman");
  push_stroke((100,580)--(900,580),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((700,580){curl 0}..(550,170)..{curl 0.3}(80,-40),
    (1.6,1.6)--(1.4,1.4)--(0.94,0.94));
  push_stroke((450,830)..(350,510)..(230,220),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((point 1.75 of get_strokep(0))..(530,180)..(840,-10),
    (0.85,0.85)--(1.5,1.5)--(1.8,1.8)--(1.6,1.6));
  replace_strokep(0)(insert_nodes(oldp)(1.5));
  expand_pbox;
enddef;

vardef kanji.grone.wood =
  push_pbox_toexpand("kanji.grone.wood");
  push_stroke((500,780)--(500,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((100,580)--(900,580),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,580)..(250,200)..(80,70),
    (1.6,1.6)..(1.3,1.3)..(0.9,0.9));
  push_stroke((500,580)..(750,200)..(870,100),
    (1.1,1.1)..(1.5,1.5)..(1.7,1.7));
  expand_pbox;
enddef;
