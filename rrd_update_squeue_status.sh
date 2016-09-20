#!/bin/bash

#creates the rrd if it does not already exist

RRDFILENAME_TEMPLATE="squeue_job_status_"

for PARTITION in `sinfo -h -o "%R"`; do
    if [ ! -f $RRDFILENAME_TEMPLATE$PARTITION".rrd" ] ; then              #No clobbering
        rrdtool create $RRDFILENAME_TEMPLATE$PARTITION".rrd" --start N-93D --step 30 DS:Running:GAUGE:600:0:U DS:Pending:GAUGE:600:0:U RRA:AVERAGE:0.5:10:1440 RRA:AVERAGE:0.5:1:2880 RRA:AVERAGE:0.5:2880:93 RRA:MAX:0.5:2880:93
    fi
done

#rrdtool create ./squeue_job_status.rrd -O --start N-93D --step 30    #No owrite, 30 second steps, should be <= update frequency
#DS:Running:GAUGE:600:0:U DS:Pending:GAUGE:600:0:U                    #Creates the guages for running and pending programs
#                                                                     ##with a 600 second heartbeat: time before assuming unkown
#RRA:AVERAGE:0.5:10:1440   #5 days, 5 min steps
#RRA:AVERAGE:0.5:1:2880    #1 day, 30 second steps
#RRA:AVERAGE:0.5:2880:93   #3 months, 1 day steps
#RRA:MAX:0.5:2880:93       #3 months, 1 day steps

#Updates the rrd, should be run with t <= highest frequency stored.

for PARTITION in `sinfo -h -o "%R"`; do
    running=$(squeue -h -o "%.18i %.9P %.8T" | awk '$3 == "RUNNING" && $2 == "${PARTITION}" {print $1}' | wc | awk '{print $1}')   ##processes running
    pending=$(squeue -h -o "%.18i %.9P %.8T" | awk '$3 == "PENDING" && $2 == "${PARTITION}" {print $1}' | wc | awk '{print $1}')   ##processes pending
    
    rrdtool update $RRDFILENAME_TEMPLATE$PARTITION".rrd"  "N:$running:$pending"
done
