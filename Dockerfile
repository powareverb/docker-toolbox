FROM ubuntu
MAINTAINER Gavin Jones <gjones@powerfarming.co.nz>
ENV DOCKER_VERSION 1.11.0
ENV TERM xterm
#To override if needed
ARG TAG=dev
ENV TAG ${TAG}

RUN apt-get update && \
    apt-get install -y git subversion nano wget curl iputils-ping dnsutils 

#Docker bins
WORKDIR     /home/toolbox/
RUN         curl -L -o /tmp/docker-latest.tgz https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz && \
            tar -xvzf /tmp/docker-latest.tgz && \
            mv docker/* /usr/bin/ 

RUN echo $TAG >> build_tag
