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
# IDInteraction video processing pipeline.
#
# This Makefile converts each input video into three separate videos - one for
# each angle that is captured during an experiment.
#

in-dir=in
out-dir=out
front-dir=$(out-dir)/front
side-dir=$(out-dir)/side
back-dir=$(out-dir)/back

pass1-opts=-x264encopts pass=1:turbo:bframes=3:b_pyramid=normal:bitrate=900:me=umh:partitions=all:qp_step=4:qcomp=0.7:direct_pred=auto
pass2-opts=-x264encopts pass=2:subq=7:frameref=6:bframes=3:b_pyramid=normal:bitrate=900:me=umh:partitions=all:8x8dct:trellis=2:qp_step=4:qcomp=0.7:direct_pred=auto

.PHONY: all all-front all-side all-back

all: all-front all-side all-back
all-front: $(patsubst $(in-dir)/%.mov,$(front-dir)/%.mp4,$(wildcard $(in-dir)/*.mov))
all-side: $(patsubst $(in-dir)/%.mov,$(side-dir)/%.mp4,$(wildcard $(in-dir)/*.mov))
all-back: $(patsubst $(in-dir)/%.mov,$(back-dir)/%.mp4,$(wildcard $(in-dir)/*.mov))

$(front-dir):
	mkdir $(front-dir)

$(side-dir):
	mkdir $(side-dir)

$(back-dir):
	mkdir $(back-dir)

$(front-dir)/%.mp4: $(in-dir)/%.mov | $(front-dir)
	rm -f $@.tmp
	mencoder $< -ovc x264 $(pass1-opts) -vf crop=640:360:640:0 -really-quiet -nosound -o /dev/null
	mencoder $< -ovc x264 $(pass2-opts) -vf crop=640:360:640:0 -really-quiet -nosound -o $@.tmp
	mv $@.tmp $@

$(side-dir)/%.mp4: $(in-dir)/%.mov | $(side-dir)
	rm -f $@.tmp
	mencoder $< -ovc x264 $(pass1-opts) -vf crop=640:360:0:0 -really-quiet -nosound -o /dev/null
	mencoder $< -ovc x264 $(pass2-opts) -vf crop=640:360:0:0 -really-quiet -nosound -o $@.tmp
	mv $@.tmp $@

$(back-dir)/%.mp4: $(in-dir)/%.mov | $(back-dir)
	rm -f $@.tmp
	mencoder $< -ovc x264 $(pass1-opts) -vf crop=640:360:640:360 -really-quiet -nosound -o /dev/null
	mencoder $< -ovc x264 $(pass2-opts) -vf crop=640:360:640:360 -really-quiet -nosound -o $@.tmp
	mv $@.tmp $@
