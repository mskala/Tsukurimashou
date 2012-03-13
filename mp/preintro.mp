%
% Early shared code for Tsukurimashou
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

% TSUKURIMASHOU PRE-INTRO

% When I say nonstopmode I mean nonstopmode, dammit!
nonstopmode;
def errorstopmode = nonstopmode enddef;

% load library
input type1.mp;

% file inclusion gatekeeper
vardef inclusion_lock(suffix fn) =
  if known already_included.fn:
    endinput;
  fi;
  boolean already_included.fn;
  already_included.fn:=true;
enddef;

% basic brush definition
transform tsu_brush_xf;
tsu_brush_shape:=1.0;
tsu_brush_angle:=0;

% special brush for punctuation
tsu_pbrush_size:=50;
tsu_pbrush_shape:=1.0;
tsu_pbrush_angle:=0;
tsu_punct_size:=100;

% size the handakuten
handakuten_inner:=120;
handakuten_outer:=200;

% general shape tweaker
mincho:=0;

% control appearance of corners
boolean sharp_corners;
sharp_corners:=false;

% for naming the font
string stylename;
stylename:="";

% brush option override
def tsu_brush_opt(expr n,l) = nib(n)(l) enddef;

% bo_serif type; point lp; direction lp; brush tip size
vardef tsu_serif.choose(expr bst,plp,dlp,l,bts,bos) =
enddef;

% do "modern" width alternation
boolean do_alternation;
do_alternation:=false;

% handle outline mode for Genjimon
boolean genji_outline;
genji_outline:=false;

% prepare to detect proportional spacing
boolean is_proportional;
is_proportional:=false;

% prepare to detect blackletter
boolean is_blackletter;
is_blackletter:=false;

% prepare to detect fine IDCs
boolean fine_idcs;
fine_idcs:=false;
