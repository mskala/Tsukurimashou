%
% Unicode page 7F (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2017  Matthew Skala
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
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.beauty =
  push_pbox_toexpand("kanji.grthree.beauty");
  build_kanji.level(build_kanji.tb(360,200)
    (kanji.toprad.sheep)
    (kanji.grone.big;
     replace_strokep(-1)(oldp shifted (-10,0))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.leave_behind =
  push_pbox_toexpand("kanji.grfour.leave_behind");
  build_kanji.tb(640,40)
    (build_kanji.sscale(scaled 0.84)(kanji.toprad.eye))
    (kanji.grtwo.straight);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.group =
  push_pbox_toexpand("kanji.grfive.group");
  build_kanji.lr(480,0)
    (kanji.grthree.junior)
    (kanji.grthree.sheep);
  expand_pbox;
enddef;

vardef kanji.grfive.wrongdoing =
  push_pbox_toexpand("kanji.grfive.wrongdoing");
  build_kanji.level(build_kanji.tb(640,0)
    (kanji.toprad.eye)
    (kanji.grfive.mistake));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kan/kama "tin can"
begintsuglyph("uni7F36",54);
  kanji.greight.tin_can;
  tsu_render;
endtsuglyph;

% extra: fu/usagiami "rabbit catching net"
begintsuglyph("uni7F58",88);
  build_kanji.tb(600,-60)
    (kanji.toprad.eye)
    (kanji.grfour.non);
  tsu_render;
endtsuglyph;

% zai/tsumi "wrongdoing"
begintsuglyph("uni7F6A",106);
  kanji.grfive.wrongdoing;
  tsu_render;
endtsuglyph;

% chi/o "desert" or "leave behind"
begintsuglyph("uni7F6E",110);
  kanji.grfour.leave_behind;
  tsu_render;
endtsuglyph;

% you/hitsuji "sheep"
begintsuglyph("uni7F8A",138);
  kanji.grthree.sheep;
  tsu_render;
endtsuglyph;

% bi/utsuku "beauty"
begintsuglyph("uni7F8E",142);
  kanji.grthree.beauty;
  tsu_render;
endtsuglyph;

% gun/mure "group"
begintsuglyph("uni7FA4",164);
  kanji.grfive.group;
  tsu_render;
endtsuglyph;

% gi/tagashi "righteousness"
begintsuglyph("uni7FA9",169);
  kanji.grfive.righteousness;
  tsu_render;
endtsuglyph;

% u/hane "feather"
begintsuglyph("uni7FBD",189);
  kanji.grtwo.feather;
  tsu_render;
endtsuglyph;

% shuu/nara "learn"
begintsuglyph("uni7FD2",210);
  kanji.grthree.learn;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
