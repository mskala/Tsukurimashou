%
% Unicode page 8B (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013, 2014  Matthew Skala
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
input bkencl.mp;
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradeten.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.deliberation =
  push_pbox_toexpand("kanji.grfour.deliberation");
  build_kanji.level(build_kanji.lr(420,-30)
    (kanji.grtwo.word)
    (kanji.grfive.righteousness));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.lecture =
  push_pbox_toexpand("kanji.grfive.lecture");
  build_kanji.level(build_kanji.lr(400,-10)
    (kanji.grtwo.word)
    (kanji.rare.inner_palace));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.conspire =
  push_pbox_toexpand("kanji.greight.conspire");
  build_kanji.level(build_kanji.lr(420,0)
    (kanji.grtwo.word)
    (kanji.greight.a_certain));
  expand_pbox;
enddef;

vardef kanji.greight.riddle =
  push_pbox_toexpand("kanji.greight.riddle");
  build_kanji.level(build_kanji.lr(380,0)
    (kanji.grtwo.word)
    (kanji.grfive.hesitate));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.history =
  push_pbox_toexpand("kanji.grnine.history");
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.grfour.stomach));
  expand_pbox;
enddef;

vardef kanji.grnine.praise =
  push_pbox_toexpand("kanji.grnine.praise");
  build_kanji.level(build_kanji.lr(430,-20)
    (kanji.grtwo.word)
    (kanji.grfive.approve));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bou/haka "conspire"
begintsuglyph("uni8B00",0);
  kanji.greight.conspire;
  tsu_render;
endtsuglyph;

% i "history"
begintsuglyph("uni8B02",2);
  kanji.grnine.history;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B03",3);
  build_kanji.level(build_kanji.lr(410,-10)
    (kanji.grtwo.word)
    (build_kanji.sscale(yscaled 0.96)(kanji.grtwo.star)));
  tsu_render;
endtsuglyph;

% extra "carol"
begintsuglyph("uni8B0C",12);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (kanji.rare.big_brother));
  tsu_render;
endtsuglyph;

% mei/nazo "riddle"
begintsuglyph("uni8B0E",14);
  kanji.greight.riddle;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B12",18);
  build_kanji.level(build_kanji.lr(400,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(yscaled 0.96)(kanji.grfour.warehouse)));
  tsu_render;
endtsuglyph;

% kou "lecture"
begintsuglyph("uni8B1B",27);
  kanji.grfive.lecture;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B1C",28);
  build_kanji.level(build_kanji.lr(380,0)
    (kanji.grtwo.word)
    (kanji.grtwo.field));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B1E",30);
  build_kanji.level(build_kanji.lr(400,-20)
    (kanji.grtwo.word)
    (kanji.grtwo.high));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B24",36);
  build_kanji.level(build_kanji.lr(410,-20)
    (kanji.grtwo.word)
    (build_kanji.sscale(yscaled 0.96 shifted (0,-30))(kanji.grfour.ticket)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B2A",42);
  build_kanji.level(build_kanji.lr(360,-20)
    (kanji.grtwo.word)
    (kanji.grthree.commerce));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B2E",46);
  build_kanji.level(build_kanji.lr(410,-20)
    (kanji.grtwo.word)
    (kanji.grfive.blame));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B30",48);
  build_kanji.level(build_kanji.lr(380,0)
    (kanji.grtwo.word)
    (kanji.grfour.bring));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B35",53);
  build_kanji.level(build_kanji.lr(410,-20)
    (kanji.grtwo.word)
    (kanji.grthree.learn));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B3B",59);
  build_kanji.level(build_kanji.lcr(320,-20)(630,0)
    (kanji.grtwo.word)
    (kanji.leftrad.two_branch_tree)
    (build_kanji.sscale(yscaled 0.96 shifted (0,-20))(kanji.grtwo.many)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B3F",63);
  build_kanji.level(build_kanji.lr(360,30)
    (kanji.grtwo.word)
    (kanji.grtwo.morning));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B46",70);
  build_kanji.lr(430,20-20*mincho)
    (kanji.grtwo.word)
    (build_kanji.sscale(shifted (0,20))(kanji.grfour.pleasure));
  tsu_render;
endtsuglyph;

% extra "certificate"
begintsuglyph("uni8B49",73);
  build_kanji.level(build_kanji.lr(410,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(yscaled 0.95)(kanji.grthree.climb)));
  tsu_render;
endtsuglyph;

% extra "disparage"
begintsuglyph("uni8B4F",79);
  build_kanji.level(build_kanji.lr(380,0)
    (kanji.grtwo.word)
    (kanji.greight.how_much));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B51",81);
  build_kanji.level(build_kanji.lr(430,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(yscaled 0.94 shifted (0,-20))(kanji.grnine.boast)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B52",82);
  build_kanji.level(build_kanji.lr(430,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(yscaled 0.94 shifted (0,-30))(kanji.grtwo.ordinal)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B54",84);
  build_kanji.level(build_kanji.lr(410,-30)
    (kanji.grtwo.word)
    (build_kanji.sscale(yscaled 0.95)(kanji.grnine.southeast)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B55",85);
  build_kanji.level(build_kanji.lr(350,-20)
    (kanji.grtwo.word)
    (kanji.grfour.nothing));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B57",87);
  build_kanji.level(build_kanji.lr(380,-20)
    (kanji.grtwo.word)
    (build_kanji.sscale(shifted (0,20))(kanji.grtwo.answer)));
  tsu_render;
endtsuglyph;

% extra "false accusation"
begintsuglyph("uni8B5B",91);
  build_kanji.level(build_kanji.lr(450,0)
    (kanji.grtwo.word)
    (build_kanji.sscale(scaled 0.95)(kanji.greight.substitute)));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B68",104);
  build_kanji.level(build_kanji.lr(380,-40)
    (kanji.grtwo.word)
    (kanji.grthree.farming));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni8B69",105);
  build_kanji.level(build_kanji.lr(400,-30)
    (kanji.grtwo.word)
    (kanji.grthree.intention));
  tsu_render;
endtsuglyph;

% gi/kata "deliberation"
begintsuglyph("uni8B70",112);
  kanji.grfour.deliberation;
  tsu_render;
endtsuglyph;

% extra "study"
begintsuglyph("uni8B80",128);
  build_kanji.level(build_kanji.lr(420,-20)
    (kanji.grtwo.word)
    (kanji.grten.sell_out));
  tsu_render;
endtsuglyph;

% san/ho "praise"
begintsuglyph("uni8B83",131);
  kanji.grnine.praise;
  tsu_render;
endtsuglyph;

% extra: alternate "hen"
begintsuglyph("uni8B8A",138);
  build_kanji.level(build_kanji.tb(360,-30)
    (build_kanji.lcr(360,10)(640,10)
       (kanji.grone.thread)
       (kanji.grtwo.word)
       (kanji.grone.thread))
    (kanji.radical.winter));
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
