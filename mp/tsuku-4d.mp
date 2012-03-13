%
% Unicode page 4D (I Ching/Yijing) for Tsukurimashou
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

% AUTODEPS
input iching.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I CHING

vardef make_hexagram(expr i,la,lb,lc,ld,le,lf) =
  string hexname;
  hexname:=if i<10: "iching0" else: "iching" fi & decimal i;
  begintsuglyph(hexname,i+191);
    iching.line(1,6,la);
    iching.line(2,6,lb);
    iching.line(3,6,lc);
    iching.line(4,6,ld);
    iching.line(5,6,le);
    iching.line(6,6,lf);
    tsu_render;
  endtsuglyph;
enddef;

make_hexagram(1, 1,1,1,1,1,1);
make_hexagram(2, 0,0,0,0,0,0);
make_hexagram(3, 1,0,0,0,1,0);
make_hexagram(4, 0,1,0,0,0,1);
make_hexagram(5, 1,1,1,0,1,0);
make_hexagram(6, 0,1,0,1,1,1);
make_hexagram(7, 0,1,0,0,0,0);
make_hexagram(8, 0,0,0,0,1,0);
make_hexagram(9, 1,1,1,0,1,1);
make_hexagram(10,1,1,0,1,1,1);
make_hexagram(11,1,1,1,0,0,0);
make_hexagram(12,0,0,0,1,1,1);
make_hexagram(13,1,0,1,1,1,1);
make_hexagram(14,1,1,1,1,0,1);
make_hexagram(15,0,0,1,0,0,0);
make_hexagram(16,0,0,0,1,0,0);

make_hexagram(17,1,0,0,1,1,0);
make_hexagram(18,0,1,1,0,0,1);
make_hexagram(19,1,1,0,0,0,0);
make_hexagram(20,0,0,0,0,1,1);
make_hexagram(21,1,0,0,1,0,1);
make_hexagram(22,1,0,1,0,0,1);
make_hexagram(23,0,0,0,0,0,1);
make_hexagram(24,1,0,0,0,0,0);
make_hexagram(25,1,0,0,1,1,1);
make_hexagram(26,1,1,1,0,0,1);
make_hexagram(27,1,0,0,0,0,1);
make_hexagram(28,0,1,1,1,1,0);
make_hexagram(29,0,1,0,0,1,0);
make_hexagram(30,1,0,1,1,0,1);
make_hexagram(31,0,0,1,1,1,0);
make_hexagram(32,0,1,1,1,0,0);

make_hexagram(33,0,0,1,1,1,1);
make_hexagram(34,1,1,1,1,0,0);
make_hexagram(35,0,0,0,1,0,1);
make_hexagram(36,1,0,1,0,0,0);
make_hexagram(37,1,0,1,0,1,1);
make_hexagram(38,1,1,0,1,0,1);
make_hexagram(39,0,0,1,0,1,0);
make_hexagram(40,0,1,0,1,0,0);
make_hexagram(41,1,1,0,0,0,1);
make_hexagram(42,1,0,0,0,1,1);
make_hexagram(43,1,1,1,1,1,0);
make_hexagram(44,0,1,1,1,1,1);
make_hexagram(45,0,0,0,1,1,0);
make_hexagram(46,0,1,1,0,0,0);
make_hexagram(47,0,1,0,1,1,0);
make_hexagram(48,0,1,1,0,1,0);

make_hexagram(49,1,0,1,1,1,0);
make_hexagram(50,0,1,1,1,0,1);
make_hexagram(51,1,0,0,1,0,0);
make_hexagram(52,0,0,1,0,0,1);
make_hexagram(53,0,0,1,0,1,1);
make_hexagram(54,1,1,0,1,0,0);
make_hexagram(55,1,0,1,1,0,0);
make_hexagram(56,0,0,1,1,0,1);
make_hexagram(57,0,1,1,0,1,1);
make_hexagram(58,1,1,0,1,1,0);
make_hexagram(59,0,1,0,0,1,1);
make_hexagram(60,1,1,0,0,1,0);
make_hexagram(61,1,1,0,0,1,1);
make_hexagram(62,0,0,1,1,0,0);
make_hexagram(63,1,0,1,0,1,0);
make_hexagram(64,0,1,0,1,0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
