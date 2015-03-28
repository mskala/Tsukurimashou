/* $Id: bezctx_ff.h 3879 2015-03-28 11:08:16Z mskala $ */
#include "spiroentrypoints.h"
#include "bezctx.h"

bezctx *new_bezctx_ff(void);

struct splinepointlist;

struct splinepointlist *bezctx_ff_close(bezctx * bc);
