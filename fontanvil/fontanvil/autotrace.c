/* $Id: autotrace.c 4674 2016-02-24 10:01:02Z mskala $ */
/* Copyright (C) 2000-2012  George Williams
 * Copyright (C) 2015  Matthew Skala
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * The name of the author may not be used to endorse or promote products
 * derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#include "fontanvilvw.h"
#include <math.h>
#include <ustring.h>
#include <utype.h>
#include "sd.h"
#include "gfile.h"

#include "potrace.h"

#include <sys/types.h>		/* for waitpid */
#   include <sys/wait.h>	/* for waitpid */
#include <unistd.h>		/* for access, unlink, fork, execvp, getcwd */
#include <sys/stat.h>		/* for open */
#include <fcntl.h>		/* for open */
#include <stdlib.h>		/* for getenv */
#include <errno.h>		/* for errors */
#include <dirent.h>		/* for opendir,etc. */

static SplinePointList *localSplinesFromEntities(Entity *ent,Color bgcol) {
   Entity *enext;
   SplinePointList *head =
      NULL, *last, *test, *next, *prev, *new, *nlast, *temp;
   int clockwise;
   SplineChar sc;
   StrokeInfo si;
   DBounds bb, sbb;
   int removed;
   double fudge;
   Layer layers[2];

   /* potrace does not close its paths (well, it closes the last one) */
   /*  and as with standard postscript fonts I need to reverse the splines */
   int bgr=COLOR_RED(bgcol), bgg=COLOR_GREEN(bgcol), bgb =
      COLOR_BLUE(bgcol);

   memset(&sc, '\0', sizeof(sc));
   memset(layers, 0, sizeof(layers));
   sc.layers=layers;
   for (; ent != NULL; ent=enext) {
      enext=ent->next;
      if (ent->type==et_splines) {
	 if (/* ent->u.splines.fill.col==0xffffffff && */ ent->u.splines.
	     stroke.col != 0xffffffff) {
	    memset(&si, '\0', sizeof(si));
	    si.join=ent->u.splines.join;
	    si.cap=ent->u.splines.cap;
	    si.radius=ent->u.splines.stroke_width/2;
	    new=NULL;
	    for (test=ent->u.splines.splines; test != NULL;
		 test=test->next) {
	       temp=SplineSetStroke(test, &si, false);
	       if (new==NULL)
		  new=temp;
	       else
		  nlast->next=temp;
	       for (nlast=temp; nlast->next != NULL; nlast=nlast->next);
	    }
	    SplinePointListsFree(ent->u.splines.splines);
	    ent->u.splines.fill.col=ent->u.splines.stroke.col;
	 } else {
	    new=ent->u.splines.splines;
	 }
	 if (head==NULL)
	    head=new;
	 else
	    last->next=new;
	 for (test=new; test != NULL; test=test->next) {
	    if (test->first != test->last &&
		RealNear(test->first->me.x, test->last->me.x) &&
		RealNear(test->first->me.y, test->last->me.y)) {
	       test->first->prevcp=test->last->prevcp;
	       test->first->noprevcp=test->last->noprevcp;
	       test->first->prevcpdef=test->last->prevcpdef;
	       test->first->prev=test->last->prev;
	       test->last->prev->to=test->first;
	       SplinePointFree(test->last);
	       test->last=test->first;
	    }
	    SplineSetReverse(test);
	    last=test;
	 }
      }
      SplinePointListsFree(ent->clippath);
      free(ent);
   }

   return (head);
}

static char *mytempdir(void) {
   char buffer[1025];
   char *dir, *eon;
   static int cnt=0;
   int tries=0;

   if ((dir=getenv("TMPDIR")) != NULL)
      strncpy(buffer, dir, sizeof(buffer)-1-5);
#   ifndef P_tmpdir
#      define P_tmpdir	"/tmp"
#   endif
   else
      strcpy(buffer, P_tmpdir);
   strcat(buffer, "/PfaEd");
   eon=buffer+strlen(buffer);
   while (1) {
      sprintf(eon, "%04X_mf%d", getpid(), ++cnt);
      if (mkdir(buffer, 0770)==0)
	 return (fastrdup(buffer));
      else if (errno != EEXIST)
	 return (NULL);
      if (++tries>100)
	 return (NULL);
   }
}

void _SCAutoTrace(SplineChar * sc, int layer, char **args) {
   ImageList *images;
   char *pt;
   SplineSet *new, *last;
   struct _GImage *ib;
   Color bgcol;
   double transform[6];
   int changed=false;
   int ac, i;
   AFILE *ps,*fd;
   int pid, status;

   if (sc->layers[ly_back].images==NULL)
     return;
   for (images=sc->layers[ly_back].images; images != NULL;
	images=images->next) {
      ib =
	images->image->list_len ==
	0?images->image->u.image:images->image->u.images[0];
      if (ib->width==0 || ib->height==0) {
	 /* pk fonts can have 0 sized bitmaps for space characters */
	 /*  but autotrace gets all snooty about being given an empty image */
	 /*  so if we find one, then just ignore it. It won't produce any */
	 /*  results anyway */
	 continue;
      }

      fd=atmpfile();
      GImageWrite_Bmp(images->image,fd);
      afseek(fd,0,SEEK_SET);

      if (ib->trans==-1)
	 bgcol=0xffffff;	/* reasonable guess */
      else if (ib->image_type==it_true)
	 bgcol=ib->trans;
      else if (ib->clut != NULL)
	 bgcol=ib->clut->clut[ib->trans];
      else
	 bgcol=0xffffff;

      /* We can't use AutoTrace's own "background-color" ignorer because */
      /*  it ignores counters as well as surrounds. So "O" would be a dark */
      /*  oval, etc. */

      ps=atmpfile();
      potrace(fd,ps);
      afclose(fd);
      
      afseek(ps,0,SEEK_SET);
      new=localSplinesFromEntities(EntityInterpretPS(ps,NULL),bgcol);
      afclose(ps);
      
      transform[0]=images->xscale;
      transform[3]=images->yscale;
      transform[1]=transform[2]=0;
      transform[4]=images->xoff;
      transform[5]=images->yoff-images->yscale * ib->height;
      new=SplinePointListTransform(new, transform, tpt_AllPoints);
      if (sc->layers[layer].order2) {
	 SplineSet *o2=SplineSetsTTFApprox(new);
	 
	 SplinePointListsFree(new);
	 new=o2;
      }
      if (new != NULL) {
	 sc->parent->onlybitmaps=false;
	 if (!changed)
	   SCPreserveLayer(sc, layer, false);
	 for (last=new; last->next != NULL; last=last->next);
	 last->next=sc->layers[layer].splines;
	 sc->layers[layer].splines=new;
	 changed=true;
      }

   }
   if (changed)
      SCCharChangedUpdate(sc, layer, true);
}

static char **makevector(const char *str) {
   char **vector;
   const char *start, *pt;
   int i, cnt;

   if (str==NULL)
      return (NULL);

   vector=NULL;
   for (i=0; i<2; ++i) {
      cnt=0;
      for (start=str; isspace(*start); ++start);
      while (*start) {
	 for (pt=start; !isspace(*pt) && *pt != '\0'; ++pt);
	 if (vector != NULL)
	    vector[cnt]=copyn(start, pt-start);
	 ++cnt;
	 for (start=pt; isspace(*start); ++start);
      }
      if (cnt==0)
	 return (NULL);
      if (vector) {
	 vector[cnt]=NULL;
	 return (vector);
      }
      vector=malloc((cnt+1)*sizeof(char *));
   }
   return (NULL);
}

static char *flatten(char *const *args) {
   char *ret, *rpt;
   int j, i, len;

   if (args==NULL)
      return (NULL);

   ret=rpt=NULL;
   for (i=0; i<2; ++i) {
      for (j=0, len=0; args[j] != NULL; ++j) {
	 if (rpt != NULL) {
	    strcpy(rpt, args[j]);
	    rpt += strlen(args[j]);
	    *rpt++=' ';
	 } else
	    len += strlen(args[j])+1;
      }
      if (rpt) {
	 rpt[-1]='\0';
	 return (ret);
      } else if (len <= 1)
	 return (NULL);
      ret=rpt=malloc(len);
   }
   return (NULL);
}

static char **args=NULL;

int autotrace_ask=0, mf_ask=0, mf_clearbackgrounds=0, mf_showerrors=0;

char *mf_args=NULL;

void *GetAutoTraceArgs(void) {
   return (flatten(args));
}

void SetAutoTraceArgs(void *a) {
   int i;

   if (args != NULL) {
      for (i=0; args[i] != NULL; ++i)
	 free(args[i]);
      free(args);
   }
   args=makevector((char *) a);
}

char **AutoTraceArgs(int ask) {
   return (args);
}

void FVAutoTrace(FontViewBase * fv, int ask) {
   char **args;
   int i, cnt, gid;

   args=AutoTraceArgs(ask);
   if (args==(char **) -1)
      return;
   for (i=cnt=0; i<fv->map->enccount; ++i)
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  fv->sf->glyphs[gid] != NULL &&
	  fv->sf->glyphs[gid]->layers[ly_back].images)
	 ++cnt;

   SFUntickAll(fv->sf);
   for (i=cnt=0; i<fv->map->enccount; ++i) {
      if (fv->selected[i] && (gid=fv->map->map[i]) != -1 &&
	  fv->sf->glyphs[gid] != NULL &&
	  fv->sf->glyphs[gid]->layers[ly_back].images &&
	  !fv->sf->glyphs[gid]->ticked) {
	 _SCAutoTrace(fv->sf->glyphs[gid], fv->active_layer, args);
      }
   }
}

char *ProgramExists(char *prog, char *buffer) {
   char *path, *pt;

   if ((path=getenv("PATH"))==NULL)
      return (NULL);

   while (1) {
      pt=strchr(path, ':');
      if (pt==NULL)
	 pt=path+strlen(path);
      if (pt-path<1000) {
	 strncpy(buffer, path, pt-path);
	 buffer[pt-path]='\0';
	 if (pt != path && buffer[pt-path-1] != '/')
	    strcat(buffer, "/");
	 strcat(buffer, prog);
	 /* Under cygwin, applying access to "potrace" will find "potrace.exe" */
	 /*  no need for special check to add ".exe" */
	 if (access(buffer, X_OK) != -1) {
	    return (buffer);
	 }
      }
      if (*pt=='\0')
	 break;
      path=pt+1;
   }
   return (NULL);
}

char *FindAutoTraceName(void) {
   static int searched=0;
   static char *name=NULL;
   char buffer[1025];

   if (searched)
      return (name);

   searched=true;
   if ((name=getenv("POTRACE")) != NULL)
     return (name);
   if (ProgramExists("potrace", buffer) != NULL)
     name="potrace";
   return (name);
}

char *FindMFName(void) {
   static int searched=0;
   static char *name=NULL;
   char buffer[1025];

   if (searched)
      return (name);

   searched=true;
   if ((name=getenv("MF")) != NULL)
      return (name);
   if (ProgramExists("mf", buffer) != NULL)
      name="mf";
   return (name);
}

static char *FindGfFile(char *tempdir) {
   DIR *temp;
   struct dirent *ent;
   char buffer[1025], *ret=NULL;

   temp=opendir(tempdir);
   if (temp != NULL) {
      while ((ent=readdir(temp)) != NULL) {
	 if (strcmp(ent->d_name, ".")==0 || strcmp(ent->d_name, "..")==0)
	    continue;
	 if (strlen(ent->d_name)>2
	     && strcmp(ent->d_name+strlen(ent->d_name)-2, "gf")==0) {
	    strcpy(buffer, tempdir);
	    strcat(buffer, "/");
	    strcat(buffer, ent->d_name);
	    ret=fastrdup(buffer);
	    break;
	 }
      }
      closedir(temp);
   }
   return (ret);
}

static void cleantempdir(char *tempdir) {
   DIR *temp;
   struct dirent *ent;
   char buffer[1025], *eod;
   char *todelete[100];
   int cnt=0;

   temp=opendir(tempdir);
   if (temp != NULL) {
      strcpy(buffer, tempdir);
      strcat(buffer, "/");
      eod=buffer+strlen(buffer);
      while ((ent=readdir(temp)) != NULL) {
	 if (strcmp(ent->d_name, ".")==0 || strcmp(ent->d_name, "..")==0)
	    continue;
	 strcpy(eod, ent->d_name);
	 /* Hmm... doing an unlink right here means changing the dir file */
	 /*  which might mean we could not read it properly. So save up the */
	 /*  things we need to delete and trash them later */
	 if (cnt<99)
	    todelete[cnt++]=fastrdup(buffer);
      }
      closedir(temp);
      todelete[cnt]=NULL;
      for (cnt=0; todelete[cnt] != NULL; ++cnt) {
	 unlink(todelete[cnt]);
	 free(todelete[cnt]);
      }
   }
   rmdir(tempdir);
}

void MfArgsInit(void) {
   if (mf_args==NULL)
      mf_args=fastrdup("\\scrollmode; mode=proof ; mag=2; input");
}

static char *MfArgs(void) {
   MfArgsInit();
   return (mf_args);
}

SplineFont *SFFromMF(char *filename) {
   char *tempdir;
   char *arglist[8];
   int pid, status, ac, i;
   SplineFont *sf=NULL;
   SplineChar *sc;

   if (FindMFName()==NULL) {
      ErrorMsg(2,"Can't find mf\n");
      return (NULL);
   } else if (FindAutoTraceName()==NULL) {
      ErrorMsg(2,"Can't find autotrace\n");
      return (NULL);
   }
   if (MfArgs()==(char *) -1 || AutoTraceArgs(false)==(char **) -1)
      return (NULL);

   /* I don't know how to tell mf to put its files where I want them. */
   /*  so instead I create a temporary directory, cd mf there, and it */
   /*  will put the files there. */
   tempdir=mytempdir();
   if (tempdir==NULL) {
      ErrorMsg(2,"Can't create temporary directory\n");
      return (NULL);
   }

   ac=0;
   arglist[ac++]=FindMFName();
   arglist[ac++]=malloc(strlen(mf_args)+strlen(filename)+20);
   arglist[ac]=NULL;
   strcpy(arglist[1], mf_args);
   strcat(arglist[1], " ");
   strcat(arglist[1], filename);
   if ((pid=fork())==0) {
      /* Child */
      int fd;

      chdir(tempdir);
      if (!mf_showerrors) {
	 close(1);		/* mf generates a lot of verbiage to stdout. Throw it away */
	 fd=open("/dev/null", O_WRONLY);
	 if (fd != 1)
	    dup2(fd, 1);
	 close(0);		/* mf sometimes asks the user questions, but I have no answers... */
	 fd=open("/dev/null", O_RDONLY);
	 if (fd != 0)
	    dup2(fd, 0);
      }
      exit(execvp(arglist[0], arglist)==-1);	/* If exec fails, then die */
   } else if (pid != -1) {
      waitpid(pid, &status, 0);
      if (WIFEXITED(status)) {
	 char *gffile=FindGfFile(tempdir);

	 if (gffile==NULL)
	    ErrorMsg(2,"Can't run mf\n");
	 else {
	    sf=SFFromBDF(gffile, 3, true);
	    free(gffile);
	    if (sf != NULL) {
	       for (i=0; i<sf->glyphcnt; ++i) {
		  if ((sc=sf->glyphs[i]) != NULL
		      && sc->layers[ly_back].images) {
		     _SCAutoTrace(sc, ly_fore, args);
		     if (mf_clearbackgrounds) {
			GImageDestroy(sc->layers[ly_back].images->image);
			free(sc->layers[ly_back].images);
			sc->layers[ly_back].images=NULL;
		     }
		  }
	       }
	    } else
	       ErrorMsg(2,"Can't run mf\n");
	 }
      } else
	 ErrorMsg(2,"Can't run mf\n");
   } else
      ErrorMsg(2,"Can't run mf\n");
   free(arglist[1]);
   cleantempdir(tempdir);
   return (sf);
}
