#!/bin/sh

if [ -f .env ]; then
    source .env

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
    config=$(ssh $USER@$HOST 'show running-config')
    echo "$config"
else
    echo "File .env not found"
    exit 1
fi
