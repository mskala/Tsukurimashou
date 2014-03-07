/* $Id: bezctx_ff.h 2918 2014-03-07 16:09:49Z mskala $ */
#include "spiroentrypoints.h"
#include "bezctx.h"

bezctx *new_bezctx_ff(void);

struct splinepointlist;

struct splinepointlist *bezctx_ff_close(bezctx * bc);
