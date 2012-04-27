%
% Unicode page 27 (Zapfian Dingbats) for Tsukurimashou
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

input latin-intro.mp;

% AUTODEPS
input enclosed.mp;
input numerals.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INVERTED CIRCLED NUMERALS

% 1
% BACKGROUND 25CF
begintsuglyph("uni2776",118);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.one);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 2
% BACKGROUND 25CF
begintsuglyph("uni2777",119);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.two);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 3
% BACKGROUND 25CF
begintsuglyph("uni2778",120);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.three);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 4
% BACKGROUND 25CF
begintsuglyph("uni2779",121);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.four);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 5
% BACKGROUND 25CF
begintsuglyph("uni277A",122);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.five);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 6
% BACKGROUND 25CF
begintsuglyph("uni277B",123);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.six);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 7
% BACKGROUND 25CF
begintsuglyph("uni277C",124);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.seven);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 8
% BACKGROUND 25CF
begintsuglyph("uni277D",125);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.eight);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 9
% BACKGROUND 25CF
begintsuglyph("uni277E",126);
  tsu_xform(tsu_xf.circled shifted tsu_xf.circ_slant_shift)(numeral.nine);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 10
% BACKGROUND 25CF
begintsuglyph("uni277F",127);
  tsu_xform(tsu_xf.ctwo.left shifted tsu_xf.circ_slant_shift)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right shifted tsu_xf.circ_slant_shift)(numeral.zero);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
