%
% Bold font weight
% Copyright (C) 2012, 2013  Matthew Skala
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

% BOLD WEIGHT

transform weight_xf;
(0,0.62) transformed weight_xf = (0,1.082);
(1,0.62) transformed weight_xf = (1,1.082);
(0,0.75) transformed weight_xf = (0,1.191);

tsu_brush_xf.brletter:=
  tsu_brush_xf.brletter transformed weight_xf;
tsu_brush_min.brletter:=
  ypart ((0,tsu_brush_min.brletter) transformed weight_xf);
tsu_brush_max.brletter:=
  ypart ((0,tsu_brush_max.brletter) transformed weight_xf);

tsu_brush_xf.bralternate:=tsu_brush_xf.bralternate yscaled (1.191/0.75);
tsu_brush_min.bralternate:=tsu_brush_min.bralternate*(1.191/0.75);
tsu_brush_max.bralternate:=tsu_brush_max.bralternate*(1.191/0.75);

tsu_brush_xf.brpunct:=tsu_brush_xf.brpunct yscaled 1.15;
tsu_punct_size:=120;

handakuten_outer:=260;

calc_mbrush_size;
