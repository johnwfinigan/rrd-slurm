#!/bin/bash

RRDFILENAME_TEMPLATE="squeue_job_status_"
IMGTYPE="PNG"

for PARTITION in `sinfo -h -o "%R"`; do
    OUTFILE=$RRDFILENAME_TEMPLATE$PARTITION

#One Day 
    rrdtool graph $OUTFILE"_daily."$IMGTYPE -a $IMGTYPE --start N-1D --end N --title="$PARTITION Daily Queue Depth" \
    --vertical-label "#Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=1" \
    "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=1" "LINE1:probe1#00ff00:Running" "LINE2:probe2#0400ff:Pending"

#5 Days
    rrdtool graph $OUTFILE"_5days."$IMGTYPE -a $IMGTYPE  --start N-5D --end N --title="$PARTITION 5 Day Queue Depth" \
    --vertical-label "Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=6" \
    "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=6" "LINE1:probe1#00ff00:Running" "LINE2:probe2#0400ff:Pending"
    
#3 Months
    rrdtool graph $OUTFILE"_3months."$IMGTYPE -a $IMGTYPE --start N-93D --end N --title="$PARTITION 3 Month Queue Depth" \
    --vertical-label "Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=24" \
    "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=24" "LINE1:probe1#00ff00:Running" "LINE2:probe2#0400ff:Pending"

#2 Years
    rrdtool graph $OUTFILE"_2years."$IMGTYPE -a $IMGTYPE --start N-2Y --end N --title="$PARTITION 2 Year Queue Depth" \
    --vertical-label "Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=288" \
    "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=288" "LINE1:probe1#00ff00:Running" "LINE2:probe2#0400ff:Pending"
done
