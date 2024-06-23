#!/bin/bash

# Define the prefix for the zip file names
PREFIX="JOKER_"

# Iterate over each item in the current directory
for item in */; do
    # Check if the item is a directory
    if [ -d "$item" ]; then
        # Get the directory name
        foldername=$(basename "$item")

        # Create the zip file name with the prefix
        zipfilename="$PREFIX$foldername.zip"

        # Zip the folder while excluding files inside
        zip -r "$zipfilename" "$item" -x "$item"*
        
        echo "Created $zipfilename"
    fi
done
