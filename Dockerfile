FROM python:3.6
WORKDIR /app
CMD /usr/local/bin/python -m pip install --upgrade pip
RUN pip install gitpython ansible boto3 awscli
COPY . .
CMD ansible-playbook -i ansible.inv --private-key=$ANSIBLE_PRIVATE_KEY main.yml
