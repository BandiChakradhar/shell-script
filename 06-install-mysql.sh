#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "error: user must have sudo access"
fi

dnf install mysql -y

