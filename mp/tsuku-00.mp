%
% Unicode page 00 (ASCII/ISO Latin-1) for Tsukurimashou
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
input latin.mp;
input numerals.mp;
input punct.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

transform ascii_punct_xf;
if is_proportional:
  ascii_punct_xf:=identity scaled (1.7*tsu_punct_size) shifted centre_pt;
else:
  ascii_punct_xf:=
    identity scaled (1.1*tsu_punct_size) shifted (250,latin_vcentre);
fi;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ASCII

% WARNING this code is substantially duplicated in tsuku-ff; just
% enough differences to make sharing impractical

% exclamation point
tsu_rescale_native_narrow;
begintsuglyph("exclam",33);
   if tsu_pbrush_size>=(tsu_punct_size*0.5):
     push_lcblob(fullcircle
        xscaled (tsu_punct_size+tsu_pbrush_size)
        yscaled (tsu_punct_size+tsu_pbrush_size*tsu_pbrush_shape)
        rotated tsu_pbrush_angle
        shifted (220,40));
   else:
     push_stroke(fullcircle scaled tsu_punct_size shifted (220,40),
       (2,2)--(2,2)--(2,2)--(2,2)--cycle);
     push_lcblob(get_strokep(0));
   fi;

   push_stroke((220,240){up}..(280,680){up}..{curl 1}(220,825){curl 1}..
     (160,680){down}..{down}(220,240),
     (1,1)--(2,2)--(2,2)--(2,2)--(1,1));

   if tsu_pbrush_size>=30:
     push_lcblob((subpath (0.1,3.9) of get_strokep(0))--cycle);
   fi;

   tsu_render;
endtsuglyph;
tsu_rescale_half;

% ASCII (neither left nor right) quotation mark
begintsuglyph("quotedbl",34);
  punct.asciiquote;
  tsu_render;
endtsuglyph;

% number sign
begintsuglyph("numbersign",35);
  punct.numbersign;
  tsu_render;
endtsuglyph;

% dollar sign
begintsuglyph("dollar",36);
  tsu_xform(identity shifted -centre_pt
    rotated -2 xyscaled (1.06,0.92) shifted centre_pt)(latin.ups);

  numeric x[],y[];
  x1=x2=0.53[xpart llcorner get_strokep(0),xpart lrcorner get_strokep(0)];
  y1=1.12[latin_wide_low_r,latin_wide_high_r];
  y2=(-0.15)[latin_wide_low_r,latin_wide_high_r];

  push_stroke(z1--z2,(2,2)--(2,2));
  set_bosize(0,90);

  tsu_render;
endtsuglyph;

% percent
begintsuglyph("percent",37);
  punct.percent;
  tsu_render;
endtsuglyph;

% ampersand
begintsuglyph("ampersand",38);
  punct.ampersand;
  tsu_render;
endtsuglyph;

% apostrophe
begintsuglyph("quotesingle",39);
  punct.make_comma((480,vmetric(0.94)),0);
  tsu_render;
endtsuglyph;

% left and right parentheses
begintsuglyph("parenleft",40);
  punct.paren_left;
  tsu_render;
endtsuglyph;
begintsuglyph("parenright",41);
  punct.paren_right;
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_native_conditional;

% asterisk
begintsuglyph("asterisk",42);
   begingroup
     path lobe,glyph[];

     lobe:=(1,0){up}..((1+tsu_brush_max)*tsu_punct_size/8,140){up}
       ..{curl 1}(0,175){curl 1}
       ..(-(1+tsu_brush_max)*tsu_punct_size/8,140){down};
     lobe:=(lobe..(lobe rotated 180)..cycle) scaled (tsu_punct_size/80);

     default_nib:=fix_nib(35*tsu_brush_max,
       35*tsu_brush_max*tsu_brush_shape,
       tsu_brush_angle);
     pen_stroke()(lobe shifted centre_pt shifted (-250,0))(glyph1);
     pen_stroke()(lobe rotated 60 shifted centre_pt shifted (-250,0))(glyph2);
     pen_stroke()(lobe rotated 120 shifted centre_pt shifted (-250,0))(glyph3);

     dangerousFill glyph1.r;
     dangerousFill glyph2.r;
     dangerousFill glyph3.r;
   endgroup;
endtsuglyph;

% plus
begintsuglyph("plus",43);
  punct.plus(ascii_punct_xf);
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_half;

% comma
begintsuglyph("comma",44);
  punct.make_comma((380,vmetric(0.03)),0);
  tsu_render;
endtsuglyph;

% hyphen-minus
tsu_rescale_native_conditional;
begintsuglyph("hyphen",45);
  punct.hminus(ascii_punct_xf);
  tsu_render;
endtsuglyph;
tsu_rescale_half;

% period
begintsuglyph("period",46);
  punct.make_period((380,vmetric(0.03)));
  tsu_render;
endtsuglyph;

% slash
begintsuglyph("slash",47);
  punct.slash;
  tsu_render;
endtsuglyph;

% 0
begintsuglyph("zero",48);
  numeral.zero;
  tsu_render;
endtsuglyph;

% 1
begintsuglyph("one",49);
  numeral.one;
  tsu_render;
endtsuglyph;

% 2
begintsuglyph("two",50);
  numeral.two;
  tsu_render;
endtsuglyph;

% 3
begintsuglyph("three",51);
  numeral.three;
  tsu_render;
endtsuglyph;

% 4
begintsuglyph("four",52);
  numeral.four;
  tsu_render;
endtsuglyph;

% 5
begintsuglyph("five",53);
  numeral.five;
  tsu_render;
endtsuglyph;

% 6
begintsuglyph("six",54);
  numeral.six;
  tsu_render;
endtsuglyph;

% 7
begintsuglyph("seven",55);
  numeral.seven;
  tsu_render;
endtsuglyph;

% 8
begintsuglyph("eight",56);
  numeral.eight;
  tsu_render;
endtsuglyph;

% 9
begintsuglyph("nine",57);
  numeral.nine;
  tsu_render;
endtsuglyph;

% colon
begintsuglyph("colon",58);
  punct.make_period((380,vmetric(0.03)));
  punct.make_period((380,vmetric(0.56)));
  tsu_render;
endtsuglyph;

% semicolon
begintsuglyph("semicolon",59);
  punct.make_comma((380,vmetric(0.03)),0);
  punct.make_period((380,vmetric(0.56)));
  tsu_render;
endtsuglyph;

% WARNING, changing rescale setting
tsu_rescale_native_conditional;

% less than
begintsuglyph("less",60);
  punct.less_than
    (identity scaled (if is_proportional: 2.1 else: 1.5 fi*tsu_punct_size)
       shifted (250,latin_vcentre));
  tsu_render;
endtsuglyph;

% equals
begintsuglyph("equals",61);
  punct.equals
    (identity scaled (if is_proportional: 2.1 else: 1.5 fi*tsu_punct_size)
       shifted (250,latin_vcentre));
  tsu_render;
endtsuglyph;

% greater than
begintsuglyph("greater",62);
  punct.greater_than
    (identity scaled (if is_proportional: 2.1 else: 1.5 fi*tsu_punct_size)
       shifted (250,latin_vcentre));
  tsu_render;
endtsuglyph;

% question mark
begintsuglyph("question",63);
   numeric r;
   if tsu_pbrush_size>=(tsu_punct_size*0.5):
     push_lcblob(fullcircle
        xscaled ((tsu_punct_size+tsu_pbrush_size)*0.89)
        yscaled ((tsu_punct_size+tsu_pbrush_size*tsu_pbrush_shape)*0.89)
        rotated tsu_pbrush_angle
        shifted (210,40));
   else:
     push_stroke(fullcircle scaled tsu_punct_size shifted (210,40),
       (2,2)--(2,2)--(2,2)--(2,2));
     if tsu_pbrush_size>=30:
       push_lcblob(get_strokep(0));
     fi;
   fi;
   r:=tsu_punct_size/2;

   push_stroke((210,300){right}..(210,300-r){left}..
       (210,300+r)..(210+2.5*r,750)..
       tension 1.3..(210-2.5*r,750+r)..
       (210-2.5*r,750-r){right}..
       (210-2.5*r,750){left},
     (0.8,0.8)--(1,1)--(2,2)--(2,2)--(2,2)--(2,2)--(1,1)--(0.8,0.8));
   replace_strokep(0)(insert_nodes(oldp)(2.5) rotatedaround ((210,10),-3));

   tsu_render;
endtsuglyph;

% WARNING, changing rescale setting
tsu_rescale_half;

% commercial at
begintsuglyph("at",64);
  punct.atsign;
  tsu_render;
endtsuglyph;

tsu_default_anchor(anc_upper_accent,tsu_xf.cap_upper_accent);
tsu_default_anchor(anc_lower_accent,accent_default[anc_lower_accent]);
tsu_default_anchor(anc_centre_accent,tsu_xf.low_centre_accent);
tsu_default_anchor(anc_upper_left,tsu_xf.cap_upper_accent);
tsu_default_anchor(anc_upper_right,tsu_xf.cap_upper_accent);
tsu_default_anchor(anc_upper_ring,tsu_xf.cap_upper_accent);
tsu_default_anchor(anc_caron_comma,
  accent_default[anc_caron_comma] shifted (200,0));

% A
begintsuglyph("A",65);
  latin.upa;
  tsu_render;
endtsuglyph;

% B
begintsuglyph("B",66);
  latin.upb;
  tsu_render;
endtsuglyph;

% C
begintsuglyph("C",67);
  latin.upc;
  tsu_render;
endtsuglyph;

% D
begintsuglyph("D",68);
  latin.upd;
  tsu_render;
endtsuglyph;

% E
begintsuglyph("E",69);
  latin.upe;
  tsu_render;
endtsuglyph;

% F
begintsuglyph("F",70);
  latin.upf;
  tsu_render;
endtsuglyph;

% G
begintsuglyph("G",71);
  latin.upg;
  tsu_render;
endtsuglyph;

% H
begintsuglyph("H",72);
  latin.uph;
  tsu_render;
endtsuglyph;

% I
begintsuglyph("I",73);
  latin.upi;
  tsu_render;
endtsuglyph;

% J
begintsuglyph("J",74);
  latin.upj;
  tsu_render;
endtsuglyph;

% K
begintsuglyph("K",75);
  latin.upk;
  tsu_render;
endtsuglyph;

% L
begintsuglyph("L",76);
  latin.upl;
  tsu_render;
endtsuglyph;

% M
begintsuglyph("M",77);
  latin.upm;
  tsu_render;
endtsuglyph;

% N
begintsuglyph("N",78);
  latin.upn;
  tsu_render;
endtsuglyph;

% O
begintsuglyph("O",79);
  latin.upo;
  tsu_render;
endtsuglyph;

% P
begintsuglyph("P",80);
  latin.upp;
  tsu_render;
endtsuglyph;

% Q
begintsuglyph("Q",81);
  latin.upq;
  tsu_render;
endtsuglyph;

% R
begintsuglyph("R",82);
  latin.upr;
  tsu_render;
endtsuglyph;

% S
begintsuglyph("S",83);
  latin.ups;
  tsu_render;
endtsuglyph;

% T
begintsuglyph("T",84);
  latin.upt;
  tsu_render;
endtsuglyph;

% U
begintsuglyph("U",85);
  latin.upu;
  tsu_render;
endtsuglyph;

% V
begintsuglyph("V",86);
  latin.upv;
  tsu_render;
endtsuglyph;

% W
begintsuglyph("W",87);
  latin.upw;
  tsu_render;
endtsuglyph;

% X
begintsuglyph("X",88);
  latin.upx;
  tsu_render;
endtsuglyph;

% Y
begintsuglyph("Y",89);
  latin.upy;
  tsu_render;
endtsuglyph;

% Z
begintsuglyph("Z",90);
  latin.upz;
  tsu_render;
endtsuglyph;

tsu_default_anchor(anc_upper_accent,0);
tsu_default_anchor(anc_lower_accent,0);
tsu_default_anchor(anc_centre_accent,0);
tsu_default_anchor(anc_upper_left,0);
tsu_default_anchor(anc_upper_right,0);
tsu_default_anchor(anc_upper_ring,0);
tsu_default_anchor(anc_caron_comma,0);

% left and right square brackets, backslash between
begintsuglyph("bracketleft",91);
  punct.sqb_left;
  tsu_render;
endtsuglyph;
% backslash
begintsuglyph("backslash",92);
  punct.slash;
  replace_strokep(0)(oldp reflectedabout (centre_pt,(centre_pt+down)));
  tsu_render;
endtsuglyph;
begintsuglyph("bracketright",93);
  punct.sqb_right;
  tsu_render;
endtsuglyph;

% circumflex accent/caret
begintsuglyph("asciicircum",94);
  tsu_accent.circumflex;
  tsu_render;
endtsuglyph;

% underscore
begintsuglyph("underscore",95);
  punct.underscore;
  tsu_render;
endtsuglyph;

% grave accent
begintsuglyph("grave",96);
  tsu_accent.grave;
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_half_lc;

tsu_default_anchor(anc_upper_accent,accent_default[anc_upper_accent]);
tsu_default_anchor(anc_lower_accent,accent_default[anc_lower_accent]);
tsu_default_anchor(anc_centre_accent,tsu_xf.low_centre_accent);
tsu_default_anchor(anc_upper_left,accent_default[anc_upper_accent]);
tsu_default_anchor(anc_upper_right,accent_default[anc_upper_accent]);
tsu_default_anchor(anc_upper_ring,accent_default[anc_upper_accent]);
tsu_default_anchor(anc_caron_comma,accent_default[anc_caron_comma]);

% a
begintsuglyph("a",97);
  latin.lowa;
  tsu_render;
endtsuglyph;

% b
begintsuglyph("b",98);
  latin.lowb;
  tsu_render;
endtsuglyph;

% c
begintsuglyph("c",99);
  latin.lowc;
  tsu_render;
endtsuglyph;

% d
begintsuglyph("d",100);
  latin.lowd;
  tsu_render;
endtsuglyph;

% e
begintsuglyph("e",101);
  latin.lowe;
  tsu_render;
endtsuglyph;

% f
begintsuglyph("f",102);
  latin.lowf;
  tsu_render;
endtsuglyph;

% g
begintsuglyph("g",103);
  latin.lowg;
  tsu_render;
endtsuglyph;

% h
begintsuglyph("h",104);
  latin.lowh;
  tsu_render;
endtsuglyph;

% i
begintsuglyph("i",105);
  latin.lowi;
  tsu_render;
endtsuglyph;

% j
begintsuglyph("j",106);
  latin.lowj;
  tsu_render;
endtsuglyph;

% k
begintsuglyph("k",107);
  latin.lowk;
  tsu_render;
endtsuglyph;

% l
begintsuglyph("l",108);
  latin.lowl;
  tsu_render;
endtsuglyph;

% m
begintsuglyph("m",109);
  latin.lowm;
  tsu_render;
endtsuglyph;

% n
begintsuglyph("n",110);
  latin.lown;
  tsu_render;
endtsuglyph;

% o
begintsuglyph("o",111);
  latin.lowo;
  tsu_render;
endtsuglyph;

% p
begintsuglyph("p",112);
  latin.lowp;
  tsu_render;
endtsuglyph;

% q
begintsuglyph("q",113);
  latin.lowq;
  tsu_render;
endtsuglyph;

% r
begintsuglyph("r",114);
  latin.lowr;
  tsu_render;
endtsuglyph;

% s
begintsuglyph("s",115);
  latin.lows;
  tsu_render;
endtsuglyph;

% t
begintsuglyph("t",116);
  latin.lowt;
  tsu_render;
endtsuglyph;

% u
begintsuglyph("u",117);
  latin.lowu;
  tsu_render;
endtsuglyph;

% v
begintsuglyph("v",118);
  latin.lowv;
  tsu_render;
endtsuglyph;

% w
begintsuglyph("w",119);
  latin.loww;
  tsu_render;
endtsuglyph;

% x
begintsuglyph("x",120);
  latin.lowx;
  tsu_render;
endtsuglyph;

% y
begintsuglyph("y",121);
  latin.lowy;
  tsu_render;
endtsuglyph;

% z
begintsuglyph("z",122);
  latin.lowz;
  tsu_render;
endtsuglyph;

tsu_default_anchor(anc_upper_accent,0);
tsu_default_anchor(anc_lower_accent,0);
tsu_default_anchor(anc_centre_accent,0);
tsu_default_anchor(anc_upper_left,0);
tsu_default_anchor(anc_upper_right,0);
tsu_default_anchor(anc_upper_ring,0);
tsu_default_anchor(anc_caron_comma,0);

% WARNING changing rescale setting
tsu_rescale_half;

% left and right square brackets
begintsuglyph("braceleft",123);
  punct.brace_left;
  tsu_render;
endtsuglyph;
begintsuglyph("bar",124);
  punct.vline;
  tsu_render;
endtsuglyph;
begintsuglyph("braceright",125);
  punct.brace_right;
  tsu_render;
endtsuglyph;

% "tilde" - rescaled "wave dash"
begintsuglyph("asciitilde",126);
  punct.wavedash;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 007F through 009F are nonprinting control characters.
% 00A0 is a space, supplied by the make-font script later

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LATIN-1 EXTRA CHARACTERS

transform tsu_xf.latin_one_super,tsu_xf.latin_one_circled,
  tsu_xf.latin_one_cbound;

if is_proportional:
  xypart tsu_xf.latin_one_super=yxpart tsu_xf.latin_one_super=0;
  xxpart tsu_xf.latin_one_super=yypart tsu_xf.latin_one_super=0.65;
  (500,latin_wide_xheight_r) transformed tsu_xf.latin_one_super=
    (500,2*latin_vcentre);

  xypart tsu_xf.latin_one_circled=yxpart tsu_xf.latin_one_circled=0;
  xxpart tsu_xf.latin_one_circled=yypart tsu_xf.latin_one_circled=0.5;
  centre_pt transformed tsu_xf.latin_one_circled=centre_pt;

  tsu_xf.latin_one_cbound=identity scaled 225 shifted centre_pt;

else:
  xypart tsu_xf.latin_one_super=yxpart tsu_xf.latin_one_super=0;
  xxpart tsu_xf.latin_one_super=yypart tsu_xf.latin_one_super=0.55;
  (500,latin_wide_xheight_r) transformed tsu_xf.latin_one_super=
    (250,2*latin_vcentre);

  xypart tsu_xf.latin_one_circled=yxpart tsu_xf.latin_one_circled=0;
  xxpart tsu_xf.latin_one_circled=yypart tsu_xf.latin_one_circled=0.333;
  centre_pt transformed tsu_xf.latin_one_circled=(250,latin_vcentre);

  tsu_xf.latin_one_cbound=identity scaled 150 shifted (250,latin_vcentre);
fi;

% inverted exclamation point
tsu_rescale_native_narrow;
begintsuglyph("exclamdown",161);
   if tsu_pbrush_size>=(tsu_punct_size*0.5):
     push_lcblob(fullcircle
       xscaled (tsu_punct_size+tsu_pbrush_size)
       yscaled (tsu_punct_size+tsu_pbrush_size*tsu_pbrush_shape)
       rotated tsu_pbrush_angle
       shifted (220,40)
       rotatedaround ((250,390),180));
   else:
     push_stroke(fullcircle
         scaled tsu_punct_size
         shifted (220,40)
         rotatedaround ((250,390),180),
       (2,2)--(2,2)--(2,2)--(2,2));
     if tsu_pbrush_size>=30:
       push_lcblob(get_strokep(0));
     fi;
   fi;

   push_stroke(((220,240){up}..(280,680){up}..{curl 1}(220,825){curl 1}..
       (160,680){down}..{down}(220,240))
       rotatedaround ((250,390),180),
     (1,1)--(2,2)--(2,2)--(2,2)--(1,1));

   if tsu_pbrush_size>=30:
     push_lcblob((subpath (0.1,3.9) of get_strokep(0))--cycle);
   fi;

   tsu_render;
endtsuglyph;
tsu_rescale_half;

begintsuglyph("cent",162);
  tsu_accent.apply(latin.lowc)(tsu_accent.slash);
  tsu_render;
endtsuglyph;

begintsuglyph("sterling",163);
  punct.pound;
  tsu_render;
endtsuglyph;

begintsuglyph("currency",164);
  punct.currency;
  tsu_render;
endtsuglyph;

% yen sign
begintsuglyph("yen",165);
  latin.upy;
  push_stroke(((-240,0)--(240,0)) shifted point 1 of get_strokep(-1),
    (2,2)--(2,2));
  set_bosize(0,80);
  push_stroke(((-240,0)--(240,0)) shifted point 1.333 of get_strokep(-2),
    (2,2)--(2,2));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

begintsuglyph("brokenbar",166);
  punct.bvline;
  tsu_render;
endtsuglyph;

begintsuglyph("section",167);
  punct.section;
  tsu_render;
endtsuglyph;

% naked umlaut
begintsuglyph("dieresis",168);
  tsu_accent.umlaut;
  tsu_render;
endtsuglyph;

% WARNING, setting rescale
tsu_rescale_native_conditional;

begintsuglyph("copyright",169);
  Fill fullcircle scaled (1320+120*tsu_brush_max) shifted centre_pt
    transformed tsu_xf.latin_one_circled;
  unFill reverse fullcircle scaled (1320-120*tsu_brush_max)
    shifted centre_pt transformed tsu_xf.latin_one_circled;
  tsu_xform(tsu_xf.latin_one_circled)(latin.upc);
  tsu_render_in_circle(tsu_xf.latin_one_cbound);
endtsuglyph;

begintsuglyph("ordfeminine",170);
  tsu_xform(tsu_xf.latin_one_super)(
    latin.lowa;
    push_stroke((270,-110)--(740,-110),(2,2)--(2,2)));
  set_bosize(0,get_bosize(-1));
  tsu_render;
endtsuglyph;

% WARNING, changing rescale setting
tsu_rescale_half;

begintsuglyph("guillemotleft",171);
  punct.guillemet_left;
  tsu_render;
endtsuglyph;

% WARNING, setting rescale
tsu_rescale_native_conditional;

begintsuglyph("logicalnot",172);
  punct.notsign(ascii_punct_xf);
  tsu_render;
endtsuglyph;

% soft hyphen is a zero-width space and added by make-font script

begintsuglyph("registered",174);
  Fill fullcircle scaled (1320+120*tsu_brush_max) shifted centre_pt
    transformed tsu_xf.latin_one_circled;
  unFill reverse fullcircle scaled (1320-120*tsu_brush_max)
    shifted centre_pt transformed tsu_xf.latin_one_circled;
  tsu_xform(tsu_xf.latin_one_circled)(latin.upr);
  tsu_render_in_circle(tsu_xf.latin_one_cbound);
endtsuglyph;

% WARNING, setting rescale
tsu_rescale_half;

% naked macron
begintsuglyph("macron",175);
  tsu_accent.apply(latin.lowe;set_bosize(0,0))(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% WARNING, setting rescale
tsu_rescale_native_conditional;

begintsuglyph("degree",176);
  Fill fullcircle scaled (2.5*tsu_punct_size) shifted (250,760);
  unFill reverse fullcircle
    scaled (2.5*tsu_punct_size-120*tsu_brush_max) shifted (250,760);
endtsuglyph;

begintsuglyph("plusminus",177);
  punct.plusminus(ascii_punct_xf);
  tsu_render;
endtsuglyph;

begintsuglyph("uni00B2",178);
  tsu_xform(identity yscaled 0.68 transformed tsu_xf.latin_one_super)(
    numeral.two);
  tsu_render;
endtsuglyph;

begintsuglyph("uni00B3",179);
  tsu_xform(identity yscaled 0.68 transformed tsu_xf.latin_one_super)(
    numeral.three);
  tsu_render;
endtsuglyph;

% WARNING, changing rescale setting
tsu_rescale_half;

% naked acute
begintsuglyph("acute",180);
  tsu_accent.acute;
  tsu_render;
endtsuglyph;

% micro
begintsuglyph("mu",181);
  punct.micro;
  tsu_render;
endtsuglyph;

% pilcrow
begintsuglyph("paragraph",182);
  punct.pilcrow;
  tsu_render;
endtsuglyph;

% period at centre
begintsuglyph("periodcentered",183);
  punct.make_period(centre_pt);
  tsu_render;
endtsuglyph;

% naked cedilla
begintsuglyph("cedilla",184);
  tsu_accent.apply(latin.lowc;set_bosize(0,0))(tsu_accent.cedilla);
  tsu_render;
endtsuglyph;

% WARNING, changing rescale setting
tsu_rescale_native_conditional;

begintsuglyph("uni00B9",185);
  tsu_xform(identity yscaled 0.68 transformed tsu_xf.latin_one_super)(
    numeral.one);
  tsu_render;
endtsuglyph;

begintsuglyph("ordmasculine",186);
  tsu_xform(tsu_xf.latin_one_super)(
    latin.lowo;
    push_stroke((260,-120)--(740,-120),(2,2)--(2,2)));
  tsu_render;
endtsuglyph;

% WARNING, changing rescale setting
tsu_rescale_half;

begintsuglyph("guillemotright",187);
  punct.guillemet_right;
  tsu_render;
endtsuglyph;

% WARNING, changing rescale setting
tsu_rescale_native_conditional;

% question mark
begintsuglyph("questiondown",191);
   if tsu_pbrush_size>=(tsu_punct_size*0.5):
     push_lcblob(fullcircle
       xscaled ((tsu_punct_size+tsu_pbrush_size)*0.89)
       yscaled ((tsu_punct_size+tsu_pbrush_size*tsu_pbrush_shape)*0.89)
       rotated tsu_pbrush_angle
       shifted (210,40)
       rotatedaround ((250,390),180));
   else:
     push_stroke(fullcircle scaled tsu_punct_size shifted (210,40)
         rotatedaround ((250,390),180),
       (1,1)..(2,2)..(2,2)..(1,1));
     if tsu_pbrush_size>=30:
       push_lcblob(get_strokep(0));
     fi;
   fi;
   r:=tsu_punct_size/2;

   push_stroke((210,300){right}..(210,300-r){left}..
       (210,300+r)..(210+2.5*r,750)..
       tension 1.3..(210-2.5*r,750+r)..
       (210-2.5*r,750-r){right}..
       (210-2.5*r,750){left},
     (0.8,0.8)--(1,1)--(2,2)--(2,2)--(2,2)--(2,2)--(1,1)--(0.8,0.8));
   replace_strokep(0)(insert_nodes(oldp)(2.5)
     rotatedaround ((210,10),-3) rotatedaround ((250,390),180));

  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ACCENTED LATIN

% WARNING, setting rescale
tsu_rescale_half;

% A with grave
begintsuglyph("Agrave",192);
  tsu_accent.apply(tsu_accent.capital(latin.upa))(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% A with acute
begintsuglyph("Aacute",193);
  tsu_accent.apply(tsu_accent.capital(latin.upa))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% A with circumflex
begintsuglyph("Acircumflex",194);
  tsu_accent.apply(tsu_accent.capital(latin.upa))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% A with tilde
begintsuglyph("Atilde",195);
  tsu_accent.apply(tsu_accent.capital(latin.upa))(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% A with dieresis/umlaut
begintsuglyph("Adieresis",196);
  tsu_accent.apply(tsu_accent.capital(latin.upa))(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

% A with ring above
begintsuglyph("Aring",197);
  tsu_accent.apply(tsu_accent.capital(latin.upa))(tsu_accent.ringabove);
  if do_alternation:
    set_boserif(-2,1,whatever);
  else:
    set_boserif(-1,1,whatever);
  fi;
  tsu_render;
endtsuglyph;

% AE ligature
begintsuglyph("AE",198);
  latin.upae;
  tsu_render;
endtsuglyph;

% C with cedilla
begintsuglyph("Ccedilla",199);
  tsu_accent.apply(latin.upc)(tsu_accent.cedilla);
  tsu_render;
endtsuglyph;

% E with grave
begintsuglyph("Egrave",200);
  tsu_accent.apply(tsu_accent.capital(latin.upe))(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% E with acute
begintsuglyph("Eacute",201);
  tsu_accent.apply(tsu_accent.capital(latin.upe))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% E with circumflex
begintsuglyph("Ecircumflex",202);
  tsu_accent.apply(tsu_accent.capital(latin.upe))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% E with dieresis/umlaut
begintsuglyph("Edieresis",203);
  tsu_accent.apply(tsu_accent.capital(latin.upe))(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

% I with grave
begintsuglyph("Igrave",204);
  tsu_accent.apply(tsu_accent.capital(latin.upi))(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% I with acute
begintsuglyph("Iacute",205);
  tsu_accent.apply(tsu_accent.capital(latin.upi))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% I with circumflex
begintsuglyph("Icircumflex",206);
  tsu_accent.apply(tsu_accent.capital(latin.upi))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% I with dieresis/umlaut
begintsuglyph("Idieresis",207);
  tsu_accent.apply(tsu_accent.capital(latin.upi))(tsu_accent.umlaut);
  replace_lcblob(-1)(oldblob shifted (15*left));
  replace_lcblob(0)(oldblob shifted (15*left));
  tsu_render;
endtsuglyph;

% uppercase Icelandic Eth
begintsuglyph("Eth",208);
  latin.upeth;
  tsu_render;
endtsuglyph;

% N with tilde
begintsuglyph("Ntilde",209);
  tsu_accent.apply(tsu_accent.capital(latin.upn))(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% O with grave
begintsuglyph("Ograve",210);
  tsu_accent.apply(tsu_accent.capital(latin.upo))(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% O with acute
begintsuglyph("Oacute",211);
  tsu_accent.apply(tsu_accent.capital(latin.upo))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% O with circumflex
begintsuglyph("Ocircumflex",212);
  tsu_accent.apply(tsu_accent.capital(latin.upo))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% O with tilde
begintsuglyph("Otilde",213);
  tsu_accent.apply(tsu_accent.capital(latin.upo))(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% O with dieresis/umlaut
begintsuglyph("Odieresis",214);
  tsu_accent.apply(tsu_accent.capital(latin.upo))(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

% times
tsu_rescale_native_conditional;
begintsuglyph("multiply",215);
  punct.times(ascii_punct_xf);
  tsu_render;
endtsuglyph;
tsu_rescale_half;

% O with stroke
begintsuglyph("Oslash",216);
  tsu_accent.apply(latin.upo)(tsu_accent.slash);
  replace_strokep(-1)(insert_nodes(oldp)(0.3,1.3,2.3,3.3));
  replace_strokeq(-1)(insert_nodes(oldq)(0.3,1.3,2.3,3.3));
  tsu_render;
endtsuglyph;

% U with grave
begintsuglyph("Ugrave",217);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% U with acute
begintsuglyph("Uacute",218);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% U with circumflex
begintsuglyph("Ucircumflex",219);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% U with dieresis/umlaut
begintsuglyph("Udieresis",220);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

% Y with acute
begintsuglyph("Yacute",221);
  tsu_accent.apply(tsu_accent.capital(latin.upy))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% uppercase Thorn
begintsuglyph("Thorn",222);
  latin.upthorn;
  tsu_render;
endtsuglyph;

% eszett
begintsuglyph("germandbls",223);
  latin.loweszett;
  tsu_render;
endtsuglyph;

% a with grave
begintsuglyph("agrave",224);
  tsu_accent.apply(latin.lowa)(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% a with acute
begintsuglyph("aacute",225);
  tsu_accent.apply(latin.lowa)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% a with circumflex
begintsuglyph("acircumflex",226);
  tsu_accent.apply(latin.lowa)(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% a with tilde
begintsuglyph("atilde",227);
  tsu_accent.apply(latin.lowa)(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% a with dieresis/umlaut
begintsuglyph("adieresis",228);
  tsu_accent.apply(latin.lowa)(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

% a with ring above
begintsuglyph("aring",229);
  tsu_accent.apply(latin.lowa)(tsu_accent.ringabove);
  replace_lcblob(-1)(oldblob shifted (30,-20));
  replace_lcblob(0)(oldblob shifted (30,-20));
  tsu_render;
endtsuglyph;

% ae ligature
begintsuglyph("ae",230);
  latin.lowae;
  tsu_render;
endtsuglyph;

% c with cedilla
begintsuglyph("ccedilla",231);
  tsu_accent.apply(latin.lowc)(tsu_accent.cedilla);
  tsu_render;
endtsuglyph;

% e with grave
begintsuglyph("egrave",232);
  tsu_accent.apply(latin.lowe)(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% e with acute
begintsuglyph("eacute",233);
  tsu_accent.apply(latin.lowe)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% e with circumflex
begintsuglyph("ecircumflex",234);
  tsu_accent.apply(latin.lowe)(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% e with dieresis/umlaut
begintsuglyph("edieresis",235);
  tsu_accent.apply(latin.lowe)(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

% i with grave
begintsuglyph("igrave",236);
  tsu_accent.apply(
    latin.lowi;
    replace_strokep(0)(oldp shifted (70*right));
    pop_lcblob;
  )(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% i with acute
begintsuglyph("iacute",237);
  tsu_accent.apply(latin.lowi;pop_lcblob)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% i with circumflex
begintsuglyph("icircumflex",238);
  tsu_accent.apply(
    latin.lowi;
    replace_strokep(0)(oldp shifted (70*right));
    pop_lcblob;
  )(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% i with dieresis/umlaut
begintsuglyph("idieresis",239);
  tsu_accent.apply(
    latin.lowi;
    replace_strokep(0)(oldp shifted (70*right));
    pop_lcblob;
  )(tsu_accent.umlaut);
  replace_lcblob(-1)(oldblob shifted (50*right));
  replace_lcblob(0)(oldblob shifted (50*left));
  tsu_render;
endtsuglyph;

% lowercase Icelandic eth
begintsuglyph("eth",240);
  latin.loweth;
  tsu_render;
endtsuglyph;

% n with tilde
begintsuglyph("ntilde",241);
  tsu_accent.apply(latin.lown)(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% o with grave
begintsuglyph("ograve",242);
  tsu_accent.apply(latin.lowo)(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% o with acute
begintsuglyph("oacute",243);
  tsu_accent.apply(latin.lowo)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% o with circumflex
begintsuglyph("ocircumflex",244);
  tsu_accent.apply(latin.lowo)(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% o with tilde
begintsuglyph("otilde",245);
  tsu_accent.apply(latin.lowo)(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% o with dieresis/umlaut
begintsuglyph("odieresis",246);
  tsu_accent.apply(latin.lowo)(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

% division sign
tsu_rescale_native_conditional;
begintsuglyph("divide",247);
  punct.dividedby(ascii_punct_xf);
  tsu_render;
endtsuglyph;
tsu_rescale_half;

% o with stroke
begintsuglyph("oslash",248);
  tsu_accent.apply(latin.lowo)(tsu_accent.slash);
  tsu_render;
endtsuglyph;

% u with grave
begintsuglyph("ugrave",249);
  tsu_accent.apply(latin.lowu)(tsu_accent.grave);
  tsu_render;
endtsuglyph;

% u with acute
begintsuglyph("uacute",250);
  tsu_accent.apply(latin.lowu)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% u with circumflex
begintsuglyph("ucircumflex",251);
  tsu_accent.apply(latin.lowu)(tsu_accent.circumflex);
  replace_strokep(0)(oldp shifted (-30,0));
  tsu_render;
endtsuglyph;

% u with dieresis/umlaut
begintsuglyph("udieresis",252);
  tsu_accent.apply(latin.lowu)(tsu_accent.umlaut);
  replace_lcblob(-1)(oldblob shifted (-60,0));
  replace_lcblob(0)(oldblob shifted (-60,0));
  tsu_render;
endtsuglyph;

% y with acute
begintsuglyph("yacute",253);
  tsu_accent.apply(latin.lowy)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% thorn
begintsuglyph("thorn",254);
  latin.lowthorn;
  tsu_render;
endtsuglyph;

% y with dieresis/umlaut
begintsuglyph("ydieresis",255);
  tsu_accent.apply(latin.lowy)(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
