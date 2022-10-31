#!/bin/bash

source utils/format.sh


generateProyect() {


      clear
      sectionHeader


      nameHasBeenAsigned=y

      if [[ -z "$1" ]]; then
        nameHasBeenAsigned=f
      fi


      if [[ "$nameHasBeenAsigned" == f ]]; then
        talk "insert the proyect name"
        IFS='\n' read name 
      else
        name=$1
        talk "proyect name has been setted as "$1
      fi
      
      talk "insert the proyect priority"
      echo "1 for high, 2 for medium, 3 for low"
      read -n 1 -s priority
      validArea=0
      while [ "$validArea" = 0 ]; do
            talk "insert the proyect responsability area (for create one just tipe and enter) "
              IFS='\n' read area 
      validArea=`./generate_respo.sh $area`
      if [[ "$validArea" = 2 ]]; then
        talk "do you wanna create a new resp called "$area" ? (y/n)"
          read -n 1 -s wants 
        if [[ "$wants" == "y" ]]; then
          touch "responsabilities/"$area".resp"
          talk "yay you've got a new resp area"
          validArea=1
        else
          talk "responsability wasn't created"
          validArea=0
        fi
      fi
      done
      echo "insert the proyect deadline (if has not just pass this)"
      read deadline 
      if [[ -z "$deadline" ]]; then
        deadline="none"
      fi
      validThisWeek=0
      while [ "$validThisWeek" = 0 ]; do 
      echo "insert if the proyect is a current week goal (y/n)"
        read -n 1 -s thisWeek
        if [ "$thisWeek" != 'y' ] && [ "$thisWeek" != 'n' ] ; then
          talk "invalid selection"
          validThisWeek=0
        else
          validThisWeek=1
      fi;
      done;

    insertData "$name" "$priority" "$area" "$deadline" "$thisWeek"
    clear

}

insertData(){
  path=~/gtd/proyects/
  name="$1"
  priority="$2"
  area="$3"
  deadline="$4"
  thisWeek="$5"
  #get a id for secuencial method 
  id=`./utils/id_generator.sh $path`
  echo "el id obtenido es: "$id
  proPath=$path$id".proyect"
  #insert the proyect data
  touch $proPath
  echo "id= ""$id" >> "$proPath"
  echo "name= ""$name" >> "$proPath"
  echo "priority= ""$priority" >> "$proPath"
  echo "area= ""$area" >> "$proPath"
  echo "deadline= ""$deadline" >> "$proPath"
  echo "thisWeek= ""$thisWeek" >> "$proPath"


}

generateProyect $1