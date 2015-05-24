library(dplyr)

#READ ACTIVITY LABELS, EXTRACT LABELS
activity <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE, stringsAsFactors=FALSE,sep="\t")

activity <- as.vector(activity)
activity$V1 <- substr(activity$V1, 3, nchar(activity$V1))
names(activity) <- "activity"

#READ VARIABLE NAMES, AND EXTRACT NAMES
v1 <- read.table("UCI HAR Dataset/features.txt", header=FALSE,   stringsAsFactors=FALSE,sep="\t")
v2 <- strsplit(v1[,1], " ")
varname <- NULL
for (i in 1:length(v2)){varname[i] <- v2[[i]][2]}
#REMOVE TEMPORARY VARIABLES FROM MEMORY
rm("v1", "v2")

#IDENTIFY LISTS OF MEANS AND STANDARD DEVIATIONS
meanlist <- grep("mean", varname, ignore.case=TRUE) # MEANS INDEX
#varname[meanlist] PROVIDES LIST OF MEANS VARIABLE NAMES
sdlist <- grep("std", varname, ignore.case=TRUE) # STDEV INDEX
#varname[sdlist] PROVIDES LIST OF STDEV VARIABLE NAMES

#READ TEST SUBJECTS FILE,ADD "test" AS SUBJECT TYPE, AND NAME THE VARIABLES
subjects.test <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
subjects.test[, 2] <- "test"
names(subjects.test) <- c("subject_id", "subject_type")

#READ TRAIN SUBJECTS FILE,ADD "train" AS SUBJECT TYPE, AND NAME THE VARIABLES
subjects.train <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subjects.train[, 2] <- "train"
names(subjects.train) <- c("subject_id", "subject_type")

#READ MEASUREMENTS FILES, ADD LABELS
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
x.test <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
y.test <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
subjects.test[,3] <- activity[y.test[,1],1]
names(subjects.test)[3] <- "activity"

x.train <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
y.train <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
subjects.train[,3] <- activity[y.train[,1],1]
names(subjects.train)[3] <- "activity"

#EXTRACT LIST OF VARIABLES WITH MEAN AND STD DEVIATION FOR TEST AND TRAIN
means.test <- x.test[meanlist]
sd.test <- x.test[sdlist]
names(means.test)[1:length(meanlist)] <- varname[meanlist]
names(sd.test)[1:length(sdlist)] <- varname[sdlist]

means.train <- x.train[meanlist]
sd.train <- x.train[sdlist]
names(means.train)[1:length(meanlist)] <- varname[meanlist]
names(sd.train)[1:length(sdlist)] <- varname[sdlist]

#MERGE TEST AND TRAIN DATASETS AND FINALLY BOTH TEST AND TRAIN DATASETS
merge.test <- cbind(subjects.test, means.test, sd.test)
merge.train <- cbind(subjects.train, means.train, sd.train)
har <- rbind(merge.test, merge.train)

#CHANGE subject_id, subject_type, activity TO FACTOR TYPE
har[,3] <- as.character(har[,3])
names(har[, 1:3]) <- as.factor(names(har[,1:3]))

#CREATE DATASET WITH MEANS AND SD SUMMARIZED BY SUBJECT AND ACTIVITY
summary <- aggregate(.~subject_id+activity, data=har, mean)

#FOR UNKNOWN REASON, aggregate COERCED subject_type TO NUMERIC, REVERT!
summary$subject_type <- as.character(summary$subject_type)
for (i in 1:nrow(summary)){if (summary[i,3]=="1")summary[i,3] <- "test"}
for (i in 1:nrow(summary)){if (summary[i,3]=="2")summary[i,3] <-"train"}

#WRITE summary TO summary.txt
write.table(summary, "summary.txt", row.names=FALSE)



