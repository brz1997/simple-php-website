
FROM krashnat922/devops-ansible-poc:ec240
WORKDIR /app
RUN pip3 install boto && apt-get upgrade -y && apt-get install ssh -y
COPY . .
ADD ansible.cfg /etc/ansible
