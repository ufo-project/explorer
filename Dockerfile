FROM ubuntu:18.04
RUN apt update -y
RUN apt install -y python3 python3-dev python3-virtualenv
RUN apt install -y redis-tools redis-server
