%
% Unicode page FF (Full-width and Half-width Forms) for Tsukurimashou
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

input latin-intro.mp;

% AUTODEPS
input accent.mp;
input dakuten.mp;
input katakana.mp;
input latin.mp;
input numerals.mp;
input punct.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FULL-WIDTH FORMS

% WARNING this code is substantially duplicated in tsuku-00; just
% enough differences to make sharing impractical

% exclamation point
begintsuglyph("uniFF01",1);
   if tsu_brush_max.brpunct*100>=tsu_punct_size:
     push_lcblob(fullcircle
        xscaled (tsu_punct_size+tsu_brush_max.brpunct*100)
        yscaled (tsu_punct_size+tsu_brush_max.brpunct*100*tsu_brush_shape.brpunct)
        rotated tsu_pbrush_angle
        shifted (500,30));
   else:
     push_stroke(fullcircle scaled tsu_punct_size shifted (500,30),
       (2,2)--(2,2)--(2,2)--(2,2)--cycle);
     if tsu_brush_max.brpunct*100>=3:
       push_lcblob(get_strokep(0));
     fi;
   fi;

   push_stroke((500,250){up}..(580,620){up}..{curl 1}(500,750){curl 1}..
       (420,620){down}..{down}(500,250),
     (2,2)--(2,2)--(2,2)--(2,2)--(2,2));

   if tsu_brush_max.brpunct>=0.3:
     push_lcblob((subpath (0.1,3.9) of get_strokep(0))--cycle);
   fi;
   tsu_render;
endtsuglyph;

% ASCII (neither left nor right) quotation mark
begintsuglyph("uniFF02",2);
  punct.asciiquote;
  tsu_render;
endtsuglyph;

% number sign
begintsuglyph("uniFF03",3);
  punct.numbersign;
  tsu_render;
endtsuglyph;

% dollar sign
begintsuglyph("uniFF04",4);
  tsu_xform(identity shifted -centre_pt
    rotated -2 xyscaled (1.06,0.92) shifted centre_pt)(latin.ups);

  numeric x[],y[];
  x1=x2=0.38[xpart llcorner get_strokep(0),xpart lrcorner get_strokep(0)];
  x3=x4=0.69[xpart llcorner get_strokep(0),xpart lrcorner get_strokep(0)];
  y1=y3=1.12[latin_wide_low_r,latin_wide_high_r];
  y2=y4=(-0.15)[latin_wide_low_r,latin_wide_high_r];

  z5=(get_strokep(0) intersectionpoint (z1--z2))+(2,-1);
  push_stroke((z1--z5--z2) shifted (0,-1),
    (2,2)--(2,2)--(2,2));
  set_bosize(0,85);
  set_bobrush(0,bralternate);

  z6=(get_strokep(-1) intersectionpoint (z3--z4))+(3,1);
  push_stroke((z3--z6--z4) shifted (0,1),
    (2,2)--(2,2)--(2,2));
  set_bosize(0,85);
  set_bobrush(0,bralternate);

  tsu_render;
endtsuglyph;

% percent
begintsuglyph("uniFF05",5);
  punct.percent;
  tsu_render;
endtsuglyph;

% ampersand
begintsuglyph("uniFF06",6);
  punct.ampersand;
  tsu_render;
endtsuglyph;

% apostrophe
begintsuglyph("uniFF07",7);
  punct.make_comma((480,vmetric(0.94)),0);
  tsu_render;
endtsuglyph;

% left and right parentheses
begintsuglyph("uniFF08",8);
  punct.paren_left;
  tsu_render;
endtsuglyph;
begintsuglyph("uniFF09",9);
  punct.paren_right;
  tsu_render;
endtsuglyph;

% asterisk
begintsuglyph("uniFF0A",10);
   begingroup
     save lobe,glyph,nlobes;
     path lobe,glyph;
     numeric nlobes;

     lobe:=(1,0){up}..((1+tsu_brush_max.brpunct)*tsu_punct_size/4,280){up}
       ..{curl 1}(0,350){curl 1}
       ..(-(1+tsu_brush_max.brpunct)*tsu_punct_size/4,280){down};
     if rescale_slant>50:
       lobe:=(lobe..(-1,0){down}..(0,-1)..cycle) scaled (tsu_punct_size/90);
       nlobes:=5;
     else:
       lobe:=(lobe..(lobe rotated 180)..cycle) scaled (tsu_punct_size/100);
       nlobes:=3;
     fi;

     default_nib:=fix_nib(50*tsu_brush_max.brpunct,
       50*tsu_brush_max.brpunct*tsu_brush_shape.brpunct,
       tsu_brush_angle.brpunct);
     
     for i:=0 upto nlobes-1:
       pen_stroke()(lobe rotated (i*360/nlobes)
                         shifted (centre_pt+(-250,0)))(glyph);
       dangerousFill glyph.r;
     endfor;
   endgroup;
endtsuglyph;

% plus
begintsuglyph("uniFF0B",11);
  punct.plus
    (identity scaled (2*tsu_punct_size) shifted centre_pt);
  tsu_render;
endtsuglyph;

% comma
begintsuglyph("uniFF0C",12);
  punct.make_comma((380,vmetric(0.03)),0);
  tsu_render;
endtsuglyph;

% hyphen-minus
begintsuglyph("uniFF0D",13);
  punct.hminus
    (identity scaled (2*tsu_punct_size) shifted centre_pt);
  tsu_render;
endtsuglyph;

% period
begintsuglyph("uniFF0E",14);
  punct.make_period((380,vmetric(0.03)));
  tsu_render;
endtsuglyph;

% slash
begintsuglyph("uniFF0F",15);
  punct.slash;
  tsu_render;
endtsuglyph;

% 0
begintsuglyph("uniFF10",16);
  numeral.zero;
  tsu_render;
endtsuglyph;

% 1
begintsuglyph("uniFF11",17);
  numeral.one;
  tsu_render;
endtsuglyph;

% 2
begintsuglyph("uniFF12",18);
  numeral.two;
  tsu_render;
endtsuglyph;

% 3
begintsuglyph("uniFF13",19);
  numeral.three;
  tsu_render;
endtsuglyph;

% 4
begintsuglyph("uniFF14",20);
  numeral.four;
  tsu_render;
endtsuglyph;

% 5
begintsuglyph("uniFF15",21);
  numeral.five;
  tsu_render;
endtsuglyph;

% 6
begintsuglyph("uniFF16",22);
  numeral.six;
  tsu_render;
endtsuglyph;

% 7
begintsuglyph("uniFF17",23);
  numeral.seven;
  tsu_render;
endtsuglyph;

% 8
begintsuglyph("uniFF18",24);
  numeral.eight;
  tsu_render;
endtsuglyph;

% 9
begintsuglyph("uniFF19",25);
  numeral.nine;
  tsu_render;
endtsuglyph;

% colon
begintsuglyph("uniFF1A",26);
  punct.make_period((380,vmetric(0.03)));
  punct.make_period((380,vmetric(0.56)));
  tsu_render;
endtsuglyph;

% semicolon
begintsuglyph("uniFF1B",27);
  punct.make_comma((380,vmetric(0.03)),0);
  punct.make_period((380,vmetric(0.56)));
  tsu_render;
endtsuglyph;

% less than
begintsuglyph("uniFF1C",28);
  punct.less_than
    (identity scaled (2.5*tsu_punct_size) shifted centre_pt);
  tsu_render;
endtsuglyph;

% equals
begintsuglyph("uniFF1D",29);
  punct.equals
    (identity scaled (2.5*tsu_punct_size) shifted centre_pt);
  tsu_render;
endtsuglyph;

% greater than
begintsuglyph("uniFF1E",30);
  punct.greater_than
    (identity scaled (2.5*tsu_punct_size) shifted centre_pt);
  tsu_render;
endtsuglyph;

% question mark
begintsuglyph("uniFF1F",31);
   numeric r;
   if tsu_brush_max.brpunct*100>=tsu_punct_size:
     push_lcblob(fullcircle
        xscaled (tsu_punct_size+tsu_brush_max.brpunct*100)
        yscaled (tsu_punct_size+tsu_brush_max.brpunct*100*tsu_brush_shape.brpunct)
        rotated tsu_pbrush_angle
        shifted (480,10));
     r:=tsu_brush_max.brpunct*100;
   else:
     push_stroke(fullcircle scaled tsu_punct_size rotated 5 shifted (480,10),
       (2,2)--(2,2)--(2,2)--(2,2)--cycle);
     if tsu_brush_max.brpunct>=0.3:
       push_lcblob(get_strokep(0));
     fi;
     r:=tsu_punct_size;
   fi;

   push_stroke((480,300){right}..(480,300-r){left}..
       (480,300+r)..(480+2.5*r,600)..
       tension 1.3..(480-2.5*r,600+r)..
       (480-2.5*r,600-r){right}..
       (480-2.5*r,600){left},
     (0.8,0.8)--(1,1)--(2,2)--(2,2)--(2,2)--(2,2)--(1,1)--(0.8,0.8));
   replace_strokep(0)(insert_nodes(oldp)(2.5) rotatedaround ((480,10),-5));

   tsu_render;
endtsuglyph;

% commercial at
begintsuglyph("uniFF20",32);
  punct.atsign;
  tsu_render;
endtsuglyph;

tsu_accent.up_default_anchors;

% A
begintsuglyph("uniFF21",33);
  latin.upa;
  tsu_render;
endtsuglyph;

% B
begintsuglyph("uniFF22",34);
  latin.upb;
  tsu_render;
endtsuglyph;

% C
begintsuglyph("uniFF23",35);
  latin.upc;
  tsu_render;
endtsuglyph;

% D
begintsuglyph("uniFF24",36);
  latin.upd;
  tsu_render;
endtsuglyph;

% E
begintsuglyph("uniFF25",37);
  latin.upe;
  tsu_render;
endtsuglyph;

% F
begintsuglyph("uniFF26",38);
  latin.upf;
  tsu_render;
endtsuglyph;

% G
begintsuglyph("uniFF27",39);
  latin.upg;
  tsu_render;
endtsuglyph;

% H
begintsuglyph("uniFF28",40);
  latin.uph;
  tsu_render;
endtsuglyph;

% I
begintsuglyph("uniFF29",41);
  latin.upi;
  tsu_render;
endtsuglyph;

% J
begintsuglyph("uniFF2A",42);
  latin.upj;
  tsu_render;
endtsuglyph;

% K
begintsuglyph("uniFF2B",43);
  latin.upk;
  tsu_render;
endtsuglyph;

% L
begintsuglyph("uniFF2C",44);
  latin.upl;
  tsu_render;
endtsuglyph;

% M
begintsuglyph("uniFF2D",45);
  latin.upm;
  tsu_render;
endtsuglyph;

% N
begintsuglyph("uniFF2E",46);
  latin.upn;
  tsu_render;
endtsuglyph;

% O
begintsuglyph("uniFF2F",47);
  latin.upo;
  tsu_render;
endtsuglyph;

% P
begintsuglyph("uniFF30",48);
  latin.upp;
  tsu_render;
endtsuglyph;

% Q
begintsuglyph("uniFF31",49);
  latin.upq;
  tsu_render;
endtsuglyph;

% R
begintsuglyph("uniFF32",50);
  latin.upr;
  tsu_render;
endtsuglyph;

% S
begintsuglyph("uniFF33",51);
  latin.ups;
  tsu_render;
endtsuglyph;

% T
begintsuglyph("uniFF34",52);
  latin.upt;
  tsu_render;
endtsuglyph;

% U
begintsuglyph("uniFF35",53);
  latin.upu;
  tsu_render;
endtsuglyph;

% V
begintsuglyph("uniFF36",54);
  latin.upv;
  tsu_render;
endtsuglyph;

% W
begintsuglyph("uniFF37",55);
  latin.upw;
  tsu_render;
endtsuglyph;

% X
begintsuglyph("uniFF38",56);
  latin.upx;
  tsu_render;
endtsuglyph;

% Y
begintsuglyph("uniFF39",57);
  latin.upy;
  tsu_render;
endtsuglyph;

% Z
begintsuglyph("uniFF3A",58);
  latin.upz;
  tsu_render;
endtsuglyph;

tsu_accent.clear_default_anchors;

% left and right square brackets
begintsuglyph("uniFF3B",59);
  punct.sqb_left;
  tsu_render;
endtsuglyph;
% backslash
begintsuglyph("uniFF3C",60);
  tsu_xform(identity reflectedabout (centre_pt,(centre_pt+down)))
    (punct.slash);
  tsu_render;
endtsuglyph;
begintsuglyph("uniFF3D",61);
  punct.sqb_right;
  tsu_render;
endtsuglyph;

% circumflex/caret
begintsuglyph("uniFF3E",62);
  tsu_accent.circumflex;
  tsu_render;
endtsuglyph;

% underscore
begintsuglyph("uniFF3F",63);
  punct.underscore;
  tsu_render;
endtsuglyph;

% grave accent
begintsuglyph("uniFF40",64);
  tsu_accent.grave;
  tsu_render;
endtsuglyph;

tsu_accent.low_default_anchors;

% a
begintsuglyph("uniFF41",65);
  latin.lowa;
  tsu_render;
endtsuglyph;

% b
begintsuglyph("uniFF42",66);
  latin.lowb;
  tsu_render;
endtsuglyph;

% c
begintsuglyph("uniFF43",67);
  latin.lowc;
  tsu_render;
endtsuglyph;

% d
begintsuglyph("uniFF44",68);
  latin.lowd;
  tsu_render;
endtsuglyph;

% e
begintsuglyph("uniFF45",69);
  latin.lowe;
  tsu_render;
endtsuglyph;

% f
begintsuglyph("uniFF46",70);
  latin.lowf;
  tsu_render;
endtsuglyph;

% g
begintsuglyph("uniFF47",71);
  latin.lowg;
  tsu_render;
endtsuglyph;

% h
begintsuglyph("uniFF48",72);
  latin.lowh;
  tsu_render;
endtsuglyph;

% i
begintsuglyph("uniFF49",73);
  latin.lowi;
  tsu_render;
endtsuglyph;

% j
begintsuglyph("uniFF4A",74);
  latin.lowj;
  tsu_render;
endtsuglyph;

% k
begintsuglyph("uniFF4B",75);
  latin.lowk;
  tsu_render;
endtsuglyph;

% l
begintsuglyph("uniFF4C",76);
  latin.lowl;
  tsu_render;
endtsuglyph;

% m
begintsuglyph("uniFF4D",77);
  latin.lowm;
  tsu_render;
endtsuglyph;

% n
begintsuglyph("uniFF4E",78);
  latin.lown;
  tsu_render;
endtsuglyph;

% o
begintsuglyph("uniFF4F",79);
  latin.lowo;
  tsu_render;
endtsuglyph;

% p
begintsuglyph("uniFF50",80);
  latin.lowp;
  tsu_render;
endtsuglyph;

% q
begintsuglyph("uniFF51",81);
  latin.lowq;
  tsu_render;
endtsuglyph;

% r
begintsuglyph("uniFF52",82);
  latin.lowr;
  tsu_render;
endtsuglyph;

% s
begintsuglyph("uniFF53",83);
  latin.lows;
  tsu_render;
endtsuglyph;

% t
begintsuglyph("uniFF54",84);
  latin.lowt;
  tsu_render;
endtsuglyph;

% u
begintsuglyph("uniFF55",85);
  latin.lowu;
  tsu_render;
endtsuglyph;

% v
begintsuglyph("uniFF56",86);
  latin.lowv;
  tsu_render;
endtsuglyph;

% w
begintsuglyph("uniFF57",87);
  latin.loww;
  tsu_render;
endtsuglyph;

% x
begintsuglyph("uniFF58",88);
  latin.lowx;
  tsu_render;
endtsuglyph;

% y
begintsuglyph("uniFF59",89);
  latin.lowy;
  tsu_render;
endtsuglyph;

% z
begintsuglyph("uniFF5A",90);
  latin.lowz;
  tsu_render;
endtsuglyph;

tsu_accent.clear_default_anchors;

% left and right square brackets, around vertical line
begintsuglyph("uniFF5B",91);
  punct.brace_left;
  tsu_render;
endtsuglyph;
begintsuglyph("uniFF5C",92);
  punct.vline;
  tsu_render;
endtsuglyph;
begintsuglyph("uniFF5D",93);
  punct.brace_right;
  tsu_render;
endtsuglyph;

% "fullwidth tilde" - identical to "wave dash"
begintsuglyph("uniFF5E",94);
   punct.wavedash;
   tsu_render;
endtsuglyph;

begingroup
save rescale_slant;
rescale_slant:=0;

% left and right white parentheses
begintsuglyph("uniFF5F",95);
  punct.wparen_left;
  tsu_render;
endtsuglyph;
begintsuglyph("uniFF60",96);
  punct.wparen_right;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HALF-WIDTH PUNCTUATION

% WARNING changing rescale setting
tsu_rescale_half;

% ideographic full stop
begintsuglyph("uniFF61",97);
   punct.full_stop;
   tsu_render;
endtsuglyph;

% left and right corner brackets
begintsuglyph("uniFF62",98);
  punct.corner_left;
  tsu_render;
endtsuglyph;
begintsuglyph("uniFF63",99);
  punct.corner_right;
  tsu_render;
endtsuglyph;

% ideographic comma
begintsuglyph("uniFF64",100);
   punct.hancomma;
   tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HALF-WIDTH KATAKANA

% WARNING changing rescale setting
tsu_rescale_half_katakana;

% katakana middle dot
begintsuglyph("uniFF65",101);
  Fill fullcircle scaled (200*tsu_brush_max.brpunct)
    shifted (250,ypart centre_pt);   
endtsuglyph;

% katakana "wo"
begintsuglyph("uniFF66",102);
  kata.wo;
  tsu_render;
endtsuglyph;

% katakana "small a"
begintsuglyph("uniFF67",103);
  tsu_xform(tsu_xf.smallkana)(kata.a);
  tsu_render;
endtsuglyph;

% katakana "small i"
begintsuglyph("uniFF68",104);
  tsu_xform(tsu_xf.smallkana)(kata.i);
  tsu_render;
endtsuglyph;

% katakana "small u"
begintsuglyph("uniFF69",105);
  tsu_xform(tsu_xf.smallkana)(kata.u);
  tsu_render;
endtsuglyph;

% katakana "small e"
begintsuglyph("uniFF6A",106);
  tsu_xform(tsu_xf.smallkana)(kata.e);
  tsu_render;
endtsuglyph;

% katakana "small o"
begintsuglyph("uniFF6B",107);
  tsu_xform(tsu_xf.smallkana)(kata.o);
  tsu_render;
endtsuglyph;

% katakana "small ya"
begintsuglyph("uniFF6C",108);
  tsu_xform(tsu_xf.smallkana)(kata.ya);
  tsu_render;
endtsuglyph;

% katakana "small yu"
begintsuglyph("uniFF6D",109);
  tsu_xform(tsu_xf.smallkana)(kata.yu);
  tsu_render;
endtsuglyph;

% katakana "small yo"
begintsuglyph("uniFF6E",110);
  tsu_xform(tsu_xf.smallkana)(kata.yo);
  tsu_render;
endtsuglyph;

% katakana "small tsu"
begintsuglyph("uniFF6F",111);
  tsu_xform(tsu_xf.smallkana)(kata.tsu);
  tsu_render;
endtsuglyph;

% hira/kata "prolonged sound mark"
begintsuglyph("uniFF70",112);
  tsu_xform(tsu_xf.smallkana)(punct.psound);
  tsu_render;
endtsuglyph;

% katakana "a"
begintsuglyph("uniFF71",113);
  kata.a;
  tsu_render;
endtsuglyph;

% katakana "i"
begintsuglyph("uniFF72",114);
  kata.i;
  tsu_render;
endtsuglyph;

% katakana "u"
begintsuglyph("uniFF73",115);
  kata.u;
  tsu_render;
endtsuglyph;

% katakana "e"
begintsuglyph("uniFF74",116);
  kata.e;
  tsu_render;
endtsuglyph;

% katakana "o"
begintsuglyph("uniFF75",117);
  kata.o;
  tsu_render;
endtsuglyph;

% katakana "ka"
begintsuglyph("uniFF76",118);
  kata.ka;
  tsu_render;
endtsuglyph;

% katakana "ki"
begintsuglyph("uniFF77",119);
  kata.ki;
  tsu_render;
endtsuglyph;

% katakana "ku"
begintsuglyph("uniFF78",120);
  kata.ku;
  tsu_render;
endtsuglyph;

% katakana "ke"
begintsuglyph("uniFF79",121);
  kata.ke;
  tsu_render;
endtsuglyph;

% katakana "ko"
begintsuglyph("uniFF7A",122);
  kata.ko;
  tsu_render;
endtsuglyph;

% katakana "sa"
begintsuglyph("uniFF7B",123);
  kata.sa;
  tsu_render;
endtsuglyph;

% katakana "shi"
begintsuglyph("uniFF7C",124);
  kata.shi;
  tsu_render;
endtsuglyph;

% katakana "su"
begintsuglyph("uniFF7D",125);
  kata.su;
  tsu_render;
endtsuglyph;

% katakana "se"
begintsuglyph("uniFF7E",126);
  kata.se;
  tsu_render;
endtsuglyph;

% katakana "so"
begintsuglyph("uniFF7F",127);
  kata.so;
  tsu_render;
endtsuglyph;

% katakana "ta"
begintsuglyph("uniFF80",128);
  kata.ta;
  tsu_render;
endtsuglyph;

% katakana "chi"
begintsuglyph("uniFF81",129);
  kata.chi;
  tsu_render;
endtsuglyph;

% katakana "tsu"
begintsuglyph("uniFF82",130);
  kata.tsu;
  tsu_render;
endtsuglyph;

% katakana "te"
begintsuglyph("uniFF83",131);
  kata.te;
  tsu_render;
endtsuglyph;

% katakana "to"
begintsuglyph("uniFF84",132);
  kata.toh;
  tsu_render;
endtsuglyph;

% katakana "na"
begintsuglyph("uniFF85",133);
  kata.na;
  tsu_render;
endtsuglyph;

% katakana "ni"
begintsuglyph("uniFF86",134);
  kata.ni;
  tsu_render;
endtsuglyph;

% katakana "nu"
begintsuglyph("uniFF87",135);
  kata.nu;
  tsu_render;
endtsuglyph;

% katakana "ne"
begintsuglyph("uniFF88",136);
  kata.ne;
  tsu_render;
endtsuglyph;

% katakana "no"
begintsuglyph("uniFF89",137);
  kata.no;
  tsu_render;
endtsuglyph;

% katakana "ha"
begintsuglyph("uniFF8A",138);
  kata.ha;
  tsu_render;
endtsuglyph;

% katakana "hi"
begintsuglyph("uniFF8B",139);
  kata.hi;
  tsu_render;
endtsuglyph;

% katakana "fu"
begintsuglyph("uniFF8C",140);
  kata.fu;
  tsu_render;
endtsuglyph;

% katakana "he"
begintsuglyph("uniFF8D",141);
  kata.he;
  tsu_render;
endtsuglyph;

% katakana "ho"
begintsuglyph("uniFF8E",142);
  kata.ho;
  tsu_render;
endtsuglyph;

% katakana "ma"
begintsuglyph("uniFF8F",143);
  kata.ma;
  tsu_render;
endtsuglyph;

% katakana "mi"
begintsuglyph("uniFF90",144);
  kata.mi;
  tsu_render;
endtsuglyph;

% katakana "mu"
begintsuglyph("uniFF91",145);
  kata.mu;
  tsu_render;
endtsuglyph;

% katakana "me"
begintsuglyph("uniFF92",146);
  kata.me;
  tsu_render;
endtsuglyph;

% katakana "mo"
begintsuglyph("uniFF93",147);
  kata.mo;
  tsu_render;
endtsuglyph;

% katakana "ya"
begintsuglyph("uniFF94",148);
  kata.ya;
  tsu_render;
endtsuglyph;

% katakana "yu"
begintsuglyph("uniFF95",149);
  kata.yu;
  tsu_render;
endtsuglyph;

% katakana "yo"
begintsuglyph("uniFF96",150);
  kata.yo;
  tsu_render;
endtsuglyph;

% katakana "ra"
begintsuglyph("uniFF97",151);
  kata.ra;
  tsu_render;
endtsuglyph;

% katakana "ri"
begintsuglyph("uniFF98",152);
  kata.ri;
  tsu_render;
endtsuglyph;

% katakana "ru"
begintsuglyph("uniFF99",153);
  kata.ru;
  tsu_render;
endtsuglyph;

% katakana "re"
begintsuglyph("uniFF9A",154);
  kata.re;
  tsu_render;
endtsuglyph;

% katakana "ro"
begintsuglyph("uniFF9B",155);
  kata.ro;
  tsu_render;
endtsuglyph;

% katakana "wa"
begintsuglyph("uniFF9C",156);
  kata.wa;
  tsu_render;
endtsuglyph;

% katakana "n"
begintsuglyph("uniFF9D",157);
  kata.n;
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_native_zero;

% combining dakuten
begintsuglyph("uniFF9E",158);
   dakuten(identity
     scaled 0.8 rotated 25 shifted (-130,780) xscaled 0.7);
   tsu_render;
endtsuglyph;

% combining handakuten
begintsuglyph("uniFF9F",159);
   Fill fullcircle scaled (handakuten_outer*0.75) shifted (-90,780);
   unFill reverse fullcircle scaled (handakuten_inner*0.75) shifted (-90,780);
endtsuglyph;

endgroup;

% WARNING changing rescale setting
tsu_rescale_full;

begintsuglyph("uniFFE0",224);
  tsu_accent.apply(latin.lowc)(tsu_accent.slash);
  tsu_render;
endtsuglyph;

begintsuglyph("uniFFE1",225);
  punct.pound;
  tsu_render;
endtsuglyph;

begintsuglyph("uniFFE2",226);
  punct.notsign
    (identity scaled (1.5*tsu_punct_size) shifted centre_pt);
  tsu_render;
endtsuglyph;

begintsuglyph("uniFFE3",227);
  tsu_accent.macron;
  tsu_render;
endtsuglyph;

begintsuglyph("uniFFE4",228);
  punct.bvline;
  tsu_render;
endtsuglyph;

begintsuglyph("uniFFE5",229);
  latin.upy;
  push_stroke(((-240,0)--(240,0)) shifted point 1 of get_strokep(-1),
    (2,2)--(2,2));
  set_bosize(0,80);
  push_stroke(((-240,0)--(240,0)) shifted point 1.333 of get_strokep(-2),
    (2,2)--(2,2));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

begintsuglyph("uniFFE6",230);
  push_stroke((40,400)--(960,400),(2,2)--(2,2));
  set_bosize(0,80);
  latin.upw;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
