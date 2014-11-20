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

    - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
    - Triaxial Angular velocity from the gyroscope.
    - A 561-feature vector with time and frequency domain variables.
    - Its activity label.
    - An identifier of the subject who carried out the experiment.

###The dataset includes the following files:

    - 'features_info.txt': Shows information about the variables used on the feature vector.
    - 'features.txt': List of all features.
    - 'activity_labels.txt': Links the class labels with their activity name.
    - 'train/X_train.txt': Training set.
    - 'train/y_train.txt': Training labels.
    - 'test/X_test.txt': Test set.
    - 'test/y_test.txt': Test labels.
    - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
    - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
    - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

##Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

   -  tBodyAcc-XYZ
   -  tGravityAcc-XYZ
   -  tBodyAccJerk-XYZ
   -  tBodyGyro-XYZ
   -  tBodyGyroJerk-XYZ
   -  tBodyAccMag
   -  tGravityAccMag
   -  tBodyAccJerkMag
   -  tBodyGyroMag
   -  tBodyGyroJerkMag
   -  fBodyAcc-XYZ
   -  fBodyAccJerk-XYZ
   -  fBodyGyro-XYZ
   -  fBodyAccMag
   -  fBodyAccJerkMag
   -  fBodyGyroMag
   -  fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

Note: features are normalized and bounded within [-1,1].

##Transformations

###Load test and training sets and the activities

The data set has been stored in the UCI HAR Dataset/ directory.

1. Load relevant R libraries: library(reshape2)
2. Download UCI data (with the download function) from the URL and extracts the zipped files in a UCI HAR Dataset folder in your local working directory (with the unzip function)
3. With the read.table function, it loads from UCI HAR Dataset folder into R environment:
   - the features.txt file into the dataframe "features"
   - the activity_labels.txt file into the dataframe "activities"
   - the subject_test.txt file into the dataframes "testData_sub"
   - the y_test.txt file into the dataframe "testData_act"
   - the X_test.txt file into the dataframe "testData"
   - the subject_train.txt file into the dataframes "trainData_sub"
   - the y_train.txt file into the dataframe "trainData_act"
   - the X_train.txt file into the dataframe "trainData"

###Descriptive activity names to name the activities in the data set

Replaces the activity class names in the testData_act and trainData_act dataframes with their label names.

###Appropriately labels the data set with descriptive activity names

Using the colnames function - it labels testData and trainData dataframes, using the features.txt, with the information about the variables used on the feature vector. The Activity and Subject columns are also named properly.

###Extract only the measurements on the mean and standard deviation for each measurement

With the grepl function, it creates a list of mean and std variables (extract_features) that it uses to extract from the test and the train dataframes only the measurements on the mean and standard deviation for each measurement, via subsetting testData and trainData.

###Merge test and training sets into one data set, including the activities

With the cbind function, testData and trainData are respectively merged to their activities and their subjects.
testData table is then appended to the trainData dataframe with the rbind function in order to generate a unique dataframe, called Data, containing the means and the standard deviations of all the measurements of both the test and the train samples, together with their activities and their sujbects.

###Creates a second, independent tidy data set with the average of each variable for each activity and each subject

In order to create a second, independent tidy data set with the average of each variable for each activity and each subject I need to "reshape" the Data table. Using the melt function, I first melt the Data dataframe using "Subject" and "Activity" as id - generating the melt_data table. Then using the dcast function, I cast the melted dataframe, calculating the average of the variables for each activity and subject.

Finaly I get a tidy_data table, with 180 obs. of 68 variables. The new dataset is saved with the write.table function in "tidy_data.txt" file in local working directory. 
