%
% Right-side radicals
% Copyright (C) 2012, 2013  Matthew Skala
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

inclusion_lock(rightrad);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.rightrad.beta =
  push_pbox_toexpand("kanji.rightrad.beta");
  kanji.radical.beta;
  replace_strokep(0)
    (oldp shifted (-250,-760) xyscaled (1.2,630/550) shifted (300,760));
  replace_strokep(0)((300,-60)--(subpath (1,infinity) of oldp));
  expand_pbox;
enddef;

% KanjiVG lists this as U+5F54, but it's a little different visually
vardef kanji.rightrad.carve_wood =
  push_pbox_toexpand("kanji.rightrad.carve_wood");
  build_kanji.tb(420,60)
    (kanji.radical.pigs_tail)
    (kanji.radical.alt_water);
  expand_pbox;
enddef;

% named for the most common character to contain it
vardef kanji.rightrad.clothing =
  push_pbox_toexpand("kanji.rightrad.clothing");
  tsu_xform(identity yscaled 0.92)(build_kanji.tb(440,60)
    (kanji.radical.seal)
    (tsu_xform(identity shifted (50,0))
       (kanji.greight.otoh)));
  replace_strokep(-2)
    ((xpart point 0 of oldp,-40)--subpath (1,infinity) of oldp);
  replace_strokep(-1)
    (oldp shifted (-900,0) xscaled 0.78 shifted (900,0));
  replace_strokep(-1)
    (((-170,0)+point 0 of oldp)--subpath (1,infinity) of oldp);
  expand_pbox;
enddef;

vardef kanji.rightrad.crooked_heaven =
  push_pbox_toexpand("kanji.rightrad.crooked_heaven");
  push_stroke((130,740)--(780,740),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((80,460)--(890,460),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((250,740)--(250,460),(1.6,1.6)--(1.5,1.5));
  push_stroke((600,740){down}..(575,510)..(370,200)..{curl 0.5}(50,-20),
    (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke((580,360),(1.6,1.6));
  build_kanji.add_ltail(0);
  set_boserif(0,0,10);
  expand_pbox;
enddef;

vardef kanji.rightrad.genius =
  push_pbox_toexpand("kanji.rightrad.genius");
  push_stroke((600,800),(1.6,1.6));
  build_kanji.add_jtail(0);
  set_boserif(0,0,10);
  push_stroke((110+30*mincho,580)--(860,580),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((520,580)..tension 1.2..(360,260)..(110,90),
    (1.6,1.6)--(1.4,1.4)--(1,1));
  expand_pbox;
enddef;

vardef kanji.rightrad.half =
  push_pbox_toexpand("kanji.rightrad.half");
  kanji.grtwo.half;
  replace_strokep(-3)(oldp shifted (-500,0));
  replace_strokep(-4)(oldp shifted (460,0));
  expand_pbox;
enddef;

vardef kanji.rightrad.professional =
  push_pbox_toexpand("kanji.rightrad.professional");
  build_kanji.tb(300,0)
    (build_kanji.tb(420,80)
       (kanji.grone.ten)
       (kanji.grone.day);
     replace_strokep(-4)((point 0 of oldp)--(point 0.5 of get_strokep(-1)));
     push_stroke((670,820)..(730,780)..(780,710),
       (1,1)--(1.4,1.4)--(1.8,1.8)))
    (kanji.grsix.inch);
  expand_pbox;
enddef;

vardef kanji.rightrad.short_hair =
  push_pbox_toexpand("kanji.rightrad.short_hair");
  push_stroke((780,750)..tension 1.2..(580,620)..(180,500),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke((880,220)..tension 1.2..(600,60)..(100,-70),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  push_stroke(interpath(0.52,get_strokep(0),get_strokep(-1)),
    (1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  expand_pbox;
enddef;

vardef kanji.rightrad.sword =
  push_pbox_toexpand("kanji.rightrad.sword");
  push_stroke((260,720)--(260,120),(1.6,1.6)--(1.4,1.4));
  set_boserif(0,0,10);
  push_stroke((740,760),(1.6,1.6));
  set_boserif(0,0,10);
  build_kanji.add_jtail(0);
  replace_strokep(0)(oldp shifted (-740,0) xscaled 2.3 shifted (740,0));
  expand_pbox;
enddef;
