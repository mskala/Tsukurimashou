%
% Enclosed characters for Tsukurimashou
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

inclusion_lock(enclosed);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef circle.single =
  push_stroke(fullcircle scaled 810 shifted centre_pt,
    (2,2)--(2,2)--(2,2)--(2,2)--cycle);
  set_bobrush(0,brpunct);
  set_bosize(0,53);
  tsu_render;
  init_obstack;
enddef;

vardef circle.double =
  push_stroke(fullcircle scaled 900 shifted centre_pt,
    (2,2)--(2,2)--(2,2)--(2,2)--cycle);
  set_bobrush(0,brpunct);
  set_bosize(0,40);
  push_stroke(fullcircle scaled 740 shifted centre_pt,
    (2,2)--(2,2)--(2,2)--(2,2)--cycle);
  set_bobrush(0,brpunct);
  set_bosize(0,40);
  tsu_render;
  init_obstack;
enddef;

vardef square.single(text curves) =
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(curves);
  push_stroke(
    ((500,790)--(100,790)--(100,-10)--(900,-10)--(900,790)--cycle)
      transformed inverse tsu_slant_xform,
    (2,2)--(2,2)--(2,2)--(2,2)--(2,2)--cycle);
  set_bobrush(0,brpunct);
  set_bosize(0,80);
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_botip(0,4,1);
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

transform tsu_xf.circled;
xxpart tsu_xf.circled=yypart tsu_xf.circled=0.68;
xypart tsu_xf.circled=yxpart tsu_xf.circled=0;
centre_pt transformed tsu_xf.circled=centre_pt;

transform tsu_xf.cletter;
xxpart tsu_xf.cletter=yypart tsu_xf.cletter=0.56;
xypart tsu_xf.cletter=yxpart tsu_xf.cletter=0;
centre_pt transformed tsu_xf.cletter=centre_pt;

transform tsu_xf.ctwo.left;
xxpart tsu_xf.ctwo.left=yypart tsu_xf.ctwo.left=0.48;
xypart tsu_xf.ctwo.left=yxpart tsu_xf.ctwo.left=0;
(centre_pt+290*right) transformed tsu_xf.ctwo.left=centre_pt;

transform tsu_xf.ctwo.right;
xxpart tsu_xf.ctwo.right=yypart tsu_xf.ctwo.right=0.48;
xypart tsu_xf.ctwo.right=yxpart tsu_xf.ctwo.right=0;
(centre_pt+310*left) transformed tsu_xf.ctwo.right=centre_pt;

transform tsu_xf.sletter;
xxpart tsu_xf.sletter=yypart tsu_xf.sletter=0.71;
xypart tsu_xf.sletter=yxpart tsu_xf.sletter=0;
centre_pt transformed tsu_xf.sletter=centre_pt+10*up;

vardef tsu_xf.circ_slant_shift =
  (centre_pt-(centre_pt transformed tsu_slant_xform))
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

transform tsu_xf.cbound;
tsu_xf.cbound=identity scaled 340 shifted centre_pt;
