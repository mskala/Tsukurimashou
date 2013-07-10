%
% Unicode page 53 (Kanji) for Tsukurimashou
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

% AUTODEPS
input bkencl.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.north =
  push_pbox_toexpand("kanji.grtwo.north");
  push_stroke((390,800)--(390,-20),(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((90,540)--(382,540),(1.6,1.6)--(1.6,1.6));
  push_stroke((920,660)..tension 1.2..(500,340)..(80,120),
    (1.1,1.1)--(1.6,1.6));
  push_stroke((610,800),(1.6,1.6));
  build_kanji.add_ltail(0);
  set_boserif(0,0,10);
  push_stroke(subpath
      (0,xpart (get_strokep(-1) intersectiontimes get_strokep(0)))
      of get_strokep(-1),
    (1.6,1.6)--(1.1,1.1));
  set_boserif(0,0,10);
  replace_strokep(-2)(subpath
      (xpart (oldp intersectiontimes get_strokep(-4)),infinity)
      of oldp);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.accept =
  push_pbox_toexpand("kanji.grthree.accept");
  build_kanji.tb(640,80)
    (kanji.toprad.paw)
    (build_kanji.tb(540,70)
       (kanji.radical.conservative_hat)
       (kanji.greight.otoh));
  expand_pbox;
enddef;

vardef kanji.grthree.doctor =
  push_pbox_toexpand("kanji.grthree.doctor");
  kanji.radical.box_on_side;
  build_kanji.sscale(scaled 0.75 shifted (40,0))(kanji.grtwo.arrow);
  expand_pbox;
enddef;

vardef kanji.grthree.number =
  push_pbox_toexpand("kanji.grthree.number");
  build_kanji.level(build_kanji.tb(500,40)
    (build_kanji.sscale(scaled 0.8)(kanji.grone.mouth))
    (kanji.greight.give;
     pop_stroke;
     replace_strokep(-2)((100,710)--(900,710));
     replace_strokep(-1)(subpath (xpart (oldp intersectiontimes
       get_strokep(-2)),infinity) of oldp));
     set_boserif(-1,0,whatever));
  expand_pbox;
enddef;

vardef kanji.grthree.take =
  push_pbox_toexpand("kanji.grthree.take");
  build_kanji.lr(520,50)
    (kanji.grone.ear)
    (tsu_xform(identity yscaled 0.83)(kanji.greight.otoh));
  expand_pbox;
enddef;

vardef kanji.grthree.ward =
  push_pbox_toexpand("kanji.grthree.ward");
  kanji.radical.box_on_side;
  build_kanji.sscale(scaled 0.75 shifted (40,0))
    (kanji.radical.cut_the_grass);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.cooperation =
  push_pbox_toexpand("kanji.grfour.cooperation");
  build_kanji.lr(340,50)
    (kanji.grone.ten;
     replace_strokep(0)(oldp shifted (0,180)))
    (build_kanji.level(build_kanji.tricluster(0.85)
       (kanji.grone.power)
       (kanji.grone.power)
       (kanji.grone.power)));
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

vardef kanji.grfour.participate =
  push_pbox_toexpand("kanji.grfour.participate");
  build_kanji.level(build_kanji.tcb(600,10)(320,120)
    (build_kanji.sscale(xscaled 0.8)(kanji.radical.mu))
    (build_kanji.spread_legs(140)(kanji.grone.big))
    (build_kanji.sscale(rotated 24 shifted (-60,0))
       (kanji.rightrad.short_hair)));
  expand_pbox;
enddef;

vardef kanji.grfour.professional =
  push_pbox_toexpand("kanji.grfour.professional");
  build_kanji.lr(340,60-20*mincho)
    (kanji.grone.ten;
     replace_strokep(0)(oldp shifted (0,80)))
    (kanji.rightrad.professional);
  expand_pbox;
enddef;

vardef kanji.grfour.seal =
  push_pbox_toexpand("kanji.grfour.seal");
  build_kanji.lr(480,40)
    (kanji.leftrad.seal)
    (build_kanji.sscale(yscaled 1.1 shifted (0,-110))(kanji.radical.seal));
  replace_strokep(0)(subpath (xpart (oldp intersectiontimes
    ((0,-80)--(1000,-80))),infinity) of oldp);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.divination =
  push_pbox_toexpand("kanji.grnine.divination");
  push_stroke((400,780)--(400,-20),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((400,500)..tension 1.1..(640,405)..(780,300),
    (1.3,1.3)--(1.6,1.6)--(1.8,1.8));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hou/tsutsu "wrap"
begintsuglyph("uni5305",5);
  kanji.grfour.wrap;
  tsu_render;
endtsuglyph;

% by itself means "be flustered"
begintsuglyph("uni5306",6);
  kanji.radical.crossed_must_not;
  tsu_render;
endtsuglyph;

% hi/saji "spoon"
begintsuglyph("uni5315",21);
  kanji.radical.spoon;
  tsu_render;
endtsuglyph;

% ka/ba "change"
begintsuglyph("uni5316",22);
  kanji.grthree.change;
  tsu_render;
endtsuglyph;

% hoku/kita "north"
begintsuglyph("uni5317",23);
  kanji.grtwo.north;
  tsu_render;
endtsuglyph;

% hou/hakogamae "box on side radical"
begintsuglyph("uni531A",26);
  kanji.radical.box_on_side;
  tsu_render;
endtsuglyph;

% kyou/suku "deliverance"
begintsuglyph("uni5321",33);
  kanji.grnine.deliverance;
  tsu_render;
endtsuglyph;

% ku "ward" (as in postal addresses)
begintsuglyph("uni533A",58);
  kanji.grthree.ward;
  tsu_render;
endtsuglyph;

% i "doctor"
begintsuglyph("uni533B",59);
  kanji.grthree.doctor;
  tsu_render;
endtsuglyph;

% juu/too "ten"
begintsuglyph("uni5341",65);
  kanji.grone.ten;
  tsu_render;
endtsuglyph;

% sen "one thousand"
begintsuglyph("uni5343",67);
  kanji.grone.one_thousand;
  tsu_render;
endtsuglyph;

% han/naka "half"
begintsuglyph("uni534A",74);
  kanji.grtwo.half;
  tsu_render;
endtsuglyph;

% go/uma "noon"
begintsuglyph("uni5348",72);
  kanji.grtwo.noon;
  tsu_render;
endtsuglyph;

% sotsu/so- "graduate"
begintsuglyph("uni5352",82);
  kanji.grfour.graduate;
  tsu_render;
endtsuglyph;

% kyou "cooperation"
begintsuglyph("uni5354",84);
  kanji.grfour.cooperation;
  tsu_render;
endtsuglyph;

% nan/minami "south"
begintsuglyph("uni5357",87);
  kanji.grtwo.south;
  tsu_render;
endtsuglyph;

% tan/hitoe "single"
begintsuglyph("uni5358",88);
  kanji.grfour.single;
  tsu_render;
endtsuglyph;

% haku "professional"
begintsuglyph("uni535A",90);
  kanji.grfour.professional;
  tsu_render;
endtsuglyph;

% boku/urana "divination"
begintsuglyph("uni535C",92);
  kanji.grnine.divination;
  tsu_render;
endtsuglyph;

% sen/urana "divination"
begintsuglyph("uni5360",96);
  kanji.greight.divination;
  tsu_render;
endtsuglyph;

% setsu/warifu "seal radical"
begintsuglyph("uni5369",105);
  kanji.radical.seal;
  tsu_render;
endtsuglyph;

% in/shiroshi "seal"
begintsuglyph("uni5370",112);
  kanji.grfour.seal;
  tsu_render;
endtsuglyph;

% soku/tsu "instant"
begintsuglyph("uni5373",115);
  kanji.greight.instant;
  tsu_render;
endtsuglyph;

% karigane "cliff radical"
begintsuglyph("uni5382",130);
  build_kanji.cliff_enclose();
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5386",134);
  build_kanji.cliff_enclose(kanji.grone.power);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5388",136);
  build_kanji.cliff_enclose(build_kanji.sscale(yscaled 0.85 shifted (0,-100))
    (kanji.grsix.dry));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5389",137);
  build_kanji.cliff_enclose(tsu_xform(identity yscaled 0.92)
    (kanji.grtwo.myriad));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni538F",143);
  build_kanji.cliff_enclose(kanji.rare.notwithstanding);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5393",147);
  build_kanji.cliff_enclose(kanji.grnine.square_jewel);
  tsu_render;
endtsuglyph;

% gen/hara "field"
begintsuglyph("uni539F",159);
  kanji.grtwo.field;
  tsu_render;
endtsuglyph;

% "mu radical"
begintsuglyph("uni53B6",182);
  kanji.radical.mu;
  tsu_render;
endtsuglyph;

% kyo/sa "go away"
begintsuglyph("uni53BB",187);
  kanji.grthree.go_away;
  tsu_render;
endtsuglyph;

% san/mai multiple meanings including "participate"
begintsuglyph("uni53C2",194);
  kanji.grfour.participate;
  tsu_render;
endtsuglyph;

% yuu/mata "on the other hand"
begintsuglyph("uni53C8",200);
  kanji.greight.otoh;
  tsu_render;
endtsuglyph;

% kyuu/oyo "reach"
begintsuglyph("uni53CA",202);
  kanji.greight.reach;
  tsu_render;
endtsuglyph;

% yuu/tomo "friend"
begintsuglyph("uni53CB",203);
  kanji.grtwo.friend;
  tsu_render;
endtsuglyph;

% han/so "anti"
begintsuglyph("uni53CD",205);
  kanji.grthree.anti;
  tsu_render;
endtsuglyph;

% shu/tori "take"
begintsuglyph("uni53D6",214);
  kanji.grthree.take;
  tsu_render;
endtsuglyph;

% shu/u "accept"
begintsuglyph("uni53D7",215);
  kanji.grthree.accept;
  tsu_render;
endtsuglyph;

% kou/kuchi "mouth"
begintsuglyph("uni53E3",227);
  kanji.grone.mouth;
  tsu_render;
endtsuglyph;

% ko/furo "old"
begintsuglyph("uni53E4",228);
  kanji.grtwo.old;
  tsu_render;
endtsuglyph;

% ku "phrase"
begintsuglyph("uni53E5",229);
  kanji.grfive.phrase;
  tsu_render;
endtsuglyph;

% kou/tata "smash"
begintsuglyph("uni53E9",233);
  kanji.rare.smash;
  tsu_render;
endtsuglyph;

% tada "only"
begintsuglyph("uni53EA",234);
  kanji.grnine.only;
  tsu_render;
endtsuglyph;

% shou/me "call"
begintsuglyph("uni53EC",236);
  kanji.greight.call;
  tsu_render;
endtsuglyph;

% ka/be "passable"
begintsuglyph("uni53EF",239);
  kanji.grfive.passable;
  tsu_render;
endtsuglyph;

% tai/utana "pedestal"
begintsuglyph("uni53F0",240);
  kanji.grtwo.pedestal;
  tsu_render;
endtsuglyph;

% shi "history"
begintsuglyph("uni53F2",242);
  kanji.grfour.history;
  tsu_render;
endtsuglyph;

% migi "right"
begintsuglyph("uni53F3",243);
  kanji.grone.right;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni53F4",244);
  build_kanji.tb(470,50)
    (kanji.grone.nine)
    (build_kanji.sscale(xscaled 0.83 shifted (-50,0))
      (kanji.grone.mouth));
  tsu_render;
endtsuglyph;

% gou/sake "number"
begintsuglyph("uni53F7",247);
  kanji.grthree.number;
  tsu_render;
endtsuglyph;

% shi/tsukasado "director" or "official (person)"
begintsuglyph("uni53F8",248);
  kanji.grfour.director;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
