/*
 * User-defined matching predicates for IDSgrep
 * Copyright (C) 2013  Matthew Skala
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
#include <stdlib.h>
#include <string.h>

#include "idsgrep.h"

/**********************************************************************/

#ifdef HAVE___ATTRIBUTE__
#define PACKED __attribute__ ((packed))
#else
#define PACKED /* */
#endif

/* Do you swap your byte at us, sir? */

/* No, sir, I do not swap my byte at you, sir, but I swap my byte, sir. */

#define BSWAP16(x) ((((x)>>8)&0xFF)|(((x)<<8)&0xFF00))
#ifdef GCC_BUILTIN_BSWAP
#define BSWAP32(x) __builtin_bswap32(x)
#else
#define BSWAP32(x) ((((x)>>24)&0xFF)|(((x)>>8)&0xFF00)|\
		    (((x)<<8)&0xFF0000)|(((x)<<24)&0xFF000000))
#endif

/* note that these structs cover only as much of the format as we need! */

typedef struct _TTC_HEADER {
   uint32_t ttc_tag PACKED;
   uint32_t version PACKED;
   uint32_t num_fonts PACKED;
   uint32_t offset_table0 PACKED;
} TTC_HEADER;

typedef struct _OFFSET_TABLE {
   uint32_t sfnt_version PACKED;
   uint16_t num_tables PACKED;
   uint16_t search_range PACKED;
   uint16_t entry_selector PACKED;
   uint16_t range_shift PACKED;
} OFFSET_TABLE;

typedef struct _TABLE_RECORD {
   uint32_t tag PACKED;
   uint32_t check_sum PACKED;
   uint32_t offset PACKED;
   uint32_t length PACKED;
} TABLE_RECORD;

typedef struct _CMAP_HEADER {
   uint16_t version PACKED;
   uint16_t num_tables PACKED;
} CMAP_HEADER;

typedef struct _ENCODING_RECORD {
   uint16_t platform_id PACKED;
   uint16_t encoding_id PACKED;
   uint32_t offset PACKED;
} ENCODING_RECORD;

static int num_userpreds=0;

/**********************************************************************/

void add_userpred_character(int i) {
   char ebuf[4];
   int clen;
   HASHED_STRING *hs;
   
   clen=construct_utf8(i,ebuf);
   hs=new_string(clen,ebuf);
   hs->userpreds|=(UINTMAX_C(1)<<(num_userpreds-1));
}

/**********************************************************************/

typedef struct _FORMAT0_TABLE {
   uint16_t length PACKED;
   uint16_t language PACKED;
   uint8_t glyph_ids[256];
} FORMAT0_TABLE;

void scan_format0_table(FILE *fontfile,int swap_votes,
			char *fn,int table_number) {
   FORMAT0_TABLE format0_table;
   int i;
   
   if (fread(&format0_table,sizeof(format0_table),1,fontfile)!=1) {
      fprintf(stderr,"error reading %s (format 0 cmap subtable %d)\n",
	      fn,table_number);
      return;
   }
   for (i=0;i<256;i++)
     if (format0_table.glyph_ids[i]>0)
       add_userpred_character(i);
}

/**********************************************************************/

typedef struct _FORMAT2_SUBHEADER {
   uint16_t first_code PACKED;
   uint16_t entry_count PACKED;
   int16_t id_delta PACKED; /* note this one is signed */
   uint16_t id_range_offset;
} FORMAT2_SUBHEADER;

typedef struct _FORMAT2_TABLE {
   uint16_t format PACKED;
   uint16_t length PACKED;
   uint16_t language PACKED;
   uint16_t sub_header_keys[256] PACKED;
   FORMAT2_SUBHEADER sub_headers[] PACKED;
} FORMAT2_TABLE;

void scan_format2_table(FILE *fontfile,int swap_votes,
			char *fn,int table_number) {
   FORMAT2_TABLE *format2_table;
   int i,j;
   uint16_t length;
   FORMAT2_SUBHEADER *sub_header;
   
   /* read the table */
   if (fread(&length,sizeof(length),1,fontfile)!=1) {
      fprintf(stderr,"error reading %s (format 2 cmap subtable %d length)\n",
	      fn,table_number);
      return;
   }
   if (swap_votes>0)
     length=BSWAP16(length);
   format2_table=malloc(length);
   format2_table->format=2;
   format2_table->length=length;
   if (fread(((uint8_t *)&format2_table)+4,length-4,1,fontfile)!=1) {
      fprintf(stderr,"error reading %s (format 2 cmap subtable %d)\n",
	      fn,table_number);
      free(format2_table);
      return;
   }
   
   /* do swapping up front - works because entire table is 16-bit entries */
   for (i=2;i<(length/2);i++)
     ((uint16_t *)format2_table)[i]=BSWAP16(((uint16_t *)format2_table)[i]);
   
   /* scan through high bytes */
   for (i=0;i<256;i++)
     if (format2_table->sub_header_keys[i]!=0) {
	if (((uint8_t *)&(format2_table->sub_headers))
	    -((uint8_t *)format2_table)
	    +format2_table->sub_header_keys[i]
	    <format2_table->length) {

	   /* scan through low bytes */
	   sub_header=(FORMAT2_SUBHEADER *)
	     (((uint8_t *)&(format2_table->sub_headers))
		 +format2_table->sub_header_keys[i]);
	   for (j=0;j<sub_header->entry_count;j++)
	     if (((uint8_t *)&(sub_header->id_range_offset))
		 -((uint8_t *)format2_table)
		 +sub_header->id_range_offset
		 +j*sizeof(uint16_t)
		 <format2_table->length) {
		
		/* I'm sorry about this. */
		if (*((uint16_t *)((uint8_t *)&(sub_header->id_range_offset)
				   +sub_header->id_range_offset
				   +j*sizeof(uint16_t)))!=0)
		  add_userpred_character(i*256+j);

	     } else {
		fprintf(stderr,"glyph index pointer out of range in %s "
			"(format 2 cmap subtable %d)\n",fn,table_number);
		free(format2_table);
		return;
	     }
	   
	} else {
	   fprintf(stderr,"subheader pointer out of range in %s "
		   "(format 2 cmap subtable %d)\n",fn,table_number);
	   free(format2_table);
	   return;
	}
     }
   
   free(format2_table);
}

/**********************************************************************/

typedef struct _FORMAT4_TABLE {
   uint16_t format PACKED;
   uint16_t length PACKED;
   uint16_t language PACKED;
   uint16_t seg_count_x2 PACKED;
   uint16_t search_range PACKED;
   uint16_t entry_selector PACKED;
   uint16_t range_shift PACKED;
   uint16_t end_count[] PACKED;
   /* there are several more variable-length arrays, but we have to
    * access them via pointer arithmetic */
} FORMAT4_TABLE;

void scan_format4_table(FILE *fontfile,int swap_votes,
			char *fn,int table_number) {
   FORMAT4_TABLE *format4_table;
   int i,j,k;
   uint16_t length;
   uint16_t *start_count;
   int16_t *id_delta;
   uint16_t *id_range_offset;
   
   /* read the table */
   if (fread(&length,sizeof(length),1,fontfile)!=1) {
      fprintf(stderr,"error reading %s (format 4 cmap subtable %d length)\n",
	      fn,table_number);
      return;
   }
   if (swap_votes>0)
     length=BSWAP16(length);
   format4_table=malloc(length);
   format4_table->format=4;
   format4_table->length=length;
   if (fread(((uint8_t *)format4_table)+4,length-4,1,fontfile)!=1) {
      fprintf(stderr,"error reading %s (format 4 cmap subtable %d)\n",
	      fn,table_number);
      free(format4_table);
      return;
   }
   
   /* do swapping up front - works because entire table is 16-bit entries */
   for (i=2;i<(length/2);i++)
     ((uint16_t *)format4_table)[i]=BSWAP16(((uint16_t *)format4_table)[i]);
   
   /* set up the pointers */
   start_count=&(format4_table->end_count[0])
     +(format4_table->seg_count_x2/2)+1;
   id_delta=(int16_t *)(start_count+(format4_table->seg_count_x2/2));
   id_range_offset=((uint16_t *)id_delta)+(format4_table->seg_count_x2/2);
   if (((uint8_t *)&(id_range_offset[format4_table->seg_count_x2/2]))
       -((uint8_t *)format4_table)
       >format4_table->length) {
      fprintf(stderr,"subtable too small in %s "
	      "(format 4 cmap subtable %d)\n",fn,table_number);
      free(format4_table);
      return;
   }
   if ((format4_table->end_count[format4_table->seg_count_x2/2-1]!=0xFFFF) ||
       (format4_table->end_count[format4_table->seg_count_x2/2]!=0)) {
      fprintf(stderr,"endCount terminator missing in %s "
	      "(format 4 cmap subtable %d)\n",fn,table_number);
      free(format4_table);
      return;
   }

   /* scan through character codes */
   j=0;
   for (i=0;i<65536;i++) {
      while (format4_table->end_count[j]<i) j++;
      if (start_count[j]>i)
	i=start_count[j];
      if (id_range_offset[j]==0)
	add_userpred_character(i);
      else {

	 /* check that pointer is in range, and see where it points */
	 k=((uint8_t *)&(id_range_offset[j]))-((uint8_t *)format4_table)
	   +id_range_offset[j]+(i-id_delta[j])*2;
	 if (k<format4_table->length) {
	    if (*((uint16_t *)(((uint8_t *)format4_table)+k))!=0)
	      add_userpred_character(i);
	    
	 } else {
	    fprintf(stderr,"glyph index pointer out of range in %s "
		    "(format 4 cmap subtable %d)\n",fn,table_number);
	    free(format4_table);
	    return;
	 }
      }
   }
   
   free(format4_table);
}

/**********************************************************************/

#define CHECKSUM_BUFFER 2048

uint32_t compute_opentype_checksum(FILE *fontfile,uint32_t length,
				   int swap_votes) {
   int i,j,to_read=CHECKSUM_BUFFER;
   uint32_t acc=0;
   uint32_t buff[CHECKSUM_BUFFER];
   
   length=(length+sizeof(uint32_t)-1)/sizeof(uint32_t);
   for (i=0;i<length;) {
      if (i+to_read>length)
	to_read=length-i;
      if (fread(buff,sizeof(uint32_t),to_read,fontfile)!=to_read)
	return acc; /* we'll catch the error in the caller */
      if (swap_votes>0) {
	 for (j=0;j<to_read;j++)
	   acc+=BSWAP32(buff[j]);
      } else {
	 for (j=0;j<to_read;j++)
	   acc+=buff[j];
      }
      i+=to_read;
   }
   return acc;
}

void font_file_userpred(char *fn) {
   FILE *fontfile;
   int swap_votes=0;
   TTC_HEADER ttc_header;
   OFFSET_TABLE offset_table;
   TABLE_RECORD table_record;
   int table_number;
   CMAP_HEADER cmap_header;
   ENCODING_RECORD encoding_record;
   uint16_t subtable_format;
   
   /* allocate a user predicate number - do first so files that fail will
    * still consume numbers and not screw up the indexing of others. */
   if (num_userpreds>=8*sizeof(uintmax_t)) {
      fprintf(stderr,"too many user predicates, skipping %s\n",fn);
      return;
   }
   num_userpreds++;
   
   /* open font file */
   fontfile=fopen(fn,"rb");
   if (fontfile==NULL) {
      fprintf(stderr,"can't open %s for reading\n",fn);
      return;
   }
   
   /* look for "TrueType Collection header" (not really expected) */
   if (fread(&ttc_header,sizeof(ttc_header),1,fontfile)!=1) {
      fprintf(stderr,"error reading %s (TTC header)\n",fn);
      return;
   }
   if ((ttc_header.ttc_tag==0x74746366 /* 'ttcf' */) ||
       (ttc_header.ttc_tag==0x66637474 /* 'fctt' */)) {
      if (ttc_header.ttc_tag==0x74746366)
	swap_votes--;
      else
	swap_votes++;
      if ((ttc_header.version&0xFFFF0000)==0)
	swap_votes++;
      if (swap_votes>0)
	ttc_header.offset_table0=BSWAP32(ttc_header.offset_table0);
   } else
     ttc_header.offset_table0=0;
   
   /* look for "offset table" */
   if (fseek(fontfile,ttc_header.offset_table0,SEEK_SET)!=0) {
      fprintf(stderr,"error seeking on %s (offset table)\n",fn);
      return;
   }
   if (fread(&offset_table,sizeof(offset_table),1,fontfile)!=1) {
      fprintf(stderr,"error reading %s (offset table)\n",fn);
      return;
   }
   /* "I know this for a fact 'cuz I used to get the shit beat out of me
    *  by great big square-headed cowboys called Otto on a fairly regular
    *  basis.  Yeah, they were ALL named Otto, which I, uh, I'm not sure
    *  what's up with that." - Steve Earle */
   if ((offset_table.sfnt_version==0x4F54544F /* 'OTTO' */) ||
       (offset_table.sfnt_version==0x00010000 /* 1.0 */) ||
       (offset_table.sfnt_version==0x00000100 /* byte-swapped 1.0 */)) {
      if (offset_table.sfnt_version==0x00010000)
	swap_votes--;
      else if (offset_table.sfnt_version==0x00000100)
	swap_votes++;
   } else {
      fprintf(stderr,"can't find sfnt wrapper in %s\n",fn);
      return;
   }

   /* Unfortunately, in case of 'OTTO' and not a TrueType collection,
    * at this point we might still not have seen anything from which we
    * can infer whether we need byte swapping.  So we might not be able
    * to trust num_tables, and can't necessarily use it as a termination
    * condition. */
   table_number=0;
   while (1) {
      table_number++;
      if ((swap_votes!=0) &&
	  (table_number>((swap_votes>0)?
			 BSWAP16(offset_table.num_tables):
			 offset_table.num_tables))) {
	 fprintf(stderr,"can't find cmap table in %s\n",fn);
	 return;
      }
      
      /* look for "table record" */
      if (fread(&table_record,sizeof(table_record),1,fontfile)!=1) {
	 fprintf(stderr,"error reading %s (table record %d)\n",
		 fn,table_number-1);
	 return;
      }
      
      /* required tables, PfEd, and space padding, are byte-swap clues */
      if ((table_record.tag==0x636D6170 /* 'cmap' */) ||
	  (table_record.tag==0x68656164 /* 'head' */) ||
	  (table_record.tag==0x68686561 /* 'hhea' */) ||
	  (table_record.tag==0x686D7478 /* 'hmtx' */) ||
	  (table_record.tag==0x6D617870 /* 'maxp' */) ||
	  (table_record.tag==0x6E616D65 /* 'name' */) ||
	  (table_record.tag==0x4F532F32 /* 'OS/2' */) ||
	  (table_record.tag==0x706F7374 /* 'post' */) ||
	  (table_record.tag==0x50664564 /* 'PfEd' */) ||
	  ((table_record.tag&0xFF)==0x20 /* padding space */))
	swap_votes--;
      if ((table_record.tag==0x70616D63 /* 'pamc' */) ||
	  (table_record.tag==0x64616568 /* 'daeh' */) ||
	  (table_record.tag==0x61656868 /* 'aehh' */) ||
	  (table_record.tag==0x78746D68 /* 'xtmh' */) ||
	  (table_record.tag==0x7078616D /* 'pxam' */) ||
	  (table_record.tag==0x656D616E /* 'eman' */) ||
	  (table_record.tag==0x322F534F /* '2/SO' */) ||
	  (table_record.tag==0x74736F70 /* 'tsop' */) ||
	  (table_record.tag==0x64456650 /* 'dEfP' */) ||
	  ((table_record.tag&0xFF000000)==0x20000000 /* ecaps gniddap */))
	swap_votes++;

      if ((table_record.tag==0x636D6170 /* 'cmap' */) ||
	  (table_record.tag==0x70616D63 /* 'pamc' */)) {
	 if (swap_votes>0) {
	    table_record.check_sum=BSWAP32(table_record.check_sum);
	    table_record.offset=BSWAP32(table_record.offset);
	    table_record.length=BSWAP32(table_record.length);
	 }
	 break;
      }
   }
   
   /* check the checksum */
   if (fseek(fontfile,table_record.offset,SEEK_SET)!=0) {
      fprintf(stderr,"error seeking on %s (before cmap checksum)\n",fn);
      return;
   }
   if (compute_opentype_checksum(fontfile,table_record.length,swap_votes)
       !=table_record.check_sum) {
      fprintf(stderr,"cmap table has bad checksum in %s\n",fn);
      return;
   }
   
   /* look for cmap header */
   if (fseek(fontfile,table_record.offset,SEEK_SET)!=0) {
      fprintf(stderr,"error seeking on %s (cmap header)\n",fn);
      return;
   }
   if (fread(&cmap_header,sizeof(cmap_header),1,fontfile)!=1) {
      fprintf(stderr,"error reading %s (cmap header)\n",fn);
      return;
   }
   if (swap_votes>0)
     cmap_header.num_tables=BSWAP16(cmap_header.num_tables);
   
   /* look at all subtables */
   for (table_number=0;table_number<cmap_header.num_tables;table_number++) {
      
      /* look for encoding record */
      if (fread(&encoding_record,sizeof(encoding_record),1,fontfile)!=1) {
	 fprintf(stderr,"error reading %s (cmap encoding record %d)\n",
		 fn,table_number);
	 return;
      }
      if (swap_votes>0) {
	 encoding_record.platform_id=BSWAP16(encoding_record.platform_id);
	 encoding_record.encoding_id=BSWAP16(encoding_record.encoding_id);
	 encoding_record.offset=BSWAP32(encoding_record.offset);
      }

      /* We understand Unicode/all, Windows/UTF-16, Windows/UTF-32,
       * and ISO/all.  Notably, no Macintosh-specific encodings; we will
       * fail on a pure old-school Mac font.  Windows/UTF-32 is most
       * likely to be useful in practice.  Many fine details of these
       * encodings are ignored; they are all close enough to compatible with
       * each other for our purposes.  We use the union of all codes we
       * find in subtables whose encodings we understand. */
      if ((encoding_record.platform_id==0       /* Unicode platform */) || 
	  (encoding_record.platform_id==2       /* ISO platform */) ||
	  ((encoding_record.platform_id==3      /* Windows platform */)
	   && ((encoding_record.encoding_id==1  /* UTF-16 */) ||
	       (encoding_record.encoding_id==10 /* UTF-32 */)))) {
	 
	 /* go to the subtable */
	 if (fseek(fontfile,table_record.offset+encoding_record.offset,
		   SEEK_SET)!=0) {
	    fprintf(stderr,"error seeking on %s (for cmap subtable %d)\n",
		    fn,table_number);
	    return;
	 }
	 
	 /* process subtable format */
	 if (fread(&subtable_format,sizeof(subtable_format),1,fontfile)!=1) {
	    fprintf(stderr,"error reading %s (cmap subtable %d format)\n",
		    fn,table_number);
	    return;
	 }
	 if (swap_votes>0)
	   subtable_format=BSWAP16(subtable_format);
	 switch (subtable_format) {
	  case 0: /* Mac byte encoding */
	    scan_format0_table(fontfile,swap_votes,fn,table_number);
	    break;

	  case 2: /* high byte through table */
	    scan_format2_table(fontfile,swap_votes,fn,table_number);
	    break;
	    
	  case 4: /* segment mapping to delta */
	    scan_format4_table(fontfile,swap_votes,fn,table_number);
	    break;
	    
	  case 6: /* 16-bit trimmed array */
	    break;
	    
	  case 8: /* mixed 16- and 32-bit */
	    break;
	    
	  case 10: /* 32-bit trimmed array */
	    break;
	    
	  case 12: /* Microsoft segmented */
	    break;
	    
	  case 13: /* many-to-one */
	    break;
	    
	  default:
	    /* Subtable type 14, Unicode Variation Sequences, is
	     * deliberately ignored because main characters in it are only
	     * relevant after already found in another subtable and the
	     * details of variation sequences are consciously excluded
	     * from the EIDS syntax definition. */

	    /* unknown format is not an error here, we expect all manner
	     * of freakiness */
	    break;
	 }
	 
	 /* return to just after the encoding record */
	 if (fseek(fontfile,
		   table_record.offset+sizeof(cmap_header)+
		   (table_number+1)*sizeof(encoding_record),
		   SEEK_SET)!=0) {
	    fprintf(stderr,"error seeking on %s "
		    "(returning from cmap subtable %d)\n",
		    fn,table_number);
	    return;
	 }
      }
   }
   
   /* seen all subtables - close the file */
   fclose(fontfile);
}

/**********************************************************************/

NODE *user_match_fn(NODE *ms) {
   int i;
   
   if ((ms->nc_needle->arity!=1) ||
       (ms->nc_haystack->head==NULL)) {
      ms->match_result=MR_FALSE;
      return ms;
   }
   if (ms->nc_needle->child[0]->head!=NULL)
     i=atoi(ms->nc_needle->child[0]->head->data);
   else
     i=1;
   if (i==0)
     i=1;
   ms->match_result=((i<=num_userpreds) && (i>0) &&
		     ((ms->nc_haystack->head->userpreds&(1<<(i-1)))!=0))?
     MR_TRUE:MR_FALSE;
   return ms;
}
