%
% Unicode page 88 (Kanji) for Tsukurimashou
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
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.blood =
  push_pbox_toexpand("kanji.grthree.blood");
  build_kanji.attach_tick(620)(kanji.grthree.dish);
  expand_pbox;
enddef;

vardef kanji.grthree.surface =
  push_pbox_toexpand("kanji.grthree.surface");
  build_kanji.level(build_kanji.tb(400,60)
    (kanji.toprad.blue)
    (push_stroke((470,810)..tension 1.2..(340,650)..(80,510),
       (1.7,1.7)--(1.5,1.5)--(1,1));
     push_stroke((point 1 of get_strokep(0))--
         (xpart point 1 of get_strokep(0),0),
       (1.5,1.5)--(1.4,1.4));
     push_stroke((510,80)..tension 1.2..(point 1 of get_strokep(0))..(130,-40),
       (1,1)--(1.4,1.4)--(1.8,1.8));
     push_stroke((540,810)..tension 1.2..(700,240)..(890,0),
       (1,1)--(1.4,1.4)--(1.7,1.7));
     push_stroke((820,540)..tension 1.2..(720,460)..
         (point 0.69 of get_strokep(0)),
       (1.7,1.7)--(1.4,1.4)--(1.2,1.2))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ketsu/chi "blood"
begintsuglyph("uni8840",64);
  kanji.grthree.blood;
  tsu_render;
endtsuglyph;

% kou/i(ku) "go"
begintsuglyph("uni884C",76);
  kanji.grtwo.go;
  tsu_render;
endtsuglyph;

% hyou/omote "surface"
begintsuglyph("uni8868",104);
  kanji.grthree.surface;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
