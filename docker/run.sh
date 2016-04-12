docker run -it --rm \
        -v /usr/local/tmp/qr/raw/:/input \
        -v `pwd`/output:/output \
        soichih/odi-quickreduce ./podi_collectcells.py -selectota=33 /input/o20160217T192119.2/o20160217T192119.2.11.fits.fz /output/%OBJECT.fits
#soichih/odi-quickreduce 
#o20160217T192119.2/o20160217T192119.2.11.fits.fz:/input \

#if you have the 2mass catalog, mount it under /2mass
#-v `pwd`/2mass:/2mass

#docker run -it --rm \
#       -v /usr/local/odi-raw/:/input \
#       -v /usr/local/odi-qred:/output \
#       soichih/odi-quickreduce 



