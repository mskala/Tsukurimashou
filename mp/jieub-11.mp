%
% Unicode page 11 (Hangul Jamo) for Jieubsida
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

% AUTODEPS
input hangul.mp;
input jamo-basic.mp;
input jamo-extra.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This file covers the basic layout (layout 0):  a lead, a vowel that may
% go both vertically and horizontally, and a non-empty tail.  All jamo are
% defined for this layout.  Other files (in private-use plane 15) define
% versions of some jamo for other layouts; the idea is that the jamo here
% are defaults, and an OpenType feature can substitute the others (or entire
% precomposed syllables) to improve the layout where applicable.

transform lixf,loxf,vixf,tvixf,voxf,tixf,toxf;

lixf=loxf=hxf((50,850),(700,525));
vixf=hxf((700,475),(950,250));
tvixf=hxf((700,535),(950,240));
voxf=hxf((50,850),(950,250));
tixf=hxf((100+20*mincho,275),(900-20*mincho,-50)) shifted (-1000,0);
toxf=hxf((50,275),(950,-50)) shifted (-1000,0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HANGUL CHOSEONG (LEAD) JAMO

tsu_rescale_native_zero;

% hangul lead kiyeok
begintsuglyph("uni1100",0);
  hangul.jamo.kiyeok(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangkiyeok
begintsuglyph("uni1101",1);
  hangul.combine.lr(100,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun
begintsuglyph("uni1102",2);
  hangul.jamo.nieun(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut
begintsuglyph("uni1103",3);
  hangul.jamo.tikeut(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangtikeut
begintsuglyph("uni1104",4);
  hangul.combine.lr(203,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul
begintsuglyph("uni1105",5);
  hangul.jamo.rieul(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum
begintsuglyph("uni1106",6);
  hangul.jamo.mieum(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup
begintsuglyph("uni1107",7);
  hangul.jamo.pieup(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangpieup
begintsuglyph("uni1108",8);
  hangul.combine.lr(207,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios
begintsuglyph("uni1109",9);
  hangul.jamo.sjc(0,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangsios
begintsuglyph("uni110A",10);
  hangul.combine.lr(209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung
begintsuglyph("uni110B",11);
  hangul.jamo.ieung(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead cieuc
begintsuglyph("uni110C",12);
  hangul.jamo.sjc(1,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangcieuc
begintsuglyph("uni110D",13);
  hangul.combine.lr(212,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch
begintsuglyph("uni110E",14);
  hangul.jamo.sjc(2,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead khieukh
begintsuglyph("uni110F",15);
  hangul.jamo.khieukh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead thieuth
begintsuglyph("uni1110",16);
  hangul.jamo.thieuth(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead phieuph
begintsuglyph("uni1111",17);
  hangul.jamo.phieuph(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead hieuh
begintsuglyph("uni1112",18);
  hangul.jamo.hieuh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-kiyeok
begintsuglyph("uni1113",19);
  hangul.combine.lr(202,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangnieun
begintsuglyph("uni1114",20);
  hangul.combine.lr(202,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-tikeut
begintsuglyph("uni1115",21);
  hangul.combine.lr(202,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-pieup
begintsuglyph("uni1116",22);
  hangul.combine.lr(202,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-kiyeok
begintsuglyph("uni1117",23);
  hangul.combine.lr(103,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-nieun
begintsuglyph("uni1118",24);
  hangul.combine.lr(205,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangrieul
begintsuglyph("uni1119",25);
  hangul.combine.lr(205,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-hieuh
begintsuglyph("uni111A",26);
  hangul.combine.lr(205,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounrieul
begintsuglyph("uni111B",27);
  hangul.combine.tb(105,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum-pieup
begintsuglyph("uni111C",28);
  hangul.combine.lr(106,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounmieum
begintsuglyph("uni111D",29);
  hangul.combine.tb(106,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-kiyeok
begintsuglyph("uni111E",30);
  hangul.combine.lr(107,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-nieun
begintsuglyph("uni111F",31);
  hangul.combine.lr(207,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-tikeut
begintsuglyph("uni1120",32);
  hangul.combine.lr(207,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios
begintsuglyph("uni1121",33);
  hangul.combine.lr(107,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-kiyeok
begintsuglyph("uni1122",34);
  hangul.combine.lcr(107,109,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-tikeut
begintsuglyph("uni1123",35);
  hangul.combine.lcr(107,209,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-pieup
begintsuglyph("uni1124",36);
  hangul.combine.lcr(107,209,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-ssangsios
begintsuglyph("uni1125",37);
  hangul.combine.lcr(107,209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-cieuc
begintsuglyph("uni1126",38);
  hangul.combine.lcr(107,209,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-cieuc
begintsuglyph("uni1127",39);
  hangul.combine.lr(207,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-chieuch
begintsuglyph("uni1128",40);
  hangul.combine.lr(207,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-thieuth
begintsuglyph("uni1129",41);
  hangul.combine.lr(207,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-phieuph
begintsuglyph("uni112A",42);
  hangul.combine.lr(207,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounpieup
begintsuglyph("uni112B",43);
  hangul.combine.tb(107,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounssangpieup
begintsuglyph("uni112C",44);
  hangul.combine.tb(108,521)(whatever,
    hxf((150,850),(850,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-kiyeok
begintsuglyph("uni112D",45);
  hangul.combine.lr(109,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-nieun
begintsuglyph("uni112E",46);
  hangul.combine.lr(209,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-tikeut
begintsuglyph("uni112F",47);
  hangul.combine.lr(209,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-rieul
begintsuglyph("uni1130",48);
  hangul.combine.lr(209,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-mieum
begintsuglyph("uni1131",49);
  hangul.combine.lr(209,106)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-pieup
begintsuglyph("uni1132",50);
  hangul.combine.lr(209,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-pieup-kiyeok
begintsuglyph("uni1133",51);
  hangul.combine.lcr(209,207,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-sios-sios
begintsuglyph("uni1134",52);
  hangul.combine.lcr(209,209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-ieung
begintsuglyph("uni1135",53);
  hangul.combine.lr(109,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-cieuc
begintsuglyph("uni1136",54);
  hangul.combine.lr(209,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-chieuch
begintsuglyph("uni1137",55);
  hangul.combine.lr(209,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-khieukh
begintsuglyph("uni1138",56);
  hangul.combine.lr(209,115)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-thieuth
begintsuglyph("uni1139",57);
  hangul.combine.lr(209,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-phieuph
begintsuglyph("uni113A",58);
  hangul.combine.lr(209,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-hieuh
begintsuglyph("uni113B",59);
  hangul.combine.lr(209,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumsios
begintsuglyph("uni113C",60);
  hangul.jamo.sjc(0,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumssangsios
begintsuglyph("uni113D",61);
  hangul.combine.lr(223,222)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumsios
begintsuglyph("uni113E",62);
  hangul.jamo.sjc(0,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumssangsios
begintsuglyph("uni113F",63);
  hangul.combine.lr(224,225)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pansios
begintsuglyph("uni1140",64);
  hangul.jamo.pansios(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-kiyeok
begintsuglyph("uni1141",65);
  hangul.combine.lr(111,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-tikeut
begintsuglyph("uni1142",66);
  hangul.combine.lr(111,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-mieum
begintsuglyph("uni1143",67);
  hangul.combine.lr(111,106)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-pieup
begintsuglyph("uni1144",68);
  hangul.combine.lr(111,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-sios
begintsuglyph("uni1145",69);
  hangul.combine.lr(111,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-pansios
begintsuglyph("uni1146",70);
  hangul.combine.lr(111,219)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangieung
begintsuglyph("uni1147",71);
  hangul.combine.lr(111,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-cieuc
begintsuglyph("uni1148",72);
  hangul.combine.lr(111,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-chieuch
begintsuglyph("uni1149",73);
  hangul.combine.lr(111,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-theiuth
begintsuglyph("uni114A",74);
  hangul.combine.lr(111,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-phieuph
begintsuglyph("uni114B",75);
  hangul.combine.lr(111,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead yesieung
begintsuglyph("uni114C",76);
  hangul.jamo.yesieung(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead cieuc-ieung
begintsuglyph("uni114D",77);
  hangul.combine.lr(112,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumcieuc
begintsuglyph("uni114E",78);
  hangul.jamo.sjc(1,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumssangcieuc
begintsuglyph("uni114F",79);
  hangul.combine.lr(227,226)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumcieuc
begintsuglyph("uni1150",80);
  hangul.jamo.sjc(1,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumssangcieuc
begintsuglyph("uni1151",81);
  hangul.combine.lr(228,229)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch-khieukh
begintsuglyph("uni1152",82);
  hangul.combine.lcr(214,230,115)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch-hieuh
begintsuglyph("uni1153",83);
  hangul.combine.lcr(214,230,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumcieuc
begintsuglyph("uni1154",84);
  hangul.jamo.sjc(2,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumcieuc
begintsuglyph("uni1155",85);
  hangul.jamo.sjc(2,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead phieuph-pieup
begintsuglyph("uni1156",86);
  hangul.combine.lr(117,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounphieuph
begintsuglyph("uni1157",87);
  hangul.combine.tb(117,521)(whatever,
    hxf((250,850),(850,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssanghieuh
begintsuglyph("uni1158",88);
  hangul.combine.lcr(118,230,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead yeorinhieuh
begintsuglyph("uni1159",89);
  hangul.jamo.yeorinhieuh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kiyeok-tikeut
begintsuglyph("uni115A",90);
  hangul.combine.lr(100,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-sios
begintsuglyph("uni115B",91);
  hangul.combine.lr(202,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-cieuc
begintsuglyph("uni115C",92);
  hangul.combine.lr(202,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-hieuh
begintsuglyph("uni115D",93);
  hangul.combine.lr(202,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-rieul
begintsuglyph("uni115E",94);
  hangul.combine.lr(203,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% uni115F "lead filler" is a space created by assemble-font script

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HANGUL JUNGSEONG (VOWEL) JAMO

tsu_rescale_full;

% uni1160 "vowel filler" is a space created by assemble-font script

% hangul vowel a
begintsuglyph("uni1161",97);
  hangul.jamo.a(300,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ae
begintsuglyph("uni1162",98);
  hangul.combine.lr(300,320)(301,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ya
begintsuglyph("uni1163",99);
  hangul.jamo.ya(302,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yae
begintsuglyph("uni1164",100);
  hangul.combine.lr(302,320)(303,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eo
begintsuglyph("uni1165",101);
  hangul.jamo.eo(304,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel e
begintsuglyph("uni1166",102);
  hangul.combine.lr(304,320)(305,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yeo
begintsuglyph("uni1167",103);
  hangul.jamo.yeo(306,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ye
begintsuglyph("uni1168",104);
  hangul.combine.lr(306,320)(307,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o
begintsuglyph("uni1169",105);
  hangul.jamo.o(308,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel wa
begintsuglyph("uni116A",106);
  hangul.combine.lr(308,300)(309,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel wae
begintsuglyph("uni116B",107);
  hangul.combine.lr(308,301)(310,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel oe
begintsuglyph("uni116C",108);
  hangul.combine.lr(308,320)(311,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo
begintsuglyph("uni116D",109);
  hangul.jamo.yo(312,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u
begintsuglyph("uni116E",110);
  hangul.jamo.u(313,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel weo
begintsuglyph("uni116F",111);
  hangul.combine.lr(313,304)(314,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel we
begintsuglyph("uni1170",112);
  hangul.combine.lr(313,305)(315,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel wi
begintsuglyph("uni1171",113);
  hangul.combine.lr(313,320)(316,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu
begintsuglyph("uni1172",114);
  hangul.jamo.yu(317,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu
begintsuglyph("uni1173",115);
  hangul.jamo.eu(318,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yi
begintsuglyph("uni1174",116);
  hangul.combine.lr(318,320)(319,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i
begintsuglyph("uni1175",117);
  hangul.jamo.i(320,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel a-o
begintsuglyph("uni1176",118);
  hangul.combine.tb(300,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel a-u
begintsuglyph("uni1177",119);
  hangul.combine.tb(300,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ya-o
begintsuglyph("uni1178",120);
  hangul.combine.tb(302,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ya-yo
begintsuglyph("uni1179",121);
  hangul.combine.tb(302,312)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eo-o
begintsuglyph("uni117A",122);
  hangul.combine.tb(304,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eo-u
begintsuglyph("uni117B",123);
  hangul.combine.tb(304,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eo-eu
begintsuglyph("uni117C",124);
  hangul.combine.tb(304,318)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yeo-o
begintsuglyph("uni117D",125);
  hangul.combine.tb(306,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yeo-u
begintsuglyph("uni117E",126);
  hangul.combine.tb(306,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-eo
begintsuglyph("uni117F",127);
  hangul.combine.lr(308,304)(429,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-e
begintsuglyph("uni1180",128);
  hangul.combine.lr(308,305)(430,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-ye
begintsuglyph("uni1181",129);
  hangul.combine.lr(308,307)(431,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-o
begintsuglyph("uni1182",130);
  hangul.combine.tb(308,308)(444,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-u
begintsuglyph("uni1183",131);
  hangul.combine.tb(308,313)(whatever,tvixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-ya
begintsuglyph("uni1184",132);
  hangul.combine.lr(312,302)(421,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-yae
begintsuglyph("uni1185",133);
  hangul.combine.lr(312,303)(422,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-yeo
begintsuglyph("uni1186",134);
  hangul.combine.lr(312,306)(432,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-o
begintsuglyph("uni1187",135);
  hangul.combine.tb(312,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-i
begintsuglyph("uni1188",136);
  hangul.combine.lr(312,320)(423,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-a
begintsuglyph("uni1189",137);
  hangul.combine.lr(313,300)(433,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-ae
begintsuglyph("uni118A",138);
  hangul.combine.lr(313,301)(434,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-eo-eu
begintsuglyph("uni118B",139);
  hangul.combine.tb(314,318)(435,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-ye
begintsuglyph("uni118C",140);
  hangul.combine.lr(313,307)(436,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-u
begintsuglyph("uni118D",141);
  hangul.combine.tb(313,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-a
begintsuglyph("uni118E",142);
  hangul.combine.lr(317,300)(437,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-eo
begintsuglyph("uni118F",143);
  hangul.combine.lr(317,304)(438,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-e
begintsuglyph("uni1190",144);
  hangul.combine.lr(317,305)(439,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-yeo
begintsuglyph("uni1191",145);
  hangul.combine.lr(317,306)(424,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-ye
begintsuglyph("uni1192",146);
  hangul.combine.lr(317,307)(425,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-u
begintsuglyph("uni1193",147);
  hangul.combine.tb(317,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-i
begintsuglyph("uni1194",148);
  hangul.combine.lr(317,320)(426,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu-u
begintsuglyph("uni1195",149);
  hangul.combine.tb(318,313)(whatever,tvixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu-eu
begintsuglyph("uni1196",150);
  hangul.combine.tb(318,318)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yi-u
begintsuglyph("uni1197",151);
  hangul.combine.tb(319,313)(440,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-a
begintsuglyph("uni1198",152);
  hangul.combine.lr(320,300)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-ya
begintsuglyph("uni1199",153);
  hangul.combine.lr(320,302)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-o
begintsuglyph("uni119A",154);
  hangul.combine.tb(320,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-u
begintsuglyph("uni119B",155);
  hangul.combine.tb(320,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-eu
begintsuglyph("uni119C",156);
  hangul.combine.tb(320,318)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-araea
begintsuglyph("uni119D",157);
  hangul.combine.tb(320,428)(441,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea
begintsuglyph("uni119E",158);
  hangul.jamo.araea(428,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea-eo
begintsuglyph("uni119F",159);
  hangul.combine.lr(428,304)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea-u
begintsuglyph("uni11A0",160);
  hangul.combine.tb(428,313)(whatever,tvixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea-i
begintsuglyph("uni11A1",161);
  hangul.combine.lr(428,320)(427,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ssangaraea
begintsuglyph("uni11A2",162);
  hangul.combine.lr(428,428)(whatever,
    hxf_inout(5,vixf,voxf),voxf);
  tsu_render;
endtsuglyph;

% hangul vowel a-eu
begintsuglyph("uni11A3",163);
  hangul.combine.tb(300,318)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ya-u
begintsuglyph("uni11A4",164);
  hangul.combine.tb(302,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yeo-ya
begintsuglyph("uni11A5",165);
  hangul.combine.lr(306,302)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-ya
begintsuglyph("uni11A6",166);
  hangul.combine.lr(308,302)(442,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-yae
begintsuglyph("uni11A7",167);
  hangul.combine.lr(308,303)(443,vixf,voxf);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HANGUL JONGSEONG (TAIL) JAMO

tsu_rescale_native_zero;

% hangul tail kiyeok
begintsuglyph("uni11A8",168);
  hangul.jamo.kiyeok(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail ssangkiyeok
begintsuglyph("uni11A9",169);
  hangul.combine.lr(501,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kiyeok-sios
begintsuglyph("uni11AA",170);
  hangul.combine.lr(501,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail nieun
begintsuglyph("uni11AB",171);
  hangul.jamo.nieun(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail nieun-cieuc
begintsuglyph("uni11AC",172);
  hangul.combine.lr(604,522)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail nieun-hieuh
begintsuglyph("uni11AD",173);
  hangul.combine.lr(604,527)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail tikeut
begintsuglyph("uni11AE",174);
  hangul.jamo.tikeut(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul
begintsuglyph("uni11AF",175);
  hangul.jamo.rieul(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-kiyeok
begintsuglyph("uni11B0",176);
  hangul.combine.lr(608,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-mieum
begintsuglyph("uni11B1",177);
  hangul.combine.lr(608,516)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-pieup
begintsuglyph("uni11B2",178);
  hangul.combine.lr(608,517)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-sios
begintsuglyph("uni11B3",179);
  hangul.combine.lr(608,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-thieuth
begintsuglyph("uni11B4",180);
  hangul.combine.lr(608,525)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-phieuph
begintsuglyph("uni11B5",181);
  hangul.combine.lr(608,526)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-hieuh
begintsuglyph("uni11B6",182);
  hangul.combine.lr(608,527)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum
begintsuglyph("uni11B7",183);
  hangul.jamo.mieum(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail pieup
begintsuglyph("uni11B8",184);
  hangul.jamo.pieup(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail pieup-sios
begintsuglyph("uni11B9",185);
  hangul.combine.lr(517,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail sios
begintsuglyph("uni11BA",186);
  hangul.jamo.sjc(0,0,false)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail ssangsios
begintsuglyph("uni11BB",187);
  hangul.combine.lr(619,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail ieung
begintsuglyph("uni11BC",188);
  hangul.jamo.ieung(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail cieuc
begintsuglyph("uni11BD",189);
  hangul.jamo.sjc(1,0,false)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail chieuch
begintsuglyph("uni11BE",190);
  hangul.jamo.sjc(2,0,false)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail khieukh
begintsuglyph("uni11BF",191);
  hangul.jamo.khieukh(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail thieuth
begintsuglyph("uni11C0",192);
  hangul.jamo.thieuth(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail phieuph
begintsuglyph("uni11C1",193);
  hangul.jamo.phieuph(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail hieuh
begintsuglyph("uni11C2",194);
  hangul.jamo.hieuh(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kiyeok-rieul
begintsuglyph("uni11C3",195);
  hangul.combine.lr(501,508)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kiyeok-sios-kiyeok
begintsuglyph("uni11C4",196);
  hangul.combine.lcr(501,519,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail nieun-kiyeok
begintsuglyph("uni11C5",197);
  hangul.combine.lr(604,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail nieun-tikeut
begintsuglyph("uni11C6",198);
  hangul.combine.lr(604,507)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail nieun-sios
begintsuglyph("uni11C7",199);
  hangul.combine.lr(604,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail nieun-pansios
begintsuglyph("uni11C8",200);
  hangul.combine.lr(604,628)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail nieun-thieuth
begintsuglyph("uni11C9",201);
  hangul.combine.lr(604,525)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail tikeut-kiyeok
begintsuglyph("uni11CA",202);
  hangul.combine.lr(607,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail tikeut-rieul
begintsuglyph("uni11CB",203);
  hangul.combine.lr(607,508)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-kiyeok-sios
begintsuglyph("uni11CC",204);
  hangul.combine.lcr(608,501,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-nieun
begintsuglyph("uni11CD",205);
  hangul.combine.lr(608,504)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-tikeut
begintsuglyph("uni11CE",206);
  hangul.combine.lr(608,507)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-tikeut-hieuh
begintsuglyph("uni11CF",207);
  hangul.combine.lcr(608,607,627)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-rieul
begintsuglyph("uni11D0",208);
  hangul.combine.lr(608,508)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-mieum-kiyeok
begintsuglyph("uni11D1",209);
  hangul.combine.lcr(608,516,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-mieum-sios
begintsuglyph("uni11D2",210);
  hangul.combine.lcr(608,516,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-pieup-sios
begintsuglyph("uni11D3",211);
  hangul.combine.lcr(608,517,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-pieup-hieuh
begintsuglyph("uni11D4",212);
  hangul.combine.lcr(608,517,527)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-kapyeounpieup
begintsuglyph("uni11D5",213);
  hangul.combine.lr(608,630)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-sios-sios
begintsuglyph("uni11D6",214);
  hangul.combine.lcr(608,619,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-pansios
begintsuglyph("uni11D7",215);
  hangul.combine.lr(608,628)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-khieukh
begintsuglyph("uni11D8",216);
  hangul.combine.lr(608,524)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail rieul-yeorinhieuh
begintsuglyph("uni11D9",217);
  hangul.combine.lr(608,631)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum-kiyeok
begintsuglyph("uni11DA",218);
  hangul.combine.lr(516,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum-rieul
begintsuglyph("uni11DB",219);
  hangul.combine.lr(516,508)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum-pieup
begintsuglyph("uni11DC",220);
  hangul.combine.lr(516,517)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum-sios
begintsuglyph("uni11DD",221);
  hangul.combine.lr(516,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum-sios-sios
begintsuglyph("uni11DE",222);
  hangul.combine.lcr(516,619,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum-pansios
begintsuglyph("uni11DF",223);
  hangul.combine.lr(516,628)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum-chieuch
begintsuglyph("uni11E0",224);
  hangul.combine.lr(516,523)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail mieum-hieuh
begintsuglyph("uni11E1",225);
  hangul.combine.lr(516,527)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kapyeounmieum
begintsuglyph("uni11E2",226);
  hangul.combine.tb(516,521)(whatever,
    hxf((200,850),(800,-50)) transformed tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail pieup-rieul
begintsuglyph("uni11E3",227);
  hangul.combine.lr(517,508)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail pieup-phieuph
begintsuglyph("uni11E4",228);
  hangul.combine.lr(517,526)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail pieup-hieuh
begintsuglyph("uni11E5",229);
  hangul.combine.lr(517,527)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kapyeounpieup
begintsuglyph("uni11E6",230);
  hangul.combine.tb(517,521)(whatever,
    hxf((200,850),(800,-50)) transformed tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail sios-kiyeok
begintsuglyph("uni11E7",231);
  hangul.combine.lr(519,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail sios-tikeut
begintsuglyph("uni11E8",232);
  hangul.combine.lr(519,507)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail sios-rieul
begintsuglyph("uni11E9",233);
  hangul.combine.lr(519,508)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail sios-pieup
begintsuglyph("uni11EA",234);
  hangul.combine.lr(519,517)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail pansios
begintsuglyph("uni11EB",235);
  hangul.jamo.pansios(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail yesieung-kiyeok
begintsuglyph("uni11EC",236);
  hangul.combine.lr(629,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail yesieung-kiyeok-kiyeok
begintsuglyph("uni11ED",237);
  hangul.combine.lcr(629,501,501)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail yesieung-yesieung
begintsuglyph("uni11EE",238);
  hangul.combine.lr(629,629)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail yesieung-khieukh
begintsuglyph("uni11EF",239);
  hangul.combine.lr(629,524)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail yesieung
begintsuglyph("uni11F0",240);
  hangul.jamo.yesieung(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail yesieung-sios
begintsuglyph("uni11F1",241);
  hangul.combine.lr(629,519)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail yesieung-pansios
begintsuglyph("uni11F2",242);
  hangul.combine.lr(629,628)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail phieuph-pieup
begintsuglyph("uni11F3",243);
  hangul.combine.lr(526,517)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kapyeounphieuph
begintsuglyph("uni11F4",244);
  hangul.combine.tb(526,521)(whatever,
    hxf((250,850),(850,-50)) transformed tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail hieuh-nieun
begintsuglyph("uni11F5",245);
  hangul.combine.lr(527,504)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail hieuh-rieul
begintsuglyph("uni11F6",246);
  hangul.combine.lr(527,508)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail hieuh-mieum
begintsuglyph("uni11F7",247);
  hangul.combine.lr(527,516)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail hieuh-pieup
begintsuglyph("uni11F8",248);
  hangul.combine.lr(527,517)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail yeorinhieuh
begintsuglyph("uni11F9",249);
  hangul.jamo.yeorinhieuh(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kiyeok-nieun
begintsuglyph("uni11FA",250);
  hangul.combine.lr(501,504)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kiyeok-pieup
begintsuglyph("uni11FB",251);
  hangul.combine.lr(501,517)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kiyeok-chieuch
begintsuglyph("uni11FC",252);
  hangul.combine.lr(501,523)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kiyeok-khieukh
begintsuglyph("uni11FD",253);
  hangul.combine.lr(501,524)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail kiyeok-hieuh
begintsuglyph("uni11FE",254);
  hangul.combine.lr(501,527)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

% hangul tail ssangnieun
begintsuglyph("uni11FF",255);
  hangul.combine.lr(604,504)(whatever,tixf,toxf);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
