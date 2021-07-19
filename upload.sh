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
[[ "$HOT" == "1" ]] \
    && DRY_RUN_FLAG="" \
    || DRY_RUN_FLAG="--dry-run"

set -x
rclone sync "$BACKUPS_FOLDER" "$REMOTE_NAME:$REMOTE_PATH" --log-level INFO --stats-one-line-date $DRY_RUN_FLAG
{ set +x; } 2>/dev/null

rm -f $LOCK_FILE
