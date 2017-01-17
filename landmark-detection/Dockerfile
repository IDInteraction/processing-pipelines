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
    apt-get install -qy python-pip libboost-all-dev
RUN pip install dlib
RUN mkdir /usr/share/dlib && wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2 && bunzip2 shape_predictor_68_face_landmarks.dat.bz2 && mv shape_predictor_68_face_landmarks.dat /usr/share/dlib/
COPY abc-landmarkDetection/outputLandmarks.py $IDI_HOME/
COPY resources/Makefile $IDI_HOME/

ENTRYPOINT ["/bin/bash"]


