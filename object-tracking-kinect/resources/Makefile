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
# IDInteraction cppMT pipeline for Kinect data
#
# This makefile runs the cppMT object tracker on KINECT data, and performs
# the necessary mappings to get the results back to "webcam time", which
# is the timebase we use in the paper.
#
empty :=
space := $(empty) $(empty)
cppmt=./cmt
# Contains frame offsets between Kinect and Webcam time and 
# when each part of the experiment started
controldir=./control
# Contains the original attention (ground-truth) files:
groundtruthdir=./attention
# Mappings between kinect and webcam times
# (Note this isn't just a case of take the offset; there are some dropped
# frames in the Kinect data we must take account of)
framemapdir=./framemap
# The mapping code we use goes here:
codedir=./abc-display-tool
# Results come out here:
outdir=./results
# Bounding boxes and skip frames go here:
bboxdir=./bbox
# Temporary directory (used for intermediate steps of rules)
tempdir=./tempdir
temptimedir=./temptimedir
# Contains the Kinect video data for each participant
videodir=./video
.PHONY: participants gentimes all
.PRECIOUS: $(outdir)/% $(tempdir)/% $(tempdir)/part1/%.csv $(tempdir)/part2/%.csv $(temptimedir)/%.start1  $(temptimedir)/%.start2 $(bboxdir)/part1/%.bbox $(bboxdir)/part2/%.bbox $(outdir)/part1/%.csv $(outdir)/part2/%.csv

groundtruthfiles=$(wildcard $(groundtruthdir)/P??_attention.txt)

participants = $(subst $(groundtruthdir)/,$(empty),$(subst _attention.txt,$(empty),$(groundtruthfiles)))
PHONY: all gentimes start1 start2 
#all: ; $(info  [${bbox1}])echo Hello world
all: track 

videofiles=$(wildcard $(videodir)/*.mp4)
videostem=_video.mp4
gentimes: start1 start2 
start1: $(patsubst $(videodir)/%, $(bboxdir)/%.start1, $(videofiles))
start2: $(patsubst $(videodir)/%, $(bboxdir)/%.start2, $(videofiles))

track: track1 track2
# removed bbox1/2 dependencies from rule below
track1: $(addsuffix .csv, $(basename $(basename $(patsubst $(videodir)/%, $(outdir)/part1/%.csv, $(videofiles)))))
track2: $(addsuffix .csv, $(basename $(basename $(patsubst $(videodir)/%, $(outdir)/part2/%.csv, $(videofiles)))))

bbox: bbox1 bbox2
bbox1: $(addsuffix .bbox, $(basename $(basename $(patsubst $(videodir)/%, $(bboxdir)/part1/%.bbox, $(videofiles)))))
bbox2: $(addsuffix .bbox, $(basename $(basename $(patsubst $(videodir)/%, $(bboxdir)/part2/%.bbox, $(videofiles)))))


# Extract the (kinect) frames each part of the experiment starts/ends at
# Is it possible to condense these rules into one?
# (End times aren't (currently) used in cppMT - we just run until the end
$(temptimedir)/%.start1: $(videodir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(groundtruthdir)/$(notdir $(basename $(subst $(videostem),$(empty),$@)))_attention.txt --outputfile $@ --participant $(notdir $(basename $(subst $(videostem),$(empty),$@))) --event start1 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemapdir)/$(notdir $(basename $(subst $(videostem),$(empty),$@)))_framelist.csv

$(temptimedir)/%.start2: $(videodir)/%
	$(codedir)/abc-extractAttention.py --attentionfile $(groundtruthdir)/$(notdir $(basename $(subst $(videostem),$(empty),$@)))_attention.txt --outputfile $@ --participant $(notdir $(basename $(subst $(videostem),$(empty),$@))) --event start2 --externaleventfile $(controldir)/transitionAnnotations.csv --offsetfile $(controldir)/frameoffsets.csv --framemap $(framemapdir)/$(notdir $(basename $(subst $(videostem),$(empty),$@)))_framelist.csv


# The files that come out of the above rules include a header and
# value to plot the event  on the vidoe frame.  We want the frame number
# alone. 
# this rule gets *just* the frame number in the file
# $$ needed to escape from make
$(bboxdir)/%: $(temptimedir)/%
	tail -1 $< |awk --field-separator=, '{print $$1}' |tr -d '\n' > $@

# These are the CppMT rules - based on the ones in the object-tracking
# pipeline. 

$(bboxdir)/part1/%.bbox: $(videodir)/%.mp4 $(bboxdir)/%.mp4.start1
	$(cppmt) --skip=`cat $(word 2, $^)` --process-frames=1 $< | head -1 | cut -d" " -f5 | tr -d '\n' > $@

$(tempdir)/part1/%.csv: $(videodir)/%.mp4  $(bboxdir)/%.mp4.start1 $(bboxdir)/part1/%.bbox
	$(cppmt) --skip=`cat $(word 2, $^)` --bbox=`cat $(word 3, $^)` --with-rotation --quiet --output-file=$@ $<

$(bboxdir)/part2/%.bbox: $(videodir)/%.mp4 $(bboxdir)/%.mp4.start2
	$(cppmt) --skip=`cat $(word 2, $^)` --process-frames=1 $< | head -1 | cut -d" " -f5 | tr -d '\n' > $@

$(tempdir)/part2/%.csv: $(videodir)/%.mp4  $(bboxdir)/%.mp4.start2 $(bboxdir)/part2/%.bbox
	$(cppmt) --skip=`cat $(word 2, $^)` --bbox=`cat $(word 3, $^)` --with-rotation --quiet --output-file=$@ $<

# All of the tracking is done in the Kinect timebase.  We need to map it
# back to webcam times for onward analysis 
$(outdir)/%: $(tempdir)/%
	python $(codedir)/remapFrames.py --infile $< --outfile $@ --framemap $(framemapdir)/$(subst $(basename $(videostem)),$(empty),$(basename $(notdir $@)))_framelist.csv --frameoffsetfile $(controldir)/frameoffsets.csv --participant $(subst $(basename $(videostem)), $(empty),$(basename $(notdir $@)))
