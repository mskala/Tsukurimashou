/*
 * Kern calculator for Tsukurimashou
 * Copyright (C) 2011, 2014  Matthew Skala
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * As a special exception, if you create a document which uses this font, and
 * embed this font or unaltered portions of this font into the document, this
 * font does not by itself cause the resulting document to be covered by the
 * GNU General Public License. This exception does not however invalidate any
 * other reasons why the document might be covered by the GNU General Public
 * License. If you modify this font, you may extend this exception to your
 * version of the font, but you are not obligated to do so. If you do not
 * wish to do so, delete this exception statement from your version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Matthew Skala
 * http://ansuz.sooke.bc.ca/
 * mskala@ansuz.sooke.bc.ca
 */

/* Usage:
 *    kerner <bdf file> <config file> <pe file> <fea file>
 */

#include <config.h>

#include <ctype.h>
#include <limits.h>
#include <math.h>
#ifdef HAVE_OBSTACK
# include <obstack.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/***********************************************************************/

#ifndef HAVE_OBSTACK

/* minimal obstack implementation for systems that don't have it */
/* covers JUST ENOUGH of the API for our purposes */

struct obstack_obj {
   struct obstack_obj *next;
   char *start;
   int size;
};

struct obstack {
   struct obstack_obj *top;
   int open;
};

void *obstack_alloc(struct obstack *o,int size) {
   struct obstack_obj *tmp;

   tmp=(struct obstack_obj *)malloc(sizeof(struct obstack_obj));
   tmp->next=o->top;
   tmp->start=(char *)malloc(size>0?size:1);
   tmp->size=size;
   o->top=tmp;
   o->open=0;
   return tmp->start;
}

void obstack_1grow(struct obstack *o,char c) {
   if (!o->open)
     obstack_alloc(o,0);
   o->open=1;
   o->top->size++;
   o->top->start=(char *)realloc((void *)o->top->start,o->top->size);
   o->top->start[o->top->size-1]=c;
}

void *obstack_copy(struct obstack *o,void *from,int size) {
   char *to;
   int i;
   
   to=(char *)obstack_alloc(o,size);
   for (i=0;i<size;i++)
     to[i]=((char *)from)[i];
   o->open=0;
   return (void *)to;
}

void *obstack_finish(struct obstack *o) {
   o->open=0;
   return (void *)(o->top->start);
}

void obstack_free(struct obstack *o,void *obj) {
   struct obstack_obj *tmp;

   while (o->top!=NULL) {
      tmp=o->top;
      o->top=tmp->next;
      free(tmp->start);
      if (tmp->start==(char *)obj) {
	 free(tmp);
	 break;
      }
      free(tmp);
   }
   o->open=0;
}

int obstack_init(struct obstack *o) {
   o->top=NULL;
   o->open=1;
   obstack_alloc(o,0);
   return 1;
}

#endif

/***********************************************************************/

typedef struct _GLYPH {
   struct _GLYPH *prev;
   char *name;
   int encoding_adobe,encoding_other;
   int swidth_x,swidth_y,dwidth_x,dwidth_y;
   int *left_bounds,*right_bounds;
   int left_margin,right_margin;
   int left_class,right_class;
} GLYPH;

typedef struct _CLASS {
   int class_size;
   int *bounds;
   int bearing;
} CLASS;

/***********************************************************************/

#define obstack_chunk_alloc malloc
#define obstack_chunk_free free

struct obstack obs;

/***********************************************************************/

char *font_name="UNKNOWN FONT";
int fbb_w,fbb_h,fbb_xo,fbb_yo;
int swidth_x,swidth_y,dwidth_x,dwidth_y;
int eoln;

int num_glyphs=0,glyphs_read=0;
GLYPH *glyph_list=NULL,**glyphs;
CLASS *left_classes,*right_classes;
int *kerns;

int xmult=10,hullslope=10,hullslope_beyond=3,
  num_left_classes=200,num_right_classes=200,
  kern_round=20,subtable_max=5000,
  min_class_limit=100,class_limit_mult=3,
  left_class_limit=100,right_class_limit=100;
double kern_exponent=3.0,kern_optimal=230.0;

/***********************************************************************/

char *read_word(FILE *f) {
   int c;
   
   while ((c=fgetc(f))>=0) {
      if (isspace(c) || (c=='\n'))
	break;
      obstack_1grow(&obs,c);
   }
   if (c<0)
     exit(1);
   eoln=(c=='\n');
   obstack_1grow(&obs,0);
   return (char *)obstack_finish(&obs);
}

char *read_string(FILE *f) {
   int c;
   
   while ((c=fgetc(f))>=0) {
      if (c=='\n')
	break;
      obstack_1grow(&obs,c);
   }
   if (c<0)
     exit(2);
   obstack_1grow(&obs,0);
   return (char *)obstack_finish(&obs);
}

int read_int(FILE *f) {
   char *s;
   int rval;
   
   s=read_word(f);
   rval=atoi(s);
   obstack_free(&obs,s);
   return rval;
}

void skip_line(FILE *f) {
   int c;
   
   while ((c=fgetc(f))>=0) {
      if (c=='\n')
	break;
   }
   if (c<0)
     exit(3);
}

/***********************************************************************/

void read_bdf(char *fname) {
   FILE *bdf_file;
   char *kw;
   int n,i,j;
   int reading_glyphs=0;
   GLYPH cg;
   int bbx_w,bbx_h,bbx_xo,bbx_yo;
   int c,b,x,y;
   
   fprintf(stderr,"Reading %s...\n",fname);
   
   bdf_file=fopen(fname,"rb");
   if (bdf_file==NULL)
     exit(4);
   
   while (1) {
      kw=read_word(bdf_file);

      if (strcmp(kw,"FONT")==0) {
	 obstack_free(&obs,kw);
	 font_name=read_string(bdf_file);

      } else if (strcmp(kw,"FONTBOUNDINGBOX")==0) {
	 obstack_free(&obs,kw);
	 fbb_w=read_int(bdf_file);
	 fbb_h=read_int(bdf_file);
	 fbb_xo=read_int(bdf_file);
	 fbb_yo=read_int(bdf_file);

      } else if (strcmp(kw,"SWIDTH")==0) {
	 obstack_free(&obs,kw);
	 if (reading_glyphs) {
	    cg.swidth_x=read_int(bdf_file);
	    cg.swidth_y=read_int(bdf_file);
	 } else {
	    swidth_x=read_int(bdf_file);
	    swidth_y=read_int(bdf_file);
	 }

      } else if (strcmp(kw,"DWIDTH")==0) {
	 obstack_free(&obs,kw);
	 if (reading_glyphs) {
	    cg.dwidth_x=read_int(bdf_file);
	    cg.dwidth_y=read_int(bdf_file);
	 } else {
	    dwidth_x=read_int(bdf_file);
	    dwidth_y=read_int(bdf_file);
	 }

      } else if (strcmp(kw,"STARTPROPERTIES")==0) {
	 obstack_free(&obs,kw);
	 n=read_int(bdf_file);
	 for (i=0;i<n;i++)
	   skip_line(bdf_file);
	 kw=read_word(bdf_file);
	 if (strcmp(kw,"ENDPROPERTIES")!=0)
	   exit(5);

      } else if (strcmp(kw,"ENDFONT")==0) {
	 break;
	 
      } else if (strcmp(kw,"CHARS")==0) {
	 obstack_free(&obs,kw);
	 skip_line(bdf_file);
	 reading_glyphs=1;

      } else if (strcmp(kw,"STARTCHAR")==0) {
	 obstack_free(&obs,kw);
	 cg.name=read_string(bdf_file);
	 cg.swidth_x=swidth_x;
	 cg.swidth_y=swidth_y;
	 cg.dwidth_x=dwidth_x;
	 cg.dwidth_y=dwidth_y;
	 cg.left_bounds=obstack_alloc(&obs,fbb_h*sizeof(int));
	 cg.right_bounds=obstack_alloc(&obs,fbb_h*sizeof(int));
	 for (i=0;i<fbb_h;i++) {
	    cg.left_bounds[i]=100000;
	    cg.right_bounds[i]=-100000;
	 }
	 cg.left_margin=INT_MAX;
	 cg.right_margin=INT_MIN;
	 reading_glyphs=1;

      } else if (strcmp(kw,"ENCODING")==0) {
	 obstack_free(&obs,kw);
	 cg.encoding_adobe=read_int(bdf_file);
	 if (cg.encoding_adobe<0)
	   cg.encoding_other=read_int(bdf_file);
	 else
	   cg.encoding_other=-1;

      } else if (strcmp(kw,"ENDCHAR")==0) {
	 obstack_free(&obs,kw);
	 glyphs_read++;
	 if ((cg.left_margin<=cg.right_margin)
	     && (cg.encoding_adobe>=0)) {
	    num_glyphs++;
	    cg.prev=glyph_list;
	    glyph_list=(GLYPH *)obstack_copy(&obs,&cg,sizeof(GLYPH));
	 } else
	   obstack_free(&obs,cg.name); /* implicitly frees bounds too */

      } else if (strcmp(kw,"BBX")==0) {
	 obstack_free(&obs,kw);
	 bbx_w=read_int(bdf_file);
	 bbx_h=read_int(bdf_file);
	 bbx_xo=read_int(bdf_file);
	 bbx_yo=read_int(bdf_file);
	 
      } else if (strcmp(kw,"BITMAP")==0) {
	 for (i=0;i<bbx_h;i++) {
	    y=fbb_h+fbb_yo-(bbx_h+bbx_yo)+i;
	    for (j=0;j<((bbx_w+7)&~7);j+=4) {
	       c=fgetc(bdf_file);
	       if (!isxdigit(c))
		 exit(7);
	       if (isdigit(c))
		 c-='0';
	       else if (islower(c))
		 c-=('a'-10);
	       else
		 c-=('A'-10);
	       for (b=0;b<4;b++)
		 if (c&(8>>b)) {
		    x=(j+b+bbx_xo)*xmult;
		    if (x<cg.left_bounds[y])
		      cg.left_bounds[y]=x;
		    if (x<cg.left_margin)
		      cg.left_margin=x;
		    if (x>cg.right_bounds[y])
		      cg.right_bounds[y]=x;
		    if (x>cg.right_margin)
		      cg.right_margin=x;
		 }
	    }
	    c=fgetc(bdf_file);
	    if (c!='\n')
	      exit(8);
	 }

      } else {
	 /* ignore any lines we don't understand */
	 if (!eoln) skip_line(bdf_file);
	 obstack_free(&obs,kw);
      }
   }
   
   fclose(bdf_file);
   fprintf(stderr,"  read %d glyphs, kept %d.\n",glyphs_read,num_glyphs);
}

/***********************************************************************/

void prepare_glyphs(void) {
   int i,j,left_sum,right_sum,denom,limit;
   
   /* make an array of glyph pointers */
   glyphs=(GLYPH **)obstack_alloc(&obs,num_glyphs*sizeof(GLYPH *));
   for (i=num_glyphs-1;i>=0;i--) {
      glyphs[i]=glyph_list;
      glyph_list=glyph_list->prev;
   }
   
   /* loop through glyphs */
   
   for (i=0;i<num_glyphs;i++) {
      
      /* push the slope forward */
      for (j=1;j<fbb_h;j++) {
	 limit=glyphs[i]->left_bounds[j-1]+
	   (glyphs[i]->left_bounds[j-1]>glyphs[i]->right_margin?
	       hullslope_beyond:hullslope);
	 if (glyphs[i]->left_bounds[j]>limit)
	   glyphs[i]->left_bounds[j]=limit;
	 limit=glyphs[i]->right_bounds[j-1]-
	   (glyphs[i]->right_bounds[j-1]<glyphs[i]->left_margin?
	       hullslope_beyond:hullslope);
	 if (glyphs[i]->right_bounds[j]<limit)
	   glyphs[i]->right_bounds[j]=limit;
      }
	 
      /* push the slope backward */
      for (j=fbb_h-2;j>=0;j--) {
	 limit=glyphs[i]->left_bounds[j+1]+
	   (glyphs[i]->left_bounds[j+1]>glyphs[i]->right_margin?
	       hullslope_beyond:hullslope);
	 if (glyphs[i]->left_bounds[j]>limit)
	   glyphs[i]->left_bounds[j]=limit;
	 limit=glyphs[i]->right_bounds[j+1]-
	   (glyphs[i]->right_bounds[j+1]<glyphs[i]->left_margin?
	       hullslope_beyond:hullslope);
	 if (glyphs[i]->right_bounds[j]<limit)
	   glyphs[i]->right_bounds[j]=limit;
      }
   }
}

/***********************************************************************/

void k_means(void) {
   int i,j,k;
   int pass=0,changed,nearest,dist,tdist,tmp;
   int hval;
   char *cp;
   
   /* figure out class limits */
   left_class_limit=(class_limit_mult*num_glyphs)/num_left_classes;
   if (left_class_limit<min_class_limit)
     left_class_limit=min_class_limit;
   right_class_limit=(class_limit_mult*num_glyphs)/num_right_classes;
   if (right_class_limit<min_class_limit)
     right_class_limit=min_class_limit;
   
   /* allocate and initialize classes */
   left_classes=(CLASS *)obstack_alloc(&obs,
				       num_left_classes*sizeof(CLASS));
   right_classes=(CLASS *)obstack_alloc(&obs,
					num_right_classes*sizeof(CLASS));
   for (i=0;i<num_left_classes;i++) {
      left_classes[i].class_size=0;
      left_classes[i].bounds=(int *)obstack_alloc(&obs,fbb_h*sizeof(int));
      for (j=0;j<fbb_h;j++)
	left_classes[i].bounds[j]=0;
   }
   for (i=0;i<num_right_classes;i++) {
      right_classes[i].class_size=0;
      right_classes[i].bounds=(int *)obstack_alloc(&obs,fbb_h*sizeof(int));
      for (j=0;j<fbb_h;j++)
	right_classes[i].bounds[j]=0;
   }
   
   /* put all glyphs in classes */
   for (i=0;i<num_glyphs;i++) {
      hval=0;
      for (cp=glyphs[i]->name;*cp;cp++)
	hval=((hval<<1)^(hval>>1)^hval^*cp)&0x3FFFFFFF;

      if (i<num_left_classes)
	glyphs[i]->left_class=i;
      else
	glyphs[i]->left_class=hval%num_left_classes;
      left_classes[glyphs[i]->left_class].class_size++;
      for (j=0;j<fbb_h;j++)
	left_classes[glyphs[i]->left_class].bounds[j]+=
	(glyphs[i]->right_bounds[j]-glyphs[i]->right_margin);

      hval=((hval<<1)^(hval>>1)^hval)&0x3FFFFFFF;

      if (i<num_right_classes)
	glyphs[i]->right_class=i;
      else
	glyphs[i]->right_class=hval%num_right_classes;
      right_classes[glyphs[i]->right_class].class_size++;
      for (j=0;j<fbb_h;j++)
	right_classes[glyphs[i]->right_class].bounds[j]+=
	(glyphs[i]->left_bounds[j]-glyphs[i]->left_margin);
   }
   
   /* attempt classification */
   changed=1;
   while (changed>0) {
      changed=0;
      
      for (i=0;i<num_glyphs;i++) {
	 nearest=-1;
	 dist=INT_MAX;
	 for (j=0;j<num_left_classes;j++) {
	    tdist=0;
	    for (k=0;k<fbb_h;k++) {
	       tmp=glyphs[i]->right_bounds[k]-glyphs[i]->right_margin
		 -(left_classes[j].bounds[k]/left_classes[j].class_size);
	       tdist+=(tmp*tmp);
	    }
	    if ((tdist<dist) &&
		((left_classes[j].class_size<left_class_limit) ||
		    (j==glyphs[i]->left_class))) {
	       nearest=j;
	       dist=tdist;
	    }
	 }
	 if ((left_classes[glyphs[i]->left_class].class_size>1)
	     && (nearest!=glyphs[i]->left_class)) {
	    for (j=0;j<fbb_h;j++) {
	       left_classes[glyphs[i]->left_class].bounds[j]-=
		 (glyphs[i]->right_bounds[j]-glyphs[i]->right_margin);
	       left_classes[nearest].bounds[j]+=
		 (glyphs[i]->right_bounds[j]-glyphs[i]->right_margin);
	    }
	    left_classes[glyphs[i]->left_class].class_size--;
	    left_classes[nearest].class_size++;
	    glyphs[i]->left_class=nearest;
	    changed++;
	 }

	 nearest=-1;
	 dist=INT_MAX;
	 for (j=0;j<num_right_classes;j++) {
	    tdist=0;
	    for (k=0;k<fbb_h;k++) {
	       tmp=glyphs[i]->left_bounds[k]-glyphs[i]->left_margin
		 -(right_classes[j].bounds[k]/right_classes[j].class_size);
	       tdist+=(tmp*tmp);
	    }
	    if ((tdist<dist) &&
		((right_classes[j].class_size<right_class_limit) ||
		    (j==glyphs[i]->right_class))) {
	       nearest=j;
	       dist=tdist;
	    }
	 }
	 if ((right_classes[glyphs[i]->right_class].class_size>1)
	     && (nearest!=glyphs[i]->right_class)) {
	    for (j=0;j<fbb_h;j++) {
	       right_classes[glyphs[i]->right_class].bounds[j]-=
		 (glyphs[i]->left_bounds[j]-glyphs[i]->left_margin);
	       right_classes[nearest].bounds[j]+=
		 (glyphs[i]->left_bounds[j]-glyphs[i]->left_margin);
	    }
	    right_classes[glyphs[i]->right_class].class_size--;
	    right_classes[nearest].class_size++;
	    glyphs[i]->right_class=nearest;
	    changed++;
	 }
      }
      
      printf("k-means pass %d, changed %d\n",pass++,changed);
   }
}

/***********************************************************************/

void do_kerning(void) {
   int i,j,k,sum;
   double bottom,middle,top,dist,diff;
   
   kerns=(int *)obstack_alloc(&obs,num_left_classes*num_right_classes*
			      sizeof(int));
   
   for (i=0;i<num_left_classes;i++)
     for (j=0;j<fbb_h;j++)
       left_classes[i].bounds[j]/=left_classes[i].class_size;
   for (i=0;i<num_right_classes;i++)
     for (j=0;j<fbb_h;j++)
       right_classes[i].bounds[j]/=right_classes[i].class_size;
   
   sum=0;
   for (i=0;i<num_left_classes;i++)
     for (j=0;j<num_right_classes;j++) {
	bottom=-1e6;
	top=1e6;
	while ((top-bottom)>0.3) {
	   middle=(bottom+top)/2.0;
	   dist=0.0;
	   for (k=0;k<fbb_h;k++) {
	      diff=middle+(double)(right_classes[j].bounds[k]-
				   left_classes[i].bounds[k]);
	      if (diff<1.0)
		dist=1e6;
	      else
		dist+=pow(kern_optimal/diff,kern_exponent);
	   }
	   if (dist<(double)fbb_h)
	     top=middle;
	   else
	     bottom=middle;
	}
	kerns[i*num_right_classes+j]=(int)bottom;
	sum+=(int)bottom;
     }
   
   sum/=(num_left_classes*num_right_classes);
   for (i=0;i<num_left_classes;i++)
     left_classes[i].bearing=(sum+1)/2;
   for (i=0;i<num_right_classes;i++)
     right_classes[i].bearing=sum/2;
   for (i=0;i<num_left_classes*num_right_classes;i++)
     kerns[i]-=sum;

   for (i=0;i<num_left_classes;i++) {
      sum=-1000;
      for (j=0;j<num_right_classes;j++)
	if (kerns[i*num_right_classes+j]>sum)
	  sum=kerns[i*num_right_classes+j];
      sum*=2;
      sum/=3;
      left_classes[i].bearing+=sum;
      for (j=0;j<num_right_classes;j++)
	kerns[i*num_right_classes+j]-=sum;
   }

   for (i=0;i<num_right_classes;i++) {
      sum=-1000;
      for (j=0;j<num_left_classes;j++)
	if (kerns[j*num_right_classes+i]>sum)
	sum=kerns[j*num_right_classes+i];
      right_classes[i].bearing+=sum;
      for (j=0;j<num_left_classes;j++)
	kerns[j*num_right_classes+i]-=sum;
   }
   
   for (i=0;i<num_left_classes*num_right_classes;i++)
     if (abs(kerns[i])<kern_round/2)
       kerns[i]=0;
}

/***********************************************************************/

void write_pe(char *fname,char *feaname) {
   int i;
   FILE *pe;
   char *final_feaname,*ctmp;
   
   pe=fopen(fname,"w");
   if (pe==NULL)
     exit(9);
   
   fprintf(pe,
	   "#!/usr/local/bin/fontanvil\n\n"
	   "# GENERATED FILE - DO NOT EDIT\n"
	   "# Edit the kerner program that generates this, "
	   "or its input, instead.\n\n"
	   "# bearings for %s\n\n",
	   font_name);
   
   for (i=0;i<num_glyphs;i++)
     if (glyphs[i]->encoding_adobe>=0)
       fprintf(pe,
	       "Select(0u%04X);SetLBearing(%d);SetRBearing(%d);\n",
	       glyphs[i]->encoding_adobe,
	       right_classes[glyphs[i]->right_class].bearing,
	       left_classes[glyphs[i]->left_class].bearing);
   
   final_feaname=strdup(feaname);
   ctmp=strstr(final_feaname,"-ktmp");
   ctmp[2]='e';
   ctmp[3]='r';
   ctmp[4]='n';
   fprintf(pe,"MergeFeature(\"%s\");\n",final_feaname);
   free(final_feaname);
   
   fclose(pe);
}

/***********************************************************************/

void write_fea(char *fname) {
   int i,j,x,flag,subtable_count=0;
   FILE *fea;
   
   fea=fopen(fname,"w");
   if (fea==NULL)
     exit(10);
   
   fprintf(fea,
	   "#\n# GENERATED FILE - DO NOT EDIT\n"
	   "# Edit the kerner program that generates this, "
	   "or its input, instead.\n\n"
	   "# class kerns for %s\n\n",
	   font_name);
   
   for (i=0;i<num_left_classes;i++) {
      fprintf(fea,"@lkclass%d=[",i);
      x=11;
      flag=0;
      for (j=0;j<num_glyphs;j++)
	if (glyphs[j]->left_class==i) {
	   x+=(strlen(glyphs[j]->name)+1);
	   if (x>72) {
	      fputs("\n ",fea);
	      x=strlen(glyphs[j]->name)+2;
	   }
	   if (flag)
	     fprintf(fea," %s",glyphs[j]->name);
	   else
	     fputs(glyphs[j]->name,fea);
	   flag=1;
	}
      fputs("];\n",fea);
   }
   fputc('\n',fea);
   
   for (i=0;i<num_right_classes;i++) {
      fprintf(fea,"@rkclass%d=[",i);
      x=11;
      flag=0;
      for (j=0;j<num_glyphs;j++)
	if (glyphs[j]->right_class==i) {
	   x+=(strlen(glyphs[j]->name)+1);
	   if (x>72) {
	      fputs("\n ",fea);
	      x=strlen(glyphs[j]->name)+2;
	   }
	   if (flag)
	     fprintf(fea," %s",glyphs[j]->name);
	   else
	     fputs(glyphs[j]->name,fea);
	   flag=1;
	}
      fputs("];\n",fea);
   }
   fputc('\n',fea);
   
   fputs("feature kern {\n",fea);
   for (i=0;i<num_left_classes;i++) {
      for (j=0;j<num_right_classes;j++)
	if (kerns[i*num_right_classes+j]!=0) {
	   fprintf(fea,"  pos @lkclass%d @rkclass%d %d;\n",
		   i,j,kerns[i*num_right_classes+j]);
	   subtable_count++;
	}
      if (subtable_count>=subtable_max) {
	 fputs("\n  subtable;\n\n",fea);
	 subtable_count=0;
      }
   }
   fputs("} kern;\n",fea);

   fclose(fea);
}

/***********************************************************************/

int main(int argc,char **argv) {
   if (argc!=5) {
      fputs("Usage:\n"
	    "kerner <bdf file> <config file> <pe file> <fea file>\n",
	    stderr);
      exit(6);
   }
   
   obstack_init(&obs);

   read_bdf(argv[1]);

   /* read config file */
   
   prepare_glyphs();
   k_means();
   do_kerning();
   write_pe(argv[3],argv[4]);
   write_fea(argv[4]);

   return 0;
}
