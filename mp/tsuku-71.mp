%
% Unicode page 71 (Kanji) for Tsukurimashou
% Copyright (C) 2012, 2013, 2014  Matthew Skala
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.cook =
  push_pbox_toexpand("kanji.grfour.cook");
  build_kanji.level(build_kanji.lr(370,60)
    (kanji.leftrad.fire)
    (kanji.grnine.mountain_high));
  expand_pbox;
enddef;

vardef kanji.grfour.heat =
  push_pbox_toexpand("kanji.grfour.heat");
  build_kanji.tb(190,-30)
    (kanji.rare.art)
    (kanji.bottomrad.four_ticks);
  expand_pbox;
enddef;

vardef kanji.grfour.illuminate =
  push_pbox_toexpand("kanji.grfour.illuminate");
  build_kanji.tb(190,-30)
    (kanji.grthree.shining)
    (kanji.bottomrad.four_ticks);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.prosperous =
  push_pbox_toexpand("kanji.grnine.prosperous");
  build_kanji.tb(190,-30)
    (build_kanji.lr(560,-30)
       (build_kanji.sscale(yscaled 0.86)
          (kanji.radical.box_on_side;
           build_kanji.box((350,530),(750,250));
           push_stroke((550,800)--(550,530),(1.5,1.5)--(1.4,1.4));
           push_stroke((550,250)--(550,-20),(1.5,1.5)--(1.4,1.4))))
       (kanji.grnine.snake_sign))
    (kanji.bottomrad.four_ticks);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mu/na "nothing"
begintsuglyph("uni7121",33);
  kanji.grfour.nothing;
  tsu_render;
endtsuglyph;

% sou as in "sou desu"
begintsuglyph("uni7136",54);
  kanji.grfour.that_case;
  tsu_render;
endtsuglyph;

% shou/ya "cook"
begintsuglyph("uni713C",60);
  kanji.grfour.cook;
  tsu_render;
endtsuglyph;

% shou/te "illuminate"
begintsuglyph("uni7167",103);
  kanji.grfour.illuminate;
  tsu_render;
endtsuglyph;

% ki/tanoshi "prosperous"
begintsuglyph("uni7199",153);
  kanji.grnine.prosperous;
  tsu_render;
endtsuglyph;

% netsu/atsu "heat"
begintsuglyph("uni71B1",177);
  kanji.grfour.heat;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
