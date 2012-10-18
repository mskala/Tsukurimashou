%
% Shared code for Tsukurimashou latin
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

inclusion_lock(latinintro);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

latin_wide_low_h:=latin_wide_baseline+mbrush_height*0.8;
latin_wide_high_h:=latin_wide_top-mbrush_height*0.8;
latin_wide_low_r:=latin_wide_baseline+mbrush_height*0.8-7;
latin_wide_high_r:=latin_wide_top-mbrush_height*0.8+15;
if sharp_corners:
  latin_wide_low_v:=latin_wide_baseline;
  latin_wide_high_v:=latin_wide_top;
else:
  latin_wide_low_v:=latin_wide_baseline+mbrush_height*0.8;
  latin_wide_high_v:=latin_wide_top-mbrush_height*0.8;
fi;

vardef vmetric(expr a) =
  (a[latin_wide_low_h,latin_wide_high_h])
enddef;

latin_wide_xheight:=vmetric(0.65);
latin_wide_xheight_h:=latin_wide_xheight-mbrush_height*0.6;
latin_wide_xheight_r:=latin_wide_xheight-mbrush_height*0.6+15;
if sharp_corners:
  latin_wide_xheight_v:=latin_wide_xheight;
else:
  latin_wide_xheight_v:=latin_wide_xheight-mbrush_height*0.5;
fi;

latin_wide_desc:=vmetric(-0.35);
latin_wide_desc_h:=latin_wide_desc+mbrush_height*0.6;
latin_wide_desc_r:=latin_wide_desc+mbrush_height*0.6-10;
if sharp_corners:
  latin_wide_desc_v:=latin_wide_desc;
else:
  latin_wide_desc_v:=latin_wide_desc+mbrush_height*0.5;
fi;

latin_wide_lc_baselift:=vmetric(0.02);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

transform tsu_xf.accentedcap,tsu_xf.cap_upper_accent,tsu_xf.low_centre_accent;

if is_proportional:
  tsu_xf.accentedcap=identity;
else:
  xpart tsu_xf.accentedcap=1;
  xypart tsu_xf.accentedcap=yxpart tsu_xf.accentedcap=0;
  (500,vmetric(0)) transformed tsu_xf.accentedcap=(500,vmetric(0));
  (500,vmetric(1)) transformed tsu_xf.accentedcap=(500,vmetric(0.82));
fi;

accent_default[anc_upper]=identity shifted (500,vmetric(0.75));
accent_default[anc_grave]=identity
  shifted (500+0.4*tsu_punct_size,vmetric(0.75));
accent_default[anc_acute]=identity
  shifted (500-0.4*tsu_punct_size,vmetric(0.75));
accent_default[anc_wide]=identity xscaled 0.75 shifted (500,vmetric(0.75));
accent_default[anc_tilde]=identity xscaled 0.75 shifted (500,vmetric(0.75));
accent_default[anc_ring]=identity shifted (500,vmetric(0.75));
accent_default[anc_caron_comma]=identity shifted (730,vmetric(0.93));
accent_default[anc_lower]=identity shifted (500,vmetric(-0.26));
accent_default[anc_lower_connect]=identity shifted (500,vmetric(0));
accent_default[anc_centre]=identity
  scaled ((latin_wide_high_r-latin_wide_low_r)/200) shifted centre_pt;

% this one is for capitals that have NOT been shrunk
tsu_xf.cap_upper_accent=identity shifted (500,vmetric(1.10));

tsu_xf.low_centre_accent=identity
    scaled ((latin_wide_xheight_r-latin_wide_low_r)/200)
    shifted (xpart centre_pt,(latin_wide_xheight_r+latin_wide_low_r)/2);

vardef tsu_accent.shift_anchors(text c)(expr s) =
  begingroup;
    save killflag;
    boolean killflag;
    for i:=1 upto max_accent_seen:
      if unknown accent_has_default[i]:
        killflag:=true;
      elseif not accent_has_default[i]:
        killflag:=true;
      else:
        killflag:=false;
        for j=sp-1 downto 1:
          if obstacktype[j]=otanchor:
            if obstackn[j]=i:
              killflag:=true;
            fi;
          fi;
          exitif killflag;
        endfor;
      fi;
      if not killflag:
        def ai = i enddef;
        def olda = ((0,0) transformed accent_default[i]) enddef;
        if c:
          push_anchor(i,accent_default[i]);
        fi;
      fi;
    endfor;
  endgroup;
  for i:=sp-1 downto 1:
    if obstacktype[i]=otanchor:
      begingroup
        def ai = obstackn[i] enddef;
        def olda = ((0,0) transformed obstackt[i]) enddef;
        if c:
          obstackt[i]:=obstackt[i] shifted s;
        fi;
      endgroup;
    fi;
  endfor;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef tsu_accent.up_default_anchors =
  tsu_default_anchor(anc_upper,accent_default[anc_upper]
    shifted (0,vmetric(1.10)-vmetric(0.75)));
  tsu_default_anchor(anc_grave,accent_default[anc_grave]
    shifted (0,vmetric(1.10)-vmetric(0.75)));
  tsu_default_anchor(anc_acute,accent_default[anc_acute]
    shifted (0,vmetric(1.10)-vmetric(0.75)));
  tsu_default_anchor(anc_wide,identity xscaled 1.2
    transformed accent_default[anc_wide]
    shifted (0,vmetric(1.10)-vmetric(0.75)));
  tsu_default_anchor(anc_tilde,accent_default[anc_tilde]
    shifted (0,vmetric(1.10)-vmetric(0.75)));
  tsu_default_anchor(anc_ring,accent_default[anc_ring]
    shifted (0,vmetric(1.10)-vmetric(0.75)));
  tsu_default_anchor(anc_caron_comma,
    accent_default[anc_caron_comma] shifted (200,0));
  tsu_default_anchor(anc_lower,accent_default[anc_lower]);
  tsu_default_anchor(anc_lower_connect,accent_default[anc_lower_connect]);
  tsu_default_anchor(anc_centre,accent_default[anc_centre]);
enddef;

vardef tsu_accent.low_default_anchors =
  tsu_default_anchor(anc_upper,accent_default[anc_upper]);
  tsu_default_anchor(anc_grave,accent_default[anc_grave]);
  tsu_default_anchor(anc_acute,accent_default[anc_acute]);
  tsu_default_anchor(anc_wide,accent_default[anc_wide]);
  tsu_default_anchor(anc_tilde,accent_default[anc_tilde]);
  tsu_default_anchor(anc_ring,accent_default[anc_ring]);
  tsu_default_anchor(anc_caron_comma,accent_default[anc_caron_comma]);
  tsu_default_anchor(anc_lower,accent_default[anc_lower]);
  tsu_default_anchor(anc_lower_connect,accent_default[anc_lower_connect]);
  tsu_default_anchor(anc_centre,tsu_xf.low_centre_accent);
enddef;

vardef tsu_accent.clear_default_anchors =
  tsu_default_anchor(anc_upper,0);
  tsu_default_anchor(anc_grave,0);
  tsu_default_anchor(anc_acute,0);
  tsu_default_anchor(anc_wide,0);
  tsu_default_anchor(anc_tilde,0);
  tsu_default_anchor(anc_ring,0);
  tsu_default_anchor(anc_caron_comma,0);
  tsu_default_anchor(anc_lower,0);
  tsu_default_anchor(anc_lower_connect,0);
  tsu_default_anchor(anc_centre,0);
enddef;
