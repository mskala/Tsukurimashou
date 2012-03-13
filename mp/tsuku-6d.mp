%
% Unicode page 6d (Kanji) for Tsukurimashou
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
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input toprad.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.ocean =
  push_pbox_toexpand("kanji.grtwo.ocean");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grtwo.every);
  expand_pbox;
enddef;

vardef kanji.grtwo.vitality =
  push_pbox_toexpand("kanji.grtwo.vitality");
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grfive.tongue);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.cancel =
  push_pbox_toexpand("kanji.grthree.cancel");
  build_kanji.lr(360,30)
    (kanji.leftrad.water)
    (kanji.greight.resemblance);
  expand_pbox;
enddef;

vardef kanji.grthree.deep =
  push_pbox_toexpand("kanji.grthree.deep");
  build_kanji.lr(360,-10)
    (kanji.leftrad.water)
    (build_kanji.level(build_kanji.tb(460,0)
       (kanji.toprad.cave;
        set_bosize(-3,0))
       (kanji.grone.wood)));
  expand_pbox;
enddef;

vardef kanji.grthree.ocean =
  push_pbox_toexpand("kanji.grthree.ocean");
  build_kanji.lr(360,30)
    (kanji.leftrad.water)
    (kanji.grthree.sheep);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% you "ocean"
begintsuglyph("uni6D0B",11);
  kanji.grthree.ocean;
  tsu_render;
endtsuglyph;

% raku "Kyoto"
begintsuglyph("uni6D1B",27);
  kanji.grnine.kyoto;
  tsu_render;
endtsuglyph;

% katsu/i "correct"
begintsuglyph("uni6D3B",59);
  kanji.grtwo.vitality;
  tsu_render;
endtsuglyph;

% kai/umi "ocean"
begintsuglyph("uni6D77",119);
  kanji.grtwo.ocean;
  tsu_render;
endtsuglyph;

% shou/ki "cancel"
begintsuglyph("uni6D88",136);
  kanji.grthree.cancel;
  tsu_render;
endtsuglyph;

% extra en/i "soak" (in particular, making tea or coffee)
begintsuglyph("uni6DF9",249);
  build_kanji.lr(360,0)
    (kanji.leftrad.water)
    (kanji.grnine.suffocate);
  tsu_render;
endtsuglyph;

% shin/fuka "deep"
begintsuglyph("uni6DF1",241);
  kanji.grthree.deep;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
