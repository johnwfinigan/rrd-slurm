#!/bin/bash

RRDFILENAME_TEMPLATE="squeue_job_status_"
IMGTYPE="PNG"
COL_BLACK="#000000"
COL_RED="#ff0000"
COL_GREEN="#00ff00"
COL_GREEN_DARK="#006400"
COL_BLUE="#0000ff"
COL_BLUE_DARK="#00008B"

for PARTITION in `sinfo -h -o "%R"`; do
    OUTFILE=$RRDFILENAME_TEMPLATE$PARTITION

#One Day 
    rrdtool graph $OUTFILE"_daily."$IMGTYPE -a $IMGTYPE --start N-1D --end N --title="$PARTITION Daily Queue Depth" \
    --vertical-label "#Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=1" \
    "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=1" "DEF:probe3=$OUTFILE.rrd:Pending:MAX:step=1" \
    "DEF:probe4=$OUTFILE.rrd:Pending:MAX:step=1" "LINE1:probe1$COL_GREEN:Running" "LINE1:probe2$COL_BLUE:Pending" \
    "LINE1:probe3$COL_GREEN_DARK:Running max" "LINE1:probe4$COL_BLUE_DARK:Pending max"

#5 Days
    rrdtool graph $OUTFILE"_5days."$IMGTYPE -a $IMGTYPE  --start N-5D --end N --title="$PARTITION 5 Day Queue Depth" \
    --vertical-label "Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=6" \
     "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=6" "DEF:probe3=$OUTFILE.rrd:Pending:MAX:step=6" \
     "DEF:probe4=$OUTFILE.rrd:Pending:MAX:step=6" "LINE1:probe1$COL_GREEN:Running" "LINE1:probe2$COL_BLUE:Pending" \
     "LINE1:probe3$COL_GREEN_DARK:Running max" "LINE1:probe4$COL_BLUE_DARK:Pending max"


#3 Months
    rrdtool graph $OUTFILE"_3months."$IMGTYPE -a $IMGTYPE --start N-93D --end N --title="$PARTITION 3 Month Queue Depth" \
    --vertical-label "Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=24" \
     "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=24" "DEF:probe3=$OUTFILE.rrd:Pending:MAX:step=24" \
     "DEF:probe4=$OUTFILE.rrd:Pending:MAX:step=24" "LINE1:probe1$COL_GREEN:Running" "LINE1:probe2$COL_BLUE:Pending" \
     "LINE1:probe3$COL_GREEN_DARK:Running max" "LINE1:probe4$COL_BLUE_DARK:Pending max"


#2 Years
    rrdtool graph $OUTFILE"_2years."$IMGTYPE -a $IMGTYPE --start N-2Y --end N --title="$PARTITION 2 Year Queue Depth" \
    --vertical-label "Jobs" "DEF:probe1=$OUTFILE.rrd:Running:AVERAGE:step=288" \
     "DEF:probe2=$OUTFILE.rrd:Pending:AVERAGE:step=288" "DEF:probe3=$OUTFILE.rrd:Pending:MAX:step=288" \
     "DEF:probe4=$OUTFILE.rrd:Pending:MAX:step=288" "LINE1:probe1$COL_GREEN:Running" "LINE1:probe2$COL_BLUE:Pending" \
     "LINE1:probe3$COL_GREEN_DARK:Running max" "LINE1:probe4$COL_BLUE_DARK:Pending max"

done
