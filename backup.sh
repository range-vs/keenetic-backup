#!/bin/sh

if [ -f .env ]; then
    #source .env
    export $(cat .env | xargs)

    if [ -z "$HOST" ]; then
        echo "HOST not find in .env"
        exit 1
    fi

    if [ -z "$USER" ]; then
        echo "USER not find in .env"
        exit 1
    fi

    if [ -z "$PASS" ]; then
        echo "PASS not find in .env"
        exit 1
    fi

    # Выполняем необходимые действия
    # config=$(ssh $USER@$HOST 'show running-config')
    config=$(sshpass -p "$PASS" ssh $USER@$HOST 'show running-config')
    echo "$config"
    version=$(sshpass -p "$PASS" ssh $USER@$HOST 'show version')
    echo "$version"
else
    echo "File .env not found"
    exit 1
fi
