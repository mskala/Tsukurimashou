%
% Grade Six kanji used on more than one page
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

inclusion_lock(gradesix);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the other common word using this kanji is "foot (unit of measure)" but
% that is a poor mnemonic because it's ambiguous with "foot (body part)"
vardef kanji.grsix.blowjob =
  push_pbox_toexpand("kanji.grsix.blowjob");
  kanji.radical.flag;
  push_stroke((490,490)..tension 1.2..(690,180)..(910,70),
    (1.2,1.2)--(1.4,1.4)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.grsix.bothered =
  push_pbox_toexpand("kanji.grsix.bothered");
  kanji.radical.box;
  build_kanji.sscale(scaled 0.75)(kanji.grone.wood);
  expand_pbox;
enddef;

vardef kanji.grsix.climax =
  push_pbox_toexpand("kanji.grsix.climax");
  build_kanji.tb(540,50)
    (kanji.radical.mu_bar)
    (kanji.grone.earth);
  expand_pbox;
enddef;

vardef kanji.grsix.dry =
  push_pbox_toexpand("kanji.grsix.dry");
  push_stroke((180,780)--(820,780),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((80,470)--(920,470),
    (1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((500,780)--(500,0),
    (1.6,1.6)--(1.5,1.5));
  expand_pbox;
enddef;

vardef kanji.grsix.emperor =
  push_pbox_toexpand("kanji.grsix.emperor");
  build_kanji.tb(350,-20)
    (kanji.grone.white)
    (kanji.grone.king);
  expand_pbox;
enddef;

vardef kanji.grsix.fountain =
  push_pbox_toexpand("kanji.grsix.fountain");
  build_kanji.level(build_kanji.tb(380,54)
    (kanji.grone.white)
    (kanji.grone.water;
     set_boserif(-1,0,whatever)));
  expand_pbox;
enddef;

vardef kanji.grsix.inch =
  push_pbox_toexpand("kanji.grsix.inch");
  push_stroke((110,590)--(890,590),(1.6,1.6)--(1.6,1.6));
  set_boserif(0,1,9);
  push_stroke((690,780),(1.6,1.6));
  build_kanji.add_jtail(0);
  set_boserif(0,0,10);
  push_stroke((180,420)..tension 1.2..(350,310)..(420,200),
    (0.9,0.9)--(1.5,1.5)--(1.7,1.7));
  expand_pbox;
enddef;

vardef kanji.grsix.noes =
  push_pbox_toexpand("kanji.grsix.noes");
  build_kanji.level(build_kanji.tb(390,70)
    (kanji.grfour.non)
    (kanji.grone.mouth));
  expand_pbox;
enddef;

vardef kanji.grsix.respect =
  push_pbox_toexpand("kanji.grsix.respect");
  build_kanji.lr(540,20)
    (kanji.rare.in_the_least)
    (kanji.radical.folding_chair);
  expand_pbox;
enddef;

vardef kanji.grsix.prolong =
  push_pbox_toexpand("kanji.grsix.prolong");
  build_kanji.long_stride_enclose(false)
    (build_kanji.add_beret(kanji.grtwo.cease));
  expand_pbox;
enddef;

vardef kanji.grsix.self =
  push_pbox_toexpand("kanji.grsix.self");
  push_stroke((160,740)--(750,740)--(750,380),
    (1.6,1.6)--(1.6,1.6)--(1.5,1.5));
  set_botip(0,1,1);
  set_boserif(0,1,4);
  push_stroke((140,450)--(750,450),
    (1.5,1.5)--(1.5,1.5));
  push_stroke((145,485-15*mincho),(1.7,1.7));
  set_boserif(0,0,10);
  build_kanji.add_ltail(0);
  expand_pbox;
enddef;
