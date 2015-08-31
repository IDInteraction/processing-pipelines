#
# Object tracking image for the IDInteraction processing pipelines.
#
# Robert Haines, University of Manchester.
#

FROM idinteraction/base:1.1

MAINTAINER Robert Haines <robert.haines@manchester.ac.uk>

RUN apt-get install -y libcv2.4 && apt-get clean

COPY CppMT/cmt $IDI_HOME/cmt
