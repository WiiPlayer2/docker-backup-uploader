#!/bin/bash
CONFIG_FOLDER="/config"
BACKUPS_FOLDER="/backups"
CONFIG_FILE="$CONFIG_FOLDER/rclone.conf"
LOCK_FILE="/sync.lock"
export RCLONE_CONFIG="$CONFIG_FILE"

if [ -e "$LOCK_FILE" ]; then
    echo "Lock file detected. Exiting..."
    exit
fi
touch $LOCK_FILE

echo "`date` - Starting sync..."
# rclone sync "$BACKUPS_FOLDER" "$REMOTE_NAME:/" --progress --dry-run

rm -f $LOCK_FILE
