%
% Unicode page 2F (Radicals and IDCs) for Tsukurimashou
% Copyright (C) 2011, 2012, 2013  Matthew Skala
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
input bkencl.mp;
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
input rightrad.mp;
input toprad.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% KANGXI RADICALS

% ichi/hito "one"
begintsuglyph("uni2F00",0);
  kanji.grone.one;
  tsu_render;
endtsuglyph;

% extra "vertical line"
begintsuglyph("uni2F01",1);
  kanji.radical.vline;
  tsu_render;
endtsuglyph;

% ni/futa "two"
begintsuglyph("uni2F06",6);
  kanji.grone.two;
  tsu_render;
endtsuglyph;

% "kettle lid radical"
begintsuglyph("uni2F07",7);
  build_kanji.tb(500,-50)
    (kanji.radical.kettle_lid)
    ();
  tsu_render;
endtsuglyph;

% hito/jin "person"
begintsuglyph("uni2F08",8);
  kanji.grone.person;
  tsu_render;
endtsuglyph;

% legs radical
begintsuglyph("uni2F09",9);
  kanji.radical.legs;
  tsu_render;
endtsuglyph;

% hai/i "put it in"
begintsuglyph("uni2F0A",10);
  kanji.grone.put_it_in;
  tsu_render;
endtsuglyph;

% hachi/ya "eight"
begintsuglyph("uni2F0B",11);
  kanji.grone.eight;
  tsu_render;
endtsuglyph;

% George Michael's Moustache
begintsuglyph("uni2F0C",12);
  kanji.radical.gmm;
  tsu_render;
endtsuglyph;

% kan "open box radical"
begintsuglyph("uni2F10",16);
  kanji.radical.open_box;
  tsu_render;
endtsuglyph;

% tou/katana "sword"
begintsuglyph("uni2F11",17);
  kanji.grtwo.sword;
  tsu_render;
endtsuglyph;

% ryoku "power", as in Koizumi Itsuki has teh "chounouryoku"
begintsuglyph("uni2F12",18);
  kanji.grone.power;
  tsu_render;
endtsuglyph;

% hou/tsutsu "wrapping radical"
begintsuglyph("uni2F13",19);
  kanji.radical.wrapping;
  tsu_render;
endtsuglyph;

% hi/saji "spoon"
begintsuglyph("uni2F14",20);
  kanji.radical.spoon;
  tsu_render;
endtsuglyph;

% hou/hakogamae "box on side radical"
begintsuglyph("uni2F15",21);
  kanji.radical.box_on_side;
  tsu_render;
endtsuglyph;

% juu/too "ten"
begintsuglyph("uni2F17",23);
  kanji.grone.ten;
  tsu_render;
endtsuglyph;

% karigane "cliff radical"
begintsuglyph("uni2F1A",26);
  build_kanji.cliff_enclose();
  tsu_render;
endtsuglyph;

% yuu/mata "on the other hand"
begintsuglyph("uni2F1C",28);
  kanji.greight.otoh;
  tsu_render;
endtsuglyph;

% kou/kuchi "mouth"
begintsuglyph("uni2F1D",29);
  kanji.grone.mouth;
  tsu_render;
endtsuglyph;

% box radical
begintsuglyph("uni2F1E",30);
  kanji.radical.box;
  tsu_render;
endtsuglyph;

% tsuchi/do "earth"
begintsuglyph("uni2F1F",31);
  kanji.grone.earth;
  tsu_render;
endtsuglyph;

% shi "gentleman" ("samurai" radical)
begintsuglyph("uni2F20",32);
  kanji.grfour.gentleman;
  tsu_render;
endtsuglyph;

% chi/shuu "winter radical"
begintsuglyph("uni2F21",33);
  kanji.radical.winter;
  tsu_render;
endtsuglyph;

% yuu/seki "evening"
begintsuglyph("uni2F23",35);
  kanji.grone.evening;
  tsu_render;
endtsuglyph;

% dai/oo "big"
begintsuglyph("uni2F24",36);
  kanji.grone.big;
  tsu_render;
endtsuglyph;

% jo/onna "woman"
begintsuglyph("uni2F25",37);
  kanji.grone.woman;
  tsu_render;
endtsuglyph;

% ko "child"
begintsuglyph("uni2F26",38);
  kanji.grone.child;
  tsu_render;
endtsuglyph;

% silly hat radical
begintsuglyph("uni2F27",39);
  build_kanji.tb(500,-30)
    (kanji.radical.silly_hat)
    ();
  tsu_render;
endtsuglyph;

% su/miki "inch", also often a radical
begintsuglyph("uni2F28",40);
  kanji.grsix.inch;
  tsu_render;
endtsuglyph;

% shuu/chii "small"
begintsuglyph("uni2F29",41);
  kanji.grone.small;
  tsu_render;
endtsuglyph;

% shi/katashiro "corpse" or "flag radial"
begintsuglyph("uni2F2B",43);
  kanji.radical.flag;
  tsu_render;
endtsuglyph;

% yama/san "mountain"
begintsuglyph("uni2F2D",45);
  kanji.grone.mountain;
  tsu_render;
endtsuglyph;

% takumi "craft"
begintsuglyph("uni2F2F",47);
  kanji.grtwo.craft;
  tsu_render;
endtsuglyph;

% ko/ki "self" (dict. says also "snake" but almost no words use it that way)
begintsuglyph("uni2F30",48);
  kanji.grsix.self;
  tsu_render;
endtsuglyph;

% kin/oo/haba "towel" or "hanging scroll"
begintsuglyph("uni2F31",49);
  kanji.greight.towel;
  tsu_render;
endtsuglyph;

% you/chiisai "short thread radical"
begintsuglyph("uni2F33",51);
  kanji.radical.short_thread;
  tsu_render;
endtsuglyph;

% madare "dotted cliff radical"
begintsuglyph("uni2F34",52);
  build_kanji.dotcliff_enclose();
  tsu_render;
endtsuglyph;

% extra
begintsuglyph("uni2F36",54);
  kanji.radical.aitch;
  tsu_render;
endtsuglyph;

% yoku/iguromi "ceremony radical"
begintsuglyph("uni2F37",55);
  kanji.radical.ceremony;
  tsu_render;
endtsuglyph;

% kyuu/yumi "bow" (projectile weapon)
begintsuglyph("uni2F38",56);
  kanji.grtwo.bow;
  tsu_render;
endtsuglyph;

% needed for lots of other things, rare by itself
begintsuglyph("uni2F39",57);
  kanji.radical.pigs_tail;
  tsu_render;
endtsuglyph;

% san "short hair radical"
begintsuglyph("uni2F3A",58);
  kanji.rightrad.short_hair;
  tsu_render;
endtsuglyph;

% shin/kokoro "heart"
begintsuglyph("uni2F3C",60);
  kanji.grtwo.heart;
  tsu_render;
endtsuglyph;

% te "hand"
begintsuglyph("uni2F3F",63);
  kanji.grone.hand;
  tsu_render;
endtsuglyph;

% bun/fumi "sentence"
begintsuglyph("uni2F42",66);
  kanji.grone.sentence;
  tsu_render;
endtsuglyph;

% to/masu "dipper"
begintsuglyph("uni2F43",67);
  kanji.greight.dipper;
  tsu_render;
endtsuglyph;

% kin/ono "axe"
begintsuglyph("uni2F44",68);
  kanji.greight.axe;
  tsu_render;
endtsuglyph;

% hou/kata "direction" or "how to do it"
begintsuglyph("uni2F45",69);
  kanji.grtwo.direction;
  tsu_render;
endtsuglyph;

% hi/nichi "day"
begintsuglyph("uni2F47",71);
  kanji.grone.day;
  tsu_render;
endtsuglyph;

% tsuki/getsu "moon"
begintsuglyph("uni2F49",73);
  kanji.grone.moon;
  tsu_render;
endtsuglyph;

% ki "wood"
begintsuglyph("uni2F4A",74);
  kanji.grone.wood;
  tsu_render;
endtsuglyph;

% ketsu/ka/akubi "fail" or "yawn"
begintsuglyph("uni2F4B",75);
  kanji.grfour.fail;
  tsu_render;
endtsuglyph;

% shi/toma "stop"
begintsuglyph("uni2F4C",76);
  kanji.grtwo.cease;
  tsu_render;
endtsuglyph;

% extra: mother radical, stroked version
begintsuglyph("uni2F4F",79);
  kanji.radical.mother_stroked;
  tsu_render;
endtsuglyph;

% mou/ke "hair"
begintsuglyph("uni2F51",81);
  kanji.grtwo.hair;
  tsu_render;
endtsuglyph;

% shi/uji "clan"
begintsuglyph("uni2F52",82);
  kanji.grfour.clan;
  tsu_render;
endtsuglyph;

% sei/tada/machi "correct"
begintsuglyph("uni2F53",83);
  build_kanji.steam_enclose((700,400))();
  tsu_render;
endtsuglyph;

% sui/mizu "water"
begintsuglyph("uni2F54",84);
  kanji.grone.water;
  tsu_render;
endtsuglyph;

% hi/ka "fire"
begintsuglyph("uni2F55",85);
  kanji.grone.fire;
  tsu_render;
endtsuglyph;

% chichi "father"
begintsuglyph("uni2F57",87);
  kanji.grtwo.father;
  tsu_render;
endtsuglyph;

% kyuu/ushi "cow"
begintsuglyph("uni2F5C",92);
  kanji.grtwo.cow;
  tsu_render;
endtsuglyph;

% inu "dog"
begintsuglyph("uni2F5D",93);
  kanji.grone.dog;
  tsu_render;
endtsuglyph;

% gyoku/tama "ball" or "precious"
begintsuglyph("uni2F5F",95);
  kanji.grone.ball;
  tsu_render;
endtsuglyph;

% sei/ki "life"
begintsuglyph("uni2F63",99);
  kanji.grone.life;
  tsu_render;
endtsuglyph;

% you/mochi "job"
begintsuglyph("uni2F64",100);
  kanji.grtwo.job;
  tsu_render;
endtsuglyph;

% ta "rice paddy"
begintsuglyph("uni2F65",101);
  kanji.grone.paddy;
  tsu_render;
endtsuglyph;

% shiro "white"
begintsuglyph("uni2F69",105);
  kanji.grone.white;
  tsu_render;
endtsuglyph;

% moku/me "eye"
begintsuglyph("uni2F6C",108);
  kanji.grone.eye;
  tsu_render;
endtsuglyph;

% shi/ya "arrow"
begintsuglyph("uni2F6E",110);
  kanji.grtwo.arrow;
  tsu_render;
endtsuglyph;

% seki/ishi "stone"
begintsuglyph("uni2F6F",111);
  kanji.grone.stone;
  tsu_render;
endtsuglyph;

% ji/shime "show" (also older radical form)
begintsuglyph("uni2F70",112);
  kanji.grfive.showing;
  tsu_render;
endtsuglyph;

% ka/ine little meaning by itself, called "two-branch tree" as a radical
begintsuglyph("uni2F72",114);
  kanji.grnine.two_branch_tree;
  tsu_render;
endtsuglyph;

% ta "stand up"
begintsuglyph("uni2F74",116);
  kanji.grone.stand_up;
  tsu_render;
endtsuglyph;

% chiku/take "bamboo"
begintsuglyph("uni2F75",117);
  kanji.grone.bamboo;
  tsu_render;
endtsuglyph;

% bei/kome "rice", also "USA" and "metre"
begintsuglyph("uni2F76",118);
  kanji.grtwo.rice;
  tsu_render;
endtsuglyph;

% shi/ito "thread"
begintsuglyph("uni2F77",119);
  kanji.grone.thread;
  tsu_render;
endtsuglyph;

% you/hitsuji "sheep"
begintsuglyph("uni2F7A",122);
  kanji.grthree.sheep;
  tsu_render;
endtsuglyph;

% u/hane "feather"
begintsuglyph("uni2F7B",123);
  kanji.grtwo.feather;
  tsu_render;
endtsuglyph;

% rou/o "old man"
begintsuglyph("uni2F7C",124);
  kanji.grfour.old_man;
  tsu_render;
endtsuglyph;

% ken/mi "ear"
begintsuglyph("uni2F7F",127);
  kanji.grone.ear;
  tsu_render;
endtsuglyph;

% brush radical
begintsuglyph("uni2F80",128);
  kanji.radical.brush;
  tsu_render;
endtsuglyph;

% niku "meat"
begintsuglyph("uni2F81",129);
  kanji.grtwo.meat;
  tsu_render;
endtsuglyph;

% ji as in jibun "self"
begintsuglyph("uni2F83",131);
  kanji.grtwo.self;
  tsu_render;
endtsuglyph;

% shi/ita "climax"
begintsuglyph("uni2F84",132);
  kanji.grsix.climax;
  tsu_render;
endtsuglyph;

% zetsu/shita "tongue"
begintsuglyph("uni2F86",134);
  kanji.grfive.tongue;
  tsu_render;
endtsuglyph;

% shuu/fune "boat"
begintsuglyph("uni2F88",136);
  kanji.greight.boat;
  tsu_render;
endtsuglyph;

% kon/ushitora "northeast"
begintsuglyph("uni2F89",137);
  kanji.radical.northeast;
  tsu_render;
endtsuglyph;

% shoku/iro "colour"
begintsuglyph("uni2F8A",138);
  kanji.grtwo.colour;
  tsu_render;
endtsuglyph;

% mushi "bug"
begintsuglyph("uni2F8D",141);
  kanji.grone.bug;
  tsu_render;
endtsuglyph;

% kou/i(ku) "go"
begintsuglyph("uni2F8F",143);
  kanji.grtwo.go;
  tsu_render;
endtsuglyph;

% ken/mi "see"
begintsuglyph("uni2F92",146);
  kanji.grone.see;
  tsu_render;
endtsuglyph;

% kaku/kado "corner"
begintsuglyph("uni2F93",147);
  kanji.grtwo.corner;
  tsu_render;
endtsuglyph;

% gen/i "word"
begintsuglyph("uni2F94",148);
  kanji.grtwo.word;
  tsu_render;
endtsuglyph;

% koku/tani "valley"
begintsuglyph("uni2F95",149);
  kanji.grtwo.valley;
  tsu_render;
endtsuglyph;

% tou/mame "bean"
begintsuglyph("uni2F96",150);
  kanji.grthree.bean;
  tsu_render;
endtsuglyph;

% inoko "pig" radical
begintsuglyph("uni2F97",151);
  kanji.radical.pig;
  tsu_render;
endtsuglyph;

% bai/kai "shellfish"
begintsuglyph("uni2F99",153);
  kanji.grone.shell;
  tsu_render;
endtsuglyph;

% aka/seki "red"
begintsuglyph("uni2F9A",154);
  kanji.grone.red;
  tsu_render;
endtsuglyph;

% sou/hashi "run"
begintsuglyph("uni2F9B",155);
  kanji.grtwo.run;
  tsu_render;
endtsuglyph;

% ashi/soku "foot"
begintsuglyph("uni2F9C",156);
  kanji.grone.foot;
  tsu_render;
endtsuglyph;

% kuruma "car/wheel"
begintsuglyph("uni2F9E",158);
  kanji.grone.wheel;
  tsu_render;
endtsuglyph;

% han/irodori "separate" or "divide" but mostly "topped rice radical"
begintsuglyph("uni2FA4",164);
  build_kanji.add_beret(kanji.grtwo.rice);
  tsu_render;
endtsuglyph;

% ri/sato, multiple meanings including 3.929km and "neighbourhood"
begintsuglyph("uni2FA5",165);
  kanji.grtwo.neighbourhood;
  tsu_render;
endtsuglyph;

% kane/kin "gold"
begintsuglyph("uni2FA6",166);
  kanji.grone.gold;
  tsu_render;
endtsuglyph;

% chou/naga "long"
begintsuglyph("uni2FA7",167);
  kanji.grtwo.long;
  tsu_render;
endtsuglyph;

% mon/kado "gate"
begintsuglyph("uni2FA8",168);
  kanji.grtwo.gate;
  tsu_render;
endtsuglyph;

% sai/tori "old bird" radical
begintsuglyph("uni2FAB",171);
  kanji.radical.old_bird;
  tsu_render;
endtsuglyph;

% u/ame "rain"
begintsuglyph("uni2FAC",172);
  kanji.grone.rain;
  tsu_render;
endtsuglyph;

% men/omo "face"
begintsuglyph("uni2FAF",175);
  kanji.grthree.face;
  tsu_render;
endtsuglyph;

% oto/on "noise"
begintsuglyph("uni2FB3",179);
  kanji.grone.noise;
  tsu_render;
endtsuglyph;

% ketsu/peeji "page"
begintsuglyph("uni2FB4",180);
  kanji.grnine.page;
  tsu_render;
endtsuglyph;

% fuu/kaze "wind"
begintsuglyph("uni2FB5",181);
  kanji.grtwo.wind;
  tsu_render;
endtsuglyph;

% shoku/ta "eat"
begintsuglyph("uni2FB7",183);
  kanji.grtwo.eat;
  tsu_render;
endtsuglyph;

% shu/kubi "neck"
begintsuglyph("uni2FB8",184);
  kanji.grtwo.neck;
  tsu_render;
endtsuglyph;

% ba/uma "horse"
begintsuglyph("uni2FBA",186);
  kanji.grtwo.horse;
  tsu_render;
endtsuglyph;

% kou/taka "high"
begintsuglyph("uni2FBC",188);
  kanji.grtwo.high;
  tsu_render;
endtsuglyph;

% hyuu/kamigashira "long hair radical"
begintsuglyph("uni2FBD",189);
  kanji.radical.long_hair;
  tsu_render;
endtsuglyph;

% gyo/sakana "fish"
begintsuglyph("uni2FC2",194);
  kanji.grtwo.fish;
  tsu_render;
endtsuglyph;

% chou/tori "bird"
begintsuglyph("uni2FC3",195);
  kanji.grtwo.bird;
  tsu_render;
endtsuglyph;

% bi/hana "nose"
begintsuglyph("uni2FD0",208);
  kanji.grthree.nose;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% IDEOGRAPHIC DESCRIPTION CHARACTERS

numeric idc_corners;

vardef idc_horiz(expr v,ha,hb) =
  for h:=ha upto hb:
    if h<hb: idc_corners[h][v].r:=1; fi;
    if h>ha: idc_corners[h][v].l:=1; fi;
  endfor;
enddef;

vardef idc_vert(expr h,va,vb) =
  for v:=va upto vb:
    if v<vb: idc_corners[h][v].d:=1; fi;
    if v>va: idc_corners[h][v].u:=1; fi;
  endfor;
enddef;

vardef idc_rect(expr ur,ll) =
  idc_horiz(ypart ur,xpart ur,xpart ll);
  idc_vert(xpart ur,ypart ll,ypart ur);
  idc_vert(xpart ll,ypart ll,ypart ur);
  idc_horiz(ypart ll,xpart ur,xpart ll);
enddef;

transform idc_drawxf;
(-1,-1) transformed idc_drawxf=(50,-50);
(97,-1) transformed idc_drawxf=(950,-50);
(97,97) transformed idc_drawxf=(950,850);

vardef idc_render =
  begingroup
    save glyph;
    path glyph;
    for h:=0 upto 6:
      for v:=0 upto 6:
        if (known idc_corners[h][v].l) or (known idc_corners[h][v].r)
          or (known idc_corners[h][v].u) or (known idc_corners[h][v].d):
          if fine_idcs:
            glyph:=(
              (-1,1)--if known idc_corners[h][v].d: (-1,2.5)--(1,2.5)-- fi
              (1,1)--if known idc_corners[h][v].r: (2.5,1)--(2.5,-1)-- fi
              (1,-1)--if known idc_corners[h][v].u: (1,-2.5)--(-1,-2.5)-- fi
              (-1,-1)--if known idc_corners[h][v].l: (-2.5,-1)--(-2.5,1)-- fi
              cycle) shifted ((h,v) scaled 16);
            dangerousFill glyph transformed idc_drawxf;
            if known idc_corners[h][v].d:
              glyph:=((-1,5.5)--(-1,10.5)--(1,10.5)--(1,5.5)--cycle)
                shifted ((h,v) scaled 16);
              dangerousFill glyph transformed idc_drawxf;
            fi;
            if known idc_corners[h][v].r:
              glyph:=((5.5,-1)--(5.5,1)--(10.5,1)--(10.5,-1)--cycle)
                shifted ((h,v) scaled 16);
              dangerousFill glyph transformed idc_drawxf;
            fi;
          else:
            glyph:=(
              (-2,2)--if known idc_corners[h][v].d: (-2,6)--(2,6)-- fi
              (2,2)--if known idc_corners[h][v].r: (6,2)--(6,-2)-- fi
              (2,-2)--if known idc_corners[h][v].u: (2,-6)--(-2,-6)-- fi
              (-2,-2)--if known idc_corners[h][v].l: (-6,-2)--(-6,2)-- fi
              cycle) shifted ((h,v) scaled 16);
            dangerousFill glyph transformed idc_drawxf;
          fi;
        fi;
        idc_corners[h][v].l:=whatever;
        idc_corners[h][v].r:=whatever;
        idc_corners[h][v].u:=whatever;
        idc_corners[h][v].d:=whatever;
      endfor;
    endfor;
  endgroup;
enddef;

% left to right
begintsuglyph("uni2FF0",240);
  idc_rect((0,6),(6,0));
  idc_vert(3,0,6);
  idc_render;
endtsuglyph;

% above to below
begintsuglyph("uni2FF1",241);
  idc_rect((0,6),(6,0));
  idc_horiz(3,0,6);
  idc_render;
endtsuglyph;

% left to middle to right
begintsuglyph("uni2FF2",242);
  idc_rect((0,6),(6,0));
  idc_vert(2,0,6);
  idc_vert(4,0,6);
  idc_render;
endtsuglyph;

% above to middle to below
begintsuglyph("uni2FF3",243);
  idc_rect((0,6),(6,0));
  idc_horiz(2,0,6);
  idc_horiz(4,0,6);
  idc_render;
endtsuglyph;

% full surround
begintsuglyph("uni2FF4",244);
  idc_rect((0,6),(6,0));
  idc_rect((1,5),(5,1));
  idc_render;
endtsuglyph;

% surround from above
begintsuglyph("uni2FF5",245);
  idc_rect((0,6),(6,0));
  idc_rect((2,4),(4,0));
  idc_render;
endtsuglyph;

% surround from below
begintsuglyph("uni2FF6",246);
  idc_rect((0,6),(6,0));
  idc_rect((2,6),(4,2));
  idc_render;
endtsuglyph;

% surround from left
begintsuglyph("uni2FF7",247);
  idc_rect((0,6),(6,0));
  idc_rect((2,4),(6,2));
  idc_render;
endtsuglyph;

% surround from upper left
begintsuglyph("uni2FF8",248);
  idc_rect((0,6),(6,0));
  idc_rect((2,4),(6,0));
  idc_render;
endtsuglyph;

% surround from upper right
begintsuglyph("uni2FF9",249);
  idc_rect((0,6),(6,0));
  idc_rect((0,4),(4,0));
  idc_render;
endtsuglyph;

% surround from lower left
begintsuglyph("uni2FFA",250);
  idc_rect((0,6),(6,0));
  idc_rect((2,6),(6,2));
  idc_render;
endtsuglyph;

% overlaid
begintsuglyph("uni2FFB",251);
  idc_rect((0,6),(4,2));
  idc_rect((2,4),(6,0));
  idc_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
