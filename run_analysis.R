## Getting and Cleaning Data - Course Project ##

# Set the working directory to the folder in which the 'UCI HAR Dataset' folder 
# is saved.


library(plyr)
library(tidyr)
library(reshape2)


## 1. Merge the training and the test sets to create one data set

## Read data files in UCI HAR Dataset folder

# Read the list of all features
features <- read.table("./UCI HAR Dataset/features.txt", 
                       col.names = c("Feature_Num", "Feature_Name"), 
                       colClasses = "character")
features[,2] <- gsub("\\()", "", features[,2])
features[,2] <- gsub("-|,|\\(|\\)", "_", features[,2])

# The last 7 elements might also be modified though it would not be necessary
# They will not be counted in the subsequent Step (i.e. step 2).
if (FALSE) {
    features[,2] <- gsub("gravityMean_", "gravityMean", features[,2])
    features[555:561,2] <- c("angle_tBodyAccMean_gravity", 
                             "angle_tBodyAccJerkMean_gravityMean",
                             "angle_tBodyGyroMean_gravityMean",
                             "angle_tBodyGyroJerkMean_gravityMean",
                             "angle_X_gravityMean",
                             "angle_Y_gravityMean",
                             "angle_Z_gravityMean")
}


# Read the training set
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      colClasses = "numeric", 
                      col.names = features[,2])

# Read the training labels
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      col.names = "Activity_Label")

# Read the training subjects' identifiers
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "Subject")

# Create a data frame for training data
training <- cbind(subject_train, y_train, X_train)

# Read the test set
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     colClasses = "numeric", 
                     col.names = features[,2])

# Read the test labels
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names = "Activity_Label")

# Read the test subjects' identifiers
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "Subject")

# Create a data frame for test data
test <- cbind(subject_test, y_test, X_test)

# Combine the two data frames: 'training' and 'test'
comb_data <- rbind(training, test)

# (optional) 
# rm(X_train, y_train, subject_train, X_test, y_test, subject_test)



## 2. Extract only the measurements on the mean and standard deviation for 
##    each measurement

# Get the index of the measurement on the mean and standard deviation
col_index <- c(1, 2, grep("*[Mm]ean|*[Ss]td*", names(comb_data)))
col_index <- col_index[! col_index %in% c(557:563)]

# Extract the data
extr_data <- comb_data[, col_index]

# (optional)
# rm(col_index)



## 3. Use descriptive activity names to name the activities in the data set

# Read the activity labels with their activity name
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              col.names = c("Activity_Label", "Activity"))

extr_data_upd <- join(activity_labels, extr_data, 
                           by = "Activity_Label")

extr_data_upd$Activity_Label <- NULL

# Move 'Subject' column to the first of the data frame 'extr_data_upd'
extr_data_upd <- cbind(extr_data_upd$Subject, extr_data_upd)
extr_data_upd$Subject <- NULL
names(extr_data_upd)[1] <- "Subject"

# (optional)
# rm(extr_data)



## 4. Appropriately label the data set with descriptive variable names

# This has been done in the first step. The descriptive values listed in 
# 'features.txt' would be appropriate. They are slightly modified and 
# used as the variable names for the data set.



## 5. From the data set in step 4, create a second, independent tidy data set 
##    with the average of each variable for each activity and each subject

# Split the data set by Subject and by Activity
sp_list <- split(extr_data_upd,
                 list(extr_data_upd$Subject,extr_data_upd$Activity))

# Calculate the average of each variable for each subject and each activity
avg_mat <- t(sapply(sp_list, function(df) {colMeans(df[, 3:81])}))

# Transform the matrix 'avg_mat' into a data frame 'avg_df'
avg_df <- as.data.frame(avg_mat)

# (optional)
# rm(sp_list, avg_mat)

# Update the column names
colnames(avg_df) <- paste("mean(", colnames(avg_df), ")", sep = "")

# Extract the row names of 'avg_df'
subject_activity <- rownames(avg_df)

# Update the data frame 'avg_df' by adding the row names as a column
avg_df_upd <- cbind(subject_activity, avg_df)

# Get the tidy data set
tidy_data <- separate(avg_df_upd, subject_activity, 
                 into = c("Subject", "Activity"), sep = "\\.")

# (optional)
# rm(subject_activity, avg_df, avg_df_upd)

# Get the final tidy data set
final_tidy_data <- tidy_data[order(as.numeric(tidy_data$Subject)), ]
rownames(final_tidy_data) <- NULL

# Export the final tidy data into a text file named 'final_tidy_data.txt'
write.table(final_tidy_data, 
            file = "final_tidy_data.txt", 
            sep = "\t", 
            row.names = FALSE)
