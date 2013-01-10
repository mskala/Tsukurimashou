%
% Latin and related letters for Tsukurimashou
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

inclusion_lock(latin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef latin.upa =
  push_pbox_toexpand("latin.upa");
  z1=(200,latin_wide_low_v);
  z2=(500,latin_wide_high_v);
  z3=(800,latin_wide_low_v);

  if do_alternation:
    z4=whatever[z1,(z2+alternate_adjust*left/2)]+(2,0);
    z5=whatever[(z2+alternate_adjust*right/2),z3]-(2,0);
    y4=y5=vmetric(0.333);

    push_stroke(z1--(z2+alternate_adjust*left/2),(1.6,1.6)--(1.6,1.6));
    set_boalternate(0);
    set_botip(0,1,0);
    set_boserif(0,0,3);
    set_boserif(0,1,1);

    push_stroke(z4--z5,(1.6,1.6)--(1.6,1.6));
    set_boalternate(0);

    push_stroke((z2+alternate_adjust*right/2)--z3,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,3);
  else:
    z4=whatever[z1,z2]+(2,0);
    z5=whatever[z2,z3]-(2,0);
    y4=y5=vmetric(0.333);

    push_stroke(z1--z2--z3,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
    set_boserif(0,0,3);
    set_boserif(0,1,1);
    set_boserif(0,2,3);

    push_stroke(z4--z5,(1.6,1.6)--(1.6,1.6));
  fi;

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upae =
  push_pbox_toexpand("latin.upae");
  y1=y2=latin_wide_high_h;
  y3=y4=latin_wide_low_h;
  y5=y6=vmetric(0.522);

  (x1+x7)/2=500;
  x2=x3;
  x1=x4;
  x5=x2+2;
  x6=0.89[x2,x1];
  (x1-x2)=(y2-y3)*0.55;

  y7=latin_wide_low_v;
  x7=(-1.6)[x2,x1];
  z10=(-0.2)[z2,z1]+2.2*alternate_adjust*left;
  z8=whatever[z7,z10];
  z9=whatever[z2,z3];
  y8=y9=vmetric(0.250);

  push_stroke(z1--z10--z7,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_boserif(0,1,1);
  set_boserif(0,2,3);
  set_boalternate(0);

  push_stroke(z8--z9,(1.6,1.6)--(1.6,1.6));
  set_boalternate(0);

  push_stroke(z2--z3--z4,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_boserif(0,1,1);

  push_stroke(z5--z6,(1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upb =
  push_pbox_toexpand("latin.upb");
  latin.upp_base(340);

  x6=x5;
  x7=0.61[x5,x3];
  x8=x5+400;

  y6=y7=latin_wide_low_h;
  y8=0.5[y6,y1];

  z9=z2;

  replace_strokep(0)(oldp--z6--z7{right}..z8..{left}z9);
  replace_strokep(0)(subpath (0,7.97) of oldp);
  replace_strokeq(0)(oldq--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));

  set_botip(0,4,1);
  set_botip(0,5,1);
  set_boserif(0,4,1);
  set_boserif(0,5,1);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors((ai=anc_ring) or (ai=anc_upper))((-27,0));
  expand_pbox;
enddef;

vardef latin.upc =
  push_pbox_toexpand("latin.upc");
  push_stroke(
    (subpath (0.5,3.5) of ((1,0)..(0,1)..(-1,0)..(0,-1)..cycle))
       scaled ((latin_wide_high_r-latin_wide_low_r)/2)
       shifted (centre_pt+(50,0)),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper])+(46,0));
  expand_pbox;
enddef;

vardef latin.upd =
  push_pbox_toexpand("latin.upd");
  y1=y5=latin_wide_high_h;
  y2=y3=latin_wide_low_h;
  y4=0.52[y2,y1];

  (x1+x4)/2=510;
  (x4-x1)=0.85*(y1-y2);
  x1=x2;
  x3=x5=0.35[x1,x4];

  push_stroke(z4..{left}z5--z1--z2--z3{right}..cycle,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_boserif(0,2,1);
  set_boserif(0,3,1);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(true)((-50,0));
  expand_pbox;
enddef;

vardef latin.upeth =
  push_pbox_toexpand("latin.upeth");
  latin.upd;
  push_stroke((0.5[z1,z2]+(-170,0))--(0.5[z1,z2]+(220,0)),
    (1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upe =
  push_pbox_toexpand("latin.upe");
  y1=y2=latin_wide_high_h;
  y3=y4=latin_wide_low_h;
  y5=y6=vmetric(0.522);

  (x1+x2)/2=520;
  x2=x3;
  x1=x4;
  x5=x2+2;
  x6=0.89[x2,x1];
  (x1-x2)=(y2-y3)*0.6;

  push_stroke(z1--z2--z3--z4,(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,1);
  set_boserif(0,2,1);

  push_stroke(z5--z6,(1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upf =
  push_pbox_toexpand("latin.upf");
  y1=y2=latin_wide_high_h;
  y3=latin_wide_low_v;
  y4=y5=vmetric(0.54);

  (x1+x2)/2=510;
  x3=x2;
  x4=x2+2;
  x5=0.82[x2,x1];
  (x1-x2)=(y2-y3)*0.6;

  push_stroke(z1--z2--z3,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_boserif(0,1,1);
  set_boserif(0,2,3);

  push_stroke(z4--z5,(1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper])+(-20,0));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((-220,0));
  expand_pbox;
enddef;

vardef latin.upg =
  push_pbox_toexpand("latin.upg");
  push_stroke(
    (subpath (0.53,3.47) of ((1,0)..(0,1)..(-1,0)..(0,-1)..cycle))
       scaled ((latin_wide_high_r-latin_wide_low_r)/2)
       shifted (centre_pt+(55,0)),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6));

  x1=xpart point 4 of get_strokep(0);
  y1=y2=vmetric(0.44);
  x1-x2=y1-(ypart point 4 of get_strokep(0))*1.0;

  replace_strokep(0)(oldp--z1--z2);
  set_botip(0,4,1);
  set_botip(0,5,1);


  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper])+(44,0));
  tsu_accent.shift_anchors(ypart olda<vmetric(0.52))((100,0));
  expand_pbox;
enddef;

vardef latin.uph =
  push_pbox_toexpand("latin.uph");
  z1=(260,latin_wide_high_v);
  z2=(740,latin_wide_high_v);
  z3=(260,latin_wide_low_v);
  z4=(740,latin_wide_low_v);

  z5=whatever[z1,z3];
  z6=whatever[z2,z4];
  y5=y6=vmetric(0.5);

  push_stroke(z1--z3,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,3);
  set_boserif(0,1,3);

  push_stroke(z2--z4,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,3);
  set_boserif(0,1,3);

  push_stroke(z5--z6,(1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((220,0));
  expand_pbox;
enddef;

vardef latin.upi =
  push_pbox_toexpand("latin.upi");
  push_stroke((500,latin_wide_high_h-2)--(500,latin_wide_low_h+2),
    (1.6,1.6)--(1.6,1.6));

  push_stroke((300,latin_wide_high_h)--(700,latin_wide_high_h),
    (1.6,1.6)--(1.6,1.6));

  push_stroke((300,latin_wide_low_h)--(700,latin_wide_low_h),
    (1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upj =
  push_pbox_toexpand("latin.upj");
  z1=(550,latin_wide_high_h-2);
  z2=(550,latin_wide_low_h+75);
  z3=z2+(-300,-200);

  push_stroke((z1--z2)..{curl 0.8}z3,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(insert_nodes(oldp)(1.5));

  push_stroke((365,latin_wide_high_h)--(710,latin_wide_high_h),
    (1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors(true)((50,0));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper])+(-10,0));
  tsu_accent.shift_anchors(ai=anc_lower)((30,0));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((-100,-120));
  expand_pbox;
enddef;

vardef latin.upij =
  push_pbox_toexpand("latin.upij");
  tsu_xform(identity shifted (-250,0))(latin.upi);
  tsu_xform(identity shifted (200,0))(latin.upj);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upk =
  push_pbox_toexpand("latin.upk");
  z1=(290,latin_wide_high_v);
  z2=(290,latin_wide_low_v);
  z3=(670,0.5[latin_wide_high_h,latin_wide_high_v]);
  x4=290+mbrush_width*if sharp_corners: 2.7 else: 2.3 fi;
  y4=vmetric(0.5);
  z5=(720,0.5[latin_wide_low_h,latin_wide_low_v]);

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,1);
  set_boserif(0,1,3);

  push_stroke(z3--(0.7[z3,z4])--z4--z5,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,2,1);
  if do_alternation:
    set_boalternate(0);
    set_boserif(0,0,3);
    set_boserif(0,3,3);
  fi;

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper])+(-30,0));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((170,0));
  expand_pbox;
enddef;

vardef latin.upl =
  push_pbox_toexpand("latin.upl");
  y1=latin_wide_high_v;
  y2=y3=latin_wide_low_h;
  x1=x2;
  (x1+x3)/2=520;
  (x3-x1)=(y1-y2)*0.6;

  push_stroke(z1--z2--z3,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_boserif(0,0,1);
  set_boserif(0,1,3);

  tsu_accent.shift_anchors((ypart olda>vmetric(0.52))
                           and not (ai=anc_caron_comma))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_caron_comma)((-160,40));
  expand_pbox;
enddef;

vardef latin.upm =
  push_pbox_toexpand("latin.upm");
  y1=y5=latin_wide_low_v;
  y2=y4=latin_wide_high_v;
  y3=(y1+y2)/2;

  if do_alternation:
    x1=x2;
    x3=500+alternate_adjust/2;
    x4=x5;
    (x3-x1)=(x5-x3);

    (x5-x1)=(y2-y1);

    push_stroke((z1--z2) shifted (alternate_adjust*left),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,3);
    set_boserif(0,1,1);
    set_boalternate(0);

    push_stroke(z2--(z3+alternate_adjust*left),(1.6,1.6)--(1.6,1.6));

    push_stroke(z3--(z4+alternate_adjust*left),(1.6,1.6)--(1.6,1.6));
    set_boalternate(0);

    push_stroke(z4--z5,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,3);
  else:
    x1=x2;
    x3=500;
    x4=x5;
    (x3-x1)=(x5-x3);

    (x5-x1)=(y2-y1);

    push_stroke(z1--z2--z3--z4--z5,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
    set_botip(0,2,0);
    set_botip(0,3,0);
    set_boserif(0,0,3);
    set_boserif(0,1,1);
    set_boserif(0,4,3);
  fi;

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((350,0));
  expand_pbox;
enddef;

vardef latin.upn =
  push_pbox_toexpand("latin.upn");
  y1=y3=latin_wide_low_v;
  y2=y4=latin_wide_high_v;

  x1=x2;
  x3=x4;
  (x1+x3)/2=500;
  (x3-x1)=(y2-y1)*4/5;

  if do_alternation:
    push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,3);
    set_boserif(0,1,1);
    set_boalternate(0);

    push_stroke((z2+alternate_adjust*right)--(z3+alternate_adjust*left),
      (1.6,1.6)--(1.6,1.6));

    push_stroke(z3--z4,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,3);
    set_boalternate(0);
  else:
    push_stroke(z1--z2--z3--z4,(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
    set_botip(0,2,0);
    set_boserif(0,0,3);
    set_boserif(0,1,1);
    set_boserif(0,3,3);
  fi;

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((250,0));
  expand_pbox;
enddef;

vardef latin.upeng =
  push_pbox_toexpand("latin.upeng");
  latin.upn;
  y5=latin_wide_desc_h;
  if do_alternation:
    x5=x3-alternate_adjust-300;
    replace_strokep(-1)(oldp{dir 268}..{curl 0.8}z5);
    replace_strokep(-1)(insert_nodes(oldp)(1.3));
    replace_strokeq(-1)(oldq--(1.6,1.6)--(1.6,1.6));
  else:
    x5=x3-300;
    push_stroke(z3{dir 268}..{curl 0.8}z5,(1.6,1.6)--(1.6,1.6));
    replace_strokep(0)(insert_nodes(oldp)(0.3));
  fi;

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upo =
  push_pbox_toexpand("latin.upo");
  push_stroke(
    ((1,0)..(0,1)..(-1,0)..(0,-1)..cycle)
    scaled ((latin_wide_high_r-latin_wide_low_r)/2)
    shifted centre_pt,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upoe =
  push_pbox_toexpand("latin.upoe");
  tsu_xform(identity shifted (280,0))(latin.upe);
  set_boserif(-1,1,whatever);
  set_boserif(-1,2,whatever);
  push_stroke(
    ((1,0)..(0,1)..(-1,0)..(0,-1)..(1,0))
       scaled ((latin_wide_high_h-latin_wide_low_h)/2)
       shifted (360,0.5[latin_wide_high_h,latin_wide_low_h]),
    (1.2,1.2)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.2,1.2));
  replace_strokep(0)(
    subpath (xpart (oldp intersectiontimes get_strokep(-2)),
             4-xpart ((reverse oldp) intersectiontimes get_strokep(-2)))
    of oldp);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upp_base(expr b) =
  x1=x5+2;
  x5=340;
  x2=x4=x5+b*0.4;
  x3=x5+b;

  y1=y2=vmetric(0.52);
  y3=(y2+y4)/2;
  y4=y5=latin_wide_high_h;

  push_stroke(z1--z2{right}..z3..{left}z4--z5,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
enddef;

vardef latin.upp =
  push_pbox_toexpand("latin.upp");
  latin.upp_base(375);
  replace_strokep(0)(oldp--(xpart point infinity of oldp,latin_wide_low_v));
  replace_strokeq(0)(oldq--(1.6,1.6));
  set_botip(0,4,1);
  set_boserif(0,4,1);
  set_boserif(0,5,3);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper])+(-20,0));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((-180,0));
  expand_pbox;
enddef;

vardef latin.upq =
  push_pbox_toexpand("latin.upq");
  push_stroke(((1,0)..(0,1)..(-1,0)..(0,-1)..cycle)
    scaled ((latin_wide_high_r-latin_wide_low_r)/2)
    shifted centre_pt,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);

  z1=point 2.9 of get_strokep(0);
  z2=z1+(350,-150);
  z3=z2+(50,25);
  push_stroke(subpath (0.02,2) of (z1{curl 0}..z2..z3),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(insert_nodes(oldp)(0.4));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_lower)((-80,0));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((100,-140));
  expand_pbox;
enddef;

vardef latin.upr =
  push_pbox_toexpand("latin.upr");
  latin.upp_base(360);
  replace_strokep(0)(oldp--(xpart point infinity of oldp,latin_wide_low_v));
  replace_strokeq(0)(oldq--(1.6,1.6));
  set_botip(0,4,1);
  set_boserif(0,4,1);
  set_boserif(0,5,3);

  push_stroke((point 0.2 of get_strokep(0)){right}..(630,310)..
    tension 3..(820,latin_wide_low_v),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(insert_nodes(oldp)(1.95));
  set_boserif(0,3,3);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((-200,0));
  expand_pbox;
enddef;

vardef latin.ups =
  push_pbox_toexpand("latin.ups");
  transform ta,tb;
  path mycurve;

  mycurve:=(1,0)..(0,1)..(-1,0);

  y2=latin_wide_high_r;
  y0=y3=vmetric(0.77);
  y4=vmetric(0.53);
  y5=y8=vmetric(0.25);
  y6=latin_wide_low_r;

  0.48[x1,x7]=0.48[x2,x6]=0.48[x3,x5]=x4=500;
  x5-x1=20;
  x5-x7=(y2-y6)*0.55;

  (point 0 of mycurve) transformed ta=z0;
  (point 0.35 of mycurve) transformed ta=z1;
  (point 1 of mycurve) transformed ta=z2;
  (point 2 of mycurve) transformed ta=z3;
  xypart ta=0;

  (point 0 of mycurve) transformed tb=z8;
  (point 0.35 of mycurve) transformed tb=z7;
  (point 1 of mycurve) transformed tb=z6;
  (point 2 of mycurve) transformed tb=z5;

  mycurve:=subpath (0.35,2) of mycurve;

  push_stroke((mycurve transformed ta)..z4..(reverse mycurve transformed tb),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)
      --(1.6,1.6));

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper])+(10,0));
  expand_pbox;
enddef;

vardef latin.upt =
  push_pbox_toexpand("latin.upt");
  z1=(190,latin_wide_high_h);
  z2=(500,latin_wide_high_h);
  z3=(810,latin_wide_high_h);
  z4=(500,latin_wide_low_v);

  push_stroke(z1--z3,(1.6,1.6)--(1.6,1.6));

  push_stroke(z2--z4,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,3);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upthorn =
  push_pbox_toexpand("latin.upthorn");
  latin.upp_base(375);
  replace_strokep(0)(oldp
    shifted (-llcorner oldp) yscaled 0.9
    shifted ((llcorner oldp)+(0,vmetric(0)-vmetric(0.18))));
  push_stroke((xpart point infinity of get_strokep(0),latin_wide_high_v)
    --(xpart point infinity of get_strokep(0),latin_wide_low_v),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,3);
  set_boserif(0,1,3);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upu =
  push_pbox_toexpand("latin.upu");
  x1=x2;
  x3=500;
  x4=x5;
  (x1+x5)/2=x3;
  (x5-x1)=(y1-y3)*0.83;

  y1=y5=latin_wide_high_v;
  y2=y4;
  y2-y3=x3-x2;
  y3=latin_wide_low_r;

  push_stroke(z1--z2{dir 274}..z3..{dir 86}z4--z5,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,3);
  set_boserif(0,4,3);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upv =
  push_pbox_toexpand("latin.upv");
  (x1+x3)/2=x2=500;

  y1=y3=latin_wide_high_v;
  y2=latin_wide_low_v;

  (x3-x1)=(y1-y2)*0.8;

  if do_alternation:
    push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,3);

    push_stroke((z2+alternate_adjust*right)--z3,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,3);
    set_boalternate(0);
  else:
    push_stroke(z1--(0.95[z1,z2])--z2--z3,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,2,0);
    set_boserif(0,0,3);
    set_boserif(0,3,3);
  fi;

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upw =
  push_pbox_toexpand("latin.upw");
  if do_alternation:
    (x1+x5)/2=(x2+x4)/2=x3=500-alternate_adjust/2;
    (x3-x2)=(x2-x1);

    y1=y3=y5=latin_wide_high_v;
    y2=y4=latin_wide_low_v;

    (x5-x1)=(y1-y2)*1.25-(3*alternate_adjust);

    push_stroke((z1--z2) shifted (alternate_adjust*left),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,3);

    push_stroke(z2--z3,(1.6,1.6)--(1.6,1.6));
    set_boalternate(0);

    push_stroke((z3--z4) shifted (alternate_adjust*right),
      (1.6,1.6)--(1.6,1.6));

    push_stroke((z4--z5) shifted (alternate_adjust*right*2),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,3);
    set_boalternate(0);
  else:
    (x1+x5)/2=(x2+x4)/2=x3=500;
    (x3-x2)=(x2-x1);

    y1=y3=y5=latin_wide_high_v;
    y2=y4=latin_wide_low_v;

    (x5-x1)=(y1-y2)*1.25;

    push_stroke(z1--z2--z3--z4--z5,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
    set_botip(0,2,0);
    set_botip(0,3,0);
    set_boserif(0,0,3);
    set_boserif(0,4,3);
  fi;

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((230,0));
  expand_pbox;
enddef;

vardef latin.upx =
  push_pbox_toexpand("latin.upx");
  (x1+x3)/2=500;
  (x2+x4)/2=500;
  (x2+x3-x1-x4)=((y1-y2)*0.9)*2;
  (x3-x1)=(x2-x4)*0.93;

  y1=y3=latin_wide_high_v;
  y2=y4=latin_wide_low_v;

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,3);
  set_boserif(0,1,3);

  if do_alternation:
    push_stroke(z3--(0.5[z3,z4]+alternate_adjust*right/4)
      --(0.5[z3,z4]+alternate_adjust*left/4)--z4,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,3);
    set_boserif(0,3,3);
  else:
    push_stroke(z3--z4,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,3);
    set_boserif(0,1,3);
  fi;
  set_boalternate(0);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((260,0));
  expand_pbox;
enddef;

vardef latin.upy =
  push_pbox_toexpand("latin.upy");
  (x3+x1)/2=x2=x4=if do_alternation: 500-alternate_adjust/2 else: 500 fi;
  (x3-x1)=0.77*(y1-y4);

  y1=y3=latin_wide_high_v;
  y2=vmetric(0.52);
  y4=latin_wide_low_v;

  push_stroke(z1--z2--z4,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,0);
  set_boserif(0,0,3);
  set_boserif(0,2,3);

  if do_alternation:
    push_stroke((z2--z3) shifted (alternate_adjust*right),
      (1.6,1.6)--(1.6,1.6));
  else:
    push_stroke(z2--z3,(1.6,1.6)--(1.6,1.6));
  fi;
  set_boserif(0,1,3);
  set_boalternate(0);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

vardef latin.upz =
  push_pbox_toexpand("latin.upz");
  y1=y2=latin_wide_high_h;
  y3=y4=latin_wide_low_h;

  x1=x3;
  x2=x4;
  (x1+x2)/2=500;
  (x2-x1)=(y1-y3)*0.86;

  push_stroke(z1--z2--z3--z4,(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,0);
  set_botip(0,2,0);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef latin.double_lowa =
  push_pbox_toexpand("latin.double_lowa");
  x1=(-0.12)[x6,x3];
  x3=x4=x5=x8;
  0.51[x6,x3]=500;
  x3-x1=0.82*(y2-y4);
  x2=0.63[x6,x3];
  x7=0.36[x6,x3];

  y1=0.7[y4,y2];
  y3=0.77[y4,y2];
  y2=latin_wide_xheight_r;
  y4=latin_wide_low_v;
  y5=0.68[y4,y2];
  y6=0.32[y7,y5];
  y7=latin_wide_low_h;
  y8=0.3[y4,y2];

  push_stroke(z1{curl 0.2}..z2{right}..z3{down}..z4,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0.2,3) of oldp);
  set_boserif(0,3,2);

  push_stroke(z5{dir 240}..z6{down}..z7{right}..z8,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0,2.97) of oldp);
  replace_strokep(0)(insert_nodes(oldp)(0.5));

  tsu_accent.shift_anchors(true)((12,0));
  tsu_accent.shift_anchors(ai=anc_ring)((28,0));
  expand_pbox;
enddef;

vardef latin.single_lowa =
  push_pbox_toexpand("latin.single_lowa");
  (x1+x4)/2=520;
  (x1-x4)=(y3-y1)*0.81;
  x1=x6-8;
  x3=0.4[x1,x4];
  x5=0.36[x4,x1];

  y1=latin_wide_low_v;
  y3=latin_wide_xheight_h;
  y4=0.47[y5,y3];
  y5=latin_wide_low_h;
  y6=0.37[y1,y3];

  z7=(x1,y3);
  z2=0.3[z7,0.5[z3,z1]];
  
  push_stroke(interpath(0.5)
      (z1{up}..{up}z7{left}..{left}z3..{down}z4..{right}z5..z6,
       z1{up}..z2..{left}z3..{down}z4..{right}z5..z6),
    (1.3,1.3)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(reverse(insert_nodes(oldp)(0.5)));
  set_boserif(0,6,if do_italic_hook: 11 else: 2 fi);
  set_botip(0,4,1);
  expand_pbox;
enddef;

vardef latin.lowa =
  latin.double_lowa;
enddef;

vardef latin.lowae =
  push_pbox_toexpand("latin.lowae");
  begingroup
    save saved_sp;
    save astem,abowl,astroke,estroke,etop,ebot;
    path astem,abowl,astroke,estroke,etop,ebot;
    saved_sp:=sp;
    
    latin.double_lowa;
    set_boserif(-1,3,whatever);
    astem:=get_strokep(-1);
    abowl:=get_strokep(0);
    
    numeric x[],y[];
    latin.lowe;
    estroke:=get_strokep(0);
    
    for i=saved_sp upto sp-1:
      obstacktype[i]:=otnull;
    endfor;
    
    astroke:=(subpath (0,2) of astem)--reverse abowl;

    numeric x[],y[];
    z1=point 3 of astroke;
    path xbp;
    xbp=estroke shifted (0,ypart ((llcorner astroke)-(llcorner estroke)));
    x2=xpart (xbp intersectionpoint ((470,y1)--(0,y1)));
    astroke:=astroke shifted (470-x1,0);

    estroke:=estroke shifted (470-x2,0);
    xbp:=xbp shifted (470-x2,0);
    
    ebot:=subpath (xpart (xbp intersectiontimes ((500,y1)--(0,y1))),
                 infinity) of xbp;
    ebot:=insert_nodes(ebot)((length ebot)-0.3);

    etop:=
      subpath (ypart (((470,1000)--(470,0))
          intersectiontimes (subpath (0,1) of estroke)),
        1+ypart (((470,1000)--(470,0))
          intersectiontimes (subpath (1,infinity) of estroke)))
        of estroke;

    astroke:=insert_nodes(astroke)(3.4);
    
    push_stroke(astroke,
      (1.6,1.6) for i=1 upto length astroke: --(1.6,1.6) endfor);
    push_stroke(etop,
      (1.6,1.6) for i=1 upto length etop: --(1.6,1.6) endfor);
    set_botip(0,1,1);
    push_stroke(ebot,
      (1.6,1.6) for i=1 upto length ebot: --(1.6,1.6) endfor);
  endgroup;
  expand_pbox;
enddef;

vardef latin.lowb =
  push_pbox_toexpand("latin.lowb");
  (x1+x4)/2=500;
  (x4-x1)=(y1-y3)*0.55;
  x2=x1=x6;
  x3=0.4[x2,x4];
  x5=0.55[x2,x4];

  y1=latin_wide_high_v;
  y2=latin_wide_lc_baselift;
  y3=latin_wide_low_r;
  y4=0.48[y3,y5];
  y5=latin_wide_xheight_h;
  y6=0.77[y3,y5];

  push_stroke(z1--z2{curl 0.05}..{right}z3..{up}z4..{left}z5..z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0,4.97) of oldp);
  set_botip(0,1,1);
  if not do_italic_hook: set_boserif(0,0,1); fi;
  expand_pbox;
enddef;

vardef latin.lowc =
  push_pbox_toexpand("latin.lowc");
  push_stroke((subpath (0.5,3.5) of ((1,0)..(0,1)..(-1,0)..(0,-1)..cycle))
    scaled ((latin_wide_xheight_r-latin_wide_low_r)/2)
    shifted ((xpart centre_pt,(latin_wide_xheight_r+latin_wide_low_r)/2)
      +(35,0)),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  tsu_accent.shift_anchors(true)((35,0));
  push_anchor(anc_centre,identity
    scaled ((latin_wide_xheight_r-latin_wide_low_r)/200)
    shifted (xpart centre_pt,(latin_wide_xheight_r+latin_wide_low_r)/2));
  expand_pbox;
enddef;

vardef latin.lowd =
  push_pbox_toexpand("latin.lowd");
  (x1+x4)/2=500;
  (x1-x4)=(y1-y3)*0.51;
  x2=x1=x6;
  x3=0.4[x2,x4];
  x5=0.45[x2,x4];

  y1=latin_wide_high_v;
  y2=y3=latin_wide_low_h;
  y4=0.47[y3,y5];
  y5=latin_wide_xheight_h;
  y6=0.91[y3,y5];

  push_stroke(z1--z2{left}..{left}z3..{up}z4..{right}z5..z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0,4.97) of oldp);
  set_botip(0,1,1);
  if not do_italic_hook: set_boserif(0,0,1); fi;
  set_boserif(0,1,2);
  
  tsu_accent.shift_anchors(ai=anc_caron_comma)((90,0));
  expand_pbox;
enddef;

vardef latin.lowe =
  push_pbox_toexpand("latin.lowe");
  y2=0.57[y5,y3];
  y3=latin_wide_xheight_r;
  y4=0.49[y5,y3];
  y5=latin_wide_low_r;
  y6=0.35[y5,y2];

  (x2+x4)/2=500;
  (x2-x4)=0.86*(y3-y5);
  x3=0.49[x4,x2];
  x5=0.52[x4,x2];
  x6=1.04[x4,x2]-(if sharp_corners: 0 else: (mbrush_width/3) fi);

  push_stroke(z2{curl 0.7}..z3{left}..z4{down}..z5{right}..z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  z1=get_strokep(0) intersectionpoint ((z2+(-1000,0))--z2+(-10,0));
  replace_strokep(0)((z1+2*right)--oldp);
  set_botip(0,1,1);

  tsu_accent.shift_anchors(ypart olda<vmetric(0.05))((13,0));
  tsu_accent.shift_anchors(ai=anc_ring)((-12,0));
  expand_pbox;
enddef;

vardef latin.loweszett =
  push_pbox_toexpand("latin.loweszett");
  (x1+x6)/2=510;
  (x6-x1)=3*(y3-y2);
  x2=x1;
  x3=x5=(x1+x4)/2;
  x4=0.85[x1,x6];
  x7=0.69[x1,x6];
  x8=0.35[x1,x6];

  y1=latin_wide_low_v;
  y2=y4=0.52[y5,y3];
  y3=latin_wide_high_r;
  y5=0.87[y7,latin_wide_xheight_h];
  y6=0.52[y7,y5];
  y7=latin_wide_low_h;
  y8=0.18[y7,y5];

  push_stroke(z1--z2{dir 88}..z3{right}..z4..{dir 200}z5{dir 350}..
      z6..z7{left}..z8{dir 120},
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,4,0);
  set_boserif(0,0,1);

  push_stroke((x1-150,latin_wide_xheight_h)--(x1,latin_wide_xheight_h),
    (1.6,1.6)--(1.6,1.6));
  expand_pbox;
enddef;

vardef latin.loweth =
  push_pbox_toexpand("latin.loweth");
  (x3+x5)/2=(x2+x4)/2=510;
  x4-x2=20;
  (x5-x3)=(y2-y4);
  x1=1.3[x3,x5];
  x6=0.2[x3,x5];

  y1=0.25[y4,y2];
  y3=y5=0.5[y4,y2];
  y2=latin_wide_xheight_r;
  y4=latin_wide_low_r;
  y6=latin_wide_high_v;

  push_stroke(z1..z2{left}..z3..z4{right}..z5..{curl 0.6}z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (xpart ((subpath (0,1) of oldp)
    intersectiontimes
      (subpath (2,infinity) of oldp)),infinity) of oldp);

  z7=point 4.67 of get_strokep(0);
  z8=z7+whatever*dir 202;
  x8=0.27[x3,x5];
  z9=2[z8,z7];

  push_stroke(z8--z9,(1.5,1.5)--(1.5,1.5));
  set_bosize(0)(85);
  expand_pbox;
enddef;

vardef latin.lowf =
  push_pbox_toexpand("latin.lowf");
  (x2-x1)=290;
  x5=x6=490=0.52[x1,x2];
  x3-x5=2*(y4-y5);
  x4=0.38[x5,x3];

  y1=y2=latin_wide_xheight_h;
  y5=0.52[y2,y4];
  y3=0.73[y2,y4];
  y4=latin_wide_high_r;
  y6=latin_wide_low_v;

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));

  push_stroke(z3{curl 0.6}..z4{left}..{dir 268}z5{down}--z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0.23,3) of oldp);
  set_boserif(0,3,3);
  expand_pbox;
enddef;

vardef latin.lowg =
  push_pbox_toexpand("latin.lowg");
  x2=x4=x7=x9=500;
  x1=1.6[x2,x5];
  x5-x2=x2-x3;
  x5-x3=1.26*(y2-y4);
  x6=0.25[x3,x2];
  x10-x7=x7-x8;
  x10-x8=1.8*(y7-y9);

  y1=y2=latin_wide_xheight_h;
  y3=y5=0.5[y4,y2];
  y4=0.35[y7,y2];
  y6=0.4[y7,y4];
  y7=latin_wide_low_h;
  y8=y10=0.5[y9,y7];
  y9=latin_wide_desc_r;

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));

  push_stroke(z3..z4..z5..z2..cycle,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);

  push_stroke(z7..z8..z9..z10..cycle,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);

  push_stroke((point 1.2 of get_strokep(-1))
      {-direction 1.2 of get_strokep(-1)}..z6..
      (point 0.05 of get_strokep(0)){-direction 0.05 of get_strokep(0)},
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0.13,1.87) of oldp);
  set_bosize(0,85);
  
  push_anchor(anc_caron_comma,
    identity rotated 180 shifted (0,90)
    transformed accent_default[anc_upper]);
  expand_pbox;
enddef;

vardef latin.lowh =
  push_pbox_toexpand("latin.lowh");
  (x1+x5)/2=510;
  (x5-x1)=(y1-y2)*0.44;
  x2=x1=x3;
  x4=0.55[x3,x5];
  x6=x5;

  y1=latin_wide_high_v;
  y2=y6=latin_wide_low_v;
  y3=0.77[y2,y4];
  y4=latin_wide_xheight_h;
  y5=0.60[y2,y4];

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
  if not do_italic_hook:
    set_boserif(0,0,1);
    set_boserif(0,1,3);
  fi;

  push_stroke(z3..z4{right}..z5{dir 273}--z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0.03,3) of oldp);
  set_boserif(0,3,if do_italic_hook: 11 else: 2 fi);

  push_anchor(anc_wide,identity xscaled 0.75
    transformed accent_default[anc_wide]);
  tsu_accent.shift_anchors(ypart olda>vmetric(0.52))((40,0));
  expand_pbox;
enddef;

vardef latin.lowi =
  push_pbox_toexpand("latin.lowi");
  x2=x3;
  0.85[x1,x2]=450;
  (x2-x1)=0.3(y2-y3);
  x4=x2-15;

  y1=y2=latin_wide_xheight_h;
  y3=latin_wide_low_v;
  y4=0.5[y2,latin_wide_high_v]+mbrush_width;

  push_stroke(z1--z2--z3,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_boserif(0,2,3);

  push_lcblob(fullcircle rotated 45 scaled (mbrush_width*2.7+15)
    shifted (z4 transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);

  push_anchor(anc_wide,
    identity xscaled 0.7 transformed accent_default[anc_wide]);
  tsu_accent.shift_anchors(true)((x4-500,0));
  tsu_accent.shift_anchors(ai=anc_acute)((-55,0));
  tsu_accent.shift_anchors(ai=anc_wide)((-40,0));
  tsu_accent.shift_anchors(ai=anc_tilde)((10,0));
  tsu_accent.shift_anchors(ai=anc_ring)((-10,55));
  expand_pbox;
enddef;

vardef latin.lowj =
  push_pbox_toexpand("latin.lowj");
  x2=x3;
  0.85[x1,x2]=450;
  (x2-x1)=0.3(y2-y3);
  x5=x2-15;

  y1=y2=latin_wide_xheight_h;
  y3=latin_wide_low_v;
  y5=0.5[y2,latin_wide_high_v]+mbrush_width;

  z4=z3+(-210,-140);

  push_stroke((z1--z2--(z3+(0,55)))..{curl 0.8}z4,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);

  push_lcblob(fullcircle scaled (mbrush_width*2.7+15)
    shifted (z5 transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);

  push_anchor(anc_wide,
    identity xscaled 0.7 transformed accent_default[anc_wide]);
  tsu_accent.shift_anchors(true)((x5-500,0));
  tsu_accent.shift_anchors(ai=anc_acute)((-55,0));
  tsu_accent.shift_anchors(ai=anc_wide)((-40,0));
  tsu_accent.shift_anchors(ai=anc_tilde)((10,0));
  tsu_accent.shift_anchors(ai=anc_ring)((-10,55));
  expand_pbox;
enddef;

vardef latin.lowij =
  push_pbox_toexpand("latin.lowij");
  tsu_xform(identity shifted (-200,0))(latin.lowi);
  numeric x[],y[];
  tsu_xform(identity shifted (150,0))(latin.lowj);
  replace_lcblob(-1)(get_lcblob(0) shifted (-350,0));
  numeric x[],y[];
  z1=point 1.7 of get_strokep(-1);
  x2=0.3[x1,x3];
  y2=vmetric(0.05);
  z3=point 1.8 of get_strokep(0);
  replace_strokep(-1)((subpath (0,1) of oldp)--
    z1{dir 273}..z2{right}..{curl 0.3}z3);
  replace_strokeq(-1)((subpath (0,1) of oldq)--(1.6,1.6)--(1.6,1.6)--(1,1));
  set_boserif(-1,2,whatever);
  expand_pbox;
enddef;

vardef latin.lowk =
  push_pbox_toexpand("latin.lowk");
  z1=(340,latin_wide_high_v);
  z2=(340,latin_wide_low_v);
  z3=(650,(latin_wide_xheight_v+latin_wide_xheight_h)/2);
  x4=340+mbrush_width*if sharp_corners: 2.7 else: 2.3 fi;
  y4=(y3+y5)/2;
  z5=(670,0.5[latin_wide_low_h,latin_wide_low_v]);

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
  if not do_italic_hook:
    set_boserif(0,0,1);
    set_boserif(0,1,3);
  fi;

  push_stroke(z3--z4--z5,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,1);
  set_boserif(0,0,if do_italic_hook: 1 else: 3 fi);
  if not do_italic_hook: set_boserif(0,2,3); fi;
  set_boalternate(0);
  expand_pbox;
enddef;

vardef latin.lowl =
  push_pbox_toexpand("latin.lowl");
  x1=x2=500;
  x3=570;

  y1=latin_wide_high_v;
  y2=y3+(x3-x2);
  y3=latin_wide_low_r;

  push_stroke(z1--z2{down}..{right}z3,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));

  tsu_accent.shift_anchors((ypart olda>vmetric(0.52))
                           and not (ai=anc_caron_comma))
    (((0,0) transformed tsu_xf.cap_upper_accent)-
     ((0,0) transformed accent_default[anc_upper]));
  tsu_accent.shift_anchors(ai=anc_centre)((180,0));
  expand_pbox;
enddef;

vardef latin.lowm =
  push_pbox_toexpand("latin.lowm");
  (x1+x9)/2=500;
  (x9-x1)*2=(y1-y2)*3;
  (x5-x1)=(x9-x5)*1.03;
  x2=x1=x3;
  x4=0.65[x3,x5];
  x6=x5;
  x8=0.65[x6,x9];
  x9=x10;

  y1=latin_wide_xheight_v;
  y2=y6=y10=latin_wide_low_v;
  y3=0.74[y2,y4];
  y4=y8=latin_wide_xheight_r;
  y5=y9=0.66[y2,y4];

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,if do_italic_hook: 11 else: 1 fi);
  if not do_italic_hook: set_boserif(0,1,3); fi;

  push_stroke(z3..z4{right}..z5{dir 275}--z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0.04,3) of oldp);

  z7=get_strokep(0) intersectionpoint (z3--z9);

  push_stroke(z7..z8{right}..z9{dir 271}--z10,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0.04,3) of oldp);
  set_boserif(0,3,if do_italic_hook: 11 else: 2 fi);
  expand_pbox;
enddef;

vardef latin.lown =
  push_pbox_toexpand("latin.lown");
  (x1+x5)/2=500;
  (x5-x1)=(y1-y2)*0.75;
  x2=x1=x3;
  x4=0.65[x3,x5];
  x6=x5;

  y1=latin_wide_xheight_v;
  y2=y6=latin_wide_low_v;
  y3=0.73[y2,y4];
  y4=latin_wide_xheight_r;
  y5=0.60[y2,y4];

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,if do_italic_hook: 11 else: 1 fi);
  if not do_italic_hook: set_boserif(0,1,3); fi;

  push_stroke(z3..z4{right}..z5{dir 273}--z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0.03,3) of oldp);
  set_boserif(0,3,if do_italic_hook: 11 else: 2 fi);
  expand_pbox;
enddef;

vardef latin.loweng =
  push_pbox_toexpand("latin.loweng");
  latin.lown;
  x7=x6-300;
  y7=latin_wide_desc_h;
  replace_strokep(0)(oldp{dir 266}..{curl 0.8}z7);
  replace_strokep(0)(insert_nodes(oldp)(3.3));
  replace_strokeq(0)(oldq--(1.6,1.6)--(1.6,1.6));
  set_boserif(0,3,whatever);
  expand_pbox;
enddef;

vardef latin.lowo =
  push_pbox_toexpand("latin.lowo");
  push_anchor(anc_centre,identity
    scaled ((latin_wide_xheight_r-latin_wide_low_r)/200)
    shifted (xpart centre_pt,(latin_wide_xheight_r+latin_wide_low_r)/2));
  push_stroke(((1,0)..(0,1)..(-1,0)..(0,-1)..cycle)
    scaled ((latin_wide_xheight_r-latin_wide_low_r)/2)
    shifted (xpart centre_pt,(latin_wide_xheight_r+latin_wide_low_r)/2),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);
  expand_pbox;
enddef;

vardef latin.lowoe =
  push_pbox_toexpand("latin.lowoe");
  tsu_xform(identity shifted (190,0))(latin.lowe);
  push_stroke(((1,0)..(0,1)..(-1,0)..(0,-1)..(1,0))
    scaled ((latin_wide_xheight_r-latin_wide_low_r)/2)
    shifted (340,0.5[latin_wide_xheight_r,latin_wide_low_r]),
    (1.2,1.2)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.2,1.2));
  replace_strokep(0)(subpath (0.03+xpart (oldp intersectiontimes
                       (subpath (2,infinity) of get_strokep(-1))),
                   3.97-xpart ((reverse oldp) intersectiontimes
                            reverse get_strokep(-1)))
          of oldp);
  expand_pbox;
enddef;

vardef latin.lowp =
  push_pbox_toexpand("latin.lowp");
  (x1+x4)/2=500;
  (x4-x1)=(y2-y1)*0.51;
  x2=x1=x6;
  x3=0.4[x2,x4];
  x5=0.45[x2,x4];

  y1=latin_wide_desc_v;
  y2=y3=latin_wide_xheight_h;
  y4=0.47[y3,y5];
  y5=latin_wide_low_h;
  y6=0.91[y3,y5];

  push_stroke(z1--z2{right}..{right}z3..{down}z4..{left}z5..z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0,4.97) of oldp);
  set_botip(0,1,1);
  if not do_italic_hook: set_boserif(0,0,3); fi;
  set_boserif(0,1,1);
  expand_pbox;
enddef;

vardef latin.lowq =
  push_pbox_toexpand("latin.lowq");
  (x1+x4)/2=520;
  (x1-x4)=(y2-y1)*0.51;
  x2=x1=x6;
  x3=0.4[x2,x4];
  x5=0.45[x2,x4];

  y1=latin_wide_desc_v;
  y2=y3=latin_wide_xheight_h;
  y4=0.47[y3,y5];
  y5=latin_wide_low_h;
  y6=0.91[y3,y5];

  z0=z1+150*(dir 20);

  push_stroke(z0--(0.6[z0,z1])--z1--z2{left}..
    {left}z3..{down}z4..{right}z5..z6,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0,6.97) of oldp);
  set_botip(0,2,0);
  set_botip(0,3,1);
  if not do_italic_hook: set_boserif(0,3,2); fi;
  expand_pbox;
enddef;

vardef latin.lowr =
  push_pbox_toexpand("latin.lowr");
  (x1+x5)/2=650;
  (x5-x1)=(y1-y2)*0.75;
  x2=x1=x3;
  x4=0.62[x3,x5];

  y1=latin_wide_xheight_v;
  y2=latin_wide_low_v;
  y3=0.58[y2,y4];
  y4=0.5[latin_wide_xheight_h,latin_wide_xheight_r];
  y5=0.60[y2,y4];

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,if do_italic_hook: 11 else: 1 fi);
  if not do_italic_hook: set_boserif(0,1,3); fi;

  push_stroke(z3..z4{right}..{dir 273}z5,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0.03,1.6) of oldp);

  tsu_accent.shift_anchors(ypart olda>vmetric(0.05))((0.5[x3,x5]-500,0));
  expand_pbox;
enddef;

vardef latin.lows =
  push_pbox_toexpand("latin.lows");
  transform ta,tb;
  path mycurve;

  mycurve:=(1,0)..(0,1)..(-1,0);

  y2=latin_wide_xheight_r;
  y0=y3=0.77[y6,y2];
  y4=0.53[y6,y2];
  y5=y8=0.25[y6,y2];
  y6=latin_wide_low_r;

  0.48[x1,x7]=0.48[x2,x6]=0.48[x3,x5]=x4=500;
  x5-x1=5;
  x5-x7=(y2-y6)*0.67;

  (point 0 of mycurve) transformed ta=z0;
  (point 0.35 of mycurve) transformed ta=z1;
  (point 1 of mycurve) transformed ta=z2;
  (point 2 of mycurve) transformed ta=z3;
  xypart ta=0;

  (point 0 of mycurve) transformed tb=z8;
  (point 0.35 of mycurve) transformed tb=z7;
  (point 1 of mycurve) transformed tb=z6;
  (point 2 of mycurve) transformed tb=z5;

  if sharp_corners:
    mycurve:=subpath (0.29,2) of mycurve;
  else:
    mycurve:=subpath (0.38,2) of mycurve;
  fi;

  push_stroke((mycurve transformed ta)..z4..(reverse mycurve transformed tb),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6));
  expand_pbox;
enddef;

vardef latin.lowlongs =
  push_pbox_toexpand("latin.lowlongs");
  latin.lowf;
  replace_strokep(-1)(subpath (0,0.52) of oldp);
  expand_pbox;
enddef;

vardef latin.lowt =
  push_pbox_toexpand("latin.lowt");
  x2=x3=x10=470;
  x1=0.2[x5,x2];
  x4=0.6[x5,x2];
  x5-x2=220;

  y1=y2=y6=latin_wide_xheight_h;
  y3=0.2[y4,y1];
  y4=latin_wide_low_r;
  y5=0.12[y4,y1];
  y10=vmetric(0.83);

  if is_proportional:
    z10-z6=whatever*dir 58;
  else:
    z10-z6=whatever*dir 47;
  fi;

  if tsu_pbrush_size<30:
    push_stroke(z1--z6--z10--z3{down}..z4{right}..{curl 0.2}z5,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,1);
    set_botip(0,2,1);
  else:
    push_stroke(z1--z2--z3{down}..z4{right}..{curl 0.2}z5,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
  fi;

  push_stroke(z6--z1,(0,0)--(0,0));

  x7=x8=x2;
  x9=x6;

  y7=y9=y2;

  if is_proportional:
    z8-z9=whatever*dir 58;
  else:
    z8-z9=whatever*dir 47;
  fi;

  if tsu_pbrush_size>=30:
    begingroup
      save t; transform t;
      t:=tsu_rescale_xform;
      push_lcblob(((z7 transformed t)+(mbrush_width,-mbrush_height))--
                  ((z8 transformed t)+(mbrush_width,mbrush_height))--
                  ((z9 transformed t)+(-mbrush_width,-mbrush_height))--cycle);
      replace_lcblob(0)(oldblob transformed inverse t);
    endgroup;
  fi;
  expand_pbox;
enddef;

vardef latin.lowthorn =
  push_pbox_toexpand("latin.lowthorn");
  latin.lowb;
  set_botip(0,1,whatever);
  set_boserif(0,0,whatever);
  push_stroke((point 0 of get_strokep(0))--
    (xpart point 0 of get_strokep(0),latin_wide_desc_v),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,1);
  set_boserif(0,1,3);
  replace_strokep(-1)(subpath (1,infinity) of oldp);
  replace_strokeq(-1)(subpath (1,infinity) of oldq);
  expand_pbox;
enddef;

vardef latin.lowu =
  push_pbox_toexpand("latin.lowu");
  (x1+x5)/2=450;
  (x1-x5)=(y2-y1)*0.75;
  x2=x1=x3;
  x4=0.65[x3,x5];
  x6=x5;

  y1=latin_wide_low_v;
  y2=y6=latin_wide_xheight_v;
  y3=0.73[y2,y4];
  y4=latin_wide_low_h;
  y5=0.60[y2,y4];

  push_stroke(z2--z1,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,if do_italic_hook: 11 else: 2 fi);

  push_stroke(reverse(z3..z4{left}..z5{dir 93}--z6),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(subpath (0,2.97) of oldp);
  if do_italic_hook: set_boserif(0,0,11); fi;

  tsu_accent.shift_anchors(true)((-50,0));
  expand_pbox;
enddef;

vardef latin.lowv =
  push_pbox_toexpand("latin.lowv");
  (x1+x3)/2=x2=500;

  y1=y3=latin_wide_xheight_v;
  y2=latin_wide_low_h;

  (x3-x1)=(y1-y2)*0.9;

  if do_alternation:
    push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,3);

    push_stroke((z2+alternate_adjust*right)--z3,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,3);
    set_boalternate(0);
  else:
    push_stroke(z1--z2--z3,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
    set_boserif(0,0,1);
  fi;
  expand_pbox;
enddef;

vardef latin.loww =
  push_pbox_toexpand("latin.loww");
  (x1+x5)/2=(x2+x4)/2=x3=500;
  (x3-x2)=(x2-x1);

  y1=y3=y5=latin_wide_xheight_v;
  y2=y4=latin_wide_low_h;

  (x5-x1)=(y1-y2)*1.45;

  if do_alternation:
    push_stroke((z1--z2) shifted (alternate_adjust*left),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,3);

    push_stroke(z2--z3,
      (1.6,1.6)--(1.6,1.6));
    set_boalternate(0);

    push_stroke((z3--z4) shifted (alternate_adjust*right),
      (1.6,1.6)--(1.6,1.6));

    push_stroke((z4--z5) shifted (alternate_adjust*right*2),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,3);
    set_boalternate(0);
  else:
    push_stroke(z1--z2--z3--z4--z5,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_botip(0,1,0);
    set_botip(0,2,0);
    set_botip(0,3,0);
    set_boserif(0,0,1);
  fi;
  expand_pbox;
enddef;

vardef latin.lowx =
  push_pbox_toexpand("latin.lowx");
  (x1+x3)/2=500;
  (x2+x4)/2=500;
  (x2+x3-x1-x4)=((y1-y2)*0.9)*2;
  (x3-x1)=(x2-x4)*0.93;

  y1=y3=latin_wide_xheight_v;
  y2=y4=latin_wide_low_v;

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));
  set_boserif(0,0,if do_italic_hook: 11 else: 3 fi);
  set_boserif(0,1,if do_italic_hook: 11 else: 3 fi);

  if do_alternation:
    push_stroke(z3--(0.5[z3,z4]+alternate_adjust*right/6)
      --(0.5[z3,z4]+alternate_adjust*left/6)--z4,
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,if do_italic_hook: 2 else: 3 fi);
    set_boserif(0,3,if do_italic_hook: 1 else: 3 fi);
  else:
    push_stroke(z3--z4,(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,if do_italic_hook: 2 else: 3 fi);
    set_boserif(0,1,if do_italic_hook: 1 else: 3 fi);
  fi;
  set_boalternate(0);
  expand_pbox;
enddef;

vardef latin.lowy =
  push_pbox_toexpand("latin.lowy");
  (x1+x3)/2=(x2+x4)/2=510;
  (x2+x3-x1-x4)=((y1-y2)*0.58)*2;
  (x3-x1)=(x2-x4)*0.93;
  x5=x4-0.1*(x2-x4);

  y1=y3=latin_wide_xheight_v;
  y2=y4;
  y5=0.5[y4,latin_wide_low_h]=latin_wide_desc_h;

  push_stroke(z1--z2,(1.6,1.6)--(1.6,1.6));

  push_stroke(z3..tension 10..(0.6[z3,z4])..tension 0.8 and 3..{left}z5,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6));

  numeric xchgtime;
  xchgtime:=ypart (get_strokep(-1) intersectiontimes get_strokep(0));

  replace_strokep(-1)(z1--subpath (xchgtime,infinity) of get_strokep(0));
  replace_strokeq(-1)
    ((1.6,1.6)--subpath (xchgtime,infinity) of get_strokeq(0));

  replace_strokep(0)(subpath (0,xchgtime) of oldp);
  replace_strokeq(0)(subpath (0,xchgtime) of oldq);

  set_boserif(-1,0,if do_italic_hook: 11 else: 3 fi);
  set_boserif(0,0,if do_italic_hook: 2 else: 3 fi);
  set_botip(-1,1,1);
  set_boalternate(0);

  if do_alternation:
    replace_strokep(-1)(oldp shifted (alternate_adjust*left/2));
    replace_strokep(0)(oldp shifted (alternate_adjust*right/2));
  fi;

  tsu_accent.shift_anchors(ai=anc_lower)((90,0));
  tsu_accent.shift_anchors(ai=anc_lower_connect)((-75,-105));
  expand_pbox;
enddef;

vardef latin.lowz =
  push_pbox_toexpand("latin.lowz");
  y1=y2=latin_wide_xheight_h;
  y3=y4=latin_wide_low_h;

  x1=x3;
  x2=x4;
  (x1+x2)/2=500;
  (x2-x1)=(y1-y3)*0.92;

  push_stroke(z1--z2--z3--z4,(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,1,0);
  set_botip(0,2,0);
  expand_pbox;
enddef;
