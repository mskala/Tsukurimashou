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

/* where? */

void handle_opening_brace(void);
void handle_closing_brace(void);

/**********************************************************************/

/* parser.c */

struct _PARSER_STATE;

void parse_error(struct _PARSER_STATE *ps,char *message,...);
void parse(void);
