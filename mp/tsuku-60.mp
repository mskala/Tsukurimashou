%
% Unicode page 60 (Kanji) for Tsukurimashou
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

% AUTODEPS
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.think =
  push_pbox_toexpand("kanji.grtwo.think");
  build_kanji.level(build_kanji.tb(390,120)
    (kanji.grone.paddy)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.breath =
  push_pbox_toexpand("kanji.grthree.breath");
  build_kanji.level(build_kanji.tb(320,40)
    (build_kanji.sscale(xscaled 1.1)(kanji.grtwo.self))
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.grthree.concept =
  push_pbox_toexpand("kanji.grthree.concept");
  build_kanji.level(build_kanji.tb(300,20)
    (kanji.grthree.correlation)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.grthree.evil =
  push_pbox_toexpand("kanji.grthree.evil");
  build_kanji.level(build_kanji.tb(280,20)
    (kanji.greight.prefix_sub)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.grthree.hurry =
  push_pbox_toexpand("kanji.grthree.hurry");
  build_kanji.level(build_kanji.tb(390,40)
    (build_kanji.sscale(xscaled 0.9 shifted (40,0))
       (build_kanji.attach_fishhook(0.6)
          (kanji.radical.pigs_head)))
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.gender =
  push_pbox_toexpand("kanji.grfive.gender");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grone.life));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.be_offended =
  push_pbox_toexpand("kanji.greight.be_offended");
  build_kanji.level(build_kanji.tb(390,40)
    (kanji.greight.guy)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.greight.desire =
  push_pbox_toexpand("kanji.greight.desire");
  build_kanji.level(build_kanji.tb(420,30)
    (kanji.grnine.again)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.greight.neglect =
  push_pbox_toexpand("kanji.greight.neglect");
  build_kanji.level(build_kanji.tb(380,50)
    (build_kanji.sscale(xscaled 1.1)(kanji.grtwo.pedestal))
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.greight.suspicious =
  push_pbox_toexpand("kanji.greight.suspicious");
  build_kanji.level(build_kanji.lr(320,40)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.88)(build_kanji.tb(380,90)
       (kanji.greight.otoh)
       (kanji.grone.earth))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extra
begintsuglyph("uni6008",8);
  build_kanji.level(build_kanji.lr(320,-40)
    (kanji.leftrad.heart)
    (kanji.grthree.world));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni600D",13);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (kanji.rare.notwithstanding));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni600E",14);
  build_kanji.level(build_kanji.tb(420,50)
    (kanji.rare.notwithstanding)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni600F",15);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (kanji.grthree.centre));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6010",16);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (kanji.grfive.phrase));
  tsu_render;
endtsuglyph;

% do/ika "be offended"
begintsuglyph("uni6012",18);
  kanji.greight.be_offended;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6013",19);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (kanji.greight.guy));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6014",20);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grone.correct));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6015",21);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grone.white));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6017",23);
  build_kanji.level(build_kanji.lr(320,60)
    (kanji.leftrad.heart)
    (kanji.greight.divination));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6018",24);
  build_kanji.level(build_kanji.tb(420,50)
    (kanji.grtwo.old)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6019",25);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (kanji.grtwo.old));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni601A",26);
  build_kanji.level(build_kanji.lr(320,40)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.93)(kanji.greight.furthermore)));
  tsu_render;
endtsuglyph;

% shi/omo "think"
begintsuglyph("uni601D",29);
  kanji.grtwo.think;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni601E",30);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (kanji.grthree.reason));
  tsu_render;
endtsuglyph;

% kai/okota/nama "neglect"
begintsuglyph("uni6020",32);
  kanji.greight.neglect;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6021",33);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (kanji.grtwo.pedestal));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6022",34);
  build_kanji.level(build_kanji.tb(360,80)
    (kanji.grfour.disappear)
    (kanji.grtwo.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6023",35);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.disappear));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6024",36);
  build_kanji.level(build_kanji.tb(420,70)
    (kanji.grfour.attach)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% kyuu/iso "hurry"
begintsuglyph("uni6025",37);
  kanji.grthree.hurry;
  tsu_render;
endtsuglyph;

% sei/saga "gender"
begintsuglyph("uni6027",39);
  kanji.grfive.gender;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6029",41);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.greight.nun));
  tsu_render;
endtsuglyph;

% kai/aya "suspicious"
begintsuglyph("uni602A",42);
  kanji.greight.suspicious;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni602C",44);
  build_kanji.level(build_kanji.lr(320,-40)
    (kanji.leftrad.heart)
    (kanji.grone.four));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni602D",45);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.inevitable));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni602F",47);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.94)(kanji.grthree.go_away)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6031",49);
  build_kanji.level(build_kanji.tb(420,50)
    (kanji.radical.crossed_must_not)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6033",51);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.big_brother));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6039",57);
  build_kanji.level(build_kanji.tb(420,30)
    (kanji.grthree.other)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni603D",61);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart)
    (kanji.grfour.not_yet));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni603E",62);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart)
    (kanji.grnine.only));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6040",64);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1) of oldp);
     replace_strokeq(0)(subpath (0,1) of oldq))
    (build_kanji.sscale(yscaled 0.92 shifted (0,-20))(kanji.grtwo.many)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6043",67);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (kanji.grtwo.temple));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6045",69);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (kanji.grfour.old_man));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6047",71);
  build_kanji.level(build_kanji.lr(320,-50)
    (kanji.leftrad.heart)
    (kanji.grnine.deliverance));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6049",73);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (kanji.greight.glutamate));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni604A",74);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.tricluster(0.85)
       (kanji.grone.power)
       (kanji.grone.power)
       (kanji.grone.power)));
  tsu_render;
endtsuglyph;

% koi/ren "love" ("take" side of "give and take")
begintsuglyph("uni604B",75);
  kanji.greight.desire;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni604E",78);
  build_kanji.level(build_kanji.lr(350,-40)
    (kanji.leftrad.heart)
    (tsu_xform(identity scaled 0.9)(kanji.grsix.climax)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni604F",79);
  build_kanji.level(build_kanji.tb(420,50)
    (kanji.grfour.fancy)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6053",83);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.west));
  tsu_render;
endtsuglyph;

% soku/iki "breath"
begintsuglyph("uni606F",111);
  kanji.grthree.breath;
  tsu_render;
endtsuglyph;

% aku/waru "evil"
begintsuglyph("uni60AA",170);
  kanji.grthree.evil;
  tsu_render;
endtsuglyph;

% sou/omo "concept"
begintsuglyph("uni60F3",243);
  kanji.grthree.concept;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
