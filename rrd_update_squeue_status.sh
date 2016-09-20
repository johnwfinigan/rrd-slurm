#!/bin/bash

#Updates the rrd, should be run with t <= highest frequency stored.

RRDFILE_PATH='./squeue_job_status.rrd'                                 #path to the rrd file
running=$(squeue | awk '$5~/R/ {print $5}' | wc | awk '{print $1}')   ##processes running
pending=$(squeue | awk '$5~/Pd?/ {print $5}' | wc | awk '{print $1}') ##processes pending

rdtool update $RRDFILE_PATH "N:$running:$pending"
