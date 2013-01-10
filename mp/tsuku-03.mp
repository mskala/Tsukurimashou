%
% Unicode page 03 (Combining Diacritical Marks) for Tsukurimashou
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

beginfont

input latin-intro.mp;

% AUTODEPS
input accent.mp;
input punct.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% COMBINING DIACRITICAL MARKS

tsu_rescale_combining_accent;

% grave accent
begintsuglyph("gravecomb",0);
  tsu_accent.apply()(tsu_accent.grave);
  push_anchor(-anc_grave,accent_default[anc_grave]);
  tsu_render;
endtsuglyph;

% acute accent
begintsuglyph("acutecomb",1);
  tsu_accent.apply()(tsu_accent.acute);
  push_anchor(-anc_acute,accent_default[anc_acute]);
  tsu_render;
endtsuglyph;

% circumflex accent
begintsuglyph("uni0302",2);
  tsu_accent.apply()(tsu_accent.circumflex);
  push_anchor(-anc_wide,accent_default[anc_wide]);
  tsu_render;
endtsuglyph;

% tilde accent
begintsuglyph("tildecomb",3);
  tsu_accent.apply()(tsu_accent.tilde);
  push_anchor(-anc_tilde,accent_default[anc_tilde]);
  tsu_render;
endtsuglyph;

% macron
begintsuglyph("uni0304",4);
  tsu_accent.apply()(tsu_accent.macron);
  push_anchor(-anc_wide,accent_default[anc_wide]);
  tsu_render;
endtsuglyph;

% breve
begintsuglyph("uni0306",6);
  tsu_accent.apply()(tsu_accent.breve);
  push_anchor(-anc_wide,accent_default[anc_wide]);
  tsu_render;
endtsuglyph;

% dot above
begintsuglyph("uni0307",7);
  tsu_accent.apply()(tsu_accent.dotabove);
  push_anchor(-anc_upper,accent_default[anc_upper]);
  tsu_render;
endtsuglyph;

% umlaut/diaeresis
begintsuglyph("uni0308",8);
  tsu_accent.apply()(tsu_accent.umlaut);
  push_anchor(-anc_wide,accent_default[anc_wide]);
  tsu_render;
endtsuglyph;

% 0309;hookabovecomb;COMBINING HOOK ABOVE

% ring above
begintsuglyph("uni030A",10);
  tsu_accent.apply()(tsu_accent.ringabove);
  push_anchor(-anc_ring,accent_default[anc_ring]);
  tsu_render;
endtsuglyph;

% double acute/hungarian umlaut
begintsuglyph("uni030B",11);
  tsu_accent.apply()(tsu_accent.hungarian_umlaut);
  push_anchor(-anc_wide,accent_default[anc_wide]);
  tsu_render;
endtsuglyph;

% caron/hacek
begintsuglyph("uni030C",12);
  tsu_accent.apply()(tsu_accent.caron);
  push_anchor(-anc_wide,accent_default[anc_wide]);
  tsu_render;
endtsuglyph;

% dot below
begintsuglyph("dotbelowcomb",35);
  tsu_accent.apply()(tsu_accent.dotbelow);
  push_anchor(-anc_lower,accent_default[anc_lower]);
  tsu_render;
endtsuglyph;

% comma below
begintsuglyph("uni0326",38);
  tsu_accent.apply()(tsu_accent.commabelow);
  push_anchor(-anc_lower,accent_default[anc_lower]);
  tsu_render;
endtsuglyph;

% cedilla
begintsuglyph("uni0327",39);
  tsu_accent.apply()(tsu_accent.cedilla);
  push_anchor(-anc_lower_connect,accent_default[anc_lower_connect]);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
