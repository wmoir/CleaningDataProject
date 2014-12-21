## Data Science Coursera:
## Getting and Cleaning Data - 016
## Course Project

## Download "raw" data and turn it into a tidy data set

## load packages
library(dplyr)
library(tidyr)

## Set working directory to my directory for this course
if (!file.exists("./datasciencecoursera/cleaning")) {dir.create("./datasciencecoursera/cleaning")}
setwd("datasciencecoursera/cleaning/")

## download and unzip file to datasciencecoursera/cleaning dir
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "har.zip", method = "curl")
unzip(zipfile = "har.zip")

## information on how to construct data is in ./UCI HAR Dataset//readme.txt

## read in training data
trainset <- read.table('./UCI HAR Dataset//train//X_train.txt')

## read in subject id for training data
subjecttrain <- read.table('./UCI HAR Dataset/train/subject_train.txt')
names(subjecttrain) <- c('subject_id')

## read in training activity labels
trainlabels <- read.table('./UCI HAR Dataset//train//y_train.txt')
names(trainlabels) <- c('activity_id')


## all datasets are read in in proper sorted order for merge
train <- cbind(subjecttrain, trainlabels, trainset)


## read in test data
testset <- read.table('./UCI HAR Dataset//test//X_test.txt')

## read in subject id for test data
subjecttest <- read.table('./UCI HAR Dataset/test/subject_test.txt')
names(subjecttest) <- c('subject_id')

## read in test activity labels
testlabels <- read.table('./UCI HAR Dataset//test//y_test.txt')
names(testlabels) <- c('activity_id')

## all datasets are read in in proper sorted order for merge
test <- cbind(subjecttest, testlabels, testset)


## concatenate test and training data
## first add flag to distinguish test and training
train$traintest <- 'train'
test$traintest <- 'test'
traintest <- rbind(train, test)

## read in feature names
featurenames <- read.table('./UCI HAR Dataset//features.txt', stringsAsFactors = FALSE)[,2]
## assign variables names to training data
names(traintest) <- c("subject_id", "activity_id", featurenames)


## we only want measurements on mean and std
## pull out all variable names that include "mean()" or "std()"
meanstd <- grep('mean\\(\\)|std\\(\\)', featurenames, value = TRUE)
## add id variables
varstokeep <- c('subject_id', 'activity_id', meanstd)
## restrict traintest to just these variables
traintest <- traintest[,varstokeep]

## remove (,), and - from variable names
newvarnames <- gsub("[-]","",names(traintest))
names(traintest) <- newvarnames
names(traintest)

# we want activity labels to be a factor
traintest$activity_id <- as.factor(traintest$activity_id)
## check that levels are 1, 2, 3, 4, 5, 6
levels(traintest$activity_id)
## assign ids per activitylabels
levels(traintest$activity_id) <- activitylabels$desc


str(traintest)

## create tidy dataset, with means for all mean and std variables
## this will be a long and narrow tidy dataset
traintest_tidy <- traintest %>%
  group_by(subject_id, activity_id) %>%
  summarise_each(funs(mean)) %>%
  gather(feature, mean, -subject_id, -activity_id) %>%
  arrange(subject_id, activity_id)

## write table
write.table(traintest_tidy, "traintest_tidy.txt", row.name = FALSE)

## check that it reads in okay
# traintest_tidy_r <- read.table("traintest_tidy.txt", header = TRUE)

  