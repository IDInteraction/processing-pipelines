#------------------------------------------------------------------------------
# Copyright (c) 2015 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

.PHONY: clean

CppMT/cmt:
	git clone -b idi-merged https://github.com/IDInteraction/CppMT.git
	cd CppMT && cmake .
	$(MAKE) -C CppMT

clean:
	rm -rf CppMT
