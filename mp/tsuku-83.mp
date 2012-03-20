%
% Unicode page 83 (Kanji) for Tsukurimashou
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
input gradefive.mp;
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

vardef kanji.grone.grass =
  push_pbox_toexpand("kanji.grone.grass");
  build_kanji.tb(600,10)
    (kanji.toprad.grass)
    (kanji.grone.early);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.tea =
  push_pbox_toexpand("kanji.grone.grass");
  build_kanji.tb(630,60)
    (kanji.toprad.grass)
    (build_kanji.level(
       kanji.radical.tent;
       replace_strokep(0)((250,380)--(750,380));
       tsu_xform(identity yscaled 0.6 shifted (0,-100))
         (kanji.grone.small);
       replace_strokep(-1)((500,570)--(500,-30));
       replace_strokeq(-1)((1.6,1.6)--(1.4,1.4));
     ));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.baggage =
  push_pbox_toexpand("kanji.grthree.baggage");
  build_kanji.tb(640,0)
    (kanji.toprad.grass)
    (kanji.grtwo.what);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extra
begintsuglyph("uni8301",1);
  build_kanji.tb(600,80)
    (kanji.toprad.grass)
    (kanji.grone.go_away);
  tsu_render;
endtsuglyph;

% myou/cha "tea"
begintsuglyph("uni8317",23);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.name);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8320",32);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grone.vacation);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8321",33);
  build_kanji.tb(600,50)
    (kanji.toprad.grass)
    (kanji.grone.character);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8324",36);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (kanji.grtwo.many);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8334",52);
  build_kanji.tb(600,0)
    (kanji.toprad.grass)
    (build_kanji.sscale(scaled 0.92)(kanji.grtwo.occurrences));
  tsu_render;
endtsuglyph;

% cha/sa "tea"
begintsuglyph("uni8336",54);
  kanji.grtwo.tea;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8338",56);
  build_kanji.tb(600,30)
    (kanji.toprad.grass)
    (kanji.grone.ear);
  tsu_render;
endtsuglyph;

% sou/kusa "grass"
begintsuglyph("uni8349",73);
  kanji.grone.grass;
  tsu_render;
endtsuglyph;

% ka/ni "baggage"
begintsuglyph("uni8377",119);
  kanji.grthree.baggage;
  tsu_render;
endtsuglyph;

% hoku/wazurawashii "no meaning given, but needed to build 'boku'"
begintsuglyph("uni83D0",208);
  kanji.rare.eight_three_dee_zero;
  tsu_render;
endtsuglyph;

% extra an/iori "hermitage"
begintsuglyph("uni83F4",244);
  build_kanji.tb(640,80)
    (kanji.toprad.grass)
    (kanji.grnine.suffocate);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
