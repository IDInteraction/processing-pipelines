# Makefile to generate facial landmark co-ordinates given 

getlandmarks = python outputLandmarks.py


in-dir=videos
out-dir=output

all: landmark

landmark: $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.landmarks, $(wildcard $(in-dir)/*.mp4))

$(out-dir)/%.landmarks: $(in-dir)/%.mp4 $(out-dir)/%.csv $(out-dir)/%.skip
	$(getlandmarks) --infile $< --outfile $@ --skipms `cat $(word 3, $^)` --bboxes $(word 2, $^)  

