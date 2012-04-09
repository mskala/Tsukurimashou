%
% TsuIta Soku
% Copyright (C) 2012  Matthew Skala
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

% TSUITA SOKU

input preintro.mp;

familyname:="TsuIta";
stylename:="Soku";

mincho:=0.8;

rescale_slant:=170;

(0,4) transformed tsu_brush_xf = (0.0,0.80);
(1,1) transformed tsu_brush_xf = (1.2,0.45);
(4,0) transformed tsu_brush_xf = (4.8,0.80);

tsu_brush_min:=0.45;
tsu_brush_max:=0.80;

tsu_brush_shape:=0.60;
tsu_brush_angle:=1;

tsu_pbrush_size:=60;
tsu_pbrush_shape:=1;
tsu_pbrush_angle:=1;

input serif.mp;

for i=1 upto 10:
  tsu_do_serif[i]:=true;
endfor;

do_alternation:=true;

genji_outline:=true;
genji_hw:=0.2;

input intro.mp;
