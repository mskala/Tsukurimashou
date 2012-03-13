%
% Unicode page 26 (Misc. Symbols) for Tsukurimashou
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

beginfont

input latin-intro.mp;

% AUTODEPS
input iching.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I CHING

begintsuglyph("ichingtri1",48);
  iching.line(1,3,1);
  iching.line(2,3,1);
  iching.line(3,3,1);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingtri2",49);
  iching.line(1,3,1);
  iching.line(2,3,1);
  iching.line(3,3,0);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingtri3",50);
  iching.line(1,3,1);
  iching.line(2,3,0);
  iching.line(3,3,1);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingtri4",51);
  iching.line(1,3,1);
  iching.line(2,3,0);
  iching.line(3,3,0);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingtri5",52);
  iching.line(1,3,0);
  iching.line(2,3,1);
  iching.line(3,3,1);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingtri6",53);
  iching.line(1,3,0);
  iching.line(2,3,1);
  iching.line(3,3,0);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingtri7",54);
  iching.line(1,3,0);
  iching.line(2,3,0);
  iching.line(3,3,1);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingtri8",55);
  iching.line(1,3,0);
  iching.line(2,3,0);
  iching.line(3,3,0);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingmono1",138);
  iching.line(1,1,1);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingmono2",139);
  iching.line(1,1,0);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdi1",140);
  iching.line(1,2,1);
  iching.line(2,2,1);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdi2",141);
  iching.line(1,2,1);
  iching.line(2,2,0);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdi3",142);
  iching.line(1,2,0);
  iching.line(2,2,1);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdi4",143);
  iching.line(1,2,0);
  iching.line(2,2,0);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% musical eighth note, required for MES-1
tsu_rescale_half;
begintsuglyph("musicalnote",106);
  push_stroke((500,150)..(380,205)..(260,95)..(380,40)..cycle,
    (1.6,1.6)--(1.4,1.4)--(1.4,1.4)--(1.4,1.4)--cycle);
  set_boalternate(0);
  push_stroke((500,153)--(500,807),(1.6,1.6)--(1.6,1.6));
  set_boalternate(0);
  push_stroke((640,640)..{curl 1}(500,810){down}..(640,550)..(780,470)..
      {curl 1}(750,400){curl 1}..(830,440)..cycle,
    (1.3,1.3)--(1.6,1.6)--(1.3,1.3)--(1.3,1.3)--(1,1)--(1.3,1.3));
  set_botip(0,1,0);
  set_botip(0,4,0);
  set_boalternate(0);
  if tsu_pbrush_size>=30:
    push_lcblob(get_strokep(-2));
    push_lcblob(get_strokep(0));
  fi;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
