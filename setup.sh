#!/bin/bash
echo "insert your installation directory (enter for default installation directory in ~/)"
read directory 
#verifiyng path
if [ -z "$directory" ]; then
  directory=$~
elif [ -d "$directory" ]; then
  echo "it will be used "$directory" as installation directory"
else
  echo "directory does not exist"
fi
# creating directories
installPath=$directory"/gtdtool"
cd $directory
git clone # proyect repository
cd gtdtool
chmod +x generate_project.sh gtd.sh generate_task.sh 
# creating alias 
echo "if you wanna create an alias for gtd starting, enter your user password. Otherwise, you will need to run ./"$installPath"/gtd.sh each time."
sudo echo "alias gtd='./"$installPath"/gtd.sh'" >> $~/.bashrc
# verifiyng that every folder has been created
if [ -d "$installPath"/proyects/ ] && [ -d "$installPath"/utils/ ] && [ -d "$installPath"/inputs/ ] && [ -d "$installPath"/responsabilities ] $$ [ -d "$installPath"/tasks ]
  echo "folders successfully created"
  echo 'you can exec the "gtd" command to start enjoining gtdtool. Created by jose pepe'
  echo "If you have any questions/suggestions about the program, please do not hesitate to contact me sending email to jose.s.contacto@gmail.com"
else
  echo "installation error. Rollback"
  rm -r -i installPath
fi
