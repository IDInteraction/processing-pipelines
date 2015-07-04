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

.PHONY: all base clean really-clean

all: .base

# Use empty targets to help make but hide them as dotfiles.
base: .base
.base: docker/base/Dockerfile
	$(docker) build -t idinteraction/base docker/base/
	touch .base

upload: all
	$(docker) push idinteraction/base

clean:
	-$(docker) stop `$(docker) ps -aq`
	-$(docker) rm -fv `$(docker) ps -aq`
	-$(docker) images -q --filter "dangling=true" | xargs $(docker) rmi

really-clean: clean
	rm -f .base
	-$(docker) rmi idinteraction/base
