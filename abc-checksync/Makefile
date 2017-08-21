# Makefile to check the synchronisation of videos against
# groundtruth (or (TODO) against predictions)
#
#
# David Mawdsley 2017
#
#
empty :=
space := $(empty) $(empty)
.PHONY: all cleanresults jobs
# The videos we want to superimpose the data on
invideodir=/idinteraction/videos
# The mapped ground truth and videos with superimposed data will appear here
outputdir=/idinteraction/output
# The folder containing the ground truth (attention) data
groundtruthdir=/idinteraction/groundtruth
# The mapping of each kinect frame to a (relative) webcam frame
framemapdir=/idinteraction/framemap
# The offsets (in frames) between the start of the webcam and start of the
# Kinect video
offsetdir=/idinteraction/offset


groundtruthfiles=$(wildcard $(groundtruthdir)/P??_attention.txt)

# We work out a list of participant codes by deleting everything
# *except* the P code
participants=$(subst $(groundtruthdir)/,$(empty),$(subst _attention.txt,$(empty),$(groundtruthfiles)))




videofiles=$(wildcard $(invideodir)/*.mp4)
processedgroundtruthfiles=$(addsuffix _processedGT.csv,$(addprefix $(outputdir)/, $(participants)))
processedvideofiles=$(addsuffix _check.avi, $(addprefix $(outputdir)/, $(participants)))



processedgt: $(processedgroundtruthfiles)
processedvideo: $(processedvideofiles)

PHONY: all processedgt processedvideo 

all:  $(outputdir)/%_check.avi

$(outputdir)/%_processedGT.csv: $(groundtruthdir)/%_attention.txt 
	./abc-display-tool/abc-extractAttention.py --attentionfile $< --participant $(subst $(groundtruthdir)/,$(empty),$(subst _attention.txt,$(empty),$<)) --framemap $(framemapdir)/$(subst $(groundtruthdir)/,$(empty),$(subst _attention.txt,$(empty),$<))_framelist.csv --offsetfile $(offsetdir)/frameoffsets.csv --outputfile $@

$(outputdir)/%_check.avi: $(invideodir)/%_video.mp4 $(outputdir)/%_processedGT.csv
	./abc-display-tool/showboxes.py $< $@ $(word 2, $^)

#jobfiles=$(wildcard $(jobfiledir)/*.job)
#outputfiles=$(patsubst $(jobfiledir)/%.job, $(outputdir)/%.jobstat, $(jobfiles))
#
#all: jobs
#
#cleanresults: 
#	$(foreach job,$(outputfiles), rm -rf $(shell head -1 $(job)) && ) :
#	rm  $(outputfiles)
#	rm $(outputdir)/*.sh
#	
#
#jobs: $(outputfiles)
#
#$(outputdir)/%.jobstat: $(jobfiledir)/%.job
#	# TODO check script has precisely 2 lines 
#	rm -rf $(shell head -1 $<) && mkdir -p $(shell head -1 $<) && cd $(shell head -1 $<) && /idinteraction/jobrunner/jobrunner.py '$(shell cat $< | head -2 | tail -1)' --extvarfile  p:$(resultsdir)/participantcodes.txt > $(basename $@).sh && bash $(basename $@).sh  && echo $(shell head -1 $<) > $@ 
#
#
#
#
#
