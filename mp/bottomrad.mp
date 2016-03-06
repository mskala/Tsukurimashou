%
% Radicals for bottom (often special forms of other radicals)
% Copyright (C) 2011, 2012, 2013, 2016  Matthew Skala
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

inclusion_lock(bottomrad);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.bottomrad.clothes = 
  push_pbox_toexpand("kanji.bottomrad.clothes");
  push_stroke((470,810)..tension 1.2..(340,650)..(80,510),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  push_stroke((point 1 of get_strokep(0))--
      (xpart point 1 of get_strokep(0),0),
    (1.5,1.5)--(1.4,1.4));
  push_stroke((510,80)..tension 1.2..(point 1 of get_strokep(0))..(130,-40),
    (1,1)--(1.4,1.4)--(1.8,1.8));
  push_stroke((540,810)..tension 1.2..(700,240)..(890,0),
    (1,1)--(1.4,1.4)--(1.7,1.7));
  push_stroke((820,540)..tension 1.2..(720,460)..
      (point 0.69 of get_strokep(0)),
    (1.7,1.7)--(1.4,1.4)--(1.2,1.2));
  expand_pbox;
enddef;

vardef kanji.bottomrad.four_ticks =
  push_pbox_toexpand("kanji.bottomrad.four_ticks");
  push_stroke((210,750)..tension 1.2..(160,250)..(100,-30),
    (1,1)--(1.3,1.3)--(1.8,1.8));
  push_stroke((350,700)..tension 1.2..(390,300)..(400,-50),
    (1.1,1.1)--(1.4,1.4)--(1.9,1.9));
  push_stroke((540,750)..tension 1.2..(610,320)..(630,-40),
    (1.1,1.1)--(1.4,1.4)--(1.9,1.9));
  push_stroke((740,800)..tension 1.2..(850,360)..(890,-20),
    (1.1,1.1)--(1.4,1.4)--(1.9,1.9));
  expand_pbox;
enddef;

vardef kanji.bottomrad.heart =
  push_pbox_toexpand("kanji.bottomrad.heart");
  perl_structure:=perl_structure&"'eids.softhead.u5FC3',";
  tsu_xform(identity shifted (-100,0))
    (push_stroke((450,670),(1.6,1.6));
     build_kanji.add_ltail(0));
  set_boserif(0,0,10);
  push_stroke((210,540)..tension 1.2..(130,280)..(60,150),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  push_stroke((500,720)..tension 1.2..(570,520)..(600,270),
    (1,1)--(1.3,1.3)--(1.6,1.6));
  push_stroke((790,540)..tension 1.2..(880,310)..(930,130),
    (1,1)--(1.5,1.5)--(1.8,1.8));
  expand_pbox;
enddef;

vardef kanji.bottomrad.long_kimono =
  push_pbox_toexpand("kanji.bottomrad.long_kimono");
  build_kanji.box((210,760),(790,540));
  push_stroke((440,540)..tension 1.2..(330,300)..(110,80),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  push_stroke((500,540)--(500,-20),(1.6,1.6)--(1.5,1.5));
  push_stroke((500,380)..tension 1.2..(710,220)..(800,100),
    (0.9,0.9)--(1.5,1.5)--(1.9,1.9));
  push_stroke(
    (810,410)..tension 1.2..(750,340)..(point 0.8 of get_strokep(0)),
    (1.7,1.7)--(1.2,1.2)--(0.9,0.9));
  expand_pbox;
enddef;

vardef kanji.bottomrad.moon =
  push_pbox_toexpand("kanji.bottomrad.moon");
  push_stroke((250,-20)..{up}(250,760)--(750,760),
    (1.4,1.4)--(1.6,1.6)--(1.6,1.6));
  build_kanji.add_jtail(0);
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_boserif(0,1,4);
  set_boserif(0,2,4);
  push_stroke((250,520)--(750,520),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((250,270)--(750,270),
    (1.5,1.5)--(1.5,1.5));
  expand_pbox;
enddef;

% CHISE calls this CDP-8C6C, it's part of U+5547, needed for U+9069
vardef kanji.bottomrad.stalk =
  push_pbox_toexpand("kanji.bottomrad.stalk");
  kanji.radical.gmm;
  build_kanji.sscale(xyscaled (0.65,0.82))(kanji.grtwo.old);
  expand_pbox;
enddef;
