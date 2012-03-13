%
% Tsukurimashou Kaku
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

% TSUKURIMASHOU KAKU

input preintro.mp;

stylename:="Kaku";

(0,4) transformed tsu_brush_xf = (4,0.75);
(1,1) transformed tsu_brush_xf = (1,0.62);
(4,0) transformed tsu_brush_xf = (0,0.75);

tsu_brush_min:=0.62;
tsu_brush_max:=0.75;

def tsu_brush_opt(expr n,l) = cut(n,rel 90)(l) enddef;
sharp_corners:=true;

input intro.mp;
