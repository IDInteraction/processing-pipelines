# Run Openface on each video
# We first double the size of each video, since this gave  qualitatively
# smoother tracking of the face

feature = $(IDI_HOME)/OpenFace/build/bin/FeatureExtraction


in-dir=videos
out-dir=output

all: openface

openface: $(patsubst $(in-dir)/%.mp4,$(out-dir)/%.openface, $(wildcard $(in-dir)/*.mp4))



$(out-dir)/%.openface: $(out-dir)/%.scaled.mp4 
	$(feature) -f $< -of $@  -q

$(out-dir)/%.scaled.mp4: $(in-dir)/%.mp4
	ffmpeg -i $< -vf scale=iw*2.0:ih*2.0 $@

