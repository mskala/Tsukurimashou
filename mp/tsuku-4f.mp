%
% Unicode page 4F (Kanji) for Tsukurimashou
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

vardef kanji.grtwo.make =
  push_pbox_toexpand("kanji.grtwo.make");
  build_kanji.lr(300,60)
    (kanji.leftrad.person)
    (kanji.rare.notwithstanding);
  expand_pbox;
enddef;

vardef kanji.grtwo.substance =
  push_pbox_toexpand("kanji.grtwo.substance");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.book);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.duty_officer =
  push_pbox_toexpand("kanji.grthree.duty_officer");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (tsu_xform(identity yscaled 0.95)(kanji.grfour.lineage));
  expand_pbox;
enddef;

vardef kanji.grthree.dwell =
  push_pbox_toexpand("kanji.grthree.dwell");
  build_kanji.lr(300,10)
    (kanji.leftrad.person)
    (kanji.grthree.master);
  expand_pbox;
enddef;

vardef kanji.grthree.use =
  push_pbox_toexpand("kanji.grthree.use");
  build_kanji.lr(300,10)
    (kanji.leftrad.person)
    (kanji.greight.officer);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.believe =
  push_pbox_toexpand("kanji.grfour.believe");
  build_kanji.lr(300,0)
    (kanji.leftrad.person)
    (kanji.grtwo.word);
  expand_pbox;
enddef;

vardef kanji.grfour.convenience =
  push_pbox_toexpand("kanji.grfour.convenience");
  build_kanji.lr(300,10)
    (kanji.leftrad.person)
    (kanji.greight.night_watch);
  expand_pbox;
enddef;

vardef kanji.grfour.example =
  push_pbox_toexpand("kanji.grfour.example");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grthree.column);
  expand_pbox;
enddef;

vardef kanji.grfour.low =
  push_pbox_toexpand("kanji.grfour.low");
  build_kanji.lr(300,50)
    (kanji.leftrad.person)
    (kanji.rare.cruithne);
  expand_pbox;
enddef;

vardef kanji.grfour.rank =
  push_pbox_toexpand("kanji.grfour.rank");
  build_kanji.lr(300,10)
    (kanji.leftrad.person)
    (kanji.grone.stand_up);
  expand_pbox;
enddef;

vardef kanji.grfour.tradition =
  push_pbox_toexpand("kanji.grfour.tradition");
  build_kanji.lr(300,10)
    (kanji.leftrad.person)
    (kanji.grnine.declaim);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.imitate =
  push_pbox_toexpand("kanji.grfive.imitate");
  build_kanji.lr(300,0)
    (kanji.leftrad.person)
    (kanji.grfour.as;
     replace_strokep(-4)(subpath (0.16,infinity) of oldp));
  expand_pbox;
enddef;

vardef kanji.grfive.price =
  push_pbox_toexpand("kanji.grfive.price");
  build_kanji.lr(300,0)
    (kanji.leftrad.person)
    (build_kanji.thickness(0.92)
      (push_stroke((110,760)--(890,760),(1.6,1.6)--(1.6,1.6));
       set_boserif(0,1,9);
       push_stroke((390,760)--(390,10),(1.5,1.5)--(1.4,1.4));
       push_stroke((610,760)--(610,10),(1.5,1.5)--(1.4,1.4));
       build_kanji.box((180,480),(820,10))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.haiku =
  push_pbox_toexpand("kanji.grsix.haiku");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grfive.mistake);
  expand_pbox;
enddef;

vardef kanji.grsix.offer =
  push_pbox_toexpand("kanji.grsix.offer");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grfour.together);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.accompany =
  push_pbox_toexpand("kanji.greight.accompany");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grtwo.half);
  expand_pbox;
enddef;

vardef kanji.greight.assistant =
  push_pbox_toexpand("kanji.greight.assistant");
  build_kanji.lr(300,40)
    (kanji.leftrad.person)
    (kanji.grone.left);
  expand_pbox;
enddef;

vardef kanji.greight.clever =
  push_pbox_toexpand("kanji.greight.clever");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grfour.advantage);
  expand_pbox;
enddef;

vardef kanji.greight.companion =
  push_pbox_toexpand("kanji.greight.companion");
  build_kanji.lr(300,40)
    (kanji.leftrad.person)
    (kanji.greight.spine);
  expand_pbox;
enddef;

vardef kanji.greight.dependency =
  push_pbox_toexpand("kanji.greight.dependency");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grfour.clothes);
  expand_pbox;
enddef;

vardef kanji.greight.earl =
  push_pbox_toexpand("kanji.greight.earl");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(shifted (0,20))(kanji.grone.white));
  expand_pbox;
enddef;

vardef kanji.greight.elongate =
  push_pbox_toexpand("kanji.greight.elongate");
  build_kanji.lr(300,40)
    (kanji.leftrad.person)
    (kanji.grthree.have_honour);
  expand_pbox;
enddef;

vardef kanji.greight.excellent =
  push_pbox_toexpand("kanji.greight.excellent");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grnine.square_jewel);
  expand_pbox;
enddef;

vardef kanji.greight.however =
  push_pbox_toexpand("kanji.greight.however");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.greight.daybreak);
  expand_pbox;
enddef;

vardef kanji.greight.inquiry =
  push_pbox_toexpand("kanji.greight.inquiry");
  build_kanji.lr(300,0)
    (kanji.leftrad.person)
    (kanji.grfour.director);
  expand_pbox;
enddef;

vardef kanji.greight.me_macho =
  push_pbox_toexpand("kanji.greight.me_macho");
  build_kanji.lr(270,40*(1-mincho))
    (kanji.leftrad.person)
    (kanji.grnine.suffocate);
  expand_pbox;
enddef;

vardef kanji.greight.samurai =
  push_pbox_toexpand("kanji.greight.samurai");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grtwo.temple);
  expand_pbox;
enddef;

vardef kanji.greight.scorn =
  push_pbox_toexpand("kanji.greight.scorn");
  build_kanji.lr(300,0)
    (kanji.leftrad.person)
    (kanji.grtwo.every);
  expand_pbox;
enddef;

vardef kanji.greight.skill =
  push_pbox_toexpand("kanji.greight.skill");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grfive.support);
  expand_pbox;
enddef;

vardef kanji.greight.unite =
  push_pbox_toexpand("kanji.greight.unite");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(shifted (0,30))(kanji.rare.merger));
  expand_pbox;
enddef;

vardef kanji.greight.urge =
  push_pbox_toexpand("kanji.greight.urge");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.foot);
  expand_pbox;
enddef;

vardef kanji.greight.worldly =
  push_pbox_toexpand("kanji.greight.worldly");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grtwo.valley);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.assistant =
  push_pbox_toexpand("kanji.grnine.assistant");
  build_kanji.lr(300,40)
    (kanji.leftrad.person)
    (kanji.grone.right);
  expand_pbox;
enddef;

vardef kanji.grnine.five =
  push_pbox_toexpand("kanji.grnine.five");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.five);
  expand_pbox;
enddef;

vardef kanji.grnine.italy =
  push_pbox_toexpand("kanji.grnine.italy");
  build_kanji.lr(300,0)
    (kanji.leftrad.person)
    (tsu_xform(identity shifted (0,-900) yscaled 1.17 shifted (0,900))
       (kanji.rare.director));
  expand_pbox;
enddef;

vardef kanji.grnine.nurse =
  push_pbox_toexpand("kanji.grnine.nurse");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grfour.addition);
  expand_pbox;
enddef;

vardef kanji.grnine.paddy =
  push_pbox_toexpand("kanji.grnine.paddy");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.paddy);
  expand_pbox;
enddef;

vardef kanji.grnine.straw_bags =
  push_pbox_toexpand("kanji.grnine.straw_bags");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grthree.surface);
  expand_pbox;
enddef;

vardef kanji.grnine.urge_to_eat =
  push_pbox_toexpand("kanji.grnine.urge_to_eat");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grthree.existence);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grten.all_together =
  push_pbox_toexpand("kanji.grten.all_together");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grthree.ingredient);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% i/kare "Italy"
begintsuglyph("uni4F0A",10);
  kanji.grnine.italy;
  tsu_render;
endtsuglyph;

% go/itsutsu "five"
begintsuglyph("uni4F0D",13);
  kanji.grnine.five;
  tsu_render;
endtsuglyph;

% gi/waza "skill"
begintsuglyph("uni4F0E",14);
  kanji.greight.skill;
  tsu_render;
endtsuglyph;

% fuku/fu "prostrate"
begintsuglyph("uni4F0F",15);
  kanji.greight.prostrate;
  tsu_render;
endtsuglyph;

% batsu/ki "strike"
begintsuglyph("uni4F10",16);
  kanji.greight.strike;
  tsu_render;
endtsuglyph;

% yasu "vacation"
begintsuglyph("uni4F11",17);
  kanji.grone.vacation;
  tsu_render;
endtsuglyph;

% kai/a "meet"
begintsuglyph("uni4F1A",26);
  kanji.grtwo.meet;
  tsu_render;
endtsuglyph;

% den/tsuta "tradition"
begintsuglyph("uni4F1D",29);
  kanji.grfour.tradition;
  tsu_render;
endtsuglyph;

% haku "earl"
begintsuglyph("uni4F2F",47);
  kanji.greight.earl;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4F31",49);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.tb(480,60)
       (kanji.grone.person)
       (kanji.grone.small));
  tsu_render;
endtsuglyph;

% han/tomona "accompany"
begintsuglyph("uni4F34",52);
  kanji.greight.accompany;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4F35",53);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(scaled 0.95)(kanji.grone.four));
  tsu_render;
endtsuglyph;

% shin/no "elongate"
begintsuglyph("uni4F38",56);
  kanji.greight.elongate;
  tsu_render;
endtsuglyph;

% shi/ukaga "inquiry"
begintsuglyph("uni4F3A",58);
  kanji.greight.inquiry;
  tsu_render;
endtsuglyph;

% ji/ni "imitate"
begintsuglyph("uni4F3C",60);
  kanji.grfive.imitate;
  tsu_render;
endtsuglyph;

% ka/togi "nurse"
begintsuglyph("uni4F3D",61);
  kanji.grnine.nurse;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4F3F",63);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(scaled 0.9)(kanji.grnine.only));
  tsu_render;
endtsuglyph;

% ten/tsukuda "cultivated paddy"
begintsuglyph("uni4F43",67);
  kanji.grnine.paddy;
  tsu_render;
endtsuglyph;

% tan/tada "however"
begintsuglyph("uni4F46",70);
  kanji.greight.however;
  tsu_render;
endtsuglyph;

% i/kurai "rank"
begintsuglyph("uni4F4D",77);
  kanji.grfour.rank;
  tsu_render;
endtsuglyph;

% tei/hiku "low" or "humble"
begintsuglyph("uni4F4E",78);
  kanji.grfour.low;
  tsu_render;
endtsuglyph;

% juu/su "dwell"
begintsuglyph("uni4F4F",79);
  kanji.grthree.dwell;
  tsu_render;
endtsuglyph;

% suke "assistant"
begintsuglyph("uni4F50",80);
  kanji.greight.assistant;
  tsu_render;
endtsuglyph;

% suke "assistant"
begintsuglyph("uni4F51",81);
  kanji.grnine.assistant;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4F52",82);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grthree.centre);
  tsu_render;
endtsuglyph;

% tai/karada "substance"
begintsuglyph("uni4F53",83);
  kanji.grtwo.substance;
  tsu_render;
endtsuglyph;

% ka/nani "what"
begintsuglyph("uni4F55",85);
  kanji.grtwo.what;
  tsu_render;
endtsuglyph;

% yo/ama "surplus" ("ama" as in "amari yoku nai")
begintsuglyph("uni4F59",89);
  kanji.grfive.surplus;
  tsu_render;
endtsuglyph;

% tsuku "make"
begintsuglyph("uni4F5C",92);
  kanji.grtwo.make;
  tsu_render;
endtsuglyph;

% extra "hesitate"
begintsuglyph("uni4F6A",106);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(scaled 0.82)(kanji.grtwo.occurrences));
  tsu_render;
endtsuglyph;

% extra "centurion"
begintsuglyph("uni4F70",112);
  kanji.rare.centurion;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4F72",114);
  build_kanji.lr(300,40)
    (kanji.leftrad.person)
    (kanji.grone.name);
  tsu_render;
endtsuglyph;

% ka "excellent"
begintsuglyph("uni4F73",115);
  kanji.greight.excellent;
  tsu_render;
endtsuglyph;

% hei/awa "unite"
begintsuglyph("uni4F75",117);
  kanji.greight.unite;
  tsu_render;
endtsuglyph;

% shi/tsuka "use"
begintsuglyph("uni4F7F",127);
  kanji.grthree.use;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4F81",129);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.ahead);
  tsu_render;
endtsuglyph;

% extra "luxury"
begintsuglyph("uni4F88",136);
  build_kanji.level(build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grtwo.many));
  tsu_render;
endtsuglyph;

% rei/tato "example"
begintsuglyph("uni4F8B",139);
  kanji.grfour.example;
  tsu_render;
endtsuglyph;

% Chinese character needed for "yin"
begintsuglyph("uni4F8C",140);
  kanji.rare.yin;
  tsu_render;
endtsuglyph;

% ji/samurai "samurai"
begintsuglyph("uni4F8D",141);
  kanji.greight.samurai;
  tsu_render;
endtsuglyph;

% yuu/susu "urge [another] to eat"
begintsuglyph("uni4F91",145);
  kanji.grnine.urge_to_eat;
  tsu_render;
endtsuglyph;

% rin/omo "be methodical"
begintsuglyph("uni4F96",150);
  kanji.rare.be_methodical;
  tsu_render;
endtsuglyph;

% kyuu/domo "offer"
begintsuglyph("uni4F9B",155);
  kanji.grsix.offer;
  tsu_render;
endtsuglyph;

% i/yo "dependency"
begintsuglyph("uni4F9D",157);
  kanji.greight.dependency;
  tsu_render;
endtsuglyph;

% ka/atai "price"
begintsuglyph("uni4FA1",161);
  kanji.grfive.price;
  tsu_render;
endtsuglyph;

% bu/anado "scorn"
begintsuglyph("uni4FAE",174);
  kanji.greight.scorn;
  tsu_render;
endtsuglyph;

% ryo/tomo "companion"
begintsuglyph("uni4FB6",182);
  kanji.greight.companion;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4FBD",189);
  build_kanji.lr(300,-20)
    (kanji.leftrad.person)
    (kanji.grone.man);
  tsu_render;
endtsuglyph;

% ben/tayo "convenience"
begintsuglyph("uni4FBF",191);
  kanji.grfour.convenience;
  tsu_render;
endtsuglyph;

% kei/kaka "person in charge"
begintsuglyph("uni4FC2",194);
  kanji.grthree.duty_officer;
  tsu_render;
endtsuglyph;

% soku/unaga "urge"
begintsuglyph("uni4FC3",195);
  kanji.greight.urge;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4FC8",200);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grfour.revelation);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni4FC9",201);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(yscaled 0.9 shifted (0,-40))
       (kanji.grnine.my));
  tsu_render;
endtsuglyph;

% ri/kashiko "clever"
begintsuglyph("uni4FD0",208);
  kanji.greight.clever;
  tsu_render;
endtsuglyph;

% zoku "worldly"
begintsuglyph("uni4FD7",215);
  kanji.greight.worldly;
  tsu_render;
endtsuglyph;

% ho/tamo "protect"
begintsuglyph("uni4FDD",221);
  kanji.grfive.protect;
  tsu_render;
endtsuglyph;

% shin "believe"
begintsuglyph("uni4FE1",225);
  kanji.grfour.believe;
  tsu_render;
endtsuglyph;

% ku/tamomi "all together"
begintsuglyph("uni4FF1",241);
  kanji.grten.all_together;
  tsu_render;
endtsuglyph;

% hai "haiku"
begintsuglyph("uni4FF3",243);
  kanji.grsix.haiku;
  tsu_render;
endtsuglyph;

% hyou/tawara "counter for straw bags"
begintsuglyph("uni4FF5",245);
  kanji.grnine.straw_bags;
  tsu_render;
endtsuglyph;

% en/ore "me" (masculine, aggressive, more so than "boku")
begintsuglyph("uni4FFA",250);
  kanji.greight.me_macho;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
