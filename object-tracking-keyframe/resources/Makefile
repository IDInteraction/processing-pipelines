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
# IDInteraction object tracking process
#
# This Makefile is used to drive the manual bounding box setting process.
#

setBB=./setBB.py
trackvid=./trackFromKeyFrame.sh
in-dir=./videos
out-dir=./output

.PHONY: all init setbb track clean
.PRECIOUS: $(out-dir)/%.skip $(out-dir)/%User.bbox $(out-dir)/%.csv

all: init track
init: $(patsubst $(in-dir)/%.mp4,$(out-dir)/%User.bbox,$(wildcard $(in-dir)/*.mp4))
track: init $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.csv,$(wildcard $(in-dir)/*.mp4))
#replay: track $(patsubst $(in-dir)/%.mp4,$(out-dir)/%_out.avi,$(wildcard $(in-dir)/*.mp4))

$(out-dir)/%.skip: $(in-dir)/%.mp4
	@read -p "At what time (in milliseconds) does the experiment start in file '$<'? " tskip; \
	echo -n $$tskip > $@

$(out-dir)/%User.bbox: $(in-dir)/%.mp4 $(out-dir)/%.skip
	$(setBB) $<  `cat $(word 2, $^)`   > $@


$(out-dir)/%.csv: $(in-dir)/%.mp4 $(out-dir)/%User.bbox $(out-dir)/%.skip
	$(trackvid) $< $(word 2, $^) $(word 3, $^); cat combinedTracking.csv > $@

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
