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

# Image containing sklean

FROM idinteraction/opencv3base:2.0

MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk> 


RUN apt-get update && apt-get install -y gawk python-matplotlib python-scipy python-pip
# Ubuntu packaged version of sklearn isn't new enough, so use pip version
RUN pip install sklearn
 


