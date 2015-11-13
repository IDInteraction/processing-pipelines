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

.PHONY: all clean

all: CppMT/cmt CppMT-replay/cmt-replay

CppMT/cmt:
	git clone -b idi-merged https://github.com/IDInteraction/CppMT.git
	cd CppMT && cmake .
	$(MAKE) -C CppMT

CppMT-replay/cmt-replay:
	git clone -b master https://github.com/IDInteraction/CppMT-replay.git
	cd CppMT-replay && cmake .
	$(MAKE) -C CppMT-replay

clean:
	rm -rf CppMT
	rm -rf CppMT-replay
