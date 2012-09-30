%
% Unicode page 01 (Latin Extended A) for Tsukurimashou
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
input ogonek.mp;
input punct.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LATIN EXTENDED A

tsu_rescale_half;

% A with macron
begintsuglyph("Amacron",0);
  tsu_accent.apply(tsu_accent.capital(latin.upa))(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% a with macron
begintsuglyph("amacron",1);
  tsu_accent.apply(latin.lowa)(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% A with breve
begintsuglyph("Abreve",2);
  tsu_accent.apply(tsu_accent.capital(latin.upa))(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% a with breve
begintsuglyph("abreve",3);
  tsu_accent.apply(latin.lowa)(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% A with ogonek
begintsuglyph("Aogonek",4);
  latin.upaogonek;
  tsu_render;
endtsuglyph;

% a with ogonek
begintsuglyph("aogonek",5);
  latin.lowaogonek;
  tsu_render;
endtsuglyph;

% C with acute
begintsuglyph("Cacute",6);
  tsu_accent.apply(tsu_accent.capital(latin.upc))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% c with acute
begintsuglyph("cacute",7);
  tsu_accent.apply(latin.lowc)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% C with circumflex
begintsuglyph("Ccircumflex",8);
  tsu_accent.apply(tsu_accent.capital(latin.upc))(tsu_accent.circumflex);
  replace_strokep(0)(oldp shifted (35,0));
  tsu_render;
endtsuglyph;

% c with circumflex
begintsuglyph("ccircumflex",9);
  tsu_accent.apply(latin.lowc)(tsu_accent.circumflex);
  replace_strokep(0)(oldp shifted (35,0));
  tsu_render;
endtsuglyph;

% C with dot above
begintsuglyph("Cdotaccent",10);
  tsu_accent.apply(tsu_accent.capital(latin.upc))(tsu_accent.dotabove);
  replace_lcblob(0)(oldblob shifted (35,0));
  tsu_render;
endtsuglyph;

% c with dot above
begintsuglyph("cdotaccent",11);
  tsu_accent.apply(latin.lowc)(tsu_accent.dotabove);
  replace_lcblob(0)(oldblob shifted (35,0));
  tsu_render;
endtsuglyph;

% C with caron
begintsuglyph("Ccaron",12);
  tsu_accent.apply(tsu_accent.capital(latin.upc))(tsu_accent.caron);
  replace_strokep(0)(oldp shifted (35,0));
  tsu_render;
endtsuglyph;

% c with caron
begintsuglyph("ccaron",13);
  tsu_accent.apply(latin.lowc)(tsu_accent.caron);
  replace_strokep(0)(oldp shifted (35,0));
  tsu_render;
endtsuglyph;

% D with caron
begintsuglyph("Dcaron",14);
  tsu_accent.apply(tsu_accent.capital(latin.upd))(tsu_accent.caron);
  replace_strokep(0)(oldp shifted (-40,0));
  tsu_render;
endtsuglyph;

% d with caron apostrophe
begintsuglyph("dcaron",15);
  tsu_accent.apply(latin.lowd)(tsu_accent.caron_comma);
  tsu_render;
endtsuglyph;

% D with stroke - same as capital Eth
begintsuglyph("Dcroat",16);
  latin.upeth;
  tsu_render;
endtsuglyph;

% d with bar
begintsuglyph("dcroat",17);
  latin.lowd;
  push_stroke((530,vmetric(0.82))--(820,vmetric(0.82)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

% E with macron
begintsuglyph("Emacron",18);
  tsu_accent.apply(tsu_accent.capital(latin.upe))(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% e with macron
begintsuglyph("emacron",19);
  tsu_accent.apply(latin.lowe)(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% E with breve
begintsuglyph("Ebreve",20);
  tsu_accent.apply(tsu_accent.capital(latin.upe))(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% e with breve
begintsuglyph("ebreve",21);
  tsu_accent.apply(latin.lowe)(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% E with dot
begintsuglyph("Edotaccent",22);
  tsu_accent.apply(tsu_accent.capital(latin.upe))(tsu_accent.dotabove);
  tsu_render;
endtsuglyph;

% e with dot
begintsuglyph("edotaccent",23);
  tsu_accent.apply(latin.lowe)(tsu_accent.dotabove);
  tsu_render;
endtsuglyph;

% E with ogonek
begintsuglyph("Eogonek",24);
  latin.upeogonek;
  tsu_render;
endtsuglyph;

% e with ogonek
begintsuglyph("eogonek",25);
  latin.loweogonek;
  tsu_render;
endtsuglyph;

% E with caron
begintsuglyph("Ecaron",26);
  tsu_accent.apply(tsu_accent.capital(latin.upe))(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% e with caron
begintsuglyph("ecaron",27);
  tsu_accent.apply(latin.lowe)(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% G with circumflex
begintsuglyph("Gcircumflex",28);
  tsu_accent.apply(tsu_accent.capital(latin.upg))(tsu_accent.circumflex);
  replace_strokep(0)(oldp shifted (35,0));
  tsu_render;
endtsuglyph;

% g with circumflex
begintsuglyph("gcircumflex",29);
  tsu_accent.apply(latin.lowg)(tsu_accent.circumflex);
  replace_strokep(0)(oldp shifted (10,0));
  tsu_render;
endtsuglyph;

% G with breve
begintsuglyph("Gbreve",30);
  tsu_accent.apply(tsu_accent.capital(latin.upg))(tsu_accent.breve);
  replace_strokep(0)(oldp shifted (35,0));
  tsu_render;
endtsuglyph;

% g with breve
begintsuglyph("gbreve",31);
  tsu_accent.apply(latin.lowg)(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% G with dot
begintsuglyph("Gdotaccent",32);
  tsu_accent.apply(tsu_accent.capital(latin.upg))(tsu_accent.dotabove);
  replace_lcblob(0)(oldblob shifted (35,0));
  tsu_render;
endtsuglyph;

% g with dot
begintsuglyph("gdotaccent",33);
  tsu_accent.apply(latin.lowg)(tsu_accent.dotabove);
  replace_lcblob(0)(oldblob shifted (35,0));
  tsu_render;
endtsuglyph;

% G with comma below
begintsuglyph("uni0122",34);
  tsu_accent.apply(latin.upg)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% g with comma upside-down above
begintsuglyph("uni0123",35);
  tsu_accent.apply(latin.lowg)(tsu_accent.caron_comma);
  tsu_render;
endtsuglyph;

% H with circumflex
begintsuglyph("Hcircumflex",36);
  tsu_accent.apply(tsu_accent.capital(latin.uph))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% h with circumflex
begintsuglyph("hcircumflex",37);
  tsu_accent.apply(tsu_accent.capital(latin.lowh))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% H with bar
begintsuglyph("Hbar",38);
  latin.uph;
  push_stroke((100,vmetric(0.74))--(900,vmetric(0.74)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

% h with bar
begintsuglyph("hbar",39);
  latin.lowh;
  push_stroke((220,vmetric(0.82))--(520,vmetric(0.82)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

% I with tilde
begintsuglyph("Itilde",40);
  tsu_accent.apply(tsu_accent.capital(latin.upi))(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% i with tilde
begintsuglyph("itilde",41);
  tsu_accent.apply(
    tsu_xform(identity shifted (70,0))(latin.lowi);
    pop_lcblob;
  )(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% I with macron
begintsuglyph("Imacron",42);
  tsu_accent.apply(tsu_accent.capital(latin.upi))(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% i with macron
begintsuglyph("imacron",43);
  tsu_accent.apply(
    tsu_xform(identity shifted (70,0))(latin.lowi);
    pop_lcblob;
  )(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% I with breve
begintsuglyph("Ibreve",44);
  tsu_accent.apply(tsu_accent.capital(latin.upi))(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% i with breve
begintsuglyph("ibreve",45);
  tsu_accent.apply(
    tsu_xform(identity shifted (70,0))(latin.lowi);
    pop_lcblob;
  )(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% I with ogonek
begintsuglyph("Iogonek",46);
  latin.upiogonek;
  tsu_render;
endtsuglyph;

% i with ogonek
begintsuglyph("iogonek",47);
  latin.lowiogonek;
  tsu_render;
endtsuglyph;

% I with dot
begintsuglyph("Idotaccent",48);
  tsu_accent.apply(tsu_accent.capital(latin.upi))(tsu_accent.dotabove);
  tsu_render;
endtsuglyph;

% i without dot
begintsuglyph("dotlessi",49);
  tsu_xform(identity shifted (70,0))(latin.lowi);
  pop_lcblob;
  tsu_render;
endtsuglyph;

% Dutch IJ ligature
begintsuglyph("IJ",50);
  latin.upij;
  tsu_render;
endtsuglyph;

% Dutch ij ligature
begintsuglyph("ij",51);
  latin.lowij;
  tsu_render;
endtsuglyph;

% J with circumflex
begintsuglyph("Jcircumflex",52);
  tsu_accent.apply(tsu_accent.capital(latin.upj))(tsu_accent.circumflex);
  replace_strokep(0)(oldp shifted (50,0));
  tsu_render;
endtsuglyph;

% j with circumflex
begintsuglyph("jcircumflex",53);
  tsu_accent.apply(
    tsu_xform(identity shifted (70,0))(latin.lowj);
    pop_lcblob;
  )(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% K with comma below
begintsuglyph("uni0136",54);
  tsu_accent.apply(latin.upk)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% k with comma below
begintsuglyph("uni0137",55);
  tsu_accent.apply(latin.lowk)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% Greenlandic k, which I'm interpreting as a squashed K
begintsuglyph("kgreenlandic",56);
  tsu_xform(identity shifted (-500,-latin_wide_low_v) xyscaled (0.92,0.63)
    shifted (500,latin_wide_low_v))(latin.upk);
  tsu_render;
endtsuglyph;

% L with acute
begintsuglyph("Lacute",57);
  tsu_accent.apply(tsu_accent.capital(latin.upl))(tsu_accent.acute);
  replace_strokep(0)(oldp shifted (-190,0));
  tsu_render;
endtsuglyph;

% l with acute
begintsuglyph("lacute",58);
  tsu_accent.apply(tsu_accent.capital(latin.lowl))(tsu_accent.acute);
  replace_strokep(0)(oldp shifted (-20,0));
  tsu_render;
endtsuglyph;

% L with comma below
begintsuglyph("uni013B",59);
  tsu_accent.apply(latin.upl)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% l with comma below
begintsuglyph("uni013C",60);
  tsu_accent.apply(latin.lowl)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% L with apostrophe caron
begintsuglyph("Lcaron",61);
  tsu_accent.apply(latin.upl)(tsu_accent.caron_comma);
  tsu_render;
endtsuglyph;

% l with apostrophe caron
begintsuglyph("lcaron",62);
  tsu_accent.apply(latin.lowl)(tsu_accent.caron_comma);
  tsu_render;
endtsuglyph;

% L with dot
begintsuglyph("Ldot",63);
  tsu_accent.apply(latin.upl)(tsu_accent.dotabove);
  replace_lcblob(0)(oldblob
    shifted ((xpart 0.8[llcorner get_strokep(0),lrcorner get_strokep(0)],vmetric(0.5))-
             0.5[llcorner oldblob,urcorner oldblob]));
  tsu_render;
endtsuglyph;

% l with dot
begintsuglyph("ldot",64);
  tsu_accent.apply(tsu_xform(identity shifted (-120,0))
    (latin.lowl))(tsu_accent.dotabove);
  replace_lcblob(0)(oldblob
    shifted ((220+xpart llcorner get_strokep(0),vmetric(0.5))-
             0.5[llcorner oldblob,urcorner oldblob]));
  tsu_render;
endtsuglyph;

% L with slash
begintsuglyph("Lslash",65);
  latin.upl;
  push_stroke((160,vmetric(0.40))--(460,vmetric(0.60)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

% l with slash
begintsuglyph("lslash",66);
  latin.lowl;
  push_stroke((350,vmetric(0.40))--(650,vmetric(0.60)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

% N with acute
begintsuglyph("Nacute",67);
  tsu_accent.apply(tsu_accent.capital(latin.upn))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% n with acute
begintsuglyph("nacute",68);
  tsu_accent.apply(latin.lown)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% N with comma below
begintsuglyph("uni0145",69);
  tsu_accent.apply(latin.upn)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% n with comma below
begintsuglyph("uni0146",70);
  tsu_accent.apply(latin.lown)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% N with caron
begintsuglyph("Ncaron",71);
  tsu_accent.apply(tsu_accent.capital(latin.upn))(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% n with caron
begintsuglyph("ncaron",72);
  tsu_accent.apply(latin.lown)(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% n with apostrophe before
begintsuglyph("napostrophe",73);
  tsu_xform(identity shifted (30,0))(latin.lown);
  punct.make_comma((230,vmetric(0.94)),0);
  tsu_render;
endtsuglyph;

% uppercase Eng
begintsuglyph("Eng",74);
  latin.upeng;
  tsu_render;
endtsuglyph;

% lowercase eng
begintsuglyph("eng",75);
  latin.loweng;
  tsu_render;
endtsuglyph;

% O with macron
begintsuglyph("Omacron",76);
  tsu_accent.apply(tsu_accent.capital(latin.upo))(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% o with macron
begintsuglyph("omacron",77);
  tsu_accent.apply(latin.lowo)(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% O with breve
begintsuglyph("Obreve",78);
  tsu_accent.apply(tsu_accent.capital(latin.upo))(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% o with breve
begintsuglyph("obreve",79);
  tsu_accent.apply(latin.lowo)(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% O with Hunarian umlaut
begintsuglyph("Ohungarumlaut",80);
  tsu_accent.apply(tsu_accent.capital(latin.upo))(tsu_accent.hungarian_umlaut);
  tsu_render;
endtsuglyph;

% o with hungarian umlaut
begintsuglyph("ohungarumlaut",81);
  tsu_accent.apply(latin.lowo)(tsu_accent.hungarian_umlaut);
  tsu_render;
endtsuglyph;

% OE ligature
begintsuglyph("OE",82);
  latin.upoe;
  tsu_render;
endtsuglyph;

% oe ligature
begintsuglyph("oe",83);
  latin.lowoe;
  tsu_render;
endtsuglyph;

% R with acute
begintsuglyph("Racute",84);
  tsu_accent.apply(tsu_accent.capital(latin.upr))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% r with acute
begintsuglyph("racute",85);
  tsu_accent.apply(latin.lowr)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% R with comma below
begintsuglyph("uni0156",86);
  tsu_accent.apply(latin.upr)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% r with comma below
begintsuglyph("uni0157",87);
  tsu_accent.apply(latin.lowr)(tsu_accent.commabelow);
  tsu_render;
endtsuglyph;

% R with caron
begintsuglyph("Rcaron",88);
  tsu_accent.apply(tsu_accent.capital(latin.upr))(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% r with caron
begintsuglyph("rcaron",89);
  tsu_accent.apply(latin.lowr)(tsu_accent.caron);
  replace_strokep(0)(oldp shifted (80,0));
  tsu_render;
endtsuglyph;

% S with acute
begintsuglyph("Sacute",90);
  tsu_accent.apply(tsu_accent.capital(latin.ups))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% s with acute
begintsuglyph("sacute",91);
  tsu_accent.apply(latin.lows)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% S with circumflex
begintsuglyph("Scircumflex",92);
  tsu_accent.apply(tsu_accent.capital(latin.ups))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% s with circumflex
begintsuglyph("scircumflex",93);
  tsu_accent.apply(latin.lows)(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% S with cedilla
begintsuglyph("Scedilla",94);
  tsu_accent.apply(latin.ups)(tsu_accent.cedilla);
  tsu_render;
endtsuglyph;

% s with cedilla
begintsuglyph("scedilla",95);
  tsu_accent.apply(latin.lows)(tsu_accent.cedilla);
  tsu_render;
endtsuglyph;

% S with caron
begintsuglyph("Scaron",96);
  tsu_accent.apply(tsu_accent.capital(latin.ups))(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% s with caron
begintsuglyph("scaron",97);
  tsu_accent.apply(latin.lows)(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% T with cedilla [sic]
begintsuglyph("uni0162",98);
  tsu_accent.apply(latin.upt)(tsu_accent.cedilla);
  tsu_render;
endtsuglyph;

% t with cedilla [sic]
begintsuglyph("uni0163",99);
  tsu_accent.apply(latin.lowt)(tsu_accent.cedilla);
  replace_strokep(0)(oldp shifted (20,0));
  tsu_render;
endtsuglyph;

% T with caron
begintsuglyph("Tcaron",100);
  tsu_accent.apply(tsu_accent.capital(latin.upt))(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% t with apostrophe caron
begintsuglyph("tcaron",101);
  tsu_accent.apply(latin.lowt)(tsu_accent.caron_comma);
  tsu_render;
endtsuglyph;

% T with bar
begintsuglyph("Tbar",102);
  latin.upt;
  push_stroke((300,vmetric(0.5))--(700,vmetric(0.5)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

% t with bar
begintsuglyph("tbar",103);
  latin.lowt;
  push_stroke((320,vmetric(0.35))--(620,vmetric(0.35)),
    (1.6,1.6)--(1.6,1.6));
  set_bosize(0,80);
  tsu_render;
endtsuglyph;

% U with tilde
begintsuglyph("Utilde",104);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.tilde);
  tsu_render;
endtsuglyph;

% u with tilde
begintsuglyph("utilde",105);
  tsu_accent.apply(latin.lowu)(tsu_accent.tilde);
  replace_strokep(0)(oldp shifted (-20,0));
  tsu_render;
endtsuglyph;

% U with macron
begintsuglyph("Umacron",106);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.macron);
  tsu_render;
endtsuglyph;

% u with macron
begintsuglyph("umacron",107);
  tsu_accent.apply(latin.lowu)(tsu_accent.macron);
  replace_strokep(0)(oldp shifted (-40,0));
  tsu_render;
endtsuglyph;

% U with breve
begintsuglyph("Ubreve",108);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.breve);
  tsu_render;
endtsuglyph;

% u with breve
begintsuglyph("ubreve",109);
  tsu_accent.apply(latin.lowu)(tsu_accent.breve);
  replace_strokep(0)(oldp shifted (-20,0));
  tsu_render;
endtsuglyph;

% U with ring above
begintsuglyph("Uring",110);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.ringabove);
  tsu_render;
endtsuglyph;

% u with ring above
begintsuglyph("uring",111);
  tsu_accent.apply(latin.lowu)(tsu_accent.ringabove);
  if find_whatever(otlcblob,-1)>0:
    replace_lcblob(-1)(oldblob shifted (-50,-40));
  fi;
  replace_lcblob(0)(oldblob shifted (-50,-40));
  tsu_render;
endtsuglyph;

% U with Hungarian umlaut
begintsuglyph("Uhungarumlaut",112);
  tsu_accent.apply(tsu_accent.capital(latin.upu))(tsu_accent.hungarian_umlaut);
  tsu_render;
endtsuglyph;

% u with Hungarian umlaut
begintsuglyph("uhungarumlaut",113);
  tsu_accent.apply(latin.lowu)(tsu_accent.hungarian_umlaut);
  tsu_render;
endtsuglyph;

% U with ogonek
begintsuglyph("Uogonek",114);
  latin.upuogonek;
  tsu_render;
endtsuglyph;

% u with ogonek
begintsuglyph("uogonek",115);
  latin.lowuogonek;
  tsu_render;
endtsuglyph;

% W with circumflex
begintsuglyph("Wcircumflex",116);
  tsu_accent.apply(tsu_accent.capital(latin.upw))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% w with circumflex
begintsuglyph("wcircumflex",117);
  tsu_accent.apply(latin.loww)(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% Y with circumflex
begintsuglyph("Ycircumflex",118);
  tsu_accent.apply(tsu_accent.capital(latin.upy))(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% y with circumflex
begintsuglyph("ycircumflex",119);
  tsu_accent.apply(latin.lowy)(tsu_accent.circumflex);
  tsu_render;
endtsuglyph;

% Y with umlaut/dieresis
begintsuglyph("Ydieresis",120);
  tsu_accent.apply(tsu_accent.capital(latin.upy))(tsu_accent.umlaut);
  tsu_render;
endtsuglyph;

% Z with acute
begintsuglyph("Zacute",121);
  tsu_accent.apply(tsu_accent.capital(latin.upz))(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% z with acute
begintsuglyph("zacute",122);
  tsu_accent.apply(latin.lowz)(tsu_accent.acute);
  tsu_render;
endtsuglyph;

% Z with dot
begintsuglyph("Zdotaccent",123);
  tsu_accent.apply(tsu_accent.capital(latin.upz))(tsu_accent.dotabove);
  tsu_render;
endtsuglyph;

% z with dot
begintsuglyph("zdotaccent",124);
  tsu_accent.apply(latin.lowz)(tsu_accent.dotabove);
  tsu_render;
endtsuglyph;

% Z with caron
begintsuglyph("Zcaron",125);
  tsu_accent.apply(tsu_accent.capital(latin.upz))(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% z with caron
begintsuglyph("zcaron",126);
  tsu_accent.apply(latin.lowz)(tsu_accent.caron);
  tsu_render;
endtsuglyph;

% long s
begintsuglyph("longs",127);
  latin.lowlongs;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
