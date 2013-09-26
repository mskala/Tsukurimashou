%
% Early shared code for Tsukurimashou
% Copyright (C) 2011, 2012, 2013  Matthew Skala
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

% INFRASTRUCTURE

% When I say nonstopmode I mean nonstopmode, dammit!
nonstopmode;
def errorstopmode = nonstopmode enddef;

% no chars we don't define, please
no_implicit_spaces:=1;

% load library from METATYPE1
input fntbase.mp;

% file inclusion gatekeeper
vardef inclusion_lock(suffix fn) =
  if known already_included.fn:
    endinput;
  fi;
  boolean already_included.fn;
  already_included.fn:=true;
enddef;

% late inclusion
numeric late_include_count;
late_include_count:=0;
string late_include[];

vardef include_late(expr fn) =
  late_include_count:=late_include_count+1;
  late_include[late_include_count]:=fn;
enddef;

vardef do_late_includes =
  for i:=1 upto late_include_count:
    scantokens ("input " & late_include[i]);
  endfor;
  late_include_count:=0;
enddef;

def whatever_xf =
  begingroup
    save newxf;
    transform newxf;
    newxf
  endgroup
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FONT PARAMETER DEFAULTS

% framework for brush definitions
transform tsu_brush_xf[];
numeric tsu_brush_shape[];
numeric tsu_brush_angle[];
numeric tsu_brush_min[];
numeric tsu_brush_max[];

def brletter = 0 enddef;
def bralternate = 1 enddef;
def brpunct = 2 enddef;

% basic brush definition
% style MUST set tsu_brush_xf.brletter;
tsu_brush_shape.brletter:=1.0;
tsu_brush_angle.brletter:=0;
tsu_brush_min.brletter:=0.5;
tsu_brush_max.brletter:=1.0;

% alternate brush
(0,0) transformed tsu_brush_xf.bralternate=(1,1);
(0,1) transformed tsu_brush_xf.bralternate=(1,1);
(1,0) transformed tsu_brush_xf.bralternate=(1,1);
tsu_brush_shape.bralternate:=1.0;
tsu_brush_angle.bralternate:=0;
tsu_brush_min.bralternate:=0.5;
tsu_brush_max.bralternate:=0.5;

% punctuation brush
(0,4) transformed tsu_brush_xf.brpunct=(0,0.5);
(1,1) transformed tsu_brush_xf.brpunct=(1,0.1);
(4,0) transformed tsu_brush_xf.brpunct=(4,0.5);
tsu_brush_shape.brpunct:=1.0;
tsu_brush_angle.brpunct:=0;
tsu_brush_min.brpunct:=0.1;
tsu_brush_max.brpunct:=0.5;

% size for punctuation
tsu_punct_size:=100;

% size the handakuten
handakuten_inner:=120;
handakuten_outer:=200;

% general shape tweaker
mincho:=0;

% slant during rescaling, for italics
rescale_slant:=0;

% control appearance of corners
boolean sharp_corners;
sharp_corners:=false;

% for naming the font
if unknown familyname:
  string familyname,stylename;
  familyname:="Tsukurimashou";
  stylename:="";
fi;

% brush option override
def tsu_brush_opt(expr n,l) = nib(n)(l) enddef;

% bo_serif type; point lp; direction lp; brush tip size; brush code
vardef tsu_serif.choose(expr bst,plp,dlp,l,bts,bos,b) =
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

% prepare to detect italic hook shapes
boolean do_italic_hook;
do_italic_hook:=false;
