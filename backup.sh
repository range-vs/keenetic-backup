#!/bin/sh

current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
sc_file="startup_config.txt"
ver_file="version.txt"

if [ -f .env ]; then
    #source .env
    export $(cat .env | xargs)

    if [ -z "$HOST_KEENETIC" ]; then
        echo "HOST_KEENETIC not find in .env"
        exit 1
    fi

    if [ -z "$USER_KEENETIC" ]; then
        echo "USER_KEENETIC not find in .env"
        exit 1
    fi

    if [ -z "$PASS_KEENETIC" ]; then
        echo "PASS_KEENETIC not find in .env"
        exit 1
    fi

    config=$(sshpass -p "$PASS_KEENETIC" ssh $USER_KEENETIC@$HOST_KEENETIC 'show running-config')
    # echo "$config"
    echo "$config" > "$sc_file"
    version=$(sshpass -p "$PASS_KEENETIC" ssh $USER_KEENETIC@$HOST_KEENETIC 'show version')
    # echo "$version"
    echo "$version" > "$ver_file"
    zip "backup_$current_datetime.zip" "$sc_file" "$ver_file"
    rm -rf "$sc_file" "$ver_file"
else
    echo "File .env not found"
    exit 1
fi
