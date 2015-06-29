/* $Id: pescript.l 4077 2015-06-29 15:51:30Z mskala $ */
/*
 * Tokenizer for FontAnvil PE script
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

#include "fontanvil.h"

#ifndef _NO_LIBREADLINE
#   include <readline/readline.h>
#   include <readline/history.h>
#endif

#include "scripting.h"

static int verbose=-1;

#define YY_DECL enum token_type ff_NextToken(Context *c)

static Context *global_context; /* Eww. */

static int AddScriptLine(AFILE *script,const char *line) {
   long pos;
   
   if ((pos=aftell(script))<0)
     return -1;
   afputs(line, script);
#   ifndef _NO_LIBREADLINE
   afputs("\n\n", script);
#   endif
   afseek(script,pos,SEEK_SET);
   return agetc(script);
}

static int _buffered_cgetc(void) {
   if (global_context->interactive) {
      int ch;

      if ((ch=agetc(global_context->script)) < 0) {
#   ifdef _NO_LIBREADLINE
	 static char *linebuf=NULL;
	 static size_t lbsize=0;

	 if (agetline(&linebuf,&lbsize,astdin) > 0) {
	    ch=AddScriptLine(global_context->script,linebuf);
	 } else {
	    if (linebuf) {
	       free(linebuf);
	       linebuf=NULL;
	    }
	 }
#   else
	 char *line=readline("> ");

	 if (line) {
	    ch=AddScriptLine(global_context->script, line);
	    add_history(line);
	    free(line);
	 }
#   endif
	 if (ch < 0) {
	    /* stdin is closed, so stop reading from it */
	    global_context->interactive=0;
	 }
      }
      return ch;
   }
   return agetc(global_context->script);
}

static int _cgetc(void) {
   int ch;

   ch=_buffered_cgetc();
   if (verbose > 0)
      putchar(ch);
   if (ch=='\r') {
      int nch=_buffered_cgetc();

      if (nch != '\n')
	 aungetc(nch, global_context->script);
      else if (verbose > 0)
	 putchar('\n');
      ch='\n';
      ++global_context->lineno;
   } else if (ch=='\n')
      ++global_context->lineno;
   return (ch);
}

void ff_FlushScanner(void) {
   YY_FLUSH_BUFFER;
}

/* FIXME this is straight out of the flex manual */

#define YY_INPUT(buf,result,max_size) \
  { int ch=_cgetc(); result=(ch<0)?YY_NULL:(buf[0]=ch,1); }

%}

%option noyywrap
%option nodefault

%x sq_string dq_string line_comment c_comment

%top{
/* GENERATED FILE.  EDIT THE SOURCE IN pescript.l INSTEAD! */
}

%%

%{
   int string_length;

   if (c->backedup) {
      c->backedup=false;
      return (c->tok);
   }

   global_context=c;
%}

\\[\r\n]	/* skip line continuation */

if	return (c->tok=tt_if);
else	return (c->tok=tt_else);
elseif	return (c->tok=tt_elseif);
endif	return (c->tok=tt_endif);
while	return (c->tok=tt_while);
foreach	return (c->tok=tt_foreach);
endloop	return (c->tok=tt_endloop);
shift	return (c->tok=tt_shift);
return	return (c->tok=tt_return);
break	return (c->tok=tt_break);

\.|\.[A-Za-z\$_@\.][A-Za-z0-9\$_@\.]*|[A-Za-z\$_@][A-Za-z0-9\$_@\.]*	{
   if (yyleng>=TOK_MAX) {
      ScriptError(c,"Name too long");
   } else {
      memcpy(c->tok_text,yytext,yyleng);
      c->tok_text[yyleng]='\0';
      return (c->tok=tt_name);
   }
}

(([1-9][0-9]*)|0)?\.[0-9]*([eE][+\-]?[0-9]+)?|[1-9][0-9]*[eE][+\-]?[0-9]+	{
   double rval,fraction;
   int exp_sign,exponent,i;
   
   rval=0.0;
   fraction=1.0;
   exp_sign=1;
   exponent=0;
   
   /* digits before decimal point */
   for (i=0;(i<yyleng) && (yytext[i]>='0') && (yytext[i]<='9');i++) {
      rval*=10.0;
      rval+=(yytext[i]-'0');
   }
  
   /* decimal point and digits after it */
   if ((i<yyleng) && (yytext[i]=='.'))
     for (i++;(i<yyleng) && (yytext[i]>='0') && (yytext[i]<='9');i++) {
	fraction/=10.0;
	rval+=((yytext[i]-'0')*fraction);
     }

   /* exponent */
   if ((i<yyleng) && ((yytext[i]=='e') || (yytext[i]=='E'))) {
      
      /* sign of exponent */
      i++;
      if (yytext[i]=='-') {
	 exp_sign=-1;
	 i++;
      } else if (yytext[i]=='+')
	   i++;
   
      /* value of exponent */
      for (;(i<yyleng) && (yytext[i]>='0') && (yytext[i]<='9');i++) {
	 exponent*=10;
	 exponent+=(yytext[i]-'0');
      }
   }
   
   c->tok_val.u.fval=rval*pow(10.0,exponent*exp_sign);
   c->tok_val.type=v_real;
   return (c->tok=tt_real);
}

0[0-7]*	{
   int i,val=0;
   
   for (i=1;i<yyleng;i++) {
      val*=8;
      val+=(yytext[i]-'0');
   }
   c->tok_val.u.ival=val;
   c->tok_val.type=v_int;
   return (c->tok=tt_number);
}

0[xXuU][0-9a-fA-F]*	{
   int i,val=0;
   
   for (i=2;i<yyleng;i++) {
      val*=16;
      val+=yytext[i];
      if ((yytext[i]>='0') && (yytext[i]<='9'))
	val-='0';
      else if ((yytext[i]>='A') && (yytext[i]<='F'))
	val-=('A'-10);
      else
	val-=('a'-10);
   }
   c->tok_val.u.ival=val;
   if ((yytext[1]=='x') || (yytext[1]=='X'))
      c->tok_val.type=v_int;
   else
     c->tok_val.type=v_unicode;
   return (c->tok=tt_number);
}

[1-9][0-9]*	{
   int i,val=0;
   
   for (i=0;i<yyleng;i++) {
      val*=10;
      val+=(yytext[i]-'0');
   }
   c->tok_val.u.ival=val;
   c->tok_val.type=v_int;
   return (c->tok=tt_number);
}

[\'\"]	{
   string_length=0;
   if (yytext[0]=='\'') {
     BEGIN(sq_string);
   } else {
     BEGIN(dq_string);
   }
}
<sq_string>[\'\n\r]	{
   BEGIN(INITIAL);
   if (string_length>=TOK_MAX) {
      ScriptError(c,"String too long");
   } else {
      memcpy(c->tok_text,yytext,string_length);
      c->tok_text[string_length]='\0';
      return (c->tok=tt_string);
   }
}
<dq_string>[\"\n\r]	{
   BEGIN(INITIAL);
   if (string_length>=TOK_MAX) {
      ScriptError(c,"String too long");
   } else {
      memcpy(c->tok_text,yytext,string_length);
      c->tok_text[string_length]='\0';
      return (c->tok=tt_string);
   }
}
<sq_string,dq_string>\\[\n\r]	yymore();
<sq_string,dq_string>\\n	{
   yytext[string_length++]='\n';
   yymore();
}
<sq_string,dq_string>\\.	{
   yytext[string_length++]=yytext[yyleng-1];
   yymore();
}
<sq_string,dq_string>.	{
   if (string_length<yyleng-1)
     yytext[string_length]=yytext[yyleng-1];
   string_length++;
   yymore();
}

\#|\/\/	BEGIN(line_comment);
<line_comment>[\n\r]	{ BEGIN(INITIAL); yyless(0); }
<line_comment>.*	/* ignore contents of line comment */

\/\*	BEGIN(c_comment);
<c_comment>\*\/	BEGIN(INITIAL);
<c_comment>.*	/* ignore contents of C comment */
<c_comment>\n	/* ignore contents of C comment */

<<EOF>>	return (c->tok=tt_eof);
[ \t]	/* ignore spaces */
\(	return (c->tok=tt_lparen);
\)	return (c->tok=tt_rparen);
\[	return (c->tok=tt_lbracket);
\]	return (c->tok=tt_rbracket);
,	return (c->tok=tt_comma);
:	return (c->tok=tt_colon);
[;\n\r]	return (c->tok=tt_eos);
-	return (c->tok=tt_minus);
-=	return (c->tok=tt_minuseq);
--	return (c->tok=tt_decr);
\+	return (c->tok=tt_plus);
\+=	return (c->tok=tt_pluseq);
\+\+	return (c->tok=tt_incr);
!	return (c->tok=tt_not);
!=	return (c->tok=tt_ne);
~	return (c->tok=tt_bitnot);
\*	return (c->tok=tt_mul);
\*=	return (c->tok=tt_muleq);
%	return (c->tok=tt_mod);
%=	return (c->tok=tt_modeq);
\/	return (c->tok=tt_div);
\/=	return (c->tok=tt_diveq);
&	return (c->tok=tt_bitand);
&&	return (c->tok=tt_and);
\|	return (c->tok=tt_bitor);
\|\|	return (c->tok=tt_or);
\^	return (c->tok=tt_xor);
=	return (c->tok=tt_assign);
==	return (c->tok=tt_eq);
>	return (c->tok=tt_gt);
>=	return (c->tok=tt_ge);
\<	return (c->tok=tt_lt);
\<=	return (c->tok=tt_le);

.	/* FIXME other characters are errors, complain */
