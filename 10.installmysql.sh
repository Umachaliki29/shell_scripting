#!/bin/bash
USERID=$(id -u)  # Check with root access 
if[ $USERID -ne 0 ] # If root user proceed to install
then 
    echo "ERROR::please run with root access"  # else show the error as please run with root access
    exit 1 # give other than 0 upto 127
else 
    echo "you are running with root access"
fi
dnf install mysql -y
