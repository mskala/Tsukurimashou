%
% Unicode page 60 (Kanji) for Tsukurimashou
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

vardef kanji.grthree.sad =
  push_pbox_toexpand("kanji.grthree.sad");
  build_kanji.level(build_kanji.tb(300,20)
    (kanji.grfive.mistake)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.feelings =
  push_pbox_toexpand("kanji.grfive.feelings");
  build_kanji.level(build_kanji.lr(330,-30)
    (kanji.leftrad.heart)
    (kanji.grone.blue));
  expand_pbox;
enddef;

vardef kanji.grfive.gender =
  push_pbox_toexpand("kanji.grfive.gender");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grone.life));
  expand_pbox;
enddef;

vardef kanji.grfive.gratitude =
  push_pbox_toexpand("kanji.grfive.gratitude");
  build_kanji.level(build_kanji.tb(340,0)
    (build_kanji.sscale(xyscaled (0.82,1))(kanji.grfive.cause))
    (kanji.bottomrad.heart));
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

vardef kanji.greight.dreadful =
  push_pbox_toexpand("kanji.greight.dreadful");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.96)(kanji.grfive.cloth)));
  expand_pbox;
enddef;

vardef kanji.greight.enlightenment =
  push_pbox_toexpand("kanji.greight.enlightenment");
  build_kanji.level(build_kanji.lr(360,0)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.4) of oldp);
     replace_strokeq(0)(subpath (0,1.4) of oldq))
    (kanji.grnine.my));
  expand_pbox;
enddef;

vardef kanji.greight.fear =
  push_pbox_toexpand("kanji.greight.fear");
  build_kanji.level(build_kanji.lr(330,20)
    (kanji.leftrad.heart)
    (kanji.grthree.ingredient));
  expand_pbox;
enddef;

vardef kanji.greight.grudge =
  push_pbox_toexpand("kanji.greight.grudge");
  build_kanji.level(build_kanji.lr(340,50)
    (kanji.leftrad.heart)
    (kanji.radical.northeast));
  expand_pbox;
enddef;

vardef kanji.greight.neglect =
  push_pbox_toexpand("kanji.greight.neglect");
  build_kanji.level(build_kanji.tb(380,50)
    (build_kanji.sscale(xscaled 1.1)(kanji.grtwo.pedestal))
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.greight.rapture =
  push_pbox_toexpand("kanji.greight.rapture");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.rare.cash));
  expand_pbox;
enddef;

vardef kanji.greight.regret =
  push_pbox_toexpand("kanji.greight.regret");
  build_kanji.level(build_kanji.lr(350,50)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.2) of oldp);
     replace_strokeq(0)(subpath (0,1.2) of oldq))
    (kanji.grthree.once_upon_a_time));
  expand_pbox;
enddef;

vardef kanji.greight.repent =
  push_pbox_toexpand("kanji.greight.repent");
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1) of oldp);
     replace_strokeq(0)(subpath (0,1) of oldq))
    (build_kanji.sscale(shifted (0,-30))(kanji.grtwo.every)));
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

vardef kanji.greight.wretched =
  push_pbox_toexpand("kanji.greight.wretched");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.5) of oldp);
     replace_strokeq(0)(subpath (0,1.5) of oldq))
    (build_kanji.sscale(scaled 0.96)(kanji.grfour.participate)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.consider =
  push_pbox_toexpand("kanji.grnine.consider");
  build_kanji.level(build_kanji.lr(320,-35)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.93 shifted (0,-20))
       (kanji.radical.old_bird)));
  expand_pbox;
enddef;

vardef kanji.grnine.have_mercy =
  push_pbox_toexpand("kanji.grnine.have_mercy");
  build_kanji.level(build_kanji.lr(320,-10)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,-10))(kanji.grthree.blood)));
  expand_pbox;
enddef;

vardef kanji.grnine.just_as =
  push_pbox_toexpand("kanji.grnine.just_as");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.join));
  expand_pbox;
enddef;

vardef kanji.grnine.realize =
  push_pbox_toexpand("kanji.grnine.realize");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.94)(kanji.grtwo.star)));
  expand_pbox;
enddef;

vardef kanji.grnine.serving_our_elders =
  push_pbox_toexpand("kanji.grnine.serving_our_elders");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,30))(kanji.grtwo.little_brother)));
  expand_pbox;
enddef;

vardef kanji.grnine.senile =
  push_pbox_toexpand("kanji.grnine.senile");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grnine.suddenly));
  expand_pbox;
enddef;

vardef kanji.grnine.sincerity =
  push_pbox_toexpand("kanji.grnine.sincerity");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.greight.undergo));
  expand_pbox;
enddef;

vardef kanji.grnine.wise =
  push_pbox_toexpand("kanji.grnine.wise");
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.orders));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extra
begintsuglyph("uni6000",0);
  build_kanji.level(build_kanji.lr(360,20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.97 shifted (0,20))(kanji.grfour.non)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6004",4);
  build_kanji.level(build_kanji.lr(340,-50)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.88 shifted (0,10))(kanji.grthree.ward)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6008",8);
  build_kanji.level(build_kanji.lr(320,-60)
    (kanji.leftrad.heart)
    (kanji.grthree.world));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6009",9);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.wrap));
  tsu_render;
endtsuglyph;

% chou/kanashimu "grieve"
begintsuglyph("uni600A",10);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.greight.call));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni600B",11);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 1.03 shifted (0,20))(kanji.grfour.people)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni600C",12);
  build_kanji.level(build_kanji.lr(340,30)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.96 shifted (0,30))(kanji.rare.glorious)));
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

% extra
begintsuglyph("uni6011",17);
  build_kanji.level(build_kanji.lr(350,-20*mincho)
    (kanji.leftrad.heart)
    (kanji.grtwo.half));
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

% fu/kowai "dreadful" greight
begintsuglyph("uni6016",22);
  kanji.greight.dreadful;
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

% datsu/itamu "be dejected"
begintsuglyph("uni601B",27);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (kanji.greight.daybreak));
  tsu_render;
endtsuglyph;

% rei/awaremu "wise" grnine
begintsuglyph("uni601C",28);
  kanji.grnine.wise;
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

% tei/modaeru "no meaning specified"
begintsuglyph("uni601F",31);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart)
    (kanji.rare.cruithne));
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

% hou "be excited"
begintsuglyph("uni6026",38);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,-20))(kanji.grthree.level)));
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

% futsu "wrathful"
begintsuglyph("uni602B",43);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.rare.dollar));
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
begintsuglyph("uni6032",50);
  build_kanji.level(build_kanji.lr(340,-30)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.98)(kanji.greight.third)));
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
begintsuglyph("uni6036",54);
  build_kanji.level(build_kanji.lr(320,-10)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.98)(kanji.grthree.pelt)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6039",57);
  build_kanji.level(build_kanji.tb(420,30)
    (kanji.grthree.other)
    (kanji.bottomrad.heart));
  tsu_render;
endtsuglyph;

% koraeru "endure"
begintsuglyph("uni603A",58);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.7) of oldp);
     replace_strokeq(0)(subpath (0,1.7) of oldq))
    (build_kanji.sscale(yscaled 1.02)(kanji.grfive.long)));
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
begintsuglyph("uni6044",68);
  build_kanji.level(build_kanji.lr(350,0)
    (kanji.leftrad.heart)
    (kanji.greight.good_luck));
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

% bou/musaborioshimu "no meaning given"
begintsuglyph("uni6048",72);
  build_kanji.level(build_kanji.lr(360,-40)
    (kanji.leftrad.heart)
    (kanji.grnine.moo));
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

% chou/usui "frivolous"
begintsuglyph("uni604C",76);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.portent));
  tsu_render;
endtsuglyph;

% kou/tobokeru "dotage"
begintsuglyph("uni604D",77);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.shine));
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

% kyou/satoi "cheerful"
begintsuglyph("uni6054",84);
  build_kanji.level(build_kanji.lr(320,-10)
    (kanji.leftrad.heart)
    (kanji.grtwo.mix));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6058",88);
  build_kanji.level(build_kanji.lr(360,-10)
    (kanji.leftrad.heart)
    (kanji.grone.vacation));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni605B",91);
  build_kanji.level(build_kanji.lr(360,-40)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.96)(kanji.grtwo.occurrences)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni605C",92);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (kanji.grthree.formula));
  tsu_render;
endtsuglyph;

% kai/ayashii "apparition"
begintsuglyph("uni6060",96);
  build_kanji.level(build_kanji.lr(320,20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.94 shifted (0,-20))(kanji.grfive.exist)));
  tsu_render;
endtsuglyph;

% kai/hiroi "wide"
begintsuglyph("uni6062",98);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted(0,20))(kanji.grsix.ash)));
  tsu_render;
endtsuglyph;

% jyutsu/megumu "have mercy"
begintsuglyph("uni6064",100);
  kanji.grnine.have_mercy;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6066",102);
  build_kanji.level(build_kanji.lr(340,-20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.97)(kanji.grthree.facing)));
  tsu_render;
endtsuglyph;

% kon/uramu "grudge"
begintsuglyph("uni6068",104);
  kanji.greight.grudge;
  tsu_render;
endtsuglyph;

% on/megumi "gratitude"
begintsuglyph("uni6069",105);
  kanji.grfive.gratitude;
  tsu_render;
endtsuglyph;

% kaku/tsutsushimu "carefulness"
begintsuglyph("uni606A",106);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (tsu_xform(identity yscaled 0.97)(kanji.grfour.every)));
  tsu_render;
endtsuglyph;

% dou/itamu "fearful"
begintsuglyph("uni606B",107);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.97)(kanji.grtwo.same)));
  tsu_render;
endtsuglyph;

% ten/yasuraku "nonchalance"
begintsuglyph("uni606C",108);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (tsu_xform(identity yscaled 0.94)(kanji.grfive.tongue)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni606E",110);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,-20))(kanji.grthree.complete)));
  tsu_render;
endtsuglyph;

% soku/iki "breath"
begintsuglyph("uni606F",111);
  kanji.grthree.breath;
  tsu_render;
endtsuglyph;

% kou/atakamo "just as"
begintsuglyph("uni6070",112);
  kanji.grnine.just_as;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6072",114);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.7) of oldp);
     replace_strokeq(0)(subpath (0,1.7) of oldq))
    (build_kanji.sscale(shifted (0,40))(kanji.rare.merger)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6080",128);
  build_kanji.level(build_kanji.lr(320,-10)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,20))(kanji.rare.walled_road)));
  tsu_render;
endtsuglyph;

% kon/agokoro "sincerity"
begintsuglyph("uni6083",131);
  build_kanji.level(build_kanji.lr(340,-20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.92)(kanji.grsix.bothered)));
  tsu_render;
endtsuglyph;

% shou/ureeru "anxiety"
begintsuglyph("uni6084",132);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart)
    (kanji.greight.resemblance));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6087",135);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (kanji.grfive.surplus));
  tsu_render;
endtsuglyph;

% kai/totonoeru "no meaning specified"
begintsuglyph("uni6088",136);
  build_kanji.level(build_kanji.lr(320,-20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,30))(kanji.greight.precept)));
  tsu_render;
endtsuglyph;

% tei/tomo "serving our elders"
begintsuglyph("uni608C",140);
  kanji.grnine.serving_our_elders;
  tsu_render;
endtsuglyph;

% ken/tatoeru "no meaning specified"
begintsuglyph("uni6093",147);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.96)(kanji.grone.see)));
  tsu_render;
endtsuglyph;

% kai/kuiru "repent"
begintsuglyph("uni6094",148);
  kanji.greight.repent;
  tsu_render;
endtsuglyph;

% ki/omou "lament"
begintsuglyph("uni6095",149);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.rarity));
  tsu_render;
endtsuglyph;

% ban "be perplexed"
begintsuglyph("uni6097",151);
  build_kanji.level(build_kanji.lr(320,30)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,0.8) of oldp shifted (40,40));
     replace_strokeq(0)(subpath (0,1) of oldq))
    (build_kanji.sscale(yscaled 0.97)(kanji.greight.dismiss)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni6099",153);
  build_kanji.level(build_kanji.lr(380,10)
    (kanji.leftrad.heart)
    (kanji.grnine.undergo));
  tsu_render;
endtsuglyph;

% shou/osoreru "fear"
begintsuglyph("uni609A",154);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.bundle));
  tsu_render;
endtsuglyph;

% kai/tawamureru "pity"
begintsuglyph("uni609D",157);
  build_kanji.level(build_kanji.lr(340,20)
    (kanji.leftrad.heart)
    (kanji.grtwo.neighbourhood));
  tsu_render;
endtsuglyph;

% go/satoru "enlightenment"
begintsuglyph("uni609F",159);
  kanji.greight.enlightenment;
  tsu_render;
endtsuglyph;

% ryou/kanashimu "regret" (no meaning in database, guess from sound)
begintsuglyph("uni60A2",162);
  build_kanji.level(build_kanji.lr(360,50)
    (kanji.leftrad.heart)
    (kanji.grfour.good));
  tsu_render;
endtsuglyph;

% etsu/yorokobu "rapture"
begintsuglyph("uni60A6",166);
  kanji.greight.rapture;
  tsu_render;
endtsuglyph;

% ri "clever"
begintsuglyph("uni60A7",167);
  build_kanji.level(build_kanji.lr(320,-30)
    (kanji.leftrad.heart;
     replace_strokep(0)(oldp shifted (20,-30)))
    (kanji.grfour.advantage));
  tsu_render;
endtsuglyph;

% aku/waru "evil"
begintsuglyph("uni60AA",170);
  kanji.grthree.evil;
  tsu_render;
endtsuglyph;

% sou/tanoshimu "enjoy"
begintsuglyph("uni60B0",176);
  build_kanji.level(build_kanji.lr(360,-20)
    (kanji.leftrad.heart)
    (kanji.grsix.religion));
  tsu_render;
endtsuglyph;

% hi/inayamu "to be desirous of speaking"
begintsuglyph("uni60B1",177);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(scaled 0.96)(kanji.grfive.mistake)));
  tsu_render;
endtsuglyph;

% hi/kana "sad"
begintsuglyph("uni60B2",178);
  kanji.grthree.sad;
  tsu_render;
endtsuglyph;

% sui/sagare "penis"
begintsuglyph("uni60B4",180);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.graduate));
  tsu_render;
endtsuglyph;

% chou/itamu "be sad"
begintsuglyph("uni60B5",181);
  build_kanji.level(build_kanji.lr(340,30)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.98)(kanji.grtwo.long)));
  tsu_render;
endtsuglyph;

% ki "shudder"
begintsuglyph("uni60B8",184);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.season));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni60BA",186);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.97 shifted (0,20))
       (kanji.grfour.bureaucracy)));
  tsu_render;
endtsuglyph;

% kei/motoru "vexation"
begintsuglyph("uni60BB",187);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,0.9) of oldp);
     replace_strokeq(0)(subpath (0,0.9) of oldq))
    (kanji.grthree.blessing));
  tsu_render;
endtsuglyph;

% kou "guileless"
begintsuglyph("uni60BE",190);
  build_kanji.level(build_kanji.lr(330,10)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.8) of oldp);
     replace_strokeq(0)(subpath (0,1.8) of oldq))
    (build_kanji.sscale(yscaled 1.03 shifted (0,-40))(kanji.grone.sky)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni60C0",192);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart;
     replace_strokep(0)(subpath (0,1.6) of oldp);
     replace_strokeq(0)(subpath (0,1.6) of oldq))
    (kanji.rare.be_methodical));
  tsu_render;
endtsuglyph;

% jou/nasa "feelings"
begintsuglyph("uni60C5",197);
  kanji.grfive.feelings;
  tsu_render;
endtsuglyph;

% chuu/uramu "be disappointed"
begintsuglyph("uni60C6",198);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfour.circuit));
  tsu_render;
endtsuglyph;

% shun/atsui "sincerity"
begintsuglyph("uni60C7",199);
  kanji.grnine.sincerity;
  tsu_render;
endtsuglyph;

% ka/isamashii "resolute"
begintsuglyph("uni60C8",200);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (kanji.grfour.fruit));
  tsu_render;
endtsuglyph;

% ryou/kanashimu "startle"
begintsuglyph("uni60CA",202);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.capital));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni60CD",205);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,30*(1-mincho)))(kanji.grone.gold)));
  tsu_render;
endtsuglyph;

% ran/musaboru "avaricious"
begintsuglyph("uni60CF",207);
  build_kanji.level(build_kanji.lr(340,-20)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 1.03)(kanji.grone.grove)));
  tsu_render;
endtsuglyph;

% tan/ureeru "cheerful"
begintsuglyph("uni60D4",212);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.96)(kanji.greight.inflammation)));
  tsu_render;
endtsuglyph;

% teki/tsutsushimu "be cautious"
begintsuglyph("uni60D5",213);
  build_kanji.level(build_kanji.lr(320,40)
    (kanji.leftrad.heart)
    (build_kanji.sscale(yscaled 0.94 shifted (0,-30))(kanji.grfive.easy)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni60D7",215);
  build_kanji.level(build_kanji.lr(310,20-40*mincho)
    (kanji.leftrad.heart)
    (kanji.grfour.care));
  tsu_render;
endtsuglyph;

% hotsu/bokeru "senile"
begintsuglyph("uni60DA",218);
  kanji.grnine.senile;
  tsu_render;
endtsuglyph;

% seki/oshii "regret"
begintsuglyph("uni60DC",220);
  kanji.greight.regret;
  tsu_render;
endtsuglyph;

% i/omonmeru "consider"
begintsuglyph("uni60DF",223);
  kanji.grnine.consider;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni60E6",230);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grtwo.shop));
  tsu_render;
endtsuglyph;

% ku/osoreru "fear"
begintsuglyph("uni60E7",231);
  kanji.greight.fear;
  tsu_render;
endtsuglyph;

% sen/mijime "wretched"
begintsuglyph("uni60E8",232);
  kanji.greight.wretched;
  tsu_render;
endtsuglyph;

% un/atsui "devise"
begintsuglyph("uni60F2",242);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (build_kanji.sscale(shifted (0,10))(kanji.grfour.army)));
  tsu_render;
endtsuglyph;

% sou/omo "concept"
begintsuglyph("uni60F3",243);
  kanji.grthree.concept;
  tsu_render;
endtsuglyph;

% kou/osoreru "fear"
begintsuglyph("uni60F6",246);
  build_kanji.level(build_kanji.lr(320,10)
    (kanji.leftrad.heart)
    (kanji.grsix.emperor));
  tsu_render;
endtsuglyph;

% sei/satoru "realize"
begintsuglyph("uni60FA",250);
  kanji.grnine.realize;
  tsu_render;
endtsuglyph;

% soku/itamu "be sad"
begintsuglyph("uni60FB",251);
  build_kanji.level(build_kanji.lr(320,0)
    (kanji.leftrad.heart)
    (kanji.grfive.conform));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni60FF",255);
  build_kanji.level(build_kanji.lr(320,50)
    (kanji.leftrad.heart)
    (build_kanji.sscale(xyscaled (0.94,0.92))(kanji.greight.righteousness)));
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
