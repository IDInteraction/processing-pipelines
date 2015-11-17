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
CMT_R_DIR=build/CppMT-replay

.PHONY: all clean

all: $(CMT_DIR)/cmt $(CMT_R_DIR)/cmt-replay

$(CMT_DIR)/cmt:
	mkdir -p $(CMT_DIR)
	cd $(CMT_DIR) && cmake ../../CppMT
	$(MAKE) -C $(CMT_DIR)

$(CMT_R_DIR)/cmt-replay:
	mkdir -p $(CMT_R_DIR)
	cd $(CMT_R_DIR) && cmake ../../CppMT-replay
	$(MAKE) -C $(CMT_R_DIR)

clean:
	rm -rf build
