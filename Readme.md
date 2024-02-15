# openssh-server

基于 Debian GNU/Linux 11 (bullseye)，OpenSSH_8.4p1 Debian-5, OpenSSL 1.1.1k，x86-64 架构。

容器默认 UTF-8 时区。


## tags
- [1.1.0, latest](https://github.com/chenxizhan1995/container-openssh.git)
- [1.0.0](https://github.com/chenxizhan1995/container-openssh.git)

## 使用
默认密码 123456，通过环境变量 -e ROOT_PASSWD 设置root账号的密码。
```bash
# 启动
podman run -p 8022:22/tcp -dit --name ssh docker.io/chenxizhan1995/openssh-server:latest
# 或者
podman run -p 8022:22/tcp -dit --name ssh -e ROOT_PASSWD=abcdefg docker.io/chenxizhan1995/openssh-server:latest

# 登录
ssh root@localhost -p 8022
# 如果提示远程主机密钥指纹不符，使用下面的命令跳过验证
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p 8022
```

有一个服务，打包成docker镜像，同时还需要通过ssh登录上传文件。一个容器最好只有一个
主进程。所以单独构造openssh-server服务的镜像，并通过共享数据卷的方式提供ssh上传文件的功能。
```bash
# 有一个名为 demo 的服务，需要客户端通过ssh上传文件到 /data/file 目录下供操作
# 启动服务
podman run -v data-ssh:/data/file -p 8080:8080/tcp --name demo-service demo

# 启动ssh服务
podman run -v data-ssh:/data/file -p 8022:22/tcp --name demo-ssh docker.io/chenxizhan1995/openssh-server:latest

# 这样，客户端通过ssh连接 demo-ssh 容器，把文件上传到 /data/file 路径下，
# 在服务 demo-service 就能操作文件了。
```
## 构建镜像
```bash
buildah bud -t docker.io/chenxizhan1995/openssh-server:latest
podman tag docker.io/chenxizhan1995/openssh-server:latest docker.io/chenxizhan1995/openssh-server:1.0.1
```
## 历史
### 1.0.1，latest
- 把容器的默认时区更改为中国北京时间（U+0800 ）
### 1.0.0

## TODO:
- 当前的镜像是 x86_64 架构的
- 缩减镜像体积
- 编写 buildah 风格的构建脚本

