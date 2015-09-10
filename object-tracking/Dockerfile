#
# Object tracking image for the IDInteraction processing pipelines.
#
# Robert Haines, University of Manchester.
#

FROM idinteraction/cppmt:0.2

MAINTAINER Robert Haines <robert.haines@manchester.ac.uk>

COPY resources/ $IDI_TRACKING_HOME

ENTRYPOINT ["/usr/bin/make"]
CMD ["all"]
