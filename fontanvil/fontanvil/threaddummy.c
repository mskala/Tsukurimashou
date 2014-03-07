/* $Id: threaddummy.c 2918 2014-03-07 16:09:49Z mskala $ */
#include <stdio.h>
void pthread_create() {
   printf
      ("You are about to die! attempt to use pthreads in something not linked\n with them\n");
}
