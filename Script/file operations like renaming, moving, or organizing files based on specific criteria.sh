#!/bin/bash

# Variables
SOURCE_DIR="/path/to/files"
PREFIX="file_"

# Rename files in source directory
for file in "$SOURCE_DIR"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        mv "$file" "$SOURCE_DIR/$PREFIX$filename"
    fi
done
