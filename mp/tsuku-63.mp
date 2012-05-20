%
% Unicode page 63 (Kanji) for Tsukurimashou
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
input gradeone.mp;
input gradesix.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.finger =
  push_pbox_toexpand("kanji.grthree.finger");
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.leftrad.hand)
    (kanji.greight.glutamate));
  expand_pbox;
enddef;

vardef kanji.grthree.have =
  push_pbox_toexpand("kanji.grthree.have");
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.leftrad.hand)
    (kanji.grtwo.temple));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.depict =
  push_pbox_toexpand("kanji.greight.depict");
  build_kanji.level(build_kanji.lr(420,30)
    (kanji.leftrad.hand)
    (build_kanji.sscale(shifted (0,-40))(kanji.greight.seedling)));
  expand_pbox;
enddef;

vardef kanji.greight.discharge =
  push_pbox_toexpand("kanji.greight.discharge");
  build_kanji.level(build_kanji.lr(420,-30)
    (kanji.leftrad.hand)
    (kanji.grfive.mistake));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ji/mo "have"
begintsuglyph("uni6301",1);
  kanji.grthree.have;
  tsu_render;
endtsuglyph;

% shi/yubi "finger"
begintsuglyph("uni6307",7);
  kanji.grthree.finger;
  tsu_render;
endtsuglyph;

% hai "discharge"
begintsuglyph("uni6392",146);
  kanji.greight.discharge;
  tsu_render;
endtsuglyph;

% byou/ega "depict"
begintsuglyph("uni63CF",207);
  kanji.greight.depict;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
