#!/bin/bash

source utils/format.sh
source utils/list.sh

index(){
  talk "looking for updates"
  git pull origin main
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
