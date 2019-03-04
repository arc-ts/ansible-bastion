FROM alpine:3.9
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22 
EXPOSE 2222
COPY ./rootfs/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN apk add --no-cache openssh \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config