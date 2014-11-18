##Course Project

This repository is hosting the R code for the assignment of the DataScience track's "Getting and Cleaning Data" course which will be peer assessed. 
The purpose of this project is to create one R script called run_analysis.R that performs data cleaning on "Human Activity Recognition Using Smartphones" data from UCI ( http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

##Files

1. The "CodeBook.md" file. It describes the variables, the data, and the work that has been performed to clean up the data.
  
2. The "run_analysis.R" file. It contains the R code that does the following:
  - Merges the training and the test sets to create one data set.
  - Extracts only the measurements on the mean and standard deviation for each measurement.
  - Uses descriptive activity names to name the activities in the data set
  - Appropriately labels the data set with descriptive activity names.
  - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Execution

Download the "run_analysis.R" file in your working directory and load it with R/R Studio. 
It will automatically download the dataset "Human Activity Recognition Using Smartphones" from UCI, it will unzip data in the UCI HAR Dataset folder in your working directory and finally it will generate a new file "tiny_data.txt" in your working directory.
