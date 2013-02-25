/*
 * General header file for IDSgrep
 * Copyright (C) 2012, 2013  Matthew Skala
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

#include "config.h"
#include "_stdint.h"

#ifdef HAVE_PCRE
#include <pcre.h>
#endif

/**********************************************************************/

typedef struct _NODE *(*MATCH_FN)(struct _NODE *);

typedef enum _MATCH_RESULT {
   MR_INITIAL=0,
     MR_FALSE,
     MR_TRUE,
     MR_AND_MAYBE,
     MR_OR_MAYBE,
     MR_NOT_MAYBE,
} MATCH_RESULT;

typedef struct _HASHED_STRING {
   struct _HASHED_STRING *next,*mate,*canonical;
   char *data;
   size_t length;
   int refs,arity;
   MATCH_FN match_fn;
#ifdef HAVE_PCRE
   pcre *pcre_compiled;
   pcre_extra *pcre_studied;
#endif
   uintmax_t userpreds;
} HASHED_STRING;

typedef struct _NODE {
   HASHED_STRING *head,*functor;
#ifdef ANON_UNION_STRUCT
   union {
      struct _NODE *child[3];
      struct { struct _NODE *nc_next,*nc_needle,*nc_haystack; };
   };
#else
   struct _NODE *child[3];
#define nc_next child[0]
#define nc_needle child[1]
#define nc_haystack child[2]
#endif
   struct _NODE *match_parent;
   int refs,arity,complete;
   MATCH_RESULT match_result;
} NODE;

typedef enum _PARSE_STATE {
   PS_ERROR=-5,
     PS_SEEKING_FUNCTOR=-4,
     PS_COMPLETE_TREE=-3,
     PS_SEEKING_HEAD=-2,
     PS_READING_HEAD=-1,
     PS_READING_NULLARY=0,
     PS_READING_UNARY,
     PS_READING_BINARY,
     PS_READING_TERNARY,
} PARSE_STATE;

/**********************************************************************/

/* assoc.c */

NODE *assoc_match_fn(NODE *);

/**********************************************************************/

/* cook.c */

extern int cook_output,canonicalize_input;

void set_output_recipe(char *);
void write_bracketed_string(HASHED_STRING *,HASHED_STRING *);
void write_cooked_tree(NODE *);

/**********************************************************************/

/* hash.c */

HASHED_STRING *new_string(size_t,char *);
void delete_string(HASHED_STRING *);
NODE *new_node(void);
void free_node(NODE *);

/**********************************************************************/

/* match.c */

NODE *default_match_fn(NODE *);

NODE *and_or_match_fn(NODE *);
NODE *anything_match_fn(NODE *);
NODE *anywhere_match_fn(NODE *);
NODE *equal_match_fn(NODE *);
NODE *not_match_fn(NODE *);
NODE *unord_match_fn(NODE *);

int tree_match(NODE *,NODE *);

/**********************************************************************/

/* parse.c */

extern HASHED_STRING *hashed_bracket[15];

extern NODE **parse_stack;
extern int stack_ptr;
extern PARSE_STATE parse_state;
extern int echoing_whitespace;

int construct_utf8(int,char *);
size_t parse(size_t,char *);
void register_syntax(void);

/**********************************************************************/

/* regex.c */

NODE *regex_match_fn(NODE *);

/**********************************************************************/

/* userpred.c */

void font_file_userpred(char *);

NODE *user_match_fn(NODE *);
