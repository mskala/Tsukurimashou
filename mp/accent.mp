%
% Accents for Tsukurimashou
% Copyright (C) 2011  Matthew Skala
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

inclusion_lock(accent);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef tsu_accent.acute =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_stroke(
    (500+1.5*tsu_punct_size,vmetric(0.95))--
      (500-0.5*tsu_punct_size,vmetric(0.78)),
    (2,2)--(1.6,1.6)--(1.3,1.3));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_bosize(0,80);
  set_botip(0,1,1);
enddef;

vardef tsu_accent.breve =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_stroke((500-1.3*tsu_punct_size,vmetric(0.95)){down}..
      (500,vmetric(0.82))..
      {up}(500+1.3*tsu_punct_size,vmetric(0.95)),
    (1,1)--(1.9,1.9)--(1,1));
enddef;

vardef tsu_accent.caron =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_stroke((500-1.5*tsu_punct_size,vmetric(0.95))--
    (500,vmetric(0.80))--
    (500+1.5*tsu_punct_size,vmetric(0.95)),
  (2,2)--(1.4,1.4)--(1.4,1.4));
  set_bosize(0,80);
  set_botip(0,1,1);
enddef;

vardef tsu_accent.caron_comma =
  push_anchor(-anc_caron_comma,accent_default[anc_caron_comma]);
  punct.make_comma((0,0) transformed accent_default[anc_caron_comma],0);
enddef;

vardef tsu_accent.cedilla =
  push_anchor(-anc_lower_accent,accent_default[anc_lower_accent]);
  push_stroke(
    ((0,0)--(-0.3,-1.8){curl 0.7}..(2.6,-2.5)..{curl 0.2}(-2.5,-3.0))
      scaled (0.5*tsu_punct_size) shifted (500,latin_wide_low_r),
    (1.4,1.4)--(1.4,1.4)--(1.7,1.7)--(1.3,1.3));
  set_bosize(0,80);
  set_botip(0,1,1);
enddef;

vardef tsu_accent.circumflex =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_stroke((500-1.5*tsu_punct_size,vmetric(0.80))--
      (500,vmetric(0.95))--
      (500+1.5*tsu_punct_size,vmetric(0.80)),
    (1.6,1.6)--(2,2)--(1.6,1.6));
  set_bosize(0,80);
  set_botip(0,1,1);
enddef;

vardef tsu_accent.commabelow =
  push_anchor(-anc_lower_accent,accent_default[anc_lower_accent]);
  punct.make_comma((0,0) transformed accent_default[anc_lower_accent],0);
enddef;

vardef tsu_accent.dotabove =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_lcblob(fullcircle rotated 45 scaled (mbrush_width*1.72+50)
    shifted ((500,vmetric(0.88))
      transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);
enddef;

vardef tsu_accent.grave =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_stroke((500-1.5*tsu_punct_size,vmetric(0.95))--
      (500+0.5tsu_punct_size,vmetric(0.78)),
    (2,2)--(1.6,1.6)--(1.3,1.3));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_bosize(0,80);
  set_botip(0,1,1);
enddef;

vardef tsu_accent.heavy_metal_umlaut =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_lcblob((up--left--down--right--cycle) scaled (mbrush_width*1.5+30)
    shifted ((520-1.5*tsu_punct_size,vmetric(0.88))
      transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);
  push_lcblob((up--left--down--right--cycle) scaled (mbrush_width*1.5+30)
    shifted ((520+1.5*tsu_punct_size,vmetric(0.88))
      transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);
enddef;

vardef tsu_accent.hungarian_umlaut =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_stroke((500+1.7*tsu_punct_size,vmetric(0.95))--
      (500+0.7*tsu_punct_size,vmetric(0.78)),
    (2,2)--(1.6,1.6)--(1.3,1.3));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_bosize(0,80);
  set_botip(0,1,1);

  push_stroke((500-0.4*tsu_punct_size,vmetric(0.95))--
      (500-1.4*tsu_punct_size,vmetric(0.78)),
    (2,2)--(1.6,1.6)--(1.3,1.3));
  replace_strokep(0)(insert_nodes(oldp)(0.5));
  set_bosize(0,80);
  set_botip(0,1,1);
enddef;

vardef tsu_accent.macron =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_stroke((500-1.75*tsu_punct_size,vmetric(0.82))--
      (500+1.75*tsu_punct_size,vmetric(0.82)),
    (2,2)--(2,2));
  set_bosize(0,80);
enddef;

vardef tsu_accent.ringabove =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_lcblob(fullcircle rotated 45
    scaled (2*tsu_punct_size+20*tsu_brush_max)
    shifted ((500,vmetric(0.83-0.03*mincho)-10)
      transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);
  push_lcblob(reverse fullcircle rotated 45
    scaled (2*tsu_punct_size-110*tsu_brush_max)
    shifted ((500,vmetric(0.83-0.03*mincho)-10)
      transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);
enddef;

vardef tsu_accent.slash =
  push_anchor(-anc_centre_accent,accent_default[anc_centre_accent]);
  push_stroke(((-100,-130)--(100,130))
    transformed accent_default[anc_centre_accent],(2,2)--(2,2));
  set_bosize(0,86);
enddef;

vardef tsu_accent.tilde =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_stroke(
    ((-3.5,-0.5){curl 0}..(-1.4,1)..(0,0)..(1.4,-1)..{curl 0}(3.5,0.5))
      rotated 5 xyscaled (0.7*tsu_punct_size,0.5*tsu_punct_size)
      shifted (500,vmetric(0.85)),
    (0.7,2.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--
      (1.7,1.7)--(0.7,2.7));
  replace_strokep(0)(insert_nodes(oldp)(0.5,3.5));
  set_bosize(0,80);
enddef;

vardef tsu_accent.umlaut =
  push_anchor(-anc_upper_accent,accent_default[anc_upper_accent]);
  push_lcblob(fullcircle rotated 45 scaled (mbrush_width*1.72+50)
    shifted ((520-1.5*tsu_punct_size,vmetric(0.88))
      transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);
  push_lcblob(fullcircle rotated 45 scaled (mbrush_width*1.72+50)
    shifted ((520+1.5*tsu_punct_size,vmetric(0.88))
      transformed tsu_rescale_xform)
    transformed inverse tsu_rescale_xform);
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef tsu_accent.capital(text curves) =
  tsu_xform(tsu_xf.accentedcap)(curves);
  if get_anchor_with_default(anc_upper_accent,identity)=identity:
    push_anchor(anc_upper_accent,
      accent_default[anc_upper_accent]
        shifted (0,vmetric(0.98)-vmetric(0.8)));
  fi;
enddef;

vardef tsu_accent.apply(text basecurves)(text markcurves) =
  begingroup;
    save xsp,ysp,bmi,mbi,bmt,killflag;
    numeric xsp,ysp,bmi,mbi;
    transform bmt;
    boolean killflag;
    basecurves;
    xsp:=sp;
    markcurves;
    killflag:=false;
    for i:=sp-1 downto xsp:
      if obstacktype[i]=otanchor:
        if obstackn[i]<0:
          mbi:=i;
          killflag:=true;
        fi;
      fi;
      exitif killflag;
    endfor;
    bmt:=accent_default[-obstackn[mbi]];
    killflag:=false;
    for i:=xsp-1 downto 1:
      if obstacktype[i]=otanchor:
        if obstackn[i]=-obstackn[mbi]:
          bmi:=i;
          bmt:=obstackt[i];
          killflag:=true;
        fi;
      fi;
      exitif killflag;
    endfor;
    obstacktype[mbi]:=otnull;
    if known bmi:
      obstacktype[bmi]:=otnull;
    fi;
    ysp:=sp;
    sp:=xsp;
    tsu_xform((inverse obstackt[mbi]) transformed bmt)(sp:=ysp);
  endgroup;
enddef;
