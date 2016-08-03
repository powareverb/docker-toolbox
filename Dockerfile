FROM ubuntu
MAINTAINER Gavin Jones <gjones@powerfarming.co.nz>
ENV DOCKER_VERSION 1.11.0
ENV DOCKER_COMPOSE_VERSION 1.8.0
ENV DOCKER_MACHINE_VERSION 0.7.0
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

#Docker compose
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#Docker machine
RUN	curl -L https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
chmod +x /usr/local/bin/docker-machine
	

RUN echo $TAG >> build_tag
