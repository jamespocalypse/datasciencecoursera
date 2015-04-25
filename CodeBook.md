# Introduction

The script `run_analysis.R`
- download the data from
  [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html)
- merge test and training data to create one data set
- extract features on the mean and standard deviation for each measurement
- replace `activity` values in the dataset with descriptive names
- change labels the columns with descriptive names
- generates a tidy dataset with an average of each variable
- The tidy data set is exported as csv file.
  
# run_analysis.R

The script requires `plyr` library is already installed. To run script simply click run in
R studio

# The original data set

The original data set is split into training and test sets (70% and 30%,
respectively) where each partition is also split into three files that contain
- measurements from the accelerometer and gyroscope
- activity label
- identifier of the subject



