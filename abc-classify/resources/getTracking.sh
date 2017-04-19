#!/bin/bash

# Get the tracking data name for a given participant

# This script attempts to work out the tracking data to use for a participant.
# It avoids the need to have a separate Docker image for Openface and CppMT
# tracking data.

# Assumes the filename is rootname.csv or rootname.openface
# where rootname will typically be Pxx_camera (what the % expands to in
# Makefile)


filelist=`ls ${1}/${2}*.csv ${1}/${2}*.openface 2>/dev/null`

files=`echo $filelist | grep -o ' ' | wc -l`
if [ ${files} -ge 1 ] 
then
	(>&2 echo "Multiple tracking file found")
else
	echo $filelist
fi


