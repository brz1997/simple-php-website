FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
WORKDIR /app
RUN export PYTHONIOENCODING=utf8
RUN apt-get update && \
  apt-get install -y gcc python-dev libkrb5-dev && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  pip3 install pywinrm[kerberos] && \
  apt install krb5-user -y && \
  pip3 install pywinrm && \
  apt remove python -y

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y language-pack-en locales
RUN apt-get install -y python3 python3-cryptography python3-dev python3-pip python3-setuptools python3-wheel
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pip3 install ansible
RUN pip3 install gitpython && \
  pip3 install boto3 && \
  pip3 install awscli
RUN mkdir /etc/ansible
ADD ansible.cfg /etc/ansible
