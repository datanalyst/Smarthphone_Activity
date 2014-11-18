#Smartphones_Activity

##Course Project

This repository is hosting the R code for the assignment of the DataScience track's "Getting and Cleaning Data" course which will be peer assessed. The purpose of this project is to create one R script called run_analysis.R that does the following:

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive activity names.
  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Scripts and execution

In this repository you will find:

  1. The "run_analysis.R" script - Run it with R/R Studio and it will automatically:
     - download the dataset "Human Activity Recognition Using Smartphones" from UCI and unzip it in the UCI HAR Dataset folder in your working directory. 
     - generate a new file tiny_data.txt in your working directory.
  2. The "CodeBook.md" file - it describes the variables, the data, and the work that has been performed to clean up the data.
  3. The "tidy.csv" file - it is created as a result of the execution.
