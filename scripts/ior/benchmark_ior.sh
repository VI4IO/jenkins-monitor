#!/bin/bash

TITLES=""
VALUES=""
for log in test_logs/*
do
    NUMBER="${log##*.}"
    i=0
    while read LINE
    do
        i=$(($i+1))
        SPEED=$(echo $LINE | awk '{print $2}')
        if [[ $LINE == Read* ]]; then
            TITLES="$TITLES, $NUMBER (READ $i)"
            VALUES="$VALUES, $SPEED"
        elif [[ $LINE == Write* ]]; then
            TITLES="$TITLES, $NUMBER (WRITE $i)"
            VALUES="$VALUES, $SPEED"
        fi
    done < <(cat $log | grep -E "^(Max Read|Max Write)" | cut -b5-    )
done

FILE=benchmark_ior.csv
rm -f $FILE
echo $TITLES | cut -b3- >> $FILE
echo $VALUES | cut -b3- >> $FILE
