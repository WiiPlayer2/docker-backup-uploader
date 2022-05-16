FROM python:3
ENV TZ=UTC
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y -qq --force-yes cron curl sudo unzip tzdata \
    && pip install rotate-backups \
    && apt-get clean \
    && curl https://rclone.org/install.sh | sudo bash \
    && touch /var/log/cron.log

VOLUME [ "/config", "/backups" ]

ENV REMOTE_NAME="remote"
ENV REMOTE_TYPE="dropbox"
ENV REMOTE_PATH="/backups"
ENV HOT="0"
ENV NO_SYNC="0"

COPY crontab /etc/cron.d/uploader
COPY run.sh /run.sh
COPY upload.sh /upload.sh

RUN chmod 0744 /upload.sh \
    && chmod 0744 /run.sh

ENTRYPOINT /run.sh
