%
% Radicals for top (often special forms of other radicals)
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

inclusion_lock(toprad);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.toprad.alt_sparkle_three =
  push_pbox_toexpand("kanji.toprad.alt_sparkle_three");
  push_stroke((220,810)..(270,450)..(300,90),
    (1.2,1.2)--(1.5,1.5)--(1.7,1.7));
  push_stroke((420,900)..(470,540)..(500,180),
    (1.2,1.2)--(1.5,1.5)--(1.7,1.7));
  push_stroke((780,870)--(670,0),(1.7,1.7)--(1.3,1.3));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.toprad.bamboo =
  push_pbox_toexpand("kanji.toprad.bamboo");
  push_stroke((250,780)..(190,590)..(70,420),
    (1.7,1.7)--(1.6,1.6)--(1.2,1.2));
  set_boserif(0,0,10);
  push_stroke((190,590)--(490,590),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((270,590)..tension 1.2..(360,480)..(390,370),
    (1.1,1.1)--(1.5,1.5)--(1.7,1.7));
  push_stroke((650,780)..(590,590)..(480,440),
    (1.7,1.7)--(1.6,1.6)--(1.2,1.2));
  set_boserif(0,0,10);
  push_stroke((590,590)--(930,590),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((680,590)..tension 1.2..(770,480)..(800,370),
    (1.1,1.1)--(1.5,1.5)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.toprad.blue =
  push_pbox_toexpand("kanji.toprad.blue");
  push_stroke((120,560)--(880,560),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,780)--(500,40),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((160,310)--(840,310),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((80,40)--(920,40),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.toprad.cave =
  push_pbox_toexpand("kanji.toprad.cave");
  build_kanji.level(build_kanji.tb(400,360)
    (kanji.radical.silly_hat)
    (kanji.radical.legs));
  expand_pbox;
enddef;

vardef kanji.toprad.grass =
  push_pbox_toexpand("kanji.toprad.grass");
  push_stroke((350,800)--(350,-30),
    (1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((650,800)--(650,-30),
    (1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((100,400)--(900,400),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.toprad.once_upon_a_time =
  push_pbox_toexpand("kanji.toprad.once_upon_a_time");
  perl_structure:=perl_structure&"'eids.u2FF1.u8279.u4E00',";
  build_kanji.sscale(xscaled 0.8)(kanji.toprad.grass);
  tsu_xform(identity shifted (0,-420))(kanji.grone.one);
  expand_pbox;
enddef;

vardef kanji.toprad.pleasure =
  push_pbox_toexpand("kanji.toprad.pleasure");
  build_kanji.level(build_kanji.tb(540,32)
    (kanji.grone.ten)
    (build_kanji.sscale(xscaled 0.9)(kanji.grthree.bean)));
  expand_pbox;
enddef;

vardef kanji.toprad.rain =
  push_pbox_toexpand("kanji.toprad.rain");
  push_stroke((120,720)--(880,720),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,720)--(500,30),(1.6,1.6)--(1.5,1.5));
  push_stroke((100,150)..(100+50*mincho,400)..(100+70*mincho,540)--
      (900,540)..(900-40*mincho,275)..(900-70*mincho,150),
    (1.7,1.7)--(1.6,1.6)--(1.4,1.4)--
      (1.7,1.7)--(1.6,1.6)--(1.4,1.4));
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_boserif(0,3,4);
  push_stroke((230,380)..(400,380),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  set_bosize(0,80);
  push_stroke(get_strokep(0) shifted (350,0),get_strokeq(0));
  set_boserif(0,1,9);
  set_bosize(0,80);
  push_stroke(get_strokep(-1) shifted (0,-220),get_strokeq(-1));
  set_boserif(0,1,9);
  set_bosize(0,80);
  push_stroke(get_strokep(-2) shifted (350,-220),get_strokeq(-2));
  set_boserif(0,1,9);
  set_bosize(0,80);
  expand_pbox;
enddef;

vardef kanji.toprad.ridiculous_hat =
  push_pbox_toexpand("kanji.toprad.ridiculous_hat");
  build_kanji.level(build_kanji.tb(620,156)
    (kanji.toprad.sparkle_three)
    (build_kanji.tb(600,410)
       (kanji.radical.conservative_hat)
       (build_kanji.sscale(xyscaled (0.8,0.64) shifted (0,-120))
         (kanji.grone.mouth))));
  expand_pbox;
enddef;

vardef kanji.toprad.sheep =
  push_pbox_toexpand("kanji.toprad.sheep");
  kanji.grthree.sheep;
  replace_strokep(0)
    ((point 0 of oldp)--(oldp intersectionpoint get_strokep(-3)));
  expand_pbox;
enddef;

vardef kanji.toprad.sparkle_four =
  push_pbox_toexpand("kanji.toprad.sparkle_four");
  push_stroke((150,600)..tension 1.2..(200,440)..(270,160),
    (1,1)--(1.3,1.3)--(1.9,1.9));
  push_stroke((390,780)--(390,-20),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((610,780)--(610,-20),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((840,620)..tension 1.2..(780,370)..(720,170),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.toprad.sparkle_three =
  push_pbox_toexpand("kanji.toprad.sparkle_three");
  kanji.toprad.sparkle_two;
  push_stroke((500,780)--(500,-20),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.toprad.sparkle_two =
  push_pbox_toexpand("kanji.toprad.sparkle_two");
  push_stroke((200,600)..tension 1.2..(250,440)..(320,160),
    (1,1)--(1.3,1.3)--(1.9,1.9));
  push_stroke((790,620)..tension 1.2..(730,370)..(670,170),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3));
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.toprad.stand_up =
  push_pbox_toexpand("kanji.toprad.stand_up");
  push_stroke((500,810)--(500,510),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke((120,510)--(880,510),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((250,430)..tension 1.2..(320,220)..(380,90),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  push_stroke((750,450)..tension 1.2..(660,220)..(580,60),
    (1.6,1.6)--(1.5,1.5)--(1.3,1.3));
  set_boserif(0,0,10);
  push_stroke((70,0)--(930,0),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;
