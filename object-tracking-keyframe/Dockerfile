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
# Docker image track from a bounding box specified after the experiment has
# begun; track backwards from bounding box frame to expt start and forwards
# from bounding box frame to video end; combine both parts

FROM idinteraction/cppmt:2.0

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
    bc  \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk>

COPY resources/ $IDI_HOME
COPY abc-set-bounding-box/ $IDI_HOME


ENTRYPOINT ["/usr/bin/make"]
CMD ["all"]
