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

.PHONY: all analysis base cppmt tracking object-tracking video clean really-clean abc-extractattention abc-classify abc-classifysweep

all: .analysis .base .cppmt .tracking .video .abc-extractattention .abc-classify .abc-classifysweep 

# Use empty targets to help make, but hide them as dotfiles.
analysis: .analysis
.analysis: analysis/Dockerfile analysis/resources/install.R
	docker build -t idinteraction/analysis analysis/
	touch .analysis

base: .base
.base: base/Dockerfile
	docker build -t idinteraction/base base/
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


.video: .base video/Dockerfile video/resources/Makefile
	docker build -t idinteraction/video video/
	touch .video

.abc-extractattention: .base abc-extractattention/Dockerfile 
	docker build -t idinteraction/abc-extractattention abc-extractattention/
	touch .abc-extractattention

.abc-classify: .base abc-classify/Dockerfile
	docker build -t idinteraction/abc-classify abc-classify/
	touch .abc-classify

.abc-classifysweep: .base abc-classifysweep/Dockerfile abc-classifysweep/Makefile
	docker build -t idinteraction/abc-classifysweep abc-classifysweep/
	touch .abc-classifysweep

upload: all
	docker push idinteraction/analysis
	docker push idinteraction/base
	docker push idinteraction/cppmt
	docker push idinteraction/object-tracking
	docker push idinteraction/video
	docker push idinteraction/abc-extractattention
	docker push idinteraction/abc-classify
clean:
	rm -f .analysis .base .cppmt .tracking .video .abc-extractattention .abc-classify
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
