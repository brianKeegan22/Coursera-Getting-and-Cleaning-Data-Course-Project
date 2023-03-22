install.packages("data.table")
library(data.table)

##Reading in training data
X_train <- fread("./train/X_train.txt", colClasses = "numeric")
y_train <- fread("./train/y_train.txt", colClasses = "numeric")
subject_train <- fread("./train/subject_train.txt", colClasses = "numeric")

##Reading in test data
X_test <- fread("./test/X_test.txt", colClasses = "numeric")
y_test <- fread("./test/y_test.txt", colClasses = "numeric")
subject_test <- fread("./test/subject_test.txt", colClasses = "numeric")

##Reading in variable labels file
features <- fread("./features.txt", colClasses = "character") 


feat <- character(561)
feat <- features[,2]

##combining training and test data sets
x_Total <- rbind(X_train, X_test)
y_Total <- rbind(y_train, y_test)
subject_Total <- rbind(subject_train, subject_test)

names(x_Total) <- t(feat)

Merged <- cbind(y_Total, subject_Total, x_Total)
colnames(Merged)[1] <- "Activity"
colnames(Merged)[2] <- "Subject_ID"
Merged <- data.frame(Merged)
##Merged is the total data set with all variable labels

##Output is data with just mean and std columns extracted
Output <- Merged[grep("^Activity$|^Subject_ID$|mean|std", names(Merged), ignore.case = TRUE)]

##df is dataset with labels added for activities and cleaned variable names(full stops removed)
df <- data.frame(setNames(c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING'), c('1', '2', '3', '4', '5', '6'))[Output$Activity], Output[,2:88])
colnames(df)[1] <- "Activity"
colnames(df) <- gsub(r"(\.)", "", colnames(df))


dfMelt <- melt(df,id=c("Activity", "Subject_ID"))
TidyDataSet <- dcast(dfMelt, Subject_ID + Activity ~ variable,mean)


write.csv(TidyDataSet, "C:\\Users\\brian.keegan\\Desktop\\R Work\\RWork\\data\\UCI HAR Dataset\\TidyDataSet.csv", row.names=FALSE)






