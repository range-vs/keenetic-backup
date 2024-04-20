FROM ubuntu:latest
RUN apt-get update && apt-get -y install cron curl bash sshpass
COPY .env /.env
COPY backup.sh /backup.sh
COPY crontab /etc/cron.d/crontab
CMD ["cron", "-f"]