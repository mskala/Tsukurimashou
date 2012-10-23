%
% Grade Five kanji used on more than one page
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

inclusion_lock(gradefive);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.blame =
  push_pbox_toexpand("kanji.grfive.blame");
  build_kanji.level(build_kanji.tb(520,-20)
    (kanji.toprad.blue)
    (kanji.grone.shell));
  expand_pbox;
enddef;

vardef kanji.grfive.compare =
  push_pbox_toexpand("kanji.grfive.compare");
  build_kanji.level(build_kanji.lr(540,-20)
    (build_kanji.lift_skirt(300,160)
      (build_kanji.sscale(yscaled 1.07 shifted (0,-27))(kanji.grone.up);
       replace_strokep(-1)
         (oldp shifted (-810,0) xscaled 1.7 shifted (810,60));
       replace_strokep(-2)
         (oldp shifted (-810,0) xscaled 1.7 shifted (810,0))))
    (kanji.radical.spoon));
  expand_pbox;
enddef;

vardef kanji.grfive.conform =
  push_pbox_toexpand("kanji.grfive.conform");
  build_kanji.level(build_kanji.lr(560,30)
    (kanji.grone.shell)
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

vardef kanji.grfive.intention =
  push_pbox_toexpand("kanji.grfive.intention");
  build_kanji.level(build_kanji.tb(420,10)
    (kanji.grfour.gentleman)
    (kanji.bottomrad.heart));
  expand_pbox;
enddef;

vardef kanji.grfive.mistake =
  push_pbox_toexpand("kanji.grfive.mistake");
  push_stroke((380,810)--(370,240){dir 266}..tension 1.2..(300,70)..(80,-50),
    (1.7,1.7)--(1.55,1.55)--(1.44,1.44)--(1,1));
  set_boserif(0,0,10);
  push_stroke((620,810)--(620,-40),(1.7,1.7)--(1.6,1.6));
  set_boserif(0,0,10);
  push_stroke((90,600)--(378,600),(1.6,1.6)--(1.6,1.6));
  push_stroke((110,400)--(372,400),(1.6,1.6)--(1.6,1.6));
  push_stroke((80,170)..tension 1.2..(300,200)..(460,240),
    (1.7,1.7)--(1.5,1.5)--(1,1));
  push_stroke((620,600)--(910,600),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((620,400)--(890,400),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((620,200)--(920,200),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  expand_pbox;
enddef;

vardef kanji.grfive.old_times =
  push_pbox_toexpand("kanji.grfive.old_times");
  build_kanji.level(build_kanji.lr(340,-20)
    (kanji.radical.vline)
    (kanji.grone.day));
  expand_pbox;
enddef;

vardef kanji.grfive.passable =
  push_pbox_toexpand("kanji.grfive.passable");
  push_stroke((80,720)--(920,720),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((800,720),
    (1.6,1.6));
  build_kanji.add_jtail(0);
  build_kanji.box((240,500),(540,200));
  expand_pbox;
enddef;

vardef kanji.grfive.phrase =
  push_pbox_toexpand("kanji.grfive.phrase");
  kanji.radical.wrapping;
  build_kanji.box((380,450),(640,250));
  expand_pbox;
enddef;

vardef kanji.grfive.showing =
  push_pbox_toexpand("kanji.grfive.showing");
  build_kanji.level(build_kanji.tb(480,130)
    (build_kanji.sscale(yscaled 0.9)(kanji.grone.two))
    (kanji.grone.small));
  set_boserif(-1,0,whatever);
  expand_pbox;
enddef;

vardef kanji.grfive.support =
  push_pbox_toexpand("kanji.grfive.support");
  build_kanji.level(build_kanji.tb(500,50)
    (kanji.grone.ten)
    (kanji.greight.otoh));
  expand_pbox;
enddef;

vardef kanji.grfive.talent =
  push_pbox_toexpand("kanji.grfive.talent");
  build_kanji.level(build_kanji.lr(520,0)
    (build_kanji.tb(480,-60)
       (kanji.radical.mu)
       (kanji.bottomrad.moon))
    (build_kanji.tb(420,-10)
       (kanji.radical.spoon)
       (kanji.radical.spoon)));
  expand_pbox;
enddef;

vardef kanji.grfive.tongue =
  push_pbox_toexpand("kanji.grfive.tongue");
  build_kanji.add_beret(kanji.grtwo.old);
  expand_pbox;
enddef;
