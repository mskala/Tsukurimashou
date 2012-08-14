/*
 * Parser for IDSgrep
 * Copyright (C) 2012  Matthew Skala
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

HASHED_STRING *hashed_bracket[15];

NODE **parse_stack=NULL;
int stack_size=0,stack_ptr=0;
char *partstr=NULL;
int partstr_size=0,partstr_len=0;
PARSE_STATE parse_state=PS_SEEKING_HEAD;
int echoing_whitespace=0;
HASHED_STRING *close_bracket,*semicolon=NULL,*socked_head=NULL;

#define MYXDIGIT(x) ((((x)>='0') && ((x)<='9')) \
		     || (((x)>='a') && ((x)<='f')) \
		     || (((x)>='A') && ((x)<='F')))
#define MYXVAL(x) (((x)&0x40)?(((x)&0xF)+9):((x)&0xF))

size_t parse(size_t len,char *inp) {
   int offs=0,clen,escaped,flag,xval,i;
   char ebuf[4],*eptr;
   HASHED_STRING *hchar,*newstr,*tmps;
   
   /* can't parse if we are in an error state */
   if (parse_state==PS_ERROR)
     return 0; /* SNH */
   
   /* reset state if the tree has been consumed */
   if ((stack_ptr==0) && (parse_state==PS_COMPLETE_TREE))
     parse_state=PS_SEEKING_HEAD;
   
   /* make sure we have a buffer */
   if (partstr==NULL) {
      partstr_size=1024;
      partstr=(char *)malloc(partstr_size);
   }
   
   /* make sure we have a stack */
   if (parse_stack==NULL) {
      stack_size=16;
      parse_stack=(NODE **)malloc(sizeof(NODE *)*stack_size);
   }
   
   /* while we have input and no other reason to stop */
   while (offs<len) {
      
      /* make sure stack is big enough */
      if (stack_size<=stack_ptr) {
	 stack_size=stack_ptr+8;
	 parse_stack=(NODE **)realloc(parse_stack,sizeof(NODE *)*stack_size);
      }

      /* handle escape sequences */
      escaped=0;
      clen=0;
      eptr=inp+offs;
      if (eptr[0]=='\\') {
	 escaped=1;
	 if (len-offs<2)
	   return offs;
	 switch (eptr[1]) {
	    
	  case 'a':
	    /* alarm */
	    ebuf[0]='\a';
	    eptr=ebuf;
	    offs++;
	    clen=1;
	    break;
	    
	  case 'b':
	    /* backspace */
	    ebuf[0]='\b';
	    eptr=ebuf;
	    offs++;
	    clen=1;
	    break;
	    
	  case 'c':
	    /* control character */
	    if (len-offs<3)
	      return offs;
	    if (((eptr[2]>='A') && (eptr[2]<='Z'))
		|| ((eptr[2]>='a') && (eptr[2]<='z'))) {
	       ebuf[0]=(eptr[2]|0x20)^0x60;
	       eptr=ebuf;
	       offs+=2;
	       clen=1;
	    } else {
	       offs++;
	       continue;
	    }
	    break;
	    
	  case 'e':
	    /* escape */
	    ebuf[0]='\e';
	    eptr=ebuf;
	    offs++;
	    clen=1;
	    break;
	    
	  case 'f':
	    /* form feed */
	    ebuf[0]='\f';
	    eptr=ebuf;
	    offs++;
	    clen=1;
	    break;
	    
	  case 'n':
	    /* newline */
	    ebuf[0]='\n';
	    eptr=ebuf;
	    offs++;
	    clen=1;
	    break;
	    
	  case 'r':
	    /* carriage return */
	    ebuf[0]='\r';
	    eptr=ebuf;
	    offs++;
	    clen=1;
	    break;
	    
	  case 't':
	    /* tab */
	    ebuf[0]='\t';
	    eptr=ebuf;
	    offs++;
	    clen=1;
	    break;
	    
	  case 'x':
	  case 'X':
	    /* hexadecimal */
	    if (len-offs<3)
	      return offs;
	    if (eptr[2]=='{') {
	       /* variable-length bracketed hex */
	       i=3;
	       xval=0;
	       while (1) {
		  if (len-offs<i+1)
		    return offs;
		  if (MYXDIGIT(eptr[i])) {
		     xval<<=4;
		     xval+=MYXVAL(eptr[i]);
		     i++;
		  } else
		    break;
	       }
	       offs+=(i+1);
	       if (eptr[i]!='}')
		 continue;

	    } else if (eptr[1]=='x') {
	       /* two-digit hex */
	       if (len-offs<4)
		 return offs;
	       offs+=4;
	       if (MYXDIGIT(eptr[2]) && MYXDIGIT(eptr[3]))
		 xval=(MYXVAL(eptr[2])<<4)+MYXVAL(eptr[3]);
	       else
		 continue;

	    } else {
	       /* four-digit hex */
	       if (len-offs<6)
		 return offs;
	       offs+=6;
	       if (MYXDIGIT(eptr[2]) && MYXDIGIT(eptr[3])
		   && MYXDIGIT(eptr[4]) && MYXDIGIT(eptr[5]))
		 xval=(MYXVAL(eptr[2])<<12)+(MYXVAL(eptr[3])<<8)
		   +(MYXVAL(eptr[4])<<4)+MYXVAL(eptr[5]);
	       else
		 continue;
	    }
	    eptr=ebuf;
	    if (xval>=0x110000)
	      xval=0xFFFD;
	    if (xval<0x80) {
	       clen=1;
	       ebuf[0]=xval;
	    } else if (xval<0x800) {
	       clen=2;
	       ebuf[0]=0xC0|(xval>>6);
	       ebuf[1]=0x80|(xval&0x3F);
	    } else if (xval<0x10000) {
	       clen=3;
	       ebuf[0]=0xE0|(xval>>12);
	       ebuf[1]=0x80|((xval>>6)&0x3F);
	       ebuf[2]=0x80|(xval&0x3F);
	    } else {
	       clen=4;
	       ebuf[0]=0xF0|(xval>>18);
	       ebuf[1]=0x80|((xval>>12)&0x3F);
	       ebuf[2]=0x80|((xval>>6)&0x3F);
	       ebuf[3]=0x80|(xval&0x3F);
	    }
	    offs-=clen;
	    break;

	  default:
	    /* will take next char literally */
	    eptr++;
	    offs++;
	    break;
	 }
      }
	  
      /* validate UTF-8 */
      if (clen>0) {
	 /* already have a char from escape sequence - do nothing */
	 
      } else if ((eptr[0]&0x80)==0) {
	 /* single-byte ASCII */
	 clen=1;
	 
      } else if ((eptr[0]&0xC0)==0x80) {
	 /* continuation byte, should never be first */
	 offs++;
	 continue;
	 
      } else if ((eptr[0]&0xE0)==0xC0) {
	 /* first of two */
	 
	 /* check for rest of char */
	 if (len-offs<2)
	   return offs-escaped;
	 
	 /* check for continuation */
	 if ((eptr[1]&0xC0)!=0x80) {
	    offs+=2;
	    continue;
	 }
	 
	 /* check for overlong */
	 if ((eptr[0]&0xFE)==0xC0) {
	    offs+=2;
	    continue;
	 }
	 clen=2;
      
      } else if ((eptr[0]&0xF0)==0xE0) {
	 /* first of three bytes */
	 
	 /* check for rest of char */
	 if (len-offs<3)
	   return offs-escaped;
	 
	 /* check for continuation */
	 if (((eptr[1]&0xC0)!=0x80)
	     || ((eptr[2]&0xC0)!=0x80)) {
	    offs+=3;
	    continue;
	 }
	 
	 /* check for surrogate */
	 if (((eptr[0]&0xFF)==0xED) && ((eptr[1]&0xE0)==0xA0)) {
	    offs+=3;
	    continue;
	 }
	 
	 /* check for overlong */
	 if (((eptr[0]&0xFF)==0xE0) && ((eptr[1]&0xE0)==0x80)) {
	    offs+=3;
	    continue;
	 }
	 clen=3;
	 
      } else if ((eptr[0]&0xF8)==0xF0) {
	 /* first of four bytes */
	 
	 /* check for rest of char */
	 if (len-offs<4)
	   return offs-escaped;
	 
	 /* check for continuation */
	 if (((eptr[1]&0xC0)!=0x80)
	     || ((eptr[2]&0xC0)!=0x80)
	     || ((eptr[3]&0xC0)!=0x80)) {
	    offs+=4;
	    continue;
	 }
	 
	 /* check for non-Unicode */
	 if (((eptr[0]==0xF4) && (eptr[2]&0xF0)>0x80) ||
	     ((eptr[0]&0xFF)>0xF4)) {
	    offs+=4;
	    continue;
	 }
	 
	 /* check for overlong */
	 if (((eptr[0]&0xFF)==0xF0) && ((eptr[1]&0xF0)==0x80)) {
	    offs+=4;
	    continue;
	 }
	 clen=4;

      } else {
	 /* invalid byte */
	 offs++;
	 continue;
      }
      
      /* see if we are waiting for an opening bracket */
      if (parse_state<PS_READING_HEAD) {
	 
	 /* skip unescaped whitespace in this context */
	 if ((clen==1) && (((unsigned char )eptr[0])<=0x20) && !escaped) {
	    if (echoing_whitespace)
	      putchar(eptr[0]);
	    offs++;
	    continue;
	 }
	 echoing_whitespace=0;

	 /* look up the character */
	 hchar=new_string(clen,eptr);
	 
	 /* can't open a head if we aren't looking for one */
	 if ((parse_state!=PS_SEEKING_HEAD) && (hchar->arity==-1) &&
	     !escaped) {
	    parse_state=PS_ERROR;
	    delete_string(hchar);
	    return offs;
	 }
	 
	 /* can we open a string? */
	 if ((hchar->arity>=-1) && (hchar->mate!=NULL) && !escaped) {
	    
	    /* yes; open the string */
	    close_bracket=hchar->mate;
	    offs+=clen;
	    parse_state=(PARSE_STATE)hchar->arity;
	    delete_string(hchar);
	    
	    /* is this a special character that makes its own functor? */
	 } else if ((hchar->arity>=-1) && !escaped) {
	    
	    /* put it in the string, then re-read it as closing bracket */
	    close_bracket=hchar;
	    parse_state=(PARSE_STATE)hchar->arity;
	    memcpy(partstr,eptr,clen);
	    partstr_len=clen;
	    delete_string(hchar);
	    continue;

	 } else {
	    /* no; this becomes head of nullary semicolon */
	    if (!semicolon)
	      semicolon=new_string(1,";");

	    /* and we had better be in state -2 */
	    if (parse_state!=PS_SEEKING_HEAD) {
	       parse_state=PS_ERROR;
	       delete_string(hchar);
	       return offs;
	    }
	    
	    /* create a new node */
	    parse_stack[stack_ptr]=new_node();
	    parse_stack[stack_ptr]->head=hchar;
	    parse_stack[stack_ptr]->functor=semicolon;
	    parse_stack[stack_ptr]->arity=0;
	    parse_stack[stack_ptr]->complete=1;
	    semicolon->refs++;
	    stack_ptr++;
	    
	    /* and now we can look for a new head */
	    offs+=clen;
	    if (stack_ptr==1) {
	       parse_state=PS_COMPLETE_TREE;
	       return offs;
	    } else
	      parse_state=PS_SEEKING_HEAD;
	 }

      } else {
	 /* we are waiting for a closing bracket */
	 
	 /* look up the character */
	 hchar=new_string(clen,eptr);
	 
	 /* unescaped matching bracket ends it */
	 if ((hchar==close_bracket) && (!escaped) && (partstr_len>0)) {

	    /* hash the partial string */
	    newstr=new_string(partstr_len,partstr);
	    partstr_len=0;
	    
	    /* replace with canonical if any */
	    if ((newstr->canonical!=NULL) &&
		(newstr->data[0]>='a') &&
		(newstr->data[0]<='z')) {
	       tmps=newstr->canonical;
	       delete_string(newstr);
	       newstr=tmps;
	    }
	    
	    /* if that was a head, sock it away, look for a functor */
	    if (parse_state==-1) {
	       socked_head=newstr;
	       parse_state=PS_SEEKING_FUNCTOR;

	    } else {
	       /* it was a functor */
	       parse_stack[stack_ptr]=new_node();
	       parse_stack[stack_ptr]->head=socked_head;
	       parse_stack[stack_ptr]->functor=newstr;
	       parse_stack[stack_ptr]->arity=parse_state;
	       if (parse_state==0)
		 parse_stack[stack_ptr]->complete=1;
	       socked_head=NULL;
	       stack_ptr++;
	       parse_state=PS_SEEKING_HEAD;
	    }
	    
	    offs+=clen;
	    close_bracket=NULL;
	    
	 } else {
	    /* add the char to the partial string */
	    
	    /* there must be enough space for it */
	    if (partstr_len+clen>partstr_size) {
	       partstr_size*=2;
	       partstr=(char *)realloc(partstr,partstr_size);
	    }
	    
	    /* append the data */
	    memcpy(partstr+partstr_len,eptr,clen);
	    partstr_len+=clen;
	    offs+=clen;
	 }
	 
	 delete_string(hchar);
      }
      
      /* try to hook up children to parent */
      flag=(stack_ptr>0) && (parse_stack[stack_ptr-1]->complete);
      while (flag) {
	 flag=0;
	 
	 /* return if we're done */
	 if (stack_ptr==1) {
	    parse_state=PS_COMPLETE_TREE;
	    return offs;
	 }
	 
	 /* handle unary nodes */
	 if ((stack_ptr>=2) &&
	     (parse_stack[stack_ptr-2]->arity==1) &&
	     (!parse_stack[stack_ptr-2]->complete)) {
	    parse_stack[stack_ptr-2]->child[0]=parse_stack[stack_ptr-1];
	    parse_stack[stack_ptr-2]->complete=1;
	    stack_ptr--;
	    flag=1;
	 }
	 
	 /* handle binary nodes */
	 if ((stack_ptr>=3) &&
	     (parse_stack[stack_ptr-3]->arity==2) &&
	     (parse_stack[stack_ptr-2]->complete) &&
	     (!parse_stack[stack_ptr-3]->complete)) {
	    parse_stack[stack_ptr-3]->child[0]=parse_stack[stack_ptr-2];
	    parse_stack[stack_ptr-3]->child[1]=parse_stack[stack_ptr-1];
	    parse_stack[stack_ptr-3]->complete=1;
	    stack_ptr-=2;
	    flag=1;
	 }
	 
	 /* handle ternary nodes */
	 if ((stack_ptr>=4) &&
	     (parse_stack[stack_ptr-4]->arity==3) &&
	     (parse_stack[stack_ptr-2]->complete) &&
	     (parse_stack[stack_ptr-3]->complete) &&
	     (!parse_stack[stack_ptr-4]->complete)) {
	    parse_stack[stack_ptr-4]->child[0]=parse_stack[stack_ptr-3];
	    parse_stack[stack_ptr-4]->child[1]=parse_stack[stack_ptr-2];
	    parse_stack[stack_ptr-4]->child[2]=parse_stack[stack_ptr-1];
	    parse_stack[stack_ptr-4]->complete=1;
	    stack_ptr-=3;
	    flag=1;
	 }
      }
   }
   return offs;
}


/**********************************************************************/

void register_brackets(char *opb,char *clb,int arity,int idx) {
   HASHED_STRING *oph,*clh;
   
   oph=new_string(strlen(opb),opb);
   clh=new_string(strlen(clb),clb);
   
   oph->arity=arity;
   oph->mate=clh;
   oph->refs++;
   clh->mate=oph;
   if (clh!=oph) clh->refs++;
   hashed_bracket[idx]=oph;
}

void register_special_functor(char *fctr,int arity,MATCH_FN mf) {
   HASHED_STRING *hs;
   
   hs=new_string(strlen(fctr),fctr);
   
   if ((hs->arity>-2) && (hs->arity!=arity)) {
      puts("attempt to register conflicting arities for functor"); /* SNH */
      exit(1); /* SNH */
   }

   hs->arity=arity;
   hs->match_fn=mf;
}

void register_alias(char *fctr,char *canon) {
   HASHED_STRING *hs,*cs;
   
   hs=new_string(strlen(fctr),fctr);
   cs=new_string(strlen(canon),canon);
   
   if ((hs->arity>-2) && (cs->arity!=hs->arity)) {
      puts("attempt to register conflicting arities for functor"); /* SNH */
      exit(1); /* SNH */
   }

   hs->arity=cs->arity;
   hs->match_fn=cs->match_fn;
   hs->canonical=cs;
   cs->canonical=hs;
}

/**********************************************************************/

void register_syntax(void) {
   register_brackets("<",">",-1,0);
   register_brackets("\xE3\x80\x90","\xE3\x80\x91",-1,1); /* b lenticular */
   register_brackets("\xE3\x80\x96","\xE3\x80\x97",-1,2); /* w lenticular */

   register_brackets("(",")",0,3);
   register_brackets("\xEF\xBC\x88","\xEF\xBC\x89",0,4);  /* wide paren */
   register_brackets("\xEF\xBD\x9F","\xEF\xBD\xA0",0,5);  /* dblwide paren */

   register_brackets(".",".",1,6);
   register_brackets(":",":",1,7);
   register_brackets("\xE3\x83\xBB","\xE3\x83\xBB",1,8);  /* centre dot */

   register_brackets("[","]",2,9);
   register_brackets("\xEF\xBC\xBB","\xEF\xBC\xBD",2,10); /* wide sqb */
   register_brackets("\xE3\x80\x9A","\xE3\x80\x9B",2,11); /* dblwide sqb */

   register_brackets("{","}",3,12);
   register_brackets("\xE3\x80\x94","\xE3\x80\x95",3,13); /* b tortoise */
   register_brackets("\xE3\x80\x98","\xE3\x80\x99",3,14); /* w tortoise */
   
   register_special_functor(";",0,default_match_fn);

   register_special_functor(",",2,default_match_fn);

   register_special_functor("?",0,anything_match_fn);
   register_alias("anything","?");

   register_special_functor(".",1,anywhere_match_fn);
   register_alias("anywhere",".");

   register_special_functor("&",2,and_or_match_fn);
   register_alias("and","&");  

   register_special_functor("|",2,and_or_match_fn);
   register_alias("or","|");
   
   register_special_functor("!",1,not_match_fn);
   register_alias("not","!");

   register_special_functor("*",1,unord_match_fn);
   register_alias("unord","*");

   register_special_functor("=",1,equal_match_fn);
   register_alias("equal","=");

   register_special_functor("@",1,assoc_match_fn);
   register_alias("assoc","@");

   register_special_functor("/",1,regex_match_fn);
   register_alias("regex","/");

   register_special_functor("\xE2\xBF\xB0",2,default_match_fn);
   register_alias("lr","\xE2\xBF\xB0");

   register_special_functor("\xE2\xBF\xB1",2,default_match_fn);
   register_alias("tb","\xE2\xBF\xB1");

   register_special_functor("\xE2\xBF\xB2",3,default_match_fn);
   register_alias("lcr","\xE2\xBF\xB2");

   register_special_functor("\xE2\xBF\xB3",3,default_match_fn);
   register_alias("tcb","\xE2\xBF\xB3");

   register_special_functor("\xE2\xBF\xB4",2,default_match_fn);
   register_alias("enclose","\xE2\xBF\xB4");

   register_special_functor("\xE2\xBF\xB5",2,default_match_fn);
   register_alias("wrapu","\xE2\xBF\xB5");

   register_special_functor("\xE2\xBF\xB6",2,default_match_fn);
   register_alias("wrapd","\xE2\xBF\xB6");

   register_special_functor("\xE2\xBF\xB7",2,default_match_fn);
   register_alias("wrapl","\xE2\xBF\xB7");

   register_special_functor("\xE2\xBF\xB8",2,default_match_fn);
   register_alias("wrapul","\xE2\xBF\xB8");

   register_special_functor("\xE2\xBF\xB9",2,default_match_fn);
   register_alias("wrapur","\xE2\xBF\xB9");

   register_special_functor("\xE2\xBF\xBA",2,default_match_fn);
   register_alias("wrapll","\xE2\xBF\xBA");

   register_special_functor("\xE2\xBF\xBB",2,default_match_fn);
   register_alias("overlap","\xE2\xBF\xBB");
}
