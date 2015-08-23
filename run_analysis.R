print("Running analysis...")

# Step 1: Merges the training and the test sets to create one data set.

## Merging X sets.
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
x <- rbind(xTrain, xTest)

## Merging subject sets.
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subjectTrain, subjectTest)

## Merging Y sets
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
y <- rbind(yTrain, yTest)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

## Filter columns from X dataset.
features <- read.table("./UCI HAR Dataset/features.txt")
featuresFiltered <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
xFiltered <- x[, featuresFiltered]

# Step 3: Use descriptive activity names to name the activities in the data set.

## Applying feature names to X data set.
names(xFiltered) <- features[featuresFiltered, 2]
names(xFiltered) <- gsub("\\(|\\)", "", names(xFiltered))

## Formatting activity names.
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities[, 2] <- tolower(as.character(activities[, 2]))
activities[, 2] <- gsub("_", " ", activities[, 2])

# Step 4: Appropriately labels the data set with descriptive variable names.

## Renaming subject and y columns.
y[, 1] = activities[y[, 1], 2]
colnames(y) <- 'activity'
colnames(subject) <- 'person_id'

## Binding columns
data <- cbind(subject, y, xFiltered)

# Step 5: From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject

## Collecting averages.
result <- aggregate(x=data, by=list(id = data$person_id, activites = data$activity), FUN=mean)
result <- result[, !(colnames(result) %in% c("person_id", "activity"))]

## Writing results.
write.table(result, './tidy_data.txt', row.names = F)

print("Finished analysis.")
