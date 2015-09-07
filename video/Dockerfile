#
# Video processing image for the IDInteraction processing pipelines.
#
# Robert Haines, University of Manchester.
#

FROM idinteraction/base:1.2

MAINTAINER Robert Haines <robert.haines@manchester.ac.uk>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy mencoder && \
    apt-get clean

ENV IDI_VIDEO_HOME $IDI_HOME/video
RUN mkdir $IDI_VIDEO_HOME
COPY resources/ $IDI_VIDEO_HOME
WORKDIR $IDI_VIDEO_HOME

ENTRYPOINT ["/usr/bin/make"]
CMD ["all"]
