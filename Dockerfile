FROM ubuntu:latest
RUN apt-get update && apt-get -y install cron bash sshpass curl
COPY backup.sh /backup.sh
COPY .env /.env
COPY cronfile /etc/cron.d/cronfile
RUN chmod 0644 /etc/cron.d/cronfile
RUN crontab /etc/cron.d/cronfile
CMD ["cron", "-f"]