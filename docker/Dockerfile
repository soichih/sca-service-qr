FROM centos:7
MAINTAINER Soichi Hayashi <hayashis@iu.edu>

#upgrade is the same as update with --obsoletes
RUN yum -y upgrade
RUN yum -y install gcc python-devel scipy python-matplotlib gsl gsl-devel

RUN yum -y install epel-release
RUN yum -y install python-pip python-Bottleneck libjpeg-devel libpng-devel

#RUN pip install --upgrade pip #not necessary..
RUN pip install numpy Image pyfits ephem astLib jdcal Cython psutil requests

RUN yum -y install http://www.astromatic.net/download/sextractor/sextractor-2.19.5-1.x86_64.rpm
RUN yum -y install http://www.astromatic.net/download/swarp/swarp-2.38.0-1.x86_64.rpm

#install qr scripts (should I pull it from svn?)
RUN yum -y install svn
#RUN svn checkout http://pubsvn.galev.org/podi/branch/prep_5x6 /qr #hoge
RUN svn checkout http://pubsvn.galev.org/podi/trunk /qr #hoge

RUN cd /qr && python setup.py build_ext --inplace

#install default config
#RUN ls -la /qr
COPY podi_sitesetup.py /qr/

WORKDIR /qr
RUN python setup.py install

CMD bash
#CMD ./podi_collectcells.py /usr/local/odi-raw/raw/o20150602T221627.2 /usr/local/odi-qred/%OBJECT.fits

