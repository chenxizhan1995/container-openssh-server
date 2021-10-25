#!/bin/bash

# 安装 openssh-server
cat <<EOF > /etc/apt/sources.list
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
EOF
apt update
apt install openssh-server --no-install-recommends -y
rm -rf /var/lib/apt/lists/*

mkdir /run/sshd
chmod 0755 /run/sshd

# # 更改 openssh 配置，允许 root 登录
sed -i s"/UsePAM yes/UsePAM no/g" /etc/ssh/sshd_config
echo PermitRootLogin yes >> /etc/ssh/sshd_config

# 设置默认时区
if [ -v "TZ" ]; then
	echo 设置默认时区为 $TZ
	ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
	echo $TZ > /etc/timezone
fi
