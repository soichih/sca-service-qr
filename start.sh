#!/usr/bin/bash


#create list.txt using all dirctories existing in the input directory
ls ../input > ../input/list.txt

dockerid=$(docker run --rm \
        -v `pwd`/../input:/input \
        -v `pwd`/output:/output \
        iusca/dockqr ./podi_multicollect.py -fromfile=/input/list.txt -formatout=/output/%OBSID.fits -nonlinearity \
    &)

echo "started docker container $dockerid"
echo $dockerid > docker.id

#echo "{\"hello\":\"there\"}" > products.json
