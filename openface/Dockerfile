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
FROM idinteraction/opencv3base

MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk>
RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy build-essential cmake libopenblas-dev liblapack-dev git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev checkinstall libboost-all-dev
RUN git clone https://github.com/TadasBaltrusaitis/OpenFace.git && cd OpenFace && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE .. && make
RUN apt-get update -q && \
	DEBIAN_FRONTEND=noninteractive \
	apt-get install -qy ffmpeg
COPY resources/Makefile $IDI_HOME


ENTRYPOINT ["/bin/bash"]


