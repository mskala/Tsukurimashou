%
% Unicode page F7 (Adobe PUA) for Tsukurimashou
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

do_late_includes;

latin_wide_sc_top:=0.4[latin_wide_xheight,latin_wide_top];

transform tsu_xf.sc;

(0,latin_wide_low_h) transformed tsu_xf.sc = (20,latin_wide_low_h);
(1000,latin_wide_low_h) transformed tsu_xf.sc = (980,latin_wide_low_h);
(0,latin_wide_top) transformed tsu_xf.sc = (20,latin_wide_sc_top);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LATIN SMALL CAPS

% WARNING changing rescale setting
tsu_rescale_half;

% A
begintsuglyph("uniF761",97);
  tsu_xform(tsu_xf.sc)(latin.upa);
  tsu_render;
endtsuglyph;

% B
begintsuglyph("uniF762",98);
  tsu_xform(tsu_xf.sc)(latin.upb);
  tsu_render;
endtsuglyph;

% C
begintsuglyph("uniF763",99);
  tsu_xform(tsu_xf.sc)(latin.upc);
  tsu_render;
endtsuglyph;

% D
begintsuglyph("uniF764",100);
  tsu_xform(tsu_xf.sc)(latin.upd);
  tsu_render;
endtsuglyph;

% E
begintsuglyph("uniF765",101);
  tsu_xform(tsu_xf.sc)(latin.upe);
  tsu_render;
endtsuglyph;

% F
begintsuglyph("uniF766",102);
  tsu_xform(tsu_xf.sc)(latin.upf);
  tsu_render;
endtsuglyph;

% G
begintsuglyph("uniF767",103);
  tsu_xform(tsu_xf.sc)(latin.upg);
  tsu_render;
endtsuglyph;

% H
begintsuglyph("uniF768",104);
  tsu_xform(tsu_xf.sc)(latin.uph);
  tsu_render;
endtsuglyph;

% I
begintsuglyph("uniF769",105);
  tsu_xform(tsu_xf.sc)(latin.upi);
  tsu_render;
endtsuglyph;

% J
begintsuglyph("uniF76A",106);
  tsu_xform(tsu_xf.sc)(latin.upj);
  tsu_render;
endtsuglyph;

% K
begintsuglyph("uniF76B",107);
  tsu_xform(tsu_xf.sc)(latin.upk);
  tsu_render;
endtsuglyph;

% L
begintsuglyph("uniF76C",108);
  tsu_xform(tsu_xf.sc)(latin.upl);
  tsu_render;
endtsuglyph;

% M
begintsuglyph("uniF76D",109);
  tsu_xform(tsu_xf.sc)(latin.upm);
  tsu_render;
endtsuglyph;

% N
begintsuglyph("uniF76E",110);
  tsu_xform(tsu_xf.sc)(latin.upn);
  tsu_render;
endtsuglyph;

% O
begintsuglyph("uniF76F",111);
  tsu_xform(tsu_xf.sc)(latin.upo);
  tsu_render;
endtsuglyph;

% P
begintsuglyph("uniF770",112);
  tsu_xform(tsu_xf.sc)(latin.upp);
  tsu_render;
endtsuglyph;

% Q
begintsuglyph("uniF771",113);
  tsu_xform(tsu_xf.sc)(latin.upq);
  tsu_render;
endtsuglyph;

% R
begintsuglyph("uniF772",114);
  tsu_xform(tsu_xf.sc)(latin.upr);
  tsu_render;
endtsuglyph;

% S
begintsuglyph("uniF773",115);
  tsu_xform(tsu_xf.sc)(latin.ups);
  tsu_render;
endtsuglyph;

% T
begintsuglyph("uniF774",116);
  tsu_xform(tsu_xf.sc)(latin.upt);
  tsu_render;
endtsuglyph;

% U
begintsuglyph("uniF775",117);
  tsu_xform(tsu_xf.sc)(latin.upu);
  tsu_render;
endtsuglyph;

% V
begintsuglyph("uniF776",118);
  tsu_xform(tsu_xf.sc)(latin.upv);
  tsu_render;
endtsuglyph;

% W
begintsuglyph("uniF777",119);
  tsu_xform(tsu_xf.sc)(latin.upw);
  tsu_render;
endtsuglyph;

% X
begintsuglyph("uniF778",120);
  tsu_xform(tsu_xf.sc)(latin.upx);
  tsu_render;
endtsuglyph;

% Y
begintsuglyph("uniF779",121);
  tsu_xform(tsu_xf.sc)(latin.upy);
  tsu_render;
endtsuglyph;

% Z
begintsuglyph("uniF77A",122);
  tsu_xform(tsu_xf.sc)(latin.upz);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
