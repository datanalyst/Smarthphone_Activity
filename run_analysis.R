# This script will perform the following steps on the UCI HAR Dataset downloaded from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Load relevant R libraries:
library(reshape2)  # used for melt/dcast

# Download and unzip files:
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip")

# Read data from files:
features = read.table('./UCI HAR Dataset/features.txt',header=FALSE, colClasses="character")
activities = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE,colClasses="character")
testData = read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE) # 2947 obs. of 561 variables
testData_act = read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE) # 7352 obs. of 561 variables
testData_sub = read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainData = read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData_act = read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_sub = read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# 3. Uses descriptive activity names to name the activities in the data set:
testData_act$V1 = factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 = factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

# 4. Appropriately labels the data set with descriptive activity names:
colnames(testData) = features$V2
colnames(trainData) = features$V2
colnames(testData_act) = ("Activity")
colnames(trainData_act) = ("Activity")
colnames(testData_sub) = ("Subject")
colnames(trainData_sub) = ("Subject")

# 2. Extract only the measurements on the mean and standard deviation for each measurement:
extract_features <- (grepl("mean", features$V2) | grepl("std", features$V2)) & !grepl("-meanFreq..",features$V2)
testData = testData[,extract_features] # 2947 obs. of 66 variables
trainData = trainData[,extract_features] # 7352 obs. of 66 variables

# 1. Merge test and training sets into one data set, including the activities:
testData = cbind(testData_sub,testData_act,testData) #2947 obs. of  68 variables
trainData = cbind(trainData_sub,trainData_act,trainData) #7352 obs. of  68 variables
Data = rbind(testData,trainData) # 10299 obs. of 68 variables

## str(Data)
## 'data.frame':   10299 obs. of  68 variables:
## $ Subject                    : int  2 2 2 2 2 2 2 2 2 2 ...
## $ Activity                   : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
## $ tBodyAcc-mean()-X          : num  0.257 0.286 0.275 0.27 0.275 ...
## $ tBodyAcc-mean()-Y          : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
##
## head(Data, n=3)
##   Subject Activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
## 1       2 STANDING         0.2571778       -0.02328523       -0.01465376
## 2       2 STANDING         0.2860267       -0.01316336       -0.11908252
## 3       2 STANDING         0.2754848       -0.02605042       -0.11815167

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject:

# Melt the data using subject and activity as id:
id_labels = c("Subject", "Activity")
data_labels = setdiff(colnames(Data), id_labels)
melt_data = melt(Data, id = id_labels, measure.vars = data_labels)

# Cast the melted table, but calculating the mean of the "variable"
tidy_data = dcast(melt_data, Subject + Activity ~ variable, mean) #180 obs. of  68 variables
write.table(tidy_data, file = "./tidy_data.txt",row.names = FALSE) # this is the final output, as a txt file

## The final, tidy dataset has 180 observations and 68 variables; the
## numering variables are now the mean value for each one of them for
## each combination of subject + activity; all columns are named and
## all factors are explicitly labelled.
##
## str(tidy_data)
## 'data.frame':   180 obs. of  68 variables:
## $ Subject                    : int  1 1 1 1 1 1 2 2 2 2 ...
## $ Activity                   : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
## $ tBodyAcc-mean()-X          : num  0.277 0.255 0.289 0.261 0.279 ...
## $ tBodyAcc-mean()-Y          : num  -0.01738 -0.02395 -0.00992 -0.00131 -0.01614 ...
## [...]
##
## head(tidy_data, n= 3)
##  Subject           Activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y 
## 1       1            WALKING         0.2773308      -0.017383819        -0.1111481      -0.28374026      0.114461337    
## 2       1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020      -0.35470803     -0.002320265     
## 3       1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662       0.03003534     -0.031935943
