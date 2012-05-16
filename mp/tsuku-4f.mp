%
% Unicode page 4F (Kanji) for Tsukurimashou
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
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
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

vardef kanji.grsix.haiku =
  push_pbox_toexpand("kanji.grsix.haiku");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grfive.mistake);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.assistant =
  push_pbox_toexpand("kanji.greight.assistant");
  build_kanji.lr(300,40)
    (kanji.leftrad.person)
    (kanji.grone.left);
  expand_pbox;
enddef;

vardef kanji.greight.earl =
  push_pbox_toexpand("kanji.greight.earl");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(shifted (0,20))(kanji.grone.white));
  expand_pbox;
enddef;

vardef kanji.greight.me_macho =
  push_pbox_toexpand("kanji.greight.me_macho");
  build_kanji.lr(270,40*(1-mincho))
    (kanji.leftrad.person)
    (kanji.grnine.suffocate);
  expand_pbox;
enddef;

vardef kanji.greight.unite =
  push_pbox_toexpand("kanji.greight.unite");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(shifted (0,30))(kanji.rare.merger));
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

vardef kanji.grnine.paddy =
  push_pbox_toexpand("kanji.grnine.paddy");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.paddy);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% extra
begintsuglyph("uni4F35",53);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (build_kanji.sscale(scaled 0.95)(kanji.grone.four));
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

% extra
begintsuglyph("uni4FBD",189);
  build_kanji.lr(300,-20)
    (kanji.leftrad.person)
    (kanji.grone.man);
  tsu_render;
endtsuglyph;

% kei/kaka "person in charge"
begintsuglyph("uni4FC2",194);
  kanji.grthree.duty_officer;
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

% hai "haiku"
begintsuglyph("uni4FF3",243);
  kanji.grsix.haiku;
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
