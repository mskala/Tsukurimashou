%
% Unicode page 50 (Kanji) for Tsukurimashou
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
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.double =
  push_pbox_toexpand("kanji.grthree.double");
  build_kanji.lr(360,-30)
    (kanji.leftrad.person)
    (build_kanji.tb(340,-60+20*mincho)
       (kanji.toprad.stand_up)
       (kanji.grone.mouth));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.borrow =
  push_pbox_toexpand("kanji.grfour.borrow");
  build_kanji.lr(320,20)
    (kanji.leftrad.person)
    (kanji.grthree.once_upon_a_time);
  expand_pbox;
enddef;

vardef kanji.grfour.halt =
  push_pbox_toexpand("kanji.grfour.halt");
  build_kanji.lr(280,0)
    (kanji.leftrad.person)
    (kanji.greight.head_of_household);
  expand_pbox;
enddef;

vardef kanji.grfour.healthy =
  push_pbox_toexpand("kanji.grfour.healthy");
  build_kanji.lr(260,0)
    (kanji.leftrad.person)
    (build_kanji.sscale(scaled 0.94)(kanji.grfour.build));
  expand_pbox;
enddef;

vardef kanji.grfour.side =
  push_pbox_toexpand("kanji.grfour.side");
  build_kanji.lr(280,0)
    (kanji.leftrad.person)
    (kanji.grfive.conform);
  expand_pbox;
enddef;

vardef kanji.grfour.warehouse =
  push_pbox_toexpand("kanji.grfour.warehouse");
  build_kanji.level(build_kanji.tb(400,320)
    (kanji.radical.tent)
    (build_kanji.sscale(xscaled 0.84)(kanji.radical.moon_flag);
     build_kanji.box((320,210),(810,-10))));
  expand_pbox;
enddef;

vardef kanji.grfour.work =
  push_pbox_toexpand("kanji.grfour.work");
  build_kanji.lr(260,0)
    (kanji.leftrad.person)
    (kanji.grthree.motion);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.individual =
  push_pbox_toexpand("kanji.grfive.individual");
  build_kanji.lr(280,-50)
    (kanji.leftrad.person)
    (build_kanji.sscale(scaled 0.87)(kanji.grfour.hard));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.manservant =
  push_pbox_toexpand("kanji.greight.manservant");
  build_kanji.lr(300,-40*mincho)
    (kanji.leftrad.person)
    (kanji.rare.eight_three_dee_zero);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sou/kura "warehouse"
begintsuglyph("uni5009",9);
  kanji.grfour.warehouse;
  tsu_render;
endtsuglyph;

% ko "individual" or "counter for things"
begintsuglyph("uni500B",11);
  kanji.grfive.individual;
  tsu_render;
endtsuglyph;

% bai/be "double"
begintsuglyph("uni500D",13);
  kanji.grthree.double;
  tsu_render;
endtsuglyph;

% shaku/ka "borrow"
begintsuglyph("uni501F",31);
  kanji.grfour.borrow;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5058",88);
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grthree.goods);
  tsu_render;
endtsuglyph;

% tei/to "halt"
begintsuglyph("uni505C",92);
  kanji.grfour.halt;
  tsu_render;
endtsuglyph;

% ken/shita "healthy"
begintsuglyph("uni5065",101);
  kanji.grfour.healthy;
  tsu_render;
endtsuglyph;

% soku/kawa "side"
begintsuglyph("uni5074",116);
  kanji.grfour.side;
  tsu_render;
endtsuglyph;

% dou/hatara "work"
begintsuglyph("uni50CD",205);
  kanji.grfour.work;
  tsu_render;
endtsuglyph;

% boku/shimobe "masculine first-person pronoun" (or "servant")
begintsuglyph("uni50D5",213);
  kanji.greight.manservant;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
