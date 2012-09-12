%
% Unicode page 52 (Kanji) for Tsukurimashou
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
input bottomrad.mp;
input buildkanji.mp;
input gradeeight.mp;
input gradefive.mp;
input gradefour.mp;
input gradenine.mp;
input gradeone.mp;
input gradesix.mp;
input gradethree.mp;
input gradetwo.mp;
input leftrad.mp;
input radical.mp;
input rare.mp;
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grtwo.before =
  tsu_xform(identity yscaled (780/720))
  (build_kanji.level(build_kanji.tb(570,0)
    (build_kanji.sscale(xscaled 0.6)(kanji.toprad.sparkle_two);
     push_stroke((70,120)--(930,120),(1.6,1.6)--(1.6,1.6));
     set_boserif(0,0,whatever);
     set_boserif(0,1,9);
     )
    (build_kanji.lr(560,30)
       (kanji.bottomrad.moon)
       (kanji.rightrad.sword))));
enddef;

vardef kanji.grtwo.cut =
  build_kanji.level(build_kanji.lr(450,80)
    (kanji.leftrad.seven)
    (kanji.grtwo.sword));
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grthree.exertion =
  push_pbox_toexpand("kanji.grthree.exertion");
  build_kanji.extend_ltail_enclose(520,30)
    (kanji.greight.dismiss)
    (kanji.grone.power);
  expand_pbox;
enddef;

vardef kanji.grthree.help =
  push_pbox_toexpand("kanji.grthree.help");
  build_kanji.level(build_kanji.lr(420,20)
    (build_kanji.lift_skirt(230,170)
       (build_kanji.sscale(yscaled 0.7)
          (kanji.greight.furthermore);
        replace_strokep(0)(oldp shifted (0,-80));
        replace_strokep(-3)((point 0 of oldp shifted (0,-80))--
          (subpath (1,length oldp-1) of oldp)--
          (point infinity of oldp shifted (0,-80)))))
    (kanji.grone.power));
  expand_pbox;
enddef;

vardef kanji.grthree.victory =
  push_pbox_toexpand("kanji.grthree.victory");
  build_kanji.level(build_kanji.lr(380,30*(1-mincho))
    (kanji.grone.moon)
    (build_kanji.tb(320,100)
       (build_kanji.sscale(yscaled 0.4 shifted (0,230))
          (kanji.toprad.sparkle_two);
        kanji.grone.person;
        build_kanji.sscale(xyscaled (1,0.37) shifted (0,-40))
          (kanji.grone.two);
        replace_strokep(-2)
          (subpath (xpart (oldp intersectiontimes get_strokep(-1)),infinity)
           of oldp))
    (build_kanji.sscale(xscaled 0.8 shifted (20,0))
      (kanji.grone.power))));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfour.auxilliary =
  push_pbox_toexpand("kanji.grfour.auxilliary");
  build_kanji.level(build_kanji.lr(620,10)
    (kanji.rare.roll_of_cloth)
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

vardef kanji.grfour.courage =
  push_pbox_toexpand("kanji.grfour.courage");
  build_kanji.level(build_kanji.tb(640,80)
    (push_stroke((220,740)--(750,740)..tension 1.2..(620,380)..(490,140),
       (1.6,1.6)--(1.6,1.6)--(1.4,1.4)--(1.1,1.1));
     set_botip(0,1,0);
     set_boserif(0,1,4);
     push_stroke((340,410)..tension 1.2..(490,140)..(520,20),
       (1.1,1.1)--(1.5,1.5)--(1.8,1.8)))
    (kanji.grone.man));
  expand_pbox;
enddef;

vardef kanji.grfour.labour =
  push_pbox_toexpand("kanji.grfour.labour");
  build_kanji.tb(740,100)
    (kanji.toprad.alt_sparkle_three)
    (build_kanji.tb(580,150)
       (kanji.radical.conservative_hat)
       (kanji.grone.power));
  expand_pbox;
enddef;

vardef kanji.grfour.merit =
  push_pbox_toexpand("kanji.grfour.merit");
  build_kanji.level(build_kanji.lr(380,60)
    (tsu_xform(identity shifted (0,50))(build_kanji.lift_skirt(400,250)
       (kanji.grtwo.craft)))
    (kanji.grone.power));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.grfive.judge =
  push_pbox_toexpand("kanji.grfive.judge");
  build_kanji.level(build_kanji.lr(560,20)
    (kanji.grtwo.half)
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

vardef kanji.grfive.publication =
  push_pbox_toexpand("kanji.grfive.publication");
  build_kanji.level(build_kanji.lr(560,0)
    (kanji.grsix.dry)
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef kanji.greight.cut_the_grass =
  push_pbox_toexpand("kanji.greight.cut_the_grass");
  build_kanji.level(build_kanji.lr(560,30)
    (kanji.radical.cut_the_grass)
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

vardef kanji.greight.temple =
  push_pbox_toexpand("kanji.greight.temple");
  build_kanji.level(build_kanji.lr(560,0)
    (build_kanji.tb(600,-20)
       (kanji.radical.cut_the_grass)
       (kanji.leftrad.wood))
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

vardef kanji.greight.whittle =
  push_pbox_toexpand("kanji.greight.whittle");
  build_kanji.level(build_kanji.lr(560,30)
    (kanji.greight.resemblance)
    (kanji.rightrad.sword));
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef build_kanji.extend_ltail_enclose(expr splitpoint,overlap)
  (text leftstuff)(text rightstuff) =
  perl_structure:=perl_structure&"'eids.u2FFA.1_4.2_3',[";
  push_pbox_toexpand("build_kanji.extend_ltail_enclose");
  perl_structure:=perl_structure&"]],";
  begingroup
    save myxf,ele_curve,i,fsi;
    transform myxf[];
    numeric ele_curve,i,fsi;
    (50,-50) transformed myxf1=(50,90);
    (50,850) transformed myxf1=(50,850);
    (950,850) transformed myxf1=(870,850);
    build_kanji.lr(splitpoint,overlap)
      (perl_structure:=perl_structure&"],";
       leftstuff;
       ele_curve:=last_ltail)
      (tsu_xform(myxf1)(rightstuff);
       perl_structure:=perl_structure&"],[[");
    obstackp[ele_curve]:=
      subpath (0,length obstackp[ele_curve]-6) of obstackp[ele_curve];
    obstackq[ele_curve]:=
      subpath (0,length obstackq[ele_curve]-6) of obstackq[ele_curve];
    i:=0;
    forever:
      fsi:=find_stroke(i);
      if fsi=last_ltail:
        build_kanji.add_ltail(i);
      fi;
      exitif fsi=last_ltail;
      i:=i-1;
    endfor;
    (ulcorner obstackp[ele_curve]) transformed myxf2=
      ulcorner obstackp[ele_curve];
    (llcorner obstackp[ele_curve]) transformed myxf2=
      llcorner obstackp[ele_curve];
    (xpart lrcorner obstackp[ele_curve],-50) transformed myxf2=
      (930,-50);
    obstackp[ele_curve]:=obstackp[ele_curve] transformed myxf2;
  endgroup;
  perl_structure:=perl_structure&"[";
  expand_pbox;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tou/katana "sword"
begintsuglyph("uni5200",0);
  kanji.grtwo.sword;
  tsu_render;
endtsuglyph;

% tou "sword radical"
begintsuglyph("uni5202",2);
  kanji.rightrad.sword;
  tsu_render;
endtsuglyph;

% bun/wa "minute" or "understand" (wakarimasu ka?)
begintsuglyph("uni5206",6);
  kanji.grtwo.minute;
  tsu_render;
endtsuglyph;

% setsu/ki "cut"
begintsuglyph("uni5207",7);
  kanji.grtwo.cut;
  tsu_render;
endtsuglyph;

% gai/ka "mow"
begintsuglyph("uni5208",8);
  kanji.greight.cut_the_grass;
  tsu_render;
endtsuglyph;

% kan "publication"
begintsuglyph("uni520A",10);
  kanji.grfive.publication;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni520C",12);
  build_kanji.level(build_kanji.lr(560,0)
    (kanji.grsix.inch)
    (kanji.rightrad.sword));
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni5215",21);
  build_kanji.level(build_kanji.tricluster(1)
    (kanji.grtwo.sword)
    (kanji.grtwo.sword)
    (kanji.grtwo.sword));
  tsu_render;
endtsuglyph;

% extra: punishment by cutting off the feet (wtf?)
begintsuglyph("uni5216",22);
  build_kanji.level(build_kanji.lr(560,30)
     (kanji.grone.moon)
     (kanji.rightrad.sword));
  tsu_render;
endtsuglyph;

% retsu "column"
begintsuglyph("uni5217",23);
  kanji.grthree.column;
  tsu_render;
endtsuglyph;

% extra: kill, destroy
begintsuglyph("uni5218",24);
  build_kanji.level(build_kanji.lr(560,0)
     (build_kanji.tb(600,-20)
        (kanji.radical.kettle_lid)
        (kanji.radical.cut_the_grass))
     (kanji.rightrad.sword));
  tsu_render;
endtsuglyph;

% han/kawa "judge"
begintsuglyph("uni5224",36);
  kanji.grfive.judge;
  tsu_render;
endtsuglyph;

% ri/ki "advantage"
begintsuglyph("uni5229",41);
  kanji.grfour.advantage;
  tsu_render;
endtsuglyph;

% extra: punishment by cutting off the ears
begintsuglyph("uni5235",53);
  build_kanji.level(build_kanji.lr(560,30)
     (tsu_xform(identity yscaled (760/720))(kanji.grone.ear))
     (kanji.rightrad.sword));
  tsu_render;
endtsuglyph;

% satsu "temple/central pillar of pagoda"
begintsuglyph("uni5239",57);
  kanji.greight.temple;
  tsu_render;
endtsuglyph;

% soku/notto "conform"
begintsuglyph("uni5247",71);
  kanji.grfive.conform;
  tsu_render;
endtsuglyph;

% saku/kezu "whittle, sharpen, plane"
begintsuglyph("uni524A",74);
  kanji.greight.whittle;
  tsu_render;
endtsuglyph;

% zen/mae "before"
begintsuglyph("uni524D",77);
  kanji.grtwo.before;
  tsu_render;
endtsuglyph;

% extra: "stab"
begintsuglyph("uni525A",90);
  build_kanji.level(build_kanji.lr(650,40)
    (kanji.grthree.thing)
    (kanji.rightrad.sword));
  tsu_render;
endtsuglyph;

% extra: "brand" (probably yet another criminal punishment)
begintsuglyph("uni5260",96);
  build_kanji.level(build_kanji.lr(650,0)
    (kanji.grtwo.capital)
    (kanji.rightrad.sword));
  tsu_render;
endtsuglyph;

% fuku/soi "auxilliary" (also "adverb")
begintsuglyph("uni526F",111);
  kanji.grfour.auxilliary;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni527B",123);
  build_kanji.level(build_kanji.lr(650,0)
    (kanji.greight.demolish)
    (kanji.rightrad.sword));
  tsu_render;
endtsuglyph;

% ryoku "power", as in Koizumi Itsuki has teh "chounouryoku"
begintsuglyph("uni529B",155);
  kanji.grone.power;
  tsu_render;
endtsuglyph;

% kou/isao "merit"
begintsuglyph("uni529F",159);
  kanji.grfour.merit;
  tsu_render;
endtsuglyph;

% kuwa "addition", also "Canada"
begintsuglyph("uni52A0",160);
  kanji.grfour.addition;
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni52A6",166);
  build_kanji.level(build_kanji.tricluster(0.85)
    (kanji.grone.power)
    (kanji.grone.power)
    (kanji.grone.power));
  tsu_render;
endtsuglyph;

% jo/tasu "help"
begintsuglyph("uni52A9",169);
  kanji.grthree.help;
  tsu_render;
endtsuglyph;

% rou/ita "labour"
begintsuglyph("uni52B4",180);
  kanji.grfour.labour;
  tsu_render;
endtsuglyph;

% yuu/isa "courage"
begintsuglyph("uni52C7",199);
  kanji.grfour.courage;
  tsu_render;
endtsuglyph;

% ben/tsuto "exertion"
begintsuglyph("uni52C9",201);
  kanji.grthree.exertion;
  tsu_render;
endtsuglyph;

% dou/ugo "motion"
begintsuglyph("uni52D5",213);
  kanji.grthree.motion;
  tsu_render;
endtsuglyph;

% shou/ka "victory"
begintsuglyph("uni52DD",221);
  kanji.grthree.victory;
  tsu_render;
endtsuglyph;

% hou/tsutsu "wrapping radical"
begintsuglyph("uni52F9",249);
  kanji.radical.wrapping;
  tsu_render;
endtsuglyph;

% shaku "ladle" (also a unit of measure)
begintsuglyph("uni52FA",250);
  kanji.grnine.ladle;
  tsu_render;
endtsuglyph;

% mochi/naka "not", esp. "must not"
begintsuglyph("uni52FF",255);
  kanji.grnine.must_not;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
