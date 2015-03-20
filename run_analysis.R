# The folder where the UCI HAR Dataset are located
folder <- "./UCI HAR Dataset/"

# Load the association between activity idx and the labels
activity_labels <- read.table(paste0(folder, "activity_labels.txt"))
# Load the association between feature_idx and full labels
features <- read.table(paste0(folder, "features.txt"))

# Load the data for the test set
# Subject info
subject_test <- read.table(paste0(folder, "test/subject_test.txt"))
# Action
y_test <- read.table(paste0(folder, "test/y_test.txt"))
# The measure
X_test <- read.table(paste0(folder, "test/X_test.txt"))
# Fuse the info for test
test_data <- cbind(subject_test, y_test, X_test)

# Load the data for the train set
# Subject info
subject_train <- read.table(paste0(folder, "train/subject_train.txt"))
# Action
y_train <- read.table(paste0(folder, "train/y_train.txt"))
# The measure
X_train <- read.table(paste0(folder, "train/X_train.txt"))
# Fuse the info for train
train_data <- cbind(subject_train, y_train, X_train)

# Fusion of all data in one dataset
all_data <- rbind(test_data, train_data)

# Renaming the columns with meaningfull names
names(all_data) <- c("subject", "activity", as.character(features[, 2]))

# Get the column in the data where the full label contain mean() or std() in
# addition to subject and activitry. There is a switch of 2 since the features
# start at column 2
selected_columns <- c(1, # the subject idx
                      2, # the activity idx
                      2 + grep("mean()", features[, 2], fix=TRUE), # the mean column
                      2 + grep("std()", features[, 2], fix=TRUE)) # the std column

mean_std_data <- all_data[selected_columns]

# 3. Uses descriptive activity names to name the activities in the data set

mean_std_data[["activity"]] <- factor(mean_std_data[["activity"]])
levels(mean_std_data[["activity"]]) <- as.character(activity_labels[, 2])


# A new data frame to old the tidy data
tidy_data <- data.frame()

# Iterate among the column containing "mean()" in ean_std_data
for (mean_column in grep("mean()", names(mean_std_data), fix=TRUE)){
    # Get only the measure of that column in addition of subject and activity
    current_mean_data <- mean_std_data[c(1, 2, mean_column)]
    # rename the third column as generic
    names(current_mean_data)[3] <- "measure"
    # Add a 4th column as description of the measurement
    current_mean_data$feature <- names(mean_std_data)[mean_column]
    # Reorder the columns to get the measure in the last column
    current_mean_data <- current_mean_data[c(1, 2, 4, 3)]
    # Fuse the current "mean" to the other tidy_data
    tidy_data <- rbind(tidy_data, current_mean_data)
}

write.table(tidy_data, file="tidy_data.txt", row.names=FALSE, quote=FALSE)
