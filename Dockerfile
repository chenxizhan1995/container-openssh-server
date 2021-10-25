From docker.io/debian:stable-slim
COPY . /app/
ENV TZ=Asia/Shanghai
RUN chmod u+x /app/*.sh && /app/_build.sh
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
