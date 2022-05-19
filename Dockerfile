FROM python:3.6
WORKDIR /app
CMD /usr/local/bin/python -m pip install --upgrade pip
CMD /bin/sh -c pip install git ansible boto3 awscli
RUN pip install git ansible boto3 awscli
COPY . .
