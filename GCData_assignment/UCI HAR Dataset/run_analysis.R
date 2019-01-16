# Assignment 1 of Getting and Cleaning Data by Nino Pozar

# 0. PREPARATION
# Installing and loading required packages
required_packages <- c("dplyr")
packages_to_install <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(packages_to_install)) install.packages(packages_to_install)

# Setting working directory
setwd("C:/Users/Nino/Desktop/Data Science/Getting and Cleaning Data/UCI HAR Dataset")

# 1. IMPORTIING DATA
# Loading the data, separetly test and training set
features <- read.table("features.txt", stringsAsFactors = FALSE)
activity.labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)

x.train <- read.table("train/X_train.txt", stringsAsFactors = FALSE)
y.train <- read.table("train/Y_train.txt", stringsAsFactors = TRUE)
sub.train <- read.table("train/subject_train.txt", stringsAsFactors = TRUE)

x.test <- read.table("test/X_test.txt", stringsAsFactors = FALSE)
y.test <- read.table("test/Y_test.txt", stringsAsFactors = TRUE)
sub.test <- read.table("test/subject_test.txt", stringsAsFactors = TRUE)

# 2. PREPARING DATA
# Naming variables according to the info provided for assignment
names(x.train) <- features$V2
names(x.test) <- features$V2
names(y.train) <- "activity"
names(y.test) <- "activity"
names(sub.train) <- "subject"
names(sub.test) <- "subject"

# Converting activity to the factor variable with levels provided in activity.labels file
y.train$activity <- factor(y.train$activity, labels=activity.labels$V2)
y.test$activity <- factor(y.test$activity, labels=activity.labels$V2)


# 3. COMBINING AND SELECTING DATA
# Combining x data with subject and activity for each, test and training set. Also added variable status
# to indicate weather observation was part of test or training set before mergeing train and test sets
train <- cbind(data.frame(status="train"),sub.train,y.train,x.train)
test <- cbind(data.frame(status="test"),sub.test,y.test,x.test)

# Merging test and training set into one data frame all.data
all.data <- rbind(test, train)

# Subseting only variables containing mean or std in name along with status, subject and activity variables
all.data.subset <- all.data[,grepl("status|subject|activity|mean\\(\\)|std\\(\\)",colnames(all.data))]


# 4. SUMMARIZING
# Summarizing averages of each variable by subject and activity (status excluded) using dplyr
library(dplyr)
tidy.data <- all.data.subset %>% 
  select(-status) %>% 
  group_by(subject, activity) %>% 
  summarize_all(funs(mean=mean))


# 5. WRITING OUT
# Writing out tidy dataset as asked in assignment
write.table(tidy.data, file = "tidy_data.txt", row.names= FALSE)
