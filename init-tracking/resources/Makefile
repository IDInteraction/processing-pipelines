#
# IDInteraction object tracking pipeline initialization.
#
# This Makefile is used to initialize the object tracking process by collecting
# set up information about each input video:
#  * The amount of time to ignore at the start of the video
#  * The initial bounding box of the object to be tracked in the video
#
# Robert Haines, University of Manchester.
#

cppmt=./cmt
video-dir=videos

.PHONY: all
.PRECIOUS: $(video-dir)/%.skip

all: $(patsubst $(video-dir)/%.mp4,$(video-dir)/%.bbox,$(wildcard $(video-dir)/*.mp4))

$(video-dir)/%.skip: $(video-dir)/%.mp4
	@read -p "At what time (in milliseconds) does the experiment start in file '$<'? " tskip; \
	echo -n $$tskip > $@

$(video-dir)/%.bbox: $(video-dir)/%.mp4 $(video-dir)/%.skip
	$(cppmt) --skip-ms=`cat $(word 2, $^)` --process-frames=1 $< | head -1 | cut -d" " -f5 | tr -d '\n' > $@
