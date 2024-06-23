#!/bin/bash

# Variables
DB_USER="username"
DB_PASS="password"
DB_NAME="database_name"
BACKUP_DIR="/path/to/backups"
DATE=$(date +%Y-%m-%d)
BACKUP_FILE="backup-$DATE.sql.gz"

# Backup database
mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" | gzip > "$BACKUP_DIR/$BACKUP_FILE"

# Cleanup older backups (keep last 7 days)
find "$BACKUP_DIR" -type f -name 'backup-*.sql.gz' -mtime +7 -exec rm {} \;
