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
    r-cran-stringr \
    python-opencv \
    python-pandas \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY opencv-detection/dynamic/face.py $IDI_HOME/face.py
COPY opencv-detection/Ranalysis/*.R $IDI_HOME/


