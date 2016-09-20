#!/bin/bash

#Updates the rrd, should be run with t <= highest frequency stored.

export path='/var/log/squeue_job_status.rrd'                                 #path to the rrd file
export running=$(squeue | awk '$5~/R/ {print $5}' | wc | awk '{print $1}')   ##processes running
export pending=$(squeue | awk '$5~/Pd?/ {print $5}' | wc | awk '{print $1}') ##processes pending

sudo rdtool update $path "N:$running:$pending"
