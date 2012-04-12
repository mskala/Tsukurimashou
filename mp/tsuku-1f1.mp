%
% Unicode page 1F1 (Enclosed Supplement) for Tsukurimashou
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

input latin-intro.mp;

% AUTODEPS
input enclosed.mp;
input latin.mp;

do_late_includes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SQUARED LATIN

% A
begintsuglyph("u1F130",48);
  square.single(latin.upa);
  tsu_render;
endtsuglyph;

% B
begintsuglyph("u1F131",49);
  square.single(latin.upb);
  tsu_render;
endtsuglyph;

% C
begintsuglyph("u1F132",50);
  square.single(latin.upc);
  tsu_render;
endtsuglyph;

% D
begintsuglyph("u1F133",51);
  square.single(latin.upd);
  tsu_render;
endtsuglyph;

% E
begintsuglyph("u1F134",52);
  square.single(latin.upe);
  tsu_render;
endtsuglyph;

% F
begintsuglyph("u1F135",53);
  square.single(latin.upf);
  tsu_render;
endtsuglyph;

% G
begintsuglyph("u1F136",54);
  square.single(latin.upg);
  tsu_render;
endtsuglyph;

% H
begintsuglyph("u1F137",55);
  square.single(latin.uph);
  tsu_render;
endtsuglyph;

% I
begintsuglyph("u1F138",56);
  square.single(latin.upi);
  tsu_render;
endtsuglyph;

% J
begintsuglyph("u1F139",57);
  square.single(latin.upj);
  tsu_render;
endtsuglyph;

% K
begintsuglyph("u1F13A",58);
  square.single(latin.upk);
  tsu_render;
endtsuglyph;

% L
begintsuglyph("u1F13B",59);
  square.single(latin.upl);
  tsu_render;
endtsuglyph;

% M
begintsuglyph("u1F13C",60);
  square.single(latin.upm);
  tsu_render;
endtsuglyph;

% N
begintsuglyph("u1F13D",61);
  square.single(latin.upn);
  tsu_render;
endtsuglyph;

% O
begintsuglyph("u1F13E",62);
  square.single(latin.upo);
  tsu_render;
endtsuglyph;

% P
begintsuglyph("u1F13F",63);
  square.single(latin.upp);
  tsu_render;
endtsuglyph;

% Q
begintsuglyph("u1F140",64);
  square.single(latin.upq);
  tsu_render;
endtsuglyph;

% R
begintsuglyph("u1F141",65);
  square.single(latin.upr);
  tsu_render;
endtsuglyph;

% S
begintsuglyph("u1F142",66);
  square.single(latin.ups);
  tsu_render;
endtsuglyph;

% T
begintsuglyph("u1F143",67);
  square.single(latin.upt);
  tsu_render;
endtsuglyph;

% U
begintsuglyph("u1F144",68);
  square.single(latin.upu);
  tsu_render;
endtsuglyph;

% V
begintsuglyph("u1F145",69);
  square.single(latin.upv);
  tsu_render;
endtsuglyph;

% W
begintsuglyph("u1F146",70);
  square.single(latin.upw);
  tsu_render;
endtsuglyph;

% X
begintsuglyph("u1F147",71);
  square.single(latin.upx);
  tsu_render;
endtsuglyph;

% Y
begintsuglyph("u1F148",72);
  square.single(latin.upy);
  tsu_render;
endtsuglyph;

% Z
begintsuglyph("u1F149",73);
  square.single(latin.upz);
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INVERSE CIRCLED LATIN

% A
% BACKGROUND 25CF
begintsuglyph("u1F150",80);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upa);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% B
% BACKGROUND 25CF
begintsuglyph("u1F151",81);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upb);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% C
% BACKGROUND 25CF
begintsuglyph("u1F152",82);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upc);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% D
% BACKGROUND 25CF
begintsuglyph("u1F153",83);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upd);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% E
% BACKGROUND 25CF
begintsuglyph("u1F154",84);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upe);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% F
% BACKGROUND 25CF
begintsuglyph("u1F155",85);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upf);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% G
% BACKGROUND 25CF
begintsuglyph("u1F156",86);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upg);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% H
% BACKGROUND 25CF
begintsuglyph("u1F157",87);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.uph);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% I
% BACKGROUND 25CF
begintsuglyph("u1F158",88);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upi);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% J
% BACKGROUND 25CF
begintsuglyph("u1F159",89);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upj);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% K
% BACKGROUND 25CF
begintsuglyph("u1F15A",90);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upk);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% L
% BACKGROUND 25CF
begintsuglyph("u1F15B",91);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upl);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% M
% BACKGROUND 25CF
begintsuglyph("u1F15C",92);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upm);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% N
% BACKGROUND 25CF
begintsuglyph("u1F15D",93);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upn);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% O
% BACKGROUND 25CF
begintsuglyph("u1F15E",94);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upo);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% P
% BACKGROUND 25CF
begintsuglyph("u1F15F",95);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upp);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% Q
% BACKGROUND 25CF
begintsuglyph("u1F160",96);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upq);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% R
% BACKGROUND 25CF
begintsuglyph("u1F161",97);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upr);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% S
% BACKGROUND 25CF
begintsuglyph("u1F162",98);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.ups);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% T
% BACKGROUND 25CF
begintsuglyph("u1F163",99);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upt);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% U
% BACKGROUND 25CF
begintsuglyph("u1F164",100);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upu);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% V
% BACKGROUND 25CF
begintsuglyph("u1F165",101);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upv);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% W
% BACKGROUND 25CF
begintsuglyph("u1F166",102);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upw);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% X
% BACKGROUND 25CF
begintsuglyph("u1F167",103);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upx);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% Y
% BACKGROUND 25CF
begintsuglyph("u1F168",104);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upy);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% Z
% BACKGROUND 25CF
begintsuglyph("u1F169",105);
  tsu_xform(tsu_xf.cletter shifted tsu_xf.circ_slant_shift)(latin.upz);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INVERSE SQUARED LATIN

% A
% BACKGROUND F1712
begintsuglyph("u1F170",112);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upa);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% B
% BACKGROUND F1712
begintsuglyph("u1F171",113);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upb);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% C
% BACKGROUND F1712
begintsuglyph("u1F172",114);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upc);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% D
% BACKGROUND F1712
begintsuglyph("u1F173",115);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upd);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% E
% BACKGROUND F1712
begintsuglyph("u1F174",116);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upe);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% F
% BACKGROUND F1712
begintsuglyph("u1F175",117);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upf);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% G
% BACKGROUND F1712
begintsuglyph("u1F176",118);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upg);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% H
% BACKGROUND F1712
begintsuglyph("u1F177",119);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.uph);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% I
% BACKGROUND F1712
begintsuglyph("u1F178",120);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upi);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% J
% BACKGROUND F1712
begintsuglyph("u1F179",121);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upj);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% K
% BACKGROUND F1712
begintsuglyph("u1F17A",122);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upk);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% L
% BACKGROUND F1712
begintsuglyph("u1F17B",123);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upl);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% M
% BACKGROUND F1712
begintsuglyph("u1F17C",124);
  if do_alternation:
    tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift
      shifted -centre_pt xscaled 0.95 shifted centre_pt)(latin.upm);
  else:
    tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upm);
  fi;
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% N
% BACKGROUND F1712
begintsuglyph("u1F17D",125);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upn);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% O
% BACKGROUND F1712
begintsuglyph("u1F17E",126);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upo);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% P
% BACKGROUND F1712
begintsuglyph("u1F17F",127);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upp);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% Q
% BACKGROUND F1712
begintsuglyph("u1F180",128);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upq);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% R
% BACKGROUND F1712
begintsuglyph("u1F181",129);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upr);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% S
% BACKGROUND F1712
begintsuglyph("u1F182",130);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.ups);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% T
% BACKGROUND F1712
begintsuglyph("u1F183",131);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upt);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% U
% BACKGROUND F1712
begintsuglyph("u1F184",132);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upu);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% V
% BACKGROUND F1712
begintsuglyph("u1F185",133);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upv);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% W
% BACKGROUND F1712
begintsuglyph("u1F186",134);
  if do_alternation:
    tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift
      shifted -centre_pt xscaled 0.95 shifted centre_pt)(latin.upw);
  else:
    tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upw);
  fi;
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% X
% BACKGROUND F1712
begintsuglyph("u1F187",135);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upx);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% Y
% BACKGROUND F1712
begintsuglyph("u1F188",136);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upy);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

% Z
% BACKGROUND F1712
begintsuglyph("u1F189",137);
  tsu_xform(tsu_xf.sletter shifted tsu_xf.circ_slant_shift)(latin.upz);
  i:=0; forever: exitif find_stroke(i)<1; set_bosize(i,107); i:=i-1; endfor;
  tsu_render;
endtsuglyph;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
