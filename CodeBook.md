#Introduction

This file describes the data, the variables, and the work that has been performed to clean up the data.

#Data Source

 - Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 - Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
For each record it is provided:

    Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
    Triaxial Angular velocity from the gyroscope.
    A 561-feature vector with time and frequency domain variables.
    Its activity label.
    An identifier of the subject who carried out the experiment.

The dataset includes the following files:

    'features_info.txt': Shows information about the variables used on the feature vector.
    'features.txt': List of all features.
    'activity_labels.txt': Links the class labels with their activity name.
    'train/X_train.txt': Training set.
    'train/y_train.txt': Training labels.
    'test/X_test.txt': Test set.
    'test/y_test.txt': Test labels.
    'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
    'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
    'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

#Transformation

The unzip function is used to extract the zip file in this directory.

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip")

read.table is used to load the data to R environment for the data, the activities and the subject of both test and training datasets. The class labels linked with their activity names are loaded from the activity_labels.txt file.

features = read.table('./UCI HAR Dataset/features.txt',header=FALSE, colClasses="character")
activities = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE,colClasses="character")
testData = read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE) # 2947 obs. of 561 variables
testData_act = read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE) # 7352 obs. of 561 variables
testData_sub = read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainData = read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData_act = read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_sub = read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

Descriptive activity names to name the activities in the data set

The numbers of the testData_act and trainData_act data frames are replaced by those names:

testData_act$V1 = factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 = factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

Appropriately labels the data set with descriptive activity names

Each data frame of the data set is labeled - using the features.txt - with the information about the variables used on the feature vector. The Activity and Subject columns are also named properly before merging them to the test and train dataset.

colnames(testData) = features$V2
colnames(trainData) = features$V2
colnames(testData_act) = ("Activity")
colnames(trainData_act) = ("Activity")
colnames(testData_sub) = ("Subject")
colnames(trainData_sub) = ("Subject")

Extract only the measurements on the mean and standard deviation for each measurement, via subsetting testData and trainData using the list of mean and std variables.

extract_features <- grepl("mean()|std()", features$V2)
testData = testData[,extract_features] 
trainData = trainData[,extract_features] 

Merge test and training sets into one data set, including the activities

The Activity and Subject columns are appended to the test and train data frames, and then are both merged in the Data data frame.

testData = cbind(testData_sub,testData_act,testData)
trainData = cbind(trainData_sub,trainData_act,trainData)
Data = rbind(testData,trainData) 

Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finaly we get a tidy data table, that is created with the average of each measurement per activity/subject combination. The new dataset is saved in tidy.csv file.

DT = data.table(Data)
tidy = DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy,file="tidy.csv",sep=",",row.names = FALSE)
