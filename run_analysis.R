library(plyr);library(dplyr)
##download & unzip data
if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/projectfiles.zip")
unzip("./data/projectfiles.zip") ##unzip in "./UCI HAR Dataset/"

##Read Train_set/Test_set/Col_name
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
col_names <- read.table("./UCI HAR Dataset/features.txt")

####Appropriately labels the data set with descriptive variable names.
colnames_full <- as.character(col_names$V2)
colnames(train_set) <- colnames_full
colnames(test_set) <- colnames_full

##Create Data_Set merge by Trainset & TestSet
Data_Set <- rbind(train_set, test_set)

##unique duplicated column name
rm_duplicated_col_fBodyAcc <- make.names(col_names$V2[303:344], unique = TRUE)
rm_duplicated_col_fBodyAccJerk <- make.names(col_names$V2[382:423], unique = TRUE)
rm_duplicated_col_fBodyGyro <- make.names(col_names$V2[461:502], unique = TRUE)
colnames(Data_Set)[303:344] <- rm_duplicated_col_fBodyAcc
colnames(Data_Set)[382:423] <- rm_duplicated_col_fBodyAccJerk
colnames(Data_Set)[461:502] <- rm_duplicated_col_fBodyGyro

####Extracts only the measurements on the mean and standard deviation for each measurement.
##select mean() & std() column
meanCol <- grep("mean\\(\\)", colnames_full, value = TRUE)
stdCol <- grep("std\\(\\)", colnames_full, value = TRUE)
select_mean_std <- select(Data_Set, one_of(meanCol), one_of(stdCol))

##Read Train_set_label/Test_set_label/labelName
train_set_label <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_set_label <- read.table("./UCI HAR Dataset/test/y_test.txt")
data_label <- rbind(train_set_label, test_set_label)

##Read train_subject/test_subject
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
data_subject <- rbind(train_subject, test_subject)

####Merges the training and the test sets to create one data set.
Data_Set <- cbind(data_subject$V1, data_label$V1,Data_Set)
colnames_full[303:344] <- rm_duplicated_col_fBodyAcc
colnames_full[382:423] <- rm_duplicated_col_fBodyAccJerk
colnames_full[461:502] <- rm_duplicated_col_fBodyGyro
colnames(Data_Set) <- c("subject", "activity", colnames_full)

####Uses descriptive activity names to name the activities in the data set
avtivity_labelName <- read.table("./UCI HAR Dataset/activity_labels.txt")
avtivity_labelName$V2 <- as.character(avtivity_labelName$V2)
Data_Set$activity <- factor(Data_Set$activity, levels = avtivity_labelName[,1], labels = avtivity_labelName[,2])
write.table(Data_Set, "tidy.txt", row.names = FALSE, quote = FALSE)

####From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Data_set_2 <- ddply(Data_Set, c("subject","activity"), numcolwise(mean))
write.table(Data_set_2, "calculated_tidy.txt", row.names = FALSE, quote = FALSE)