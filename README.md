# docker-toolbox
Simple toolbox for dealing with stuff in Docker.  Includes handy tools such as
- Git & SVN
- Ping/Dig
- Nano
- Docker Bins for connecting to docker instances
- Powershell by default

Note - that it's based on Ubuntu, and includes lots of things, so not lightweight by default.
TODO: Create a lightweight version for running scripts and tools.

## Some examples
```
sudo docker pull gavinjonespf/docker-toolbox

#Do simple things
sudo docker run --rm -it --name docker-toolbox gavinjonespf/docker-toolbox:latest bash
sudo docker run --rm -it --name docker-toolbox gavinjonespf/docker-toolbox:latest powershell

#Do docker related things on host
sudo docker run --rm -it --name docker-toolbox -v /var/run/docker.sock:/var/run/docker.sock:ro gavinjonespf/docker-toolbox:latest bash

#Custom DNS checks using local DNS & Docker
export DOCKERIP=$(ifconfig docker0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
sudo docker run --rm -it --name docker-toolbox -v /var/run/docker.sock:/var/run/docker.sock:ro --dns "$DOCKERIP" gavinjonespf/docker-toolbox:latest bash
```

