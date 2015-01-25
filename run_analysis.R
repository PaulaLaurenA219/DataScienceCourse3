
###Data Science - Getting and Cleaning Data
###Course Project

#set working directory
setwd("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData")

###STEP 1 - read in input data files
#read in the data from the UCI HAR dataset 

###TO RUN, please change the file path which will be where you store the files on your drive
X_train<-read.table("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData/UCI HAR Dataset/train/X_train.txt", header=F, sep="")
X_test<-read.table("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData/UCI HAR Dataset/test/X_test.txt", header=F, sep="")
subject_test<-read.table("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData/UCI HAR Dataset/test/subject_test.txt", header=F, sep="")
subject_train<-read.table("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData/UCI HAR Dataset/train/subject_train.txt", header=F, sep="")
y_test<-read.table("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData/UCI HAR Dataset/test/y_test.txt", header=F, sep="")
y_train<-read.table("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData/UCI HAR Dataset/train/y_train.txt", header=F, sep="")
features<-read.table("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData/UCI HAR Dataset/features.txt", header=F, sep="")
activity_labels<-read.table("C:/Users/SemanticPrincess/Desktop/dataSciencecoursera/CleaningData/UCI HAR Dataset/activity_labels.txt", header=F, sep="")

###STEP 2- combining data files
# combine X_train and the feature names together for Xtrain
X_train_df<-data.frame(X_train)
names(X_train_df)<-features[,2]
# combine X_train and the feature names together for Xtest
X_test_df<-data.frame(X_test)
names(X_test_df)<-features[,2]

# combine the X_train_df and x_test_df from above with the subject names 
X_test_subject<-cbind(X_test_df,subject_test[,1])
X_test_subject<-data.frame(X_test_subject) 
X_train_subject<-cbind(X_train_df,subject_train[,1])
X_train_subject<-data.frame(X_train_subject)
colnames(X_train_subject)[562] <- "Subject" #changing column name to subject
colnames(X_test_subject)[562] <- "Subject"#changing column name to subject

#create a record id (sequence number for 1: to record total) for both test and training data.  Purpose of this is identify the record so during
#merge stage downstream the joining variable is this variable.  Note the record id will also be created for the 
#table that it is joining. 
X_test_subject$id <- 1:nrow(X_test_subject) 
x_test_subject_id <- cbind(X_test_subject, "id"=1:nrow(X_test_subject)) 
X_train_subject$id <- 1:nrow(X_train_subject) 
x_train_subject_id <- cbind(X_train_subject, "id"=1:nrow(X_train_subject))

#create a record id (sequence number for 1: to record total) for y_test and y_train
y_test$id<- 1:nrow(y_test) 
y_train$id <- 1:nrow(y_train) 

#merge the activity label data with the y_test/y_train to give the name associated with the activity
activity_label_test<- merge(activity_labels,y_test,by="V1")
activity_label_train <- merge(activity_labels,y_train,by="V1")

#merge the X_train and activity labels for training and test)
X_train_final<-merge(X_train_subject,activity_label_train, by="id")
X_test_final<-merge(X_test_subject,activity_label_test, by="id")

#merge both X_train and X_test to create one dataset. 
complete<-rbind(X_train_final, X_test_final)
colName<-names(complete)

#identify all of the column headings that have "mean" in it
mean<-grep("(?i)*mean*", colName)
#identify all of the column headings that have "std" in it
stddev<-grep("(?i)*std*", colName)
print (mean)
print(std)

###STEP 3 - create tidy data set
#looking at the values(column nunbers) returned from the mean and stddev variables, identify the groupings of means
#alongside the applicable standard deviation to retain that order
cols <- c(2:7,42:47, 82:87, 122:127, 162:167, 202:203, 215:216, 228:229, 241:242, 254:255, 267:272, 295:297,346:351,374:376, 425:430, 504:505, 514, 517:518, 527, 530:531, 540, 543:544,553, 556:565) 
complete_STD_Mean<-complete[,cols]
#quick validation that all the correct values are extracted
head(complete_STD_Mean) #specific to mean and STD columns, identified 83.

#the desciptive names to the activities had been completed by previously joining the activity labels to the 
#respective X_train and X_test data.

#renaming the rest of the variables to provide a better description.
colnames(complete_STD_Mean)[1] <- "aveBodyAccelerometerTimeXaxis"  
colnames(complete_STD_Mean)[2] <- "aveBodyAccelerometerTimeYaxis" 
colnames(complete_STD_Mean)[3] <- "aveBodyAccelerometerTimeZaxis"  
colnames(complete_STD_Mean)[4] <- "stdDevBodyAccelerometerTimeXAxis" 
colnames(complete_STD_Mean)[5] <- "stdDevBodyAccelerometerTimeYAxis" 
colnames(complete_STD_Mean)[6] <- "stdDevBodyAccelerometerTimeZAxis" 
colnames(complete_STD_Mean)[7] <- "aveGravityAccelerometerTimeXAxis" 
colnames(complete_STD_Mean)[8] <- "aveGravityAccelerometerTimeYAxis" 
colnames(complete_STD_Mean)[9] <- "aveGravityAccelerometerTimeZAxis" 
colnames(complete_STD_Mean)[10] <- "stdDevGravityAccelerometerTimeXAxis" 
colnames(complete_STD_Mean)[11] <- "stdDevGravityAccelerometerTimeYAxis" 
colnames(complete_STD_Mean)[12] <- "stdDevGravityAccelerometerTimeZAxis"
colnames(complete_STD_Mean)[13] <- "aveBodyAccelerometerJerkTimeXAxis" 
colnames(complete_STD_Mean)[14] <- "aveBodyAccelerometerJerkTimeYAxis" 
colnames(complete_STD_Mean)[15] <- "aveBodyAccelerometerJerkTimeZAxis" 
colnames(complete_STD_Mean)[16] <- "standardDevBodyAccJerkTimeXAxis" 
colnames(complete_STD_Mean)[17] <- "standardDevBodyAccJerkTimeYAxis" 
colnames(complete_STD_Mean)[18] <- "standardDevBodyAccJerkTimeZAxis"
colnames(complete_STD_Mean)[19] <- "aveBodyGyroscopeTimeXaxis" 
colnames(complete_STD_Mean)[20] <- "aveBodyGyroscopeTimeYaxis" 
colnames(complete_STD_Mean)[21] <- "aveBodyGyroscopeTimeZAxis" 
colnames(complete_STD_Mean)[22] <- "stdDevBodyGyroscopeTimeXaxis" 
colnames(complete_STD_Mean)[23] <- "stdDevBodyGyroscopeTimeYaxis" 
colnames(complete_STD_Mean)[24] <- "stdDevBodyGyroscopeTimeZaxis" 
colnames(complete_STD_Mean)[25] <- "aveBodyGyrosopeJerkTimeXaxis" 
colnames(complete_STD_Mean)[26] <- "aveBodyGyrosopeJerkTimeYaxis" 
colnames(complete_STD_Mean)[27] <- "aveBodyGyrosopeJerkTimeZaxis" 
colnames(complete_STD_Mean)[28] <- "stdDevBodyGyrosopeJerkTimeXaxis" 
colnames(complete_STD_Mean)[29] <- "stdDevBodyGyrosopeJerkTimeYaxis" 
colnames(complete_STD_Mean)[30] <- "stdDevBodyGyrosopeJerkTimeZaxis"
colnames(complete_STD_Mean)[31] <- "aveBodyAccelerometerMagitudeTime"
colnames(complete_STD_Mean)[32] <- "stdDevBodyAcceleromeMagnitudeTime"
colnames(complete_STD_Mean)[33] <- "aveBodyGravityMagitudeTime"
colnames(complete_STD_Mean)[34] <- "stdDevBodyGravityMagnitudeTime"
colnames(complete_STD_Mean)[35] <- "aveBodyAccelerometerJerkMagitudeTime"
colnames(complete_STD_Mean)[36] <- "stdDevBodyAccelerometerJerkMagitudeTime"
colnames(complete_STD_Mean)[37] <- "aveBodyGyroscopeMagnitudeTime"
colnames(complete_STD_Mean)[38] <- "stdDevBodyGyroscopeMagnitudeTime"
colnames(complete_STD_Mean)[39] <- "aveBodyGyroscopeJerkMagitudeTime"
colnames(complete_STD_Mean)[40] <- "stdDevBodyGyroscopeJerkMagitudeTime"
colnames(complete_STD_Mean)[41] <- "aveBodyAccelerometerFFTxAxis"
colnames(complete_STD_Mean)[42] <- "aveBodyAccelerometerFFTyAxis"
colnames(complete_STD_Mean)[43] <- "aveBodyAccelerometerFFTzAxis"
colnames(complete_STD_Mean)[44] <- "stdDevBodyAccelerometerFFTxAxis"
colnames(complete_STD_Mean)[45] <- "stdDevBodyAccelerometerFFTyAxis"
colnames(complete_STD_Mean)[46] <- "stdDevBodyAccelerometerFFTzAxis"
colnames(complete_STD_Mean)[50] <- "aveBodyAccelerometerJerkFFTfreqXaxis"
colnames(complete_STD_Mean)[51] <- "aveBodyAccelerometerJerkFFTfreqYaxis"
colnames(complete_STD_Mean)[52] <- "aveBodyAccelerometerJerkFFTfreqZaxis"
colnames(complete_STD_Mean)[53] <- "stdDevBodyAccelerometerJerkFFTfreqXaxis"
colnames(complete_STD_Mean)[54] <- "stdDevBodyAccelerometerJerkFFTfreqYaxis"
colnames(complete_STD_Mean)[55] <- "stdDevBodyAccelerometerJerkFFTfreqZaxis"
colnames(complete_STD_Mean)[59] <- "aveBodyGyroscopeFFTxAxis"
colnames(complete_STD_Mean)[60] <- "aveBodyGyroscopeFFTyAxis"
colnames(complete_STD_Mean)[61] <- "aveBodyGyroscopeFFTzAxis"
colnames(complete_STD_Mean)[62] <- "stdDevBodyGyroscopeFFTxAxis"
colnames(complete_STD_Mean)[63] <- "stdDevBodyGyroscopeFFTyAxis"
colnames(complete_STD_Mean)[64] <- "stdDevBodyGyroscopeFFTzAxis"
colnames(complete_STD_Mean)[65] <- "aveBodyAccelerometerMagnitude"
colnames(complete_STD_Mean)[66] <- "stdDevBodyAccelerometerMagnitude"
colnames(complete_STD_Mean)[68] <- "aveBodyBodyAccelerometerJerkMagnitudeFFT"
colnames(complete_STD_Mean)[69] <- "stdDevBodyBodyAccelerometerJerkMagnitudeFFT"
colnames(complete_STD_Mean)[71] <- "aveBodyBodyGyroscopeMagnitudeFFT"
colnames(complete_STD_Mean)[72] <- "stdDevBodyBodyGyroscopeMagnitudeFFT"
colnames(complete_STD_Mean)[74] <- "aveBodyBodyGyroscopeJerkMagnitudeFFT"
colnames(complete_STD_Mean)[75] <- "stdDevBodyBodyGyroscopeJerkMagnitudeFFT"
colnames(complete_STD_Mean)[84] <- "subject"
colnames(complete_STD_Mean)[86] <- "activityLabel"

#Revised dataset with retention of only columns that have mean with an associatedstandard deviation.  This reduced the variables from 83 to 66.
cols2<- c(1:46,50:55,59:66,68:69, 71:72, 74:75, 84,86) 
complete_STD_Mean2<-complete_STD_Mean[,cols2]
#take the average of the activities for each person
activityAvePerPerson<-aggregate(complete_STD_Mean2[,1:66], by=list(complete_STD_Mean2$subject,complete_STD_Mean2$activityLabel), FUN=mean)
#rename columns 1 and 2 
colnames(activityAvePerPerson)[1]="subject"
colnames(activityAvePerPerson)[2]="activityLabel"

##rearrange by subject then activity average
subjectTidyData<-data.frame()
for (i in 1:180) 
{            
        subjectTidyData<-rbind(subjectTidyData, activityAvePerPerson[activityAvePerPerson$subject==i,])
}


###STEP 4 - create output file of tidy data
tidyDataOutput <-write.table(subjectTidyData,'tidyData.txt',row.names = FALSE) 

