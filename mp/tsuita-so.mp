%
% TsuIta Soku
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

% TSUITA SOKU

input preintro.mp;

familyname:="TsuIta";
stylename:="Soku";

mincho:=0.8;

(0,4) transformed tsu_brush_xf.brletter = (0.0,0.80);
(1,1) transformed tsu_brush_xf.brletter = (1.2,0.45);
(4,0) transformed tsu_brush_xf.brletter = (4.8,0.80);

tsu_brush_min.brletter:=0.45;
tsu_brush_max.brletter:=0.80;
tsu_brush_shape.brletter:=0.60;
tsu_brush_angle.brletter:=1;

tsu_brush_xf.bralternate:=identity xyscaled (1.2,0) shifted (0,0.48);
tsu_brush_min.bralternate:=0.48;
tsu_brush_max.bralternate:=0.48;
tsu_brush_shape.bralternate:=1;
tsu_brush_angle.bralternate:=0;

tsu_brush_xf.brpunct:=whatever_xf;
(0,4) transformed tsu_brush_xf.brpunct = (0,0.45);
(1,1) transformed tsu_brush_xf.brpunct = (1,0.10);
(4,0) transformed tsu_brush_xf.brpunct = (4,0.45);

tsu_brush_min.brpunct:=0.10;
tsu_brush_max.brpunct:=0.45;
tsu_brush_shape.brpunct:=1;
tsu_brush_angle.brpunct:=0;

input serif.mp;

tsu_do_serif[1]:=true;
tsu_do_serif[2]:=true;
tsu_do_serif[3]:=true;

do_alternation:=true;

genji_outline:=true;

input intro.mp;

let old_render_segment = tsu_render_segment;

def tsu_render_segment(expr i,p,q,b) =
  begingroup
    save start_time,end_time;
    numeric start_time,end_time;
  endgroup;
  old_render_segment(i,p,q,b);
enddef;

let old_rescale_half = tsu_rescale_half;

def tsu_rescale_half =
  old_rescale_half;
  width_curve:=((-1,-1)--(100,100))..(560,310)..{right}(2000,400);
enddef;

let old_rescale_half_lc = tsu_rescale_half_lc;

def tsu_rescale_half_lc =
  old_rescale_half_lc;
  width_curve:=((-1,-1)--(100,100))..(610,310)..{right}(2000,400);
enddef;

do_italic_hook:=true;
italic_hook_radius:=170;
italic_hook_dir:=25;

include_late("tsuita-common.mp");

% overridden per-page later
rescale_slant:=190;
