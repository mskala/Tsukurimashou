%
% Unicode page 02 (Spacing Modifier Letters) for Tsukurimashou
% Copyright (C) 2011, 2012  Matthew Skala
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

beginfont

input latin-intro.mp;

% AUTODEPS
input accent.mp;
input latin.mp;
input ogonek.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SPACING MODIFIER LETTERS

tsu_rescale_half;

% circumflex accent
begintsuglyph("circumflex",198);
  tsu_accent.circumflex;
  tsu_render;
endtsuglyph;

% caron
begintsuglyph("caron",199);
  tsu_accent.caron;
  tsu_render;
endtsuglyph;

% breve
begintsuglyph("breve",216);
  tsu_accent.breve;
  tsu_render;
endtsuglyph;

% dot above
begintsuglyph("dotaccent",217);
  tsu_accent.dotabove;
  tsu_render;
endtsuglyph;

% ring above
begintsuglyph("ring",218);
  tsu_accent.ringabove;
  tsu_render;
endtsuglyph;

% ogonek
begintsuglyph("ogonek",219);
  latin.loweogonek;
  set_bosize(-1,0);
  tsu_render;
endtsuglyph;

% small tilde
begintsuglyph("tilde",220);
  tsu_accent.tilde;
  tsu_render;
endtsuglyph;

% double acute accent
begintsuglyph("hungarumlaut",221);
  tsu_accent.hungarian_umlaut;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
