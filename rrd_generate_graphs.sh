#!/bin/bash

RRDFILENAME_TEMPLATE="squeue_job_status_"
IMGTYPE="PNG"

for PARTITION in `sinfo -h -o "%R"`; do
    OUTFILE=$RRDFILENAME_TEMPLATE$PARTITION

#One Day 
    rrdtool graph $OUTFILE"_daily."$IMGTYPE -a $IMGTYPE --title="$PARTITION Daily Queue Depth" --vertical-label "#Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=1" "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=1" "LINE1:probe1#00ff00:Running" "LINE1:probe2#0400ff:Pending"
    
    
    #5 Days
    rrdtool graph $OUTFILE"_5days."$IMGTYPE -a $IMGTYPE  --start N-5D --end N --title="$PARTITION 5 Day Queue Depth" --vertical-label "Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=10" "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=10" "LINE1:probe1#00ff00:Running" "LINE1:probe2#0400ff:Pending"
    
    #3 Months
    rrdtool graph $OUTFILE"_3months."$IMGTYPE -a $IMGTYPE --start N-93D --end N --title="$PARTITION 3 Month Queue Depth" --vertical-label "Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=2880" "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=2880" "DEF:probe3=$OUTFILE.rrd:Running:MAX:step=2880" "DEF:probe4=$OUTFILE.rrd:Pending:MAX:step=2880" "LINE1:probe1#00ff00:Running Average" "LINE1:probe2#0400ff:Pending Average" "LINE1:probe4#00ffff:Pending Max" "LINE1:probe3#f0ff00:Running Max"
done
