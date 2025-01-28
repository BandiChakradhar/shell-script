#!/bin/bash

NUMBER=$1

if [ $NUMBER -gt 100 ]
then
    echo "given number is greater than 100"
else
    echo "number is less than 100"
fi

