#
# IDInteraction object tracking pipeline.
#
# This Makefile is used to drive the object tracking process.
#
# Robert Haines, University of Manchester.
#

cppmt=./cmt
video-dir=videos

.PHONY: all clean

all: $(patsubst $(video-dir)/%.mp4,$(video-dir)/%.csv,$(wildcard $(video-dir)/*.mp4))

$(video-dir)/%.csv: $(video-dir)/%.mp4 $(video-dir)/%.skip $(video-dir)/%.bbox
	$(cppmt) --skip-ms=`cat $(word 2, $^)` --bbox=`cat $(word 3, $^)` --with-rotation --quiet --output-file=$@ $<

clean:
	rm -f $(video-dir)/*.csv
