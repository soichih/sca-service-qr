#!/usr/bin/bash

dockerid=`cat docker.id`
status=`docker inspect $dockerid | jq -r '.[0].State.Status'`
case "$status" in
    running)
        echo "$dockerid running"
        exit 0 
        ;;
    exited)
        exitcode=`docker inspect $dockerid | jq -r '.[0].State.ExitCode'`
        if [ $exitcode -eq 0 ]; then
            echo "$dockerid finished successfully"
            docker rm $dockerid
            exit 1
        else
            echo "$dockerid exited with code:$exitcode"
            docker rm $dockerid
            exit 2
        fi
        ;;
    *)
        echo "unknown status:$status"
        exit 3
esac

