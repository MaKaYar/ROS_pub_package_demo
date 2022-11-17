#!/bin/bash
cpuConsumingFunc()
{
    dd if=/dev/urandom | bzip2 -9 >> /dev/null;
}

max_cpu=$(grep -c ^processor /proc/cpuinfo)
cpu_to_load=$((max_cpu/2))
echo "Try to load $cpu_to_load logical cores"
fulload()
{
    x=0
    while [ $x -lt $cpu_to_load ]; do
        cpuConsumingFunc&
        let x=x+1 
    done
};
echo "Starting CPU load" 
fulload;
echo "Press enter to stop CPU load"
read;
echo "CPU load stopped"
killall dd