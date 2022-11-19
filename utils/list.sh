#!/bin/bash

listData(){
  back=0
  while [ $back -eq 0 ]; do
    clear
    sectionHeader
    talk "what kind of data do you wanna list?"
    space 
    echo "a) your tasks"
    echo "b) your proyects"
    echo "c) your inputs"
    echo "d) get back"
    read -n 1 -s toList
    case "$toList" in
      a) listTasks
      ;;
      b) listAllProyects
      ;;    
      c) listInputs
      ;;
      d) back=1
      ;;
      *) echo "wrong input"
      ;;
    esac
  done

}

#task

listTasks(){
    space
    talk "and you wanna list all your tasks, or only which are related to a particular proyect?"
    space
    echo "a) all"
    echo "b) all related to"
    space
    read -n 1 -s wanna
    if [ "$wanna" == "a" ]; then 
      listAllTasks;
    elif [ "$wanna" == "b" ]; then 
      listTasksRelatedProyect;
    else
      echo "wrong input. Try again"; 
      read no;
    fi;
}

listAllTasks(){
  for FILE in tasks/*; do
    id=$(grep -r 'id=' "$FILE")
    todo=$(grep -r 'todo=' "$FILE") 
    echo "$id" " " "$todo"
  done
  read no
}

listTasksRelatedProyect(){ 
 talk "enter proyect id to see all task related to and press enter"
 space
 listAllProyects
 space
 read proyToSearch
 listAllTaskRelatedTo "$proyToSearch"
}

listAllTaskRelatedTo(){
  idProject="$1"
  proj="$(grep -l 'id= '"$idProject" proyects/*)"
  projName=$(grep -i 'name= ' "$proj" | sed 's/name= //g')
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

#projects

listAllProyects(){
  space
  if [[ -z "$1" ]]; then
    for FILE in proyects/*; do
      id=$(grep -r 'id=' "$FILE")
      name=$(grep -r 'name=' "$FILE") 
      echo $id " " $name
    done
  space
  read no
  else
      grep -r "id= $1" proyects/ 
  fi
}

#inputs

listInputs(){
  space
  for n in inputs/*; do printf '%s\n' "$n"; done
  cd ..
  read s 
}


