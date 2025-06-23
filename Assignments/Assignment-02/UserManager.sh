#!/bin/bash

function=$1
agr1=$2
arg2=$3


# addTeam function
case "$function" in

    addTeam)
        group_name=$agr1
        sudo groupadd "$group_name"
        echo "✅ User added '$group_name' successfully."

        #echo "❌ Invalid function. \n Use: addTeam <group_name>"
    ;;

    addUser)
        group_name=$agr2
        user_name=$agr1
        sudo usermod -aG "$group_name" "$user_name"
        sudo addUser "$user_name"

        echo "✅✅ User '$user_name' added to group '$group_name' successfully."
        #echo -e "❌ Invalid function. addUser <group_name> <user_name>"
    ;;

 esac 