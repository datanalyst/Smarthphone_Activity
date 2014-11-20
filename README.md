##Course Project

This repository is hosting the R code for the assignment of the Coursera DataScience track's "Getting and Cleaning Data" course. 

The purpose of this project is to create an R script called run_analysis.R that collects and performs data cleaning on "Human Activity Recognition Using Smartphones" data from UCI and generates a tidy dataset.

##Scripts

1. The "CodeBook.md" file describes the variables, the data, and the work that has been performed to clean up the data. 

2. The "run_analysis.R" is the script that has been used for this work.

##Execution

Download the "run_analysis.R" file in your working directory, run it with R/R Studio and execute it without any parameters. 

It does the following: 
  - downloads the dataset "Human Activity Recognition Using Smartphones" from UCI
  - unzips data in the UCI HAR Dataset folder in your working directory 
  - performs data cleaning on UCI data
  - generates a "tidy_data.txt" in your working directory.

The result of the execution is the tidy_data.txt file that stores the data (mean and standard deviation of each measurement per activity&subject) for later analysis.
