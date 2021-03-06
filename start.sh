#!/usr/bin/bash

#make sure jq is installed on $SCA_SERVICE_DIR
if [ ! -f $SCA_SERVICE_DIR/jq ];
then
        echo "installing jq"
        wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O $SCA_SERVICE_DIR/jq
        chmod +x $SCA_SERVICE_DIR/jq
fi

input_task_id=`$SCA_SERVICE_DIR/jq -r '.input_task_id' config.json`
#echo "dumping products.json"
#cat ../$input_task_id/products.json

mkdir -p output

#create list.txt using all dirctories existing in the input directory
#$SCA_SERVICE_DIR/jq -r '.[0] .exps[]' ../$input_task_id/products.json > output/exps.txt #TODO - I need to prepent /input to each lines
ls  ../$input_task_id/exps | awk '{print "/input/exps/"$1}' > output/exps.txt

#construct opts for podi_collectcell
#http://pubsvn.galev.org/podi/trunk/podi_collectcells.py
opts=""

if [ `$SCA_SERVICE_DIR/jq -r '.nonlinear' config.json` == "true" ]; then
    opts=$opts+" -nonlinearity"
fi
#if [ `$SCA_SERVICE_DIR/jq -r '.persistency' config.json` == "true" ]; then
#    opts="$opts -persistency=/dir"
#fi
#if [ `$SCA_SERVICE_DIR/jq -r '.fringe' config.json` == "true" ]; then
#    opts="$opts -fringe=/dir"
#fi
#if [ `$SCA_SERVICE_DIR/jq -r '.wcs' config.json` == "true" ]; then
#    opts="$opts -wcs=/dir/file.fits"
#fi
#if [ `$SCA_SERVICE_DIR/jq -r '.wcs' config.json` == "true" ]; then
#    opts="$opts -wcs=/dir/file.fits"
#fi
if [ `$SCA_SERVICE_DIR/jq -r '.photo' config.json` == "true" ]; then
    opts="$opts -photcalib"
fi

#process calibration input
dark=`$SCA_SERVICE_DIR/jq -r '.[0] .dark' ../$input_task_id/products.json`
if [ ! $dark == "null" ]; then
    opts="$opts --dark=/input/$dark"
fi
flat=`$SCA_SERVICE_DIR/jq -r '.[0] .flat' ../$input_task_id/products.json`
if [ ! $flat == "null" ]; then
    opts="$opts --flat=/input/$flat"
fi
bias=`$SCA_SERVICE_DIR/jq -r '.[0] .bias' ../$input_task_id/products.json`
if [ ! $bias == "null" ]; then
    opts="$opts --bias=/input/$bias"
fi

echo "using opts"
echo $opts

pwd=`pwd`
dockerid=`docker run \
    -e SCA_PROGRESS_URL=$SCA_PROGRESS_URL \
    -v $pwd/../$input_task_id:/input \
    -v $pwd/output:/output \
    -d iusca/dockqr ./podi_multicollect.py -fromfile=/output/exps.txt -formatout=/output/%OBSID.fits $opts`

#this should get the docker container id
#dockerid=`docker ps -l -q`

#-e SCA_PROGRESS_URL="https://soichi7.ppa.iu.edu/api/progress/status/_sca.5707063c4f94be7d71ce1297.570706494f94be7d71ce1298" \

echo "started docker container $dockerid"
echo $dockerid > docker.id
