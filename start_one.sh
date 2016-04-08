#!/usr/bin/bash

docker run --rm \
        -v `pwd`/../input:/input \
        -v `pwd`/output:/output \
        soichih/odi-quickreduce ./podi_collectcells.py -nonlinearity /input/o20160217T192119.2.11.fits.fz /output/%OBJECT.fits \
    &

echo "{\"hello\":\"there\"}" > products.json
