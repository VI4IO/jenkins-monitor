#!/bin/bash

TITLES=""
VALUES=""

for BTYPE in basic advanced ; do
for log in $HOME/workspace/ior/test_logs/$BTYPE/*
do
    NUMBER="${log##*.}"
    i=1
    enable=0
    extra=""
    while read LINE
    do
        if [[ $LINE == "Summary of all tests:" ]] ; then
          enable=1
        fi
        if [[ $enable == 0 ]] ; then
          continue
        fi
        SPEED=$(echo $LINE | awk '{print $2}')
        if [[ $i != 1 ]] ; then
          extra="-$i"
        fi
        if [[ $LINE == read* ]]; then
            i=$(($i+1))
            TITLES="$TITLES, $NUMBER-read$extra"
            VALUES="$VALUES, $SPEED"
        elif [[ $LINE == write* ]]; then
            i=$(($i+1))
            TITLES="$TITLES, $NUMBER-write$extra"
            VALUES="$VALUES, $SPEED"
        fi
    done < <(cat $log)
done

FILE=benchmark_ior-$BTYPE.csv
rm -f $FILE
echo $TITLES | cut -b3- >> $FILE
echo $VALUES | cut -b3- >> $FILE

done
