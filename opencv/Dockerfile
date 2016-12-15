#------------------------------------------------------------------------------
# Copyright (c) 2016 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: David Mawdsley
#------------------------------------------------------------------------------

FROM idinteraction/base:2.0



MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk>

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    libcv2.4 \
    mencoder \
    r-cran-stringr \
    r-cran-rsqlite \
    python-opencv \
    opencv-data \
    libopencv-dev \
    python-pandas \
    python-pandas-lib \
    python-setuptools \
    python-distribute \
    libdc1394-22-dev \
    nano \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
#RUN apt-get install -qy python-setuptools --no-install-recommends
# Suggestion from http://stackoverflow.com/questions/12689304/ctypes-error-libdc1394-error-failed-to-initialize-libdc1394
RUN ln /dev/null /dev/raw1394
COPY opencv-detection/dynamic/face.py $IDI_HOME/opencv/abc-classifier/dynamic/face.py
COPY opencv-detection/Ranalysis/*.R $IDI_HOME/opencv/abc-classifier/Ranalysis/
#COPY opencv-detection/showboxes/*.py $IDI_HOME/opencv/abc-classifier/
COPY resources/Makefile $IDI_HOME/

ENTRYPOINT ["/usr/bin/make"]
CMD ["all"]
