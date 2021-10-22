From docker.io/debian:stable
COPY . /app/
RUN chmod u+x /app/*.sh && /app/install.sh
ENTRYPOINT ["/app/start.sh"]
CMD ["/usr/sbin/sshd", "-D"]
