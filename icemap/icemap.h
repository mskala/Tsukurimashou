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
   int x,y,z;
} NODE;

NODE *node_new(void);
void node_delete(NODE *n);

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

/* context.c */

typedef enum _DUPE_PRIORITY {
   dp_error,dp_first,dp_last,dp_min,dp_max
} DUPE_PRIORITY;

typedef struct _CONTEXT {
   struct _CONTEXT *parent;
   char *id;
   NODE **arrows;
   int num_arrows,max_arrows;
   DUPE_PRIORITY dupe_priority;
   char *skip_regex,*parse_regex;
} CONTEXT;

extern CONTEXT *context_stack;

void handle_opening_brace(PARSER_STATE *ps);
void handle_closing_brace(PARSER_STATE *ps);

/**********************************************************************/

/* arrows.c */

void raw_add_arrow(PARSER_STATE *ps,NODE *k,NODE *v);
void add_one_arrow(PARSER_STATE *ps);
void add_many_arrows(PARSER_STATE *ps);
