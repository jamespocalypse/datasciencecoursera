library(plyr)
# Download data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data.zip", method="curl")
unzip("data.zip")


# Read the data
training.x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
training.y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
training.subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
test.x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

# Merge training and test data
merged.x <- rbind(training.x, test.x)
merged.y <- rbind(training.y, test.y)
merged.subject <- rbind(training.subject, test.subject)
# merge train and test datasets and return
merged <- list(x=merged.x, y=merged.y, subject=merged.subject)

# Extract  the mean and standard deviation for each measurement
features <- read.table("data/UCI HAR Dataset/features.txt")
mean.col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
std.col <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
cx <- merged$x
cx  <- cx[, (mean.col | std.col)]
colnames(cx) <- features[(mean.col | std.col), 2]

# Name the activities
cy <- merged$y
colnames(cy) <- "activity"
cy$activity[cy$activity == 1] = "WALKING"
cy$activity[cy$activity == 2] = "WALKING_UPSTAIRS"
cy$activity[cy$activity == 3] = "WALKING_DOWNSTAIRS"
cy$activity[cy$activity == 4] = "SITTING"
cy$activity[cy$activity == 5] = "STANDING"
cy$activity[cy$activity == 6] = "LAYING"

# add descriptive column name for subjects
colnames(merged$subject) <- c("subject")

# Combine data
combined <- bind.data(cx, cy, merged$subject)

# Create tidy dataset

tidy <- ddply(combined, .(subject, activity), function(x) colMeans(x[,1:60]))

# Write tidy dataset as csv
write.table(tidy, file="tidy.txt",sep=",", row.names=FALSE)