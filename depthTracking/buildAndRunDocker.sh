#!/bin/bash

# (build and) Run the docker depth image

docker build DockerDepth -t idinteraction/dockerdepth

# Set up the mount points needed by the docker image
controldir=../controlfiles
attentiondir=../attention
framemapdir=../kinect_webcam
framesourcedir=./depthexample
outdir=./depthresultsdocker
docker run -it -v `pwd`/${outdir}:/idinteraction/results/ -v `pwd`/${framemapdir}:/idinteraction/framemap/:ro -v `pwd`/${framesourcedir}:/idinteraction/framesource/:ro -v `pwd`/${controldir}:/idinteraction/control/:ro -v `pwd`/${attentiondir}:/idinteraction/attention/:ro --entrypoint /bin/bash idinteraction/dockerdepth

#-v `pwd`/contrib:/tmp/contrib