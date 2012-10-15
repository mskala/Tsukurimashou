%
% Unicode page 57 (Kanji) for Tsukurimashou
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
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.garden =
  push_pbox_toexpand("kanji.grtwo.garden");
  kanji.radical.box;
  build_kanji.sscale(scaled 0.75)
    (kanji.radical.long_kimono);
  expand_pbox;
enddef;

vardef kanji.grtwo.ground =
  push_pbox_toexpand("kanji.grtwo.ground");
  build_kanji.level(build_kanji.lr(370,0)
    (kanji.leftrad.earth)
    (kanji.grnine.to_be));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.slope =
  push_pbox_toexpand("kanji.grthree.slope");
  build_kanji.level(build_kanji.lr(370,0)
    (kanji.leftrad.earth)
    (kanji.grthree.anti));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.pressure =
  push_pbox_toexpand("kanji.grfive.pressure");
  build_kanji.cliff_enclose(kanji.grone.earth);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% en/zono "garden"
begintsuglyph("uni5712",18);
  kanji.grtwo.garden;
  tsu_render;
endtsuglyph;

% tsuchi/do "earth"
begintsuglyph("uni571F",31);
  kanji.grone.earth;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5722",34);
  build_kanji.level(build_kanji.lr(450,60)
    (kanji.leftrad.earth)
    (kanji.grthree.thumbtack));
  tsu_render;
endtsuglyph;

% extra: "sacred"
begintsuglyph("uni5723",35);
  kanji.rare.sacred;
  tsu_render;
endtsuglyph;

% atsu/o "pressure"
begintsuglyph("uni5727",39);
  kanji.grfive.pressure;
  tsu_render;
endtsuglyph;

% kei/ka "square jewel"
begintsuglyph("uni572D",45);
  kanji.grnine.square_jewel;
  tsu_render;
endtsuglyph;

% chi/ji "ground"
begintsuglyph("uni5730",48);
  kanji.grtwo.ground;
  tsu_render;
endtsuglyph;

% han/saka "slope"
begintsuglyph("uni5742",66);
  kanji.grthree.slope;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
