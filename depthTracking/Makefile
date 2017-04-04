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
mindepth=710
maxdepth=1710

controldir=../controlfiles
attentiondir=../attention
codedir=./abc-display-tool
outframetimedir=./frametimedir
tempdir=./tempdir
tempdirpca=./tempdirpca
#framesourcedir=/media/sf_IDInteraction/Kinect/depth
framesourcedir=./depthexample
framemap=../kinect_webcam
pcadir=./PCA
.PHONY: participants gentimes all
.PRECIOUS: $(frametimedir)/%.start1 $(frametimedir)/%.start2 $(pcadir)/%
# Might be a quicker way of doing this?? Traverses the whole tree
participants = $(shell find $(framesourcedir)/P* -type d)
#PHONY: all
#all: ; $(info $$var is [${var}])echo Hello world
all: pca 

gentimes: start1 start2 end1 end2
start1: $(patsubst $(framesourcedir)/%, $(outframetimedir)/%.start1, $(participants)) 
start2: $(patsubst $(framesourcedir)/%, $(outframetimedir)/%.start2, $(participants)) 
end1: $(patsubst $(framesourcedir)/%, $(outframetimedir)/%.end1, $(participants)) 
end2: $(patsubst $(framesourcedir)/%, $(outframetimedir)/%.end2, $(participants)) 

pca: pca1 pca2
pca1: $(patsubst $(framesourcedir)%, $(pcadir)/%.pca1, $(participants))
pca2: $(patsubst $(framesourcedir)%, $(pcadir)/%.pca2, $(participants))

# Extract the (kinect) frames each part of the experiment starts/ends at
# Is it possible to condense these rules into one?
$(tempdir)/%.start1: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event start1 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv

$(tempdir)/%.start2: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event start2 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv

$(tempdir)/%.end1: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event end1 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv

$(tempdir)/%.end2: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event end2 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv

# Process an intermediate timing point
# Gets *just* the frame number in the file
# $$ needed to escape from make
$(outframetimedir)/%: $(tempdir)/%
	tail -1 $< |awk --field-separator=, '{print $$1}' > $@

# PCA
$(tempdirpca)/%.pca1: $(framesourcedir)/% $(outframetimedir)/%.start1 $(outframetimedir)/%.end1
	python $(codedir)/depthPCA.py --infolder $</ --frameprefix depthDepth --noshuffle --mindepth=$(mindepth) --maxdepth=$(maxdepth) --startframe=`cat $(word 2, $^)` --endframe=`cat $(word 3, $^)` --outfile=$@ --pickle $@.pickle

$(tempdirpca)/%.pca2: $(framesourcedir)/% $(outframetimedir)/%.start2 $(outframetimedir)/%.end2
	python $(codedir)/depthPCA.py --infolder $</ --frameprefix depthDepth --noshuffle --mindepth=$(mindepth) --maxdepth=$(maxdepth) --startframe=`cat $(word 2, $^)` --endframe=`cat $(word 3, $^)` --outfile=$@ --pickle $@.pickle
# Remap PCA to webcam timebase
$(pcadir)/%: $(tempdirpca)/%
	$(codedir)/remapframes.py --infile $< --outfile $@ --framemap $(framemap)/$(notdir $(basename $@))_framelist.csv --frameoffsetfile $(controldir)/frameoffsets.csv --participant $(notdir $(basename $@))