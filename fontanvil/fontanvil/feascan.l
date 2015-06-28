/* $Id: feascan.l 4069 2015-06-28 19:55:59Z mskala $ */
/*
 * Tokenizer for Adobe-style feature files
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

%{

#include <math.h>
#include <string.h>

#include "fontanvil.h"
#include "gfile.h"
#include "ustring.h"
#include "feascan.h"

#define YY_DECL void fea_ParseTok(struct parseState *tok,TOKENIZER_MODE tm)

/* FIXME it'd be nice to make this do better buffering */
#define YY_INPUT(buf,result,max_size) \
   { int ch=agetc((AFILE *)yyin); result=(ch<0)?YY_NULL:(buf[0]=ch,1); }

%}

%option noyywrap
%option nodefault

%s kw_allowed hexint tenths
%x in_string

%top{
/* GENERATED FILE.  EDIT THE SOURCE IN feascan.l INSTEAD! */

}

%%

%{
   char *string_in_progress;
   int string_buffer_size,string_buffer_ptr;
   
   if (tok->backedup) {
      tok->backedup=false;
      return;
   }

   if (yyin==NULL)
     yyin=(FILE *)(tok->inlist[tok->inc_depth]);

   switch (tm) {
    case tm_nokw:
      BEGIN(INITIAL);
      break;
    case tm_hexint:
      BEGIN(hexint);
      break;
    case tm_tenths:
      BEGIN(tenths);
      break;
    case tm_string:
      BEGIN(in_string);
      string_in_progress=(char *)malloc(80);
      string_buffer_size=80;
      string_buffer_ptr=0;
      string_in_progress[0]='\0';
      break;
    case tm_generic:
    default:
      BEGIN(kw_allowed);
      break;
   }
   
   tok->could_be_tag=false;
%}

<in_string>\\([0-9a-fA-F]{1,4})	{
   int i;
   uint32_t uval=0;

   if (string_buffer_ptr+4>=string_buffer_size) {
      string_buffer_size*=5;
      string_buffer_size/=4;
      string_in_progress=(char *)realloc(string_in_progress,
					 string_buffer_size);
   }

   for (i=1;i<yyleng;i++) {
      uval*=16;
      if ((yytext[i]>='0') && (yytext[i]<='9'))
	uval+=(yytext[i]-'0');
      else if ((yytext[i]>='A') && (yytext[i]<='F'))
	uval+=(yytext[i]-'A'+10);
      else
	uval+=(yytext[i]-'a'+10);
   }
   string_buffer_ptr=utf8_idpb(string_in_progress+string_buffer_ptr,uval,0)
     -string_in_progress;
   string_in_progress[string_buffer_ptr]='\0';
}
<in_string>(\n|\r|\r\n)	{ tok->line[tok->inc_depth]++; }
<in_string>\"	{
   tok->nm=string_in_progress;
   BEGIN(INITIAL);
   return;
}
<in_string>(\\?)(.|\n)	{
   int i;

   if (string_buffer_ptr+1>=string_buffer_size) {
      string_buffer_size*=5;
      string_buffer_size/=4;
      string_in_progress=(char *)realloc(string_in_progress,
					 string_buffer_size);
   }

   string_in_progress[string_buffer_ptr++]=yytext[yyleng-1];
   string_in_progress[string_buffer_ptr]='\0';
}

\#.*(\n|\r|\r\n)	{ tok->line[tok->inc_depth]++; }
(\n|\r|\r\n)	{ tok->line[tok->inc_depth]++; }
[ \t]+	/* skip whitespace */

<<EOF>>	{
   if (tok->inc_depth>0) {
      afclose(tok->inlist[tok->inc_depth]);
      free(tok->filename[tok->inc_depth]);
      yyin=(FILE *)(tok->inlist[--tok->inc_depth]);
      yypop_buffer_state();
   } else {
      tok->type=tk_eof;
      strcpy(tok->tokbuf,"EOF");
      return;
   }
}

<kw_allowed>{
   
include[ \t]*\([ \t]*[^ \t\)]+[ \t]*\)	{
   char *cp=yytext+7,*fn,*fn2;
   AFILE *in;
   
   /* find and mark end of filename */
   while (*cp!='(') cp++;
   cp++;
   while ((*cp==' ') || (*cp=='\t')) cp++;
   fn=cp;
   while ((*cp!=' ') && (*cp!='\t') && (*cp!=')')) cp++;
   *cp='\0';
   
   do {
   
      if (tok->inc_depth>=MAXI-1) {
	 ErrorMsg(2,"Includes nested too deeply on line %d of %s\n",
		  tok->line[tok->inc_depth], tok->filename[tok->inc_depth]);
	 ++tok->err_count;
	 break;
      }
      
      if ((*fn=='/') ||
	  ((cp=strrchr(tok->filename[tok->inc_depth],'/'))==NULL))
	fn2=fastrdup(fn);
      else {
	 *cp='\0';
	 fn2=GFileAppendFile(tok->filename[tok->inc_depth],fn,false);
	 *cp='/';
      }
      
      in=afopen(fn2,"r");
      if (in==NULL) {
	 ErrorMsg(2,"Could not open include file (%s) on line %d of %s\n",
		  fn2,tok->line[tok->inc_depth],
		  tok->filename[tok->inc_depth]);
	 tok->err_count++;
	 free(fn2);
	 break;
      }
      
      tok->inc_depth++;
      tok->filename[tok->inc_depth]=fn2;
      tok->inlist[tok->inc_depth]=in;
      tok->line[tok->inc_depth]=1;

      yyin=(FILE *)in;
      yypush_buffer_state(yy_create_buffer(yyin,YY_BUF_SIZE));

   } while (0);
}

anchor		{ tok->type=tk_anchor; return; }
anonymous	{ tok->type=tk_anonymous; return; }
by		{ tok->type=tk_by; return; }
caret		{ tok->type=tk_caret; return; }
cursive		{ tok->type=tk_cursive; return; }
device		{ tok->type=tk_device; return; }
enumerate	{ tok->type=tk_enumerate; return; }
excludeDFLT	{ tok->type=tk_excludeDFLT; return; }
exclude_dflt	{ tok->type=tk_exclude_dflt; return; }
feature		{ tok->type=tk_feature; return; }
from		{ tok->type=tk_from; return; }
ignore		{ tok->type=tk_ignore; return; }
IgnoreBaseGlyphs	{ tok->type=tk_IgnoreBaseGlyphs; return; }
IgnoreLigatures	{ tok->type=tk_IgnoreLigatures; return; }
IgnoreMarks	{ tok->type=tk_IgnoreMarks; return; }
includeDFLT	{ tok->type=tk_includeDFLT; return; }
include_dflt	{ tok->type=tk_include_dflt; return; }
language	{ tok->type=tk_language; return; }
languagesystem	{ tok->type=tk_languagesystem; return; }
lookup		{ tok->type=tk_lookup; return; }
lookupflag	{ tok->type=tk_lookupflag; return; }
mark		{ tok->type=tk_mark; return; }
nameid		{ tok->type=tk_nameid; return; }
NULL		{ tok->type=tk_NULL; return; }
parameters	{ tok->type=tk_parameters; return; }
position	{ tok->type=tk_position; return; }
required	{ tok->type=tk_required; return; }
RightToLeft	{ tok->type=tk_RightToLeft; return; }
script		{ tok->type=tk_script; return; }
substitute	{ tok->type=tk_substitute; return; }
subtable	{ tok->type=tk_subtable; return; }
table		{ tok->type=tk_table; return; }
useExtension	{ tok->type=tk_useExtension; return; }

anchorDef	{ tok->type=tk_anchorDef; return; }
valueRecordDef	{ tok->type=tk_valueRecordDef; return; }
contourpoint	{ tok->type=tk_contourpoint; return; }
MarkAttachmentType	{ tok->type=tk_MarkAttachmentType; return; }
UseMarkFilteringSet	{ tok->type=tk_UseMarkFilteringSet; return; }
reversesub	{ tok->type=tk_reversesub; return; }
markClass	{ tok->type=tk_markClass; return; }
base		{ tok->type=tk_base; return; }
ligature	{ tok->type=tk_ligature; return; }
ligComponent	{ tok->type=tk_ligComponent; return; }
featureNames	{ tok->type=tk_featureNames; return; }

sub	{ tok->type=tk_substitute; return; }
pos	{ tok->type=tk_position; return; }
rsub	{ tok->type=tk_reversesub; return; }
enum	{ tok->type=tk_enumerate; return; }
anon	{ tok->type=tk_anonymous; return; }

}

<hexint>[+\-\\]?[0-9A-FXa-fx]+	{
   char *buf;
   
   buf=(char *)malloc(yyleng+1);
   memcpy(buf,yytext,yyleng);
   buf[yyleng]='\0';
   if (yytext[0]=='\\') {
      tok->type=tk_cid;
      tok->value=strtol(buf+1,NULL,0);
   } else {
      tok->type=tk_int;
      tok->value=strtol(buf,NULL,0);
   }
   free(buf);
   return;
}

<tenths>[+\-]?[0-9]+\.[0-9]+	{
   char *buf;
   
   buf=(char *)malloc(yyleng+1);
   memcpy(buf,yytext,yyleng);
   buf[yyleng]='\0';
   tok->type=tk_int;
   tok->value=rint(strtod(buf,NULL)*10);
   free(buf);
   return;
}

[+\-\\]?[0-9]+	{
   char *buf;

   buf=(char *)malloc(yyleng+1);
   memcpy(buf,yytext,yyleng);
   buf[yyleng]='\0';
   if (yytext[0]=='\\') {
      tok->type=tk_cid;
      tok->value=strtol(buf+1,NULL,10);
   } else {
      tok->type=tk_int;
      tok->value=strtol(buf,NULL,10);
   }
   free(buf);
   return;
}

[@_\\A-Za-z0-9][A-Za-z0-9_\.]*|OS\/2	{
   int start=0;
   
   tok->type=tk_name;
   if (yytext[0]=='@') {
      tok->type=tk_class;
      start=1;
   } else if (yytext[0]=='\\')
	start=1;
   strncpy(tok->tokbuf,yytext+start,yyleng-start>MAXT?MAXT+1:yyleng-start+1);
   tok->tokbuf[MAXT]='\0';

   if (yyleng>31+start) {
      /* Adobe says glyphnames are 31 chars, but Mangal uses longer names */
      ErrorMsg(2,"Name, %s%s, too long on line %d of %s\n",
	       tok->tokbuf, yyleng-start>MAXT? "..." : "",
	       tok->line[tok->inc_depth], tok->filename[tok->inc_depth]);
      if (yyleng-start>MAXT)
	tok->err_count++;

   } else if (yyleng==start) {
      ErrorMsg(2,"Missing name on line %d of %s\n",
	       tok->line[tok->inc_depth], tok->filename[tok->inc_depth]);
      tok->err_count++;

   } else {
      if ((tok->type==tk_name) && (yyleng<=4)) {
	 tok->could_be_tag=true;
	 switch (yyleng) {
	  case 4:
	    tok->tag=(yytext[0]<<24)|(yytext[1]<<16)|(yytext[2]<<8)|yytext[3];
	    break;
	  case 3:
	    tok->tag=(yytext[0]<<24)|(yytext[1]<<16)|(yytext[2]<<8)|0x20;
	    break;
	  case 2:
	    tok->tag=(yytext[0]<<24)|(yytext[1]<<16)|0x2020;
	    break;
	  case 1:
	  default:
	    tok->tag=(yytext[0]<<24)|0x202020;
	    break;
	 }
      }
      return;
   }
}

[;,\-=\'\"{}\[\]<>()]	{
   tok->type=tk_char;
   tok->tokbuf[0]=yytext[0];
   tok->tokbuf[1]='\0';
   return;
}

.	{
   if (!tok->skipping) {
      ErrorMsg(2,"Unexpected character (0x%02X) on line %d of %s\n",
	       yytext[0],
	       tok->line[tok->inc_depth],
	       tok->filename[tok->inc_depth]);
      ++tok->err_count;
   }
}
