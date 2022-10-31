#!/bin/bash

source utils/format.sh

insertRespo (){
    resp=0
    if [[ -f "responsabilities/""$1"".resp" ]];
    then 
        resp=1
    else 
        resp=2
    fi
    echo $resp
}

insertRespo $1