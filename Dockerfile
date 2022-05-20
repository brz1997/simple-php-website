FROM krashnat922/devops-ansible-poc
WORKDIR /app
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get update
RUN apt-get install -y language-pack-en locales
RUN apt-get install -y python3 python3-cryptography python3-dev python3-pip python3-setuptools python3-wheel
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pip3 install ansible

RUN apt remove python -y && \
  pip3 install gitpython && \
  pip3 install boto3 && \
  pip3 install awscli
COPY . .
CMD echo -e "[defaults]\nremote_tmp     = /tmp/ansible-$USER\nsudo_user      = root\nsudo           = true" > ansible.cfg
