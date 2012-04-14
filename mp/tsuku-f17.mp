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
if unknown genji_rounded:
  boolean genji_rounded;
  genji_rounded:=false;
fi;

path genji_background;

% gb(f) - start a line at the bottom in file f
vardef gb(expr f,gp) =
  begingroup
    save myxf,mygl;
    transform myxf;
    path mygl;
    myxf=identity scaled (genji_grid/2) shifted (whatever,whatever);
    ((3-f)*2,4) transformed myxf=centre_pt;
    if genji_rounded:
      mygl:=((0,-genji_hw){right}..(genji_hw,0){up}..
          {up}(gp shifted (0,1)){down}..
          {down}(-genji_hw,0)..{right}cycle) transformed myxf;
    else:
      mygl:=((0,-genji_hw)--(genji_hw,-genji_hw)--
          (gp shifted (0,1))--
          (-genji_hw,-genji_hw)--cycle) transformed myxf;
    fi;
    if genji_outline:
      unFill reverse mygl;
      save mybk,x,y,old_dir;
      path mybk;
      pair old_dir;
      mybk:=(0,genji_hw-1.99) transformed myxf;
      old_dir:=right;
      for i:=1 upto (length mygl)-1:
        numeric x[],y[];
        z1=(point i of mygl)-(precontrol i of mygl);
        z2=(postcontrol i of mygl)-(point i of mygl);
        z3=z1/abs(z1);
        z4=z2/abs(z2);
        if z3=z4:
          mybk:=mybk{old_dir}..
            {z3}((0.99-genji_hw)*genji_grid*(z4 rotated -90)
                +point i of mygl);
        else:
          mybk:=mybk{old_dir}..
            {z3}((0.99-genji_hw)*genji_grid*((z3+z4) rotated -90)
                +point i of mygl);
        fi;
        if (((point i of mybk)-(point (i-1) of mybk)) dotprod z3<0)
        or (((point i of mybk)-(point (i-1) of mybk)) dotprod old_dir<0):
          mybk:=(subpath (0,i-1) of mybk)--(point i of mybk);
        fi;
        if (length mybk)>3:
          z5=(subpath ((length mybk)-4,(length mybk)-3) of mybk)
              intersectiontimes
            (subpath ((length mybk)-1,(length mybk)) of mybk);
          if x5>0:
            mybk:=(subpath (0,(length mybk)-4+x5) of mybk)..
              (subpath ((length mybk)-1+y5,infinity) of mybk)
          fi;
        fi;
        if (length mybk)>3:
          z6=(subpath ((length mybk)-4,(length mybk)-3) of mybk)
              intersectiontimes
            (subpath ((length mybk)-2,(length mybk)-1) of mybk);
          if x6>0:
            mybk:=(subpath (0,(length mybk)-4+x6) of mybk)..
              (subpath ((length mybk)-2+y6,infinity) of mybk)
          fi;
        fi;
        old_dir:=z4;
      endfor;
      mybk:=regenerate(mybk{old_dir}..{right}cycle);
      dangerousFill mybk;
    else:
      Fill mygl;
    fi;
  endgroup;
enddef;

path ge_path[];
ge_path[0]=(genji_hw,0)--(genji_hw,genji_hw)--
  (-genji_hw,genji_hw)--(-genji_hw,0);
ge_path[1]=(genji_hw,0){up}..(0,genji_hw){left}..
  (-genji_hw,genji_hw)--(-genji_hw,0);
ge_path[2]=(genji_hw,0)--(genji_hw,genji_hw)--
  (0,genji_hw){left}..{down}(-genji_hw,0);
ge_path[3]=(genji_hw,0){up}..(0,genji_hw){left}..{down}(-genji_hw,0);

% ge(t) - end a line, style t
vardef ge(expr t) =
  if genji_rounded:
    ((genji_hw,0)..(ge_path[t] shifted (0,1))..(-genji_hw,0))
  else:
    ((genji_hw,0)..(ge_path[0] shifted (0,1))..(-genji_hw,0))
  fi
enddef;

% gf(d) - go forward d steps
vardef gf(expr d,gp) =
  ((genji_hw,0)--(gp shifted (0,2*d))--(-genji_hw,0))
enddef;

% gr(r) - turn to right, radius r
vardef gr(expr r,gp) =
  if genji_rounded and (r>=0):
    ((genji_hw,0){up}..
     (gp shifted (0,r+1) rotated -90 shifted (0,r+1))..
     {down}(-genji_hw,0))
  else:
    ((genji_hw,0)--(genji_hw,max(r,0)+1-genji_hw)--
     (gp shifted (0,max(r,0)+1) rotated -90 shifted (0,max(r,0)+1))--
     (-genji_hw,max(r,0)+1+genji_hw)--(-genji_hw,0))
  fi
enddef;

% gl(r) - turn to left, radius r
vardef gl(expr r,gp) =
  if genji_rounded and (r>=0):
    ((genji_hw,0)..
     (gp shifted (0,r+1) rotated 90 shifted (0,r+1))..
     (-genji_hw,0))
  else:
    ((genji_hw,0)--(genji_hw,max(r,0)+1+genji_hw)--
     (gp shifted (0,max(r,0)+1) rotated 90 shifted (0,max(r,0)+1))--
     (-genji_hw,max(r,0)+1-genji_hw)--(-genji_hw,0))
  fi
enddef;

% gt(gpa,gpb) - make a T-junction
vardef gt(expr gpa,gpb) =
  ((genji_hw,0)--(genji_hw,1-genji_hw)--
   (gpa shifted (0,1) rotated -90 shifted (0,1))--
   (genji_hw,1+genji_hw)--(gpb shifted (0,2))--(-genji_hw,0))
enddef;

% gx(gpa,gpb,gpc) - make an X-junction
vardef gx(expr gpa,gpb,gpc) =
  ((genji_hw,0)--(genji_hw,1-genji_hw)--
   (gpa shifted (0,1) rotated -90 shifted (0,1))--
   (genji_hw,1+genji_hw)--(gpb shifted (0,2))--(-genji_hw,1+genji_hw)--
   (gpc shifted (0,1) rotated 90 shifted (0,1))--
   (-genji_hw,1-genji_hw)--(-genji_hw,0))
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #1 Kiritsubo
begintsuglyph("genjimon01",193);
  gb(1,gf(2.5,gr(1,gr(1,gf(2.5,ge(3))))));
  gb(2,gf(2,ge(3)));
  gb(4,gf(3,gr(0,gr(0,gf(3,ge(3))))));
endtsuglyph;

% #2 Hahakigi
begintsuglyph("genjimon02",194);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,ge(3)));
  gb(3,gf(3,ge(3)));
  gb(4,gf(3,ge(3)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #3 Utsusemi
begintsuglyph("genjimon03",195);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,ge(3)));
  gb(3,gf(3,ge(3)));
  gb(4,gf(3,gr(0,gr(0,gf(3,ge(3))))));
endtsuglyph;

% #4 Yuugao
begintsuglyph("genjimon04",196);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,ge(3)));
  gb(3,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #5 Wakamurasaki
begintsuglyph("genjimon05",197);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(4,gf(3,gr(0,gr(0,gf(3,ge(3))))));
endtsuglyph;

% #6 Suetsumuhana
begintsuglyph("genjimon06",198);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gt(gf(3,ge(3)),
    gr(0,gf(3,ge(3))))))));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #7 Momiji no Ga
begintsuglyph("genjimon07",199);
  gb(1,gf(3,ge(3)));
  gb(4,gf(2,ge(1)));
  gb(2,gf(3,gr(0,gt(gf(3,ge(3)),gf(0.5,gr(1,gf(2.5,ge(3))))))));
endtsuglyph;

% #8 Hana no En
begintsuglyph("genjimon08",200);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,ge(3)));
  gb(3,gf(2.5,gr(1,gr(1,gf(2.5,ge(3))))));
  gb(4,gf(2,ge(3)));
endtsuglyph;

% #9 Aoi
begintsuglyph("genjimon09",201);
  gb(1,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(3,gf(3,ge(3)));
  gb(4,gf(3,ge(3)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #10 Sakaki
begintsuglyph("genjimon10",202);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gr(0,gf(3,ge(3)))))));
  gb(4,gf(3,gr(0,gr(0,gf(3,ge(3))))));
endtsuglyph;

% #11 Hana Chiru Sato
begintsuglyph("genjimon11",203);
  gb(1,gf(3,ge(3)));
  gb(2,gf(2,gr(2,gr(0,gx(gl(0,gf(2,ge(3))),
    gf(2,ge(3)),gr(0,gf(2,ge(3))))))));
endtsuglyph;

% #12 Suma
begintsuglyph("genjimon12",204);
  gb(1,gf(2,gr(0,gx(gf(2,ge(3)),gt(gf(2,ge(3)),
    gr(0,gf(2,ge(3)))),gr(0,gf(1,gr(2,gf(2,ge(3)))))))));
endtsuglyph;

% #13 Akashi
begintsuglyph("genjimon13",205);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(4,gf(3,ge(3)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #14 Miotsukushi
begintsuglyph("genjimon14",206);
  gb(1,gf(3,ge(3)));
  gb(2,gf(2.5,gr(1,gf(0.5,gt(gf(3,ge(3)),gr(0,gf(3,ge(3))))))));
  gb(3,gf(2,ge(2)));
endtsuglyph;

% #15 Yomogyuu
begintsuglyph("genjimon15",207);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gr(0,gf(3,ge(3)))))));
  gb(4,gf(3,ge(3)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #16 Sekiya
begintsuglyph("genjimon16",208);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,gr(0,gt(gf(3,ge(3)),gr(0,gf(3,ge(3)))))));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #17 Eawase
begintsuglyph("genjimon17",209);
  gb(1,gf(2,gr(0,gx(gf(2,ge(3)),gr(-1,gf(2,ge(3))),
    gr(0,gf(1.5,gr(1,gf(2.5,ge(3)))))))));
  gb(4,gf(2,ge(1)));
endtsuglyph;

% #18 Matsukaze
begintsuglyph("genjimon18",210);
  gb(1,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(3,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #19 Usugumo
begintsuglyph("genjimon19",211);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,gr(0,gt(gf(3,ge(3)),gt(gf(3,ge(3)),
    gr(0,gf(3,ge(3))))))));
endtsuglyph;

% #20 Asagao
begintsuglyph("genjimon20",212);
  gb(1,gf(2.5,gr(1,gf(0.5,gt(gf(3,ge(3)),gr(0,gf(3,ge(3))))))));
  gb(2,gf(2,ge(2)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #21 Otome
begintsuglyph("genjimon21",213);
  gb(1,gf(2.5,gr(1,gr(1,gf(2.5,ge(3))))));
  gb(2,gf(2,ge(3)));
  gb(4,gf(3,ge(3)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #22 Tamakazura
begintsuglyph("genjimon22",214);
  gb(1,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(3,gf(3,gr(0,gt(gf(3,ge(3)),gr(0,gf(3,ge(3)))))));
endtsuglyph;

% #23 Hatsune
begintsuglyph("genjimon23",215);
  gb(1,gf(2,gr(0,gx(gf(2,ge(3)),gr(0,gf(2,ge(3))),
    gr(0,gr(2,gf(2,ge(3))))))));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #24 Kochou
begintsuglyph("genjimon24",216);
  gb(1,gf(2,gr(2,gf(1,gr(0,gx(reverse gt(gf(2,ge(3)),
    gr(0,gf(2,ge(3)))) xscaled -1,gf(2,ge(3)),
    gr(0,gf(2,ge(3)))))))));
endtsuglyph;

% #25 Hotaru
begintsuglyph("genjimon25",217);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gf(0.5,gr(1,gf(2.5,ge(3))))))));
  gb(3,gf(2,ge(1)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #26 Tokonatsu
begintsuglyph("genjimon26",218);
  gb(1,gf(3,ge(3)));
  gb(2,gf(3,ge(3)));
  gb(3,gf(3,gr(0,gt(gf(3,ge(3)),gr(0,gf(3,ge(3)))))));
endtsuglyph;

% #27 Kagaribi
begintsuglyph("genjimon27",219);
  gb(1,gf(3,ge(3)));
  gb(2,gf(2.5,gr(1,gr(1,gf(2.5,ge(3))))));
  gb(3,gf(2,ge(3)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #28 Nowaki
begintsuglyph("genjimon28",220);
  gb(1,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(3,gf(3,ge(3)));
  gb(4,gf(3,gr(0,gr(0,gf(3,ge(3))))));
endtsuglyph;

% #29 Miyuki
begintsuglyph("genjimon29",221);
  gb(1,gf(2,gr(2,gr(0,gx(gl(0,gf(2,ge(3))),
    gf(2,ge(3)),gt(gf(2,ge(3)),gr(0,gf(2,ge(3)))))))));
endtsuglyph;

% #30 Fujibakama
begintsuglyph("genjimon30",222);
  gb(1,gf(2.5,gr(1,gf(1,gr(1,gf(2.5,ge(3)))))));
  gb(2,gf(2,ge(2)));
  gb(3,gf(2,ge(1)));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #31 Makibashira
begintsuglyph("genjimon31",223);
  gb(1,gf(1.5,gr(3,gr(3,gf(1.5,ge(3))))));
  gb(2,gf(1.5,gr(1,gr(1,gf(1.5,ge(3))))));
  gb(3,gf(1,ge(3)));
endtsuglyph;

% #32 Umegae
begintsuglyph("genjimon32",224);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gt(gf(3,ge(3)),gf(0.5,
    gr(1,gf(2.5,ge(3)))))))));
  gb(4,gf(2,ge(1)));
endtsuglyph;

% #33 Fuji no Uraba
begintsuglyph("genjimon33",225);
  gb(1,gf(3,ge(3)));
  gb(2,gf(2,gr(2,gr(2,gf(2,ge(3))))));
  gb(3,gf(2,gr(0,gr(0,gf(2,ge(3))))));
endtsuglyph;

% #34 Wakana no Jou
begintsuglyph("genjimon34",226);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gf(1,
    gr(2,gf(2,ge(3))))))));
  gb(3,gf(2,gr(-1,gr(0,gf(2,ge(3))))));
endtsuglyph;

% #35 Wakana no Ge
begintsuglyph("genjimon35",227);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gf(1,
    gr(0,gx(gl(-1,gf(2,ge(3))),gf(2,ge(3)),gr(0,gf(2,ge(3))))))))));
endtsuglyph;

% #36 Kashiwagi
begintsuglyph("genjimon36",228);
  gb(1,gf(2.5,gr(1,gf(0.5,gt(gf(3,ge(3)),
    gf(0.5,gr(1,gf(2.5,ge(3)))))))));
  gb(2,gf(2,ge(2)));
  gb(4,gf(2,ge(1)));
endtsuglyph;

% #37 Yokobue
begintsuglyph("genjimon37",229);
  gb(1,gf(2.5,gr(1,gf(1.5,gt(gf(3,ge(3)),
    gr(0,gf(3,ge(3))))))));
  gb(2,gf(2,ge(2)));
  gb(3,gf(2,ge(0)));
endtsuglyph;

% #38 Suzumushi
begintsuglyph("genjimon38",230);
  gb(1,gf(2.5,gr(1,gf(1.5,gr(2,gf(2,ge(3)))))));
  gb(2,gf(2,ge(2)));
  gb(3,gf(2,gr(-1,gr(0,gf(2,ge(3))))));
endtsuglyph;

% #39 Yuugiri
begintsuglyph("genjimon39",231);
  gb(1,gf(1.5,gr(1,gf(0.5,gx(gf(2,ge(3)),gr(0,gf(2,ge(3))),
    gr(0,gr(2,gf(2,ge(3)))))))));
  gb(2,gf(1,ge(2)));
endtsuglyph;

% #40 Minori
begintsuglyph("genjimon40",232);
  gb(1,gf(1.5,gr(3,gf(0.5,gr(0,gx(gf(0.5,gl(1,gf(1.5,ge(3)))),
    gf(2,ge(3)),gr(0,gf(2,ge(3)))))))));
  gb(3,gf(1,ge(2)));
endtsuglyph;

% #41 Maboroshi
begintsuglyph("genjimon41",233);
  gb(1,gf(2.5,gr(1,gf(2,gr(1,gf(2.5,ge(3)))))));
  gb(2,gf(2,ge(2)));
  gb(3,gf(2,ge(0)));
  gb(4,gf(2,ge(1)));
endtsuglyph;

% #42 Ninounomiya
begintsuglyph("genjimon42",234);
  gb(1,gf(2,gr(0,gt(gf(2,ge(3)),gx(gf(2,ge(3)),gr(0,gf(2,ge(3))),
    gr(0,gr(2,gf(2,ge(3)))))))));
endtsuglyph;

% #43 Koubai
begintsuglyph("genjimon43",235);
  gb(1,gf(3,ge(3)));
  gb(2,gf(2.5,gr(1,gf(1,gr(1,gf(2.5,ge(3)))))));
  gb(3,gf(2,ge(2)));
  gb(4,gf(2,ge(1)));
endtsuglyph;

% #44 Takegawa
begintsuglyph("genjimon44",236);
  gb(1,gf(2,gr(2,gf(1,gr(2,gf(2,ge(3)))))));
  gb(2,gf(2,gr(0,gt(gf(2,ge(3)),gr(0,gf(2,ge(3)))))));
endtsuglyph;

% #45 Hashihime
begintsuglyph("genjimon45",237);
  gb(1,gf(2.5,gr(1,gf(0.5,gt(gf(3,ge(3)),gt(gf(3,ge(3)),
    gr(0,gf(3,ge(3)))))))));
  gb(2,gf(2,ge(2)));
endtsuglyph;

% #46 Shii ga Moto
begintsuglyph("genjimon46",238);
  gb(1,gf(2,gr(2,gr(2,gf(2,ge(3))))));
  gb(2,gf(2,gr(0,gr(0,gf(2,ge(3))))));
  gb(5,gf(3,ge(3)));
endtsuglyph;

% #47 Agemaki
begintsuglyph("genjimon47",239);
  gb(1,gf(2,gr(2,gf(1,gt(gf(3,ge(3)),gr(0,gf(3,ge(3))))))));
  gb(2,gf(2,gr(0,gr(-1,gf(2,ge(3))))));
endtsuglyph;

% #48 Sawarabi
begintsuglyph("genjimon48",240);
  gb(1,gf(3,gr(0,gr(0,gf(3,ge(3))))));
  gb(3,gf(2.5,gr(1,gr(1,gf(2.5,ge(3))))));
  gb(4,gf(2,ge(3)));
endtsuglyph;

% #49 Yadorigi
begintsuglyph("genjimon49",241);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gf(1,gt(gf(3,ge(3)),
    gr(0,gf(3,ge(3)))))))));
  gb(3,gf(2,ge(0)));
endtsuglyph;

% #50 Azumaya
begintsuglyph("genjimon50",242);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gf(1.5,gr(1,gf(2.5,ge(3))))))));
  gb(3,gf(2,ge(0)));
  gb(4,gf(2,ge(1)));
endtsuglyph;

% #51 Ukifune
begintsuglyph("genjimon51",243);
  gb(1,gf(2,gr(2,gf(1,gt(gf(3,ge(3)),gr(0,gf(3,ge(3))))))));
  gb(2,gf(2,gr(0,gr(-1,gf(2,ge(3))))));
endtsuglyph;

% #52 Kagerou
begintsuglyph("genjimon52",244);
  gb(2,gf(2,gr(2,gt(gx(gl(0,gf(2,ge(3))),
    gf(2,ge(3)),gr(0,gf(2,ge(3)))),gr(2,gf(2,ge(3)))))));
endtsuglyph;

% #53 Tenarai
begintsuglyph("genjimon53",245);
  gb(1,gf(3,gr(0,gt(gf(3,ge(3)),gt(gf(3,ge(3)),gt(gf(3,ge(3)),
    gr(0,gf(3,ge(3)))))))));
endtsuglyph;

% #54 Yume no Ukihashi
begintsuglyph("genjimon54",246);
  gb(1,gf(3,gr(0,gr(0,gf(3,gl(0,gl(0,gf(3,gr(0,gr(0,gf(3,
    gl(0,gl(0,gf(3,ge(3)))))))))))))));
endtsuglyph;

endgroup;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
