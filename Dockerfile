FROM ubuntu:18.04

LABEL maintainer="Bhairavi <borawake.s97@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8 LC_ALL
WORKDIR /app
RUN export PYTHONIOENCODING=utf8
RUN apt-get update -y && \
  apt-get install -y gcc python-dev libkrb5-dev python3-pip
RUN pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  pip3 install pywinrm[kerberos] && \
  apt install -y krb5-user && \
  pip3 install pywinrm
RUN apt remove python -y && \
  apt-get install -y language-pack-en locales && \
  apt-get install -y python3 python3-cryptography python3-dev python3-pip python3-setuptools python3-wheel && \
  locale-gen en_US.UTF-8 && dpkg-reconfigure locales && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pip3 install ansible && \
  pip3 install gitpython boto3 awscli
RUN mkdir /etc/ansible
ADD ansible.cfg /etc/ansible

# Make sure the package repository is up to date.
RUN apt-get update 
RUN apt-get -qy full-upgrade 
RUN apt-get install -qy git

# Install a basic SSH server
RUN apt-get install -qy openssh-server 
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd 
RUN mkdir -p /var/run/sshd

# Install JDK 8 (latest stable edition at 2019-04-01)
RUN apt-get install -qy openjdk-8-jdk

# Cleanup old packages
RUN apt-get -qy autoremove

# Add user jenkins to the image
RUN adduser --quiet jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2

#ADD settings.xml /home/jenkins/.m2/
# Copy authorized keys
#COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ 
#    chown -R jenkins:jenkins /home/jenkins/.ssh/

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
