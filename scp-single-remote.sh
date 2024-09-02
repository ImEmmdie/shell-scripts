#!/bin/bash

# Prompt for user input
read -p "Enter the remote server username: " REMOTE_USER
read -p "Enter the remote server IP or hostname: " REMOTE_HOST
read -p "Enter the path to the remote folder: " REMOTE_DIR
read -p "Enter the path to the local folder where you want to save the copied folder: " LOCAL_DIR

# Create local directory if it doesn't exist
mkdir -p "$LOCAL_DIR"

# Copy the folder from the remote server to the local machine
scp -r "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}" "$LOCAL_DIR"

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Folder copied successfully to $LOCAL_DIR"
else
    echo "Failed to copy folder"
fi
