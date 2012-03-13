%
% Common code for Tsukurimashou fractions
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

inclusion_lock(fracintro);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

transform nxf[];

frac.in.x1=200;
frac.in.x2=800;
frac.in.y1=latin_wide_baseline;
frac.in.y2=latin_wide_top;

frac.one.y1=0.02[frac.in.y1,frac.in.y2];
frac.one.y2=0.40[frac.in.y1,frac.in.y2];
frac.one.y3=0.51[frac.in.y1,frac.in.y2];
frac.one.y4=0.60[frac.in.y1,frac.in.y2];
frac.one.y5=0.98[frac.in.y1,frac.in.y2];

(frac.one.x1+frac.one.x2)/2=500;
frac.one.x2-frac.one.x1=320;

frac.two.y1=0.04[frac.in.y1,frac.in.y2];
frac.two.y2=0.38[frac.in.y1,frac.in.y2];
frac.two.y3=0.51[frac.in.y1,frac.in.y2];
frac.two.y4=0.62[frac.in.y1,frac.in.y2];
frac.two.y5=0.96[frac.in.y1,frac.in.y2];

(frac.two.x1+frac.two.x3)/2=500;
(frac.two.x3-frac.two.x2)=
  (frac.two.x2-frac.two.x1);
frac.two.x3-frac.two.x1=600;

frac.three.y1=0.06[frac.in.y1,frac.in.y2];
frac.three.y2=0.36[frac.in.y1,frac.in.y2];
frac.three.y3=0.51[frac.in.y1,frac.in.y2];
frac.three.y4=0.64[frac.in.y1,frac.in.y2];
frac.three.y5=0.94[frac.in.y1,frac.in.y2];

(frac.three.x1+frac.three.x4)/2=500;
(frac.three.x4-frac.three.x3)=
  (frac.three.x3-frac.three.x2)=
  (frac.three.x2-frac.three.x1);
frac.three.x4-frac.three.x1=700;

frac.four.y1=0.08[frac.in.y1,frac.in.y2];
frac.four.y2=0.34[frac.in.y1,frac.in.y2];
frac.four.y3=0.51[frac.in.y1,frac.in.y2];
frac.four.y4=0.66[frac.in.y1,frac.in.y2];
frac.four.y5=0.92[frac.in.y1,frac.in.y2];

(frac.four.x1+frac.four.x5)/2=500;
(frac.four.x5-frac.four.x4)=
  (frac.four.x4-frac.four.x3)=
  (frac.four.x3-frac.four.x2)=
  (frac.four.x2-frac.four.x1);
frac.four.x5-frac.four.x1=800;

frac.half.y1=0.10*latin_vcentre;
frac.half.y2=0.82*latin_vcentre;
frac.half.y3=latin_vcentre;
frac.half.y4=1.18*latin_vcentre;
frac.half.y5=1.90*latin_vcentre;

(frac.half.x1+frac.half.x2)/2=250;
frac.half.x2-frac.half.x1=330;

vardef hexdig(expr d) =
  if d<10: decimal d else: char (d+87) fi
enddef;

vardef make_digit_set(expr xfm,thispage,place) =
  numeric ccount;
  ccount:=0;
  forsuffixes i=zero,one,two,three,four,five,six,seven,eight,nine:
    begintsuglyph("uFF" & thispage & place & hexdig(ccount),
        hex(place & hexdig(ccount)));
      tsu_xform(xfm)(numeral.i);
      tsu_render;
    endtsuglyph;
    ccount:=ccount+1;
  endfor;
enddef;
