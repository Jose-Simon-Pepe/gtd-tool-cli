#!/bin/bash


index(){
  talk "looking for updates"
  git pull origin main
  clear
  separator
  cat utils/logo.txt
  echo ""
  talk "welcome "$USER" to gtd cli tool"
  menu
}

menu (){
  todo=0
  while [[ $todo -ne 3 ]]; do
    talk "what would you like to do?"
    space
    echo "1) add a proyect"
    echo "2) add a task"
    echo "3) exit"
    space
    read todo
    if [ "$todo" == "1" ]; then generateProyect;
    elif [ "$todo" == "2" ]; then echo "dos";
    elif [ "$todo" == "3" ]; then 
	    echo "getting closed. goodbye!";
	    read none
	    clear
    else echo "wrong input. Try again"; fi;
  done
  }

generateProyect() {
  clear 
  space
  separator
  talk "insert the proyect name"
  read name
  talk "insert the proyect priority"
  echo "1 for high, 2 for medium, 3 for low"
  read priority
  validArea=0
  while [ "$validArea" = 0 ]; do
        talk "insert the proyect responsability area (for create one just tipe and enter) "
        read area
	insertRespo $area
  validArea=$?
  done
  echo "insert the proyect deadline (if has not just pass this)"
  read deadline 
  if [[ -z "$deadline" ]]; then
    deadline="none"
  fi
  validThisWeek=0
  while [ "$validThisWeek" = 0 ]; do 
  echo "insert if the proyect is a current week goal (y/n)"
  read thisWeek
    if [ "$thisWeek" != 'y' ] && [ "$thisWeek" != 'n' ] ; then
      talk "invalid selection"
      validThisWeek=0
    else
      validThisWeek=1
  fi;
  done;
}


 insertRespo (){
  if [[ -f "responsabilities/""$1"".resp" ]];
  then 
   return 1
  else 
    talk "do you wanna create a new resp called "$1" ? (y/n)" ;
   read wants 
   if [[ "$wants" == "y" ]]; then
     touch "responsabilities/"$1".resp"
     talk "yay you've got a new resp area"
     return 1
   else
     talk "responsability wasn't created"
   fi
  fi
}

function separator {
  echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
}

function space {
  echo ""
}

function talk (){ 
  echo "> "$@
}


index 
