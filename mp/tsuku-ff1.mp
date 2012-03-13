%
% Unicode page FF1 (Fraction Denominators) for Tsukurimashou
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

% FRACTION DENOMINATORS

transform nxf[];

(frac.in.x1,frac.in.y1) transformed nxf1=(frac.one.x1,frac.one.y1);
(frac.in.x2,frac.in.y1) transformed nxf1=(frac.one.x2,frac.one.y1);
(frac.in.x1,frac.in.y2) transformed nxf1=(frac.one.x1,frac.one.y2);

(frac.in.x1,frac.in.y1) transformed nxf2=(frac.two.x1,frac.two.y1);
(frac.in.x2,frac.in.y1) transformed nxf2=(frac.two.x2,frac.two.y1);
(frac.in.x1,frac.in.y2) transformed nxf2=(frac.two.x1,frac.two.y2);
(frac.in.x1,frac.in.y1) transformed nxf3=(frac.two.x2,frac.two.y1);
(frac.in.x2,frac.in.y1) transformed nxf3=(frac.two.x3,frac.two.y1);
(frac.in.x1,frac.in.y2) transformed nxf3=(frac.two.x2,frac.two.y2);

(frac.in.x1,frac.in.y1) transformed nxf4=(frac.three.x1,frac.three.y1);
(frac.in.x2,frac.in.y1) transformed nxf4=(frac.three.x2,frac.three.y1);
(frac.in.x1,frac.in.y2) transformed nxf4=(frac.three.x1,frac.three.y2);
(frac.in.x1,frac.in.y1) transformed nxf5=(frac.three.x2,frac.three.y1);
(frac.in.x2,frac.in.y1) transformed nxf5=(frac.three.x3,frac.three.y1);
(frac.in.x1,frac.in.y2) transformed nxf5=(frac.three.x2,frac.three.y2);
(frac.in.x1,frac.in.y1) transformed nxf6=(frac.three.x3,frac.three.y1);
(frac.in.x2,frac.in.y1) transformed nxf6=(frac.three.x4,frac.three.y1);
(frac.in.x1,frac.in.y2) transformed nxf6=(frac.three.x3,frac.three.y2);

(frac.in.x1,frac.in.y1) transformed nxf7=(frac.four.x1,frac.four.y1);
(frac.in.x2,frac.in.y1) transformed nxf7=(frac.four.x2,frac.four.y1);
(frac.in.x1,frac.in.y2) transformed nxf7=(frac.four.x1,frac.four.y2);
(frac.in.x1,frac.in.y1) transformed nxf8=(frac.four.x2,frac.four.y1);
(frac.in.x2,frac.in.y1) transformed nxf8=(frac.four.x3,frac.four.y1);
(frac.in.x1,frac.in.y2) transformed nxf8=(frac.four.x2,frac.four.y2);
(frac.in.x1,frac.in.y1) transformed nxf9=(frac.four.x3,frac.four.y1);
(frac.in.x2,frac.in.y1) transformed nxf9=(frac.four.x4,frac.four.y1);
(frac.in.x1,frac.in.y2) transformed nxf9=(frac.four.x3,frac.four.y2);
(frac.in.x1,frac.in.y1) transformed nxf10=(frac.four.x4,frac.four.y1);
(frac.in.x2,frac.in.y1) transformed nxf10=(frac.four.x5,frac.four.y1);
(frac.in.x1,frac.in.y2) transformed nxf10=(frac.four.x4,frac.four.y2);

(frac.in.x1,frac.in.y1) transformed nxf11=(frac.half.x1,frac.half.y1);
(frac.in.x2,frac.in.y1) transformed nxf11=(frac.half.x2,frac.half.y1);
(frac.in.x1,frac.in.y2) transformed nxf11=(frac.half.x1,frac.half.y2);

tsu_rescale_full;
make_digit_set(nxf1,"1","1");

tsu_rescale_native_zero;
make_digit_set(nxf2,"1","2");
tsu_rescale_full;
make_digit_set(nxf3,"1","3");

tsu_rescale_native_zero;
make_digit_set(nxf4,"1","4");
make_digit_set(nxf5,"1","5");
tsu_rescale_full;
make_digit_set(nxf6,"1","6");

tsu_rescale_native_zero;
make_digit_set(nxf7,"1","7");
make_digit_set(nxf8,"1","8");
make_digit_set(nxf9,"1","9");
tsu_rescale_full;
make_digit_set(nxf10,"1","a");

tsu_rescale_native_narrow;
make_digit_set(nxf11,"1","b");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
