/* $Id: encoding.c 4050 2015-06-24 18:42:21Z mskala $ */
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
#include <ustring.h>
#include <utype.h>
#include <math.h>
#include <unistd.h>
#include <sys/types.h>
#include <dirent.h>
#include <gfile.h>
#include "encoding.h"
#include "ffglib.h"
#include <glib/gprintf.h>

#include "macenctab.h"
#include "nonmactab.h"

typedef int (*EncFunc) (int);

Encoding *default_encoding=NULL;

/* I don't think iconv provides encodings for zapfdingbats nor jis201 */
/*  Perhaps I should list them here for compatability, but I think I'll just */
/*  leave them out. I doubt they get used. */
static Encoding texbase =
   { "TeX-Base-Encoding", 256, __icemap_enc_texbase_array, NULL, NULL, 1, 1, 1, 1, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0 };
Encoding custom =
   { "Custom", 0, NULL, NULL, &texbase, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
0, "", 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0 };
static Encoding original =
   { "Original", 0, NULL, NULL, &custom, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
0, 0, "", 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0 };
static Encoding unicodebmp =
   { "UnicodeBmp", 65536, NULL, NULL, &original, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0,
0, 0, 0, 0, "", 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0 };
static Encoding unicodefull =
   { "UnicodeFull", 17 * 65536, NULL, NULL, &unicodebmp, 1, 1, 0, 0, 1, 0, 1,
0, 0, 0, 0, 0, 0, 0, "", 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0 };
static Encoding adobestd =
   { "AdobeStandard", 256, unicode_from_adobestd, AdobeStandardEncoding,
&unicodefull,
   1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 0, 0, NULL, NULL, NULL,
      NULL, NULL, 0, 0
};
static Encoding symbol =
   { "Symbol", 256, __icemap_macenc_symbol_array, NULL, &adobestd, 1, 1, 1, 1, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, "", 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0 };

static Encoding *enclist=&symbol;

const char *FindUnicharName(void) {
   /* Iconv and libiconv use different names for UCS2. Just great. Perhaps */
   /*  different versions of each use still different names? */
   /* Even worse, both accept UCS-2, but under iconv it means native byte */
   /*  ordering and under libiconv it means big-endian */
   iconv_t test;

   static char *goodname=NULL;
   static char *names[] =
      { "UCS-4-INTERNAL", "UCS-4", "UCS4", "ISO-10646-UCS-4", "UTF-32",
NULL };
   static char *namesle[]={ "UCS-4LE","UTF-32LE",NULL };
   static char *namesbe[]={ "UCS-4BE","UTF-32BE",NULL };
   char **testnames;

   int i;

   union {
      short s;
      char c[2];
   } u;

   if (goodname != NULL)
      return (goodname);

   u.c[0]=0x1;
   u.c[1]=0x2;
   if (u.s==0x201) {		/* Little endian */
      testnames=namesle;
   } else {
      testnames=namesbe;
   }
   for (i=0; testnames[i] != NULL; ++i) {
      test=iconv_open(testnames[i], "ISO-8859-1");
      if (test != (iconv_t) - 1 && test != NULL) {
	 iconv_close(test);
	 goodname=testnames[i];
	 break;
      }
   }

   if (goodname==NULL) {
      for (i=0; names[i] != NULL; ++i) {
	 test=iconv_open(names[i], "ISO-8859-1");
	 if (test != (iconv_t) - 1 && test != NULL) {
	    iconv_close(test);
	    goodname=names[i];
	    break;
	 }
      }
   }

   if (goodname==NULL) {
      ErrorMsg(3,"Cannot determine version of iconv().  A name for the UCS-4 encoding is required.\n");
      exit(1);
   }

   test=iconv_open(goodname, "Mac");
   if (test==(iconv_t) - 1 || test==NULL) {
      ErrorMsg(2,"This version of iconv does not support the \"Mac Roman\" encoding.\n");
   } else
      iconv_close(test);

   /* I really should check for ISO-2022-JP, KR, CN, and all the other encodings */
   /*  I might find in a ttf 'name' table. But those tables take too long to build */
   return (goodname);
}

static int TryEscape(Encoding *enc,char *escape_sequence) {
   char from[20], ucs[20];
   size_t fromlen, tolen;
   ICONV_CONST char *fpt;
   char *upt;
   int i, j, low;
   int esc_len=strlen(escape_sequence);

   strcpy(from, escape_sequence);

   enc->has_2byte=false;
   low=-1;
   for (i=0; i < 256; ++i)
      if (i != escape_sequence[0]) {
	 for (j=0; j < 256; ++j) {
	    from[esc_len]=i;
	    from[esc_len + 1]=j;
	    from[esc_len + 2]=0;
	    fromlen=esc_len + 2;
	    fpt=from;
	    upt=ucs;
	    tolen=sizeof(ucs);
	    if (iconv(enc->tounicode, &fpt, &fromlen, &upt, &tolen) !=
		(size_t) (-1)
		&& upt - ucs ==
		sizeof(unichar_t) /* Exactly one character */ ) {
	       if (low==-1) {
		  enc->low_page=low=i;
		  enc->has_2byte=true;
	       }
	       enc->high_page=i;
	       break;
	    }
	 }
      }
   if (enc->low_page==enc->high_page)
      enc->has_2byte=false;
   if (enc->has_2byte) {
      strcpy(enc->iso_2022_escape, escape_sequence);
      enc->iso_2022_escape_len=esc_len;
   }
   return (enc->has_2byte);
}

static Encoding *_FindOrMakeEncoding(const char *name,int make_it) {
   Encoding *enc;
   char buffer[20];
   const char *iconv_name;
   Encoding temp;
   uint8_t good[256];
   int i, j, any, all;
   char from[8], ucs[20];
   size_t fromlen, tolen;
   ICONV_CONST char *fpt;
   char *upt;

   /* iconv is not case sensitive */

   if (strncasecmp(name, "iso8859_", 8)==0
       || strncasecmp(name, "koi8_", 5)==0) {
      /* Fixup for old naming conventions */
      strncpy(buffer, name, sizeof(buffer));
      *strchr(buffer, '_')='-';
      name=buffer;
   } else if (strcasecmp(name, "iso-8859")==0) {
      /* Fixup for old naming conventions */
      strncpy(buffer, name, 3);
      strncpy(buffer + 3, name + 4, sizeof(buffer) - 3);
      name=buffer;
   } else if (strcasecmp(name, "isolatin1")==0) {
      name="iso8859-1";
   } else if (strcasecmp(name, "isocyrillic")==0) {
      name="iso8859-5";
   } else if (strcasecmp(name, "isoarabic")==0) {
      name="iso8859-6";
   } else if (strcasecmp(name, "isogreek")==0) {
      name="iso8859-7";
   } else if (strcasecmp(name, "isohebrew")==0) {
      name="iso8859-8";
   } else if (strcasecmp(name, "isothai")==0) {
      name="tis-620";		/* TIS doesn't define non-breaking space in 0xA0 */
   } else if (strcasecmp(name, "latin0")==0
	      || strcasecmp(name, "latin9")==0) {
      name="iso8859-15";	/* "latin-9" is supported (libiconv bug?) */
   } else if (strcasecmp(name, "koi8r")==0) {
      name="koi8-r";
   } else if (strncasecmp(name, "jis201", 6)==0
	      || strncasecmp(name, "jisx0201", 8)==0) {
      name="jis_x0201";
   } else if (strcasecmp(name, "AdobeStandardEncoding")==0
	      || strcasecmp(name, "Adobe")==0)
      name="AdobeStandard";
   for (enc=enclist; enc != NULL; enc=enc->next)
      if (strmatch(name, enc->enc_name)==0 ||
	  (enc->iconv_name != NULL && strmatch(name, enc->iconv_name)==0))
	 return (enc);
   if (strmatch(name, "unicode")==0 || strmatch(name, "iso10646")==0
       || strmatch(name, "iso10646-1")==0)
      return (&unicodebmp);
   if (strmatch(name, "unicode4")==0 || strmatch(name, "ucs4")==0)
      return (&unicodefull);

   iconv_name=name;
   /* Mac seems to work ok */
   if (strcasecmp(name, "win")==0 || strcasecmp(name, "ansi")==0)
      iconv_name="MS-ANSI";	/* "WINDOWS-1252"; */
   else if (strncasecmp(name, "jis208", 6)==0
	    || strncasecmp(name, "jisx0208", 8)==0)
      iconv_name="ISO-2022-JP";
   else if (strncasecmp(name, "jis212", 6)==0
	    || strncasecmp(name, "jisx0212", 8)==0)
      iconv_name="ISO-2022-JP-2";
   else if (strncasecmp(name, "ksc5601", 7)==0)
      iconv_name="ISO-2022-KR";
   else if (strcasecmp(name, "gb2312pk")==0
	    || strcasecmp(name, "gb2312packed")==0)
      iconv_name="EUC-CN";
   else if (strncasecmp(name, "gb2312", 6)==0)
      iconv_name="ISO-2022-CN";
   else if (strcasecmp(name, "wansung")==0)
      iconv_name="EUC-KR";
   else if (strcasecmp(name, "EUC-CN")==0) {
      iconv_name=name;
      name="gb2312pk";
   } else if (strcasecmp(name, "EUC-KR")==0) {
      iconv_name=name;
      name="wansung";
   }

/* Escape sequences:					*/
/*	ISO-2022-CN:     \e $ ) A ^N			*/
/*	ISO-2022-KR:     \e $ ) C ^N			*/
/*	ISO-2022-JP:     \e $ B				*/
/*	ISO-2022-JP-2:   \e $ ( D			*/
   /*	ISO-2022-JP-3:   \e $ ( O			*//* Capital "O", not zero */
   /*	ISO-2022-CN-EXT: \e $ ) E ^N			*//* Not sure about this, also uses CN escape */

   memset(&temp, 0, sizeof(temp));
   temp.builtin=true;
   temp.tounicode=iconv_open(FindUnicharName(), iconv_name);
   if (temp.tounicode==(iconv_t) - 1 || temp.tounicode==NULL)
      return (NULL);		/* Iconv doesn't recognize this name */
   temp.fromunicode=iconv_open(iconv_name, FindUnicharName());
   if (temp.fromunicode==(iconv_t) - 1 || temp.fromunicode==NULL) {
      /* This should never happen, but if it does... */
      iconv_close(temp.tounicode);
      return (NULL);
   }

   memset(good, 0, sizeof(good));
   any=false;
   all=true;
   for (i=1; i < 256; ++i) {
      from[0]=i;
      from[1]=0;
      fromlen=1;
      fpt=from;
      upt=ucs;
      tolen=sizeof(ucs);
      if (iconv(temp.tounicode, &fpt, &fromlen, &upt, &tolen) !=
	  (size_t) (-1)) {
	 good[i]=true;
	 any=true;
      } else
	 all=false;
   }
   if (any)
      temp.has_1byte=true;
   if (all)
      temp.only_1byte=true;

   if (!all) {
      if (strstr(iconv_name, "2022")==NULL) {
	 for (i=temp.has_1byte; i < 256; ++i)
	    if (!good[i]) {
	       for (j=0; j < 256; ++j) {
		  from[0]=i;
		  from[1]=j;
		  from[2]=0;
		  fromlen=2;
		  fpt=from;
		  upt=ucs;
		  tolen=sizeof(ucs);
		  if (iconv(temp.tounicode, &fpt, &fromlen, &upt, &tolen) !=
		      (size_t) (-1)
		      && upt - ucs ==
		      sizeof(unichar_t) /* Exactly one character */ ) {
		     if (temp.low_page==-1)
			temp.low_page=i;
		     temp.high_page=i;
		     temp.has_2byte=true;
		     break;
		  }
	       }
	    }
	 if (temp.low_page==temp.high_page) {
	    temp.has_2byte=false;
	    temp.low_page=temp.high_page=-1;
	 }
      }
      if (!temp.has_2byte && !good[033] /* escape */ ) {
	 if (strstr(iconv_name, "2022") != NULL &&
	     strstr(iconv_name, "JP3") != NULL &&
	     TryEscape(&temp, "\33$(O")) {
	    ;
	 } else if (strstr(iconv_name, "2022") != NULL &&
		    strstr(iconv_name, "JP2") != NULL &&
		    TryEscape(&temp, "\33$(D")) {
	    ;
	 } else if (strstr(iconv_name, "2022") != NULL &&
		    strstr(iconv_name, "JP") != NULL &&
		    TryEscape(&temp, "\33$B")) {
	    ;
	 } else if (strstr(iconv_name, "2022") != NULL &&
		    strstr(iconv_name, "KR") != NULL &&
		    TryEscape(&temp, "\33$)C\16")) {
	    ;
	 } else if (strstr(iconv_name, "2022") != NULL &&
		    strstr(iconv_name, "CN") != NULL &&
		    TryEscape(&temp, "\33$)A\16")) {
	    ;
	 }
      }
   }
   if (!temp.has_1byte && !temp.has_2byte)
      return (NULL);
   if (!make_it)
      return (NULL);

   enc=chunkalloc(sizeof(Encoding));
   *enc=temp;
   enc->enc_name=copy(name);
   if (iconv_name != name)
      enc->iconv_name=copy(iconv_name);
   enc->next=enclist;
   enc->builtin=true;
   enclist=enc;
   if (enc->has_2byte)
      enc->char_cnt=(enc->high_page << 8) + 256;
   else {
      enc->char_cnt=256;
      enc->only_1byte=true;
   }
   if (strstrmatch(iconv_name, "JP") != NULL ||
       strstrmatch(iconv_name, "sjis") != NULL ||
       strstrmatch(iconv_name, "cp932") != NULL)
      enc->is_japanese=true;
   else if (strstrmatch(iconv_name, "KR") != NULL)
      enc->is_korean=true;
   else if (strstrmatch(iconv_name, "CN") != NULL)
      enc->is_simplechinese=true;
   else if (strstrmatch(iconv_name, "BIG") != NULL
	    && strstrmatch(iconv_name, "5") != NULL)
      enc->is_tradchinese=true;

   if (strstrmatch(name, "ISO8859") != NULL &&
       strtol(name + strlen(name) - 2, NULL, 10) >= 16)
      /* Not in our menu, don't hide */ ;
   else if (iconv_name != name || strmatch(name, "mac")==0
	    || strstrmatch(name, "ISO8859") != NULL
	    || strmatch(name, "koi8-r")==0 || strmatch(name, "sjis")==0
	    || strmatch(name, "big5")==0
	    || strmatch(name, "big5hkscs")==0)
      enc->hidden=true;

   return (enc);
}

Encoding *FindOrMakeEncoding(const char *name) {
   return (_FindOrMakeEncoding(name, true));
}

/* Plugin API */
int AddEncoding(char *name, EncFunc enc_to_uni, EncFunc uni_to_enc, int max) {
   Encoding *enc;

   int i;

   for (enc=enclist; enc != NULL; enc=enc->next) {
      if (strmatch(name, enc->enc_name)==0 ||
	  (enc->iconv_name != NULL && strmatch(name, enc->iconv_name)==0)) {
	 if (enc->tounicode_func==NULL)
	    return (0);		/* Failure */
	 else {
	    enc->tounicode_func=enc_to_uni;
	    enc->fromunicode_func=uni_to_enc;
	    enc->char_cnt=max;
	    return (2);
	 }
      }
   }

   if (strmatch(name, "unicode")==0 || strmatch(name, "iso10646")==0
       || strmatch(name, "iso10646-1")==0)
      return (0);		/* Failure */
   if (strmatch(name, "unicode4")==0 || strmatch(name, "ucs4")==0)
      return (0);		/* Failure */

   enc=chunkalloc(sizeof(Encoding));
   enc->enc_name=copy(name);
   enc->next=enclist;
   enclist=enc;
   enc->tounicode_func=enc_to_uni;
   enc->fromunicode_func=uni_to_enc;
   enc->char_cnt=max;
   for (i=0; i < 256 && i < max; ++i)
      if (enc_to_uni(i) != -1)
	 break;

   if (i < 256 && i < max)
      enc->has_1byte=true;
   if (max < 256)
      enc->only_1byte=true;
   else
      enc->has_2byte=true;
   return (1);
}

static void EncodingFree(Encoding *item) {
   int i;

   free(item->enc_name);
   if (item->psnames != NULL)
      for (i=0; i < item->char_cnt; ++i)
	 free(item->psnames[i]);
   free(item->psnames);
   free(item->unicode);
   free(item);
}

static void DeleteEncoding(Encoding *me) {
   FontViewBase *fv;

   Encoding *prev;

   if (me->builtin)
      return;

   for (fv=FontViewFirst(); fv != NULL; fv=fv->next) {
      if (fv->map->enc==me)
	 fv->map->enc=&custom;
   }
   if (me==enclist)
      enclist=me->next;
   else {
      for (prev=enclist; prev != NULL && prev->next != me;
	   prev=prev->next);
      if (prev != NULL)
	 prev->next=me->next;
   }
   EncodingFree(me);
   if (default_encoding==me)
      default_encoding=FindOrMakeEncoding("ISO8859-1");
   if (default_encoding==NULL)
      default_encoding=&custom;
}

/* Parse a TXT file from the unicode consortium */
    /* Unicode Consortium Format A */
    /* List of lines with several fields, */
	/* first is the encoding value (in hex), second the Unicode value (in hex) */
    /* # is a comment character (to eol) */
static Encoding *ParseConsortiumEncodingFile(AFILE *file) {
   char buffer[200];

   int32_t encs[0x10000];

   int enc, unienc, max;

   Encoding *item;

   memset(encs, 0, sizeof(encs));
   max=-1;

   while (afgets(buffer, sizeof(buffer), file) != NULL) {
      if (ishexdigit(buffer[0])) {
	 if (sscanf(buffer, "%x %x", (unsigned *) &enc, (unsigned *) &unienc)
	    ==2 && enc < 0x10000 && enc >= 0) {
	    encs[enc]=unienc;
	    if (enc > max)
	       max=enc;
	 }
      }
   }

   if (max==-1)
      return (NULL);

   ++max;
   if (max < 256)
      max=256;
   item=calloc(1, sizeof(Encoding));
   item->only_1byte=item->has_1byte=true;
   item->char_cnt=max;
   item->unicode=malloc(max * sizeof(int32_t));
   memcpy(item->unicode, encs, max * sizeof(int32_t));
   return (item);
}

static void RemoveMultiples(Encoding *item) {
   Encoding *test;

   for (test=enclist; test != NULL; test=test->next) {
      if (strcmp(test->enc_name, item->enc_name)==0)
	 break;
   }
   if (test != NULL)
      DeleteEncoding(test);
}

char *ParseEncodingFile(char *filename, char *encodingname) {
   AFILE *file;

   char *orig=filename;

   Encoding *head, *item, *prev, *next;

   char *buf, *name;

   int i, ch;

   if (filename==NULL)
     return NULL;
   file=afopen(filename, "r");
   if (file==NULL) {
      if (orig != NULL)
	 ErrorMsg(2,"Couldn't open file %.200s\n",orig);
      return (NULL);
   }
   ch=agetc(file);
   if (ch==EOF) {
      afclose(file);
      return (NULL);
   }
   aungetc(ch, file);
   if (ch=='#' || ch=='0') {
      head=ParseConsortiumEncodingFile(file);
      if (encodingname)
	 head->enc_name=copy(encodingname);
   } else
      head=PSSlurpEncodings(file);
   afclose(file);
   if (head==NULL) {
      ErrorMsg(2,"Bad encoding file format\n");
      return (NULL);
   }

   for (i=0, prev=NULL, item=head; item != NULL;
	prev=item, item=next, ++i) {
      next=item->next;
      if (item->enc_name==NULL) {
	 ErrorMsg(2,"Bad encoding file format (unnamed encoding).\n");
	 return (NULL);
      }
   }
   for (item=head; item != NULL; item=item->next)
      RemoveMultiples(item);

   if (enclist==NULL)
      enclist=head;
   else {
      for (item=enclist; item->next != NULL; item=item->next);
      item->next=head;
   }
   return (copy(head->enc_name));
}

/* ************************************************************************** */
/* ****************************** CID Encodings ***************************** */
/* ************************************************************************** */
struct cidmap *cidmaps=NULL;

int CIDFromName(char *name, SplineFont *cidmaster) {
   /* We've had various conventions for encoding a cid inside a name */
   /* I'm primarily interested in this when the name is something like */
   /*  Japan1.504.vert */
   /* which tells me that the current glyph is the rotated version of */
   /*  cid 504 */
   /* Other convention "cid-504.vert" */
   int len=strlen(cidmaster->ordering);

   int cid;

   char *end;

   if (strncmp(name, cidmaster->ordering, len)==0) {
      if (name[len]=='.')
	 ++len;
   } else if (strncmp(name, "cid-", 4)==0) {
      len=4;
   } else
      len=0;
   cid=strtol(name + len, &end, 10);
   if (end==name + len)
      return (-1);
   if (*end != '.' && *end != '\0')
      return (-1);

   return (cid);
}

int CID2NameUni(struct cidmap *map, int cid, char *buffer, int len) {
   int enc=-1;

   const char *temp;

   if (map==NULL)
      snprintf(buffer, len, "cid-%d", cid);
   else if (cid < map->namemax && map->name[cid] != NULL) {
      strncpy(buffer, map->name[cid], len);
      buffer[len - 1]='\0';
   } else if (cid==0)
      strcpy(buffer, ".notdef");
   else if (cid < map->namemax && map->unicode[cid] != 0) {
      if (map->unicode==NULL || map->namemax==0)
	 enc=0;
      else
	 enc=map->unicode[cid];
      temp=StdGlyphName(buffer, enc, ui_none, (NameList *) - 1);
      if (temp != buffer)
	 strcpy(buffer, temp);
   } else
      snprintf(buffer, len, "%s.%d", map->ordering, cid);
   return (enc);
}

int NameUni2CID(struct cidmap *map, int uni, const char *name) {
   int i;

   struct cidaltuni *alts;

   if (map==NULL)
      return (-1);
   if (uni != -1) {
      // Search for a matching code.
      for (i=0; i < map->namemax; ++i)
	 if (map->unicode[i]==uni)
	    return (i);
      for (alts=map->alts; alts != NULL; alts=alts->next)
	 if (alts->uni==uni)
	    return (alts->cid);
   } else {
      // Search for a matching name.
      for (i=0; i < map->namemax; ++i)
	 if (map->name[i] != NULL && strcmp(map->name[i], name)==0)
	    return (i);
   }
   return (-1);
}

struct altuni *CIDSetAltUnis(struct cidmap *map, int cid) {
   /* Some CIDs are mapped to several unicode code points, damn it */
   struct altuni *sofar=NULL, *alt;

   struct cidaltuni *alts;

   for (alts=map->alts; alts != NULL; alts=alts->next) {
      if (alts->cid==cid) {
	 alt=chunkalloc(sizeof(struct altuni));
	 alt->next=sofar;
	 sofar=alt;
	 alt->unienc=alts->uni;
	 alt->vs=-1;
      }
   }
   return (sofar);
}

int MaxCID(struct cidmap *map) {
   return (map->cidmax);
}

static char *SearchDirForCidMap(char *dir,char *registry,char *ordering,
				int supplement, char **maybefile) {
   char maybe[FILENAME_MAX + 1];

   struct dirent *ent;

   DIR *d;

   int len, rlen=strlen(registry), olen=strlen(ordering);

   char *pt, *end, *ret;

   int test, best=-1;

   if (dir==NULL)
      return (NULL);

   if (*maybefile != NULL) {
      char *pt=strrchr(*maybefile, '.');

      while (pt > *maybefile && isdigit(pt[-1]))
	 --pt;
      best=strtol(pt, NULL, 10);
   }

   d=opendir(dir);
   if (d==NULL)
      return (NULL);
   while ((ent=readdir(d)) != NULL) {
      if ((len=strlen(ent->d_name)) < 8)
	 continue;
      if (strcmp(ent->d_name + len - 7, ".cidmap") != 0)
	 continue;
      if (strncmp(ent->d_name, registry, rlen) != 0
	  || ent->d_name[rlen] != '-')
	 continue;
      pt=ent->d_name + rlen + 1;
      if (strncmp(pt, ordering, olen) != 0 || pt[olen] != '-')
	 continue;
      pt += olen + 1;
      if (!isdigit(*pt))
	 continue;
      test=strtol(pt, &end, 10);
      if (*end != '.')
	 continue;
      if (test >= supplement) {
	 ret=malloc(strlen(dir) + 1 + len + 1);
	 strcpy(ret, dir);
	 strcat(ret, "/");
	 strcat(ret, ent->d_name);
	 closedir(d);
	 return (ret);
      } else if (test > best) {
	 best=test;
	 strcpy(maybe, ent->d_name);
      }
   }
   closedir(d);
   if (best > -1) {
      ret=malloc(strlen(dir) + 1 + strlen(maybe) + 1);
      strcpy(ret, dir);
      strcat(ret, "/");
      strcat(ret, maybe);
      *maybefile=ret;
   }
   return (NULL);
}

static struct cidmap *MakeDummyMap(char *registry,char *ordering,
				   int supplement) {
   struct cidmap *ret=malloc(sizeof(struct cidmap));

   ret->registry=copy(registry);
   ret->ordering=copy(ordering);
   ret->supplement=ret->maxsupple=supplement;
   ret->cidmax=ret->namemax=0;
   ret->unicode=NULL;
   ret->name=NULL;
   ret->alts=NULL;
   ret->next=cidmaps;
   cidmaps=ret;
   return (ret);
}

struct cidmap *LoadMapFromFile(char *file, char *registry, char *ordering,
			       int supplement) {
   struct cidmap *ret=malloc(sizeof(struct cidmap));

   char *pt=strrchr(file, '.');

   AFILE *f;

   int cid1, cid2, uni, cnt, i, ch;

   char name[100];

   while (pt > file && isdigit(pt[-1]))
      --pt;
   ret->supplement=ret->maxsupple=strtol(pt, NULL, 10);
   if (supplement > ret->maxsupple)
      ret->maxsupple=supplement;
   ret->registry=copy(registry);
   ret->ordering=copy(ordering);
   ret->alts=NULL;
   ret->cidmax=ret->namemax=0;
   ret->unicode=NULL;
   ret->name=NULL;
   ret->next=cidmaps;
   cidmaps=ret;

   f=afopen(file, "r");
   if (f==NULL)
      ErrorMsg(2,"Couldn't open cidmap file: %s\n",file);
   else if (afscanf(f, "%d %d", &ret->cidmax, &ret->namemax) != 2) {
      ErrorMsg(2,"Bad cidmap file %s\n",file);
   } else {
      ret->unicode=calloc(ret->namemax + 1, sizeof(uint32_t));
      ret->name=calloc(ret->namemax + 1, sizeof(char *));
      while (1) {
	 cnt=afscanf(f, "%d..%d %x", &cid1, &cid2, (unsigned *) &uni);
	 if (cnt <= 0)
	    break;
	 if (cid1 > ret->namemax)
	    continue;
	 if (cnt==3) {
	    if (cid2 > ret->namemax)
	       cid2=ret->namemax;
	    for (i=cid1; i <= cid2; ++i)
	       ret->unicode[i]=uni++;
	 } else if (cnt==1) {
	    if (afscanf(f, "%x", (unsigned *) &uni)==1) {
	       ret->unicode[cid1]=uni;
	       ch=agetc(f);
	       while (ch==',') {
		  if (afscanf(f, "%x", (unsigned *) &uni)==1) {
		     struct cidaltuni *alt =
			chunkalloc(sizeof(struct cidaltuni));
		     alt->next=ret->alts;
		     ret->alts=alt;
		     alt->uni=uni;
		     alt->cid=cid1;
		  }
		  ch=agetc(f);
	       }
	       aungetc(ch, f);
	    } else if (afscanf(f, " /%s", name)==1)
	       ret->name[cid1]=copy(name);
	 }
      }
      afclose(f);
   }
   return (ret);
}

struct cidmap *FindCidMap(char *registry, char *ordering, int supplement,
			  SplineFont *sf) {
   struct cidmap *map, *maybe=NULL;
   char *file, *maybefile=NULL;
   int maybe_sup=-1;
   char *buts[3], *buts2[3], *buts3[3];
   gchar *buf=NULL;
   int ret;

   if (sf != NULL && sf->cidmaster)
      sf=sf->cidmaster;
   if (sf != NULL && sf->loading_cid_map)
      return (NULL);

   for (map=cidmaps; map != NULL; map=map->next) {
      if (strcmp(map->registry, registry)==0
	  && strcmp(map->ordering, ordering)==0) {
	 if (supplement <= map->supplement)
	    return (map);
	 else if (maybe==NULL || maybe->supplement < map->supplement)
	    maybe=map;
      }
   }
   if (maybe != NULL && supplement <= maybe->maxsupple)
      return (maybe);		/* User has said it's ok to use maybe at this supplement level */

   file=SearchDirForCidMap(".", registry, ordering, supplement, &maybefile);
   if (file==NULL)
      file =
	 SearchDirForCidMap(getFontAnvilShareDir(), registry, ordering,
			    supplement, &maybefile);

   if (file==NULL && (maybe != NULL || maybefile != NULL)) {
      if (maybefile != NULL) {
	 char *pt=strrchr(maybefile, '.');

	 while (pt > maybefile && isdigit(pt[-1]))
	    --pt;
	 maybe_sup=strtol(pt, NULL, 10);
	 if (maybe != NULL && maybe->supplement >= maybe_sup) {
	    free(maybefile);
	    maybefile=NULL;
	    maybe_sup=maybe->supplement;
	 } else
	    maybe=NULL;
      }
      if (maybe != NULL)
	 maybe_sup=maybe->supplement;
      if (sf != NULL)
	 sf->loading_cid_map=true;
      buts[0]=_("_Use It");
      buts[1]=_("_Search");
      buts[2]=NULL;
      ret=0;
      if (sf != NULL)
	 sf->loading_cid_map=false;
	 if (maybe != NULL) {
	    maybe->maxsupple=supplement;
	    return (maybe);
	 } else {
	    file=maybefile;
	    maybefile=NULL;
	 }
   }

   if (file==NULL) {
      char *uret;

      buf=g_strdup_printf("%s-%s-*.cidmap", registry, ordering);
      if (maybe==NULL && maybefile==NULL) {
	 buts3[0]=_("_Browse");
	 buts3[1]=_("_Give Up");
	 buts3[2]=NULL;
	 ret=0;
	 g_free(buf);
	 buf=NULL;
      }
      uret=NULL;
      if (uret==NULL) {
	 buts2[0]="_Use It";
	 buts2[1]="_Search";
	 buts2[2]=NULL;
	 if (maybe==NULL && maybefile==NULL)
	    /* No luck */ ;
	 else if (maybe!=NULL) {
	    maybe->maxsupple=supplement;
	    return (maybe);
	 } else {
	    file=maybefile;
	    maybefile=NULL;
	 }
      } else {
	 file=utf82def_copy(uret);
	 free(uret);
      }
   }

   free(maybefile);
   if (file != NULL) {
      map=LoadMapFromFile(file, registry, ordering, supplement);
      free(file);
      return (map);
   }

   return (MakeDummyMap(registry, ordering, supplement));
}

static void SFApplyOrdering(SplineFont *sf,int glyphcnt) {
   SplineChar **glyphs, *sc;

   int i;

   RefChar *refs, *rnext, *rprev;

   SplineSet *new, *spl;

   /* Remove references to characters which aren't in the new map (if any) */
   /* Don't need to fix up dependencies, because we throw the char away */
   for (i=0; i < sf->glyphcnt; ++i)
      if ((sc=sf->glyphs[i]) != NULL) {
	 for (rprev=NULL, refs=sc->layers[ly_fore].refs; refs != NULL;
	      refs=rnext) {
	    rnext=refs->next;
	    if (refs->sc->orig_pos==-1) {
	       new=refs->layers[0].splines;
	       if (new != NULL) {
		  for (spl=new; spl->next != NULL; spl=spl->next);
		  spl->next=sc->layers[ly_fore].splines;
		  sc->layers[ly_fore].splines=new;
	       }
	       refs->layers[0].splines=NULL;
	       RefCharFree(refs);
	       if (rprev==NULL)
		  sc->layers[ly_fore].refs=rnext;
	       else
		  rprev->next=rnext;
	    } else
	       rprev=refs;
	 }
      }

   glyphs=calloc(glyphcnt + 1, sizeof(SplineChar *));
   for (i=0; i < sf->glyphcnt; ++i)
      if ((sc=sf->glyphs[i]) != NULL) {
	 if (sc->orig_pos==-1)
	    SplineCharFree(sc);
	 else
	    glyphs[sc->orig_pos]=sc;
      }

   free(sf->glyphs);
   sf->glyphcnt=sf->glyphmax=glyphcnt;
   sf->glyphs=glyphs;
}

/* Convert a normal font to a cid font, rearranging glyphs into cid order */
static void SFEncodeToMap(SplineFont *sf,struct cidmap *map) {
   SplineChar *sc;

   int i, max=0, anyextras=0;

   for (i=0; i < sf->glyphcnt; ++i)
      if (SCWorthOutputting(sc=sf->glyphs[i])) {
	 sc->orig_pos=NameUni2CID(map, sc->unicodeenc, sc->name);
	 if (sc->orig_pos > max)
	    max=sc->orig_pos;
	 else if (sc->orig_pos==-1)
	    ++anyextras;
      } else if (sc != NULL)
	 sc->orig_pos=-1;

   if (anyextras) {
      char *buttons[3];

      buttons[0]=_("_Delete");
      buttons[1]=_("_Add");
      buttons[2]=NULL;
   }
   SFApplyOrdering(sf, max + 1);
}

enum cmaptype { cmt_out=-1, cmt_coderange, cmt_notdefs, cmt_cid, cmt_max };

struct coderange {
   uint32_t first, last, cid;
};

struct cmap {
   struct {
      int n;
      struct coderange *ranges;
   } groups[cmt_max];
   char *registry;
   char *ordering;
   int supplement;
   struct remap *remap;
   int total;
};

static void cmapfree(struct cmap *cmap) {
   free(cmap->registry);
   free(cmap->ordering);
   free(cmap->groups[cmt_coderange].ranges);
   free(cmap->groups[cmt_notdefs].ranges);
   free(cmap->groups[cmt_cid].ranges);
   free(cmap->remap);
   free(cmap);
}

static struct coderange *ExtendArray(struct coderange *ranges,int *n,
				     int val) {
   if (*n==0)
      ranges=calloc(val, sizeof(struct coderange));
   else {
      ranges=realloc(ranges, (*n + val) * sizeof(struct coderange));
      memset(ranges + *n, 0, val * sizeof(struct coderange));
   }
   *n += val;
   return (ranges);
}

static char *readpsstr(char *str) {
   char *eos;

   while (isspace(*str))
      ++str;
   if (*str=='(')
      ++str;
   /* PostScript strings can be more complicated than this (hex, nested parens, Enc85...) */
   /*  but none of those should show up here */
   for (eos=str; *eos != ')' && *eos != '\0'; ++eos);
   return (copyn(str, eos - str));
}

static struct cmap *ParseCMap(char *filename) {
   char buf2[200];

   AFILE *file;

   struct cmap *cmap;

   char *end, *pt;

   int val, pos;

   enum cmaptype in;

   static const char *bcsr="begincodespacerange",*bndr =
      "beginnotdefrange", *bcr="begincidrange";
   static const char *reg="/Registry",*ord="/Ordering",*sup =
      "/Supplement";

   file=afopen(filename, "r");
   if (file==NULL)
      return (NULL);

   cmap=calloc(1, sizeof(struct cmap));
   in=cmt_out;
   while (afgets(buf2, sizeof(buf2), file) != NULL) {
      for (pt=buf2; isspace(*pt); ++pt);
      if (in==cmt_out) {
	 if (*pt=='/') {
	    if (strncmp(pt, reg, strlen(reg))==0)
	       cmap->registry=readpsstr(pt + strlen(reg));
	    else if (strncmp(pt, ord, strlen(ord))==0)
	       cmap->ordering=readpsstr(pt + strlen(ord));
	    else if (strncmp(pt, ord, strlen(ord))==0) {
	       for (pt += strlen(sup); isspace(*pt); ++pt);
	       cmap->supplement=strtol(pt, NULL, 10);
	    }
	    continue;
	 } else if (!isdigit(*pt))
	    continue;
	 val=strtol(pt, &end, 10);
	 while (isspace(*end))
	    ++end;
	 if (strncmp(end, bcsr, strlen(bcsr))==0)
	    in=cmt_coderange;
	 else if (strncmp(end, bndr, strlen(bndr))==0)
	    in=cmt_notdefs;
	 else if (strncmp(end, bcr, strlen(bcr))==0)
	    in=cmt_cid;
	 if (in != cmt_out) {
	    pos=cmap->groups[in].n;
	    cmap->groups[in].ranges =
	       ExtendArray(cmap->groups[in].ranges, &cmap->groups[in].n, val);
	 }
      } else if (strncmp(pt, "end", 3)==0)
	 in=cmt_out;
      else {
	 if (*pt != '<')
	    continue;
	 cmap->groups[in].ranges[pos].first=strtoul(pt + 1, &end, 16);
	 if (*end=='>')
	    ++end;
	 while (isspace(*end))
	    ++end;
	 if (*end=='<')
	    ++end;
	 cmap->groups[in].ranges[pos].last=strtoul(end, &end, 16);
	 if (in != cmt_coderange) {
	    if (*end=='>')
	       ++end;
	    while (isspace(*end))
	       ++end;
	    cmap->groups[in].ranges[pos].cid=strtol(end, &end, 10);
	 }
	 ++pos;
      }
   }
   afclose(file);
   return (cmap);
}

static void CompressCMap(struct cmap *cmap) {
   int32_t i, j, k, pos, base;

   uint32_t min, oldmax;

   /* we can't really deal with three and four byte encodings */
   /*  so if we get one arrange for the sf itself to do a remap */

   cmap->total=0x10000;
   for (i=0; i < cmap->groups[cmt_coderange].n; ++i)
      if (cmap->groups[cmt_coderange].ranges[i].last > 0xfffff)
	 break;
   if (i==cmap->groups[cmt_coderange].n)	/* No need to remap */
      return;

   cmap->remap =
      calloc(cmap->groups[cmt_coderange].n + 1, sizeof(struct remap));
   base=0;
   for (i=0; i < cmap->groups[cmt_coderange].n; ++i)
      if (cmap->groups[cmt_coderange].ranges[i].last < 0xffff) {
	 base=0x10000;
	 break;
      }

   pos=0;
   oldmax=base==0 ? 0 : 0xffff;
   for (i=0; i < cmap->groups[cmt_coderange].n; ++i) {
      min=0xffffffff;
      k=-1;
      for (j=0; j < cmap->groups[cmt_coderange].n; ++j)
	 if (cmap->groups[cmt_coderange].ranges[j].first > oldmax &&
	     cmap->groups[cmt_coderange].ranges[j].first < min) {
	    min=cmap->groups[cmt_coderange].ranges[j].first;
	    k=j;
	 }
      if (k==-1)
	 break;
      cmap->remap[pos].firstenc =
	 cmap->groups[cmt_coderange].ranges[k].first & ~0xff;
      cmap->remap[pos].lastenc =
	 cmap->groups[cmt_coderange].ranges[k].last | 0xff;
      cmap->remap[pos].infont=base;
      base += cmap->remap[pos].lastenc - cmap->remap[pos].firstenc + 1;
      oldmax=cmap->remap[pos].lastenc;
      ++pos;
   }
   cmap->remap[pos].infont=-1;	/* Marks end */
   cmap->total=base;
   /* so cmap->remap will map sf indices into the encoding in the cmap */

   /* And now we want to change the groups[cmt_cid].ranges so that they will */
   /*  map into sf indices rather than into the encoding of the cmap */
   for (i=0; i < cmap->groups[cmt_cid].n; ++i) {
      for (k=0; cmap->remap[k].infont != -1; ++k)
	 if (cmap->groups[cmt_cid].ranges[i].first >= cmap->remap[k].firstenc
	     && cmap->groups[cmt_cid].ranges[i].first <=
	     cmap->remap[k].lastenc)
	    break;
      if (cmap->remap[k].infont==-1)
	 continue;
      cmap->groups[cmt_cid].ranges[i].first +=
	 cmap->remap[k].infont - cmap->remap[k].firstenc;
      cmap->groups[cmt_cid].ranges[i].last +=
	 cmap->remap[k].infont - cmap->remap[k].firstenc;
   }
}

static SplineFont *CIDFlatten(SplineFont *cidmaster,SplineChar ** glyphs,
		       int charcnt) {
   FontViewBase *fvs;

   SplineFont *new;

   char buffer[20];

   BDFFont *bdf;

   int j;

   if (cidmaster==NULL)
      return (NULL);
   new=SplineFontEmpty();
   new->fontname=copy(cidmaster->fontname);
   new->fullname=copy(cidmaster->fullname);
   new->familyname=copy(cidmaster->familyname);
   new->weight=copy(cidmaster->weight);
   new->copyright=copy(cidmaster->copyright);
   sprintf(buffer, "%g", cidmaster->cidversion);
   new->version=copy(buffer);
   new->italicangle=cidmaster->italicangle;
   new->upos=cidmaster->upos;
   new->uwidth=cidmaster->uwidth;
   new->ascent=cidmaster->ascent;
   new->descent=cidmaster->descent;
   new->changed=true;
   new->display_antialias=cidmaster->display_antialias;
   new->hasvmetrics=cidmaster->hasvmetrics;
   new->fv=cidmaster->fv;
   /* Don't copy the grid splines, there won't be anything meaningfull at top level */
   /*  and won't know which font to copy from below */
   new->bitmaps=cidmaster->bitmaps;	/* should already be flattened */
   cidmaster->bitmaps=NULL;	/* don't free 'em */
   for (bdf=new->bitmaps; bdf != NULL; bdf=bdf->next)
      bdf->sf=new;
   new->gpos_lookups=cidmaster->gpos_lookups;
   cidmaster->gpos_lookups=NULL;
   new->gsub_lookups=cidmaster->gsub_lookups;
   cidmaster->gsub_lookups=NULL;
   new->kerns=cidmaster->kerns;
   new->vkerns=cidmaster->vkerns;
   cidmaster->kerns=cidmaster->vkerns=NULL;
   new->names=cidmaster->names;
   cidmaster->names=NULL;
   new->horiz_base=cidmaster->horiz_base;
   cidmaster->horiz_base=NULL;
   new->vert_base=cidmaster->vert_base;
   cidmaster->vert_base=NULL;
   new->pfminfo=cidmaster->pfminfo;
   new->texdata=cidmaster->texdata;
   new->possub=cidmaster->possub;
   cidmaster->possub=NULL;
   new->sm=cidmaster->sm;
   cidmaster->sm=NULL;
   new->features=cidmaster->features;
   cidmaster->features=NULL;
   new->macstyle=cidmaster->macstyle;
   new->origname=copy(cidmaster->origname);
   new->display_size=cidmaster->display_size;
   /* Don't copy private */
   new->xuid=copy(cidmaster->xuid);
   new->glyphs=glyphs;
   new->glyphcnt=new->glyphmax=charcnt;
   for (j=0; j < charcnt; ++j)
      if (glyphs[j] != NULL) {
	 glyphs[j]->parent=new;
	 glyphs[j]->orig_pos=j;
      }
   for (fvs=new->fv; fvs != NULL; fvs=fvs->nextsame) {
      fvs->cidmaster=NULL;
      if (fvs->sf->glyphcnt != new->glyphcnt) {
	 free(fvs->selected);
	 fvs->selected=calloc(new->glyphcnt, sizeof(char));
	 if (fvs->map->encmax < new->glyphcnt)
	    fvs->map->map =
	       realloc(fvs->map->map,
		       (fvs->map->encmax=new->glyphcnt) * sizeof(int32_t));
	 fvs->map->enccount=new->glyphcnt;
	 if (fvs->map->backmax < new->glyphcnt)
	    fvs->map->backmap =
	       realloc(fvs->map->backmap,
		       (fvs->map->backmax=new->glyphcnt) * sizeof(int32_t));
	 for (j=0; j < new->glyphcnt; ++j)
	    fvs->map->map[j]=fvs->map->backmap[j]=j;
      }
      fvs->sf=new;
   }
   SplineFontFree(cidmaster);
   return (new);
}

void SFFlatten(SplineFont *cidmaster) {
   SplineChar **glyphs;

   int i, j, max;

   if (cidmaster==NULL)
      return;
   if (cidmaster->cidmaster != NULL)
      cidmaster=cidmaster->cidmaster;
   /* This doesn't change the ordering, so no need for special tricks to */
   /*  preserve scrolling location. */
   for (i=max=0; i < cidmaster->subfontcnt; ++i) {
      if (max < cidmaster->subfonts[i]->glyphcnt)
	 max=cidmaster->subfonts[i]->glyphcnt;
   }
   glyphs=calloc(max, sizeof(SplineChar *));
   for (j=0; j < max; ++j) {
      for (i=0; i < cidmaster->subfontcnt; ++i) {
	 if (j < cidmaster->subfonts[i]->glyphcnt
	     && cidmaster->subfonts[i]->glyphs[j] != NULL) {
	    glyphs[j]=cidmaster->subfonts[i]->glyphs[j];
	    cidmaster->subfonts[i]->glyphs[j]=NULL;
	    break;
	 }
      }
   }
   CIDFlatten(cidmaster, glyphs, max);
}

int SFFlattenByCMap(SplineFont *sf, char *cmapname) {
   struct cmap *cmap;
   int i, j, k, l, m, extras, max, curmax, warned;
   int found[4];
   SplineChar **glyphs=NULL, *sc;
   FontViewBase *fvs;

   if (sf->cidmaster != NULL)
      sf=sf->cidmaster;
   if (sf->subfontcnt==0) {
      ErrorMsg(2,"Not a CID-keyed font\n");
      return (false);
   }
   if (cmapname==NULL)
      return (false);
   cmap=ParseCMap(cmapname);
   if (cmap==NULL)
      return (false);
   CompressCMap(cmap);
   max=0;
   for (i=0; i < cmap->groups[cmt_cid].n; ++i) {
      if (max < cmap->groups[cmt_cid].ranges[i].last)
	 max=cmap->groups[cmt_cid].ranges[i].last;
      if (cmap->groups[cmt_cid].ranges[i].last > 0x100000) {
	 ErrorMsg(2,"Encoding too large\n");
	 cmapfree(cmap);
	 return (false);
      }
   }

   curmax=0;
   for (k=0; k < sf->subfontcnt; ++k) {
      if (curmax < sf->subfonts[k]->glyphcnt)
	 curmax=sf->subfonts[k]->glyphcnt;
   }

   glyphs=calloc(curmax, sizeof(SplineChar *));
   for (i=0; i < curmax; ++i) {
      for (k=0; k < sf->subfontcnt; ++k)
	 if (i < sf->subfonts[k]->glyphcnt
	     && sf->subfonts[k]->glyphs[i] != NULL) {
	    glyphs[i]=sf->subfonts[k]->glyphs[i];
	    sf->subfonts[k]->glyphs[i]=NULL;
	    break;
	 }
   }
   sf=CIDFlatten(sf, glyphs, curmax);

   warned=true;
   for (fvs=sf->fv; fvs != NULL; fvs=fvs->nextsame) {
      EncMap *map=fvs->map;

      for (j=0; j < 2; ++j) {
	 extras=0;
	 for (i=0; i < curmax; ++i) {
	    sc=glyphs[i];
	    if (sc != NULL) {
	       m=0;
	       for (l=0; l < cmap->groups[cmt_cid].n; ++l) {
		  if (i >= cmap->groups[cmt_cid].ranges[l].cid &&
		      i <= cmap->groups[cmt_cid].ranges[l].cid +
		      cmap->groups[cmt_cid].ranges[l].last -
		      cmap->groups[cmt_cid].ranges[l].first) {
		     if (m < sizeof(found) / sizeof(found[0]))
			found[m++]=l;
		     else if (!warned) {
			ErrorMsg(1,"The glyph at CID %d is mapped to more "
			           "than %d encodings.  Only the first %d "
			           "are handled.\n",
                                 i,sizeof(found)/sizeof(found[0]),
                                 sizeof(found)/sizeof(found[0]));
			warned=true;
		     }
		  }
	       }
	       if (m==0) {
		  if (j) {
		     map->map[max + extras]=sc->orig_pos;
		     map->backmap[sc->orig_pos]=max + extras;
		  }
		  ++extras;
	       } else {
		  if (j) {
		     int p=cmap->groups[cmt_cid].ranges[found[0]].first +
			i - cmap->groups[cmt_cid].ranges[found[0]].cid;
		     map->map[p]=sc->orig_pos;
		     map->backmap[sc->orig_pos]=p;
		     for (l=1; l < m; ++l) {
			int pos =
			   cmap->groups[cmt_cid].ranges[found[l]].first + i -
			   cmap->groups[cmt_cid].ranges[found[l]].cid;
			map->map[pos]=sc->orig_pos;
		     }
		  }
	       }
	    }
	 }
	 if (!j) {
	    map->map =
	       realloc(map->map,
		       (map->encmax=map->enccount =
			max + extras) * sizeof(int32_t));
	    memset(map->map, -1, map->enccount * sizeof(int32_t));
	    memset(map->backmap, -1, sf->glyphcnt * sizeof(int32_t));
	    map->remap=cmap->remap;
	    cmap->remap=NULL;
	 }
	 warned=true;
      }
   }
   cmapfree(cmap);
   return (true);
}

static int Enc2CMap(struct cmap *cmap,int enc) {
   int i;

   for (i=0; i < cmap->groups[cmt_cid].n; ++i)
      if (enc >= cmap->groups[cmt_cid].ranges[i].first &&
	  enc <= cmap->groups[cmt_cid].ranges[i].last)
	 return (enc - cmap->groups[cmt_cid].ranges[i].first +
		 cmap->groups[cmt_cid].ranges[i].cid);

   return (-1);
}

static void SFEncodeToCMap(SplineFont *cidmaster,SplineFont *sf,
			   EncMap * oldmap, struct cmap *cmap) {
   SplineChar *sc, *GID0=NULL;

   int i, max=0, anyextras=0;

   cidmaster->cidregistry=cmap->registry;
   cmap->registry=NULL;
   cidmaster->ordering=cmap->ordering;
   cmap->ordering=NULL;
   cidmaster->supplement=cmap->supplement;

   for (i=0; i < sf->glyphcnt; ++i)
      if ((sc=sf->glyphs[i]) != NULL) {
	 if (strcmp(sc->name, ".notdef")==0)
	    sc->orig_pos=0;
	 else if (oldmap->backmap[i]==-1)
	    sc->orig_pos=-1;
	 else {
	    sc->orig_pos=Enc2CMap(cmap, oldmap->backmap[i]);
	    if (sc->orig_pos==0) {
	       if (GID0==NULL)
		  GID0=sc;
	       else
		  sc->orig_pos=-1;
	    }
	 }
	 if (sc->orig_pos > max)
	    max=sc->orig_pos;
	 else if (sc->orig_pos==-1)
	    ++anyextras;
      }
   if (GID0 != NULL)
      GID0->orig_pos=++max;

   SFApplyOrdering(sf, max + 1);
}

/* If we change the ascent/descent of a sub font then consider changing the */
/*  as/ds of the master font. I used to think this irrelevant, but as the */
/*  typoAscent/Descent is based on the master's ascent/descent it actually */
/*  is meaningful. Set the master to the subfont with the most glyphs */
static void CIDMasterAsDes(SplineFont *sf) {
   SplineFont *cidmaster=sf->cidmaster;

   SplineFont *best;

   int i, cid, cnt, bcnt;

   if (cidmaster==NULL)
      return;
   best=NULL;
   bcnt=0;
   for (i=0; i < cidmaster->subfontcnt; ++i) {
      sf=cidmaster->subfonts[i];
      for (cid=cnt=0; cid < sf->glyphcnt; ++cid)
	 if (sf->glyphs[cid] != NULL)
	    ++cnt;
      if (cnt > bcnt) {
	 best=sf;
	 bcnt=cnt;
      }
   }
   if (best==NULL && cidmaster->subfontcnt > 0)
      best=cidmaster->subfonts[0];
   if (best != NULL) {
      double ratio=1000.0 / (best->ascent + best->descent);

      int ascent=rint(best->ascent * ratio);

      if (cidmaster->ascent != ascent || cidmaster->descent != 1000 - ascent) {
	 cidmaster->ascent=ascent;
	 cidmaster->descent=1000 - ascent;
      }
   }
}

SplineFont *MakeCIDMaster(SplineFont *sf, EncMap * oldmap, int bycmap,
			  char *cmapfilename, struct cidmap *cidmap) {
   SplineFont *cidmaster;

   struct cidmap *map;

   struct cmap *cmap;

   FontViewBase *fvs;

   cidmaster=SplineFontEmpty();
   if (bycmap) {
      if (cmapfilename==NULL) {
	 SplineFontFree(cidmaster);
	 return (NULL);
      }
      cmap=ParseCMap(cmapfilename);
      if (cmap==NULL) {
	 SplineFontFree(cidmaster);
	 return (NULL);
      }
      CompressCMap(cmap);
      SFEncodeToCMap(cidmaster, sf, oldmap, cmap);
      cmapfree(cmap);
   } else {
      map=cidmap;
      if (map==NULL) {
	 SplineFontFree(cidmaster);
	 return (NULL);
      }
      cidmaster->cidregistry=copy(map->registry);
      cidmaster->ordering=copy(map->ordering);
      cidmaster->supplement=map->supplement;
      SFEncodeToMap(sf, map);
   }
   if (sf->uni_interp != ui_none && sf->uni_interp != ui_unset)
      cidmaster->uni_interp=sf->uni_interp;
   else if (strstrmatch(cidmaster->ordering, "japan") != NULL)
      cidmaster->uni_interp=ui_japanese;
   else if (strstrmatch(cidmaster->ordering, "CNS") != NULL)
      cidmaster->uni_interp=ui_trad_chinese;
   else if (strstrmatch(cidmaster->ordering, "GB") != NULL)
      cidmaster->uni_interp=ui_simp_chinese;
   else if (strstrmatch(cidmaster->ordering, "Korea") != NULL)
      cidmaster->uni_interp=ui_korean;
   sf->uni_interp=cidmaster->uni_interp;
   cidmaster->fontname=copy(sf->fontname);
   cidmaster->fullname=copy(sf->fullname);
   cidmaster->familyname=copy(sf->familyname);
   cidmaster->weight=copy(sf->weight);
   cidmaster->copyright=copy(sf->copyright);
   cidmaster->cidversion=1.0;
   cidmaster->display_antialias=sf->display_antialias;
   cidmaster->display_size=sf->display_size;
   cidmaster->ascent=sf->ascent /*880 */ ;
   cidmaster->descent=sf->descent /*120 */ ;
   cidmaster->changed=true;
   for (fvs=sf->fv; fvs != NULL; fvs=fvs->nextsame)
      fvs->cidmaster=cidmaster;
   cidmaster->fv=sf->fv;
   sf->cidmaster=cidmaster;
   cidmaster->subfontcnt=1;
   cidmaster->subfonts=calloc(2, sizeof(SplineFont *));
   cidmaster->subfonts[0]=sf;
   cidmaster->gpos_lookups=sf->gpos_lookups;
   sf->gpos_lookups=NULL;
   cidmaster->gsub_lookups=sf->gsub_lookups;
   sf->gsub_lookups=NULL;
   cidmaster->horiz_base=sf->horiz_base;
   sf->horiz_base=NULL;
   cidmaster->vert_base=sf->vert_base;
   sf->vert_base=NULL;
   cidmaster->possub=sf->possub;
   sf->possub=NULL;
   cidmaster->kerns=sf->kerns;
   sf->kerns=NULL;
   cidmaster->vkerns=sf->vkerns;
   sf->vkerns=NULL;
   if (sf->private==NULL)
      sf->private=calloc(1, sizeof(struct psdict));
   if (!PSDictHasEntry(sf->private, "lenIV"))
      PSDictChangeEntry(sf->private, "lenIV", "1");	/* It's 4 by default, in CIDs the convention seems to be 1 */
   for (fvs=sf->fv; fvs != NULL; fvs=fvs->nextsame) {
      free(fvs->selected);
      fvs->selected=calloc(fvs->sf->glyphcnt, sizeof(char));
      EncMapFree(fvs->map);
      fvs->map=EncMap1to1(fvs->sf->glyphcnt);
   }
   CIDMasterAsDes(sf);
   return (cidmaster);
}

/* ************************** Reencoding  routines ************************** */

static void BDFOrigFixup(BDFFont *bdf,int orig_cnt,SplineFont *sf) {
   BDFChar **glyphs;

   int i;

   if (bdf->glyphmax >= orig_cnt) {
      if (bdf->glyphcnt < orig_cnt) {
	 for (i=bdf->glyphcnt; i < orig_cnt; ++i)
	    bdf->glyphs[i]=NULL;
	 bdf->glyphcnt=orig_cnt;
      }
      return;
   }

   glyphs=calloc(orig_cnt, sizeof(BDFChar *));
   for (i=0; i < bdf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL) {
	 glyphs[sf->glyphs[i]->orig_pos]=bdf->glyphs[i];
	 if (bdf->glyphs[i] != NULL)	/* Not all glyphs exist in a piecemeal font */
	    bdf->glyphs[i]->orig_pos=sf->glyphs[i]->orig_pos;
      }
   free(bdf->glyphs);
   bdf->glyphs=glyphs;
   bdf->glyphcnt=bdf->glyphmax=orig_cnt;
   bdf->ticked=true;
}

static int _SFForceEncoding(SplineFont *sf,EncMap *old,Encoding *new_enc) {
   int enc_cnt, i;

   BDFFont *bdf;

   FontViewBase *fvs;

   /* Normally we base our encoding process on unicode code points. */
   /*  but encodings like AdobeStandard are more interested in names than */
   /*  code points. It is perfectly possible to have a font properly */
   /*  encoded by code point which is not properly encoded by name */
   /*  (might have f_i where it should have fi). So even if it's got */
   /*  the right encoding, we still may want to force the names */
   if (new_enc->is_custom)
      return (false);		/* Custom, it's whatever's there */

   if (new_enc->is_original) {
      SplineChar **glyphs;

      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL)
	    sf->glyphs[i]->orig_pos=-1;
      for (i=enc_cnt=0; i < old->enccount; ++i)
	 if (old->map[i] != -1 && sf->glyphs[old->map[i]] != NULL &&
	     sf->glyphs[old->map[i]]->orig_pos==-1)
	    sf->glyphs[old->map[i]]->orig_pos=enc_cnt++;
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL)
	    if (sf->glyphs[i]->orig_pos==-1)
	       sf->glyphs[i]->orig_pos=enc_cnt++;
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL) {
	    struct splinecharlist *scl;

	    int layer;

	    RefChar *ref;

	    for (scl=sf->glyphs[i]->dependents; scl != NULL;
		 scl=scl->next) {
	       for (layer=0; layer < scl->sc->layer_cnt; ++layer)
		  for (ref=scl->sc->layers[layer].refs; ref != NULL;
		       ref=ref->next)
		     ref->orig_pos=ref->sc->orig_pos;
	    }
	 }
      for (fvs=sf->fv; fvs != NULL; fvs=fvs->nextsame) {
	 fvs->map->ticked=false;
	 /*if ( fvs->filled!=NULL ) fvs->filled->ticked=false; */
      }
      for (fvs=sf->fv; fvs != NULL; fvs=fvs->nextsame)
	 if (!fvs->map->ticked) {
	    EncMap *map=fvs->map;

	    for (i=0; i < map->enccount; ++i)
	       if (map->map[i] != -1)
		  map->map[i]=sf->glyphs[map->map[i]]->orig_pos;
	    if (enc_cnt > map->backmax) {
	       free(map->backmap);
	       map->backmax=enc_cnt;
	       map->backmap=malloc(enc_cnt * sizeof(int32_t));
	    }
	    memset(map->backmap, -1, enc_cnt * sizeof(int32_t));
	    for (i=0; i < map->enccount; ++i)
	       if (map->map[i] != -1)
		  if (map->backmap[map->map[i]]==-1)
		     map->backmap[map->map[i]]=i;
	    map->ticked=true;
	 }
      if (!old->ticked)
	 ErrorMsg(2,"Unticked encmap\n");
      for (bdf=sf->bitmaps; bdf != NULL; bdf=bdf->next)
	 BDFOrigFixup(bdf, enc_cnt, sf);
      glyphs=calloc(enc_cnt, sizeof(SplineChar *));
      for (i=0; i < sf->glyphcnt; ++i)
	 if (sf->glyphs[i] != NULL)
	    glyphs[sf->glyphs[i]->orig_pos]=sf->glyphs[i];
      free(sf->glyphs);
      sf->glyphs=glyphs;
      sf->glyphcnt=sf->glyphmax=enc_cnt;
      return (true);
   }

   enc_cnt=new_enc->char_cnt;

   if (old->enccount < enc_cnt) {
      if (old->encmax < enc_cnt) {
	 old->map=realloc(old->map, enc_cnt * sizeof(int32_t));
	 old->encmax=enc_cnt;
      }
      memset(old->map + old->enccount, -1,
	     (enc_cnt - old->enccount) * sizeof(int32_t));
      old->enccount=enc_cnt;
   }
   old->enc=new_enc;
   for (i=0; i < old->enccount && i < enc_cnt; ++i)
      if (old->map[i] != -1 && sf->glyphs[old->map[i]] != NULL) {
	 SplineChar dummy;

	 int j=old->map[i];

	 SCBuildDummy(&dummy, sf, old, i);
	 sf->glyphs[j]->unicodeenc=dummy.unicodeenc;
	 free(sf->glyphs[j]->name);
	 sf->glyphs[j]->name=copy(dummy.name);
      }
   /* We just changed the unicode values for most glyphs */
   /* but any references to them will have the old values, and that's bad, so fix 'em up */
   for (i=0; i < sf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL) {
	 struct splinecharlist *scl;

	 int layer;

	 RefChar *ref;

	 for (scl=sf->glyphs[i]->dependents; scl != NULL; scl=scl->next) {
	    for (layer=0; layer < scl->sc->layer_cnt; ++layer)
	       for (ref=scl->sc->layers[layer].refs; ref != NULL;
		    ref=ref->next)
		  ref->unicode_enc=ref->sc->unicodeenc;
	 }
      }
   return (true);
}

int SFForceEncoding(SplineFont *sf, EncMap * old, Encoding * new_enc) {
   if (sf->mm != NULL) {
      MMSet *mm=sf->mm;

      int i;

      for (i=0; i < mm->instance_count; ++i)
	 _SFForceEncoding(mm->instances[i], old, new_enc);
      _SFForceEncoding(mm->normal, old, new_enc);
   } else
      return (_SFForceEncoding(sf, old, new_enc));

   return (true);
}

EncMap *EncMapFromEncoding(SplineFont *sf, Encoding * enc) {
   int i, j, extras, found, base, unmax;

   int32_t *encoded, *unencoded;

   EncMap *map;

   struct altuni *altuni;

   SplineChar *sc;

   if (enc==NULL)
      return (NULL);

   base=enc->char_cnt;
   if (enc->is_original)
      base=0;
   else if (enc->char_cnt <= 256)
      base=256;
   else if (enc->char_cnt <= 0x10000)
      base=0x10000;
   encoded=malloc(base * sizeof(int32_t));
   memset(encoded, -1, base * sizeof(int32_t));
   unencoded=malloc(sf->glyphcnt * sizeof(int32_t));
   unmax=sf->glyphcnt;

   for (i=extras=0; i < sf->glyphcnt; ++i)
      if ((sc=sf->glyphs[i]) != NULL) {
	 found=false;
	 if (enc->psnames != NULL) {
	    for (j=enc->char_cnt - 1; j >= 0; --j) {
	       if (enc->psnames[j] != NULL &&
		   strcmp(enc->psnames[j], sc->name)==0) {
		  found=true;
		  encoded[j]=i;
	       }
	    }
	 }
	 if (!found) {
	    if (sc->unicodeenc != -1 &&
		sc->unicodeenc < unicode4_size &&
		(j=EncFromUni(sc->unicodeenc, enc)) != -1)
	       encoded[j]=i;
	    else {
	       /* I don't think extras can surpass unmax now, but it doesn't */
	       /*  hurt to leave the code (it's from when we encoded duplicates see below) */
	       if (extras >= unmax)
		  unencoded =
		     realloc(unencoded, (unmax += 300) * sizeof(int32_t));
	       unencoded[extras++]=i;
	    }
	    for (altuni=sc->altuni; altuni != NULL; altuni=altuni->next) {
	       if (altuni->unienc != -1 &&
		   altuni->unienc < unicode4_size &&
		   altuni->vs==-1 &&
		   altuni->fid==0 &&
		   (j=EncFromUni(altuni->unienc, enc)) != -1)
		  encoded[j]=i;
	       /* I used to have code here to add these unencoded duplicates */
	       /*  but I don't really see any reason to do so. The main unicode */
	       /*  will occur, and any encoded duplicates so the glyph won't */
	       /*  vanish */
	    }
	 }
      }

   /* Some glyphs have both a pua encoding and an encoding in a non-bmp */
   /*  plane. Big5HK does and the AMS glyphs do */
   if (enc->is_unicodefull && (sf->uni_interp==ui_trad_chinese ||
			       sf->uni_interp==ui_ams)) {
      extern const int cns14pua[], amspua[];

      const int *pua=sf->uni_interp==ui_ams ? amspua : cns14pua;

      for (i=0xe000; i < 0xf8ff; ++i) {
	 if (pua[i - 0xe000] != 0)
	    encoded[pua[i - 0xe000]]=encoded[i];
      }
   }

   if (enc->psnames != NULL) {
      /* Names are more important than unicode code points for some encodings */
      /*  AdobeStandard for instance which won't work if you have a glyph  */
      /*  named "f_i" (must be "fi") even though the code point is correct */
      /* The code above would match f_i where AS requires fi, so force the */
      /*  names to be correct. */
      for (j=0; j < enc->char_cnt; ++j) {
	 if (encoded[j] != -1 && enc->psnames[j] != NULL &&
	     strcmp(sf->glyphs[encoded[j]]->name, enc->psnames[j]) != 0) {
	    free(sf->glyphs[encoded[j]]->name);
	    sf->glyphs[encoded[j]]->name=copy(enc->psnames[j]);
	 }
      }
   }

   map=chunkalloc(sizeof(EncMap));
   map->enccount=map->encmax=base + extras;
   map->map=malloc(map->enccount * sizeof(int32_t));
   memcpy(map->map, encoded, base * sizeof(int32_t));
   memcpy(map->map + base, unencoded, extras * sizeof(int32_t));
   map->backmax=sf->glyphcnt;
   map->backmap=malloc(sf->glyphcnt * sizeof(int32_t));
   memset(map->backmap, -1, sf->glyphcnt * sizeof(int32_t));	/* Just in case there are some unencoded glyphs (duplicates perhaps) */
   for (i=map->enccount - 1; i >= 0; --i)
      if (map->map[i] != -1)
	 map->backmap[map->map[i]]=i;
   map->enc=enc;

   free(encoded);
   free(unencoded);

   return (map);
}

EncMap *CompactEncMap(EncMap *map, SplineFont *sf) {
   int i,inuse,gid;
   int32_t *newmap;

   inuse=0;
   for (i=0;i<map->enccount;i++)
      if (((gid=map->map[i])!=-1) && SCWorthOutputting(sf->glyphs[gid]))
	 inuse++;

   newmap=malloc(inuse*sizeof(int32_t));
   for (i=inuse=0; i < map->enccount; ++i)
      if ((gid=map->map[i]) != -1 && SCWorthOutputting(sf->glyphs[gid]))
	 newmap[inuse++]=gid;
   free(map->map);
   map->map=newmap;
   map->enccount=inuse;
   map->encmax=inuse;
   map->enc=&custom;
   memset(map->backmap,-1,sf->glyphcnt*sizeof(int32_t));
   for (i=inuse-1;i>=0;i--)
      if ((gid=map->map[i])!=-1)
	 map->backmap[gid]=i;
   return (map);
}

static void BCProtectUndoes(Undoes *undo,BDFChar *bc) {
   BDFRefChar *brhead, *brprev=NULL, *brnext;

   for (; undo != NULL; undo=undo->next) {
      switch (undo->undotype) {
	case ut_bitmap:
	   for (brhead=undo->u.bmpstate.refs; brhead != NULL;
		brhead=brnext) {
	      brnext=brhead->next;
	      if (brhead->bdfc==bc) {
		 BCPasteInto(&undo->u.bmpstate, bc, brhead->xoff,
			     brhead->yoff, false, false);
		 if (brprev==NULL)
		    undo->u.bmpstate.refs=brnext;
		 else
		    brprev->next=brnext;
		 free(brhead);
	      } else
		 brprev=brhead;
	   }
	   break;
	case ut_multiple:
	   BCProtectUndoes(undo->u.multiple.mult, bc);
	   break;
	case ut_composit:
	   BCProtectUndoes(undo->u.composit.bitmaps, bc);
	   break;
      }
   }
}

void SFRemoveGlyph(SplineFont *sf, SplineChar * sc, int *flags) {
   struct splinecharlist *dep, *dnext;
   struct bdfcharlist *bdep, *bdnext;
   RefChar *rf, *refs, *rnext;
   BDFRefChar *bref, *brnext, *brprev;
   KernPair *kp, *kprev;
   int i;
   BDFFont *bdf;
   BDFChar *bfc, *dbc;
   int layer;

   if (sc==NULL)
      return;

   /* Turn any references to this glyph into inline copies of it */
   for (dep=sc->dependents; dep != NULL; dep=dnext) {
      SplineChar *dsc=dep->sc;

      dnext=dep->next;
      /* May be more than one reference to us, colon has two refs to period */
      /*  but only one dlist entry */
      for (layer=0; layer < dsc->layer_cnt; ++layer) {
	 for (rf=dsc->layers[layer].refs; rf != NULL; rf=rnext) {
	    rnext=rf->next;
	    if (rf->sc==sc)
	       SCRefToSplines(dsc, rf, layer);
	 }
      }
   }

   for (layer=0; layer < sc->layer_cnt; ++layer) {
      for (refs=sc->layers[layer].refs; refs != NULL; refs=rnext) {
	 rnext=refs->next;
	 SCRemoveDependent(sc, refs, layer);
      }
   }

   /* Remove any kerning pairs that look at this character */
   for (i=0; i < sf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL) {
	 for (kprev=NULL, kp=sf->glyphs[i]->kerns; kp != NULL;
	      kprev=kp, kp=kp->next) {
	    if (kp->sc==sc) {
	       if (kprev==NULL)
		  sf->glyphs[i]->kerns=kp->next;
	       else
		  kprev->next=kp->next;
	       kp->next=NULL;
	       KernPairsFree(kp);
	       break;
	    }
	 }
      }

   sf->glyphs[sc->orig_pos]=NULL;

   for (bdf=sf->bitmaps; bdf != NULL; bdf=bdf->next) {
      if (sc->orig_pos < bdf->glyphcnt
	  && (bfc=bdf->glyphs[sc->orig_pos]) != NULL) {
	 /* Turn any references to this glyph into inline copies of it */
	 for (bdep=bfc->dependents; bdep != NULL; bdep=bdnext) {
	    dbc=bdep->bc;
	    bdnext=bdep->next;
	    brprev=NULL;
	    /* May be more than one reference to us, colon has two refs to period */
	    /*  but only one dlist entry */
	    for (bref=dbc->refs; bref != NULL; bref=brnext) {
	       brnext=bref->next;
	       if (bref->bdfc==bfc) {
		  BCPasteInto(dbc, bref->bdfc, bref->xoff, bref->yoff, false,
			      false);
		  if (brprev==NULL)
		     dbc->refs=brnext;
		  else
		     brprev->next=brnext;
		  free(bref);
	       } else
		  brprev=bref;
	    }
	 }
	 /* Suppose we have deleted a reference from a composite glyph and than
	  * going to remove the previously referenced glyph from the font. The
	  * void reference still remains in the undoes stack, so that executing Undo/Redo
	  * on the first glyph may lead to unpredictable effects. It is also 
	  * impossible to detect such problematic undoes checking just our
	  * going-to-be-deleted glyph's dependents, because the composite character
	  * no longer contains the problematic reference and so is not listed
	  * in the dependents. Thus the only solution seems to be checking
	  * every single glyph in the font.
	  */
	 for (i=0; i < bdf->glyphcnt; i++)
	    if ((dbc=bdf->glyphs[i]) != NULL) {
	       BCProtectUndoes(dbc->undoes, bfc);
	       BCProtectUndoes(dbc->redoes, bfc);
	    }
	 for (bref=bfc->refs; bref != NULL; bref=brnext) {
	    brnext=bref->next;
	    BCRemoveDependent(bfc, bref);
	 }
	 bdf->glyphs[sc->orig_pos]=NULL;
	 BDFCharFree(bfc);
      }
   }

   SplineCharFree(sc);
   GlyphHashFree(sf);
}

static int MapAddEncodingSlot(EncMap *map,int gid) {
   int enc;

   if (map->enccount >= map->encmax)
      map->map=realloc(map->map, (map->encmax += 10) * sizeof(int32_t));
   enc=map->enccount++;
   map->map[enc]=gid;
   map->backmap[gid]=enc;
   return (enc);
}

static void FVAddEncodingSlot(FontViewBase *fv,int gid) {
   EncMap *map=fv->map;

   int enc;

   enc=MapAddEncodingSlot(map, gid);

   fv->selected=realloc(fv->selected, map->enccount);
   fv->selected[enc]=0;
}

void SFAddEncodingSlot(SplineFont *sf, int gid) {
   FontViewBase *fv;

   for (fv=sf->fv; fv != NULL; fv=fv->nextsame)
      FVAddEncodingSlot(fv, gid);
}

static int MapAddEnc(SplineFont *sf,SplineChar *sc,EncMap *basemap,
		     EncMap * map, int baseenc, int gid, FontViewBase * fv) {
   int any=false, enc;

   if (gid >= map->backmax) {
      map->backmap =
	 realloc(map->backmap, (map->backmax += 10) * sizeof(int32_t));
      memset(map->backmap + map->backmax - 10, -1, 10 * sizeof(int32_t));
   }
   if (map->enc->psnames != NULL) {
      /* Check for multiple encodings */
      for (enc=map->enc->char_cnt - 1; enc >= 0; --enc) {
	 if (map->enc->psnames[enc] != NULL
	     && strcmp(sc->name, map->enc->psnames[enc])==0) {
	    if (!any) {
	       map->backmap[gid]=enc;
	       any=true;
	    }
	    map->map[enc]=gid;
	 }
      }
   } else {
      enc=SFFindSlot(sf, map, sc->unicodeenc, sc->name);
      if (enc != -1) {
	 map->map[enc]=gid;
	 map->backmap[gid]=enc;
	 any=true;
      }
   }
   if (basemap != NULL && map->enc==basemap->enc && baseenc != -1) {
      if (baseenc >= map->enccount) {
	 if (fv && map==fv->map)
	    FVAddEncodingSlot(fv, gid);
	 else
	    MapAddEncodingSlot(map, gid);
      } else {
	 map->map[baseenc]=gid;
	 if (map->backmap[gid]==-1)
	    map->backmap[gid]=baseenc;
      }
      any=true;
   }
   return (any);
}

void SFAddGlyphAndEncode(SplineFont *sf, SplineChar * sc, EncMap * basemap,
			 int baseenc) {
   int gid, mapfound=false;

   FontViewBase *fv;

   BDFFont *bdf;

   if (sf->cidmaster==NULL) {
      if (sf->glyphcnt + 1 >= sf->glyphmax)
	 sf->glyphs =
	    realloc(sf->glyphs, (sf->glyphmax += 10) * sizeof(SplineChar *));
      gid=sf->glyphcnt++;
      for (bdf=sf->bitmaps; bdf != NULL; bdf=bdf->next) {
	 if (sf->glyphcnt + 1 >= bdf->glyphmax)
	    bdf->glyphs =
	       realloc(bdf->glyphs,
		       (bdf->glyphmax=sf->glyphmax) * sizeof(BDFChar *));
	 if (sf->glyphcnt > bdf->glyphcnt) {
	    memset(bdf->glyphs + bdf->glyphcnt, 0,
		   (sf->glyphcnt - bdf->glyphcnt) * sizeof(BDFChar *));
	    bdf->glyphcnt=sf->glyphcnt;
	 }
      }
      for (fv=sf->fv; fv != NULL; fv=fv->nextsame) {
	 EncMap *map=fv->map;

	 if (gid >= map->backmax)
	    map->backmap =
	       realloc(map->backmap,
		       (map->backmax=gid + 10) * sizeof(int32_t));
	 map->backmap[gid]=-1;
      }
   } else {
      gid=baseenc;
      if (baseenc + 1 >= sf->glyphmax)
	 sf->glyphs =
	    realloc(sf->glyphs,
		    (sf->glyphmax=baseenc + 10) * sizeof(SplineChar *));
      if (baseenc >= sf->glyphcnt) {
	 memset(sf->glyphs + sf->glyphcnt, 0,
		(baseenc + 1 - sf->glyphcnt) * sizeof(SplineChar *));
	 sf->glyphcnt=baseenc + 1;
	 for (bdf=sf->cidmaster->bitmaps; bdf != NULL; bdf=bdf->next) {
	    if (baseenc + 1 >= bdf->glyphmax)
	       bdf->glyphs =
		  realloc(bdf->glyphs,
			  (bdf->glyphmax=baseenc + 10) * sizeof(BDFChar *));
	    if (baseenc + 1 > bdf->glyphcnt) {
	       memset(bdf->glyphs + bdf->glyphcnt, 0,
		      (baseenc + 1 - bdf->glyphcnt) * sizeof(BDFChar *));
	       bdf->glyphcnt=baseenc + 1;
	    }
	 }
	 for (fv=sf->fv; fv != NULL; fv=fv->nextsame)
	    if (fv->sf==sf) {
	       EncMap *map=fv->map;

	       if (gid >= map->backmax)
		  map->backmap =
		     realloc(map->backmap,
			     (map->backmax=gid + 10) * sizeof(int32_t));
	       map->backmap[gid]=-1;
	    }
      }
   }
   sf->glyphs[gid]=NULL;
   for (fv=sf->fv; fv != NULL; fv=fv->nextsame) {
      EncMap *map=fv->map;

      if (!MapAddEnc(sf, sc, basemap, map, baseenc, gid, fv))
	 FVAddEncodingSlot(fv, gid);
      if (map==basemap)
	 mapfound=true;
      if (fv->normal != NULL) {
	 if (!MapAddEnc(sf, sc, basemap, fv->normal, baseenc, gid, fv))
	    MapAddEncodingSlot(fv->normal, gid);
      }
   }
   if (!mapfound && basemap != NULL)
      MapAddEnc(sf, sc, basemap, basemap, baseenc, gid, fv);
   sf->glyphs[gid]=sc;
   sc->orig_pos=gid;
   sc->parent=sf;
   SFHashGlyph(sf, sc);
}

static SplineChar *SplineCharMatch(SplineFont *parent,SplineChar *sc) {
   SplineChar *scnew=SFSplineCharCreate(parent);

   scnew->parent=parent;
   scnew->orig_pos=sc->orig_pos;
   scnew->name=copy(sc->name);
   scnew->unicodeenc=sc->unicodeenc;
   scnew->width=sc->width;
   scnew->vwidth=sc->vwidth;
   scnew->widthset=true;
   return (scnew);
}

void SFMatchGlyphs(SplineFont *sf, SplineFont *target, int addempties) {
   /* reorder sf so that its glyphs array is the same as that in target */
   int i, j, cnt, cnt2;

   SplineChar **glyphs;

   BDFFont *bdf;

   for (i=0; i < sf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL)
	 sf->glyphs[i]->ticked=false;
   if ((cnt=target->glyphcnt) < sf->glyphcnt)
      cnt=sf->glyphcnt;
   glyphs=calloc(cnt, sizeof(SplineChar *));
   for (i=0; i < target->glyphcnt; ++i)
      if (target->glyphs[i] != NULL) {
	 SplineChar *sc =
	    SFGetChar(sf, target->glyphs[i]->unicodeenc,
		      target->glyphs[i]->name);
	 if (sc==NULL && addempties)
	    sc=SplineCharMatch(sf, target->glyphs[i]);
	 if (sc != NULL) {
	    glyphs[i]=sc;
	    sc->ticked=true;
	 }
      }
   for (i=cnt2=0; i < sf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL && !sf->glyphs[i]->ticked)
	 ++cnt2;
   if (target->glyphcnt + cnt2 > cnt) {
      glyphs =
	 realloc(glyphs, (target->glyphcnt + cnt2) * sizeof(SplineChar *));
      memset(glyphs + cnt, 0,
	     (target->glyphcnt + cnt2 - cnt) * sizeof(SplineChar *));
      cnt=target->glyphcnt + cnt2;
   }
   j=target->glyphcnt;
   for (i=0; i < sf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL && !sf->glyphs[i]->ticked)
	 glyphs[j++]=sf->glyphs[i];
   free(sf->glyphs);
   sf->glyphs=glyphs;
   sf->glyphcnt=sf->glyphmax=cnt;
   for (i=0; i < sf->glyphcnt; ++i)
      if (sf->glyphs[i] != NULL)
	 sf->glyphs[i]->orig_pos=i;
   for (bdf=sf->bitmaps; bdf != NULL; bdf=bdf->next) {
      BDFChar **glyphs;

      glyphs=calloc(sf->glyphcnt, sizeof(BDFChar *));
      for (i=0; i < bdf->glyphcnt; ++i)
	 if (bdf->glyphs[i] != NULL)
	    glyphs[bdf->glyphs[i]->sc->orig_pos]=bdf->glyphs[i];
      free(bdf->glyphs);
      bdf->glyphs=glyphs;
      bdf->glyphcnt=bdf->glyphmax=sf->glyphcnt;
   }
}

void MMMatchGlyphs(MMSet * mm) {
   /* reorder all instances so that they have the same orig_pos */
   int i, j, index, lasthole;

   SplineFont *sf, *base=NULL;

   SplineChar *sc, *scnew, *sc2;

   for (i=0; i < mm->instance_count; ++i)
      if (mm->instances[i] != NULL) {
	 base=mm->instances[i];
	 break;
      }
   if (base==NULL)
      return;

   /* First build up an ordering that uses all glyphs found in any of the */
   /*  sub-fonts, "base" will be the start of it. We will add glyphs to */
   /*  "base" as needed */
   lasthole=-1;
   for (i=0; i < mm->instance_count; ++i)
      if ((sf=mm->instances[i]) != NULL && sf != NULL) {
	 for (j=0; j < sf->glyphcnt; ++j)
	    if ((sc=sf->glyphs[j]) != NULL) {
	       if (j < base->glyphcnt && base->glyphs[j] != NULL &&
		   base->glyphs[j]->unicodeenc==sc->unicodeenc &&
		   strcmp(base->glyphs[j]->name, sc->name)==0)
		  continue;	/* It's good, and in the same place */
	       else if ((sc2=SFGetChar(base, sc->unicodeenc, sc->name)) !=
			NULL && sc2->unicodeenc==sc->unicodeenc
			&& strcmp(sc2->name, sc->name)==0)
		  continue;	/* Well, it's in there somewhere */
	       else {
		  /* We need to add it */
		  if (j < base->glyphcnt && base->glyphs[j]==NULL)
		     index=j;
		  else {
		     for (++lasthole;
			  lasthole < base->glyphcnt
			  && base->glyphs[lasthole] != NULL; ++lasthole);
		     index=lasthole;
		     if (lasthole >= base->glyphmax)
			base->glyphs =
			   realloc(base->glyphs,
				   (base->glyphmax +=
				    20) * sizeof(SplineChar *));
		     if (lasthole >= base->glyphcnt)
			base->glyphcnt=lasthole + 1;
		  }
		  base->glyphs[index]=scnew=SplineCharMatch(base, sc);
		  scnew->orig_pos=index;
	       }
	    }
      }

   /* Now force all other instances to match */
   for (i=0; i < mm->instance_count; ++i)
      if ((sf=mm->instances[i]) != NULL && sf != base)
	 SFMatchGlyphs(sf, base, true);
   if (mm->normal != NULL)
      SFMatchGlyphs(mm->normal, base, true);
}

int32_t UniFromEnc(int enc, Encoding * encname) {
   char from[20];

   unichar_t to[20];

   ICONV_CONST char *fpt;

   char *tpt;

   size_t fromlen, tolen;

   if (encname->is_custom || encname->is_original)
      return (-1);
   if (enc >= encname->char_cnt)
      return (-1);
   if (encname->is_unicodebmp || encname->is_unicodefull)
      return (enc);
   if (encname->unicode != NULL)
      return (encname->unicode[enc]);
   else if (encname->tounicode) {
      /* To my surprise, on RH9, doing a reset on conversion of CP1258->UCS2 */
      /* causes subsequent calls to return garbage */
      if (encname->iso_2022_escape_len) {
	 tolen=sizeof(to);
	 fromlen=0;
	 iconv(encname->tounicode, NULL, &fromlen, NULL, &tolen);	/* Reset state */
      }
      fpt=from;
      tpt=(char *) to;
      tolen=sizeof(to);
      if (encname->has_1byte && enc < 256) {
	 *(char *) fpt=enc;
	 fromlen=1;
      } else if (encname->has_2byte) {
	 if (encname->iso_2022_escape_len)
	    strncpy(from, encname->iso_2022_escape,
		    encname->iso_2022_escape_len);
	 fromlen=encname->iso_2022_escape_len;
	 from[fromlen++]=enc >> 8;
	 from[fromlen++]=enc & 0xff;
      }
      if (iconv(encname->tounicode, &fpt, &fromlen, &tpt, &tolen) ==
	  (size_t) - 1)
	 return (-1);
      if (tpt - (char *) to==0) {
	 /* This strange call appears to be what we need to make CP1258->UCS2 */
	 /*  work.  It's supposed to reset the state and give us the shift */
	 /*  out. As there is no state, and no shift out I have no idea why */
	 /*  this works, but it does. */
	 if (iconv(encname->tounicode, NULL, &fromlen, &tpt, &tolen) ==
	     (size_t) - 1)
	    return (-1);
      }
      if (tpt - (char *) to==sizeof(unichar_t)) {
#if defined(__MINGW32__)
	 {
	    printf("UniFromEnc(original ret) enc:%d initial result:%ld\n",
		   enc, to[0]);
	    // For whatever reason the mingw32 build seems to always produce
	    // a result in byte swapped order.
	    unichar_t t=to[0];

	    printf("UniFromEnc(ret1) %ld\n", t);
	    unichar_t low16=t & 0xFFFF;

	    unichar_t high16=t >> 16;

	    t=(low16 << 16) | high16;
	    printf("UniFromEnc(ret2) enc:%d final result:%ld\n", enc, t);
	    to[0]=t;
	 }
	 printf("UniFromEnc(final ret) %ld\n", to[0]);
#endif
	 return (to[0]);
      }
   } else if (encname->tounicode_func != NULL) {
      return ((encname->tounicode_func) (enc));
   }
   return (-1);
}

int32_t EncFromUni(int32_t uni, Encoding * enc) {
   unichar_t from[20];

   unsigned char to[20];

   ICONV_CONST char *fpt;

   char *tpt;

   size_t fromlen, tolen;

   int i;

   if (enc->is_custom || enc->is_original || enc->is_compact || uni==-1)
      return (-1);
   if (enc->is_unicodebmp || enc->is_unicodefull)
      return (uni < enc->char_cnt ? uni : -1);

   if (enc->unicode != NULL) {
      for (i=0; i < enc->char_cnt; ++i) {
	 if (enc->unicode[i]==uni)
	    return (i);
      }
      return (-1);
   } else if (enc->fromunicode != NULL) {
      /* I don't see how there can be any state to reset in this direction */
      /*  So I don't reset it */
      from[0]=uni;
      fromlen=sizeof(unichar_t);
      fpt=(char *) from;
      tpt=(char *) to;
      tolen=sizeof(to);
      iconv(enc->fromunicode, NULL, NULL, NULL, NULL);	/* reset shift in/out, etc. */
      if (iconv(enc->fromunicode, &fpt, &fromlen, &tpt, &tolen) ==
	  (size_t) - 1)
	 return (-1);
      if (tpt - (char *) to==1)
	 return (to[0]);
      if (enc->iso_2022_escape_len != 0) {
	 if (tpt - (char *) to==enc->iso_2022_escape_len + 2 &&
	     strncmp((char *) to, enc->iso_2022_escape,
		     enc->iso_2022_escape_len)==0)
	    return ((to[enc->iso_2022_escape_len] << 8) |
		    to[enc->iso_2022_escape_len + 1]);
      } else {
	 if (tpt - (char *) to==sizeof(unichar_t))
	    return ((to[0] << 8) | to[1]);
      }
   } else if (enc->fromunicode_func != NULL) {
      return ((enc->fromunicode_func) (uni));
   }
   return (-1);
}

int32_t EncFromName(const char *name, enum uni_interp interp,
		  Encoding * encname) {
   int i;

   if (encname->psnames != NULL) {
      for (i=0; i < encname->char_cnt; ++i)
	 if (encname->psnames[i] != NULL
	     && strcmp(name, encname->psnames[i])==0)
	    return (i);
   }
   i=UniFromName(name, interp, encname);
   if (i==-1 && strlen(name)==4) {
      /* MS says use this kind of name, Adobe says use the one above */
      char *end;

      i=strtol(name, &end, 16);
      if (i < 0 || i > 0xffff || *end != '\0')
	 return (-1);
   }
   return (EncFromUni(i, encname));
}

void SFExpandGlyphCount(SplineFont *sf, int newcnt) {
   int old=sf->glyphcnt;

   FontViewBase *fv;

   if (old >= newcnt)
      return;
   if (sf->glyphmax < newcnt) {
      sf->glyphs=realloc(sf->glyphs, newcnt * sizeof(SplineChar *));
      sf->glyphmax=newcnt;
   }
   memset(sf->glyphs + sf->glyphcnt, 0,
	  (newcnt - sf->glyphcnt) * sizeof(SplineChar *));
   sf->glyphcnt=newcnt;

   for (fv=sf->fv; fv != NULL; fv=fv->nextsame) {
      if (fv->sf==sf) {	/* Beware of cid keyed fonts which might look at a different subfont */
	 if (fv->normal != NULL)
	    continue;		/* If compacted then we haven't added any glyphs so haven't changed anything */
	 /* Don't display any of these guys, so not mapped. */
	 /*  No change to selection, or to map->map, but change to backmap */
	 if (newcnt > fv->map->backmax)
	    fv->map->backmap =
	       realloc(fv->map->backmap,
		       (fv->map->backmax=newcnt + 5) * sizeof(int32_t));
	 memset(fv->map->backmap + old, -1, (newcnt - old) * sizeof(int32_t));
      }
   }
}
