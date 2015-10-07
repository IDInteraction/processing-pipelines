# IDInteraction Processing Pipelines

*Pipelines for converting video files and object tracking for automated behavioural coding.*

## Prerequisites

The only software needed to run these pipelines is [Docker][docker]. Please see the [installation instructions for your platform][dockerdocs] to get started.

To build these pipelines you will also need:
* make
* CMake
* OpenCV 2.4

You should use the pre-built docker images, described below, if you possibly can.

## Getting the Docker images

All of our Docker images are available from the [Docker Hub][dockerhub].

To get the latest version of the [video processing image][videoimage] run:

```shell
$ docker pull idinteraction/video
```

Images are tagged every so often to denote a stable, production quality release. A specific tagged image can be pulled like so:

```shell
$ docker pull idinteraction/<image>:<tag>
```

## Running the pipelines

This will depend on which platform you are using. For now the instructions below are for Linux.

### Video processing

*Process the video streams of the participants in our experiments in preparation for input to the object tracking pipeline.*

The raw video streams are quartered, showing the participants from three directions and the TV they are watching in one frame. This pipeline takes a set of raw experiment videos and splits them into separate streams for the front, side and back view of each participant.

The directory holding the raw video streams and the directory to which the processed video streams will be saved must be specified when running the docker image. It is advisable to mount the input directory as 'read-only'.

The following command will run the video processing pipeline on any videos it finds in the input directory (edit the parts in `<angle brackets>` to suit your set up):

```shell
$ docker run -it --rm --name=<name> \
 -v <input-directory>:/idinteraction/in:ro \
 -v <output-directory>:/idinteraction/out \
 idinteraction/video
```

### Object tracking

*Collect metadata about the video streams to be processed and then perform object tracking.*

To configure video starting position and object bounding boxes, use:

```shell
$ docker run -it --rm --name=<name> \
 -v <video-directory>:/idinteraction/videos \
 -v /tmp/.X11-unix:/tmp/.X11-unix \
 -e DISPLAY=unix$DISPLAY \
 idinteraction/object-tracking init
```

To perform object tracking only, use:

```shell
$ docker run -it --rm --name=<name> \
 -v <video-directory>:/idinteraction/videos \
 idinteraction/object-tracking track
```

To perform both steps in one go:

```shell
$ docker run -it --rm --name=<name> \
 -v <video-directory>:/idinteraction/videos \
 -v /tmp/.X11-unix:/tmp/.X11-unix \
 -e DISPLAY=unix$DISPLAY \
 idinteraction/object-tracking
```

## Acknowledgements

The IDInteraction Processing Pipelines were developed in the IDInteraction project, funded by the Engineering and Physical Sciences Research Council, UK through grant agreement number [EP/M017133/1][gow].

## Licence

Copyright (c) 2015 The University of Manchester, UK.

Licenced under LGPL version 2.1. See LICENCE for details.

[docker]: https://www.docker.com/
[dockerdocs]: https://docs.docker.com/
[dockerhub]: https://hub.docker.com/u/idinteraction/
[videoimage]: https://hub.docker.com/r/idinteraction/video/
[gow]: http://gow.epsrc.ac.uk/NGBOViewGrant.aspx?GrantRef=EP/M017133/1
