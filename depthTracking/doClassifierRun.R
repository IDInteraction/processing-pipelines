library(tidyverse)


getFrame <- function(participantCode, experimentpart, event, method = "extractAttention", extfile = NULL){
  
  # Get the frame number that an experiemnt part start/ends at
  part <- stringr::str_match(experimentpart, "\\d+")
  if (is.na(part)) {
    stop("Experiment part could not be extracted")
  }
  
  eventstring <- paste0(event, part)
  if (method == "extractAttention") {
    outputname <- tempfile()
    
    sysargs <- c(paste0("--attentionfile=", "../../DIS2017/Attention/", participantCode, "_attention.txt"),
                 paste0("--outputfile=", outputname),
                 paste0("--participant=", participantCode),
                 paste0("--event=", eventstring),
                 paste0("--externaleventfile=../../DIS2017/Attention/transitionAnnotations.csv")
    )
    system2("../../abc-display-tool/abc-extractAttention.py",
            args = sysargs,
            stdout = NULL
    )
    
    results <- read.csv(outputname)
    
    if (nrow(results) != 1) {
      stop("Error reading results frame")
    }
    
    outframe <- results[1, "frame"]
    
    unlink(outputname)
  }
  else if (method == "eventlist")
  {
    if (is.null(extfile)) {
      stop("Must specify and external file containing events and frames")
    }
    
    if (any(class(participantCode) == "data.frame")) {
      # Check we've only 1 row and if so extract code
      if (nrow(participantCode) != 1) {
        stop("Invalid participantcode data - check table only has 1 row")
      }
      participantCode <- participantCode$participantCode
    }
    
    eventdata <- read.delim(extfile, header = FALSE, 
                            col.names = c("participantCode",
                                          "event",
                                          "frame"),
                            sep = " ",
                            stringsAsFactors = FALSE)
    
    
    theevent <- eventdata[eventdata$event == eventstring & 
                            eventdata$participantCode == participantCode, ]
    
    if (nrow(theevent) != 1) {
      stop("Could not extract event")
    }
    
    outframe <- theevent$frame
  }
  
  
  
  return(outframe)
}

getDepthName <- function(participantCode, experimentpart, depthLoc, forceWebcam = FALSE){
  # Get a filename for a depth-output file
  # We do this programatically, since we include the depths we've filtered to in the
  # filename
  
  if (forceWebcam == TRUE) { 
    possiblefiles <- list.files(path = depthLoc, pattern = "*_webcam.csv")
  } else{
    possiblefiles <- list.files(path = depthLoc, pattern = "*.csv")
  }
  exptpart <- stringr::str_match(experimentpart, "^\\w+(\\d)$")[,2]
  
  regex <- paste0("^",
                  participantCode,
                  "_",
                  "\\w+",
                  exptpart,
                  "_.+\\.csv$")
  
  filematch <- stringr::str_match(possiblefiles, regex)
  filename <- filematch[!is.na(filematch),]
  if (length(filename) != 1) {
    stop("Could not extract filename")
  }
  return(filename)
}


fps <- 30

participantCode <- paste0("P",sprintf("%02d", 1:18))[1:2]
numparticipants <- length(participantCode)

seqtimes <- c(15,30,60)
randframes <- c(30, 60, 120, 240, 450)
experimentpart <- c("part1", "part2")

tracker <- c("cppMT", "depthPCA", "openface")
trackercombinations <- NULL
for (i in 1:length(tracker)) {
  trackercombinations <- c(trackercombinations,
                           apply(combn(tracker, i), 2, paste, collapse = ","))
}


groundTruthPath <- "../../DIS2017/Groundtruth/"
trackerPath <- "../../DIS2017/Tracking/"
PCAPath <- "PCA/"
classifier <- "../../abc-display-tool/abc-classify.py"
seqframes <- seqtimes * fps

configurations <- tidyr::crossing(participantCode, experimentpart, tracker = trackercombinations,
                                  dplyr::bind_rows(tidyr::crossing(config = "shuffle", frames = randframes),
                                                   tidyr::crossing(config = "noshuffle", frames = seqframes))
)

genTrackerString <- function(tracker, participantCode, experimentpart, trackerlist = NULL){
  # Generate a tracker string file.
  # I.e. given a tracker, e.g. depthPCA, participantCode and experiemnt part generate the 
  # required command line argument for abc-classify
  
  if (stringr::str_count(tracker, ",") > 0 ) {
    # Call function recursively 
    trackersplit <- stringr::str_split(tracker, ",", simplify = TRUE)
    for (trackstring in trackersplit) {
      trackerlist <- append(trackerlist,
                            genTrackerString(trackstring, participantCode, experimentpart, trackerlist))
    }
  }
  if (tracker == "openface") {
    trackerpfn <- paste0(trackerPath, participantCode, "_front.openface.gz")
  } else if (tracker == "cppMT") {
    trackerpfn <- paste0(trackerPath, participantCode, "_",
                         paste0(experimentpart, "_front_cppMT.csv.gz"))
  } else if (tracker == "depthPCA") {
    trackerpfn <- paste0(PCAPath, getDepthName(participantCode,
                                               experimentpart,
                                               PCAPath, forceWebcam = TRUE)) 
  } else { 
    return(trackerlist)
  }
 
  return((trackerpfn))
  
}


logConn <- file("Runlog.txt", open = "at")
resultsframe <- NULL
for (i in 1:nrow(configurations)) {
  # Generating the results can take a long while, but anything we print will end up in the paper
  # So dump the current config to a file to allow progress to be monitored
  write(paste(configurations[i,], collapse = ":"), file = "Runlog.txt", append = TRUE)
  runoutput <- tempfile()
  
  trackerpfn <- genTrackerString(configurations[i,"tracker"],
                                 configurations[i,"participantCode"],
                                 configurations[i,"experimentpart"])
  
  groundtruthpfn <- paste0(groundTruthPath,
                           configurations[i, "participantCode"], "_groundtruth.csv")
  
  # Use abc-extractAttention to get start/end frame of each experiement
  # These are *webcam* frames, since we have converted the PCA tracking data to webcam reference
  startframe <- getFrame(configurations[i,"participantCode"], configurations[i,"experimentpart"], 
                         "start")
  endframe <- getFrame(configurations[i,"participantCode"], configurations[i,"experimentpart"], "end")
  # Replace , in participant code string when we have >1 data source to 
  # prevent problems with delimters in output file
  codestring <- stringr::str_replace_all(paste0(configurations[i,], collapse = ":"), ",", "x")
  runargs <- c(paste0("--trackerfile=",  trackerpfn),
               paste0("--startframe=", startframe),
               paste0("--endframe=", endframe),
               paste0("--extgt=", groundtruthpfn),
               "--useexternalgt",
               paste0("--participantcode=", codestring),
               paste0("--", configurations[i, "config"]),
               paste0("--summaryfile=", runoutput),
               paste0("--externaltrainingframes=", configurations[i,"frames"]),
               paste0("--rngstate=RNGstate"),
               paste0("--maxmissing=15")
  )
  
  
   system2(classifier,
           args = runargs,
           stdout = NULL
   )

   results <- read.csv(runoutput, header = FALSE,
                       col.names = c("configuration",
                                     "trainedframes",
                                     "startframe",
                                     "endframe",
                                     "crossvalAccuracy",
                                     "crossvalAccuracySD",
                                     "crossvalAccuracyLB",
                                     "crossvalAccuracyUB",
                                     "groundtruthAccuracy"
                       ))
  if (nrow(results) > 1) {
    stop(paste("Something went wrong for ", configurations[i,]))
  }
  resultsframe <- rbind(resultsframe,
                        data.frame(c(configurations[i,],  results)))
  unlink(runoutput)
}


resultsframe <- as_tibble(resultsframe)
write.csv(resultsframe, file = paste0("results", Sys.Date(), ".csv"))
resultsmean <- resultsframe %>% group_by(config, frames, tracker, experimentpart) %>%
  summarise(avgxval = mean(crossvalAccuracy),
            avggt = mean(groundtruthAccuracy),
            datapts = length(groundtruthAccuracy))
if (all(resultsmean$datapts > numparticipants)) {
  warning("Multiple experimental configs being grouped")
}
if (all(resultsmean$datapts < numparticipants)) {
  warning("Incomplete run - don't have results for all participants")
}
resultsmean$avgxval <- ifelse(resultsmean$config == "shuffle", resultsmean$avgxval, NA)
# recode levels to nicer names
conflevs <- levels(resultsmean$config)
conflevs <- ifelse(conflevs == "shuffle", "randomised", conflevs)

conflevs <- ifelse(conflevs == "noshuffle", "sequential", conflevs)
levels(resultsmean$config) <- conflevs

resultsmean <- resultsmean %>% rename(training = config)
accuracyfigure <- ggplot(data = resultsmean, aes(x = frames, y = avggt, colour = training)) + geom_line() + geom_line(aes(y = avgxval), linetype = 2) +   facet_wrap( experimentpart ~ tracker) + xlab("training frames") +
  ylab("mean accuracy") + theme(legend.position = "bottom")
# We save the figure here - it gets pulled into the document later
#ggsave("figures/accuracy.pdf", plot = accuracyfigure, device = "pdf", width = 10, height = 26, units = "cm")
print(accuracyfigure)
