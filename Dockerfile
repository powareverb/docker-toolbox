FROM 			ubuntu:xenial
MAINTAINER 		Gavin Jones <gjones@powerfarming.co.nz>
ENV 			DOCKER_VERSION 1.12.0
ENV 			DOCKER_COMPOSE_VERSION 1.8.0
ENV 			DOCKER_MACHINE_VERSION 0.7.0
ENV 			TERM xterm
#To override if needed
ARG 			TAG=dev
ENV 			POWERSHELL_DOWNLOAD_URL https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.13/powershell_6.0.0-alpha.13-1ubuntu1.16.04.1_amd64.deb
ENV 			TAG ${TAG}

RUN 			apt-get update  \
				&& apt-get install -y git subversion nano wget curl iputils-ping dnsutils  \
				&& apt-get clean

#Docker bins
WORKDIR     /home/toolbox/
RUN         curl -L -o /tmp/docker-latest.tgz https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz && \
            tar -xvzf /tmp/docker-latest.tgz && \
            mv docker/* /usr/bin/ 

#Docker compose
RUN 			curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
				chmod +x /usr/local/bin/docker-compose

#Docker machine
RUN			curl -L https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
				chmod +x /usr/local/bin/docker-machine
	
#Minio tools
RUN			curl -L https://dl.minio.io/server/minio/release/linux-amd64/minio > /usr/local/bin/minio && \
				chmod +x /usr/local/bin/minio
RUN			curl -L https://dl.minio.io/client/mc/release/linux-amd64/mc > /usr/local/bin/mc && \
				chmod +x /usr/local/bin/mc

### Install .NET Core
RUN 			apt-get update \
				&& apt-get install apt-transport-https curl -y \
				&& sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
				&& apt-get update \
				&& apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 \
				&& apt-get update \
				&& apt-get install dotnet-dev-1.0.0-preview2-003121 -y \
				&& mkdir /powershell \
				&& apt-get clean

# Install PowerShell
### Set the working directory to /powershell
WORKDIR 		/powershell

### Set some environment variables
RUN 			curl -SL $POWERSHELL_DOWNLOAD_URL --output powershell.deb \
				&& apt-get install libunwind8 libicu55 \
				&& dpkg --install powershell.deb \
				&& rm powershell.deb \
				&& apt-get clean

RUN 			echo $TAG >> build_tag
