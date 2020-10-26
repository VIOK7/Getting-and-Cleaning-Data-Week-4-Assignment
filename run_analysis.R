# load library
library(dplyr) 

# set working directory
setwd("UCI HAR Dataset")

# read training data 
x_train   <- read.table("./train/X_train.txt")
y_train   <- read.table("./train/Y_train.txt") 
sub_train <- read.table("./train/subject_train.txt")

# read test data 
x_test   <- read.table("./test/X_test.txt")
y_test   <- read.table("./test/Y_test.txt") 
sub_test <- read.table("./test/subject_test.txt")

# read features
features <- read.table("./features.txt") 

# read activity labels 
activity_labels <- read.table("./activity_labels.txt") 

# Step 1: merge the training and the test sets to create one data set.
x_total   <- rbind(x_train, x_test)
y_total   <- rbind(y_train, y_test) 
sub_total <- rbind(sub_train, sub_test) 

# Step 2: Extract only the measurements on the mean and standard deviation for each measurement 
col_to_keep <- grep("mean|std",features$name, value=TRUE)
data_set_sub <- subset(data_set, select = c("subject", "activity", col_to_keep))

# Step 3: Use descriptive activity names to name the activities in the data set
colnames(x_total)   <- sel_features[,2]
colnames(y_total)   <- "activity"
colnames(sub_total) <- "subject"

# merge final dataset
total <- cbind(sub_total, y_total, x_total)

# Step 4: Appropriately label the data set with descriptive variable names
total$activity <- factor(total$activity, levels = activity_labels[,1], labels = activity_labels[,2]) 
total$subject  <- as.factor(total$subject) 

Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
total_mean <- total %>% group_by(activity, subject) %>% summarize_all(funs(mean)) 

# export summary dataset
write.table(total_mean, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE) 
