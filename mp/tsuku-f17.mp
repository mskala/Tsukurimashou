%
% Unicode page F17 (Tsukurimashou-specific extensions) for Tsukurimashou
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
input buildkanji.mp;
input enclosed.mp;
input gradeone.mp;
input iching.mp;
input katakana.mp;
input latin.mp;
input leftrad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% COMBINING DOTS FOR I CHING

% WARNING changing rescale setting
tsu_rescale_native_zero;

vardef make_iching_anchors(expr lnum,lmax) =
  for i:=1 upto lmax:
    push_anchor(if i=lnum: -1 else: 1 fi*anc_iching_line(i),
      identity shifted (((1,i) transformed iching_xform)
                       +(1000-iching.size)*0.25*right+1000*left));
  endfor;
enddef;

begintsuglyph("ichingdot1.6",1);
  Fill iching.dot(1,6) shifted (-1000,0);
  make_iching_anchors(1,6);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdot2.6",2);
  Fill iching.dot(2,6) shifted (-1000,0);
  make_iching_anchors(2,6);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdot3.6",3);
  Fill iching.dot(3,6) shifted (-1000,0);
  make_iching_anchors(3,6);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdot4.6",4);
  Fill iching.dot(4,6) shifted (-1000,0);
  make_iching_anchors(4,6);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdot5.6",5);
  Fill iching.dot(5,6) shifted (-1000,0);
  make_iching_anchors(5,6);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdot6.6",6);
  Fill iching.dot(6,6) shifted (-1000,0);
  make_iching_anchors(6,6);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdot1.3",7);
  Fill iching.dot(1,3) shifted (-1000,0);
  make_iching_anchors(1,3);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdot2.3",8);
  Fill iching.dot(2,3) shifted (-1000,0);
  make_iching_anchors(2,3);
  tsu_render;
endtsuglyph;

begintsuglyph("ichingdot3.3",9);
  Fill iching.dot(3,3) shifted (-1000,0);
  make_iching_anchors(3,3);
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_full;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MISCELLANEOUS

begingroup
save rescale_slant;
rescale_slant:=0;

begintsuglyph("Euro.official",16);
  z25=(fullcircle scaled 10) intersectionpoint ((0,0)--(10*dir 40));
  z11=(0,-6);

  z1=(0,6);
  z2=(fullcircle scaled 12) intersectionpoint ((-10,1.5)--(0,1.5));
  y3=y2;
  z3-z4=whatever*(z25-z11);
  z4=(-7.5,0.5);
  z5=(fullcircle scaled 12) intersectionpoint ((-10,0.5)--(0,0.5));
  z6=(-6,0);
  z7=(fullcircle scaled 12) intersectionpoint ((-10,-0.5)--(0,-0.5));
  y8=y7;
  z8-z9=whatever*(z25-z11);
  z9=(-7.5,-1.5);
  z10=(fullcircle scaled 12) intersectionpoint ((-10,-1.5)--(0,-1.5));
  z13=(fullcircle scaled 10) intersectionpoint ((0,0)--(10*dir 320));
  z12=(fullcircle scaled 12) intersectionpoint (z13--(z13+(0,-3)));
  z14=(0,-5);
  z15=(fullcircle scaled 10) intersectionpoint ((-10,-1.5)--(0,-1.5));
  y16=-1.5;
  z16=whatever[z11,z25];
  y17=-0.5;
  z17=whatever[z11,z25];
  z18=(fullcircle scaled 10) intersectionpoint ((-10,-0.5)--(0,-0.5));
  z19=(-5,0);
  z20=(fullcircle scaled 10) intersectionpoint ((-10,0.5)--(0,0.5));
  y21=0.5;
  z21=whatever[z11,z25];
  y22=1.5;
  z22=whatever[z11,z25];
  z23=(fullcircle scaled 10) intersectionpoint ((-10,1.5)--(0,1.5));
  z24=(0,5);
  z26=(fullcircle scaled 12) intersectionpoint (z11--1.5[z11,z25]);
  path euro;
  euro:=z1..z2--z3--z4--z5..z6..z7--z8--z9--z10..z11..z12--z13..
    z14..z15--z16--z17--z18..z19..z20--z21--z22--z23..z24..z25--z26..cycle;
  dangerousFill euro scaled (400/6) shifted (centre_pt+90*right);
endtsuglyph;

% circled "katakana n"
begintsuglyph("uF1711",17);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.n);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% background for use with enclosed alpha
begintsuglyph("squarebackground",18);
  if sharp_corners:
    dangerousFill (60,830)--(60,-50)--(940,-50)--(940,830)--cycle;
  else:
    path crnp;
    crnp:=(60+1.5*tsu_punct_size,830){left}..
      {down}(60,830-1.5*tsu_punct_size);
    dangerousFill crnp--
      (crnp rotatedaround (centre_pt,90))--
      (crnp rotatedaround (centre_pt,180))--
      (crnp rotatedaround (centre_pt,270))--cycle;
  fi;
endtsuglyph;

% Individual Eleven
vardef kanji.reference.enemy =
  push_pbox_toexpand("kanji.reference.enemy");
  build_kanji.lr(300,20)
    (kanji.leftrad.person)
    (kanji.grone.nine);
  expand_pbox;
enddef;
begintsuglyph("individualeleven",19);
  numeric x[],y[];
  z3=z7=centre_pt;
  z3-z1=z5-z3;
  z3-z2=z4-z3;
  z3-z8=z6-z3;
  y1=y3;
  y2=y6;
  x2=x8;
  y2-y1=x2-x1;
  x3-x1=290;
  x2-x1=111;
  save default_nib;
  path default_nib;
  path iepa,iepb;
  default_nib:=fix_nib(53,53,0);
  pen_stroke()(z1{up}..z2{right}..z3..z4{right}..{up}z5)(iepa);
  dangerousFill iepa;
  % do this in between the halves of the infinity, to work around a bug
  dangerousFill unitsquare shifted (-0.5,-0.5) scaled 680
    rotated 45 shifted centre_pt;
  dangerousFill reverse unitsquare shifted (-0.5,-0.5) scaled 590
    rotated 45 shifted centre_pt;
  pen_stroke()(z5{up}..z6{left}..z7..z8{left}..{up}z1)(iepb);
  dangerousFill iepb;
  build_kanji.sscale(scaled 0.22 shifted (0,230))
    (kanji.reference.enemy);
  build_kanji.sscale(xyscaled (0.25,0.20) shifted (0,-180))
    (kanji.grone.ten);
  build_kanji.sscale(scaled 0.20 shifted (0,-290))
    (kanji.grone.one);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,35); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TOMOE ORNAMENTS

vardef spiral_interpolate(expr start_cart,end_cart,ckpts,loops) =
  begingroup
    pair start_pol,end_pol,inter_pol;

    start_pol:=(abs(start_cart),angle(start_cart));
    end_pol:=(abs(end_cart),angle(end_cart));
    if (ypart start_pol)-(ypart end_pol)>180:
      start_pol:=start_pol+(0,-360);
    fi;
    if (ypart end_pol)-(ypart start_pol)>180:
      end_pol:=end_pol+(0,-360);
    fi;
    end_pol:=end_pol+(0,360*loops);
    for i=1 upto ckpts:
      begingroup
        inter_pol:=(i/(ckpts+1))[start_pol,end_pol];
        ((dir ypart inter_pol)*xpart inter_pol)
      endgroup
      if i<ckpts: .. fi
    endfor
  endgroup
enddef;

vardef make_tomoe(expr k,ir,or,hr,phase,
  tail_start,tail_advance,ckpts,do_flip) =
  begingroup
    path tomoe;
    pair tail_tip;

    loops:=if k=1: 1 else: 0 fi;
    tail_tip:=(dir (tail_advance-360/k))*or;
    tomoe:=(subpath (tail_start/90,3) of (right..up..left..down..cycle))
      scaled hr shifted (ir+hr,0);
    tomoe:=tomoe{curl 1}..
      spiral_interpolate(point infinity of tomoe,tail_tip,ckpts,-loops)..
      {curl 1}tail_tip{curl 1}..
      spiral_interpolate(tail_tip,point 0 of tomoe,ckpts,loops)..cycle;

    if do_flip: tomoe:=tomoe xscaled -1; fi;

    for i=1 upto k:
      dangerousFill tomoe rotated (phase+i*360/k) shifted centre_pt;
    endfor;
  endgroup;
enddef;

% hitotsudomoe ornament
begintsuglyph("tomoe1",49);
  make_tomoe(1,-219,450,335,105,0,35,6,false);
endtsuglyph;

% futatsudomoe ornament
begintsuglyph("tomoe2",50);
  make_tomoe(2,17,450,210,120,15,15,4,false);
endtsuglyph;

% mitsudomoe ornament
begintsuglyph("tomoe3",51);
  make_tomoe(3,81,450,185,130,5,15,3,false);
endtsuglyph;

% yotsudomoe ornament
begintsuglyph("tomoe4",52);
  make_tomoe(4,104,450,162,47,12,12,4,false);
endtsuglyph;

% 5-tsudomoe ornament
begintsuglyph("tomoe5",53);
  make_tomoe(5,143,450,150,31,10,15,3,false);
endtsuglyph;

% 6-tsudomoe ornament
begintsuglyph("tomoe6",54);
  make_tomoe(4,248,450,104,47,2,8,4,false);
  make_tomoe(2,17,231,98,0,15,15,4,true);
endtsuglyph;

% 7-tsudomoe ornament
begintsuglyph("tomoe7",55);
  make_tomoe(4,248,450,104,47,2,8,4,false);
  make_tomoe(3,40,231,95,75,15,15,4,true);
endtsuglyph;

% 8-tsudomoe ornament
begintsuglyph("tomoe8",56);
  make_tomoe(5,260,450,92,47,2,8,4,false);
  make_tomoe(3,40,231,92,75,15,25,4,true);
endtsuglyph;

endgroup;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HEAVY METAL UMLAUT

% WARNING, setting rescale
tsu_rescale_half;

% naked heavy metal umlaut
begintsuglyph("dieresis.hmu",64);
  tsu_accent.heavy_metal_umlaut;
  tsu_render;
endtsuglyph;

% A with heavy metal umlaut
begintsuglyph("Adieresis.hmu",65);
  tsu_accent.apply(tsu_accent.capital(latin.upa))
    (tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% E with heavy metal umlaut
begintsuglyph("Edieresis.hmu",66);
  tsu_accent.apply(tsu_accent.capital(latin.upe))
    (tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% I with heavy metal umlaut
begintsuglyph("Idieresis.hmu",67);
  tsu_accent.apply(tsu_accent.capital(latin.upi))
    (tsu_accent.heavy_metal_umlaut);
  replace_lcblob(-1)(oldblob shifted (-15,0));
  replace_lcblob(0)(oldblob shifted (-15,0));
  tsu_render;
endtsuglyph;

% N with heavy metal umlaut
begintsuglyph("Ndieresis.hmu",68);
  tsu_accent.apply(tsu_accent.capital(latin.upn))
    (tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% O with heavy metal umlaut
begintsuglyph("Odieresis.hmu",69);
  tsu_accent.apply(tsu_accent.capital(latin.upo))
    (tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% U with heavy metal umlaut
begintsuglyph("Udieresis.hmu",70);
  tsu_accent.apply(tsu_accent.capital(latin.upu))
    (tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% Y with heavy metal umlaut
begintsuglyph("Ydieresis.hmu",71);
  tsu_accent.apply(tsu_accent.capital(latin.upy))
    (tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% a with heavy metal umlaut
begintsuglyph("adieresis.hmu",72);
  tsu_accent.apply(latin.lowa)(tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% e with heavy metal umlaut
begintsuglyph("edieresis.hmu",73);
  tsu_accent.apply(latin.lowe)(tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% i with heavy metal umlaut
begintsuglyph("idieresis.hmu",74);
  tsu_accent.apply(
    latin.lowi;
    replace_strokep(0)(oldp shifted (70*right));
    pop_lcblob;
  )(tsu_accent.heavy_metal_umlaut);
  replace_lcblob(-1)(oldblob shifted (50*right));
  replace_lcblob(0)(oldblob shifted (50*left));
  tsu_render;
endtsuglyph;

% n with heavy metal umlaut
begintsuglyph("ndieresis.hmu",75);
  tsu_accent.apply(latin.lown)(tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% o with heavy metal umlaut
begintsuglyph("odieresis.hmu",76);
  tsu_accent.apply(latin.lowo)(tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

% u with heavy metal umlaut
begintsuglyph("udieresis.hmu",77);
  tsu_accent.apply(latin.lowu)(tsu_accent.heavy_metal_umlaut);
  replace_lcblob(-1)(oldblob shifted (-60,0));
  replace_lcblob(0)(oldblob shifted (-60,0));
  tsu_render;
endtsuglyph;

% y with heavy metal umlaut
begintsuglyph("ydieresis.hmu",78);
  tsu_accent.apply(latin.lowy)(tsu_accent.heavy_metal_umlaut);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% GENJI-MON

begingroup
save rescale_slant;
rescale_slant:=0;

% WARNING, setting rescale
tsu_rescale_full;

genji_grid:=150;
if unknown genji_hw:
  genji_hw:=tsu_brush_max/1.5;
  if genji_hw>0.85: genji_hw:=0.85; fi;
fi;
if genji_outline: genji_hw:=1-genji_hw; fi;

vardef dflt_genji_coords =
  transform genji_coords;
  genji_coords=identity scaled genji_grid shifted (whatever,whatever);
  (3,3) transformed genji_coords=centre_pt;
enddef;

% gb(x) - start a line at the bottom in file x
% gf(y) - go forward, to or from rank y
% gs(k) - go sideways k steps
% ge - end a line (at top or bottom)
% gt - end a line (T junction)
% gx - end a line and start a new one (X junction)
% gr - turn to right
% gl - turn to left (only used for Yume no Ukihashi)
% gbk(l,r) - draw background with l/r squares removed at upper left, right
% gp(i,r) - build a simple "spike" in index 1, to rank r
% gj(s,e) - build a simple "jumper" from s to e

vardef gb(expr a) =
  dflt_genji_coords;
  genji_coords:=identity scaled 0.5 shifted (a,1) transformed genji_coords;
  path genji_path;
  genji_path:=((-genji_hw,1)--(-genji_hw,-genji_hw)--
    (genji_hw,-genji_hw)--(genji_hw,1)) transformed genji_coords;
  path genji_spine;
  genji_spine:=(0,0) transformed genji_coords;
  genji_coords:=identity shifted (0,2) transformed genji_coords;
enddef;

vardef gf(expr a) =
  gs(4-a);
enddef;

vardef gs(expr a) =
  genji_path:=((-genji_hw,2*a-1) transformed genji_coords)--
    genji_path--
    ((genji_hw,2*a-1) transformed genji_coords);
  genji_coords:=identity shifted (0,2*a) transformed genji_coords;
enddef;

vardef ge =
  genji_path:=((-genji_hw,genji_hw) transformed genji_coords)--
    genji_path--
    ((genji_hw,genji_hw) transformed genji_coords)--
    cycle;
  if genji_outline:
    unFill reverse genji_path;
  else:
    Fill genji_path;
  fi;
  genji_spine:=genji_spine--((0,0) transformed genji_coords);
  if unknown gsp: gsp:=1; fi;
  write ("SEGMENT "&(decimal gsp)&" 0 "&(decimal length genji_spine))
    to "proof.prf";
  for i=0 upto length genji_spine:
    write ("POINT "&(decimal gsp)&" "&(decimal i)&" "&
           (decimal xpart point i of genji_spine)&" "&
           (decimal ypart point i of genji_spine)) to "proof.prf";
  endfor;
  gsp:=gsp+1;
enddef;

vardef gt =
  genji_path:=((-genji_hw,-genji_hw) transformed genji_coords)--
    genji_path--
    ((genji_hw,-genji_hw) transformed genji_coords)--
    cycle;
  if genji_outline:
    unFill reverse genji_path;
  else:
    Fill genji_path;
  fi;
  genji_spine:=genji_spine--((0,-1) transformed genji_coords);
  if unknown gsp: gsp:=1; fi;
  write ("SEGMENT "&(decimal gsp)&" 0 "&(decimal length genji_spine))
    to "proof.prf";
  for i=0 upto length genji_spine:
    write ("POINT "&(decimal gsp)&" "&(decimal i)&" "&
           (decimal xpart point i of genji_spine)&" "&
           (decimal ypart point i of genji_spine)) to "proof.prf";
  endfor;
  gsp:=gsp+1;
enddef;

vardef gx =
  gt;
  genji_path:=((-genji_hw,1)--(-genji_hw,genji_hw)--
    (genji_hw,genji_hw)--(genji_hw,1)) transformed genji_coords;
  genji_spine:=(0,1) transformed genji_coords;
  genji_coords:=identity shifted (0,2) transformed genji_coords;
enddef;

vardef gr =
  genji_path:=((1,genji_hw) transformed genji_coords)--
    ((-genji_hw,genji_hw) transformed genji_coords)--
    genji_path--
    ((genji_hw,-genji_hw) transformed genji_coords)--
    ((1,-genji_hw) transformed genji_coords);
  genji_spine:=genji_spine--((0,0) transformed genji_coords);
  genji_coords:=identity shifted (0,2) rotated -90 transformed genji_coords;
enddef;

vardef gl =
  genji_path:=((-1,-genji_hw) transformed genji_coords)--
    ((-genji_hw,-genji_hw) transformed genji_coords)--
    genji_path--
    ((genji_hw,genji_hw) transformed genji_coords)--
    ((-1,genji_hw) transformed genji_coords);
  genji_spine:=genji_spine--((0,0) transformed genji_coords);
  genji_coords:=identity shifted (0,2) rotated 90 transformed genji_coords;
enddef;

vardef gbk(expr lcut,rcut) =
  gsp:=whatever;
  if genji_outline:
    path genji_path;
    genji_path:=(genji_hw/2,genji_hw/2)--(6-genji_hw/2,genji_hw/2)--
      if rcut>0:
        (6-genji_hw/2,5-genji_hw/2)--
        (6-genji_hw/2-rcut,5-genji_hw/2)--
        (6-genji_hw/2-rcut,6-genji_hw/2)--
      else:
        (6-genji_hw/2,6-genji_hw/2)--
      fi
      if lcut>0:
        (genji_hw/2+lcut,6-genji_hw/2)--
        (genji_hw/2+lcut,5-genji_hw/2)--
        (genji_hw/2,5-genji_hw/2)--
      else:
        (genji_hw/2,6-genji_hw/2)--
      fi
      cycle;
    dflt_genji_coords;
    Fill genji_path transformed genji_coords;
  fi;
enddef;

vardef gp(expr i,r) =
  gb(i);gf(r);ge;
enddef;

vardef gj(expr si,ei) =
  gb(si);gf(1);gr;if ei>si+1:gs(ei-si-1);fi;gr;gf(1);ge;
enddef;

vardef gtt(expr a,b) =
  gb(a);gf(b);gt;
enddef;

% #1 Kiritsubo
begintsuglyph("genjimon01",193);
  gbk(0,0);
  gj(1,3);
  gp(2,2);
  gj(4,5);
endtsuglyph;

% #2 Hahakigi
begintsuglyph("genjimon02",194);
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gp(3,1);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #3 Utsusemi
begintsuglyph("genjimon03",195);
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gp(3,1);
  gj(4,5);
endtsuglyph;

% #4 Yuugao
begintsuglyph("genjimon04",196);
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gj(3,4);
  gp(5,1);
endtsuglyph;

% #5 Wakamurasaki
begintsuglyph("genjimon05",197);
  gbk(0,0);
  gp(1,1);
  gj(2,3);
  gj(4,5);
endtsuglyph;

% #6 Suetsumuhana
begintsuglyph("genjimon06",198);
  gbk(0,0);
  gj(1,4);
  gtt(2,1);
  gtt(3,1);
  gp(5,1);
endtsuglyph;

% #7 Momiji no Ga
begintsuglyph("genjimon07",199);
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gtt(3,1);
  gp(4,2);
endtsuglyph;

% #8 Hana no En
begintsuglyph("genjimon08",200);
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gj(3,5);
  gp(4,2);
endtsuglyph;

% #9 Aoi
begintsuglyph("genjimon09",201);
  gbk(0,0);
  gj(1,2);
  gp(3,1);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #10 Sakaki
begintsuglyph("genjimon10",202);
  gbk(0,0);
  gj(1,3);
  gtt(2,1);
  gj(4,5);
endtsuglyph;

% #11 Hana Chiru Sato
begintsuglyph("genjimon11",203);
  gbk(0,1);
  gp(1,1);
  gj(2,4);
  gb(3);gf(2);gr;gx;gr;gf(2);ge;
endtsuglyph;

% #12 Suma
begintsuglyph("genjimon12",204);
  gbk(1,0);
  gb(1);gf(2);gr;gx;gs(1);gr;gf(2);ge;
  gj(2,5);
  gtt(3,2);
endtsuglyph;

% #13 Akashi
begintsuglyph("genjimon13",205);
  gbk(0,0);
  gp(1,1);
  gj(2,3);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #14 Miotsukushi
begintsuglyph("genjimon14",206);
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gp(3,2);
  gtt(4,1);
endtsuglyph;

% #15 Yomogyuu
begintsuglyph("genjimon15",207);
  gbk(0,0);
  gj(1,3);
  gtt(2,1);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #16 Sekiya
begintsuglyph("genjimon16",208);
  gbk(0,0);
  gp(1,1);
  gj(2,4);
  gtt(3,1);
  gp(5,1);
endtsuglyph;

% #17 Eawase
begintsuglyph("genjimon17",209);
  gbk(1,0);
  gb(1);gf(2);gr;gx;gr;gf(2);ge;
  gj(2,5);
  gp(4,2);
endtsuglyph;

% #18 Matsukaze
begintsuglyph("genjimon18",210);
  gbk(0,0);
  gj(1,2);
  gj(3,4);
  gp(5,1);
endtsuglyph;

% #19 Usugumo
begintsuglyph("genjimon19",211);
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gtt(3,1);
  gtt(4,1);
endtsuglyph;

% #20 Asagao
begintsuglyph("genjimon20",212);
  gbk(0,0);
  gj(1,4);
  gp(2,2);
  gtt(3,1);
  gp(5,1);
endtsuglyph;

% #21 Otome
begintsuglyph("genjimon21",213);
  gbk(0,0);
  gj(1,3);
  gp(2,2);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #22 Tamakazura
begintsuglyph("genjimon22",214);
  gbk(0,0);
  gj(1,2);
  gj(3,5);
  gtt(4,1);
endtsuglyph;

% #23 Hatsune
begintsuglyph("genjimon23",215);
  gbk(1,0);
  gb(1);gf(2);gr;gx;gr;gf(2);ge;
  gj(2,4);
  gp(5,1);
endtsuglyph;

% #24 Kochou
begintsuglyph("genjimon24",216);
  gbk(0,1);
  gj(1,4);
  gb(2);gf(2);gr;gs(1);gx;gr;gf(2);ge;
  gtt(3,2);
endtsuglyph;

% #25 Hotaru
begintsuglyph("genjimon25",217);
  gbk(0,0);
  gj(1,4);
  gtt(2,1);
  gp(3,2);
  gp(5,1);
endtsuglyph;

% #26 Tokonatsu
begintsuglyph("genjimon26",218);
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gj(3,5);
  gtt(4,1);
endtsuglyph;

% #27 Kagaribi
begintsuglyph("genjimon27",219);
  gbk(0,0);
  gp(1,1);
  gj(2,4);
  gp(3,2);
  gp(5,1);
endtsuglyph;

% #28 Nowaki
begintsuglyph("genjimon28",220);
  gbk(0,0);
  gj(1,2);
  gp(3,1);
  gj(4,5);
endtsuglyph;

% #29 Miyuki
begintsuglyph("genjimon29",221);
  gbk(0,2);
  gj(1,3);
  gb(2);gf(2);gr;gx;gs(1);gr;gf(2);ge;
  gtt(4,2);
endtsuglyph;

% #30 Fujibakama
begintsuglyph("genjimon30",222);
  gbk(0,0);
  gj(1,4);
  gp(2,2);
  gp(3,2);
  gp(5,1);
endtsuglyph;

% #31 Makibashira
begintsuglyph("genjimon31",223);
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gs(1);gr;gf(2);ge;
  gp(3,3);
endtsuglyph;

% #32 Umegae
begintsuglyph("genjimon32",224);
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gtt(3,1);
  gp(4,2);
endtsuglyph;

% #33 Fuji no Uraba
begintsuglyph("genjimon33",225);
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gb(3);gf(2);gr;gr;gf(2);ge;
endtsuglyph;

% #34 Wakana no Jou
begintsuglyph("genjimon34",226);
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gb(3);gf(2);gr;gr;gf(2);ge;
endtsuglyph;

% #35 Wakana no Ge
begintsuglyph("genjimon35",227);
  gbk(0,1);
  gj(1,4);
  gtt(2,1);
  gb(3);gf(2);gr;gx;gr;gf(2);ge;
endtsuglyph;

% #36 Kashiwagi
begintsuglyph("genjimon36",228);
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gtt(3,1);
  gp(4,2);
endtsuglyph;

% #37 Yokobue
begintsuglyph("genjimon37",229);
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gp(3,2);
  gtt(4,1);
endtsuglyph;

% #38 Suzumushi
begintsuglyph("genjimon38",230);
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gb(3);gf(2);gr;gr;gf(2);ge;
endtsuglyph;

% #39 Yuugiri
begintsuglyph("genjimon39",231);
  gbk(2,0);
  gb(1);gf(2);gr;gs(1);gx;gr;gf(2);ge;
  gp(2,3);
  gj(3,5);
endtsuglyph;

% #40 Minori
begintsuglyph("genjimon40",232);
  gbk(0,1);
  gj(1,4);
  gb(2);gf(2);gr;gs(1);gx;gr;gf(2);ge;
  gp(3,3);
endtsuglyph;

% #41 Maboroshi
begintsuglyph("genjimon41",233);
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gp(3,2);
  gp(4,2);
endtsuglyph;

% #42 Ninounomiya
begintsuglyph("genjimon42",234);
  gbk(2,0);
  gb(1);gf(2);gr;gs(1);gx;gr;gf(2);ge;
  gtt(2,2);
  gj(3,5);
endtsuglyph;

% #43 Koubai
begintsuglyph("genjimon43",235);
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gp(3,2);
  gp(4,2);
endtsuglyph;

% #44 Takegawa
begintsuglyph("genjimon44",236);
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gs(1);gr;gf(2);ge;
  gtt(3,2);
endtsuglyph;

% #45 Hashihime
begintsuglyph("genjimon45",237);
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gtt(3,1);
  gtt(4,1);
endtsuglyph;

% #46 Shii ga Moto
begintsuglyph("genjimon46",238);
  gbk(0,0);
  gj(1,4);
  gb(2);gf(2);gr;gr;gf(2);ge;
  gp(5,1);
endtsuglyph;

% #47 Agemaki
begintsuglyph("genjimon47",239);
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gr;gf(2);ge;
  gtt(4,1);
endtsuglyph;

% #48 Sawarabi
begintsuglyph("genjimon48",240);
  gbk(0,0);
  gj(1,2);
  gj(3,5);
  gp(4,2);
endtsuglyph;

% #49 Yadorigi
begintsuglyph("genjimon49",241);
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gp(3,2);
  gtt(4,1);
endtsuglyph;

% #50 Azumaya
begintsuglyph("genjimon50",242);
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gp(3,2);
  gp(4,2);
endtsuglyph;

% #51 Ukifune
begintsuglyph("genjimon51",243);
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gr;gf(2);ge;
  gp(4,2);
endtsuglyph;

% #52 Kagerou
begintsuglyph("genjimon52",244);
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gx;gr;gf(2);ge;
  gtt(3,1);
endtsuglyph;

% #53 Tenarai
begintsuglyph("genjimon53",245);
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gtt(3,1);
  gtt(4,1);
endtsuglyph;

% #54 Yume no Ukihashi
begintsuglyph("genjimon54",246);
  gbk(0,0);
  gb(1);gf(1);gr;gr;gf(1);gl;gl;gf(1);gr;gr;gf(1);gl;gl;gf(1);ge;
endtsuglyph;

endgroup;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
