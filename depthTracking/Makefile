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
# The depth range of interest:
mindepth?=710
maxdepth?=1710

# Contains frame offsets between Kinect and Webcam time and 
# when each part of the experiment started
controldir=./control
# Contains the original attention (ground-truth) files:
attentiondir=./attention
# Mappings between kinect and webcam times
# (Note this isn't just a case of take the offset; there are some dropped
# frames in the Kinect data we must take account of)
framemapdir=./framemap
# All the code we use goes here:
codedir=./abc-display-tool
# Results come out here:
outdir=./results
# Temporary directory (used for intermediate steps of rules)
tempdir=./tempdir
temptimedir=./temptimedir
# Contains the participants' depth data, in folders below this
# i.e. $(framesourcedir)/P01 etc.
framesourcedir=./framesource
.PHONY: participants gentimes all
.PRECIOUS: $(outdir)/% $(tempdir)/% $(temptimedir)/%.start1  $(temptimedir)/%.start2 $(temptimedir)/%.end1  $(temptimedir)/%.end2


participants = $(shell find $(framesourcedir)/P* -maxdepth 0 -type d)
PHONY: all gentimes start1 start2 end1 end2 pca pca1 pca2 mixture mixture1 mixture2
#all: ; $(info $$var is [${var}])echo Hello world
all: mixture pca 

gentimes: start1 start2 end1 end2
start1: $(patsubst $(framesourcedir)/%, $(outdir)/%.start1, $(participants)) 
start2: $(patsubst $(framesourcedir)/%, $(outdir)/%.start2, $(participants)) 
end1: $(patsubst $(framesourcedir)/%, $(outdir)/%.end1, $(participants)) 
end2: $(patsubst $(framesourcedir)/%, $(outdir)/%.end2, $(participants)) 

pca: pca1 pca2
pca1: $(patsubst $(framesourcedir)%, $(outdir)/%.pca1, $(participants))
pca2: $(patsubst $(framesourcedir)%, $(outdir)/%.pca2, $(participants))

mixture: mixture1 mixture2
mixture1: $(patsubst $(framesourcedir)%, $(outdir)/%.mixture1, $(participants))
mixture2: $(patsubst $(framesourcedir)%, $(outdir)/%.mixture2, $(participants))

# Extract the (kinect) frames each part of the experiment starts/ends at
# Is it possible to condense these rules into one?
$(temptimedir)/%.start1: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event start1 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemapdir)/$(notdir $(basename $@))_framelist.csv

$(temptimedir)/%.start2: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event start2 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemapdir)/$(notdir $(basename $@))_framelist.csv

$(temptimedir)/%.end1: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event end1 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemapdir)/$(notdir $(basename $@))_framelist.csv

$(temptimedir)/%.end2: $(framesourcedir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(attentiondir)/$(notdir $(basename $@))_attention.txt --outputfile $@ --participant $(notdir $(basename $@)) --event end2 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemapdir)/$(notdir $(basename $@))_framelist.csv

# The files that come out of the above rules include a header and
# value to plot the event  on the vidoe frame.  We want the frame number
# alone. 
# this rule gets *just* the frame number in the file
# $$ needed to escape from make
$(outdir)/%: $(temptimedir)/%
	tail -1 $< |awk --field-separator=, '{print $$1}' > $@

# PCA
$(tempdir)/%.pca1: $(framesourcedir)/% $(outdir)/%.start1 $(outdir)/%.end1
	python $(codedir)/depthPCA.py --infolder $</ --frameprefix depthDepth --noshuffle --mindepth=$(mindepth) --maxdepth=$(maxdepth) --startframe=`cat $(word 2, $^)` --endframe=`cat $(word 3, $^)` --outfile=$@ --pickle $@.pickle

$(tempdir)/%.pca2: $(framesourcedir)/% $(outdir)/%.start2 $(outdir)/%.end2
	python $(codedir)/depthPCA.py --infolder $</ --frameprefix depthDepth --noshuffle --mindepth=$(mindepth) --maxdepth=$(maxdepth) --startframe=`cat $(word 2, $^)` --endframe=`cat $(word 3, $^)` --outfile=$@ --pickle $@.pickle

$(tempdir)/%.mixture1: $(framesourcedir)/% $(outdir)/%.start1 $(outdir)/%.end1
	python $(codedir)/fitmixture.py --infolder $</ --frameprefix depthDepth --numcomponents=0 --componentsample=20 --maxcomponents=10 --startframe=`cat $(word 2, $^)` --endframe=`cat $(word 3, $^)` --outfile=$@ --pickle --mindepth=$(mindepth) --maxdepth=$(maxdepth)

$(tempdir)/%.mixture2: $(framesourcedir)/% $(outdir)/%.start2 $(outdir)/%.end2
	python $(codedir)/fitmixture.py --infolder $</ --frameprefix depthDepth --numcomponents=0 --componentsample=20 --maxcomponents=10 --startframe=`cat $(word 2, $^)` --endframe=`cat $(word 3, $^)` --outfile=$@ --pickle --mindepth=$(mindepth) --maxdepth=$(maxdepth)

# All of the tracking is done in the Kinect timebase.  We need to map it
# back to webcam times for onward analysis 
$(outdir)/%: $(tempdir)/%
	python $(codedir)/remapFrames.py --infile $< --outfile $@ --framemap $(framemapdir)/$(notdir $(basename $@))_framelist.csv --frameoffsetfile $(controldir)/frameoffsets.csv --participant $(notdir $(basename $@))
