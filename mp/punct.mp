%
% Punctuation for Tsukurimashou
% Copyright (C) 2011, 2013, 2015  Matthew Skala
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

inclusion_lock(punct);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef punct.ampersand =
  push_pbox_toexpand("punct.ampersand");

  push_stroke((707,384)..tension 1.3..(420,40)..(230,180)..(440,420)..
      (610,600)..(470,760)..(330,590)..tension 1.5 and 4..(770,30),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  replace_strokep(0)(insert_nodes(oldp)(1.3));

  push_stroke((600,395)..(710,388)..(820,390),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  expand_pbox;
enddef;

vardef punct.asciiquote =
  push_pbox_toexpand("punct.asciiquote");

  numeric dx;
  dx=tsu_punct_size;

  (x1+x2)/2=(x3+x4)/2=500;
  x2-x1=1.2*dx+tsu_punct_size;
  x4-x3=tsu_punct_size*1.85;

  y1=y2=latin_wide_high_r-dx/2;
  y3=y4=y1-1.5*dx;

  path ptmp;
  ptmp:=(down..right..up..left..cycle)
    scaled (abs(z3-z1)+-+(dx/2));

  push_stroke((down..right..up..left..cycle) scaled (dx/2) shifted z1,
    (2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(1.3,1.3)--cycle);
  replace_strokep(0)(z3--(subpath ((xpart (oldp intersectiontimes
    (ptmp shifted z3))),(4-xpart ((reverse oldp) intersectiontimes
    (ptmp shifted z3)))) of oldp)--cycle);
  replace_strokep(0)((subpath (0.8,6) of oldp)--cycle);
  set_bobrush(0,brpunct);
  set_bosize(0,75);
  set_botip(0,6,0);

  push_stroke((down..right..up..left..cycle) scaled (dx/2) shifted z2,
    (2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(1.3,1.3)--cycle);
  replace_strokep(0)(z4--(subpath ((xpart (oldp intersectiontimes
    (ptmp shifted z4))),(4-xpart ((reverse oldp) intersectiontimes
    (ptmp shifted z4)))) of oldp)--cycle);
  replace_strokep(0)((subpath (0.8,6) of oldp)--cycle);
  set_bobrush(0,brpunct);
  set_bosize(0,75);
  set_botip(0,6,0);;

  if tsu_brush_max.brpunct>=0.3:
    push_lcblob(get_strokep(-1));
    push_lcblob(get_strokep(0));
  fi;
  expand_pbox;
enddef;

vardef punct.atsign =
  push_pbox_toexpand("punct.atsign");
  begingroup
    save xsp,ysp;
    xsp:=sp;
    latin.lowa;
    set_boserif(-1,3,whatever);
    ysp:=sp;

    numeric x[],y[];
    x1-x2=x2-x3=y2-y1;
    x2=x4=500;
    y1=y3=0.49[y4,y2];
    y2=latin_wide_high_r;
    y4=latin_wide_low_r;

    transform shrinka;
    (0.5[llcorner get_strokep(-1),urcorner get_strokep(-1)])
      transformed shrinka=0.5[z3,z1];
    (0.5[lrcorner get_strokep(-1),urcorner get_strokep(-1)])
      transformed shrinka=0.71[z3,z1];
    (0.5[ulcorner get_strokep(-1),urcorner get_strokep(-1)])
      transformed shrinka=z2+(0.07,-1)*0.29*(x1-x3);
    sp:=xsp;
    tsu_xform(shrinka shifted (-10,0))(sp:=ysp);

    z5=point infinity of get_strokep(0);
    y6=ypart lrcorner get_strokep(0);
    x6=0.5[x2,x1];
    replace_strokep(-1)((subpath (0,length(oldp)-1) of oldp)..z5..z6..
       (subpath (0,3.85) of (z1..z2..z3..z4..cycle)));
    replace_strokep(-1)(insert_nodes(oldp)((length oldp-4.5)));
    replace_strokeq(-1)(oldq--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6)--(0,0));
  endgroup;
  expand_pbox;
enddef;

vardef punct.brace_left =
  push_pbox_toexpand("punct.brace_left");
  push_stroke((900,780){left}..
    (900-1.5*tsu_punct_size,680)..
    (900-1.1*tsu_punct_size,490)..
    (900-3.1*tsu_punct_size,390-0.25*tsu_punct_size){left}..
    (900-3.5*tsu_punct_size,390)..
    (900-3.1*tsu_punct_size,390+0.25*tsu_punct_size){right}..
    (900-1.1*tsu_punct_size,290)..
    (900-1.5*tsu_punct_size,100)..
    (900,0){right},
    (1.7,1.7)--(2,2)--(2,2)--
    (1.2,1.2)--(1.2,1.2)--(1.2,1.2)--
    (2,2)--(2,2)--(1.7,1.7));
  set_bosize(0,90);
  expand_pbox;
enddef;
vardef punct.brace_right =
  push_pbox_toexpand("punct.brace_right");
  tsu_xform(identity rotatedaround (centre_pt,180))
    (punct.brace_left);
  expand_pbox;
enddef;

vardef punct.bvline =
  push_pbox_toexpand("punct.bvline");

  push_stroke((500,690+tsu_punct_size)--(500,390+0.7*tsu_punct_size),
    (1.6,1.6)--(1.6,1.6));
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_stroke((500,390-0.7*tsu_punct_size)--(500,90-tsu_punct_size),
    (1.6,1.6)--(1.6,1.6));
  set_bobrush(0,brpunct);
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef punct.make_comma(expr cpos,cang) =
  begingroup
    save x,y,t,u,xsp;
    numeric x[],y[];
    transform t,u;
    xsp:=sp;
    sp:=1;
    t:=tsu_rescale_xform;
    sp:=xsp;

    x1=0.8[x2,x4];
    (x2+x4)/2=x3=0;
    (x2-x4)=0.45*(y3-y1)=tsu_punct_size;
    x5=x3;

    y2=y4=0.32[y3,y1]=0;
    y5-y4=0.73*(y4-y3);

    push_stroke(z1{curl 0.2}..tension 1.2..z2..z3..z4{dir 280}..
        z5..{curl 0.2}(point 0.8 of (z1{curl 0.2}..tension 1.2..
        z2..z3..z4{dir 280})),
      (2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2));
    replace_strokep(0)((point 4.2 of oldp)--oldp);
    (0,0) transformed u=llcorner get_strokep(0);
    (1,0) transformed u=lrcorner get_strokep(0);
    (0,1) transformed u=ulcorner get_strokep(0);
    replace_strokep(0)(oldp rotated (cang-6) shifted (cpos transformed t)
      transformed inverse t);
    u:=u scaled 1.3 rotated (cang-6) shifted (cpos transformed t)
      transformed inverse t;
    set_botip(0,1,0);
    set_bobrush(0,brpunct);

    if tsu_brush_max.brpunct>=0.3:
      set_bosize(0,40);
      push_lcblob(get_strokep(0)--cycle);
    else:
      replace_strokep(0)(subpath (0,5.2) of oldp);
      set_bosize(0,80);
    fi;
    push_pbox_explicit("punct.make_comma",u);
  endgroup;
enddef;

vardef punct.make_revcomma(expr cpos,cang) =
  begingroup
    save x,y,t,u,xsp;
    numeric x[],y[];
    transform t,u;
    xsp:=sp;
    sp:=1;
    t:=tsu_rescale_xform;
    sp:=xsp;

    x1=0.8[x2,x4];
    (x2+x4)/2=x3=0;
    (x2-x4)=0.45*(y3-y1)=tsu_punct_size;
    x5=x3;

    y2=y4=0.32[y3,y1]=0;
    y5-y4=0.73*(y4-y3);

    push_stroke(z1{curl 0.2}..tension 1.2..z2..z3..z4{dir 280}..
        z5..{curl 0.2}(point 0.8 of (z1{curl 0.2}..tension 1.2..
        z2..z3..z4{dir 280})),
      (2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2));
    replace_strokep(0)((point 4.2 of oldp)--oldp);
    (0,0) transformed u=llcorner get_strokep(0);
    (1,0) transformed u=lrcorner get_strokep(0);
    (0,1) transformed u=ulcorner get_strokep(0);
    replace_strokep(0)(reverse (oldp rotated -6 reflectedabout(up,down)));
    replace_strokep(0)(oldp rotated (cang-6) shifted (cpos transformed t)
      transformed inverse t);
    u:=u scaled 1.3 rotated (cang-6) shifted (cpos transformed t)
      transformed inverse t;
    set_botip(0,1,0);
    set_bobrush(0,brpunct);

    if tsu_brush_max.brpunct>=0.3:
      set_bosize(0,40);
      push_lcblob(get_strokep(0)--cycle);
    else:
      replace_strokep(0)(subpath (0.8,6) of oldp);
      set_bosize(0,80);
    fi;
    push_pbox_explicit("punct.make_revcomma",u);
  endgroup;
enddef;

vardef punct.corner_left =
  push_pbox_toexpand("punct.corner_left");
  push_stroke((910,800)--(650,800)--(650,400),(2,2)--(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,120);
  set_botip(0,1,1);
  expand_pbox;
enddef;
vardef punct.corner_right =
  push_pbox_toexpand("punct.corner_right");
  tsu_xform(identity rotatedaround (centre_pt,180))
    (punct.corner_left);
  expand_pbox;
enddef;

vardef punct.currency =
  push_pbox_toexpand("punct.currency");

  push_stroke(fullcircle scaled (4*tsu_punct_size) shifted centre_pt,
    (2,2)--(2,2)--(2,2)--(2,2)--cycle);
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_stroke(((1,0)--(1.55,0)) rotated 45
      scaled (2*tsu_punct_size) shifted centre_pt,
    (2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_stroke(((1,0)--(1.55,0)) rotated 135
      scaled (2*tsu_punct_size) shifted centre_pt,
    (2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_stroke(((1,0)--(1.55,0)) rotated 225
      scaled (2*tsu_punct_size) shifted centre_pt,
    (2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_stroke(((1,0)--(1.55,0)) rotated 315
      scaled (2*tsu_punct_size) shifted centre_pt,
    (2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef punct.dash.double_hyphen =
  push_pbox_toexpand("punct.dash.double_hyphen");

  (z1+z4)/2=centre_pt;
  x2-x1=400;
  y1-y3=200;
  y1=y2;
  y3=y4;
  x1=x3;
  x2=x4;
  
  push_stroke(z1--z2,(2,2)--(2,2));
%  set_bobrush(0,brpunct);
  push_stroke(z3--z4,(2,2)--(2,2));
%  set_bobrush(0,brpunct);

  expand_pbox;
enddef;

vardef punct.dash.em =
  push_pbox_toexpand("punct.dash.em");
  (z1+z2)/2=centre_pt;
  x2-x1=if is_proportional: 750 else: 630 fi;
  y1=y2;
  push_stroke(z1--z2,(2,2)--(2,2));
%  set_bobrush(0,brpunct);
  expand_pbox;
enddef;

vardef punct.dash.en =
  push_pbox_toexpand("punct.dash.en");
  (z1+z2)/2=centre_pt;
  x2-x1=580;
  y1=y2;
  push_stroke(z1--z2,(2,2)--(2,2));
%  set_bobrush(0,brpunct);
  expand_pbox;
enddef;

vardef punct.dash.hyphen =
  push_pbox_toexpand("punct.dash.hyphen");
  (z1+z2)/2=centre_pt;
  x2-x1=340;
  y1=y2;
  push_stroke(z1--z2,(2,2)--(2,2));
%  set_bobrush(0,brpunct);
  expand_pbox;
enddef;

vardef punct.dash.long =
  push_pbox_toexpand("punct.dash.long");
  (z1+z2)/2=centre_pt;
  x2-x1=340;
  y1=y2;
  push_stroke(z1--z2,(2,2)--(2,2));
%  set_bobrush(0,brpunct);
  expand_pbox;
enddef;

vardef punct.dividedby(expr t) =
  push_stroke(((-1,0)--(1,0)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_lcblob(fullcircle scaled (0.65*tsu_punct_size/xxpart t)
    shifted (0,0.9) transformed t);
  push_lcblob(fullcircle scaled (0.65*tsu_punct_size/xxpart t)
    shifted (0,-0.9) transformed t);

  push_pbox_explicit("punct.dividedby",
    identity shifted (-0.5,-0.5) scaled 2.4 transformed t);
enddef;

vardef punct.equals(expr t) =
  push_stroke(((-1,0.667)--(1,0.667)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_stroke(((-1,-0.667)--(1,-0.667)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_pbox_explicit("punct.equals",
    identity shifted (-0.5,-0.5) xyscaled (2.4,1.8) transformed t);
enddef;

vardef punct.euro =
  push_pbox_toexpand("punct.euro");

  push_stroke((subpath (0.5,3.5) of ((1,0)..(0,1)..(-1,0)..(0,-1)..cycle))
      scaled ((latin_wide_high_r-latin_wide_low_r)/2)
      shifted (centre_pt+(100,0)),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  set_bosize(0,90);

  push_stroke(((-1.25,0.1667)--
      (((0,0.1667)--(1,0.1667)) intersectionpoint ((0.707,0.707)--(0,-1))))
      scaled ((latin_wide_high_r-latin_wide_low_r)/2)
      shifted (centre_pt+(100,0)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,90);
  
  push_stroke(((-1.25,-0.1667)--
      (((0,-0.1667)--(1,-0.1667)) intersectionpoint ((0.707,0.707)--(0,-1))))
      scaled ((latin_wide_high_r-latin_wide_low_r)/2)
      shifted (centre_pt+(100,0)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,90);
  expand_pbox;
enddef;

% this is *ideographic* full stop, not Latin period
vardef punct.full_stop =
  push_pbox_toexpand("punct.full_stop");

  if tsu_brush_max.brpunct*100>=tsu_punct_size:
    push_lcblob(fullcircle
      xscaled (1.5*tsu_punct_size+tsu_brush_max.brpunct*100)
      yscaled (1.5*tsu_punct_size+tsu_brush_max.brpunct*100
        *tsu_brush_shape.brpunct)
      rotated tsu_brush_angle.brpunct
      shifted (170,50));
  else:
    push_stroke(fullcircle scaled (1.5*tsu_punct_size) shifted (170,50),
      (2,2)--(2,2)--(2,2)--(2,2)--cycle);
    set_bobrush(0,brpunct);
  fi;
  expand_pbox;
enddef;

vardef punct.greater_than(expr t) =
  push_stroke(((-1,1)--(1,0)--(-1,-1)) transformed t,(2,2)--(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);
  set_botip(0,1,1);

  push_pbox_explicit("punct.greater_than",
    identity shifted (-0.5,-0.5) scaled 2.4 transformed t);
enddef;

vardef punct.guillemet_left =
  push_pbox_toexpand("punct.guillemet_left");

  push_stroke(((-0.5,1.5)--(-2.5,0)--(-0.5,-1.5))
      scaled tsu_punct_size shifted centre_pt,
    (1.5,1.5)--(2,2)--(1.5,1.5));
  set_bosize(0,90);
  set_botip(0,1,1);

  push_stroke(((2.5,1.5)--(0.5,0)--(2.5,-1.5))
      scaled tsu_punct_size shifted centre_pt,
    (1.5,1.5)--(2,2)--(1.5,1.5));
  set_bosize(0,90);
  set_botip(0,1,1);
  expand_pbox;
enddef;

vardef punct.guillemet_right =
  push_pbox_toexpand("punct.guillemet_right");

  push_stroke(((0.5,1.5)--(2.5,0)--(0.5,-1.5))
      scaled tsu_punct_size shifted centre_pt,
    (1.5,1.5)--(2,2)--(1.5,1.5));
  set_bosize(0,90);
  set_botip(0,1,1);

  push_stroke(((-2.5,1.5)--(-0.5,0)--(-2.5,-1.5))
      scaled tsu_punct_size shifted centre_pt,
    (1.5,1.5)--(2,2)--(1.5,1.5));
  set_bosize(0,90);
  set_botip(0,1,1);
  expand_pbox;
enddef;

vardef punct.hancomma =
  push_pbox_toexpand("punct.hancomma");
  push_stroke((80,140)..(180,40)..(230,-30),(1.3,1.3)..(1.6,1.6)..(1.8,1.8));
  expand_pbox;
enddef;

vardef punct.hminus(expr t) =
  push_stroke(((-1,0)--(1,0)) transformed t,(2,2)--(2,2));
%  set_bobrush(0,brpunct);

  push_pbox_explicit("punct.hminus",
    identity shifted (-0.5,-0.5) xyscaled (2.4,0.6) transformed t);
enddef;

vardef punct.less_than(expr t) =
  push_stroke(((1,1)--(-1,0)--(1,-1)) transformed t,(2,2)--(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);
  set_botip(0,1,1);

  push_pbox_explicit("punct.less_than",
    identity shifted (-0.5,-0.5) scaled 2.4 transformed t);
enddef;

% in the future, this will probably become greek.lowmu
vardef punct.micro =
  push_pbox_toexpand("punct.micro");

  x1-x2=y2-y1;
  (x2+x6)/2=450;
  (x2-x6)=(y3-y1)*0.75;
  x3=x2=x4;
  x5=0.5[x4,x6];
  x7=x8=x6;

  y1=(-0.06)[y5,y3];
  y2=0.26[y5,y3];
  y3=y7=latin_wide_xheight_v;
  y4=0.73[y3,y5];
  y5=latin_wide_low_h;
  y6=0.60[y3,y5];
  y8=latin_wide_desc_v;

  push_stroke(z1{dir 173}..{up}z2--z3,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  push_stroke(subpath (0.03,2) of (z4..z5{left}..z6{dir 93}),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
  push_stroke(z7--z8,(1.6,1.6)--(1.6,1.6));
  expand_pbox;
enddef;

vardef punct.notsign(expr t) =
  push_stroke(((-1,0)--(1,0)--(1,-1)) transformed t,(2,2)--(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);
  set_botip(0,1,1);

  push_pbox_explicit("punct.notsign",
    identity shifted (-0.5,-0.5) scaled 2.4 transformed t);
enddef;

vardef punct.numbersign =
  push_pbox_toexpand("punct.numbersign");

  (x1+x2)/2=500;
  (x2-x1)=0.9*(y2-y1);
  x3=0.15[x1,x2];

  y1=latin_wide_low_v;
  y2=y3=latin_wide_high_v;

  transform xf_num;
  (0,0) transformed xf_num = z1;
  (3.5,3.5) transformed xf_num = z2;
  (0,3.5) transformed xf_num = z3;

  push_stroke(((0,2.5)--(3.5,2.5)) transformed xf_num,(1.6,1.6)--(1.6,1.6));
  set_bobrush(0,brpunct);
  set_bosize(0,85);
  push_stroke(((1,3.5)--(1,0)) transformed xf_num,(1.6,1.6)--(1.6,1.6));
  set_bobrush(0,brpunct);
  set_bosize(0,85);
  push_stroke(((0,1)--(3.5,1)) transformed xf_num,(1.6,1.6)--(1.6,1.6));
  set_bobrush(0,brpunct);
  set_bosize(0,85);
  push_stroke(((2.5,3.5)--(2.5,0)) transformed xf_num,(1.6,1.6)--(1.6,1.6));
  set_bobrush(0,brpunct);
  set_bosize(0,85);
  expand_pbox;
enddef;

% in the future, this will probably become greek.upomega
vardef punct.ohm =
  push_pbox_toexpand("punct.ohm");

  (x5+x3)/2=(x6+x2)/2=(x7+x1)/2=x4=500;
  x2=0.7[x1,x4];
  x7-x1=0.76*(y4-y1);
  x5-x3=0.67*(y4-y1);

  y1=y7=latin_wide_low_h;
  y2=y6=y1+2;
  y3=y5=0.7[y1,y4];
  y4=latin_wide_high_r;

  push_stroke(z1--z2..tension 1.5 and 1.3..z3..z4..
      z5..tension 1.3 and 1.5..z6--z7,
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--
      (1.6,1.6)--(1.6,1.6));
  set_botip(0,1,0);
  set_botip(0,5,0);
  expand_pbox;
enddef;

vardef punct.paren_left =
  push_pbox_toexpand("punct.paren_left");
  push_stroke((900,780)..(900-2.5*tsu_punct_size,390)..(900,0),
    (1.5,1.5)--(2,2)--(1.5,1.5));
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef punct.paren_right =
  push_pbox_toexpand("punct.paren_right");
  tsu_xform(identity rotatedaround (centre_pt,180))
    (punct.paren_left);
  expand_pbox;
enddef;

vardef punct.percent =
  push_pbox_toexpand("punct.percent");

  (x1+x2)/2=500;
  (x1-x2)=0.67(y1-y2);

  y1=latin_wide_high_v;
  y2=latin_wide_low_v;

  push_stroke(fullcircle scaled 260 shifted (x2,latin_wide_high_r-130),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);

  push_stroke((z1--z2)
      shifted -centre_pt scaled (tsu_punct_size/100) shifted centre_pt,
    (1.6,1.6)--(1.6,1.6));

  push_stroke(fullcircle scaled 260 shifted (x1,latin_wide_low_r+130),
    (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);
  expand_pbox;
enddef;

vardef punct.pilcrow =
  push_pbox_toexpand("punct.pilcrow");

  x1=x2=x6=710;
  x3=x5=x1-420*0.4;
  x4=x1-420;

  y1=latin_wide_low_v;
  y2=y3=latin_wide_high_h;
  y4=(y3+y5)/2;
  y5=y6=vmetric(0.58);

  x7=x8=x9=x1-1.8*tsu_punct_size;
  y7=y2+50;
  y8=y4;
  y9=y1;

  push_stroke(z1--z2--z3{left}..z4..{right}z5--z6,
    (2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2));
  replace_strokeq(0)(subpath (0,xpart (get_strokep(0) intersectiontimes
    (z8--z9))) of oldq);
  replace_strokep(0)(subpath (0,xpart (oldp intersectiontimes
    (z8--z9))) of oldp);
  set_bobrush(0,brpunct);
  set_bosize(0,67);
  set_botip(0,1,1);
  set_boserif(0,0,3);
  set_boserif(0,1,2);

  push_stroke(((z7--z8) intersectionpoint get_strokep(0))--z9,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,67);
  set_boserif(0,1,3);

  if tsu_brush_max.brpunct>=0.3:
    push_lcblob((subpath (xpart (get_strokep(-1) intersectiontimes (z7--z8)),
      infinity) of get_strokep(-1))--cycle);
  fi;
  expand_pbox;
enddef;

vardef punct.plus(expr t) =
  push_stroke(((-1,0)--(1,0)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  push_stroke(((0,1)--(0,-1)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  push_pbox_explicit("punct.plus",
    identity shifted (-0.5,-0.5) scaled 2.4 transformed t);
enddef;

vardef punct.plusminus(expr t) =
  push_stroke(((-1,0.25)--(1,0.25)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  push_stroke(((0,1.25)--(0,-0.75)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  push_stroke(((-1,-1.25)--(1,-1.25)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);

  push_pbox_explicit("punct.plusminus",
    identity shifted (-0.5,-0.5) xyscaled (2.4,3.2) transformed t);
enddef;

vardef punct.pound =
  push_pbox_toexpand("punct.pound");

  push_stroke((660,680)..(510,760)..(420,390)..tension 1.1..(250,10)..
      (260,100)..(710,-10)..(810,70),
    (1.3,1.3)--(1.7,1.7)--(1.9,1.9)--(1.4,1.4)--(1.2,1.2)--
      (1.1,1.2)--(2,2)--(2.1,2.1)--(2,2)--(1.3,1.3));
  replace_strokep(0)(insert_nodes(oldp)(2.8,4.3,4.7));

  push_stroke((240,430)--(600,430),(2,2)--(2,2));
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef punct.psound =
  push_pbox_toexpand("punct.psound");
  push_stroke((130,390-15*mincho)..(500,390)..(870,390+10*mincho),
    (0.7,3.3)--(2,2)--(0.7,3.3));
  expand_pbox;
enddef;

vardef punct.make_period(expr cpos) =
  push_stroke(fullcircle scaled (tsu_punct_size*1.15) shifted cpos,
    (2,2)--(2,2)--(2,2)--(2,2)--cycle);
  set_bobrush(0,brpunct);

  if tsu_brush_max.brpunct>=0.3:
    set_bosize(0,40);
    push_lcblob(get_strokep(0));
  else:
    set_bosize(0,80);
  fi;

  push_pbox_explicit("punct.make_period",
    identity shifted (-0.5,-0.5) scaled (tsu_punct_size*1.5) shifted cpos);
enddef;

vardef punct.section =
  push_pbox_toexpand("punct.section");

  (x1+x3)/2=x2=x4=x6=500;
  x5=0.8[x2,x1];
  2*(x5-x2)=0.45*(latin_wide_high_r-latin_wide_low_r);

  y1=y3=0.8[ypart centre_pt,latin_wide_high_r];
  y2=latin_wide_high_r;
  y4=0.35[ypart centre_pt,latin_wide_high_r];
  y5=ypart centre_pt;
  y4-y5=y5-y6;

  push_stroke((z1..z2..z3..z4..z5..z6) rotatedaround (centre_pt,-6),
    (1.8,1.8)--(1.2,1.2)--(1.7,1.7)--(1.3,1.3)--(2,2)--(1.5,1.5));

  push_stroke(get_strokep(0) rotatedaround (centre_pt,180),get_strokeq(0));
  expand_pbox;
enddef;

vardef punct.slash =
  push_pbox_toexpand("punct.slash");
  (x1+x2)/2=500;
  (x1-x2)=0.67(y1-y2);

  y1=latin_wide_high_v;
  y2=latin_wide_low_v;

  push_stroke((z1--z2)
      shifted -centre_pt scaled (tsu_punct_size/100) shifted centre_pt,
    (2,2)--(2,2));
  set_bobrush(0,brpunct);
  expand_pbox;
enddef;

vardef punct.sqb_left =
  push_pbox_toexpand("punct.sqb_left");
  push_stroke((900,780)--
      (900-2.5*tsu_punct_size,780)--
      (900-2.5*tsu_punct_size,0)--
      (900,0),
    (2,2)--(2,2)--(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,1);
  expand_pbox;
enddef;

vardef punct.sqb_right =
  push_pbox_toexpand("punct.sqb_right");
  tsu_xform(identity rotatedaround (centre_pt,180))
    (punct.sqb_left);
  expand_pbox;
enddef;

vardef punct.times(expr t) =
  push_stroke(((-1,-1)--(1,1)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);
  push_stroke(((-1,1)--(1,-1)) transformed t,(2,2)--(2,2));
  set_bobrush(0,brpunct);
  set_bosize(0,90);

  push_pbox_explicit("punct.times",
    identity shifted (-0.5,-0.5) scaled 2.4 transformed t);
enddef;

vardef punct.underscore =
  push_pbox_toexpand("punct.underscore");
  push_stroke((100,0.3[latin_wide_desc_h,latin_wide_low_h])--
      (900,0.3[latin_wide_desc_h,latin_wide_low_h]),
    (2,2)--(2,2));
%  set_bobrush(0,brpunct);
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef punct.vline =
  push_pbox_toexpand("punct.vline");
  push_stroke((500,690+tsu_punct_size)--(500,90-tsu_punct_size),
    (1.6,1.6)--(1.6,1.6));
  set_bobrush(0,brpunct);
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef punct.wavedash =
  push_pbox_toexpand("punct.wavedash");
  push_stroke(((-3.5,-0.5){curl 0}..(-1.4,1)..(0,0)..(1.4,-1)..
      {curl 0}(3.5,0.5)) scaled tsu_punct_size shifted centre_pt,
    (0.7,2.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--
      (1.7,1.7)--(0.7,2.7));
  replace_strokep(0)(insert_nodes(oldp)(0.5,3.5));
  set_bobrush(0,brpunct);
  expand_pbox;
enddef;

vardef punct.wparen_left =
  push_pbox_toexpand("punct.wparen_left");

  push_stroke((900,780)..(900-2.15*tsu_punct_size,390)..(900,0),
    (1.5,1.5)--(2,2)--(1.5,1.5));
  set_bosize(0,90);

  push_stroke((900-2.15*tsu_punct_size,780)..
      (900-4*tsu_punct_size,390)..
      (900-2.15*tsu_punct_size,0),
    (1.5,1.5)--(2,2)--(1.5,1.5));
  set_bosize(0,90);
  expand_pbox;
enddef;

vardef punct.wparen_right =
  push_pbox_toexpand("punct.wparen_right");
  tsu_xform(identity rotatedaround (centre_pt,180))
    (punct.wparen_left);
  expand_pbox;
enddef;
