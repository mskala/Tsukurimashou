#!/bin/bash

# infinite looping RMO operation on 32-bit Linux

ulimit -t 30
fontanvil/fontanvil -c 'Open("test/fonts/rmo-loop2.sfd");'\
'SelectAll();RemoveOverlap();'
