FROM krashnat922/devops-ansible-poc
WORKDIR /app
RUN apt install -y locales
CMD export PYTHONIOENCODING=utf8
CMD export LANG=en_US.UTF-8
CMD locale-gen en_US.UTF-8
CMD export LANG=en_US.UTF-8
CMD export LC_ALL=en_US.UTF-8
RUN apt remove python -y && \
  pip3 install ansible && \
  pip3 install gitpython && \
  pip3 install boto3 && \
  pip3 install awscli
COPY . .
CMD echo -e "[defaults]\nremote_tmp     = /tmp/ansible-$USER\nsudo_user      = root\nsudo           = true" > ansible.cfg
