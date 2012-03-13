%
% Unicode page FF2 (alternate glyphs for vowel jamo) for Jieubsida
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

% This file is supposed to cover vowels only, for the "empty tail" layouts
% (layouts 3, 4, and 5).  But for the moment, it also contains a set of
% lead jamo for layout 0, duplicating the ones on the U+11xx page, in
% order to work around XeTeX's apparent inability to process "ignore sub"
% feature rules.

transform lixf,loxf,vixf,tvixf,voxf;

lixf=loxf=hxf((50,850),(700,525));
vixf=hxf((700,275),(950,-50));
tvixf=hxf((700,335),(950,-50));
voxf=identity;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HANGUL CHOSEONG (LEAD) JAMO

tsu_rescale_native_zero;

% hangul lead kiyeok
begintsuglyph("uni1100.bug",0);
  hangul.jamo.kiyeok(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangkiyeok
begintsuglyph("uni1101.bug",1);
  hangul.combine.lr(100,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun
begintsuglyph("uni1102.bug",2);
  hangul.jamo.nieun(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut
begintsuglyph("uni1103.bug",3);
  hangul.jamo.tikeut(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangtikeut
begintsuglyph("uni1104.bug",4);
  hangul.combine.lr(203,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul
begintsuglyph("uni1105.bug",5);
  hangul.jamo.rieul(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum
begintsuglyph("uni1106.bug",6);
  hangul.jamo.mieum(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup
begintsuglyph("uni1107.bug",7);
  hangul.jamo.pieup(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangpieup
begintsuglyph("uni1108.bug",8);
  hangul.combine.lr(207,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios
begintsuglyph("uni1109.bug",9);
  hangul.jamo.sjc(0,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangsios
begintsuglyph("uni110A.bug",10);
  hangul.combine.lr(209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung
begintsuglyph("uni110B.bug",11);
  hangul.jamo.ieung(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead cieuc
begintsuglyph("uni110C.bug",12);
  hangul.jamo.sjc(1,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangcieuc
begintsuglyph("uni110D.bug",13);
  hangul.combine.lr(212,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch
begintsuglyph("uni110E.bug",14);
  hangul.jamo.sjc(2,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead khieukh
begintsuglyph("uni110F.bug",15);
  hangul.jamo.khieukh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead thieuth
begintsuglyph("uni1110.bug",16);
  hangul.jamo.thieuth(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead phieuph
begintsuglyph("uni1111.bug",17);
  hangul.jamo.phieuph(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead hieuh
begintsuglyph("uni1112.bug",18);
  hangul.jamo.hieuh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-kiyeok
begintsuglyph("uni1113.bug",19);
  hangul.combine.lr(202,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangnieun
begintsuglyph("uni1114.bug",20);
  hangul.combine.lr(202,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-tikeut
begintsuglyph("uni1115.bug",21);
  hangul.combine.lr(202,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-pieup
begintsuglyph("uni1116.bug",22);
  hangul.combine.lr(202,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-kiyeok
begintsuglyph("uni1117.bug",23);
  hangul.combine.lr(103,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-nieun
begintsuglyph("uni1118.bug",24);
  hangul.combine.lr(205,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangrieul
begintsuglyph("uni1119.bug",25);
  hangul.combine.lr(205,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-hieuh
begintsuglyph("uni111A.bug",26);
  hangul.combine.lr(205,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounrieul
begintsuglyph("uni111B.bug",27);
  hangul.combine.tb(105,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum-pieup
begintsuglyph("uni111C.bug",28);
  hangul.combine.lr(106,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounmieum
begintsuglyph("uni111D.bug",29);
  hangul.combine.tb(106,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-kiyeok
begintsuglyph("uni111E.bug",30);
  hangul.combine.lr(107,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-nieun
begintsuglyph("uni111F.bug",31);
  hangul.combine.lr(207,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-tikeut
begintsuglyph("uni1120.bug",32);
  hangul.combine.lr(207,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios
begintsuglyph("uni1121.bug",33);
  hangul.combine.lr(107,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-kiyeok
begintsuglyph("uni1122.bug",34);
  hangul.combine.lcr(107,109,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-tikeut
begintsuglyph("uni1123.bug",35);
  hangul.combine.lcr(107,209,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-pieup
begintsuglyph("uni1124.bug",36);
  hangul.combine.lcr(107,209,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-ssangsios
begintsuglyph("uni1125.bug",37);
  hangul.combine.lcr(107,209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-cieuc
begintsuglyph("uni1126.bug",38);
  hangul.combine.lcr(107,209,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-cieuc
begintsuglyph("uni1127.bug",39);
  hangul.combine.lr(207,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-chieuch
begintsuglyph("uni1128.bug",40);
  hangul.combine.lr(207,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-thieuth
begintsuglyph("uni1129.bug",41);
  hangul.combine.lr(207,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-phieuph
begintsuglyph("uni112A.bug",42);
  hangul.combine.lr(207,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounpieup
begintsuglyph("uni112B.bug",43);
  hangul.combine.tb(107,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounssangpieup
begintsuglyph("uni112C.bug",44);
  hangul.combine.tb(108,521)(whatever,
    hxf((150,850),(850,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-kiyeok
begintsuglyph("uni112D.bug",45);
  hangul.combine.lr(109,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-nieun
begintsuglyph("uni112E.bug",46);
  hangul.combine.lr(209,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-tikeut
begintsuglyph("uni112F.bug",47);
  hangul.combine.lr(209,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-rieul
begintsuglyph("uni1130.bug",48);
  hangul.combine.lr(209,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-mieum
begintsuglyph("uni1131.bug",49);
  hangul.combine.lr(209,106)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-pieup
begintsuglyph("uni1132.bug",50);
  hangul.combine.lr(209,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-pieup-kiyeok
begintsuglyph("uni1133.bug",51);
  hangul.combine.lcr(209,207,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-sios-sios
begintsuglyph("uni1134.bug",52);
  hangul.combine.lcr(209,209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-ieung
begintsuglyph("uni1135.bug",53);
  hangul.combine.lr(109,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-cieuc
begintsuglyph("uni1136.bug",54);
  hangul.combine.lr(209,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-chieuch
begintsuglyph("uni1137.bug",55);
  hangul.combine.lr(209,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-khieukh
begintsuglyph("uni1138.bug",56);
  hangul.combine.lr(209,115)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-thieuth
begintsuglyph("uni1139.bug",57);
  hangul.combine.lr(209,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-phieuph
begintsuglyph("uni113A.bug",58);
  hangul.combine.lr(209,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-hieuh
begintsuglyph("uni113B.bug",59);
  hangul.combine.lr(209,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumsios
begintsuglyph("uni113C.bug",60);
  hangul.jamo.sjc(0,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumssangsios
begintsuglyph("uni113D.bug",61);
  hangul.combine.lr(223,222)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumsios
begintsuglyph("uni113E.bug",62);
  hangul.jamo.sjc(0,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumssangsios
begintsuglyph("uni113F.bug",63);
  hangul.combine.lr(224,225)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pansios
begintsuglyph("uni1140.bug",64);
  hangul.jamo.pansios(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-kiyeok
begintsuglyph("uni1141.bug",65);
  hangul.combine.lr(111,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-tikeut
begintsuglyph("uni1142.bug",66);
  hangul.combine.lr(111,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-mieum
begintsuglyph("uni1143.bug",67);
  hangul.combine.lr(111,106)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-pieup
begintsuglyph("uni1144.bug",68);
  hangul.combine.lr(111,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-sios
begintsuglyph("uni1145.bug",69);
  hangul.combine.lr(111,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-pansios
begintsuglyph("uni1146.bug",70);
  hangul.combine.lr(111,219)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangieung
begintsuglyph("uni1147.bug",71);
  hangul.combine.lr(111,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-cieuc
begintsuglyph("uni1148.bug",72);
  hangul.combine.lr(111,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-chieuch
begintsuglyph("uni1149.bug",73);
  hangul.combine.lr(111,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-theiuth
begintsuglyph("uni114A.bug",74);
  hangul.combine.lr(111,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-phieuph
begintsuglyph("uni114B.bug",75);
  hangul.combine.lr(111,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead yesieung
begintsuglyph("uni114C.bug",76);
  hangul.jamo.yesieung(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead cieuc-ieung
begintsuglyph("uni114D.bug",77);
  hangul.combine.lr(112,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumcieuc
begintsuglyph("uni114E.bug",78);
  hangul.jamo.sjc(1,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumssangcieuc
begintsuglyph("uni114F.bug",79);
  hangul.combine.lr(227,226)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumcieuc
begintsuglyph("uni1150.bug",80);
  hangul.jamo.sjc(1,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumssangcieuc
begintsuglyph("uni1151.bug",81);
  hangul.combine.lr(228,229)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch-khieukh
begintsuglyph("uni1152.bug",82);
  hangul.combine.lcr(214,230,115)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch-hieuh
begintsuglyph("uni1153.bug",83);
  hangul.combine.lcr(214,230,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumcieuc
begintsuglyph("uni1154.bug",84);
  hangul.jamo.sjc(2,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumcieuc
begintsuglyph("uni1155.bug",85);
  hangul.jamo.sjc(2,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead phieuph-pieup
begintsuglyph("uni1156.bug",86);
  hangul.combine.lr(117,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounphieuph
begintsuglyph("uni1157.bug",87);
  hangul.combine.tb(117,521)(whatever,
    hxf((250,850),(850,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssanghieuh
begintsuglyph("uni1158.bug",88);
  hangul.combine.lcr(118,230,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead yeorinhieuh
begintsuglyph("uni1159.bug",89);
  hangul.jamo.yeorinhieuh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kiyeok-tikeut
begintsuglyph("uni115A.bug",90);
  hangul.combine.lr(100,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-sios
begintsuglyph("uni115B.bug",91);
  hangul.combine.lr(202,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-cieuc
begintsuglyph("uni115C.bug",92);
  hangul.combine.lr(202,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-hieuh
begintsuglyph("uni115D.bug",93);
  hangul.combine.lr(202,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-rieul
begintsuglyph("uni115E.bug",94);
  hangul.combine.lr(203,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HANGUL JUNGSEONG (VOWEL) JAMO

tsu_rescale_full;

% hangul vowel a
begintsuglyph("uni1161.nt",97);
  hangul.jamo.a(300,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ae
begintsuglyph("uni1162.nt",98);
  hangul.combine.lr(300,320)(301,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ya
begintsuglyph("uni1163.nt",99);
  hangul.jamo.ya(302,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yae
begintsuglyph("uni1164.nt",100);
  hangul.combine.lr(302,320)(303,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eo
begintsuglyph("uni1165.nt",101);
  hangul.jamo.eo(304,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel e
begintsuglyph("uni1166.nt",102);
  hangul.combine.lr(304,320)(305,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yeo
begintsuglyph("uni1167.nt",103);
  hangul.jamo.yeo(306,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ye
begintsuglyph("uni1168.nt",104);
  hangul.combine.lr(306,320)(307,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o
begintsuglyph("uni1169.nt",105);
  hangul.jamo.o(308,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel wa
begintsuglyph("uni116A.nt",106);
  hangul.combine.lr(308,300)(309,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel wae
begintsuglyph("uni116B.nt",107);
  hangul.combine.lr(308,301)(310,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel oe
begintsuglyph("uni116C.nt",108);
  hangul.combine.lr(308,320)(311,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo
begintsuglyph("uni116D.nt",109);
  hangul.jamo.yo(312,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u
begintsuglyph("uni116E.nt",110);
  hangul.jamo.u(313,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel weo
begintsuglyph("uni116F.nt",111);
  hangul.combine.lr(313,304)(314,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel we
begintsuglyph("uni1170.nt",112);
  hangul.combine.lr(313,305)(315,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel wi
begintsuglyph("uni1171.nt",113);
  hangul.combine.lr(313,320)(316,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu
begintsuglyph("uni1172.nt",114);
  hangul.jamo.yu(317,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu
begintsuglyph("uni1173.nt",115);
  hangul.jamo.eu(318,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yi
begintsuglyph("uni1174.nt",116);
  hangul.combine.lr(318,320)(319,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i
begintsuglyph("uni1175.nt",117);
  hangul.jamo.i(320,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel a-o
begintsuglyph("uni1176.nt",118);
  hangul.combine.tb(300,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel a-u
begintsuglyph("uni1177.nt",119);
  hangul.combine.tb(300,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ya-o
begintsuglyph("uni1178.nt",120);
  hangul.combine.tb(302,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ya-yo
begintsuglyph("uni1179.nt",121);
  hangul.combine.tb(302,312)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eo-o
begintsuglyph("uni117A.nt",122);
  hangul.combine.tb(304,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eo-u
begintsuglyph("uni117B.nt",123);
  hangul.combine.tb(304,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eo-eu
begintsuglyph("uni117C.nt",124);
  hangul.combine.tb(304,318)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yeo-o
begintsuglyph("uni117D.nt",125);
  hangul.combine.tb(306,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yeo-u
begintsuglyph("uni117E.nt",126);
  hangul.combine.tb(306,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-eo
begintsuglyph("uni117F.nt",127);
  hangul.combine.lr(308,304)(429,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-e
begintsuglyph("uni1180.nt",128);
  hangul.combine.lr(308,305)(430,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-ye
begintsuglyph("uni1181.nt",129);
  hangul.combine.lr(308,307)(431,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-o
begintsuglyph("uni1182.nt",130);
  hangul.combine.tb(308,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-u
begintsuglyph("uni1183.nt",131);
  hangul.combine.tb(308,313)(whatever,tvixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-ya
begintsuglyph("uni1184.nt",132);
  hangul.combine.lr(312,302)(421,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-yae
begintsuglyph("uni1185.nt",133);
  hangul.combine.lr(312,303)(422,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-yeo
begintsuglyph("uni1186.nt",134);
  hangul.combine.lr(312,306)(432,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-o
begintsuglyph("uni1187.nt",135);
  hangul.combine.tb(312,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-i
begintsuglyph("uni1188.nt",136);
  hangul.combine.lr(312,320)(423,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-a
begintsuglyph("uni1189.nt",137);
  hangul.combine.lr(313,300)(433,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-ae
begintsuglyph("uni118A.nt",138);
  hangul.combine.lr(313,301)(434,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-eo-eu
begintsuglyph("uni118B.nt",139);
  hangul.combine.tb(314,318)(435,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-ye
begintsuglyph("uni118C.nt",140);
  hangul.combine.lr(313,307)(436,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-u
begintsuglyph("uni118D.nt",141);
  hangul.combine.tb(313,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-a
begintsuglyph("uni118E.nt",142);
  hangul.combine.lr(317,300)(437,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-eo
begintsuglyph("uni118F.nt",143);
  hangul.combine.lr(317,304)(438,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-e
begintsuglyph("uni1190.nt",144);
  hangul.combine.lr(317,305)(439,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-yeo
begintsuglyph("uni1191.nt",145);
  hangul.combine.lr(317,306)(424,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-ye
begintsuglyph("uni1192.nt",146);
  hangul.combine.lr(317,307)(425,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-u
begintsuglyph("uni1193.nt",147);
  hangul.combine.tb(317,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-i
begintsuglyph("uni1194.nt",148);
  hangul.combine.lr(317,320)(426,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu-u
begintsuglyph("uni1195.nt",149);
  hangul.combine.tb(318,313)(whatever,tvixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu-eu
begintsuglyph("uni1196.nt",150);
  hangul.combine.tb(318,318)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yi-u
begintsuglyph("uni1197.nt",151);
  hangul.combine.tb(319,313)(440,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-a
begintsuglyph("uni1198.nt",152);
  hangul.combine.lr(320,300)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-ya
begintsuglyph("uni1199.nt",153);
  hangul.combine.lr(320,302)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-o
begintsuglyph("uni119A.nt",154);
  hangul.combine.tb(320,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-u
begintsuglyph("uni119B.nt",155);
  hangul.combine.tb(320,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-eu
begintsuglyph("uni119C.nt",156);
  hangul.combine.tb(320,318)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-araea
begintsuglyph("uni119D.nt",157);
  hangul.combine.tb(320,428)(441,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea
begintsuglyph("uni119E.nt",158);
  hangul.jamo.araea(428,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea-eo
begintsuglyph("uni119F.nt",159);
  hangul.combine.lr(428,304)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea-u
begintsuglyph("uni11A0.nt",160);
  hangul.combine.tb(428,313)(whatever,tvixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea-i
begintsuglyph("uni11A1.nt",161);
  hangul.combine.lr(428,320)(427,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ssangaraea
begintsuglyph("uni11A2.nt",162);
  hangul.combine.lr(428,428)(whatever,
    hxf_inout(5,vixf,voxf),voxf);
  tsu_render;
endtsuglyph;

% hangul vowel a-eu
begintsuglyph("uni11A3.nt",163);
  hangul.combine.tb(300,318)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel ya-u
begintsuglyph("uni11A4.nt",164);
  hangul.combine.tb(302,313)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yeo-ya
begintsuglyph("uni11A5.nt",165);
  hangul.combine.lr(306,302)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-ya
begintsuglyph("uni11A6.nt",166);
  hangul.combine.lr(308,302)(442,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-yae
begintsuglyph("uni11A7.nt",167);
  hangul.combine.lr(308,303)(443,vixf,voxf);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
