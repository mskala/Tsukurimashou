%
% Generic Unicode page (precomposed hangul syllables) for Jieubsida
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

inclusion_lock(hglpage);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfont

% AUTODEPS
input buildkanji.mp;
input hangul.mp;

% non-auto dep (accessed through code table)
input jamo-basic.mp;

string hexdigit[];

hexdigit[0]="0";hexdigit[1]="1";hexdigit[2]="2";hexdigit[3]="3";
hexdigit[4]="4";hexdigit[5]="5";hexdigit[6]="6";hexdigit[7]="7";
hexdigit[8]="8";hexdigit[9]="9";hexdigit[10]="A";hexdigit[11]="B";
hexdigit[12]="C";hexdigit[13]="D";hexdigit[14]="E";hexdigit[15]="F";

for i:=0 upto 255:
  begintsuglyph("uni" & hgls_page
    & hexdigit[floor(i/16)] & hexdigit[i mod 16],i);
message "uni" & hgls_page
    & hexdigit[floor(i/16)] & hexdigit[i mod 16];
    hangul.combine.syllable(100+hgls_lead,300+hgls_vowel,500+hgls_tail)
      (300+hgls_vowel,identity,identity);
    tsu_render;
  endtsuglyph;
  hgls_tail:=hgls_tail+1;
  if hgls_tail>=28:
    hgls_tail:=0;
    hgls_vowel:=hgls_vowel+1;
    if hgls_vowel>=21:
      hgls_vowel:=0;
      hgls_lead:=hgls_lead+1;
      exitif hgls_lead>=19;
    fi;
  fi;
endfor;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
