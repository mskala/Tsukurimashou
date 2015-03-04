/*
 * General header file for Icemap
 * Copyright (C) 2014  Matthew Skala
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

void parse(void);

/**********************************************************************/

/* arrows.c */

typedef enum _DUPE_PRIORITY {
   dp_error,dp_first,dp_last,dp_min,dp_max
} DUPE_PRIORITY;

typedef struct _ARROW_MAP {
   NODE **arrows;
   int num_arrows,num_buckets;
} ARROW_MAP;

void arrow_map_new(ARROW_MAP *am);
void arrow_map_copy(ARROW_MAP *zm,ARROW_MAP *am);
void arrow_map_delete(ARROW_MAP *am);
NODE *arrow_map_lookup(ARROW_MAP *am,NODE *k);

int raw_add_arrow(ARROW_MAP *am,NODE *k,NODE *v,DUPE_PRIORITY dp);

void add_one_arrow(PARSER_STATE *ps);
void add_many_arrows(PARSER_STATE *ps);

/**********************************************************************/

/* context.c */

typedef struct _CONTEXT {
   struct _CONTEXT *parent;
   char *id;
   ARROW_MAP am;
   DUPE_PRIORITY dupe_priority;
   char *skip_regex,*parse_regex;
} CONTEXT;

extern CONTEXT *context_stack;

void handle_opening_brace(PARSER_STATE *ps);
void handle_closing_brace(PARSER_STATE *ps);

/**********************************************************************/

/* rxparse.c */

void handle_rxparse(PARSER_STATE *ps);
