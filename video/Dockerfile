#
# Video processing image for the IDInteraction processing pipelines.
#
# Robert Haines, University of Manchester.
#

FROM idinteraction/base:2.0

MAINTAINER Robert Haines <robert.haines@manchester.ac.uk>

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    mencoder \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY resources/ $IDI_HOME

ENTRYPOINT ["/usr/bin/make"]
CMD ["all"]
