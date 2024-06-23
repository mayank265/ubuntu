#!/bin/bash

# Variables
SOURCE="/path/to/source"
DESTINATION="/path/to/backup"
DATE=$(date +%Y-%m-%d)
BACKUP_FILE="backup-$DATE.tar.gz"

# Create backup archive
tar -czf "$DESTINATION/$BACKUP_FILE" "$SOURCE"

# Cleanup older backups (keep last 7 days)
find "$DESTINATION" -type f -name 'backup-*.tar.gz' -mtime +7 -exec rm {} \;
