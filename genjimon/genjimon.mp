%
% Genjimon font shapes
% Copyright (C) 2010  Matthew Skala
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

def begintsuglyph(expr name,code) =
  message name;
  encode(name) (code); standard_introduce(name);
  beginglyph(name);
enddef;

def endtsuglyph =
    fix_hsbw(1000,0,0);
  endglyph
enddef;

pair centre_pt;
centre_pt:=(500,320);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

genji_grid:=150;
genji_hw:=brush_max/1.5;
if genji_hw>0.95: genji_hw:=0.95; fi;
if genji_outline: genji_hw:=1-genji_hw; fi;

vardef dflt_genji_coords =
  transform genji_coords;
  genji_coords=identity scaled genji_grid shifted (whatever,whatever);
  (3,3) transformed genji_coords=centre_pt;
enddef;

% gb(x) - start a line at the bottom in file x
% gf(y) - go forward, to or from rank y
% gs(k) - go sideways k steps
% ge - end a line (at top or bottom)
% gt - end a line (T junction)
% gx - end a line and start a new one (X junction)
% gr - turn to right
% gl - turn to left (only used for Yume no Ukihashi)
% gbk(l,r) - draw background with l/r squares removed at upper left, right
% gp(i,r) - build a simple "spike" in index 1, to rank r
% gj(s,e) - build a simple "jumper" from s to e
% gtt(i,r) - build a T-junction lin at index i, to rank r

vardef gb(expr a) =
  dflt_genji_coords;
  genji_coords:=identity scaled 0.5 shifted (a,1) transformed genji_coords;
  path genji_path;
  genji_path:=((-genji_hw,1)--(-genji_hw,-genji_hw)--
    (genji_hw,-genji_hw)--(genji_hw,1)) transformed genji_coords;
  genji_coords:=identity shifted (0,2) transformed genji_coords;
enddef;

vardef gf(expr a) =
  gs(4-a);
enddef;

vardef gs(expr a) =
  genji_path:=((-genji_hw,2*a-1) transformed genji_coords)--
    genji_path--
    ((genji_hw,2*a-1) transformed genji_coords);
  genji_coords:=identity shifted (0,2*a) transformed genji_coords;
enddef;

vardef ge =
  genji_path:=((-genji_hw,genji_hw) transformed genji_coords)--
    genji_path--
    ((genji_hw,genji_hw) transformed genji_coords)--
    cycle;
  if genji_outline:
    unFill reverse genji_path;
  else:
    Fill genji_path;
  fi;
enddef;

vardef gt =
  genji_path:=((-genji_hw,-genji_hw) transformed genji_coords)--
    genji_path--
    ((genji_hw,-genji_hw) transformed genji_coords)--
    cycle;
  if genji_outline:
    unFill reverse genji_path;
  else:
    Fill genji_path;
  fi;
enddef;

vardef gx =
  gt;
  genji_path:=((-genji_hw,1)--(-genji_hw,genji_hw)--
    (genji_hw,genji_hw)--(genji_hw,1)) transformed genji_coords;
  genji_coords:=identity shifted (0,2) transformed genji_coords;
enddef;

vardef gr =
  genji_path:=((1,genji_hw) transformed genji_coords)--
    ((-genji_hw,genji_hw) transformed genji_coords)--
    genji_path--
    ((genji_hw,-genji_hw) transformed genji_coords)--
    ((1,-genji_hw) transformed genji_coords);
  genji_coords:=identity shifted (0,2) rotated -90 transformed genji_coords;
enddef;

vardef gl =
  genji_path:=((-1,-genji_hw) transformed genji_coords)--
    ((-genji_hw,-genji_hw) transformed genji_coords)--
    genji_path--
    ((genji_hw,genji_hw) transformed genji_coords)--
    ((-1,genji_hw) transformed genji_coords);
  genji_coords:=identity shifted (0,2) rotated 90 transformed genji_coords;
enddef;

vardef gbk(expr lcut,rcut) =
  if genji_outline:
    path genji_path;
    genji_path:=(genji_hw/2,genji_hw/2)--(6-genji_hw/2,genji_hw/2)--
      if rcut>0:
        (6-genji_hw/2,5-genji_hw/2)--
        (6-genji_hw/2-rcut,5-genji_hw/2)--
        (6-genji_hw/2-rcut,6-genji_hw/2)--
      else:
        (6-genji_hw/2,6-genji_hw/2)--
      fi
      if lcut>0:
        (genji_hw/2+lcut,6-genji_hw/2)--
        (genji_hw/2+lcut,5-genji_hw/2)--
        (genji_hw/2,5-genji_hw/2)--
      else:
        (genji_hw/2,6-genji_hw/2)--
      fi
      cycle;
    dflt_genji_coords;
    Fill genji_path transformed genji_coords;
  fi;
enddef;

vardef gp(expr i,r) =
  gb(i);gf(r);ge;
enddef;

vardef gj(expr si,ei) =
  gb(si);gf(1);gr;if ei>si+1:gs(ei-si-1);fi;gr;gf(1);ge;
enddef;

vardef gtt(expr a,b) =
  gb(a);gf(b);gt;
enddef;

% #1 Kiritsubo
begintsuglyph("genjimon1",65)
  gbk(0,0);
  gj(1,3);
  gp(2,2);
  gj(4,5);
endtsuglyph;

% #2 Hahakigi
begintsuglyph("genjimon2",66)
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gp(3,1);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #3 Utsusemi
begintsuglyph("genjimon3",67)
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gp(3,1);
  gj(4,5);
endtsuglyph;

% #4 Yuugao
begintsuglyph("genjimon4",68)
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gj(3,4);
  gp(5,1);
endtsuglyph;

% #5 Wakamurasaki
begintsuglyph("genjimon5",69)
  gbk(0,0);
  gp(1,1);
  gj(2,3);
  gj(4,5);
endtsuglyph;

% #6 Suetsumuhana
begintsuglyph("genjimon6",70)
  gbk(0,0);
  gj(1,4);
  gtt(2,1);
  gtt(3,1);
  gp(5,1);
endtsuglyph;

% #7 Momiji no Ga
begintsuglyph("genjimon7",71)
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gtt(3,1);
  gp(4,2);
endtsuglyph;

% #8 Hana no En
begintsuglyph("genjimon8",72)
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gj(3,5);
  gp(4,2);
endtsuglyph;

% #9 Aoi
begintsuglyph("genjimon9",73)
  gbk(0,0);
  gj(1,2);
  gp(3,1);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #10 Sakaki
begintsuglyph("genjimon10",74)
  gbk(0,0);
  gj(1,3);
  gtt(2,1);
  gj(4,5);
endtsuglyph;

% #11 Hana Chiru Sato
begintsuglyph("genjimon11",75)
  gbk(0,1);
  gp(1,1);
  gj(2,4);
  gb(3);gf(2);gr;gx;gr;gf(2);ge;
endtsuglyph;

% #12 Suma
begintsuglyph("genjimon12",76)
  gbk(1,0);
  gb(1);gf(2);gr;gx;gs(1);gr;gf(2);ge;
  gj(2,5);
  gtt(3,2);
endtsuglyph;

% #13 Akashi
begintsuglyph("genjimon13",77)
  gbk(0,0);
  gp(1,1);
  gj(2,3);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #14 Miotsukushi
begintsuglyph("genjimon14",78)
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gp(3,2);
  gtt(4,1);
endtsuglyph;

% #15 Yomogyuu
begintsuglyph("genjimon15",79)
  gbk(0,0);
  gj(1,3);
  gtt(2,1);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #16 Sekiya
begintsuglyph("genjimon16",80)
  gbk(0,0);
  gp(1,1);
  gj(2,4);
  gtt(3,1);
  gp(5,1);
endtsuglyph;

% #17 Eawase
begintsuglyph("genjimon17",81)
  gbk(1,0);
  gb(1);gf(2);gr;gx;gr;gf(2);ge;
  gj(2,5);
  gp(4,2);
endtsuglyph;

% #18 Matsukaze
begintsuglyph("genjimon18",82)
  gbk(0,0);
  gj(1,2);
  gj(3,4);
  gp(5,1);
endtsuglyph;

% #19 Usugumo
begintsuglyph("genjimon19",83)
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gtt(3,1);
  gtt(4,1);
endtsuglyph;

% #20 Asagao
begintsuglyph("genjimon20",84)
  gbk(0,0);
  gj(1,4);
  gp(2,2);
  gtt(3,1);
  gp(5,1);
endtsuglyph;

% #21 Otome
begintsuglyph("genjimon21",85)
  gbk(0,0);
  gj(1,3);
  gp(2,2);
  gp(4,1);
  gp(5,1);
endtsuglyph;

% #22 Tamakazura
begintsuglyph("genjimon22",86)
  gbk(0,0);
  gj(1,2);
  gj(3,5);
  gtt(4,1);
endtsuglyph;

% #23 Hatsune
begintsuglyph("genjimon23",87)
  gbk(1,0);
  gb(1);gf(2);gr;gx;gr;gf(2);ge;
  gj(2,4);
  gp(5,1);
endtsuglyph;

% #24 Kochou
begintsuglyph("genjimon24",88)
  gbk(0,1);
  gj(1,4);
  gb(2);gf(2);gr;gs(1);gx;gr;gf(2);ge;
  gtt(3,2);
endtsuglyph;

% #25 Hotaru
begintsuglyph("genjimon25",89)
  gbk(0,0);
  gj(1,4);
  gtt(2,1);
  gp(3,2);
  gp(5,1);
endtsuglyph;

% #26 Tokonatsu
begintsuglyph("genjimon26",90)
  gbk(0,0);
  gp(1,1);
  gp(2,1);
  gj(3,5);
  gtt(4,1);
endtsuglyph;

% #27 Kagaribi
begintsuglyph("genjimon27",91)
  gbk(0,0);
  gp(1,1);
  gj(2,4);
  gp(3,2);
  gp(5,1);
endtsuglyph;

% #28 Nowaki
begintsuglyph("genjimon28",97)
  gbk(0,0);
  gj(1,2);
  gp(3,1);
  gj(4,5);
endtsuglyph;

% #29 Miyuki
begintsuglyph("genjimon29",98)
  gbk(0,2);
  gj(1,3);
  gb(2);gf(2);gr;gx;gs(1);gr;gf(2);ge;
  gtt(4,2);
endtsuglyph;

% #30 Fujibakama
begintsuglyph("genjimon30",99)
  gbk(0,0);
  gj(1,4);
  gp(2,2);
  gp(3,2);
  gp(5,1);
endtsuglyph;

% #31 Makibashira
begintsuglyph("genjimon31",100)
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gs(1);gr;gf(2);ge;
  gp(3,3);
endtsuglyph;

% #32 Umegae
begintsuglyph("genjimon32",101)
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gtt(3,1);
  gp(4,2);
endtsuglyph;

% #33 Fuji no Uraba
begintsuglyph("genjimon33",102)
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gb(3);gf(2);gr;gr;gf(2);ge;
endtsuglyph;

% #34 Wakana no Jou
begintsuglyph("genjimon34",103)
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gb(3);gf(2);gr;gr;gf(2);ge;
endtsuglyph;

% #35 Wakana no Ge
begintsuglyph("genjimon35",104)
  gbk(0,1);
  gj(1,4);
  gtt(2,1);
  gb(3);gf(2);gr;gx;gr;gf(2);ge;
endtsuglyph;

% #36 Kashiwagi
begintsuglyph("genjimon36",105)
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gtt(3,1);
  gp(4,2);
endtsuglyph;

% #37 Yokobue
begintsuglyph("genjimon37",106)
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gp(3,2);
  gtt(4,1);
endtsuglyph;

% #38 Suzumushi
begintsuglyph("genjimon38",107)
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gb(3);gf(2);gr;gr;gf(2);ge;
endtsuglyph;

% #39 Yuugiri
begintsuglyph("genjimon39",108)
  gbk(2,0);
  gb(1);gf(2);gr;gs(1);gx;gr;gf(2);ge;
  gp(2,3);
  gj(3,5);
endtsuglyph;

% #40 Minori
begintsuglyph("genjimon40",109)
  gbk(0,1);
  gj(1,4);
  gb(2);gf(2);gr;gs(1);gx;gr;gf(2);ge;
  gp(3,3);
endtsuglyph;

% #41 Maboroshi
begintsuglyph("genjimon41",110)
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gp(3,2);
  gp(4,2);
endtsuglyph;

% #42 Ninounomiya
begintsuglyph("genjimon42",111)
  gbk(2,0);
  gb(1);gf(2);gr;gs(1);gx;gr;gf(2);ge;
  gtt(2,2);
  gj(3,5);
endtsuglyph;

% #43 Koubai
begintsuglyph("genjimon43",112)
  gbk(0,0);
  gp(1,1);
  gj(2,5);
  gp(3,2);
  gp(4,2);
endtsuglyph;

% #44 Takegawa
begintsuglyph("genjimon44",113)
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gs(1);gr;gf(2);ge;
  gtt(3,2);
endtsuglyph;

% #45 Hashihime
begintsuglyph("genjimon45",114)
  gbk(0,0);
  gj(1,5);
  gp(2,2);
  gtt(3,1);
  gtt(4,1);
endtsuglyph;

% #46 Shii ga Moto
begintsuglyph("genjimon46",115)
  gbk(0,0);
  gj(1,4);
  gb(2);gf(2);gr;gr;gf(2);ge;
  gp(5,1);
endtsuglyph;

% #47 Agemaki
begintsuglyph("genjimon47",116)
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gr;gf(2);ge;
  gtt(4,1);
endtsuglyph;

% #48 Sawarabi
begintsuglyph("genjimon48",117)
  gbk(0,0);
  gj(1,2);
  gj(3,5);
  gp(4,2);
endtsuglyph;

% #49 Yadorigi
begintsuglyph("genjimon49",118)
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gp(3,2);
  gtt(4,1);
endtsuglyph;

% #50 Azumaya
begintsuglyph("genjimon50",119)
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gp(3,2);
  gp(4,2);
endtsuglyph;

% #51 Ukifune
begintsuglyph("genjimon51",120)
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gr;gf(2);ge;
  gp(4,2);
endtsuglyph;

% #52 Kagerou
begintsuglyph("genjimon52",121)
  gbk(0,0);
  gj(1,5);
  gb(2);gf(2);gr;gx;gr;gf(2);ge;
  gtt(3,1);
endtsuglyph;

% #53 Tenarai
begintsuglyph("genjimon53",122)
  gbk(0,0);
  gj(1,5);
  gtt(2,1);
  gtt(3,1);
  gtt(4,1);
endtsuglyph;

% #54 Yumi no Ukihashi
begintsuglyph("genjimon54",123)
  gbk(0,0);
  gb(1);gf(1);gr;gr;gf(1);gl;gl;gf(1);gr;gr;gf(1);gl;gl;gf(1);ge;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
