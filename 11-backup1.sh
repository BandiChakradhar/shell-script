#!/bin/bash


SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
LOGS_FOLDER="/home/ec2-user/shellscript-logs"
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

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "error: user must have sudo access"
        exit 1
    fi
}


USAGE(){
    echo -e "USAGE:: sh 10-backup.sh <source_dir> <dest_dir> <days(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURDE_DIR ]
then
    echo -e "$SOURCE_DIR doesnot exist.please check"
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$DEST_DIR doesnot exist.please check"
fi

echo "script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)


if [ -n "$FILES" ]
then
    echo "files are: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
else
    echo " no files found older than $DAYS"
    exit 1
fi

if [ -f "$ZIP_FILE" ]
then
    echo -e "successfully created zip file for older than $DAYS"
    while read -r filepath
    do
        echo "deleting file: $filepath" &>>$LOG_FILE_NAME
        rm -rf $FILES
        echo "deleted file: $filepath"
    done <<< $FILES
else
    echo -e "error: failed to create zip file"
    exit 1
fi