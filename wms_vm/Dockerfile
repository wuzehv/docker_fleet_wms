FROM ubuntu:18.04

RUN apt update && apt -y install net-tools iputils-ping telnet vim

COPY ./api_gw /usr/sbin/

ENTRYPOINT ["/usr/sbin/api_gw"]