#!/bin/bash

stub=/app/.stub
if ! [ -e $stub ]; then
	# 设置root账号的密码
	DEFAULT_ROOT_PASSWD=123456
	ROOT_PASSWD=${ROOT_PASSWD:-${DEFAULT_ROOT_PASSWD}}
	echo set root password to $ROOT_PASSWD
	echo "root:$ROOT_PASSWD" | chpasswd
	touch $stub
fi

exec "$@"
