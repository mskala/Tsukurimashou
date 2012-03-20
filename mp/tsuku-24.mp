%
% Unicode page 24 (Enclosed Numerics) for Tsukurimashou
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
input enclosed.mp;
input latin.mp;
input numerals.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CIRCLED NUMERALS

% 1
begintsuglyph("uni2460",96);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.one);
  tsu_render;
endtsuglyph;

% 2
begintsuglyph("uni2461",97);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.two);
  tsu_render;
endtsuglyph;

% 3
begintsuglyph("uni2462",98);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.three);
  tsu_render;
endtsuglyph;

% 4
begintsuglyph("uni2463",99);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.four);
  tsu_render;
endtsuglyph;

% 5
begintsuglyph("uni2464",100);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.five);
  tsu_render;
endtsuglyph;

% 6
begintsuglyph("uni2465",101);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.six);
  tsu_render;
endtsuglyph;

% 7
begintsuglyph("uni2466",102);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.seven);
  tsu_render;
endtsuglyph;

% 8
begintsuglyph("uni2467",103);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.eight);
  tsu_render;
endtsuglyph;

% 9
begintsuglyph("uni2468",104);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.nine);
  tsu_render;
endtsuglyph;

% 10
begintsuglyph("uni2469",105);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.zero);
  tsu_render;
endtsuglyph;

% 11
begintsuglyph("uni246A",106);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.one);
  tsu_render;
endtsuglyph;

% 12
begintsuglyph("uni246B",107);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.two);
  tsu_render;
endtsuglyph;

% 13
begintsuglyph("uni246C",108);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.three);
  tsu_render;
endtsuglyph;

% 14
begintsuglyph("uni246D",109);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.four);
  tsu_render;
endtsuglyph;

% 15
begintsuglyph("uni246E",110);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.five);
  tsu_render;
endtsuglyph;

% 16
begintsuglyph("uni246F",111);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.six);
  tsu_render;
endtsuglyph;

% 17
begintsuglyph("uni2470",112);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.seven);
  tsu_render;
endtsuglyph;

% 18
begintsuglyph("uni2471",113);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.eight);
  tsu_render;
endtsuglyph;

% 19
begintsuglyph("uni2472",114);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.nine);
  tsu_render;
endtsuglyph;

% 20
begintsuglyph("uni2473",115);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.zero);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CIRCLED LATIN AND ZERO

% A
begintsuglyph("uni24B6",182);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upa);
  tsu_render;
endtsuglyph;

% B
begintsuglyph("uni24B7",183);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upb);
  tsu_render;
endtsuglyph;

% C
begintsuglyph("uni24B8",184);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upc);
  tsu_render;
endtsuglyph;

% D
begintsuglyph("uni24B9",185);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upd);
  tsu_render;
endtsuglyph;

% E
begintsuglyph("uni24BA",186);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upe);
  tsu_render;
endtsuglyph;

% F
begintsuglyph("uni24BB",187);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upf);
  tsu_render;
endtsuglyph;

% G
begintsuglyph("uni24BC",188);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upg);
  tsu_render;
endtsuglyph;

% H
begintsuglyph("uni24BD",189);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.uph);
  tsu_render;
endtsuglyph;

% I
begintsuglyph("uni24BE",190);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upi);
  tsu_render;
endtsuglyph;

% J
begintsuglyph("uni24BF",191);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upj);
  tsu_render;
endtsuglyph;

% K
begintsuglyph("uni24C0",192);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upk);
  tsu_render;
endtsuglyph;

% L
begintsuglyph("uni24C1",193);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upl);
  tsu_render;
endtsuglyph;

% M
begintsuglyph("uni24C2",194);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upm);
  tsu_render;
endtsuglyph;

% N
begintsuglyph("uni24C3",195);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upn);
  tsu_render;
endtsuglyph;

% O
begintsuglyph("uni24C4",196);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upo);
  tsu_render;
endtsuglyph;

% P
begintsuglyph("uni24C5",197);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upp);
  tsu_render;
endtsuglyph;

% Q
begintsuglyph("uni24C6",198);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upq);
  tsu_render;
endtsuglyph;

% R
begintsuglyph("uni24C7",199);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upr);
  tsu_render;
endtsuglyph;

% S
begintsuglyph("uni24C8",200);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.ups);
  tsu_render;
endtsuglyph;

% T
begintsuglyph("uni24C9",201);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upt);
  tsu_render;
endtsuglyph;

% U
begintsuglyph("uni24CA",202);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upu);
  tsu_render;
endtsuglyph;

% V
begintsuglyph("uni24CB",203);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upv);
  tsu_render;
endtsuglyph;

% W
begintsuglyph("uni24CC",204);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upw);
  tsu_render;
endtsuglyph;

% X
begintsuglyph("uni24CD",205);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upx);
  tsu_render;
endtsuglyph;

% Y
begintsuglyph("uni24CE",206);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upy);
  tsu_render;
endtsuglyph;

% Z
begintsuglyph("uni24CF",207);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.upz);
  tsu_render;
endtsuglyph;

% a
begintsuglyph("uni24D0",208);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowa);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% b
begintsuglyph("uni24D1",209);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowb);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% c
begintsuglyph("uni24D2",210);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowc);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% d
begintsuglyph("uni24D3",211);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowd);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% e
begintsuglyph("uni24D4",212);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowe);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% f
begintsuglyph("uni24D5",213);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowf);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% g
begintsuglyph("uni24D6",214);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowg);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% h
begintsuglyph("uni24D7",215);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowh);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% i
begintsuglyph("uni24D8",216);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowi);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% j
begintsuglyph("uni24D9",217);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowj);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% k
begintsuglyph("uni24DA",218);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowk);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% l
begintsuglyph("uni24DB",219);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowl);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% m
begintsuglyph("uni24DC",220);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowm);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% n
begintsuglyph("uni24DD",221);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lown);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% o
begintsuglyph("uni24DE",222);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowo);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% p
begintsuglyph("uni24DF",223);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowp);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% q
begintsuglyph("uni24E0",224);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowq);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% r
begintsuglyph("uni24E1",225);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowr);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% s
begintsuglyph("uni24E2",226);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lows);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% t
begintsuglyph("uni24E3",227);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowt);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% u
begintsuglyph("uni24E4",228);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowu);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% v
begintsuglyph("uni24E5",229);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowv);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% w
begintsuglyph("uni24E6",230);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.loww);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% x
begintsuglyph("uni24E7",231);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowx);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% y
begintsuglyph("uni24E8",232);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowy);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% z
begintsuglyph("uni24E9",233);
  circle.single;
  tsu_xform(tsu_xf.cletter)(latin.lowz);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% 0
begintsuglyph("uni24EA",234);
  circle.single;
  tsu_xform(tsu_xf.circled)(numeral.zero);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INVERTED CIRCLED NUMERALS

% 11
% BACKGROUND 25CF
begintsuglyph("uni24EB",235);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.one);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 12
% BACKGROUND 25CF
begintsuglyph("uni24EC",236);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.two);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 13
% BACKGROUND 25CF
begintsuglyph("uni24ED",237);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.three);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 14
% BACKGROUND 25CF
begintsuglyph("uni24EE",238);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.four);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 15
% BACKGROUND 25CF
begintsuglyph("uni24EF",239);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.five);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 16
% BACKGROUND 25CF
begintsuglyph("uni24F0",240);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.six);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 17
% BACKGROUND 25CF
begintsuglyph("uni24F1",241);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.seven);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 18
% BACKGROUND 25CF
begintsuglyph("uni24F2",242);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.eight);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 19
% BACKGROUND 25CF
begintsuglyph("uni24F3",243);
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.nine);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% 20
% BACKGROUND 25CF
begintsuglyph("uni24F4",244);
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.zero);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DOUBLY CIRCLED NUMERALS

% 1
begintsuglyph("uni24F5",245);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.one);
  tsu_render;
endtsuglyph;

% 2
begintsuglyph("uni24F6",246);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.two);
  tsu_render;
endtsuglyph;

% 3
begintsuglyph("uni24F7",247);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.three);
  tsu_render;
endtsuglyph;

% 4
begintsuglyph("uni24F8",248);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.four);
  tsu_render;
endtsuglyph;

% 5
begintsuglyph("uni24F9",249);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.five);
  tsu_render;
endtsuglyph;

% 6
begintsuglyph("uni24FA",250);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.six);
  tsu_render;
endtsuglyph;

% 7
begintsuglyph("uni24FB",251);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.seven);
  tsu_render;
endtsuglyph;

% 8
begintsuglyph("uni24FC",252);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.eight);
  tsu_render;
endtsuglyph;

% 9
begintsuglyph("uni24FD",253);
  circle.double;
  tsu_xform(tsu_xf.circled)(numeral.nine);
  tsu_render;
endtsuglyph;

% 10
begintsuglyph("uni24FE",254);
  circle.double;
  tsu_xform(tsu_xf.ctwo.left)(numeral.one);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.zero);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ONE MORE INVERTED CIRCLED NUMERAL

% 9
% BACKGROUND 25CF
begintsuglyph("uni24FF",255);
  tsu_xform(tsu_xf.circled)(numeral.zero);
  i:=0; forever: exitif find_stroke(i)<1;
    set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
