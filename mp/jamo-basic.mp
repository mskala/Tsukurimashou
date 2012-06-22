%
% Hangul basic jamo for Jieubsida
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

inclusion_lock(jamobasic);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FILLER JAMO

% filler for jamo not yet defined
vardef hangul.jamo.bigx(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.bigx");
    push_stroke((100,800)--(900,0),(1.5,1.5)--(1.5,1.5));
    push_stroke((900,800)--(100,0),(1.5,1.5)--(1.5,1.5));
    expand_pbox);
enddef;

% 230 head empty
hangul.jamo[230]code="jamo.empty";
hangul.jamo[230]w=0;
hangul.jamo[230]h=0;

% 500 tail empty
hangul.jamo[500]code="jamo.empty";
hangul.jamo[500]w=0;
hangul.jamo[500]h=0;

vardef hangul.jamo.empty(expr vow,ixf,oxf) =
  % do nothing
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SIOS/CIEUC/CHIEUCH FAMILY

% this defines eighteen jamo that are closely related
% "bars" = 0, 1, or 2, number of horizontal strokes to add to sios
%        0 = sios, 1 = cieuc, 2 = chieuch
% "shove" = -1, 0, or 1, direction to shift top junction
%        -1 = ceongchieum (left), 0 = (centre), 1 = chiteum (right)
% "isalt" = boolean, use "alternate" form

vardef hangul.jamo.sjc(expr bars,shove,isalt)(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(if bars=2: 7 else: 5 fi,ixf,oxf))(
    begingroup
      push_pbox_toexpand("jamo.sjc");
      save x,y;
      numeric x[],y[];
      
      if bars=2:
        push_stroke((320,790)..(510,790)..(680,790+10*mincho),
          (1.5,1.5)--(1.5,1.5)--(1.5,1.5));
        set_boserif(0,0,5);
        set_boserif(0,2,6);

        z7=(180,600);
        z8=(530,y7);
        z9=(820,y7+20*mincho);
      else:
        z7=(270,740);
        z8=(530,y7);
        z9=(730,y7+20*mincho);
      fi;
      
      if bars>0:
        push_stroke(z7..z8..z9,(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
        set_boserif(0,0,5);
        if (not isalt) and not (shove=-1):
          set_boserif(0,2,6);
        fi;
      fi;

      if shove=0:
        z1=(530,if bars>0: y7-30+10*bars else: 720 fi);
        if isalt:
          z3=mincho[(170,140),(120,140)];
          z2=(390-20*mincho,((390-y3)/(720-y3))*(y1-y3)+y3);
        else:
          z3=mincho[(200,50),(120,20)];
          z2=(400-20*mincho,((340-y3)/(720-y3))*(y1-y3)+y3);
        fi;
      elseif shove=1:
        z1=(780,if bars>0: y7-30+30*bars else: 720 fi);
        if isalt:
          z3=mincho[(130,140),(80,140)];
          z2=(540-20*mincho,((390-y3)/(720-y3))*(y1-y3)+y3);
        else:
          z3=mincho[(160,50),(80,20)];
          z2=(550-20*mincho,((340-y3)/(720-y3))*(y1-y3)+y3);
        fi;
      elseif shove=-1:
        z1=(320,if bars>0: y7-30+10*bars else: 720 fi);
        if isalt:
          z3=mincho[(140,210),(90,210)];
          z2=(260-20*mincho,((430-y3)/(720-y3))*(y1-y3)+y3);
        else:
          z3=mincho[(200,50),(120,20)];
          z2=(280-20*mincho,((340-y3)/(720-y3))*(y1-y3)+y3);
        fi;
      fi;
      
      push_stroke(z1..tension 1.2..z2..z3,(1.6,1.6)--(1.5,1.5)--(1,1));
      if bars=0:
        set_boserif(0,0,8);
      fi;
      
      z4=point 0.25 of get_strokep(0);
      if shove=0:
        if isalt:
          z6=mincho[(740,180),(710,220)];
        else:
          z6=(810,70);
        fi;
        z5=(620+20*mincho,((360-y6)/(720-y6))*(y1-y6)+y6);
      elseif shove=1:
        if isalt:
          z6=mincho[(940,180),(910,220)];
          z5=(770+20*mincho,((390-y6)/(720-y6))*(y1-y6)+y6);
        else:
          z6=(810,70);
          z5=(750+20*mincho,((360-y6)/(720-y6))*(y1-y6)+y6);
        fi;
      elseif shove=-1:
        if isalt:
          z6=mincho[(870,80),(840,130)];
          z5=(520+20*mincho,((360-y6)/(720-y6))*(y1-y6)+y6);
        else:
          z6=(850,70);
          z5=(520+20*mincho,((330-y6)/(720-y6))*(y1-y6)+y6);
        fi;
      fi;
      
      push_stroke(z4..tension 1.2..z5..z6,
        (1,1)--(1.3,1.3)--(1.7,1.7));

      if bars=2:
        set_bosize(-2,89);
        set_bosize(-1,89);
        set_bosize(0,89);
      fi;
      expand_pbox;
    endgroup);
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% KIYEOK

% 100 lead G
hangul.jamo[100]code="jamo.maybealt_kiyeok";
hangul.jamo[100]h=5;
hangul.jamo[100]w=3;
hangul.jamo[100]lb=450;
hangul.jamo[100]rb=800;
hangul.jamo[100]ub=820;
hangul.jamo[100]db=300;

% 101 lead GG
hangul.jamo[101]code="combine.lr(100,100)";
hangul.jamo[101]w=5;

% 501 tail G
hangul.jamo[501]code="jamo.kiyeok";
hangul.jamo[501]lb=450;
hangul.jamo[501]rb=800;
hangul.jamo[501]ub=820;
hangul.jamo[501]db=400;

% 502 tail GG
hangul.jamo[502]code="combine.lr(501,501)";
hangul.jamo[502]w=5;

vardef hangul.jamo.kiyeok(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.kiyeok");
    push_stroke((190+70*mincho,680)--(800,680+20*mincho)..tension 1.2..
        (800-20*mincho,420)..(800-100*mincho,70),
      (1.5,1.5)--(1.6,1.6)--(1.5,1.5)--(1.1,1.1));
    set_boserif(0,0,5);
    set_boserif(0,1,4);
    set_botip(0,1,1);
    expand_pbox);
enddef;

% 200 lead alt-G
hangul.jamo[200]code="jamo.alt_kiyeok";
hangul.jamo[200]h=5;
hangul.jamo[200]w=3;
hangul.jamo[200]lb=450;
hangul.jamo[200]rb=800;
hangul.jamo[200]ub=710;
hangul.jamo[200]db=300;

vardef hangul.jamo.alt_kiyeok(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.alt_kiyeok");
    push_stroke((190+80*mincho,680)--(840-20*mincho,680+20*mincho)..
        tension 1.2..(560,360)..(40,50),
      (1.5,1.5)--(1.6,1.6)--(1.4,1.4)--(1,1));
    set_boserif(0,0,5);
    set_boserif(0,1,4);
    set_botip(0,1,0);
    expand_pbox);
enddef;

vardef hangul.jamo.maybealt_kiyeok(expr vow,ixf,oxf) =
  if unknown vow:
    hangul.jamo.kiyeok(vow,ixf,oxf);
  elseif hangul.jamo[vow]invokes_alternate:
    hangul.jamo.alt_kiyeok(vow,ixf,oxf);
  else:
    hangul.jamo.kiyeok(vow,ixf,oxf);
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NIEUN

% 102 lead N
hangul.jamo[102]code="jamo.maybealt_nieun";
hangul.jamo[102]w=2.5;
hangul.jamo[102]lb=190;
hangul.jamo[102]rb=700;
hangul.jamo[102]ub=400;
hangul.jamo[102]db=140;

% 202 lead alt-N
hangul.jamo[202]code="jamo.alt_nieun";
hangul.jamo[202]w=2.5;
hangul.jamo[202]lb=190;
hangul.jamo[202]rb=700;
hangul.jamo[202]ub=400;
hangul.jamo[202]db=140;

% 504 tail N
hangul.jamo[504]code="jamo.nieun";
hangul.jamo[504]lb=190;
hangul.jamo[504]rb=700;
hangul.jamo[504]ub=400;
hangul.jamo[504]db=140;

% 604 tail alt-N
hangul.jamo[604]code="jamo.alt_nieun";
hangul.jamo[604]lb=190;
hangul.jamo[604]rb=700;
hangul.jamo[604]ub=400;
hangul.jamo[604]db=140;

vardef hangul.jamo.nieun_inside =
  push_stroke(interpath(mincho,
      (190,680)--(190,240)--(190,140)--(310,140)--(770,140),
      (190,680)--(190,240){down}..(220,160)..{right}(310,140)--(770,140)),
    (1.6,1.6)--(1.5,1.5)--(1.5,1.5)--(1.6,1.6)--(1.5,1.5));
  set_boserif(0,0,8);
  set_boserif(0,4,6);
  set_botip(0,2,1);
enddef;

vardef hangul.jamo.nieun(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.nieun");
    hangul.jamo.nieun_inside;
    expand_pbox);
enddef;

vardef hangul.jamo.alt_nieun_inside =
  push_stroke(interpath(mincho,
      (190,680)--(190,340)--(190,140)--(310,140)--(800,140),
      (190,680)--(190,340){down}..(220,160)..{right}(310,140)..
      (520,160)..(810,260)),
    (1.6,1.6)--(1.5,1.5)--(1.5,1.5)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
  set_boserif(0,0,8);
  set_botip(0,2,1);
enddef;

vardef hangul.jamo.alt_nieun(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(1,ixf,oxf))(
    push_pbox_toexpand("jamo.alt_nieun");
    hangul.jamo.alt_nieun_inside;
    expand_pbox);
enddef;

vardef hangul.jamo.maybealt_nieun(expr vow,ixf,oxf) =
  if unknown vow:
    hangul.jamo.nieun(vow,ixf,oxf);
  elseif hangul.jamo[vow]invokes_alternate:
    hangul.jamo.alt_nieun(vow,ixf,oxf);
  else:
    hangul.jamo.nieun(vow,ixf,oxf);
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TIKEUT

% 103 lead D
hangul.jamo[103]code="jamo.maybealt_tikeut";
hangul.jamo[103]lb=190;
hangul.jamo[103]rb=500;
hangul.jamo[103]ub=850;
hangul.jamo[103]db=140;

% 104 lead DD
hangul.jamo[104]code="combine.lr(203,103)";

% 203 lead alt-D
hangul.jamo[203]code="jamo.alt_tikeut";
hangul.jamo[203]lb=190;
hangul.jamo[203]rb=500;
hangul.jamo[203]ub=850;
hangul.jamo[203]db=140;

% 507 tail D
hangul.jamo[507]code="jamo.tikeut";
hangul.jamo[507]lb=190;
hangul.jamo[507]rb=500;
hangul.jamo[507]ub=850;
hangul.jamo[507]db=140;

% 607 tail alt-D
hangul.jamo[607]code="jamo.alt_tikeut";
hangul.jamo[607]lb=190;
hangul.jamo[607]rb=500;
hangul.jamo[607]ub=850;
hangul.jamo[607]db=140;

vardef hangul.jamo.tikeut_inside(expr ixf) =
  push_stroke((120+40*mincho,700+(15/yypart ixf)*mincho)..
      (500,700)..(760,700+10*mincho),
    (1.5,1.5)--(1.4,1.4)--(1.4,1.4));
  set_boserif(0,2,6);
enddef;

vardef hangul.jamo.tikeut(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.tikeut");
    hangul.jamo.tikeut_inside(ixf);
    hangul.jamo.nieun_inside;
    expand_pbox);
enddef;

vardef hangul.jamo.alt_tikeut_inside(expr ixf) =
  push_stroke((120+40*mincho,700+(15/yypart ixf)*mincho)..
      (520,700)..(810,700+10*mincho),
    (1.5,1.5)--(1.4,1.4)--(1.4,1.4));
enddef;

vardef hangul.jamo.alt_tikeut(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(1,ixf,oxf))(
    push_pbox_toexpand("jamo.alt_tikeut");
    hangul.jamo.alt_tikeut_inside(ixf);
    hangul.jamo.alt_nieun_inside;
    expand_pbox);
enddef;

vardef hangul.jamo.maybealt_tikeut(expr vow,ixf,oxf) =
  if unknown vow:
    hangul.jamo.tikeut(vow,ixf,oxf);
  elseif hangul.jamo[vow]invokes_alternate:
    hangul.jamo.alt_tikeut(vow,ixf,oxf);
  else:
    hangul.jamo.tikeut(vow,ixf,oxf);
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RIEUL

% 105 lead R
hangul.jamo[105]code="jamo.maybealt_rieul";
hangul.jamo[105]lb=160;
hangul.jamo[105]rb=780;
hangul.jamo[105]ub=830;
hangul.jamo[105]db=50;

% 508 tail L
hangul.jamo[508]code="jamo.rieul";
hangul.jamo[508]lb=160;
hangul.jamo[508]rb=780;
hangul.jamo[508]ub=830;
hangul.jamo[508]db=50;

% 608 tail alt-L
hangul.jamo[608]code="jamo.alt_rieul";
hangul.jamo[608]lb=160;
hangul.jamo[608]rb=780;
hangul.jamo[608]ub=830;
hangul.jamo[608]db=50;

vardef hangul.jamo.rieul(expr vow,ixf,oxf) =
  hangul.jamo.kiyeok(whatever,hxf((50,780),(850,340)) transformed ixf,oxf);
  hangul.jamo.tikeut(vow,hxf((80,500),(930,0)) transformed ixf,oxf);
  replace_strokep(-1)(subpath (0,0.14-0.22*mincho+
    xpart (oldp intersectiontimes
    ((xpart point infinity of get_strokep(-2),-50)--
       (xpart point infinity of get_strokep(-2),850)))) of oldp);
enddef;

% 205 lead alt-R
hangul.jamo[205]code="jamo.alt_rieul";
hangul.jamo[205]lb=160;
hangul.jamo[205]rb=780;
hangul.jamo[205]ub=830;
hangul.jamo[205]db=50;

vardef hangul.jamo.alt_rieul(expr vow,ixf,oxf) =
  hangul.jamo.kiyeok(whatever,hxf((50,780),(850,340)) transformed ixf,oxf);
  hangul.jamo.alt_tikeut(vow,hxf((80,500),(930,0)) transformed ixf,oxf);
  replace_strokep(-1)(subpath (0,0.14-0.22*mincho+
    xpart (oldp intersectiontimes
    ((xpart point infinity of get_strokep(-2),-50)--
       (xpart point infinity of get_strokep(-2),850)))) of oldp);
enddef;

vardef hangul.jamo.maybealt_rieul(expr vow,ixf,oxf) =
  if unknown vow:
    hangul.jamo.rieul(vow,ixf,oxf);
  elseif hangul.jamo[vow]invokes_alternate:
    hangul.jamo.alt_rieul(vow,ixf,oxf);
  else:
    hangul.jamo.rieul(vow,ixf,oxf);
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MIEUM

% 106 lead M
hangul.jamo[106]code="jamo.mieum";
hangul.jamo[106]lb=170;
hangul.jamo[106]rb=790;
hangul.jamo[106]ub=760;
hangul.jamo[106]db=150;

% 516 tail M
hangul.jamo[516]code="jamo.mieum";
hangul.jamo[516]lb=170;
hangul.jamo[516]rb=790;
hangul.jamo[516]ub=760;
hangul.jamo[516]db=150;

vardef hangul.jamo.mieum(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.mieum");
    push_stroke((120+40*mincho,700+(15/yypart ixf)*mincho)..
        (500,700)..{curl 1}(780,700+10*mincho){curl 1}..tension 1.2..
        (780-10*mincho,420)..(780-30*mincho,150),
      (1.5,1.5)--(1.4,1.4)--(1.5,1.5)--(1.4,1.4)--(1.1,1.1));
    set_boserif(0,2,4);
    set_botip(0,2,1);
    push_stroke((190,680)--(190,110),(1.6,1.6)--(1.5,1.5));
    set_boserif(0,0,8);
    push_stroke((190,170)..(0.5[(190,170),(820,160)]+(0,-15)*mincho)..
        (820,160),
      (1.5,1.5)--(1.5,1.5));
    expand_pbox);
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PIEUP

% 107 lead B
hangul.jamo[107]code="jamo.pieup";
hangul.jamo[107]lb=200;
hangul.jamo[107]rb=800;
hangul.jamo[107]h=5;

% 108 lead BB
hangul.jamo[108]code="combine.lr(207,107)";
hangul.jamo[108]h=5;
hangul.jamo[108]w=5;

% 517 tail B
hangul.jamo[517]code="jamo.pieup";
hangul.jamo[517]lb=200;
hangul.jamo[517]rb=800;
hangul.jamo[517]h=5;

vardef hangul.jamo.pieup(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.pieup");
    push_stroke((260,700-40*mincho)--(260,110),(1.6,1.6)--(1.5,1.5));
    set_boserif(0,0,8);
    push_stroke((260,450-10*mincho)--(740,450),(1.5,1.5)--(1.5,1.5));
    push_stroke((740,700)--(740,120),(1.6,1.6)--(1.5,1.5));
    set_boserif(0,0,8);
    push_stroke((260,170-10*mincho)--(740,170),(1.5,1.5)--(1.5,1.5));
    expand_pbox);
enddef;

% 207 lead alt-B
hangul.jamo[207]code="jamo.alt_pieup";

vardef hangul.jamo.alt_pieup(expr vow,ixf,oxf) =
  hangul.jamo.pieup(vow,
    hxf((50,850-100*mincho),(950,-50+30*mincho)) transformed ixf,oxf);
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SIOS

% 109 lead S
hangul.jamo[109]code="jamo.sjc(0,0,false)";
hangul.jamo[109]lb=250;
hangul.jamo[109]rb=700;

% 110 lead SS
hangul.jamo[110]code="combine.lr(209,109)";

% 519 tail S
hangul.jamo[519]code="jamo.sjc(0,0,false)";
hangul.jamo[519]lb=250;
hangul.jamo[519]rb=700;

% 520 tail SS
hangul.jamo[520]code="combine.lr(619,519)";

% 209 lead alt-S
hangul.jamo[209]code="jamo.sjc(0,0,true)";
hangul.jamo[209]lb=250;
hangul.jamo[209]rb=700;

% 619 tail alt-S
hangul.jamo[619]code="jamo.sjc(0,0,true)";
hangul.jamo[619]lb=250;
hangul.jamo[619]rb=700;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% IEUNG

% 111 lead empty (=NG)
hangul.jamo[111]code="jamo.ieung";
hangul.jamo[111]h=5;

% 521 tail NG
hangul.jamo[521]code="jamo.ieung";
hangul.jamo[521]h=3;

vardef hangul.jamo.ieung(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.ieung");
    if unknown vow:
      push_stroke((530,750)..(200,375)..(500,0)..(800,375)..cycle,
        (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--cycle);
    elseif (vow>=313) and (vow<=319):
      push_stroke((530,750)..(200,425)..(500,100)..(800,425)..cycle,
        (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--cycle);
    else:
      push_stroke((530,750)..(200,375)..(500,0)..(800,375)..cycle,
        (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--cycle);
    fi;
    set_boserif(0,0,6);
    expand_pbox);
  replace_strokep(0)(insert_nodes(oldp)(0.5,1.5,2.5,3.5));
  replace_strokeq(0)(insert_nodes(oldq)(0.5,1.5,2.5,3.5));
  begingroup
    save i,j,t;
    numeric i,j,t;
    i:=-1;
    forever:
      j:=find_whatever(otstroke,i);
      exitif j=0;
      j:=xpart (get_strokep(i) intersectiontimes get_strokep(0));
      if (j>0) and (j<1):
        replace_strokep(i)(subpath (j,infinity) of oldp);
      fi;
      if known tsu_do_serif[8]:
        if 0<ypart (get_strokep(0) intersectiontimes
            (((-80,80)+point 0 of get_strokep(i))--get_strokep(i))):
          set_boserif(i,0,whatever);
        fi;
      fi;
      i:=i-1;
    endfor;
  endgroup;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CIEUC

% 112 lead J
hangul.jamo[112]code="jamo.sjc(1,0,false)";
hangul.jamo[112]lb=250;
hangul.jamo[112]rb=700;

% 113 lead JJ
hangul.jamo[113]code="combine.lr(212,112)";

% 522 tail J
hangul.jamo[522]code="jamo.sjc(1,0,false)";
hangul.jamo[522]lb=250;
hangul.jamo[522]rb=700;

% 212 lead alt-J
hangul.jamo[212]code="jamo.sjc(1,0,true)";
hangul.jamo[212]lb=250;
hangul.jamo[212]rb=700;

% 622 tail alt-J
hangul.jamo[622]code="jamo.sjc(1,0,true)";
hangul.jamo[622]lb=250;
hangul.jamo[622]rb=700;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CHIEUCH

% 114 lead C
hangul.jamo[114]code="jamo.sjc(2,0,false)";
hangul.jamo[114]lb=250;
hangul.jamo[114]rb=700;

% 214 lead alt-C
hangul.jamo[214]code="jamo.sjc(2,0,true)";
hangul.jamo[214]lb=250;
hangul.jamo[214]rb=700;

% 523 tail C
hangul.jamo[523]code="jamo.sjc(2,0,false)";
hangul.jamo[523]lb=250;
hangul.jamo[523]rb=700;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% KHIEUKH

% 115 lead K
hangul.jamo[115]code="jamo.maybealt_khieukh";
hangul.jamo[115]h=5;
hangul.jamo[115]w=3;
hangul.jamo[115]lb=450;
hangul.jamo[115]rb=800;
hangul.jamo[115]ub=820;
hangul.jamo[115]db=300;

% 524 tail K
hangul.jamo[524]code="jamo.khieukh";
hangul.jamo[524]h=5;
hangul.jamo[524]w=3;
hangul.jamo[524]lb=450;
hangul.jamo[524]rb=800;
hangul.jamo[524]ub=820;
hangul.jamo[524]db=300;

vardef hangul.jamo.khieukh(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.khieukh");
    push_stroke((190+70*mincho,680)--(800,680+20*mincho)..tension 1.2..
        (800-20*mincho,420)..(800-100*mincho,70),
      (1.5,1.5)--(1.6,1.6)--(1.5,1.5)--(1.1,1.1));
    set_boserif(0,0,5);
    set_boserif(0,1,4);
    set_botip(0,1,1);
    push_stroke((210+70*mincho,380)--(point 1.9 of get_strokep(0)),
      (1.6,1.6)--(1.5,1.5));
    set_boserif(0,0,5);
    expand_pbox);
enddef;

% 215 lead alt-K
hangul.jamo[215]code="jamo.alt_khieuk";
hangul.jamo[215]h=5;
hangul.jamo[215]w=3;
hangul.jamo[215]lb=450;
hangul.jamo[215]rb=800;
hangul.jamo[215]ub=710;
hangul.jamo[215]db=300;

vardef hangul.jamo.alt_khieukh(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.alt_khieukh");
    push_stroke((190+80*mincho,680)--(840-20*mincho,680+20*mincho)..
        tension 1.2..(560,360)..(40,50),
      (1.5,1.5)--(1.6,1.6)--(1.4,1.4)--(1,1));
    set_boserif(0,0,5);
    set_boserif(0,1,4);
    set_botip(0,1,0);
    push_stroke((210+80*mincho,400)--(point 1.6 of get_strokep(0)),
      (1.5,1.5)--(1.4,1.4));
    set_boserif(0,0,5);
    expand_pbox);
enddef;

vardef hangul.jamo.maybealt_khieukh(expr vow,ixf,oxf) =
  if unknown vow:
    hangul.jamo.khieukh(vow,ixf,oxf);
  elseif hangul.jamo[vow]invokes_alternate:
    hangul.jamo.alt_khieukh(vow,ixf,oxf);
  else:
    hangul.jamo.khieukh(vow,ixf,oxf);
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% THIEUTH

% 116 lead T
hangul.jamo[116]code="jamo.maybealt_thieuth";
hangul.jamo[116]lb=190;
hangul.jamo[116]rb=500;
hangul.jamo[116]ub=850;
hangul.jamo[116]db=140;

% 525 tail T
hangul.jamo[525]code="jamo.thieuth";
hangul.jamo[525]lb=190;
hangul.jamo[525]rb=500;
hangul.jamo[525]ub=850;
hangul.jamo[525]db=140;

vardef hangul.jamo.thieuth(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.thieuth");
    hangul.jamo.tikeut_inside(ixf);
    push_stroke((190,420)..(500,430-20*mincho)..(770,440),
      (1.6,1.6)--(1.5,1.5)--(1.6,1.6));
    set_boserif(0,2,6);
    hangul.jamo.nieun_inside;
    expand_pbox);
enddef;

% 216 lead alt-T
hangul.jamo[216]code="jamo.alt_thieuth";
hangul.jamo[216]lb=190;
hangul.jamo[216]rb=500;
hangul.jamo[216]ub=850;
hangul.jamo[216]db=140;

vardef hangul.jamo.alt_thieuth(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(1,ixf,oxf))(
    push_pbox_toexpand("jamo.alt_thieuth");
    hangul.jamo.alt_tikeut_inside(ixf);
    push_stroke((190,420)..(500,430-20*mincho)..(790,450),
      (1.6,1.6)--(1.5,1.5)--(1.6,1.6));
    hangul.jamo.alt_nieun_inside;
    expand_pbox);
enddef;

vardef hangul.jamo.maybealt_thieuth(expr vow,ixf,oxf) =
  if unknown vow:
    hangul.jamo.thieuth(vow,ixf,oxf);
  elseif hangul.jamo[vow]invokes_alternate:
    hangul.jamo.alt_thieuth(vow,ixf,oxf);
  else:
    hangul.jamo.thieuth(vow,ixf,oxf);
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PHIEUPH

% 117 lead P
hangul.jamo[117]code="jamo.phieuph";
hangul.jamo[117]w=5;
hangul.jamo[117]h=5;
hangul.jamo[117]lb=320;
hangul.jamo[117]rb=690;
hangul.jamo[117]ub=800;
hangul.jamo[117]db=160;

% 526 tail P
hangul.jamo[526]code="jamo.phieuph";
hangul.jamo[526]w=5;
hangul.jamo[526]h=5;
hangul.jamo[526]lb=320;
hangul.jamo[526]rb=690;
hangul.jamo[526]ub=800;
hangul.jamo[526]db=160;

vardef hangul.jamo.phieuph(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.phieuph");
    push_stroke((180,660)--(820,660),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,5);
    set_boserif(0,1,6);
    push_stroke((250,530)..tension 1.2..(350,350)..(380,280),
      (1.1,1.1)--(1.3,1.3)--(1.6,1.6));
    push_stroke((730,550)..tension 1.2..(660,350)..(600,240),
      (1.5,1.5)--(1.4,1.4)--(1.2,1.2));
    push_stroke((120,160)--(880,160),
      (1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,5);
    set_boserif(0,1,6);
    expand_pbox);
  begingroup
    save i,j,t;
    numeric i,j,t;
    i:=-4;
    forever:
      j:=find_whatever(otstroke,i);
      exitif j=0;
      j:=xpart (get_strokep(i) intersectiontimes get_strokep(0));
      if (j>0) and (j<1):
        replace_strokep(i)(subpath (j,infinity) of oldp);
      fi;
      if known tsu_do_serif[8]:
        if 0<ypart (get_strokep(0) intersectiontimes
            (((-50,50)+point 0 of get_strokep(i))--get_strokep(i))):
          set_boserif(i,0,whatever);
        fi;
      fi;
      i:=i-1;
    endfor;
  endgroup;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HIEUH

% 118 lead H
hangul.jamo[118]code="jamo.hieuh";
hangul.jamo[118]h=5;
hangul.jamo[118]lb=200;
hangul.jamo[118]rb=800;

% 527 tail H
hangul.jamo[527]code="jamo.hieuh";
hangul.jamo[527]lb=200;
hangul.jamo[527]rb=800;

% 627 tail right-scooged H
hangul.jamo[627]code="combine.lr(500,527)";
hangul.jamo[627]lb=200;
hangul.jamo[627]rb=800;

vardef hangul.jamo.hieuh(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(7,ixf,oxf))(
    push_pbox_toexpand("jamo.hieuh");
    push_stroke((320,790)..(510,790)..(680,790+10*mincho),
      (1.5,1.5)--(1.5,1.5)--(1.5,1.5));
    set_boserif(0,0,5);
    set_boserif(0,2,6);
    push_stroke((180,600)..(530,600)..(820,600+20*mincho),
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,5);
    set_boserif(0,2,6);
    push_stroke((520,500)..(300,250)..(500,0)..(700,250)..cycle,
      (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--cycle);
    set_boserif(0,0,6);
    set_bosize(-2,89);
    set_bosize(-1,89);
    set_bosize(0,89);
    expand_pbox);
  replace_strokep(0)(insert_nodes(oldp)(0.5,1.5,2.5,3.5));
  replace_strokeq(0)(insert_nodes(oldq)(0.5,1.5,2.5,3.5));
  begingroup
    save i,j,t;
    numeric i,j,t;
    i:=-3;
    forever:
      j:=find_whatever(otstroke,i);
      exitif j=0;
      j:=xpart (get_strokep(i) intersectiontimes get_strokep(0));
      if (j>0) and (j<1):
        replace_strokep(i)(subpath (j,infinity) of oldp);
      fi;
      if known tsu_do_serif[8]:
        if 0<ypart (get_strokep(0) intersectiontimes
            (((-80,80)+point 0 of get_strokep(i))--get_strokep(i))):
          set_boserif(i,0,whatever);
        fi;
      fi;
      i:=i-1;
    endfor;
  endgroup;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MIXED TAILS

% 503 tail GS
hangul.jamo[503]code="combine.lr(501,519)";

% 505 tail NJ
hangul.jamo[505]code="combine.lr(504,522)";

% 506 tail NH
hangul.jamo[506]code="combine.lr(504,527)";

% 509 tail LG
hangul.jamo[509]code="combine.lr(508,501)";

% 510 tail LM
hangul.jamo[510]code="combine.lr(508,516)";

% 511 tail LB
hangul.jamo[511]code="combine.lr(508,517)";

% 512 tail LS
hangul.jamo[512]code="combine.lr(508,519)";

% 513 tail LT
hangul.jamo[513]code="combine.lr(508,525)";

% 514 tail LP
hangul.jamo[514]code="combine.lr(508,526)";

% 515 tail LH
hangul.jamo[515]code="combine.lr(508,527)";
hangul.jamo[515]h=5;

% 518 tail BS
hangul.jamo[518]code="combine.lr(517,519)";
hangul.jamo[518]h=5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% VOWELS

% 300 vowel A
hangul.jamo[300]code="jamo.a";
hangul.jamo[300]w=2.5;
hangul.jamo[300]h=0;
hangul.jamo[300]lb=400;
hangul.jamo[300]rb=700;
hangul.jamo[300]ub=850;
hangul.jamo[300]db=100;

% 301 vowel AE
hangul.jamo[301]code="combine.lr(300,320)";
hangul.jamo[301]w=3;
hangul.jamo[301]h=0;
hangul.jamo[301]lb=340;
hangul.jamo[301]db=100;

vardef hangul.jamo.a(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(11,ixf,oxf))(
    push_pbox_toexpand("jamo.a");
    push_stroke((440,820)--(440-10*mincho,0),(1.6,1.6)--(1.4,1.4));
    set_boserif(0,0,8);
    push_stroke((450,310)--(930-120*mincho,310+10*mincho),
      (1.5,1.5)--(1.7,1.7));
    set_boserif(0,1,6);
    expand_pbox);
enddef;

% 302 vowel YA
hangul.jamo[302]code="jamo.ya";
hangul.jamo[302]w=3;
hangul.jamo[302]h=0;
hangul.jamo[302]lb=400;
hangul.jamo[302]rb=700;
hangul.jamo[302]ub=850;
hangul.jamo[302]db=100;

% 303 vowel YAE
hangul.jamo[303]code="combine.lr(302,320)";
hangul.jamo[303]w=3.5;
hangul.jamo[303]h=0;
hangul.jamo[303]lb=340;
hangul.jamo[303]db=100;

vardef hangul.jamo.ya(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(11,ixf,oxf))(
    push_pbox_toexpand("jamo.ya");
    push_stroke((440,820)--(440-10*mincho,0),(1.6,1.6)--(1.4,1.4));
    set_boserif(0,0,8);
    push_stroke((450,520)--(930-120*mincho,520+10*mincho),
      (1.5,1.5)--(1.7,1.7));
    set_boserif(0,1,6);
    push_stroke((450,270)--(930-120*mincho,270+10*mincho),
      (1.5,1.5)--(1.7,1.7));
    set_boserif(0,1,6);
    expand_pbox);
enddef;

% 304 vowel EO
hangul.jamo[304]code="jamo.eo";
hangul.jamo[304]w=2.5;
hangul.jamo[304]h=0;
hangul.jamo[304]lb=300;
hangul.jamo[304]rb=640;
hangul.jamo[304]ub=850;
hangul.jamo[304]db=100;

% 305 vowel E
hangul.jamo[305]code="combine.lr(304,320)";
hangul.jamo[305]w=3;
hangul.jamo[305]h=0;
hangul.jamo[305]lb=300;
hangul.jamo[305]db=100;

vardef hangul.jamo.eo(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(11,ixf,oxf))(
    push_pbox_toexpand("jamo.eo");
    push_stroke((560,820)--(560-10*mincho,0),(1.6,1.6)--(1.4,1.4));
    set_boserif(0,0,8);
    if unknown vow: vow=304; fi;
    if vow=435:
      push_stroke((70+100*mincho,110)--(550,110+10*mincho),
        (1.7,1.7)--(1.5,1.5));
    elseif vow=448:
      push_stroke((70+100*mincho,410)--(550,410+10*mincho),
        (1.7,1.7)--(1.5,1.5));
    elseif (vow>=308) and (vow<454):
      push_stroke((70+100*mincho,210)--(550,210+10*mincho),
        (1.7,1.7)--(1.5,1.5));
    else:
      push_stroke((70+100*mincho,310)--(550,310+10*mincho),
        (1.7,1.7)--(1.5,1.5));
    fi;
    set_boserif(0,0,5);
    expand_pbox);
enddef;

% 306 vowel YEO
hangul.jamo[306]code="jamo.yeo";
hangul.jamo[306]w=2.5;
hangul.jamo[306]h=0;
hangul.jamo[306]lb=300;
hangul.jamo[306]rb=640;
hangul.jamo[306]ub=850;
hangul.jamo[306]db=100;

% 307 vowel YE
hangul.jamo[307]code="combine.lr(306,320)";
hangul.jamo[307]w=3;
hangul.jamo[307]h=0;
hangul.jamo[307]lb=300;
hangul.jamo[307]db=100;

vardef hangul.jamo.yeo(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(11,ixf,oxf))(
    push_pbox_toexpand("jamo.yeo");
    push_stroke((560,820)--(560-10*mincho,0),(1.6,1.6)--(1.4,1.4));
    set_boserif(0,0,8);
   push_stroke((70+100*mincho,520)--(550,520+10*mincho),
     (1.7,1.7)--(1.5,1.5));
   set_boserif(0,0,5);
    if unknown vow: vow=304; fi;
    if vow>=308:
      push_stroke((70+100*mincho,190)--(550,190+10*mincho),
        (1.7,1.7)--(1.5,1.5));
      if vow<=420:
        set_boserif(0,0,5);
      fi;
    else:
      push_stroke((70+100*mincho,270)--(550,270+10*mincho),
        (1.7,1.7)--(1.5,1.5));
      set_boserif(0,0,5);
    fi;
    expand_pbox);
enddef;

% 308 vowel O
hangul.jamo[308]code="jamo.o";
hangul.jamo[308]w=0;
hangul.jamo[308]h=3;
hangul.jamo[308]invokes_alternate=false;

% 309 vowel WA
hangul.jamo[309]code="combine.lr(308,300)";
hangul.jamo[309]w=2;
hangul.jamo[309]invokes_alternate=false;

% 310 vowel WAE
hangul.jamo[310]code="combine.lr(308,301)";
hangul.jamo[310]w=3;
hangul.jamo[310]invokes_alternate=false;

% 311 vowel OE
hangul.jamo[311]code="combine.lr(308,320)";
hangul.jamo[311]w=1;
hangul.jamo[311]invokes_alternate=false;

vardef hangul.jamo.o(expr vow,ixf,oxf) =
  begingroup
    save myxf;
    transform myxf[];
    myxf1=hxf_inout(13,ixf,oxf);
    hgbox_ll transformed myxf3=
      0.1[hgbox_ll transformed myxf1,
          hgbox_ll transformed oxf];
    hgbox_ur transformed myxf3=
      (0.4*mincho)[hgbox_ur transformed myxf1,
          hgbox_ur transformed oxf];
    if unknown vow: vow=308; fi;
    if vow=308:
      hgbox_lr transformed myxf3=
        0.3[hgbox_lr transformed myxf1,
            hgbox_lr transformed oxf];
      myxf2=hxf((50,750),(950,-50)) transformed myxf3;
    else:
      (hgbox_ur transformed myxf3)-(hgbox_lr transformed myxf3)=
        (hgbox_ur transformed myxf1)-(hgbox_lr transformed myxf1);
      myxf2=myxf3;
    fi;
    tsu_xform(myxf2)(
      push_pbox_toexpand("jamo.o");
      push_stroke((540,900-100*mincho)--(540,350-10*mincho),
        (1.6,1.6)--(1.5,1.5));
      set_boserif(0,0,8);
      push_stroke((120,350)..(500,350-10*mincho)..(920,350),
        (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
      set_boserif(0,0,5);
      expand_pbox);
  endgroup;
enddef;

% 312 vowel YO
hangul.jamo[312]code="jamo.yo";
hangul.jamo[312]w=0;
hangul.jamo[312]h=3;
hangul.jamo[312]invokes_alternate=false;

% "yo" isn't normally used in compounds, but let's keep the code for that
vardef hangul.jamo.yo(expr vow,ixf,oxf) =
  begingroup
    save myxf;
    transform myxf[];
    myxf1=hxf_inout(13,ixf,oxf);
    hgbox_ll transformed myxf3=
      0.1[hgbox_ll transformed myxf1,
          hgbox_ll transformed oxf];
    hgbox_ur transformed myxf3=
      (0.3*mincho)[hgbox_ur transformed myxf1,
          hgbox_ur transformed oxf];
    if unknown vow: vow=312; fi;
    if vow=312:
      hgbox_lr transformed myxf3=
        0.2[hgbox_lr transformed myxf1,
            hgbox_lr transformed oxf];
      myxf2=hxf((50,750),(950,-50)) transformed myxf3;
    else:
      (hgbox_ur transformed myxf3)-(hgbox_lr transformed myxf3)=
        (hgbox_ur transformed myxf1)-(hgbox_lr transformed myxf1);
      myxf2=myxf3;
    fi;
    tsu_xform(myxf2)(
      push_pbox_toexpand("jamo.yo");
      push_stroke((420,900-110*mincho)--(420,350-10*mincho),
        (1.6,1.6)--(1.5,1.5));
      set_boserif(0,0,8);
      push_stroke((660,900-90*mincho)--(660,350-10*mincho),
        (1.6,1.6)--(1.5,1.5));
      set_boserif(0,0,8);
      push_stroke((120,350)..(390,350-10*mincho)..
          (690,350-10*mincho)..(920,350),
        (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6));
      set_boserif(0,0,5);
      expand_pbox);
  endgroup;
enddef;

% 313 vowel U
hangul.jamo[313]code="jamo.u";
hangul.jamo[313]w=0;
hangul.jamo[313]h=3;
hangul.jamo[313]db=150;
hangul.jamo[313]invokes_alternate=false;

% 314 vowel WEO
hangul.jamo[314]code="combine.lr(313,304)";
hangul.jamo[314]w=2;
hangul.jamo[314]db=150;
hangul.jamo[314]invokes_alternate=false;

% 315 vowel WE
hangul.jamo[315]code="combine.lr(313,305)";
hangul.jamo[315]w=3;
hangul.jamo[315]db=150;
hangul.jamo[315]invokes_alternate=false;

% 316 vowel WI
hangul.jamo[316]code="combine.lr(313,320)";
hangul.jamo[316]w=1;
hangul.jamo[316]db=150;
hangul.jamo[316]invokes_alternate=false;

vardef hangul.jamo.u(expr vow,ixf,oxf) =
  begingroup
    save myxf;
    transform myxf[];
    myxf1=hxf_inout(13,ixf,oxf);
    hgbox_ll transformed myxf3=
      0.2[hgbox_ll transformed myxf1,
          hgbox_ll transformed oxf];
    hgbox_ur transformed myxf3=
      0.2[hgbox_ur transformed myxf1,
          hgbox_ur transformed oxf];
    if unknown vow: vow=313; fi;
    if vow=313:
      hgbox_lr transformed myxf3=
        0.1[hgbox_lr transformed myxf1,
            hgbox_lr transformed oxf];
      myxf2=hxf((50,600),(950,-50)) transformed myxf3;
    else:
      (hgbox_ur transformed myxf3)-(hgbox_lr transformed myxf3)=
        (hgbox_ur transformed myxf1)-(hgbox_lr transformed myxf1);
      myxf2=myxf3;
    fi;
    tsu_xform(myxf2)(
      push_pbox_toexpand("jamo.o");
      push_stroke((540,700)--(540,50+100*mincho),
        (1.6,1.6)--(1.5,1.5));
      set_boserif(0,1,7);
      push_stroke((120,700)--(920,700),(1.6,1.6)--(1.6,1.6));
      set_boserif(0,0,5);
      expand_pbox);
  endgroup;
enddef;

% 317 vowel YU
hangul.jamo[317]code="jamo.yu";
hangul.jamo[317]w=0;
hangul.jamo[317]h=3;
hangul.jamo[317]db=150;
hangul.jamo[317]invokes_alternate=false;

vardef hangul.jamo.yu(expr vow,ixf,oxf) =
  begingroup
    save myxf;
    transform myxf[];
    myxf1=hxf_inout(13,ixf,oxf);
    hgbox_ll transformed myxf3=
      0.2[hgbox_ll transformed myxf1,
          hgbox_ll transformed oxf];
    hgbox_ur transformed myxf3=
      0.2[hgbox_ur transformed myxf1,
          hgbox_ur transformed oxf];
    if unknown vow: vow=317; fi;
    if vow=317:
      hgbox_lr transformed myxf3=
        0.1[hgbox_lr transformed myxf1,
            hgbox_lr transformed oxf];
      myxf2=hxf((50,600),(950,-50)) transformed myxf3;
    else:
      (hgbox_ur transformed myxf3)-(hgbox_lr transformed myxf3)=
        (hgbox_ur transformed myxf1)-(hgbox_lr transformed myxf1);
      myxf2=myxf3;
    fi;
    tsu_xform(myxf2)(
      push_pbox_toexpand("jamo.yu");
      push_stroke((120,700)--(930,700),(1.6,1.6)--(1.6,1.6));
      set_boserif(0,0,5);
      push_stroke((400,700)--(400,50+100*mincho),
        (1.6,1.6)--(1.5,1.5));
      set_boserif(0,1,7);
      push_stroke((640,700)--(640,50+100*mincho),
        (1.6,1.6)--(1.5,1.5));
      set_boserif(0,1,7);
      expand_pbox);
  endgroup;
enddef;

% 318 vowel EU
hangul.jamo[318]code="jamo.eu";
hangul.jamo[318]w=0;
hangul.jamo[318]h=3;
hangul.jamo[318]invokes_alternate=false;

% 319 vowel YI
hangul.jamo[319]code="combine.lr(318,320)";
hangul.jamo[319]w=2;
hangul.jamo[319]h=3;
hangul.jamo[319]invokes_alternate=false;

vardef hangul.jamo.eu(expr vow,ixf,oxf) =
  begingroup
    save myxf;
    transform myxf[];
    myxf1=hxf_inout(13,ixf,oxf);
    hgbox_ll transformed myxf3=
      0.1[hgbox_ll transformed myxf1,
          hgbox_ll transformed oxf];
    hgbox_ur transformed myxf3=
      0.1[hgbox_ur transformed myxf1,
          hgbox_ur transformed oxf];
    if unknown vow: vow=318; fi;
    if vow=318:
      hgbox_lr transformed myxf3=
        0.1[hgbox_lr transformed myxf1,
            hgbox_lr transformed oxf];
      myxf2=hxf((50,600),(950,-50)) transformed myxf3;
    else:
      (hgbox_ur transformed myxf3)-(hgbox_lr transformed myxf3)=
        (hgbox_ur transformed myxf1)-(hgbox_lr transformed myxf1);
      myxf2=myxf3;
    fi;
    tsu_xform(myxf2)(
      push_pbox_toexpand("jamo.eu");
      push_stroke((120,520)--(925,520),(1.6,1.6)--(1.6,1.6));
      set_boserif(0,0,5);
      expand_pbox);
  endgroup;
enddef;

% 320 vowel I
hangul.jamo[320]code="jamo.i";
hangul.jamo[320]w=1.5;
hangul.jamo[320]h=0;
hangul.jamo[320]lb=490;
hangul.jamo[320]rb=540;
hangul.jamo[320]ub=850;
hangul.jamo[320]db=-50;
hangul.jamo[320]invokes_alternate=false;

vardef hangul.jamo.i(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(10,ixf,oxf))(
    push_pbox_toexpand("jamo.i");
    push_stroke((500,820)--(500,400)--(500-10*mincho,0),
      (1.6,1.6)--(1.5,1.5)--(1.4,1.4));
    set_boserif(0,0,8);
    expand_pbox);
enddef;
