%
% Unicode page 21 (Symbols) for Tsukurimashou
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
input latin.mp;
input punct.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SYMBOLS REQUIRED BY MES-1

% WARNING changing rescale setting
tsu_rescale_half;

% trademark symbol
begintsuglyph("trademark",34);
  tsu_xform(identity scaled 0.5 shifted (0,400))(latin.upt);
  numeric x[],y[];
  tsu_xform(identity scaled 0.5 shifted (500,400))(latin.upm);
  tsu_render;
endtsuglyph;

% ohm (resistance unit) symbol
begintsuglyph("uni2126",38);
  punct.ohm;
  tsu_render;
endtsuglyph;

% Note: 0x5B through 0x5E, which are x/8 fractions, are assembled by the
% assemble-font script

% WARNING changing rescale setting
tsu_rescale_full;

vardef arrow(expr rot) =
  push_stroke(((-4,0)--(3.99,0))
      scaled tsu_punct_size rotated rot shifted centre_pt,
    (1.6,1.6)--(1.6,1.6));
  set_bobrush(0,bralternate);
  set_bosize(0,80);
  push_stroke(((2,2)..((3,1)+(0.2*mincho*(-1,-1)))..
      {curl 1}(4,0){curl 1}..
      ((3,-1)+(0.2*mincho*(-1,1)))..(2,-2))
      xyscaled (1,1-0.4*mincho)
      scaled tsu_punct_size rotated rot shifted centre_pt,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,2,1);
  set_bobrush(0,bralternate);
  set_bosize(0,80);
enddef;

begintsuglyph("arrowleft",144);
  arrow(180);
  tsu_render;
endtsuglyph;

begintsuglyph("arrowup",145);
  arrow(90);
  tsu_render;
endtsuglyph;

begintsuglyph("arrowright",146);
  arrow(0);
  tsu_render;
endtsuglyph;

begintsuglyph("arrowdown",147);
  arrow(270);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
