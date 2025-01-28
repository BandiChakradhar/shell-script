#!/bib/bash

echo "all variables passed: $@"
echo "number of variables: $#"
echo "script name: $0"
echo "present working directory: $PWD"
echo "home dir of curr user: $HOME"
echo "which user is running thios script: $USER"
echo "process id of curr script: $$"
sleep 60 &
echo "process is of last command in background: $!"