#!/bin/sh

current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")
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

    if [ -z "$WEBDAV_HOST" ]; then
        echo "WEBDAV_HOST not find in .env"
        exit 1
    fi
    
    if [ -z "$WEBDAV_USER" ]; then
        echo "WEBDAV_USER not find in .env"
        exit 1
    fi

    if [ -z "$WEBDAV_PASS" ]; then
        echo "WEBDAV_PASS not find in .env"
        exit 1
    fi

    if [ -z "$NAME_ROUTER" ]; then
        echo "NAME_ROUTER not find in .env"
        exit 1
    fi
    
    if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
        echo "TELEGRAM_BOT_TOKEN not find in .env"
        exit 1
    fi

    if [ -z "$TELEGRAM_USER_ID" ]; then
        echo "TELEGRAM_USER_ID not find in .env"
        exit 1
    fi

    config=$(sshpass -p "$PASS_KEENETIC" ssh $USER_KEENETIC@$HOST_KEENETIC 'show running-config')
    # echo "$config"
    echo "$config" > "$sc_file"
    version=$(sshpass -p "$PASS_KEENETIC" ssh $USER_KEENETIC@$HOST_KEENETIC 'show version')
    # echo "$version"
    echo "$version" > "$ver_file"
    filename="backup_$current_datetime.zip"
    zip "$filename" "$sc_file" "$ver_file"
    rm -rf "$sc_file" "$ver_file"
  
    out=$(curl -s -u "$WEBDAV_USER:$WEBDAV_PASS" -T "$filename" -o "curl_output_webdav.log" -X PUT "$WEBDAV_HOST/$filename")
    echo "$out"
    rm -rf "$filename"

    curl "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage?chat_id=$TELEGRAM_USER_ID^^&text=Backup-for-$NAME_ROUTER-is-successfull"
    
else
    echo "File .env not found"
    exit 1
fi
