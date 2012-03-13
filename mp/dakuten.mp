%
% Dakuten and handakuten for Tsukurimashou
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

inclusion_lock(dakuten);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef dakuten(expr xf) =
  push_pbox_explicit("dakuten",
    identity shifted (-0.4,-0.5) scaled 200 rotated -50 transformed xf);

  push_stroke(((-80,10)..(-35,-35)..(10,-90)) transformed xf,
    (1,1)..(1.4,1.4)..(1.8,1.8));
  set_bosize(0,85);
  set_boserif(0,2,4);

  push_stroke(((0,80)..(50,30)..(100,-30)) transformed xf,
    (1,1)..(1.4,1.4)..(1.8,1.8));
  set_bosize(0,85);
  set_boserif(0,2,4);
enddef;

vardef handakuten(expr location) =
   push_lcblob(fullcircle scaled handakuten_outer shifted location
     transformed inverse tsu_rescale_xform);
   push_lcblob(reverse fullcircle scaled handakuten_inner shifted location
     transformed inverse tsu_rescale_xform);
enddef;
