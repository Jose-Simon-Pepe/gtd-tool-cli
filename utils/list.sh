#!/bin/bash

listData(){
  clear
  sectionHeader
  talk "what kind of data do you wanna list?"
  space 
  echo "a) your tasks"
  echo "b) your proyects"
  echo "c) your inputs"
  read -n 1 -s toList
  if [ "$toList" == "a" ]; then listTasks;
  elif [ "$toList" == "b" ]; then listAllProyects;
  elif [ "$toList" == "c" ]; then listInputs;
  else echo "wrong input. Try again"; fi;
}

listTasks(){
 space
 talk "and do you wanna list all your tasks, or only which are related to a particular proyect?"
 space
 echo "a) all"
 echo "b) all related to"
 space
 read -n 1 -s wanna
  if [ "$wanna" == "a" ]; then listAllTasks;
  elif [ "$wanna" == "b" ]; then listTasksRelatedProyect;
  else echo "wrong input. Try again"; fi;
  read a
}

listAllTasks(){
   for FILE in tasks/*; do
    id=$(grep -r 'id=' "$FILE")
    todo=$(grep -r 'todo=' "$FILE") 
    echo $id " " $todo
  done
}

listTasksRelatedProyect(){ 
 talk "enter proyect id to see all task related to and press enter"
 space
 listAllProyects
 space
 read -s proyToSearch
 listAllTaskRelatedTo "$proyToSearch"
}

listInputs(){
  space
  cd inputs/
  for n in *; do printf '%s\n' "$n"; done
  cd ..
  read s 
}

listAllProyects(){
  if [[ -z "$1" ]]; then
    for FILE in proyects/*; do
      id=$(grep -r 'id=' "$FILE")
      name=$(grep -r 'name=' "$FILE") 
      echo $id " " $name
    done
  else
      grep -r "id= $1" proyects/ 
  fi
}

listAllTaskRelatedTo(){
  proj="$(grep -l "id= $1" proyects/*)"
  projName=$(grep -i 'name= ' $proj | sed 's/name= //g')
  tasks="$(grep -l "proyect= $projName" tasks/*)"
  for FILE in tasks/*; do
    found="$(grep -l "proyect= $projName" "$FILE")"
    if [[ ! -z "$found" ]]; then
    for FOUND in "$found"; do 
    idFound="$(grep -r "id=" "$found")"
    todoFound="$(grep -r "todo=" "$found" )"
      echo "$todoFound" "$idFound"
    done
  fi
  done
}
