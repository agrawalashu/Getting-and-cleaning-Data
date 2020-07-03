#Load all the required package to support the operations

library(dplyr)

#Load Data sets in to Data frames using read.table


##Load data in Data frames using proper names 


#read feature names and activity labels
features<-read.table("C:/Users/aaa270/Desktop/R_Project/Exams/Course3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", header =F, sep =" " , col.names = c("id", "feature_name"))
activity_lab <- read.table("C:/Users/aaa270/Desktop/R_Project/Exams/Course3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("activity_id", "activity_desc"))


subject_test<-read.table("C:/Users/aaa270/Desktop/R_Project/Exams/Course3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header =F)
names(subject_test) <- "subject_id"
X_test<-read.table("C:/Users/aaa270/Desktop/R_Project/Exams/Course3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header =F, comment.char="", col.names = features$feature_name)
y_test<-read.table("C:/Users/aaa270/Desktop/R_Project/Exams/Course3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header =F, col.names="activity_id")

#read train data
subject_train<-read.table("C:/Users/aaa270/Desktop/R_Project/Exams/Course3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header =F)
names(subject_train) <- "subject_id"
X_train<-read.table("C:/Users/aaa270/Desktop/R_Project/Exams/Course3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header =F, comment.char="", col.names = features$feature_name)
y_train<-read.table("C:/Users/aaa270/Desktop/R_Project/Exams/Course3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header =F, col.names="activity_id")

##Merges the training and the test sets to create one data set.
testData<-cbind(subject_test, X_test, y_test)
trainData<-cbind(subject_train, X_train, y_train)

##Extracts only the measurements on the mean and standard deviation for each measurement.
#toal data = train + test
data <- rbind(trainData, testData)

#only get measurements for mean and std, ignore rest
newdata<-data[ , grepl( "subject|mean|std|activity_id" , names( data ) ) ]
newdata<-newdata[ , !grepl( "meanFreq" , names( newdata ) ) ]

#merge the above data with activity labels to get descriptive activities
UciNew <- merge(newdata, activity_lab, by.x = "activity_id", by.y = "activity_id", sort = FALSE)
UciNew<-UciNew[ , !grepl( "activity_id" , names( UciNew ) ) ]

#Appropriately labels the data set with descriptive variable names.
UciNewNames <- as.vector(names(UciNew))
UciNewNames <- gsub("Acc", "_Acceleration", UciNewNames)
UciNewNames <- gsub("Mag", "_Magnitude", UciNewNames)
UciNewNames <- gsub("Jerk", "_jerk", UciNewNames)
UciNewNames <- gsub("Gyro", "_gyro", UciNewNames)
UciNewNames <- gsub("BodyBody", "Body", UciNewNames)
UciNewNames <- tolower(UciNewNames)

names(UciNew) <- UciNewNames

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyData<- aggregate(. ~subject_id + activity_desc, UciNew, mean)

#write final data to a file.
write.table(TidyData, file="TidyData.txt", row.names = FALSE)
