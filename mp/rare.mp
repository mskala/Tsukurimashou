%
% Rare kanji needed to build others
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

inclusion_lock(rare);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.rare.ancient_pig =
  push_pbox_toexpand("kanji.rare.ancient_pig");
  build_kanji.level(
    kanji.radical.narrow_flag;
    build_kanji.sscale(xyscaled (0.63,0.66) shifted (30,-120))
      (kanji.greight.towel));
  expand_pbox;
enddef;

vardef kanji.rare.art =
  push_pbox_toexpand("kanji.rare.art");
  build_kanji.level(build_kanji.lr(420,10)
    (build_kanji.sscale(yscaled 0.94 shifted (0,-40))(build_kanji.tb(330,40)
       (kanji.rare.mushroom)
       (kanji.leftrad.earth)))
    (kanji.grtwo.circle));
  expand_pbox;
enddef;

vardef kanji.rare.bald =
  push_pbox_toexpand("kanji.rare.bald");
  build_kanji.level(build_kanji.tb(690,180)
    (kanji.grone.one)
    (kanji.radical.legs));
  expand_pbox;
enddef;

vardef kanji.rare.be_methodical =
  push_pbox_toexpand("kanji.rare.be_methodical");
  build_kanji.level(
    build_kanji.sscale(yscaled 0.8 shifted (0,100))(kanji.radical.tent);
    build_kanji.sscale(yscaled 0.56 shifted (0,-200))
      (kanji.radical.gmm;
       push_stroke((383,780)--(383,0),(1.6,1.6)--(1.5,1.5));
       push_stroke((617,780)--(617,0),(1.6,1.6)--(1.5,1.5));
       push_stroke((150,410)--(850,410),(1.5,1.5)--(1.5,1.5))));
  expand_pbox;
enddef;

vardef kanji.rare.befuddled =
  push_pbox_toexpand("kanji.rare.befuddled");
  build_kanji.level(build_kanji.tb(460,120)
    (build_kanji.sscale(scaled 0.9)(kanji.grone.mouth))
    (kanji.grone.wood));
  expand_pbox;
enddef;

vardef kanji.rare.big_brother =
  push_pbox_toexpand("kanji.rare.big_brother");
  build_kanji.tb(440,0)
    (kanji.grfive.passable)
    (build_kanji.sscale(xscaled 1.03)(kanji.grfive.passable));
  expand_pbox;
enddef;

vardef kanji.rare.bobbin =
  push_pbox_toexpand("kanji.rare.bobbin");
  build_kanji.level(build_kanji.tb(480,20)
    (kanji.radical.silly_hat)
    (kanji.grthree.thumbtack));
  expand_pbox;
enddef;

vardef kanji.rare.branch =
  push_pbox_toexpand("kanji.rare.branch");
  push_stroke((770,810)..tension 1.2..(550,740)..(250,700),
    (1.8,1.8)--(1.5,1.5)--(1,1));
  push_stroke((250,730){down}..(160,180)..(50,30),
    (1.6,1.6)--(1.3,1.3)--(1,1));
  set_boserif(0,0,10);
  build_kanji.sscale(rotated 90 slanted 0.1 rotated -90
       xyscaled (0.8,0.75) shifted (80,-50))
    (kanji.radical.travel_inside);
  expand_pbox;
enddef;

vardef kanji.rare.cash =
  push_pbox_toexpand("kanji.rare.cash");
  build_kanji.level(build_kanji.tb(600,60)
    (build_kanji.sscale(xyscaled (0.8,1.1))(kanji.toprad.sparkle_two))
    (kanji.grtwo.big_brother));
  expand_pbox;
enddef;

vardef kanji.rare.centurion =
  push_pbox_toexpand("kanji.rare.centurion");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(yscaled 0.9)(kanji.grone.hundred));
  expand_pbox;
enddef;

vardef kanji.rare.clear =
  push_pbox_toexpand("kanji.rare.clear");
  kanji.radical.gmm;
  build_kanji.sscale(xyscaled (0.7,0.84))(build_kanji.tb(520,40)
    (kanji.radical.legs)
    (build_kanji.sscale(scaled 0.7)(kanji.grone.mouth)));
  expand_pbox;
enddef;

vardef kanji.rare.clod_of_earth =
  push_pbox_toexpand("kanji.rare.clod_of_earth");
  build_kanji.tb(280,40)
    (kanji.rare.mushroom)
    (kanji.grone.earth);
  expand_pbox;
enddef;

% dictionary says "name of an ancient tribe"; needed for grfour.low
vardef kanji.rare.cruithne =
  push_pbox_toexpand("kanji.rare.cruithne");
  kanji.grfour.clan;
  replace_strokep(-3)((250,730)--(250,120));
  replace_strokep(-2)(oldp shifted (0,130));
  push_stroke((180,-10)--(600,-10),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.rare.decide =
  push_pbox_toexpand("kanji.rare.decide");
  kanji.grfour.husband;
  replace_strokep(-3)((210,610)--(760,610)--(760,360));
  replace_strokeq(-3)((1.5,1.5)--(1.5,1.5)--(1.4,1.4));
  set_boserif(-3,1,4);
  set_botip(-3,1,1);
  expand_pbox;
enddef;

vardef kanji.rare.decorate =
  push_pbox_toexpand("kanji.rare.decorate");
  build_kanji.level(build_kanji.tb(480,-10)
    (build_kanji.tb(390,150)
     (kanji.grone.ten)
     (kanji.toprad.grass))
    (kanji.grone.shell));  
  expand_pbox;
enddef;

vardef kanji.rare.deficient =
  push_pbox_toexpand("kanji.rare.deficient");
  build_kanji.level(build_kanji.sscale(yscaled 1.1 shifted (0,40))
    (build_kanji.tb(500,100)
       (build_kanji.sscale(xscaled 0.8)(kanji.grone.one))
       (kanji.rare.obstruction)));
  expand_pbox;
enddef;

vardef kanji.rare.director =
  push_pbox_toexpand("kanji.rare.director");
  tsu_xform(identity yscaled 0.5 shifted (0,400))
    (kanji.radical.pigs_snout);
  push_stroke(
    (point 0.5 of get_strokep(-2))..tension 1.4..(340,360)..(60,100),
    (1.6,1.6)--(1.4,1.4)--(0.9,0.9));
  expand_pbox;
enddef;

vardef kanji.rare.dollar =
  push_pbox_toexpand("kanji.rare.dollar");
  push_stroke((140,680)--(800,680)--(800,440),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((180,500)--(800,500),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((185,535-15*mincho)..tension 1.2..(150,350)..(100,240),
    (1.7,1.7)--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((get_strokep(0) intersectionpoint ((0,300)--(1000,300)))--
      (870,300),
    (1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((380,810){down}..(260,150)..(100,-60),
    (1.6,1.6)--(1.3,1.3)--(1,1));
  set_boserif(0,0,10);
  push_stroke((620,810)--(620,-60),(1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.rare.drink =
  push_pbox_toexpand("kanji.rare.early_death");
  build_kanji.level(build_kanji.tb(420,290)
    (build_kanji.spread_legs(160)
       (kanji.rare.early_death))
    (build_kanji.sscale(xyscaled (0.8,0.7) shifted (0,-50))
       (kanji.grone.mouth)));
  expand_pbox;
enddef;

vardef kanji.rare.early_death =
  push_pbox_toexpand("kanji.rare.early_death");
  build_kanji.add_beret(kanji.grone.big);
  expand_pbox;
enddef;

vardef kanji.rare.extremely =
  push_pbox_toexpand("kanji.rare.extremely");
  build_kanji.level(
    path my_saved_path;
    tsu_xform(identity shifted (-500,-740)
      xyscaled (0.5,0.87) shifted (440,740))
      (kanji.rare.obstruction;
       my_saved_path:=get_strokep(-2));
    replace_strokep(-2)(my_saved_path shifted (-500,0)
      xscaled 0.9 shifted (500,0));
    replace_strokep(-1)(subpath (0,(length oldp)-0.4) of oldp);
    push_stroke((get_strokep(0) intersectionpoint ((0,450)--(1000,450)))--
        (820,450)..tension 1.2..(770,260)..(660,100),
      (1.5,1.5)--(1.6,1.6)--(1.4,1.4)--(0.9,0.95));
    set_boserif(0,1,4);
    set_botip(0,1,1);
    push_stroke((660,330)..tension 1.2..(750,270)..(860,120),
      (1,1)--(1.3,1.3)--(1.6,1.6));
    build_kanji.box((180,400),(400,210));
    push_stroke(my_saved_path shifted (0,-740),(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
  );
  expand_pbox;
enddef;

vardef kanji.rare.finally =
  push_pbox_toexpand("kanji.rare.finally");
  build_kanji.tb(480,-70)
    (kanji.grone.stand_up)
    (build_kanji.level(build_kanji.tb(440,70)
       (kanji.grone.day)
       (kanji.radical.legs)));
  expand_pbox;
enddef;

vardef kanji.rare.glorious =
  push_pbox_toexpand("kanji.rare.glorious");
  kanji.grfour.non;
  push_stroke((130,-70)--(870,-70),(1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.rare.high_spirits =
  push_pbox_toexpand("kanji.rare.high_spirits");
  build_kanji.level(build_kanji.tb(520,-100)
    (kanji.radical.kettle_lid)
    (kanji.radical.windy));
  expand_pbox;
enddef;

vardef kanji.rare.history_inside =
  push_pbox_toexpand("kanji.rare.history_inside");
  build_kanji.tb(420,80)
    (kanji.grone.grove)
    (kanji.grtwo.cease);
  expand_pbox;
enddef;

vardef kanji.rare.merger =
  push_pbox_toexpand("kanji.rare.merger");
  build_kanji.level(build_kanji.tb(620,110)
    (build_kanji.spread_legs(-220)(kanji.toprad.sparkle_two))
    (kanji.radical.topped_aitch));
  expand_pbox;
enddef;

% This obscure form of the "grass" radical seems to be used only in U+83D0,
% an obscure kanji that doesn't seem to have a meaning of its own but forms
% the right-hand side of the fairly common kanji for the masculine
% first-person pronoun "boku," which we need in order to spell the type
% style name "Bokukko." It's not even clear that it really is a form of the
% "grass" radical at all, but that's how Unicode seems to classify it.

vardef kanji.rare.obscure_grass_toprad =
  push_pbox_toexpand("kanji.rare.obscure_grass_toprad");
  kanji.toprad.sparkle_four;
  push_stroke((110,-20)--(890,-20),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.rare.eight_three_dee_zero =
  push_pbox_toexpand("kanji.rare.eight_three_dee_zero");
  build_kanji.tb(620,0)
    (kanji.rare.obscure_grass_toprad)
    (kanji.radical.twin_tailed_sheep);
  expand_pbox;
enddef;

vardef kanji.rare.in_the_least =
  push_pbox_toexpand("kanji.rare.in_the_least");
  build_kanji.tb(620,90)
    (kanji.toprad.grass;
     replace_strokep(-2)(oldp shifted (70,0)))
    (kanji.grfive.phrase);
  expand_pbox;
enddef;

vardef kanji.rare.mosquito_larva =
  push_pbox_toexpand("kanji.rare.mosquito_larva");
  kanji.grone.child;
  replace_strokep(0)((110,290)..tension 1.2..(500,350)..(890,530));
  replace_strokeq(0)((1.9,1.9)--(1.6,1.6)--(0.9,0.9));
  set_boserif(0,1,whatever);
  expand_pbox;
enddef;

vardef hook.mound_bottoms(expr left_i,right_i,bottom_i) =
  if (obstacktype[left_i]=otstroke)
    and (obstacktype[right_i]=otstroke)
    and (obstacktype[bottom_i]=otstroke):
    if (3=length obstackp[left_i])
      and (2=length obstackp[right_i])
      and (1=length obstackp[bottom_i]):
      begingroup;
        save x,y,p,e;
        numeric x[],y[],e[];
        path p[];
        
        p1=obstackp[left_i];
        p2=obstackp[bottom_i];
        p3=obstackp[right_i];

        z1=-(direction 0 of p1)/abs(direction 0 of p1);
        z2=(direction 0.5 of p2)/abs(direction 0.5 of p2);
        z3=(direction 2 of p3)/abs(direction 2 of p3);

        e3=obstackna.bosize[bottom_i]*tsu_brush_max*tsu_brush_shape*0.5;
        if abs(z1 dotprod z2)<0.1:
          point 0 of p1=z4+e1*z1;
          z4=(point 0.5 of p2)+whatever*z2;

          if e1<e3:
            p1:=(z4+e3*z1)--(subpath (1,3) of p1);
            obstackp[left_i]:=p1;
          fi;
        fi;
        if abs(z3 dotprod z2)<0.1:
          point 0 of p1=z5+e2*z3;
          z5=(point 0.5 of p2)+whatever*z2;

          if e2<e3:
            p3:=(subpath (0,1) of p2)--(z5+e3*z2);
            obstackp[right_i]:=p3;
          fi;
        fi;
      endgroup;
    fi;
  fi;
enddef;

vardef kanji.rare_helper.mound =
  push_pbox_toexpand("kanji.rare_helper.mound");
  begingroup
    save x,y;
    numeric x[],y[];

    x1=x2=x5=x7=x10=180;
    x3=x4=x6=0.87[x1,x8];
    x8=x9=x11=1000-x1;

    y1=y9=(-0.2)[y10,y7];
    y2=y3=780;
    y4=(-0.2)[y5,y2];
    y5=y6=530;
    y7=y8=290;
    y10=y11=0;
    
    push_stroke(z1--z2--z3--z4,(1.5,1.5)--(1.7,1.7)--(1.7,1.7)--(1.5,1.5));
    set_botip(0,1,1);
    set_botip(0,2,1);
    set_boserif(0,1,4);
    set_boserif(0,2,4);
    push_stroke(z5--z6,(1.5,1.5)--(1.5,1.5));
    push_stroke(z7--z8--z9,(1.5,1.5)--(1.6,1.6)--(1.5,1.5));
    set_botip(0,1,1);
    set_boserif(0,1,4);
    push_stroke(z10--z11,(1.5,1.5)--(1.5,1.5));

    push_hook(hsmain_render,
      "hook.box_bottom("&(decimal find_stroke(-3))&","
                        &(decimal find_stroke(-2))&");" );
    push_hook(hsmain_render,
      "hook.mound_bottoms("&(decimal find_stroke(-3))&","
                           &(decimal find_stroke(-1))&","
                           &(decimal find_stroke(0))&");" );
  endgroup;
  expand_pbox;
enddef;

vardef kanji.rare.mound =
  push_pbox_toexpand("kanji.rare.mound");
  build_kanji.attach_tick(660)(kanji.rare_helper.mound);
  expand_pbox;
enddef;

vardef kanji.rare.mushroom =
  push_pbox_toexpand("kanji.rare.mushroom");
  build_kanji.tb(450,60)
    (kanji.grone.earth)
    (kanji.radical.legs);
  expand_pbox;
enddef;

vardef kanji.rare.mysterious =
  push_pbox_toexpand("kanji.rare.mysterious");
  push_stroke((200,810))((1.7,1.7));
  build_kanji.add_ltail(0);
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.rare.notwithstanding =
  push_pbox_toexpand("kanji.rare.notwithstanding");
  push_stroke((370,790){curl 0.1}..(250,580)..(60,350),
    (1.7,1.7)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,10);
  push_stroke(
    (((0,620)--(1000,620)) intersectionpoint get_strokep(0))--(890,620),
    (1.4,1.4)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((420,620)--(420,-20),
    (1.6,1.6)--(1.4,1.4));
  push_stroke((420,410)--(790,410),
    (1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  push_stroke((420,200)--(840,200),
    (1.5,1.5)--(1.5,1.5));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.rare.obey =
  push_pbox_toexpand("kanji.rare.obey");
  build_kanji.tb(640,50)
    (build_kanji.spread_legs(-180)(kanji.toprad.sparkle_two))
    (kanji.radical.pig);
  expand_pbox;
enddef;

vardef kanji.rare.obstruction =
  push_pbox_toexpand("kanji.rare.obstruction");
  push_stroke((90,740)--(910,740),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((320,736)..tension 1.2..(290,550)..(230,360),
    (1.7,1.7)--(1.6,1.6)--(1.6,1.6));
  push_stroke((get_strokep(0) intersectionpoint ((0,500)--(1000,500)))--
      (780,500)..tension 1.7..(750,250)..(600,-10)..{curl 0.1}(390,0),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5)--(1.7,1.7)--(1.8,1.8));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  expand_pbox;
enddef;

vardef kanji.rare.other =
  push_pbox_toexpand("kanji.rare.other");
  build_kanji.tb(450,200)
    (kanji.radical.silly_hat)
    (build_kanji.sscale(xscaled 0.79)
       (kanji.radical.spoon));
  expand_pbox;
enddef;

vardef kanji.rare.outspokenly =
  push_pbox_toexpand("kanji.rare.outspokenly");
  build_kanji.level(build_kanji.tb(540,40)
    (build_kanji.sscale(scaled 0.84)(build_kanji.lr(480,0)
       (kanji.grone.mouth)(kanji.grone.mouth)))
    (kanji.rare.deficient));
  expand_pbox;
enddef;

vardef kanji.rare.punish =
  push_pbox_toexpand("kanji.rare.punish");
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.radical.flag;
     build_kanji.box((280,280),(780,0)))
    (kanji.greight.acrid));
  expand_pbox;
enddef;

vardef kanji.rare.roll_of_cloth =
  push_pbox_toexpand("kanji.rare.roll_of_cloth");
  build_kanji.level(build_kanji.tb(360,20)
    (build_kanji.tb(460,180)
       (kanji.grone.one)
       (build_kanji.sscale(scaled 0.8)(kanji.grone.mouth)))
    (kanji.grone.paddy));
  expand_pbox;
enddef;

vardef kanji.rare.sacred =
  push_pbox_toexpand("kanji.rare.sacred");
  build_kanji.level(build_kanji.tb(380,100)
    (kanji.greight.otoh)
    (kanji.grone.earth));
  expand_pbox;
enddef;

vardef kanji.rare.smash =
  push_pbox_toexpand("kanji.rare.smash");
  build_kanji.level(build_kanji.lr(500,-70)
    (tsu_xform(identity shifted (0,100))(kanji.grone.mouth))
    (kanji.radical.seal));
  expand_pbox;
enddef;

vardef kanji.rare.spiced_liqueur =
  push_pbox_toexpand("kanji.rare.spiced_liqueur");
  build_kanji.tb(400,-60)
    (push_stroke((280,720)..(520,480)..(700,180),
       (1,1)--(1.4,1.4)--(1.7,1.7));
     set_bosize(0,90);
     push_stroke((730,780)..(530,440)..(260,140),
       (1.7,1.7)--(1.5,1.5)--(1.1,1.1));
     set_boserif(0,0,10);
     set_bosize(0,90);
     push_stroke((470,780)..(510,750)..(530,700),(1,1)--(1.5,1.5)--(1.7,1.7));
     set_bosize(0,90);
     push_stroke((230,490)..(270,460)..(290,410),(1,1)--(1.5,1.5)--(1.7,1.7));
     set_bosize(0,90);
     push_stroke((700,470)..(740,440)..(760,390),(1,1)--(1.5,1.5)--(1.7,1.7));
     set_bosize(0,90);
     push_stroke((470,210)..(510,180)..(530,130),(1,1)--(1.5,1.5)--(1.7,1.7));
     set_bosize(0,90);
     build_kanji.cup((110,810),(890,0)))
    (kanji.radical.spoon);
  expand_pbox;
enddef;

vardef kanji.rare.sun =
  push_pbox_toexpand("kanji.rare.sun");
  build_kanji.tb(510,-30)
    (tsu_xform(identity shifted (30,0))(kanji.grone.day))
    (kanji.grnine.must_not;
     set_boserif(-3,0,whatever);
     push_stroke((100,780)--(900,780),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9));
  expand_pbox;
enddef;

vardef kanji.rare.swim =
  push_pbox_toexpand("kanji.rare.swim");
  build_kanji.level(build_kanji.flag_enclose(0.72,0.7)
    (kanji.grone.child));
  expand_pbox;
enddef;

vardef kanji.rare.the_same =
  push_pbox_toexpand("kanji.rare.the_same");
  tsu_xform(identity yscaled (830/760))
    (kanji.radical.ceremony;
     replace_strokep(-2)
       ((50,-50)..(120,100)..(150,300)..tension 1.2..(160,540)--(880,540));
     replace_strokeq(-2)
       ((1,1)--(1.3,1.3)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6)));
  set_botip(-2,3,1);
  set_boserif(-2,1,whatever);
  replace_strokep(-1)(oldp shifted (-950,0) xscaled 0.6 shifted (950,0));
  replace_strokep(0)(oldp shifted (-950,0) xscaled 0.6 shifted (950,0));
  push_stroke((if sharp_corners: 240 else: 270 fi,440)--
      (if sharp_corners: 570 else: 540 fi,440),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.box((280,310),(530,50));
  push_stroke((830,420)..tension 1.2..(700,150)..(480,-70),
    (1.6,1.6)--(1.4,1.4)--(0.9,0.9));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.rare.uncultivated =
  push_pbox_toexpand("kanji.rare.uncultivated");
  build_kanji.level(build_kanji.tb(650,70)
    (kanji.radical.kettle_lid)
    (build_kanji.tb(520,-30)
       (kanji.radical.mu)
       (tsu_xform(identity shifted (40,0))
          (tsu_xform(identity xscaled 0.84)(kanji.grone.river);
           replace_strokep(0)((point 0 of oldp));
           replace_strokeq(0)((point 0 of oldq));
           build_kanji.add_ltail(0)))));
  expand_pbox;
enddef;

vardef kanji.rare.walled_road =
  push_pbox_toexpand("kanji.rare.walled_road");
  push_stroke((200,740)--(770,740)..tension 1.2..(630,650)..(490,590),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_botip(0,1,0);
  set_boserif(0,1,4);
  push_stroke((320,660)..tension 1.2..(490,590)..(520,560),
    (1.1,1.1)--(1.5,1.5)--(1.8,1.8));
  push_stroke((170,-40)--(170,530)--(830,530),
    (1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  push_stroke((500,530)--(500,-20),(1.6,1.6)--(1.5,1.5));
  push_stroke((170,370)--(830,370),(1.5,1.5)--(1.5,1.5));
  push_stroke((170,210)--(830,210),(1.5,1.5)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.rare.yin =
  push_pbox_toexpand("kanji.rare.yin");
  build_kanji.tb(380,100)
    (kanji.grtwo.now)
    (kanji.grnine.declaim);
  expand_pbox;
enddef;
