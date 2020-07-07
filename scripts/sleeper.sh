#!/bin/sh

while true
do
    if [ -f /tmp/stop ]
    then
        exit 0
    fi
    date "+%H:%M:%S"
    sleep 5
done
