%
% Blackletter Lolita overrides for Tsukurimashou
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

familyname:="BLL";

is_blackletter:=true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pair bl_stroke_dir[];
numeric bl_stroke_width[];

bl_stroke_dir[0]:=dir 0;
bl_stroke_dir[1]:=dir 45;
bl_stroke_dir[2]:=dir 90;
bl_stroke_dir[3]:=dir 135;
bl_stroke_dir[4]:=dir 180;
bl_stroke_dir[5]:=dir 225;
bl_stroke_dir[6]:=dir 270;
bl_stroke_dir[7]:=dir 315;
num_bl_strokes:=8;

bl_stroke_width[0]:=0.4;
bl_stroke_width[1]:=0.6;
bl_stroke_width[2]:=1.6;
bl_stroke_width[3]:=0.8;
bl_stroke_width[4]:=0.4;
bl_stroke_width[5]:=0.6;
bl_stroke_width[6]:=1.6;
bl_stroke_width[7]:=0.8;

for state:=0 upto num_bl_strokes-1:
  bl_stroke_dir[state]:=bl_stroke_dir[state]/abs(bl_stroke_dir[state]);
endfor;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef tsu_render_segment(expr i,p,q,b) =
  begingroup
    save lp,glyph,pcorner,pdir,k,ta,tz,dl,dr,dp,sl,sr,goodness,best,dtl,dtr,
      itl,itr;
    path lp,glyph;
    numeric pdir[],k,ta,tz,sl,sr,goodness,best,dtl,dtr,itl,itr;
    pair pcorner[],dl,dr,dp;
    
    % for debugging - dot the path to be approximated
    if false:
      for j:=0 step 0.25 until length p:
        glstk[ngls]:=fullcircle scaled 25 shifted point j of p;
        ngls:=ngls+1;
      endfor;
    fi;

    pcorner[0]:=point 0 of p;
    pdir[0]=-1;
    k:=0;
    ta:=0;
    forever:
      k:=k+1;

      if ta=floor(ta):
        dp:=(postcontrol ta of p)-(point ta of p);
      else:
        dp:=direction ta of p;
      fi;
      dp:=dp/abs(dp);

      tz:=floor(ta+1);
      forever:
        exitif tz=length p;
        dr:=(point tz of p)-(precontrol tz of p);
        exitif (dr dotprod dp)<=0;
        dl:=(postcontrol tz of p)-(point tz of p);
        dl:=dl/abs(dl);
        dr:=dr/abs(dr);
        exitif (dl dotprod dr)<0.95;
        tz:=tz+1;
      endfor;

      dr:=(point tz of p)-(point ta of p);
      dr:=dr/abs(dr);
      dp:=(dp+0.05*dr)/abs(dp+0.05*dr);

      dl:=bl_stroke_dir[0];
      dr:=bl_stroke_dir[num_bl_strokes-1];
      sl:=0;
      sr:=num_bl_strokes-1;
      best:=(dl dotprod dp)+(dr dotprod dp);
      
      for j:=0 upto num_bl_strokes-2:
        goodness:=(bl_stroke_dir[j] dotprod dp)
                 +(bl_stroke_dir[j+1] dotprod dp);
        if goodness>best:
          best:=goodness;
          dr:=bl_stroke_dir[j];
          dl:=bl_stroke_dir[j+1];
          sr:=j;
          sl:=j+1;
        fi;
      endfor;
% message "ta "&(decimal ta)&
%   " tz "&(decimal tz)&
%   " sl "&(decimal sl)&
%   " sr "&(decimal sr);
      
      if (((point tz of p)-(point ta of p)) dotprod dl>=
        abs((point tz of p)-(point ta of p))*0.999)
        and (tz-ta<3):
        pdir[k]:=sl;
      elseif (((point tz of p)-(point ta of p)) dotprod dr>=
        abs((point tz of p)-(point ta of p))*0.999)
        and (tz-ta<3):
        pdir[k]:=sr;
      else:
        itl:=xpart (p intersectiontimes
          (((dl*10)+point ta of p)--((dl*1000)+point ta of p)));
        itr:=xpart (p intersectiontimes
          (((dr*10)+point ta of p)--((dr*1000)+point ta of p)));
        if (itl<ta+0.01) or (itl>tz):
          itl:=-1;
        fi;
        if (itr<ta+0.01) or (itr>tz):
          itr:=-1;
        fi;
        dtl:=directiontime dl of p;
        dtr:=directiontime dr of p;
        if (dtl<ta+0.01) or (dtl>tz):
          dtl:=-1;
        fi;
        if (dtr<ta+0.01) or (dtr>tz):
          dtr:=-1;
        fi;
        if (itl>ta) and ((itl<=itr) or (itr<ta)):
          tz:=itl;
          pdir[k]:=sl;
        elseif itr>ta:
          tz:=itr;
          pdir[k]:=sr;
        elseif (dtl>ta) and ((dtl<dtr) or (dtr<ta)):
          tz:=dtl;
          pdir[k]:=sr;
          pcorner[k]:=(whatever*dr)+point ta of p;
          pcorner[k]=(whatever*dl)+point tz of p;
          if k>1:
            if pdir[k]=pdir[k-1]:
              pcorner[k-1]:=pcorner[k];
              k:=k-1;
            fi;
          fi;
          k:=k+1;
          pdir[k]:=sl;
        elseif dtr>ta:
          tz:=dtr;
          pdir[k]:=sl;
          pcorner[k]:=(whatever*dl)+point ta of p;
          pcorner[k]=(whatever*dr)+point tz of p;
          if k>1:
            if pdir[k]=pdir[k-1]:
              pcorner[k-1]:=pcorner[k];
              k:=k-1;
            fi;
          fi;
          k:=k+1;
          pdir[k]:=sr;
        elseif false and (pdir[k-1]=sr):
          pcorner[k-1]:=whatever*dr+point ta of p;
          pcorner[k-1]=whatever*dl+point tz of p;
          pdir[k]:=sl;
        elseif false and (pdir[k-1]=sl):
          pcorner[k-1]:=whatever*dl+point ta of p;
          pcorner[k-1]=whatever*dr+point tz of p;
          pdir[k]:=sr;
        elseif abs(ypart dl)>abs(ypart dr):
          pdir[k]:=sr;
          pcorner[k]:=whatever*dr+point ta of p;
          pcorner[k]=whatever*dl+point tz of p;
          k:=k+1;
          pdir[k]:=sl;
        else:
          pdir[k]:=sl;
          pcorner[k]:=whatever*dl+point ta of p;
          pcorner[k]=whatever*dr+point tz of p;
          k:=k+1;
          pdir[k]:=sr;
        fi;
      fi;
      pcorner[k]:=point tz of p;
      
      if k>1:
        if pdir[k]=pdir[k-1]:
          pcorner[k-1]:=pcorner[k];
          k:=k-1;
        fi;
      fi;
      
      exitif tz>=length p;
      ta:=tz;
    endfor;
    
    for j:=1 upto k:
      if (abs(pcorner[j-1]-pcorner[j])>10) and (pdir[j]>=0):
        lp:=subpath (0.01,0.99) of (pcorner[j-1]--pcorner[j]);
        default_nib:=fix_nib(obstackna.bosize[i]*tsu_brush_max[b]
            *bl_stroke_width[pdir[j]],
          obstackna.bosize[i]*tsu_brush_max[b]*tsu_brush_shape[b]
            *bl_stroke_width[pdir[j]],
          tsu_brush_angle[b]);
        pen_stroke()(lp)(glyph);
        glstk[ngls]:=regenerate(glyph);
        ngls:=ngls+1;
      fi;
    endfor;
  endgroup;
enddef;
