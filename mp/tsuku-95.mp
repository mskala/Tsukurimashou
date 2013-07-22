%
% Unicode page 95 (Kanji) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013  Matthew Skala
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
input buildkanji.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.open =
  push_pbox_toexpand("kanji.grthree.open");
  build_kanji.gate_enclose(kanji.radical.topped_aitch);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.barrier =
  push_pbox_toexpand("kanji.grfour.barrier");
  build_kanji.gate_enclose(build_kanji.sscale(xscaled 0.8)
    (kanji.leftrad.barrier));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.leisure =
  push_pbox_toexpand("kanji.greight.leisure");
  build_kanji.gate_enclose(kanji.grone.wood);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grnine.brandish =
  push_pbox_toexpand("kanji.grnine.brandish");
  build_kanji.gate_enclose(kanji.grone.person);
  expand_pbox;
enddef;

vardef kanji.grnine.leap_year =
  push_pbox_toexpand("kanji.grnine.leap_year");
  build_kanji.gate_enclose(kanji.grone.king);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.leftrad.barrier =
  push_pbox_toexpand("kanji.leftrad.barrier");
  build_kanji.tb(620,190)
    (kanji.toprad.sparkle_two)
    (kanji.leftrad.husband;
     replace_strokep(-1)(subpath
       (xpart (oldp intersectiontimes get_strokep(-3)),infinity) of oldp);
     set_boserif(-1,0,whatever));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% chou/naga "long"
begintsuglyph("uni9577",119);
  kanji.grtwo.long;
  tsu_render;
endtsuglyph;

% mon/kado "gate"
begintsuglyph("uni9580",128);
  kanji.grtwo.gate;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9582",130);
  build_kanji.gate_enclose(kanji.grone.one);
  tsu_render;
endtsuglyph;

% sen/hirame "brandish"
begintsuglyph("uni9583",131);
  kanji.grnine.brandish;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9585",133);
  build_kanji.gate_enclose(kanji.grthree.thumbtack);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9586",134);
  build_kanji.gate_enclose(kanji.grone.three);
  tsu_render;
endtsuglyph;

% hei/to "block up"
begintsuglyph("uni9587",135);
  build_kanji.gate_enclose(kanji.grone.down);
  tsu_render;
endtsuglyph;

% tsuka "choke"
begintsuglyph("uni958A",138);
  build_kanji.gate_enclose(kanji.grone.mountain);
  tsu_render;
endtsuglyph;

% kai/hira "open"
begintsuglyph("uni958B",139);
  kanji.grthree.open;
  tsu_render;
endtsuglyph;

% jun/uruu "leap year"
begintsuglyph("uni958F",143);
  kanji.grnine.leap_year;
  tsu_render;
endtsuglyph;

% kan/hima "leisure"
begintsuglyph("uni9591",145);
  kanji.greight.leisure;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9592",146);
  build_kanji.gate_enclose(kanji.grone.moon);
  tsu_render;
endtsuglyph;

% kan/aida "interval"
begintsuglyph("uni9593",147);
  kanji.grtwo.interval;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni9596",150);
  build_kanji.gate_enclose(kanji.grone.water);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni959A",154);
  build_kanji.gate_enclose(kanji.grone.stand_up);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni95A0",160);
  build_kanji.gate_enclose(kanji.grone.ball);
  tsu_render;
endtsuglyph;

% kan/seki "barrier"
begintsuglyph("uni95A2",162);
  kanji.grfour.barrier;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni95A9",169);
  build_kanji.gate_enclose(kanji.grone.bug);
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni95AB",171);
  build_kanji.gate_enclose(kanji.grsix.bothered);
  tsu_render;
endtsuglyph;

% extra en/an/oo "eunuch"
begintsuglyph("uni95B9",185);
  build_kanji.gate_enclose(kanji.grnine.suffocate);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
