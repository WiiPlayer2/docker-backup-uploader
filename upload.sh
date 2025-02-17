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

[[ "$HOT" == "1" ]] \
    && DRY_RUN_FLAG="" \
    || DRY_RUN_FLAG="--dry-run"

echo "`date` - Rotate backups..."
set -x
rotate-backups \
    --daily ${RETENTION_DAILY:-2} \
    --weekly ${RETENTION_WEEKLY:-2} \
    --monthly ${RETENTION_MONTHLY:-2} \
    --relaxed --prefer-recent $DRY_RUN_FLAG "$BACKUPS_FOLDER"
{ set +x; } 2>/dev/null

if [[ "$NO_SYNC" == "0" ]]; then
    echo "`date` - Starting sync..."
    set -x
    rclone sync "$BACKUPS_FOLDER" "$REMOTE_NAME:$REMOTE_PATH" --log-level INFO --stats-one-line-date $DRY_RUN_FLAG
    { set +x; } 2>/dev/null
fi

rm -f $LOCK_FILE
