

function separator {
 echo "~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·~·"
}

function space {
  echo ""
}

function talk (){ 
  echo "> "$@
}

function logo {
  cat utils/logo.txt
}

function sectionHeader (){ 
  separator 
  logo
  echo 
  separator
  space
}
