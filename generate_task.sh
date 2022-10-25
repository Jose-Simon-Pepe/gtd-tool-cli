#!/bin/bash

path=~/gtd/tasks/
name=$1
taskPath=$path$name".task"
id=0
priority=$2
area=$3
deadline=$4

touch $taskPath
echo "id= "$id >> $taskPath
echo "name= "$name>> $taskPath
echo "priority= "$priority >> $taskPath
echo "area= "$area >> $taskPath
echo "deadline= "$deadline >> $taskPath
