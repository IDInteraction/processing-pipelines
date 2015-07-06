#
# Base image for the IDInteraction processing pipelines.
#
# Robert Haines, University of Manchester.
#

FROM ubuntu:14.04

MAINTAINER Robert Haines <robert.haines@manchester.ac.uk>

RUN apt-get update && apt-get upgrade -y && apt-get clean

ENV IDI_HOME /opt/idinteraction

RUN mkdir $IDI_HOME
