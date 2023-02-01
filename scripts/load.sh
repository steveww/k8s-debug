#!/bin/sh

BATCH_SIZE=5

while true
do
        # random number between 1 and 12
        LIMIT=$(shuf -i 1-12 -n 1)
        if [ $LIMIT -eq 1 ]
        then
            # force crash loop
            for CRASH in $(seq 5)
            do
                for SEQ in $(seq 20)
                do
                    curl -s "http://leaky.test:8080/batch?count=$BATCH_SIZE"
                    echo ''
                    sleep 1
                done
            done
        else
            for SEQ in $(seq $LIMIT)
            do
                    curl -s "http://leaky.test:8080/batch?count=$BATCH_SIZE"
                    echo ''
                    sleep 1
            done
            curl -s http://leaky.test:8080/free
            echo ''
        fi
done

