#!/bin/bash
TAG='local'

docker build --build-arg TAG=$TAG -t gavinjonespf/docker-toolbox:$TAG .
