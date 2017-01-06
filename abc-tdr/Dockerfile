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

FROM idinteraction:opencv3base

MAINTAINER David Mawdsley <david.mawdsley@manchester.ac.uk> 

COPY resources/ $IDI_HOME

ENTRYPOINT ["/usr/bin/make"]
CMD ["all"]

