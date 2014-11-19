#CodeBook 

This file describes the data, the variables, and the work that has been performed to clean up the data.

##Data Source

For this project, I used data collected from the accelerometers from the Samsung Galaxy S smartphone and derived from the "Human Activity Recognition Using Smartphones Data Set" (originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Human Activity Recognition Using Smartphones Data Set Information

I refer you to the README and features.txt files in the original dataset to learn more about the experiment and the feature selection for this dataset. 

For the purpose of this project I use the following files from UCI dataset:

    1. 'features_info.txt': Shows information about the variables used on the feature vector.
    2. 'features.txt': List of all features.
    3. 'activity_labels.txt': Links the class labels with their activity name.
    4. 'train/X_train.txt': Training set.
    5. 'train/y_train.txt': Training labels.
    6. 'test/X_test.txt': Test set.
    7. 'test/y_test.txt': Test labels.
    8. 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

All the variables within files from 3. to 8. are used. From features.txt file I select the mean() and the std () for the following signals:

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

Note: features are normalized and bounded within [-1,1].

##Tidy_data Dataset Information

To generate the tidy_data dataset, the "run_analysis.R" script needs to be run. It performs the following steps on the UCI HAR Dataset:

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
5. Using the colnames function - it labels testData and trainData dataframes, using the features.txt, with the information about the variables used on the feature vector. The Activity and Subject columns are also named properly.
6. With the grepl function, it creates a list of mean and std variables (extract_features) that it uses to extract from the test and the train dataframes only the measurements on the mean and standard deviation for each measurement, via subsetting testData and trainData.
7. With the cbind function, testData and trainData are respectively merged to their activities and their subjects.
8. testData table is then appended to the trainData dataframe with the rbind function in order to generate a unique dataframe, called Data, containing the means and the standard deviations of all the measurements of both the test and the train samples, together with their activities and their sujbects.
9. In order to create a second, independent tidy data set with the average of each variable for each activity and each subject I need to "reshape" the Data table. Using the melt function, I first melt the Data dataframe using "Subject" and "Activity" as id - generating the melt_data table. Then using the dcast function, I cast the melted dataframe, calculating the average of the variables for each activity and subject.
10. Finaly I get a tidy_data table, with 180 obs. of 68 variables. The new dataset is saved with the write.table function in "tidy_data.txt" file in local working directory. 
