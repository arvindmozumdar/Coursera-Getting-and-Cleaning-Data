# Overview of `run_analysis.R`

The R script `run_analysis.R` performs the steps required in the course project:
1. Merges the training and the test sets to create one data set (lines 6-32)
2. Extracts only the measurements on the mean and standard deviation for each measurement (lines 35-36) 
3. Uses descriptive activity names to name the activities in the data set (lines 39-40)
4. Appropriately labels the data set with descriptive variable names (lines 43 47
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (lines 50 -51)

The code assumes that the dataset has been downloaded as a zip file in the same folder that is set as the working folder. 
In the script the zip file is uncompressed and all the data files are read in. Then files which are similar are combined, and the columns named. 
Only the mean and sd columns are retained, and then the feature names are mapped from the master file provided.
Finally the dataset is aggregated by subject and activity.

# Variables

* The downloaded files contain data in `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` 
* `x_data`, `y_data` and `subject_data` are merged with the datasets from the prior step
* `features` contains the names which are used for labeling the factors 
* `Combined` is the combined dataset that combined all the subjects, activities and features; this is subset for the required features only
* 'tidy' is the dataset summarized by subject and activity
