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

# 容器默认是 UTC 时区，可以通过指定 UTC+0800 时区
# 因为不同软件使用不同的方式确定时区设置，为了保险，
# 同时使用 环境变量TZ、文件/etc/localtime，文件 /etc/timezone 三种方式
podman run -p 8022:22/tcp -dit --name ssh \
  -e ROOT_PASSWD=abcdefg \
  -e TZ=Asia/Shanghai \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezong:/etc/timezone:ro \
  docker.io/chenxizhan1995/sshd:latest
```

有一个服务，打包成docker镜像，同时还需要通过ssh登录上传文件。一个容器最好只有一个
主进程。所以单独构造sshd服务的镜像，并通过共享数据卷的方式提供ssh上传文件的功能。
```bash
# 有一个名为 demo 的服务，需要客户端通过ssh上传文件到 /data/file 目录下供操作
# 启动服务
podman run -v data-ssh:/data/file -p 8080:8080/tcp --name demo-service demo

# 启动ssh服务
podman run -v data-ssh:/data/file -p 8022:22/tcp --name demo-ssh docker.io/chenxizhan1995/sshd:latest

# 这样，客户端通过ssh连接 demo-ssh 容器，把文件上传到 /data/file 路径下，
# 在服务 demo-service 就能操作文件了。
```
## 历史

### latest
基于 Debian GNU/Linux 11 (bullseye)，OpenSSH_8.4p1 Debian-5, OpenSSL 1.1.1k
构建：buildah bud -t docker.io/chenxizhan1995/sshd:latest

## TODO:
- 当前的镜像是 x86_64 架构的
- 缩减镜像体积
- 编写 buildah 风格的构建脚本
