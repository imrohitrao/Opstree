#!/bin/bash

function=$1
agr1=$2
arg2=$3


# addTeam function
case "$function" in
    addTeam)
        group_name=$agr1
        if [ -z "$group_name" ]; then
            echo "❌ Invalid function. Use: addTeam <group_name>"
            exit 1
        fi

        # Check if the group already exists
        if getent group "$group_name" > /dev/null; then
            echo "❌ Group '$group_name' already exists."
            exit 1
        fi

        # Create the group
        sudo groupadd "$group_name"
        echo "✅ Group '$group_name' added successfully."
    ;;

# addUser function 
    addUser)
        if [ -z "$agr1" ] || [ -z "$agr2" ]; then
            echo "❌ Invalid usage. Correct format: addUser <group_name> <user_name>"
            exit 1
        fi

        group_name="$agr1"
        user_name="$agr2"

        if [ "$group_name" = "root" ] || [ "$user_name" = "root" ]; then
            echo "❌ Invalid input. Cannot use 'root' as group or user."
            exit 1
        fi

        sudo adduser "$user_name"
        sudo usermod -aG "$group_name" "$user_name"

        mkdir -p "/home/$user_name/team"
        chmod 751 "/home/$user_name/team"

        mkdir -p "/home/$user_name/ninja"
        chmod 751 "/home/$user_name/ninja"

        echo "✅ User '$user_name' added to group '$group_name' successfully."
        ;;
 esac