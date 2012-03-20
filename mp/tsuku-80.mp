%
% Unicode page 80 (Kanji) for Tsukurimashou
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
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input radical.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.consider =
  push_pbox_toexpand("kanji.grtwo.consider");
  kanji.radical.old_man(
    build_kanji.sscale(xyscaled (0.8,1.5) shifted (60,220))
      (push_stroke((250,500)..tension 1.2..(550,520)..(780,550+30*mincho),
         (1.5,1.5)--(1.5,1.5)--(1.9,1.9));
       push_stroke((255,535-15*mincho)..tension 1.2..(220,350)..(170,240),
         (1.7,1.7)--(1.6,1.6)--(1.6,1.6));
       set_boserif(0,0,10);
       push_stroke((get_strokep(0) intersectionpoint ((0,300)--(1000,300)))--
           (820,300)..tension 1.7..(780,150)..(650,-10)..{curl 0.1}(450,0),
         (1.6,1.6)--(1.6,1.6)--(1.5,1.5)--(1.7,1.7)--(1.8,1.8));
       set_botip(0,1,1);
       set_boserif(0,1,4)));
  expand_pbox;
enddef;

vardef kanji.grtwo.hear =
  push_pbox_toexpand("kanji.grtwo.hear");
  build_kanji.gate_enclose(kanji.grone.ear);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.raise =
  push_pbox_toexpand("kanji.grthree.raise");
  build_kanji.level(build_kanji.tb(480,-50)
    (push_stroke((500,810)--(500,560),(1.6,1.6)--(1.5,1.5));
     set_boserif(0,0,10);
     tsu_xform(identity yscaled (560/780))(kanji.radical.mu_bar))
    (kanji.bottomrad.moon));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% rou/o "old man"
begintsuglyph("uni8001",1);
  kanji.grfour.old_man;
  tsu_render;
endtsuglyph;

% "old man without a spoon" radical
begintsuglyph("uni8002",2);
  kanji.radical.old_man();
  tsu_render;
endtsuglyph;

% kou/kanga "consider"
begintsuglyph("uni8003",3);
  kanji.grtwo.consider;
  tsu_render;
endtsuglyph;

% sha/mono "person" or "thing"
begintsuglyph("uni8005",5);
  kanji.grthree.person;
  tsu_render;
endtsuglyph;

% ken/mi "ear"
begintsuglyph("uni8033",51);
  kanji.grone.ear;
  tsu_render;
endtsuglyph;

% bun/ki "hear"
begintsuglyph("uni805E",94);
  kanji.grtwo.hear;
  tsu_render;
endtsuglyph;

% brush radical
begintsuglyph("uni807F",127);
  kanji.radical.brush;
  tsu_render;
endtsuglyph;

% niku "meat"
begintsuglyph("uni8089",137);
  kanji.grtwo.meat;
  tsu_render;
endtsuglyph;

% shou/ayaka "resemblance"
begintsuglyph("uni8096",150);
  kanji.greight.resemblance;
  tsu_render;
endtsuglyph;

% iku/soda "raise"
begintsuglyph("uni80B2",178);
  kanji.grthree.raise;
  tsu_render;
endtsuglyph;

% ko/nanzo "barbarian"
begintsuglyph("uni80E1",225);
  kanji.grnine.barbarian;
  tsu_render;
endtsuglyph;

% nou/yo "talent"
begintsuglyph("uni80FD",253);
  kanji.grfive.talent;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
