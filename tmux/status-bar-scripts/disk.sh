#!/bin/bash

case "$OSTYPE" in
    linux-gnu)
        io_line_count=`iostat -d -x -m | wc -l` ; 
        iostat -d -x -m 1 2 -z | tail -n +$io_line_count | grep -e "^sd[a-z].*" | awk 'BEGIN{rsum=0; wsum=0}{ rsum+=$6; wsum+=$7} END {print "IO: " rsum " " wsum " | "}'
        ;;
esac
