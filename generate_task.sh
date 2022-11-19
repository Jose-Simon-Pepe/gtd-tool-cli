#!/bin/bash

source utils/format.sh

generateTask() {
  clear
  sectionHeader
  # setting todo
  talk "insert the task todo"
  IFS='\n' read todo
  # setting task priority
  talk "insert the task priority"
  echo "1 for high, 2 for medium, 3 for low"
  read -n 1 -s priority
  # seeting task project
  validProyect=0
  listAllProyects
    while [ "$validProyect" = 0 ]; do
          talk "insert the proyect related (for create one just tipe and enter) "
    IFS='\n' read proyect 
    relatedProyect=$(grep -l "$proyect" proyects/*)
    proyectName="$(grep  -i "name= " "$relatedProyect" | sed 's/name= //g' )"
    if [[ ! -z "$proyectName" ]]; then
        proyect="$proyectName"
        validProyect=1
    else
        insertProyect $proyect
        validProyect=$?
    fi
  done
  if [[ "$validProyect" = 2 ]]; then
    sectionHeader
  fi
  # setting task deadline
  echo "insert the task deadline (if has not just pass this)"
  read deadline 
  if [[ -z "$deadline" ]]; then
    deadline="none"
  fi
  # setting this day
  validThisDay=0
  while [ "$validThisDay" = 0 ]; do 
  echo "insert if the task is a current day goal (y/n)"
    read -n 1 -s today
    if [ "$today" != 'y' ] && [ "$today" != 'n' ] ; then
      talk "invalid selection"
      validThisDay=0
    else
      validThisDay=1
  fi;
  done;
  insertData   
  read no
  clear
}

listAllProyects (){
    for FILE in proyects/*; do
      id=$(grep -r 'id=' "$FILE")
      name=$(grep -r 'name=' "$FILE") 
      echo $id " " $name
    done
}

insertProyect (){
  relatedProyect=$(grep -l $1 proyects/*)
  proyectName="$(grep  -i "name= " "$relatedProyect" | sed 's/name= //g' )"
  echo "se relaciona con proy "$proyectName

  if [[ -z "$relatedProyect" ]]; then
    talk "do you wanna create a new proyect called "$1" ? (y/n)" 
     read -n 1 -s wants 
    if [[ "$wants" == "y" ]]; then
      ./generate_proyect.sh $1
      return 2
    else
      talk "proyect wasn't created"
    fi
 else 
   return 1
  fi
}


insertData(){
  id=0
  path=~/gtd/tasks/
  id=`./utils/id_generator.sh $path`
  echo "el id de la tarea es: "$id
  taskPath=$path$id".task"
  echo el path es "$taskPath"
  touch $taskPath
  echo "id= ""$id" >> "$taskPath"
  echo "todo= ""$todo" >> "$taskPath"
  echo "priority= ""$priority" >> "$taskPath"
  echo "proyect= ""$proyect" >> "$taskPath"
  echo "deadline= ""$deadline" >> "$taskPath"
  echo "today= "$today >> "$taskPath"
}

generateTask
