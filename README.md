# DataScienceCourse3
Course 3 in the Data Science Specialization

The data for the creation of the tidyData.txt file is derived from the raw data in the Human Activity Recognition Using Smartphones Dataset (UCI HAR Dataset).   The original dataset
consist of 10299 records and 561 variables.   Only columns that have the mean and associated standard deviation were used for the creation of the tidyData.txt, which consists of 68 of those 
variables with 180 records.   The condension of the records to 180 is the result of averaging all of the activity levels (e.g, walking, laying, etc) per subject, 30 subjects times 6 activity levels=180.

The following raw data were used from the UCI HAR Dataset:


- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.


The dataset includes the following files:
=========================================
- README.txt
- tidyData.txt:  The data that summarizes per each subject the activity level average for 66 measurement fields from the UCI HAR Dataset:
- run_analysis.R:  This script executes all the steps for transforming the raw data files to the tidy dataset.
- CodeBook.md:  This contains a high level description that associates with CodeBook.pdf.
- Codebook.pdf:  This contains the variables along with their descriptions.  



