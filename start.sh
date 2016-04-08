#!/usr/bin/bash


#create list.txt using all dirctories existing in the input directory
ls  ../input | awk '{print "/input/"$1}' > ../input/list.txt

echo $SCA_PROGRESS_URL
docker run \
	-e SCA_PROGRESS_URL=$SCA_PROGRESS_URL \
        -v `pwd`/../input:/input \
        -v `pwd`/output:/output \
	-d iusca/dockqr ./podi_multicollect.py -fromfile=/input/list.txt -formatout=/output/%OBSID.fits -nonlinearity \
    &

#this should get the docker container id
dockerid=`docker ps -l -q`

#-e SCA_PROGRESS_URL="https://soichi7.ppa.iu.edu/api/progress/status/_sca.5707063c4f94be7d71ce1297.570706494f94be7d71ce1298" \

echo "started docker container $dockerid"
echo $dockerid > docker.id

#echo "{\"hello\":\"there\"}" > products.json
