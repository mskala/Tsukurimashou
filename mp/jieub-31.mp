%
% Unicode page 31 (Hangul Compatibility Jamo) for Jieubsida
% Copyright (C) 2011  Matthew Skala
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

% AUTODEPS
input hangul.mp;
input jamo-basic.mp;
input jamo-extra.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HANGUL COMPATIBILITY JAMO

% hangul kiyeok
begintsuglyph("uni3131",49);
  hangul.jamo.kiyeok(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ssangkiyeok
begintsuglyph("uni3132",50);
  hangul.combine.lr(100,100)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul kiyeok-sios
begintsuglyph("uni3133",51);
  hangul.combine.lr(100,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul nieun
begintsuglyph("uni3134",52);
  hangul.jamo.nieun(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul nieun-cieuc
begintsuglyph("uni3135",53);
  hangul.combine.lr(202,112)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul nieun-hieuh
begintsuglyph("uni3136",54);
  hangul.combine.lr(202,118)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul tikeut
begintsuglyph("uni3137",55);
  hangul.jamo.tikeut(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ssangtikeut
begintsuglyph("uni3138",56);
  hangul.combine.lr(203,103)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul
begintsuglyph("uni3139",57);
  hangul.jamo.rieul(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-kiyeok
begintsuglyph("uni313A",58);
  hangul.combine.lr(205,100)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-mieum
begintsuglyph("uni313B",59);
  hangul.combine.lr(105,106)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-pieup
begintsuglyph("uni313C",60);
  hangul.combine.lr(105,107)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-sios
begintsuglyph("uni313D",61);
  hangul.combine.lr(105,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-thieuth
begintsuglyph("uni313E",62);
  hangul.combine.lr(105,116)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-phieuph
begintsuglyph("uni313F",63);
  hangul.combine.lr(205,117)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-hieuh
begintsuglyph("uni3140",64);
  hangul.combine.lr(205,118)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul mieum
begintsuglyph("uni3141",65);
  hangul.jamo.mieum(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul pieup
begintsuglyph("uni3142",66);
  hangul.jamo.pieup(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ssangpieup
begintsuglyph("uni3143",67);
  hangul.combine.lr(207,107)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul pieup-sios
begintsuglyph("uni3144",68);
  hangul.combine.lr(107,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul sios
begintsuglyph("uni3145",69);
  hangul.jamo.sjc(0,0,false)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ssangsios
begintsuglyph("uni3146",70);
  hangul.combine.lr(209,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ieung
begintsuglyph("uni3147",71);
  hangul.jamo.ieung(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul cieuc
begintsuglyph("uni3148",72);
  hangul.jamo.sjc(1,0,false)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ssangcieuc
begintsuglyph("uni3149",73);
  hangul.combine.lr(212,112)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul chieuch
begintsuglyph("uni314A",74);
  hangul.jamo.sjc(2,0,false)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul khieukh
begintsuglyph("uni314B",75);
  hangul.jamo.khieukh(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul thieuth
begintsuglyph("uni314C",76);
  hangul.jamo.thieuth(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul phieuph
begintsuglyph("uni314D",77);
  hangul.jamo.phieuph(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul hieuh
begintsuglyph("uni314E",78);
  hangul.jamo.hieuh(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul a
begintsuglyph("uni314F",79);
  hangul.jamo.a(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ae
begintsuglyph("uni3150",80);
  hangul.combine.lr(300,320)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ya
begintsuglyph("uni3151",81);
  hangul.jamo.ya(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul yae
begintsuglyph("uni3152",82);
  hangul.combine.lr(302,320)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul eo
begintsuglyph("uni3153",83);
  hangul.jamo.eo(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul e
begintsuglyph("uni3154",84);
  hangul.combine.lr(304,320)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul yeo
begintsuglyph("uni3155",85);
  hangul.jamo.yeo(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ye
begintsuglyph("uni3156",86);
  hangul.combine.lr(306,320)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul o
begintsuglyph("uni3157",87);
  hangul.jamo.o(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul wa
begintsuglyph("uni3158",88);
  hangul.combine.lr(308,300)(309,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul wae
begintsuglyph("uni3159",89);
  hangul.combine.lr(308,301)(310,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul oe
begintsuglyph("uni315A",90);
  hangul.combine.lr(308,320)(311,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul yo
begintsuglyph("uni315B",91);
  hangul.jamo.yo(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul u
begintsuglyph("uni315C",92);
  hangul.jamo.u(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul weo
begintsuglyph("uni315D",93);
  hangul.combine.lr(313,304)(314,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul we
begintsuglyph("uni315E",94);
  hangul.combine.lr(313,305)(315,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul wi
begintsuglyph("uni315F",95);
  hangul.combine.lr(313,320)(316,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul yu
begintsuglyph("uni3160",96);
  hangul.jamo.yu(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul eu
begintsuglyph("uni3161",97);
  hangul.jamo.eu(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul yi
begintsuglyph("uni3162",98);
  hangul.combine.lr(318,320)(319,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul i
begintsuglyph("uni3163",99);
  hangul.jamo.i(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% uni3164 is "hangul filler," a full-width space created by external script

% hangul ssangnieun
begintsuglyph("uni3165",101);
  hangul.combine.lr(102,102)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul nieun-tikeut
begintsuglyph("uni3166",102);
  hangul.combine.lr(102,103)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul nieun-sios
begintsuglyph("uni3167",103);
  hangul.combine.lr(102,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul nieun-pansios
begintsuglyph("uni3168",104);
  hangul.combine.lr(102,219)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-kiyeok-sios
begintsuglyph("uni3169",105);
  hangul.combine.lcr(205,100,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-tikeut
begintsuglyph("uni316A",106);
  hangul.combine.lr(105,103)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-pieup-sios
begintsuglyph("uni316B",107);
  hangul.combine.lcr(105,107,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-pansios
begintsuglyph("uni316C",108);
  hangul.combine.lr(105,219)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul rieul-yeorinhieuh
begintsuglyph("uni316D",109);
  hangul.combine.lr(105,221)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul mieum-pieup
begintsuglyph("uni316E",110);
  hangul.combine.lr(106,107)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul mieum-sios
begintsuglyph("uni316F",111);
  hangul.combine.lr(106,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul mieum-pansios
begintsuglyph("uni3170",112);
  hangul.combine.lr(106,219)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul kapyeounmieum
begintsuglyph("uni3171",113);
  hangul.combine.tb(106,521)(whatever,hxf((200,850),(800,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul pieup-kiyeok
begintsuglyph("uni3172",114);
  hangul.combine.lr(107,100)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul pieup-tikeut
begintsuglyph("uni3173",115);
  hangul.combine.lr(107,103)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul pieup-sios-kiyeok
begintsuglyph("uni3174",116);
  hangul.combine.lcr(107,109,100)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul pieup-sios-tikeut
begintsuglyph("uni3175",117);
  hangul.combine.lcr(107,109,103)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul pieup-cieuc
begintsuglyph("uni3176",118);
  hangul.combine.lr(107,112)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul pieup-thieuth
begintsuglyph("uni3177",119);
  hangul.combine.lr(107,116)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul kapyeounpieup
begintsuglyph("uni3178",120);
  hangul.combine.tb(107,521)(whatever,hxf((200,850),(800,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul kapyeounssangpieup
begintsuglyph("uni3179",121);
  hangul.combine.tb(108,521)(whatever,hxf((150,850),(850,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul sios-kiyeok
begintsuglyph("uni317A",122);
  hangul.combine.lr(109,100)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul sios-nieun
begintsuglyph("uni317B",123);
  hangul.combine.lr(109,102)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul sios-tikeut
begintsuglyph("uni317C",124);
  hangul.combine.lr(109,103)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul sios-pieup
begintsuglyph("uni317D",125);
  hangul.combine.lr(109,107)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul sios-cieuc
begintsuglyph("uni317E",126);
  hangul.combine.lr(209,112)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul pansios
begintsuglyph("uni317F",127);
  hangul.jamo.pansios(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul ssangieung
begintsuglyph("uni3180",128);
  hangul.combine.lr(111,111)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul yesieung
begintsuglyph("uni3181",129);
  hangul.jamo.yesieung(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul yesieung-sios
begintsuglyph("uni3182",130);
  hangul.combine.lr(220,109)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul yesieung-pansios
begintsuglyph("uni3183",131);
  hangul.combine.lr(220,219)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul kapyeounphieuph
begintsuglyph("uni3184",132);
  hangul.combine.tb(117,521)(whatever,hxf((200,850),(800,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul ssanghieuh
begintsuglyph("uni3185",133);
  hangul.combine.lcr(118,230,118)(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul yeorinhieuh
begintsuglyph("uni3186",134);
  hangul.jamo.yeorinhieuh(whatever,identity,identity);
  tsu_render;
endtsuglyph;

% hangul yo-ya
begintsuglyph("uni3187",135);
  hangul.combine.lr(312,302)(421,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul yo-yae
begintsuglyph("uni3188",136);
  hangul.combine.lr(312,303)(422,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul yo-i
begintsuglyph("uni3189",137);
  hangul.combine.lr(312,320)(423,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul yu-yeo
begintsuglyph("uni318A",138);
  hangul.combine.lr(317,306)(424,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul yu-ye
begintsuglyph("uni318B",139);
  hangul.combine.lr(317,307)(425,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul yu-i
begintsuglyph("uni318C",140);
  hangul.combine.lr(317,320)(426,hxf((500,400),(950,-50)),identity);
  tsu_render;
endtsuglyph;

% hangul araea
begintsuglyph("uni318D",141);
  hangul.jamo.araea(428,identity,identity);
  tsu_render;
endtsuglyph;

% hangul araeae
begintsuglyph("uni318E",142);
  hangul.combine.lr(428,320)(427,identity,identity);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
