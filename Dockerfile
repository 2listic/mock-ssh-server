FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    apt-get clean

RUN echo 'root:root' | chpasswd
RUN echo 'Beautiful banner' > /etc/banner

RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh
# Use the secret to copy the public key
RUN --mount=type=secret,id=ssh-key \
    cp /run/secrets/ssh-key /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
