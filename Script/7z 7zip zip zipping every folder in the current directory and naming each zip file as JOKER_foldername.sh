#!/bin/bash

# Define the prefix for the zip file names
PREFIX="JOKER_"

# Define the compression level (default is 3)
COMPRESSION_LEVEL=3

# Iterate over each item in the current directory
for item in */; do
    # Check if the item is a directory
    if [ -d "$item" ]; then
        # Get the directory name
        foldername=$(basename "$item")

        # Create the 7z file name with the prefix
        sevenzipfilename="$PREFIX$foldername.7z"

        # Zip the folder using 7z with specified compression level
        7z a -t7z -m0=lzma -mx=$COMPRESSION_LEVEL "$sevenzipfilename" "$item"
        
        echo "Created $sevenzipfilename"
    fi
done
