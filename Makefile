#
# Build docker images for IDInteraction processing pipelines.
#
# Robert Haines, University of Manchester.
#

# Docker usually needs to run as root, so make sure we do.
root := $(shell id -u)
ifeq ($(root),0)
	docker = docker
else
	docker = sudo docker
endif

.PHONY: all base tracking video clean really-clean

all: .base .tracking .video

# Use empty targets to help make, but hide them as dotfiles.
base: .base
.base: base/Dockerfile
	$(docker) build -t idinteraction/base base/
	touch .base

tracking: .tracking
.tracking: .base tracking/Dockerfile tracking/Makefile
	$(MAKE) -C tracking
	$(docker) build -t idinteraction/tracking tracking/
	touch .tracking

video: .video
.video: .base video/Dockerfile video/resources/Makefile
	$(docker) build -t idinteraction/video video/
	touch .video

upload: all
	$(docker) push idinteraction/base
	$(docker) push idinteraction/tracking
	$(docker) push idinteraction/video

clean:
	-$(docker) stop `$(docker) ps -aq`
	-$(docker) rm -fv `$(docker) ps -aq`
	-$(docker) images -q --filter "dangling=true" | xargs $(docker) rmi

really-clean: clean
	rm -f .base .tracking .video
	$(MAKE) -C tracking clean
	-$(docker) rmi idinteraction/base
	-$(docker) rmi idinteraction/tracking
	-$(docker) rmi idinteraction/video
