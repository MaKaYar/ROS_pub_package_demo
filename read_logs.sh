#!/bin/bash
tail -f logs/cpu_load.log |
while read line
do
    echo $line
done