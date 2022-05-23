
FROM krashnat922/devops-ansible-poc:ec240
WORKDIR /app
RUN pip3 install boto
COPY . .
ADD ansible.cfg /etc/ansible
