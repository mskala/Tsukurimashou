%
% Radicals for left side (often special forms of other radicals)
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

inclusion_lock(leftrad);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.bare_bone =
  push_pbox_toexpand("kanji.leftrad.bare_bone");
  push_stroke((120,790)--(880,790),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((420,790)..tension 1.2..(300,530)..(120,320),
    (1.6,1.6)--(1.5,1.5)--(1.2,1.2));
  push_stroke(
    (get_strokep(0) intersectionpoint ((-infinity,560)--(infinity,560)))--
      (740,564)..tension 1.2..(500,130)..(170,-70),
    (1.5,1.5)--(1.6,1.6)--(1.4,1.4)--(1.2,1.2));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke(
    (point 1.6 of get_strokep(-1))..(400,340)..(point 1.8 of get_strokep(0)),
    (1.2,1.2)--(1.4,1.4)--(1.8,1.8));
  replace_strokep(0)(subpath (0,1.7) of oldp);
  expand_pbox;
enddef;

vardef kanji.leftrad.boat =
  push_pbox_toexpand("kanji.leftrad.boat");
  push_stroke((560,850)..tension 1.2..(500,750)..(450,700),
    (1.6,1.6)--(1.4,1.4)--(1.2,1.2));
  set_boserif(0,0,10);
  push_stroke(
    (150,0)..(260,200)..{dir 89.5}(300,700)--(730,700),
    (1.5,1.5)--(1.6,1.6)--(1.7,1.7)--(1.7,1.7));
  build_kanji.add_jtail(0);
  set_botip(0,2,1);
  set_botip(0,3,0);
  set_boserif(0,2,4);
  set_boserif(0,3,4);
  push_stroke((410,610)..tension 1.2..(520,540)..(560,480),
    (1.1,1.1)--(1.4,1.4)--(1.7,1.7));
  set_bosize(0,90);
  push_stroke((110,350)..tension 1.2..(500,380)..(890,440),
    (1.6,1.6)--(1.5,1.5)--(1.1,1.1));
  push_stroke((500,300)--(500,100),
    (1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef kanji.leftrad.day =
  push_pbox_toexpand("kanji.leftrad.day");
  tsu_xform(identity shifted (0,-600) yscaled 0.62 shifted (0,600))
    (kanji.grone.day);
  expand_pbox;
enddef;

vardef kanji.leftrad.earth =
  push_pbox_toexpand("kanji.leftrad.earth");
  build_kanji.sscale(yscaled 0.9)
    (build_kanji.lift_skirt(370,150+30*mincho)(kanji.grone.earth));
  expand_pbox;
enddef;

vardef kanji.leftrad.eat =
  push_pbox_toexpand("kanji.leftrad.eat");
  kanji.grtwo.eat;
  pop_stroke;
  replace_strokep(-6)(subpath(0,1.75) of oldp);
  replace_strokep(-1)
    ((130,-20)..tension 1.2..(point 0 of get_strokep(-4))..(720,80));
  replace_strokep(0)((650,170)..tension 1.3..(720,80)..(770,-20));
  replace_strokeq(0)((1,1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.leftrad.fire =
  push_pbox_toexpand("kanji.leftrad.fire");
  kanji.grone.person;
  pop_stroke;
  push_stroke((510,270)..tension 1.2..(750,180)..(900,60),
    (0.9,0.9)--(1.3,1.3)--(1.8,1.8));
  push_stroke((360,600)..(270,480)..(140,360),
    (0.9,0.9)--(1.3,1.3)--(1.8,1.8));
  push_stroke((860,640)..(790,550)..(680,440),
    (1.6,1.6)--(1.4,1.4)--(1.2,1.2));
  expand_pbox;
enddef;

vardef kanji.leftrad.foot =
  push_pbox_toexpand("kanji.leftrad.foot");
  build_kanji.box((210,730),(790,460));
  push_stroke((500,460)--(500,40),(1.6,1.6)--(1.5,1.5));
  push_stroke((500,250)--(850,250),(1.5,1.5)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((220,310)--(220,20),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((100,0)..tension 1.2..(500,40)..(900,100),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  expand_pbox;
enddef;

vardef kanji.leftrad.gold =
  push_pbox_toexpand("kanji.leftrad.gold");
  build_kanji.lift_skirt(250,120)(kanji.grone.gold);
  replace_strokep(-6)(subpath (0,1.7) of oldp);
  expand_pbox;
enddef;

vardef kanji.leftrad.hand =
  push_pbox_toexpand("kanji.leftrad.hand");
  build_kanji.sscale(xscaled 1.5)
    (push_stroke((500,810),(1.6,1.6));
     build_kanji.add_jtail(0);
     set_boserif(0,0,10));
  push_stroke((100,580)--(900,580),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((120,280)..tension 1.2..(500,330)..(910,420),
    (1.8,1.8)--(1.5,1.5)--(1.1,1.1));
  expand_pbox;
enddef;

vardef kanji.leftrad.heap_big =
  push_pbox_toexpand("kanji.leftrad.heap_big");
  build_kanji.sscale(scaled 0.88)
    (kanji.grthree.heap_big;
     replace_strokep(0)(get_strokep(-6));
     replace_strokep(0)
       (get_strokep(-1) shifted ((point 1 of oldp)-(point 0 of oldp))
        shifted (-500,0) xscaled 1.1 shifted (500,0));
     replace_strokeq(0)(reverse get_strokeq(-1));
     set_boserif(0,1,whatever));
  expand_pbox;
enddef;

vardef kanji.leftrad.heart =
  push_pbox_toexpand("kanji.leftrad.heart");
  kanji.radical.vline;
  push_stroke((320,630)..tension 1.2..(210,470)..(60,380),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  push_stroke((660,660)..tension 1.2..(840,530)..(890,470),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.leftrad.ice =
  push_pbox_toexpand("kanji.leftrad.ice");
  push_stroke((450,790)..tension 1.2..(600,730)..(750,650),
    (1,1)--(1.3,1.3)--(1.9,1.9));
  push_stroke(
    interpath(mincho,
      (880,350)..(810,270)..(750,210)..(600,90)..(450,0),
      (880,480)..tension 1.2..(630,300)..{dir 180}(360,240){dir 350}..
        (500,130)..{curl 0}(550,-20)),
    interpath(mincho,
      (1.4,1.4)--(1.45,1.45)--(1.5,1.5)--(1.6,1.6)--(1.7,1.7),
      (0.8,0.8)--(1.2,1.2)--(2.1,2.1)--(1.2,1.2)--(1.9,1.9)));
  expand_pbox;
enddef;

vardef kanji.leftrad.king =
  push_pbox_toexpand("kanji.leftrad.king");
  build_kanji.sscale(yscaled 0.9)
    (build_kanji.lift_skirt(370,150+30*mincho)(kanji.grone.king));
  expand_pbox;
enddef;

vardef kanji.leftrad.long_hair =
  push_pbox_toexpand("kanji.leftrad.long_hair");
  build_kanji.level(
    kanji.grtwo.long;
    pop_stroke;pop_stroke;pop_stroke;
    replace_strokep(-3)((300,320)--(300,770)--(800,770));
    build_kanji.sscale(xyscaled (0.9,0.38) shifted (0,-240))
      (kanji.radical.mu));
  expand_pbox;
enddef;

vardef kanji.leftrad.mouth =
  push_pbox_toexpand("kanji.leftrad.mouth");
  build_kanji.box((200,700),(800,230));
  replace_strokep(-1)((subpath (0,2) of oldp)--((0,40)+point 3 of oldp));
  expand_pbox;
enddef;

vardef kanji.leftrad.person =
  push_pbox_toexpand("kanji.leftrad.person");
  push_stroke((900,800)..(500,520)..(0,330),
    (1.6,1.6)--(1.4,1.4)--(0.8,0.8));
  set_bosize(0,115);
  set_boserif(0,0,10);
  push_stroke(
    (point 0.7 of get_strokep(0))..(xpart point 0.7 of get_strokep(0),-40),
    (1.6,1.6)--(1.4,1.4));
  set_bosize(0,115);
  expand_pbox;
enddef;

vardef kanji.leftrad.sentence =
  push_pbox_toexpand("kanji.leftrad.sentence");
  build_kanji.level(build_kanji.tb(580,30)
    (kanji.radical.kettle_lid)
    (kanji.radical.cut_the_grass;
     replace_strokep(-1)(oldp shifted (0,-400) yscaled 0.7 shifted (0,400))));
  expand_pbox;
enddef;

vardef kanji.leftrad.seven =
  push_pbox_toexpand("kanji.leftrad.seven");
  build_kanji.sscale(shifted (0,-300) yscaled 0.7 shifted (0,300))
    (kanji.grone.seven);
  set_boserif(-1,3,whatever);
  expand_pbox;
enddef;

vardef kanji.leftrad.showing =
  push_pbox_toexpand("kanji.leftrad.showing");
  push_stroke((500,810)--(500,620),(1.6,1.6)--(1.57,1.57));
  set_boserif(0,0,10);
  push_stroke((160,620)--(830,620)..tension 1.2..
      (500,350)..(100,200),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1,1));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke((500,350)--(500,-60),(1.5,1.5)--(1.4,1.4));
  push_stroke((560,350)..tension 1.2..(710,260)..(800,160),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.leftrad.two_branch_tree =
  push_pbox_toexpand("kanji.leftrad.two_branch_tree");
  tsu_xform(identity shifted (0,-50))
    (build_kanji.add_beret(kanji.leftrad.wood));
  expand_pbox;
enddef;

vardef kanji.leftrad.water =
  push_pbox_toexpand("kanji.leftrad.water");
  kanji.leftrad.ice;
  push_stroke((230,590)..tension 1.2..(390,530)..(540,450),
    (1,1)--(1.3,1.3)--(1.9,1.9));
  expand_pbox;
enddef;

vardef kanji.leftrad.woman =
  push_pbox_toexpand("kanji.leftrad.woman");
  perl_structure:=perl_structure&"'eids.softhead.u5973',";
  push_stroke((100,580)--(800,580){curl 0}..(550,170)..{curl 0.3}(80,-40),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(0.94,0.94));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke((450,830)..(310,510)..(140,220),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((point 1.75 of get_strokep(0))..(530,200)..(840,60),
    (0.85,0.85)--(1.5,1.5)--(1.8,1.8)--(1.6,1.6));
  replace_strokep(0)(insert_nodes(oldp)(1.5));
  expand_pbox;
enddef;

vardef kanji.leftrad.wood =
  push_pbox_toexpand("kanji.leftrad.wood");
  perl_structure:=perl_structure&"'eids.softhead.u6728',";
  push_stroke((500,780)--(500,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((100,580)--(830,580),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,580)..(250,200)..(80,70),
    (1.6,1.6)..(1.3,1.3)..(0.9,0.9));
  push_stroke((500,470)..(680,320)..(800,210),
    (1.1,1.1)..(1.5,1.5)..(1.7,1.7));
  expand_pbox;
enddef;
