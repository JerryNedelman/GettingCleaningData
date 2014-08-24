Codebook for averages.txt
========================================================

Introduction
----------------------
averages.txt is the output of the course project for the Coursera course Getting and Cleaning Data. 

As explained in the project assignment: 
"One of the most exciting areas in all of data science right now is wearable computing - see for example 
[this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the 
most advanced algorithms to attract new users." 

The source data for the creation of averages.txt represents data collected from accelerometers in Samsung Galaxy S smartphones. A full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Here is a brief description of the source data from the README file at the above website:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, 
LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and 
gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 
50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been 
randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training 
data and 30% the test data." 

More details provided in the section "Variables in average.txt", below.

The training and test data sets are 7352x561 and 2947x561, respectively. Each row corresponds to a 
set of signal-processed variables for a particular subject performing a particular activity. There are
561 such signal-processed variables, which comprise the columns. The subjects and activities associated
with the rows are contained in separate data sets; see Inputs, below.

The project assignment was as follows:  
"The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on 
a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set 
as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) 
a code book that describes the variables, the data, and any transformations or work that you performed to 
clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
This readme file explains how all of the scripts work and how they are connected.

"You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject."

Inputs
-----------------------------------
[This zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) was downloaded per instructions from the course website.
It was unzipped and found to contain several files, among which the following were used:

* train/X_train.txt:  Training data set. 7352x561.
* test/X_test.txt: Test data set. 2947x561.
* 
* features.txt: Identifiers of the 561 variables (columns) in the training and test data sets. 561x1.
* 
* train/y_train.txt: Activity codes (1, 2, ..., 6) for rows of the training data. 7352x1.
* test/y_test.txt: Activity codes (1, 2, ..., 6) for rows of the test data. 2947x1.
* activity_labels.txt: Activity names (WALKING, ...) corresponding to the activity codes. 6x1.
* 
* train/subject_train.txt: Subject numbers corresponding to rows in the training data. 7352x1.
* test/subject_test.txt: Subject numbers corresponding to rows in the test data. 2947x1

Program flow, including transformations of the data.
-------------------------------------
1. From features.txt, identify variables, i.e., columns of training and test data sets, 
that contain means and standard deviations.

2. A feature identifier consists of a number, corresponding to the column number
in the data set, and a name of the feature. 
Split the number from the name, and eliminate "()" from the name.

3. Read in training and test data.
Retain only columns with means and standard deviations.
Assign feature names as column names.

4. Each row of the training and test data sets corresponds to an activity for a subject.
Read in the subject identifiers from  test/subject_test.txt and train/subject_train.txt,
and cbind with data sets.

5. Read in activity names from activity_labels.txt. These are of the form "1 WALKING".
Get rid of the digit.

6. Now read in activity labels, which are numeric 1, 2, ..., 6.
Convert the labels to the names, then cbind with the data sets.

7. Combine test and training data. Compute output data set of averages by Activity and Subject.
Output.

Variables in averages.txt
--------------------------------
The variable names (i.e., column names) in averages.txt are given below.

"Activity" gives the name of the activity -i.e., one of: 
  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
  
"Subject" gives the subject number -i.e., one of 1, 2, ,..., 30.

The remaining 79 are names of the signal-processed variables used. This explanation of what they are
comes from the file "features_info.txt" at the source website:

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

"Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

"Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

"These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."

Per instructions in the assignment, only variables containing means and standard deviations of signals
were retained.

For each Activity, Subject, and variable, the value in the data set is the mean of the observations
of the variable for the Activity and Subject.

 [1] "Activity"                      "Subject"                       "tBodyAcc-mean-X"              
 [4] "tBodyAcc-mean-Y"               "tBodyAcc-mean-Z"               "tBodyAcc-std-X"               
 [7] "tBodyAcc-std-Y"                "tBodyAcc-std-Z"                "tGravityAcc-mean-X"           
[10] "tGravityAcc-mean-Y"            "tGravityAcc-mean-Z"            "tGravityAcc-std-X"            
[13] "tGravityAcc-std-Y"             "tGravityAcc-std-Z"             "tBodyAccJerk-mean-X"          
[16] "tBodyAccJerk-mean-Y"           "tBodyAccJerk-mean-Z"           "tBodyAccJerk-std-X"           
[19] "tBodyAccJerk-std-Y"            "tBodyAccJerk-std-Z"            "tBodyGyro-mean-X"             
[22] "tBodyGyro-mean-Y"              "tBodyGyro-mean-Z"              "tBodyGyro-std-X"              
[25] "tBodyGyro-std-Y"               "tBodyGyro-std-Z"               "tBodyGyroJerk-mean-X"         
[28] "tBodyGyroJerk-mean-Y"          "tBodyGyroJerk-mean-Z"          "tBodyGyroJerk-std-X"          
[31] "tBodyGyroJerk-std-Y"           "tBodyGyroJerk-std-Z"           "tBodyAccMag-mean"             
[34] "tBodyAccMag-std"               "tGravityAccMag-mean"           "tGravityAccMag-std"           
[37] "tBodyAccJerkMag-mean"          "tBodyAccJerkMag-std"           "tBodyGyroMag-mean"            
[40] "tBodyGyroMag-std"              "tBodyGyroJerkMag-mean"         "tBodyGyroJerkMag-std"         
[43] "fBodyAcc-mean-X"               "fBodyAcc-mean-Y"               "fBodyAcc-mean-Z"              
[46] "fBodyAcc-std-X"                "fBodyAcc-std-Y"                "fBodyAcc-std-Z"               
[49] "fBodyAcc-meanFreq-X"           "fBodyAcc-meanFreq-Y"           "fBodyAcc-meanFreq-Z"          
[52] "fBodyAccJerk-mean-X"           "fBodyAccJerk-mean-Y"           "fBodyAccJerk-mean-Z"          
[55] "fBodyAccJerk-std-X"            "fBodyAccJerk-std-Y"            "fBodyAccJerk-std-Z"           
[58] "fBodyAccJerk-meanFreq-X"       "fBodyAccJerk-meanFreq-Y"       "fBodyAccJerk-meanFreq-Z"      
[61] "fBodyGyro-mean-X"              "fBodyGyro-mean-Y"              "fBodyGyro-mean-Z"             
[64] "fBodyGyro-std-X"               "fBodyGyro-std-Y"               "fBodyGyro-std-Z"              
[67] "fBodyGyro-meanFreq-X"          "fBodyGyro-meanFreq-Y"          "fBodyGyro-meanFreq-Z"         
[70] "fBodyAccMag-mean"              "fBodyAccMag-std"               "fBodyAccMag-meanFreq"         
[73] "fBodyBodyAccJerkMag-mean"      "fBodyBodyAccJerkMag-std"       "fBodyBodyAccJerkMag-meanFreq"   
[76] "fBodyBodyGyroMag-mean"         "fBodyBodyGyroMag-std"          "fBodyBodyGyroMag-meanFreq"    
[79] "fBodyBodyGyroJerkMag-mean"     "fBodyBodyGyroJerkMag-std"      "fBodyBodyGyroJerkMag-meanFreq"


