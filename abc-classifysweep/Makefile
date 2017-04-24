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

# jobfiledir contains the job files
jobfiledir=/idinteraction/jobs
# outputdir contains the outputs of the jobs
outputdir=/idinteraction/output
# results dir contains the (mainly tracking) data used 
# by the classifier. The list of participant codes to process is also stored
# here.  This is mounted ro in the Docker image
resultsdir=/idinteraction/results

jobfiles=$(wildcard $(jobfiledir)/*.job)
outputfiles=$(patsubst $(jobfiledir)/%.job, $(outputdir)/%.jobstat, $(jobfiles))

all: jobs

cleanresults: 
	$(foreach job,$(outputfiles), rm -rf $(shell head -1 $(job)) && ) :
	rm  $(outputfiles)
	rm $(outputdir)/*.sh
	

jobs: $(outputfiles)

$(outputdir)/%.jobstat: $(jobfiledir)/%.job
	# TODO check script has precisely 2 lines 
	/idinteraction/jobrunner/jobrunner.py '$(shell cat $< | head -2 | tail -1)' --extvarfile  p:$(resultsdir)/participantcodes.txt > $(basename $@).sh && bash $(basename $@).sh  && echo $(shell head -1 $<) > $@ 





