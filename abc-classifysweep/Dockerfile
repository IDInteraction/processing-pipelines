#------------------------------------------------------------------------------
# Copyright (c) 2017 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: David Mawdsley
#------------------------------------------------------------------------------

#Run the abc-classify code to predict participant behaviour
FROM idinteraction/opencv3base:2.0

MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk> 

RUN apt-get update && apt-get install -y gawk python-matplotlib python-scipy python-pip
# Ubuntu packaged version of sklearn isn't new enough, so use pip version
RUN pip install sklearn
 
COPY abc-display-tool/  $IDI_HOME/abc-display-tool
COPY Makefile $IDI_HOME
COPY jobrunner/ $IDI_HOME/jobrunner

# Get git commit ID in image
ARG GIT_COMMIT
ENV GIT_COMMIT ${GIT_COMMIT}

#ENTRYPOINT ["/usr/bin/make"]
ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ["abc-display-tool/abc-classify.py"]
#CMD ["all"]
