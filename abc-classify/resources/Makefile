# Makefile to run abc-classify
#
# This requires that we've already generated tracking data for
# each input  video
#
# For each video we require the start and end frames for the period
#  of interest and the tracking data
#

classify=./abc-classify.py

video-dir=video
tracking-dir=tracking
out-dir=output

.PRECIOUS: $(out-dir)/*.start $(out-dir)/%.end $(out-dir)/%.csv

all: start end classify

start: $(patsubst $(video-dir)/%.mp4,$(out-dir)/%.start,$(wildcard $(video-dir)/*.mp4))

end: $(patsubst $(video-dir)/%.mp4,$(out-dir)/%.end,$(wildcard $(video-dir)/*.mp4))

classify: start end $(patsubst $(video-dir)/%.mp4,$(out-dir)/%.csv,$(wildcard $(video-dir)/*.mp4))

$(out-dir)/%.start: $(video-dir)/%.mp4
	@read -p "At what frame does the experiment start in file '$<'? " tskip; \
	echo -n $$tskip > $@	


$(out-dir)/%.end: $(video-dir)/%.mp4
	@read -p "At what frame does the experiment finish in file '$<'? " tskip; \
	echo -n $$tskip > $@	

$(out-dir)/%.csv: $(video-dir)/%.mp4 $(out-dir)/%.start $(out-dir)/%.end 
	$(classify) --videofile $< --trackerfile `./getTracking.sh $(tracking-dir)  $(basename $(notdir $@))` --startframe `cat $(word 2, $^)` --endframe `cat $(word 3, $^)` --outfile $@


