%
% TsuIta Atama
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

% TSUITA ATAMA

input preintro.mp;

stylename:="Atama";

(0,4) transformed tsu_brush_xf.brletter = (4,0.77);
(1,1) transformed tsu_brush_xf.brletter = (1,0.73);
(4,0) transformed tsu_brush_xf.brletter = (0,0.77);

tsu_brush_min.brletter:=0.73;
tsu_brush_max.brletter:=0.77;

def tsu_brush_opt(expr n,l) =
  if rescale_slant>10: cut(n,rel 90)(l) fi enddef;
def sharp_corners = (rescale_slant>10) enddef;

input intro.mp;

let old_rescale_half = tsu_rescale_half;

def tsu_rescale_half =
  old_rescale_half;
  width_curve:=((-1,-1)--(100,100))..(480,330)..{right}(2000,440);
enddef;

let old_rescale_half_lc = tsu_rescale_half_lc;

def tsu_rescale_half_lc =
  old_rescale_half_lc;
  width_curve:=((-1,-1)--(100,100))..(610,330)..{right}(2000,420);
enddef;

include_late("tsuita-common.mp");

% overridden per-page later
rescale_slant:=190;
