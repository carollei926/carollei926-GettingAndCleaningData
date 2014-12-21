#####
### Getting and Cleaning Data - Course Project (by carollei926, 12/20/2014)
#####

### Project Description
if(FALSE){
  You should create one R script called run_analysis.R that does the following. 
  
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of 
     each variable for each activity and each subject.
}

getwd()
setwd("C:/Users/leip/Desktop/Getting and Cleaning Data/Course Project")
getwd()

### Load library
library(plyr)

##### Read-in data
      ### First Level
activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "")
features        <- read.table("~/UCI HAR Dataset/features.txt"       , header = FALSE, sep = "")

      ### Second Level
      ## test
subject_test  <- read.table("~/UCI HAR Dataset/test/subject_test.txt" , header = FALSE, sep = "")
X_test        <- read.table("~/UCI HAR Dataset/test/X_test.txt"       , header = FALSE, sep = "")
Y_test        <- read.table("~/UCI HAR Dataset/test/Y_test.txt"       , header = FALSE, sep = "")
      ## train
subject_train  <- read.table("~/UCI HAR Dataset/train/subject_train.txt" , header = FALSE, sep = "")
X_train        <- read.table("~/UCI HAR Dataset/train/X_train.txt"       , header = FALSE, sep = "")
Y_train        <- read.table("~/UCI HAR Dataset/train/Y_train.txt"       , header = FALSE, sep = "")

##### 1. Merges the training and the test sets to create one data set.
        # Combines data table (train vs test) by rows
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
            # Create flag of group (test and train):
subject_train_flag <- subject_train
subject_train_flag$group_flag <- "train"
  #str(subject_train_flag)
subject_test_flag <- subject_test
subject_test_flag$group_flag <- "test"
  #str(subject_test_flag)
S <- rbind(subject_train_flag, subject_test_flag)
  #str(S)

##### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

        # Rename features' columns (variable name)
#before: str(features)
names(features) <- c('feature_id', 'feature_name')
#after: str(features)

        # Search for matches to argument mean or standard deviation (sd)  within each element of character vector
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feature_name) 
X <- X[, index_features] 


##### 3. Uses descriptive activity names to name the activities in the data set.
# Rename X dataset with all matches of a string features from features dataset
#before: str(X)
names(X) <- gsub("\\(|\\)", "", (features[index_features, 2]))
#after: str(X)


##### 4. Appropriately labels the data set with descriptive activity names:

        # Rename Activities dataset with proper variable names
  #before: str(activity_labels)
names(activity_labels) <- c('activity_id', 'activity_name')
  #after: str(activity_labels)

        # Replace Y's variable of activity_id with activity_name using corresponding values from activity_labels dataset
        # Rename Y and S's variable 
  #before: str(Y)      
Y[, 1] = activity_labels[Y[, 1], 2]
names(Y) <- "Activity"
  #after: str(Y)
        # Rename S's variable   
  #before: str(S)  
names(S) <- c("Subject","group_flag")
  #after: str(S) 

        # Combines data table by columns
TidyDataSet <- cbind(S, Y, X)
  # str(TidyDataSet)


##### 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#####    each variable for each activity and each subject.

        # Create a partial dataset with only numeric variables of all activities' readings
partial <- TidyDataSet[, 4:dim(TidyDataSet)[2]] 
str(partial)

        # Calculate average of all vars in the partial dataset, and merge back not-being-averaged vars 
        # back from TidyDataSet
TidyDataSet_avg <- aggregate(partial,list(TidyDataSet$Subject, TidyDataSet$group_flag, TidyDataSet$Activity), mean)
        # Rename the first 3 columns for more descriptive names
names(TidyDataSet_avg)[1] <- "Subject"
names(TidyDataSet_avg)[2] <- "group_flag"
names(TidyDataSet_avg)[3] <- "Activity"
        # Sort data by number of subject
TidyDataSet_avg <- arrange(TidyDataSet_avg, Subject, Activity)
str(TidyDataSet_avg)


##### Create data file to be uploaded
if(!file.exists("Deliverables")){
  dir.create("Deliverables")
}
write.table(TidyDataSet_avg, file = "~/Deliverable/TidyDataSet_avg.txt", row.names = FALSE)

##### END #####