#!/bin/bash
CONFIG_FOLDER="/config"
BACKUP_FOLDER="/backups"
CONFIG_FILE="$CONFIG_FOLDER/rclone.conf"
export RCLONE_CONFIG="$CONFIG_FILE"

# Configure timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating rclone config \"$REMOTE_NAME\" of type \"$REMOTE_TYPE\""
    rclone config create "$REMOTE_NAME" "$REMOTE_TYPE" config_is_local false
fi

env >> /etc/environment
cron -f -l 2
