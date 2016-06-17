FROM ubuntu
MAINTAINER Gavin Jones <gjones@powerfarming.co.nz>
ENV         DOCKER_VERSION 1.11.0

RUN apt-get update && \
    apt-get install -y git subversion nano wget curl ping dnsutils 
ENV TERM xterm

#Docker bins
WORKDIR     /home/toolbox/
RUN         curl -L -o /tmp/docker-latest.tgz https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz && \
            tar -xvzf /tmp/docker-latest.tgz && \
            mv docker/* /usr/bin/ 

