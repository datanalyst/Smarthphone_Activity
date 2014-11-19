##Introduction

The aim of the project is to write a "run_analysis.R" script that does the following:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
This file describes the data, the variables, and the work that has been performed to clean up the data.

##Data Source

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Data Set Information

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
    
##Transformation

The "run_analysis.R" script performs the following steps on the UCI HAR Dataset:

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
4. Replaces the activity class names in the testData_act and trainData_act dataframes by their label names.
5. Using the colnames function - testData and trainData dataframes are labeled, using the features.txt, with the information about the variables used on the feature vector. The Activity and Subject columns are also named properly.
6. With the grepl function, it creates a list of mean and std variables (extract_features) that it uses to extract from the test and the train dataframes only the measurements on the mean and standard deviation for each measurement, via subsetting testData and trainData.
7. With the cbind function testData and trainData are respectively merged to their activities and their subjects.
8. The testData is then appended to the trainData dataframe with the rbind function in order to generate a unique dataframe, called Data, containing the means and the standard deviations of all the measurements of both the test and the train samples, together with their activities and their sujbects.
9. In order to create a second, independent tidy data set with the average of each variable for each activity and each subject we need to "reshape" the Data table. Using the melt function, we first melt the Data dataframe using "Subject" and "Activity" as id - generating the melt_data table. Then using the dcast function, we cast the melted dataframe, calculating the average of the variables for each activity and subject.
10. Finaly we get a tidy_data table, with 180 obs. of 68 variables. The new dataset is saved with the write.table function in "tidy_data.txt" file in your local working directory.



