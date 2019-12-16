FROM mysql:5.7
MAINTAINER ma.alex <ma.alex@qq.com>

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
    echo "Asia/Shanghai" > /etc/timezone

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list


RUN apt-get update && apt-get install -y \
    htop \
    inetutils-ping \
    vim \
    git \
    wget \
    golang \
	# 用完包管理器后安排打扫卫生可以显著的减少镜像大小
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "alias ll='ls $LS_OPTIONS -l'" >> /root/.bashrc


RUN echo "export GOROOT=/usr/lib/go" >> /root/.bashrc && \
	echo "export GOPATH=/root/go" >> /root/.bashrc && \
	echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> /root/.bashrc



