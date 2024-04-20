FROM ubuntu:latest
RUN apt-get update && apt-get -y install cron bash sshpass curl supervisor
COPY backup.sh /backup.sh
COPY .env /.env
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
