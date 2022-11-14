#!/bin/bash

source utils/format.sh

index(){
  talk "looking for updates"
  #git pull origin main
  menu
}

menu (){
  todo=0
  while [[ $todo -ne 6 ]]; do
    clear
    sectionHeader
    talk "welcome "$USER" to gtd cli tool :)"
    talk "what would you like to do?"
    space
    echo "·-~=o(|1|) add a proyect"
    echo "·-~=o(|2|) add a task"
    echo "·-~=o(|3|) clean datastores"
    echo "·-~=o(|4|) list your data"
    echo "·-~=o(|5|) enter input to inputbox"
    echo "·-~=o(|6|) exit"
    space
    read -n 1 -s todo
    if [ "$todo" == "1" ]; then ./generate_proyect.sh;
    elif [ "$todo" == "2" ]; then ./generate_task.sh;
    elif [ "$todo" == "3" ]; then cleanData;
    elif [[ "$todo" == "4" ]]; then listData;
    elif [[ "$todo" == "5" ]]; then enterInput;
    elif [ "$todo" == "6" ]; then 
	    echo "getting closed. goodbye!";
	    read none
      cd ~
	    clear
    else echo "wrong input. Try again"; fi;
  done
  }


enterInput(){
  clear
  sectionHeader
  talk "insert the data"
  read data && touch inputs/"$data"
}

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

cleanData (){
  into=1
  while [[ $into = 1 ]]; do
    clear
    sectionHeader
    Red=$'\e[0;31m'
    Green=$'\e[0;32m'
    Blue=$'\e[0;34m'
    White=$'\e[0;97m'
    echo "$Red "
    talk "attention! data removing is not undoable"
    talk "pay carefully attention to what you will do"
    space
    talk "what do you want to remove?"
    echo "a) all your personal data"
    echo "b) all your proyects"
    echo "c) all your responsabilities"
    echo "d) all your tasks"
    echo "e) go back"
    space
    read -n 1 -s toRemove
    if [[ "$toRemove" == "a" ]]; then
      rm -i  proyects/*
      rm -i  inputs/*
      rm -i  responsabilities/*
      rm -i  tasks/*
    elif [[ "$toRemove" == "b" ]]; then
      rm -i proyects/*
    elif [[ "$toRemove" == "c" ]]; then
      rm -i responsabilities/*
    elif [[ "$toRemove" == "d" ]]; then
      rm -i tasks/*
    elif [[ "$toRemove" == "e" ]]; then
      into=0
    fi
    echo "$White"
  done
}

index 
