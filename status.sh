#!/usr/bin/bash

dockerid=`cat docker.id`
status=`docker inspect $dockerid | underscore select .Status`
echo $status
