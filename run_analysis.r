##Creates R script that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Get the features (column names)
features <- read.table("features.txt")
col_names <- features[,2]

## Get the activity labels
activity <- read.table("activity_labels.txt")

## Get training data
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
names(subject_train) <- "Subject"

## Name the columns for X_train 
names(x_train) <- col_names

##Match the activity with activity labels
activity_labels <- activity[,2]
y_train[,2] <- activity_labels[y_train[,1]]


##Name the activity and activity labels and subject
names(y_train) <- c("Activity", "Activity_labels")
y_train <- y_train[c("Activity_labels", "Activity")]

#Get only the Mean and SD columns
get_meansd_train <- grep("mean|sd", colnames(x_train), value = TRUE)
meansd_train <- x_train[,get_meansd_train]


##Combine training data
train_data <- cbind(subject_train,y_train, meansd_train)

## Get the test data

x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
names(subject_test) <- "Subject"

## Name the columns for X_test
names(x_test) <- col_names

##Match the activity with activity labels
y_test[,2] <- activity_labels[y_test[,1]]

##Name the activity and activity labels and subject
names(y_test) <- c("Activity", "Activity_labels")
y_test <- y_test[c("Activity_labels", "Activity")]

#Get only the Mean and SD columns
get_meansd_test <- grep("mean|sd", colnames(x_test), value = TRUE)
meansd_test <- x_test[,get_meansd_test]

##Combine test data
test_data <- cbind(subject_test,y_test, meansd_test)

##Merge training and the test dataset
final_data <- rbind(train_data, test_data)

## Calculate average of each variable for each activity and each subject.
average <- aggregate(final_data[,3:ncol(final_data)], by=list(final_data$Subject, final_data$Activity_labels), mean)
write.table(average, "tidy.txt",row.name = FALSE) 




