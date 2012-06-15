%
% Unicode page 66 (Kanji) for Tsukurimashou
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
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradenine.mp;
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

vardef kanji.grtwo.daytime =
  push_pbox_toexpand("kanji.grtwo.daytime");
  build_kanji.level(build_kanji.sscale(yscaled 0.9 shifted (0,30))
    (build_kanji.tb(360,290)
      (build_kanji.spread_legs(280)(kanji.grsix.blowjob))
      (build_kanji.sscale(scaled 0.75)(kanji.grone.day)));
    push_stroke((90,-30)--(910,-30),(1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9));
  expand_pbox;
enddef;

vardef kanji.grtwo.fairweather =
  push_pbox_toexpand("kanji.grtwo.fairweather");
  build_kanji.lr(330,0)
    (kanji.leftrad.day)
    (kanji.grone.blue);
  expand_pbox;
enddef;

vardef kanji.grtwo.spring =
  push_pbox_toexpand("kanji.grtwo.spring");
  build_kanji.tb(320,90)
    (kanji.grone.person;
     build_kanji.sscale(xyscaled (1,0.5) shifted (0,30))
       (kanji.grone.three);
     replace_strokep(-3)
       (subpath (xpart (oldp intersectiontimes get_strokep(-1)),infinity)
        of oldp))
    (build_kanji.sscale(xscaled 0.8 shifted (10,0))
      (kanji.grone.day));
  expand_pbox;
enddef;

vardef kanji.grtwo.star =
  push_pbox_toexpand("kanji.grtwo.star");
  build_kanji.sscale(xscaled 1.07)(build_kanji.tb(420,0)
    (kanji.grone.day)
    (kanji.grone.life));
  expand_pbox;
enddef;

vardef kanji.grtwo.time =
  push_pbox_toexpand("kanji.grtwo.time");
  build_kanji.lr(330,0)
    (kanji.leftrad.day)
    (kanji.grtwo.temple);
  expand_pbox;
enddef;

vardef kanji.grtwo.day_of_week =
  push_pbox_toexpand("kanji.grtwo.day_of_week");
  build_kanji.level(build_kanji.lr(330,0)
    (kanji.leftrad.day)
    (build_kanji.tb(480,0)
       (build_kanji.lr(520,-10)
          (build_kanji.sscale(scaled 0.9)
             (kanji.radical.pigs_head))
          (build_kanji.sscale(scaled 0.9)
             (kanji.radical.pigs_head)))
       (kanji.radical.old_bird)));
  expand_pbox;
enddef;

% "write" is a reserved word
vardef kanji.grtwo.writing =
  push_pbox_toexpand("kanji.grtwo.writing");
  build_kanji.tb(250,0)
    (kanji.radical.brush;
     replace_strokep(-5)((point 0 of oldp)--
       (oldp intersectionpoint get_strokep(0))))
    (kanji.grone.day);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.dark =
  push_pbox_toexpand("kanji.grthree.dark");
  build_kanji.lr(330,0)
    (kanji.leftrad.day)
    (kanji.grone.noise);
  expand_pbox;
enddef;

vardef kanji.grthree.heat =
  push_pbox_toexpand("kanji.grthree.heat");
  build_kanji.tb(520,0)
    (kanji.grone.day)
    (kanji.grthree.person);
  expand_pbox;
enddef;

vardef kanji.grthree.shining =
  push_pbox_toexpand("kanji.grthree.shining");
  build_kanji.lr(330,0)
    (kanji.leftrad.day)
    (kanji.greight.call);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.easy =
  push_pbox_toexpand("kanji.grfive.easy");
  build_kanji.tb(480,0)
    (tsu_xform(identity shifted (30,0))(kanji.grone.day))
    (kanji.grnine.must_not);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mei/aka "light"
begintsuglyph("uni660E",14);
  kanji.grtwo.light;
  tsu_render;
endtsuglyph;

% eki/yasi/yasu "easy"
begintsuglyph("uni6613",19);
  kanji.grfive.easy;
  tsu_render;
endtsuglyph;

% seki/mukashi "once upon a time"
begintsuglyph("uni6614",20);
  kanji.grthree.once_upon_a_time;
  tsu_render;
endtsuglyph;

% you "sun" or "open" (rare, but part of other chars)
begintsuglyph("uni661C",28);
  kanji.rare.sun;
  tsu_render;
endtsuglyph;

% sei/hoshi "star"
begintsuglyph("uni661F",31);
  kanji.grtwo.star;
  tsu_render;
endtsuglyph;

% shun/haru "spring (season)"
begintsuglyph("uni6625",37);
  kanji.grtwo.spring;
  tsu_render;
endtsuglyph;

% shou "shining"
begintsuglyph("uni662D",45);
  kanji.grthree.shining;
  tsu_render;
endtsuglyph;

% ze/kore "righteousness"
begintsuglyph("uni662F",47);
  kanji.greight.righteousness;
  tsu_render;
endtsuglyph;

% chuu/hiro "daytime"
begintsuglyph("uni663C",60);
  kanji.grtwo.daytime;
  tsu_render;
endtsuglyph;

% jo/toki "time"
begintsuglyph("uni6642",66);
  kanji.grtwo.time;
  tsu_render;
endtsuglyph;

% sei/ha "fair or clear weather"
begintsuglyph("uni6674",116);
  kanji.grtwo.fairweather;
  tsu_render;
endtsuglyph;

% sho/atsu "heat"
begintsuglyph("uni6691",145);
  kanji.grthree.heat;
  tsu_render;
endtsuglyph;

% an/kura "dark"
begintsuglyph("uni6697",151);
  kanji.grthree.dark;
  tsu_render;
endtsuglyph;

% you "day of week"
begintsuglyph("uni66DC",220);
  kanji.grtwo.day_of_week;
  tsu_render;
endtsuglyph;

% kyoku/ma "melody"
begintsuglyph("uni66F2",242);
  kanji.grthree.melody;
  tsu_render;
endtsuglyph;

% sho/ka "writing"
begintsuglyph("uni66F8",248);
  kanji.grtwo.writing;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
