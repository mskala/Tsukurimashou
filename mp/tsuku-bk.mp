%
% Tsukurimashou Bokukko
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

% TSUKURIMASHOU BOKUKKO

input preintro.mp;

if stylename="": stylename:="Bokukko"; fi;

mincho:=0.3;

(0,4) transformed tsu_brush_xf.brletter = (0.8,0.95);
(1,1) transformed tsu_brush_xf.brletter = (1.02,0.80);
(4,0) transformed tsu_brush_xf.brletter = (3.8,0.95);

tsu_brush_min:=0.80;
tsu_brush_max:=0.95;
tsu_brush_shape:=0.3;
tsu_brush_angle:=20;

tsu_brush_xf.brpunct:=whatever_xf;
(0,4) transformed tsu_brush_xf.brpunct = (0,0.60);
(1,1) transformed tsu_brush_xf.brpunct = (1,0.10);
(4,0) transformed tsu_brush_xf.brpunct = (4,0.60);

tsu_brush_min.brpunct:=0.10;
tsu_brush_max.brpunct:=0.60;
tsu_brush_shape.brpunct:=0.3;
tsu_brush_angle.brpunct:=20;

def tsu_brush_opt(expr n,l) = cut(n,rel 120)(l) enddef;
sharp_corners:=true;

genji_outline:=true;
genji_hw:=0.55;

input intro.mp;
