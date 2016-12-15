#------------------------------------------------------------------------------
# Copyright (c) 2016 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: David Mawdsley (modified from Robert Haines' objetc tracking Makefile)
#------------------------------------------------------------------------------
#
# IDInteraction object detection pipeline.
#
# This Makefile is used to drive the object detection process.
#
# "make init" will collect set up information about each input video:
#  * The amount of time to ignore at the start of the video
#
# "make track" will perform object tracking on a set of input files, collecting
# set up information if required.
#
# "make replay" will draw the tracked bounding box into a new copy of the
# video, performing the object tracking step beforehand if necessary.
#

facedetect = python  ./opencv/abc-classifier/dynamic/face.py
#convertdetect = Rscript opencv/abc-classifier/Ranalysis/convertdata.R
#showbox = python ./opencv/abc-classifier/showboxes.py
in-dir=videos
out-dir=output
skip-dir=skip

.PHONY: all init track replay clean
.PRECIOUS: $(out-dir)/%.skip $(out-dir)/%.csv

all: init track replay
init: $(patsubst $(in-dir)/%.mp4,$(skip-dir)/%.skip,$(wildcard $(in-dir)/*.mp4))
track: init $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.csv,$(wildcard $(in-dir)/*.mp4))
#replay: track $(patsubst $(in-dir)/%.mp4,$(out-dir)/%_out.avi,$(wildcard $(in-dir)/*.mp4))

$(out-dir)/%.skip: $(in-dir)/%.mp4
	@read -p "At what time (in milliseconds) does the experiment start in file '$<'? " tskip; \
	echo -n $$tskip > $@

$(out-dir)/%.csv: $(in-dir)/%.mp4 $(skip-dir)/%.skip
	$(facedetect) $< \
	$(subst $(in-dir), $(out-dir), $(patsubst %.mp4, %face.csv, $(word 1, $^))) \
	`cat $(word 2, $^)`
#	$(convertdetect) $(subst $(in-dir), $(out-dir), $(patsubst %.mp4, %face.csv, $(word 1, $^))) \
	$(subst $(in-dir), $(out-dir), $(patsubst %.mp4, %face.csv, $(word 1, $^)))
#	$(convertdetect) $(subst $(in-dir), $(out-dir), $(patsubst %.mp4, %eye.csv, $(word 1, $^))) \
		$(subst $(in-dir), $(out-dir), $(patsubst %.mp4, %eye.csv, $(word 1, $^))) \



#$(out-dir)/%_out.avi: $(in-dir)/%.mp4 $(out-dir)/%face.csv $(out-dir)/%eye.csv
	$(showbox) $< $@  $(word 2, $^) $(word 3, $^)

clean:
	rm -f $(out-dir)/*.skip
	rm -f $(out-dir)/*.csv
	rm -f $(out-dir)/*_out.avi
