library(dplyr)
filename<-"Coursera_DS3_Final.zip"

fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = filename, method="curl")
# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Read the Features files
x_train <- read.table(("./UCI HAR Dataset/train/X_train.txt"),header=FALSE)
x_test <- read.table(("./UCI HAR Dataset/test/X_test.txt"),header=FALSE)
#Read the Activity files
y_train<-read.table(("./UCI HAR Dataset/train/y_train.txt"),header=FALSE)
y_test<-read.table(("./UCI HAR Dataset/test/y_test.txt"),header = FALSE)
#Read the Subject files 
subject_train<-read.table(("./UCI HAR Dataset/train/subject_train.txt"),header=FALSE)
subject_test<-read.table(("./UCI HAR Dataset/test/subject_test.txt"),header=FALSE)

#Merge the dataset
#1. Concatenate the data tables by row
dataSubject <- rbind(subject_train, subject_test)
dataActivity<- rbind(y_train, y_test)
dataFeatures<- rbind(x_train, x_test)
#2.Set names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(("./UCI HAR Dataset/features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
#3. Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

#Subset only the measurements on the mean and the SD for each measurement
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
str(Data)

#Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(("./UCI HAR Dataset/activity_labels.txt"),head=FALSE)
Data$activity<-factor(Data$activity, labels=activityLabels$V2)
head(Data$activity,30)

#Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#Creates a second,independent tidy data set and ouput it
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

