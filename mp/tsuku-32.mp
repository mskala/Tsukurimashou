%
% Unicode page 32 (Enclosed Alpha and Katakana) for Tsukurimashou
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
input katakana.mp;
input numerals.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CIRCLED NUMERALS

% 21
begintsuglyph("uni3251",81);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.one);
  tsu_render;
endtsuglyph;

% 22
begintsuglyph("uni3252",82);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.two);
  tsu_render;
endtsuglyph;

% 23
begintsuglyph("uni3253",83);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.three);
  tsu_render;
endtsuglyph;

% 24
begintsuglyph("uni3254",84);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.four);
  tsu_render;
endtsuglyph;

% 25
begintsuglyph("uni3255",85);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.five);
  tsu_render;
endtsuglyph;

% 26
begintsuglyph("uni3256",86);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.six);
  tsu_render;
endtsuglyph;

% 27
begintsuglyph("uni3257",87);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.seven);
  tsu_render;
endtsuglyph;

% 28
begintsuglyph("uni3258",88);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.eight);
  tsu_render;
endtsuglyph;

% 29
begintsuglyph("uni3259",89);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.two);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.nine);
  tsu_render;
endtsuglyph;

% 30
begintsuglyph("uni325A",90);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.zero);
  tsu_render;
endtsuglyph;

% 31
begintsuglyph("uni325B",91);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.one);
  tsu_render;
endtsuglyph;

% 32
begintsuglyph("uni325C",92);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.two);
  tsu_render;
endtsuglyph;

% 33
begintsuglyph("uni325D",93);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.three);
  tsu_render;
endtsuglyph;

% 34
begintsuglyph("uni325E",94);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.four);
  tsu_render;
endtsuglyph;

% 35
begintsuglyph("uni325F",95);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.five);
  tsu_render;
endtsuglyph;

% WARNING discontiguous

% 36
begintsuglyph("uni32B1",177);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.six);
  tsu_render;
endtsuglyph;

% 37
begintsuglyph("uni32B2",178);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.seven);
  tsu_render;
endtsuglyph;

% 38
begintsuglyph("uni32B3",179);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.eight);
  tsu_render;
endtsuglyph;

% 39
begintsuglyph("uni32B4",180);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.three);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.nine);
  tsu_render;
endtsuglyph;

% 40
begintsuglyph("uni32B5",181);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.zero);
  tsu_render;
endtsuglyph;

% 41
begintsuglyph("uni32B6",182);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.one);
  tsu_render;
endtsuglyph;

% 42
begintsuglyph("uni32B7",183);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.two);
  tsu_render;
endtsuglyph;

% 43
begintsuglyph("uni32B8",184);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.three);
  tsu_render;
endtsuglyph;

% 44
begintsuglyph("uni32B9",185);
  circle.single;
  tsu_xform(tsu_xf.ctwo.right)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  tsu_render;
endtsuglyph;

% 45
begintsuglyph("uni32BA",186);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.five);
  tsu_render;
endtsuglyph;

% 46
begintsuglyph("uni32BB",187);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.six);
  tsu_render;
endtsuglyph;

% 47
begintsuglyph("uni32BC",188);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.seven);
  tsu_render;
endtsuglyph;

% 48
begintsuglyph("uni32BD",189);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.eight);
  tsu_render;
endtsuglyph;

% 49
begintsuglyph("uni32BE",190);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.four);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.nine);
  tsu_render;
endtsuglyph;

% 50
begintsuglyph("uni32BF",191);
  circle.single;
  tsu_xform(tsu_xf.ctwo.left)(numeral.five);
  numeric x[],y[];
  tsu_xform(tsu_xf.ctwo.right)(numeral.zero);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CIRCLED KATAKANA

% circled "a"
begintsuglyph("uni32D0",208);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.a);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "i"
begintsuglyph("uni32D1",209);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.i);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "u"
begintsuglyph("uni32D2",210);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.u);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "e"
begintsuglyph("uni32D3",211);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.e);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "o"
begintsuglyph("uni32D4",212);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.o);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ka"
begintsuglyph("uni32D5",213);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ka);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ki"
begintsuglyph("uni32D6",214);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ki);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ku"
begintsuglyph("uni32D7",215);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ku);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ke"
begintsuglyph("uni32D8",216);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ke);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ko"
begintsuglyph("uni32D9",217);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ko);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "sa"
begintsuglyph("uni32DA",218);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.sa);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "shi"
begintsuglyph("uni32DB",219);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.shi);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "su"
begintsuglyph("uni32DC",220);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.su);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "se"
begintsuglyph("uni32DD",221);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.se);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "so"
begintsuglyph("uni32DE",222);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.so);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ta"
begintsuglyph("uni32DF",223);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ta);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "chi"
begintsuglyph("uni32E0",224);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.chi);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "tsu"
begintsuglyph("uni32E1",225);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.tsu);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "te"
begintsuglyph("uni32E2",226);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.te);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "to"
begintsuglyph("uni32E3",227);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.toh);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "na"
begintsuglyph("uni32E4",228);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.na);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ni"
begintsuglyph("uni32E5",229);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ni);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "nu"
begintsuglyph("uni32E6",230);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.nu);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ne"
begintsuglyph("uni32E7",231);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ne);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "no"
begintsuglyph("uni32E8",232);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.no);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ha"
begintsuglyph("uni32E9",233);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ha);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "hi"
begintsuglyph("uni32EA",234);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.hi);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "fu"
begintsuglyph("uni32EB",235);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.fu);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "he"
begintsuglyph("uni32EC",236);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.he);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ho"
begintsuglyph("uni32ED",237);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ho);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ma"
begintsuglyph("uni32EE",238);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ma);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "mi"
begintsuglyph("uni32EF",239);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.mi);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "mu"
begintsuglyph("uni32F0",240);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.mu);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "me"
begintsuglyph("uni32F1",241);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.me);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "mo"
begintsuglyph("uni32F2",242);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.mo);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ya"
begintsuglyph("uni32F3",243);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ya);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "yu"
begintsuglyph("uni32F4",244);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.yu);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "yo"
begintsuglyph("uni32F5",245);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.yo);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ra"
begintsuglyph("uni32F6",246);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ra);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ri"
begintsuglyph("uni32F7",247);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ri);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ru"
begintsuglyph("uni32F8",248);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ru);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "re"
begintsuglyph("uni32F9",249);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.re);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "ro"
begintsuglyph("uni32FA",250);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.ro);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "wa"
begintsuglyph("uni32FB",251);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.wa);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "wi"
begintsuglyph("uni32FC",252);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.wi);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "we"
begintsuglyph("uni32FD",253);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.we);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

% circled "wo"
begintsuglyph("uni32FE",254);
  circle.single;
  tsu_xform(tsu_xf.circled)(kata.wo);
  tsu_render_in_circle(tsu_xf.cbound);
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
