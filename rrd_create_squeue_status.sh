#!/bin/bash
#Creates the squeue_job_status rrd
sudo rrdtool create /var/log/squeue_job_status.rrd --start N-93D --step 30 DS:Running:GAUGE:600:0:U DS:Pending:GAUGE:600:0:U RRA:AVERAGE:0.5:10:1440 RRA:AVERAGE:0.5:1:2880 RRA:AVERAGE:0.5:2880:93 RRA:MAX:0.5:2880:93

#rrdtool create /var/log/squeue_job_status.rrd --start N-93D --step 30  #30 second steps, should be <= update frequency
#DS:Running:GAUGE:600:0:U DS:Pending:GAUGE:600:0:U                      #Creates the guages for running and pending programs
#                                                                       ##with a 600 second heartbeat: time before assuming unkown
#RRA:AVERAGE:0.5:10:1440   #5 days, 5 min steps 
#RRA:AVERAGE:0.5:1:2880    #1 day, 30 second steps
#RRA:AVERAGE:0.5:2880:93   #3 months, 1 day steps
#RRA:MAX:0.5:2880:93       #3 months, 1 day steps
