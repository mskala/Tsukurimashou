%
% Object stack for Tsukurimashou
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

inclusion_lock(obstack);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OBJECT STACK DATA

% object types:
%   "anchor"   - uses transform, numeric
%   "hook"     - uses string, numeric
%   "lcblob"   - uses path p
%   "null"     - uses nothing
%   "pbox"     - uses transform
%   "stroke"   - uses path p, path q, numeric array, bool array

vardef init_obstack =
  numeric obstacktype[];
  numeric obstackn[];
  numeric obstackna[][];
  numeric obstacknaa[][][];
  boolean obstackb[];
  boolean obstackba[][];
  path obstackp[];
  path obstackq[];
  transform obstackt[];
  string obstacks[];
  numeric sp;
  sp:=1;
enddef;

sp:=0;

% numeric values, needed for syntax reasons

def boalternate = 1924 enddef;
def bokeepshape = 1838 enddef;
def boserif = 1746 enddef;
def bosize = 1393 enddef;
def botip = 1322 enddef;
def botoexpand = 1972 enddef;

def hsmain_render = 1304 enddef;

def otanchor = 1882 enddef;
def othook = 1753 enddef;
def otlcblob = 1722 enddef;
def otnull = 1699 enddef;
def otpbox = 1007 enddef;
def otstroke = 1069 enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OBJECT STACK METHODS

vardef expand_pbox =
  begingroup
    save mysp,i;
    numeric mysp;
    for i=sp-1 downto 1:
      if (obstacktype[i]=otpbox) and (known obstackba.botoexpand[i]):
        if obstackba.botoexpand[i]:
          mysp:=i;
        fi;
      fi;
      exitif known mysp;
    endfor;
    if known mysp:
      obstackba.botoexpand[mysp]:=false;
%      message "expanding " & decimal mysp;
      save x,y,myxf;
      numeric x[],y[];
      transform myxf;
      z1=(70,830);
      z2=(930,-30);
      for i=mysp+1 upto sp-1:
        if obstacktype[i]=otpbox:
          x3:=xpart ((0,0.5) transformed obstackt[i]);
          if x3<x1: x1:=x3; fi;
          y3:=ypart ((0.5,1) transformed obstackt[i]);
          if y3>y1: y1:=y3; fi;
          x4:=xpart ((1,0.5) transformed obstackt[i]);
          if x4>x2: x2:=x4; fi;
          y4:=ypart ((0.5,0) transformed obstackt[i]);
          if y4<y2: y2:=y4; fi;
        fi;
      endfor;
      z0=(x1,y2);
      (0,0) transformed myxf=z0+(-20,-20);
      (0,1) transformed myxf=z1+(-20,20);
      (1,0) transformed myxf=z2+(20,-20);
      obstackt[mysp]:=myxf;
    else:
      errmessage "Can't find PBOX to expand";
    fi;
  endgroup;
  perl_structure:=perl_structure&"],";
enddef;

vardef find_stroke(expr idx) =
  (find_whatever(otstroke,idx))
enddef;

vardef find_whatever(expr w,idx) =
  begingroup
    save i,j;
    numeric i,j;
    i:=sp-1;
    j:=-idx;
    forever:
      exitif i<=0;
      if obstacktype[i]=w:
        j:=j-1;
      fi;
      exitif j<0;
      i:=i-1;
    endfor;
    i
  endgroup
enddef;

vardef get_bosize(expr idx) =
  obstackna.bosize[find_whatever(otstroke,idx)]
enddef;

vardef get_anchor_with_default(expr atype,default_anchor) =
  begingroup
    save i,j;
    numeric i,j;
    i:=0;
    forever:
      j:=find_whatever(otanchor,i);
      exitif j<=0;
      exitif obstackn[j]=atype;
      i:=i-1;
    endfor;
    if j<=0: default_anchor else: obstackt[j] fi
  endgroup
enddef;

vardef get_anchor(expr atype) =
  get_anchor_with_default(atype,identity)
enddef;

vardef get_lcblob(expr idx) =
  obstackp[find_whatever(otlcblob,idx)]
enddef;

vardef get_strokep(expr idx) =
  obstackp[find_whatever(otstroke,idx)]
enddef;

vardef get_strokeq(expr idx) =
  obstackq[find_whatever(otstroke,idx)]
enddef;

vardef pop_hook =
  obstacktype[find_whatever(othook,0)]:=otnull;
enddef;

vardef pop_lcblob =
  obstacktype[find_whatever(otlcblob,0)]:=otnull;
enddef;

vardef pop_stroke =
  obstacktype[find_whatever(otstroke,0)]:=otnull;
enddef;

vardef push_anchor(expr atype,anchor) =
  obstacktype[sp]:=otanchor;
  obstackn[sp]:=atype;
  if pair anchor:
    obstackt[sp]:=identity shifted anchor;
  else:
    obstackt[sp]:=anchor;
  fi;
  sp:=sp+1;
enddef;

vardef push_hook(expr stage,htext) =
  obstacktype[sp]:=othook;
  obstackn[sp]:=stage;
  obstacks[sp]:=htext;
  sp:=sp+1;
enddef;

vardef push_lcblob(expr blob) =
  obstacktype[sp]:=otlcblob;
  obstackp[sp]:=blob;
  sp:=sp+1;
enddef;

vardef push_pbox(expr pbname) =
  obstacktype[sp]:=otpbox;
  obstackt[sp]:=identity scaled 900 shifted (50,-50);
  obstacks[sp]:=pbname;
  sp:=sp+1;
enddef;

vardef push_pbox_explicit(expr pbname,pbox) =
  obstacktype[sp]:=otpbox;
  obstackt[sp]:=pbox;
  obstacks[sp]:=pbname;
  sp:=sp+1;
enddef;

vardef push_pbox_toexpand(expr pbname) =
  obstacktype[sp]:=otpbox;
  obstackt[sp]:=identity scaled 1000 shifted (0,-100);
  obstacks[sp]:=pbname;
  obstackba.botoexpand[sp]:=true;
%  message "to expand " & decimal sp;
  sp:=sp+1;
  perl_structure:=perl_structure&"['"&pbname&"',";
enddef;

vardef push_stroke(expr p,q) =
  obstacktype[sp]:=otstroke;
  obstackp[sp]:=p;
  obstackq[sp]:=q;
  obstackna.bosize[sp]:=100;
  sp:=sp+1;
  perl_structure:=perl_structure&"push_stroke,";
enddef;

vardef replace_lcblob(expr idx)(text blob) =
  begingroup
    save oldblob;
    path oldblob;
    oldblob:=obstackp[find_whatever(otlcblob,idx)];
    obstackp[find_whatever(otlcblob,idx)]:=blob;
  endgroup;
enddef;

vardef replace_strokep(expr idx)(text curves) =
  begingroup
    save oldp;
    path oldp;
    oldp:=obstackp[find_whatever(otstroke,idx)];
    obstackp[find_whatever(otstroke,idx)]:=curves;
  endgroup;
  perl_structure:=perl_structure&"replace_strokep,";
enddef;

vardef replace_strokeq(expr idx)(text curves) =
  begingroup
    save oldq;
    path oldq;
    oldq:=obstackq[find_whatever(otstroke,idx)];
    obstackq[find_whatever(otstroke,idx)]:=curves;
  endgroup;
enddef;

vardef set_boalternate(expr idx) =
  obstackba.boalternate[find_stroke(idx)]:=true;
enddef;

vardef set_bokeepshape(expr idx) =
  obstackba.bokeepshape[find_whatever(otlcblob,idx)]:=true;
enddef;

vardef set_boserif(expr idx,t,srf) =
  obstacknaa.boserif[find_stroke(idx)][t]:=srf;
enddef;

vardef set_bosize(expr idx,bos) =
  obstackna.bosize[find_stroke(idx)]:=bos;
  if bos=0:
    perl_structure:=perl_structure&"bosize0,";
  fi;
enddef;

vardef set_botip(expr idx,t,bt) =
  obstacknaa.botip[find_stroke(idx)][t]:=bt;
enddef;
