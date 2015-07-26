## README ##

### Getting and Cleaning Data - Course Project

This text explains how all of the scripts work and how they are connected.


#### Data
The data for this course project are available from 
[Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
 
You can read each of the text files using the `read.table()` function in R. For example, reading in 'features.txt' (from the **UCI HAR Dataset** folder) can be done with the following code:

	features <- read.table("./UCI HAR Dataset/features.txt")

#### R packages required
The packages required to run the script are as follows: 

* **plyr**
* **reshape2**
* **tidyr**


#### Procedure:

Set the working directory to the folder in which the **UCI HAR Dataset** folder is saved.

##### Step I - Merge the training and the test sets to create one data set

1. Read the list of all features

		features <- read.table("./UCI HAR Dataset/features.txt", 
		                       col.names = c("Feature_Num", "Feature_Name"), 
		                       colClasses = "character")
	
		features[,2] <- gsub("\\()", "", features[,2])
	
		features[,2] <- gsub("-|,|\\(|\\)", "_", features[,2])

2. Read the training data set

		X_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
		                      colClasses = "numeric", 
		                      col.names = features[,2])

3. Read the training labels

		y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
		                      col.names = "Activity_Label")

4. Read the training subjects' identifiers

		subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
		                            col.names = "Subject")

5. Create a data frame for training data

		training <- cbind(subject_train, y_train, X_train)

6. Read the test set

		X_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
		                     colClasses = "numeric", 
		                     col.names = features[,2])

7. Read the test labels

		y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
		                     col.names = "Activity_Label")

8. Read the test subjects' identifiers

		subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
		                           col.names = "Subject")

9. Create a data frame for test data

		test <- cbind(subject_test, y_test, X_test)

10. Combine the two data frames: `training` and `test`

		comb_data <- rbind(training, test)


##### Step II - Extract only the measurements on the mean and standard deviation for each measurement

1. Get the index of the measurement on the mean and standard deviation

		col_index <- c(1, 2, grep("*[Mm]ean|*[Ss]td*", names(comb_data)))
		col_index <- col_index[! col_index %in% c(557:563)]

2. Extract the data

		extr_data <- comb_data[, col_index]


##### Step III - Uses descriptive activity names to name the activities in the data set

1. Read the activity labels with their activity name

		activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
		                              col.names = c("Activity_Label", "Activity"))

2. Update `extr_data` with descriptive activity names

		extr_data_upd <- join(activity_labels, extr_data, by = "Activity_Label")
		
		extr_data_upd$Activity_Label <- NULL

3. Move `Subject` column to the first of the data frame `extr_data_upd`

		extr_data_upd <- cbind(extr_data_upd$Subject, extr_data_upd)
		extr_data_upd$Subject <- NULL
		names(extr_data_upd)[1] <- "Subject"


##### Step IV - Appropriately label the data set with descriptive variable names. 

This has been done in **Step I**. The descriptive values listed in **features.txt** would be appropriate. They are slightly modified and used as the variable names for the data set.


##### Step V - From the data set in Step IV, create a second, independent tidy data set with the average of each variable for each activity and each subject

1. Split the data set by Subject and by Activity

		sp_list <- split(extr_data_upd, list(extr_data_upd$Subject,extr_data_upd$Activity))

2. Calculate the average of each variable for each subject and each activity

		avg_mat <- t(sapply(sp_list, function(df) {colMeans(df[, 3:81])}))

3. Transform the matrix `avg_mat` into a data frame `avg_df`

		avg_df <- as.data.frame(avg_mat)

4. Update the column names

		colnames(avg_df) <- paste("mean(", colnames(avg_df), ")", sep = "")

5. Extract the row names of `avg_df`

		subject_activity <- rownames(avg_df)

6. Update the data frame `avg_df` by adding the row names as a column

		avg_df_upd <- cbind(subject_activity, avg_df)

7. Get the tidy data set

		tidy_data <- separate(avg_df_upd, subject_activity, 
                 			  into = c("Subject", "Activity"), 
							  sep = "\\.")

8. Get the final tidy data set

		final_tidy_data <- tidy_data[order(as.numeric(tidy_data$Subject)), ]
		rownames(final_tidy_data) <- NULL


##### Step VI - Export the data set into a text file

	write.table(final_tidy_data, 
	            file = "final_tidy_data.txt", 
	            sep = "\t", 
	            row.names = FALSE)
