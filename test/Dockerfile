FROM alpine

RUN echo -e "\033[0;32mInstalling OpenSSH and bash...\033[0m" && \
    apk add openssh bash && \
    echo -e "\033[0;32mAdding test group...\033[0m" && \
    addgroup -g 1000 test && \
    echo -e "\033[0;32mAdding test user...\033[0m" && \
    adduser -h "/var/www" -G test -H -S -D -s /bin/bash -u 1000 test && \
    echo -e "\033[0;32mModifying SSHD configuration...\033[0m" && \
    sed -i -e 's/#Port 22/Port 2222/' /etc/ssh/sshd_config && \
    sed -i -e 's$AuthorizedKeysFile      .ssh/authorized_keys$AuthorizedKeysFile /etc/ssh/authorized_keys$' /etc/ssh/sshd_config && \
    sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    echo "AllowUsers test" >>/etc/ssh/sshd_config && \
    echo -e "\033[0;32mCreating webroot directory...\033[0m" && \
    echo -e "\033[0;32mCreating authorized_keys file in /etc/ssh...\033[0m" && \
    echo "" >/etc/ssh/authorized_keys && \
    chown test:test /etc/ssh/authorized_keys && \
    chmod 0640 /etc/ssh/authorized_keys && \
    mkdir -p /test
COPY containerroot /

HEALTHCHECK --start-period=10s CMD /usr/bin/ssh-keyscan 127.0.0.1:2222
EXPOSE 2222
USER 100
CMD ["/usr/local/bin/init.sh"]