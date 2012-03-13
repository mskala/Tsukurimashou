%
% Hangul infrastructure for Jieubsida
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

inclusion_lock(hangul);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input buildkanji.mp;

pair hgbox_ll,hgbox_ul,hgbox_lr,hgbox_ur;

hgbox_ll=(50,-50);
hgbox_ul=(50,850);
hgbox_lr=(950,-50);
hgbox_ur=(950,850);

pair hgbox_lb,hgbox_rb,hgbox_ub,hgbox_db;

hgbox_lb=0.5[hgbox_ll,hgbox_ul];
hgbox_rb=0.5[hgbox_lr,hgbox_ur];
hgbox_ub=0.5[hgbox_ul,hgbox_ur];
hgbox_db=0.5[hgbox_ll,hgbox_lr];

% return a translate-and-scale (no rotation or skew) transform that takes
% the (50,850)-(950,-50) square to the specified upper left and lower
% right coordinates
vardef hxf(expr ul,lr) =
  begingroup
    save rval;
    transform rval;
    hgbox_ul transformed rval=ul;
    hgbox_lr transformed rval=lr;
    hgbox_ll transformed rval=(xpart ul,ypart lr);
    rval
  endgroup
enddef;

vardef hxf_inout(expr iotype,ixf,oxf) =
  begingroup
    save rval,vv,hv;
    transform rval;
    pair vv,hv;
    vv=(hgbox_ul transformed oxf)-(hgbox_ll transformed oxf);
    hv=(hgbox_lr transformed oxf)-(hgbox_ll transformed oxf);
    (hgbox_ul transformed rval)-(hgbox_ll transformed rval)=
      whatever*vv;
    (hgbox_lr transformed rval)-(hgbox_ll transformed rval)=
      whatever*hv;
    hgbox_rb transformed rval=whatever*vv+(hgbox_rb transformed
      if (iotype mod 2)=1: oxf else: ixf fi);
    hgbox_ub transformed rval=whatever*hv+(hgbox_ub transformed
      if (iotype mod 4)>=2: oxf else: ixf fi);
    hgbox_lb transformed rval=whatever*vv+(hgbox_lb transformed
      if (iotype mod 8)>=4: oxf else: ixf fi);
    hgbox_db transformed rval=whatever*hv+(hgbox_db transformed
      if iotype>=8: oxf else: ixf fi);
    rval
  endgroup
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Much useful information about how Unicode encodes hangul syllables is
% at http://www.uni-graz.at/~katzer/korean_hangul_unicode.html , and
% I'm following that source's nomenclature of "lead, vowel, tail."

% jamo IDs used in the table:
%    100+  lead
%    300+  vowel
%    500+  tail
% add 100 for alternate form, which is usually the one used on the left in
% multi-consonant clusters (like "leftrad" or "lift_skirt" in kanji)

string hangul.jamo[]code;
boolean hangul.jamo[]invokes_alternate;

% fill in default values for jamo - saves typing
vardef hangul.fill_in_jamo(expr jid) =
  if unknown hangul.jamo[jid]code: hangul.jamo[jid]code="jamo.bigx"; fi;
  if unknown hangul.jamo[jid]w: hangul.jamo[jid]w=4; fi;
  if unknown hangul.jamo[jid]h: hangul.jamo[jid]h=4; fi;
  if unknown hangul.jamo[jid]lb: hangul.jamo[jid]lb=50; fi;
  if unknown hangul.jamo[jid]rb: hangul.jamo[jid]rb=950; fi;
  if unknown hangul.jamo[jid]ub: hangul.jamo[jid]ub=850; fi;
  if unknown hangul.jamo[jid]db: hangul.jamo[jid]db=-50; fi;
  if unknown hangul.jamo[jid]invokes_alternate:
    hangul.jamo[jid]invokes_alternate=true;
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% JAMO COMBINING OPERATIONS

% calling convention:  hangul macros generally take a final set of
% parentheses containing a vowel ID and two transforms, ixf and oxf.
% The ixf transform will transform the (50,-50) to (950,850) square into
% where the jamo (or combination thereof) should be placed.  The oxf
% transform transforms that same square into a possibly-larger space
% representing limits created by adjacent jamo; this allows for parts
% of jamo that may extend into the adjacent jamo's space conditionally
% on the shape of the adjacent jamo.
%
% The "id" family of arguments are jamo IDs pointing into the hangul.jamo
% tables.

vardef hangul.combine.lr(expr lid,rid)(expr vow,ixf,oxf) =
  % put in default values if necessary
  hangul.fill_in_jamo(lid);
  hangul.fill_in_jamo(rid);

  % set up transform variables
  begingroup
    save lixf,loxf,rixf,roxf;
    transform lixf,loxf,rixf,roxf;

    % left inner transform
    hgbox_ul transformed lixf=hgbox_ul transformed ixf;
    hgbox_ll transformed lixf=hgbox_ll transformed ixf;
    if hangul.jamo[lid]w+hangul.jamo[rid]w=0:
      hgbox_lr transformed lixf=(0.5[hgbox_ll,hgbox_lr]) transformed ixf;
    else:
      hgbox_lr transformed lixf=
        ((hangul.jamo[lid]w/(hangul.jamo[lid]w+hangul.jamo[rid]w))
          [hgbox_ll,hgbox_lr]) transformed ixf;
    fi;
    
    % right inner transform
    hgbox_ur transformed rixf=hgbox_ur transformed ixf;
    hgbox_lr transformed rixf=hgbox_lr transformed ixf;
    hgbox_ll transformed rixf=hgbox_lr transformed lixf;
    
    % left outer transform
    (hgbox_ul transformed loxf)-(hgbox_ll transformed loxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed loxf)-(hgbox_ll transformed loxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed loxf)=
      (whatever[hgbox_ll,hgbox_ul]) transformed oxf;
    (hgbox_rb transformed loxf)=
      (hangul.jamo[rid]lb,400) transformed rixf
      +whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_ub transformed loxf)=
      (whatever[hgbox_ul,hgbox_ur]) transformed oxf;
    (hgbox_db transformed loxf)=
      (whatever[hgbox_ll,hgbox_lr]) transformed oxf;

    % right outer transform
    (hgbox_ul transformed roxf)-(hgbox_ll transformed roxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed roxf)-(hgbox_ll transformed roxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed roxf)=
      (hangul.jamo[lid]rb,400) transformed lixf
      +whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_rb transformed roxf)=
      (whatever[hgbox_lr,hgbox_ur]) transformed oxf;
    (hgbox_ub transformed roxf)=
      (whatever[hgbox_ul,hgbox_ur]) transformed oxf;
    (hgbox_db transformed roxf)=
      (whatever[hgbox_ll,hgbox_lr]) transformed oxf;

    % draw the contents
    hangul.scantokens hangul.jamo[lid]code (vow,lixf,loxf);
    hangul.scantokens hangul.jamo[rid]code (vow,rixf,roxf);
  endgroup;
enddef;

vardef hangul.combine.lcr(expr lid,cid,rid)(expr vow,ixf,oxf) =
  % put in default values if necessary
  hangul.fill_in_jamo(lid);
  hangul.fill_in_jamo(cid);
  hangul.fill_in_jamo(rid);

  % set up transform variables
  begingroup
    save lixf,loxf,cixf,coxf,rixf,roxf;
    transform lixf,loxf,cixf,coxf,rixf,roxf;

    % left inner transform
    hgbox_ul transformed lixf=hgbox_ul transformed ixf;
    hgbox_ll transformed lixf=hgbox_ll transformed ixf;
    if hangul.jamo[lid]w+hangul.jamo[cid]w+hangul.jamo[rid]w=0:
      hgbox_lr transformed lixf=(0.333[hgbox_ll,hgbox_lr]) transformed ixf;
    else:
      hgbox_lr transformed lixf=
        ((hangul.jamo[lid]w/
         (hangul.jamo[lid]w+hangul.jamo[cid]w+hangul.jamo[rid]w))
          [hgbox_ll,hgbox_lr]) transformed ixf;
    fi;

    % centre inner transform
    hgbox_ul transformed cixf=hgbox_ur transformed lixf;
    hgbox_ll transformed cixf=hgbox_lr transformed lixf;
    if hangul.jamo[lid]w+hangul.jamo[cid]w+hangul.jamo[rid]w=0:
      hgbox_lr transformed cixf=(0.667[hgbox_ll,hgbox_lr]) transformed ixf;
    else:
      hgbox_lr transformed cixf=
        (((hangul.jamo[lid]w+hangul.jamo[cid]w)/
         (hangul.jamo[lid]w+hangul.jamo[cid]w+hangul.jamo[rid]w))
          [hgbox_ll,hgbox_lr]) transformed ixf;
    fi;
    
    % right inner transform
    hgbox_ur transformed rixf=hgbox_ur transformed ixf;
    hgbox_lr transformed rixf=hgbox_lr transformed ixf;
    hgbox_ll transformed rixf=hgbox_lr transformed cixf;
    
    % left outer transform
    (hgbox_ul transformed loxf)-(hgbox_ll transformed loxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed loxf)-(hgbox_ll transformed loxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed loxf)=
      (whatever[hgbox_ll,hgbox_ul]) transformed oxf;
    (hgbox_rb transformed loxf)=
      (hangul.jamo[cid]lb,400) transformed cixf
      +whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_ub transformed loxf)=
      (whatever[hgbox_ul,hgbox_ur]) transformed oxf;
    (hgbox_db transformed loxf)=
      (whatever[hgbox_ll,hgbox_lr]) transformed oxf;

    % centre outer transform
    (hgbox_ul transformed coxf)-(hgbox_ll transformed coxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed coxf)-(hgbox_ll transformed coxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed coxf)=
      (hangul.jamo[lid]rb,400) transformed lixf
      +whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_rb transformed coxf)=
      (hangul.jamo[rid]lb,400) transformed rixf
      +whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_ub transformed coxf)=
      (whatever[hgbox_ul,hgbox_ur]) transformed oxf;
    (hgbox_db transformed coxf)=
      (whatever[hgbox_ll,hgbox_lr]) transformed oxf;

    % right outer transform
    (hgbox_ul transformed roxf)-(hgbox_ll transformed roxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed roxf)-(hgbox_ll transformed roxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed roxf)=
      (hangul.jamo[cid]rb,400) transformed cixf
      +whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_rb transformed roxf)=
      (whatever[hgbox_lr,hgbox_ur]) transformed oxf;
    (hgbox_ub transformed roxf)=
      (whatever[hgbox_ul,hgbox_ur]) transformed oxf;
    (hgbox_db transformed roxf)=
      (whatever[hgbox_ll,hgbox_lr]) transformed oxf;

    % draw the contents
    hangul.scantokens hangul.jamo[lid]code (vow,lixf,loxf);
    hangul.scantokens hangul.jamo[cid]code (vow,cixf,coxf);
    hangul.scantokens hangul.jamo[rid]code (vow,rixf,roxf);
  endgroup;
enddef;

vardef hangul.combine.syllable(expr lid,vid,tid)(expr vow,ixf,oxf) =
  % put in default values if necessary
  hangul.fill_in_jamo(lid);
  hangul.fill_in_jamo(vid);
  hangul.fill_in_jamo(tid);

  % set up transform variables
  begingroup
    save lixf,loxf,vixf,voxf,tixf,toxf;
    transform lixf,loxf,vixf,voxf,tixf,toxf;

    % lead inner transform
    hgbox_ul transformed lixf=hgbox_ul transformed ixf;
    if hangul.jamo[lid]w+hangul.jamo[vid]w=0:
      hgbox_ur transformed lixf=(0.5[hgbox_ul,hgbox_ur]) transformed ixf;
    else:
      hgbox_ur transformed lixf=
        ((hangul.jamo[lid]w/(hangul.jamo[lid]w+hangul.jamo[vid]w))
          [hgbox_ul,hgbox_ur]) transformed ixf;
    fi;
    if hangul.jamo[lid]h+hangul.jamo[vid]h+hangul.jamo[tid]h=0:
      hgbox_ll transformed lixf=(0.333[hgbox_ul,hgbox_ll]) transformed ixf;
    else:
      hgbox_ll transformed lixf=
        ((hangul.jamo[lid]h/
            (hangul.jamo[lid]h+hangul.jamo[vid]h+hangul.jamo[tid]h))
          [hgbox_ul,hgbox_ll]) transformed ixf;
    fi;

    % vowel inner transform
    hgbox_ul transformed vixf=hgbox_lr transformed lixf;
    if hangul.jamo[lid]h+hangul.jamo[vid]h+hangul.jamo[tid]h=0:
      hgbox_ur transformed vixf=(0.333[hgbox_ur,hgbox_lr]) transformed ixf;
      hgbox_lr transformed vixf=(0.333[hgbox_lr,hgbox_ur]) transformed ixf;
    else:
      hgbox_ur transformed vixf=
        ((hangul.jamo[lid]h/
            (hangul.jamo[lid]h+hangul.jamo[vid]h+hangul.jamo[tid]h))
          [hgbox_ur,hgbox_lr]) transformed ixf;
      hgbox_lr transformed vixf=
        ((hangul.jamo[tid]h/
            (hangul.jamo[lid]h+hangul.jamo[vid]h+hangul.jamo[tid]h))
          [hgbox_lr,hgbox_ur]) transformed ixf;
    fi;

    % tail inner transform
    hgbox_ll transformed tixf=hgbox_ll transformed ixf;
    hgbox_lr transformed tixf=hgbox_lr transformed ixf;
    hgbox_ur transformed tixf=hgbox_lr transformed vixf;
    
    % lead outer transform
    (hgbox_ul transformed loxf)-(hgbox_ll transformed loxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed loxf)-(hgbox_ll transformed loxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed loxf)=
      (whatever[hgbox_ll,hgbox_ul]) transformed oxf;
    (hgbox_rb transformed loxf)=
      (hangul.jamo[vid]lb,400) transformed vixf
      +whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_ub transformed loxf)=
      (whatever[hgbox_ul,hgbox_ur]) transformed oxf;
    (hgbox_db transformed loxf)=
      (500,hangul.jamo[vid]ub) transformed vixf
      +whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));

    % vowel outer transform
    (hgbox_ul transformed voxf)-(hgbox_ll transformed voxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed voxf)-(hgbox_ll transformed voxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed voxf)=
      (whatever[hgbox_ll,hgbox_ul]) transformed oxf;
    (hgbox_rb transformed voxf)=
      (whatever[hgbox_lr,hgbox_ur]) transformed oxf;
    (hgbox_ub transformed voxf)=
      (whatever[hgbox_ul,hgbox_ur]) transformed oxf;
    (hgbox_db transformed voxf)=
      (500,hangul.jamo[tid]ub) transformed tixf
      +whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));

    % tail outer transform
    (hgbox_ul transformed toxf)-(hgbox_ll transformed toxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed toxf)-(hgbox_ll transformed toxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed toxf)=
      (whatever[hgbox_ll,hgbox_ul]) transformed oxf;
    (hgbox_rb transformed toxf)=
      (whatever[hgbox_lr,hgbox_ur]) transformed oxf;
    (hgbox_ub transformed toxf)=
      (500,hangul.jamo[vid]db) transformed vixf
      +whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_db transformed toxf)=
      (whatever[hgbox_ll,hgbox_lr]) transformed oxf;
    
    % draw the contents
    build_kanji.level(hangul.scantokens hangul.jamo[vid]code (vid,vixf,voxf));
    hangul.scantokens hangul.jamo[lid]code (vid,lixf,loxf);
    hangul.scantokens hangul.jamo[tid]code
      (vid,hxf((100+20*mincho,850+30*mincho),(900-20*mincho,-50))
         transformed tixf,toxf);
  endgroup;
enddef;

vardef hangul.combine.tb(expr tid,bid)(expr vow,ixf,oxf) =
  % put in default values if necessary
  hangul.fill_in_jamo(tid);
  hangul.fill_in_jamo(bid);

  % set up transform variables
  begingroup
    save tixf,toxf,bixf,boxf;
    transform tixf,toxf,bixf,boxf;

    % top inner transform
    hgbox_ul transformed tixf=hgbox_ul transformed ixf;
    hgbox_ur transformed tixf=hgbox_ur transformed ixf;
    if hangul.jamo[tid]h+hangul.jamo[bid]h=0:
      hgbox_lr transformed tixf=(0.5[hgbox_ur,hgbox_lr]) transformed ixf;
    else:
      hgbox_lr transformed tixf=
        ((hangul.jamo[tid]h/(hangul.jamo[tid]h+hangul.jamo[bid]h))
          [hgbox_ur,hgbox_lr]) transformed ixf;
    fi;
    
    % bottom inner transform
    hgbox_lr transformed bixf=hgbox_lr transformed ixf;
    hgbox_ll transformed bixf=hgbox_ll transformed ixf;
    hgbox_ur transformed bixf=hgbox_lr transformed tixf;
    
    % left outer transform
    (hgbox_ul transformed toxf)-(hgbox_ll transformed toxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed toxf)-(hgbox_ll transformed toxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed toxf)=
      (whatever[hgbox_ll,hgbox_ul]) transformed oxf;
    (hgbox_rb transformed toxf)=
      (whatever[hgbox_lr,hgbox_ur]) transformed oxf;
    (hgbox_ub transformed toxf)=
      (whatever[hgbox_ul,hgbox_ur]) transformed oxf;
    (hgbox_db transformed toxf)=
      (500,hangul.jamo[bid]ub) transformed bixf
      +whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));

    % right outer transform
    (hgbox_ul transformed boxf)-(hgbox_ll transformed boxf)=
      whatever*((hgbox_ul transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lr transformed boxf)-(hgbox_ll transformed boxf)=
      whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_lb transformed boxf)=
      (whatever[hgbox_ll,hgbox_ul]) transformed oxf;
    (hgbox_rb transformed boxf)=
      (whatever[hgbox_lr,hgbox_ur]) transformed oxf;
    (hgbox_ub transformed boxf)=
      (500,hangul.jamo[tid]db) transformed tixf
      +whatever*((hgbox_lr transformed oxf)-(hgbox_ll transformed oxf));
    (hgbox_db transformed boxf)=
      (whatever[hgbox_ll,hgbox_lr]) transformed oxf;

    % draw the contents
    hangul.scantokens hangul.jamo[tid]code (vow,tixf,toxf);
    hangul.scantokens hangul.jamo[bid]code (vow,bixf,boxf);
  endgroup;
enddef;

