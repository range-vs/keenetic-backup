FROM ubuntu:latest

RUN apt-get update && apt-get -y install cron bash sshpass curl rsyslog

COPY backup.sh /backup.sh
COPY .env /.env

# Добавляем задачу cron напрямую в файл crontab
RUN echo "0 0 * * * root /bin/bash /backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/backup-cron \
    && chmod 0644 /etc/cron.d/backup-cron \
    && touch /var/log/cron.log

# Запускаем rsyslog для логирования cron
CMD service rsyslog start && cron -f
