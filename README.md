Course project for the Getting and Cleaning Data


run_analyses.R is the script that takes and data and tidies it:

Reads in training data (7352 records)
Reads in test data (2947 records)

Combines the training and test data with the subject and activity columns to produce one data file.
Then the script labels the activites 1 to 6 to "WALKING" etc and cleans the variable labels(removes "." so they're more readable).

The it averages each reading for each subject for each of the 6 activities using the melt and dcast functions and outputs the final data set to "TidyDataSet.csv" 