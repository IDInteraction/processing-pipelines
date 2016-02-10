#------------------------------------------------------------------------------
# Copyright (c) 2016 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

FROM r-base:3.2.3

MAINTAINER Robert Haines <robert.haines@manchester.ac.uk>

COPY tracking-analysis/dataProcessing.R /home/docker
COPY resources/ /home/docker
WORKDIR /home/docker

RUN Rscript install.R && \
  rm -f install.R Rplots.pdf

CMD ["bash"]
