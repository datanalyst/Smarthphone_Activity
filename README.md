##Course Project

This repository is hosting the R code for the assignment of the Coursera DataScience track's "Getting and Cleaning Data" course. 

The purpose of this project is to create one R script called run_analysis.R that performs some data cleaning on "Human Activity Recognition Using Smartphones" data from UCI ( http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and generates the "tidy_data.txt" file.

In particular, the aim of the project is to write a "run_analysis.R" script that does the following:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Files

1. The "CodeBook.md" file describes the variables, the data, and the work that has been performed to clean up the data.
  
2. The "run_analysis.R" file contains the R code that does the following:
  - downloads the dataset "Human Activity Recognition Using Smartphones" from UCI
  - unzips data in the UCI HAR Dataset folder in your working directory 
  - performs data cleaning on UCI data
  - generates a tidy data - called "tidy_data.txt" - in your working directory.
  
##Execution

Download the "run_analysis.R" file in your working directory and load it with R/R Studio. 
