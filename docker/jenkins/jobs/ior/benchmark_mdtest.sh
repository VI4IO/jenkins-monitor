#!/bin/bash

DIRECTORY=""
DIRECTORY_VALUE=""
FILE=""
FILE_VALUE=""
TREE=""
TREE_VALUE=""

for BTYPE in basic advanced ; do
for log in /home/www-jenkins/git/docker/jenkins/workspace/ior/test_logs/$BTYPE/*
do
    NUMBER="${log##*.}"
    while read LINE
    do
	SPEED=$(echo "$LINE" | cut -b 23-40 )
	TYPE=$(echo "$LINE" | cut -b -26 )
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
    done < <(cat $log| grep -E "^   (Directory|File|Tree)")
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
