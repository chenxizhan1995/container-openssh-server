# openssh-server

## tags
- [latest](https://github.com/chenxizhan1995/container-openssh.git)

## 使用
默认密码 123456，通过环境变量 -e ROOT_PASSWD 设置root账号的密码。
```bash
# 启动
podman run -p 8022:22/tcp -dit --name ssh docker.io/chenxizhan1995/sshd:latest
# 或者
podman run -p 8022:22/tcp -dit --name ssh -e ROOT_PASSWD=abcdefg docker.io/chenxizhan1995/sshd:latest

# 登录
ssh root@localhost -p 8022
# 如果提示远程主机密钥指纹不符，使用下面的命令跳过验证
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p 8022
```
## 历史

### latest
基于 Debian GNU/Linux 11 (bullseye)，OpenSSH_8.4p1 Debian-5, OpenSSL 1.1.1k
构建：buildah bud -t docker.io/chenxizhan1995/sshd:latest

