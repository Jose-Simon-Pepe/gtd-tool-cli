secuencialId(){
    id=0
    if [ "$(ls -A $1)" ]; then
        lastFile=$(ls -tp $1 | grep -v / | head -n1)
        lastFilePath=$1$lastFile
        id=$(grep -i 'id= ' $lastFilePath | sed 's/id= //g' )
        id=$(($id+1))
    fi
    echo $id 
}

secuencialId $1
