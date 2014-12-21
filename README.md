carollei926-GettingAndCleaningData
==================================
# GettingAndCleaningData
##Repo for Coursera course Getting And Cleaning Data

### This ReadMe file will explain the content of the course project for course "Getting and Cleaning Data" and how the rest of the files in this repo work/connect with each other

### Course Project Content
Data source: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Full description of the dataset can be obtained here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

After you have finished step 5:
Please upload the tidy data set created in step 5 of the instructions to the course project page. 
Please upload your data set as a txt file.

### Process happened in **run_analysis.R**
0. Preparation- download and unlip files from above-mentioned URL and save to working directory.

1. Merges the training and the test sets to create one data set.
  - Merge the X_test and X_train data by raw to get a dataset with all subjects' test and train data.
  - Merge the Y_test and Y_train data by raw to get a dataset with all subjects' test and train activiies.
  - Create a group_flag variabe for both Subject_test and Subject_train, with value of "test" or "train" to indicate the research group the subject belongs to. Merge the Subject_test and Subject_train data by raw to get a dataset with all subjects' id and group. 
  
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  - Use grep() to get the index of feature names that has "mean" or "std" in it (using general formatting).
  - Apply the index to test and train data (X) to get the only data related to mean or standard deviation.

3. Uses descriptive activity names to name the activities in the data set
  - Rename X with meaningful feature using the index of subsetted feature name we just got in step 2-1.
4. Appropriately labels the data set with descriptive variable names. 
  - Rename variables with meaningful names for subject(S) and Activity(Y) datasets
  - Column bind to join Subject(S), Activity(Y), and measure data(X) datasets into one "TidyDataSet",
  in which each row means one activity of one subject. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - Subset a "partial" dataset from "TidyDataSet," with only the numeric measurement data (originally coming from dataset X) in order to prepare for getting average.
  - Use aggregate() to get the mean  of each activity on each subject, group, and activity level (the original course project requires means of each variable on  each activity, each subject level, but in order to withhold the group level data in the output dataset, and adding group level doesn't change the result, therefore I included the group level in the list()). The output dataset is named "TidyDataSet_avg".

6. After-steps
  - Create a "Deliverable" folder in the working directory
  - Use write.table() and row.names = FALSE to save a copy of "TidyDataSet_avg" (in .txt format) to [working directory]/Deliverable folder. 


### Description of Codebook
1. Codebook name : Codebook_TidyDataSet_avg.pdf
2. Codebook lists the following:
  - Source of original dataset
  - Data manipulation/analysis program: run_analysis.R
  - Summary of target dataset (TidyDataSet.txt)
  - List of variable name, type, length, and description







  
