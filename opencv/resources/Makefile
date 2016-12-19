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
include gmsl

empty:=
space := $(empty) $(empty)

facedetect = python  ./opencv/abc-classifier/dynamic/face.py
getconsensus = python ./opencv/recogniser/consensusBB.py
getpreds = python ./opencv/recogniser/FaceRecognizerPrediction.py
#convertdetect = Rscript opencv/abc-classifier/Ranalysis/convertdata.R
#showbox = python ./opencv/abc-classifier/showboxes.py
in-dir=videos
out-dir=output
annote-dir=annote

.PHONY: all init getbbox replay clean fdeigen
.PRECIOUS: $(out-dir)/%.skip $(out-dir)/%.csv $(out-dir)/%.facetrack $(out-dir)/%.cfacetrack \
	$(out-dir)/%.eigen $(out-dir)/%.fisher $(out-dir)/%.LBPH $(annote-dir)/%.attention

all: init getbbox  fdlbph fdeigen fdfisher
init: $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.skip,$(wildcard $(in-dir)/*.mp4))
getbbox: init $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.cfacetrack,$(wildcard $(in-dir)/*.mp4))
fdeigen: getbbox $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.eigen,$(wildcard $(in-dir)/*.mp4))
fdfisher: getbbox $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.fisher,$(wildcard $(in-dir)/*.mp4))
fdlbph: getbbox $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.lbph,$(wildcard $(in-dir)/*.mp4))
#replay: getbbox $(patsubst $(in-dir)/%.mp4,$(out-dir)/%_out.avi,$(wildcard $(in-dir)/*.mp4))

$(out-dir)/%.skip: $(in-dir)/%.mp4
	@read -p "At what time (in milliseconds) does the experiment start in file '$<'? " tskip; \
	echo -n $$tskip > $@

# TODO split into two rules; facetrack and consensus
$(out-dir)/%.cfacetrack: $(in-dir)/%.mp4 $(out-dir)/%.skip
	$(facedetect) $< \
	$(subst $(in-dir), $(out-dir), $(patsubst %.mp4, %.facetrack, $(word 1, $^))) \
	`cat $(word 2, $^)`
	$(getconsensus) $(subst $(in-dir), $(out-dir), $(patsubst %.mp4, %.facetrack, $(word 1, $^))) \
	$(subst $(in-dir), $(out-dir), $(patsubst %.mp4, %.cfacetrack, $(word 1, $^)))

$(out-dir)/%.eigen: $(in-dir)/%.mp4 $(out-dir)/%.cfacetrack $(out-dir)/%.skip
	$(getpreds) $< $(word 2, $^)  $(annote-dir)/$(addsuffix -timings.csv, $(call substr, $(notdir $@),1,4))   `cat $(word 3, $^)` 5 Eigen $@

$(out-dir)/%.fisher: $(in-dir)/%.mp4 $(out-dir)/%.cfacetrack $(out-dir)/%.skip
	$(getpreds) $< $(word 2, $^)  $(annote-dir)/$(addsuffix -timings.csv, $(call substr, $(notdir $@),1,4))   `cat $(word 3, $^)` 5 Fisher $@

$(out-dir)/%.lbph: $(in-dir)/%.mp4 $(out-dir)/%.cfacetrack $(out-dir)/%.skip
	$(getpreds) $< $(word 2, $^)  $(annote-dir)/$(addsuffix -timings.csv, $(call substr, $(notdir $@),1,4))   `cat $(word 3, $^)` 5 LBPH $@


clean:
	rm -f $(out-dir)/*.skip
	rm -f $(out-dir)/*.csv
	rm -f $(out-dir)/*_out.avi
