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
# Modified: David Mawdsley 6 Jan 2017 to track using OpenCV3 algorithms
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
# "make replay" will draw the tracked bounding box into a new copy of the
# video, performing the object tracking step beforehand if necessary.
#

tracker=python ./tracker.py
#cppmt-r=./cmt-replay
in-dir=videos
out-dir=output

TRACKERS=BOOSTING KCF MEDIANFLOW MIL TLD

.PHONY: all init track replay clean
.PRECIOUS: $(out-dir)/%.skip $(out-dir)/%.bbox $(out-dir)/%.csv

all: init track replay
init: $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.bbox,$(wildcard $(in-dir)/*.mp4))
outfiles: $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.csv$(TRACKERS),$(wildcard $(in-dir)/*.mp4))
track: init  outfiles

#replay: track $(patsubst $(in-dir)/%.mp4,$(out-dir)/%_out.avi,$(wildcard $(in-dir)/*.mp4))

$(out-dir)/%.skip: $(in-dir)/%.mp4
	@read -p "At what time (in milliseconds) does the experiment start in file '$<'? " tskip; \
	echo -n $$tskip > $@

#$(out-dir)/%.bbox: $(in-dir)/%.mp4 $(out-dir)/%.skip
	$(tracker) --skip-ms=`cat $(word 2, $^)` --process-frames=1 $< | head -1 | cut -d" " -f5 | tr -d '\n' > $@

$(outfiles): $(in-dir)/%.mp4 $(out-dir)/%.skip $(out-dir)/%.bbox
	$(tracker) --infile $< --skipframe `cat $(word 2, $^)` --bbox `cat $(word 3, $^)` --tracker MEDIANFLOW >$@

#$(out-dir)/%_out.avi: $(out-dir)/%.csv $(in-dir)/%.mp4
#	$(cppmt-r) $(word 2, $^) $< $(out-dir)

clean:
	rm -f $(out-dir)/*.skip
	rm -f $(out-dir)/*.bbox
	rm -f $(out-dir)/*.csv
	rm -f $(out-dir)/*_out.avi
