#------------------------------------------------------------------------------
# Copyright (c) 2016 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: David Mawdsley (modified from Robert Haines' object tracking pipeline)
#------------------------------------------------------------------------------
#
# IDInteraction bounding box setting pipeline.
#
# This Makefile is used to drive the OpenCV face detection bounding box setting # process.


setBB=./getface.py
rewindBB=./rewindBB.sh
in-dir=./videos
out-dir=./output

.PHONY: all init track replay clean
.PRECIOUS: $(out-dir)/%.skip $(out-dir)/%.Userbbox $(out-dir)/%.csv

all: init
init: $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.bbox,$(wildcard $(in-dir)/*.mp4))
#setbb: init $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.csv,$(wildcard $(in-dir)/*.mp4))
#replay: track $(patsubst $(in-dir)/%.mp4,$(out-dir)/%_out.avi,$(wildcard $(in-dir)/*.mp4))

$(out-dir)/%.skip: $(in-dir)/%.mp4
	@read -p "At what time (in milliseconds) does the experiment start in file '$<'? " tskip; \
	echo -n $$tskip > $@

$(out-dir)/%User.bbox: $(in-dir)/%.mp4 $(out-dir)/%.skip
	$(setBB) $<  `cat $(word 2, $^)`   > $@

$(out-dir)/%.bbox: $(in-dir)/%.mp4 $(out-dir)/%User.bbox $(out-dir)/%.skip
	$(rewindBB) $< $(word 2, $^) $(word 3, $^); cat outbbox.csv > $@

# $(out-dir)/%.csv: $(in-dir)/%.mp4 $(out-dir)/%.skip $(out-dir)/%.bbox
# 	$(cppmt) --skip-ms=`cat $(word 2, $^)` --bbox=`cat $(word 3, $^)` --with-rotation --quiet --output-file=$@ $<
#
# $(out-dir)/%_out.avi: $(out-dir)/%.csv $(in-dir)/%.mp4
# 	$(cppmt-r) $(word 2, $^) $< $(out-dir)

# clean:
# 	rm -f $(out-dir)/*.skip
# 	rm -f $(out-dir)/*.bbox
# 	rm -f $(out-dir)/*.csv
# 	rm -f $(out-dir)/*_out.avi
