#------------------------------------------------------------------------------
# Copyright (c) 2015 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: David Mawdsley 
#------------------------------------------------------------------------------

FROM idinteraction/opencv

MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk> 

RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive \
apt-get install -qy python-pip
RUN pip install sklearn scipy

COPY resources/ $IDI_HOME
COPY resources/abc-display-tool/abc-classify.py $IDI_HOME

COPY resources/Makefile $IDI_HOME
COPY resources/getTracking.sh $IDI_HOME

ENTRYPOINT ["/bin/bash"]
#CMD ["all"]

