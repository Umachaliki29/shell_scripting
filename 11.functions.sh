#!/bin/bash  # This indicates that the script should run using the bash shell

# Get the user ID of the person running the script
USERID=$(id -u)  # `id -u` returns 0 if root, otherwise a non-zero number

# Check if the script is being run as root (user ID 0)
if [ $USERID -ne 0 ]  # If the user ID is not 0, then the user is not root
then
    echo "ERROR:: Please run this script with root access"  # Print error message
    exit 1  # Exit the script with a non-zero status to indicate failure
else
    echo "You are running with root access"  # Inform the user that they have root privileges
fi

# Define a function to validate the success or failure of a command
# Takes two parameters: $1 = exit status of the command, $2 = name of the package
VALIDATE(){
    if [ $1 -eq 0 ]  # If the exit status is 0, the command succeeded
    then
        echo "Installing $2 is ... SUCCESS"  # Print success message for the package
    else
        echo "Installing $2 is ... FAILURE"  # Print failure message for the package
        exit 1  # Exit the script due to failure
    fi
}

# Check if MySQL is already installed using dnf
dnf list installed mysql  # List installed packages and check for 'mysql'
if [ $? -ne 0 ]  # If the exit status is not 0, MySQL is not installed
then
    echo "MySQL is not installed... going to install it"  # Inform user
    dnf install mysql -y  # Install MySQL without prompting for confirmation
    VALIDATE $? "MySQL"  # Call the validation function with the status and package name
else
    echo "MySQL is already installed...Nothing to do"  # Inform user
fi

# Check if python3 is already installed
dnf list installed python3  # Check for python3 installation
if [ $? -ne 0 ]  # If not installed
then
    echo "python3 is not installed... going to install it"  # Inform user
    dnf install python3 -y  # Install python3
    VALIDATE $? "python3"  # Validate the result of the installation
else
    echo "python3 is already installed...Nothing to do"  # Inform user
fi

# Check if nginx is already installed
dnf list installed nginx  # Check for nginx installation
if [ $? -ne 0 ]  # If nginx is not installed
then
    echo "nginx is not installed... going to install it"  # Inform user
    dnf install nginx -y  # Install nginx
    VALIDATE $? "nginx"  # Validate installation
else
    echo "nginx is already installed...Nothing to do"  # Inform user
fi
