/*
 * General header file for Icemap
 * Copyright (C) 2014, 2015  Matthew Skala
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

#include "_stdint.h"
#include "config.h"

/**********************************************************************/

/* nodes.c */

typedef enum _NODE_TYPE {
   nt_keyword,
   nt_parser_file,
   nt_eof,
   nt_int,
   nt_int_range,
   nt_string,
   nt_map_entry
} NODE_TYPE;

typedef struct _NODE {
   NODE_TYPE type;
   struct _NODE *next;
   int refs;
   struct _NODE *nodes;
   FILE *fp;
   char *cp;
   int x,y;
} NODE;

NODE *node_new(void);
void node_delete(NODE *n);

int atom_cmp(NODE *x,NODE *y);

/**********************************************************************/

/* parser.c */

typedef struct _PARSER_STATE {
   NODE *file_stack;
   int ignore_semicolon;
   NODE *first_token,*last_token;
} PARSER_STATE;

void parse_error(PARSER_STATE *ps,char *message,...);
NODE *get_token(PARSER_STATE *ps);
void complete_int_range(PARSER_STATE *ps,NODE *start_tok);

void parse(int,char **,int);

/**********************************************************************/

/* arrows.c */

typedef enum _DUPE_PRIORITY {
   dp_error,dp_first,dp_last,dp_min,dp_max
} DUPE_PRIORITY;

typedef struct _ARROW_MAP {
   NODE **arrows;
   int num_arrows,num_buckets;
   NODE *first_key,*last_key;
} ARROW_MAP;

void arrow_map_new(ARROW_MAP *am);
void arrow_map_copy(ARROW_MAP *zm,ARROW_MAP *am);
void arrow_map_delete(ARROW_MAP *am);
NODE *arrow_map_lookup(ARROW_MAP *am,NODE *k);

int raw_add_arrow(ARROW_MAP *am,NODE *k,NODE *v,DUPE_PRIORITY dp);

void add_one_arrow(PARSER_STATE *ps);
void add_many_arrows(PARSER_STATE *ps);

void arrow_map_remap_keys(ARROW_MAP *,ARROW_MAP *,ARROW_MAP *,
			    DUPE_PRIORITY);
void arrow_map_remap_values(ARROW_MAP *,ARROW_MAP *,ARROW_MAP *);

/**********************************************************************/

/* context.c */

typedef enum _QUOTE_POLICY {
   qp_strings,qp_nothing,qp_everything
} QUOTE_POLICY;

typedef struct _CONTEXT {
   struct _CONTEXT *parent;
   char *id;
   ARROW_MAP am;
   DUPE_PRIORITY dupe_priority;
   char *skip_regex,*parse_regex;
   char *c_file,*h_file;
   void (*generator)(struct _CONTEXT *);
   char *key_c_type,*value_c_type;
   QUOTE_POLICY quote_policy;
   int leaves;
} CONTEXT;

extern CONTEXT *context_stack;

void handle_opening_brace(PARSER_STATE *ps);
void handle_closing_brace(PARSER_STATE *ps);
void handle_generate(PARSER_STATE *ps);
void handle_quote_policy(PARSER_STATE *ps);

/**********************************************************************/

/* arrays.c */

int prefer_basic_array(CONTEXT *c);
void gen_basic_array(CONTEXT *c);

/**********************************************************************/

/* cascade.c */

int prefer_cascade(CONTEXT *c);
void gen_cascade(CONTEXT *c);

int prefer_wide_cascade(CONTEXT *c);
void gen_wide_cascade(CONTEXT *c);

/**********************************************************************/

/* encode.c */

void handle_encode(PARSER_STATE *,int);

/**********************************************************************/

/* fileout.c */

extern char *default_c_file,*default_h_file;
extern int delete_failed;

NODE *open_output_file(char *);
void close_output_files(void);

void of_write(NODE *,char *,...);
void of_write_wrapped(NODE *,char *,...);

void of_indent(NODE *,int);
void of_unindent(NODE *,int);

void handle_c_file(PARSER_STATE *ps);
void handle_h_file(PARSER_STATE *ps);
void handle_c_write(PARSER_STATE *ps);
void handle_h_write(PARSER_STATE *ps);

/**********************************************************************/

/* icemap.c */

extern int exit_code;
extern int quiet;
extern int bdd_error_segfault;

/**********************************************************************/

/* remap.c */

void handle_remap(PARSER_STATE *ps);

/**********************************************************************/

/* rxparse.c */

void handle_rxparse(PARSER_STATE *ps);
