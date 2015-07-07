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

.PHONY: all base video clean really-clean

all: .base .video

# Use empty targets to help make, but hide them as dotfiles.
base: .base
.base: base/Dockerfile
	$(docker) build -t idinteraction/base base/
	touch .base

video: .video
.video: .base video/Dockerfile video/resources/Makefile
	$(docker) build -t idinteraction/video video/
	touch .video

upload: all
	$(docker) push idinteraction/base
	$(docker) push idinteraction/video

clean:
	-$(docker) stop `$(docker) ps -aq`
	-$(docker) rm -fv `$(docker) ps -aq`
	-$(docker) images -q --filter "dangling=true" | xargs $(docker) rmi

really-clean: clean
	rm -f .base .video
	-$(docker) rmi idinteraction/base
	-$(docker) rmi idinteraction/video
