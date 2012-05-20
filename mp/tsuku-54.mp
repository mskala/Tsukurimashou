%
% Unicode page 54 (Kanji) for Tsukurimashou
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

vardef kanji.grtwo.same =
  push_pbox_toexpand("kanji.grtwo.same");
  kanji.radical.gmm;
  push_stroke((310,620)--(690,620),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  build_kanji.box((350,470),(650,170));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.decree =
  push_pbox_toexpand("kanji.grthree.decree");
  build_kanji.level(
    build_kanji.sscale(xyscaled (1,0.8) shifted (0,110))
      (kanji.radical.tent);
    build_kanji.sscale(xyscaled (0.9,0.55) shifted (0,-200))
      (kanji.rare.smash);
  );
  expand_pbox;
enddef;

vardef kanji.grthree.facing =
  push_pbox_toexpand("kanji.grthree.facing");
  push_stroke((520,810)..tension 1.2..(470,720)..(420,640),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  set_boserif(0,0,10);
  tsu_xform(identity yscaled (640/780))(kanji.radical.gmm);
  build_kanji.box((350,460),(650,170));
  expand_pbox;
enddef;

vardef kanji.grthree.junior =
  push_pbox_toexpand("kanji.grthree.junior");
  kanji.rare.director;
  build_kanji.box((320,240),(810,0));
  expand_pbox;
enddef;

vardef kanji.grthree.member =
  push_pbox_toexpand("kanji.grthree.member");
  build_kanji.level(build_kanji.tb(620,0)
    (build_kanji.sscale(xscaled 0.67)(kanji.grone.mouth))
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grthree.taste =
  push_pbox_toexpand("kanji.grthree.taste");
  build_kanji.lr(380,-30)
    (kanji.leftrad.mouth)
    (kanji.grfour.not_yet);
  expand_pbox;
enddef;

vardef kanji.grthree.wa =
  push_pbox_toexpand("kanji.grthree.wa");
  build_kanji.lr(560,10)
    (kanji.leftrad.two_branch_tree)
    (kanji.grone.mouth);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kaku/onoono "every"
begintsuglyph("uni5404",4);
  kanji.grfour.every;
  tsu_render;
endtsuglyph;

% gou/a "meet"
begintsuglyph("uni5408",8);
  kanji.grtwo.join;
  tsu_render;
endtsuglyph;

% extra chou/tsu "hanging"
begintsuglyph("uni540A",10);
  build_kanji.level(build_kanji.tb(440,145)
    (build_kanji.sscale(scaled 0.8)(kanji.grone.mouth))
    (kanji.greight.towel));
  tsu_render;
endtsuglyph;

% dou/onaji "the same"
begintsuglyph("uni540C",12);
  kanji.grtwo.same;
  tsu_render;
endtsuglyph;

% na "name"
begintsuglyph("uni540D",13);
  kanji.grone.name;
  tsu_render;
endtsuglyph;

% ri "officer"
begintsuglyph("uni540F",15);
  kanji.greight.officer;
  tsu_render;
endtsuglyph;

% kou/mu "facing"
begintsuglyph("uni5411",17);
  kanji.grthree.facing;
  tsu_render;
endtsuglyph;

% kun/kimi "pronoun or honorific for a subordinate"
begintsuglyph("uni541B",27);
  kanji.grthree.junior;
  tsu_render;
endtsuglyph;

% go/ware "my, mine"
begintsuglyph("uni543E",62);
  kanji.grnine.my;
  tsu_render;
endtsuglyph;

% ryo "spine"
begintsuglyph("uni5442",66);
  kanji.greight.spine;
  tsu_render;
endtsuglyph;

% koku "revelation"
begintsuglyph("uni544A",74);
  kanji.grfour.revelation;
  tsu_render;
endtsuglyph;

% ton/no "drink" (rare form used as part of other things)
begintsuglyph("uni5451",81);
  kanji.rare.drink;
  tsu_render;
endtsuglyph;

% shuu/mawa "circuit"
begintsuglyph("uni5468",104);
  kanji.grfour.circuit;
  tsu_render;
endtsuglyph;

% mi/aji "taste"
begintsuglyph("uni5473",115);
  kanji.grthree.taste;
  tsu_render;
endtsuglyph;

% mei/inochi "decree"
begintsuglyph("uni547D",125);
  kanji.grthree.decree;
  tsu_render;
endtsuglyph;

% wa/yawa "wa" (supposedly-untranslatable term equated with Japanese spirit)
begintsuglyph("uni548C",140);
  kanji.grthree.wa;
  tsu_render;
endtsuglyph;

% rare character in the name of Shirayama Hime shrine
begintsuglyph("uni54A9",169);
  build_kanji.lr(380,10)
    (build_kanji.sscale(shifted (0,-50))(kanji.leftrad.mouth))
    (kanji.grthree.sheep);
  tsu_render;
endtsuglyph;

% hin.shina "goods"
begintsuglyph("uni54C1",193);
  kanji.grthree.goods;
  tsu_render;
endtsuglyph;

% in "member"
begintsuglyph("uni54E1",225);
  kanji.grthree.member;
  tsu_render;
endtsuglyph;

% ka/uta "big brother" (needed for ka/uta "song")
begintsuglyph("uni54E5",229);
  kanji.rare.big_brother;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
