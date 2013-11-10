%
% Unicode page A9 (Hangul Jamo Extended A) for Mandeubsida
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

% AUTODEPS
input hangul.mp;

% non-auto dependencies
input jamo-basic.mp;
input jamo-extra.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This file covers the basic layout (layout 0):  a lead, a vowel that may
% go both vertically and horizontally, and a non-empty tail.  All jamo are
% defined for this layout.  Other files (in private-use plane 15) define
% versions of some jamo for other layouts; the idea is that the jamo here
% are defaults, and an OpenType feature can substitute the others (or entire
% precomposed syllables) to improve the layout where applicable.

transform lixf,loxf,vixf,tvixf,voxf,tixf,toxf;

lixf=loxf=hxf((50,850),(700,525));
vixf=hxf((700,475),(950,250));
tvixf=hxf((700,535),(950,240));
voxf=hxf((50,850),(950,250));
tixf=hxf((100+20*mincho,275),(900-20*mincho,-50)) shifted (-1000,0);
toxf=hxf((50,275),(950,-50)) shifted (-1000,0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HANGUL CHOSEONG (LEAD) JAMO EXTENDED A

tsu_rescale_native_zero;

% hangul lead tikeut-mieum
begintsuglyph("uniA960",96);
  hangul.combine.lr(203,106)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-pieup
begintsuglyph("uniA961",97);
  hangul.combine.lr(203,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-sios
begintsuglyph("uniA962",98);
  hangul.combine.lr(203,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-cieuc
begintsuglyph("uniA963",99);
  hangul.combine.lr(203,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-kiyeok
begintsuglyph("uniA964",100);
  hangul.combine.lr(205,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-ssangkiyeok
begintsuglyph("uniA965",101);
  hangul.combine.lcr(205,100,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-tikeut
begintsuglyph("uniA966",102);
  hangul.combine.lr(205,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-ssangtikeut
begintsuglyph("uniA967",103);
  hangul.combine.lcr(205,203,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-mieum
begintsuglyph("uniA968",104);
  hangul.combine.lr(205,106)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-pieup
begintsuglyph("uniA969",105);
  hangul.combine.lr(205,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-ssangpieup
begintsuglyph("uniA96A",106);
  hangul.combine.lcr(205,207,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-kapyeounpieup
begintsuglyph("uniA96B",107);
  hangul.combine.lr(205,231)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-sios
begintsuglyph("uniA96C",108);
  hangul.combine.lr(205,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-cieuc
begintsuglyph("uniA96D",109);
  hangul.combine.lr(205,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-khieukh
begintsuglyph("uniA96E",110);
  hangul.combine.lr(205,115)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum-kiyeok
begintsuglyph("uniA96F",111);
  hangul.combine.lr(106,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum-tikeut
begintsuglyph("uniA970",112);
  hangul.combine.lr(106,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum-sios
begintsuglyph("uniA971",113);
  hangul.combine.lr(106,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-thieuth
begintsuglyph("uniA972",114);
  hangul.combine.lcr(207,209,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-khieukh
begintsuglyph("uniA973",115);
  hangul.combine.lr(207,115)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-hieuh
begintsuglyph("uniA974",116);
  hangul.combine.lr(207,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangsios-pieup
begintsuglyph("uniA975",117);
  hangul.combine.lcr(209,209,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-rieul
begintsuglyph("uniA976",118);
  hangul.combine.lr(111,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-hieuh
begintsuglyph("uniA977",119);
  hangul.combine.lr(111,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangcieuc-hieuh
begintsuglyph("uniA978",120);
  hangul.combine.lcr(212,212,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangthieuth
begintsuglyph("uniA979",121);
  hangul.combine.lr(216,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead phieuph-hieuh
begintsuglyph("uniA97A",122);
  hangul.combine.lr(117,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead hieuh-sios
begintsuglyph("uniA97B",123);
  hangul.combine.lr(118,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangyeorinhieuh
begintsuglyph("uniA97C",124);
  hangul.combine.lcr(221,230,221)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
