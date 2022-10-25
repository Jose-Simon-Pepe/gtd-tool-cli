#!/bin/bash

path=~/gtd/proyects/
name=$1
proPath=$path$name".proyect"
id=0
priority=$2
area=$3
deadline=$4
thisWeek=$5

#get the last file 

if [ "$(ls -A $path)" ]; then
	lastFile= ls -tp | grep -v /$ |head -1
	echo $lastFile
fi

touch $proPath
echo "id= "$id >> $proPath
echo "name= "$name>> $proPath
echo "priority= "$priority >> $proPath
echo "area= "$area >> $proPath
echo "deadline= "$deadline >> $proPath
echo "thisWeek= "$thisWeek >> $proPath
