%
% Beikaitoru subfont generator
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% When I say nonstopmode I mean nonstopmode, dammit!
nonstopmode;
def errorstopmode = nonstopmode enddef;

% no chars we don't define, please
no_implicit_spaces:=1;

% load library from METATYPE1
input fntbase.mp;

input fontno.mp;

subfontno:=round((fontno-floor(fontno)+0.001)*10);

string hershey_file;
hershey_file:=if subfontno>=7: "oriental" else: "occident" fi;

if subfontno=0:
  start_index:=0;
  end_index:=70.4;
elseif subfontno=1:
  start_index:=70.4;
  end_index:=112.6;
elseif subfontno=2:
  start_index:=112.6;
  end_index:=210.3;
elseif subfontno=3:
  start_index:=210.3;
  end_index:=250.7;
elseif subfontno=4:
  start_index:=250.7;
  end_index:=305.2;
elseif subfontno=5:
  start_index:=305.2;
  end_index:=370.2;
elseif subfontno=6:
  start_index:=370.2;
  end_index:=392.7;
elseif subfontno=7:
  start_index:=0;
  end_index:=205.8;
elseif subfontno=8:
  start_index:=205.8;
  end_index:=460.2;
elseif subfontno=9:
  start_index:=460.2;
  end_index:=620.3;
fi;

weight:=floor(fontno) mod 10;
wmult:=4**((weight-4)/if weight<4: 2 else: 6 fi);

boolean do_smooth_curves;
do_smooth_curves:=((floor(fontno) mod 20)>=10);

string glyph_prefix;
glyph_prefix:=substring (0,3) of hershey_file;

beginfont;

pf_info_quad 1000;
pf_info_space 723, 0, 0;
pf_info_familyname "Beikaitoru Subfont";
pf_info_fixedpitch true;
pf_info_capheight 800;
pf_info_xheight 585;
pf_info_ascender 800;
pf_info_descender 200;

current_char:=1;

string line_buffer,glname;

default_nib:=fix_nib(32*wmult,32*wmult,0);
transform coord_xform;
coord_xform:=identity xyscaled (32,-32) shifted (0,304);

vardef hchar_start(expr name,code) =
  encode(name) (code); standard_introduce(name);
  beginglyph(name);
enddef;

vardef hchar_end =
  fix_hsbw((rmarg-lmarg)*32,0,0);
  endglyph;
enddef;

forever:
  line_buffer:=readfrom (hershey_file&".dat");
  exitif line_buffer=EOF;

  charnum:=scantokens ((substring (0,4) of line_buffer)&
                        "."&(substring (4,5) of line_buffer));
  if (charnum>=start_index) and (charnum<end_index):
    glname:=glyph_prefix&decimal charnum;
    message glname;
    hchar_start(glname,current_char);

      path current_stroke;
      numeric lmarg,rmarg;
      
      lmarg:=ASCII(substring (8,9) of line_buffer)-ASCII("R");
      rmarg:=ASCII(substring (9,10) of line_buffer)-ASCII("R");

      for i:=10 step 2 until length line_buffer:
        if substring (i,i+2) of (line_buffer&" R")=" R":
          if known current_stroke:

            if do_smooth_curves and (length current_stroke>1):
              current_stroke:=(point 0 of current_stroke){curl 1}..
                for j:=1 upto (length current_stroke)-1:
                  hide(
                    numeric x[],y[];
                    z1=point (j-1) of current_stroke;
                    z2=point j of current_stroke;
                    z3=point (j+1) of current_stroke;

                    x4=abs(((angle(z2-z1)-angle(z3-z2)) mod 360)-180);
                    y4=if x4>130: (x4-130)/4 else: -1 fi;
                    x5=abs(z2-z1);
                    y5=if x5<8: 8-x5 else: -1 fi;
                    x6=abs(z3-z2);
                    y6=if x6<8: 8-x6 else: -1 fi;
                  )
                  if (y4>0) and (y5>0) and (y6>0) and (y4+y5+y6>13):
                    z2..
                  else:
                    {curl 1}z2{curl 1}..
                  fi
                endfor
                {curl 1}(point infinity of current_stroke);
            fi;
          
            path g;
            pen_stroke()(current_stroke
              shifted (-lmarg,0) transformed coord_xform)(g);
            dangerousFill g;
            path current_stroke;
          fi;
        elseif unknown current_stroke:
          current_stroke:=
            (ASCII(substring (i,i+1) of line_buffer)-ASCII("R"),
             ASCII(substring (i+1,i+2) of line_buffer)-ASCII("R"));
        else:
          current_stroke:=current_stroke--
            (ASCII(substring (i,i+1) of line_buffer)-ASCII("R"),
             ASCII(substring (i+1,i+2) of line_buffer)-ASCII("R"));
        fi;
      endfor;

    hchar_end;

    current_char:=current_char+1;
  fi;
  exitif current_char>255;
endfor;
closefrom (hershey_file&".dat");

end.
