/*
 * Internally-generated Unicode dictionary for IDSgrep
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

typedef struct _UNICODE_BLOCK_DATA {
   int low,high;
   char *name;
} UNICODE_BLOCK_DATA;

UNICODE_BLOCK_DATA unicode_blocks[]={
   {0x0000,0x007F,"Basic Latin"},
   {0x0080,0x00FF,"Latin-1 Supplement"},
   {0x0100,0x017F,"Latin Extended-A"},
   {0x0180,0x024F,"Latin Extended-B"},
   {0x0250,0x02AF,"IPA Extensions"},
   {0x02B0,0x02FF,"Spacing Modifier Letters"},
   {0x0300,0x036F,"Combining Diacritical Marks"},
   {0x0370,0x03FF,"Greek and Coptic"},
   {0x0400,0x04FF,"Cyrillic"},
   {0x0500,0x052F,"Cyrillic Supplement"},
   {0x0530,0x058F,"Armenian"},
   {0x0590,0x05FF,"Hebrew"},
   {0x0600,0x06FF,"Arabic"},
   {0x0700,0x074F,"Syriac"},
   {0x0750,0x077F,"Arabic Supplement"},
   {0x0780,0x07BF,"Thaana"},
   {0x07C0,0x07FF,"NKo"},
   {0x0800,0x083F,"Samaritan"},
   {0x0840,0x085F,"Mandaic"},
   {0x08A0,0x08FF,"Arabic Extended-A"},
   {0x0900,0x097F,"Devanagari"},
   {0x0980,0x09FF,"Bengali"},
   {0x0A00,0x0A7F,"Gurmukhi"},
   {0x0A80,0x0AFF,"Gujarati"},
   {0x0B00,0x0B7F,"Oriya"},
   {0x0B80,0x0BFF,"Tamil"},
   {0x0C00,0x0C7F,"Telugu"},
   {0x0C80,0x0CFF,"Kannada"},
   {0x0D00,0x0D7F,"Malayalam"},
   {0x0D80,0x0DFF,"Sinhala"},
   {0x0E00,0x0E7F,"Thai"},
   {0x0E80,0x0EFF,"Lao"},
   {0x0F00,0x0FFF,"Tibetan"},
   {0x1000,0x109F,"Myanmar"},
   {0x10A0,0x10FF,"Georgian"},
   {0x1100,0x11FF,"Hangul Jamo"},
   {0x1200,0x137F,"Ethiopic"},
   {0x1380,0x139F,"Ethiopic Supplement"},
   {0x13A0,0x13FF,"Cherokee"},
   {0x1400,0x167F,"Unified Canadian Aboriginal Syllabics"},
   {0x1680,0x169F,"Ogham"},
   {0x16A0,0x16FF,"Runic"},
   {0x1700,0x171F,"Tagalog"},
   {0x1720,0x173F,"Hanunoo"},
   {0x1740,0x175F,"Buhid"},
   {0x1760,0x177F,"Tagbanwa"},
   {0x1780,0x17FF,"Khmer"},
   {0x1800,0x18AF,"Mongolian"},
   {0x18B0,0x18FF,"Unified Canadian Aboriginal Syllabics Extended"},
   {0x1900,0x194F,"Limbu"},
   {0x1950,0x197F,"Tai Le"},
   {0x1980,0x19DF,"New Tai Lue"},
   {0x19E0,0x19FF,"Khmer Symbols"},
   {0x1A00,0x1A1F,"Buginese"},
   {0x1A20,0x1AAF,"Tai Tham"},
   {0x1B00,0x1B7F,"Balinese"},
   {0x1B80,0x1BBF,"Sundanese"},
   {0x1BC0,0x1BFF,"Batak"},
   {0x1C00,0x1C4F,"Lepcha"},
   {0x1C50,0x1C7F,"Ol Chiki"},
   {0x1CC0,0x1CCF,"Sundanese Supplement"},
   {0x1CD0,0x1CFF,"Vedic Extensions"},
   {0x1D00,0x1D7F,"Phonetic Extensions"},
   {0x1D80,0x1DBF,"Phonetic Extensions Supplement"},
   {0x1DC0,0x1DFF,"Combining Diacritical Marks Supplement"},
   {0x1E00,0x1EFF,"Latin Extended Additional"},
   {0x1F00,0x1FFF,"Greek Extended"},
   {0x2000,0x206F,"General Punctuation"},
   {0x2070,0x209F,"Superscripts and Subscripts"},
   {0x20A0,0x20CF,"Currency Symbols"},
   {0x20D0,0x20FF,"Combining Diacritical Marks for Symbols"},
   {0x2100,0x214F,"Letterlike Symbols"},
   {0x2150,0x218F,"Number Forms"},
   {0x2190,0x21FF,"Arrows"},
   {0x2200,0x22FF,"Mathematical Operators"},
   {0x2300,0x23FF,"Miscellaneous Technical"},
   {0x2400,0x243F,"Control Pictures"},
   {0x2440,0x245F,"Optical Character Recognition"},
   {0x2460,0x24FF,"Enclosed Alphanumerics"},
   {0x2500,0x257F,"Box Drawing"},
   {0x2580,0x259F,"Block Elements"},
   {0x25A0,0x25FF,"Geometric Shapes"},
   {0x2600,0x26FF,"Miscellaneous Symbols"},
   {0x2700,0x27BF,"Dingbats"},
   {0x27C0,0x27EF,"Miscellaneous Mathematical Symbols-A"},
   {0x27F0,0x27FF,"Supplemental Arrows-A"},
   {0x2800,0x28FF,"Braille Patterns"},
   {0x2900,0x297F,"Supplemental Arrows-B"},
   {0x2980,0x29FF,"Miscellaneous Mathematical Symbols-B"},
   {0x2A00,0x2AFF,"Supplemental Mathematical Operators"},
   {0x2B00,0x2BFF,"Miscellaneous Symbols and Arrows"},
   {0x2C00,0x2C5F,"Glagolitic"},
   {0x2C60,0x2C7F,"Latin Extended-C"},
   {0x2C80,0x2CFF,"Coptic"},
   {0x2D00,0x2D2F,"Georgian Supplement"},
   {0x2D30,0x2D7F,"Tifinagh"},
   {0x2D80,0x2DDF,"Ethiopic Extended"},
   {0x2DE0,0x2DFF,"Cyrillic Extended-A"},
   {0x2E00,0x2E7F,"Supplemental Punctuation"},
   {0x2E80,0x2EFF,"CJK Radicals Supplement"},
   {0x2F00,0x2FDF,"Kangxi Radicals"},
   {0x2FF0,0x2FFF,"Ideographic Description Characters"},
   {0x3000,0x303F,"CJK Symbols and Punctuation"},
   {0x3040,0x309F,"Hiragana"},
   {0x30A0,0x30FF,"Katakana"},
   {0x3100,0x312F,"Bopomofo"},
   {0x3130,0x318F,"Hangul Compatibility Jamo"},
   {0x3190,0x319F,"Kanbun"},
   {0x31A0,0x31BF,"Bopomofo Extended"},
   {0x31C0,0x31EF,"CJK Strokes"},
   {0x31F0,0x31FF,"Katakana Phonetic Extensions"},
   {0x3200,0x32FF,"Enclosed CJK Letters and Months"},
   {0x3300,0x33FF,"CJK Compatibility"},
   {0x3400,0x4DBF,"CJK Unified Ideographs Extension A"},
   {0x4DC0,0x4DFF,"Yijing Hexagram Symbols"},
   {0x4E00,0x9FFF,"CJK Unified Ideographs"},
   {0xA000,0xA48F,"Yi Syllables"},
   {0xA490,0xA4CF,"Yi Radicals"},
   {0xA4D0,0xA4FF,"Lisu"},
   {0xA500,0xA63F,"Vai"},
   {0xA640,0xA69F,"Cyrillic Extended-B"},
   {0xA6A0,0xA6FF,"Bamum"},
   {0xA700,0xA71F,"Modifier Tone Letters"},
   {0xA720,0xA7FF,"Latin Extended-D"},
   {0xA800,0xA82F,"Syloti Nagri"},
   {0xA830,0xA83F,"Common Indic Number Forms"},
   {0xA840,0xA87F,"Phags-pa"},
   {0xA880,0xA8DF,"Saurashtra"},
   {0xA8E0,0xA8FF,"Devanagari Extended"},
   {0xA900,0xA92F,"Kayah Li"},
   {0xA930,0xA95F,"Rejang"},
   {0xA960,0xA97F,"Hangul Jamo Extended-A"},
   {0xA980,0xA9DF,"Javanese"},
   {0xAA00,0xAA5F,"Cham"},
   {0xAA60,0xAA7F,"Myanmar Extended-A"},
   {0xAA80,0xAADF,"Tai Viet"},
   {0xAAE0,0xAAFF,"Meetei Mayek Extensions"},
   {0xAB00,0xAB2F,"Ethiopic Extended-A"},
   {0xABC0,0xABFF,"Meetei Mayek"},
   {0xAC00,0xD7AF,"Hangul Syllables"},
   {0xD7B0,0xD7FF,"Hangul Jamo Extended-B"},
   /* surrogates NOT included in this table because we skip them */
   {0xE000,0xF8FF,"Private Use Area"},
   {0xF900,0xFAFF,"CJK Compatibility Ideographs"},
   {0xFB00,0xFB4F,"Alphabetic Presentation Forms"},
   {0xFB50,0xFDFF,"Arabic Presentation Forms-A"},
   {0xFE00,0xFE0F,"Variation Selectors"},
   {0xFE10,0xFE1F,"Vertical Forms"},
   {0xFE20,0xFE2F,"Combining Half Marks"},
   {0xFE30,0xFE4F,"CJK Compatibility Forms"},
   {0xFE50,0xFE6F,"Small Form Variants"},
   {0xFE70,0xFEFF,"Arabic Presentation Forms-B"},
   {0xFF00,0xFFEF,"Halfwidth and Fullwidth Forms"},
   {0xFFF0,0xFFFF,"Specials"},
   {0x10000,0x1007F,"Linear B Syllabary"},
   {0x10080,0x100FF,"Linear B Ideograms"},
   {0x10100,0x1013F,"Aegean Numbers"},
   {0x10140,0x1018F,"Ancient Greek Numbers"},
   {0x10190,0x101CF,"Ancient Symbols"},
   {0x101D0,0x101FF,"Phaistos Disc"},
   {0x10280,0x1029F,"Lycian"},
   {0x102A0,0x102DF,"Carian"},
   {0x10300,0x1032F,"Old Italic"},
   {0x10330,0x1034F,"Gothic"},
   {0x10380,0x1039F,"Ugaritic"},
   {0x103A0,0x103DF,"Old Persian"},
   {0x10400,0x1044F,"Deseret"},
   {0x10450,0x1047F,"Shavian"},
   {0x10480,0x104AF,"Osmanya"},
   {0x10800,0x1083F,"Cypriot Syllabary"},
   {0x10840,0x1085F,"Imperial Aramaic"},
   {0x10900,0x1091F,"Phoenician"},
   {0x10920,0x1093F,"Lydian"},
   {0x10980,0x1099F,"Meroitic Hieroglyphs"},
   {0x109A0,0x109FF,"Meroitic Cursive"},
   {0x10A00,0x10A5F,"Kharoshthi"},
   {0x10A60,0x10A7F,"Old South Arabian"},
   {0x10B00,0x10B3F,"Avestan"},
   {0x10B40,0x10B5F,"Inscriptional Parthian"},
   {0x10B60,0x10B7F,"Inscriptional Pahlavi"},
   {0x10C00,0x10C4F,"Old Turkic"},
   {0x10E60,0x10E7F,"Rumi Numeral Symbols"},
   {0x11000,0x1107F,"Brahmi"},
   {0x11080,0x110CF,"Kaithi"},
   {0x110D0,0x110FF,"Sora Sompeng"},
   {0x11100,0x1114F,"Chakma"},
   {0x11180,0x111DF,"Sharada"},
   {0x11680,0x116CF,"Takri"},
   {0x12000,0x123FF,"Cuneiform"},
   {0x12400,0x1247F,"Cuneiform Numbers and Punctuation"},
   {0x13000,0x1342F,"Egyptian Hieroglyphs"},
   {0x16800,0x16A3F,"Bamum Supplement"},
   {0x16F00,0x16F9F,"Miao"},
   {0x1B000,0x1B0FF,"Kana Supplement"},
   {0x1D000,0x1D0FF,"Byzantine Musical Symbols"},
   {0x1D100,0x1D1FF,"Musical Symbols"},
   {0x1D200,0x1D24F,"Ancient Greek Musical Notation"},
   {0x1D300,0x1D35F,"Tai Xuan Jing Symbols"},
   {0x1D360,0x1D37F,"Counting Rod Numerals"},
   {0x1D400,0x1D7FF,"Mathematical Alphanumeric Symbols"},
   {0x1EE00,0x1EEFF,"Arabic Mathematical Alphabetic Symbols"},
   {0x1F000,0x1F02F,"Mahjong Tiles"},
   {0x1F030,0x1F09F,"Domino Tiles"},
   {0x1F0A0,0x1F0FF,"Playing Cards"},
   {0x1F100,0x1F1FF,"Enclosed Alphanumeric Supplement"},
   {0x1F200,0x1F2FF,"Enclosed Ideographic Supplement"},
   {0x1F300,0x1F5FF,"Miscellaneous Symbols And Pictographs"},
   {0x1F600,0x1F64F,"Emoticons"},
   {0x1F680,0x1F6FF,"Transport And Map Symbols"},
   {0x1F700,0x1F77F,"Alchemical Symbols"},
   {0x20000,0x2A6DF,"CJK Unified Ideographs Extension B"},
   {0x2A700,0x2B73F,"CJK Unified Ideographs Extension C"},
   {0x2B740,0x2B81F,"CJK Unified Ideographs Extension D"},
   {0x2F800,0x2FA1F,"CJK Compatibility Ideographs Supplement"},
   {0xE0000,0xE007F,"Tags"},
   {0xE0100,0xE01EF,"Variation Selectors Supplement"},
   {0xF0000,0xFFFFF,"Supplementary Private Use Area-A"},
   {0x100000,0x10FFFF,"Supplementary Private Use Area-B"},
};

void generate_unicode_list(NODE *match_pattern,char *cfg) {
   int i,j,blen=64,elen,complained=0,cfgbits;
   char *ebuf,*cptr;
   int start,parsed;
   NODE *to_match;
   
   /* start with a small buffer - usually enough */
   ebuf=(char *)malloc(blen);

   /* loop over chars */
   for (i=0;i<0x110000;i++) {
      
      /* skip surrogates */
      if (i==0xD800)
	i=0xE000;
      
      /* generate dictionary entry */
      ebuf[0]='<';
      if (i==(int)'\\') {
	 ebuf[1]='\\';
	 ebuf[2]='\\';
	 elen=3;
      } else
	elen=1+construct_utf8(i,ebuf+1);
      ebuf[elen++]='>';
      if ((cfg==NULL) || (*cfg=='\0'))
	ebuf[elen++]=';';
      else {
	 j=0;
	 cfgbits=0;
	 for (cptr=cfg;*cptr;cptr++) {
	    if (blen-elen<50) {
	       blen*=2;
	       ebuf=(char *)realloc(ebuf,blen);
	    }
	    switch (*cptr) {
	     case 'b':
	       for (;unicode_blocks[j].high<i;j++);
	       if (unicode_blocks[j].low<=i) {
		  ebuf[elen++]=cfgbits?';':'(';
		  cfgbits++;
		  strcpy(ebuf+elen,unicode_blocks[j].name);
		  elen+=strlen(unicode_blocks[j].name);
	       }
	       break;
	       
	     case 'd':
	       ebuf[elen++]=cfgbits?';':'(';
	       cfgbits++;
	       elen+=sprintf(ebuf+elen,"%d",i);
	       break;
	       
	     case 'x':
	       ebuf[elen++]=cfgbits?';':'(';
	       cfgbits++;
	       elen+=sprintf(ebuf+elen,"U+%04X",i);
	       break;
	       
	     default:
	       if (!complained) {
		  fprintf(stderr,
			  "bad character %c in dictionary generator config\n",
			  *cptr);
		  complained=1;
	       }
	       break;
	    }
	 }
	 ebuf[elen++]=cfgbits?')':';';
      }
      ebuf[elen++]='\n';
      
      /* try to parse */
      for (start=0;start<elen;start+=parsed) {
	 parsed=parse(elen-start,ebuf+start);

	 /* complain about errors */
	 if (parse_state==PS_ERROR) {
	    puts("can't parse internally generated " /* SNH */
		 "dictionary entry"); /* SNH */
	    fwrite(ebuf,1,elen,stdout); /* SNH */
	    exit(1); /* SNH */
	 }
	 
	 /* deal with a complete tree if we have one */
	 if (parse_state==PS_COMPLETE_TREE) {
	    to_match=parse_stack[0];
	    stack_ptr=0;
	    if (tree_match(match_pattern,to_match)) {
	       if (cook_output)
		 write_cooked_tree(to_match);
	       else {
		  fwrite(ebuf,1,elen-1,stdout);
		  echoing_whitespace=1;
	       }
	    }
	    free_node(to_match);
	 }
      }
   }
   
   free(ebuf);
}
