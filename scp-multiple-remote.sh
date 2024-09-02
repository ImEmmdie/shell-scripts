#!/bin/bash

# Define a list of servers with numeric keys
declare -A servers
servers=(
    ["1"]="root@192.168.1.150"
    ["2"]="root@192.168.1.151"
    ["3"]="root@192.168.1.152"
    ["4"]="root@192.168.1.153"
    ["5"]="root@192.168.1.154"
    ["6"]="root@192.168.1.155"
    ["7"]="root@192.168.1.156"
    ["8"]="root@192.168.1.157"
    ["9"]="root@192.168.1.158"
    ["10"]="root@192.168.1.159"
    ["11"]="root@192.168.1.180"
    ["12"]="root@192.168.1.190"
)

# Display the list of servers
echo "Select the server you want to connect to:"
for key in "${!servers[@]}"; do
    echo "$key) ${servers[$key]}"
done

# Prompt the user to select a server by number
read -p "Enter the number corresponding to the server: " server_choice

# Validate the user's choice
if [[ ! ${servers[$server_choice]} ]]; then
    echo "Invalid choice. Exiting."
    exit 1
fi

# Assign the selected server to a variable
remote_server=${servers[$server_choice]}

# Prompt for the remote folder path
read -p "Enter the full path of the folder you want to copy from the remote server: " remote_folder_path

# Prompt for the local directory where the folder should be copied to
read -p "Enter the local directory where you want to copy the folder to: " local_directory

# Ensure the local directory exists
if [ ! -d "$local_directory" ]; then
    read -p "The local directory does not exist. Do you want to create it? (y/n): " create_dir
    if [ "$create_dir" == "y" ]; then
        mkdir -p "$local_directory"
        echo "Directory created."
    else
        echo "Exiting script."
        exit 1
    fi
fi

# Copy the folder using scp
scp -r "$remote_server":"$remote_folder_path" "$local_directory"

# Check if the scp command was successful
if [ $? -eq 0 ]; then
    echo "Folder copied successfully to $local_directory"
else
    echo "Failed to copy the folder."
fi
