%
% Unicode page 99 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2016  Matthew Skala
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
input gradefour.mp;
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

vardef kanji.grthree.building =
  push_pbox_toexpand("kanji.grthree.building");
  build_kanji.lr(480,20)
    (kanji.leftrad.eat)
    (kanji.grfour.bureaucracy);
  expand_pbox;
enddef;

vardef kanji.grthree.station =
  push_pbox_toexpand("kanji.grthree.station");
  build_kanji.lr(480,0)
    (kanji.grtwo.horse)
    (build_kanji.sscale(yscaled 1.11)
       (kanji.grsix.blowjob));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% you/yashina "nurture"
begintsuglyph("uni990A",10);
  kanji.grfour.nurture;
  tsu_render;
endtsuglyph;

% kan/yukata "building"
begintsuglyph("uni9928",40);
  kanji.grthree.building;
  tsu_render;
endtsuglyph;

% shu/kubi "neck"
begintsuglyph("uni9996",150);
  kanji.grtwo.neck;
  tsu_render;
endtsuglyph;

% ba/uma "horse"
begintsuglyph("uni99AC",172);
  kanji.grtwo.horse;
  tsu_render;
endtsuglyph;

% eki "station"
begintsuglyph("uni99C5",197);
  kanji.grthree.station;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
