#------------------------------------------------------------------------------
# Copyright (c) 2015 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

# Pipeline to generate PCA and mixture model data from the 
# (previously extracted) depth frames
# The results of these can be used with 

FROM idinteraction/opencv3base:2.0

MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk> 

COPY abc-display-tool/  $IDI_HOME/abc-display-tool
COPY Makefile $IDI_HOME

RUN mkdir tempdir && mkdir temptimedir
RUN apt-get update && apt-get install -y gawk python-matplotlib python-scipy python-pip
# Ubuntu packaged version of sklearn isn't new enough, so use pip version
RUN pip install sklearn
 

# Get git commit ID in image
ARG GIT_COMMIT
ENV GIT_COMMIT ${GIT_COMMIT}

ENTRYPOINT ["/usr/bin/make"]
CMD ["all"]
