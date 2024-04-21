FROM ubuntu:latest
RUN apt-get update && apt-get -y install curl bash sshpass
COPY .env /.env
COPY backup.sh /backup.sh
RUN chmod +x /backup.sh
CMD ["/backup.sh"]
