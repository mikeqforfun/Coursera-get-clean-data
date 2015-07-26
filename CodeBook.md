## Code Book ##

### Getting and Cleaning Data - Course Project

This **code book** describes all the variables, the data, and any transformations that has been created and performed to clean up the data. 


##### `features`
> List of all features.
> 
> [*data.frame*] [561 x 2]
> 
> 1. `Feature_Num`: Feature number
> 2. `Feature_Name`: Feature names


##### `X_train`
> Training data set.
> 
> [*data.frame*] [7352 x 561]
> 
> (Each variable/column corresponds to a feature listed in **`features`**.)


##### `y_train`
> Activity labels for the training data set.
> 
> [*data.frame*] [7352 x 1]
> 
> 1. `Activity_Label`: Activity labels


##### `subject_train`
> Identifiers of subjects who performed the activity for the training sample.
> 
> [*data.frame*] [7352 x 1]
> 
> 1. `Subject`: Identifiers of subjects


##### `training`
> Training data set, which combines **`subject_train`**, **`y_train`** and **`X_train`**.
> 
> [*data.frame*] [7352 x 563]
> 
> 1. `Subject`: Identifiers of subjects
> 2. `Activity_Label`: Activity labels
> 
> (Each of the rest variables/columns corresponds to a feature listed in **`features`**.)


##### `X_test`
> Test data set.
> 
> [*data.frame*] [2947 x 561]
> 
> (Each variable/column corresponds to a feature listed in **`features`**.)


##### `y_test`
> Test labels
> 
> [*data.frame*] [2947 x 561]
> 
> 1. `Activity_Label`: Activity labels


##### `subject_test`
> Identifiers of subjects who performed the activity for the test sample.
> 
> [*data.frame*] [2947 x 1]
> 
> 1. `Subject`: Identifiers of subjects


##### `test`
> Test data set, which combines **`subject_test`**, **`y_test`** and **`X_test`**.
> 
> [*data.frame*] [2947 x 563]
> 
> 1. `Subject`: Identifiers of subjects
> 2. `Activity_Label`: Activity labels
> 
> (Each of the rest variables/columns corresponds to a feature listed in **`features`**.)


##### `comb_data`
> A data set that combines **`training`** and **`test`**.
> 
> [*data.frame*] [10299 x 563]
> 
> 1. `Subject`: Identifiers of subjects who performed the activity
> 2. `Activity_Label`: Activity labels
> 
> (Each of the rest variables/columns corresponds to a feature listed in **`features`**.) 


##### `col_index`
> Index of the measurements on the mean and standard deviation in **`comb_data`**
> 
> [*numeric*] [1:81]


##### `extr_data`
> Measurements on the mean and standard deviation for each measurement, which are extracted from the combined data set **`comb_data`**.
> 
> [*data.frame*] [10299 x 81]
> 
> 1. `Subject`: Identifiers of subjects who performed the activity
> 2. `Activity_Label`: Activity labels
> 
> (Each of the rest variables/columns corresponds to a measurement on a mean or a standard deviation.)


##### `activity_labels`
> Activity labels
> 
> [*data.frame*] [6 x 2]
> 
> 1. `Activity_Label`: Activity labels
> 2. `Activity`: Names of the activities


##### `extr_data_upd`
> Updated **`extr_data`** with activity names for each observation
> 
> [*data.frame*] [10299 x 81]
> 
> 1. `Subject`: Identifiers of subjects who performed the activity
> 2. `Activity`: Names of the activities
> 
> (Each of the rest variables/columns corresponds to a measurement on a mean or a standard deviation.)


##### `sp_list`
> A list, of which each element containing the data [*data.frame*] for a subject performing an activity
> 
> [*list*] [180 elements]


##### `avg_mat`
> Averages of each variable/feature for each subject and each activity
> 
> [*matrix*] [180 x 79]
> 
> (Each variables/columns corresponds to a measurement on a mean or a standard deviation.)


##### `avg_df`
> Averages of each variable/feature for each subject and each activity
> 
> [*data.frame*] [180 x 79]
> 
> (Each variables/columns corresponds to a measurement on a mean or a standard deviation.)


##### `subject_activity`
> Row names of **`avg_df`**
> 
> [*character*] [1:180]


##### `avg_df_upd`
> Updated **`avg_df`** with an extra column being **`subject_activity`**
> 
> [*data.frame*] [180 x 80]
> 
> 1. `subject_activity`: Row names of **`avg_df`**
> 
> (Each of the rest variables/columns corresponds to a measurement on a mean or a standard deviation.)


##### `tidy_data`
> Tidy data set with the average of each variable for each activity and each subject
> 
> [*data.frame*] [180 x 81]
> 
> 1. `Subject`: Identifiers of subjects who performed the activity
> 2. `Activity`: Names of the activities
> 
> (Each of the rest variables/columns corresponds to a measurement on a mean or a standard deviation.)


##### `final_tidy_data`
> Final tidy data set with the average of each variable for each activity and each subject (without row names)
> 
> [*data.frame*] [180 x 81]
> 
> 1. `Subject`: Identifiers of subjects who performed the activity
> 2. `Activity`: Names of the activities
> 
> (Each of the rest variables/columns corresponds to a measurement on a mean or a standard deviation.)

