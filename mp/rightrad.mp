%
% Right-side radicals
% Copyright (C) 2012  Matthew Skala
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
