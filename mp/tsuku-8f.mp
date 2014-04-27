%
% Unicode page 8F (Kanji) for Tsukurimashou
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
input gradethree.mp;
input gradetwo.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.near =
  push_pbox_toexpand("kanji.grtwo.near");
  build_kanji.road_enclose(kanji.greight.axe);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.pursue =
  push_pbox_toexpand("kanji.grthree.pursue");
  build_kanji.road_enclose(kanji.rare.mound);
  expand_pbox;
enddef;

vardef kanji.grthree.return =
  push_pbox_toexpand("kanji.grthree.return");
  build_kanji.road_enclose(kanji.grthree.anti);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.resign =
  push_pbox_toexpand("kanji.grfour.resign");
  build_kanji.level(build_kanji.lr(480,-10)
    (tsu_xform(identity yscaled 0.92 shifted (0,-20))(kanji.grfive.tongue))
    (tsu_xform(identity yscaled 1.02 shifted (0,0))(kanji.greight.acrid)));
  expand_pbox;
enddef;

vardef kanji.grfour.vicinity =
  push_pbox_toexpand("kanji.grfour.vicinity");
  build_kanji.road_enclose(kanji.grtwo.sword);
  expand_pbox;
enddef;

vardef kanji.grfour.wheel =
  push_pbox_toexpand("kanji.grfour.wheel");
  build_kanji.level(build_kanji.lr(480,-20)
    (kanji.grone.wheel)
    (kanji.rare.be_methodical));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.crowded =
  push_pbox_toexpand("kanji.greight.crowded");
  build_kanji.road_enclose(kanji.grone.put_it_in);
  expand_pbox;
enddef;

vardef kanji.greight.reshuffle =
  push_pbox_toexpand("kanji.greight.reshuffle");
  build_kanji.road_enclose(kanji.grfour.disappear);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.crossroads =
  push_pbox_toexpand("kanji.grnine.crossroads");
  build_kanji.road_enclose(kanji.grone.ten);
  expand_pbox;
enddef;

vardef kanji.grnine.edify =
  push_pbox_toexpand("kanji.grnine.edify");
  build_kanji.road_enclose(kanji.grthree.reason);
  expand_pbox;
enddef;

vardef kanji.grnine.grope_along =
  push_pbox_toexpand("kanji.grnine.grope_along");
  build_kanji.road_enclose(kanji.grone.mountain);
  expand_pbox;
enddef;

vardef kanji.grnine.phonetic_ka =
  push_pbox_toexpand("kanji.grnine.phonetic_ka");
  build_kanji.road_enclose(tsu_xform(identity shifted (-950,-850)
       scaled 0.98 shifted (950,850))
    (kanji.grfour.addition));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% rin/wa "wheel"
begintsuglyph("uni8F2A",42);
  kanji.grfour.wheel;
  tsu_render;
endtsuglyph;

% shin/kara "acrid"
begintsuglyph("uni8F9B",155);
  kanji.greight.acrid;
  tsu_render;
endtsuglyph;

% ji/ya "resign" or "dictionary"
begintsuglyph("uni8F9E",158);
  kanji.grfour.resign;
  tsu_render;
endtsuglyph;

% heki/kimu "punish"
begintsuglyph("uni8F9F",159);
  kanji.rare.punish;
  tsu_render;
endtsuglyph;

% shin/tatsu "zodiac sign of the dragon"
begintsuglyph("uni8FB0",176);
  kanji.grnine.dragon_sign;
  tsu_render;
endtsuglyph;

% nou/na "farming"
begintsuglyph("uni8FB2",178);
  kanji.grthree.farming;
  tsu_render;
endtsuglyph;

% hen/ata "vicinity"
begintsuglyph("uni8FBA",186);
  kanji.grfour.vicinity;
  tsu_render;
endtsuglyph;

% tsuji "crossroads"
begintsuglyph("uni8FBB",187);
  kanji.grnine.crossroads;
  tsu_render;
endtsuglyph;

% ko "crowded"
begintsuglyph("uni8FBC",188);
  kanji.greight.crowded;
  tsu_render;
endtsuglyph;

% ten/tado "grope along"
begintsuglyph("uni8FBF",191);
  kanji.grnine.grope_along;
  tsu_render;
endtsuglyph;

% kin/chika "near"
begintsuglyph("uni8FD1",209);
  kanji.grtwo.near;
  tsu_render;
endtsuglyph;

% hen/kae "return"
begintsuglyph("uni8FD4",212);
  kanji.grthree.return;
  tsu_render;
endtsuglyph;

% ka "phoneme only"
begintsuglyph("uni8FE6",230);
  kanji.grnine.phonetic_ka;
  tsu_render;
endtsuglyph;

% teki/michi "edify"
begintsuglyph("uni8FEA",234);
  kanji.grnine.edify;
  tsu_render;
endtsuglyph;

% tetsu "reshuffle"
begintsuglyph("uni8FED",237);
  kanji.greight.reshuffle;
  tsu_render;
endtsuglyph;

% mei/mayo "hesitate"
begintsuglyph("uni8FF7",247);
  kanji.grfive.hesitate;
  tsu_render;
endtsuglyph;

% tsui/o "pursue"
begintsuglyph("uni8FFD",253);
  kanji.grthree.pursue;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
