# Makefile to run job files through jobrunner
#
# David Mawdsley 2017
#
# A .job file takes the following format
#
# workingpath
# jobrunnerline
#
# workingpath is the path the job is to be run under. This will be created if
# it does not already exist.
# jobrunnerline is the commandline to pass to jobrunner.py; see its readme
# for full details.  Briefly a.out -o {1,2,3} -p {a,b} will generate command
# lines for all 6 combinations of options. 
#

.PHONY: all cleanresults jobs

jobfiledir=/idinteraction/jobs
outputdir=/idinteraction/output

jobfiles=$(wildcard $(jobfiledir)/*.job)
outputfiles=$(patsubst $(jobfiledir)/%.job, $(outputdir)/%.jobstat, $(jobfiles))

all: jobs

cleanresults: $(outputfiles)
	$(foreach job,$^, rm -rf $(shell head -1 $(job)) && ) :
	rm -f $^

jobs: $(outputfiles)

$(outputdir)/%.jobstat: $(jobfiledir)/%.job
	# TODO check script has precisely 2 lines
	mkdir -p $(shell head -1 $<) && cd $(shell head -1 $<) && /idinteraction/jobrunner/jobrunner.py '$(shell cat $< | head -2 | tail -1)' |tee jobscript.txt | /bin/bash 
	echo $(shell head -1 $<) > $@





