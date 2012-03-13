%
% Pentagrams and crosses for Blackletter Lolita
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

inclusion_lock(pentacross);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% UTILITIES FOR PENTAGRAMS AND CROSSES

path my_nib,my_path;

% Golden Ratio
phi:=(1+sqrt(5))/2;

% lw - line width
% ct - corner type, use -1 for rounded, 0 for bevelled, 1 for mitred
% dp - path to draw
vardef draw_stroked(expr lw,ct)(expr dp) =
  default_nib:=fix_nib(lw,lw,0);
  if ct<0:
    draw_stroked_opts()(dp);
  else:
    draw_stroked_opts(tip(ct)(0 for i:=1 upto length dp: ,i endfor))(dp);
  fi;
enddef;

vardef draw_stroked_opts(text myopts)(expr dp) =
  begingroup
    save glyph;
    path glyph;
    pen_stroke(myopts)(dp)(glyph);
    if cycle dp:
      glyph.r:=regenerate(glyph.r);
      glyph.l:=regenerate(glyph.l);
      dangerousFill glyph.r;
      dangerousFill glyph.l;
    else:
      glyph:=regenerate(glyph);
      dangerousFill glyph;
    fi;
  endgroup;
enddef;

path pentagram;
pentagram:=
  ((dir 0)--(dir 144)--(dir 288)--(dir 72)--(dir 216)--cycle)
  rotated 90 scaled 0.5;

% "tip isolated" pentagram, used to de-emphasize corners
path tipentagram;
tipentagram:=insert_nodes(pentagram)
  (0.15,0.85,1.15,1.85,2.15,2.85,3.15,3.85,4.15,4.85);

vardef cross_path(expr hwid) =
  begingroup
    save x,y;
    numeric x,y;
    z1=(0,0.5); % spectacles
    z2=(0,-0.5); % testicles
    z3=(y3-y1,(phi-1)[y2,y1]); % wallet
    z4=(y1-y3,y3); % watch
    x5=x12=x13=x16=x1-hwid;
    x6=x7=x10=x11=x1+hwid;
    x8=x9=x4;
    x14=x15=x3;
    y5=y6=y1;
    y7=y8=y15=y16=y3+hwid;
    y9=y10=y13=y14=y3-hwid;
    y11=y12=y2;
    z5--z6--z7--z8--z9--z10--z11--z12--z13--z14--z15--z16--cycle
  endgroup
enddef;
