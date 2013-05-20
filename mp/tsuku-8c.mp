%
% Unicode page 8C (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013  Matthew Skala
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

vardef kanji.grtwo.buy =
  push_pbox_toexpand("kanji.grtwo.buy");
  build_kanji.level(build_kanji.tb(610,0)
    (kanji.toprad.eye)
    (kanji.grone.shell));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.undertake =
  push_pbox_toexpand("kanji.grthree.undertake");
  build_kanji.attach_fishhook(0.77)(kanji.grone.shell);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.elephant =
  push_pbox_toexpand("kanji.grfour.elephant");
  build_kanji.attach_fishhook(0.8)
    (build_kanji.level(build_kanji.tb(580,140)
       (kanji.grone.mouth)
       (kanji.radical.pig);
     replace_strokep(-6)((point 1.5 of get_strokep(-8))
         --(point 0.5 of get_strokep(-7)));
     replace_strokeq(-6)((1.5,1.5)--(1.4,1.4))));
  expand_pbox;
enddef;

vardef kanji.grfour.freight =
  push_pbox_toexpand("kanji.grfour.freight");
  build_kanji.level(build_kanji.tb(560,-50)
    (kanji.grthree.change)
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfour.prize =
  push_pbox_toexpand("kanji.grfour.prize");
  build_kanji.level(build_kanji.tb(460,-10)
    (build_kanji.sscale(xscaled 0.87)(kanji.toprad.ridiculous_hat))
    (kanji.grone.shell));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.fortune =
  push_pbox_toexpand("kanji.grfive.fortune");
  build_kanji.level(build_kanji.lr(480,0)
    (kanji.grone.shell)
    (kanji.rightrad.genius));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% koku/tani "valley"
begintsuglyph("uni8C37",55);
  kanji.grtwo.valley;
  tsu_render;
endtsuglyph;

% tou/mame "bean"
begintsuglyph("uni8C46",70);
  kanji.grthree.bean;
  tsu_render;
endtsuglyph;

% inoko "pig" radical
begintsuglyph("uni8C55",85);
  kanji.radical.pig;
  tsu_render;
endtsuglyph;

% shou/katado "elephant" or "to imitate"
begintsuglyph("uni8C61",97);
  kanji.grfour.elephant;
  tsu_render;
endtsuglyph;

% bai/kai "shellfish"
begintsuglyph("uni8C9D",157);
  kanji.grone.shell;
  tsu_render;
endtsuglyph;

% fu/ma "undertake"
begintsuglyph("uni8CA0",160);
  kanji.grthree.undertake;
  tsu_render;
endtsuglyph;

% zai/takara "fortune"
begintsuglyph("uni8CA1",161);
  kanji.grfive.fortune;
  tsu_render;
endtsuglyph;

% ka/takara "freight"
begintsuglyph("uni8CA8",168);
  kanji.grfour.freight;
  tsu_render;
endtsuglyph;

% seki/se "blame"
begintsuglyph("uni8CAC",172);
  kanji.grfive.blame;
  tsu_render;
endtsuglyph;

% gai/ka "buy"
begintsuglyph("uni8CB7",183);
  kanji.grtwo.buy;
  tsu_render;
endtsuglyph;

% fun "decorate" (needed for greight.indignation)
begintsuglyph("uni8CC1",193);
  kanji.rare.decorate;
  tsu_render;
endtsuglyph;

% shuu/ho "prize"
begintsuglyph("uni8CDE",222);
  kanji.grfour.prize;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
