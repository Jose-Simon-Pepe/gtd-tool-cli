#!/bin/bash
path=~/gtd/proyects/
name=$1
priority=$2
area=$3
deadline=$4
thisWeek=$5
#get a id for secuencial method 
id=`./utils/id_generator.sh $path`
echo "el id obtenido es: "$id
proPath=$path$name$id".proyect"
#insert the proyect data
touch $proPath
echo "id= "$id >> $proPath
echo "name= "$name>> $proPath
echo "priority= "$priority >> $proPath
echo "area= "$area >> $proPath
echo "deadline= "$deadline >> $proPath
echo "thisWeek= "$thisWeek >> $proPath
#usetting  
