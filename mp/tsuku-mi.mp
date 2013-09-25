%
% Tsukurimashou Mincho
% Copyright (C) 2011, 2013  Matthew Skala
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

% TSUKURIMASHOU MINCHO

input preintro.mp;

stylename:="Mincho";

mincho:=1;

(0,4) transformed tsu_brush_xf.brletter = (0.0,1.1);
(1,1) transformed tsu_brush_xf.brletter = (1.2,0.35);
(4,0) transformed tsu_brush_xf.brletter = (4.8,1.1);

tsu_brush_min.brletter:=0.35;
tsu_brush_max.brletter:=1.05;
tsu_brush_shape.brletter:=0.38;
tsu_brush_angle.brletter:=1;

tsu_brush_xf.bralternate:=identity xyscaled (1.2,0) shifted (0,0.315);
tsu_brush_min.bralternate:=0.315;
tsu_brush_max.bralternate:=0.315;
tsu_brush_shape.bralternate:=1;
tsu_brush_angle.bralternate:=0;

tsu_brush_min.brpunct:=0.117;
tsu_brush_max.brpunct:=0.60;
tsu_brush_shape.brpunct:=1;
tsu_brush_angle.brpunct:=1;

input serif.mp;

for i=1 upto 10:
  tsu_do_serif[i]:=true;
endfor;

do_alternation:=true;

genji_outline:=true;
genji_hw:=0.2;

input intro.mp;
