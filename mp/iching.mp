%
% I Ching characters for Tsukurimashou
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

inclusion_lock(iching);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iching.size:=680;

vardef make_iching_xform(expr numlines) =
  transform iching_xform;
  numeric x[];

  x2-x1=iching.size;
  (x1+x2)/2=500;

  (-1,(numlines+1)/2) transformed iching_xform=
    (x1,0.5[latin_wide_low_h,latin_wide_high_h]);
  (1,(numlines+1)/2) transformed iching_xform=
    (x2,0.5[latin_wide_low_h,latin_wide_high_h]);
  (-1,(numlines+1)/2-2.5) transformed iching_xform=
    (x1,latin_wide_low_h);
enddef;

vardef iching.line(expr line,numlines,linetype) =
  make_iching_xform(numlines);
  if linetype=0:
    push_stroke(((-1,line)--(-0.28,line)) transformed iching_xform,
      (2,2)--(2,2));
    push_stroke(get_strokep(0) reflectedabout (centre_pt,centre_pt+down),
      (2,2)--(2,2));
  else:
    push_stroke(((-1,line)--(1,line)) transformed iching_xform,
      (2,2)--(2,2));
  fi;
  push_anchor(anc_iching_line(line),
    identity shifted (((1,line) transformed iching_xform)
                     +(1000-iching.size)*0.25*right));
enddef;

% WARNING, nonstandard calling convention, simply returns a path to fill
vardef iching.dot(expr line,numlines) =
  begingroup;
    make_iching_xform(numlines);
    (fullcircle scaled (tsu_punct_size*1.10)
      shifted (((1,line) transformed iching_xform)
              +(1000-iching.size)*0.25*right))
  endgroup
enddef;
