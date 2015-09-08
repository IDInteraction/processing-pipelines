#
# Base image for the IDInteraction processing pipelines.
#
# Robert Haines, University of Manchester.
#

FROM ubuntu:14.04

MAINTAINER Robert Haines <robert.haines@manchester.ac.uk>

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    make \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV IDI_HOME /idinteraction
RUN mkdir $IDI_HOME
