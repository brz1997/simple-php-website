FROM krashnat922/devops-ansible-poc
WORKDIR /app
CMD export PYTHONIOENCODING=utf8
RUN pip3 install gitpython && \
  pip3 install boto3 && \
  pip3 install awscli
COPY . .
