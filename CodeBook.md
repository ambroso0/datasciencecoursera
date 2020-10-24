The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Download the dataset
Dataset downloaded and extracted under the folder called "UCI HAR Dataset"

2. Read and assign each data to variables:

x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels
y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed

3. Merges the training and the test sets to create one data set

dataFeatures (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
dataActivity (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
dataSubject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function

3.1 Merge column to get the data frame Data for all data 

dataCombine is cretaed by merging dataActivity and dataSubject using cbind() function
Data (10299 rows, 563 column) is created by merging dataSubject, dataActivity and dataCombine using cbind() function

4. Extracts only the measurements on the mean and standard deviation for each measurement

Data (10299 rows, 88 columns) is created by subsetting Data, selecting only columns: subject, activity and the measurements on the mean and standard deviation (std) for each measurement

5. Uses descriptive activity names to name the activities in the data set

activityLabels <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)
Data$activity <- factorized the activity column in the Data dataset to replace it with the with corresponding activity taken from V2 column of the activitiesLabels variable

6. Appropriately labels the data set with descriptive variable names

code column in Data renamed into activities
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All Mag in column’s name replaced by Magnitude
All BodyBody in column’s name replaced by Body

7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Data2 (180 rows, 88 columns) is created by sumarizing Data taking the means of each variable for each activity and each subject. 
Export Data2 into tidydata.txt file.


Activity Labels

WALKING (value 1): subject was walking during the test

WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test

WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test

SITTING (value 4): subject was sitting during the test

STANDING (value 5): subject was standing during the test

LAYING (value 6): subject was laying down during the test
