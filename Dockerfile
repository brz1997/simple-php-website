FROM krashnat922/devops-ansible-poc:ec235
WORKDIR /app
CMD mkdir /etc/ansible
ADD ansible.cfg /etc/ansible
COPY . /app
