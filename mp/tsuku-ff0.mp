%
% Unicode page FF0 (Fraction Numerators) for Tsukurimashou
% Copyright (C) 2011  Matthew Skala
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
input numerals.mp;
input frac-intro.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FRACTION NUMERATORS

transform nxf[];

(frac.in.x1,frac.in.y1) transformed nxf1=(frac.one.x1,frac.one.y4);
(frac.in.x2,frac.in.y1) transformed nxf1=(frac.one.x2,frac.one.y4);
(frac.in.x1,frac.in.y2) transformed nxf1=(frac.one.x1,frac.one.y5);

(frac.in.x1,frac.in.y1) transformed nxf2=(frac.two.x1,frac.two.y4);
(frac.in.x2,frac.in.y1) transformed nxf2=(frac.two.x2,frac.two.y4);
(frac.in.x1,frac.in.y2) transformed nxf2=(frac.two.x1,frac.two.y5);
(frac.in.x1,frac.in.y1) transformed nxf3=(frac.two.x2,frac.two.y4);
(frac.in.x2,frac.in.y1) transformed nxf3=(frac.two.x3,frac.two.y4);
(frac.in.x1,frac.in.y2) transformed nxf3=(frac.two.x2,frac.two.y5);

(frac.in.x1,frac.in.y1) transformed nxf4=(frac.three.x1,frac.three.y4);
(frac.in.x2,frac.in.y1) transformed nxf4=(frac.three.x2,frac.three.y4);
(frac.in.x1,frac.in.y2) transformed nxf4=(frac.three.x1,frac.three.y5);
(frac.in.x1,frac.in.y1) transformed nxf5=(frac.three.x2,frac.three.y4);
(frac.in.x2,frac.in.y1) transformed nxf5=(frac.three.x3,frac.three.y4);
(frac.in.x1,frac.in.y2) transformed nxf5=(frac.three.x2,frac.three.y5);
(frac.in.x1,frac.in.y1) transformed nxf6=(frac.three.x3,frac.three.y4);
(frac.in.x2,frac.in.y1) transformed nxf6=(frac.three.x4,frac.three.y4);
(frac.in.x1,frac.in.y2) transformed nxf6=(frac.three.x3,frac.three.y5);

(frac.in.x1,frac.in.y1) transformed nxf7=(frac.four.x1,frac.four.y4);
(frac.in.x2,frac.in.y1) transformed nxf7=(frac.four.x2,frac.four.y4);
(frac.in.x1,frac.in.y2) transformed nxf7=(frac.four.x1,frac.four.y5);
(frac.in.x1,frac.in.y1) transformed nxf8=(frac.four.x2,frac.four.y4);
(frac.in.x2,frac.in.y1) transformed nxf8=(frac.four.x3,frac.four.y4);
(frac.in.x1,frac.in.y2) transformed nxf8=(frac.four.x2,frac.four.y5);
(frac.in.x1,frac.in.y1) transformed nxf9=(frac.four.x3,frac.four.y4);
(frac.in.x2,frac.in.y1) transformed nxf9=(frac.four.x4,frac.four.y4);
(frac.in.x1,frac.in.y2) transformed nxf9=(frac.four.x3,frac.four.y5);
(frac.in.x1,frac.in.y1) transformed nxf10=(frac.four.x4,frac.four.y4);
(frac.in.x2,frac.in.y1) transformed nxf10=(frac.four.x5,frac.four.y4);
(frac.in.x1,frac.in.y2) transformed nxf10=(frac.four.x4,frac.four.y5);

(frac.in.x1,frac.in.y1) transformed nxf11=(frac.half.x1,frac.half.y4);
(frac.in.x2,frac.in.y1) transformed nxf11=(frac.half.x2,frac.half.y4);
(frac.in.x1,frac.in.y2) transformed nxf11=(frac.half.x1,frac.half.y5);

tsu_rescale_native_zero;

begintsuglyph("fraction.1",1);
  push_stroke(((-0.25)[(frac.one.x1,frac.one.y3),(frac.one.x2,frac.one.y3)])
      --(1.25[(frac.one.x1,frac.one.y3),(frac.one.x2,frac.one.y3)]),
    (2,2)--(2,2));
  set_bosize(0,60);
  tsu_render;
endtsuglyph;

begintsuglyph("fraction.2",2);
  push_stroke(((-0.07)[(frac.two.x1,frac.two.y3),(frac.two.x3,frac.two.y3)])
      --(1.07[(frac.two.x1,frac.two.y3),(frac.two.x3,frac.two.y3)]),
    (2,2)--(2,2));
  set_bosize(0,60);
  tsu_render;
endtsuglyph;

begintsuglyph("fraction.3",3);
  push_stroke((frac.three.x1,frac.three.y3)--(frac.three.x4,frac.three.y3),
    (2,2)--(2,2));
  set_bosize(0,55);
  tsu_render;
endtsuglyph;

begintsuglyph("fraction.4",4);
  push_stroke((0.03[(frac.four.x1,frac.four.y3),(frac.four.x5,frac.four.y3)])
      --(0.97[(frac.four.x1,frac.four.y3),(frac.four.x5,frac.four.y3)]),
    (2,2)--(2,2));
  set_bosize(0,50);
  tsu_render;
endtsuglyph;

begintsuglyph("fraction.latn",5);
  push_stroke(
    ((-0.15)[(frac.half.x1,frac.half.y3),(frac.half.x2,frac.half.y3)])
      --(1.15[(frac.half.x1,frac.half.y3),(frac.half.x2,frac.half.y3)]),
    (2,2)--(2,2));
  set_bosize(0,60);
  tsu_render;
endtsuglyph;

make_digit_set(nxf1,"0","1");

make_digit_set(nxf2,"0","2");
make_digit_set(nxf3,"0","3");

make_digit_set(nxf4,"0","4");
make_digit_set(nxf5,"0","5");
make_digit_set(nxf6,"0","6");

make_digit_set(nxf7,"0","7");
make_digit_set(nxf8,"0","8");
make_digit_set(nxf9,"0","9");
make_digit_set(nxf10,"0","a");

make_digit_set(nxf11,"0","b");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
