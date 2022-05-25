#!/bin/bash

# To execute only as root user.

if [ $UID -ne 0 ]
then
        echo "You are not a root user. Execute this script only as root user."
        exit 1
fi

# Get the username
read -p 'Enter the username: ' USER_NAME
# Get the full/real name.
read -p 'Enter the real name: ' COMMENT
# Get the password
read -p 'Enter the password for the account: ' PASSWORD

# Creating the user

useradd -c "$COMMENT" -m $USER_NAME

# Check to see if the useradd command succeeded.
if [ $? -ne 0 ]
then
        echo "Sorry, user creation is not succesful."
        exit 1
fi

# Setting the password.

echo $PASSWORD | passwd --stdin $USER_NAME

# Check to see if the passwd command succeeded.

if [ $? -ne 0 ]
then
        echo "Password not created succesfully."
        exit 1
fi

# Force password change on first login.
passwd -e $USER_NAME

# Display the username, password, and the host where the user was created.
echo
echo "The username is: $USER_NAME"
echo
echo "The password is: $PASSWORD"
echo
echo "host: $(hostname)"
echo
echo "*****************"
