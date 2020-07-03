The run_analysis.R script performs the data preparation

Download the dataset


One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Assign each data to variables
features <- features.txt : 561 rows, 2 columns
activities <- activity_labels.txt : 6 rows, 2 columns
subject_test <- test/subject_test.txt : 2947 rows, 1 column
x_test <- test/X_test.txt : 2947 rows, 561 columns
y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

Merges the training and the test sets to create one data set

testData<-cbind(subject_test, X_test, y_test)
trainData<-cbind(subject_train, X_train, y_train)

Extracts only the measurements on the mean and standard deviation for each measurement
#toal data = train + test
data <- rbind(trainData, testData)
Uses descriptive activity names to name the activities in the data set


Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
UciNewNames <- as.vector(names(UciNew))
UciNewNames <- gsub("Acc", "_Acceleration", UciNewNames)
UciNewNames <- gsub("Mag", "_Magnitude", UciNewNames)
UciNewNames <- gsub("Jerk", "_jerk", UciNewNames)
UciNewNames <- gsub("Gyro", "_gyro", UciNewNames)
UciNewNames <- gsub("BodyBody", "Body", UciNewNames)
UciNewNames <- tolower(UciNewNames)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyData<- aggregate(. ~subject_id + activity_desc, UciNew, mean)

#write final data to a file.
write.table(TidyData, file="TidySet.txt", row.names = FALSE)
