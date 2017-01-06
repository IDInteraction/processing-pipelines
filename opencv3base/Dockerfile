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


# Ubuntu 16.04 and Opencv 3 with Python 2 bindings .  Install based on tutorial at
# http://www.pyimagesearch.com/2016/10/24/ubuntu-16-04-how-to-install-opencv/
FROM idinteraction/base:3.0

MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk>

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
 build-essential cmake pkg-config \
 libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev \
   libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
libxvidcore-dev libx264-dev \
 libgtk-3-dev \
libatlas-base-dev gfortran \
python2.7-dev python3.5-dev \

    mencoder \
    r-cran-stringr \
    r-cran-rsqlite \



    python-pandas \
    python-pandas-lib \
    python-numpy \
    python-setuptools \
    python-distribute \

    gmsl \
    nano \
    git wget \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Might want to git clone these 
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/3.2.0.zip
RUN wget -O opencvcontrib.zip https://github.com/opencv/opencv_contrib/archive/3.2.0.zip
RUN unzip opencv.zip
RUN unzip opencvcontrib.zip

RUN  cd ./opencv-3.2.0/ && mkdir build &&  cd build && \
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.2.0/modules \
    -D PYTHON_EXECUTABLE=/usr/bin/python \
    -D BUILD_EXAMPLES=ON ..
RUN cd opencv-3.2.0/build/ && make -j4 && make install && ldconfig
ENTRYPOINT ["/bin/bash"]


