#!/bin/bash

path=~/gtd/proyects/
name=$1
proPath=$path$name".proyect"
id=0
priority=$2
area=$3
deadline=$4

touch $proPath
echo "id= "$id >> $proPath
echo "name= "$name>> $proPath
echo "priority= "$priority >> $proPath
echo "area= "$area >> $proPath
echo "deadline= "$deadline >> $proPath
