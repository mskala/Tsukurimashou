%
% Extra (not in Unicode syllable block) hangul jamo for Jieubsida
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

inclusion_lock(jamoextra);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% special alternate vowel codes (used for non-syllable vowel jamo)
% 421 yo-ya
% 422 yo-yae
% 423 yo-i
% 424 yu-yeo
% 425 yu-ye
% 426 yu-i
% 427 araea-i
% 428 araea
% 429 o-eo
% 430 o-e
% 431 o-ye
% 432 yo-yeo
% 433 u-a
% 434 u-ae
% 435 u-eo-eu
% 436 u-ye
% 437 yu-a
% 438 yu-eo
% 439 yu-e
% 440 yi-u
% 441 i-araea
% 442 o-ya
% 443 o-yae
% 444 o-yeo
% 445 o-o-i
% 446 yo-a
% 447 yo-ae
% 448 yo-eo
% 449 u-yeo
% 450 u-i-i
% 451 yu-ae
% 452 yu-o
% 453 eu -a
% 454 eu-eo
% 455 eu-e
% 456 eu-o
% 457 i-ya-o
% 458 i-yae
% 459 i-yeo
% 460 i-ye
% 461 i-o-i
% 462 i-yo
% 463 i-yu
% 464 i-i
% 465 araea-a
% 466 araea-e
% 467 i-ya
% 468 o-i

% 428 vowel ARAEA
hangul.jamo[428]code="jamo.araea";
hangul.jamo[428]w=0;
hangul.jamo[428]h=2;
hangul.jamo[428]invokes_alternate=false;

vardef hangul.jamo.araea(expr vow,ixf,oxf) =
  begingroup
    save tmpxf;
    transform tmpxf;
    if unknown vow: vow=428; fi;
    tmpxf=hxf_inout(if vow=441: 1 else: 5 fi,ixf,oxf);
    tsu_xform(tmpxf)(
      push_pbox_toexpand("jamo.araea");
      expand_pbox);
    push_lcblob(fullcircle
      scaled ((140+40*mincho)*sqrt(sqrt(xxpart tmpxf*yypart tmpxf)))
      shifted ((if vow=441: 500 else: 540 fi,390) transformed tmpxf));
  endgroup;
enddef;

% 445 vowel O-O-I
hangul.jamo[445]code="jamo.ooi";
hangul.jamo[445]w=0;
hangul.jamo[445]h=5;
hangul.jamo[445]invokes_alternate=false;

vardef hangul.jamo.ooi(expr vow,ixf,oxf) =
  begingroup
    save xfa,xfb;
    transform xfa,xfb;

    (50,-50) transformed xfa=(50,450) transformed hxf_inout(5,ixf,oxf);
    (950,-50) transformed xfa=(950,450) transformed hxf_inout(5,ixf,oxf);
    (50,850) transformed xfa=(50,1050) transformed hxf_inout(5,ixf,oxf);
    hangul.combine.tb(308,308)(vow,xfa,xfa);

    (50,-50) transformed xfb=(90,-50) transformed hxf_inout(5,ixf,oxf);
    (950,-50) transformed xfb=(990,-50) transformed hxf_inout(5,ixf,oxf);
    (50,850) transformed xfb=(90,350) transformed hxf_inout(5,ixf,oxf);
    hangul.jamo.i(vow,xfb,xfb);
  endgroup;
enddef;

% 464 vowel I-I
hangul.jamo[464]code="combine.lr(320,320)";
hangul.jamo[464]w=3;
hangul.jamo[464]h=0;
hangul.jamo[464]invokes_alternate=false;

% 467 vowel I-YA
hangul.jamo[467]code="combine.lr(320,302)";
hangul.jamo[467]w=4;
hangul.jamo[467]h=0;
hangul.jamo[467]invokes_alternate=false;

% 468 vowel O-I (for I-O-I)
hangul.jamo[468]code="jamo.oi";
hangul.jamo[468]w=0;
hangul.jamo[468]h=5;
hangul.jamo[468]invokes_alternate=false;

vardef hangul.jamo.oi(expr vow,ixf,oxf) =
  begingroup
    save xfa,xfb;
    transform xfa,xfb;

    (50,-50) transformed xfa=(50,450) transformed hxf_inout(5,ixf,oxf);
    (950,-50) transformed xfa=(950,450) transformed hxf_inout(5,ixf,oxf);
    (50,850) transformed xfa=(50,1050) transformed hxf_inout(5,ixf,oxf);
    hangul.jamo.o(vow,xfa,xfa);

    (50,-50) transformed xfb=(90,-50) transformed hxf_inout(5,ixf,oxf);
    (950,-50) transformed xfb=(990,-50) transformed hxf_inout(5,ixf,oxf);
    (50,850) transformed xfb=(90,350) transformed hxf_inout(5,ixf,oxf);
    hangul.jamo.i(vow,xfb,xfb);
  endgroup;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PANSIOS

% 219 lead "letter that died out in the 16th century and nobody is sure
%   how it was prounounced"
hangul.jamo[219]code="jamo.pansios";
hangul.jamo[219]lb=250;
hangul.jamo[219]rb=700;

% 628 tail LTDOIT16CANISHIWP
hangul.jamo[628]code="jamo.pansios";
hangul.jamo[628]lb=250;
hangul.jamo[628]rb=700;

vardef hangul.jamo.pansios(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.pansios");
    push_stroke((675,375+20*mincho)--(500,660+40*mincho)--
        (150,90+10*mincho)--(850,90)--cycle,
      (1.4,1.4)--(1.2,1.2)--(1.6,1.6)--(1.6,1.6)--(1.4,1.4));
    set_boserif(0,1,8);
    set_botip(0,1,1);
    set_botip(0,2,1);
    set_botip(0,3,1);
    replace_strokep(0)(oldp--(point 0.05 of oldp));
    replace_strokeq(0)(oldq--(point 0.05 of oldq));
    expand_pbox);
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YESIEUNG

% 220 lead NG (mnemonic: "yes, REALLY ieung, as opposed to 'ieung' which
%   actually is 'empty' when in the lead")
hangul.jamo[220]code="jamo.yesieung";
hangul.jamo[220]h=5;

% 629 tail NG
hangul.jamo[629]code="jamo.yesieung";
hangul.jamo[629]h=5;

vardef hangul.jamo.yesieung(expr vow,ixf,oxf) =
  tsu_xform(ixf)(
    push_pbox_toexpand("jamo.yesieung");
    push_stroke((500,750)--(500,660),(1.6,1.6)--(1.5,1.5));
    set_boserif(0,0,8);
    if unknown vow:
      push_stroke((500,660)..(200,335)..(500,0)..(800,335)..cycle,
        (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--cycle);
    elseif (vow>=313) and (vow<=319):
      push_stroke((500,660)..(200,385)..(500,100)..(800,385)..cycle,
        (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--cycle);
    else:
      push_stroke((500,660)..(200,335)..(500,0)..(800,335)..cycle,
        (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--cycle);
    fi;
    expand_pbox);
  replace_strokep(0)(insert_nodes(oldp)(0.5,1.5,2.5,3.5));
  replace_strokeq(0)(insert_nodes(oldq)(0.5,1.5,2.5,3.5));
  begingroup
    save i,j,t;
    numeric i,j,t;
    i:=-2;
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

% YEORINHIEUH

% 221 lead ` (W'dia says medium-strength glottal stop)
hangul.jamo[221]code="jamo.yeorinhieuh";
hangul.jamo[221]h=5;
hangul.jamo[221]lb=200;
hangul.jamo[221]rb=800;

% 631 tail `
hangul.jamo[631]code="jamo.yeorinhieuh";
hangul.jamo[631]h=5;
hangul.jamo[631]lb=200;
hangul.jamo[631]rb=800;

vardef hangul.jamo.yeorinhieuh(expr vow,ixf,oxf) =
  tsu_xform(hxf_inout(7,ixf,oxf))(
    push_pbox_toexpand("jamo.yieorinhieuh");
    push_stroke((180,780)..(530,780)..(820,780+20*mincho),
      (1.6,1.6)--(1.6,1.6)--(1.6,1.6));
    set_boserif(0,0,5);
    set_boserif(0,2,6);
    push_stroke((520,650)..(300,325)..(500,0)..(700,325)..cycle,
      (1.6,1.6)--(1.5,1.5)--(1.4,1.4)--(1.5,1.5)--cycle);
    set_boserif(0,0,6);
    expand_pbox);
  replace_strokep(0)(insert_nodes(oldp)(0.5,1.5,2.5,3.5));
  replace_strokeq(0)(insert_nodes(oldq)(0.5,1.5,2.5,3.5));
  begingroup
    save i,j,t;
    numeric i,j,t;
    i:=-2;
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

% CHITUEUM AND CEONGCHIEUM VARIANTS

% 222 lead right-shoved S
hangul.jamo[222]code="jamo.sjc(0,1,false)";
hangul.jamo[222]lb=250;
hangul.jamo[222]rb=700;

% 223 lead alt-right-shoved S
hangul.jamo[223]code="jamo.sjc(0,1,true)";
hangul.jamo[223]lb=250;
hangul.jamo[223]rb=700;

% 224 lead left-shoved S
hangul.jamo[224]code="jamo.sjc(0,-1,false)";
hangul.jamo[224]lb=250;
hangul.jamo[224]rb=700;

% 225 lead alt-left-shoved S
hangul.jamo[225]code="jamo.sjc(0,-1,true)";
hangul.jamo[225]lb=250;
hangul.jamo[225]rb=700;

% 226 lead right-shoved J
hangul.jamo[226]code="jamo.sjc(1,1,false)";
hangul.jamo[226]lb=250;
hangul.jamo[226]rb=700;

% 227 lead alt-right-shoved J
hangul.jamo[227]code="jamo.sjc(1,1,true)";
hangul.jamo[227]lb=250;
hangul.jamo[227]rb=700;

% 228 lead left-shoved J
hangul.jamo[228]code="jamo.sjc(1,-1,false)";
hangul.jamo[228]lb=250;
hangul.jamo[228]rb=700;

% 229 lead alt-left-shoved J
hangul.jamo[229]code="jamo.sjc(1,-1,true)";
hangul.jamo[229]lb=250;
hangul.jamo[229]rb=700;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% KAPYEOUN VARIANTS

% 231 lead kapyeounpieup
hangul.jamo[231]code="combine.tb(107,111)";
hangul.jamo[231]h=6;

% 630 tail kapyeounpieup
hangul.jamo[630]code="combine.tb(517,521)";
hangul.jamo[630]h=6;
