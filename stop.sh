#!/usr/bin/bash

dockerid=`cat docker.id`
docker rm -f $dockerid
