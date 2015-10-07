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
#
# IDInteraction object tracking pipeline.
#
# This Makefile is used to drive the object tracking process.
#
# "make init" will collect set up information about each input video:
#  * The amount of time to ignore at the start of the video
#  * The initial bounding box of the object to be tracked in the video
#
# "make track" will perform object tracking on a set of input files, collecting
# set up information if required.
#

cppmt=./cmt
video-dir=videos

.PHONY: all init track clean
.PRECIOUS: $(video-dir)/%.skip $(video-dir)/%.bbox

all: init track
init: $(patsubst $(video-dir)/%.mp4,$(video-dir)/%.bbox,$(wildcard $(video-dir)/*.mp4))
track: init $(patsubst $(video-dir)/%.mp4,$(video-dir)/%.csv,$(wildcard $(video-dir)/*.mp4))

$(video-dir)/%.skip: $(video-dir)/%.mp4
	@read -p "At what time (in milliseconds) does the experiment start in file '$<'? " tskip; \
	echo -n $$tskip > $@

$(video-dir)/%.bbox: $(video-dir)/%.mp4 $(video-dir)/%.skip
	$(cppmt) --skip-ms=`cat $(word 2, $^)` --process-frames=1 $< | head -1 | cut -d" " -f5 | tr -d '\n' > $@

$(video-dir)/%.csv: $(video-dir)/%.mp4 $(video-dir)/%.skip $(video-dir)/%.bbox
	$(cppmt) --skip-ms=`cat $(word 2, $^)` --bbox=`cat $(word 3, $^)` --with-rotation --quiet --output-file=$@ $<

clean:
	rm -f $(video-dir)/*.skip
	rm -f $(video-dir)/*.bbox
	rm -f $(video-dir)/*.csv
