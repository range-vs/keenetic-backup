FROM ubuntu:latest

RUN apt-get update && apt-get -y install cron bash sshpass curl

COPY backup.sh /backup.sh
COPY .env /.env

# Добавляем задачу cron напрямую в файл crontab с новым временем
RUN echo "0 19 * * * root /bin/bash /backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/backup-cron \
    && chmod 0644 /etc/cron.d/backup-cron \
    && touch /var/log/cron.log

# Запускаем cron в режиме передачи вывода на stdout
CMD cron -f
