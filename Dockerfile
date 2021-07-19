FROM ubuntu:latest
ENV TZ=UTC

RUN apt-get update \
    && apt-get install -y -qq --force-yes cron curl sudo unzip tzdata \
    && apt-get clean \
    && curl https://rclone.org/install.sh | sudo bash \
    && touch /var/log/cron.log

VOLUME [ "/config", "/backups" ]

ENV REMOTE_NAME="remote"
ENV REMOTE_TYPE="dropbox"
ENV REMOTE_PATH="/backups"
ENV HOT="0"

COPY crontab /etc/cron.d/uploader
COPY run.sh /run.sh
COPY upload.sh /upload.sh

RUN chmod 0744 /upload.sh \
    && chmod 0744 /run.sh

CMD /run.sh
