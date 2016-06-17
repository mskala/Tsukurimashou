%
% Grade Nine kanji used on more than one page
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

inclusion_lock(gradenine);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.again =
  push_pbox_toexpand("kanji.grnine.again");
  push_stroke((500,810)--(500,560),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((50,560)--(950,560),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((240,410)..tension 1.3..(150,210)..(40,70),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  push_stroke((400,560){down}..tension 1.3..(380,200)..(190,-40),
    (1.6,1.6)--(1.5,1.5)--(1,1));
  push_stroke((600,560),(1.6,1.6));
  build_kanji.add_jtail(0);
  push_stroke((740,410)..tension 1.3..(820,260)..(880,80),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grnine.animal_counter =
  push_pbox_toexpand("kanji.grnine.animal_counter");
  tsu_xform(identity yscaled (780/460))
    (push_stroke((150,460)--(830,460)..tension 1.2..(790,390)..(760,360),
       (1.6,1.6)--(1.7,1.7)--(1.6,1.6)--(1.4,1.4));
     set_botip(0,1,1);
     set_boserif(0,1,4);
     push_stroke((500,460)--(500,40),(1.6,1.6)--(1.5,1.5));
     push_stroke((500,250)--(820,250),(1.5,1.5)--(1.6,1.6));
     set_boserif(0,1,9);
     kanji.grone_helper.foot);
  expand_pbox;
enddef;

vardef kanji.grnine.barbarian =
  push_pbox_toexpand("kanji.grnine.barbarian");
  build_kanji.level(build_kanji.lr(480,0)
    (kanji.grtwo.old)
    (kanji.grone.moon));
  expand_pbox;
enddef;

vardef kanji.grnine.bird_sign =
  push_pbox_toexpand("kanji.grnine.bird_sign");
  build_kanji.thickness(0.93)(
    push_stroke((120,770)--(880,770),(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
    build_kanji.sscale(xyscaled (0.7,0.6) shifted (0,145))
      (kanji.radical.legs);
    build_kanji.box((180,560),(820,0));
    push_stroke((180,180)--(820,180),(1.5,1.5)--(1.5,1.5)));
  expand_pbox;
enddef;

vardef kanji.grnine.boast =
  push_pbox_toexpand("kanji.grnine.boast");
  build_kanji.tb(340,0)
    (kanji.rare.drink)
    (kanji.radical.gmm;
     build_kanji.box((350,480),(650,190)));
  expand_pbox;
enddef;

vardef kanji.grnine.boy =
  push_pbox_toexpand("kanji.grnine.boy");
  build_kanji.level(build_kanji.tb(480,0)
    (kanji.toprad.stand_up)
    (build_kanji.sscale(xscaled 0.9 shifted (50,20))
       (kanji.rightrad.short_hair)));
  replace_strokep(-3)((50,-50)..(120,80)..(160,200)..tension 1.2..
    (180,ypart point 0 of oldp)--(880,ypart point 1 of oldp));
  replace_strokeq(-3)((1,1)--(1.3,1.3)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_botip(-3,3,1);
  set_boserif(-3,1,whatever);
  set_boserif(-3,3,4);
  set_boserif(-3,4,9);
  expand_pbox;
enddef;

vardef kanji.grnine.chad =
  push_pbox_toexpand("kanji.grnine.chad");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.85,0.63) shifted (60,-130))
      (kanji.greight.resemblance));
  expand_pbox;
enddef;

vardef kanji.grnine.declaim =
  push_pbox_toexpand("kanji.grnine.declaim");
  build_kanji.level(build_kanji.tb(480,0)
    (push_stroke((170,420)--(830,420),
       (1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9);
     )
    (kanji.radical.mu_bar));
  expand_pbox;
enddef;

vardef kanji.grnine.deliverance =
  push_pbox_toexpand("kanji.grthree.deliverance");
  kanji.radical.box_on_side;
  build_kanji.sscale(scaled 0.75 shifted (40,0))(kanji.grone.king);
  expand_pbox;
enddef;

vardef kanji.grnine.divination =
  push_pbox_toexpand("kanji.grnine.divination");
  push_stroke((400,780)--(400,-20),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((400,500)..tension 1.1..(640,405)..(780,300),
    (1.3,1.3)--(1.6,1.6)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grnine.dragon_sign =
  push_pbox_toexpand("kanji.grnine.dragon_sign");
  build_kanji.cliff_enclose(build_kanji.sscale(xscaled 1.12)
    (build_kanji.tb(540,100)
      (kanji.grone.two;
       replace_strokep(-1)
         (oldp shifted (-500,-100) xscaled 0.8 shifted (500,0)))
      (push_stroke((340,780)--(340,0),(1.6,1.6)--(1.5,1.5));
       push_stroke((620,140)..tension 1.2..
           (point 1 of get_strokep(0))..(130,-40),
         (1,1)--(1.5,1.5)--(1.8,1.8));
       push_stroke((500,780)..tension 1.2..(700,240)..(890,0),
         (1,1)--(1.4,1.4)--(1.7,1.7));
       push_stroke((820,540)..tension 1.2..(720,460)..
           (point 0.69 of get_strokep(0)),
         (1.7,1.7)--(1.4,1.4)--(1.2,1.2)))));
  expand_pbox;
enddef;

vardef kanji.grnine.extremely =
  push_pbox_toexpand("kanji.grnine.extremely");
  build_kanji.level(build_kanji.lr(440,30)
    (build_kanji.sscale(shifted (0,40))(kanji.grthree.pelt))
    (kanji.grnine.page));
  expand_pbox;
enddef;

vardef kanji.grnine.fifth =
  push_pbox_toexpand("kanji.grnine.fifth");
  push_stroke((50,-50)..(120,100)..(160,300)..tension 1.2..(180,560)
      --(850,560),
    (1,1)--(1.3,1.3)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,3,1);
  set_boserif(0,4,9);
  push_stroke(interpath(mincho,
      (570,760){down}..(660,100)..(810,0)..tension 1.5..
        (870,70)..{curl 0.3}(910,200),
      (540,760){down}..(670,100)..{right}(910,-40){curl 1}..
        (860,60)..(860,160)),
    (1.6,1.6)--(1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(0.9,0.9));
  set_boserif(0,0,10);
  push_stroke((680,720)..tension 1.2..(750,690)..(790,640),
    (1,1)..(1.5,1.5)--(1.7,1.7));
  set_bosize(0,90);
  push_stroke((820,410)..tension 1.2..(720,240)..(370,-60),
    (1.6,1.6)--(1.4,1.4)--(1.2,1.2));
  expand_pbox;
enddef;

vardef kanji.grnine.fork_in_the_road =
  push_pbox_toexpand("kanji.grnine.fork_in_the_road");
  build_kanji.tb(400,120)
    (kanji.grfour.together)
    (build_kanji.sscale(xscaled 0.77 shifted (20,0))(kanji.grsix.self));
  expand_pbox;
enddef;

vardef kanji.grnine.kyoto =
  push_pbox_toexpand("kanji.grnine.kyoto");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grfour.every);
  expand_pbox;
enddef;

vardef kanji.grnine.ladle =
  push_pbox_toexpand("kanji.grnine.ladle");
  kanji.radical.wrapping;
  push_stroke((340,400)..tension 1.2..(430,340)..(490,230),
    (1.1,1.1)--(1.4,1.4)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.grnine.leap_year =
  push_pbox_toexpand("kanji.grnine.leap_year");
  build_kanji.gate_enclose(kanji.grone.king);
  expand_pbox;
enddef;

vardef kanji.grnine.manor =
  push_pbox_toexpand("kanji.grnine.manor");
  build_kanji.dotcliff_enclose(kanji.grone.earth);
  expand_pbox;
enddef;

vardef kanji.grnine.moe =
  push_pbox_toexpand("kanji.grnine.moe");
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grtwo.light);
  expand_pbox;
enddef;

vardef kanji.grnine.moo =
  push_pbox_toexpand("kanji.grnine.moo");
  build_kanji.tb(510,0)
    (kanji.radical.mu)
    (kanji.grtwo.cow);
  expand_pbox;
enddef;

vardef kanji.grnine.mountain_high =
  push_pbox_toexpand("kanji.grnine.mountain_high");
  build_kanji.level(build_kanji.tb(360,30)
    (build_kanji.tb(420,150)
       (kanji.grone.ten)
       (kanji.toprad.grass))
    (kanji.rare.bald));
  expand_pbox;
enddef;

vardef kanji.grnine.must_not =
  push_pbox_toexpand("kanji.grnine.must_not");
  kanji.radical.wrapping;
  push_stroke(
    (480,610)..tension 1.2..(380,430)..(160,270),
    (1.6,1.6)--(1.4,1.4)--(1.0,1.0));
  push_stroke(
    (680,610)..tension 1.2..(540,300)..(180,80),
    (1.6,1.6)--(1.4,1.4)--(1.0,1.0));
  expand_pbox;
enddef;

vardef kanji.grnine.my =
  push_pbox_toexpand("kanji.grnine.my");
  build_kanji.level(build_kanji.tb(400,-30)
    (kanji.grone.five)
    (kanji.grone.mouth));
  expand_pbox;
enddef;

vardef kanji.grnine.ninth =
  push_pbox_toexpand("kanji.grnine.ninth");
  build_kanji.add_beret(
    kanji.grfour.gentleman;
    replace_strokep(-1)(oldp shifted (0,-60)));
  expand_pbox;
enddef;

vardef kanji.grnine.only =
  push_pbox_toexpand("kanji.grnine.only");
  build_kanji.tb(400,30)
    (kanji.grone.mouth)
    (kanji.radical.eight);
  expand_pbox;
enddef;

vardef kanji.grnine.page =
  push_pbox_toexpand("kanji.grnine.page");
  build_kanji.level(build_kanji.tb(120,20)
    (kanji.toprad.summer)
    (build_kanji.sscale(xscaled 0.85)(kanji.radical.eight)));
  expand_pbox;
enddef;

vardef kanji.grnine.permission =
  push_pbox_toexpand("kanji.grnine.permission");
  build_kanji.level(build_kanji.tb(440,-30)
    (kanji.radical.mu)
    (kanji.radical.legs));
  expand_pbox;
enddef;

vardef kanji.grnine.prosperity =
  push_pbox_toexpand("kanji.grnine.prosperity");
  build_kanji.level(build_kanji.tb(380,-40)
    (build_kanji.sscale(xscaled 0.76)(kanji.grone.day))
    (kanji.grone.day));
  expand_pbox;
enddef;

vardef kanji.grnine.snake_sign =
  push_pbox_toexpand("kanji.grnine.snake_sign");
  push_stroke((750,380)--(750,740)--(150,740),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  build_kanji.add_ltail(0);
  push_stroke((150,450)--(750,450),
    (1.5,1.5)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.grnine.southeast =
  push_pbox_toexpand("kanji.grnine.southeast");
  build_kanji.level(build_kanji.tb(460,-30)
    (build_kanji.lr(480,0)
       (kanji.grsix.self)
       (kanji.grsix.self))
    (kanji.grfour.together));
  expand_pbox;
enddef;

vardef kanji.grnine.square_jewel =
  push_pbox_toexpand("kanji.grnine.square_jewel");
  build_kanji.tb(440,10)
    (kanji.grone.earth)
    (kanji.grone.earth);
  expand_pbox;
enddef;

vardef kanji.grnine.suddenly =
  push_pbox_toexpand("kanji.grnine.suddenly");
  build_kanji.level(build_kanji.tb(360,80)
    (kanji.grnine.must_not)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.grnine.suffocate =
  push_pbox_toexpand("kanji.grnine.suffocate");
  build_kanji.tb(420,130)
    (build_kanji.spread_legs(110)
       (kanji.grone.big))
    (build_kanji.sscale(xyscaled (0.95,0.6) shifted (0,150))
       (kanji.grone.day);
     push_stroke(((0,130)+point 1.5 of get_strokep(-2)),(1.6,1.6));
     build_kanji.add_ltail(0);
     set_boserif(0,0,10));
  expand_pbox;
enddef;

vardef kanji.grnine.that =
  push_pbox_toexpand("kanji.grnine.that");
  build_kanji.level(build_kanji.tb(160,-20+20*mincho)
    (push_stroke((330,810)--(330,0),(1.6,1.6)--(1.5,1.5));
     set_boserif(0,0,10);
     push_stroke((670,810)--(670,0),(1.6,1.6)--(1.5,1.5));
     set_boserif(0,0,10);
     push_stroke((130,640)--(870,640),(1.5,1.5)--(1.5,1.5));
     set_boserif(0,1,9);
     push_stroke((330,430)--(670,430),(1.5,1.5)--(1.5,1.5));
     push_stroke((330,210)--(670,210),(1.5,1.5)--(1.5,1.5));
     push_stroke((120,0)--(880,0),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9))
    (kanji.radical.eight));
  expand_pbox;
enddef;

vardef kanji.grnine.to_be =
  push_pbox_toexpand("kanji.grnine.to_be");
  tsu_xform(identity shifted (0,250))(
    push_stroke((100,150)--(740,350),
      (1.4,1.4)--(1.6,1.6));
    set_botip(0,1,0);
    set_boserif(0,1,4);
    build_kanji.add_jtail(0);
  );
  push_stroke((220,740),(1.6,1.6));
  build_kanji.add_ltail(0);
  set_boserif(0,0,10);
  push_stroke((460,810)--(460,160),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.grnine.tomoe =
  push_pbox_toexpand("kanji.grnine.tomoe");
  kanji.grnine.snake_sign;
  push_stroke((450,740)--(450,450),(1.6,1.6)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.grnine.twenty =
  push_pbox_toexpand("kanji.grnine.twenty");
  push_stroke((100,440)--(900,440),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.cup((320,760),(680,0));
  expand_pbox;
enddef;

vardef kanji.grnine.two_branch_tree =
  push_pbox_toexpand("kanji.grnine.two_branch_tree");
  tsu_xform(identity shifted (0,-50))
    (build_kanji.add_beret(kanji.grone.wood));
  expand_pbox;
enddef;

vardef kanji.grnine.undergo =
  push_pbox_toexpand("kanji.grnine.undergo");
  build_kanji.level(build_kanji.tb(650,-20)
    (kanji.radical.kettle_lid)
    (build_kanji.tb(550,-40)
      (build_kanji.sscale(xscaled 0.9)(kanji.grone.mouth))
      (kanji.greight.completion)));
  expand_pbox;
enddef;
