/* $Id: woff.c 4524 2015-12-20 19:28:13Z mskala $ */
/* Copyright (C) 2010-2012  George Williams
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

/* Support for woff files */
/* Which are defined here: http://people.mozilla.com/~jkew/woff/woff-2009-09-16.html */
/* Basically sfnts with compressed tables and some more metadata */

#include "fontanvil.h"
#include <math.h>
#include <ctype.h>

#ifdef _NO_LIBPNG

SplineFont *_SFReadWOFF(AFILE *woff, int flags, enum openflags openflags,
			char *filename, struct fontdict *fd) {
   ErrorMsg(2,"WOFF not supported:  this requires a version of FontAnvil "
              "built with both libpng and zlib.\n");
   return (NULL);
}

int _WriteWOFFFont(AFILE *woff, SplineFont *sf, enum fontformat format,
		   int32_t * bsizes, enum bitmapformat bf, int flags,
		   EncMap * enc, int layer) {
   ErrorMsg(2,"WOFF not supported:  this requires a version of FontAnvil "
              "built with both libpng and zlib.\n");
   return (1);
}

int WriteWOFFFont(char *fontname, SplineFont *sf, enum fontformat format,
		  int32_t * bsizes, enum bitmapformat bf, int flags,
		  EncMap * enc, int layer) {
   ErrorMsg(2,"WOFF not supported:  this requires a version of FontAnvil "
              "built with both libpng and zlib.\n");
   return (1);
}

#else /* ! _NO_LIBPNG */

#   include <zlib.h>

static void copydata(AFILE *to,int off_to,AFILE *from,int off_from,
		     int len) {
   int ch, i;

   afseek(to, off_to, SEEK_SET);
   afseek(from, off_from, SEEK_SET);
   for (i=0; i < len; ++i) {
      ch=agetc(from);
      aputc(ch, to);
   }
}

#   define CHUNK	(128*1024)
/* Copied with few mods from the zlib usage examples */

static int decompressdata(AFILE *to,int off_to,AFILE *from,int off_from,
			  int len, int uncomplen) {
   /* Return whether an error occurred */
   char in[CHUNK];
   char out[CHUNK];
   z_stream strm;
   int ret;
   int amount;

   afseek(to, off_to, SEEK_SET);
   afseek(from, off_from, SEEK_SET);
   memset(&strm, 0, sizeof(strm));
   ret=inflateInit(&strm);
   if (ret != Z_OK)
      return (true);

   do {
      if (len <= 0) {
	 (void) inflateEnd(&strm);
	 return (true);
      }
      amount=len;
      if (amount > CHUNK)
	 amount=CHUNK;
      strm.avail_in=afread(in, 1, amount, from);
      len -= strm.avail_in;
      if (aferror(from)) {
	 (void) inflateEnd(&strm);
	 return (true);
      }
      if (strm.avail_in==0)
	 break;
      strm.next_in=in;
      do {
	 strm.avail_out=CHUNK;
	 strm.next_out=out;
	 ret=inflate(&strm, Z_NO_FLUSH);
	 if (ret != Z_OK && ret != Z_STREAM_END) {
	    (void) inflateEnd(&strm);
	    return (true);
	 }
	 amount=CHUNK - strm.avail_out;
	 if (afwrite(out, 1, amount, to) != amount || aferror(to)) {
	    (void) inflateEnd(&strm);
	    return (true);
	 }
      } while (strm.avail_out==0);
   } while (ret != Z_STREAM_END);
   (void) inflateEnd(&strm);
   if (uncomplen != strm.total_out) {
      ErrorMsg(2,"Decompressed length did not match expected length for table\n");
      return (true);
   }

   return (false);
}

static int compressOrNot(AFILE *to,int off_to,AFILE *from,int off_from,
			 int len, int forcecompress) {
   char in[CHUNK];
   char out[CHUNK];
   z_stream strm;
   int ret, err=0;
   int amount;
   AFILE *tmp;
   int uncompLen=len;

   /* Empty table, nothing to do */
   if (len==0)
      return (0);

   afseek(from, off_from, SEEK_SET);
   memset(&strm, 0, sizeof(strm));
   ret=deflateInit(&strm, Z_DEFAULT_COMPRESSION);
   if (ret != Z_OK) {
      ErrorMsg(2,"Compression initialization failed.\n");
      return (0);
   }
   tmp=atmpfile();

   do {
      if (len <= 0) {
	 (void) deflateEnd(&strm);
	 break;
      }
      amount=len;
      if (amount > CHUNK)
	 amount=CHUNK;
      strm.avail_in=afread(in, 1, amount, from);
      len -= strm.avail_in;
      if (aferror(from)) {
	 (void) deflateEnd(&strm);
	 ErrorMsg(2,"IO error.\n");
	 break;
      }
      if (strm.avail_in==0)
	 break;
      strm.next_in=in;
      do {
	 strm.avail_out=CHUNK;
	 strm.next_out=out;
	 ret=deflate(&strm, len==0 ? Z_FINISH : Z_NO_FLUSH);
	 if (ret==Z_STREAM_ERROR) {
	    (void) deflateEnd(&strm);
	    ErrorMsg(2,"Compression failed somehow.\n");
	    err=1;
	    break;
	 }
	 amount=CHUNK - strm.avail_out;
	 if (afwrite(out, 1, amount, tmp) != amount || aferror(tmp)) {
	    (void) deflateEnd(&strm);
	    ErrorMsg(2,"IO Error.\n");
	    err=1;
	    break;
	 }
      } while (strm.avail_out==0);
      if (err)
	 break;
   } while (ret != Z_STREAM_END);
   (void) deflateEnd(&strm);

   if (strm.total_out >= uncompLen) {
      /* Didn't actually make the data smaller, so store uncompressed */
      afclose(tmp);
      copydata(to, off_to, from, off_from, uncompLen);
      return (uncompLen);
   } else {
      copydata(to, off_to, tmp, 0, strm.total_out);
      afclose(tmp);
      return (strm.total_out);
   }
}

SplineFont *_SFReadWOFF(AFILE *woff, int flags, enum openflags openflags,
			char *filename, struct fontdict * fd) {
   int flavour;
   int iscff;
   int len, len_stated;
   int num_tabs;
   int major, minor;
   int metaOffset, metaLenCompressed, metaLenUncompressed;
   int privOffset, privLength;
   int i, j, err;
   int tag, offset, compLen, uncompLen, checksum;
   AFILE *sfnt;
   int here, next, tab_start;
   int head_pos=-1;
   SplineFont *sf;

   afseek(woff, 0, SEEK_END);
   len=aftell(woff);
   afseek(woff,0,SEEK_SET);
   if (aget_int32_be(woff) != CHR('w', 'O', 'F', 'F')) {
      ErrorMsg(2,"Bad signature in WOFF\n");
      return (NULL);
   }
   flavour=aget_int32_be(woff);
   iscff=(flavour==CHR('O', 'T', 'T', 'O'));
   len_stated=aget_int32_be(woff);
   if (len != len_stated) {
      ErrorMsg(2,"File length as specified in the WOFF header does not match the actual file length.\n");
      return (NULL);
   }

   num_tabs=aget_uint16_be(woff);
   if (aget_uint16_be(woff) != 0) {
      ErrorMsg(2,"Bad WOFF header, a field which must be 0 is not.\n");
      return (NULL);
   }

   /* total_uncompressed_sfnt_size=*/
   aget_int32_be(woff);
   major=aget_uint16_be(woff);
   minor=aget_uint16_be(woff);
   metaOffset=aget_int32_be(woff);
   metaLenCompressed=aget_int32_be(woff);
   metaLenUncompressed=aget_int32_be(woff);
   privOffset=aget_int32_be(woff);
   privLength=aget_int32_be(woff);

   sfnt=atmpfile();
   if (sfnt==NULL) {
      ErrorMsg(2,"Could not open temporary file.\n");
      return (NULL);
   }

   putlong(sfnt, flavour);
   aput_int16_be_checked(num_tabs,sfnt);
   for (i=1, j=0; 2 * i <= num_tabs; i <<= 1, ++j);
   aput_int16_be_checked(i * 16,sfnt);
   aput_int16_be_checked(j,sfnt);
   aput_int16_be_checked((num_tabs - i) * 16,sfnt);

   /* dummy space for table pointers */
   tab_start=aftell(sfnt);
   for (i=0; i < 4 * num_tabs; ++i)
      putlong(sfnt, 0);

   for (i=0; i < num_tabs; ++i) {
      tag=aget_int32_be(woff);
      offset=aget_int32_be(woff);
      compLen=aget_int32_be(woff);
      uncompLen=aget_int32_be(woff);
      checksum=aget_int32_be(woff);
      if (compLen > uncompLen || offset + compLen > len) {
	 afclose(sfnt);
	 if (compLen > uncompLen)
	    ErrorMsg(2,"Invalid compressed table length for '%c%c%c%c'.\n",
		     tag >> 24, tag >> 16, tag >> 8, tag);
	 else
	    ErrorMsg(2,"Table length stretches beyond end of file for '%c%c%c%c'.\n",
		     tag >> 24, tag >> 16, tag >> 8, tag);
	 return (NULL);
      }
      here=aftell(woff);
      next=aftell(sfnt);
      afseek(sfnt, tab_start, SEEK_SET);
      putlong(sfnt, tag);
      putlong(sfnt, checksum);
      putlong(sfnt, next);
      putlong(sfnt, uncompLen);
      if (tag==CHR('h', 'e', 'a', 'd'))
	 head_pos=next;
      tab_start=aftell(sfnt);
      afseek(sfnt, next, SEEK_SET);
      if (compLen==uncompLen) {
	 /* Not compressed, copy verbatim */
	 copydata(sfnt, next, woff, offset, compLen);
      } else {
	 err=decompressdata(sfnt, next, woff, offset, compLen, uncompLen);
	 if (err) {
	    ErrorMsg(2,"Problem decompressing '%c%c%c%c' table.\n",
		     tag >> 24, tag >> 16, tag >> 8, tag);
	    afclose(sfnt);
	    return (NULL);
	 }
      }
      if ((aftell(sfnt) & 3) != 0) {
	 /* Pad to a 4 byte boundary */
	 if (aftell(sfnt) & 1)
	    aputc('\0', sfnt);
	 if (aftell(sfnt) & 2)
	    aput_int16_be_checked(0,sfnt);
      }
      afseek(woff, here, SEEK_SET);
   }
   /* I assumed at first that the check sum would just be right */
   /*  but I've reordered the tables (probably) so I've got a different */
   /*  set of offsets and I must figure it out for myself */
   /* Usually, I don't care. But if fontlint is on, then do it right */
   if ((openflags & of_fontlint) && head_pos != -1) {
      int checksum;

      afseek(sfnt, head_pos + 8, SEEK_SET);
      putlong(sfnt, 0);		/* Clear what was there */
      checksum=filechecksum(sfnt);	/* Recalc */
      checksum=0xb1b0afba - checksum;
      afseek(sfnt, head_pos + 8, SEEK_SET);
      putlong(sfnt, checksum);
   }
   afseek(sfnt,0,SEEK_SET);
   sf=_SFReadTTF(sfnt, flags, openflags, filename, fd);
   afclose(sfnt);

   if (sf != NULL) {
      sf->woffMajor=major;
      sf->woffMinor=minor;
   }

   if (sf != NULL && metaOffset != 0) {
      char *temp=malloc(metaLenCompressed + 1);
      uLongf len=metaLenUncompressed;

      afseek(woff, metaOffset, SEEK_SET);
      afread(temp, 1, metaLenCompressed, woff);
      sf->woffMetadata=malloc(metaLenUncompressed + 1);
      sf->woffMetadata[metaLenUncompressed]='\0';
      uncompress(sf->woffMetadata, &len, temp, metaLenCompressed);
      sf->woffMetadata[len]='\0';
      free(temp);
   }

   return (sf);
}

int _WriteWOFFFont(AFILE *woff, SplineFont *sf, enum fontformat format,
		   int32_t * bsizes, enum bitmapformat bf, int flags,
		   EncMap * enc, int layer) {
   int ret;
   AFILE *sfnt;
   int major=sf->woffMajor, minor=sf->woffMinor;
   int flavour, num_tabs;
   int filelen, len;
   int i;
   int compLen, uncompLen, newoffset;
   int tag, checksum, offset;
   int tab_start, here;

   if (major==woffUnset) {
      struct ttflangname *useng;

      major=1;
      minor=0;
      for (useng=sf->names; useng != NULL; useng=useng->next)
	 if (useng->lang==0x409)
	    break;
      if (useng != NULL && useng->names[ttf_version] != NULL &&
	  sscanf(useng->names[ttf_version], "Version %d.%d", &major,
		 &minor) >= 1) {
	 /* All done */
      } else if (sf->subfontcnt != 0) {
	 major=floor(sf->cidversion);
	 minor=floor(1000. * (sf->cidversion - major));
      } else if (sf->version != NULL) {
	 char *pt=sf->version;
	 char *end;

	 while (*pt && !isdigit(*pt) && *pt != '.')
	    ++pt;
	 if (*pt) {
	    major=strtol(pt, &end, 10);
	    if (*end=='.')
	       minor=strtol(end + 1, NULL, 10);
	 }
      }
   }

   format=sf->subfonts != NULL ? ff_otfcid :
      sf->layers[layer].order2 ? ff_ttf : ff_otf;
   sfnt=atmpfile();
   ret=_WriteTTFFont(sfnt, sf, format, bsizes, bf, flags, enc, layer);
   if (!ret) {
      afclose(sfnt);
      return (ret);
   }

   afseek(sfnt, 0, SEEK_END);
   filelen=aftell(sfnt);
   afseek(sfnt,0,SEEK_SET);

   flavour=aget_int32_be(sfnt);
   /* The woff standard says we should accept all flavours of sfnt, so can't */
   /*  test flavour to make sure we've got a valid sfnt */
   /* But we can test the rest of the header for consistancy */
   num_tabs=aget_uint16_be(sfnt);
   (void) aget_uint16_be(sfnt);
   (void) aget_uint16_be(sfnt);
   (void) aget_uint16_be(sfnt);

   afseek(woff,0,SEEK_SET);
   putlong(woff, CHR('w', 'O', 'F', 'F'));
   putlong(woff, flavour);
   putlong(woff, 0);		/* Off: 8. total length of file, fill in later */
   aput_int16_be_checked(num_tabs,woff);
   aput_int16_be_checked(0,woff);		/* Must be zero */
   putlong(woff, filelen);
   aput_int16_be_checked(major,woff);	/* Major and minor version numbers of font */
   aput_int16_be_checked(minor,woff);
   putlong(woff, 0);		/* Off: 24. Offset to metadata table */
   putlong(woff, 0);		/* Off: 28. Length (compressed) of metadata */
   putlong(woff, 0);		/* Off: 32. Length (uncompressed) */
   putlong(woff, 0);		/* Off: 36. Offset to private data */
   putlong(woff, 0);		/* Off: 40. Length of private data */

   tab_start=aftell(woff);
   for (i=0; i < 5 * num_tabs; ++i)
      putlong(woff, 0);

   for (i=0; i < num_tabs; ++i) {
      tag=aget_int32_be(sfnt);
      checksum=aget_int32_be(sfnt);
      offset=aget_int32_be(sfnt);
      uncompLen=aget_int32_be(sfnt);
      here=aftell(sfnt);
      newoffset=aftell(woff);
      compLen =
	 compressOrNot(woff, newoffset, sfnt, offset, uncompLen, false);
      if ((aftell(woff) & 3) != 0) {
	 /* Pad to a 4 byte boundary */
	 if (aftell(woff) & 1)
	    aputc('\0', woff);
	 if (aftell(woff) & 2)
	    aput_int16_be_checked(0,woff);
      }
      afseek(sfnt, here, SEEK_SET);
      afseek(woff, tab_start, SEEK_SET);
      putlong(woff, tag);
      putlong(woff, newoffset);
      putlong(woff, compLen);
      putlong(woff, uncompLen);
      putlong(woff, checksum);
      tab_start=aftell(woff);
      afseek(woff, 0, SEEK_END);
   }
   afclose(sfnt);

   if (sf->woffMetadata != NULL) {
      int uncomplen=strlen(sf->woffMetadata);
      uLongf complen=2 * uncomplen;
      char *temp=malloc(complen + 1);

      newoffset=aftell(woff);
      compress(temp, &complen, sf->woffMetadata, uncomplen);
      afwrite(temp, 1, complen, woff);
      free(temp);
      if ((aftell(woff) & 3) != 0) {
	 /* Pad to a 4 byte boundary */
	 if (aftell(woff) & 1)
	    aputc('\0', woff);
	 if (aftell(woff) & 2)
	    aput_int16_be_checked(0,woff);
      }
      afseek(woff, 24, SEEK_SET);
      putlong(woff, newoffset);
      putlong(woff, complen);
      putlong(woff, uncomplen);
      afseek(woff, 0, SEEK_END);
   }

   afseek(woff, 0, SEEK_END);
   len=aftell(woff);
   afseek(woff, 8, SEEK_SET);
   putlong(woff, len);
   return (true);		/* No errors */
}

int WriteWOFFFont(char *fontname, SplineFont *sf, enum fontformat format,
		  int32_t * bsizes, enum bitmapformat bf, int flags,
		  EncMap * enc, int layer) {
   AFILE *woff;
   int ret;

   if ((woff=afopen(fontname, "wb+"))==NULL)
      return (0);
   ret=_WriteWOFFFont(woff, sf, format, bsizes, bf, flags, enc, layer);
   if (afclose(woff)==-1)
      return (0);
   return (ret);
}

#endif /* ! _NO_LIBPNG */
