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
# Docker image to set the initial bounding box on a series of videos
# using OpenCV face detection and/or initial "full face" specification
# and rewinding to experiment start

FROM idinteraction/cppmt

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    libcv2.4 \
    mencoder \
    mplayer \
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


MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk>

COPY resources/ $IDI_HOME
COPY setBoundingBox/ $IDI_HOME


ENTRYPOINT ["/usr/bin/make"]
CMD ["all"]
