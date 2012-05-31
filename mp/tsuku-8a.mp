%
% Unicode page 8A (Kanji) for Tsukurimashou
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.permit =
  push_pbox_toexpand("kanji.grfive.permit");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.noon));
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

vardef kanji.grsix.part_of_speech =
  push_pbox_toexpand("kanji.grsix.part_of_speech");
  build_kanji.level(build_kanji.lr(450,30)
    (kanji.grtwo.word)
    (kanji.grfour.director));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.edict =
  push_pbox_toexpand("kanji.greight.edict");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.greight.call));
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

% extra: separation
begintsuglyph("uni8A23",35);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.rare.decide));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A28",40);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (tsu_xform(identity yscaled 1.1)(kanji.grtwo.cease)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8A2C",44);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grtwo.little));
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

% kei/mou "pilgrimage"
begintsuglyph("uni8A63",99);
  kanji.greight.pilgrimage;
  tsu_render;
endtsuglyph;

% shi/uta "poem"
begintsuglyph("uni8A69",105);
  kanji.grthree.poem;
  tsu_render;
endtsuglyph;

% wa/hana "talk"
begintsuglyph("uni8A71",113);
  kanji.grtwo.talk;
  tsu_render;
endtsuglyph;

% go/kata "language"
begintsuglyph("uni8A9E",158);
  kanji.grtwo.language;
  tsu_render;
endtsuglyph;

% goku/yo "read"
begintsuglyph("uni8AAD",173);
  kanji.grtwo.read;
  tsu_render;
endtsuglyph;

% chou/shira "tune"
begintsuglyph("uni8ABF",191);
  kanji.grthree.tune;
  tsu_render;
endtsuglyph;

% dan "discuss"
begintsuglyph("uni8AC7",199);
  kanji.grthree.discuss;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
