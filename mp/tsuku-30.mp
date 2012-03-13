%
% Unicode page 30 (Kana) for Tsukurimashou
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

% AUTODEPS
input dakuten.mp;
input hiragana.mp;
input katakana.mp;
input punct.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% IDEOGRAPHIC SYMBOLS AND PUNCTUATION

% ideographic comma
begintsuglyph("uni3001",1);
   punct.hancomma;
   tsu_render;
endtsuglyph;

% ideographic full stop
begintsuglyph("uni3002",2);
  punct.full_stop;
  tsu_render;
endtsuglyph;

% kanji zero
begintsuglyph("uni3007",7);
   % letter brush for this so it blends better with other kanji digits;
   % let's drag the Japanese kicking and screaming into the Sixth Century!
   push_stroke(fullcircle scaled 760 shifted (480,390),
     (1.6,1.6)--(1.6,1.6)--(1.6,1.6)--(1.6,1.6)--cycle);
   set_bosize(0,90);
   tsu_render;
endtsuglyph;

path bracket[];

% left and right single angle brackets
bracket1:=(880,830)--(580,390)--(880,-50);
begintsuglyph("uni3008",8);
  push_stroke((880,830)--(580,390)--(880,-50),
    (2,2)--(2,2)--(2,2));
  set_bosize(0,120);
  set_botip(0,1,1);
  tsu_render;
endtsuglyph;
begintsuglyph("uni3009",9);
  push_stroke(((880,830)--(580,390)--(880,-50)) rotatedaround (centre_pt,180),
    (2,2)--(2,2)--(2,2));
  set_bosize(0,120);
  set_botip(0,1,1);
  tsu_render;
endtsuglyph;

% left and right double angle brackets
bracket1:=(880-tsu_punct_size*3/2,830)--(580,390)
  --(880-tsu_punct_size*3/2,-50);
bracket2:=(880,830)--(580+tsu_punct_size*3/2,390)--(880,-50);
begintsuglyph("uni300A",10);
  push_stroke(bracket1,
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,1,1);

  push_stroke(bracket2,
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,1,1);

  tsu_render;
endtsuglyph;
begintsuglyph("uni300B",11);
  push_stroke(bracket1 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,1,1);

  push_stroke(bracket2 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,1,1);

  tsu_render;
endtsuglyph;

% left and right corner brackets
begintsuglyph("uni300C",12);
  punct.corner_left;
  tsu_render;
endtsuglyph;
begintsuglyph("uni300D",13);
  punct.corner_right;
  tsu_render;
endtsuglyph;

% left and right white corner brackets
bracket1:=(920,750)--
  (920,750+tsu_punct_size*0.7)--
  (650-tsu_punct_size*0.7,750+tsu_punct_size*0.7)--
  (650-tsu_punct_size*0.7,400-tsu_punct_size*0.7)--
  (650+tsu_punct_size*0.7,400-tsu_punct_size*0.7)--
  (650+tsu_punct_size*0.7,750-tsu_punct_size*0.7)--
  (920,750-tsu_punct_size*0.7)--cycle;
begintsuglyph("uni300E",14);
  push_stroke(bracket1,
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--
     (1.7,1.7)--(1.7,1.7)--cycle);
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_botip(0,4,1);
  set_botip(0,5,1);
  set_botip(0,6,1);

  tsu_render;
endtsuglyph;
begintsuglyph("uni300F",15);
  push_stroke(bracket1 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--
     (1.7,1.7)--(1.7,1.7)--cycle);
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,1);
  set_botip(0,3,1);
  set_botip(0,4,1);
  set_botip(0,5,1);
  set_botip(0,6,1);

  tsu_render;
endtsuglyph;

% left and right white and black lenticular brackets
% grouped here, out of Unicode sequence, to share the outline
bracket1:=(900-2*tsu_punct_size,390){up}..
  (900,800)--(900-3.3*tsu_punct_size,800)--
  (900-3.3*tsu_punct_size,-20)--(900,-20)..
  {up}cycle;
bracket1:=(0.5[point 0.3 of bracket1,point 4.7 of bracket1])--
  subpath (0.3,4.7) of bracket1--cycle;
begintsuglyph("uni3010",16);
  push_stroke(bracket1,
    (2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2)--cycle);
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,0);
  set_botip(0,3,1);
  set_botip(0,4,1);
  set_botip(0,5,0);
  set_botip(0,6,1);
  push_lcblob(get_strokep(0));

  tsu_render;
endtsuglyph;
begintsuglyph("uni3011",17);
  push_stroke(bracket1 rotatedaround (centre_pt,180),
    (2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2)--(2,2)--cycle);
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,0);
  set_botip(0,3,1);
  set_botip(0,4,1);
  set_botip(0,5,0);
  set_botip(0,6,1);
  push_lcblob(get_strokep(0));

  tsu_render;
endtsuglyph;
begintsuglyph("uni3016",22);
  push_stroke(bracket1,
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--
      (1.7,1.7)--(1.7,1.7)--cycle);
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,0);
  set_botip(0,3,1);
  set_botip(0,4,1);
  set_botip(0,5,0);
  set_botip(0,6,1);

  tsu_render;
endtsuglyph;
begintsuglyph("uni3017",23);
  push_stroke(bracket1 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--
      (1.7,1.7)--(1.7,1.7)--cycle);
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,0);
  set_botip(0,3,1);
  set_botip(0,4,1);
  set_botip(0,5,0);
  set_botip(0,6,1);

  tsu_render;
endtsuglyph;

% Japanese postal mark
begintsuglyph("uni3012",18);
   push_stroke((170,680)--(830,680),(1.7,1.7)--(1.7,1.7));

   push_stroke((170,680-2*tsu_punct_size)--(830,680-2*tsu_punct_size),
     (1.7,1.7)--(1.7,1.7));

   push_stroke((500,720-2.5*tsu_punct_size)--(500,-20),
     (1.7,1.7)--(1.7,1.7));

   tsu_render;
endtsuglyph;

% "geta" or substitute mark
begintsuglyph("uni3013",19);
   x2-x1=6*tsu_punct_size;
   0.5[x1,x2]=500;
   y4-y1=4*tsu_punct_size;
   y2-y1=y3-y2=y4-y3;
   0.5[y1,y4]=390;
   dangerousFill
     (x1,y4)--(x1,y3)--(x2,y3)--(x2,y4)--cycle,
     (x1,y2)--(x1,y1)--(x2,y1)--(x2,y2)--cycle;
endtsuglyph;

% left and right plain and white tortoise shell brackets
% grouped here, out of Unicode sequence, to share the outline
bracket1:=(900,800)..
  (900-tsu_punct_size*0.9,800-tsu_punct_size*3/4)..
  {left}(900-2.2*tsu_punct_size,800-tsu_punct_size)--
  (900-2.2*tsu_punct_size,-20+tsu_punct_size){right}..
  (900-tsu_punct_size*0.9,-20+tsu_punct_size*3/4)..
  (900,-20);
bracket2:=(point 1 of bracket1)--(point 4 of bracket1);
begintsuglyph("uni3014",20);
  push_stroke(bracket1,
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,2,1);
  set_botip(0,3,1);

  tsu_render;
endtsuglyph;
begintsuglyph("uni3015",21);
  push_stroke(bracket1 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,2,1);
  set_botip(0,3,1);

  tsu_render;
endtsuglyph;
begintsuglyph("uni3018",24);
  push_stroke(bracket1,
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,2,1);
  set_botip(0,3,1);

  push_stroke(bracket2,
    (1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);

  tsu_render;
endtsuglyph;
begintsuglyph("uni3019",25);
  push_stroke(bracket1 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,2,1);
  set_botip(0,3,1);

  push_stroke(bracket2 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);

  tsu_render;
endtsuglyph;

% left and right white square brackets
bracket1:=(900,780)--
  (900-2.6*tsu_punct_size,780)--
  (900-2.6*tsu_punct_size,0)--
  (900,0);
bracket2:=(point 0.5 of bracket1)--(point 2.5 of bracket1);
begintsuglyph("uni301A",26);
  push_stroke(bracket1,
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,1);

  push_stroke(bracket2,
    (1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);

  tsu_render;
endtsuglyph;
begintsuglyph("uni301B",27);
  push_stroke(bracket1 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7)--(1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);
  set_botip(0,1,1);
  set_botip(0,2,1);

  push_stroke(bracket2 rotatedaround (centre_pt,180),
    (1.7,1.7)--(1.7,1.7));
  set_bosize(0,90);

  tsu_render;
endtsuglyph;

% "wave dash"
begintsuglyph("uni301C",28);
   punct.wavedash;
   bo_serif.a0:=5;
   bo_serif.a6:=8;
   tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HIRAGANA

% hiragana "small a"
begintsuglyph("uni3041",65);
  tsu_xform(tsu_xf.smallkana)(hira.a);
  tsu_render;
endtsuglyph;

% hiragana "a"
begintsuglyph("uni3042",66);
  hira.a;
  tsu_render;
endtsuglyph;

% hiragana "small i"
begintsuglyph("uni3043",67);
  tsu_xform(tsu_xf.smallkana)(hira.i);
  tsu_render;
endtsuglyph;

% hiragana "i"
begintsuglyph("uni3044",68);
  hira.i;
  tsu_render;
endtsuglyph;

% hiragana "small u"
begintsuglyph("uni3045",69);
  tsu_xform(tsu_xf.smallkana)(hira.u);
  tsu_render;
endtsuglyph;

% hiragana "u"
begintsuglyph("uni3046",70);
  hira.u;
  tsu_render;
endtsuglyph;

% hiragana "small e"
begintsuglyph("uni3047",71);
  tsu_xform(tsu_xf.smallkana)(hira.e);
  tsu_render;
endtsuglyph;

% hiragana "e"
begintsuglyph("uni3048",72);
  hira.e;
  tsu_render;
endtsuglyph;

% hiragana "small o"
begintsuglyph("uni3049",73);
  tsu_xform(tsu_xf.smallkana)(hira.o);
  tsu_render;
endtsuglyph;

% hiragana "o"
begintsuglyph("uni304A",74);
  hira.o;
  tsu_render;
endtsuglyph;

% hiragana "ka"
begintsuglyph("uni304B",75);
  hira.ka;
  tsu_render;
endtsuglyph;

% hiragana "ga"
begintsuglyph("uni304C",76);
  hira.ka;
  dakuten(identity shifted (850,730));
  tsu_render;
endtsuglyph;

% hiragana "ki"
begintsuglyph("uni304D",77);
  hira.ki;
  tsu_render;
endtsuglyph;

% hiragana "gi"
begintsuglyph("uni304E",78);
  hira.ki;
  replace_strokep(-2,subpath (0,1.9-0.1*mincho) of oldp);
  replace_strokep(-1,subpath (0,1.95-0.05*mincho) of oldp);
  dakuten(identity rotated -10 shifted (850,730));
  tsu_render;
endtsuglyph;

% hiragana "ku"
begintsuglyph("uni304F",79);
  hira.ku;
  tsu_render;
endtsuglyph;

% hiragana "gu"
begintsuglyph("uni3050",80);
  hira.ku;
  dakuten(identity shifted (700,520));
  tsu_render;
endtsuglyph;

% hiragana "ke"
begintsuglyph("uni3051",81);
  hira.ke;
  tsu_render;
endtsuglyph;

% hiragana "ge"
begintsuglyph("uni3052",82);
  hira.ke;
  dakuten(identity rotated -25 shifted (867,730));
  tsu_render;
endtsuglyph;

% hiragana "ko"
begintsuglyph("uni3053",83);
  hira.ko;
  tsu_render;
endtsuglyph;

% hiragana "go"
begintsuglyph("uni3054",84);
  hira.ko;
  dakuten(identity rotated -7 shifted (860,730));
  tsu_render;
endtsuglyph;

% hiragana "sa"
begintsuglyph("uni3055",85);
  hira.sa;
  tsu_render;
endtsuglyph;

% hiragana "za"
begintsuglyph("uni3056",86);
  hira.sa;
  replace_strokep(-1,subpath (0,2.8) of oldp);
  dakuten(identity rotated -15 shifted (850,730));
  tsu_render;
endtsuglyph;

% hiragana "shi"
begintsuglyph("uni3057",87);
  hira.shi;
  tsu_render;
endtsuglyph;

% hiragana "ji"
begintsuglyph("uni3058",88);
  hira.shi;
  dakuten(identity shifted (740,640));
  tsu_render;
endtsuglyph;

% hiragana "su"
begintsuglyph("uni3059",89);
  hira.su;
  tsu_render;
endtsuglyph;

% hiragana "zu"
begintsuglyph("uni305A",90);
  hira.su;
  dakuten(identity rotated -30 slanted -0.4 xyscaled (1.2,0.8)
    shifted (780,790));
  tsu_render;
endtsuglyph;

% hiragana "se"
begintsuglyph("uni305B",91);
  hira.se;
  tsu_render;
endtsuglyph;

% hiragana "ze"
begintsuglyph("uni305C",92);
  hira.se;
  dakuten(identity rotated 12 shifted (850,740));
  tsu_render;
endtsuglyph;

% hiragana "so"
begintsuglyph("uni305D",93);
  hira.so;
  tsu_render;
endtsuglyph;

% hiragana "zo"
begintsuglyph("uni305E",94);
  hira.so;
  dakuten(identity rotated -5 shifted (860,700));
  tsu_render;
endtsuglyph;

% hiragana "ta"
begintsuglyph("uni305F",95);
  hira.ta;
  tsu_render;
endtsuglyph;

% hiragana "da"
begintsuglyph("uni3060",96);
  hira.ta;
  dakuten(identity rotated 10 shifted (790,670));
  tsu_render;
endtsuglyph;

% hiragana "chi"
begintsuglyph("uni3061",97);
  hira.chi;
  tsu_render;
endtsuglyph;

% hiragna "dji"
begintsuglyph("uni3062",98);
  hira.chi;
  dakuten(identity rotated -20 shifted (850,710));
  tsu_render;
endtsuglyph;

% hiragana "small tsu"
begintsuglyph("uni3063",99);
  tsu_xform(tsu_xf.smallkana)(hira.tsu);
  tsu_render;
endtsuglyph;

% hiragana "tsu"
begintsuglyph("uni3064",100);
  hira.tsu;
  tsu_render;
endtsuglyph;

% hiragana "dzu"
begintsuglyph("uni3065",101);
  hira.tsu;
  dakuten(identity rotated -5 shifted (840,730));
  tsu_render;
endtsuglyph;

% hiragana "te"
begintsuglyph("uni3066",102);
  hira.te;
  tsu_render;
endtsuglyph;

% hiragana "de"
begintsuglyph("uni3067",103);
  hira.te;
  dakuten(identity shifted (770,440));
  tsu_render;
endtsuglyph;

% hiragana "to"
begintsuglyph("uni3068",104);
  hira.toh;
  tsu_render;
endtsuglyph;

% hiragana "do"
begintsuglyph("uni3069",105);
  hira.toh;
  replace_strokep(0,subpath (0.1,infinity) of oldp);
  dakuten(identity rotated (-18+10*mincho)
     shifted ((860,650) shifted (100*mincho*(dir 110))));
  tsu_render;
endtsuglyph;

% hiragna "na"
begintsuglyph("uni306A",106);
  hira.na;
  tsu_render;
endtsuglyph;

% hirgana "ni"
begintsuglyph("uni306B",107);
  hira.ni;
  tsu_render;
endtsuglyph;

% hiragana "nu"
begintsuglyph("uni306C",108);
  hira.nu;
  tsu_render;
endtsuglyph;

% hiragana "ne"
begintsuglyph("uni306D",109);
  hira.ne;
  tsu_render;
endtsuglyph;

% hiragana "no"
begintsuglyph("uni306E",110);
  hira.no;
  tsu_render;
endtsuglyph;

% hiragana "ha"
begintsuglyph("uni306F",111);
  hira.ha;
  tsu_render;
endtsuglyph;

% hiragana "ba"
begintsuglyph("uni3070",112);
  hira.ha;
  dakuten(identity rotated 12 shifted (850,730));
  tsu_render;
endtsuglyph;

% hiragana "pa"
begintsuglyph("uni3071",113);
  hira.ha;
  handakuten((850,730));
  tsu_render;
endtsuglyph;

% hiragana "hi"
begintsuglyph("uni3072",114);
  hira.hi;
  tsu_render;
endtsuglyph;

% hiragana "bi"
begintsuglyph("uni3073",115);
  hira.hi;
  dakuten(identity rotated 20 shifted (830,740));
  tsu_render;
endtsuglyph;

% hiragana "pi"
begintsuglyph("uni3074",116);
  hira.hi;
  handakuten((830,740));
  tsu_render;
endtsuglyph;

% hiragana "fu"
begintsuglyph("uni3075",117);
  hira.fu;
  tsu_render;
endtsuglyph;

% hiragana "bu"
begintsuglyph("uni3076",118);
  hira.fu;
  dakuten(identity shifted (830,710));
  tsu_render;
endtsuglyph;

% hiragana "pu"
begintsuglyph("uni3077",119);
  hira.fu;
  handakuten((830,710));
  tsu_render;
endtsuglyph;

% hiragana "he"
begintsuglyph("uni3078",120);
  hira.he;
  tsu_render;
endtsuglyph;

% hiragana "be"
begintsuglyph("uni3079",121);
  hira.he;
  dakuten(identity shifted (800,670));
  tsu_render;
endtsuglyph;

% hiragana "pe"
begintsuglyph("uni307A",122);
  hira.he;
  handakuten((800,670));
  tsu_render;
endtsuglyph;

% hiragana "ho"
begintsuglyph("uni307B",123);
  hira.ho;
  tsu_render;
endtsuglyph;

% hiragana "bo"
begintsuglyph("uni307C",124);
  hira.ho;
  replace_strokep(-2,subpath (0,1.65-0.07*mincho) of oldp);
  replace_strokep(0,oldp shifted (-20,0));
  dakuten(identity rotated -10 shifted (875,770));
  tsu_render;
endtsuglyph;

% hiragana "po"
begintsuglyph("uni307D",125);
  hira.ho;
  replace_strokep(-2,subpath (0,1.65-0.07*mincho) of oldp);
  replace_strokep(0,oldp shifted (-20,0));
  handakuten((885,770));
  tsu_render;
endtsuglyph;

% hiragana "ma"
begintsuglyph("uni307E",126);
  hira.ma;
  tsu_render;
endtsuglyph;

% hiragana "mi"
begintsuglyph("uni307F",127);
  hira.mi;
  tsu_render;
endtsuglyph;

% hiragana "mu"
begintsuglyph("uni3080",128);
  hira.mu;
  tsu_render;
endtsuglyph;

% hiragana "me"
begintsuglyph("uni3081",129);
  hira.me;
  tsu_render;
endtsuglyph;

% hiragana "mo"
begintsuglyph("uni3082",130);
  hira.mo;
  tsu_render;
endtsuglyph;

% hiragana "small ya"
begintsuglyph("uni3083",131);
  tsu_xform(tsu_xf.smallkana)(hira.ya);
  tsu_render;
endtsuglyph;

% hiragana "ya"
begintsuglyph("uni3084",132);
  hira.ya;
  tsu_render;
endtsuglyph;

% hiragana "small yu"
begintsuglyph("uni3085",133);
  tsu_xform(tsu_xf.smallkana)(hira.yu);
  tsu_render;
endtsuglyph;

% hiragana "yu"
begintsuglyph("uni3086",134);
  hira.yu;
  tsu_render;
endtsuglyph;

% hiragana "small yo"
begintsuglyph("uni3087",135);
  tsu_xform(tsu_xf.smallkana)(hira.yo);
  tsu_render;
endtsuglyph;

begintsuglyph("uni3088",136);
  hira.yo;
  tsu_render;
endtsuglyph;

% hiragana "ra"
begintsuglyph("uni3089",137);
  hira.ra;
  tsu_render;
endtsuglyph;

% hiragana "ri"
begintsuglyph("uni308A",138);
  hira.ri;
  tsu_render;
endtsuglyph;

% hiragana "ru"
begintsuglyph("uni308B",139);
  hira.ru;
  tsu_render;
endtsuglyph;

% hiragana "re"
begintsuglyph("uni308C",140);
  hira.re;
  tsu_render;
endtsuglyph;

% hiragana "ro"
begintsuglyph("uni308D",141);
  hira.ro;
  tsu_render;
endtsuglyph;

% hiragana "small wa"
begintsuglyph("uni308E",142);
  tsu_xform(tsu_xf.smallkana)(hira.wa);
  tsu_render;
endtsuglyph;

% hiragana "wa"
begintsuglyph("uni308F",143);
  hira.wa;
  tsu_render;
endtsuglyph;

% obsolete hiragana "wi"
begintsuglyph("uni3090",144);
   hira.wi;
   tsu_render;
endtsuglyph;

% obsolete hiragana "we"
begintsuglyph("uni3091",145);
   hira.we;
   tsu_render;
endtsuglyph;

% hiragana "wo"
begintsuglyph("uni3092",146);
  hira.wo;
  tsu_render;
endtsuglyph;

% hiragana "n"
begintsuglyph("uni3093",147);
  hira.n;
  tsu_render;
endtsuglyph;

% hiragana "vu"
begintsuglyph("uni3094",148);
  hira.u;
  dakuten(identity rotated 5 shifted (810,640));
  tsu_render;
endtsuglyph;

% hiragana "small ka"
begintsuglyph("uni3095",149);
  tsu_xform(tsu_xf.smallkana)(hira.ka);
  tsu_render;
endtsuglyph;

% hiragana "small ke"
begintsuglyph("uni3096",150);
  tsu_xform(tsu_xf.smallkana)(hira.ke);
  tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_native_zero;

% combining dakuten
begintsuglyph("uni3099",153);
   dakuten(identity shifted (-140,730));
   tsu_render;
endtsuglyph;

% combining handakuten
begintsuglyph("uni309A",154);
   handakuten((-140,730));
   tsu_render;
endtsuglyph;

% WARNING changing rescale setting
tsu_rescale_full;

% dakuten alone
begintsuglyph("uni309B",155);
   dakuten(identity shifted (860,730));
   tsu_render;
endtsuglyph;

% handakuten alone
begintsuglyph("uni309C",156);
   handakuten((860,730));
   tsu_render;
endtsuglyph;

% hiragana "iteration mark"
begintsuglyph("uni309D",157);
  hira.iteration;
  tsu_render;
endtsuglyph;

% hiragana "voiced iteration mark"
begintsuglyph("uni309E",158);
  hira.iteration;
  dakuten(identity rotated 7 shifted (720,610));
  tsu_render;
endtsuglyph;

% hiragana "yori ligature"
begintsuglyph("uni309F",159);
  hira.yori;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% KATAKANA

% katakana double hyphen
begintsuglyph("uni30A0",160);
  punct.dash.double_hyphen;
  tsu_render;
endtsuglyph;

% katakana "small a"
begintsuglyph("uni30A1",161);
  tsu_xform(tsu_xf.smallkana)(kata.a);
  tsu_render;
endtsuglyph;

% katakana "a"
begintsuglyph("uni30A2",162);
  kata.a;
  tsu_render;
endtsuglyph;

% katakana "small i"
begintsuglyph("uni30A3",163);
  tsu_xform(tsu_xf.smallkana)(kata.i);
  tsu_render;
endtsuglyph;

% katakana "i"
begintsuglyph("uni30A4",164);
  kata.i;
  tsu_render;
endtsuglyph;

% katakana "small u"
begintsuglyph("uni30A5",165);
  tsu_xform(tsu_xf.smallkana)(kata.u);
  tsu_render;
endtsuglyph;

% katakana "u"
begintsuglyph("uni30A6",166);
  kata.u;
  tsu_render;
endtsuglyph;

% katakana "small e"
begintsuglyph("uni30A7",167);
  tsu_xform(tsu_xf.smallkana)(kata.e);
  tsu_render;
endtsuglyph;

% katakana "e"
begintsuglyph("uni30A8",168);
  kata.e;
  tsu_render;
endtsuglyph;

% katakana "small o"
begintsuglyph("uni30A9",169);
  tsu_xform(tsu_xf.smallkana)(kata.o);
  tsu_render;
endtsuglyph;

% katakana "o"
begintsuglyph("uni30AA",170);
  kata.o;
  tsu_render;
endtsuglyph;

% katakana "ka"
begintsuglyph("uni30AB",171);
  kata.ka;
  tsu_render;
endtsuglyph;

% katakana "ga"
begintsuglyph("uni30AC",172);
  kata.ka;
  dakuten(identity rotated 15 shifted (830,730));
  tsu_render;
endtsuglyph;

% katakana "ki"
begintsuglyph("uni30AD",173);
  kata.ki;
  tsu_render;
endtsuglyph;

% katakana "gi"
begintsuglyph("uni30AE",174);
  kata.ki;
  dakuten(identity rotated 9 shifted (850,740));
  tsu_render;
endtsuglyph;

% katakana "ku"
begintsuglyph("uni30AF",175);
  kata.ku;
  tsu_render;
endtsuglyph;

% katakana "gu"
begintsuglyph("uni30B0",176);
  kata.ku;
  dakuten(identity rotated 12 shifted (850,740));
  tsu_render;
endtsuglyph;

% katakana "ke"
begintsuglyph("uni30B1",177);
  kata.ke;
  tsu_render;
endtsuglyph;

% katakana "ge"
begintsuglyph("uni30B2",178);
  kata.ke;
  dakuten(identity
    rotated -20 slanted -0.1 xyscaled (1.07,0.93) shifted (800,730));
  tsu_render;
endtsuglyph;

% katakana "ko"
begintsuglyph("uni30B3",179);
  kata.ko;
  tsu_render;
endtsuglyph;

% katakana "go"
begintsuglyph("uni30B4",180);
  kata.ko;
  bo_tip1[1]:=0;
  dakuten(identity rotated 8 shifted (860,735));
  tsu_render;
endtsuglyph;

% katakana "sa"
begintsuglyph("uni30B5",181);
  kata.sa;
  tsu_render;
endtsuglyph;

% katakana "za"
begintsuglyph("uni30B6",182);
  kata.sa;
  dakuten(identity rotated 20 shifted (850,740));
  tsu_render;
endtsuglyph;

% katakana "shi"
begintsuglyph("uni30B7",183);
  kata.shi;
  tsu_render;
endtsuglyph;

% katakana "ji"
begintsuglyph("uni30B8",184);
  kata.shi;
  dakuten(identity shifted (810,710));
  tsu_render;
endtsuglyph;

% katakana "su"
begintsuglyph("uni30B9",185);
  kata.su;
  tsu_render;
endtsuglyph;

% katakana "zu"
begintsuglyph("uni30BA",186);
  kata.su;
  dakuten(identity rotated 18 shifted (860,590));
  tsu_render;
endtsuglyph;

% katakana "se"
begintsuglyph("uni30BB",187);
  kata.se;
  tsu_render;
endtsuglyph;

% katakana "ze"
begintsuglyph("uni30BC",188);
  kata.se;
  dakuten(identity rotated 18 shifted (860,750));
  tsu_render;
endtsuglyph;

% katakana "so"
begintsuglyph("uni30BD",189);
  kata.so;
  tsu_render;
endtsuglyph;

% katakana "zo"
begintsuglyph("uni30BE",190);
  kata.so;
  replace_strokep(0,subpath (0.5,infinity) of oldp);
  dakuten(identity rotated 15 shifted (830,740));
  tsu_render;
endtsuglyph;

% katakana "ta"
begintsuglyph("uni30BF",191);
  kata.ta;
  tsu_render;
endtsuglyph;

% katakana "da"
begintsuglyph("uni30C0",192);
  kata.ta;
  dakuten(identity rotated 12 shifted (850,740));
  tsu_render;
endtsuglyph;

% katakana "chi"
begintsuglyph("uni30C1",193);
  kata.chi;
  tsu_render;
endtsuglyph;

% katakana "dji"
begintsuglyph("uni30C2",194);
  kata.chi;
  dakuten(identity rotated 18 shifted (860,630));
  tsu_render;
endtsuglyph;

% katakana "small tsu"
begintsuglyph("uni30C3",195);
  tsu_xform(tsu_xf.smallkana)(kata.tsu);
  tsu_render;
endtsuglyph;

% katakana "tsu"
begintsuglyph("uni30C4",196);
  kata.tsu;
  tsu_render;
endtsuglyph;

% katakana "dzu"
begintsuglyph("uni30C5",197);
  kata.tsu;
  replace_strokep(0,subpath (1,infinity) of oldp);
  dakuten(identity rotated 15 shifted (830,740));
  tsu_render;
endtsuglyph;

% katakana "te"
begintsuglyph("uni30C6",198);
  kata.te;
  tsu_render;
endtsuglyph;

% katakana "de"
begintsuglyph("uni30C7",199);
  kata.te;
  replace_strokep(-2,(subpath (0,1.9) of oldp) shifted (-30,0));
  replace_strokep(-1,oldp shifted (-30,0));
  replace_strokep(0,oldp shifted (-30,0));
  dakuten(identity rotated 15 shifted (840,670));
  tsu_render;
endtsuglyph;

% katakana "to"
begintsuglyph("uni30C8",200);
  kata.toh;
  tsu_render;
endtsuglyph;

% katakana "do"
begintsuglyph("uni30C9",201);
  kata.toh;
  dakuten(identity shifted (810,700));
  tsu_render;
endtsuglyph;

% katakana "na"
begintsuglyph("uni30CA",202);
  kata.na;
  tsu_render;
endtsuglyph;

% katakana "ni"
begintsuglyph("uni30CB",203);
  kata.ni;
  tsu_render;
endtsuglyph;

% katakana "nu"
begintsuglyph("uni30CC",204);
  kata.nu;
  tsu_render;
endtsuglyph;

% katakana "ne"
begintsuglyph("uni30CD",205);
  kata.ne;
  tsu_render;
endtsuglyph;

% katakana "no"
begintsuglyph("uni30CE",206);
  kata.no;
  tsu_render;
endtsuglyph;

% katakan "ha"
begintsuglyph("uni30CF",207);
  kata.ha;
  tsu_render;
endtsuglyph;

% katakan "ba"
begintsuglyph("uni30D0",208);
  kata.ha;
  dakuten(identity shifted (810,700));
  tsu_render;
endtsuglyph;

% katakan "pa"
begintsuglyph("uni30D1",209);
  kata.ha;
  handakuten((810,700));
  tsu_render;
endtsuglyph;

% katakana "hi"
begintsuglyph("uni30D2",210);
  kata.hi;
  tsu_render;
endtsuglyph;

% katakana "bi"
begintsuglyph("uni30D3",211);
  kata.hi;
  dakuten(identity rotated 7 shifted (850,725));
  tsu_render;
endtsuglyph;

% katakana "pi"
begintsuglyph("uni30D4",212);
  kata.hi;
  handakuten((850,725));
  tsu_render;
endtsuglyph;

% katakana "fu"
begintsuglyph("uni30D5",213);
  kata.fu;
  tsu_render;
endtsuglyph;

% katakana "bu"
begintsuglyph("uni30D6",214);
  kata.fu;
  replace_strokep(0,oldp shifted (-40,-10));
  dakuten(identity rotated 4 shifted (857,735));
  tsu_render;
endtsuglyph;

% katakana "pu"
begintsuglyph("uni30D7",215);
  kata.fu;
  replace_strokep(0,oldp shifted (-40,-10));
  handakuten((875,735));
  tsu_render;
endtsuglyph;

% katakana "he"
begintsuglyph("uni30D8",216);
  kata.he;
  tsu_render;
endtsuglyph;

% katakana "be"
begintsuglyph("uni30D9",217);
  kata.he;
  dakuten(identity shifted (800,670));
  tsu_render;
endtsuglyph;

% katakana "pe"
begintsuglyph("uni30DA",218);
  kata.he;
  handakuten((800,670));
  tsu_render;
endtsuglyph;

% katakana "ho"
begintsuglyph("uni30DB",219);
  kata.ho;
  tsu_render;
endtsuglyph;

% katakana "bo"
begintsuglyph("uni30DC",220);
  kata.ho;
  dakuten(identity
    rotated -25 slanted -0.3 xyscaled (1.2,0.8) shifted (780,760));
  tsu_render;
endtsuglyph;

% katakana "po"
begintsuglyph("uni30DD",221);
  kata.ho;
  handakuten((800,770));
  tsu_render;
endtsuglyph;

% katakana "ma"
begintsuglyph("uni30DE",222);
  kata.ma;
  tsu_render;
endtsuglyph;

% katakana "mi"
begintsuglyph("uni30DF",223);
  kata.mi;
  tsu_render;
endtsuglyph;

% katakana "mu"
begintsuglyph("uni30E0",224);
  kata.mu;
  tsu_render;
endtsuglyph;

% katakana "me"
begintsuglyph("uni30E1",225);
  kata.me;
  tsu_render;
endtsuglyph;

% katakana "mo"
begintsuglyph("uni30E2",226);
  kata.mo;
  tsu_render;
endtsuglyph;

% katakana "small ya"
begintsuglyph("uni30E3",227);
  tsu_xform(tsu_xf.smallkana)(kata.ya);
  tsu_render;
endtsuglyph;

% katakana "ya"
begintsuglyph("uni30E4",228);
  kata.ya;
  tsu_render;
endtsuglyph;

% katakana "small yu"
begintsuglyph("uni30E5",229);
  tsu_xform(tsu_xf.smallkana)(kata.yu);
  tsu_render;
endtsuglyph;

% katakana "yu"
begintsuglyph("uni30E6",230);
  kata.yu;
  tsu_render;
endtsuglyph;

% katakana "small yo"
begintsuglyph("uni30E7",231);
  tsu_xform(tsu_xf.smallkana)(kata.yo);
  tsu_render;
endtsuglyph;

% katakana "yo"
begintsuglyph("uni30E8",232);
  kata.yo;
  tsu_render;
endtsuglyph;

% katakana "ra"
begintsuglyph("uni30E9",233);
  kata.ra;
  tsu_render;
endtsuglyph;

% katakana "ri"
begintsuglyph("uni30EA",234);
  kata.ri;
  tsu_render;
endtsuglyph;

% katakana "ru"
begintsuglyph("uni30EB",235);
  kata.ru;
  tsu_render;
endtsuglyph;

% katakana "re"
begintsuglyph("uni30EC",236);
  kata.re;
  tsu_render;
endtsuglyph;

% katakana "ro"
begintsuglyph("uni30ED",237);
  kata.ro;
  tsu_render;
endtsuglyph;

% katakana "small wa"
begintsuglyph("uni30EE",238);
  tsu_xform(tsu_xf.smallkana)(kata.wa);
  tsu_render;
endtsuglyph;

% katakana "wa"
begintsuglyph("uni30EF",239);
  kata.wa;
  tsu_render;
endtsuglyph;

% katakana "wi"
begintsuglyph("uni30F0",240);
  kata.wi;
  tsu_render;
endtsuglyph;

% katakana "we"
begintsuglyph("uni30F1",241);
  kata.we;
  tsu_render;
endtsuglyph;

% katakana "wo"
begintsuglyph("uni30F2",242);
  kata.wo;
  tsu_render;
endtsuglyph;

% katakana "n"
begintsuglyph("uni30F3",243);
  kata.n;
  tsu_render;
endtsuglyph;

% katakana "vu"
begintsuglyph("uni30F4",244);
  kata.u;
  dakuten(identity rotated 12 shifted (860,720));
  tsu_render;
endtsuglyph;

% katakana "small ka"
begintsuglyph("uni30F5",245);
  tsu_xform(tsu_xf.smallkana)(kata.ka);
  tsu_render;
endtsuglyph;

% katakana "small ke"
begintsuglyph("uni30F6",246);
  tsu_xform(tsu_xf.smallkana)(kata.ke);
  tsu_render;
endtsuglyph;

% katakana "va"
begintsuglyph("uni30F7",247);
  kata.wa;
  replace_strokep(0,oldp shifted (-15,0));
  dakuten(identity rotated 4 shifted (860,740));
  tsu_render;
endtsuglyph;

% katakana "vi"
begintsuglyph("uni30F8",248);
  kata.wi;
  dakuten(identity rotated 15 shifted (860,750));
  tsu_render;
endtsuglyph;

% katakana "ve"
begintsuglyph("uni30F9",249);
  kata.we;
  dakuten(identity rotated 15 shifted (860,750));
  tsu_render;
endtsuglyph;

% katakana "vo"
begintsuglyph("uni30FA",250);
  tsu_xform(identity shifted (-40,-30))(kata.wo);
  dakuten(identity shifted (860,750));
  tsu_render;
endtsuglyph;

% katakana middle dot
begintsuglyph("uni30FB",251);
  Fill fullcircle scaled (200*tsu_brush_max) shifted centre_pt;   
endtsuglyph;

% hira/kata "prolonged sound mark"
begintsuglyph("uni30FC",252);
  punct.psound;
  tsu_render;
endtsuglyph;

% katakana "iteration mark"
begintsuglyph("uni30FD",253);
  kata.iteration;
  tsu_render;
endtsuglyph;

% katakana "voiced iteration mark"
begintsuglyph("uni30FE",254);
  kata.iteration;
  dakuten(identity rotated 7 shifted (720,610));
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
