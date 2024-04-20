FROM ubuntu:latest

RUN apt-get update && apt-get -y install cron bash sshpass curl rsyslog

COPY backup.sh /backup.sh
COPY .env /.env

RUN echo "0 0 * * * /bin/bash /backup.sh" >> /etc/cron.d/backup-cron

CMD cron && tail -f /dev/null