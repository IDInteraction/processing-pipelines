#!/bin/bash

# Run the docker depth image


# Set up the mount points needed by the docker image
controldir=../controlfiles
attentiondir=../attention
framemapdir=../kinect_webcam
framesourcedir=/media/zzalsdme/SAMSUNG/IDInteraction/Kinect/depth
outdir=./depthResultstmp
docker run -it -v `pwd`/${outdir}:/idinteraction/results/ -v `pwd`/${framemapdir}:/idinteraction/framemap/:ro -v ${framesourcedir}:/idinteraction/framesource/:ro -v `pwd`/${controldir}:/idinteraction/control/:ro -v `pwd`/${attentiondir}:/idinteraction/attention/:ro  idinteraction/dockerdepth -j 4 all

#-v `pwd`/contrib:/tmp/contrib
