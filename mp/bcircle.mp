%
% Bounding circle algorithm of E. Welzl
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

inclusion_lock(bcircle);

% swap points in pts[] array
vardef swap_pts(expr a,b)=
  pair tmppt;
  tmppt:=pts[a];
  pts[a]:=pts[b];
  pts[b]:=tmppt;
enddef;

% compute bounding circle on up to three points
vardef bcircle.basis(expr rstart,rend) =
  if rend<=rstart+1:
    identity
  else:
    begingroup
      save x,y,myt;
      numeric x[],y[];
      transform myt;
      z1=pts[rstart];
      z2=pts[rstart+1];
      xypart myt=0;
      yxpart myt=0;
      if rend=rstart+2:
        z3=(z1+z2)/2;
        (0,0) transformed myt=(z1+z2)/2;
        xxpart myt=yypart myt=abs(z1-z3);
      else:
        z3=pts[rstart+2];
        z4=(z1+z2)/2;
        z5=(z1+z3)/2;
        z6=z4+whatever*((z2-z1) rotated 90);
        z6=z5+whatever*((z3-z1) rotated 90);
        (0,0) transformed myt=z6;
        xxpart myt=yypart myt=abs(z1-z6);
      fi;
      myt
    endgroup
  fi
enddef;

% recursion to compute bounding circle.
% Input point sets are in pts[] array, arguments are indices into it
vardef bcircle.internal(expr pstart,rstart,rend) =
  if (pstart=rstart) or (rend-rstart=3):
    bcircle.basis(rstart,rend)
  else:
    begingroup
      transform d;
      pind:=floor ((rstart-pstart)*uniformdeviate 1)+pstart;
      swap_pts(pstart,pind);
      d=bcircle.internal(pstart+1,rstart,rend);
      pair xpt;
      xpt transformed d=pts[pstart];
      if abs(xpt)>1:
        swap_pts(pstart,(rstart-1));
        d:=bcircle.internal(pstart,rstart-1,rend);
      fi;
      d
    endgroup
  fi
enddef;

% wrapper for bounding circle algorithm - compute bcircle of points
vardef bcircle.points(text txt) =
  begingroup
    save d,tmppt,pind,xpt,pts,pcnt;
    pcnt:=0;
    for myp=txt:
      pts[pcnt]:=myp;
      pcnt:=pcnt+1;
    endfor;
    bcircle.internal(0,pcnt,pcnt)
  endgroup
enddef;

% wrapper for bounding circle algorithm - compute bcircle of paths
vardef bcircle.paths(text txt) =
  begingroup
    save d,tmppt,pind,xpt,pts,pcnt;
    pcnt:=0;
    for myp=txt:
      for i=0 step 0.1 until length myp:
        pts[pcnt]:=point i of myp;
        pcnt:=pcnt+1;
      endfor
    endfor;
    bcircle.internal(0,pcnt,pcnt)
  endgroup
enddef;

