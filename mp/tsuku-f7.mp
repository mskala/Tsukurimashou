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
input accent.mp;
input latin.mp;

do_late_includes;

if is_proportional:
  latin_wide_sc_top:=0.4[latin_wide_xheight,latin_wide_top];
else:
  latin_wide_sc_top=0.1[latin_wide_xheight,latin_wide_top];
fi;

transform tsu_xf.sc;

(0,latin_wide_low_h) transformed tsu_xf.sc = (20,latin_wide_low_h);
(1000,latin_wide_low_h) transformed tsu_xf.sc = (980,latin_wide_low_h);
(0,latin_wide_top) transformed tsu_xf.sc = (20,latin_wide_sc_top);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LATIN SMALL CAPS

% WARNING changing rescale setting
tsu_rescale_half;
tsu_accent.up_default_anchors;

% A
begintsuglyph("a.sc",97);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upa))());
  tsu_render;
endtsuglyph;

% B
begintsuglyph("b.sc",98);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upb))());
  tsu_render;
endtsuglyph;

% C
begintsuglyph("c.sc",99);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upc))());
  tsu_render;
endtsuglyph;

% D
begintsuglyph("d.sc",100);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upd))());
  tsu_render;
endtsuglyph;

% E
begintsuglyph("e.sc",101);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upe))());
  tsu_render;
endtsuglyph;

% F
begintsuglyph("f.sc",102);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upf))());
  tsu_render;
endtsuglyph;

% G
begintsuglyph("g.sc",103);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upg))());
  tsu_render;
endtsuglyph;

% H
begintsuglyph("h.sc",104);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.uph))());
  tsu_render;
endtsuglyph;

% I
begintsuglyph("i.sc",105);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upi))());
  tsu_render;
endtsuglyph;

% J
begintsuglyph("j.sc",106);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upj))());
  tsu_render;
endtsuglyph;

% K
begintsuglyph("k.sc",107);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upk))());
  tsu_render;
endtsuglyph;

% L
begintsuglyph("l.sc",108);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upl))());
  tsu_render;
endtsuglyph;

% M
begintsuglyph("m.sc",109);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upm))());
  tsu_render;
endtsuglyph;

% N
begintsuglyph("n.sc",110);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upn))());
  tsu_render;
endtsuglyph;

% O
begintsuglyph("o.sc",111);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upo))());
  tsu_render;
endtsuglyph;

% P
begintsuglyph("p.sc",112);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upp))());
  tsu_render;
endtsuglyph;

% Q
begintsuglyph("q.sc",113);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upq))());
  tsu_render;
endtsuglyph;

% R
begintsuglyph("r.sc",114);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upr))());
  tsu_render;
endtsuglyph;

% S
begintsuglyph("s.sc",115);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.ups))());
  tsu_render;
endtsuglyph;

% T
begintsuglyph("t.sc",116);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upt))());
  tsu_render;
endtsuglyph;

% U
begintsuglyph("u.sc",117);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upu))());
  tsu_render;
endtsuglyph;

% V
begintsuglyph("v.sc",118);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upv))());
  tsu_render;
endtsuglyph;

% W
begintsuglyph("w.sc",119);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upw))());
  tsu_render;
endtsuglyph;

% X
begintsuglyph("x.sc",120);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upx))());
  tsu_render;
endtsuglyph;

% Y
begintsuglyph("y.sc",121);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upy))());
  tsu_render;
endtsuglyph;

% Z
begintsuglyph("z.sc",122);
  tsu_xform(tsu_xf.sc)(tsu_accent.apply(tsu_accent.capital(latin.upz))());
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
