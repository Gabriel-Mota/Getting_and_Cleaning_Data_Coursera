Getting-CleanData_Week3
=======================
If the link of the dataset presented in README.md does not work, you can download the data from here:  
[UCI HAR Dataset](https://www.dropbox.com/s/rp9l8yrafajjx7p/UCI%20HAR%20Dataset.zip?dl=0) [61MB]

The script needs to be placed in the root folder of the datasets.
After running it, the following happens:

1. The test and train datasets are bind together with the correspondent files (X_test,y_test,X_train,y_train).
2. The features are read and applied as names of columns of the dataset created in 1.
3. From this new dataset (2), only the columns whose features measure the mean or standard deviation, are chosen.
4. The names of the features are changed to more descriptive ones
5. The numbers in the labels are replaced by the correspondent names of the activities.
6. A dataset with the requirements (1,2,3 and 4) established in the assignment, is returned.
7. A column is added to the dataset, with the number of each subject.
8. A new dataset is created with the average of each variable for each activity and each subject.
9. That dataset is written as a .csv file, named tidyData.csv
