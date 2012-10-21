%
% Unicode page 20 (Punctuation) for Tsukurimashou
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

input latin-intro.mp;

% AUTODEPS
input punct.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% GENERAL PUNCTUATION

% WARNING changing rescale setting
tsu_rescale_half;

% hyphen
begintsuglyph("uni2010",16);
  punct.dash.hyphen;
  tsu_render;
endtsuglyph;

% non-breaking hyphen
begintsuglyph("uni2011",17);
  punct.dash.hyphen;
  tsu_render;
endtsuglyph;

% figure dash
begintsuglyph("figuredash",18);
  punct.dash.en;
  tsu_render;
endtsuglyph;

% en dash
begintsuglyph("endash",19);
  punct.dash.en;
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_full;

% em dash
begintsuglyph("emdash",20);
  punct.dash.em;
  tsu_render;
endtsuglyph;

% horizontal bar
begintsuglyph("uni2015",21);
  push_stroke((130,390)--(870,390),(2,2)--(2,2));
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_half;

% high-6
begintsuglyph("quoteleft",24);
  punct.make_comma((520,vmetric(0.94)),180);
  tsu_render;
endtsuglyph;

% high-9
begintsuglyph("quoteright",25);
  punct.make_comma((480,vmetric(0.94)),0);
  tsu_render;
endtsuglyph;

% low-9
begintsuglyph("quotesinglbase",26);
  punct.make_comma((520,vmetric(0.03)),0);
  tsu_render;
endtsuglyph;

% high-rev-9
begintsuglyph("quotereversed",27);
  punct.make_revcomma((520,vmetric(0.94)),0);
  tsu_render;
endtsuglyph;

% high-66
begintsuglyph("quotedblleft",28);
  punct.make_comma((520-tsu_punct_size,vmetric(0.94)),180);
  punct.make_comma((520+tsu_punct_size,vmetric(0.94)),180);
  tsu_render;
endtsuglyph;

% high-99
begintsuglyph("quotedblright",29);
  punct.make_comma((480-tsu_punct_size,vmetric(0.94)),0);
  punct.make_comma((480+tsu_punct_size,vmetric(0.94)),0);
  tsu_render;
endtsuglyph;

% low-99
begintsuglyph("quotedblbase",30);
  punct.make_comma((520-tsu_punct_size,vmetric(0.03)),0);
  punct.make_comma((520+tsu_punct_size,vmetric(0.03)),0);
  tsu_render;
endtsuglyph;

% high-rev-99
begintsuglyph("quotedblreversed",31);
  punct.make_revcomma((520-tsu_punct_size,vmetric(0.94)),0);
  punct.make_revcomma((520+tsu_punct_size,vmetric(0.94)),0);
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_native_narrow;

vardef dagger_spur =
  if sharp_corners:
    dagger_x:=(tsu_punct_size-60)*1.25;
    if dagger_x<12: dagger_x:=15; fi;
    (4,mincho*30){curl 0}..
      (0.5[(0,mincho*20),(dagger_x,222-mincho*72)]+mincho*(-7,4))..
    {curl 1}(dagger_x,222-mincho*72)--(0,200)--
      (-dagger_x,222-mincho*72){curl 1}..
      (0.5[(0,mincho*20),(-dagger_x,222-mincho*72)]+mincho*(7,4))..
    {curl 0}(-4,mincho*30)--cycle
  else:
    dagger_x:=tsu_punct_size-60;
    if dagger_x<12: dagger_x:=15; fi;
    (4,mincho*30){curl 0}..
      (0.5[(0,mincho*20),(dagger_x,160)]+mincho*(-7,4))..
    (dagger_x,160)..(0,200)..(-dagger_x,160)..
      (0.5[(0,mincho*20),(-dagger_x,160)]+mincho*(7,4))..
    {curl 0}(-4,mincho*30)--cycle
  fi
enddef;

% dagger
begintsuglyph("dagger",32);
  begingroup
    save tsx;
    transform tsx;
  
    tsx:=tsu_slant_xform;
  
    dangerousFill (dagger_spur rotated 90 shifted (250,650)
      transformed tsx);
    dangerousFill (dagger_spur shifted (250,650)
      transformed tsx);
    dangerousFill (dagger_spur rotated -90 shifted (250,650)
      transformed tsx);
    dangerousFill (fullcircle scaled (20+mincho*50) shifted (250,650)
      transformed tsx);

    x1=x5=246;
    x3=250-(tsu_punct_size-60)*1.25;
    x2=x4=0.5[x1,x3];
    x6=x10=500-x1;
    x7=x9=500-x2;
    x8=500-x3;
    x11=x12=0.4[250,x3];
    x13=x14=500-x11;

    y1=y10=650;
    y2=y9=550;
    y3=y8=450;
    y4=y7=250;
    y5=y6=-50;
    y11=y14=535;
    y12=y13=280;

    dangerousFill (interpath(mincho,
      z1--z2--z3--z4--z5--z6--z7--z8--z9--z10--cycle,
      z1{curl 1}..z11..{curl 1}z3{curl 1}..z12..{curl 0}z5--
        z6{curl 0}..z13..{curl 1}z8{curl 1}..z14..{curl 1}z10--cycle)
      transformed tsx);
  endgroup;
endtsuglyph;

% double dagger
begintsuglyph("daggerdbl",33);
  begingroup
    save x,y,tsx;
    numeric x[],y[];
    transform tsx;

    tsx:=tsu_slant_xform;

    dangerousFill (dagger_spur rotated 90 shifted (250,650)
      transformed tsx);
    dangerousFill (dagger_spur shifted (250,650)
      transformed tsx);
    dangerousFill (dagger_spur rotated -90 shifted (250,650)
      transformed tsx);
    dangerousFill (fullcircle scaled (20+mincho*50) shifted (250,650)
      transformed tsx);
    dangerousFill (dagger_spur rotated -90 shifted (250,150)
      transformed tsx);
    dangerousFill (dagger_spur rotated 180 shifted (250,150)
      transformed tsx);
    dangerousFill (dagger_spur rotated 90 shifted (250,150)
      transformed tsx);
    dangerousFill (fullcircle scaled (20+mincho*50) shifted (250,150)
      transformed tsx);

    x1=x4=x7=246;
    x3=x5=250-(tsu_punct_size-60)*1.25;
    x2=x6=0.5[x1,x3];
    x8=x11=x14=500-x1;
    x9=x13=500-x2;
    x10=x12=500-x3;

    y1=y14=650-mincho*30;
    y3=y12=550;
    y2=y13=0.5[y1,y3];
    y4=y11=400;
    y5=y10=800-y3;
    y6=y9=800-y2;
    y7=y8=800-y1;

    x15=x16=x2+7*mincho;
    x17=x18=500-x15;
    
    y15=y18=y2-20*mincho;
    y16=y17=800-y15;
    
    dangerousFill (interpath(mincho,
      z1--z2--z3--z4--z5--z6--z7--z8--z9--z10--z11--z12--z13--z14--cycle,
      z1{curl 1}..z15..{curl 1}z3{curl 1}..z4..
        {curl 1}z5{curl 1}..z16..{curl 1}z7--
        z8{curl 1}..z17..{curl 1}z10{curl 1}..z11..
        {curl 1}z12{curl 1}..z18..{curl 1}z14--cycle)
      transformed tsx);
  endgroup;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_full;

% euro symbol
begintsuglyph("Euro",172);
  punct.euro;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
