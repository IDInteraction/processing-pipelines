#------------------------------------------------------------------------------
# Copyright (c) 2015, 2016, 2017 The University of Manchester, UK.
#
# Licenced under LGPL version 2.1. See LICENCE for details.
#
# The IDInteraction Processing Pipelines were developed in the IDInteraction
# project, funded by the Engineering and Physical Sciences Research Council,
# UK through grant agreement number EP/M017133/1.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

.PHONY: all analysis base cppmt sklearn tracking object-tracking video clean really-clean abc-extractattention abc-classify abc-classifysweep dockerdepth checksync object-tracking-kinect

all: .analysis .base .cppmt .tracking .video .abc-extractattention .abc-classify .abc-classifysweep .dockerdepth .checksync .sklearn .object-tracking-kinect

# Use empty targets to help make, but hide them as dotfiles.
analysis: .analysis
.analysis: analysis/Dockerfile analysis/resources/install.R
	docker build -t idinteraction/analysis analysis/
	touch .analysis

base: .base
.base: base/Dockerfile
	docker build -t idinteraction/base base/
	touch .base

opencv3base: .opencv3base
.opencv3base: opencv3base/Dockerfile
	docker build -t idinteraction/opencv3base opencv3base/
	touch .opencv3base

abc-tdr: .abc-tdr
.abc-tdr: abc-tdr/Dockerfile
	docker build -t idinteraction/abc-tdr abc-tdr
	touch .abc-tdr

object-tracking-kinect: .object-tracking-kinect
.object-tracking-kinect: .base object-tracking-kinect/Dockerfile object-tracking-kinect/Makefile object-tracking-kinect/resources/Makefile
	$(MAKE) -C object-tracking-kinect
	docker build -t idinteraction/object-tracking-kinect object-tracking-kinect/
	touch .object-tracking-kinect

cppmt: .cppmt
.cppmt: .base cppmt/Dockerfile cppmt/Makefile
	$(MAKE) -C cppmt
	docker build -t idinteraction/cppmt cppmt/
	touch .cppmt

sklearn: .sklearn
.sklearn: .base sklearn/Dockerfile
	docker build -t idinteraction/sklearn sklearn
	touch .sklearn

tracking: .tracking
object-tracking: .tracking
.tracking: object-tracking/Dockerfile object-tracking/resources/Makefile
	docker build -t idinteraction/object-tracking object-tracking/
	touch .tracking

tracking-keyframe: .tracking-keyframe
object-tracking-keyframe: .tracking-keyframe
.tracking-keyframe: object-tracking-keyframe/Dockerfile object-tracking-keyframe/resources/Makefile
		docker build -t idinteraction/object-tracking-keyframe object-tracking-keyframe/
		touch .tracking-keyframe


opencv: .opencv
.opencv: opencv/Dockerfile opencv/resources/Makefile
		docker build -t idinteraction/opencv opencv/
		touch .opencv
openface: .openface
.openface: openface/Dockerfile openface/resources/Makefile
		docker build -t idinteraction/openface openface/
		touch .openface


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

.abc-extractattention: .base abc-extractattention/Dockerfile 
	docker build -t idinteraction/abc-extractattention abc-extractattention/
	touch .abc-extractattention

.abc-classify: .base abc-classify/Dockerfile abc-classify/abc-display-tool/abc-classify.py
	docker build -t idinteraction/abc-classify abc-classify/
	touch .abc-classify

.dockerdepth: .base .sklearn depthTracking/Dockerfile depthTracking/Makefile
	docker build -t idinteraction/dockerdepth depthTracking/
	touch .dockerdepth

.checksync: .opencv abc-checksync/Dockerfile abc-checksync/Makefile
	docker build -t idinteraction/checksync abc-checksync/
	touch .checksync

.abc-classifysweep: .base abc-classifysweep/Dockerfile abc-classifysweep/Makefile abc-classifysweep/jobrunner/jobrunner.py abc-classifysweep/jobrunner/processjob.py abc-classifysweep/abc-display-tool/abc-classify.py

	docker build -t idinteraction/abc-classifysweep:refactor abc-classifysweep/
	touch .abc-classifysweep

upload: all
	docker push idinteraction/analysis
	docker push idinteraction/base
	docker push idinteraction/cppmt
	docker push idinteraction/object-tracking
	docker push idinteraction/opencv
	docker push idinteraction/video
	docker push idinteraction/abc-extractattention
	docker push idinteraction/abc-classify
	docker push idinteraction/abc-classifysweep
	docker push idinteraction/dockerdepth
	docker push idinteraction/checksync
	docker push idinteraction/sklearn
	docker push idinteraction/object-tracking-kinect
clean:
	rm -f .analysis .base .cppmt .tracking .video .abc-extractattention .abc-classify .dockerdepth .checksync .sklearn .object-tracking-kinect
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
	-docker rmi idinteraction/abc-extractattention
	-docker rmi idinteraction/abc-classify
	-docker rmi idinteraction/abc-classifysweep
	-docker rmi idinteraction/dockerdepth
	-docker rmi idinteraction/checksync
	-docker rmi idinteraction/sklearn
	-docker rmi idinteraction/object-tracking-kinect

