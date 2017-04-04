#------------------------------------------------------------------------------
# Copyright (c) 2017 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: David Mawdsley
#------------------------------------------------------------------------------
#
# IDInteraction depth data processing pipeline
#
# This makefile takes a series of depth frames and applies PCA and
# mixture model analysis to both parts of the experiment, for each participant

controldir=../controlfiles
attentiondir=../attention
codedir=./abc-display-tool
outframetimedir=./frametimedir
frametimedir=./tempframetimedir
framesourcedir=/media/sf_IDInteraction/Kinect/depth
framemap=../kinect_webcam
.PHONY: participants gentimes all
.PRECIOUS: $(frametimedir)/%.start1
# Might be a quicker way of doing this?? Traverses the whole tree
participants = $(shell find $(framesourcedir)/P* -type d)
#PHONY: all
#all: ; $(info $$var is [${var}])echo Hello world
all: gentimes

gentimes: start1 start2 end1 end2
start1: $(patsubst $(framesourcedir)/%, $(outframetimedir)/%.start1, $(participants)) 
start2: $(patsubst $(framesourcedir)/%, $(outframetimedir)/%.start2, $(participants)) 
end1: $(patsubst $(framesourcedir)/%, $(outframetimedir)/%.end1, $(participants)) 
end2: $(patsubst $(framesourcedir)/%, $(outframetimedir)/%.end2, $(participants)) 

# Extract the (kinect) frames each part of the experiment starts/ends at
# Is it possible to condense these rules into one?
$(frametimedir)/%.start1: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event start1 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv

$(frametimedir)/%.start2: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event start2 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv

$(frametimedir)/%.end1: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event end1 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv

$(frametimedir)/%.end2: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event end2 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv

# Process an intermediate timing point
# Gets *just* the fame number in the file
$(outframetimedir)/%: $(frametimedir)/%
	tail -1 $< |awk --field-separator=, '{print $$1}' > $@
