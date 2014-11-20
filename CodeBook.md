#CodeBook 

This file describes the data, the variables, and the work that has been performed to clean up the data.

##Data Source

For this project, I use data collected from the accelerometers from the Samsung Galaxy S smartphone and derived from the "Human Activity Recognition Using Smartphones Data Set" (originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Data Set Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###For each record it is provided:

    Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
    Triaxial Angular velocity from the gyroscope.
    A 561-feature vector with time and frequency domain variables.
    Its activity label.
    An identifier of the subject who carried out the experiment.

###The dataset includes the following files:

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

##Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    tBodyAcc-XYZ
    tGravityAcc-XYZ
    tBodyAccJerk-XYZ
    tBodyGyro-XYZ
    tBodyGyroJerk-XYZ
    tBodyAccMag
    tGravityAccMag
    tBodyAccJerkMag
    tBodyGyroMag
    tBodyGyroJerkMag
    fBodyAcc-XYZ
    fBodyAccJerk-XYZ
    fBodyGyro-XYZ
    fBodyAccMag
    fBodyAccJerkMag
    fBodyGyroMag
    fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

    mean(): Mean value
    std(): Standard deviation
    mad(): Median absolute deviation
    max(): Largest value in array
    min(): Smallest value in array
    sma(): Signal magnitude area
    energy(): Energy measure. Sum of the squares divided by the number of values. 
    iqr(): Interquartile range 
    entropy(): Signal entropy
    arCoeff(): Autorregresion coefficients with Burg order equal to 4
    correlation(): correlation coefficient between two signals
    maxInds(): index of the frequency component with largest magnitude
    meanFreq(): Weighted average of the frequency components to obtain a mean frequency
    skewness(): skewness of the frequency domain signal 
    kurtosis(): kurtosis of the frequency domain signal 
    bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
    angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

    gravityMean
    tBodyAccMean
    tBodyAccJerkMean
    tBodyGyroMean
    tBodyGyroJerkMean

Note: features are normalized and bounded within [-1,1].

##Transformations

###Load data from UCI

Load relevant R libraries:

    library(reshape2)

To download data from UCI website, I use the download function : 

    fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = "UCI HAR Dataset.zip")
    
The unzip function extracts the zipped files in an UCI HAR Dataset folder in your local working directory:

    unzip("UCI HAR Dataset.zip")
   
read.table function is used to load into R environment: data, activities, subjects of both test and training datasets, as well as the features and the activity_labels:

    features = read.table('./UCI HAR Dataset/features.txt',header=FALSE, colClasses="character")
    activities = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE,colClasses="character")
    testData = read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
    testData_act = read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE) 
    testData_sub = read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
    trainData = read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
    trainData_act = read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
    trainData_sub = read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

###Descriptive activity names to name the activities in the data set

The class labels linked with their activity names are loaded from the activity_labels.txt file. The numbers of the testData_act and trainData_act data frames are replaced by those names:

    testData_act$V1 = factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
    trainData_act$V1 = factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

###Appropriately labels the data set with descriptive activity names

Each data frame of the data set is labeled - using the features.txt - with the information about the variables used on the feature vector. The Activity and Subject columns are also named properly before merging them to the test and train dataset.

    colnames(testData) = features$V2
    colnames(trainData) = features$V2
    colnames(testData_act) = ("Activity")
    colnames(trainData_act) = ("Activity")
    colnames(testData_sub) = ("Subject")
    colnames(trainData_sub) = ("Subject")

###Extract only the measurements on the mean and standard deviation for each measurement

A list of mean() and std() variables is created via the grepl function in the extract_features list. It is used to extract the measurements on the mean and standard deviation for each measurement from the test and the train dataframes, via subsetting testData and trainData.

    extract_features <- (grepl("mean", features$V2) | grepl("std", features$V2)) & !grepl("-meanFreq..",features$V2)
    testData = testData[,extract_features] 
    trainData = trainData[,extract_features] 

###Merge test and training sets into one data set

With the cbind function, testData and trainData are respectively merged to their activities and their subjects.

    testData = cbind(testData_sub,testData_act,testData) 
    trainData = cbind(trainData_sub,trainData_act,trainData) 

testData table is then appended to the trainData dataframe with the rbind function to generate a Data dataframe, containing the means and the standard deviations of all the measurements of both the test and the train samples, together with their activities and sujbects.

    Data = rbind(testData,trainData) 

###Creates a second, independent tidy data set with the average of each variable for each activity and each subject

To get the average of each variable for each activity and subject I need to "reshape" the Data table. Using the melt function, I first melt the Data dataframe using "Subject" and "Activity" as ids - generating the melt_data table.

    id_labels = c("Subject", "Activity")
    data_labels = setdiff(colnames(Data), id_labels)
    melt_data = melt(Data, id = id_labels, measure.vars = data_labels)

Then the melted dataframe is casted using the dcast function, calculating the average of the variables for each activity and subject. Finally a tidy data table is created with the average of each measurement per activity/subject combination. 

    tidy_data = dcast(melt_data, Subject + Activity ~ variable, mean)

The new dataset is saved with the write.table function in a "tidy_data.txt" file that is stored in local working directory. 

    write.table(tidy_data, file = "./tidy_data.txt",row.names = FALSE)
