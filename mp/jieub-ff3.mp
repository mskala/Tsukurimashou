%
% Unicode page FF3 (alternate lead jamo) for Jieubsida
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

% This file contains leads for layouts 1 and 3: vertical vowel and nonempty
% tail, or vertical and horizontal vowel with empty tail.

transform lixf,loxf;

lixf=loxf=hxf((50,850),(700,325));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HANGUL CHOSEONG (LEAD) JAMO

tsu_rescale_native_zero;

% hangul lead kiyeok
begintsuglyph("uni1100.lj1",0);
  hangul.jamo.kiyeok(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangkiyeok
begintsuglyph("uni1101.lj1",1);
  hangul.combine.lr(100,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun
begintsuglyph("uni1102.lj1",2);
  hangul.jamo.nieun(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut
begintsuglyph("uni1103.lj1",3);
  hangul.jamo.tikeut(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangtikeut
begintsuglyph("uni1104.lj1",4);
  hangul.combine.lr(203,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul
begintsuglyph("uni1105.lj1",5);
  hangul.jamo.rieul(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum
begintsuglyph("uni1106.lj1",6);
  hangul.jamo.mieum(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup
begintsuglyph("uni1107.lj1",7);
  hangul.jamo.pieup(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangpieup
begintsuglyph("uni1108.lj1",8);
  hangul.combine.lr(207,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios
begintsuglyph("uni1109.lj1",9);
  hangul.jamo.sjc(0,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangsios
begintsuglyph("uni110A.lj1",10);
  hangul.combine.lr(209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung
begintsuglyph("uni110B.lj1",11);
  hangul.jamo.ieung(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead cieuc
begintsuglyph("uni110C.lj1",12);
  hangul.jamo.sjc(1,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangcieuc
begintsuglyph("uni110D.lj1",13);
  hangul.combine.lr(212,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch
begintsuglyph("uni110E.lj1",14);
  hangul.jamo.sjc(2,0,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead khieukh
begintsuglyph("uni110F.lj1",15);
  hangul.jamo.khieukh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead thieuth
begintsuglyph("uni1110.lj1",16);
  hangul.jamo.thieuth(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead phieuph
begintsuglyph("uni1111.lj1",17);
  hangul.jamo.phieuph(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead hieuh
begintsuglyph("uni1112.lj1",18);
  hangul.jamo.hieuh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-kiyeok
begintsuglyph("uni1113.lj1",19);
  hangul.combine.lr(202,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangnieun
begintsuglyph("uni1114.lj1",20);
  hangul.combine.lr(202,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-tikeut
begintsuglyph("uni1115.lj1",21);
  hangul.combine.lr(202,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-pieup
begintsuglyph("uni1116.lj1",22);
  hangul.combine.lr(202,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-kiyeok
begintsuglyph("uni1117.lj1",23);
  hangul.combine.lr(103,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-nieun
begintsuglyph("uni1118.lj1",24);
  hangul.combine.lr(205,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangrieul
begintsuglyph("uni1119.lj1",25);
  hangul.combine.lr(205,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead rieul-hieuh
begintsuglyph("uni111A.lj1",26);
  hangul.combine.lr(205,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounrieul
begintsuglyph("uni111B.lj1",27);
  hangul.combine.tb(105,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead mieum-pieup
begintsuglyph("uni111C.lj1",28);
  hangul.combine.lr(106,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounmieum
begintsuglyph("uni111D.lj1",29);
  hangul.combine.tb(106,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-kiyeok
begintsuglyph("uni111E.lj1",30);
  hangul.combine.lr(107,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-nieun
begintsuglyph("uni111F.lj1",31);
  hangul.combine.lr(207,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-tikeut
begintsuglyph("uni1120.lj1",32);
  hangul.combine.lr(207,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios
begintsuglyph("uni1121.lj1",33);
  hangul.combine.lr(107,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-kiyeok
begintsuglyph("uni1122.lj1",34);
  hangul.combine.lcr(107,109,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-tikeut
begintsuglyph("uni1123.lj1",35);
  hangul.combine.lcr(107,209,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-pieup
begintsuglyph("uni1124.lj1",36);
  hangul.combine.lcr(107,209,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-ssangsios
begintsuglyph("uni1125.lj1",37);
  hangul.combine.lcr(107,209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-sios-cieuc
begintsuglyph("uni1126.lj1",38);
  hangul.combine.lcr(107,209,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-cieuc
begintsuglyph("uni1127.lj1",39);
  hangul.combine.lr(207,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-chieuch
begintsuglyph("uni1128.lj1",40);
  hangul.combine.lr(207,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-thieuth
begintsuglyph("uni1129.lj1",41);
  hangul.combine.lr(207,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pieup-phieuph
begintsuglyph("uni112A.lj1",42);
  hangul.combine.lr(207,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounpieup
begintsuglyph("uni112B.lj1",43);
  hangul.combine.tb(107,521)(whatever,
    hxf((200,850),(800,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounssangpieup
begintsuglyph("uni112C.lj1",44);
  hangul.combine.tb(108,521)(whatever,
    hxf((150,850),(850,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-kiyeok
begintsuglyph("uni112D.lj1",45);
  hangul.combine.lr(109,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-nieun
begintsuglyph("uni112E.lj1",46);
  hangul.combine.lr(209,102)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-tikeut
begintsuglyph("uni112F.lj1",47);
  hangul.combine.lr(209,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-rieul
begintsuglyph("uni1130.lj1",48);
  hangul.combine.lr(209,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-mieum
begintsuglyph("uni1131.lj1",49);
  hangul.combine.lr(209,106)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-pieup
begintsuglyph("uni1132.lj1",50);
  hangul.combine.lr(209,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-pieup-kiyeok
begintsuglyph("uni1133.lj1",51);
  hangul.combine.lcr(209,207,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-sios-sios
begintsuglyph("uni1134.lj1",52);
  hangul.combine.lcr(209,209,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-ieung
begintsuglyph("uni1135.lj1",53);
  hangul.combine.lr(109,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-cieuc
begintsuglyph("uni1136.lj1",54);
  hangul.combine.lr(209,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-chieuch
begintsuglyph("uni1137.lj1",55);
  hangul.combine.lr(209,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-khieukh
begintsuglyph("uni1138.lj1",56);
  hangul.combine.lr(209,115)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-thieuth
begintsuglyph("uni1139.lj1",57);
  hangul.combine.lr(209,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-phieuph
begintsuglyph("uni113A.lj1",58);
  hangul.combine.lr(209,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead sios-hieuh
begintsuglyph("uni113B.lj1",59);
  hangul.combine.lr(209,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumsios
begintsuglyph("uni113C.lj1",60);
  hangul.jamo.sjc(0,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumssangsios
begintsuglyph("uni113D.lj1",61);
  hangul.combine.lr(223,222)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumsios
begintsuglyph("uni113E.lj1",62);
  hangul.jamo.sjc(0,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumssangsios
begintsuglyph("uni113F.lj1",63);
  hangul.combine.lr(224,225)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead pansios
begintsuglyph("uni1140.lj1",64);
  hangul.jamo.pansios(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-kiyeok
begintsuglyph("uni1141.lj1",65);
  hangul.combine.lr(111,100)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-tikeut
begintsuglyph("uni1142.lj1",66);
  hangul.combine.lr(111,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-mieum
begintsuglyph("uni1143.lj1",67);
  hangul.combine.lr(111,106)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-pieup
begintsuglyph("uni1144.lj1",68);
  hangul.combine.lr(111,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-sios
begintsuglyph("uni1145.lj1",69);
  hangul.combine.lr(111,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-pansios
begintsuglyph("uni1146.lj1",70);
  hangul.combine.lr(111,219)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssangieung
begintsuglyph("uni1147.lj1",71);
  hangul.combine.lr(111,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-cieuc
begintsuglyph("uni1148.lj1",72);
  hangul.combine.lr(111,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-chieuch
begintsuglyph("uni1149.lj1",73);
  hangul.combine.lr(111,114)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-theiuth
begintsuglyph("uni114A.lj1",74);
  hangul.combine.lr(111,116)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ieung-phieuph
begintsuglyph("uni114B.lj1",75);
  hangul.combine.lr(111,117)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead yesieung
begintsuglyph("uni114C.lj1",76);
  hangul.jamo.yesieung(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead cieuc-ieung
begintsuglyph("uni114D.lj1",77);
  hangul.combine.lr(112,111)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumcieuc
begintsuglyph("uni114E.lj1",78);
  hangul.jamo.sjc(1,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumssangcieuc
begintsuglyph("uni114F.lj1",79);
  hangul.combine.lr(227,226)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumcieuc
begintsuglyph("uni1150.lj1",80);
  hangul.jamo.sjc(1,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumssangcieuc
begintsuglyph("uni1151.lj1",81);
  hangul.combine.lr(228,229)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch-khieukh
begintsuglyph("uni1152.lj1",82);
  hangul.combine.lcr(214,230,115)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chieuch-hieuh
begintsuglyph("uni1153.lj1",83);
  hangul.combine.lcr(214,230,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead chitueumcieuc
begintsuglyph("uni1154.lj1",84);
  hangul.jamo.sjc(2,1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ceongchieumcieuc
begintsuglyph("uni1155.lj1",85);
  hangul.jamo.sjc(2,-1,false)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead phieuph-pieup
begintsuglyph("uni1156.lj1",86);
  hangul.combine.lr(117,107)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kapyeounphieuph
begintsuglyph("uni1157.lj1",87);
  hangul.combine.tb(117,521)(whatever,
    hxf((250,850),(850,-50)) transformed lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead ssanghieuh
begintsuglyph("uni1158.lj1",88);
  hangul.combine.lcr(118,230,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead yeorinhieuh
begintsuglyph("uni1159.lj1",89);
  hangul.jamo.yeorinhieuh(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead kiyeok-tikeut
begintsuglyph("uni115A.lj1",90);
  hangul.combine.lr(100,103)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-sios
begintsuglyph("uni115B.lj1",91);
  hangul.combine.lr(202,109)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-cieuc
begintsuglyph("uni115C.lj1",92);
  hangul.combine.lr(202,112)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead nieun-hieuh
begintsuglyph("uni115D.lj1",93);
  hangul.combine.lr(202,118)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

% hangul lead tikeut-rieul
begintsuglyph("uni115E.lj1",94);
  hangul.combine.lr(203,105)(whatever,lixf,loxf);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
