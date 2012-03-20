%
% Unicode page 8C (Kanji) for Tsukurimashou
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
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input radical.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.buy =
  push_pbox_toexpand("kanji.grtwo.buy");
  build_kanji.level(build_kanji.tb(610,0)
    (begingroup
       save x,y;
       numeric x[],y[];
       x1=x5=130;
       x2=x6=0.333[x1,x4];
       x3=x7=0.667[x1,x4];
       x4=x8=1000-x1;
       y1=y2=y3=y4=700;
       y5=y6=y7=y8=120;
       build_kanji.box(z1,z8);
       push_stroke(z2--z6,(1.6,1.6)--(1.5,1.5));
       push_stroke(z3--z7,(1.6,1.6)--(1.5,1.5));
     endgroup)
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

% bai/kai "shellfish"
begintsuglyph("uni8C9D",157);
  kanji.grone.shell;
  tsu_render;
endtsuglyph;

% fu/ma "undertake
begintsuglyph("uni8CA0",160);
  kanji.grthree.undertake;
  tsu_render;
endtsuglyph;

% gai/ka "buy"
begintsuglyph("uni8CB7",183);
  kanji.grtwo.buy;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
