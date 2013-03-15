%
% Unicode page 79 (Kanji) for Tsukurimashou
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
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradenine.mp;
input gradeone.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.autumn =
  push_pbox_toexpand("kanji.grtwo.autumn");
  build_kanji.lr(450,120)
    (kanji.leftrad.two_branch_tree)
    (kanji.grone.fire);
  expand_pbox;
enddef;

vardef kanji.grtwo.company =
  push_pbox_toexpand("kanji.grtwo.company");
  build_kanji.lr(450,120)
    (kanji.leftrad.showing)
    (kanji.grone.earth);
  expand_pbox;
enddef;

vardef kanji.grtwo.department =
  push_pbox_toexpand("kanji.grtwo.department");
  build_kanji.lr(470,90)
    (build_kanji.lift_skirt(300,140)
       (kanji.leftrad.two_branch_tree);
     replace_strokep(-4)((point 0 of oldp)..(xpart point 1 of oldp,-50)))
    (kanji.greight.dipper);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.ceremony =
  push_pbox_toexpand("kanji.grthree.ceremony");
  build_kanji.lr(540,-30)
    (kanji.leftrad.showing)
    (push_stroke((120,810),(1.6,1.6));
     set_boserif(0,0,10);
     build_kanji.add_ltail(0));
  expand_pbox;
enddef;

vardef kanji.grthree.deity =
  push_pbox_toexpand("kanji.grthree.deity");
  build_kanji.lr(450,40)
    (kanji.leftrad.showing)
    (kanji.grthree.have_honour);
  expand_pbox;
enddef;

vardef kanji.grthree.good_luck =
  push_pbox_toexpand("kanji.grthree.deity");
  build_kanji.lr(450,20)
    (kanji.leftrad.showing)
    (kanji.rare.roll_of_cloth);
  expand_pbox;
enddef;

vardef kanji.grthree.second_of_time =
  push_pbox_toexpand("kanji.grthree.second_of_time");
  build_kanji.level(build_kanji.lr(470,40)
    (build_kanji.lift_skirt(300,140)
       (kanji.leftrad.two_branch_tree))
    (kanji.grtwo.little));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.celebrate =
  push_pbox_toexpand("kanji.grfour.celebrate");
  build_kanji.lr(450,20)
    (kanji.leftrad.showing)
    (kanji.grtwo.big_brother);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grsix.i =
  push_pbox_toexpand("kanji.grsix.i");
  build_kanji.lr(520,60)
    (kanji.leftrad.two_branch_tree)
    (kanji.radical.mu);
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ji/shime "show" (also older radical form)
begintsuglyph("uni793A",58);
  kanji.grfive.showing;
  tsu_render;
endtsuglyph;

% "showing" radical (simple, more popular form)
begintsuglyph("uni793B",59);
  kanji.leftrad.showing;
  tsu_render;
endtsuglyph;

% rei "ceremony"
begintsuglyph("uni793C",60);
  kanji.grthree.ceremony;
  tsu_render;
endtsuglyph;

% sha/yashiro "company"
begintsuglyph("uni793E",62);
  kanji.grtwo.company;
  tsu_render;
endtsuglyph;

% shin/kami "deity"
begintsuglyph("uni795E",94);
  kanji.grthree.deity;
  tsu_render;
endtsuglyph;

% shuku/iwa "celebrate"
begintsuglyph("uni795D",93);
  kanji.grfour.celebrate;
  tsu_render;
endtsuglyph;

% sei/matsuri "festival"
begintsuglyph("uni796D",109);
  kanji.grthree.festival;
  tsu_render;
endtsuglyph;

% fuku/toshi "good luck"
begintsuglyph("uni798F",143);
  kanji.grthree.good_luck;
  tsu_render;
endtsuglyph;

% ka/ine little meaning by itself, called "two-branch tree" as a radical
begintsuglyph("uni79BE",190);
  kanji.grnine.two_branch_tree;
  tsu_render;
endtsuglyph;

% shi/watashi "first person pronoun"
begintsuglyph("uni79C1",193);
  kanji.grsix.i;
  tsu_render;
endtsuglyph;

% shuu/aki "autumn"
begintsuglyph("uni79CB",203);
  kanji.grtwo.autumn;
  tsu_render;
endtsuglyph;

% ka "department"
begintsuglyph("uni79D1",209);
  kanji.grtwo.department;
  tsu_render;
endtsuglyph;

% byou "second of time"
begintsuglyph("uni79D2",210);
  kanji.grthree.second_of_time;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
