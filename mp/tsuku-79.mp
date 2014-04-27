%
% Unicode page 79 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2014  Matthew Skala
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
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.autumn =
  push_pbox_toexpand("kanji.grtwo.autumn");
  build_kanji.lr(450,120)
    (kanji.leftrad.two_branch_tree)
    (kanji.grone.fire);
  expand_pbox;
enddef;

vardef kanji.grtwo.company =
  push_pbox_toexpand("kanji.grtwo.company");
  build_kanji.lr(450,120)
    (kanji.leftrad.showing)
    (kanji.grone.earth);
  expand_pbox;
enddef;

vardef kanji.grtwo.department =
  push_pbox_toexpand("kanji.grtwo.department");
  build_kanji.lr(470,90)
    (build_kanji.lift_skirt(300,140)
       (kanji.leftrad.two_branch_tree);
     replace_strokep(-4)((point 0 of oldp)..(xpart point 1 of oldp,-50)))
    (kanji.greight.dipper);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.ceremony =
  push_pbox_toexpand("kanji.grthree.ceremony");
  build_kanji.lr(540,-30)
    (kanji.leftrad.showing)
    (push_stroke((120,810),(1.6,1.6));
     set_boserif(0,0,10);
     build_kanji.add_ltail(0));
  expand_pbox;
enddef;

vardef kanji.grthree.deity =
  push_pbox_toexpand("kanji.grthree.deity");
  build_kanji.lr(450,40)
    (kanji.leftrad.showing)
    (kanji.grthree.have_honour);
  expand_pbox;
enddef;

vardef kanji.grthree.good_luck =
  push_pbox_toexpand("kanji.grthree.deity");
  build_kanji.lr(450,20)
    (kanji.leftrad.showing)
    (kanji.rare.roll_of_cloth);
  expand_pbox;
enddef;

vardef kanji.grthree.second_of_time =
  push_pbox_toexpand("kanji.grthree.second_of_time");
  build_kanji.level(build_kanji.lr(470,40)
    (build_kanji.lift_skirt(300,140)
       (kanji.leftrad.two_branch_tree))
    (kanji.grtwo.little));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.celebrate =
  push_pbox_toexpand("kanji.grfour.celebrate");
  build_kanji.lr(450,20)
    (kanji.leftrad.showing)
    (kanji.grtwo.big_brother);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.forbidden =
  push_pbox_toexpand("kanji.grfive.forbidden");
  build_kanji.tb(460,20)
    (kanji.grone.grove)
    (kanji.grfive.showing);
  expand_pbox;
enddef;

vardef kanji.grfive.pioneer =
  push_pbox_toexpand("kanji.grfive.pioneer");
  build_kanji.lr(450,20)
    (kanji.leftrad.showing)
    (kanji.greight.furthermore);
  expand_pbox;
enddef;

vardef kanji.grfive.shift =
  push_pbox_toexpand("kanji.grfive.shift");
  build_kanji.level(build_kanji.lr(380,30)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 0.96 shifted (0,-20))(kanji.grtwo.many)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.i =
  push_pbox_toexpand("kanji.grsix.i");
  build_kanji.lr(520,60)
    (kanji.leftrad.two_branch_tree)
    (kanji.radical.mu);
  expand_pbox;
enddef;

vardef kanji.grsix.secret =
  push_pbox_toexpand("kanji.grsix.secret");
  build_kanji.lr(460,-20)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,-10))(kanji.grfour.inevitable));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.crop_tax =
  push_pbox_toexpand("kanji.greight.crop_tax");
  build_kanji.lr(440,60)
    (kanji.leftrad.two_branch_tree)
    (kanji.greight.furthermore);
  expand_pbox;
enddef;

vardef kanji.greight.regularity =
  push_pbox_toexpand("kanji.greight.regularity");
  build_kanji.lr(460,20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.disappear);
  expand_pbox;
enddef;

vardef kanji.greight.zen_buddhism =
  push_pbox_toexpand("kanji.greight.zen_buddhism");
  build_kanji.lr(450,40-20*mincho)
    (kanji.leftrad.showing)
    (kanji.grfour.single);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.weigh_scale =
  push_pbox_toexpand("kanji.grnine.weigh_scale");
  build_kanji.lr(460,20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.level);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ji/shime "show" (also older radical form)
begintsuglyph("uni793A",58);
  kanji.grfive.showing;
  tsu_render;
endtsuglyph;

% "showing" radical (simple, more popular form)
begintsuglyph("uni793B",59);
  kanji.leftrad.showing;
  tsu_render;
endtsuglyph;

% rei "ceremony"
begintsuglyph("uni793C",60);
  kanji.grthree.ceremony;
  tsu_render;
endtsuglyph;

% sha/yashiro "company"
begintsuglyph("uni793E",62);
  kanji.grtwo.company;
  tsu_render;
endtsuglyph;

% so "pioneer"
begintsuglyph("uni7956",86);
  kanji.grfive.pioneer;
  tsu_render;
endtsuglyph;

% shin/kami "deity"
begintsuglyph("uni795E",94);
  kanji.grthree.deity;
  tsu_render;
endtsuglyph;

% shuku/iwa "celebrate"
begintsuglyph("uni795D",93);
  kanji.grfour.celebrate;
  tsu_render;
endtsuglyph;

% hyou "ticket"
begintsuglyph("uni7968",104);
  kanji.grfour.ticket;
  tsu_render;
endtsuglyph;

% sei/matsuri "festival"
begintsuglyph("uni796D",109);
  kanji.grthree.festival;
  tsu_render;
endtsuglyph;

% kin "forbidden"
begintsuglyph("uni7981",129);
  kanji.grfive.forbidden;
  tsu_render;
endtsuglyph;

% zen/shizuka "Zen Buddhism"
begintsuglyph("uni7985",133);
  kanji.greight.zen_buddhism;
  tsu_render;
endtsuglyph;

% fuku/toshi "good luck"
begintsuglyph("uni798F",143);
  kanji.grthree.good_luck;
  tsu_render;
endtsuglyph;

% ka/ine little meaning by itself, called "two-branch tree" as a radical
begintsuglyph("uni79BE",190);
  kanji.grnine.two_branch_tree;
  tsu_render;
endtsuglyph;

% shi/watashi "first person pronoun"
begintsuglyph("uni79C1",193);
  kanji.grsix.i;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79C4",196);
  build_kanji.lr(480,70)
    (kanji.leftrad.two_branch_tree)
    (kanji.grone.child);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79C6",198);
  build_kanji.lr(520,40)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,-30))(kanji.grsix.dry));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79C7",199);
  build_kanji.lr(460,50)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,-20))(kanji.grtwo.circle));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79C8",200);
  build_kanji.lr(460,-20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grone.mountain);
  tsu_render;
endtsuglyph;

% shuu/aki "autumn"
begintsuglyph("uni79CB",203);
  kanji.grtwo.autumn;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79CD",205);
  build_kanji.lr(480,20)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,-30))(kanji.grone.middle));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79CE",206);
  build_kanji.lr(520,60)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.minute);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79CF",207);
  build_kanji.lr(480,70)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.hair);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79D0",208);
  build_kanji.lr(480,70)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 1.06 shifted (0,40))(kanji.grnine.declaim));
  tsu_render;
endtsuglyph;

% ka "department"
begintsuglyph("uni79D1",209);
  kanji.grtwo.department;
  tsu_render;
endtsuglyph;

% byou "second of time"
begintsuglyph("uni79D2",210);
  kanji.grthree.second_of_time;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79D3",211);
  build_kanji.level(build_kanji.lr(500,70)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfive.support));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79D4",212);
  build_kanji.lr(480,70)
    (kanji.leftrad.two_branch_tree)
    (kanji.rare.high_spirits);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79D5",213);
  build_kanji.lr(460,30)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfive.compare);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79D6",214);
  build_kanji.lr(460,60)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,10))(kanji.grfour.clan));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79D7",215);
  build_kanji.lr(460,40)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,-30))(kanji.rare.early_death));
  tsu_render;
endtsuglyph;

% hi as in himitsu "secret"
begintsuglyph("uni79D8",216);
  kanji.grsix.secret;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79D9",217);
  build_kanji.lr(460,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.old);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79DA",218);
  build_kanji.lr(460,60)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.half);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79DB",219);
  build_kanji.lr(400,20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.pelt);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79DC",220);
  build_kanji.lr(440,40)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 1.05)(kanji.greight.nun));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79DD",221);
  build_kanji.lr(480,20-20*mincho)
    (kanji.leftrad.two_branch_tree)
    (kanji.grnine.two_branch_tree);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79DE",222);
  build_kanji.lr(460,60)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.reason);
  tsu_render;
endtsuglyph;

% so "crop tax"
begintsuglyph("uni79DF",223);
  kanji.greight.crop_tax;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79E0",224);
  build_kanji.lr(460,30)
    (kanji.leftrad.two_branch_tree)
    (kanji.rare.glorious);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79E2",226);
  build_kanji.lr(460,80)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.orders);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79E3",227);
  build_kanji.lr(520,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.tip);
  tsu_render;
endtsuglyph;

% shou/hakari "weigh_scale"
begintsuglyph("uni79E4",228);
  kanji.grnine.weigh_scale;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79E5",229);
  build_kanji.lr(460,50)
    (kanji.leftrad.two_branch_tree)
    (kanji.greight.divination);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79E7",231);
  build_kanji.lr(460,50)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.centre);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79E8",232);
  build_kanji.lr(460,60)
    (kanji.leftrad.two_branch_tree)
    (kanji.rare.notwithstanding);
  tsu_render;
endtsuglyph;

% chitsu/chichi "regularity"
begintsuglyph("uni79E9",233);
  kanji.greight.regularity;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79EA",234);
  build_kanji.lr(420,50)
    (kanji.leftrad.two_branch_tree)
    (kanji.rare.cruithne);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79EE",238);
  build_kanji.lr(470,50)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.pedestal);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79EF",239);
  build_kanji.lr(460,20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grnine.only);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79F1",241);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.same);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79F2",242);
  build_kanji.lr(460,30)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.temple);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79F3",243);
  build_kanji.lr(460,20)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 0.95 shifted (0,-20))(kanji.grfive.tongue));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79F4",244);
  build_kanji.lr(460,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.join);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79F5",245);
  build_kanji.lr(440,-10)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfive.cause);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79F7",247);
  build_kanji.lr(460,30)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 0.95 shifted (0,-30))(kanji.grsix.climax));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79F8",248);
  build_kanji.lr(460,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.greight.good_luck);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni79F9",249);
  build_kanji.lr(420,20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfive.responsibility);
  tsu_render;
endtsuglyph;

% i/utsu "shift"
begintsuglyph("uni79FB",251);
  kanji.grfive.shift;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
