#!/bin/bash

RRDFILE_PATH='./squeue_job_status.rrd'

#One Day 
rrdtool graph squeue_job_status_daily.png -a PNG --title="Daily Job Status" --vertical-label "#Jobs" 'DEF:probe1=squeue_job_status.rrd:Running:AVERAGE:step=1' 'DEF:probe2=squeue_job_status.rrd:Pending:AVERAGE:step=1' 'LINE1:probe1#00ff00:Running' 'LINE1:probe2#0400ff:Pending'


#5 Days
rrdtool graph squeue_job_status_5days.png -a PNG --start N-5D --end N --title="5 Day Job Status" --vertical-label "Jobs" 'DEF:probe1=squeue_job_status.rrd:Running:AVERAGE:step=10' 'DEF:probe2=squeue_job_status.rrd:Pending:AVERAGE:step=10' 'LINE1:probe1#00ff00:Running' 'LINE1:probe2#0400ff:Pending'

#3 Months
rrdtool graph squeue_job_status_3month.png -a PNG --start N-93D --end N --title="3 Month Job Status" --vertical-label "Jobs" 'DEF:probe1=squeue_job_status.rrd:Running:AVERAGE:step=2880' 'DEF:probe2=squeue_job_status.rrd:Pending:AVERAGE:step=2880' 'DEF:probe3=squeue_job_status.rrd:Running:MAX:step=2880' 'DEF:probe4=squeue_job_status.rrd:Pending:MAX:step=2880' 'LINE1:probe1#00ff00:Running Average' 'LINE1:probe2#0400ff:Pending Average' 'LINE1:probe4#00ffff:Pending Max' 'LINE1:probe3#04ff00:Running Max'
