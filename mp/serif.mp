%
% Serifs for Tsukurimashou
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

inclusion_lock(serif);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure out size of brush
(sbrush_width,sbrush_height)=urcorner (
   fullcircle yscaled tsu_brush_shape
   rotated tsu_brush_angle
);
if sbrush_width>sbrush_height:
  sbrush_long:=sbrush_width;
  sbrush_short:=sbrush_height;
else:
  sbrush_short:=sbrush_width;
  sbrush_long:=sbrush_height;
fi;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef tsu_serif.latin.lrcore(expr bst,plp,dlp,l,bts,bos) =
  serif:=serif xscaled sbrush_long yscaled sbrush_short;
  serif:=serif xscaled ((1+3*xxpart tsu_rescaling_xf)/4)
    yscaled bos scaled bts;
  glstk[ngls]:=regenerate(serif shifted plp);
  ngls:=ngls+1;
enddef;

vardef tsu_serif.latin.left(expr bst,plp,dlp,l,bts,bos) =
  begingroup
    save serif;
    path serif;
    if sharp_corners:
      serif:=(-serif_size,1)--(-serif_size,-1)--
        (0,-1)--(0,1)--cycle;
    else:
      serif:=(-serif_size,1){left}..{right}(-serif_size,-1)--
        (0,-1)--(0,1)--cycle;
    fi;
    tsu_serif.latin.lrcore(bst,plp,dlp,l,bts,bos);
  endgroup;
enddef;

vardef tsu_serif.latin.right(expr bst,plp,dlp,l,bts,bos) =
  begingroup
    save serif;
    path serif;
    if sharp_corners:
      serif:=(0,1)--(0,-1)--
        (serif_size,-1)--(serif_size,1)--cycle;
    else:
      serif:=(0,1)--(0,-1)--
        (serif_size,-1){right}..{left}(serif_size,1)--cycle;
    fi;
    tsu_serif.latin.lrcore(bst,plp,dlp,l,bts,bos);
  endgroup;
enddef;

vardef tsu_serif.latin.leftright(expr bst,plp,dlp,l,bts,bos) =
  begingroup
    save serif,xoffs;
    path serif;
    if sharp_corners:
      serif:=(-serif_size,1)--(-serif_size,-1)--
        (serif_size,-1)--(serif_size,1)--cycle;
    else:
      serif:=(-serif_size,1){left}..{right}(-serif_size,-1)--
        (serif_size,-1){right}..{left}(serif_size,1)--cycle; fi;
    numeric xoffs;
    xoffs=xpart (dlp/abs(dlp));
    tsu_serif.latin.lrcore(bst,
      plp+if l=0: right else: left fi*50*sbrush_long*xoffs,
      dlp,l,bts,bos);
  endgroup;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef tsu_serif.mincho.corner(expr bst,plp,dlp,l,bts,bos) =
  begingroup
    save serif;
    path serif;
    serif:=(-1,-0.3)..(0.25,-1.3)..(1,-1.2)..tension 1.2..
      (1,0.6)..(-0.25,1.3)..(-1,1.2)..tension 1.2..cycle;
    serif:=serif yscaled sqrt(tsu_brush_shape) rotated tsu_brush_angle
      scaled (bts*0.43);
    glstk[ngls]:=regenerate(serif shifted plp);
    ngls:=ngls+1;
  endgroup;
enddef;

vardef tsu_serif.mincho.ulpoint(expr bst,plp,dlp,l,bts,bos) =
  begingroup
    save serif;
    path serif;
    serif:=(-1.5,2.7)..tension 2..(-1,0)..(-0.4,-0.3)..tension 1.5..
      (0.707,0)..(0.2,0.6)..(-0.1,1.1)..tension 2..(-1.2,2.9)..cycle;
    serif:=serif yscaled sqrt(tsu_brush_shape) rotated tsu_brush_angle
      scaled (bts*0.5);
    glstk[ngls]:=regenerate(serif shifted
       (plp+(-1,0)*0.25*bts*(xpart dlp/abs(dlp))));
    ngls:=ngls+1;
  endgroup;
enddef;

vardef tsu_serif.mincho.triangle(expr bst,plp,dlp,l,bts,bos) =
  begingroup
    save serif;
    path serif;
    serif:=(-1.2,0)..(0,-0.8)..(1.2,0.4)..tension 2..(0.2,1.3)..
      (-0.2,1.3)..tension 2..cycle;
    serif:=serif yscaled sqrt(tsu_brush_shape) rotated tsu_brush_angle
      scaled (bts*0.5);
    glstk[ngls]:=regenerate(serif shifted (plp+0.25*bts*dlp/abs(dlp)));
    ngls:=ngls+1;
  endgroup;
enddef;

vardef tsu_serif.mincho.llpoint(expr bst,plp,dlp,l,bts,bos) =
  begingroup
    save serif;
    path serif;
    serif:=(-2.1,-1.9)..(-1.8,-2.1)..tension 2..(-0.1,-1.2)..(0.2,-1.1)..
      (0.707,0.707)..(-1,-0.3)..tension 2..cycle;
    serif:=serif yscaled sqrt(tsu_brush_shape) rotated tsu_brush_angle
      scaled (bts*0.5);
    glstk[ngls]:=regenerate(serif shifted plp);
    ngls:=ngls+1;
  endgroup;
enddef;

vardef tsu_serif.mincho.lpoint(expr bst,plp,dlp,l,bts,bos) =
  begingroup
    save serif;
    path serif;
    serif:=(-1.5,1.7)..tension 2..(-1,0)..(-0.4,-0.3)..tension 1.8..
      (0.707,0.2)..(0.2,0.8)..(-0.4,1.1)..tension 2..(-1.2,2.0)..cycle;
    serif:=reverse serif reflectedabout ((-1,1),(1,-1))
      xyscaled (0.7,0.9) shifted (0.3,-0.3);
    serif:=serif yscaled sqrt(tsu_brush_shape) rotated tsu_brush_angle
      scaled bts;
    glstk[ngls]:=regenerate(serif shifted plp);
    ngls:=ngls+1;
  endgroup;
enddef;

vardef tsu_serif.mincho.ktriangle(expr bst,plp,dlp,l,bts,bos) =
  begingroup;
    save serif,x,y,t,q;
    path serif;
    transform t;
    (0,0) transformed t=(0,0);
    right transformed t=(dlp/abs(dlp));
    z1=(dlp/abs(dlp)) rotated 90;
    if y1<-x1: x1:=-x1; y1:=-y1; fi;
    up transformed t=z1;
    q1:=2;
    q2:=q1+-+0.5;
    q3:=0.5*q2/q1;
    q5:=0.5+-+q3;
    z2=(0,q1);
    z3=(-q3,q5);
    z4=(q3,q5);
    serif:=((0.1[z2,z4]){z2-z4}..{z3-z2}(0.1[z2,z3])
      --z3--z4--cycle)
      transformed t yscaled tsu_brush_shape
      rotated tsu_brush_angle
      scaled (bts*bos*0.98) shifted plp;
    if (xxpart t)*(yypart t)<0: serif:=reverse serif; fi;
    glstk[ngls]:=regenerate(serif);
    ngls:=ngls+1;
  endgroup;
enddef;

vardef tsu_serif.mincho.khellipse(expr bst,plp,dlp,l,bts,bos) =
  begingroup;
    save serif,x,y,t,q;
    path serif;
    transform t;
    (0,0) transformed t=(0,0);
    right transformed t=(dlp/abs(dlp));
    z1=(dlp/abs(dlp)) rotated 90;
    up transformed t=z1;
    t:=t rotated -tsu_brush_angle yscaled tsu_brush_shape
      rotated tsu_brush_angle scaled (bts*bos*0.99) shifted plp;
    z2=(0.5[x3,x4],1);
    if l=0:
      z3=(-0.5,0);
      z4=(1.3,0);
    else:
      z3=(-1.3,0);
      z4=(0.5,0);
    fi;
    serif:=((subpath (0.2,2) of (z4{up}..z2..{down}z3))--cycle) transformed t;
    glstk[ngls]:=regenerate(serif);
    ngls:=ngls+1;
  endgroup;
enddef;

% standard serif codes:
% 1 - Latin left
% 2 - Latin right
% 3 - Latin left and right
% 4 - Mincho corner blob
% 5 - Mincho blob, pointy to ul
% 6 - Mincho blob, triangular
% 7 - Mincho blob, point to ll
% 8 - Mincho blob, point to l
% 9 - Mincho kanji triangle
% 10 - Mincho kanji half-ellipse

boolean tsu_do_serif[];

vardef tsu_serif.standard(expr bst,plp,dlp,l,bts,bos) =
  if known tsu_do_serif[1]:
    if tsu_do_serif[1] and (bst=1):
      tsu_serif.latin.left(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[2]:
    if tsu_do_serif[2] and (bst=2):
      tsu_serif.latin.right(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[3]:
    if tsu_do_serif[3] and (bst=3):
      tsu_serif.latin.leftright(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[4]:
    if tsu_do_serif[4] and (bst=4):
      tsu_serif.mincho.corner(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[5]:
    if tsu_do_serif[5] and (bst=5):
      tsu_serif.mincho.ulpoint(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[6]:
    if tsu_do_serif[6] and (bst=6):
      tsu_serif.mincho.triangle(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[7]:
    if tsu_do_serif[7] and (bst=7):
      tsu_serif.mincho.llpoint(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[8]:
    if tsu_do_serif[8] and (bst=8):
      tsu_serif.mincho.lpoint(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[9]:
    if tsu_do_serif[9] and (bst=9):
      tsu_serif.mincho.ktriangle(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
  if known tsu_do_serif[10]:
    if tsu_do_serif[10] and (bst=10):
      tsu_serif.mincho.khellipse(bst,plp,dlp,l,bts,bos);
    fi;
  fi;
enddef;

vardef tsu_serif.choose(expr bst,plp,dlp,l,bts,bos) =
  tsu_serif.standard(bst,plp,dlp,l,bts,bos);
enddef;

