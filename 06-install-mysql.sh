#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "error: user must have sudo access"
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
   dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "installing mysql failure"
        exit 1
    else 
        echo "installing mysql success"
    fi
else 
    echo "mysql already installed"
fi


# if [ $? -ne 0 ]
# then
#     echo "installing mysql failure"
#     exit 1
# else 
#     echo "installing mysql success"
# fi

dnf list installed git

if [ $? -ne 0 ]
then
   dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "installing git failure"
        exit 1
    else 
        echo "installing git success"
    fi
else 
    echo "git already installed"
fi


# dnf install git -y
# if [ $? -ne 0 ]
# then
#     echo "installing git failure"
#     exit 1
# else 
#     echo "installing git success"
# fi



