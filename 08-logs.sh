#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 failure"
        exit 1
    else 
        echo "$2 success"
    fi
}

echo "script executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ]
then
    echo "error: user must have sudo access"
    exit 1
fi

dnf list installed mysql &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then
   dnf install mysql -y &>>$LOG_FILE_NAME
   VALIDATE $? "installing mysql"
else 
    echo "mysql already installed"
fi


dnf list installed git &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then
   dnf install git -y &>>$LOG_FILE_NAME
    VALIDATE $? "installing git"
else 
    echo "git already installed"
fi





