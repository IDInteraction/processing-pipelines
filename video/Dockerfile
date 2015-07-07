#
# Video processing image for the IDInteraction processing pipelines.
#
# Robert Haines, University of Manchester.
#

FROM idinteraction/base

MAINTAINER Robert Haines <robert.haines@manchester.ac.uk>

RUN apt-get install -y mencoder && \
    apt-get clean

ENV IDI_VIDEO_HOME $IDI_HOME/video
RUN mkdir $IDI_VIDEO_HOME
COPY resources/ $IDI_VIDEO_HOME
WORKDIR $IDI_VIDEO_HOME
