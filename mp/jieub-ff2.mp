%
% Unicode page FF2 (alternate glyphs for vowel jamo) for Jieubsida
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

% This file covers vowel jamo for the "empty tail" layouts (layouts 3, 4,
% and 5).  Consonant bug letters for layout 0, formerly on this page, have
% been moved to page FF7 because we ran out of space here on FF2.  These are
% private-use code points and have no stability guarantees anyway.

transform lixf,loxf,vixf,tvixf,voxf;

lixf=loxf=hxf((50,850),(700,525));
vixf=hxf((700,275),(950,-50));
tvixf=hxf((700,335),(950,-50));
voxf=identity;

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
  hangul.combine.tb(308,308)(444,vixf,voxf);
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

% HANGUL JUNGSEONG (VOWEL) JAMO EXTENSION B

% hangul vowel o-yeo
begintsuglyph("uniD7B0.nt",176);
  hangul.combine.lr(308,306)(444,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel o-o-i
begintsuglyph("uniD7B1.nt",177);
  hangul.jamo.ooi(445,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-a
begintsuglyph("uniD7B2.nt",178);
  hangul.combine.lr(312,300)(446,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-ae
begintsuglyph("uniD7B3.nt",179);
  hangul.combine.lr(312,301)(447,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yo-eo
begintsuglyph("uniD7B4.nt",180);
  hangul.combine.lr(312,304)(448,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-yeo
begintsuglyph("uniD7B5.nt",181);
  hangul.combine.lr(313,306)(449,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel u-i-i
begintsuglyph("uniD7B6.nt",182);
  hangul.combine.lr(313,464)(450,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-ae
begintsuglyph("uniD7B7.nt",183);
  hangul.combine.lr(317,301)(451,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel yu-o
begintsuglyph("uniD7B8.nt",184);
  hangul.combine.tb(317,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu-a
begintsuglyph("uniD7B9.nt",185);
  hangul.combine.lr(318,300)(453,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu-eo
begintsuglyph("uniD7BA.nt",186);
  hangul.combine.lr(318,304)(454,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu-e
begintsuglyph("uniD7BB.nt",187);
  hangul.combine.lr(318,305)(455,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel eu-o
begintsuglyph("uniD7BC.nt",188);
  hangul.combine.tb(318,308)(whatever,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-ya-o
begintsuglyph("uniD7BD.nt",189);
  hangul.combine.tb(467,308)(457,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-yae
begintsuglyph("uniD7BE.nt",190);
  hangul.combine.lr(320,303)(458,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-yeo
begintsuglyph("uniD7BF.nt",191);
  hangul.combine.lr(320,306)(459,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-ye
begintsuglyph("uniD7C0.nt",192);
  hangul.combine.lr(320,307)(460,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-o-i
begintsuglyph("uniD7C1.nt",193);
  hangul.combine.tb(320,468)(461,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-yo
begintsuglyph("uniD7C2.nt",194);
  hangul.combine.tb(320,312)(462,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-yu
begintsuglyph("uniD7C3.nt",195);
  hangul.combine.tb(320,317)(463,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel i-i
begintsuglyph("uniD7C4.nt",196);
  hangul.combine.lr(320,320)(464,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea-a
begintsuglyph("uniD7C5.nt",197);
  hangul.combine.lr(428,300)(465,vixf,voxf);
  tsu_render;
endtsuglyph;

% hangul vowel araea-e
begintsuglyph("uniD7C6.nt",198);
  hangul.combine.lr(428,305)(466,vixf,voxf);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
