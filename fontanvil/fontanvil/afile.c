/* $Id: afile.c 3905 2015-04-10 11:10:14Z mskala $ */
/*
 * File abstraction for FontAnvil
 * Copyright (C) 2015  Matthew Skala
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
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

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include <math.h>

#include "_stdint.h"
#include "afile.h"

#define MAGIC_PRIME 33617
#define MAGIC_OFFSET 13399

#define FP_MAGIC (MAGIC_PRIME*101+MAGIC_OFFSET)
#define PSOB_MAGIC (MAGIC_PRIME*103+MAGIC_OFFSET)
#define B85_MAGIC (MAGIC_PRIME*107+MAGIC_OFFSET)
#define MEM_MAGIC (MAGIC_PRIME*109+MAGIC_OFFSET)

#define MAGICAL(f) (((f)!=NULL) && ((f)->magic%MAGIC_PRIME==MAGIC_OFFSET))

typedef struct _AFILE_VTBL {
   int (*fclose_fn)(AFILE *);
   int (*feof_fn)(AFILE *);
   int (*ferror_fn)(AFILE *);
   int (*isatty_fn)(AFILE *);
   int (*fseek_fn)(AFILE *,off_t,int);
   off_t (*ftell_fn)(AFILE *);
   size_t (*fread_fn)(void *,size_t,size_t,AFILE *);
   size_t (*fwrite_fn)(const void *,size_t,size_t,AFILE *);
   int (*ungetc_fn)(int,AFILE *);
} AFILE_VTBL;

struct _AFILE {
   int magic;
   AFILE_VTBL *vtbl;
};

AFILE *astdin,*astdout,*astderr;

/**********************************************************************/

int afclose(AFILE *f) {
   if (MAGICAL(f))
     return f->vtbl->fclose_fn(f);
   else
     return -1;
}

int afeof(AFILE *f) {
   if (MAGICAL(f))
     return f->vtbl->feof_fn(f);
   else
     return -1;
}

int aferror(AFILE *f) {
   if (MAGICAL(f))
     return f->vtbl->ferror_fn(f);
   else
     return -1;
}

int aisatty(AFILE *f) {
   if (MAGICAL(f))
     return f->vtbl->isatty_fn(f);
   else
     return -1;
}

int afseek(AFILE *f,off_t offset,int whence) {
   if (MAGICAL(f))
     return f->vtbl->fseek_fn(f,offset,whence);
   else
     return -1;
}

off_t aftell(AFILE *f) {
   if (MAGICAL(f))
     return f->vtbl->ftell_fn(f);
   else
     return -1;
}

off_t afilesize(AFILE *f) {
   off_t saved,rval;
   
   saved=aftell(f);
   if (afseek(f,0,SEEK_END)<0)
     return -1;
   rval=aftell(f);
   if (afseek(f,saved,SEEK_SET)<0)
     return -1;
   return rval;
}

int agetc(AFILE *f) {
   size_t got;
   char c;
   
   got=afread((void *)&c,sizeof(char),1,f);
   if (got!=1)
     return -1;
   else
     return (int)(unsigned char)c;
}

int aungetc(int c,AFILE *f) {
   if (MAGICAL(f))
     return f->vtbl->ungetc_fn(c,f);
   else
     return -1;
}

char *afgets(char *s,int z,AFILE *f) {
   char *dest=s;

   z--;
   while (z>0) {
      if (afread((void *)dest,sizeof(char),1,f)==1) {
	 z--;
	 if ((*(dest++)=='\n') || (z<=0)) {
	    *dest='\0';
	    return s;
	 }
      } else
	return (dest==s)?NULL:s;
   }

   *s='\0';
   return NULL;
}

int aputc(int c,AFILE *f) {
   if (afwrite(&c,1,1,f)==1)
     return (int)(unsigned char)c;
   else
     return -1;
}

int afputs(const char *s,AFILE *f) {
   int l;

   l=strlen(s);
   return (afwrite(s,1,l,f)==l)?0:-1;
}

size_t afread(void *ptr,size_t size,size_t nitems,AFILE *f) {
   if (MAGICAL(f))
     return f->vtbl->fread_fn(ptr,size,nitems,f);
   else
     return -1;
}

size_t afwrite(const void *ptr,size_t size,size_t nitems,AFILE *f) {
   if (MAGICAL(f))
     return f->vtbl->fwrite_fn(ptr,size,nitems,f);
   else
     return -1;
}

static char *afprintf_buffer=NULL;
static int afprintf_buffer_size=0;

int afprintf(AFILE *f,const char *r,...) {
  va_list args;
  int rval;
  
  va_start(args,r);
  rval=avfprintf(f,r,args);
  va_end(args);
  return rval;
}

int avfprintf(AFILE *f,const char *r,va_list args) {
   int size;
   va_list copied_args;

   if (MAGICAL(f)) {
      if (afprintf_buffer==NULL) {
	 afprintf_buffer=(char *)malloc(100);
	 afprintf_buffer_size=100;
      }
      
      va_copy(copied_args,args);
      size=vsnprintf(afprintf_buffer,afprintf_buffer_size,r,copied_args);
      va_end(copied_args);

      if (size<0)
	return size;
      if (size>=afprintf_buffer_size) {
	 free(afprintf_buffer);
	 afprintf_buffer_size=size+50;
	 afprintf_buffer=(char *)malloc(afprintf_buffer_size);

	 size=vsnprintf(afprintf_buffer,afprintf_buffer_size,r,args);
	 if (size<0) return size;
	 if (size>afprintf_buffer_size) return -1;
      }
      
      return f->vtbl->fwrite_fn(afprintf_buffer,1,size,f);

   } else
     return -1;
}

static void skip_whitespace(AFILE *f) {
   int c;
   
   while (1) {
      c=agetc(f);
      if ((c!=' ') && (c!='\f') && (c!='\n') &&
	  (c!='\r') && (c!='\t') && (c!='\v')) {
	 aungetc(c,f);
	 break;
      }
   }
}

static double scan_double(AFILE *f,int *error) {
   double rval,fraction;
   int main_sign,exp_sign,exponent,c;
   
   rval=0.0;
   fraction=1.0;
   main_sign=1;
   exp_sign=1;
   exponent=0;
   
   *error=1;
   
   /* sign */
   c=agetc(f);
   if (c=='-') {
      main_sign=-1;
      c=agetc(f);
   } else if (c=='+')
	c=agetc(f);
   
   /* digits before decimal point */
   while ((c>='0') && (c<='9')) {
      rval*=10.0;
      rval+=(c-'0');
      *error=0;
      c=agetc(f);
   }
   
   if (c<0)
     return rval*main_sign;
   else if ((c!='.') && (c!='e') && (c!='E')) {
      aungetc(c,f);
      return rval*main_sign;
   }

   /* decimal point */
   if (c=='.') {
      /* digits after decimal point */
      c=agetc(f);
      while ((c>='0') && (c<='9')) {
	 rval+=((c-'0')*fraction);
	 fraction/=10.0;
	 *error=0;
	 c=agetc(f);
      }
      
      if (c<0)
	return rval*main_sign;
      else if ((c!='e') && (c!='E')) {
	 aungetc(c,f);
	 return rval*main_sign;
      }
   }
   
   /* assertion:  c=='e' or c=='E' */
   
   /* sign of exponent */
   c=agetc(f);
   *error=1;
   if (c=='-') {
      exp_sign=-1;
      c=agetc(f);
   } else if (c=='+')
	c=agetc(f);
   
   /* exponent */
   while ((c>=0) && (c<='9')) {
      exponent*=10;
      exponent+=(c-'0');
      *error=0;
      c=agetc(f);
   }
   
   if (c>=0)
     aungetc(c,f);
   
   return main_sign*rval*pow(10.0,exponent*exp_sign);
}

int afscanf(AFILE *f,const char *r,...) {
   va_list args;
   int rval=0,c,error=0,sign;
   const char *rptr;
   char modifier,convspec;
   long read_int;
   unsigned long read_uint;
   double read_double;
   char *read_cptr;
   
   if ((!MAGICAL(f)) || (r==NULL))
     return -1;
   
   va_start(args,r);
   rptr=r;
   
   while (*rptr) {
      /* find a conversion specifier */
      switch (*rptr) {
       case '%':
	 rptr++;

	 switch (*rptr) {
	  case '*':
	  case 'h':
	  case 'l':
	    modifier=*(rptr++);
	    break;
	    
	  default:
	    modifier='\0';
	    break;
	 }
	 
	 switch (*rptr) {
	  case 'c':
	  case 'd':
	  case 'f':
	  case 'g':
	  case 's':
	  case 'u':
	  case 'x':
	    convspec=*(rptr++);
	    break;
	    
	  default:
	    ErrorMsg(3,"Bad afscanf conversion specifier %c\n",*rptr);
	    error=1;
	    rval=0;
	    break;
	 }
	 break;
	 
       case ' ':
       case '\f':
       case '\n':
       case '\r':
       case '\t':
       case '\v':
	 convspec=' ';
	 break;

       default:
	 convspec='\0';
	 modifier=*(rptr++);
	 break;
      }
      
      if (error)
	break;
      
      /* process the specifier */
      switch (convspec) {
       case 'c': /* character by code */
	 c=agetc(f);
	 if (c<0)
	   error=1;
	 else {
	    if (modifier=='\0') {
	       *(va_arg(args,unsigned char *))=(unsigned char)c;
	       rval++;
	    } else if (modifier!='*') {
	       ErrorMsg(3,"Bad modifier to %%c in afscanf\n");
	       error=1;
	       rval=0;
	    }
	 }
	 break;
 
       case 'd': /* decimal int */
	 skip_whitespace(f);
	 error=1;
	 c=agetc(f);
	 if (c=='-') {
	    sign=-1;
	    c=agetc(f);
	 } else if (c=='+') {
	    sign=1;
	    c=agetc(f);
	 } else
	   sign=1;
	 
	 read_int=0;
	 while (1) {
	    if ((c>='0') && (c<='9')) {
	       read_int*=10;
	       read_int+=c;
	       read_int-='0';
	       error=0;
	    } else {
	       aungetc(c,f);
	       break;
	    }
	    c=agetc(f);
	 }
	 read_int*=sign;

	 if (!error) {
	    switch (modifier) {
	     case '*':
	       /* do nothing */
	       break;
	       
	     case 'h':
	       *(va_arg(args,short *))=read_int;
	       rval++;
	       break;

	     case 'l':
	       *(va_arg(args,long *))=read_int;
	       rval++;
	       break;
	       
	     default:
	       *(va_arg(args,int *))=read_int;
	       rval++;
	       break;
	    }
	 }
	 break;
	 
       case 'f':
       case 'g':
	 skip_whitespace(f);
	 read_double=scan_double(f,&error);
	 if (!error) {
	    switch (modifier) {
	     case '*':
	       /* do nothing */
	       break;
	       
	     case 'l':
	       *(va_arg(args,double *))=read_double;
	       rval++;
	       break;
	       
	     default:
	       *(va_arg(args,float *))=read_double;
	       rval++;
	       break;
	    }
	 }
	 break;
	 
       case 's': /* buffer overflow me harder */
	 skip_whitespace(f);

	 if (modifier=='\0')
	   read_cptr=va_arg(args,char *);
	 else if (modifier=='*')
	   read_cptr=NULL;
	 else {
	    ErrorMsg(3,"Bad modifier to %%s in afscanf\n");
	    error=1;
	    rval=0;
	    break;
	 }
	 
	 error=1;
	 while (1) {
	    c=agetc(f);
	    if ((c!=' ') && (c!='\f') && (c!='\n') &&
		(c!='\r') && (c!='\t') && (c!='\v')) {
	       if (read_cptr)
		 *(read_cptr++)=c;
	       error=0;
	    } else {
	       aungetc(c,f);
	       break;
	    }
	 }
	 
	 if (read_cptr && !error) {
	    *(read_cptr)='\0';
	    rval++;
	 }

	 break;
	 
       case 'u': /* unsigned decimal int */
	 skip_whitespace(f);
	 error=1;
	 read_uint=0;
	 
	 while (1) {
	    c=agetc(f);
	    if ((c>='0') && (c<='9')) {
	       read_uint*=10;
	       read_uint+=c;
	       read_uint-='0';
	       error=0;
	    } else {
	       aungetc(c,f);
	       break;
	    }
	 }

	 if (!error) {
	    switch (modifier) {
	     case '*':
	       /* do nothing */
	       break;

	     case 'h':
	       *(va_arg(args,unsigned short *))=read_uint;
	       rval++;
	       break;

	     case 'l':
	       *(va_arg(args,unsigned long *))=read_uint;
	       rval++;
	       break;
	       
	     default:
	       *(va_arg(args,unsigned int *))=read_uint;
	       rval++;
	       break;
	    }
	 }
	 break;
	 
       case 'x': /* signed hexadecimal integer */
	 skip_whitespace(f);

	 error=1;
	 c=agetc(f);
	 if (c=='-') {
	    sign=-1;
	    c=agetc(f);
	 } else if (c=='+') {
	    sign=1;
	    c=agetc(f);
	 } else
	   sign=1;
	 
	 if (c=='0') {
	    c=agetc(f);
	    if ((c=='x') || ('c'=='X'))
	      c=agetc(f);
	 }
	 
	 read_int=0;
	 while (1) {
	    if ((c>='0') && (c<='9')) {
	       read_int*=16;
	       read_int+=c;
	       read_int-='0';
	       error=0;
	    } else if ((c>='a') && (c<='f')) {
	       read_int*=16;
	       read_int+=c;
	       read_int-='a';
	       error=0;
	    } else if ((c>='A') && (c<='F')) {
	       read_int*=16;
	       read_int+=c;
	       read_int-='A';
	       error=0;
	    } else {
	       aungetc(c,f);
	       break;
	    }
	    c=agetc(f);
	 }
	 read_int*=sign;

	 if (!error) {
	    switch (modifier) {
	     case '*':
	       /* do nothing */
	       break;
	       
	     case 'h':
	       *(va_arg(args,short *))=read_int;
	       rval++;
	       break;

	     case 'l':
	       *(va_arg(args,long *))=read_int;
	       rval++;
	       break;
	       
	     default:
	       *(va_arg(args,int *))=read_int;
	       rval++;
	       break;
	    }
	 }
	 break;
	 
       case ' ': /* skip whitespace */
	 skip_whitespace(f);
	 break;
	 
       case '\0': /* search for literal char */
	 c=agetc(f);
	 if (c!=modifier) {
	    aungetc(c,f);
	    error=1;
	 }
	 break;

       default:
	 ErrorMsg(3,"Internal bad afscanf convspec %c\n",convspec);
	 error=1;
	 rval=0;
	 break;
      }
      
      if (error) break;
   }
   
   va_end(args);
   return (rval==0 && error)?-1:rval;
}

/**********************************************************************/

typedef struct _FP_AFILE {
   int magic;
   AFILE_VTBL *vtbl;
   FILE *fp;
} FP_AFILE;

static int fp_fclose(AFILE *f) {
   int rval;
   
   rval=fclose(((FP_AFILE *)f)->fp);
   f->magic=0;
   free(f);
   return rval;
}

static int fp_feof(AFILE *f) {
   return feof(((FP_AFILE *)f)->fp);
}

static int fp_ferror(AFILE *f) {
   return ferror(((FP_AFILE *)f)->fp);
}

static int fp_isatty(AFILE *f) {
   return isatty(fileno(((FP_AFILE *)f)->fp));
}

static int fp_fseek(AFILE *f,off_t offset,int whence) {
#ifdef HAVE_FSEEKO
  return fseeko(((FP_AFILE *)f)->fp,offset,whence);
#else
  return fseek(((FP_AFILE *)f)->fp,offset,whence);
#endif
}

static off_t fp_ftell(AFILE *f) {
#ifdef HAVE_FTELLO
   return ftello(((FP_AFILE *)f)->fp);
#else
   return ftell(((FP_AFILE *)f)->fp);
#endif
}

static size_t fp_fread(void *ptr,size_t size,size_t nmemb,AFILE *f) {
   return fread(ptr,size,nmemb,((FP_AFILE *)f)->fp);
}

static size_t fp_fwrite(const void *ptr,size_t size,size_t nmemb,AFILE *f) {
   return fwrite(ptr,size,nmemb,((FP_AFILE *)f)->fp);
}

static int fp_ungetc(int c,AFILE *f) {
   return ungetc(c,((FP_AFILE *)f)->fp);
}

static AFILE_VTBL fp_afile_vtbl={
   &fp_fclose,&fp_feof,&fp_ferror,&fp_isatty,&fp_fseek,&fp_ftell,
   &fp_fread,&fp_fwrite,&fp_ungetc,
};

AFILE *afopen(const char *filename,const char *mode) {
   return afpopen(fopen(filename,mode));
}

AFILE *afpopen(FILE *fp) {
   FP_AFILE *rval;
   
   if (fp==NULL)
     return NULL;
   rval=(FP_AFILE *)malloc(sizeof(FP_AFILE));
   if (rval==NULL)
     return NULL;

   rval->magic=FP_MAGIC;
   rval->vtbl=&fp_afile_vtbl;
   rval->fp=fp;

   return (AFILE *)rval;
}

/**********************************************************************/

typedef struct _MEM_AFILE {
   int magic;
   AFILE_VTBL *vtbl;
   char *buffer;
   size_t allocated,used;
   off_t ptr;
} MEM_AFILE;

static int mem_fclose(AFILE *f) {
   int rval;
   
   free(((MEM_AFILE *)f)->buffer);
   ((MEM_AFILE *)f)->buffer=NULL;
   f->magic=0;
   free(f);
   return 0;
}

static int mem_feof(AFILE *f) {
   return ((MEM_AFILE *)f)->ptr==((MEM_AFILE *)f)->used;
}

static int mem_zero(AFILE *f) {
   return 0;
}

#define MEM_CHUNK_SIZE 4096
#define MEM_CHUNK_MASK (MEM_CHUNK_SIZE-1)
#define MEM_CHUNK_SHIFT 3072

static void mem_resize(MEM_AFILE *f,size_t new_size) {
   if ((new_size&MEM_CHUNK_MASK)>MEM_CHUNK_SHIFT)
     new_size+=MEM_CHUNK_SIZE;
   new_size&=~MEM_CHUNK_MASK;
   new_size+=MEM_CHUNK_SHIFT;

   f->buffer=(char *)realloc(f->buffer,new_size);
   memset(f->buffer+f->allocated,0,new_size-f->allocated);
   f->allocated=new_size;
}

static int mem_fseek(AFILE *f,off_t offset,int whence) {
   switch (whence) {
    case SEEK_SET:
      if (offset<0)
	return -1;
      ((MEM_AFILE *)f)->ptr=offset;
      break;

    case SEEK_CUR:
      if (-offset>((MEM_AFILE *)f)->ptr)
	return -1;
      ((MEM_AFILE *)f)->ptr+=offset;
      break;

    case SEEK_END:
      if (-offset>((MEM_AFILE *)f)->used)
	return -1;
      ((MEM_AFILE *)f)->ptr=((MEM_AFILE *)f)->used+offset;
      break;

    default:
      return -1;
      break;
   }
   
   if (((MEM_AFILE *)f)->ptr>((MEM_AFILE *)f)->allocated)
     mem_resize((MEM_AFILE *)f,((MEM_AFILE *)f)->ptr);
   return 0;
}

static off_t mem_ftell(AFILE *f) {
   return ((MEM_AFILE *)f)->ptr;
}

static size_t mem_fread(void *ptr,size_t size,size_t nmemb,AFILE *f) {
   size_t rsize;

   if (ptr==NULL)
     return -1;
   if (((MEM_AFILE *)f)->used<((MEM_AFILE *)f)->ptr)
     return -1;
   if ((size<=0) || (nmemb<=0))
     return 0;

   rsize=size*nmemb;
   if (rsize>((MEM_AFILE *)f)->used-((MEM_AFILE *)f)->ptr) {
      rsize=((MEM_AFILE *)f)->used-((MEM_AFILE *)f)->ptr;
      rsize/=size;
      rsize*=size;
   }
   
   memcpy(ptr,((MEM_AFILE *)f)->buffer+((MEM_AFILE *)f)->ptr,rsize);
   ((MEM_AFILE *)f)->ptr+=rsize;

   return rsize/size;
}

static size_t mem_fwrite(const void *ptr,size_t size,size_t nmemb,AFILE *f) {
   if (ptr==NULL)
     return -1;
   if ((size<=0) || (nmemb<=0))
     return 0;

   if (((MEM_AFILE *)f)->ptr>((MEM_AFILE *)f)->used)
     ((MEM_AFILE *)f)->used=((MEM_AFILE *)f)->ptr;
   
   size*=nmemb;
   if (((MEM_AFILE *)f)->ptr+size>((MEM_AFILE *)f)->allocated)
     mem_resize((MEM_AFILE *)f,((MEM_AFILE *)f)->ptr+size);
   
   memcpy(((MEM_AFILE *)f)->buffer+((MEM_AFILE *)f)->ptr,ptr,size);
   ((MEM_AFILE *)f)->ptr+=size;
   if (((MEM_AFILE *)f)->ptr>((MEM_AFILE *)f)->used)
     ((MEM_AFILE *)f)->used=((MEM_AFILE *)f)->ptr;
   
   return nmemb;
}

static int mem_ungetc(int c,AFILE *f) {
   if (c==EOF)
     return EOF;

   if (((MEM_AFILE *)f)->ptr>((MEM_AFILE *)f)->used)
     ((MEM_AFILE *)f)->used=((MEM_AFILE *)f)->ptr;

   if (((MEM_AFILE *)f)->used>=((MEM_AFILE *)f)->allocated)
     mem_resize((MEM_AFILE *)f,((MEM_AFILE *)f)->used+1);
   
   if (((MEM_AFILE *)f)->used>=((MEM_AFILE *)f)->ptr)
     memmove(((MEM_AFILE *)f)->buffer+((MEM_AFILE *)f)->ptr+1,
	     ((MEM_AFILE *)f)->buffer+((MEM_AFILE *)f)->ptr,
	     ((MEM_AFILE *)f)->used-((MEM_AFILE *)f)->ptr+1);

   ((MEM_AFILE *)f)->buffer[((MEM_AFILE *)f)->ptr]=c;
   ((MEM_AFILE *)f)->used++;
   
   return (unsigned char)c;
}

static AFILE_VTBL mem_afile_vtbl={
   &mem_fclose,&mem_feof,&mem_zero,&mem_zero,&mem_fseek,&mem_ftell,
   &mem_fread,&mem_fwrite,&mem_ungetc,
};

AFILE *atmpfile(void) {
   MEM_AFILE *rval;
   
   rval=(MEM_AFILE *)malloc(sizeof(MEM_AFILE));
   if (rval==NULL)
     return NULL;

   rval->magic=MEM_MAGIC;
   rval->vtbl=&mem_afile_vtbl;
   rval->buffer=NULL;
   rval->allocated=0;
   rval->used=0;
   rval->ptr=0;

   return (AFILE *)rval;
}

/**********************************************************************/

#define c1      52845
#define c2      22719

typedef struct _PSOB_AFILE {
   int magic;
   AFILE_VTBL *vtbl;
   AFILE *inner;
   uint16_t r;
   int hexline;
} PSOB_AFILE;

static int psob_fclose(AFILE *f) {
   f->magic=0;
   free(f);
   return 0;
}

static int psob_feof(AFILE *f) {
   return afeof(((PSOB_AFILE *)f)->inner);
}

static int psob_ferror(AFILE *f) {
   return aferror(((PSOB_AFILE *)f)->inner);
}

static int psob_isatty(AFILE *f) {
   return 0;
}

static int psob_fseek(AFILE *f,off_t offset,int whence) {
   ErrorMsg(3,"fseek unimplemented on streams of this type\n");
   return -1;
}

static off_t psob_ftell(AFILE *f) {
   ErrorMsg(3,"ftell unimplemented on streams of this type\n");
   return -1;
}

static size_t psob_fread(void *ptr,size_t size,size_t nmemb,AFILE *f) {
   ErrorMsg(3,"fread unimplemented on streams of this type\n");
   return -1;
}

static size_t psob_bin_write(const void *ptr,size_t size,size_t nmemb,AFILE *f) {
   size_t i,rval,rrval;
   uint8_t cypher;
   
   rval=0;
   for (i=0;i<size*nmemb;i++) {
      cypher=((const uint8_t *)ptr)[i]^(((PSOB_AFILE *)f)->r>>8);
      ((PSOB_AFILE *)f)->r=(cypher+((PSOB_AFILE *)f)->r)*c1+c2;
      rrval=afwrite(&cypher,1,1,((PSOB_AFILE *)f)->inner);
      if (rrval==1)
	rval++;
      else
	break;
   }

   if ((rval==0) && (size*nmemb>0))
     rval=-1;
   return rval;
}

static size_t psob_hex_write(const void *ptr,size_t size,size_t nmemb,AFILE *f) {
   size_t i,rval,rrval;
   uint8_t cypher,ch[2];
   
   rval=0;
   for (i=0;i<size*nmemb;i++) {
      cypher=((const uint8_t *)ptr)[i]^(((PSOB_AFILE *)f)->r>>8);
      ((PSOB_AFILE *)f)->r=(cypher+((PSOB_AFILE *)f)->r)*c1+c2;
      
      ch[0]=cypher>>4;
      if (ch[0]<=9)
	ch[0]+='0';
      else
	ch[0]+=('A'-10);

      ch[1]=cypher&0xF;
      if (ch[1]<=9)
	ch[1]+='0';
      else
	ch[1]+=('A'-10);
      
      rrval=afwrite(&ch,1,2,((PSOB_AFILE *)f)->inner);

      if (rrval==2) {
	 ((PSOB_AFILE *)f)->hexline+=2;
	 if (((PSOB_AFILE *)f)->hexline>70) {
	    ch[0]='\n';
	    rrval=afwrite(&ch,1,1,((PSOB_AFILE *)f)->inner);
	    if (rrval!=1)
	      break;
	    ((PSOB_AFILE *)f)->hexline=0;
	    rval++;
	 } 
      } else
	break;
   }

   if ((rval==0) && (size*nmemb>0))
     rval=-1;
   return rval;
}

static int psob_ungetc(int c,AFILE *f) {
   ErrorMsg(3,"ungetc unimplemented on streams of this type\n");
   return -1;
}

static AFILE_VTBL psob_bin_afile_vtbl={
   &psob_fclose,&psob_feof,&psob_ferror,&psob_isatty,&psob_fseek,&psob_ftell,
   &psob_fread,&psob_bin_write,&psob_ungetc,
};

static AFILE_VTBL psob_hex_afile_vtbl={
   &psob_fclose,&psob_feof,&psob_ferror,&psob_isatty,&psob_fseek,&psob_ftell,
   &psob_fread,&psob_hex_write,&psob_ungetc,
};

AFILE *ps_obfuscated_afile(AFILE *f,int dobinary) {
   static uint8_t randombytes[4]={0xAA,0x55,0x3E,0x4D};

   PSOB_AFILE *rval;

   if (!MAGICAL(f))
     return NULL;
   
   randombytes[0] += 3;
   randombytes[1] += 5;
   randombytes[2] += 7;
   randombytes[3] += 11;
   
   rval=(PSOB_AFILE *)malloc(sizeof(PSOB_AFILE));
   rval->magic=PSOB_MAGIC;
   rval->vtbl=dobinary?&psob_bin_afile_vtbl:&psob_hex_afile_vtbl;
   rval->inner=f;
   rval->r=55665;
   rval->hexline=0;
   
   if (dobinary) {
      uint16_t r;
      uint8_t cypher;

      while (1) {
	 /* find some random bytes such that at least one encrypts to */
	 /* a non-hex character */
	 r=55665;
	 cypher=(randombytes[0]^(r>>8));
	 if ((cypher!='\t') && (cypher!='\n') && (cypher!='\v') &&
	     (cypher!='\r') && (cypher!=' ')) {
	    if (cypher<'0' || (cypher>'9' && cypher<'A')
		|| (cypher>'F' && cypher<'a') || cypher>'f')
	      break;
	    r=(cypher+r)*c1+c2;
	    cypher=(randombytes[1]^(r>>8));
	    if (cypher<'0' || (cypher>'9' && cypher<'A')
		|| (cypher>'F' && cypher<'a') || cypher>'f')
	      break;
	    r=(cypher+r)*c1+c2;
	    cypher=(randombytes[2]^(r>>8));
	    if (cypher<'0' || (cypher>'9' && cypher<'A')
		|| (cypher>'F' && cypher<'a') || cypher>'f')
	      break;
	    r=(cypher+r)*c1+c2;
	    cypher=(randombytes[3]^(r>>8));
	    if (cypher<'0' || (cypher>'9' && cypher<'A')
		|| (cypher>'F' && cypher<'a') || cypher>'f')
	      break;
	 }

	 randombytes[0] += 3;
	 randombytes[1] += 5;
	 randombytes[2] += 7;
	 randombytes[3] += 11;
      }
   }

   afwrite(randombytes,1,4,(AFILE *)rval);
   return (AFILE *)rval;
}

/**********************************************************************/

/* note first three fields are shared with PSOB */
typedef struct _B85_AFILE {
   int magic;
   AFILE_VTBL *vtbl;
   AFILE *inner;
   uint32_t ascii85encode;
   int ascii85n,ascii85bytes_per_line;
} B85_AFILE;

static size_t b85_write(const void *ptr,size_t size,size_t nmemb,AFILE *f) {
   size_t i,rval,rrval;
   
   rval=0;
   for (i=0;i<size*nmemb;i++) {
      
      ((B85_AFILE *)f)->ascii85encode=
	(((B85_AFILE *)f)->ascii85encode<<8)|((uint8_t *)ptr)[i];
      if (++(((B85_AFILE *)f)->ascii85n)==4) {
	 int ch5,ch4,ch3,ch2,ch1;
	 uint32_t val=((B85_AFILE *)f)->ascii85encode;
	 
	 if (val==0) {
	    if (aputc('z',((B85_AFILE *)f)->inner)<0)
	      break;
	    ((B85_AFILE *)f)->ascii85n=0;
	    if (++(((B85_AFILE *)f)->ascii85bytes_per_line)>=76) {
	       if (aputc('\n',((B85_AFILE *)f)->inner)<0)
		 break;
	       ((B85_AFILE *)f)->ascii85bytes_per_line=0;
	    }
	    
	 } else {
	    ch5=val%85;
	    val/=85;
	    ch4=val%85;
	    val/=85;
	    ch3=val%85;
	    val/=85;
	    ch2=val%85;
	    ch1=val/85;
	    if (afprintf(((B85_AFILE *)f)->inner,"%c%c%c%c%c",
			 ch1+'!',ch2+'!',ch3+'!',ch4+'!',ch5+'!')<0)
	      break;
	    ((B85_AFILE *)f)->ascii85encode=0;
	    ((B85_AFILE *)f)->ascii85n=0;
	    if ((((B85_AFILE *)f)->ascii85bytes_per_line+=5)>=80) {
	       if (aputc('\n',((B85_AFILE *)f)->inner)<0)
		 break;
	       ((B85_AFILE *)f)->ascii85bytes_per_line=0;
	    }
	 }

	 rval++;
      }
   }
   
   if ((rval==0) && (size*nmemb>0))
     rval=-1;
   return rval;
}

static int b85_fclose(AFILE *f) {
   uint32_t val=((B85_AFILE *)f)->ascii85encode;
   int n=((B85_AFILE *)f)->ascii85n;
   int ch5,ch4,ch3,ch2,ch1;
   int rval=0;
   
   if (n!=0) {      
      while (n++<4)
	val<<=8;
      ch5=val%85;
      val/=85;
      ch4=val%85;
      val/=85;
      ch3=val%85;
      val/=85;
      ch2=val%85;
      ch1=val/85;

      if (aputc(ch1+'!',((B85_AFILE *)f)->inner)<0) rval=-1;
      if (aputc(ch2+'!',((B85_AFILE *)f)->inner)<0) rval=-1;
      if (((B85_AFILE *)f)->ascii85n>=2)
	if (aputc(ch3+'!',((B85_AFILE *)f)->inner)<0) rval=-1;
      if (((B85_AFILE *)f)->ascii85n>=3)
	if (aputc(ch4+'!',((B85_AFILE *)f)->inner)<0) rval=-1;
   }

   if (aputc('~',((B85_AFILE *)f)->inner)<0) rval=-1;
   if (aputc('>',((B85_AFILE *)f)->inner)<0) rval=-1;
   if (aputc('\n',((B85_AFILE *)f)->inner)<0) rval=-1;

   f->magic=0;
   free(f);
   return 0;
}

static AFILE_VTBL b85_afile_vtbl={
   &b85_fclose,&psob_feof,&psob_ferror,&psob_isatty,&psob_fseek,&psob_ftell,
   &psob_fread,&b85_write,&psob_ungetc,
};

AFILE *base85_afile(AFILE *f) {
   B85_AFILE *rval;

   if (!MAGICAL(f))
     return NULL;
   
   rval=(B85_AFILE *)malloc(sizeof(B85_AFILE));
   rval->ascii85encode=0;
   rval->ascii85n=0;
   rval->ascii85bytes_per_line=0;
   rval->magic=B85_MAGIC;
   rval->vtbl=&b85_afile_vtbl;
   
   return (AFILE *)rval;
}

/**********************************************************************/

static int message_level=1;

void ErrorMsg(int level,const char *format,...) {
  va_list args;

  if (level>=message_level) {
    va_start(args,format);
    avfprintf(astderr,format,args);
    va_end(args);
  }
}
