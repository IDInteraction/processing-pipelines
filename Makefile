#------------------------------------------------------------------------------
# Copyright (c) 2015, 2016 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

.PHONY: all analysis base cppmt tracking object-tracking video setbb opencvbb clean really-clean opencv object-tracking-keyframe

all: .analysis .base .cppmt .tracking .video .opencv .setbb .opencvbb .tracking-keyframe .tracking-no-rotation

# Use empty targets to help make, but hide them as dotfiles.
analysis: .analysis
.analysis: analysis/Dockerfile analysis/resources/install.R
	docker build -t idinteraction/analysis analysis/
	touch .analysis

base: .base
.base: base/Dockerfile
	docker build -t idinteraction/base:3.0 base/
	touch .base

cppmt: .cppmt
.cppmt: .base cppmt/Dockerfile cppmt/Makefile
	$(MAKE) -C cppmt
	docker build -t idinteraction/cppmt cppmt/
	touch .cppmt

tracking: .tracking
object-tracking: .tracking
.tracking: object-tracking/Dockerfile object-tracking/resources/Makefile
	docker build -t idinteraction/object-tracking object-tracking/
	touch .tracking

tracking-no-rotation: .tracking-no-rotation
object-tracking-no-rotation: .tracking-no-rotation
.tracking-no-rotation: object-tracking-no-rotation/Dockerfile object-tracking-no-rotation/resources/Makefile
	docker build -t idinteraction/object-tracking-no-rotation object-tracking-no-rotation/
	touch .tracking-no-rotation


tracking-keyframe: .tracking-keyframe
object-tracking-keyframe: .tracking-keyframe
.tracking-keyframe: object-tracking-keyframe/Dockerfile object-tracking-keyframe/resources/Makefile
		docker build -t idinteraction/object-tracking-keyframe object-tracking-keyframe/
		touch .tracking-keyframe


opencv: .opencv
.opencv: opencv/Dockerfile opencv/resources/Makefile
		docker build -t idinteraction/opencv opencv/
		touch .opencv

setbb: .setbb
.setbb: setBB/Dockerfile setBB/resources/Makefile
		docker build -t idinteraction/setbb setBB/
		touch .setbb

opencvbb: .opencvbb
.opencvbb:	opencvBB/Dockerfile opencvBB/resources/Makefile
	docker build -t idinteraction/opencvbb opencvBB
	touch .opencvbb


video: .video
.video: .base video/Dockerfile video/resources/Makefile
	docker build -t idinteraction/video video/
	touch .video

upload: all
	docker push idinteraction/analysis
	docker push idinteraction/base
	docker push idinteraction/cppmt
	docker push idinteraction/object-tracking
	docker push idinteraction/object-tracking-no-rotation
	docker push idinteraction/opencv
	docker push idinteraction/video
	docker push idinteraction/setbb
	docker push idinteraction/opencvbb
	docker push idinteraction/object-tracking-keyframe

clean:
	rm -f .analysis .base .cppmt .tracking .opencv .video .setbb .opencvbb .tracking-keyframe .tracking-no-rotation
	$(MAKE) -C cppmt clean
	-docker stop `docker ps -aq`
	-docker rm -fv `docker ps -aq`
	-docker images -q --filter "dangling=true" | xargs docker rmi

really-clean: clean
	-docker rmi idinteraction/analysis
	-docker rmi idinteraction/base
	-docker rmi idinteraction/cppmt
	-docker rmi idinteraction/object-tracking
	-docker rmi idinteraction/video
	-docker rmi idinteraction/opencv
	-docker rmi idinteraction/setbb
	-docker rmi idinteraction/opencvbb
	-docker rmi idinteraction/object-tracking-keyframe
