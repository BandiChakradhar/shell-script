#!/bin/bash

USERID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 failure"
        exit 1
    else 
        echo "$2 success"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "error: user must have sudo access"
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
   dnf install mysql -y
   VALIDATE $? "installing mysql"
else 
    echo "mysql already installed"
fi


dnf list installed git

if [ $? -ne 0 ]
then
   dnf install git -y
    VALIDATE $? "installing git"
else 
    echo "git already installed"
fi





