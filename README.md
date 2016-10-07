## Getting and Cleaning Data - Course Project

### Introduction
This R script(run_analysis.R) accomplish the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### About run_analysis.R
`run_analysis.R` was combined by these part: 

1. download & unzip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. load train data and test data, merge to create Data_det 
3. select mean and standard deviation from all columns
4. load train data label and test data label, merge with Data_set
5. write result to `tidy.txt`
6. group with subject and activity, calculate the result to `calculated_tidy.txt` 