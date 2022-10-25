#!/bin/bash

path=~/gtd/tasks/
todo=$1
taskPath=$path$name".task"
id=0
priority=$2
proyect=$3
deadline=$4
today=$5

touch $taskPath
echo "id= "$id >> $taskPath
echo "todo= "$todo >> $taskPath
echo "priority= "$priority >> $taskPath
echo "proyect= "$proyect >> $taskPath
echo "deadline= "$deadline >> $taskPath
echo "today= "$today >> $taskPath
