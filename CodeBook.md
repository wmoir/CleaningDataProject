CleaningDataProject CodeBook
===================

### Introduction

This codebook describes the tidy dataset which is the final project 

Name: traintest_tidy.txt

Dimensions: 11,880 observations, 4 variables

The four variables are subject_id, activity_id, feature and mean. 

There are 30 subjects, each doing 6 activities, and for each activity there are 66 features. 30 * 6 * 66 = 11,880 rows.

For each subject, activity and feature, the tidy dataset reports the mean value.

### Variables

subject_id: integer, 1:30

activity_id: factor with 6 levels "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" "STANDING" "LAYING" 

feature: factor with 66 levels, see below for description

mean: num, mean value of the feature

### Measures

The 66 values of the feature variable are as follows. There are 17 main features, of which 8 have measures in the X, Y and Z directions. For each of these, there is a mean and standard deviation. So, (9 + 8*3) * 2 = 66 total.

The 17 main features are as follows:

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

A full description of the variables can be found in features_info.txt

### Transformations

Prior to tidying, the dataset comprised of 10,299 observations of 68 variables. The variables were subject_id, activity_id, and each of the 66 features was set as it's own variable. The subjects have multiple measurements of each feature for each activity. Thus, there were two transformations to create the tidy data.

-1 The values of each measurement for each subject and activity were collapsed to means, so each subject has only one measurement of each feature for each activity.

-2 The features were gathered into one variable, taking the dataset from wide to long.

### Units

All features are normalized and therefore unitless.
