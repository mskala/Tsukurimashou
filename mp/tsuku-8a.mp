%
% Unicode page 8A (Kanji) for Tsukurimashou
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
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.account =
  push_pbox_toexpand("kanji.grtwo.account");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grsix.self));
  expand_pbox;
enddef;

vardef kanji.grtwo.language =
  push_pbox_toexpand("kanji.grtwo.language");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (tsu_xform(identity yscaled 0.95)
      (kanji.grnine.my)));
  expand_pbox;
enddef;

vardef kanji.grtwo.plan =
  push_pbox_toexpand("kanji.grtwo.plan");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grone.ten;
     replace_strokep(0)(oldp shifted (0,70))));
  expand_pbox;
enddef;

vardef kanji.grtwo.read =
  push_pbox_toexpand("kanji.grtwo.read");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.sell));
  expand_pbox;
enddef;

vardef kanji.grtwo.talk =
  push_pbox_toexpand("kanji.grtwo.talk");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (build_kanji.add_beret(tsu_xform(identity yscaled 0.88)
      (kanji.grtwo.old))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.discuss =
  push_pbox_toexpand("kanji.grthree.discuss");
  build_kanji.level(build_kanji.lr(450,-10-20*mincho)
    (kanji.grtwo.word)
    (kanji.greight.inflammation));
  expand_pbox;
enddef;

vardef kanji.grthree.poem =
  push_pbox_toexpand("kanji.grthree.poem");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.temple));
  expand_pbox;
enddef;

vardef kanji.grthree.tune =
  push_pbox_toexpand("kanji.grthree.tune");
  build_kanji.level(build_kanji.lr(380,10)
    (kanji.grtwo.word)
    (kanji.grfour.circuit));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.kunyomi =
  push_pbox_toexpand("kanji.grfour.kunyomi");
  build_kanji.level(build_kanji.lr(450,10)
    (kanji.grtwo.word)
    (kanji.grone.river));
  expand_pbox;
enddef;

vardef kanji.grfour.lesson =
  push_pbox_toexpand("kanji.grfour.lesson");
  build_kanji.level(build_kanji.lr(450,20)
    (kanji.grtwo.word)
    (kanji.grfour.fruit));
  expand_pbox;
enddef;

vardef kanji.grfour.preach =
  push_pbox_toexpand("kanji.grfour.preach");
  build_kanji.level(build_kanji.lr(450,20)
    (kanji.grtwo.word)
    (kanji.rare.cash));
  expand_pbox;
enddef;

vardef kanji.grfour.test =
  push_pbox_toexpand("kanji.grfour.test");
  build_kanji.level(build_kanji.lr(450,30)
    (kanji.grtwo.word)
    (kanji.grthree.formula));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.evaluate =
  push_pbox_toexpand("kanji.grfive.evaluate");
  build_kanji.level(build_kanji.lr(450,20)
    (kanji.grtwo.word)
    (kanji.grthree.level));
  expand_pbox;
enddef;

vardef kanji.grfive.permit =
  push_pbox_toexpand("kanji.grfive.permit");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.noon));
  expand_pbox;
enddef;

vardef kanji.grfive.preparation =
  push_pbox_toexpand("kanji.grfive.preparation");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.radical.windy_again));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.attack =
  push_pbox_toexpand("kanji.grsix.attack");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grsix.inch));
  expand_pbox;
enddef;

vardef kanji.grsix.magazine =
  push_pbox_toexpand("kanji.grsix.magazine");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grfive.intention));
  expand_pbox;
enddef;

vardef kanji.grsix.nativity =
  push_pbox_toexpand("kanji.grsix.nativity");
  build_kanji.level(build_kanji.lr(330,0)
    (kanji.grtwo.word)
    (kanji.grsix.prolong));
  expand_pbox;
enddef;

vardef kanji.grsix.part_of_speech =
  push_pbox_toexpand("kanji.grsix.part_of_speech");
  build_kanji.level(build_kanji.lr(450,30)
    (kanji.grtwo.word)
    (kanji.grfour.director));
  expand_pbox;
enddef;

vardef kanji.grsix.sincerity =
  push_pbox_toexpand("kanji.grsix.sincerity");
  build_kanji.level(build_kanji.lr(420,-10)
    (kanji.grtwo.word)
    (build_kanji.sscale(shifted (0,20))(kanji.grfour.become)));
  expand_pbox;
enddef;

vardef kanji.grsix.translate =
  push_pbox_toexpand("kanji.grsix.translate");
  build_kanji.level(build_kanji.lr(450,-10)
    (kanji.grtwo.word)
    (kanji.grsix.blowjob));
  expand_pbox;
enddef;

vardef kanji.grsix.various =
  push_pbox_toexpand("kanji.grsix.various");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grthree.person));
  expand_pbox;
enddef;

vardef kanji.grsix.visit =
  push_pbox_toexpand("kanji.grsix.visit");
  build_kanji.level(build_kanji.lr(450,-30)
    (kanji.grtwo.word)
    (kanji.grtwo.direction));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.compose =
  push_pbox_toexpand("kanji.greight.compose");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grfive.long));
  expand_pbox;
enddef;

vardef kanji.greight.detailed =
  push_pbox_toexpand("kanji.greight.detailed");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grthree.sheep));
  expand_pbox;
enddef;

vardef kanji.greight.edict =
  push_pbox_toexpand("kanji.greight.edict");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.greight.call));
  expand_pbox;
enddef;

vardef kanji.greight.justified_means =
  push_pbox_toexpand("kanji.greight.justified_means");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grthree.complete));
  expand_pbox;
enddef;

vardef kanji.greight.obituary =
  push_pbox_toexpand("kanji.greight.obituary");
  build_kanji.level(build_kanji.lr(450,100)
    (kanji.grtwo.word)
    (kanji.grnine.divination));
  expand_pbox;
enddef;

vardef kanji.greight.packed =
  push_pbox_toexpand("kanji.greight.packed");
  build_kanji.level(build_kanji.lr(450,-30*mincho)
    (kanji.grtwo.word)
    (kanji.greight.good_luck));
  expand_pbox;
enddef;

vardef kanji.greight.pilgrimage =
  push_pbox_toexpand("kanji.greight.pilgrimage");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.greight.glutamate));
  expand_pbox;
enddef;

vardef kanji.greight.revise =
  push_pbox_toexpand("kanji.greight.revise");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grthree.thumbtack));
  expand_pbox;
enddef;

vardef kanji.greight.sue =
  push_pbox_toexpand("kanji.greight.sue");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.public));
  expand_pbox;
enddef;

vardef kanji.greight.who =
  push_pbox_toexpand("kanji.greight.who");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(shifted (0,-50))(kanji.radical.old_bird)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.annotate =
  push_pbox_toexpand("kanji.grnine.annotate");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(shifted (0,-20))(kanji.grthree.master)));
  expand_pbox;
enddef;

vardef kanji.grnine.tedious =
  push_pbox_toexpand("kanji.grnine.tedious");
  build_kanji.level(build_kanji.lr(450,10)
    (kanji.grtwo.word)
    (kanji.greight.undergo));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% gen/i "word"
begintsuglyph("uni8A00",0);
  kanji.grtwo.word;
  tsu_render;
endtsuglyph;

% extra (word left radical)
begintsuglyph("uni8A01",1);
  build_kanji.lr(450,0)
    (kanji.grtwo.word)
    ();
  tsu_render;
endtsuglyph;

% tei "revise"
begintsuglyph("uni8A02",2);
  kanji.greight.revise;
  tsu_render;
endtsuglyph;

% fu/shirase "obituary"
begintsuglyph("uni8A03",3);
  kanji.greight.obituary;
  tsu_render;
endtsuglyph;

% kei/haka "plan"
begintsuglyph("uni8A08",8);
  kanji.grtwo.plan;
  tsu_render;
endtsuglyph;

% extra: kou "become confused"
begintsuglyph("uni8A0C",12);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(yscaled 1.26)(kanji.grtwo.craft)));
  tsu_render;
endtsuglyph;

% tou/u "attack"
begintsuglyph("uni8A0E",14);
  kanji.grsix.attack;
  tsu_render;
endtsuglyph;

% extra "divulge"
begintsuglyph("uni8A10",16);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(shifted (0,-20))(kanji.grsix.dry)));
  tsu_render;
endtsuglyph;

% kun "native Japanese kanji pronunciation"
% of course "kun" is the "on" reading of this kanji, don't be silly
begintsuglyph("uni8A13",19);
  kanji.grfour.kunyomi;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A14",20);
  build_kanji.level(build_kanji.tb(650,0)
    (kanji.grone.mountain)
    (kanji.grtwo.word));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A15",21);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grone.mountain));
  tsu_render;
endtsuglyph;

% ki/shiru "account"
begintsuglyph("uni8A18",24);
  kanji.grtwo.account;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A19",25);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.circle));
  tsu_render;
endtsuglyph;

% ka/nama "accent (speech)"
begintsuglyph("uni8A1B",27);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grthree.change));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A1C",28);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.minute));
  tsu_render;
endtsuglyph;

% extra "doubt"
begintsuglyph("uni8A1D",29);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.greight.tusk));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A1E",30);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.rare.early_death));
  tsu_render;
endtsuglyph;

% shou "sue"
begintsuglyph("uni8A1F",31);
  kanji.greight.sue;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A20",32);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.pull));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A21",33);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.now));
  tsu_render;
endtsuglyph;

% extra "separation"
begintsuglyph("uni8A23",35);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.rare.decide));
  tsu_render;
endtsuglyph;

% extra "stutter"
begintsuglyph("uni8A25",37);
  build_kanji.level(build_kanji.lr(420,-30)
    (kanji.grtwo.word)
    (kanji.grtwo.home));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A28",40);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (tsu_xform(identity yscaled 1.1)(kanji.grtwo.cease)));
  tsu_render;
endtsuglyph;

% hou/otazu "visit"
begintsuglyph("uni8A2A",42);
  kanji.grsix.visit;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A2C",44);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.little));
  tsu_render;
endtsuglyph;

% satsu/mou "preparation"
begintsuglyph("uni8A2D",45);
  kanji.grfive.preparation;
  tsu_render;
endtsuglyph;

% kyo/yuru "permit" (forgive)
begintsuglyph("uni8A31",49);
  kanji.grfive.permit;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A32",50);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grone.middle));
  tsu_render;
endtsuglyph;

% yaku/wake "translate"
begintsuglyph("uni8A33",51);
  kanji.grsix.translate;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A35",53);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grone.four));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A36",54);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grfive.passable));
  tsu_render;
endtsuglyph;

% chou "annotate"
begintsuglyph("uni8A3B",59);
  kanji.grnine.annotate;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A3C",60);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grone.correct));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A40",64);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.greight.divination));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A41",65);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.old));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A42",66);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grfour.attach));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A47",71);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grthree.centre));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A4B",75);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.big_brother));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A50",80);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.rare.notwithstanding));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A51",81);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.rare.other));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A52",82);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.pedestal));
  tsu_render;
endtsuglyph;

% shou/mikotonori "imperial edict"
begintsuglyph("uni8A54",84);
  kanji.greight.edict;
  tsu_render;
endtsuglyph;

% hyou "evaluate"
begintsuglyph("uni8A55",85);
  kanji.grfive.evaluate;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A57",87);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.radical.gmm;
     build_kanji.box((350,550),(650,250));));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A58",88);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grone.go_away));
  tsu_render;
endtsuglyph;

% extra "curse"
begintsuglyph("uni8A5B",91);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.greight.furthermore));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A5D",93);
  build_kanji.level(build_kanji.lr(470,-30)
    (kanji.grtwo.word)
    (build_kanji.tb(480,0)
       (kanji.radical.silly_hat)
       (kanji.grthree.thumbtack)));
  tsu_render;
endtsuglyph;

% shi "part of speech"
begintsuglyph("uni8A5E",94);
  kanji.grsix.part_of_speech;
  tsu_render;
endtsuglyph;

% ei/yo "compose" (as, a song)
begintsuglyph("uni8A60",96);
  kanji.greight.compose;
  tsu_render;
endtsuglyph;

% kei/mou "pilgrimage"
begintsuglyph("uni8A63",99);
  kanji.greight.pilgrimage;
  tsu_render;
endtsuglyph;

% shi/kokoro "test"
begintsuglyph("uni8A66",102);
  kanji.grfour.test;
  tsu_render;
endtsuglyph;

% shi/uta "poem"
begintsuglyph("uni8A69",105);
  kanji.grthree.poem;
  tsu_render;
endtsuglyph;

% sen "justified means"
begintsuglyph("uni8A6E",110);
  kanji.greight.justified_means;
  tsu_render;
endtsuglyph;

% kitsu/tsu "packed"
begintsuglyph("uni8A70",112);
  kanji.greight.packed;
  tsu_render;
endtsuglyph;

% wa/hana "talk"
begintsuglyph("uni8A71",113);
  kanji.grtwo.talk;
  tsu_render;
endtsuglyph;

% shou/kuwa "detailed"
begintsuglyph("uni8A73",115);
  kanji.greight.detailed;
  tsu_render;
endtsuglyph;

% extra "jest"
begintsuglyph("uni8A7C",124);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grsix.ash));
  tsu_render;
endtsuglyph;

% extra "order"
begintsuglyph("uni8A82",130);
  build_kanji.level(build_kanji.lr(450,-30*mincho)
    (kanji.grtwo.word)
    (kanji.grfour.portent));
  tsu_render;
endtsuglyph;

% shi "magazine"
begintsuglyph("uni8A8C",140);
  kanji.grsix.magazine;
  tsu_render;
endtsuglyph;

% tan "nativity"
begintsuglyph("uni8A95",149);
  kanji.grsix.nativity;
  tsu_render;
endtsuglyph;

% extra "censure"
begintsuglyph("uni8A9A",154);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.greight.resemblance));
  tsu_render;
endtsuglyph;

% go/kata "language"
begintsuglyph("uni8A9E",158);
  kanji.grtwo.language;
  tsu_render;
endtsuglyph;

% sei/makoto "sincerity"
begintsuglyph("uni8AA0",160);
  kanji.grsix.sincerity;
  tsu_render;
endtsuglyph;

% extra "admonish"
begintsuglyph("uni8AA1",161);
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(shifted (0,20))(kanji.greight.precept)));
  tsu_render;
endtsuglyph;

% extra "give instructions"
begintsuglyph("uni8AA5",165);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grfour.revelation));
  tsu_render;
endtsuglyph;

% extra "recite"
begintsuglyph("uni8AA6",166);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.rare.walled_road));
  tsu_render;
endtsuglyph;

% extra "instruct"
begintsuglyph("uni8AA8",168);
  build_kanji.level(build_kanji.lr(400,-20)
    (kanji.grtwo.word)
    (kanji.grtwo.every));
  tsu_render;
endtsuglyph;

% setsu/to "preach"
begintsuglyph("uni8AAC",172);
  kanji.grfour.preach;
  tsu_render;
endtsuglyph;

% goku/yo "read"
begintsuglyph("uni8AAD",173);
  kanji.grtwo.read;
  tsu_render;
endtsuglyph;

% sui/dare "who"
begintsuglyph("uni8AB0",176);
  kanji.greight.who;
  tsu_render;
endtsuglyph;

% ka "lesson"
begintsuglyph("uni8AB2",178);
  kanji.grfour.lesson;
  tsu_render;
endtsuglyph;

% extra "ridicule"
begintsuglyph("uni8AB9",185);
  build_kanji.level(build_kanji.lr(430,-20)
    (kanji.grtwo.word)
    (kanji.grfive.mistake));
  tsu_render;
endtsuglyph;

% chou/shira "tune"
begintsuglyph("uni8ABF",191);
  kanji.grthree.tune;
  tsu_render;
endtsuglyph;

% shun/kudo "tedious"
begintsuglyph("uni8AC4",196);
  kanji.grnine.tedious;
  tsu_render;
endtsuglyph;

% dan "discuss"
begintsuglyph("uni8AC7",199);
  kanji.grthree.discuss;
  tsu_render;
endtsuglyph;

% <\X8ACB>[lr]\X8A00<\X9752>[tb](anything)\X6708
% <\X8ACC>[lr]\X8A00\X6771
% <\X8ACF>[lr]\X8A00<\X53D6>[lr]\X8033\X53C8
% <\X8AD2>[lr]\X8A00<\X4EAC>[tb]\X4EA0(anything)
% <\X8AD6>[lr]\X8A00<\X4F96>[tb]\X4EBA(anything)
% <\X8ADA>[lr]\X8A00<\X5B9A>[tb]\X5B80\X758B
% <\X8AE2>[lr]\X8A00<\X8ECD>[tb]\X5196\X8ECA
% <\X8AE4>[lr]\X8A00<\X54A2>[tb][lr]\X53E3\X53E3(anything)
% <\X8AE7>[lr]\X8A00<\X7686>[tb]<\X6BD4>[lr](anything)\X5315<\X767D>[tb](anything)\X65E5
% <\X8AF3>[lr]\X8A00<\X97F3>[tb]<\X7ACB>[tb]\X4EA0(anything)\X65E5
% <\X8AF7>[lr]\X8A00\X98A8
% sho/moro "various"
begintsuglyph("uni8AF8",248);
  kanji.grsix.various;
  tsu_render;
endtsuglyph;

% <\X8AFA>[lr]\X8A00\X5F66
% <\X8AFE>[lr]\X8A00<\X82E5>[tb]\X8279\X53F3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
