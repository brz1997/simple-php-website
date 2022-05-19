FROM python:3.6
WORKDIR /app
RUN pip install gitpython ansible boto3 awscli
COPY . .
