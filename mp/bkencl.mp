%
% Enclosure operations for building kanji
% Copyright (C) 2011, 2012, 2013, 2015  Matthew Skala
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

inclusion_lock(bkencl);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef build_kanji.cliff_enclose(text contents) =
  push_pbox_toexpand("build_kanji.cliff_enclose");
  perl_structure:=perl_structure&"'eids.u2FF8.u5382.1_',";
  push_stroke((50,-50)..(120,100)..(160,300)..tension 1.2..(180,760)
      --(850,760),
    (1,1)--(1.3,1.3)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,3,1);
  begingroup
    save t;
    transform t;
    (50,-50) transformed t=(230,-50);
    (500,-50) transformed t=(560,-50);
    (500,850) transformed t=(560,730);
    tsu_xform(t)(contents);
  endgroup;
  expand_pbox;
enddef;

vardef build_kanji.dotcliff_enclose(text contents) =
  push_pbox_toexpand("build_kanji.dotcliff_enclose");
  perl_structure:=perl_structure&"'eids.u2FF8.u5E7F.2_',";
  push_stroke((550,810)--(550,660),
    (1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,10);
  push_stroke(
    (50,-50)..(120,100)..(160,300)..tension 1.2..(180,660)--(850,660),
    (1,1)--(1.3,1.3)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6));
  set_botip(0,3,1);
  begingroup
    save t;
    transform t;
    (50,-50) transformed t=(230,-50);
    (500,-50) transformed t=(560,-50);
    (500,850) transformed t=(560,630);
    tsu_xform(t)(contents);
  endgroup;
  expand_pbox;
enddef;

vardef build_kanji.flag_enclose(expr xs,ys)(text contents) =
  push_pbox_toexpand("build_kanji.flag_enclose");
  perl_structure:=perl_structure&"'eids.u2FF8.u5C38.1_',";
  string flag_enclose.ps;
  flag_enclose.ps:=perl_structure;
  build_kanji.lr(460,60)
    (kanji.grtwo.direction;)
    (perl_structure:=flag_enclose.ps;
     push_stroke((300,810)..tension 1.2..(220,600)..(110,480),
       (1.6,1.6)--(1.4,1.4)--(1,1));
     set_boserif(0,0,10);
     push_stroke((100,680)--(780,680),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,1,9);
     replace_strokep(0)(subpath
       (0.01+xpart (oldp intersectiontimes get_strokep(-1)),1) of oldp);
     tsu_xform(identity shifted (-500,0) xyscaled (xs,ys)
         shifted (500,-20))
       (contents);
     flag_enclose.ps:=perl_structure);
  expand_pbox;
  perl_structure:=flag_enclose.ps&"],";
enddef;

vardef build_kanji.gate_enclose(text contents) =
  perl_structure:=perl_structure&"['build_kanji.gate_enclose',";
  perl_structure:=perl_structure&"'eids.u2FF5.u9580.1_',";
  kanji.grtwo.gate;
  begingroup
    transform xf;
    (50,-50) transformed xf=(220,40);
    (950,850) transformed xf=(780,420);
    xypart xf=yxpart xf=0;
    tsu_xform(xf)(contents);
  endgroup;
  perl_structure:=perl_structure&"],";
enddef;

% note special calling convention - extra boolean for inclusion of "tick"
% seen in some Japanese and Korean characters
vardef build_kanji.long_stride_enclose(expr do_tick)(text contents) =
  push_pbox_toexpand("build_kanji.long_stride_enclose");
  perl_structure:=perl_structure&"'eids.u2FFA.u5EF4._3',";
  begingroup
    save myxf;
    transform myxf;
    (50,850) transformed myxf=(350,810);
    (50,-50) transformed myxf=(350,80);
    (950,-50) transformed myxf=(950,80);
    tsu_xform(myxf)(contents);
    save x,y;
    numeric x[],y[];
    x1=80;
    x2=260;
    x4=120;
    y1=y2=780;
    y4=460;
    z3=0.4[z4,z2]+mincho*(30,0);
    z5=(0.3-0.5*mincho)[z4,z2];
    push_stroke(z1--z2..tension 1.2..z3..z5,
      (1.6,1.6)--(1.6,1.6)--(1.6-0.1*mincho,1.6-0.1*mincho)--
        (1.6-0.2*mincho,1.6-0.2*mincho));
    set_boserif(0,1,4);
    set_botip(0,1,0);
    x7=0;
    x9=300;
    x10=220;
    x11=100;
    y7=y9=y4;
    y10=80;
    y11=-70;
    z6=point 2.2 of get_strokep(0);
    z8=(z7--z9) intersectionpoint (get_strokep(0)--((-1)[z4,z2]));
    push_stroke(z6--z8--z9..tension 1.2..z10..z11,
      (1.6-0.5*mincho,1.6-0.5*mincho)--(1.5-0.1*mincho,1.5-0.1*mincho)--
      (1.6,1.6)--(1.4,1.4)--(1,1));
    set_boserif(0,2,4);
    set_botip(0,1,1);
    set_botip(0,2,0);
    if do_tick:
      push_stroke((150,330)..(120,290)..(60,220),
        (1.2,1.2)--(1.1,1.1)--(1.6,1.6));
    fi;
    push_stroke((130,300)..(390,30)..tension 1.6..(900,-50),
      (1,1)--(1.6,1.6)--(1.9,1.9));
  endgroup;
  expand_pbox;
enddef;

vardef build_kanji.road_enclose(text contents) =
  push_pbox_toexpand("build_kanji.road_enclose");
  perl_structure:=perl_structure&"'eids.u2FFA.u2ECC._3',";
  begingroup
    save myxf;
    transform myxf;
    (50,850) transformed myxf=(315,850);
    (50,-50) transformed myxf=(315,50);
    (950,-50) transformed myxf=(950,50);
    tsu_xform(myxf)(contents);
    push_stroke((100,770)..tension 1.2..(180,690)..(220,630),
      (1,1)--(1.3,1.3)--(1.9,1.9));
    set_bosize(0,92);
    push_stroke((80,453)--(240,450)..(mincho[230,210],250)
        ..tension 1.2..(mincho[180,140],50)..{curl 0.4}(60,-40),
      (1.4,1.4)--(1.6,1.6)--(1.4,1.4)--(1.2,1.2)--(1,1));
    set_botip(0,1,1);
    set_botip(0,2,1);
    set_boserif(0,1,4);
    set_bosize(0,92);
    push_stroke((point (2.3+mincho) of get_strokep(0))
         {(1-2*mincho)*direction (2.3+mincho) of get_strokep(0)}..
         (240,100)..(270,45+15*mincho)..(400,-10)..tension 3..(950,-20),
      (1,1)--(1.1,1.1)--(1.1,1.1)--(1.7,1.7)--(1.9,1.9));
    set_bosize(0,92);
  endgroup;
  expand_pbox;
enddef;

vardef build_kanji.steam_enclose(expr ur)(text contents) =
  push_pbox_toexpand("build_kanji.steam_enclose");
  begingroup
    save xfa,xfb,xfc,xfd;
    transform xfa,xfb,xfc,xfd;
    (50,-50) transformed xfc=(50,-50);
    (950,850) transformed xfc=ur;
    xypart xfc=yxpart xfc=0;
    tsu_xform(xfc)(contents);

    (0,0) transformed xfa=(0,950) transformed xfc;
    (1,1) transformed xfa=(280,810);
    xypart xfa=yxpart xfa=0;
    (0,0) transformed xfb=(1100,950) transformed xfc;
    (1,1) transformed xfb=(970,810);
    xypart xfb=yxpart xfb=0;
    (0,1) transformed xfd=(1100,950) transformed xfc;
    (1,0) transformed xfd=(1000,-50);
    xypart xfd=yxpart xfd=0;

    push_stroke(((1,1)..tension 1.2..(0.5,0.45)..(0,0.2)) transformed xfa,
      (1.7,1.7)--(1.5,1.5)--(1.2,1.2));
    set_boserif(0,0,10);
    set_bosize(0,90);
    
    push_stroke((get_strokep(0) intersectionpoint
        (((0,0.8)--(1,0.8)) transformed xfa))--
        ((0.5,0.8) transformed xfb),
      (1.5,1.5)--(1.6,1.6));
    set_boserif(0,1,9);
    set_bosize(0,90);
    
    push_stroke(((0.8,0.4) transformed xfa)--((0.15,0.4) transformed xfb),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,1,9);
    set_bosize(0,90);

    push_stroke(((0.2,0) transformed xfa)--(interpath(mincho,
      (0,1)..tension 1.6..(0.4,0)..(0.6,0)..tension 1.5..
        (0.73,0.2)..(0.8,0.4),
      (0,1)..tension 1.6..(0.25,0.2)..{right}(0.8,0){curl 1}..
       (0.6,0.2)..(0.6,0.4)
      ) transformed xfd),
      (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--
        (1.4,1.4)--(1.2,1.2)--(0.9,0.9));
    set_boserif(0,1,4);
    set_botip(0,1,1);
    set_bosize(0,90);
  endgroup;
  expand_pbox;
enddef;

vardef build_kanji.wind_enclose(text contents) =
  push_pbox_toexpand("build_kanji.wind_enclose");
  push_stroke((50,-50)..(120,100)..(160,300)..tension 1.2..(180,760)
      --interpath(mincho,
      (770,760){down}..{dir -72}(810,-20)..(860,-10)..tension 1.5..
        (890,100)..(910,200),
      (760,760){down}..(780,100)..{right}(910,-40){curl 1}..
        (890,60)..(890,160)),
    (1,1)--(1.3,1.3)--(1.5,1.5)--(1.6,1.6)--(1.6,1.6)--
      (1.4,1.4)--(1.4,1.4)--(1.2,1.2)--(0.9,0.9));
  set_botip(0,3,1);
  set_botip(0,4,1);
  set_boserif(0,3,4);
  set_boserif(0,4,4);
  begingroup
    save t;
    transform t;
    (50,-50) transformed t=(230,-50);
    (950,-50) transformed t=(700,-50);
    (950,850) transformed t=(700,660+20*mincho);
    tsu_xform(t)(contents);
  endgroup;
  expand_pbox;
enddef;
