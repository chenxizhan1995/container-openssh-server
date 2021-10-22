#!/bin/bash

stub=/app/.root_passwd_set

if ! [ -e $stub ]; then

DEFAULT_ROOT_PASSWD=123456
ROOT_PASSWD=${ROOT_PASSWD:-${DEFAULT_ROOT_PASSWD}}
echo set root password to $ROOT_PASSWD
echo "root:$ROOT_PASSWD" | chpasswd
touch /app/password
fi

exec "$@"
