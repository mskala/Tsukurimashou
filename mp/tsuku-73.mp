%
% Unicode page 73 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2014, 2017  Matthew Skala
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
input gradeone.mp;
input leftrad.mp;
input radical.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.actually =
  push_pbox_toexpand("kanji.grfive.actually");
  build_kanji.lr(400,20)
    (kanji.leftrad.king)
    (kanji.grone.see);
  expand_pbox;
enddef;

vardef kanji.grfive.ratio =
  push_pbox_toexpand("kanji.grfive.ratio");
  build_kanji.level(build_kanji.tcb(610+40*mincho,10-20*mincho)(240,0)
    (kanji.radical.kettle_lid)
    (build_kanji.sscale(xscaled 0.6)(kanji.radical.short_thread);
     push_stroke((80,740)..tension 1.2..(170,600)..(210,500),
       (1,1)--(1.5,1.5)--(1.8,1.8));
     push_stroke((230,330)..(160,190)..tension 1.2..(70,90),
       (1.1,1.1)--(1.4,1.4)--(1.9,1.9));
     push_stroke(get_strokep(-1) shifted ((760,330)-point 0 of get_strokep(-1)),
       get_strokeq(-1));
     push_stroke(get_strokep(-1) shifted ((760,480)-point 2 of get_strokep(-1)),
       get_strokeq(-1)))
    (kanji.grone.ten));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sotsu/hiki "ratio"
begintsuglyph("uni7387",135);
  kanji.grfive.ratio;
  tsu_render;
endtsuglyph;

% gyoku/tama "ball" or "precious"
begintsuglyph("uni7389",137);
  kanji.grone.ball;
  tsu_render;
endtsuglyph;

% ou "king"
begintsuglyph("uni738B",139);
  kanji.grone.king;
  tsu_render;
endtsuglyph;

% gen/arawa "actually"
begintsuglyph("uni73FE",254);
  kanji.grfive.actually;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
