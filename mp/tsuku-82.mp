%
% Unicode page 82 (Kanji) for Tsukurimashou
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grone.flower =
  push_pbox_toexpand("kanji.grone.flower");
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grthree.change);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.boat =
  push_pbox_toexpand("kanji.grtwo.boat");
  build_kanji.lr(520,0)
    (kanji.leftrad.boat)
    (build_kanji.level(build_kanji.tb(410,0)
       (kanji.radical.eight)
       (kanji.grone.mouth)));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.suffering =
  push_pbox_toexpand("kanji.grthree.suffering");
  build_kanji.tb(630,60)
    (kanji.toprad.grass)
    (kanji.grtwo.old);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.english =
  push_pbox_toexpand("kanji.grfour.english");
  build_kanji.tb(630,80)
    (kanji.toprad.grass)
    (kanji.grthree.centre);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.young_master =
  push_pbox_toexpand("kanji.grsix.young_master");
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.right);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% zetsu/shita "tongue"
begintsuglyph("uni820C",12);
  kanji.grfive.tongue;
  tsu_render;
endtsuglyph;

% shuu/fune "boat"
begintsuglyph("uni821F",31);
  kanji.greight.boat;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8220",32);
  build_kanji.lr(520,30)
    (kanji.leftrad.boat)
    (kanji.grtwo.sword);
  tsu_render;
endtsuglyph;

% extra: boat
begintsuglyph("uni8221",33);
  build_kanji.lr(520,0)
    (kanji.leftrad.boat)
    (build_kanji.sscale(xyscaled (1.15,1.3))(kanji.grtwo.craft));
  tsu_render;
endtsuglyph;

% extra: "English" meaning is "sampan"
begintsuglyph("uni8222",34);
  build_kanji.lr(520,0)
    (kanji.leftrad.boat)
    (kanji.grone.mountain);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8225",37);
  build_kanji.lr(460,0)
    (kanji.leftrad.boat)
    (kanji.grnine.tomoe);
  tsu_render;
endtsuglyph;

% extra: boat
begintsuglyph("uni8229",41);
  build_kanji.lr(480,0)
    (kanji.leftrad.boat)
    (kanji.grtwo.public);
  tsu_render;
endtsuglyph;

% extra: moor/berth
begintsuglyph("uni822B",43);
  build_kanji.lr(520,30)
    (kanji.leftrad.boat)
    (kanji.grtwo.direction);
  tsu_render;
endtsuglyph;

% sen/fune "boat"
begintsuglyph("uni8239",57);
  kanji.grtwo.boat;
  tsu_render;
endtsuglyph;

% kon/ushitora "northeast"
begintsuglyph("uni826E",110);
  kanji.radical.northeast;
  tsu_render;
endtsuglyph;

% ryou/yo "good"
begintsuglyph("uni826F",111);
  kanji.grfour.good;
  tsu_render;
endtsuglyph;

% shoku/iro "colour"
begintsuglyph("uni8272",114);
  kanji.grtwo.colour;
  tsu_render;
endtsuglyph;

% extra "naked grass radical"
begintsuglyph("uni8279",121);
  build_kanji.sscale(yscaled 0.5)(kanji.toprad.grass);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni827B",123);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.power);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni827C",124);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grthree.thumbtack);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni827D",125);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.nine);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8284",132);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grtwo.circle);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni828A",138);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.one_thousand);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8293",147);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.child);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8296",150);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.big);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82AB",171);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grtwo.origin);
  tsu_render;
endtsuglyph;

% hana "flower"
begintsuglyph("uni82B1",177);
  kanji.grone.flower;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82C2",194);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.fire);
  tsu_render;
endtsuglyph;

% byo/nae "rice seedling"
begintsuglyph("uni82D7",215);
  kanji.greight.seedling;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82D9",217);
  build_kanji.tb(600,50)
    (kanji.toprad.grass)
    (kanji.grone.stand_up);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82DA",218);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grtwo.job);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82DC",220);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.eye);
  tsu_render;
endtsuglyph;

% waka "young master"
begintsuglyph("uni82E5",229);
  kanji.grsix.young_master;
  tsu_render;
endtsuglyph;

% ku/kuru "suffering"
begintsuglyph("uni82E6",230);
  kanji.grthree.suffering;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82E9",233);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.white);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82EE",238);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.greight.wizard);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82EF",239);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.book);
  tsu_render;
endtsuglyph;

% ei "English"
begintsuglyph("uni82F1",241);
  kanji.grfour.english;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82F2",242);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.rare.notwithstanding);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni82FC",252);
  build_kanji.tb(600,50)
    (kanji.toprad.grass)
    (kanji.grone.life);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
