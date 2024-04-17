#!/bin/sh

source .env

config=$(ssh $USER@$HOST 'show running-config')
echo "$config"
