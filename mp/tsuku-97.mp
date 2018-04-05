%
% Unicode page 97 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2017  Matthew Skala
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
input gradefive.mp;
input gradefour.mp;
input gradeone.mp;
input gradethree.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.spirit =
  push_pbox_toexpand("kanji.greight.spirit");
  build_kanji.level(build_kanji.tb(300,50)
    (kanji.toprad.rain)
    (build_kanji.tb(420,115)
       (kanji.grone.two)
       (kanji.rare.obscure_grass_toprad;
        set_boserif(-3,0,whatever);
        set_boserif(-2,0,whatever))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.quiet =
  push_pbox_toexpand("kanji.grfour.quiet");
  build_kanji.lr(460,-40)
    (kanji.grone.blue)
    (kanji.grfour.dispute);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% rei/tama "spirit"
begintsuglyph("uni970A",10);
  kanji.greight.spirit;
  tsu_render;
endtsuglyph;

% ao "blue"
begintsuglyph("uni9752",82);
  kanji.grone.blue;
  tsu_render;
endtsuglyph;

% sei/shizu "quiet"
begintsuglyph("uni9759",89);
  kanji.grfour.quiet;
  tsu_render;
endtsuglyph;

% hi/ara "mistake"
begintsuglyph("uni975E",94);
  kanji.grfive.mistake;
  tsu_render;
endtsuglyph;

% men/omo "face"
begintsuglyph("uni9762",98);
  kanji.grthree.face;
  tsu_render;
endtsuglyph;

% i/somu "tanned leather radical"
begintsuglyph("uni97CB",203);
  kanji.radical.tanned_leather;
  tsu_render;
endtsuglyph;

% oto/on "noise"
begintsuglyph("uni97F3",243);
  kanji.grone.noise;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
