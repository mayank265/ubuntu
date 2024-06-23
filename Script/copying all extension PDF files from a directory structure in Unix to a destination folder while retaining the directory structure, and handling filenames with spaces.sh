#!/bin/bash

# Variables
EXTENSION="pdf"
SOURCE="/path/to/source"  # Replace with your actual source directory
DESTINATION="/tmp/pdf"

# Ensure destination directory exists
mkdir -p "$DESTINATION"

# Use find with print0 to handle filenames with spaces
find "$SOURCE" -type f -name "*.$EXTENSION" -print0 |
xargs -0 -I {} sh -c '
    # Get absolute path of the file
    filepath="$1"
    
    # Determine relative path from source directory
    relpath="${filepath#'"$SOURCE"'/}"
    
    # Create destination directory structure if it doesn't exist
    mkdir -p "$DESTINATION/$(dirname "$relpath")"
    
    # Copy PDF file to destination
    cp "$filepath" "$DESTINATION/$relpath"
' sh {}
