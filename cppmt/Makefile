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

CMT_DIR=build/CppMT

.PHONY: all clean

all: $(CMT_DIR)/cmt CppMT-replay/cmt-replay

$(CMT_DIR)/cmt:
	mkdir -p $(CMT_DIR)
	cd $(CMT_DIR) && cmake ../../CppMT
	$(MAKE) -C $(CMT_DIR)

CppMT-replay/cmt-replay:
	git clone -b master https://github.com/IDInteraction/CppMT-replay.git
	cd CppMT-replay && cmake .
	$(MAKE) -C CppMT-replay

clean:
	rm -rf CppMT-replay
