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

slang:=0;

pf_info_quad 1000;
pf_info_space 1000, 0, 0;
pf_info_familyname familyname;
pf_info_fontname
  (familyname & stylename & "Subfont"),
  (familyname & " " & stylename & " Subfont");
pf_info_fixedpitch true;
pf_info_capheight 900;
pf_info_xheight 585;
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
    if rescale_to.right>0:
      fix_hsbw((rescale_to.left+rescale_to.right),0,0);
    else:
      fix_hsbw(0,0,0);
    fi;
  endglyph;
  perl_structure:=perl_structure&"];";
  write "PERL_STRUCTURE "&perl_structure to "proof.prf";
  if rescale_to.right>0:
    write ("ENDGLYPH 0 "&decimal (rescale_to.left+rescale_to.right))
      to "proof.prf";
  else:
    write "ENDGLYPH -10 0" to "proof.prf";
  fi;
  sp:=0;
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

def tsu_rescale_full =
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

def tsu_rescale_half =
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

def tsu_rescale_half_lc =
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

def tsu_rescale_half_katakana =
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

def tsu_rescale_double =
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

def tsu_rescale_decenter =
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

def tsu_rescale_native_narrow =
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

def tsu_rescale_native_zero =
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

def tsu_rescale_native_conditional =
  if is_proportional:
    tsu_rescale_full;
  else:
    tsu_rescale_native_narrow;
  fi;
enddef;

def tsu_rescale_combining_full =
  rescale_from.left:=wide_margin;
  rescale_from.right:=1000-wide_margin;
  rescale_from.top:=ypart centre_pt;
  rescale_from.bottom:=latin_wide_baseline;

  rescale_to.left:=wide_margin-1000;
  rescale_to.right:=-wide_margin;
  rescale_to.top:=ypart centre_pt;
  rescale_to.bottom:=latin_wide_baseline;

  rescale_skew:=0;

  width_curve:=(-1,-1)--(2000,2000);
enddef;

def tsu_rescale_combining_half =
  rescale_from.left:=wide_margin;
  rescale_from.right:=1000-wide_margin;
  rescale_from.top:=ypart centre_pt;
  rescale_from.bottom:=latin_wide_baseline;

  rescale_to.left:=narrow_margin-500;
  rescale_to.right:=-narrow_margin;
  rescale_to.top:=latin_vcentre;
  rescale_to.bottom:=0;

  rescale_skew:=0;

  width_curve:=((-1,-1)--(100,100))..(940,410)..{right}(2000,1000);
enddef;

def tsu_rescale_combining_accent =
  if is_proportional:
    tsu_rescale_combining_full;
  else:
    tsu_rescale_combining_half;
  fi;
enddef;

tsu_rescale_full;

def tsu_slant_xform =
  begingroup
    save st,cp;
    transform st;
    pair cp;
    
    cp:=((rescale_from.left+rescale_from.right)/2,rescale_from.bottom);
    cp transformed st=cp;
    cp+(100,0) transformed st=cp+(100,0);
    cp+(0,100) transformed st=cp+(rescale_slant/10,100);
    st
  endgroup
enddef;

def tsu_rescale_xform =
  begingroup
    save t,st,cp;
    transform t,st;
    st:=tsu_slant_xform;
    t:=st;
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
      pair cp;
      transform st;
      cp:=((rescale_to.left+rescale_to.right)/2,rescale_to.bottom);
      cp transformed st=cp;
      cp+(100,0) transformed st=cp+(100,0);
      cp+(0,100) transformed st=cp+(rescale_slant/10,100);
      t:=t transformed st;
    endgroup; fi;
    t
  endgroup
enddef;

% solve the quadratic equation ax^2+bx+c=0, including pathological cases
vardef solve_quadratic(expr a,b,c) =
  if a=0:
    if b=0:
      if c=0:
        (0,whatever)
      else:
        (whatever,whatever)
      fi
    else:
      (-c/b,whatever)
    fi
  elseif abs(a)<abs(b)/500:
    (whatever,whatever)
  else:
    save d;
    numeric d;
    d=b*b-4*a*c;
    if d>0:
      ((-b-sqrt(d),-b+sqrt(d))/(2*a))
    elseif d=0:
      (-b/(2*a),whatever)
    else:
      (whatever,whatever)
    fi
  fi
enddef;

% find the t-values of any inflection points of subpath (0,1) of p
vardef segment_inflections(expr p) =
  save x,y,c;
  numeric x[],y[],c[];
  
  % normalize to prevent numerical misbehaviour
  z10=(point 0 of p)+z22;
  z11=(postcontrol 0 of p)+z22;
  z12=(precontrol 1 of p)+z22;
  z13=(point 1 of p)+z22;
  z10+z11+z12+z13=(0,0);
  c10=(abs(z10)+abs(z11)+abs(z12)+abs(z13))/4;
  if c10<0.1:
    c10:=0.1;
  fi;
  z0=z10/c10;
  z1=z11/c10;
  z2=z12/c10;
  z3=z13/c10;

  % abort if points are close enough to collinear
  if (abs(x0*y1-x1*y0)<0.01) and (abs(x2*y3-x3*y2)<0.01):
    (whatever,whatever)
  else:

    % find t-values at which |z'(t) cross z''(t)|=0
    c2=y0*(      -1*x1 +2*x2   -x3)
      +y1*(   x0       -3*x2 +2*x3)
      +y2*(-2*x0 +3*x1         -x3)
      +y3*(   x0 -2*x1   +x2      );

    c1=y0*(       2*x1 -3*x2   +x3)
      +y1*(-2*x0       +3*x2   -x3)
      +y2*( 3*x0 -3*x1            )
      +y3*(  -x0   +x1            );

    c0=y0*(        -x1   +x2)
      +y1*(   x0         -x2)
      +y2*(  -x0   +x1      );

    z20=solve_quadratic(c2,c1,c0);

    % filter and sort to find points properly within the segment
    if known x20:
      if (x20>0.01) and (x20<0.99):
        x21=x20;
      fi;
    fi;
    if known y20:
      if (y20>0.01) and (y20<0.99):
        y21=y20;
      fi;
    fi;
    if known x21:
      z21
    else:
      (y21,x21)
    fi
  fi
enddef;

% version of insert_nodes modified to *always* insert, which is needed
% to keep node numbers in sync on pen-size-control paths
vardef really_insert_nodes(expr p)(text t) =
 save j_, p_, s_, t_; path p_; p_:=p;
 t_:=0;
 for i_:=t:
   t_[incr t_]=arclength(subpath(0,i_ mod length(p_)) of p_);
 endfor
 for i_:=1 upto t_:
  s_:=arctime t_[i_] of p_;
  p_:=(subpath (0, s_) of p_) && (subpath (s_,length p_) of p_)
    if cycle p_: & cycle fi;
 endfor;
 p_
enddef;

% render a single segment - pulled out to make it easier to override
def tsu_render_segment(expr i,p,q) =
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
  boolean is_cycle;
  is_cycle=(abs((point infinity of p)-(point 0 of p))<1);
  pen_stroke(for ell=0 step 1 until length(p):
      if sharp_corners and known obstacknaa.botip[i][ltime[ell]]:
        tip(obstacknaa.botip[i][ltime[ell]])(ell)
      else:
        tsu_brush_opt(mytip[ell])(ell)
      fi
    endfor if is_cycle:
      if sharp_corners and known obstacknaa.botip[i][ltime[length(p)]]:
        tip(obstacknaa.botip[i][ltime[length(p)]])((length(p)+1))
      else:
        tsu_brush_opt(mytip[length(p)])((length(p)+1))
      fi
    fi)(p if is_cycle:
      --(point 0.001 of p)
    fi)(glyph);
  glstk[ngls]:=regenerate(glyph);
  ngls:=ngls+1;
  for l=0 step 1 until length(p):
    si:=floor (ltime[l]+0.5);
    if (abs(ltime[l]-si)<0.05) and known obstacknaa.boserif[i][si]:
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
             p:=subpath (s,t) of obstackp[i];
             q:=subpath (s,t) of bqi;
             numeric ltime[];
             ltime[0]:=s;
             for l=1 step 1 until (length p)-1:
               ltime[l]:=floor (s+l);
             endfor;
             ltime[length p]:=t;
             l:=0;
             forever:
               exitif l=length p;
               begingroup
                 save x,y;
                 numeric x[],y[];
                 z10=segment_inflections(subpath (l,l+1) of p);
                 if known x10:
                   p:=really_insert_nodes(p)(l+x10);
                   q:=really_insert_nodes(q)(l+x10);
                   for ll=length p step -1 until l+1:
                     ltime[ll]:=ltime[ll-1];
                   endfor;
                   ltime[l+1]:=x10[ltime[l],ltime[l+2]];
                 else:
                   z0=(point l of p)/100;
                   z1=(postcontrol l of p)/100;
                   z2=(precontrol (l+1) of p)/100;
                   z3=(point (l+1) of p)/100;
                   if if abs(z2-z1)>0.1: ((z1-z0) dotprod (z3-z2))
                                      /((z2-z1) dotprod (z2-z1))
                      else: 1 fi<0.5:
                     p:=really_insert_nodes(p)(l+0.5);
                     q:=really_insert_nodes(q)(l+0.5);
                     for ll=length p step -1 until l+1:
                       ltime[ll]:=ltime[ll-1];
                     endfor;
                     ltime[l+1]:=0.5[ltime[l],ltime[l+2]];
                   else:
                     l:=l+1;
                   fi;
                 fi;
               endgroup;
             endfor;
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

def tsu_xform(expr xform)(text curves) =
  begingroup
    save txfsp,zc,zs;
    txfsp:=sp;
    curves;
    numeric zs;
    zs:=abs(((0,0) transformed xform)
            -((1,0) transformed xform))
       *abs(((0,0) transformed xform)
           -((0,1) transformed xform));
    size_scale:=zs**0.16667;
    for i=txfsp upto sp-1:
      if known obstackp[i]:
        if known obstackba.bokeepshape[i]:
          if obstackba.bokeepshape[i]:
            pair zc;
            zc:=0.5[llcorner obstackp[i],urcorner obstackp[i]];
            obstackp[i]:=obstackp[i] shifted (-zc) scaled (yypart xform)
              shifted (zc transformed xform);
          else:
            obstackp[i]:=obstackp[i] transformed xform;
          fi;
        else:
          obstackp[i]:=obstackp[i] transformed xform;
        fi;
      fi;
      if known obstackna.bosize[i]:
        obstackna.bosize[i]:=obstackna.bosize[i]*size_scale;
      fi;
      if known obstackt[i]:
        if (xxpart obstackt[i]=1) and (yypart obstackt[i]=1)
          and (xypart obstackt[i]=0) and (yxpart obstackt[i]=0):
          obstackt[i]:=obstackt[i]
            shifted (((0,0) transformed obstackt[i] transformed xform)-
                     ((0,0) transformed obstackt[i]));
        else:
          obstackt[i]:=obstackt[i] transformed xform;
        fi;
      fi;
    endfor;
  endgroup;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

def anc_upper = 1 enddef;
def anc_grave = 2 enddef;
def anc_acute = 3 enddef;
def anc_wide = 4 enddef;
def anc_tilde = 5 enddef;
def anc_ring = 6 enddef;
def anc_caron_comma = 7 enddef;
def anc_dakuten = 8 enddef;
def anc_lower = 9 enddef;
def anc_lower_connect = 10 enddef;
def anc_centre = 11 enddef;
def anc_iching_line(expr lnum) = (11+lnum) enddef;

transform accent_default[];
boolean accent_has_default[];
max_accent_seen:=0;

def tsu_default_anchor(expr aindex,avalue) =
  if numeric avalue:
    write ("DEFAULTANCHOR "&(decimal aindex)&" FALSE") to "proof.prf";
    accent_has_default[aindex]:=false;
  elseif transform avalue:
    write ("DEFAULTANCHOR "&
           (decimal aindex)&" "&
           (decimal xpart ((0,0) transformed avalue
                           transformed tsu_rescale_xform))&" "&
           (decimal ypart ((0,0) transformed avalue
                           transformed tsu_rescale_xform)))
            to "proof.prf";
    accent_has_default[aindex]:=true;
  elseif pair avalue:
    write ("DEFAULTANCHOR "&
           (decimal aindex)&" "&
           (decimal xpart (avalue transformed tsu_rescale_xform))&" "&
           (decimal ypart (avalue transformed tsu_rescale_xform))
            to "proof.prf";
    accent_has_default[aindex]:=true;
  fi;
  if aindex>max_accent_seen:
    max_accent_seen:=aindex;
  fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure out size of brush
vardef calc_mbrush_size =
  numeric mbrush_width,mbrush_height,alternate_adjust;
  (mbrush_width,mbrush_height)=urcorner (
     fullcircle xscaled (tsu_brush_max*100)
     yscaled (tsu_brush_max*tsu_brush_shape*100)
     rotated tsu_brush_angle
  );
  alternate_adjust:=abs(mbrush_height-mbrush_width);
  if tsu_brush_max>0.75:
    serif_size:=2;
  else:
    serif_size:=2*((tsu_brush_max/0.75)**(1/3));
  fi;
  mincho_blob_size:=sqrt(tsu_brush_max/0.75);
enddef;

calc_mbrush_size;
