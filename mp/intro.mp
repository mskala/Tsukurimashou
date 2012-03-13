%
% General shared code for Tsukurimashou
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

inclusion_lock(intro);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  Tsukurimashou intro - utility routines for all pages
%

pf_info_quad 1000;
pf_info_space 1000, 0, 0;
pf_info_familyname "Tsukurimashou" & stylename;
pf_info_fixedpitch true;
pf_info_capheight 900;
pf_info_xheight 585;
% pf_info_ascender 900;
% pf_info_descender 100;
pf_info_ascender 985;
pf_info_descender 265;

pair centre_pt;
centre_pt=(500,390);
latin_vcentre:=430;
latin_wide_baseline:=25;
latin_wide_top:=750;
wide_margin:=30;
narrow_margin:=40;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input bcircle.mp;
input obstack.mp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get rid of degeneracies
vardef regenerate(expr p) =
  begingroup
    save q;
    path q;
    for t=1 step 1 until length p:
      if abs((point t of p)-(point (t-1) of p))>3:
        if unknown q:
          q:=subpath (t-1,t) of p;
        elseif length(q)=1:
          q:=(point 0 of q)..
              controls (postcontrol 0 of q) and (precontrol 1 of q)..
            (0.5[point 1 of q,point t-1 of p])..
              controls (postcontrol t-1 of p) and (precontrol t of p)..
            (point t of p);
        else:
          q:=(subpath (0,length(q)-1) of q)..
              controls (postcontrol length(q)-1 of q)
                and (precontrol length(q) of q)..
            (0.5[point length(q) of q,point t-1 of p])..
              controls (postcontrol t-1 of p) and (precontrol t of p)..
            (point t of p);
        fi;
      fi;
    endfor;
    if cycle p:
      q:=subpath (0,length(q)-1) of q..
           controls (postcontrol length(q)-1 of q)
             and (precontrol length(q) of q)..
         cycle;
    fi;
    q
  endgroup
enddef;

% like Fill, but doesn't complain about turning number
def dangerousFill text glist =
 begingroup
  save h_; path h_;
  for g_:=glist:
   h_:=g_ start.default; % JMN's suggestion
   if glyph_usage div store = 1: % storing
    glyph_stored.glyph_name[incr glyph_stored.glyph_name.num]=h_;
   fi
   glyph_list[incr glyph_list.num]:=round_node_values(h_ italicized);
   update_glyph_bb(glyph_list[glyph_list.num]);
  endfor;
 endgroup
enddef;

default_nib:=fix_nib(100,100,0);

def begintsuglyph(expr name,code) =
  message name;
  encode(name) (code); standard_introduce(name);
  write ("BEGINGLYPH '"&name& "' "&decimal code) to "proof.prf";
  beginglyph(name);
    init_obstack;
    string perl_structure;
    perl_structure:="$structure{'"&name&"'}=['"&name&"',";
enddef;

def endtsuglyph =
    fix_hsbw((rescale_to.left+rescale_to.right),0,0);
  endglyph;
  perl_structure:=perl_structure&"];";
  write "PERL_STRUCTURE "&perl_structure to "proof.prf";
  if rescale_to.right=0:
    write "ENDGLYPH -10 0" to "proof.prf";
  else:
    write ("ENDGLYPH 0 "&decimal (rescale_to.left+rescale_to.right))
      to "proof.prf";
  fi;
enddef;

def tsu_brush_tip_size(expr l,q) =
  begingroup
    numeric y,yy;
    y:=ypart (point l of q);
    if y<tsu_brush_min:
      yy:=tsu_brush_min;
    elseif y>tsu_brush_max:
      yy:=tsu_brush_max;
    else:
      yy:=y;
    fi;
    yy
  endgroup
enddef;

def tsu_brush_tip(expr l,p,q,bsi,is_start,is_end,is_alt) =
  begingroup
    numeric y;
    y=tsu_brush_tip_size(l,q);
    if is_alt and do_alternation:
      fix_nib(bsi*y*tsu_brush_shape,bsi*y*tsu_brush_shape,tsu_brush_angle)
    else:
      fix_nib(bsi*y,bsi*y*tsu_brush_shape,tsu_brush_angle)
    fi
  endgroup
enddef;

% rescaling for half/double width
% this is basically global because it will be shared by most glyphs in a file

path width_curve;

vardef tsu_rescale_full =
  rescale_from.left:=wide_margin;
  rescale_from.right:=1000-wide_margin;
  rescale_from.top:=ypart centre_pt;
  rescale_from.bottom:=latin_wide_baseline;

  rescale_to.left:=wide_margin;
  rescale_to.right:=1000-wide_margin;
  rescale_to.top:=ypart centre_pt;
  rescale_to.bottom:=latin_wide_baseline;

  rescale_skew:=0;

  width_curve:=(-1,-1)--(2000,2000);
enddef;

vardef tsu_rescale_half =
  rescale_from.left:=wide_margin;
  rescale_from.right:=1000-wide_margin;
  rescale_from.top:=ypart centre_pt;
  rescale_from.bottom:=latin_wide_baseline;

  rescale_to.left:=narrow_margin;
  rescale_to.right:=500-narrow_margin;
  rescale_to.top:=latin_vcentre;
  rescale_to.bottom:=0;

  rescale_skew:=0;

  width_curve:=((-1,-1)--(100,100))..(940,410)..{right}(2000,1000);
enddef;

vardef tsu_rescale_half_lc =
  rescale_from.left:=wide_margin*3.5;
  rescale_from.right:=1000-wide_margin*3.5;
  rescale_from.top:=ypart centre_pt;
  rescale_from.bottom:=latin_wide_baseline;

  rescale_to.left:=narrow_margin;
  rescale_to.right:=500-narrow_margin;
  rescale_to.top:=latin_vcentre;
  rescale_to.bottom:=0;

  rescale_skew:=0;

  width_curve:=((-1,-1)--(100,100))..(780,410)..{right}(2000,1000);
enddef;

vardef tsu_rescale_half_katakana =
  rescale_from.left:=wide_margin;
  rescale_from.right:=1000-wide_margin;
  rescale_from.top:=700;
  rescale_from.bottom:=0;

  rescale_to.left:=narrow_margin;
  rescale_to.right:=500-narrow_margin;
  rescale_to.top:=670;
  rescale_to.bottom:=30;

  rescale_skew:=8;

  width_curve:=((-1,-1)--(100,100))..(860,440)..{right}(2000,1000);
enddef;

vardef tsu_rescale_double =
  rescale_from.left:=narrow_margin;
  rescale_from.right:=500-narrow_margin;
  rescale_from.top:=latin_vcentre;
  rescale_from.bottom:=0;

  rescale_to.left:=wide_margin;
  rescale_to.right:=1000-wide_margin;
  rescale_to.top:=ypart centre_pt;
  rescale_to.bottom:=latin_wide_baseline;

  rescale_skew:=0;

  width_curve:=(-1,-1)--(2000,2000);
enddef;

vardef tsu_rescale_decenter =
  rescale_from.left:=300;
  rescale_from.right:=700;
  rescale_from.top:=ypart centre_pt;
  rescale_from.bottom:=latin_wide_baseline;

  rescale_to.left:=50;
  rescale_to.right:=450;
  rescale_to.top:=latin_vcentre;
  rescale_to.bottom:=0;

  rescale_skew:=0;

  width_curve:=(-1,-1)--(2000,2000);
enddef;

vardef tsu_rescale_native_narrow =
  rescale_from.left:=narrow_margin;
  rescale_from.right:=500-narrow_margin;
  rescale_from.top:=latin_vcentre;
  rescale_from.bottom:=0;

  rescale_to.left:=narrow_margin;
  rescale_to.right:=500-narrow_margin;
  rescale_to.top:=latin_vcentre;
  rescale_to.bottom:=0;

  rescale_skew:=0;

  width_curve:=(-1,-1)--(2000,2000);
enddef;

vardef tsu_rescale_native_zero =
  rescale_from.left:=0;
  rescale_from.right:=0;
  rescale_from.top:=1000;
  rescale_from.bottom:=0;

  rescale_to.left:=0;
  rescale_to.right:=0;
  rescale_to.top:=1000;
  rescale_to.bottom:=0;

  rescale_skew:=0;

  width_curve:=(-1,-1)--(2000,2000);
enddef;

vardef tsu_rescale_native_conditional =
  if is_proportional:
    tsu_rescale_full;
  else:
    tsu_rescale_native_narrow;
  fi;
enddef;

tsu_rescale_full;

vardef tsu_rescale_xform =
  begingroup
    save t;
    transform t;
    t:=identity;
    % check if rescaling is active
    if (rescale_from.left<>rescale_to.left)
    or (rescale_from.right<>rescale_to.right): begingroup
      save i,xa,xb,lf,rf,wf,lt,rt,wt;
      numeric i,xa,xb,lf,rf,wf,lt,rt,wt;
      transform t;
      % find the bounds of the paths
      if find_stroke(0)<=0:
        xa:=0.5[rescale_from.left,rescale_from.right];
        xb:=0.5[rescale_from.left,rescale_from.right];
      else:
        xa:=infinity;
        xb:=-infinity;
        for i=1 upto sp-1:
          if obstacktype[i]=otstroke:
            if (xpart llcorner obstackp[i])<xa:
              xa:=xpart llcorner obstackp[i];
            fi;
            if (xpart lrcorner obstackp[i])>xb:
              xb:=xpart lrcorner obstackp[i];
            fi;
          fi;
        endfor;
      fi;
      % compute bearings and widths
      lf=xa-rescale_from.left;
      rf=rescale_from.right-xb;
      lf+rf+wf=rescale_from.right-rescale_from.left;
      lt+rt+wt=rescale_to.right-rescale_to.left;
      (lt,rt)=whatever[(0,0),(lf,rf)];
      wt=ypart (width_curve intersectionpoint ((wf,-infinity)--(wf,infinity)));
      % find transformation
      if wf>0:
        (rescale_from.left+lf,rescale_from.bottom) transformed t=
          (rescale_to.left+lt,rescale_to.bottom-rescale_skew);
        (rescale_from.left+lf,rescale_from.top) transformed t=
          (rescale_to.left+lt,rescale_to.top-rescale_skew);
        (rescale_from.right-rf,rescale_from.bottom) transformed t=
          (rescale_to.right-rt,rescale_to.bottom+rescale_skew);
      else:
        (rescale_from.left+lf,rescale_from.bottom) transformed t=
          (rescale_to.left+lt,rescale_to.bottom);
        (rescale_from.left+lf,rescale_from.top) transformed t=
          (rescale_to.left+lt,rescale_to.top);
        (rescale_from.left+lf+1,rescale_from.bottom) transformed t=
          (rescale_to.left+lt+1,rescale_to.bottom);
      fi;
    endgroup; fi;
    t
  endgroup
enddef;

% render a single segment - pulled out to make it easier to override
vardef tsu_render_segment(expr i,p,q) =
  if do_alternation and obstackba.boalternate[i]:
    default_nib:=fix_nib(obstackna.bosize[i]*tsu_brush_max
                           *tsu_brush_shape,
                         obstackna.bosize[i]*tsu_brush_max
                           *tsu_brush_shape,
                         0);
  else:
    default_nib:=fix_nib(obstackna.bosize[i]*tsu_brush_max,
                         obstackna.bosize[i]*tsu_brush_max
                           *tsu_brush_shape,
                         tsu_brush_angle);
  fi;
  path mytip[],glyph;
  for l=0 step 1 until length(p):
    mytip[l]:=tsu_brush_tip(l,p,q,obstackna.bosize[i],s<1,
      t>(length obstackp[i])-1,obstackba.boalternate[i]);
  endfor;
  pen_stroke(for l=0 step 1 until length(p):
      if sharp_corners and known obstacknaa.botip[i][ltime[l]]:
        tip(obstacknaa.botip[i][ltime[l]])(l)
      else:
        tsu_brush_opt(mytip[l])(l)
      fi
    endfor)(p)(glyph);
  glstk[ngls]:=regenerate(glyph);
  ngls:=ngls+1;
  for l=0 step 1 until length(p):
    si:=floor (ltime[l]+0.5);
    if known obstacknaa.boserif[i][si]:
      tsu_serif.choose(obstacknaa.boserif[i][si],
        point l of p,direction l of p,l,
        obstackna.bosize[i],tsu_brush_tip_size(l,q));
      write ("SERIF "&(decimal obstacknaa.boserif[i][si])&" "&
            (decimal xpart point l of p)&","&
            (decimal ypart point l of p)) to "proof.prf";
    fi;
  endfor;
enddef;

def tsu_render_in_circle(expr fitcircle) =
  %
  % find and apply rescaling xform
  %
  transform tsu_rescaling_xf;
  tsu_rescaling_xf:=tsu_rescale_xform;
  for i=1 upto sp-1:
    if known obstackp[i]:
      obstackp[i]:=obstackp[i] transformed tsu_rescaling_xf;
    fi;
    if known obstackt[i]:
      obstackt[i]:=obstackt[i] transformed tsu_rescaling_xf;
    fi;
  endfor;
  %
  % main render
  %
  for i=1 upto sp-1: if obstacktype[i]=othook:
    if obstackn[i]=hsmain_render:
      scantokens obstacks[i];
    fi;
  fi; endfor;
  begingroup
    numeric i,j,k,l,s,t,si,ngls,flati;
    path bqi,p,q,glstk[];
    ngls:=0;
    flati:=1;
    for i=1 upto sp-1: if obstacktype[i]=otstroke:
      if unknown obstackba.boalternate[i]:
        obstackba.boalternate[i]:=false;
      fi;
% message "suffix " & str i;
      bqi:=obstackq[i] transformed tsu_brush_xf;
      s:=0;
      for j=0 step 1 until (length obstackp[i])-1:
         k:=j+1;
% message "  j=" & decimal j & " thr " & decimal (xpart point j of bqi)
%   & "/" & decimal (xpart point k of bqi);
         if ((xpart point j of bqi)<1)
             and ((xpart point k of bqi)>=1):
% message "    START";
           if (xpart point k of bqi)=1:
             s:=k;
           else:
             s:=j+(xpart ((subpath (j,k) of bqi)
               intersectiontimes ((1,-infinity)
               --(1,infinity))));
           fi;
         fi;
         if ((((xpart point j of bqi)>=1) and ((xpart point k of bqi)<1))
           or (k=length obstackp[i])):
% message "    END";
           if (xpart point k of bqi)>=1:
             t:=k;
           else:
             t:=j+(xpart ((subpath (j,k) of bqi)
               intersectiontimes ((1,-infinity)
               --(1,infinity))));
           fi;
           if ((t-s)>0.02) and (obstackna.bosize[i]>0):
             boolean is_cycle;
             is_cycle:=((point s of obstackp[i])=(point t of obstackp[i]));
             p:=subpath (s,t) of obstackp[i];
             q:=subpath (s,t) of bqi;
% message "ltiming...";
             numeric ltime[];
             ltime[0]:=s;
% message decimal s;
             for l=1 step 1 until (length p)-1:
               ltime[l]:=floor (s+l);
% message decimal floor (s+l);
             endfor;
             ltime[length p]:=t;
% message decimal t;
             write ("SEGMENT "&(decimal flati)&" "&(decimal s)&" "&(decimal t))
               to "proof.prf";
             for lcbj=0 upto length p:
               write ("POINT "&(decimal flati)&" "&(decimal ltime[lcbj])&" "
                 &(decimal xpart point lcbj of p)&" "
                 &(decimal ypart point lcbj of p)) to "proof.prf";
             endfor;
             flati:=flati+1;
             tsu_render_segment(i,p,q);
           fi;
         fi;
      endfor;
    elseif obstacktype[i]=otlcblob:
      glstk[ngls]:=regenerate(obstackp[i]);
      ngls:=ngls+1;
    fi; endfor;
    %
    % handle bounding circle
    %
    if xxpart fitcircle>0:
      begingroup
        save d,tmppt,pind,xpt,pts,pcnt,tmpxf;
        pair pts[];
        transform d;
        pcnt:=0;
        for j=0 upto ngls-1:
          for i=0 step 0.1 until length glstk[j]:
            pts[pcnt]:=point i of glstk[j];
            pcnt:=pcnt+1;
          endfor
        endfor;
        save lowpt; numeric lowpt;
        lowpt:=0;
        for i=0 upto pcnt-2:
          for j=i+1 upto pcnt-1:
            if (i>=lowpt) and (j>=lowpt) and (abs(pts[i]-pts[j])<2):
              swap_pts(j,lowpt);
              lowpt:=lowpt+1;
            fi;
          endfor;
        endfor;
        d:=bcircle.internal(lowpt,pcnt,pcnt);
        transform tmpxf;
        tmpxf=identity shifted (((0,0) transformed fitcircle)-
                                ((0,0) transformed d));
        for j=0 upto ngls-1:
          glstk[j]:=glstk[j] transformed tmpxf;
        endfor;
      endgroup
    fi;
    %
    % finally render it all
    %
    for i=0 upto ngls-1:
      dangerousFill glstk[i];
    endfor;
    %
    % write misc. proof file stuff
    %
    blobcount:=0;
    boxcount:=0;
    for i=1 upto sp-1:
      if obstacktype[i]=otlcblob:
        begingroup
          save spt,n;
          pair spt;
          spt:=(0,0);
          n:=0;
          for j=1 upto length obstackp[i]:
            n:=n+1;
            spt:=spt+(point j of obstackp[i]);
          endfor;
          spt:=spt/n;
          blobcount:=blobcount+1;
          write ("BLOBCENTRE "&(decimal blobcount)&" "
            &(decimal xpart spt)&" "&(decimal ypart spt)) to "proof.prf";
        endgroup;
      elseif obstacktype[i]=otpbox:
        boxcount:=boxcount+1;
        write ("PBOX "&
               (decimal boxcount)&" "&
               (decimal xpart ((0,0) transformed obstackt[i]))&" "&
               (decimal ypart ((0,0) transformed obstackt[i]))&" "&
               (decimal xpart ((1,0) transformed obstackt[i]))&" "&
               (decimal ypart ((1,0) transformed obstackt[i]))&" "&
               (decimal xpart ((1,1) transformed obstackt[i]))&" "&
               (decimal ypart ((1,1) transformed obstackt[i]))&" "&
               (decimal xpart ((0,1) transformed obstackt[i]))&" "&
               (decimal ypart ((0,1) transformed obstackt[i]))&" '"&
               obstacks[i]&"'") to "proof.prf";
        if known obstackba.botoexpand[i]:
          if obstackba.botoexpand[i]:
            errmessage "Unexpanded PBOX: " & obstacks[i];
          fi;
        fi;
      elseif obstacktype[i]=otanchor:
        begingroup
          save topanchor;
          numeric topanchor;
          topanchor:=i;
          for j:=sp-1 downto i+1:
            if obstacktype[j]=otanchor:
              if obstackn[j]=obstackn[i]:
                topanchor:=j;
              fi;
            fi;
            exitif topanchor<>i;
          endfor;
          if topanchor=i:
            write ("ANCHOR "&
                   (decimal obstackn[i])&" "&
                   (decimal xpart ((-35,0) transformed obstackt[i]))&" "&
                   (decimal ypart ((-35,0) transformed obstackt[i]))&" "&
                   (decimal xpart ((35,0) transformed obstackt[i]))&" "&
                   (decimal ypart ((35,0) transformed obstackt[i]))&" "&
                   (decimal xpart ((0,-35) transformed obstackt[i]))&" "&
                   (decimal ypart ((0,-35) transformed obstackt[i]))&" "&
                   (decimal xpart ((0,35) transformed obstackt[i]))&" "&
                   (decimal ypart ((0,35) transformed obstackt[i])))
                    to "proof.prf";
          fi;
        endgroup;
      fi;
    endfor;
  endgroup;
enddef;

% the usual case - just render it without fitting into a circle
def tsu_render =
  tsu_render_in_circle(identity scaled -1);
enddef;

transform tsu_xf.smallkana;

tsu_xf.smallkana = identity shifted (-500,0) scaled 5.5/8 shifted (500,0);

vardef tsu_xform(expr xform)(text curves) =
  begingroup
    save txfsp;
    txfsp:=sp;
    curves;
    size_scale:=(abs(((0,0) transformed xform)
                    -((1,0) transformed xform))
                *abs(((0,0) transformed xform)
                    -((0,1) transformed xform)))**0.16667;
    for i=txfsp upto sp-1:
      if known obstackp[i]:
        obstackp[i]:=obstackp[i] transformed xform;
      fi;
      if known obstackna.bosize[i]:
        obstackna.bosize[i]:=obstackna.bosize[i]*size_scale;
      fi;
      if known obstackt[i]:
        obstackt[i]:=obstackt[i] transformed xform;
      fi;
    endfor;
  endgroup;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

def anc_upper_accent = 1 enddef;
def anc_lower_accent = 2 enddef;
def anc_centre_accent = 3 enddef;
def anc_upper_left = 4 enddef;
def anc_upper_right = 5 enddef;
def anc_upper_ring = 6 enddef;
def anc_caron_comma = 7 enddef;
def anc_dakuten = 8 enddef;
vardef anc_iching_line(expr lnum) = (8+lnum) enddef;

transform accent_default[];
numeric anchor_parent[];

vardef tsu_default_anchor(expr aindex,avalue) =
  if numeric avalue:
    write ("DEFAULTANCHOR "&(decimal aindex)&" FALSE") to "proof.prf";
  elseif transform avalue:
    write ("DEFAULTANCHOR "&
           (decimal aindex)&" "&
           (decimal xpart ((0,0) transformed avalue))&" "&
           (decimal ypart ((0,0) transformed avalue)))
            to "proof.prf";
  elseif pair avalue:
    write ("DEFAULTANCHOR "&
           (decimal aindex)&" "&
           (decimal xpart avalue)&" "&
           (decimal ypart avalue))
            to "proof.prf";
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% there is some kind of bug in MetaType1 causing it to blow up when
% stroking a path at a certain angle of about 290 degrees.  Exactly why,
% I don't know; the code is documented primarily in Polish and not well
% documented at all.  The code below is a workaround to prevent it from
% evaluating turning angles on zero vectors; in addition to this, it is
% sometimes necessary to add extra points to paths to get correct-looking
% behaviour.

% "fixed" version
vardef pen_stroke_edge(expr p) =
 save e_,e__,l_,i_,i__,myflag; path e_[\\],e__[\\];
 l_:=length(p);
 for i_:=0 upto l_-1:
  e_[i_]=pen_stroke_edge_(subpath (i_,i_+1) of p,
   local_nib_(i_),local_nib_(i_+1));
 endfor
 for i_:=0 upto l_ if cycle p: -1 else: -2 fi:
  i__:=(i_+1) mod l_;
  boolean myflag;
  if ((direction 1 of e_[i_])=(0,0)) or ((direction 0 of e_[i__])=(0,0)):
    myflag:=true;
  elseif abs(turn_ang(direction 1 of e_[i_], direction 0 of e_[i__]))>1:
    myflag:=true;
  else:
    myflag:=false;
  fi;
  if myflag:
   save t_; (t_.a,t_.b)=e_[i_] intersectiontimes reverse e_[i__];
   if t_.a>0:
    e_[i_]:=subpath (0,t_.a) of e_[i_];
    e_[i__]:=subpath (1-t_.b,1) of e_[i__];
   elseif known local_tip_(i__):
    e__1:=extrapolate  (0,xpart local_tip_(i__)) of e_[i_];
    e__2:=extrapolate (ypart local_tip_(i__),1) of e_[i__];
    save t_; (t_.a,t_.b)=e__1 intersectiontimes reverse e__2;
    if t_.a>0:
     e_[i_]:=subpath (0,t_.a) of e__1;
     e_[i__]:=subpath (1-t_.b,1) of e__2;
    fi
   fi
  fi
 endfor
 for i_:=0 upto l_-1:
  hide(i__:=(i_-1) mod l_)
  if cycle p or (i_>0):
   if length((point 1 of e_[i__])-(point 0 of e_[i_]))>1/4ignore_nib_limit:
   % the constant |1/4ignore_nib_limit| plays a similar role
   % to that of the |SNAP_TO_NODE| variable in pf2mt1.awk
    (point 1 of e_[i__])
    if known local_tip_(i_): -- else:
     && pen_join(predir 1 of e_[i__],postdir 0 of e_[i_],point i_ of p,
      local_nib_(i_)) &&
    fi
   fi
  fi
  % reconstruct |e_[i_]| (possibly ignoring direction(s)):
  (point 0 of e_[i_])
  if is_line(e_[i_]):
  % this circumvents \MF{}//\MP{} instable behaviour
  % (the operator |...| may cause that a control point and
  % a node coincide; note that this is feature, not a bug),
  % and thus is advisable:
   --
  else:
   if not ignore_dir_(i_): {direction 0 of e_[i_]} fi ...
   if not ignore_dir_(i_+1): {direction 1 of e_[i_]} fi
  fi
 endfor
 if cycle p: cycle else: (point 1 of e_[l_-1]) fi
enddef;

% figure out size of brush
(mbrush_width,mbrush_height)=urcorner (
   fullcircle xscaled (tsu_brush_max*100)
   yscaled (tsu_brush_max*tsu_brush_shape*100)
   rotated tsu_brush_angle
);
alternate_adjust:=abs(mbrush_height-mbrush_width);

serif_size:=2;
