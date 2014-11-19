# This script will perform the following steps on the UCI HAR Dataset downloaded from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Load relevant R libraries:

library(data.table)

# Download and unzip files:

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip")

# Read data from files:

features = read.table('./UCI HAR Dataset/features.txt',header=FALSE, colClasses="character") 
activities = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE,colClasses="character")

testData = read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)     # 2947 obs. of  561 variables
testData_act = read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE) # 7352 obs. of  561 variables
testData_sub = read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)

trainData = read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData_act = read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_sub = read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# Uses descriptive activity names to name the activities in the data set:

testData_act$V1 = factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 = factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

# Appropriately labels the data set with descriptive activity names:
colnames(testData) = features$V2
colnames(trainData) = features$V2
colnames(testData_act) = ("Activity")
colnames(trainData_act) = ("Activity")
colnames(testData_sub) = ("Subject")
colnames(trainData_sub) = ("Subject")

# Extract only the measurements on the mean and standard deviation for each measurement:

extract_features <- grepl("mean()|std()", features$V2)
testData = testData[,extract_features]    # 2947 obs. of  79 variables
trainData = trainData[,extract_features]  # 7352 obs. of  79 variables

# Merge test and training sets into one data set, including the activities:

testData = cbind(testData_sub,testData_act,testData)
trainData = cbind(trainData_sub,trainData_act,trainData)

Data = rbind(testData,trainData) # 10299 obs. of  81 variables

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject:

DT = data.table(Data)
tidy_data = DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy_data,file="tidy_data.txt",sep=",",row.names = FALSE)
