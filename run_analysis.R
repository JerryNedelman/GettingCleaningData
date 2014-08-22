
library(plyr)
setwd("c:/Homework/CleaningData/Data")

#*********************************************
# From features.txt, identify variables, i.e., columns of training and test data sets 
# that contain means and standard deviations.
#*********************************************

## Read in data set containing "features", i.e., identifiers of columns in the data set.
features <- readLines("features.txt")

## Which of those feature identifiers contain the word "mean"?
means <- grep("mean",features)

#*********************************************
# A feature identifier consists of a number, corresponding to the column number
# in the data set, and a name of the feature. 
# Split the number from the name, and eliminate "()" from the name.
#*********************************************

dfmeans <- ldply(strsplit(features[means]," "))
dfmeans[,1] <- as.numeric(dfmeans[,1])

## Now do all of the same things for standard deviations.
stds  <- grep("std", features)
dfstds <- ldply(strsplit(features[stds]," "))
dfstds[,1] <- as.numeric(dfstds[,1])

## Put the means and standard deviations together. Sort by column number.
dfms0 <- rbind(dfmeans,dfstds)
dfms1 <- dfms0[order(dfms0$V1),]

## The feature names all contain "()", which is not pretty. Get rid of it.
dfms2 <- within(dfms1, V2 <- sub("()","",V2,fixed=TRUE))

#***********************************************
# Read in training and test data
# Retain only columns with means and standard deviations.
# Assign feature names as column names.
#***********************************************

testdata <- read.table("test/X_test.txt")
testdata <- testdata[,dfms2$V1]
names(testdata) <- dfms2$V2

traindata <- read.table("train/X_train.txt")
traindata <- traindata[,dfms2$V1]
names(traindata) <- dfms2$V2

#***********************************************
# Each row of the training and test data sets corresponds to
# an activity for a subject.
# Read in the subject identifiers from 
# test/subject_test.txt and train/subject_train.txt,
# and cbind with data sets.
#***********************************************
testsubj <- read.table("test/subject_test.txt")
names(testsubj) <- "Subject"
testdata <- cbind(testsubj, testdata)

trainsubj <- read.table("train/subject_train.txt")
names(trainsubj) <- "Subject"
traindata <- cbind(trainsubj, traindata)

#*************************************************
# Read in activity names from activity_labels.txt. 
# These are of the form "1 WALKING".
# Get rid of the digit.
#************************************************
ActNames <- readLines("activity_labels.txt")
dfActNames <- ldply(strsplit(ActNames," "))
ActNames <- dfActNames[,2]

#************************************************
# Now read in activity labels, which are numeric 1, 2, ..., 6.
# Convert the labels to the names, then cbind with the data sets.
#*************************************************

testActLabels <- as.numeric(readLines("test/y_test.txt"))
testActNames <- data.frame(ActNames[testActLabels])
names(testActNames) <- "Activity"
testdata <- cbind(testActNames,testdata)

trainActLabels <- as.numeric(readLines("train/y_train.txt"))
trainActNames <- data.frame(ActNames[trainActLabels])
names(trainActNames) <- "Activity"
traindata <- cbind(trainActNames,traindata)

#************************************************
# Combine test and training data.
# Compute output data set of averages by Activity and Subject.
# Output.
#************************************************

alldata <- rbind(traindata,testdata)

mymean <- function(df) apply(df[,-(1:2)],2,mean)
averages <- ddply(.data=alldata, .variables=.(Activity,Subject), .fun=mymean)

write.table(averages, file="../Analysis/averages.txt", row.names=FALSE, quote=FALSE)

#************************************************
# List variable names in output data set for documentation purposes.
#************************************************
names(averages)

