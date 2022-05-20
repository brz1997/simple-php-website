FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
RUN apt-get update && \
  apt-get install -y gcc python-dev libkrb5-dev && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  pip3 install pywinrm[kerberos] && \
  apt install krb5-user -y && \ 
  pip3 install pywinrm && \
  pip3 install ansible && \
  pip3 install gitpython && \
  pip3 install boto3 && \
  pip3 install awscli && \
  pip3 install --upgrade requests==2.20.1
  
COPY . .
