%
% Unicode page 7A (Kanji) for Tsukurimashou
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
input bottomrad.mp;
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

vardef kanji.grone.sky =
  push_pbox_toexpand("kanji.grone.sky");
  build_kanji.level(build_kanji.tb(500,70)
    (kanji.toprad.cave)
    (kanji.grtwo.craft));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.child =
  push_pbox_toexpand("kanji.grthree.child");
  build_kanji.level(build_kanji.tb(480,-30)
    (kanji.toprad.stand_up)
    (kanji.grtwo.neighbourhood ));
  expand_pbox;
enddef;

vardef kanji.grthree.research =
  push_pbox_toexpand("kanji.grthree.research");
  build_kanji.level(build_kanji.tb(500,70)
    (kanji.toprad.cave)
    (kanji.grone.nine));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.contest =
  push_pbox_toexpand("kanji.grfour.contest");
  build_kanji.lr(480,-50)
    (kanji.leftrad.contend)
    (kanji.rare.contend);
  expand_pbox;
enddef;

vardef kanji.grfour.load =
  push_pbox_toexpand("kanji.grfour.load");
  build_kanji.lr(420,-20*mincho)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfive.blame);
  expand_pbox;
enddef;

vardef kanji.grfour.seed =
  push_pbox_toexpand("kanji.grfour.seed");
  build_kanji.lr(360,0)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 0.91)(kanji.grthree.heap_big));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.tax =
  push_pbox_toexpand("kanji.grfive.tax");
  build_kanji.lr(420,10)
    (kanji.leftrad.two_branch_tree)
    (kanji.rare.cash);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.contend =
  push_pbox_toexpand("kanji.leftrad.contend");
  kanji.rare.contend;
  begingroup
    save myxf,myp;
    transform myxf;
    path myp;
    myp=get_strokep(0);
    (0,0) transformed myxf=llcorner myp;
    (1,0) transformed myxf=lrcorner myp;
    (0,1) transformed myxf=ulcorner myp;
    replace_strokep(0)(((0.05,1)--(0.07,0.07)) transformed myxf);
    replace_strokeq(0)((1.7,1.7)--(1.5,1.5));
    push_stroke(((-0.46,0)..tension 1.2..(0.07,0.07)..(1,0.27))
        transformed myxf,
      (1.7,1.7)--(1.5,1.5)--(1,1));
    set_bosize(0)(get_bosize(-1));
  endgroup;
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.rare.contend =
  push_pbox_toexpand("kanji.rare.contend");
  build_kanji.tb(480,-60)
    (kanji.grone.stand_up)
    (kanji.grtwo.big_brother);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extra
begintsuglyph("uni7A00",0);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.rarity);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A02",2);
  build_kanji.lr(450,60)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.good);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A03",3);
  tsu_render;
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.tb(580,0)
       (kanji.toprad.paw)
       (kanji.grone.child)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A07",7);
  build_kanji.level(build_kanji.lr(380,-20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grsix.bothered));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A09",9);
  build_kanji.lr(420,20)
    (kanji.leftrad.two_branch_tree)
    (kanji.greight.night_watch);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A0A",10);
  build_kanji.lr(400,20)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,20))(kanji.grtwo.little_brother));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A0C",12);
  build_kanji.lr(420,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfive.surplus);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A0D",13);
  build_kanji.lr(420,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.greight.resemblance);
  tsu_render;
endtsuglyph;

% zei "tax"
begintsuglyph("uni7A0E",14);
  kanji.grfive.tax;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A10",16);
  build_kanji.lr(360,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.rare.be_methodical);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A11",17);
  build_kanji.lr(400,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.rare.clod_of_earth);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A12",18);
  build_kanji.lr(380,-20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.hard);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A13",19);
  build_kanji.lr(420,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.once_upon_a_time);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A14",20);
  build_kanji.lr(420,20)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,-20))(kanji.grfour.care));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A15",21);
  build_kanji.lr(400,10)
    (kanji.leftrad.two_branch_tree)
    (kanji.greight.undergo);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A18",24);
  build_kanji.lr(420,20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grnine.that);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A19",25);
  build_kanji.lr(380,00)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.straight);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A1A",26);
  build_kanji.lr(400,0)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,-20))(kanji.radical.old_bird));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A1E",30);
  build_kanji.lr(420,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.fruit);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A20",32);
  build_kanji.lr(410,20)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.circuit);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A21",33);
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.graduate));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A24",36);
  build_kanji.level(build_kanji.lr(420,40)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.capital));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A29",41);
  build_kanji.lr(420,30)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfour.stomach);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A2B",43);
  build_kanji.lr(420,20)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 1.06)(kanji.rare.roll_of_cloth));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A2D",45);
  build_kanji.lr(420,10)
    (kanji.leftrad.two_branch_tree)
    (kanji.greight.everybody);
  tsu_render;
endtsuglyph;

% shu/tane "seed"
begintsuglyph("uni7A2E",46);
  kanji.grfour.seed;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A33",51);
  build_kanji.lr(390,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.hurry);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A3C",60);
  build_kanji.lr(400,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.house);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A3F",63);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grtwo.high);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A41",65);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.tb(600,30)
       (kanji.toprad.grass)
       (kanji.grone.ear));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A43",67);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grfive.face);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A44",68);
  build_kanji.lr(360,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.festival);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A45",69);
  build_kanji.lr(380,0)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 1.07)(kanji.grfour.peace));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A4A",74);
  build_kanji.lr(380,0)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 1.07)(kanji.greight.already));
  tsu_render;
endtsuglyph;

% seki/tsu "load"
begintsuglyph("uni7A4D",77);
  kanji.grfour.load;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A55",85);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(shifted (0,-20))(kanji.grthree.collect));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A56",86);
  build_kanji.lr(370,30)
    (kanji.leftrad.two_branch_tree)
    (kanji.greight.how_much);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A59",89);
  build_kanji.lr(410,30)
    (kanji.leftrad.two_branch_tree)
    (kanji.rare.eight_three_dee_zero);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A5A",90);
  build_kanji.level(build_kanji.lr(380,-10)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 0.96 shifted (0,-20))(kanji.grnine.boast)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A5C",92);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.child);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A5D",93);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 0.96 shifted (0,-20))(kanji.grfour.utmost));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni7A60",96);
  build_kanji.lr(420,0)
    (kanji.leftrad.two_branch_tree)
    (kanji.grthree.farming);
  tsu_render;
endtsuglyph;

% kyuu/kiwa "research"
begintsuglyph("uni7A76",118);
  kanji.grthree.research;
  tsu_render;
endtsuglyph;

% kara/sora "sky"
begintsuglyph("uni7A7A",122);
  kanji.grone.sky;
  tsu_render;
endtsuglyph;

% ta "stand up"
begintsuglyph("uni7ACB",203);
  kanji.grone.stand_up;
  tsu_render;
endtsuglyph;

% extra: "contend"
begintsuglyph("uni7ADE",222);
  kanji.rare.contend;
  tsu_render;
endtsuglyph;

% kyou/owa "finally"
begintsuglyph("uni7ADF",223);
  kanji.rare.finally;
  tsu_render;
endtsuglyph;

% shou/aki "chapter"
begintsuglyph("uni7AE0",224);
  kanji.grthree.chapter;
  tsu_render;
endtsuglyph;

% dou/warabe "child"
begintsuglyph("uni7AE5",229);
  kanji.grthree.child;
  tsu_render;
endtsuglyph;

% chiku/take "bamboo"
begintsuglyph("uni7AF9",249);
  kanji.grone.bamboo;
  tsu_render;
endtsuglyph;

% kyou/kiso "contest"
begintsuglyph("uni7AF6",246);
  kanji.grfour.contest;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
