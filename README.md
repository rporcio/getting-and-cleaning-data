Getting and Cleaning Data Course Project
========================================
This file describes how the `run_analysis.R` script works:

1. Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to your current working directory.
2. Put the run_analysis.R script to your current working directory.
3. Use `source("run_analysis.R")` command to run the script.
4. The script will do the followings:
    * Loads the train and test data sets and merges them.
    * Extracts mean and standard deviation from the features.
    * Filters the X data set based on the extracted features.
    * Column names are applied to the x data frame.
    * Merges the X, Y and subject data sets.
    * Creates a tidy data txt file by computing the `mean` of the values grouped by subject (id) and activities.
