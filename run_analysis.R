
library(plyr) ### To be used for tidy dataset later
setwd("C:/Users/526899/Documents/Projects/Coursera Data Scientist/Getting and Cleaning Data")

### Unzip the file
unzip(zipfile="./getdata-projectfiles-UCI HAR Dataset.zip",exdir=".")

### List files and read all of them in
filepath <- file.path(".","UCI HAR Dataset")
files <- list.files(filepath, recursive = TRUE)

activity.train <- read.table(file.path(filepath,"train","Y_train.txt"), header = FALSE)
activity.test <- read.table(file.path(filepath,"test","Y_test.txt"), header = FALSE)

subject.train <- read.table(file.path(filepath, "train", "subject_train.txt"),header = FALSE)
subject.test <- read.table(file.path(filepath, "test", "subject_test.txt"),header = FALSE)

features.train <- read.table(file.path(filepath, "train", "X_train.txt"),header = FALSE)
features.test <- read.table(file.path(filepath, "test", "X_test.txt"),header = FALSE)

### Merge the training and testing dataset for all the types of data
activity.all <- rbind(activity.train, activity.test)
subject.all <- rbind(subject.train, subject.test)
features.all <- rbind(features.train, features.test)

### Assign names to variables
names(activity.all) <- "activity"; names(subject.all) <- "subject"
features.names <- read.table(file.path(filepath, "features.txt"),head=FALSE)
names(features.all)<- features.names$V2

### Combine all datasets
combined <- cbind(features.all, subject.all, activity.all)

### Extract only the measurements on the mean and standard deviation for each measurement
req.features.names <- features.names$V2[grep("mean\\(\\)|std\\(\\)", features.names$V2)]
combined <- subset(combined, select = c(as.character(req.features.names),"subject","activity"))

### Use descriptive activity names to name the activities in the data set
activity.desc <- as.vector(read.table(file.path(filepath, "activity_labels.txt"),header = FALSE)$V2)
combined$activity <- ordered(combined$activity, levels = c(1:6), labels = activity.desc)

### Appropriately label the data set with descriptive variable names
curr.names <- c("^t", "^f","Acc","Gyro","Mag","BodyBody")
new.names <- c("time","frequency","Accelermeter","Gyroscope","Magnitude","Body")
for(i in 1:length(curr.names)) {
  names(combined) <- gsub(curr.names[i],new.names[i],names(combined))
}

### Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy <-aggregate(. ~subject + activity, combined, mean)
write.table(tidy, file = "tidydata.txt",row.name=FALSE)
