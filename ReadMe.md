Запуск резервной копии раз в день:
install docker
sudo docker build -t "NAME_ROUTER" . (NAME_ROUTER вписать из env)
sudo chmod +x start.sh
sudo crontab -e: * * * * * путь/к/start.sh (в start.sh NAME_ROUTER вписать из env)