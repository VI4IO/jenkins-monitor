#!/bin/bash

DIRECTORY=""
DIRECTORY_VALUE=""
FILE=""
FILE_VALUE=""
TREE=""
TREE_VALUE=""

for BTYPE in basic advanced ; do
for log in $HOME/workspace/ior/test_logs/$BTYPE/*
do
    NUMBER="${log##*.}"
    while read LINE
    do
	SPEED=$(echo $LINE | cut -f2- -d":" | cut -f2 -d ' ')
	TYPE=$(echo $LINE | cut -f1 -d":" | cut -f2 -d ' ')
        if [[ $LINE == Directory* ]]; then
            DIRECTORY="$DIRECTORY, $NUMBER-$TYPE"
            DIRECTORY_VALUE="$DIRECTORY_VALUE, $SPEED"
        elif [[ $LINE == File* ]]; then
            FILE="$FILE, $NUMBER-$TYPE"
            FILE_VALUE="$FILE_VALUE, $SPEED"
	elif [[ $LINE == Tree* ]]; then
            TREE="$TREE, $NUMBER-$TYPE"
            TREE_VALUE="$TREE_VALUE, $SPEED"
        fi
    done < <(cat $log | cut -b4- | grep -E "^(Directory|File|Tree)")
done

DIRECTORY_CSV=benchmark_mdtest_directory-$BTYPE.csv
rm -f $DIRECTORY_CSV
echo $DIRECTORY | cut -b3-  >> $DIRECTORY_CSV
echo $DIRECTORY_VALUE | cut -b3- >> $DIRECTORY_CSV

FILE_CSV=benchmark_mdtest_file-$BTYPE.csv
rm -f $FILE_CSV
echo $FILE | cut -b3-  >> $FILE_CSV
echo $FILE_VALUE | cut -b3- >> $FILE_CSV

TREE_CSV=benchmark_mdtest_tree-$BTYPE.csv
rm -f $TREE_CSV
echo $TREE | cut -b3-  >> $TREE_CSV
echo $TREE_VALUE | cut -b3- >> $TREE_CSV

done
