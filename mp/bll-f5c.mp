%
% Unicode page F5C (pentagrams and crosses) for Blackletter Lolita
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
input pentacross.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PENTAGRAMS

begintsuglyph("pentagram01",1);
  default_nib:=fix_nib(20,20,0);
  my_nib:=fix_nib(14,14,0);
  draw_stroked_opts(tip(my_nib,1,1)(0,3,6,9,12,15))
    (tipentagram scaled 844 shifted centre_pt);
endtsuglyph;

begintsuglyph("pentagram02",2);
  default_nib:=fix_nib(20,20,0);
  my_nib:=fix_nib(14,14,0);
  draw_stroked_opts(tip(my_nib,1,1)(0,3,6,9,12,15))
    (tipentagram rotated 180 scaled 844 shifted centre_pt);
endtsuglyph;

begintsuglyph("pentagram03",3);
  default_nib:=fix_nib(20,20,0);
  my_nib:=fix_nib(14,14,0);
  draw_stroked_opts(tip(my_nib,1,1)(0,3,6,9,12,15))
    (tipentagram rotated 270 scaled 844 shifted centre_pt);
endtsuglyph;

begintsuglyph("pentagram04",4);
  default_nib:=fix_nib(20,20,0);
  my_nib:=fix_nib(14,14,0);
  draw_stroked_opts(tip(my_nib,1,1)(0,3,6,9,12,15))
    (tipentagram rotated 90 scaled 844 shifted centre_pt);
endtsuglyph;

begintsuglyph("pentagram05",5);
  draw_stroked(25,0)(pentagram scaled 888 shifted centre_pt);
  draw_stroked(25,-1)(fullcircle scaled 875 shifted centre_pt);
endtsuglyph;

begintsuglyph("pentagram06",6);
  draw_stroked(25,0)(pentagram rotated 180 scaled 888 shifted centre_pt);
  draw_stroked(25,-1)(fullcircle scaled 875 shifted centre_pt);
endtsuglyph;

begintsuglyph("pentagram07",7);
  draw_stroked(50,1)(pentagram scaled 740 shifted centre_pt);
endtsuglyph;

begintsuglyph("pentagram08",8);
  draw_stroked(50,1)(pentagram rotated 180 scaled 740 shifted centre_pt);
endtsuglyph;

vardef penta_ell(expr lw,loff) =
  begingroup
    save myl;
    path myl[];
    myl1:=(dir 90)--(dir 234);
    myl2:=((dir 162)--(dir 18)) shifted (loff*dir 90);
    myl3:=myl1 shifted (lw*dir 342);
    myl6:=(dir 90)--(dir 306);
    myl4:=myl6 shifted (lw*dir 198);
    myl5:=((dir 18)--(dir 234)) shifted ((loff+lw)*dir 126);
    (dir 90)--(myl6 intersectionpoint myl5)--
      (myl5 intersectionpoint myl4)--(myl4 intersectionpoint myl3)--
      (myl3 intersectionpoint myl2)--(myl2 intersectionpoint myl1)--cycle
  endgroup
enddef;

begintsuglyph("pentagram09",9);
  my_path:=penta_ell(0.1,0.1);
  for i:=0 upto 4:
    dangerousFill my_path rotated (i*72) scaled 450 shifted centre_pt;
  endfor;
endtsuglyph;

begintsuglyph("pentagram10",10);
  my_path:=penta_ell(0.1,0.1);
  for i:=0 upto 4:
    dangerousFill my_path
      reflectedabout (down,up) rotated (i*72) scaled 450 shifted centre_pt;
  endfor;
endtsuglyph;

begintsuglyph("pentagram11",11);
  begingroup
    save lp;
    path lp[];
    my_path:=penta_ell(0.06,0);
    lp1:=subpath (5,7) of my_path;
    lp2:=subpath (2,4) of my_path;
    default_nib:=fix_nib(10,10,0);
    pen_stroke(tip(1)(1))(lp1 scaled 430 shifted centre_pt)(lp3);
    pen_stroke(tip(1)(1))(lp2 scaled 430 shifted centre_pt)(lp4);
    lp3:=regenerate(lp3);
    lp4:=regenerate(lp4);
    for i:=0 upto 4:
      dangerousFill lp3 rotatedaround (centre_pt,i*72);
      dangerousFill lp4 rotatedaround (centre_pt,i*72);
    endfor;
  endgroup;
endtsuglyph;

begintsuglyph("pentagram12",12);
  begingroup
    save lp;
    path lp[];
    my_path:=penta_ell(0.10,0);
    lp1:=subpath (5,7) of my_path;
    lp2:=subpath (2,4) of my_path;
    default_nib:=fix_nib(14,14,0);
    pen_stroke(tip(1)(1))(lp1 scaled 425 shifted centre_pt)(lp3);
    pen_stroke(tip(1)(1))(lp2 scaled 425 shifted centre_pt)(lp4);
    lp3:=regenerate(lp3);
    lp4:=regenerate(lp4);
    for i:=0 upto 4:
      dangerousFill lp3 rotatedaround (centre_pt,i*72);
      dangerousFill lp4 rotatedaround (centre_pt,i*72);
    endfor;
  endgroup;
endtsuglyph;

begintsuglyph("pentagram13",13);
  begingroup
    save lp;
    path lp[];
    my_path:=penta_ell(0.15,0);
    lp1:=subpath (5,7) of my_path;
    lp2:=subpath (2,4) of my_path;
    default_nib:=fix_nib(17,17,0);
    pen_stroke(tip(1)(1))(lp1 scaled 420 shifted centre_pt)(lp3);
    pen_stroke(tip(1)(1))(lp2 scaled 420 shifted centre_pt)(lp4);
    lp3:=regenerate(lp3);
    lp4:=regenerate(lp4);
    for i:=0 upto 4:
      dangerousFill lp3 rotatedaround (centre_pt,i*72);
      dangerousFill lp4 rotatedaround (centre_pt,i*72);
    endfor;
  endgroup;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

begintsuglyph("cross01",129);
  draw_stroked(20,1)(cross_path(0.09) scaled 880 shifted centre_pt);
endtsuglyph;

begintsuglyph("cross02",130);
  draw_stroked(20,1)(cross_path(0.09)
    rotated 180 scaled 880 shifted centre_pt);
endtsuglyph;

begintsuglyph("cross03",131);
  draw_stroked(20,1)(cross_path(0.05) scaled 880 shifted centre_pt);
endtsuglyph;

begintsuglyph("cross04",132);
  draw_stroked(20,1)(cross_path(0.13) scaled 880 shifted centre_pt);
endtsuglyph;

begintsuglyph("cross05",133);
  dangerousFill cross_path(0.04) scaled 900 shifted centre_pt;
endtsuglyph;

begintsuglyph("cross06",134);
  dangerousFill cross_path(0.08) scaled 900 shifted centre_pt;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
