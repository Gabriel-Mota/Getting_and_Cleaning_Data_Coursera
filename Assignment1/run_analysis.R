##In order to use this script, place it inside the folder UCI HAR Dataset

##Read the datasets
xTest<-read.table("test/X_test.txt", stringsAsFactors=FALSE)
yTest<-read.table("test/y_test.txt", stringsAsFactors=FALSE)
xTrain<-read.table("train/X_train.txt", stringsAsFactors=FALSE)
yTrain<-read.table("train/y_train.txt", stringsAsFactors=FALSE)

##1- Merge the test and training data sets into a single dataset (final)
test<-cbind(xTest, yTest)
train<-cbind(xTrain, yTrain)

final<-rbind(test, train)

##4 - Get the names of the features
features <- read.table("./features.txt", header=FALSE, sep="", stringsAsFactors=FALSE)

##Descriptive variable names
features$V2<-gsub("tBodyAcc", "Body acceleration ", features$V2)
features$V2<-gsub("tGravityAcc", "Gravity acceleration ", features$V2)
features$V2<-gsub("tBodyAccJerk", "Jerk signal body acceleration ", features$V2)
features$V2<-gsub("tBodyGyro", "Body angular velocity ", features$V2)
features$V2<-gsub("tBodyGyroJerk", "Jerk signal body acceleration ", features$V2)
features$V2<-gsub("tBodyAccMag", "Body acceleration magnitude ", features$V2)
features$V2<-gsub("tGravityAccMag", "Gravity acceleration magnitude ", features$V2)
features$V2<-gsub("tBodyAccJerkMag", "Jerk signal body acceleration magnitude ", features$V2)
features$V2<-gsub("tBodyGyroMag", "Body angular velocity magnitude ", features$V2)
features$V2<-gsub("tBodyGyroJerkMag", "Jerk signal body angular velocity magnitude ", features$V2)
features$V2<-gsub("fBodyAcc", "Fast Fourier Transform body acceleration ", features$V2)
features$V2<-gsub("fBodyAccJerk", "Fast Fourier Transform jerk signal body acceleration ", features$V2)
features$V2<-gsub("fBodyGyro", "Fast Fourier Transform body angular velocity ", features$V2)
features$V2<-gsub("fBodyAccMag", "Fast Fourier Transform body acceleration magnitude ", features$V2)
features$V2<-gsub("fBodyAccJerkMag", "Fast Fourier Transform jerk signal body acceleration magnitude ", features$V2)
features$V2<-gsub("fBodyGyroMag", "Fast Fourier Transform body angular velocity magnitude ", features$V2)
features$V2<-gsub("fBodyGyroJerkMag", "Fast Fourier Transform jerk signal body angular velocity magnitude ", features$V2)

features$V2<-gsub("-mean()-X", " mean value in the X axis", features$V2)
features$V2<-gsub("-mean()-Y", " mean value in the Y axis", features$V2)
features$V2<-gsub("-mean()-Z", " mean value in the Z axis", features$V2)
features$V2<-gsub("-std()-X", " standard deviation value in the X axis", features$V2)
features$V2<-gsub("-std()-Y", " standard deviation value in the Y axis", features$V2)
features$V2<-gsub("-std()-Z", " standard deviation value in the Z axis", features$V2)




names(final)[1:561] <- features[,2]

##2 - Extracts only the measurements on the mean and std for each measurement
final2<-final[grepl("mean", names(final)) | grepl("std", names(final))]

##3 - Names the activities in the data set
activities <- read.table("./activity_labels.txt", stringsAsFactors=FALSE)

o<-rbind(yTest, yTrain)

q<-NULL

for(i in 1:nrow(o)){
  q <- rbind(q, activities$V2[o[i,]])
}

final3<-cbind(final2, q)

final3aux<-cbind(final2, o)

names(final3)[80] <- "Label"

subjectsTrain<-read.table("train/subject_train.txt", stringsAsFactors=FALSE)
subjectsTest<-read.table("test/subject_test.txt", stringsAsFactors=FALSE)

subjects <- rbind(subjectsTest, subjectsTrain)

final4 <- cbind(subjects, final3aux)

final5 <- NULL
aux <- NULL
aux2 <- NULL
aux3 <- NULL
d <- unique(final4[1])
d1 <- unique(final4[81])
for(i in 1:nrow(d)){
  for(n in 1:nrow(d1)){
    aux <- subset(final4, final4[1] == i & final4[81] == n)
    aux2 <- t(colMeans(aux[2:80]))
    aux2 <- cbind(aux[1,1], aux2)
    aux2 <- cbind(aux2, aux[1,81])
    aux3 <- rbind(aux3, aux2)
  }
}

final5 <- data.frame(aux3)

write.csv2(x=final5, file = "tidyData.csv", row.names = FALSE)